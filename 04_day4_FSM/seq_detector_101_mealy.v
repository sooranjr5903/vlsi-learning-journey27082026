module seq_detector_101_mealy (
    input  wire clk,
    input  wire rst_n,
    input  wire x,
    output reg  z
);

    // State encoding
    localparam S0 = 2'b00;
    localparam S1 = 2'b01;
    localparam S2 = 2'b10;

    reg [1:0] state, next_state;

    // State register
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            state <= S0;
        else
            state <= next_state;
    end

    // Next state + Output logic (Mealy)
    always @(*) begin
        // Default values
        next_state = state;
        z = 1'b0;

        case (state)
            S0: begin
                if (x) begin
                    next_state = S1;
                    z = 1'b0;
                end else begin
                    next_state = S0;
                    z = 1'b0;
                end
            end

            S1: begin
                if (x) begin
                    next_state = S1;   // still '1'
                    z = 1'b0;
                end else begin
                    next_state = S2;   // got "10"
                    z = 1'b0;
                end
            end

            S2: begin
                if (x) begin
                    next_state = S1;   // got "101" → go to S1 (overlapping)
                    z = 1'b1;          // Detected!
                end else begin
                    next_state = S0;
                    z = 1'b0;
                end
            end

            default: begin
                next_state = S0;
                z = 1'b0;
            end
        endcase
    end

endmodule
