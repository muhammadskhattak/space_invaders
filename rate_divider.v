//The rate divider module, the rate divider counter that is running with the MHz clock
module ratedivider(enable, load, clk, reset_n, q);
	input enable, clk, reset_n;
	input [27:0] load;
	output reg [27:0] q;
	
	always @(posedge clk)
	begin
		if (reset_n == 1'b0)
			q <= load;
		else if (enable == 1'b1)
			begin
				if (q == 0)
					q <= load; //Switch back to 20'b11001110111001100001
				else
					q <= q - 1'b1;
			end
	end
endmodule


////The delay, 50 million divided by 59 to get 60 hz from 50mhz clock
//module delay_counter(clock,reset_n,enable,q);
//		input clock;
//		input reset_n;
//		input enable;
//		output reg [19:0] q;
//		
//		always @(posedge clock)
//		begin
//			if(reset_n == 1'b0)
//				q <= 20'b11001110111001100001;
//			else if(enable ==1'b1)
//			begin
//			   if ( q == 20'd0 )
//					q <= 20'b11001110111001100001;
//				else
//					q <= q - 1'b1;
//			end
//		end
//endmodule