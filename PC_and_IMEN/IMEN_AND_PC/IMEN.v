// Instruction Memory
// de 32bits.
// by Alan Gomez
// 
// 1. Crea un módulo llamado IMEM con los siguientes puertos:
// input [31:0] addr → dirección de la instrucción
// output [31:0] instruction → instrucción leída
// 
// 2. Implementa la memoria como un arreglo de 16 palabras de 32 bits:
// reg [31:0] memory [0:15];
// 
// 3. Inicializa la memoria con 10 instrucciones, ejemplo:
// initial begin
// memory[0] = 32'b000000_00001_00010_00011_00000_100000; // ADD $3, $1, $2
// memory[1] = 32'b001000_01000_01001_0000000000001010; // ADDI $9, $8, 10
// ...
// ...
// ...
// end
// 
// 4. Asigna la instrucción de salida según la dirección:
// assign instruction = memory[addr[4:0]]; // usa bits menos significativos
// 
// 5. Testbench para IMEM
// Crea un testbench que recorra varias direcciones (addr) y muestre la instrucción con $display.
// Extrae los campos de la instrucción (opcode, rs, rt, rd, shamt, funct o immediate) y muéstralos en pantalla.

module IMEN( input [31:0] addr,
             output [31:0] instruction );
    reg [31:0] memory [0:15];

    initial begin
        memory[0]  = 32'b000000_00001_00010_00011_00000_100000;
        memory[1]  = 32'b001000_01000_01001_0000000000001010;
        memory[2]  = 32'b100000_00001_00010_00011_00000_100000;
        memory[3]  = 32'b010000_00001_00010_00011_00000_100000;
        memory[4]  = 32'b001000_00001_00010_00011_00000_100000;
        memory[5]  = 32'b000100_00001_00010_00011_00000_100000;
        memory[6]  = 32'b000010_00001_00010_00011_00000_100000;
        memory[7]  = 32'b000001_00001_00010_00011_00000_100000;
        memory[8]  = 32'b000000_10001_00010_00011_00000_100000;
        memory[9]  = 32'b000000_01001_00010_00011_00000_100000;
        memory[10] = 32'b000000_00101_00010_00011_00000_100000;
        memory[11] = 32'b000000_00011_00010_00011_00000_100000;
        memory[12] = 32'b000000_00000_00010_00011_00000_100000;
        memory[13] = 32'b000000_00001_10010_00011_00000_100000;
        memory[14] = 32'b000000_00001_01010_00011_00000_100000;
        memory[15] = 32'b000000_00001_00110_00011_00000_100000;
    end

    assign instruction = memory[addr[3:0]];

endmodule

// module IMEN_tb;
//     reg [31:0] addr;
//     wire [31:0] instruction;

//     IMEN uut (
//         .addr(addr),
//         .instruction(instruction)   
//     );

//     initial begin
//         $dumpfile("IMEN_tb.vcd");
//         $dumpvars(0, IMEN_tb);

//         addr = 32'd0;  #10; display_fields();
//         addr = 32'd1;  #10; display_fields();
//         addr = 32'd2;  #10; display_fields();
//         addr = 32'd3;  #10; display_fields();
//         addr = 32'd4;  #10; display_fields();
//         addr = 32'd5;  #10; display_fields();
//         addr = 32'd6;  #10; display_fields();
//         addr = 32'd7;  #10; display_fields();
//         addr = 32'd8;  #10; display_fields();
//         addr = 32'd15; #10; display_fields();

//         #10 $finish;
//     end

//     task display_fields;
//         begin
//             $display("Time=%0t | addr=%0d", $time, addr);
//             $display("Instruction = %b", instruction);
//             $display("opcode = %b | rs = %b | rt = %b | rd = %b | shamt = %b | funct/immediate = %b",
//                      instruction[31:26], instruction[25:21], instruction[20:16],
//                      instruction[15:11], instruction[10:6], instruction[5:0]);
//             $display("------------------------------------------------------");
//         end
//     endtask
// endmodule