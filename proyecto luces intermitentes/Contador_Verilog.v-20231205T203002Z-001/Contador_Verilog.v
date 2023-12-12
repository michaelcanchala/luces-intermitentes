`timescale 1ns /100ps 
module Contador_Verilog(
    output reg LED1,
    output reg LED2,
    input Reloj
    );
//Declaramos variables
integer C1 =0;
integer CB=0;
reg senal_1HZ = 0;
reg senal_Blink = 0;
reg Flag_1HZ = 0;
//Detectamos flanco de subida del Reloj y sumamos 1 al contador
always @(posedge Reloj)
begin
C1 <= C1+1;
//Refrescamos el C1 cada seg, modificamos el estado de la senal_1HZ (LED1)
//activamos el blink mediante Flag_1HZ
if (C1 == 49_999_999) 
begin
senal_1HZ<= ~senal_1HZ;
C1 <= 0;
Flag_1HZ<=1;
end
//Contador para activar el blink (LED2)
if (Flag_1HZ==1)
begin 
CB <= CB+1;
senal_Blink <= 1;
end
//Efecto Blink que dura 200ms y reinicio de contador
if (CB==9_999_999)
begin
senal_Blink <= 0;
CB <= 0;
Flag_1HZ<=0;
end
//Obtenemos la salida para los leds
LED1 <= senal_1HZ;
LED2 <= senal_Blink;
end
endmodule
