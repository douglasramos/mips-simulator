library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALUControl is
  generic(
       NBend : integer := 4;
       NBdado : integer := 8;
       Tread : time := 5 ns;
       Twrite : time := 5 ns
  );
  port(																				
  		ALUOp      : in std_logic_vector(2 downto 0);
  		FunctField : in std_logic_vector(5 downto 0);
		ULASet     : out std_logic_vector(2 downto 0);
		MulBit     : out std_logic
  );
end ALUControl;

architecture ALUControl of ALUControl is

---- Architecture declarations -----
---- Signal declarations used on the diagram ----
signal vetorEntrada : std_logic_vector(8 downto 0);

signal FEnable : std_logic;

vetorEntrada(0) <= ALUOp(0);
vetorEntrada(1) <= ALUOp(1);
vetorEntrada(2) <= ALUOp(2);
vetorEntrada(3) <= FunctField(0);
vetorEntrada(4) <= FunctField(1);
vetorEntrada(5) <= FunctField(2);
vetorEntrada(6) <= FunctField(3);
vetorEntrada(7) <= FunctField(4);
vetorEntrada(8) <= FunctField(5);

begin

---- Processes ----

process (vetorEntrada)

begin
	if ALUOp = "010" then	
		case functField is
			when "100000" => ULASet <= "001";
							 MulBit <= '0';
			when "101010" => ULASet <= "110";
							 MulBit <= '0';
			when "001000" => ULASet <= "000";
							 MulBit <= '0';
			when "100001" => ULASet <= "001";
							 MulBit <= '0';
			when "000000" => ULASet <= "000";
							 MulBit <= '0';
			when "110001" => ULASet <= "000";
							 MulBit <= '1';
			when others   => ULASet <= "000";
							 MulBit <= '0';
		end case;
	else
		case ALUOp is
			when "000" => ULASet <= "000";
						  MulBit <= '0';
			when "001" => ULASet <= "001";
						  MulBit <= '0';
			when "011" => ULASet <= "110";
						  MulBit <= '0';
			when "100" => ULASet <= "001";
						  MulBit <= '0';
		end case;
	end if;
	 
end process;

---- User Signal Assignments ----


end ALUControl;
