library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity dec_7seg is -- 7 segment decoder with 2 bit input
    port (i_sw    : in std_logic_vector(2 downto 0);
          o_dat   : out std_logic_vector(6 downto 0)
          );
end dec_7seg;

architecture behavioral of dec_7seg is
begin
    with i_sw select o_dat <= "0100001" when "000",
                              "0000110" when "001",
                              "1111001" when "010",
                              "1000000" when "011",
                              "1111111" when others;
end behavioral;
