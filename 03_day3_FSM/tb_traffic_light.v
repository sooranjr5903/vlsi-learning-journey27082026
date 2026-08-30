`timescale 1ns/1ps

module tb_traffic_light;

    reg  clk;
    reg  rst_n;
    wire red, yellow, green;

    // Instantiate the design
    traffic_light uut (
        .clk(clk),
        .rst_n(rst_n),
        .red(red),
        .yellow(yellow),
        .green(green)
    );

    // Clock generation (10 ns period)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Stimulus
    initial begin
        $dumpfile("traffic_light.vcd");
        $dumpvars(0, tb_traffic_light);

        // Apply reset
        rst_n = 0;
        #20;

        // Release reset
        rst_n = 1;

        // Let it run for enough time to see several cycles
        #300;

        $display("Traffic Light simulation finished");
        $finish;
    end

endmodule
