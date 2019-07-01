library ieee;
use ieee.std_logic_1164.all;

entity TB_IC is
end TB_IC;
-- importa os types do projeto
library pipeline;
use pipeline.types.all;

architecture TB_IC_arch of TB_IC is

	component Cache_I is
	  port(
			-- I/O relacionados ao controle
			write_options:   in std_logic;
			update_valid:    in std_logic;
			update_tag:      in std_logic; 
			hit:             out std_logic := '0';
		
			-- I/O relacionados ao IF stage
        	cpu_adrr: in  word_type;
        	data_out:     out word_type;	

        	-- I/O relacionados a Memória princial
        	mem_bloco_data: in  word_vector_type(15 downto 0);
			mem_addr:       out word_type := (others => '0');
			valid: out std_logic
	  );
	end component;
	
	-- sinais --
	signal write_options : std_logic;
	signal update_valid : std_logic;
	signal update_tag : std_logic;
	signal hit: std_logic;
	signal cpu_adrr: word_type;
	signal data_out: word_type;
	signal mem_bloco_data: word_vector_type(15 downto 0);
	signal mem_addr: word_type;
	signal valid: std_logic;

begin  
	dut : Cache_I
	port map(
		write_options => write_options,
		update_valid => update_valid,
		update_tag => update_tag,
		hit => hit,
		cpu_adrr => cpu_adrr,
		data_out => data_out,
		mem_bloco_data => mem_bloco_data,
		mem_addr => mem_addr,
		valid => valid);
	
	simulation : process
	begin
		-- Primeira opera??o --
		-- Desviar para o endere?o 4 atrav?s de uma opera??o de jump
		
		write_options <= '0';
		update_valid <= '0';
		update_tag <= '0';
		mem_bloco_data <= (3 => word_vector_test2, others => word_vector_test);
		cpu_adrr <= "11000000000000000111111111001100";

		wait for 5 ns;
			
		--- rolou altos miss e ainda caiu no estado MEM
		write_options <= '1';
		update_tag <= '1';
		update_valid <= '1';
		
		-- Ready --
		wait for 5 ns;
		write_options <= '0';
		update_tag <= '0';
		update_valid <= '0';
		mem_bloco_data <= (others => word_vector_test);
		cpu_adrr <= "11000000000000000111111101001100";
		
		-- MEM 
		wait for 5 ns;
		
		write_options <= '1';
		update_tag <= '1';
		update_valid <= '1';
		
		-- Ready --
		wait for 5 ns;
		write_options <= '0';
		update_tag <= '0';
		update_valid <= '0';
		mem_bloco_data <= (others => word_vector_test);
		cpu_adrr <= "11000000000000000111111111001100";
		
		-- MEM 
		wait for 5 ns;
		
--		write_options <= '1';
--		update_tag <= '1';
--		update_valid <= '1';	
		
		
		wait;
	end process;
end	TB_IC_arch;