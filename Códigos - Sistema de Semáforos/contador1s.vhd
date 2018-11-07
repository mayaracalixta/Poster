library ieee;
use ieee.std_logic_1164.all;

entity contador1s is
	port(
		clk :in  std_logic;
		S : in std_logic;
		enable : in std_logic;
		reset : in std_logic;
		botao1,botao2 : in std_logic;
		segundos : out integer;
		Sout : out std_logic
	);
end contador1s;

architecture contador1s of contador1s is

	component flipFlopJK is
		port(
			J,K : in std_logic;
			clear, preset : in std_logic;
			clk : in std_logic;
			Q: out std_logic
		);
	end component;
	
	component DivisorFrequencia is 
		port( 
			clock_in : in std_logic;
			botao1,botao2 : in std_logic;
			contar_ate : out integer;
			clock_out : out std_logic
			);
	end component;
	
	signal J : std_logic;
	signal K : std_logic;
	signal Q : std_logic;
	signal Qf : std_logic;
	signal clk_outx : std_logic;
	signal conta_ate : integer :=0;
	
	begin
	
	J <= (enable and S and not(Q)) or (enable and not(S) and not(Q)) or (((not(not(enable) and reset) and reset) and (not(enable))));
	K <= (enable and S and Q) or (enable and not(S) and Q) or (not(enable) and reset);
		
	NewClock : DivisorFrequencia port map(clk,botao1,botao2,conta_ate,clk_outx);
	ff00 : flipFlopJK port map(J,K,'1','1',clk_outx,Qf);
	
	segundos <= conta_ate;
	Q <= Qf;
	Sout <= clk_outx;
	
end contador1s;