library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_mux_4x1 is
    generic (DATA_WIDTH : integer := 2
             );
    port (SW    : in std_logic_vector(9 downto 0);
          LEDR  : out std_logic_Vector (9 downto 0)
          );
end top_mux_4x1;

architecture behavioral of top_mux_4x1 is
    component mux4x1 is
        generic (DATA_WIDTH : integer
                 );
        port (i_sw    : in std_logic_vector(1 downto 0);
              i_dat_u : in std_logic_vector(DATA_WIDTH-1 downto 0);
              i_dat_w : in std_logic_vector(DATA_WIDTH-1 downto 0);
              i_dat_x : in std_logic_vector(DATA_WIDTH-1 downto 0);
              i_dat_z : in std_logic_vector(DATA_WIDTH-1 downto 0);
              o_dat   : out std_logic_vector(DATA_WIDTH-1 downto 0)
              );
    end component;
begin
    MUX2BIT : mux4x1
             generic map (DATA_WIDTH => DATA_WIDTH
                          )
             port map (i_sw => SW(9 downto 8),
                       i_dat_u => SW(7 downto 6),
                       i_dat_w => SW(5 downto 4),
                       i_dat_x => SW(3 downto 2),
                       i_dat_z => SW(1 downto 0),
                       o_dat => LEDR(1 downto 0)
                       );
                       
    LEDR(9 downto 2) <= (others => '0');
end behavioral;
