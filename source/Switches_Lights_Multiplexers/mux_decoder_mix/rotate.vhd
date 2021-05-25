library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rotate is
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
end rotate;

architecture behavioral of rotate is
    component mux6x1 is
        generic (DATA_WIDTH : integer
             );
        port (i_sw    : in std_logic_vector(2 downto 0);
              i_dat_0 : in std_logic_vector(DATA_WIDTH-1 downto 0);
              i_dat_1 : in std_logic_vector(DATA_WIDTH-1 downto 0);
              i_dat_2 : in std_logic_vector(DATA_WIDTH-1 downto 0);
              i_dat_3 : in std_logic_vector(DATA_WIDTH-1 downto 0);
              i_dat_4 : in std_logic_vector(DATA_WIDTH-1 downto 0);
              i_dat_5 : in std_logic_vector(DATA_WIDTH-1 downto 0);
              o_dat   : out std_logic_vector(DATA_WIDTH-1 downto 0)
              );
    end component;
    component dec_7seg is
        port (i_sw    : in std_logic_vector(2 downto 0);
              o_dat   : out std_logic_vector(6 downto 0)
              );
    end component;
    
    -- this width is defined by DATA_WIDTH, but max is 2 downto 0, because dec_7seg input is max
    signal o_m0 : std_logic_vector(DATA_WIDTH-1 downto 0);
    signal o_m1 : std_logic_vector(DATA_WIDTH-1 downto 0);
    signal o_m2 : std_logic_vector(DATA_WIDTH-1 downto 0);
    signal o_m3 : std_logic_vector(DATA_WIDTH-1 downto 0);
    signal o_m4 : std_logic_vector(DATA_WIDTH-1 downto 0);
    signal o_m5 : std_logic_vector(DATA_WIDTH-1 downto 0);
     
    alias sw_ctrl : std_logic_vector(2 downto 0) is i_sw(9 downto 7);
    alias sw_dat0 : std_logic_vector(DATA_WIDTH-1 downto 0) is i_sw(6 downto 4); -- d
    alias sw_dat1 : std_logic_vector(DATA_WIDTH-1 downto 0) is i_sw(3 downto 1); -- e
    
    -- using constant values here because there are not enough switches to test for 3 bit wide data
    constant im_sw2 : std_logic_vector(DATA_WIDTH-1 downto 0) := "010"; -- 1
    constant im_sw3 : std_logic_vector(DATA_WIDTH-1 downto 0) := "011"; -- 0
    constant im_sw_blank : std_logic_vector(DATA_WIDTH-1 downto 0) := "111"; -- blank
    
begin
    U0 : mux6x1
         generic map (DATA_WIDTH => DATA_WIDTH)
         port map (i_sw => sw_ctrl,
                   i_dat_0 => im_sw3,
                   i_dat_1 => im_sw_blank,
                   i_dat_2 => im_sw_blank,
                   i_dat_3 => sw_dat0,
                   i_dat_4 => sw_dat1,
                   i_dat_5 => im_sw2,
                   o_dat => o_m0
                   );
    H0 : dec_7seg
         port map (i_sw => o_m0,
                   o_dat => o_dat0);
                   
    U1 : mux6x1
         generic map (DATA_WIDTH => DATA_WIDTH)
         port map (i_sw => sw_ctrl,
                   i_dat_0 => im_sw2,
                   i_dat_1 => im_sw3,
                   i_dat_2 => im_sw_blank,
                   i_dat_3 => im_sw_blank,
                   i_dat_4 => sw_dat0,
                   i_dat_5 => sw_dat1,
                   o_dat => o_m1
                   );
    
    H1 : dec_7seg
         port map (i_sw => o_m1,
                   o_dat => o_dat1);
    U2 : mux6x1
         generic map (DATA_WIDTH => DATA_WIDTH)
         port map (i_sw => sw_ctrl,
                   i_dat_0 => sw_dat1,
                   i_dat_1 => im_sw2,
                   i_dat_2 => im_sw3,
                   i_dat_3 => im_sw_blank,
                   i_dat_4 => im_sw_blank,
                   i_dat_5 => sw_dat0,
                   o_dat => o_m2
                   );
    
    H2 : dec_7seg
         port map (i_sw => o_m2,
                   o_dat => o_dat2);
    U3 : mux6x1
         generic map (DATA_WIDTH => DATA_WIDTH)
         port map (i_sw => sw_ctrl,
                   i_dat_0 => sw_dat0,
                   i_dat_1 => sw_dat1,
                   i_dat_2 => im_sw2,
                   i_dat_3 => im_sw3,
                   i_dat_4 => im_sw_blank,
                   i_dat_5 => im_sw_blank,
                   o_dat => o_m3
                   );
    
    H3 : dec_7seg
         port map (i_sw => o_m3,
                   o_dat => o_dat3);
                   
    U4 : mux6x1
         generic map (DATA_WIDTH => DATA_WIDTH)
         port map (i_sw => sw_ctrl,
                   i_dat_0 => im_sw_blank,
                   i_dat_1 => sw_dat0,
                   i_dat_2 => sw_dat1,
                   i_dat_3 => im_sw2,
                   i_dat_4 => im_sw3,
                   i_dat_5 => im_sw_blank,
                   o_dat => o_m4
                   );
    
    H4 : dec_7seg
         port map (i_sw => o_m4,
                   o_dat => o_dat4);
                   
    U5 : mux6x1
         generic map (DATA_WIDTH => DATA_WIDTH)
         port map (i_sw => sw_ctrl,
                   i_dat_0 => im_sw_blank,
                   i_dat_1 => im_sw_blank,
                   i_dat_2 => sw_dat0,
                   i_dat_3 => sw_dat1,
                   i_dat_4 => im_sw2,
                   i_dat_5 => im_sw3,
                   o_dat => o_m5
                   );
    
    H5 : dec_7seg
         port map (i_sw => o_m5,
                   o_dat => o_dat5);
end behavioral;
