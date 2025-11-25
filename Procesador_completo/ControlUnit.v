// Control Unit
// Universidad del Valle de Guatemala
// Curso: Arquitectura de Computadores
// Autor: Samuel Tortola - 22094, Alan Gomez - 22115
// Fecha: 27/10/2025


// La unidad de control (Control Unit) es responsable de dirigir el flujo de datos dentro del procesador y coordinar las operaciones de los diferentes componentes. 
//Interpreta las instrucciones del programa y genera las señales de control necesarias para ejecutar cada instrucción correctamente.

module ControlUnit (
    input [5:0] opcode,        // Código de operación de la instrucción
    output reg RegDst,        // Señal para seleccionar el destino del registro
    output reg ALUSrc,        // Señal para seleccionar la fuente  de la ALU
    output reg RegWrite,      // Señal para habilitar la escritura en el registro
    output reg Jump,         // Señal para instrucciones de salto
    output reg [1:0] ALUOp         // Señal para seleccionar la operación de la ALU
);

    always @(*) begin
        // Inicializar todas las señales de control a 0
        RegDst = 0;
        ALUSrc = 0;
        RegWrite = 0;
        Jump = 0;
        ALUOp = 2'b00;

        case (opcode)
            6'b000000: begin   // Tipo R
                RegDst = 1;
                ALUSrc = 0;
                RegWrite = 1;
                ALUOp = 2'b10;
            end

            6'b001010: begin   // Tipo I, MOVI
                RegDst = 0;
                ALUSrc = 1;
                RegWrite = 1;
                ALUOp = 2'b00;
            end

            6'b001000: begin   // Tipo I, ADDI
                RegDst = 0;
                ALUSrc = 1;
                RegWrite = 1;
                ALUOp = 2'b01;
            end

            6'b001001: begin   // Tipo I, SUBI
                RegDst = 0;
                ALUSrc = 1;
                RegWrite = 1;
                ALUOp = 2'b11;
            end

            6'b000010: begin   // Tipo J
                RegDst = 0;
                ALUSrc = 0;
                RegWrite = 0;
                ALUOp = 2'b00;
                Jump = 1;
            end


            
            default: begin
                // Señales de control por defecto (todas en 0)
                RegDst = 0;
                ALUSrc = 0;
                RegWrite = 0;
                ALUOp = 2'b00;
                
            end
        endcase
    end

endmodule