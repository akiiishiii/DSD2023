// hysteresis_comparator.v

`timescale 1ns / 1ps

// �ͻرȽ���
module hysteresis_comparator(
    input rst_, // ��λ�ź�
    input [7:0] wave, // ��������ֲ���
    output square_wave // ����ķ���
    );

    reg high_threshold_reached; // ����ֵ�ﵽ��־

    always @(*) begin
        if (!rst_) begin
            high_threshold_reached <= 0;
        end else if (wave > 8'd128) begin
            high_threshold_reached <= 1;
        end else begin
            high_threshold_reached <= 0;
        end
    end

    assign square_wave = high_threshold_reached;

endmodule
