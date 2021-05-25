library ieee;
use ieee.std_logic_1164.all;

entity mux2x1 is -- DATA_WIDTH bit wide 2 to 1 mux
    generic (DATA_WIDTH : integer
             );
    port (i_sw    : in std_logic;
          i_dat_x : in std_logic_vector(DATA_WIDTH-1 downto 0);
          i_dat_y : in std_logic_vector(DATA_WIDTH-1 downto 0);
          o_sw    : out std_logic;
          o_dat   : out std_logic_vector(DATA_WIDTH-1 downto 0)
          );
end mux2x1;

architecture behavioral of mux2x1 is
begin
    o_dat <= i_dat_x when (i_sw='0') else
             i_dat_y when (i_sw='1') else
             (others => '0');
    o_sw <= i_sw;
end behavioral;
