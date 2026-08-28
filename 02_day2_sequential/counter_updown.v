module counter_updown (
    input  wire       clk,
    input  wire       rst_n,     // active low reset
    input  wire       up_down,   // 1 = up, 0 = down
    output reg  [3:0] count
);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            count <= 4'b0000;
        else if (up_down)
            count <= count + 1'b1;   // Count Up
        else
            count <= count - 1'b1;   // Count Down
    end

endmodule
