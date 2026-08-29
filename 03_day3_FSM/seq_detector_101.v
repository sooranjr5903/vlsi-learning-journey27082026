module seq_detector_101 (
    input  wire clk,
    input  wire rst_n,     // active low reset
    input  wire x,         // serial input
    output reg  z          // output (1 when "101" detected)
);

    // State encoding
    localparam S0 = 2'b00;
    localparam S1 = 2'b01;
    localparam S2 = 2'b10;
    localparam S3 = 2'b11;

    reg [1:0] state, next_state;

    // State register (sequential)
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            state <= S0;
        else
            state <= next_state;
    end

    // Next state logic (combinational)
    always @(*) begin
        case (state)
            S0: next_state = x ? S1 : S0;
            S1: next_state = x ? S1 : S2;
            S2: next_state = x ? S3 : S0;
            S3: next_state = x ? S1 : S2;
            default: next_state = S0;
        endcase
    end

    // Output logic (Moore - depends only on state)
    always @(*) begin
        case (state)
            S3: z = 1'b1;
            default: z = 1'b0;
        endcase
    end

endmodule
