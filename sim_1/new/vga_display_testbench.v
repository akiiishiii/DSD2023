// vga_display_testbench.v

`timescale 1ns / 1ps

// VGA��ʾ����ģ��
module vga_display_testbench();
    reg clk_25MHz = 1'b0; // ʱ���ź�
    reg rst_ = 1'b0; // ��λ�ź�
    wire h_sync; // ˮƽͬ���ź�
    wire v_sync; // ��ֱͬ���ź�
    wire [3:0] r, g, b; // ��������

    vga_display vga_display_inst( // ʵ����VGA��ʾģ��
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
