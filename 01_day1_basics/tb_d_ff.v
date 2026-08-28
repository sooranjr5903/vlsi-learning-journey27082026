`timescale 1ns/1ps

module tb_d_ff;

    reg clk;
    reg rst_n;
    reg d;
    wire q;

    // Instantiate the design
    d_ff uut (
        .clk(clk),
        .rst_n(rst_n),
        .d(d),
        .q(q)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;   // Clock period = 10 ns
    end

    // Stimulus
    initial begin
        $dumpfile("d_ff.vcd");
        $dumpvars(0, tb_d_ff);

        // Apply reset
        rst_n = 0;
        d = 0;
        #12;

        // Release reset
        rst_n = 1;
        #10;

        // Apply different data values
        d = 1; #10;
        d = 0; #10;
        d = 1; #10;
        d = 1; #10;
        d = 0; #20;

        $display("D Flip-Flop simulation finished");
        $finish;
    end

endmodule
