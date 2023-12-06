// implementation_module.v

`timescale 1ns / 1ps

// ʵ��ģ��
module implementation_module(
    input clk,
    input rst_,
    input [1:0] sw,
    input [1:0] h_pb,
    input [1:0] v_pb,
    input c_pb,
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
    output [7:0] dac_data,
    output h_sync,
    output v_sync,
    output [3:0] vga_r,
    output [3:0] vga_g,
    output [3:0] vga_b
    );

    wire clk_100kHz; // 100kHzʱ���ź�
    wire clk_1kHz; // 1kHzʱ���ź�
    wire gate_1Hz; // �ſ��ź�
    wire vga_clk; // VGAʱ���ź�

    wire [7:0] wave; // �����
    reg [3:0] num0, num1, num2, num3, num4, num5, num6, num7; // ������� 0Ϊ��λ 7Ϊ��λ
    reg [3:0] en1, en2; // ����ʹ�����
    reg [3:0] dp1, dp2; // С�������

    integer mode = 0; // ģʽѡ��
    wire [1:0] dh_pb; // ����������Ұ�ť
    wire [1:0] dv_pb; // ����������°�ť
    wire dc_pb; // ������Ĺ�һ��ť
    reg [1:0] last_h_pb_state; // ��һʱ�����ڵ����Ұ�ť״̬
    reg [1:0] last_v_pb_state; // ��һʱ�����ڵ����°�ť״̬
    reg last_c_pb_state; // ��һʱ�����ڵĹ�һ��ť״̬

    reg [7:0] freq_ctrl = 8'd1; // Ƶ�ʿ�����
    wire [3:0] cnum0, cnum1, cnum2, cnum3, cnum4, cnum5, cnum6, cnum7; // Ƶ�ʿ��������� 0Ϊ��λ 7Ϊ��λ
    wire [7:0] cen; // Ƶ�ʿ���������ʹ��

    wire [31:0] freq_theory; // ����Ƶ��
    wire [3:0] fnum0, fnum1, fnum2, fnum3, fnum4, fnum5, fnum6, fnum7; // ����Ƶ������ 0Ϊ��λ 7Ϊ��λ
    wire [7:0] fen; // ����Ƶ������ʹ��

    wire [31:0] freq_real; // ʵ��Ƶ��
    wire [3:0] rnum0, rnum1, rnum2, rnum3, rnum4, rnum5, rnum6, rnum7; // ʵ��Ƶ������ 0Ϊ��λ 7Ϊ��λ
    wire [7:0] ren; // ʵ��Ƶ������ʹ��

    wire [9:0] vga_h_pos, vga_v_pos; // VGA����λ��
    wire [11:0] rgb_data; // VGA��������

    // ���Ұ�ť����ģʽѡ��
    always @(posedge clk_100kHz or negedge rst_ ) begin
        if (!rst_) begin
            mode <= 0; // ��λʱ��ģʽѡ��Ϊ0
            last_h_pb_state <= 2'b0; // ��λʱ����һ�ε����Ұ�ť״̬Ϊ0
        end else begin
            if (dh_pb[1] == 1'b1 && last_h_pb_state[1] == 1'b0 && mode < 3) begin
                mode <= mode + 1;
            end else if (dh_pb[0] == 1'b1 && last_h_pb_state[0] == 1'b0 && mode > 0) begin
                mode <= mode - 1;
            end else begin
                mode <= mode;
            end
            last_h_pb_state <= dh_pb; // ������һ�ε����Ұ�ť״̬
        end
    end

    // ���°�ť����Ƶ�ʿ�����
    always @(posedge clk_100kHz or negedge rst_ ) begin
        if (!rst_) begin
            freq_ctrl <= 8'd1; // ��λʱ��Ƶ�ʿ�����Ϊ1
            last_v_pb_state <= 2'b0; // ��λʱ����һ�ε����°�ť״̬Ϊ0
            last_c_pb_state <= 1'b0; // ��λʱ����һ�εĹ�һ��ť״̬Ϊ0
        end else begin
            if (dc_pb == 1'b1 && last_c_pb_state == 1'b0) begin
                freq_ctrl <= 8'd1;
            end else if (dv_pb[0] == 1'b1 && last_v_pb_state[0] == 1'b0) begin
                if (freq_ctrl == 8'd128) begin
                    freq_ctrl <= 8'd1;
                end else begin
                    freq_ctrl <= freq_ctrl + 8'd1;
                end
            end else if (dv_pb[1] == 1'b1 && last_v_pb_state[1] == 1'b0) begin
                if (freq_ctrl == 8'd1) begin
                    freq_ctrl <= 8'd128;
                end else begin
                    freq_ctrl <= freq_ctrl - 8'd1;
                end
            end
            last_v_pb_state <= dv_pb; // ������һ�ε����°�ť״̬
            last_c_pb_state <= dc_pb; // ������һ�εĹ�һ��ť״̬
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

    divider div_vga(
        .clk_in(clk),
        .rst_(rst_),
        .div_factor(4),
        .clk_out(vga_clk)
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

    debounce h_pb0_debounce(
        .clk_100kHz(clk_100kHz),
        .rst_(rst_),
        .key_in(h_pb[0]),
        .key_out(dh_pb[0])
    );

    debounce h_pb1_debounce(
        .clk_100kHz(clk_100kHz),
        .rst_(rst_),
        .key_in(h_pb[1]),
        .key_out(dh_pb[1])
    );

    debounce v_pb0_debounce(
        .clk_100kHz(clk_100kHz),
        .rst_(rst_),
        .key_in(v_pb[0]),
        .key_out(dv_pb[0])
    );

    debounce v_pb1_debounce(
        .clk_100kHz(clk_100kHz),
        .rst_(rst_),
        .key_in(v_pb[1]),
        .key_out(dv_pb[1])
    );

    debounce c_pb_debounce(
        .clk_100kHz(clk_100kHz),
        .rst_(rst_),
        .key_in(c_pb),
        .key_out(dc_pb)
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

    vga_display vga(
        .clk_25MHz(vga_clk),
        .rst_(rst_),
        .rgb_in(rgb_data),
        .h_pos(vga_h_pos),
        .v_pos(vga_v_pos),
        .h_sync(h_sync),
        .v_sync(v_sync),
        .r(vga_r),
        .g(vga_g),
        .b(vga_b)
    );

    vga_control vga_ctrl(
        .clk_25MHz(vga_clk),
        .rst_(rst_),
        .h_pos(vga_h_pos),
        .v_pos(vga_v_pos),
        .sw(sw),
        .ctrl_num0(cnum0),
        .ctrl_num1(cnum1),
        .ctrl_num2(cnum2),
        .cen(cen[7:5]),
        .freq_t_num0(fnum0),
        .freq_t_num1(fnum1),
        .freq_t_num2(fnum2),
        .freq_t_num3(fnum3),
        .freq_t_num4(fnum4),
        .ten(fen[7:3]),
        .freq_r_num0(rnum0),
        .freq_r_num1(rnum1),
        .freq_r_num2(rnum2),
        .freq_r_num3(rnum3),
        .freq_r_num4(rnum4),
        .ren(ren[7:3]),
        .rgb_out(rgb_data)
    );

endmodule
