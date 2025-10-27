module testbench_ALU;

// ================================================
// 1. DECLARACIÓN DE SEÑALES
// ================================================
// Señales para conectar al DUT (Design Under Test)
    reg  [31:0] src1;
    reg  [31:0] src2;
    reg  [3:0] alu_control;
    wire [31:0] result;
    wire zero;

    // ================================================
    // 2. INSTANCIACIÓN DEL DISEÑO BAJO PRUEBA (DUT)
    // ================================================

    ALU dut (
        .src1(src1),
        .src2(src2),
        .alu_control(alu_control),
        .result(result),
        .zero(zero)
    );


    // ================================================
    // 3. GENERACIÓN DE ESTÍMULOS Y MONITOREO
    // ================================================

    initial begin
        // Inicialización de señales
        src1 = 32'd0;
        src2 = 32'd0;
        alu_control = 4'b0000;
       

        #10;
        src1 = 32'd15; // Primer operando
        src2 = 32'd5;  // Segundo operando
        alu_control = 4'b0010; // Operación de suma
        $display("Src1 - Src2 - ALU_Control - Result - Zero");
        $monitor("%0d - %0d - %b - %0d - %0b", src1, src2, alu_control, result, zero);
        $display("");

        // Esperar un tiempo y cambiar la operación para probar diferentes casos
        #10;
        alu_control = 4'b0110; // Operación de resta
        $monitor("%0d - %0d - %b - %0d - %0b", src1, src2, alu_control, result, zero);
        $display("");

        #10;
        alu_control = 4'b1000; // Operación de multiplicación
        $monitor("%0d - %0d - %b - %0d - %0b", src1, src2, alu_control, result, zero);
        $display("");

        #10;
        alu_control = 4'b1001; // Operación de división
        $monitor("%0d - %0d - %b - %0d - %0b", src1, src2, alu_control, result, zero);
        $display("");

        #10;
        alu_control = 4'b0000; // Operación por defecto
        $monitor("%0d - %0d - %b - %0d - %0b", src1, src2, alu_control, result, zero);
        $display("");

            //Cambiar operandos para probar más casos
        #10;
        src1 = 32'd20;
        src2 = 32'd4;
        alu_control = 4'b0110; // Operación de resta
        $monitor("%0d - %0d - %b - %0d - %0b", src1, src2, alu_control, result, zero);
        $display("");


        #10;
        alu_control = 4'b0010; // Operación de suma
        $monitor("%0d - %0d - %b - %0d - %0b", src1, src2, alu_control, result, zero);
        $display("");


        //Probar bandera zero
        #10;
        src1 = 32'd10;
        src2 = 32'd10;
        alu_control = 4'b0110; // Operación de resta    
        $monitor("%0d - %0d - %b - %0d - %0b", src1, src2, alu_control, result, zero);
        $display("");


        // Finalizar la simulación después de un tiempo
        #10;
        $finish;
    end


    initial begin
    $dumpfile("ALU.vcd");
    $dumpvars(0, testbench_ALU);
    end




endmodule