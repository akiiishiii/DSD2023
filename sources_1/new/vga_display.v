// vga_display.v

`timescale 1ns / 1ps

`define H_SYNC_CYCLES 96
`define H_BACK_PORCH 48
`define H_ACTIVE 640
`define H_FRONT_PORCH 16
`define H_TOTAL_CYCLES (`H_SYNC_CYCLES + `H_BACK_PORCH + `H_ACTIVE + `H_FRONT_PORCH)

`define V_SYNC_CYCLES 2
`define V_BACK_PORCH 33
`define V_ACTIVE 480
`define V_FRONT_PORCH 10
`define V_TOTAL_CYCLES (`V_SYNC_CYCLES + `V_BACK_PORCH + `V_ACTIVE + `V_FRONT_PORCH)

// VGA显示模块 640x480 @ 60Hz
module vga_display(
    input clk_25MHz, // 时钟信号
    input rst_, // 复位信号
    input [11:0] rgb_in, // RGB输入
    output [9:0] h_pos, // 水平和垂直位置
    output [9:0] v_pos,
    output h_sync, // 水平同步信号
    output v_sync, // 垂直同步信号
    output [3:0] r, // 像素数据
    output [3:0] g,
    output [3:0] b
    );

    reg [9:0] h_cnt = 10'd0; // 水平和垂直计数器
    reg [9:0] v_cnt = 10'd0;
    wire pixel_active; // 像素活动标志

    assign h_sync = (h_cnt < `H_SYNC_CYCLES) ? 1'b0 : 1'b1;
    assign v_sync = (v_cnt < `V_SYNC_CYCLES) ? 1'b0 : 1'b1;

    assign h_pos = h_cnt - `H_SYNC_CYCLES - `H_BACK_PORCH;
    assign v_pos = v_cnt - `V_SYNC_CYCLES - `V_BACK_PORCH;

    always @(posedge clk_25MHz or negedge rst_ ) begin
        if (!rst_) begin
            h_cnt <= 10'd0;
            v_cnt <= 10'd0;
        end else if (h_cnt == `H_TOTAL_CYCLES - 1) begin
            h_cnt <= 0;
            if (v_cnt == `V_TOTAL_CYCLES - 1) begin
                v_cnt <= 0;
            end else begin
                v_cnt <= v_cnt + 1;
            end
        end else begin
            h_cnt <= h_cnt + 1;
        end
    end

    assign pixel_active = (h_cnt >= `H_SYNC_CYCLES + `H_BACK_PORCH) &&
                          (h_cnt < `H_SYNC_CYCLES + `H_BACK_PORCH + `H_ACTIVE) &&
                          (v_cnt >= `V_SYNC_CYCLES + `V_BACK_PORCH) &&
                          (v_cnt < `V_SYNC_CYCLES + `V_BACK_PORCH + `V_ACTIVE);

    assign valid_area = (h_pos > 100 && h_pos < 540 && v_pos > 40 && v_pos < 440);

    assign r = pixel_active ? rgb_in[11:8] : 4'b0;
    assign g = pixel_active ? rgb_in[7:4] : 4'b0;
    assign b = pixel_active ? rgb_in[3:0] : 4'b0;

endmodule
