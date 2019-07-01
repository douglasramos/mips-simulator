library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

library biblioteca_de_componentes;

entity Buffer_IF_ID is
  port(
       clk, hold : in std_logic;
       PCin, instructIn : in std_logic_vector(31 downto 0);
	   PCout, instructOut : out std_logic_vector(31 downto 0)
	   
  );
end Buffer_IF_ID;

architecture Buffer_IF_ID of Buffer_IF_ID is

signal PC, instruct: std_logic_vector(31 downto 0);

begin

IF_ID :
process (clk)
begin
	if (clk'event and clk='1' and hold='0') then  -- Clock na borda de subida
		PC <= PCin;
		instruct <= instruct;
	end if;
end process;

PCout <= PC when hold = '0' else "00000000000000000000000000000000";
instructOut <= instruct when hold = '0' else "00000000000000000000000000000000";


end Buffer_IF_ID;