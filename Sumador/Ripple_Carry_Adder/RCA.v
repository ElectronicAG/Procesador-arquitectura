// Reppli Carry Adder 
// de 16bits.
// by Alan Gomez


// Adder sin Entrada Carry
module Half_adder(
    input AH,// Entrada A
    input BH,// Entrada B
    output CoutH,// Carry de salida
    output SH // Resultado de la Suma
);
    assign SH = AH ^ BH;
    assign CoutH = AH & BH;
endmodule
// Adder con Entrada de Carry
module Full_adder(
    input AF,// Entrada A
    input BF,// Entrada B
    input CinF,// Entrada de Carry
    output CoutF,// Carry de Salida
    output SF// Resultado de la suma
);
    wire W1, W2, W3;

    Half_adder HA1 (.AH(AF), .BH(BF), .CoutH(W1), .SH(W2));// Primera parte del sumador
    Half_adder HA2 (.AH(W2), .BH(CinF), .CoutH(W3), .SH(SF));// Segunda parte del sumador

    assign CoutF = W1 | W3 ;// Carry de salida

endmodule
//Reppli Carry Adder 
module RCA(
    input  [15:0] A,// A de 16 bits
    input  [15:0] B,// B de 16 bits
    output [31:0] S    // <- este es el resultado de la suma de 32 bits
);
    wire [15:0] C;  // carries internos
    // Conexiones 
    Full_adder FA0(.AF(A[0]), .BF(B[0]), .CinF(1'b0),   .CoutF(C[0]), .SF(S[0]));
    Full_adder FA1(.AF(A[1]), .BF(B[1]), .CinF(C[0]),   .CoutF(C[1]), .SF(S[1]));
    Full_adder FA2(.AF(A[2]), .BF(B[2]), .CinF(C[1]),   .CoutF(C[2]), .SF(S[2]));
    Full_adder FA3(.AF(A[3]), .BF(B[3]), .CinF(C[2]),   .CoutF(C[3]), .SF(S[3]));
    Full_adder FA4(.AF(A[4]), .BF(B[4]), .CinF(C[3]),   .CoutF(C[4]), .SF(S[4]));
    Full_adder FA5(.AF(A[5]), .BF(B[5]), .CinF(C[4]),   .CoutF(C[5]), .SF(S[5]));
    Full_adder FA6(.AF(A[6]), .BF(B[6]), .CinF(C[5]),   .CoutF(C[6]), .SF(S[6]));
    Full_adder FA7(.AF(A[7]), .BF(B[7]), .CinF(C[6]),   .CoutF(C[7]), .SF(S[7]));
    Full_adder FA8(.AF(A[8]), .BF(B[8]), .CinF(C[7]),   .CoutF(C[8]), .SF(S[8]));
    Full_adder FA9(.AF(A[9]), .BF(B[9]), .CinF(C[8]),   .CoutF(C[9]), .SF(S[9]));
    Full_adder FA10(.AF(A[10]), .BF(B[10]), .CinF(C[9]), .CoutF(C[10]), .SF(S[10]));
    Full_adder FA11(.AF(A[11]), .BF(B[11]), .CinF(C[10]), .CoutF(C[11]), .SF(S[11]));
    Full_adder FA12(.AF(A[12]), .BF(B[12]), .CinF(C[11]), .CoutF(C[12]), .SF(S[12]));
    Full_adder FA13(.AF(A[13]), .BF(B[13]), .CinF(C[12]), .CoutF(C[13]), .SF(S[13]));
    Full_adder FA14(.AF(A[14]), .BF(B[14]), .CinF(C[13]), .CoutF(C[14]), .SF(S[14]));
    Full_adder FA15(.AF(A[15]), .BF(B[15]), .CinF(C[14]), .CoutF(S[16]), .SF(S[15]));
    // El ultimo carry de salida seria el bit 16 de la salida de 32 bits

    assign S[31:17] = 15'b0;// se colocan los bit del 17 al 31 0

endmodule


// module RCA_tb;

//     // Entradas
//     reg [15:0] A;
//     reg [15:0] B;

//     // Salidas
//     wire [31:0] SUM;

//     // Variables de tiempo
//     time start, finish;

//     // Instancia del DUT (Device Under Test)
//     RCA uut (
//         .A(A),
//         .B(B),
//         .S(SUM)
//     );

//     initial begin
//         // Generar archivo de ondas para GTKWave (opcional)
//         $dumpfile("RCA_tb.vcd");
//         $dumpvars(0, RCA_tb);

//         // Caso 1
//         A = 0; B = 0;
//         start = $time;
//         #1; // esperar que la salida se estabilice
//         finish = $time;
//         $display("Time=%0t | A=%b (%0d), B=%b (%0d) -> SUM=%b (%0d), Cout=%b", 
//                  finish, A, A, B, B, SUM, SUM, SUM[16]);
//         // Caso 2
//         A = 1; B = 1;
//         start = $time;
//         #1;
//         finish = $time;
//         $display("Time=%0t | A=%b (%0d), B=%b (%0d) -> SUM=%b (%0d), Cout=%b", 
//                  finish, A, A, B, B, SUM, SUM, SUM[16]);
//         // Caso 3
//         A = 65535; B = 1;
//         start = $time;
//         #1;
//         finish = $time;
//         $display("Time=%0t | A=%b (%0d), B=%b (%0d) -> SUM=%b (%0d), Cout=%b", 
//                  finish, A, A, B, B, SUM, SUM, SUM[16]);
//         // Caso 4
//         A = 10; B = 5;
//         start = $time;
//         #1;
//         finish = $time;
//         $display("Time=%0t | A=%b (%0d), B=%b (%0d) -> SUM=%b (%0d), Cout=%b", 
//                  finish, A, A, B, B, SUM, SUM, SUM[16]);
//         // Caso 5
//         A = 32767; B = 1;
//         start = $time;
//         #1;
//         finish = $time;
//         $display("Time=%0t | A=%b (%0d), B=%b (%0d) -> SUM=%b (%0d), Cout=%b", 
//                  finish, A, A, B, B, SUM, SUM, SUM[16]);
//         // Caso 6
//         A = 61440; B = 3855;
//         start = $time;
//         #1;
//         finish = $time;
//         $display("Time=%0t | A=%b (%0d), B=%b (%0d) -> SUM=%b (%0d), Cout=%b", 
//                  finish, A, A, B, B, SUM, SUM, SUM[16]);
//         // Caso 7
//         A = 5; B = 3;
//         start = $time;
//         #1;
//         finish = $time;
//         $display("Time=%0t | A=%b (%0d), B=%b (%0d) -> SUM=%b (%0d), Cout=%b", 
//                  finish, A, A, B, B, SUM, SUM, SUM[16]);
//         // Caso 8
//         A = 43690; B = 21845;
//         start = $time;
//         #1;
//         finish = $time;
//         $display("Time=%0t | A=%b (%0d), B=%b (%0d) -> SUM=%b (%0d), Cout=%b", 
//                  finish, A, A, B, B, SUM, SUM, SUM[16]);
//         // Caso 9
//         A = 0; B = 21845;
//         start = $time;
//         #1;
//         finish = $time;
//         $display("Time=%0t | A=%b (%0d), B=%b (%0d) -> SUM=%b (%0d), Cout=%b", 
//                  finish, A, A, B, B, SUM, SUM, SUM[16]);
//         // Caso 10
//         A = 65535; B = 65535;
//         start = $time;
//         #1;
//         finish = $time;
//         $display("Time=%0t | A=%b (%0d), B=%b (%0d) -> SUM=%b (%0d), Cout=%b", 
//                  finish, A, A, B, B, SUM, SUM, SUM[16]);
//         // Finalizar simulación
//         #10 $finish;
//     end

// endmodule

// REF 
//[1] “Ripple Carry Adder - COMPUTER SCIENCE BYTES,” COMPUTER SCIENCE BYTES, Jul. 12, 2017.
//     https://www.computersciencebytes.com/boolean-logic/ripple-carry-adder/ (accessed Sep. 01, 2025).
‌
