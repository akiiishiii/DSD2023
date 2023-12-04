// implementation_module.v

`timescale 1ns / 1ps

// ʵ��ģ��
module implementation_module(
    input clk,
    input rst_,
    input [1:0] sw,
    input [1:0] h_pb,
    input [1:0] v_pb,
    output [3:0] an1,
    output [7:0] seg1,
    output [3:0] an2,
    output [7:0] seg2,
    output reg [15:0] led,
    output ile,
    output cs_,
    output wr1_,
    output wr2_,
    output xfer_,
    output [7:0] dac_data
    );

    wire clk_100kHz; // 100kHzʱ���ź�
    wire clk_1kHz; // 1kHzʱ���ź�
    wire gate_1Hz; // �ſ��ź�

    wire [7:0] wave; // �����
    reg [3:0] num0, num1, num2, num3, num4, num5, num6, num7; // ������� 0Ϊ��λ 7Ϊ��λ
    reg [3:0] en1, en2; // ����ʹ�����
    reg [3:0] dp1, dp2; // С�������

    integer mode = 0; // ģʽѡ��
    reg [1:0] last_h_pb_state; // ��һ�ε����Ұ�ť״̬
    reg [1:0] last_v_pb_state; // ��һ�ε����°�ť״̬

    reg [8:0] freq_ctrl = 8'd1; // Ƶ�ʿ�����
    wire [3:0] cnum0, cnum1, cnum2, cnum3, cnum4, cnum5, cnum6, cnum7; // Ƶ�ʿ��������� 0Ϊ��λ 7Ϊ��λ
    wire [7:0] cen; // Ƶ�ʿ���������ʹ��

    wire [31:0] freq_theory; // ����Ƶ��
    wire [3:0] fnum0, fnum1, fnum2, fnum3, fnum4, fnum5, fnum6, fnum7; // ����Ƶ������ 0Ϊ��λ 7Ϊ��λ
    wire [7:0] fen; // ����Ƶ������ʹ��

    wire [31:0] freq_real; // ʵ��Ƶ��
    wire [3:0] rnum0, rnum1, rnum2, rnum3, rnum4, rnum5, rnum6, rnum7; // ʵ��Ƶ������ 0Ϊ��λ 7Ϊ��λ
    wire [7:0] ren; // ʵ��Ƶ������ʹ��

    // ���Ұ�ť����ģʽѡ��
    always @(posedge clk_100kHz or negedge rst_ ) begin
        if (!rst_) begin
            mode <= 0; // ��λʱ��ģʽѡ��Ϊ0
            last_h_pb_state <= 2'b0; // ��λʱ����һ�ε����Ұ�ť״̬Ϊ0
        end else begin
            if (h_pb[1] == 1'b1 && last_h_pb_state[1] == 1'b0 && mode < 3) begin
                mode <= mode + 1;
            end else if (h_pb[0] == 1'b1 && last_h_pb_state[0] == 1'b0 && mode > 0) begin
                mode <= mode - 1;
            end else begin
                mode <= mode;
            end
            last_h_pb_state <= h_pb; // ������һ�ε����Ұ�ť״̬
        end
    end

    // ���°�ť����Ƶ�ʿ�����
    always @(posedge clk_100kHz or negedge rst_ ) begin
        if (!rst_) begin
            freq_ctrl <= 8'd1; // ��λʱ��Ƶ�ʿ�����Ϊ1
            last_v_pb_state <= 2'b0; // ��λʱ����һ�ε����°�ť״̬Ϊ0
        end else begin
            if (v_pb[0] == 1'b1 && last_v_pb_state[0] == 1'b0) begin
                if (freq_ctrl == 8'd128) begin
                    freq_ctrl <= 8'd1;
                end else begin
                    freq_ctrl <= freq_ctrl + 8'd1;
                end
            end else if (v_pb[1] == 1'b1 && last_v_pb_state[1] == 1'b0) begin
                if (freq_ctrl == 8'd1) begin
                    freq_ctrl <= 8'd128;
                end else begin
                    freq_ctrl <= freq_ctrl - 8'd1;
                end
            end
            last_v_pb_state <= v_pb; // ������һ�ε����°�ť״̬
        end
    end

    // mode�����������ʾ���ݣ�0Ϊѧ����ʾ��1ΪƵ�ʿ�������ʾ��2Ϊ����Ƶ����ʾ��3Ϊʵ��Ƶ����ʾ
    always @(posedge clk_100kHz or negedge rst_ ) begin
        if (!rst_) begin
            num0 <= 4'd0;
            num1 <= 4'd0;
            num2 <= 4'd0;
            num3 <= 4'd0;
            num4 <= 4'd0;
            num5 <= 4'd0;
            num6 <= 4'd0;
            num7 <= 4'd0;
            en1 <= 4'b0000;
            en2 <= 4'b0000;
            dp1 <= 4'b0000;
            dp2 <= 4'b0000;
            led <= 16'd0;
        end else begin
            led <= 16'd0;
            case (mode)
                'd0: begin
                    num0 <= 4'h3;
                    num1 <= 4'h2;
                    num2 <= 4'h1;
                    num3 <= 4'h0;
                    num4 <= 4'h1;
                    num5 <= 4'h2;
                    num6 <= 4'h9; // 9����g
                    num7 <= 4'hd;
                    en1 <= 4'b1111;
                    en2 <= 4'b1111;
                    dp1 <= 4'b1000;
                    dp2 <= 4'b0000;
                end
                'd1: begin
                    num0 <= cnum0;
                    num1 <= cnum1;
                    num2 <= cnum2;
                    num3 <= cnum3;
                    num4 <= cnum4;
                    num5 <= cnum5;
                    num6 <= cnum6;
                    num7 <= cnum7;
                    en1 <= cen[3:0];
                    en2 <= cen[7:4];
                    dp1 <= 4'b0000;
                    dp2 <= 4'b0000;
                end
                'd2: begin
                    num0 <= fnum0;
                    num1 <= fnum1;
                    num2 <= fnum2;
                    num3 <= fnum3;
                    num4 <= fnum4;
                    num5 <= fnum5;
                    num6 <= fnum6;
                    num7 <= fnum7;
                    en1 <= fen[3:0];
                    en2 <= fen[7:4];
                    dp1 <= 4'b0000;
                    dp2 <= 4'b0000;
                end
                'd3: begin
                    num0 <= rnum0;
                    num1 <= rnum1;
                    num2 <= rnum2;
                    num3 <= rnum3;
                    num4 <= rnum4;
                    num5 <= rnum5;
                    num6 <= rnum6;
                    num7 <= rnum7;
                    en1 <= ren[3:0];
                    en2 <= ren[7:4];
                    dp1 <= 4'b0000;
                    dp2 <= 4'b0000;
                    led[15] <= gate_1Hz;
                end
                default : begin
                    num0 <= 4'd0;
                    num1 <= 4'd0;
                    num2 <= 4'd0;
                    num3 <= 4'd0;
                    num4 <= 4'd0;
                    num5 <= 4'd0;
                    num6 <= 4'd0;
                    num7 <= 4'd0;
                    en1 <= 4'b0000;
                    en2 <= 4'b0000;
                    dp1 <= 4'b0000;
                    dp2 <= 4'b0000;
                end
            endcase
            led[mode] <= 1'b1;
        end
    end

    divider div_100kHz(
        .clk_in(clk),
        .rst_(rst_),
        .div_factor(1000),
        .clk_out(clk_100kHz)
    );

    divider div_1kHz(
        .clk_in(clk),
        .rst_(rst_),
        .div_factor(100000),
        .clk_out(clk_1kHz)
    );

    divider div_1Hz(
        .clk_in(clk),
        .rst_(rst_),
        .div_factor(100000000),
        .clk_out(gate_1Hz)
    );

    segment_display segmentl(
        .clk_1kHz(clk_1kHz),
        .rst_(rst_),
        .en(en1),
        .bin0(num7),
        .bin1(num6),
        .bin2(num5),
        .bin3(num4),
        .dpin(dp1),
        .an(an1),
        .seg(seg1)
    );

    segment_display segmentr(
        .clk_1kHz(clk_1kHz),
        .rst_(rst_),
        .en(en2),
        .bin0(num3),
        .bin1(num2),
        .bin2(num1),
        .bin3(num0),
        .dpin(dp2),
        .an(an2),
        .seg(seg2)
    );

    wave_generator wave_gen(
        .clk_100kHz(clk_100kHz),
        .rst_(rst_),
        .sw(sw),
        .freq_ctrl(freq_ctrl),
        .wave_out(wave)
    );

    DAC0832_driver dac(
        .clk(clk_100kHz),
        .rst_(rst_),
        .data_in(wave),
        .ile(ile),
        .cs_(cs_),
        .wr1_(wr1_),
        .wr2_(wr2_),
        .xfer_(xfer_),
        .data_out(dac_data)
    );

    freq_calc freq_calc(
        .clk_100kHz(clk_100kHz),
        .rst_(rst_),
        .freq_ctrl(freq_ctrl),
        .freq_theory(freq_theory)
    );

    freq_measure freq_measure(
        .clk_100kHz(clk_100kHz),
        .rst_(rst_),
        .gate(gate_1Hz),
        .wave(wave),
        .freq_real(freq_real)
    );

    bin_to_bcd freq_ctrl_bcd(
        .clk_100kHz(clk_100kHz),
        .rst_(rst_),
        .bin(freq_ctrl),
        .bcd0(cnum0),
        .bcd1(cnum1),
        .bcd2(cnum2),
        .bcd3(cnum3),
        .bcd4(cnum4),
        .bcd5(cnum5),
        .bcd6(cnum6),
        .bcd7(cnum7),
        .en(cen)
    );

    bin_to_bcd freq_calc_bcd(
        .clk_100kHz(clk_100kHz),
        .rst_(rst_),
        .bin(freq_theory),
        .bcd0(fnum0),
        .bcd1(fnum1),
        .bcd2(fnum2),
        .bcd3(fnum3),
        .bcd4(fnum4),
        .bcd5(fnum5),
        .bcd6(fnum6),
        .bcd7(fnum7),
        .en(fen)
    );

    bin_to_bcd freq_measure_bcd(
        .clk_100kHz(clk_100kHz),
        .rst_(rst_),
        .bin(freq_real),
        .bcd0(rnum0),
        .bcd1(rnum1),
        .bcd2(rnum2),
        .bcd3(rnum3),
        .bcd4(rnum4),
        .bcd5(rnum5),
        .bcd6(rnum6),
        .bcd7(rnum7),
        .en(ren)
    );

endmodule
