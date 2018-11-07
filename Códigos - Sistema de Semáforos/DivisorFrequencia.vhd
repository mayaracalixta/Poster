library ieee;
use ieee.std_logic_1164.all;

entity DivisorFrequencia is
	port( 
		clock_in : in std_logic;
		clock_out : out std_logic
		);
end DivisorFrequencia;

architecture DivisorFrequencia of DivisorFrequencia is
	
	signal  estado : std_logic;
	signal contagem : integer :=1;
	
	begin
	
	process(clock_in,contagem,estado)
		
		begin
			
				if(clock_in='1' and clock_in'Event) then
					
					if (contagem = 27/2) then
						estado <= not(estado);
						contagem <= 1;
					else
						contagem <= contagem + 1;
					end if;
				end if;

	
	end process;
	
	clock_out <= estado;
	
end DivisorFrequencia;