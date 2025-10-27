// ALU
// Universidad del Valle de Guatemala
// Curso: Arquitectura de Computadores
// Autor: Samuel Tortola - 22094, Alan Gomez - 22115
// Fecha: 27/10/2025

//El ALU (Unidad Aritmético Lógica) es un componente fundamental del procesador que realiza operaciones aritméticas 
//y lógicas sobre los datos.

module ALU (
    input [31:0] src1,  // Primer operando
    input [31:0] src2,    // Segundo operando
    input [3:0] alu_control,  // Señal de control para seleccionar la operación de la ALU
    output reg [31:0] result, // Resultado de la operación
    output reg zero    // Señal que indica si el resultado es cero
);

    always @(*) begin
        case (alu_control)
            4'b0010: result = src1 + src2; // suma
            4'b0110: result = src1 - src2; // resta
            4'b1000: result = src1 * src2; // Multiplicación
            4'b1001: result = src1 / src2; // división
            default: result = 32'b0; // Operación por defecto
        endcase

        // Establecer la señal zero si el resultado es cero
        if (result == 32'b0)
            zero = 1;
        else
            zero = 0;


    end



    endmodule
