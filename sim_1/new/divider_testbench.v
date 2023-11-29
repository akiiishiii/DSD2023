// divider_testbench.v

`timescale 1ns / 1ps

// �ɵ���Ƶ���ӵķ�Ƶ������ģ��
module divider_testbench();
    reg clk_100MHz; // 100MHz����ʱ��
    wire clk_100kHz, clk_1kHz; // 100kHz��1kHz���ʱ��
    reg rst_; // ��λ�ź�

    // ʵ����dividerģ��
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

    // ʱ��������
    always begin
        #5 clk_100MHz = ~clk_100MHz; // 10ns���ڵ�ʱ�ӣ���100MHz
    end

    // ���Թ���
    initial begin
        rst_ = 0; // ��ʼ����λ�ź�
        clk_100MHz = 0; // ��ʼ��ʱ��
        #500 rst_ = 1; // 500ns��λ�źű�Ϊ1
        #1000000000; // 1s���������
        $finish; // ��������
    end

endmodule
