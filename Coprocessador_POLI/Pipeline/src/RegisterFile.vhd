-------------------------------------------------------------------------------
--
-- Title       : No Title
-- Design      : Biblioteca_de_Componentes
-- Author      : Wilson Ruggiero
-- Company     : LARC-EPUSP
--
-------------------------------------------------------------------------------
--
-- File        : C:\My_Designs\Biblioteca_de_ComponentesV4.5\compile\DualRegFile.vhd
-- Generated   : Thu Feb  1 16:01:23 2018
-- From        : C:\My_Designs\Biblioteca_de_ComponentesV4.5\src\DualRegFile.bde
-- By          : Bde2Vhdl ver. 2.6
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------
-- Design unit header --
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity RegisterFile is
  generic(
       NBend : integer := 5;
       NBdado : integer := 32;
       Tread : time := 5 ns;
       Twrite : time := 5 ns
  );
  port(
       clk, reset : in std_logic;
       we : in std_logic;
       dadoina : in std_logic_vector(NBdado - 1 downto 0);
	   endwrite : in std_logic_vector(NBend - 1 downto 0);
       enda : in std_logic_vector(NBend - 1 downto 0);
       endb : in std_logic_vector(NBend - 1 downto 0);
       dadoouta : out std_logic_vector(NBdado - 1 downto 0);
       dadooutb : out std_logic_vector(NBdado - 1 downto 0)
  );
end RegisterFile;

architecture RegisterFile of RegisterFile is

---- Architecture declarations -----
type ram_type is array (0 to 2**NBend - 1)
        of std_logic_vector (NBdado - 1 downto 0);
signal ram: ram_type:= (others=>(others=>'0'));



---- Signal declarations used on the diagram ----

signal enda_reg : std_logic_vector(NBend - 1 downto 0);
signal endb_reg : std_logic_vector(NBend - 1 downto 0);

begin

---- Processes ----

RegisterMemory :
process (clk)
-- Section above this comment may be overwritten according to
-- "Update sensitivity list automatically" option status
-- declarations
begin
	if (reset = '1') then
		for i in ram'range loop
  			ram(i) <= "00000000000000000000000000000000";
		end loop; 
		 ram(28) <= "00000000000000000000000000100000";
		 ram(29) <= "00000000000000001111111111111111";
		 ram(30) <= "00000000000001111111111111111111";
		 ram(31) <= "00000000000000000000000000000000";
	 elsif (clk'event and clk = '1' and reset = '0') then
        if (we = '1') then
           ram(to_integer(unsigned(endwrite))) <= dadoina after Twrite;
        end if;
        enda_reg <= enda;
        endb_reg <= endb;
     end if;
end process;

---- User Signal Assignments ----
dadoouta <= ram(to_integer(unsigned
								(enda_reg))) after Tread;
dadooutb <= ram(to_integer(unsigned
								(endb_reg))) after Tread;

								
								
end RegisterFile;
