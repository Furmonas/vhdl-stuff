library ieee;
use ieee.std_logic_1164.all;

entity top_mux_2x1 is
    generic (DATA_WIDTH : integer := 4
             );
    port (SW    : in std_logic_vector(9 downto 0);
          LEDR  : out std_logic_Vector (9 downto 0)
          );
end top_mux_2x1;

architecture behavioral of top_mux_2x1 is
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
begin
    MUX4BIT : mux2x1
             generic map (DATA_WIDTH => DATA_WIDTH
                          )
             port map (i_sw => SW(9),
                       i_dat_x => SW(3 downto 0),
                       i_dat_y => SW(7 downto 4),
                       o_sw => LEDR(9),
                       o_dat => LEDR(3 downto 0)
                       );
                       
    LEDR(8 downto 4) <= (others => '0');
end behavioral;
