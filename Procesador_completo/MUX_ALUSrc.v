// MUX de ALUSrc
// Universidad del Valle de Guatemala
// Curso: Arquitectura de Computadores
// Autor: Samuel Tortola - 22094, Alan Gomez - 22115
// Fecha: 1/11/2025

// El MUX de ALUSrc selecciona entre dos fuentes de datos para la segunda entrada de la ALU:
// - El segundo registro leído del Banco de Registros (read_data2).
// - El valor inmediato extendido de la instrucción.
// La selección se basa en la señal de control ALUSrc generada por la Unidad de Control.


module MUX_ALUSrc (
    input  [31:0] read_data2,    // Datos del segundo registro leído
    input  [31:0] immediate,      // Valor inmediato extendido
    input  ALUSrc,         // Señal de control para seleccionar la fuente
    output [31:0] alu_src2    // Salida seleccionada para la ALU
);

    assign alu_src2 = (ALUSrc) ? immediate : read_data2;

endmodule

