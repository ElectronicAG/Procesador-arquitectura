// Banco de Registros (Register File) 
// Universidad del Valle de Guatemala
// Curso: Arquitectura de Computadores
// Autor: Samuel Tortola - 22094, Alan Gomez - 22115
// Fecha: 1/10/2025

// El Banco de Registros es un componente esencial en la arquitectura de computadores que almacena
// un conjunto de registros utilizados para operaciones de lectura y escritura durante la ejecución

module RegisterFile (
    input  clk,                     // Reloj del sistema
    input reset,                // Señal de reinicio    
    input RegWrite,               // Señal de control para habilitar la escritura
    input [4:0] read_reg1,        // Dirección del primer registro a leer
    input [4:0] read_reg2,        // Dirección del segundo registro a leer
    input [4:0] write_reg,        // Dirección del registro a escribir
    input [31:0] write_data,      // Datos a escribir en el registro
    output [31:0] read_data1,      // Datos leídos del primer registro
    output [31:0] read_data2       // Datos leídos del segundo registro
);

    // Definición del banco de registros (32 registros de 32 bits cada uno)
    reg [31:0] registers [0:31];

    // Lectura de registros
    assign read_data1 = registers[read_reg1];
    assign read_data2 = registers[read_reg2];
 

    // Escritura de registros 
    integer i;
    always @(posedge clk or posedge reset) begin

         if (reset) begin
            for (i = 0; i < 32; i = i + 1) begin
                registers[i] <= 32'b0;
            end
        end

        else if (RegWrite && (write_reg != 5'd0)) begin  // Evita escribir en registro $0
            registers[write_reg] <= write_data;
        end

       
    end
endmodule


