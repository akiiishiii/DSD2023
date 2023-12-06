// vga_display_testbench.v

`timescale 1ns / 1ps

// VGA显示测试模块
module vga_display_testbench();
    reg clk_25MHz = 1'b0; // 时钟信号
    reg rst_ = 1'b0; // 复位信号
    wire h_sync; // 水平同步信号
    wire v_sync; // 垂直同步信号
    wire [3:0] r, g, b; // 像素数据

    vga_display vga_display_inst( // 实例化VGA显示模块
        .clk_25MHz(clk_25MHz),
        .rst_(rst_),
        .rgb_in(12'b1111_1111_1111),
        .h_pos(),
        .v_pos(),
        .h_sync(h_sync),
        .v_sync(v_sync),
        .r(r),
        .g(g),
        .b(b)
    );

    initial begin
        clk_25MHz = 1'b0;
        forever
            #20 clk_25MHz = ~clk_25MHz;
    end

    initial begin
        rst_ = 1'b0;
        #100 rst_ = 1'b1;
    end

endmodule
