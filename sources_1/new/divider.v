// divider.v

`timescale 1ns / 1ps

// 可调分频因子的分频器模块
module divider(
    input clk_in, // 输入时钟
    input rst_, // 复位信号
    input [31:0] div_factor, // 分频因子
    output reg clk_out // 输出时钟
    );

    reg [31:0] counter = 0; // 计数器

    always @(posedge clk_in or negedge rst_ ) begin
        if (!rst_) begin
            clk_out = 0; // 复位输出时钟
            counter = 0; // 复位计数器
        end else if (counter == div_factor[31:1] - 1) begin
            clk_out = ~clk_out; // 切换输出时钟状态
            counter = 0; // 重置计数器
        end else begin
            counter = counter + 1; // 增加计数器的值
        end
    end

endmodule
