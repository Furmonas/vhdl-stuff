library ieee;
use ieee.std_logic_1164.all;

entity mux2x1_single is -- 2 to 1 mux
    port (i_sw    : in std_logic;
          i_dat_x : in std_logic;
          i_dat_y : in std_logic;
          o_dat   : out std_logic
          );
end mux2x1_single;

architecture behavioral of mux2x1_single is
begin
    o_dat <= i_dat_x when (i_sw='0') else
             i_dat_y when (i_sw='1');
end behavioral;
