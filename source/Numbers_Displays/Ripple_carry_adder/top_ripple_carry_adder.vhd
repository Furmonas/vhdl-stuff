library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_ripple_carry_adder is
    port (SW   : in std_logic_vector(8 downto 0);
          LEDR : out std_logic_vector(4 downto 0)
          );
end top_ripple_carry_adder;

architecture behavioral of top_ripple_carry_adder is
    component ripple_carry_adder is
        port (i_c    : in  std_logic; -- input carry signal
              i_dat0 : in  std_logic_vector(3 downto 0); -- input first 4 bit data
              i_dat1 : in  std_logic_vector(3 downto 0); -- input second 4 bit data
              o_c    : out std_logic; -- output carry signal
              o_sum  : out std_logic_vector(3 downto 0) -- output sum
              );
    end component;
begin
    RC0 : ripple_carry_adder
          port map (i_c => SW(8),
                    i_dat0 => SW(3 downto 0),
                    i_dat1 => SW(7 downto 4),
                    o_c => LEDR(4),
                    o_sum => LEDR(3 downto 0)
                    );
end behavioral;
