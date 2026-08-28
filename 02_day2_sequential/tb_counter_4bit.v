`timescale 1ns/1ps

module tb_counter_4bit;

    reg        clk;
    reg        rst_n;
    wire [3:0] count;          // 4-bit wire

    // Instantiate the design
    counter_4bit uut (
        .clk(clk),
        .rst_n(rst_n),
        .count(count)
    );

    // Clock generation (10 ns period)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Stimulus
    initial begin
        $dumpfile("counter_4bit.vcd");
        $dumpvars(0, tb_counter_4bit);

        // Apply reset
        rst_n = 0;
        #20;

        // Release reset
        rst_n = 1;

        // Let the counter run for enough time (so you can see 0 to 15)
        #200;

        $display("4-bit Counter simulation finished");
        $finish;
    end

endmodule
