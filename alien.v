module alien(clk, reset_n, y_init, add_x, x_pos, y_pos);
  input clk; // Clock synced to the system
  input reset_n; // Resets the system
  input [2:0] add_x; // Indicates how much to move the x-pixel
  input [6:0] y_init; // The initial y_pos for this alien (should not change)
  output [7:0] x_pos; // The current x-position of the alien
  output [6:0] y_pos; // The current y-position of the alien

  reg [7:0] x_pixel;
  reg [6:0] y_pixel;

  always @(posedge clk) begin
  if (!reset_n)
  begin
    x_pixel <= 8'b00000000;
    y_pixel <= y_init;
  end
  if (draw_enable)
  begin
    assign x_pos = x_pixel + add_x;
    assign y_pos = y_init;
  end
  end
endmodule
