// divider_testbench.v

`timescale 1ns / 1ps

// 可调分频因子的分频器测试模块
module divider_testbench();
    reg clk_100MHz; // 100MHz输入时钟
    wire clk_100kHz, clk_1kHz; // 100kHz和1kHz输出时钟
    reg rst_; // 复位信号

    // 实例化divider模块
    divider div_100kHz(
        .clk_in(clk_100MHz),
        .rst_(rst_),
        .div_factor(1000),
        .clk_out(clk_100kHz)
    );

    divider div_1kHz(
        .clk_in(clk_100MHz),
        .rst_(rst_),
        .div_factor(100000),
        .clk_out(clk_1kHz)
    );

    // 时钟生成器
    always begin
        #5 clk_100MHz = ~clk_100MHz; // 10ns周期的时钟，即100MHz
    end

    // 测试过程
    initial begin
        rst_ = 0; // 初始化复位信号
        clk_100MHz = 0; // 初始化时钟
        #500 rst_ = 1; // 500ns后复位信号变为1
        #1000000000; // 1s后结束测试
        $finish; // 结束测试
    end

endmodule
