module traffic_light_ped (
    input  wire clk,
    input  wire rst_n,
    input  wire ped_btn,      // Pedestrian button
    output reg  red,
    output reg  yellow,
    output reg  green
);

    // State encoding
    localparam S_RED    = 2'b00;
    localparam S_GREEN  = 2'b01;
    localparam S_YELLOW = 2'b10;

    reg [1:0] state, next_state;
    reg [2:0] timer;

    // State + Timer
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= S_RED;
            timer <= 3'd4;
        end
        else begin
            state <= next_state;

            if (timer == 0)
                timer <= (next_state == S_YELLOW) ? 3'd2 : 3'd4;
            else
                timer <= timer - 1'b1;
        end
    end

    // Next state logic (with pedestrian button)
    always @(*) begin
        case (state)
            S_RED: begin
                if (timer == 0)
                    next_state = S_GREEN;
                else
                    next_state = S_RED;
            end

            S_GREEN: begin
                if (timer == 0)
                    next_state = S_YELLOW;
                else if (ped_btn)          // Pedestrian pressed
                    next_state = S_YELLOW; // Go to Yellow soon, then Red
                else
                    next_state = S_GREEN;
            end

            S_YELLOW: begin
                if (timer == 0)
                    next_state = S_RED;
                else
                    next_state = S_YELLOW;
            end

            default: next_state = S_RED;
        endcase
    end

    // Output logic
    always @(*) begin
        red    = 0;
        yellow = 0;
        green  = 0;

        case (state)
            S_RED:    red    = 1'b1;
            S_GREEN:  green  = 1'b1;
            S_YELLOW: yellow = 1'b1;
        endcase
    end

endmodule
