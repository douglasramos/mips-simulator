-- PCS3412 - Organizacao e Arquitetura de Computadores I
-- PicoMIPS
-- Author: Douglas Ramos
--
-- Description:
--     Controle do Cache de Dados

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; 

-- importa os types do projeto
library pipeline;
use pipeline.types.all;


entity CacheD_Controle is
    generic (
        tempo_acesso: in time := 5 ns
    );
    port (
		clk_pipeline: in std_logic;
		clk:          in std_logic;
		enable:       in std_logic;
		cpu_addr:     in std_logic_vector(15 downto 0);

		-- I/O relacionados ao stage MEM
        cpu_write: in std_logic;
		stall: out std_logic := '0';
		
		-- I/O relacionados ao cache
		dirty_bit:       in std_logic;
		set_valid:       in std_logic_vector(1 downto 0);
		hit_signal:      in  std_logic;
		control_index:   out std_logic;
		write_buffer:    out std_logic;
		write_options:   out std_logic_vector(1 downto 0) := "00";
		update_info:     out std_logic := '0';
		
        -- I/O relacionados a Memoria princial
		mem_ready:      in  std_logic;
		mem_rw:         out std_logic := '0';  --- '1' write e '0' read
        mem_enable:     out std_logic := '0';

        -- I/O relacionados ao Write buffer
		wb_ready:      in  std_logic;
		wb_write:      out std_logic := '0'  --- '1' write e '0' not write
        
    );
end entity CacheD_Controle;

architecture CacheD_Controle_arch of CacheD_Controle is	 	  
							  
	-- Definicao de estados
    type states is (INIT, READY, CTAG, WRITE, WBWRITE, CTAG2, HIT, MISS, MEM, BUFF);
    signal state: states := INIT; 
	
begin 
	process (enable, clk, clk_pipeline, cpu_addr)									  
	begin
		if rising_edge(clk) or enable'event then -- talvez precise do rising_edge do clk pipeline
			case state is 
				
				--- estado inicial
				when INIT =>
					state <= READY;	
					
				--- estado Ready
				when READY =>
                    if cpu_addr'event then
                        state <= CTAG;
                    end if;
					
				--- estado Compare Tag
				when CTAG =>
					if cpu_write = '0' then	  -- Leitura
						if hit_signal = '1' then 
					   		state <= HIT;

						else -- Miss
							state <= MISS;								
                		end if;

					elsif cpu_write = '1' then -- Escrita
						if dirty_bit = '1' then
							state <= BUFF;	-- precisa colocar data atual no buffer primeiro
						elsif dirty_bit = '0' then
						 	state <= WRITE; -- pode ja escrever no cache
						end if;
                	end if;
				
				--- estado Write
				when WRITE =>
				   state <= READY;
				
				when BUFF =>
					if wb_ready = '1' then
						state <= WBWRITE;
					elsif wb_ready = '0' then
						state <= BUFF;
					end if;
				
				when WBWRITE =>
					state <= READY;
						
				--- estado Compare Tag2 
				--- (segunda comparacao apos MISS)
				when CTAG2 =>
					if hit_signal = '1' then 
					   state <= HIT;

					else -- Miss
						state <= MISS;
													
                    end if;	
					
				--- estado Hit
				when HIT =>
					state <= READY;
					
				--- estado Miss
				when MISS =>
					if mem_ready = '1' then
						state <= MEM;
                    end if;
					
				--- estado Memory Ready
				when MEM =>
					state <= CTAG2;			
					
				when others =>
					state <= INIT;
			end case;
		end if;
	end process;
	
	--- saidas ---
	
	-- mem_rw
	mem_rw <= '0'; -- sempre leitra
	
	-- stall -- trava pipeline
	stall <= '1' after tempo_acesso when state = MISS  or 
										 state = CTAG2 or
										 state = BUFF  else '0';  
	         
	-- write_options
	write_options <= "01" when state = MEM   else
        	         "10" when state = WRITE else 
		             "00";
	         		 
	-- update_info
	update_info <= '1' when state = MEM else '0';
	         	   				  
    -- mem_enable		
	mem_enable <= '1' when state = MISS else '0';
	
	-- write buffer
	wb_write <= '1' when state = WBWRITE else '0';

end architecture CacheD_Controle_arch;