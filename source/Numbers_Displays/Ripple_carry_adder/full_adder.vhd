library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity full_adder is -- full 2 bit adder
    port (i_c    : in std_logic; -- input carry signal
          i_dat0 : in std_logic; -- first data input
          i_dat1 : in std_logic; -- second data input
          o_c    : out std_logic; -- output carry signal
          o_sum  : out std_logic -- output sum result
          );
end full_adder;

architecture behavioral of full_adder is
    component mux2x1_single is
        port (i_sw    : in std_logic;
              i_dat_x : in std_logic;
              i_dat_y : in std_logic;
              o_dat   : out std_logic
              );
    end component;
    
    -- stores xor result of 2 bit input
    signal i_dat_xor : std_logic;
    
begin
    i_dat_xor <= i_dat0 XOR i_dat1;
    o_sum <= i_dat_xor XOR i_c;
    
    U1 : mux2x1_single
         port map (i_sw => i_dat_xor,
                   i_dat_x => i_dat1,
                   i_dat_y => i_c,
                   o_dat => o_c
                   );
end behavioral;
