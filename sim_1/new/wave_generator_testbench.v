// wave_generator_testbench.v

`timescale 1ns / 1ps

// ������������ģ��
module wave_generator_testbench();

        reg clk = 0; // ʱ���ź�
        reg rst_ = 0; // ��λ�ź�
        reg [1:0] sw = 2'b00; // ���뿪��
        reg [7:0] freq_ctrl = 8'd1; // Ƶ�ʿ�����
        wire [7:0] wave_out; // �����

        wave_generator wave_gen(
            .clk_100kHz(clk),
            .rst_(rst_),
            .sw(sw),
            .freq_ctrl(freq_ctrl),
            .wave_out(wave_out)
        );

        initial begin
            #10 rst_ = 1; // 10ns��λ�ź���1
            forever
                //#20000 freq_ctrl = freq_ctrl + 1; // 20us��Ƶ�ʿ����ּ�1
                #20000 sw = sw + 1; // 20us���뿪�ؼ�1
        end

        always begin
           // ʱ������Ϊ100kHz
              #5 clk = ~clk; // 5ns��ʱ���ź�ȡ��
        end

endmodule
