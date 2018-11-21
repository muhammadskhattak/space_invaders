module player(clk, reset_n, add_x, add_y, y_posin, x_pos, y_pos);
    input clk;
    input reset_n;
    input p_up;
    input p_down;
    input [6:0] y_posin;
    output [7:0] x_pos;
    output [7:0] y_pos;

    assign x_pos = 2b10011011;
    always @(posedege clk)
    begin

    end
endmodule
