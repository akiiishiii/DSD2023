// segment_display.v

`timescale 1ns / 1ps

// �߶���ʾ��ģ��
module segment_display(
    input clk_1kHz, // ����ʱ��
    input rst_, // ��λ�ź�
    input [3:0] en, // �����ź�
    input [3:0] bin0, // ����������0
    input [3:0] bin1, // ����������1
    input [3:0] bin2, // ����������2
    input [3:0] bin3, // ����������3
    input [3:0] dpin, // С��������
    output reg [7:0] seg, // �߶���ʾ�����
    output reg [3:0] an // Ƭѡ���
    );

    reg [3:0] digout; // �������
    reg dp; // С����
    reg [1:0] counter; // ������

    always @(posedge clk_1kHz or negedge rst_ ) begin
        if (!rst_) begin
            counter <= 0; // ��λ������
            an <= 4'b0000; // ��λƬѡ���
        end else begin
            counter <= counter + 1; // ���Ӽ�������ֵ
            an <= 4'b0000; // Ĭ�ϲ����
            case (counter)
                2'b00: begin
                    digout = bin0; // �������������0
                    dp = dpin[0]; // ���С��������0
                end
                2'b01: begin
                    digout = bin1; // �������������1
                    dp = dpin[1]; // ���С��������1
                end
                2'b10: begin
                    digout = bin2; // �������������2
                    dp = dpin[2]; // ���С��������2
                end
                2'b11: begin
                    digout = bin3; // �������������3
                    dp = dpin[3]; // ���С��������3
                end
                default: begin
                    digout = 4'b0000; // Ĭ�����0
                    dp = 1'b0; // Ĭ��С�������0
                end
            endcase
            if(en[counter] == 1)
                an[counter] <= 1; // ��������ź�Ϊ1�����
        end
    end

    // �߶���ʾ������߼�
    always @(*) begin
        case(digout)
            // ��Ӧÿ�����ֵ��߶���ʾ������
            4'h0: seg[6:0] = 7'b1111110;
            4'h1: seg[6:0] = 7'b0110000;
            4'h2: seg[6:0] = 7'b1101101;
            4'h3: seg[6:0] = 7'b1111001;
            4'h4: seg[6:0] = 7'b0110011;
            4'h5: seg[6:0] = 7'b1011011;
            4'h6: seg[6:0] = 7'b1011111;
            4'h7: seg[6:0] = 7'b1110000;
            4'h8: seg[6:0] = 7'b1111111;
            4'h9: seg[6:0] = 7'b1111011;
            4'ha: seg[6:0] = 7'b1110111;
            4'hb: seg[6:0] = 7'b0011111;
            4'hc: seg[6:0] = 7'b1001110;
            4'hd: seg[6:0] = 7'b0111101;
            4'he: seg[6:0] = 7'b1001111;
            4'hf: seg[6:0] = 7'b1000111;
            default: seg[6:0] = 7'b0000000; // Ĭ�����0
        endcase
        seg[7] = dp; // ���С����
    end

endmodule
