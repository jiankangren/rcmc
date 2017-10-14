library IEEE;
use IEEE.STD_LOGIC_1164.all;
use WORK.CONSTANTS.all;
use WORK.LIBNODE.all;

entity NoC is
  port(--SW       : in  std_logic_vector(17 downto 0);
       --CLOCK_50 : in  std_logic;
       LEDR     : out std_logic_vector(64 downto 0));
end;

architecture STRUCTURE of NoC is
  component NOCUNIT
    generic(id : integer; count : integer; nocdim : std_logic_vector(63 downto 0));
    port(Clk         : in  std_logic;
         rst_n       : in  std_logic;
         LED         : out std_logic;
         NorthIn     : in  P_PORT_VERTICAL_BACK;
         NorthOut    : out P_PORT_VERTICAL;
         SouthIn     : in  P_PORT_VERTICAL;
         SouthOut    : out P_PORT_VERTICAL_BACK;
         EastIn      : in  P_PORT_HORIZONTAL_BACK;
         EastOut     : out P_PORT_HORIZONTAL;
         WestIn      : in  P_PORT_HORIZONTAL;
         WestOut     : out P_PORT_HORIZONTAL_BACK;
         CoreAddress : in  Address
         );
  end component;



-------------------------------------------------
--SIGNALS for NODE 0000

SIGNAL N_0000EAST_OUT			:P_PORT_HORIZONTAL;
SIGNAL N_0000NORTH_OUT			:P_PORT_VERTICAL;
SIGNAL N_0000WEST_OUT			:P_PORT_HORIZONTAL_BACK;
SIGNAL N_0000SOUTH_OUT			:P_PORT_VERTICAL_BACK;
SIGNAL N_0000CORE_ADDRESS			:Address;

-------------------------------------------------
--SIGNALS for NODE 0001

SIGNAL N_0001EAST_OUT			:P_PORT_HORIZONTAL;
SIGNAL N_0001NORTH_OUT			:P_PORT_VERTICAL;
SIGNAL N_0001WEST_OUT			:P_PORT_HORIZONTAL_BACK;
SIGNAL N_0001SOUTH_OUT			:P_PORT_VERTICAL_BACK;
SIGNAL N_0001CORE_ADDRESS			:Address;

-------------------------------------------------
--SIGNALS for NODE 0010

SIGNAL N_0010EAST_OUT			:P_PORT_HORIZONTAL;
SIGNAL N_0010NORTH_OUT			:P_PORT_VERTICAL;
SIGNAL N_0010WEST_OUT			:P_PORT_HORIZONTAL_BACK;
SIGNAL N_0010SOUTH_OUT			:P_PORT_VERTICAL_BACK;
SIGNAL N_0010CORE_ADDRESS			:Address;

-------------------------------------------------
--SIGNALS for NODE 0011

SIGNAL N_0011EAST_OUT			:P_PORT_HORIZONTAL;
SIGNAL N_0011NORTH_OUT			:P_PORT_VERTICAL;
SIGNAL N_0011WEST_OUT			:P_PORT_HORIZONTAL_BACK;
SIGNAL N_0011SOUTH_OUT			:P_PORT_VERTICAL_BACK;
SIGNAL N_0011CORE_ADDRESS			:Address;

-------------------------------------------------
--SIGNALS for NODE 0100

SIGNAL N_0100EAST_OUT			:P_PORT_HORIZONTAL;
SIGNAL N_0100NORTH_OUT			:P_PORT_VERTICAL;
SIGNAL N_0100WEST_OUT			:P_PORT_HORIZONTAL_BACK;
SIGNAL N_0100SOUTH_OUT			:P_PORT_VERTICAL_BACK;
SIGNAL N_0100CORE_ADDRESS			:Address;

-------------------------------------------------
--SIGNALS for NODE 0101

SIGNAL N_0101EAST_OUT			:P_PORT_HORIZONTAL;
SIGNAL N_0101NORTH_OUT			:P_PORT_VERTICAL;
SIGNAL N_0101WEST_OUT			:P_PORT_HORIZONTAL_BACK;
SIGNAL N_0101SOUTH_OUT			:P_PORT_VERTICAL_BACK;
SIGNAL N_0101CORE_ADDRESS			:Address;

-------------------------------------------------
--SIGNALS for NODE 0110

SIGNAL N_0110EAST_OUT			:P_PORT_HORIZONTAL;
SIGNAL N_0110NORTH_OUT			:P_PORT_VERTICAL;
SIGNAL N_0110WEST_OUT			:P_PORT_HORIZONTAL_BACK;
SIGNAL N_0110SOUTH_OUT			:P_PORT_VERTICAL_BACK;
SIGNAL N_0110CORE_ADDRESS			:Address;

-------------------------------------------------
--SIGNALS for NODE 0111

SIGNAL N_0111EAST_OUT			:P_PORT_HORIZONTAL;
SIGNAL N_0111NORTH_OUT			:P_PORT_VERTICAL;
SIGNAL N_0111WEST_OUT			:P_PORT_HORIZONTAL_BACK;
SIGNAL N_0111SOUTH_OUT			:P_PORT_VERTICAL_BACK;
SIGNAL N_0111CORE_ADDRESS			:Address;

-------------------------------------------------
--SIGNALS for NODE 1000

SIGNAL N_1000EAST_OUT			:P_PORT_HORIZONTAL;
SIGNAL N_1000NORTH_OUT			:P_PORT_VERTICAL;
SIGNAL N_1000WEST_OUT			:P_PORT_HORIZONTAL_BACK;
SIGNAL N_1000SOUTH_OUT			:P_PORT_VERTICAL_BACK;
SIGNAL N_1000CORE_ADDRESS			:Address;

-------------------------------------------------
--SIGNALS for NODE 1001

SIGNAL N_1001EAST_OUT			:P_PORT_HORIZONTAL;
SIGNAL N_1001NORTH_OUT			:P_PORT_VERTICAL;
SIGNAL N_1001WEST_OUT			:P_PORT_HORIZONTAL_BACK;
SIGNAL N_1001SOUTH_OUT			:P_PORT_VERTICAL_BACK;
SIGNAL N_1001CORE_ADDRESS			:Address;

-------------------------------------------------
--SIGNALS for NODE 1010

SIGNAL N_1010EAST_OUT			:P_PORT_HORIZONTAL;
SIGNAL N_1010NORTH_OUT			:P_PORT_VERTICAL;
SIGNAL N_1010WEST_OUT			:P_PORT_HORIZONTAL_BACK;
SIGNAL N_1010SOUTH_OUT			:P_PORT_VERTICAL_BACK;
SIGNAL N_1010CORE_ADDRESS			:Address;

-------------------------------------------------
--SIGNALS for NODE 1011

SIGNAL N_1011EAST_OUT			:P_PORT_HORIZONTAL;
SIGNAL N_1011NORTH_OUT			:P_PORT_VERTICAL;
SIGNAL N_1011WEST_OUT			:P_PORT_HORIZONTAL_BACK;
SIGNAL N_1011SOUTH_OUT			:P_PORT_VERTICAL_BACK;
SIGNAL N_1011CORE_ADDRESS			:Address;

-------------------------------------------------
--SIGNALS for NODE 1100

SIGNAL N_1100EAST_OUT			:P_PORT_HORIZONTAL;
SIGNAL N_1100NORTH_OUT			:P_PORT_VERTICAL;
SIGNAL N_1100WEST_OUT			:P_PORT_HORIZONTAL_BACK;
SIGNAL N_1100SOUTH_OUT			:P_PORT_VERTICAL_BACK;
SIGNAL N_1100CORE_ADDRESS			:Address;

-------------------------------------------------
--SIGNALS for NODE 1101

SIGNAL N_1101EAST_OUT			:P_PORT_HORIZONTAL;
SIGNAL N_1101NORTH_OUT			:P_PORT_VERTICAL;
SIGNAL N_1101WEST_OUT			:P_PORT_HORIZONTAL_BACK;
SIGNAL N_1101SOUTH_OUT			:P_PORT_VERTICAL_BACK;
SIGNAL N_1101CORE_ADDRESS			:Address;

-------------------------------------------------
--SIGNALS for NODE 1110

SIGNAL N_1110EAST_OUT			:P_PORT_HORIZONTAL;
SIGNAL N_1110NORTH_OUT			:P_PORT_VERTICAL;
SIGNAL N_1110WEST_OUT			:P_PORT_HORIZONTAL_BACK;
SIGNAL N_1110SOUTH_OUT			:P_PORT_VERTICAL_BACK;
SIGNAL N_1110CORE_ADDRESS			:Address;

-------------------------------------------------
--SIGNALS for NODE 1111

SIGNAL N_1111EAST_OUT			:P_PORT_HORIZONTAL;
SIGNAL N_1111NORTH_OUT			:P_PORT_VERTICAL;
SIGNAL N_1111WEST_OUT			:P_PORT_HORIZONTAL_BACK;
SIGNAL N_1111SOUTH_OUT			:P_PORT_VERTICAL_BACK;
SIGNAL N_1111CORE_ADDRESS			:Address;


-- added
component sim_clock
	port(clk : out std_logic);
end component;

component sim_reset
	port(rst_n : out std_logic);
end component;

SIGNAL CLOCK_50 : std_logic;
SIGNAL RST_N : std_logic;

--
begin
-- added

	CLOCK : sim_clock
	port map(
			clk => CLOCK_50
	);

	RESET : sim_reset
	port map(
			rst_n => RST_N
	);

--

	NOCUNIT0000 : NOCUNIT
generic map ( id => 0, count => 16, nocdim => x"0001000100040004" )
 port map( 
				CLOCK_50,
				RST_N, -- SW(17)
				LEDR(0),
				N_1100SOUTH_OUT,
				N_0000NORTH_OUT,
				N_0100NORTH_OUT,
				N_0000SOUTH_OUT,
				N_0001WEST_OUT,
				N_0000EAST_OUT,
				N_0011EAST_OUT,
				N_0000WEST_OUT,
				N_0000CORE_ADDRESS);
	NOCUNIT0001 : NOCUNIT
generic map ( id => 1, count => 16, nocdim => x"0001000100040004" )
 port map( 
				CLOCK_50,
				RST_N, -- SW(17)
				LEDR(1),
				N_1101SOUTH_OUT,
				N_0001NORTH_OUT,
				N_0101NORTH_OUT,
				N_0001SOUTH_OUT,
				N_0010WEST_OUT,
				N_0001EAST_OUT,
				N_0000EAST_OUT,
				N_0001WEST_OUT,
				N_0001CORE_ADDRESS);
	NOCUNIT0010 : NOCUNIT
generic map ( id => 2, count => 16, nocdim => x"0001000100040004" )
 port map( 
				CLOCK_50,
				RST_N, -- SW(17)
				LEDR(2),
				N_1110SOUTH_OUT,
				N_0010NORTH_OUT,
				N_0110NORTH_OUT,
				N_0010SOUTH_OUT,
				N_0011WEST_OUT,
				N_0010EAST_OUT,
				N_0001EAST_OUT,
				N_0010WEST_OUT,
				N_0010CORE_ADDRESS);
	NOCUNIT0011 : NOCUNIT
generic map ( id => 3, count => 16, nocdim => x"0001000100040004" )
 port map( 
				CLOCK_50,
				RST_N, -- SW(17)
				LEDR(3),
				N_1111SOUTH_OUT,
				N_0011NORTH_OUT,
				N_0111NORTH_OUT,
				N_0011SOUTH_OUT,
				N_0000WEST_OUT,
				N_0011EAST_OUT,
				N_0010EAST_OUT,
				N_0011WEST_OUT,
				N_0011CORE_ADDRESS);
	NOCUNIT0100 : NOCUNIT
generic map ( id => 4, count => 16, nocdim => x"0001000100040004" )
 port map( 
				CLOCK_50,
				RST_N, -- SW(17)
				LEDR(4),
				N_0000SOUTH_OUT,
				N_0100NORTH_OUT,
				N_1000NORTH_OUT,
				N_0100SOUTH_OUT,
				N_0101WEST_OUT,
				N_0100EAST_OUT,
				N_0111EAST_OUT,
				N_0100WEST_OUT,
				N_0100CORE_ADDRESS);
	NOCUNIT0101 : NOCUNIT
generic map ( id => 5, count => 16, nocdim => x"0001000100040004" )
 port map( 
				CLOCK_50,
				RST_N, -- SW(17)
				LEDR(5),
				N_0001SOUTH_OUT,
				N_0101NORTH_OUT,
				N_1001NORTH_OUT,
				N_0101SOUTH_OUT,
				N_0110WEST_OUT,
				N_0101EAST_OUT,
				N_0100EAST_OUT,
				N_0101WEST_OUT,
				N_0101CORE_ADDRESS);
	NOCUNIT0110 : NOCUNIT
generic map ( id => 6, count => 16, nocdim => x"0001000100040004" )
 port map( 
				CLOCK_50,
				RST_N, -- SW(17)
				LEDR(6),
				N_0010SOUTH_OUT,
				N_0110NORTH_OUT,
				N_1010NORTH_OUT,
				N_0110SOUTH_OUT,
				N_0111WEST_OUT,
				N_0110EAST_OUT,
				N_0101EAST_OUT,
				N_0110WEST_OUT,
				N_0110CORE_ADDRESS);
	NOCUNIT0111 : NOCUNIT
generic map ( id => 7, count => 16, nocdim => x"0001000100040004" )
 port map( 
				CLOCK_50,
				RST_N, -- SW(17)
				LEDR(7),
				N_0011SOUTH_OUT,
				N_0111NORTH_OUT,
				N_1011NORTH_OUT,
				N_0111SOUTH_OUT,
				N_0100WEST_OUT,
				N_0111EAST_OUT,
				N_0110EAST_OUT,
				N_0111WEST_OUT,
				N_0111CORE_ADDRESS);
	NOCUNIT1000 : NOCUNIT
generic map ( id => 8, count => 16, nocdim => x"0001000100040004" )
 port map( 
				CLOCK_50,
				RST_N, -- SW(17)
				LEDR(8),
				N_0100SOUTH_OUT,
				N_1000NORTH_OUT,
				N_1100NORTH_OUT,
				N_1000SOUTH_OUT,
				N_1001WEST_OUT,
				N_1000EAST_OUT,
				N_1011EAST_OUT,
				N_1000WEST_OUT,
				N_1000CORE_ADDRESS);
	NOCUNIT1001 : NOCUNIT
generic map ( id => 9, count => 16, nocdim => x"0001000100040004" )
 port map( 
				CLOCK_50,
				RST_N, -- SW(17)
				LEDR(9),
				N_0101SOUTH_OUT,
				N_1001NORTH_OUT,
				N_1101NORTH_OUT,
				N_1001SOUTH_OUT,
				N_1010WEST_OUT,
				N_1001EAST_OUT,
				N_1000EAST_OUT,
				N_1001WEST_OUT,
				N_1001CORE_ADDRESS);
	NOCUNIT1010 : NOCUNIT
generic map ( id => 10, count => 16, nocdim => x"0001000100040004" )
 port map( 
				CLOCK_50,
				RST_N, -- SW(17)
				LEDR(10),
				N_0110SOUTH_OUT,
				N_1010NORTH_OUT,
				N_1110NORTH_OUT,
				N_1010SOUTH_OUT,
				N_1011WEST_OUT,
				N_1010EAST_OUT,
				N_1001EAST_OUT,
				N_1010WEST_OUT,
				N_1010CORE_ADDRESS);
	NOCUNIT1011 : NOCUNIT
generic map ( id => 11, count => 16, nocdim => x"0001000100040004" )
 port map( 
				CLOCK_50,
				RST_N, -- SW(17)
				LEDR(11),
				N_0111SOUTH_OUT,
				N_1011NORTH_OUT,
				N_1111NORTH_OUT,
				N_1011SOUTH_OUT,
				N_1000WEST_OUT,
				N_1011EAST_OUT,
				N_1010EAST_OUT,
				N_1011WEST_OUT,
				N_1011CORE_ADDRESS);
	NOCUNIT1100 : NOCUNIT
generic map ( id => 12, count => 16, nocdim => x"0001000100040004" )
 port map( 
				CLOCK_50,
				RST_N, -- SW(17)
				LEDR(12),
				N_1000SOUTH_OUT,
				N_1100NORTH_OUT,
				N_0000NORTH_OUT,
				N_1100SOUTH_OUT,
				N_1101WEST_OUT,
				N_1100EAST_OUT,
				N_1111EAST_OUT,
				N_1100WEST_OUT,
				N_1100CORE_ADDRESS);
	NOCUNIT1101 : NOCUNIT
generic map ( id => 13, count => 16, nocdim => x"0001000100040004" )
 port map( 
				CLOCK_50,
				RST_N, -- SW(17)
				LEDR(13),
				N_1001SOUTH_OUT,
				N_1101NORTH_OUT,
				N_0001NORTH_OUT,
				N_1101SOUTH_OUT,
				N_1110WEST_OUT,
				N_1101EAST_OUT,
				N_1100EAST_OUT,
				N_1101WEST_OUT,
				N_1101CORE_ADDRESS);
	NOCUNIT1110 : NOCUNIT
generic map ( id => 14, count => 16, nocdim => x"0001000100040004" )
 port map( 
				CLOCK_50,
				RST_N, -- SW(17)
				LEDR(14),
				N_1010SOUTH_OUT,
				N_1110NORTH_OUT,
				N_0010NORTH_OUT,
				N_1110SOUTH_OUT,
				N_1111WEST_OUT,
				N_1110EAST_OUT,
				N_1101EAST_OUT,
				N_1110WEST_OUT,
				N_1110CORE_ADDRESS);
	NOCUNIT1111 : NOCUNIT
generic map ( id => 15, count => 16, nocdim => x"0001000100040004" )
 port map( 
				CLOCK_50,
				RST_N, -- SW(17)
				LEDR(15),
				N_1011SOUTH_OUT,
				N_1111NORTH_OUT,
				N_0011NORTH_OUT,
				N_1111SOUTH_OUT,
				N_1100WEST_OUT,
				N_1111EAST_OUT,
				N_1110EAST_OUT,
				N_1111WEST_OUT,
				N_1111CORE_ADDRESS);








	N_0000CORE_ADDRESS.X <= "00";
	N_0000CORE_ADDRESS.Y <= "00";
	N_0001CORE_ADDRESS.X <= "01";
	N_0001CORE_ADDRESS.Y <= "00";
	N_0010CORE_ADDRESS.X <= "10";
	N_0010CORE_ADDRESS.Y <= "00";
	N_0011CORE_ADDRESS.X <= "11";
	N_0011CORE_ADDRESS.Y <= "00";
	N_0100CORE_ADDRESS.X <= "00";
	N_0100CORE_ADDRESS.Y <= "01";
	N_0101CORE_ADDRESS.X <= "01";
	N_0101CORE_ADDRESS.Y <= "01";
	N_0110CORE_ADDRESS.X <= "10";
	N_0110CORE_ADDRESS.Y <= "01";
	N_0111CORE_ADDRESS.X <= "11";
	N_0111CORE_ADDRESS.Y <= "01";
	N_1000CORE_ADDRESS.X <= "00";
	N_1000CORE_ADDRESS.Y <= "10";
	N_1001CORE_ADDRESS.X <= "01";
	N_1001CORE_ADDRESS.Y <= "10";
	N_1010CORE_ADDRESS.X <= "10";
	N_1010CORE_ADDRESS.Y <= "10";
	N_1011CORE_ADDRESS.X <= "11";
	N_1011CORE_ADDRESS.Y <= "10";
	N_1100CORE_ADDRESS.X <= "00";
	N_1100CORE_ADDRESS.Y <= "11";
	N_1101CORE_ADDRESS.X <= "01";
	N_1101CORE_ADDRESS.Y <= "11";
	N_1110CORE_ADDRESS.X <= "10";
	N_1110CORE_ADDRESS.Y <= "11";
	N_1111CORE_ADDRESS.X <= "11";
	N_1111CORE_ADDRESS.Y <= "11";
end; 
