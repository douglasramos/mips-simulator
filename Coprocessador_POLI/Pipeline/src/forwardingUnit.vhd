library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity forwardingUnit is
  generic(
       NBend : integer := 4;
       NBdado : integer := 8;
       Tread : time := 5 ns;
       Twrite : time := 5 ns
  );
  port(																				
  		ExMemWrite : in std_logic;
  		MemWbWrite : in std_logic;
		ExMemRd    : in std_logic_vector(31 downto 0);
		MemWbRd    : in std_logic_vector(31 downto 0);
		IdExRs     : in std_logic_vector(31 downto 0);
		IdExRt     : in std_logic_vector(31 downto 0);
		ForwardA   : out std_logic_vector(1 downto 0);
		ForwardB   : out std_logic_vector(1 downto 0)
  );
end forwardingUnit;

architecture forwardingUnit of forwardingUnit is

---- Architecture declarations -----
---- Signal declarations used on the diagram ----
	
begin		   
	
	process(ExMemWrite,MemWbWrite,ExMemRd,MemWbRd,IdExRs,IdExRt)
		if ExMemWrite and (ExMemRd /= "00000000000000000000000000000000") and (ExMemRd = IdExRs) then
			ForwardA = "10";
		elsif ExMemWrite and (ExMemRd /= "00000000000000000000000000000000") and (ExMemRd = IdExRt) then
			ForwardB = "10";
		elsif MemWbWrite and (MemWbRd /= "00000000000000000000000000000000") and (ExMemRd /= IdExRs) and (MemWbRd = IdExRs) then
			ForwardA = "10";
		elsif MemWbWrite and (MemWbRd /= "00000000000000000000000000000000") and (ExMemRd /= IdExRs) and (MemWbRd = IdExRt) then
			ForwardB = "10";
	   	end if;	
	end process;
	


---- User Signal Assignments ----


end forwardingUnit;
