library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity b2d is --4 bit binary number convert to two diget decimal equivalent
    generic (DATA_WIDTH : integer
             );
    port (i_dat   : in std_logic_vector(3 downto 0);
          o_seg_1 : out std_logic_vector(6 downto 0);
          o_seg_0 : out std_logic_vector(6 downto 0)
          );
end b2d;

architecture behavioral of b2d is
    component seg7_dec is
        port (i_dat : in std_logic_vector(3 downto 0);
              o_seg : out std_logic_vector(6 downto 0)
              );
    end component;
    
    component mux2x1 is
        generic (DATA_WIDTH : integer
                 );
        port (i_sw    : in std_logic;
              i_dat_x : in std_logic_vector(DATA_WIDTH-1 downto 0);
              i_dat_y : in std_logic_vector(DATA_WIDTH-1 downto 0);
              o_sw    : out std_logic;
              o_dat   : out std_logic_vector(DATA_WIDTH-1 downto 0)
              );
    end component;

    constant decimal_dozen : std_logic_vector(DATA_WIDTH-2 downto 0) := "000";
    
    signal o_comp     : std_logic;
    signal o_dozens   : std_logic_vector(DATA_WIDTH-1 downto 0);
    signal i_dat_conv : std_logic_vector(DATA_WIDTH-1 downto 0);
    signal o_units    : std_logic_vector(DATA_WIDTH-1 downto 0);

begin
    -- check if input >9 with boolean expression
    o_comp <= i_dat(3) AND (i_dat(1) OR i_dat(2));
    o_dozens <= decimal_dozen & o_comp;
    
    -- output 0 or 1 for the dozens based on o_dozens signal
    U0 : seg7_dec
         port map (i_dat => o_dozens,
                   o_seg => o_seg_1
                   );
    
    -- convert the data for values >9 in units (based on K-map)
    i_dat_conv(0) <= i_dat(0);
    i_dat_conv(1) <= NOT i_dat(1);
    i_dat_conv(2) <= i_dat(1) AND i_dat(2);
    i_dat_conv(3) <= '0';
    
    -- output the units based on the dozens
    U1 : mux2x1
         generic map (DATA_WIDTH => DATA_WIDTH)
         port map (i_sw => o_comp,
                   i_dat_x => i_dat,
                   i_dat_y => i_dat_conv,
                   o_dat => o_units
                   );
                   
    -- show units on the 7 segments display
    U2 : seg7_dec
         port map (i_dat => o_units,
                   o_seg => o_seg_0
                   );
    
end behavioral;
