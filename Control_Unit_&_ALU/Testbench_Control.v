module testbench_ControlUnit;


    // ================================================
    // 1. DECLARACIÓN DE SEÑALES
    // ================================================
    // Señales para conectar al DUT (Design Under Test)
    reg  [5:0] opcode;
    wire RegDst;
    wire ALUSrc;
    wire RegWrite;
    wire Jump;
    wire [1:0] ALUOp;

    // ================================================
    // 2. INSTANCIACIÓN DEL DISEÑO BAJO PRUEBA (DUT)
    // ================================================

    ControlUnit dut (
        .opcode(opcode),
        .RegDst(RegDst),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite),
        .Jump(Jump),
        .ALUOp(ALUOp)
    );

    // ================================================
    // 3. GENERACIÓN DE ESTÍMULOS Y MONITOREO
    // ================================================

    initial begin
        // Inicialización de señales
        opcode = 6'b000000; // Tipo R
        $display("Opcode - RegDst - ALUSrc - RegWrite - Jump - ALUOp");
        $monitor("%b - %b - %b - %b - %b - %b", opcode, RegDst, ALUSrc, RegWrite, Jump, ALUOp);
        $display(" ");


        // Esperar un tiempo y cambiar el opcode para probar diferentes casos
        #10;
        opcode = 6'b001010; // MOVI
        $monitor("%b - %b - %b - %b - %b - %b", opcode, RegDst, ALUSrc, RegWrite, Jump, ALUOp);
        $display(" ");

        #10;
        opcode = 6'b001000; // ADDI     
        $monitor("%b - %b - %b - %b - %b - %b", opcode, RegDst, ALUSrc, RegWrite, Jump, ALUOp);
        $display(" ");


        #10;
        opcode = 6'b001001; // SUBI
        $monitor("%b - %b - %b - %b - %b - %b", opcode, RegDst, ALUSrc, RegWrite, Jump, ALUOp);
        $display(" ");

        #10;
        opcode = 6'b000010; // JUMP
        $monitor("%b - %b - %b - %b - %b - %b", opcode, RegDst, ALUSrc, RegWrite, Jump, ALUOp);
        $display(" ");

        #10;
        opcode = 6'b111111; // Caso por defecto
        $monitor("%b - %b - %b - %b - %b - %b", opcode, RegDst, ALUSrc, RegWrite, Jump, ALUOp);
        $display(" ");
        


        // Finalizar la simulación después de probar todos los casos
        #10;
        $finish;
    end


     initial begin
    $dumpfile("ControlUnit.vcd");
    $dumpvars(0, testbench_ControlUnit);
    end



endmodule

