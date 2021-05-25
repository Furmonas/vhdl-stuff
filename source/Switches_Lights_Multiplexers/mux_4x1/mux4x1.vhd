library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux4x1 is -- DATA_WIDTH bit wide 4 to 1 mux
    generic (DATA_WIDTH : integer
             );
    port (i_sw    : in std_logic_vector(1 downto 0);
          i_dat_u : in std_logic_vector(DATA_WIDTH-1 downto 0);
          i_dat_w : in std_logic_vector(DATA_WIDTH-1 downto 0);
          i_dat_x : in std_logic_vector(DATA_WIDTH-1 downto 0);
          i_dat_z : in std_logic_vector(DATA_WIDTH-1 downto 0);
          o_dat   : out std_logic_vector(DATA_WIDTH-1 downto 0)
          );
end mux4x1;

architecture behavioral of mux4x1 is
begin
    o_dat <= i_dat_u when (i_sw="00") else
             i_dat_w when (i_sw="01") else
             i_dat_x when (i_sw="10") else
             i_dat_z when (i_sw="11") else
             (others => '0');
end behavioral;
