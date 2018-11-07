library ieee;
use ieee.std_logic_1164.all;

entity Contador3s is
	
	port( 
		clk_maquina : in std_logic; --Ja sabe neh
		botao1,botao2 : in std_logic; --botao de começo e fim da contagem
		passou_o_tempo : out std_logic --se 0 então vai ser multado se 1 não
	);
	
end Contador3s;

architecture Contador3s of Contador3s is

	component flipFlopJK is --vrau
		port(
			J,K : in std_logic;
			clear, preset : in std_logic;
			clk : in std_logic;
			Q : out std_logic
		);
	end component;
	
	component DivisorFrequencia is --pra contar em segundos
		port( 
			clock_in : in std_logic;
			clock_out : out std_logic
			);
	end component;
	
	signal J2,K2,J1,K1,J0,K0 : std_logic;
	signal Qa2,Qa1,Qa0 : std_logic;
	signal Qf2,Qf1,Qf0 : std_logic;
	signal clk_out : std_logic;
	signal botao1_pressionado : std_logic;
	signal contador : integer := -3;
	signal passou : std_logic;
	
	begin
	
	process(botao1,Qa1,Qa0,botao2,passou)
		begin
		if(botao1 = '1') then
			botao1_pressionado <= '1';
		end if;
		
		if(botao2 = '1') then
			botao1_pressionado <= '0';
		end if;
		
		if(Qa1 = '1' and Qa0 = '1') then
			contador <= contador+3;
		end if;
		
		if(contador = 3) then
			passou <= '1';
		end if;
			
		if(botao2 = '1' and passou = '1') then
			passou_o_tempo <= '1';
		end if; 
		
		if(botao2 = '1' and passou = '0') then
			passou_o_tempo <= '0';
		end if;
		
	end process;
	
	J2 <= '0';
	K2 <= '0';
	J1 <= not(Qa2) and not(Qa1) and Qa0;
	K1 <= not(Qa2) and Qa1 and Qa0;
	J0 <= not(Qa2) and not(Qa0);
	K0 <= not(Qa2) and Qa0;
	
	time_set : DivisorFrequencia port map(clk_maquina,clk_out);
	ff22 : flipFlopJK port map(J2,K2,'1','1',clk_out,Qf2);
	ff11 : flipFlopJK port map(J1,K1,'1','1',clk_out,Qf1);
	ff00 : flipFlopJK port map(J0,K0,'1','1',clk_out,Qf0);
	
	Qa2 <= Qf2 and botao1_pressionado;
	Qa1 <= Qf1 and botao1_pressionado;
	Qa0 <= Qf0 and botao1_pressionado;
	
	
end architecture;