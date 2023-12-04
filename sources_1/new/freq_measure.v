// freq_measure.v

`timescale 1ns / 1ps

// Ƶ�ʲ���ģ��
module freq_measure(
    input clk_100kHz,
    input rst_,
    input gate,
    input [7:0] wave,
    output reg [31:0] freq_real
    );

    reg [31:0] counter; // ������
    wire square_wave; // �����ź�ת��Ϊ����
    reg prev_square_wave; // ��һ�εķ���

    always @(posedge clk_100kHz or negedge rst_ ) begin
        if (!rst_) begin
            counter <= 32'd0;
            freq_real <= 32'd0;
            prev_square_wave <= 0;
        end else begin
            if (gate) begin
                if (square_wave && !prev_square_wave) begin
                    counter <= counter + 1;
                end
            end else begin
                if (counter != 32'd0) begin
                    freq_real = counter << 1; // ����Ƶ�ʣ�����ʱ��Ϊ0.5s)
                    counter = 32'd0;
                end
            end
            prev_square_wave <= square_wave;
        end
    end

    // �ͻرȽ���
    hysteresis_comparator hysteresis_comparator(
        .rst_(rst_),
        .wave(wave),
        .square_wave(square_wave)
    );

endmodule
