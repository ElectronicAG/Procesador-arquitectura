//Para correr: iverilog -o Prueba Testbench.v Etapa1.v Etapa2.v Etapa3.v PC.v MUX_next_PC.v IMEM2.v Instruction_Decoder.v ControlUnit.v RegisterFile.v MUX_RegDst.v MUX_ALUSrc.v ALUcontrol.v ALU.v
  //Luego: vvp Prueba
  //Finalmente: gtkwave Procesador.vcd

module testbench();
    // Señales para conectar al módulo Etapa1_Fetch
    reg clk;
    reg reset;
    wire [31:0] instruction;
    reg [31:0] idx;  

    // Instancia del módulo a probar
    Etapa1_Fetch fetch_stage (
        .clk(clk),
        .reset(reset),
        .instruction(instruction)
    );

    // Generación de reloj
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Estímulos y monitoreo
        initial begin
        reset = 1;
        idx = 0;
        #10;
        reset = 0;

        // 35 ciclos (como antes)
        repeat (20) begin
            @(posedge clk);
        end

        // Esperar N ciclos extra para vaciar pipeline (ajustá N a 3..6 según tu número de etapas)
        repeat (5) @(posedge clk); // <- da tiempo a que instrucciones lleguen a WB

        // Asegúrate de que la escritura posedge ocurra y se propague
        @(posedge clk); #1;

        // Imprimir el estado final de los registros
        print_registers;

        $finish;
    end


    //imprime en cada flanco positivo del reloj
    always @(negedge clk) begin
        idx <= idx + 1;
        
        // Monitoreo detallado de la instrucción actual
        $display("\n=== Ciclo %0d === Tiempo %0t ===", idx, $time);
        $display("PC = %0d | Instruccion = %b", fetch_stage.pc_inst.current_pc, instruction);
        
        // Monitoreo de señales de control
        $display("Senales de Control:");
        $display("RegWrite = %b | ALUSrc = %b | RegDst = %b | Opcode = %b",
            fetch_stage.decode_stage.control_unit_inst.RegWrite,
            fetch_stage.decode_stage.control_unit_inst.ALUSrc,
            fetch_stage.decode_stage.control_unit_inst.RegDst,
            fetch_stage.decode_stage.instr_decoder_inst.opcode);

        // Monitoreo de registros y ALU
        $display("Operacion:");
        $display("write_reg = %0d | ALU_Result = %0d | write_data = %0d",
            fetch_stage.decode_stage.write_reg,
            $signed(fetch_stage.decode_stage.alu_result),
            $signed(fetch_stage.decode_stage.alu_result));
        
        $display("----------------------------------------");
    end

    // Tarea para imprimir registros (sin cambios)
    task print_registers;
        integer i;
        begin
            $display("\n=======================================================");
            $display("          Estado Final del Banco de Registros           ");
            $display("=======================================================");
            for (i = 0; i < 32; i = i + 1) begin
                $display("R[%0d] ($%0d) = %0D", 
                    i, i, 
                    $signed(fetch_stage.decode_stage.register_file_inst.registers[i]));
            end
            $display("=======================================================\n");
        end
    endtask

    initial begin
        $dumpfile("Procesador.vcd");
        $dumpvars(0, testbench);
    end

endmodule

