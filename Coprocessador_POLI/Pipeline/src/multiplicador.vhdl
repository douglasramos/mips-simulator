library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity ex is
port(Multiplicando, Multiplicador: in std_logic_vector(15 downto 0);
Resultado:out std_logic_vector(31 downto 0));
end ex;

architecture ex of ex is 

begin

process(Multiplicando, Multiplicador)
variable A: std_logic_vector(32 downto 0);
variable S,P: std_logic_vector(15 downto 0);
variable contador: integer;

begin
A := "000000000000000000000000000000000";
S := Multiplicador;
A(16 downto 1) := Multiplicando;

for contador in 0 to 15 loop
if(A(1) = '1' and A(0) = '0') then
P := (A(32 downto 17));
A(32 downto 17) := (P - S);

elsif(A(1) = '0' and A(0) = '1') then
P := (A(32 downto 17));
A(32 downto 17) := (P + S);

end if;

A(31 downto 0) := A(32 downto 1);

end loop;

Resultado(31 downto 0) <= A(32 downto 1);

end process;

end ex;