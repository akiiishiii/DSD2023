// hysteresis_comparator_testbench.v

`timescale 1ns / 1ps

// �ͻرȽ�������ģ��
module hysteresis_comparator_testbench();
    reg clk_100kHz; // 100kHzʱ���ź�
    reg rst_; // ��λ�ź�
    wire [7:0] wave; // ��������ֲ���
    wire square_wave; // ����ķ���
    reg [1:0] sw; // ���뿪��

    // �ͻرȽ���
    hysteresis_comparator hysteresis_comparator(
        .rst_(rst_),
        .wave(wave),
        .square_wave(square_wave)
    );

    // �����ò���
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
