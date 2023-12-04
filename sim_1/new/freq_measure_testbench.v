// freq_measure_testbench.v

`timescale 1ns / 1ps

// Ƶ�ʲ�������ģ��
module freq_measure_testbench();
    reg clk_100kHz; // 100kHzʱ���ź�
    reg rst_; // ��λ�ź�
    reg gate; // �ſ��ź�
    wire [7:0] wave; // �����
    wire [31:0] freq_real; // ʵ��Ƶ��
    reg [1:0] sw; // ���뿪��
    reg [7:0] freq_ctrl; // Ƶ�ʿ�����

    // �����ò���
    wave_generator wave_generator(
        .clk_100kHz(clk_100kHz),
        .rst_(rst_),
        .sw(sw),
        .freq_ctrl(freq_ctrl),
        .wave_out(wave)
    );

    // Ƶ�ʲ���ģ��
    freq_measure freq_measure(
        .clk_100kHz(clk_100kHz),
        .rst_(rst_),
        .gate(gate),
        .wave(wave),
        .freq_real(freq_real)
    );

    initial begin
        clk_100kHz = 1'b0;
        forever #5 clk_100kHz = ~clk_100kHz;
    end

    initial begin
        gate = 1'b0;
        forever #500000 gate = ~gate;
    end

    initial begin
        rst_ = 1'b0;
        sw = 2'b00;
        freq_ctrl = 8'd1;
        #10 rst_ = 1'b1;
        #2000000 freq_ctrl = 8'd10;
        #2000000 freq_ctrl = 8'd50;
        #2000000 $finish;
    end

endmodule
