library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ripple_carry_adder is -- 4 bit ripple carry adder
    port (i_c    : in  std_logic; -- input carry signal
          i_dat0 : in  std_logic_vector(3 downto 0); -- input first 4 bit data
          i_dat1 : in  std_logic_vector(3 downto 0); -- input second 4 bit data
          o_c    : out std_logic; -- output carry signal
          o_sum  : out std_logic_vector(3 downto 0) -- output sum
          );
end ripple_carry_adder;

architecture behavioral of ripple_carry_adder is
    component full_adder is
        port (i_c    : in std_logic; -- input carry signal
              i_dat0 : in std_logic; -- first data input
              i_dat1 : in std_logic; -- second data input
              o_c    : out std_logic; -- output carry signal
              o_sum  : out std_logic -- output sum result
              );
    end component;
    
    signal temp_c0 : std_logic; -- ripple carry signal 0->1
    signal temp_c1 : std_logic; -- ripple carry signal 1->2
    signal temp_c2 : std_logic; -- ripple carry signal 2->3
    
begin

    FA0 : full_adder
          port map (i_c => i_c,
                    i_dat0 => i_dat0(0),
                    i_dat1 => i_dat1(0),
                    o_c => temp_c0,
                    o_sum => o_sum(0)
                    );
                    
    FA1 : full_adder
          port map (i_c => temp_c0,
                    i_dat0 => i_dat0(1),
                    i_dat1 => i_dat1(1),
                    o_c => temp_c1,
                    o_sum => o_sum(1)
                    );
                    
    FA2 : full_adder
          port map (i_c => temp_c1,
                    i_dat0 => i_dat0(2),
                    i_dat1 => i_dat1(2),
                    o_c => temp_c2,
                    o_sum => o_sum(2)
                    );
                    
    FA3 : full_adder
          port map (i_c => temp_c2,
                    i_dat0 => i_dat0(3),
                    i_dat1 => i_dat1(3),
                    o_c => o_c,
                    o_sum => o_sum(3)
                    );
    
end behavioral;
