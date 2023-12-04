// hysteresis_comparator_testbench.v

`timescale 1ns / 1ps

// 滞回比较器测试模块
module hysteresis_comparator_testbench();
    reg clk_100kHz; // 100kHz时钟信号
    reg rst_; // 复位信号
    wire [7:0] wave; // 输入的数字波形
    wire square_wave; // 输出的方波
    reg [1:0] sw; // 拨码开关

    // 滞回比较器
    hysteresis_comparator hysteresis_comparator(
        .rst_(rst_),
        .wave(wave),
        .square_wave(square_wave)
    );

    // 测试用波形
    wave_generator wave_generator(
        .clk_100kHz(clk_100kHz),
        .rst_(rst_),
        .sw(sw),
        .freq_ctrl(8'd1),
        .wave_out(wave)
    );

    initial begin
        clk_100kHz = 1'b0;
        forever #5 clk_100kHz = ~clk_100kHz;
    end

    initial begin
        rst_ = 1'b0;
        sw = 2'b00;
        #10 rst_ = 1'b1;
        #200000 sw = 2'b01;
        #200000 sw = 2'b10;
        #200000 sw = 2'b11;
        #200000 $finish;
    end


endmodule
