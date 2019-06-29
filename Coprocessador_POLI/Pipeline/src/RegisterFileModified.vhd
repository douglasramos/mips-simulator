-------------------------------------------------------------------------------
--
-- Title       : No Title
-- Design      : Biblioteca_de_Componentes
-- Author      : Wilson Ruggiero
-- Company     : LARC-EPUSP
--
-------------------------------------------------------------------------------
--
-- File        : c:\Aldec\Active-HDL-Student-Edition\vlib\Biblioteca_de_ComponentesV4.5\compile\RegFile.vhd
-- Generated   : Wed Feb 28 10:02:04 2018
-- From        : c:\Aldec\Active-HDL-Student-Edition\vlib\Biblioteca_de_ComponentesV4.5\src\RegFile.bde
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

entity RegFile is
  generic(
       NBend : integer := 5;
       NBdado : integer := 32;
       Tread : time := 5 ns;
       Twrite : time := 5 ns
  );
  port(
       clk : in std_logic;
       wenable : in std_logic;
       writeData : in std_logic_vector(NBdado - 1 downto 0);
       enda : in std_logic_vector(NBend - 1 downto 0);
       dadoout1 : out std_logic_vector(NBdado - 1 downto 0); 
	   dadoout2 : out std_logic_vector(NBdado - 1 downto 0);
	   reg1 : in std_logic_vector(NBend - 1 downto 0);
	   reg2 : in std_logic_vector(NBend - 1 downto 0);
  );
end RegFile;

architecture RegFile of RegFile is

---- Architecture declarations -----
type ram_type is array (0 to 2**NBend - 1)
        of std_logic_vector (NBdado - 1 downto 0);
signal ram: ram_type;



---- Signal declarations used on the diagram ----

signal end1_reg : std_logic_vector(NBend - 1 downto 0);
signal end2_reg : std_logic_vector(NBend - 1 downto 0);

begin

---- Processes ----

RegisterMemory :
process (clk)
-- Section above this comment may be overwritten according to
-- "Update sensitivity list automatically" option status
-- declarations
begin
	 if (clk'event and clk = '1') then
        if (wenable = '1') then
           ram(to_integer(unsigned(enda))) <= writeData after Twrite;
        end if;
     end if;   
	 
	 end1_reg <= reg1;
	 end2_reg <= reg2;
end process RegisterMemory;

---- User Signal Assignments ----
dadoout1 <= ram(to_integer(unsigned(end1_reg))) after Tread;
dadoout2 <= ram(to_integer(unsigned(end2_reg))) after Tread;


end RegFile;
