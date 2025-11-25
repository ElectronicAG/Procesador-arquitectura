// IMEM
// Universidad del Valle de Guatemala
// Curso: Arquitectura de Computadores
// Autor: Samuel Tortola - 22094, Alan Gomez - 22115
// Fecha: 13/10/2025

//El Instruction Memory (IMEM) es una memoria que almacena las instrucciones del programa que la CPU debe ejecutar.
//Cada instrucción es una palabra de 32 bits, y la IMEM permite acceder a estas instrucciones utilizando una dirección específica.
// La CPU utiliza la dirección proporcionada por el Program Counter (PC) para leer la instrucción correspondiente desde la IMEM.



module IMEM( 
    input  wire [31:0] addr,        // Dirección de la instrucción
    output wire [31:0] instruction // Instrucción leída
);

    reg [31:0] memory [0:4095]; // Memoria de 32 palabras de 32 bits

    initial begin
        // Indexar secuencialmente: memory[0] corresponde a PC=0, memory[1] a PC=4, etc.
         

// =======================
// Programa de prueba MIPS personalizado
// =======================
    memory[0]  = 32'b001010_00000_00001_0000000000001111;   // MOVI $1, 15               // PC = 0
    memory[1]  = 32'b001010_00000_00010_0000000000010100;   // MOVI $2, 20               // PC = 4
    memory[2]  = 32'b001010_00000_00011_0000000000110010;   // MOVI $3, 50               // PC = 8
    memory[3]  = 32'b001010_00000_00100_0000000000000101;   // MOVI $4, 5                // PC = 12
    memory[4]  = 32'b001010_00000_00101_0000000000000010;   // MOVI $5, 2                // PC = 16
    memory[5]  = 32'b000000_00001_00010_00110_00000_100000; // ADD  $6, $1, $2  = 35     // PC = 20
    memory[6]  = 32'b000000_00011_00001_00111_00000_100010; // SUB  $7, $3, $1  = 35     // PC = 24
    memory[7]  = 32'b000000_00010_00011_01000_00000_011000; // MUL  $8, $2, $3  = 1000   // PC = 28
    memory[8]  = 32'b000000_00011_00010_01001_00000_011010; // DIV  $9, $3, $2  = 2      // PC = 32
    memory[9]  = 32'b001000_00001_00001_0000000000001010;   // ADDI $1, $1, 10  = 25     // PC = 36
    memory[10] = 32'b001001_00010_00010_0000000000000100;   // SUBI $2, $2, 4   = 16     // PC = 40
    memory[11] = 32'b000000_00110_00100_01010_00000_100000; // ADD  $10, $6, $4 = 40     // PC = 44
    memory[12] = 32'b000000_00110_00101_01011_00000_011000; // MUL  $11, $6, $5 = 70     // PC = 48
    memory[13] = 32'b000000_01010_00101_01100_00000_011010; // DIV  $12, $10, $5 = 20    // PC = 52
    memory[14] = 32'b001000_00100_00100_0000000000010100;   // ADDI $4, $4, 20  = 25     // PC = 56
    memory[15] = 32'b000000_00100_00011_01101_00000_100010; // SUB  $13, $4, $3 = -25    // PC = 60
    memory[16] = 32'b001010_00000_01110_0000000001100100;   // MOVI $14, 100             // PC = 64
    memory[17] = 32'b000000_01110_00001_01111_00000_100000; // ADD  $15, $14, $1 = 125   // PC = 68
    memory[18] = 32'b001001_00011_00011_0000000000000101;   // SUBI $3, $3, 5   = 45     // PC = 72
    memory[19] = 32'b000000_01111_00010_10000_00000_011000; // MUL  $16, $15, $2 = 2000  // PC = 76
    memory[20] = 32'b001000_00001_10001_0000000000000001;   // ADDI $17, $1, 1  = 26     // PC = 80
    memory[21] = 32'b000010_00000000000000010000000000;     // JUMP 1024 (salta)         // PC = 84

    memory[1024] = 32'b000010_00000000000000000000010110;   // JUMP 22 (regresa)         // PC = 4096
    memory[22] = 32'b000000_10001_00010_10010_00000_100000; // ADD  $18, $17, $2 = 42    // PC = 88
    memory[23] = 32'b000000_10010_00101_10011_00000_100010; // SUB  $19, $18, $5 = 40    // PC = 92
    memory[24] = 32'b001010_00000_10100_0000000011111111;   // MOVI $20, 255             // PC = 96
    memory[25] = 32'b001010_00000_00000_0000000011111111;   // MOVI $0, 255              // PC = 100



    end

    assign instruction = memory[addr[13:2]]; // Divide la dirección por 4
  //  El índice de la memoria debe usar 12 bits para cubrir el rango [0:4095].
	// La dirección de byte (PC) está alineada a 4 bytes (siempre termina en '00'), por lo que
	// los bits [31:2] de la dirección de byte (PC) dan el índice de palabra.
	// Si el índice más alto es 4095 (12 bits), necesitamos addr[13:2].
	// Aunque el PC es de 32 bits, para una memoria de 4096 palabras, solo necesitamos 12 bits para el índice.

endmodule




