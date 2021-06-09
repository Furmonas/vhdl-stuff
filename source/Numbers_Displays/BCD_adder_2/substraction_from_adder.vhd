library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- substraction module
-- based on two adders

entity substraction is -- 4 bit substraction
    port (i_dat0 : in std_logic_vector(3 downto 0); -- first data input
          i_dat1 : in std_logic_vector(3 downto 0); -- second data input
          o_sub  : out std_logic_vector(3 downto 0) -- output sub result
          );
end substraction;

architecture behavioral of substraction is
    component ripple_carry_adder is
        port (i_c    : in  std_logic; -- input carry signal
              i_dat0 : in  std_logic_vector(3 downto 0); -- input first 4 bit data
              i_dat1 : in  std_logic_vector(3 downto 0); -- input second 4 bit data
              o_c    : out std_logic; -- output carry signal
              o_sum  : out std_logic_vector(3 downto 0) -- output sum
              );
    end component;
    
    signal sub_int : std_logic_Vector (3 downto 0);
    
begin
    
    U1 : ripple_carry_adder
         port map (i_c => '0',
                   i_dat0 => i_dat0,
                   i_dat1 => NOT i_dat1, -- 1's complement
                   o_sum => sub_int
                   );
                   
    U2 : ripple_carry_adder
         port map (i_c => '0',
                   i_dat0 => sub_int,
                   i_dat1 => "0001", -- carry in
                   o_sum => o_sub
                   );
    
end behavioral;
