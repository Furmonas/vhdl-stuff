library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_segment7_decoder is
    port (SW   : in std_logic_vector(9 downto 0);
          LEDR : out std_logic_vector(9 downto 0);
          HEX0 : out std_logic_Vector (6 downto 0);
          HEX1 : out std_logic_Vector (6 downto 0)
          );
end top_segment7_decoder;

architecture behavioral of top_segment7_decoder is
    component seg7_dec is
        port (i_dat : in std_logic_vector(3 downto 0);
              o_seg : out std_logic_vector(6 downto 0)
              );
    end component;
begin
    U0 : seg7_dec
         port map (i_dat => SW(3 downto 0),
                   o_seg => HEX0
                   );
    
    U1 : seg7_dec
         port map (i_dat => SW(7 downto 4),
                   o_seg => HEX1
                   );
    LEDR <= SW;
end behavioral;
