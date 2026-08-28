`timescale 1ns/1ps

module tb_t_ff;

    reg clk;
    reg rst_n;
    reg t;
    wire q;

    // Instantiate the design
    t_ff uut (
        .clk(clk),
        .rst_n(rst_n),
        .t(t),
        .q(q)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;   // Clock period = 10 ns
    end

    // Stimulus
    initial begin
      $dumpfile("t_ff.vcd");
      $dumpvars(0, tb_t_ff);

        // Apply reset
        rst_n = 0;
        t = 0;
        #15;

        // Release reset
        rst_n = 1;
        #10;

        // Apply different data values
        t = 1; #20;
        t = 0; #20;
        t = 1; #20;
        t = 1; #20;
        t = 0; #20;

        $display("T Flip-Flop simulation finished");
        $finish;
    end

endmodule
