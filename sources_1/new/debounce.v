// debounce.v

`timescale 1ns / 1ps

// ��������ģ��
module debounce (
    input clk_100kHz,
    input rst_,
    input key_in,
    output key_out
    );

    parameter DEBOUNCE_TIME = 2000; // ����ʱ����Ϊ2000��ʱ������
    reg [15:0] counter = 0; // 16λ������
    reg key_state = 0; // ����״̬

    always @(posedge clk_100kHz or negedge rst_ ) begin
        if (!rst_) begin
            counter <= 0;
            key_state <= 0;
        end else if (key_in != key_state) begin
            counter <= counter + 1;
            if (counter == DEBOUNCE_TIME) begin
                key_state <= key_in;
                counter <= 0;
            end
        end else begin
            counter <= 0;
        end
    end

    assign key_out = key_state;

endmodule
