library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

library biblioteca_de_componentes;

entity Buffer_ID_EX is
  port(
       clk, hold : in std_logic;
       PCin : in std_logic_vector(31 downto 0);
	   regData1in, regData2in, endDesvioIn : in std_logic_vector(31 downto 0);
	   rtIn, rdIn : in std_logic_vector(4 downto 0);
	   
	   
	   PCout : out std_logic_vector(31 downto 0);
	   regData1out, regData2out, endDesvioOut : out std_logic_vector(31 downto 0);
	   rtOut, rdOut : out std_logic_vector(4 downto 0);
	   
	   -- sinais de controle --
	   ULAcIn : in std_logic_vector(3 downto 0);
	   mux1cIn, mux2cIn : in std_logic;
	   
	   ULAcOut : out std_logic_vector(3 downto 0);
	   mux1cOut, mux2cOut : out std_logic;
	   
	   -- controle dos estagios seguintes --
	   muxMEMcIn, muxWBcIn : in std_logic;
	   muxMEMcOut, muxWBcOut : out std_logic
	   
  );
end Buffer_ID_EX;

architecture Buffer_ID_EX of Buffer_ID_EX is

signal PC, regData1, regData2, endDesvio: std_logic_vector(31 downto 0);
signal rt, rd : std_logic_vector(4 downto 0);
signal ULAc : std_logic_vector(3 downto 0);
signal mux1c, mux2c, muxMEMc, muxWBc : std_logic;

begin

IF_ID :
process (clk)
begin
	if (clk'event and clk='1' and hold='0') then  -- Clock na borda de subida
		PC <= PCin;
		regData1 <= regData1in;
		regData2 <= regData2in;
		endDesvio <= endDesvioIn;
		rt <= rtIn;
		rd <= rdIn;
		
		ULAc <= ULAcIn;
		mux1c <= mux1cIn;
		mux2c <= mux2cIn;
		
		muxMEMc <= muxMEMcIn;
		muxWBc <= muxWBcIn;
	end if;
end process;

PCout <= PC when hold = '0' else "00000000000000000000000000000000";
regData1out <= regData1 when hold = '0' else "00000000000000000000000000000000";
regData2out <= regData2 when hold = '0' else "00000000000000000000000000000000";
endDesvioOut <= endDesvio when hold = '0' else "00000000000000000000000000000000";
rtOut <= rt when hold = '0' else "00000";
rdOut <= rd when hold = '0' else "00000";

ULAcOut <= ULAc;
mux1cOut <= mux1c;
mux2cOut <= mux2c;

muxMEMcOut <= muxMEMc;
muxWBcOut <= muxWBc;

end Buffer_ID_EX;