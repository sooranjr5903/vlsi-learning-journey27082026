module counter_4bit_en (
    input  wire       clk,
    input  wire       rst_n,
    input  wire       en,          // enable
    output reg  [3:0] count
);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            count <= 4'b0000;
        else if (en)
            count <= count + 1'b1;   // count only when enable = 1
        else
            count <= count;          // hold value when enable = 0
    end

endmodule
