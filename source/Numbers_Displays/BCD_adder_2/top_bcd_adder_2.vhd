library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- This is used to implement the following algorithm:
-- (1)  T0 = A + B + C0
-- (2)  if (T0 > 9) then
-- (3)      Z0 = 10
-- (4)      C1 = 1
-- (5)  else
-- (6)      Z0 = 0
-- (7)      C1 = 0
-- (8)  end if
-- (9)  S0 = T0 - Z0
-- (10) S1 = C1

-- similar implemetation in top_bcd_adder
-- this uses other method -> just to show that there are more methods in solving the same problem

entity top_bcd_adder_2 is
    port (SW   : in std_logic_vector(8 downto 0);
          LEDR : out std_logic_vector(5 downto 0);
          HEX0 : out std_logic_Vector (6 downto 0);
          HEX1 : out std_logic_Vector (6 downto 0);
          HEX3 : out std_logic_Vector (6 downto 0);
          HEX5 : out std_logic_Vector (6 downto 0)
          );
end top_bcd_adder_2;

architecture behavioral of top_bcd_adder_2 is
    component bcd_adder is
        port (i_c   : in std_logic; -- input carry signal
              i_a   : in std_logic_vector(3 downto 0); -- first bcd digit
              i_b   : in std_logic_vector(3 downto 0); -- second bcd digit
              o_sum : out std_logic_vector(4 downto 0) -- 5-bit binary sum
              );
    end component;
    
    component seg7_dec is
        port (i_dat : in std_logic_vector(3 downto 0);
              o_seg : out std_logic_vector(6 downto 0)
              );
    end component;
    
    component substraction is
        port (i_dat0 : in std_logic_vector(3 downto 0); -- first data input
              i_dat1 : in std_logic_vector(3 downto 0); -- second data input
              o_sub  : out std_logic_vector(3 downto 0) -- output sub result
              );
    end component;
    
    signal t0_sum : std_logic_vector(4 downto 0);
    signal S0_S1 : std_logic_vector(4 downto 0);
    
    signal Z0_C1 : std_logic_vector(4 downto 0);
    
    -- signals are used to indicate an error if BCD digit is >9
    signal bcd_err1 : std_logic;
    signal bcd_err2 : std_logic;
    
begin
    B0 : bcd_adder
         port map (i_c => SW(8),
                   i_a => SW(3 downto 0),
                   i_b => SW(7 downto 4),
                   o_sum => t0_sum
                  );
    
    with t0_sum select Z0_C1 <= "00000" when "00000",
                                "00000" when "00001",
                                "00000" when "00010",
                                "00000" when "00011",
                                "00000" when "00100",
                                "00000" when "00101",
                                "00000" when "00110",
                                "00000" when "00111",
                                "00000" when "01000",
                                "00000" when "01001",
                                "11010" when others;
                                
    B1 : substraction
         port map (i_dat0 => t0_sum(3 downto 0),
                   i_dat1 => Z0_C1(3 downto 0),
                   o_sub => S0_S1(3 downto 0)
                  );

    S0_S1(4) <= Z0_C1(4);
                   
    D1 : seg7_dec
         port map (i_dat => SW(3 downto 0),
                   o_seg => HEX3
                   );
                   
    D2 : seg7_dec
         port map (i_dat => SW(7 downto 4),
                   o_seg => HEX5
                   );
                   
    D3 : seg7_dec
         port map (i_dat => "000" & S0_S1(4),
                   o_seg => HEX1
                   );
                   
    D4 : seg7_dec
         port map (i_dat => S0_S1(3 downto 0),
                   o_seg => HEX0
                   );
                                
    LEDR(4 downto 0) <= t0_sum(4 downto 0);

    -- indicate an error if BCD digits are >9
    bcd_err1 <= SW(3) AND (SW(2) OR SW(1));
    bcd_err2 <= SW(7) AND (SW(6) OR SW(5));
    LEDR(5) <= bcd_err1 OR bcd_err2;
    
end behavioral;
