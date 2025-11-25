module Etapa1_Fetch(
    input clk,
    input reset,
    output [31:0] instruction
);

 
    // Señales internas
    wire [31:0] next_pc; // Dirección siguiente del PC
    wire [31:0] current_pc; // Dirección actual del PC
    wire Jump; // Señal de salto desde la etapa de decodificación

   // Instancia del PC
    PC pc_inst (
        .clk(clk),
        .reset(reset),
        .next_pc(next_pc),
        .current_pc(current_pc)
    );

    //Instancia del MUX de next PC
    MUX_next_PC mux_next_pc_inst (
        .pc_plus_4(current_pc + 32'd4), //se usa d para decimal
        // Construir la dirección de salto al estilo MIPS: {PC[31:28], instr_index, 2'b00}
        .jump_address({current_pc[31:28], instruction[25:0], 2'b00}), //Añede dos ceros al final, En MIPS la instrucción J sólo trae 26 bits de destino. Para formar la dirección completa de 32 bits, 
                        //se concatenan los 4 bits más significativos del PC actual con los 26 bits de la instrucción y se añaden 2 bits de ceros al final para alinear a palabra.
                            //Se usan los 4 bits más significativos del PC actual para mantener la coherencia en la dirección de salto dentro del mismo segmento de memoria.
                                //Esto porque por ejemplo: si el PC actual es 0x00400000 y la instrucción de salto tiene un valor de 0x0000000A, la dirección de salto completa será 0x00400028.
        .next_pc(next_pc),
        .Jump(Jump)
    );

    // Instancia de IMEM
    IMEM imem_inst (
        .addr(current_pc),
        .instruction(instruction)
    );

    // Intancia de etapa 2: decode
    Etapa2_decode decode_stage (
        .clk(clk),
        .reset(reset),
        .instruction(instruction),
        .Jump(Jump)
    );

endmodule


