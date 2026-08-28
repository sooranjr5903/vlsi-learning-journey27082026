module t_ff (
    input  wire clk,
    input  wire rst_n,   // active low reset
    input  wire t,
    output reg  q
);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            q <= 1'b0;
        else if (t)
            q <= ~q;     // Toggle when t = 1
        else
            q <= q;      // Hold when t = 0
    end

endmodule
