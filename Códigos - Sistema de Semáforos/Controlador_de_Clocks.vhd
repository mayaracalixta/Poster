library ieee;
use ieee.std_logic_1164.all;

entity Controlador_de_Clocks is
	port(
		temp1,temp0 : in std_logic;
		clk3,clk10,clk20,clk30 : in std_logic;
		clk_saida : out std_logic
	);
end Controlador_de_Clocks;

architecture Controlador_de_Clocks of Controlador_de_Clocks is

	begin
		process(temp1,temp0)
			begin

			
		end process;		

end architecture;