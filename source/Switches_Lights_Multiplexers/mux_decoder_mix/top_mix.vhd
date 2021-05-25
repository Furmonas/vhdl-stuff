library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_mix is
    generic (DATA_WIDTH : integer := 3
             );
    port (SW   : in std_logic_vector(9 downto 0);
          LEDR : out std_logic_vector(9 downto 0);
          HEX0 : out std_logic_Vector(6 downto 0);
          HEX1 : out std_logic_Vector(6 downto 0);
          HEX2 : out std_logic_Vector(6 downto 0);
          HEX3 : out std_logic_Vector(6 downto 0);
          HEX4 : out std_logic_Vector(6 downto 0);
          HEX5 : out std_logic_Vector(6 downto 0)
          );
end top_mix;

architecture behavioral of top_mix is
    component rotate is
        generic (DATA_WIDTH : integer
                 );
        port (i_sw   : in std_logic_vector(9 downto 0);
              o_dat0 : out std_logic_Vector(6 downto 0);
              o_dat1 : out std_logic_Vector(6 downto 0);
              o_dat2 : out std_logic_Vector(6 downto 0);
              o_dat3 : out std_logic_Vector(6 downto 0);
              o_dat4 : out std_logic_Vector(6 downto 0);
              o_dat5 : out std_logic_Vector(6 downto 0)
              );
    end component;
begin
    R1 : rotate
         generic map (DATA_WIDTH => DATA_WIDTH)
         port map (i_sw => SW,
                   o_dat0 => HEX0,
                   o_dat1 => HEX1,
                   o_dat2 => HEX2,
                   o_dat3 => HEX3,
                   o_dat4 => HEX4,
                   o_dat5 => HEX5
                   );
                   
    LEDR <= SW;
end behavioral;
