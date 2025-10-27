module testbench_banco;

    // ================================================
    // 1. DECLARACIÓN DE SEÑALES
    // ================================================
    // Señales para conectar al DUT (Design Under Test)
    reg  clk;
    reg  reset;
    reg  RegWrite;
    reg  [4:0] read_reg1;
    reg  [4:0] read_reg2;
    reg  [4:0] write_reg;
    reg  [31:0] write_data;
    wire [31:0] read_data1;
    wire [31:0] read_data2;


     // ================================================
    // 2. INSTANCIACIÓN DEL DISEÑO BAJO PRUEBA (DUT)
    // ================================================
    RegisterFile dut (
        .clk(clk),
        .reset(reset),
        .RegWrite(RegWrite),
        .read_reg1(read_reg1),
        .read_reg2(read_reg2),
        .write_reg(write_reg),
        .write_data(write_data),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );


     // ================================================
    // 3. GENERACIÓN DE ESTÍMULOS Y MONITOREO
    // ================================================

    // Generación de reloj
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Periodo de 10 unidades de tiempo
    end

    initial begin
        // Inicialización de señales
        reset = 1;
        RegWrite = 0;
        read_reg1 = 5'd0;
        read_reg2 = 5'd0;
        write_reg = 5'd0;
        write_data = 32'd0;

        // Liberar el reset después de un tiempo
        #10;
        reset = 0;

        // Escritura y lectura en el registro 5, lectura en el registro 0
        #10;
        RegWrite = 1;
        write_reg = 5'd5;
        write_data = 32'hA5A5A5A5;
        $display("Escritura en R5 = 0x%h", write_data);

        #10;
        RegWrite = 0;
        read_reg1 = 5'd5;
        read_reg2 = 5'd0;
        $display("Lectura: R5 = 0x%h, R0 = 0x%h", read_data1, read_data2);
        $display("");



        // Escritura  y lectura en el registro 12, y lectura en el registro 0
        #10;
        RegWrite = 1;
        write_reg = 5'd12;
        write_data = 32'hAAAAAAAA;
        $display("Escritura en R12 = 0x%h", write_data);

        #10;
        RegWrite = 0;
        read_reg1 = 5'd12;
        read_reg2 = 5'd0;
        $display("Lectura: R12 = 0x%h, R0 = 0x%h", read_data1, read_data2);
        $display("");


        // Intento de escritura en el registro 0 (debe ser ignorado), lectura en el registro 0 y 5
        #10;
        RegWrite = 1;
        write_reg = 5'd0;   
        write_data = 32'hFFFFFFFF;
        $display("Intento de escritura en R0 = 0x%h", write_data);

        #10;
        RegWrite = 0;
        read_reg1 = 5'd0;
        read_reg2 = 5'd5;
        $display("Lectura: R0 = 0x%h, R5 = 0x%h", read_data1, read_data2);
        $display("");

        // Escritura y lectura en el registro 31, lectura en el registro 12
        #10;
        RegWrite = 1;
        write_reg = 5'd31;
        write_data = 32'h12345678;
        $display("Escritura en R31 = 0x%h", write_data);

        #10;
        RegWrite = 0;
        read_reg1 = 5'd31;
        read_reg2 = 5'd12;
        $display("Lectura: R31 = 0x%h, R12 = 0x%h", read_data1, read_data2);
        $display("");


        //Lectura en registros no escritos (R1 y R2)
        #10;
        read_reg1 = 5'd1;
        read_reg2 = 5'd2;
        $display("Lectura: R1 = 0x%h, R2 = 0x%h", read_data1, read_data2);
        $display("");





        // Finalizar la simulación
        #20;
        $finish;
    end

    initial begin
        $dumpfile("RegisterFile.vcd");
        $dumpvars(0, testbench_banco);
    end



endmodule