//Alan Gomez

// Ejercicio 3: Integración PC + IMEM
// Conecta tu módulo PC con IMEM de manera que:

// current_pc del PC se use como addr de IMEM.

// Cada ciclo se lea la instrucción correspondiente.

// Crea un testbench que:

// Avance el PC automáticamente (next_pc = current_pc + 1 o +4 según convenga).

// Muestre la instrucción completa y los campos en cada ciclo.

// Ejemplo de salida esperada:

// PC=0, Instr=000000_00001_00010_00011_00000_100000
// opcode=000000 rs=00001 rt=00010 rd=00011 shamt=00000 funct=100000
// PC=1, Instr=001000_01000_01001_0000000000001010 opcode=001000 rs=01000 rt=01001 immediate=0000000000001010

// iverilog -o PC_IMEN.out PC_IMEN.v Program_counter.v IMEN.v 
// vvp PC_IMEN.out
// gtkwave tb_pc_imen.vcd

module pc_imen(
    input [31:0] PC_INPUT,
    input clk,
    input reset,
    output [31:0] instruction_OUTPUT 
);

    wire [31:0] current_pc;


    PC U1(.next_pc(PC_INPUT), .clk(clk), .reset(reset), .current_pc(current_pc));
    IMEN U2(.addr(current_pc), .instruction(instruction_OUTPUT));

endmodule



module tb_pc_imen;

    reg clk;
    reg reset;
    reg [31:0] PC_INPUT;
    wire [31:0] instruction_OUTPUT;

    pc_imen uut (
        .PC_INPUT(PC_INPUT),
        .clk(clk),
        .reset(reset),
        .instruction_OUTPUT(instruction_OUTPUT)
    );

    // Generador de reloj
    always #5 clk = ~clk;

    initial begin
        $dumpfile("tb_pc_imen.vcd");
        $dumpvars(0, tb_pc_imen);

        clk = 0;
        reset = 1;
        PC_INPUT = 0;
        #10 reset = 0;

        repeat (16) begin
            #10 display_fields();
            PC_INPUT = PC_INPUT + 1; // avanza PC
        end

        #10 $finish;
    end

    task display_fields;
        reg [5:0] opcode;
        begin
            opcode = instruction_OUTPUT[31:26];
            $display("PC=%0d | Instr=%b", PC_INPUT, instruction_OUTPUT);

            // Si opcode == 0 → tipo R
            if (opcode == 6'b000000) begin
                $display("opcode=%b rs=%b rt=%b rd=%b shamt=%b funct=%b",
                    instruction_OUTPUT[31:26],
                    instruction_OUTPUT[25:21],
                    instruction_OUTPUT[20:16],
                    instruction_OUTPUT[15:11],
                    instruction_OUTPUT[10:6],
                    instruction_OUTPUT[5:0]
                );
            end 
            // Si opcode != 0 → tipo I
            else begin
                $display("opcode=%b rs=%b rt=%b immediate=%b",
                    instruction_OUTPUT[31:26],
                    instruction_OUTPUT[25:21],
                    instruction_OUTPUT[20:16],
                    instruction_OUTPUT[15:0]
                );
            end

            $display("------------------------------------------------------");
        end
    endtask

endmodule
