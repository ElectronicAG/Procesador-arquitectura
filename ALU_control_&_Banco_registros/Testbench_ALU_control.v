module testbench_ALU_control;


    // ================================================
    // 1. DECLARACIÓN DE SEÑALES
    // ================================================
    // Señales para conectar al DUT (Design Under Test)

    reg  [1:0] ALUOp;
    reg  [5:0] funct;
    wire [3:0] alu_control;



    // ================================================
    // 2. INSTANCIACIÓN DEL DISEÑO BAJO PRUEBA (DUT)
    // ================================================
    ALUControl dut (
        .ALUOp(ALUOp),
        .funct(funct),
        .alu_control(alu_control)

    );


    // ================================================
    // 3. GENERACIÓN DE ESTÍMULOS Y MONITOREO
    // ================================================

    initial begin
        // Prueba para ALUOp = 00 (MOVI)
        ALUOp = 2'b00;
        funct = 6'b000000; // No importa el funct en este caso
        #10;
        $display("Time=%0t | ALUOp=%b | funct=%b | alu_control=%b", $time, ALUOp, funct, alu_control);

        // Prueba para ALUOp = 10 y diferentes valores de funct
        ALUOp = 2'b10;

        funct = 6'b100000; // ADD
        #10;
        $display("Time=%0t | ALUOp=%b | funct=%b | alu_control=%b", $time, ALUOp, funct, alu_control);

        funct = 6'b100100; // SUB
        #10;
        $display("Time=%0t | ALUOp=%b | funct=%b | alu_control=%b", $time, ALUOp, funct, alu_control);

        funct = 6'b100001; // MULT
        #10;
        $display("Time=%0t | ALUOp=%b | funct=%b | alu_control=%b", $time, ALUOp, funct, alu_control);

        funct = 6'b100010; // DIV
        #10;
        $display("Time=%0t | ALUOp=%b | funct=%b | alu_control=%b", $time, ALUOp, funct, alu_control);

        funct = 6'b100011; // MOV
        #10;
        $display("Time=%0t | ALUOp=%b | funct=%b | alu_control=%b", $time, ALUOp, funct, alu_control);

        funct = 6'b111111; // Valor no definido
        #10;
        $display("Time=%0t | ALUOp=%b | funct=%b | alu_control=%b", $time, ALUOp, funct, alu_control);

        $finish;
    end



    initial begin
        $dumpfile("ALU_control.vcd");
        $dumpvars(0, testbench_ALU_control);
    end

endmodule