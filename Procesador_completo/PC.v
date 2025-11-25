// Program Counter (PC) Module
// Universidad del Valle de Guatemala
// Curso: Arquitectura de Computadores
// Autor: Samuel Tortola - 22094, Alan Gomez - 22115
// Fecha: 13/10/2025

//El Program Counter (PC) es un registro especial en la CPU que almacena la dirección de la siguiente instrucción que debe ejecutarse.
//En cada ciclo de reloj, el PC se actualiza para apuntar a la siguiente instrucción en memoria, permitiendo que el procesador siga la secuencia del programa.
//Cuando ocurre un salto, llamada o interrupción, el PC se actualiza con la nueva dirección correspondiente.

module PC(
    input clk,
    input reset,
    input  wire [31:0] next_pc,  //Dirección siguiente
    output reg  [31:0] current_pc //Dirección actual
);

    

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_pc <= 32'b0; // Reiniciar PC a 0 en reset
        end 
        
        else begin
             current_pc <= next_pc; // Actualizar PC con next_pc en flanco positivo de clk
        end
    end

endmodule


