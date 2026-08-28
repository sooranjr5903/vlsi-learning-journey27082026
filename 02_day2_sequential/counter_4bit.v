module counter_4bit (
    input  wire       clk,
    input  wire       rst_n,     // active low reset
    output reg  [3:0] count
);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            count <= 4'b0000;           // Reset to 0
        else
            count <= count + 1'b1;      // Increment by 1
    end

endmodule
