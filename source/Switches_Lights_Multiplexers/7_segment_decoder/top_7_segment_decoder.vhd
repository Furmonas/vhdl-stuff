library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_7_segment_decoder is
    port (SW   : in std_logic_vector(2 downto 0);
          HEX0 : out std_logic_Vector (6 downto 0)
          );
end top_7_segment_decoder;

architecture behavioral of top_7_segment_decoder is
    component dec_7seg is
        port (i_sw    : in std_logic_vector(2 downto 0);
              o_dat   : out std_logic_vector(6 downto 0)
              );
    end component;
begin
    SEG7 : dec_7seg
           port map (i_sw => SW,
                     o_dat => HEX0
                     );
end behavioral;
