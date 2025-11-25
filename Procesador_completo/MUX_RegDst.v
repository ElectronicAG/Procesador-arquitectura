// MUX de RegDst
// Universidad del Valle de Guatemala
// Curso: Arquitectura de Computadores
// Autor: Samuel Tortola - 22094, Alan Gomez - 22115
// Fecha: 1/11/2025

//El MUX de RegDst selecciona entre dos posibles destinos de registro para la operación de escritura en el Banco de Registros (Register File).
//La selección se basa en la señal de control RegDst generada por la Unidad de Control


module MUX_RegDst(
    input  [4:0] rt,          // Registro fuente 2 / destino, que se usa en instrucciones I-type y R-type
    input  [4:0] rd,          // Registro destino, se usa en instrucciones R-type
    input  RegDst,      // Señal de control para seleccionar el destino del registro
    output [4:0] write_reg    // Registro seleccionado para la operación de escritura
);

    assign write_reg = (RegDst) ? rd : rt; // Si RegDst es 1, selecciona rd; si es 0, selecciona rt
       //por ejemplo si es una instruccion R-type RegDst es 1 y se selecciona rd, se almacena el resultado de la ALU en rd


endmodule