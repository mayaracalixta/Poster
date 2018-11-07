library ieee;
use ieee.std_logic_1164.all;

entity Sensor_Velocidade is
	port(
		clk_maquina : in std_logic;
		botao1,botao2 : in std_logic;
		velocidade_ok,velocidade_bad : out std_logic
		);
	
end Sensor_Velocidade;

architecture Sensor_Velocidade of Sensor_Velocidade is

	component Contador3s is
		port(
			clk_maquina : in std_logic;
			botao1,botao2 : in std_logic;
			passou_o_tempo : out std_logic
		);
	end component;
	
	signal tempo : std_logic;
	
	begin
	
	sensor : Contador3s port map(clk_maquina,botao1,botao2,tempo);	
	
	velocidade_ok <= botao2 and tempo;
	velocidade_bad <= botao2 and not(tempo);
		
end architecture;