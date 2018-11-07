library ieee;
use ieee.std_logic_1164.all;

entity Projeto_Semaforo is
	port(
		clk_maquina : in std_logic; --clock da maquina ... duh
		temp1,temp0 : in std_logic; -- bits que definem a temporização (temp1 é o bit mais significativo)
		botao1,botao2 : in std_logic; -- botões para se medir a velocidade do automovel
		--clk_testeA_gua, clk_testeB_gua, clk_testeC_gua  : out std_logic; --variaveis de teste
		--clk_testeA_acai,clk_testeB_acai,clk_testeC_acai : out std_logic; -- variaveis de teste
		guarana_vermelho,guarana_amarelo,guarana_verde : out std_logic; -- luzes do sinal guarana
		acai_vermelho,acai_amarelo,acai_verde : out std_logic; --luzes do sinal acai
		velocidade_ok,velocidade_bad : out std_logic --luzes de multa ou não-multa
	);
end Projeto_Semaforo;


architecture Projeto_Semaforo of Projeto_Semaforo is
	
	component Gerador_de_Clocks is
		port(
			clk_maquina : in std_logic; -- clk da maquina novamente
			temp1,temp0 : in std_logic; -- adivinha
			clk_saida_gua,clk_saida_acai : out std_logic -- saida de cada clock para cada temporização
		);
	end component;
	
	component Sensor_Velocidade is
		port(
			clk_maquina : in std_logic; -- 1 é pouco, 2 é bom, 3 é demais
			botao1,botao2 : in std_logic; -- que dejavi!
			velocidade_ok,velocidade_bad : out std_logic -- sera que viajo no tempo?!
			);
	
	end component;
	
	signal clk_tempA_gua, clk_tempB_gua, clk_tempC_gua  : std_logic; --Boas praticas no VHDL
	signal clk_tempA_acai,clk_tempB_acai,clk_tempC_acai : std_logic; --kkkkkkkkkkkkk
	
	begin
	
	clk_A : Gerador_de_Clocks port map (clk_maquina,'0','0',clk_tempA_gua,clk_tempA_acai); --gerando os clocks de cada caso para cada semaforo
	clk_B : Gerador_de_Clocks port map (clk_maquina,'0','1',clk_tempB_gua,clk_tempB_acai);
	clk_C : Gerador_de_Clocks port map (clk_maquina,'1','0',clk_tempC_gua,clk_tempC_acai);
	
	--clk_testeA_gua <= clk_tempA_gua;
   --clk_testeA_acai <= clk_tempA_acai;
	--clk_testeB_gua <= clk_tempB_gua; --variaveis de teste
	--clk_testeB_acai <= clk_tempB_acai;
	--clk_testeC_gua <= clk_tempC_gua;
	--clk_testeC_acai <= clk_tempC_acai;
	
	guarana_verde <= (not(temp1) and not(temp0) and clk_tempA_gua) or --temporização A
						  (not(temp1) and temp0 and clk_tempB_gua) or --temporização B
						  (temp1 and not(temp0) and clk_tempC_gua); --temporização C
						  
						  
	acai_verde <= (not(temp1) and not(temp0) and clk_tempA_acai) or --temporização A
				     (not(temp1) and temp0 and clk_tempB_acai) or --temporização B
					  (temp1 and not(temp0) and clk_tempC_acai); --temporização C
	
	guarana_amarelo <= (not(temp1) and not(temp0) and not(clk_tempA_gua) and not(clk_tempA_acai)) or --temporização A
							 (not(temp1) and temp0 and not(clk_tempB_gua) and not(clk_tempB_acai)) or  --temporização B
							 (not(clk_tempC_gua) and not(clk_tempC_acai)); --temporização C
							 
							 
	acai_amarelo <= (not(temp1) and not(temp0) and not(clk_tempA_gua) and not(clk_tempA_acai)) or --igualao guarana_amarelo
					    (not(temp1) and temp0 and not(clk_tempB_gua) and not(clk_tempB_acai)) or 
						 (not(clk_tempC_gua) and not(clk_tempC_acai));
	
	acai_vermelho <=  (not(temp1) and not(temp0) and clk_tempA_gua) or --igual ao guarana_verde
							   (not(temp1) and temp0 and clk_tempB_gua) or 
								(temp1 and not(temp0) and clk_tempC_gua);

	guarana_vermelho <= (not(temp1) and not(temp0) and clk_tempA_acai) or --igual ao acai_verde
					     (not(temp1) and temp0 and clk_tempB_acai) or 
						  (temp1 and not(temp0) and clk_tempC_acai);
	
	Policia : Sensor_Velocidade port map(clk_maquina,botao1,botao2,velocidade_ok,velocidade_bad); --Sensor de velocidade

	
	
	
	
end architecture;