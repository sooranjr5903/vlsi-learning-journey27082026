module traffic_light (
    input  wire clk,
    input  wire rst_n,      // active low reset
    output reg  red,
    output reg  yellow,
    output reg  green
);

    // State encoding
    localparam S_RED    = 2'b00;
    localparam S_GREEN  = 2'b01;
    localparam S_YELLOW = 2'b10;

    reg [1:0] state, next_state;
    reg [2:0] timer;        // counter for timing

    // State register + timer
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= S_RED;
            timer <= 0;
        end
        else begin
            state <= next_state;

            if (timer == 0)
                timer <= (next_state == S_YELLOW) ? 2 : 4;  // load new time
            else
                timer <= timer - 1;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            S_RED:    next_state = (timer == 0) ? S_GREEN  : S_RED;
            S_GREEN:  next_state = (timer == 0) ? S_YELLOW : S_GREEN;
            S_YELLOW: next_state = (timer == 0) ? S_RED    : S_YELLOW;
            default:  next_state = S_RED;
        endcase
    end

    // Output logic (Moore)
    always @(*) begin
        // Default all lights off
        red    = 0;
        yellow = 0;
        green  = 0;

        case (state)
            S_RED:    red    = 1;
            S_GREEN:  green  = 1;
            S_YELLOW: yellow = 1;
        endcase
    end

endmodule
