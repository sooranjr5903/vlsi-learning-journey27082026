`timescale 1ns/1ps

module tb_counter_updown;

    reg        clk;
    reg        rst_n;
    reg        up_down;
    wire [3:0] count;

    // Instantiate the correct design
    counter_updown uut (
        .clk(clk),
        .rst_n(rst_n),
        .up_down(up_down),
        .count(count)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Stimulus
    initial begin
        $dumpfile("counter_updown.vcd");
        $dumpvars(0, tb_counter_updown);

        // Apply reset
        rst_n   = 0;
        up_down = 1;
        #20;

        // Release reset
        rst_n = 1;

        // Count UP
        up_down = 1;
        #100;               // Count up for some time

        // Count DOWN
        up_down = 0;
        #80;                // Count down for some time

        // Count UP again
        up_down = 1;
        #60;

        $display("Up-Down Counter simulation finished");
        $finish;
    end

endmodule
