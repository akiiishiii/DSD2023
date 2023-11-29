// phase_accumulator.v

`timescale 1ns / 1ps

// 相位累加器模块
module phase_accumulator(
    input clk_100kHz, // 100kHz时钟信号
    input rst_, // 复位信号
    input [7:0] freq_ctrl, // 频率控制字
    output reg [7:0] acc_sum // N位累加和
    );

    always @(posedge clk_100kHz or negedge rst_ ) begin
        if (!rst_) begin
            acc_sum <= 8'd0; // 复位时，累加和为0
        end else begin
            acc_sum <= acc_sum + freq_ctrl; // 每个时钟周期，累加和增加频率控制字
        end
    end

endmodule
