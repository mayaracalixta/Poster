library ieee;
use ieee.std_logic_1164.all;

entity Gerador_de_Clocks is
	port(
		clk_maquina : in std_logic;
		temp1, temp0 : std_logic;
		clk_saida_gua,clk_saida_acai : out std_logic
   );
	
end Gerador_de_Clocks;

architecture Gerador_de_Clocks of Gerador_de_Clocks is

	signal contador_gua,contador_acai : integer := 0;
	signal valor_gua : std_logic := '1';
	signal valor_acai : std_logic := '0';

	begin
	
		process(clk_maquina,temp1,temp0,contador_acai,contador_gua)
			begin
			
			if(clk_maquina = '1' and clk_maquina'Event) then
				
				if(temp1 = '0' and temp0 = '0') then --clock da temporização A (Sinal guarana)
				
					if(contador_gua <= 27*20*1000000) then --20 segundos ativado
						valor_gua <= '1';
						contador_gua <= contador_gua + 1;
					else if(contador_gua > 27*20 and contador_gua <= 27*20*1000000 + 27*3*1000000) then --3 segundos desativados para o amarelo
						valor_gua <= '0';
						contador_gua <= contador_gua + 1;
					else if(contador_gua > 27*20 + 27*3 and contador_gua <= 27*20*1000000 + 27*3*1000000 + 27*20*1000000) then --20 segundos desativado para o vermelho
						valor_gua <= '0';
						contador_gua <= contador_gua+1;
					else if(contador_gua > 27*20 + 27*3 + 27*20 and contador_gua <= 27*20*1000000 + 27*3*1000000 + 27*20*1000000 + 27*3*1000000) then --3 segundos desativado para o amarelo
						valor_gua <= '0';
						contador_gua <= contador_gua+1;
					else
						contador_gua <= 0; --repete novamente
					end if;
					end if;
					end if;
					end if;
				end if;
				
				if(temp1 = '0' and temp0 = '0') then --clock da temporização A (Sinal acai)
				
					if(contador_acai <= 27*20*1000000) then --20 segundos desativado no vermelho
						valor_acai <= '0';
						contador_acai <= contador_acai + 1;
					else if(contador_acai > 27*20*1000000 and contador_acai <= 27*20*1000000 + 27*3*1000000) then -- 3 segundos desativado no amarelo
						valor_acai <= '0';
						contador_acai <= contador_acai + 1;
					else if(contador_acai > 27*20*1000000 + 27*3*1000000 and contador_acai <= 27*20*1000000 + 27*3*1000000 + 27*20*1000000) then --20 segundos ativado no verde
						valor_acai <= '1';
						contador_acai <= contador_acai+1;
					else if(contador_acai > 27*20*1000000 + 27*3*1000000 + 20*20*1000000 and contador_acai <= 27*20*1000000 + 27*3*1000000 + 27*20*1000000 + 27*3*1000000) then --3 segundos desativado no amarelo
						valor_acai <= '0';
						contador_acai <= contador_acai + 1;
					else
						contador_acai <= 0; --repete novamente
					end if;
					end if;
					end if;
					end if;
					
				end if;
			
				if(temp1 = '0' and temp0 = '1') then --Clock da temporização B ( sinal guarana)
				
					if(contador_gua <= 27*30*1000000) then -- ativado 30 segundos
						valor_gua <= '1';
						contador_gua <= contador_gua + 1;
					else if(contador_gua > 27*30*1000000 and contador_gua <= 27*30*1000000 + 27*3*1000000) then -- desativado 3 segundos no amarelo
						valor_gua <= '0';
						contador_gua <= contador_gua + 1;
					else if(contador_gua > 27*30*1000000 + 27*3*1000000 and contador_gua <= 27*30*1000000 + 27*3*1000000 + 27*10*1000000) then -- desativado 10 segundos no vermelho
						valor_gua <= '0';
						contador_gua <= contador_gua+1;
					else if(contador_gua > 27*30*1000000 + 27*3*1000000 + 27*10*1000000 and contador_gua <= 27*30*1000000 + 27*3*1000000 + 27*10*1000000 + 27*3*1000000) then -- desativo 3 segundos no amarelo
						valor_gua <= '0';
						contador_gua <= contador_gua +1;
					else
						contador_gua <= 0; -- repete novamente
					end if;
					end if;
					end if;
					end if;
					
				end if;
				
				if(temp1 = '0' and temp0 = '1') then --Clock da temporização B (sinal acai)
				
					if(contador_acai <= 27*30*1000000) then -- 30 segundos desativado
						valor_acai <= '0';
						contador_acai <= contador_acai + 1;
					else if(contador_acai > 27*30*1000000 and contador_acai <= 27*30*1000000 + 27*3*1000000) then -- 3 segundos desativado no amarelo
						valor_acai <= '0';
						contador_acai <= contador_acai + 1;
					else if(contador_acai > 27*30*1000000 + 27*3*1000000 and contador_acai <= 27*30*1000000 + 27*3*1000000 + 27*10*1000000) then -- 10 segundos ativado
						valor_acai <= '1';
						contador_acai <= contador_acai+1;
					else if(contador_acai > 27*30*1000000 + 27*3*1000000 + 27*10*1000000 and contador_acai <= 27*30*1000000 + 27*3*1000000 + 27*10*1000000 + 27*3*1000000) then -- 3 segundos desativado no amarelo
						valor_acai <= '0';
						contador_acai <= contador_acai +1;
					else
						contador_acai <= 0; -- repete novamente
					end if;
					end if;
					end if;
					end if;
					
				end if;
				
				
				if(temp1 = '1' and temp0 = '0') then --Clock da temporização C (Sinal guarana)
					valor_gua <= '1'; -- ativado enquanto estiver nesse temporizador
				end if;
				
				if(temp1 = '1' and temp0 = '0') then --Clock da temporização C (Sinal acai)
					valor_acai <= '0'; --preciso dar uma olhada nesse cara ainda !!!!
				end if;
			
			end if;
		end process;
		
	clk_saida_gua <= valor_gua; --saidas dos clocks
	clk_saida_acai <= valor_acai;
		
end architecture;

					