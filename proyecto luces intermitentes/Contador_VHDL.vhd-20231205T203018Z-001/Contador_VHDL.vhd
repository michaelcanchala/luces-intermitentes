
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--Declaramos entradas y salidas
entity Contador_VHDL is
    Port ( Reloj : in  STD_LOGIC;
           LED1 : out  STD_LOGIC;
           LED2 : out  STD_LOGIC);
end Contador_VHDL;

architecture Behavioral of Contador_VHDL is
--Declaramos variables internas
signal C1: INTEGER range 0 to 50_000_000;
signal CB: INTEGER range 0 to 10_000_000;
signal senal_1HZ: std_logic:= '0';
signal Flag_1HZ: std_logic:= '0';
signal senal_Blink: std_logic:= '0';
begin

Process (Reloj,senal_Blink,senal_1HZ)
begin
if (Reloj'event and Reloj='1') then
C1 <= C1+1;
--Refrescamos el C1 cada seg, modificamos el estado de la senal_1HZ (LED1)
--activamos el blink mediante Flag_1HZ
if (C1 = 49_999_999) then
senal_1HZ<= not senal_1HZ;
C1 <= 0;
Flag_1HZ <= '1'; 
end if;
--Contador para activar el blink (LED2)
if (Flag_1HZ = '1') then 
CB <= CB+1;
senal_Blink <= '1';
end if;
--Efecto Blink que dura 200ms y reinicio de contador
if (CB = 9_999_999) then
senal_Blink <= '0';
CB <= 0;
Flag_1HZ<='0';
end if;
 
end if;
--Obtenemos la salida para los leds
LED1 <= senal_1HZ;
LED2 <= senal_Blink;
end Process;
end Behavioral;

