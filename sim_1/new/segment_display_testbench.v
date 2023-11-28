// segment_display_testbench.v

`timescale 1ns / 1ps
`define Clock 10 // 定义时钟周期为10ns

// 七段显示器测试模块
module segment_display_testbench();
    reg clk_1kHz; // 1kHz时钟信号
    reg rst_; // 复位信号
    wire [3:0] an1, an2; // 片选输出
    wire [6:0] seg1, seg2; // 七段显示器输出
    wire dp1, dp2; // 小数点输出

    // 初始化过程
    initial begin
        clk_1kHz = 0; // 初始化时钟为0
        rst_ = 0; #(`Clock * 40 + 1); // 复位信号延迟40个时钟周期后变为1
        rst_ = 1;
        forever
            #(500000) clk_1kHz = ~clk_1kHz; // 生成1kHz时钟信号
    end

    // 实例化左边的七段显示器
    segment_display segmentl(
        .clk_1kHz(clk_1kHz),
        .rst_(rst_),
        .en(4'b1111), // 启用所有段
        .bin0(4'hd), // 输入数字d
        .bin1(4'h9), // 输入数字9代替g
        .bin2(4'h2), // 输入数字2
        .bin3(4'h1), // 输入数字1
        .dpin(4'b1000), // 小数点在第一位
        .an(an1), // 片选输出
        .seg({dp1,seg1}) // 七段显示器和小数点输出
    );

    // 实例化右边的七段显示器
    segment_display segmentr(
        .clk_1kHz(clk_1kHz),
        .rst_(rst_),
        .en(4'b1111), // 启用所有段
        .bin0(4'h0), // 输入数字0
        .bin1(4'h1), // 输入数字1
        .bin2(4'h2), // 输入数字2
        .bin3(4'h3), // 输入数字3
        .dpin(4'b0000), // 小数点在第一位
        .an(an2), // 片选输出
        .seg({dp2,seg2}) // 七段显示器和小数点输出
    );

endmodule
