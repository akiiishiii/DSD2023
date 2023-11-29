// wave_generator_testbench.v

`timescale 1ns / 1ps

// 波发生器测试模块
module wave_generator_testbench();

        reg clk = 0; // 时钟信号
        reg rst_ = 0; // 复位信号
        reg [1:0] sw = 2'b00; // 拨码开关
        reg [7:0] freq_ctrl = 8'd1; // 频率控制字
        wire [7:0] wave_out; // 波输出

        wave_generator wave_gen(
            .clk_100kHz(clk),
            .rst_(rst_),
            .sw(sw),
            .freq_ctrl(freq_ctrl),
            .wave_out(wave_out)
        );

        initial begin
            #10 rst_ = 1; // 10ns后复位信号置1
            forever
                //#20000 freq_ctrl = freq_ctrl + 1; // 20us后频率控制字加1
                #20000 sw = sw + 1; // 20us后拨码开关加1
        end

        always begin
           // 时钟周期为100kHz
              #5 clk = ~clk; // 5ns后时钟信号取反
        end

endmodule
