library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux6x1 is -- DATA_WIDTH bit wide 6 to 1 mux
    generic (DATA_WIDTH : integer
             );
    port (i_sw    : in std_logic_vector(2 downto 0);
          i_dat_0 : in std_logic_vector(DATA_WIDTH-1 downto 0);
          i_dat_1 : in std_logic_vector(DATA_WIDTH-1 downto 0);
          i_dat_2 : in std_logic_vector(DATA_WIDTH-1 downto 0);
          i_dat_3 : in std_logic_vector(DATA_WIDTH-1 downto 0);
          i_dat_4 : in std_logic_vector(DATA_WIDTH-1 downto 0);
          i_dat_5 : in std_logic_vector(DATA_WIDTH-1 downto 0);
          o_dat   : out std_logic_vector(DATA_WIDTH-1 downto 0)
          );
end mux6x1;

architecture behavioral of mux6x1 is
begin
    o_dat <= i_dat_0 when (i_sw="000") else
             i_dat_1 when (i_sw="001") else
             i_dat_2 when (i_sw="010") else
             i_dat_3 when (i_sw="011") else
             i_dat_4 when (i_sw="100") else
             i_dat_5 when (i_sw="101") else
             (others => '0');
end behavioral;