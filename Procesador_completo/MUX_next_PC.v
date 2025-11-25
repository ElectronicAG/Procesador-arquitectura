// MUX de next PC
// Universidad del Valle de Guatemala
// Curso: Arquitectura de Computadores
// Autor: Samuel Tortola - 22094, Alan Gomez - 22115
// Fecha: 1/11/2025

//El MUX de next PC selecciona la dirección siguiente del Program Counter (PC) entre dos opciones: la dirección secuencial (PC + 4) y una dirección de salto proporcionada.
//La selección se basa en una señal de control de salto (Jump). Si Jump está activa

module MUX_next_PC(
    input wire [31:0] pc_plus_4,    // Dirección PC + 4
    input wire [31:0] jump_address,  // Dirección de salto
    input wire       Jump,           // Señal de control para salto
    output wire [31:0] next_pc       // Dirección siguiente del PC
);

    assign next_pc = (Jump) ? jump_address : pc_plus_4;

endmodule
