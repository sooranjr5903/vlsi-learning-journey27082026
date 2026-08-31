`timescale 1ns/1ps

module tb_traffic_light_ped;

    reg  clk;
    reg  rst_n;
    reg  ped_btn;
    wire red, yellow, green;

    // Instantiate the design
    traffic_light_ped uut (
        .clk(clk),
        .rst_n(rst_n),
        .ped_btn(ped_btn),
        .red(red),
        .yellow(yellow),
        .green(green)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Stimulus
    initial begin
        $dumpfile("traffic_light_ped.vcd");
        $dumpvars(0, tb_traffic_light_ped);   // Correct module name

        // Apply reset
        rst_n   = 0;
        ped_btn = 0;
        #20;

        // Release reset
        rst_n = 1;

        // Let normal cycle run for some time
        #80;

        // Press pedestrian button while light is running
        ped_btn = 1;
        #30;
        ped_btn = 0;

        // Let it continue
        #200;

        $display("Traffic Light with Pedestrian Button simulation finished");
        $finish;
    end

endmodule
