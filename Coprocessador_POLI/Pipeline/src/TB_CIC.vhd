library ieee;
use ieee.std_logic_1164.all;

entity TB_CIC is
end TB_CIC;
-- importa os types do projeto
library pipeline;
use pipeline.types.all;

architecture TB_CIC_arch of TB_CIC is

	component CacheI_Controle is
	  port(
        clk:    in std_logic;
        enable: in std_logic;
		pc:     in word_type;

		-- I/O relacionados ao stage IF
        stall: out std_logic := '0';
		
		-- I/O relacionados ao cache
		hit_signal:      in  std_logic;
		write_options:   out std_logic := '0';
		update_info:     out std_logic := '0';

		
        -- I/O relacionados a Memória princial
		mem_ready:      in  std_logic;
		mem_rw:         out std_logic := '0';  --- '1' write e '0' read
        mem_enable:     out std_logic := '0'
	  );
	end component;
	
	-- sinais --
	signal clk : std_logic;
	signal enable : std_logic;
	signal pc : word_type;
	signal stall: std_logic;
	signal hit_signal: std_logic;
	signal write_options: std_logic;
	signal update_info: std_logic;
	signal mem_ready: std_logic;
	signal mem_rw: std_logic;
	signal mem_enable: std_logic;

begin  
	dut : CacheI_Controle
	port map(
		clk => clk,
		enable => enable,
		pc => pc,
		stall => stall,
		hit_signal => hit_signal,
		write_options => write_options,
		update_info => update_info,
		mem_ready => mem_ready,
		mem_rw => mem_rw,
		mem_enable => mem_enable);
	
	simulation : process
	begin	
		-- INIT 
		clk <= '0';
		hit_signal <= '1';
		mem_ready <= '1';
		pc <= "11000000000000000111111111001100";
		wait for 5 ns;
		
		clk <= '0';
		hit_signal <= '0';
		mem_ready <= '0';
		pc <= "11000000000000000111111111001100";
		wait for 5 ns;
			
		-- Ready --
		clk <= '1';
		hit_signal <= '1';
		mem_ready <= '1';
		pc <= "11000000000000000111111111001100";
		wait for 5 ns;
		
		clk <= '0';
		hit_signal <= '1';
		mem_ready <= '1';
		pc <= "11000000000000000111111111001100";
		wait for 5 ns;
		
		-- Ready --
		clk <= '1';
		hit_signal <= '1';
		mem_ready <= '1';
		pc <= "11000000000000000111111111001100";
		wait for 5 ns;
		
		clk <= '0';
		hit_signal <= '1';
		mem_ready <= '1';
		pc <= "11000000000000000111111111001100";
		wait for 5 ns;
		
		-- Ready --
		clk <= '1';
		hit_signal <= '1';
		mem_ready <= '1';
		pc <= "11000000000000000111111101001100";
		wait for 5 ns;
		
		clk <= '0';
		hit_signal <= '0';
		mem_ready <= '1';
		pc <= "11000000000000000111111101001100";
		wait for 5 ns;
		
		-- CTAG ---
		clk <= '1';
		hit_signal <= '0';
		mem_ready <= '1';
		pc <= "11000000000000000111111101001100";
		wait for 5 ns;
		
		clk <= '0';
		hit_signal <= '0';
		mem_ready <= '1';
		pc <= "11000000000000000111111101001100";
		wait for 5 ns;
		
		-- MISS -- 
		clk <= '1';
		hit_signal <= '0';
		mem_ready <= '0';
		pc <= "11000000000000000111111101001100";
		wait for 5 ns;
		
		clk <= '0';
		hit_signal <= '0';
		mem_ready <= '1';
		pc <= "11000000000000000111111101001100";
		wait for 5 ns;
		
		-- MISS -- 
		clk <= '1';
		hit_signal <= '0';
		mem_ready <= '1';
		pc <= "11000000000000000111111101001100";
		wait for 5 ns;
		
		clk <= '0';
		hit_signal <= '0';
		mem_ready <= '1';
		pc <= "11000000000000000111111101001100";
		wait for 5 ns;
		
		-- MEM --
		wait for 5 ns;
		--pc <= "11000000000000000111111111001100";
		
		-- --- 
		wait for 5 ns;
		
		wait;
	end process;
end	TB_CIC_arch;