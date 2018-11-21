module fpga_top(CLOCK_50, // The 50 MHz clock
                KEY, // Used exclusively for mapping the reset button
                VGA_CLK, // The VGA clock
                VGA_HS, // The VGA horizontal sync
                VGA_VS, // The VGA vertical sync
                VGA_BLANK_N, // The VGA Blank
                VGA_SYNC_N, // VGA Sync
                VGA_R, // VGA Red[9:0]
                VGA_G, // VGA Green[9:0]
                VGA_B); //VGA Blue[9:0]
