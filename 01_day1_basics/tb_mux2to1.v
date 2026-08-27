`timescale 1ns/1ps

module tb_mux2to1;

    reg a, b, sel;
    wire y;

    // Instantiate the design
    mux2to1 uut (
        .a(a),
        .b(b),
        .sel(sel),
        .y(y)
    );

    initial begin
        $dumpfile("mux2to1.vcd");
        $dumpvars(0, tb_mux2to1);

        // Test all combinations
        a = 0; b = 0; sel = 0; #10;
        a = 0; b = 1; sel = 0; #10;
        a = 1; b = 0; sel = 0; #10;
        a = 1; b = 1; sel = 0; #10;

        a = 0; b = 0; sel = 1; #10;
        a = 0; b = 1; sel = 1; #10;
        a = 1; b = 0; sel = 1; #10;
        a = 1; b = 1; sel = 1; #10;

        $display("Simulation finished");
        $finish;
    end

endmodule
