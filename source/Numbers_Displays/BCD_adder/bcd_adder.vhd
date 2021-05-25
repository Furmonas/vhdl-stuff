library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bcd_adder is -- 4 bit bcd adder
    port (i_c   : in std_logic; -- input carry signal
          i_a   : in std_logic_vector(3 downto 0); -- first bcd digit
          i_b   : in std_logic_vector(3 downto 0); -- second bcd digit
          o_sum : out std_logic_vector(4 downto 0) -- 5-bit binary sum
          );
end bcd_adder;

architecture behavioral of bcd_adder is
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
          port map (i_c => i_c,
                    i_dat0 => i_a,
                    i_dat1 => i_b,
                    o_c => o_sum(4),
                    o_sum => o_sum(3 downto 0)
                    );      
end behavioral;
