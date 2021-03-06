library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.libeu.all;
USE work.constants.ALL;
use work.libnode.all;

entity execute_stage is
	port(
		clk          : in  std_logic;
		rst_n        : in  std_logic;
		a            : in  execute_in_type;
		d            : in  execute_in_type;
		q            : out execute_out_type;
		y            : out execute_out_type;
		global_stall : in  std_logic
	);

end entity execute_stage;

architecture rtl of execute_stage is
	type execute_reg_type is record
		pc        : std_logic_vector(63 downto 0);
		address   : std_logic_vector(63 downto 0);
		jump      : std_logic;
		rs2       : std_logic_vector(63 downto 0);
		res       : std_logic_vector(63 downto 0);
		waddr     : std_logic_vector(4 downto 0);
		we        : std_logic;
		lsfunc    : std_logic_vector(2 downto 0);
		dre       : std_logic;
		dwe       : std_logic;
		dbyteen   : std_logic_vector(7 downto 0);
		csrval    : std_logic_vector(63 downto 0);
		csraddr   : std_logic_vector(11 downto 0);
		csrwe     : std_logic;
		exception : exception_type;
		fgmop     : std_logic;
	end record;

	procedure alu(
		op1, op2 : in  std_logic_vector(63 downto 0);
		func1    : in  std_logic_vector(2 downto 0);
		func2    : in  std_logic;       -- set if srai/sub/sra or branch or slti/sltiu/slt/sltu
		alu32    : in  std_logic;
		res      : out std_logic_vector(63 downto 0);
		brcond   : out std_logic) is
		variable au : unsigned(63 downto 0); -- a unsigned
		variable bu : unsigned(63 downto 0); -- b unsigned

		variable bun : unsigned(63 downto 0); -- b unsigned negated
		variable sum : unsigned(64 downto 0);

		variable condeq  : std_logic;
		variable condlt  : std_logic;
		variable condltu : std_logic;

		variable count  : unsigned(5 downto 0);
		variable shift0 : unsigned(126 downto 0);
		variable shift5 : unsigned(63 downto 0);
	begin
		-- 64bit adder
		au := unsigned(op1);
		bu := unsigned(op2);

		bun := bu xor (63 downto 0 => func2);
		sum := ("0" & au) + ("0" & bun) + (x"0000000000000000" & func2);

		-- branch condition calculation
		if sum(63 downto 0) = to_unsigned(0, 64) then
			condeq := '1';
		else
			condeq := '0';
		end if;
		condltu := not sum(64);
		condlt  := (au(63) and bun(63)) or (au(63) and sum(63)) or (bun(63) and sum(63));

		-- shift
		if func1(2) = '0' then
			count := not bu(5 downto 0);
			if alu32 = '1' then
				count := '1' & (not bu(4 downto 0));
			end if;
			shift0(126 downto 63) := au(63 downto 0); -- SLL
			shift0(62 downto 0)   := (others => '0');
		elsif alu32 = '0' then
			count := bu(5 downto 0);
			if func2 = '1' then
				shift0(126 downto 64) := (others => au(63)); -- SRA
			else
				shift0(126 downto 64) := (others => '0'); -- SRL
			end if;
			shift0(63 downto 0) := au(63 downto 0);
		else
			count := '0' & bu(4 downto 0);
			if func2 = '1' then
				shift0(126 downto 32) := (others => au(31)); -- SRA
			else
				shift0(126 downto 32) := (others => '0'); -- SRL
			end if;
			shift0(31 downto 0) := au(31 downto 0);
		end if;

		shift5 := shift_right(shift0, to_integer(count))(63 downto 0);

		-- arithmetic logical result
		case func1 is
			when FUNC_ADD  => res := std_logic_vector(sum(63 downto 0));
			when FUNC_SLL  => res := std_logic_vector(shift5);
			when FUNC_SLT  => res := x"000000000000000" & "000" & condlt;
			when FUNC_SLTU => res := x"000000000000000" & "000" & condltu;
			when FUNC_XOR  => res := std_logic_vector(au xor bu);
			when FUNC_SRL  => res := std_logic_vector(shift5);
			when FUNC_OR   => res := std_logic_vector(au or bu);
			when FUNC_AND  => res := std_logic_vector(au and bu);
			when others    => null;
		end case;

		-- branch condition evaluation
		case func1 is
			when FUNC_BEQ  => brcond := condeq;
			when FUNC_BNE  => brcond := not condeq;
			when FUNC_BLT  => brcond := condlt;
			when FUNC_BGE  => brcond := not condlt;
			when FUNC_BLTU => brcond := condltu;
			when FUNC_BGEU => brcond := not condltu;
			when others    => null;
		end case;

	end procedure;

	function aluop1out(
		rs1     : std_logic_vector(63 downto 0);
		pc      : std_logic_vector(63 downto 0);
		op1pc   : std_logic;
		op1zero : std_logic
		) return std_logic_vector is
		variable q : std_logic_vector(63 downto 0);
	begin
		q := rs1;
		if op1pc = '1' then
			q := pc;
		end if;
		if op1zero = '1' then
			q := (others => '0');
		end if;
		return q;
	end function aluop1out;

	function aluop2out(
		rs2    : std_logic_vector(63 downto 0);
		imm    : std_logic_vector(63 downto 0);
		op2imm : std_logic
		) return std_logic_vector is
		variable q : std_logic_vector(63 downto 0);
	begin
		q := rs2;
		if op2imm = '1' then
			q := imm;
		end if;
		return q;
	end function aluop2out;

	function addresscalc(
		rs1      : std_logic_vector(63 downto 0);
		imm      : std_logic_vector(63 downto 0);
		pc       : std_logic_vector(63 downto 0);
		rs1pcsel : std_logic
		) return std_logic_vector is
		variable q : std_logic_vector(63 downto 0);
	begin
		if rs1pcsel = '1' then          -- OP_JALR, OP_LOAD, OP_STORE
			q := rs1;
		else                            -- OP_JAL, OP_BRANCH
			q := pc;
		end if;
		return (std_logic_vector(unsigned(imm) + unsigned(q)));
	end function addresscalc;

	function byteenout(
		func : std_logic_vector(1 downto 0);
		addr : std_logic_vector(2 downto 0)
		) return std_logic_vector is
		variable q : std_logic_vector(7 downto 0);
	begin
		case func is
			when "00" =>
				case addr is
					when "000" =>
						q := "00000001";
					when "001" =>
						q := "00000010";
					when "010" =>
						q := "00000100";
					when "011" =>
						q := "00001000";
					when "100" =>
						q := "00010000";
					when "101" =>
						q := "00100000";
					when "110" =>
						q := "01000000";
					when "111" =>
						q := "10000000";
					when others => null;
				end case;
			when "01" =>
				case addr(2 downto 1) is
					when "00" =>
						q := "00000011";
					when "01" =>
						q := "00001100";
					when "10" =>
						q := "00110000";
					when "11" =>
						q := "11000000";
					when others => null;
				end case;
			when "10" =>
				if addr(2) = '0' then
					q := "00001111";
				else
					q := "11110000";
				end if;
			when "11" =>
				q := "11111111";
			when others => null;
		end case;
		return q;
	end function byteenout;

	function csralu(
		rs1    : std_logic_vector(63 downto 0);
		imm    : std_logic_vector(63 downto 0);
		csrval : std_logic_vector(63 downto 0);
		immsel : std_logic;
		func   : std_logic_vector(1 downto 0)
		) return std_logic_vector is
		variable q : std_logic_vector(63 downto 0);
	begin
		if immsel = '1' then
			q := imm;
		else
			q := rs1;
		end if;

		case func is
			when FUNC_CSRRS => return (std_logic_vector(unsigned(csrval) or unsigned(q)));
			when FUNC_CSRRC => return (std_logic_vector(unsigned(csrval) and unsigned(not q)));
			when others     => return q; -- FUNC_CSRRW
		end case;
	end function csralu;

	signal r, rin : execute_reg_type;

begin
	comb : process(d, r)
		variable v : execute_reg_type;
	begin
		v := r;

		v.fgmop := d.d.fgmop;

		v.pc := d.d.pc;

		v.exception := d.d.exception;

		v.rs2 := d.d.rs2;

		v.csraddr := d.d.csraddr;
		v.csrwe   := '0';

		alu(aluop1out(d.d.rs1, d.d.pc, d.d.aluop1pc, d.d.aluop1zero),
			aluop2out(d.d.rs2, d.d.imm, d.d.aluop2imm),
			d.d.alufunc1, d.d.alufunc2, d.d.alu32, v.res, v.jump);

		if d.d.alu32 = '1' then
			v.res(63 downto 32) := (others => v.res(31));
		end if;

		if d.d.csrop = '1' and d.d.alufunc1(1 downto 0) /= FUNC_CSRNO then
			v.csrwe  := '1';
			v.csrval := csralu(d.d.rs1, d.d.imm, d.d.csrval, d.d.alufunc1(2), d.d.alufunc1(1 downto 0));
			v.res    := d.d.csrval;
		end if;

		v.address := addresscalc(d.d.rs1, d.d.imm, d.d.pc, d.d.jumpreg);

		if v.fgmop = '1' then
			v.res := d.d.rs1;
		end if;

		-- if JAL, JALR, or taken BRANCH
		v.jump := d.d.jump or (d.d.br and v.jump);

		if d.d.jump = '1' then
			v.res := d.d.pc4;
		end if;

		v.waddr := d.d.waddr;
		v.we    := d.d.we;

		v.lsfunc  := d.d.lsfunc;
		v.dre     := d.d.dre;
		v.dwe     := d.d.dwe;
		v.dbyteen := byteenout(v.lsfunc(1 downto 0), v.address(2 downto 0));

		-- we are jumping or something down the pipe is throwing
		if r.jump = '1' or r.exception.valid = '1' -- we are currently throwing (nop next input)
		or d.m.exception.valid = '1'    -- memory stage
		or d.w.exception = '1'          -- writeback stage
		then
			v.jump            := '0';
			v.we              := '0';
			v.dre             := '0';
			v.dwe             := '0';
			v.csrwe           := '0';
			v.exception.valid := '0';
			v.fgmop           := '0';
		end if;

		-- we are throwing
		if v.exception.valid = '1' then
			v.jump          := '0';
			v.we            := '0';
			v.dre           := '0';
			v.dwe           := '0';
			v.csrwe         := '0';
			v.exception.epc := d.d.pc;
			v.fgmop         := '0';
		end if;

		rin <= v;

		y.pc        <= v.pc;
		y.pcjump    <= v.address;
		y.jump      <= v.jump;
		y.rs2       <= v.rs2;
		y.res       <= v.res;
		y.waddr     <= v.waddr;
		y.we        <= v.we;
		y.lsfunc    <= v.lsfunc;
		y.dre       <= v.dre;
		y.dwe       <= v.dwe;
		y.dbyteen   <= v.dbyteen;
		y.csrval    <= v.csrval;
		y.csraddr   <= v.csraddr;
		y.csrwe     <= v.csrwe;
		y.exception <= v.exception;
		y.fgmop     <= v.fgmop;

		q.pc        <= r.pc;
		q.pcjump    <= r.address;
		q.rs2       <= r.rs2;
		q.res       <= r.res;
		q.waddr     <= r.waddr;
		q.lsfunc    <= r.lsfunc;
		q.dbyteen   <= r.dbyteen;
		q.csrval    <= r.csrval;
		q.csraddr   <= r.csraddr;
		q.exception <= r.exception;
		q.jump      <= r.jump;
		q.we        <= r.we;
		q.dre       <= r.dre;
		q.dwe       <= r.dwe;
		q.csrwe     <= r.csrwe;
		q.fgmop     <= r.fgmop;

	end process;

	regs : process(clk, rst_n)          -- sequential process
	begin
		if rst_n = '0' then
			r.pc              <= (others => '0');
			r.res             <= (others => '0');
			r.address         <= (others => '0');
			r.jump            <= '0';
			r.waddr           <= (others => '0');
			r.we              <= '0';
			r.dre             <= '0';
			r.dwe             <= '0';
			r.csrwe           <= '0';
			r.exception.epc   <= (others => '0');
			r.exception.cause <= (others => '0');
			r.exception.valid <= '0';
			r.fgmop           <= '0';
		elsif rising_edge(clk) then
			if global_stall = '0' then
				r <= rin;
			end if;
		end if;
	end process;

end architecture;