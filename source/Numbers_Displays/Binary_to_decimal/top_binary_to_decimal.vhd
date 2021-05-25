library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_binary_to_decimal is
    generic (DATA_WIDTH : integer := 4
             );
    port (SW   : in std_logic_vector(9 downto 0);
          LEDR : out std_logic_vector(9 downto 0);
          HEX0 : out std_logic_Vector (6 downto 0);
          HEX1 : out std_logic_Vector (6 downto 0)
          );
end top_binary_to_decimal;

architecture behavioral of top_binary_to_decimal is
    component b2d is
        generic (DATA_WIDTH : integer
                 );
        port (i_dat   : in std_logic_vector(3 downto 0);
              o_seg_1 : out std_logic_vector(6 downto 0);
              o_seg_0 : out std_logic_vector(6 downto 0)
              );
    end component;
begin
    B0 : b2d
         generic map (DATA_WIDTH => DATA_WIDTH
                      )
         port map (i_dat => SW(3 downto 0),
                   o_seg_1 => HEX1,
                   o_seg_0 => HEX0
                   );
    LEDR <= SW;
end behavioral;
