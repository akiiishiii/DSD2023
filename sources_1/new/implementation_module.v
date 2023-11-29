// implementation_module.v

`timescale 1ns / 1ps

// 实现模块
module implementation_module(
    input clk,
    input rst_,
    input [1:0] sw,
    output [3:0] an1,
    output [7:0] seg1,
    output [3:0] an2,
    output [7:0] seg2,
    output ile,
    output cs_,
    output wr1_,
    output wr2_,
    output xfer_,
    output [7:0] dac_data
    );

    wire clk_1kHz; // 1kHz时钟信号
    wire clk_100kHz; // 100kHz时钟信号
    wire [7:0] wave; // 波输出

    divider div_1kHz(
        .clk_in(clk),
        .rst_(rst_),
        .div_factor(100000),
        .clk_out(clk_1kHz)
    );

    divider div_100kHz(
        .clk_in(clk),
        .rst_(rst_),
        .div_factor(1000),
        .clk_out(clk_100kHz)
    );

    segment_display segmentl(
        .clk_1kHz(clk_1kHz),
        .rst_(rst_),
        .en(4'b1111),
        .bin0(4'hd),
        .bin1(4'h9), // 9代替g
        .bin2(4'h2),
        .bin3(4'h1),
        .dpin(4'b1000),
        .an(an1),
        .seg(seg1)
    );

    segment_display segmentr(
        .clk_1kHz(clk_1kHz),
        .rst_(rst_),
        .en(4'b1111),
        .bin0(4'h0),
        .bin1(4'h1),
        .bin2(4'h2),
        .bin3(4'h3),
        .dpin(4'b0000),
        .an(an2),
        .seg(seg2)
    );

    wave_generator wave_gen(
        .clk_100kHz(clk_100kHz),
        .rst_(rst_),
        .sw(sw),
        .freq_ctrl(8'd1),
        .wave_out(wave)
    );

    DAC0832_driver dac(
        .clk(clk_100kHz),
        .rst_(rst_),
        .data_in(wave),
        .ile(ile),
        .cs_(cs_),
        .wr1_(wr1_),
        .wr2_(wr2_),
        .xfer_(xfer_),
        .data_out(dac_data)
    );

endmodule
