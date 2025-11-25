module Etapa2_decode(
    input clk,
    input reset,  
    input [31:0] instruction,
    output Jump

);

// Señales internas
wire [5:0] opcode;
wire [4:0] rs;
wire [4:0] rt;
wire [4:0] rd;
wire [4:0] shamt;
wire [5:0] funct;
wire [15:0] immediate;
wire [25:0] jump_target;
wire RegDst;
wire ALUSrc;
wire RegWrite;
wire [1:0] ALUOp;
wire [4:0] write_reg;
wire [31:0] read_data1;
wire [31:0] read_data2;
wire [31:0] alu_src2;
wire [3:0] alu_control;
wire [31:0] alu_result;
wire zero;


// Instancia del Instruction Decoder
Instruction_Decoder instr_decoder_inst (
    .instruction(instruction),
    .opcode(opcode),
    .rs(rs),
    .rt(rt),
    .rd(rd),
    .shamt(shamt),
    .funct(funct),
    .immediate(immediate),
    .jump_target(jump_target)
);

// Instancia del Control Unit
ControlUnit control_unit_inst (
    .opcode(opcode),
    .RegDst(RegDst),
    .ALUSrc(ALUSrc),
    .RegWrite(RegWrite),
    .Jump(Jump),
    .ALUOp(ALUOp)
);

// Intancia de MUX_reg_dst 

MUX_RegDst mux_RegDst_inst (
    .rt(rt),
    .rd(rd),
    .RegDst(RegDst),
    .write_reg(write_reg)
);

// Instancia del Banco de Registros
RegisterFile register_file_inst (
    .clk(clk),
    .reset(reset),
    .RegWrite(RegWrite),
    .read_reg1(rs),
    .read_reg2(rt),
    .write_reg(write_reg),
    .write_data(alu_result), // Datos de escritura, que vendrían de la etapa de ejecución
    .read_data1(read_data1), // Datos leídos del registro rs
    .read_data2(read_data2)  // Datos leídos del registro rt
);

// Instancia del MUX de ALUSrc
MUX_ALUSrc mux_ALUSrc_inst (
    .read_data2(read_data2),    // Datos del segundo registro leído
    .immediate({{16{immediate[15]}}, immediate}),     // Valor inmediato extendido a 32 bits, esto se hace asi: se extiende el bit 15 (signo) a los 16 bits altos
                //se hace la concatenacion: {16 bits de signo, 16 bits de immediate} 
                // 16{immediate[15]}}, immediate es explicitamente: el bit 15 repetido 16 veces
    .ALUSrc(ALUSrc),
    .alu_src2(alu_src2)    // Salida seleccionada para la ALU
);

// Instancia de la ALU Control Unit
ALUControl alu_control_inst (
    .ALUOp(ALUOp),
    .funct(funct),
    .alu_control(alu_control) // Señal de control para la ALU
);


// Instancia etapa 3: execute
Etapa3_execute execute_stage (
    .clk(clk),
    .reset(reset),
    .alu_src2(alu_src2), // Conectar la salida del MUX ALUSrc
    .alu_control(alu_control), // Conectar la salida de la ALU Control Unit
    .read_data1(read_data1), // Datos del primer registro leído

    .alu_result(alu_result), // Resultado de la ALU
    .zero(zero)        // Señal zero de la ALU
);



endmodule

