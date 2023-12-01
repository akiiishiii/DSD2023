// freq_calc_testbench.v

`timescale 1ns / 1ps

// Ƶ�ʼ���ģ�����
module freq_calc_testbench();
    reg [7:0] freq_ctrl = 1; // Ƶ�ʿ�����
    reg rst_ = 0; // ��λ�ź�
    reg clk_100kHz = 0; // 100kHzʱ���ź�
    wire [31:0] freq_theory; // ����Ƶ��

    initial begin
        #50 rst_ = 1; // 50ns��λ�źű�Ϊ1
        forever begin
            #1000 freq_ctrl = freq_ctrl + 1; // ÿ1000ns����1
            // �����ִ�1������255��ֹͣ
            if (freq_ctrl == 8'd255) begin
                $finish;
            end
        end
    end

    always begin
        #5 clk_100kHz = ~clk_100kHz; // 5ns��ʱ���ź�ȡ��
    end

    freq_calc freq_calc_1(
        .clk_100kHz(clk_100kHz),
        .rst_(rst_),
        .freq_ctrl(freq_ctrl),
        .freq_theory(freq_theory)
    );

endmodule
