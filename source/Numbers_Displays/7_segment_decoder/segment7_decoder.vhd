library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity seg7_dec is -- 7 segment decoder with 4 bit input
    port (i_dat : in std_logic_vector(3 downto 0);
          o_seg : out std_logic_vector(6 downto 0)
          );
end seg7_dec;

architecture behavioral of seg7_dec is
begin
    with i_dat select o_seg <= "1000000" when "0000",
                               "1111001" when "0001",
                               "0100100" when "0010",
                               "0110000" when "0011",
                               "0011001" when "0100",
                               "0010010" when "0101",
                               "0000011" when "0110",
                               "1111000" when "0111",
                               "0000000" when "1000",
                               "0010000" when "1001",
                               "1111111" when others;
end behavioral;
