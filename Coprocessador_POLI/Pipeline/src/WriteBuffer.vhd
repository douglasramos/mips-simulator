-- PCS3412 - Organizacao e Arquitetura de Computadores I
-- PicoMIPS
-- File: WriteBuffer.vhd
-- Author: Douglas Ramos
--
-- Description:
--     Write Buffer para escrita Data Cache to Memory

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; 

-- importa os types do projeto
library pipeline;
use pipeline.types.all;


entity WriteBuffer is
    port (
		write:          in  std_logic;
		mem_ready:      in  std_logic;
		data_block_in:  in  word_vector_type(15 downto 0);
		data_block_out: out word_vector_type(15 downto 0);
		ready:          out std_logic := '1'	   
    );
end entity WriteBuffer;

architecture WriteBuffer_arch of WriteBuffer is	 	  
							 
    constant empty_buffer: word_vector_type(15 downto 0) := (others => word_vector_init);

	signal data_buffer: word_vector_type(15 downto 0) := (others => word_vector_init); 	
	
begin 
	

	-- Saída sempre está conectada ao buffer interno
	data_block_out <= data_buffer;
	
	-- atualizacao do cache de acordo com os sinais de controle
	process(mem_ready, write)
	begin
		if (write'event) then
			
			-- Se data_buffer esta vazio e cache solicita um write
			if ((data_buffer = empty_buffer) and write = '1') then
				data_buffer <= data_block_in;
				ready <= '0';
				
			-- Se data buffer ja esta ocupado e cache solicita um write	[talvez esse cara seja redundante]
			elsif (((data_buffer /= empty_buffer) and write = '1')) then
				ready <= '0';
			end if;
			
		end if;
		
		if (mem_ready'event) then
			
			-- Se data buffer nao eh vazio e memoria completou operacao
			if ((data_buffer /= empty_buffer) and mem_ready = '1') then
				data_buffer <= empty_buffer;
				ready <= '1';
			end if;
			
		end if;
	end process;

end architecture WriteBuffer_arch;