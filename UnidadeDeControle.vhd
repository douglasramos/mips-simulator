
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_signed.all;

library biblioteca_de_componentes;


	entity UnidadeDeControle is port (
		X, Y: in std_logic_vector(15 downto 0);
		ProdutoParcial: in std_logic_vector(32 downto 0);
		clock, somar: in std_logic;
		Produto: out std_logic_vector(31 downto 0);
		countFluxo: in std_logic_vector(3 downto 0);
		state, countControle: out std_logic_vector(3 downto 0);
		fin: out std_logic);
	
	end UnidadeDeControle;
	
	architecture controle of UnidadeDeControle is
	
		type state_type is (s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15, s16);
		signal PS, NS : state_type;
		
		signal resetO, soma, cicle, fim: std_logic := '0';
		signal referencia: std_logic_vector(32 downto 0);
		signal countContr: std_logic_vector(3 downto 0);
		
		begin
					
		sync_proc: process (clock, NS)
			begin	
				if (somar = '0') then 
					PS <= s0;
					state <= "0001";
				elsif (rising_edge(clock)) then
					PS <= NS;
				end if;
		end process sync_proc;
		
		
		comb_proc: process (PS)
			begin
	
				case PS is					   --primeira iteracao
					when s0=>
						countContr <= "0000";
						referencia <= ProdutoParcial;
						if (countFluxo = countContr) then
							NS <= s1;
						end if;
											   --segunda iteracao
					when s1=> 		
						countContr <= "0001";
						if (countFluxo = countContr and referencia /= ProdutoParcial) then
							referencia <= ProdutoParcial;
							NS <= s2;
						end if;
					
					when s2=>		 
						countContr <= "0010";
						if (countFluxo = countContr and referencia /= ProdutoParcial) then
							referencia <= ProdutoParcial;
							NS <= s3;
						end if;	
						
					
					when s3=>		
						countContr <= "0011";
						if (countFluxo = countContr and referencia /= ProdutoParcial) then
							referencia <= ProdutoParcial;
							NS <= s4;
						end if;
					
					when s4=>		
						countContr <= "0100";
						if (countFluxo = countContr and referencia /= ProdutoParcial) then
							referencia <= ProdutoParcial;
							NS <= s5;
						end if;
						
					when s5=>		
						countContr <= "0101";
						if (countFluxo = countContr and referencia /= ProdutoParcial) then
							referencia <= ProdutoParcial;
							NS <= s6;
						end if;
						
					when s6=>		
						countContr <= "0110";
						if (countFluxo = countContr and referencia /= ProdutoParcial) then
							referencia <= ProdutoParcial;
							NS <= s7;
						end if;
						
					when s7=>		
						countContr <= "0111";
						if (countFluxo = countContr and referencia /= ProdutoParcial) then
							referencia <= ProdutoParcial;
							NS <= s8;
						end if;
						
					when s8=>		
						countContr <= "1000";
						if (countFluxo = countContr and referencia /= ProdutoParcial) then
							referencia <= ProdutoParcial;
							NS <= s9;
						end if;
						
					when s9=>		
						countContr <= "1001";
						if (countFluxo = countContr and referencia /= ProdutoParcial) then
							referencia <= ProdutoParcial;
							NS <= s10;
						end if;
						
					when s10=>		
						countContr <= "1010";
						if (countFluxo = countContr and referencia /= ProdutoParcial) then
							referencia <= ProdutoParcial;
							NS <= s11;
						end if;	
						
					when s11=>		
						countContr <= "1011";
						if (countFluxo = countContr and referencia /= ProdutoParcial) then
							referencia <= ProdutoParcial;
							NS <= s12;
						end if;
						
					when s12=>		
						countContr <= "1100";
						if (countFluxo = countContr and referencia /= ProdutoParcial) then
							referencia <= ProdutoParcial;
							NS <= s13;
						end if;
						
					when s13=>		
						countContr <= "1101";
						if (countFluxo = countContr and referencia /= ProdutoParcial) then
							referencia <= ProdutoParcial;
							NS <= s14;
						end if;
						
					when s14=>		
						countContr <= "1110";
						if (countFluxo = countContr and referencia /= ProdutoParcial) then
							referencia <= ProdutoParcial;
							NS <= s15;
						end if;
						
					when s15=>						 --ultima iteracao
						countContr <= "1111";
						if (countFluxo = countContr and referencia /= ProdutoParcial) then
							referencia <= ProdutoParcial;
							NS <= s16;
						end if;
						
					when s16=>	 					 --final das iteracoes, o valor final do produto foi alcancado ao
						fim <= '1';					 --desconsiderar o bit menos significativo de ProdutoParcial
						Produto <= ProdutoParcial(32 downto 1);
						
						
				
				end case;		
		end process;
		
		
		
		countControle <= countContr;
		fin <= fim;
			
			
	end controle;