// freq_calc_testbench.v

`timescale 1ns / 1ps

// 频率计算模块测试
module freq_calc_testbench();
    reg [7:0] freq_ctrl = 1; // 频率控制字
    reg rst_ = 0; // 复位信号
    reg clk_100kHz = 0; // 100kHz时钟信号
    wire [31:0] freq_theory; // 理论频率

    initial begin
        #50 rst_ = 1; // 50ns后复位信号变为1
        forever begin
            #1000 freq_ctrl = freq_ctrl + 1; // 每1000ns增加1
            // 控制字从1递增到255后停止
            if (freq_ctrl == 8'd255) begin
                $finish;
            end
        end
    end

    always begin
        #5 clk_100kHz = ~clk_100kHz; // 5ns后时钟信号取反
    end

    freq_calc freq_calc_1(
        .clk_100kHz(clk_100kHz),
        .rst_(rst_),
        .freq_ctrl(freq_ctrl),
        .freq_theory(freq_theory)
    );

endmodule
