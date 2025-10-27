// ALU Control Unit
// Universidad del Valle de Guatemala
// Curso: Arquitectura de Computadores
// Autor: Samuel Tortola - 22094, Alan Gomez - 22115
// Fecha: 1/10/2025

// La ALU Control Unit es responsable de generar las señales de control específicas para la Unidad Aritmético-Lógica (ALU)
// basándose en el código de operación (opcode) y el campo funct de la instrucción


module ALUControl(
    input [1:0] ALUOp, //Señal de control de 2 bits proveniente de la unidad de control principal
    input [5:0] funct, //Campo funct de instrucciones tipo R
    output reg [3:0] alu_control //Señal de control de 4 bits para la ALU
);

    always @(*) begin
        case(ALUOp)
            2'b00: alu_control = 4'b0000; // MOVI
            2'b10: begin
                case(funct)
                    6'b100000: alu_control = 4'b0010; // ADD
                    6'b100100: alu_control = 4'b0110; // SUB
                    6'b100001: alu_control = 4'b1000; // MULT
                    6'b100010: alu_control = 4'b1001; // DIV
                    6'b100011: alu_control = 4'b0001; // MOV
                    default:   alu_control = 4'b0000; // Valor por defecto
                endcase
            end
            default: alu_control = 4'b0000; // Valor por defecto
        endcase
    end

endmodule



