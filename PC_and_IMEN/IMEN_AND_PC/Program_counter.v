// Program counter
// de 32bits.
// by Alan Gomez

// Ejercicio 1: Crear el módulo PC

// 1. Crea un módulo llamado PC con los siguientes puertos:
//      input clk → reloj
//      input reset → reinicia el PC
//      input [31:0] next_pc → dirección siguiente
//      output reg [31:0] current_pc → dirección actual

// 2. El PC debe:
//      Reiniciarse a 0 cuando reset = 1.
//      Tomar el valor de next_pc en cada flanco positivo de clk.

// 3. Testbench para PC
//      Crea un testbench que:
//      Inicialice clk = 0 y reset = 1.
//      Desactive reset después de algunos ciclos.
//      Cambie next_pc cada ciclo y observe current_pc.
//      Usa $display para imprimir el valor de current_pc cada ciclo.

module PC(  
    input clk,
    input reset,
    input [31:0] next_pc,
    output reg [31:0] current_pc
);
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_pc <= 32'b0;
        else
            current_pc <= next_pc;
    end

endmodule


// module PC_tb;

//     // Entradas
//     reg [31:0] next_pc;
//     reg clk;
//     reg reset;

//     // Salida
//     wire [31:0] current_pc;

//     // Instancia del módulo bajo prueba (DUT)
//     PC uut (
//         .clk(clk),
//         .reset(reset),
//         .next_pc(next_pc),
//         .current_pc(current_pc)
//     );

//     // Generador de reloj: cambia cada 5 ns
//     always #5 clk = ~clk;

//     initial begin
//         $dumpfile("PC_tb.vcd");
//         $dumpvars(0, PC_tb);

//         // Inicialización
//         clk = 0;
//         reset = 1;
//         next_pc = 0;

//         // Mantener reset activo por unos ciclos
//         #10 reset = 0;

//         // Cambiar next_pc en cada ciclo
//         next_pc = 32'd1; #10;
//         next_pc = 32'd2; #10;
//         next_pc = 32'd3; #10;
//         next_pc = 32'd4; #10;

//         // Mostrar resultados
//         $display("Time=%0t | next_pc=%0d | current_pc=%0d", $time, next_pc, current_pc);

//         // Terminar simulación
//         #10 $finish;
//     end

// endmodule
