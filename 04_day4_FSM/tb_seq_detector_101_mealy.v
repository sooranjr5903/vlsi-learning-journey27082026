`timescale 1ns/1ps

module tb_seq_detector_101_mealy;

    reg  clk;
    reg  rst_n;
    reg  x;
    wire z;

    // Instantiate the design
    seq_detector_101_mealy uut (
        .clk(clk),
        .rst_n(rst_n),
        .x(x),
        .z(z)
    );

    // Clock generation (10 ns period)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Stimulus
    initial begin
      $dumpfile("seq_detector_101_mealy.vcd");
      $dumpvars(0, tb_seq_detector_101_mealy);

        // Apply reset
        rst_n = 0;
        x     = 0;
        #20;

        // Release reset
        rst_n = 1;
        #10;

        // Apply serial input sequence: 1 0 1 1 0 1 0
        // We change x just before the rising edge of clock

        x = 1; #10;   // First 1
        x = 0; #10;   // 0
        x = 1; #10;   // 1  → "101" detected here
        x = 1; #10;   // 1
        x = 0; #10;   // 0
        x = 1; #10;   // 1  → "101" detected again
        x = 0; #10;   // 0

        #20;
        $display("Sequence Detector 101 simulation finished");
        $finish;
    end

endmodule
