module Etapa3_execute(
    input clk,
    input reset,
    input [31:0] alu_src2,
    input [3:0] alu_control,
    input [31:0] read_data1,

    output [31:0] alu_result,
    output  zero
);

// Instancia de la ALU
ALU alu_inst (  
    .src1(read_data1),
    .src2(alu_src2),
    .alu_control(alu_control),
    .result(alu_result),
    .zero(zero)
);


    endmodule

