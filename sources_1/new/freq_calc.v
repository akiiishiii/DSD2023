// freq_calc.v

`timescale 1ns / 1ps

// 理论频率计算模块
module freq_calc(
    input clk_100kHz, // 100kHz时钟信号
    input rst_, // 复位信号
    input [7:0] freq_ctrl, // 频率控制字
    output reg [31:0] freq_theory // 理论频率
    );

    integer i = 0; // 循环变量
    reg [31:0] temp_freq;

    always @(posedge clk_100kHz or negedge rst_ ) begin
        if (!rst_) begin
            freq_theory <= 32'd0; // 复位时，理论频率输出0
        end else begin
            temp_freq = 32'd0;
            for (i = 0; i < freq_ctrl; i = i + 1) begin
                temp_freq = temp_freq + 'd100000; // 理论频率计算
            end
            temp_freq = temp_freq >> 'd8; // 理论频率计算
            freq_theory <= temp_freq; // 理论频率输出
        end
    end

endmodule
