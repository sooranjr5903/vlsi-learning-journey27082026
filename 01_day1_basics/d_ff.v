module d_ff (
    input  wire clk,
    input  wire rst_n,   // active low reset
    input  wire d,
    output reg  q
);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            q <= 1'b0;        // reset
        else
            q <= d;           // normal operation
    end

endmodule
