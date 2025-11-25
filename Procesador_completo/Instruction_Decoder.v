// Instruction_Decoder
// Universidad del Valle de Guatemala
// Curso: Arquitectura de Computadores
// Autor: Samuel Tortola - 22094, Alan Gomez - 22115
// Fecha: 1/11/2025

//El Instruction Decoder es el módulo encargado de interpretar las instrucciones obtenidas de la memoria de instrucciones (IMEM).
//Este módulo descompone la instrucción en sus campos constituyentes, como el opcode

module Instruction_Decoder(
    input  [31:0] instruction, // Instrucción de 32 bits
    output [5:0]  opcode,      // Código de operación
    output [4:0]  rs,          // Registro fuente 1
    output [4:0]  rt,          // Registro fuente 2 / destino
    output [4:0]  rd,          // Registro destino
    output [4:0]  shamt,       // Cantidad de desplazamiento
    output [5:0]  funct,       // Función (para instrucciones R-type)
    output [15:0] immediate,   // Valor inmediato (para instrucciones I-type)
    output [25:0] jump_target  // Índice de instrucción (para instrucciones J-type)
);

    // Descomposición de la instrucción en sus campos
    assign opcode      = instruction[31:26];
    assign rs          = instruction[25:21];
    assign rt          = instruction[20:16];
    assign rd          = instruction[15:11];
    assign shamt       = instruction[10:6];
    assign funct       = instruction[5:0];

    assign immediate   = instruction[15:0];

    assign jump_target = instruction[25:0];

    endmodule