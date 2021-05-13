library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity clock_div is
    Port (clk_100MHz : in STD_LOGIC;
          half_period : in integer;
          clk_out : out STD_lOGIC);
end clock_div;

architecture Behavioral of clock_div is

signal count : integer;
signal clk : STD_LOGIC;

begin

clk_out <= clk;

process(clk_100MHz) begin

    if rising_edge(clk_100MHz) then
        if count < half_period then
            count <= count + 1;
        else
            count <= 0;
            clk <= NOT clk;
        end if;
    end if;

end process;

end Behavioral;
