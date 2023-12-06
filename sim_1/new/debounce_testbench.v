// debounce_testbench.v

`timescale 1ns / 1ps

// °´¼üÏû¶¶Ä£¿é²âÊÔ
module debounce_testbench();

    reg clk_100kHz = 0;
    reg rst_ = 0;
    reg key_in = 0;
    wire key_out;

    debounce dut (
        .clk_100kHz(clk_100kHz),
        .rst_(rst_),
        .key_in(key_in),
        .key_out(key_out)
    );

    initial begin
        #100 rst_ = 1;
        #100 key_in = 1;
        #100 key_in = 0;
        #100 key_in = 1;
        #100 key_in = 0;
        #100 key_in = 1;
        #100000 key_in = 0;
        #100000 $finish;
    end

    always #5 clk_100kHz = ~clk_100kHz;

endmodule
