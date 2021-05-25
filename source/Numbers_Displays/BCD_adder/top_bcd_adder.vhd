library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_bcd_adder is
    port (SW   : in std_logic_vector(8 downto 0);
          LEDR : out std_logic_vector(5 downto 0);
          HEX0 : out std_logic_Vector (6 downto 0);
          HEX1 : out std_logic_Vector (6 downto 0);
          HEX3 : out std_logic_Vector (6 downto 0);
          HEX5 : out std_logic_Vector (6 downto 0)
          );
end top_bcd_adder;

architecture behavioral of top_bcd_adder is
    component bcd_adder is
        port (i_c   : in std_logic; -- input carry signal
              i_a   : in std_logic_vector(3 downto 0); -- first bcd digit
              i_b   : in std_logic_vector(3 downto 0); -- second bcd digit
              o_sum : out std_logic_vector(4 downto 0) -- 5-bit binary sum
              );
    end component;
    component bcd_segment_disp is
        port (i_dat   : in std_logic_vector(4 downto 0);
              o_seg_1 : out std_logic_vector(6 downto 0);
              o_seg_0 : out std_logic_vector(6 downto 0)
              );
    end component;
    component seg7_dec is
        port (i_dat : in std_logic_vector(3 downto 0);
              o_seg : out std_logic_vector(6 downto 0)
              );
    end component;
    
    signal bit5_bin_sum : std_logic_vector(4 downto 0);
    
    -- signals are used to indicate an error if BCD digit is >9
    signal bcd_err1 : std_logic;
    signal bcd_err2 : std_logic;
    
begin
    B0 : bcd_adder
         port map (i_c => SW(8),
                   i_a => SW(3 downto 0),
                   i_b => SW(7 downto 4),
                   o_sum => bit5_bin_sum
                  );
    D0 : bcd_segment_disp
         port map (i_dat => bit5_bin_sum,
                   o_seg_1 => HEX1,
                   o_seg_0 => HEX0
                   );
                   
    D1 : seg7_dec
         port map (i_dat =>  SW(3 downto 0),
                   o_seg => HEX3
                   );
                   
    D2 : seg7_dec
         port map (i_dat =>  SW(7 downto 4),
                   o_seg => HEX5
                   );
                                
    LEDR(4 downto 0) <= bit5_bin_sum(4 downto 0);

    -- indicate an error if BCD digits are >9
    bcd_err1 <= SW(3) AND (SW(2) OR SW(1));
    bcd_err2 <= SW(7) AND (SW(6) OR SW(5));
    LEDR(5) <= bcd_err1 OR bcd_err2;
    
end behavioral;
