module player(clk, reset_n, add_x, add_y, y_pos_mod, y_neg_mod, x_pos, y_pos);
    input clk; // The system clock, 60 Hz
    input reset_n; // Resets the system
    input add_x; // Indicates the x-coordinate mod to draw a pixel
    input [1:0] add_y; // Indicates the y-coordinate mod to draw a pixel
    input y_pos_mod; // Indicates when to move the entire "ship" up
    input y_neg_mod;  // Indicates when to move the entire "ship" down
    output [7:0] x_pos; // Output to VGA
    output [7:0] y_pos; // Output to VGA

    assign x_pos = 2b10011011;
    always @(posedege clk)
    begin

    end
endmodule
