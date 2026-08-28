`timescale 1ns/1ps

module tb_counter_4bit_en;

    reg        clk;
    reg        rst_n;
    reg        en;
    wire [3:0] count;

    // Instantiate the correct design
    counter_4bit_en uut (
        .clk(clk),
        .rst_n(rst_n),
        .en(en),
        .count(count)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Stimulus
    initial begin
        $dumpfile("counter_4bit_en.vcd");
        $dumpvars(0, tb_counter_4bit_en);

        // Apply reset
        rst_n = 0;
        en    = 0;
        #20;

        // Release reset
        rst_n = 1;

        // Enable counting
        en = 1;
        #80;            // Count for some time

        // Disable (freeze the count)
        en = 0;
        #40;            // Hold value

        // Enable again
        en = 1;
        #60;

        $display("4-bit Counter with Enable simulation finished");
        $finish;
    end

endmodule
