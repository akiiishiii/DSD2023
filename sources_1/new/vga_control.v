// vga_control.v

`timescale 1ns / 1ps

`define WHITE 12'hFFF
`define BLACK 12'h000
`define RED 12'hF00
`define GREEN 12'h0F0
`define BLUE 12'h00F
`define YELLOW 12'hFF0
`define CYAN 12'h0FF
`define MAGENTA 12'hF0F
`define GRAY 12'h888
`define BROWN 12'hB22
`define ORANGE 12'hFA0
`define PURPLE 12'h808
`define PINK 12'hF88
`define LIGHT_GRAY 12'hCCC
`define LIGHT_GREEN 12'h8F8
`define LIGHT_BLUE 12'h88F
`define LIGHT_YELLOW 12'hFF8
`define LIGHT_CYAN 12'h8FF
`define LIGHT_MAGENTA 12'hF8F
`define DARK_GRAY 12'h444
`define DARK_GREEN 12'h080
`define DARK_BLUE 12'h008
`define DARK_YELLOW 12'h880
`define DARK_CYAN 12'h088
`define DARK_MAGENTA 12'h808
`define DARK_RED 12'h800

`define OUTER_TEXT_COLOR `WHITE
`define INNER_TEXT_COLOR `BLACK
`define MARGIN_COLOR `BLACK
`define BACKGROUND_COLOR `LIGHT_GRAY

`define NAME_H_START 10
`define NAME_H_END 162
`define NAME_V_START 10
`define NAME_V_END 26

`define TITLE_H_START 256
`define TITLE_H_END 384
`define TITLE_V_START 60
`define TITLE_V_END 76

`define BORDER_H_START 100
`define BORDER_H_END 540
`define BORDER_V_START 100
`define BORDER_V_END 380

`define WAVE_FORM_H_START 240
`define WAVE_FORM_H_END 320
`define WAVE_FORM_V_START 184
`define WAVE_FORM_V_END 200

`define FREQ_CTRL_H_START 224
`define FREQ_CTRL_H_END 320
`define FREQ_CTRL_V_START 216
`define FREQ_CTRL_V_END 232

`define FREQ_THEORY_H_START 224
`define FREQ_THEORY_H_END 320
`define FREQ_THEORY_V_START 248
`define FREQ_THEORY_V_END 264

`define FREQ_REAL_H_START 224
`define FREQ_REAL_H_END 320
`define FREQ_REAL_V_START 280
`define FREQ_REAL_V_END 296

`define WAVE_TYPE_H_START 320
`define WAVE_TYPE_H_END 368
`define WAVE_TYPE_V_START 184
`define WAVE_TYPE_V_END 200

`define HZ_MARK_1_H_START 360
`define HZ_MARK_1_H_END 376
`define HZ_MARK_1_V_START 248
`define HZ_MARK_1_V_END 264

`define HZ_MARK_2_H_START 360
`define HZ_MARK_2_H_END 376
`define HZ_MARK_2_V_START 280
`define HZ_MARK_2_V_END 296

`define FREQ_C_NUM_H_START 320
`define FREQ_C_NUM_H_END 344
`define FREQ_C_NUM_V_START 216
`define FREQ_C_NUM_V_END 232

`define FREQ_T_NUM_H_START 320
`define FREQ_T_NUM_H_END 360
`define FREQ_T_NUM_V_START 248
`define FREQ_T_NUM_V_END 264

`define FREQ_R_NUM_H_START 320
`define FREQ_R_NUM_H_END 360
`define FREQ_R_NUM_V_START 280
`define FREQ_R_NUM_V_END 296

// VGA控制模块 640x480 @ 60Hz
module vga_control(
    input clk_25MHz, // 时钟信号
    input rst_, // 复位信号
    input [9:0] h_pos, // 水平和垂直位置
    input [9:0] v_pos,
    input [1:0] sw, // 拨码开关
    input [3:0] ctrl_num0, // 控制字
    input [3:0] ctrl_num1,
    input [3:0] ctrl_num2,
    input [2:0] cen, // 数显使能
    input [3:0] freq_t_num0, // 理论频率
    input [3:0] freq_t_num1,
    input [3:0] freq_t_num2,
    input [3:0] freq_t_num3,
    input [3:0] freq_t_num4,
    input [4:0] ten, // 数显使能
    input [3:0] freq_r_num0, // 实际频率
    input [3:0] freq_r_num1,
    input [3:0] freq_r_num2,
    input [3:0] freq_r_num3,
    input [3:0] freq_r_num4,
    input [4:0] ren, // 数显使能
    output reg [11:0] rgb_out // RGB输出
    );

    parameter NAME0  = 152'h08000840010000000000000000000000000000;
    parameter NAME1  = 152'h08001C40010000000000000000000000000000;
    parameter NAME2  = 152'h0FFEF040010000000000000000000000000000;
    parameter NAME3  = 152'h100810407FFC003C3C0C0C3C303C3C3C0C3C3C;
    parameter NAME4  = 152'h1008114403800066661C1C66306666661C6666;
    parameter NAME5  = 152'h33C8FD4405400066667C7C6E3666666E7C6666;
    parameter NAME6  = 152'h3248114809200066060C0C6E3606066E0C0606;
    parameter NAME7  = 152'h52483250111000660C0C0C66361C1C660C0C1C;
    parameter NAME8  = 152'h924838402108003E180C0C76660606760C1806;
    parameter NAME9  = 152'h124854A0C106000C300C0C767F6666760C3066;
    parameter NAME10 = 152'h13C854A001000018600C0C66066666660C6066;
    parameter NAME11 = 152'h12489090000000387E0C0C3C063C3C3C0C7E3C;
    parameter NAME12 = 152'h10081110248800000000000000000000000000;
    parameter NAME13 = 152'h10081108224400000000000000000000000000;
    parameter NAME14 = 152'h10281204424400000000000000000000000000;
    parameter NAME15 = 152'h10101402800400000000000000000000000000;

    parameter TITLE0  = 128'h0820020000F810401040010000000040;
    parameter TITLE1  = 128'h492001003F0010201020010021F02040;
    parameter TITLE2  = 128'h2A207FFE0400202023FE028011101040;
    parameter TITLE3  = 128'h083E4002082023FE2202044011101040;
    parameter TITLE4  = 128'hFF448004104048404800082001100040;
    parameter TITLE5  = 128'h2A441FE03F80F888F9FC3018020E0040;
    parameter TITLE6  = 128'h49440040010011041000CFE6F400F7FE;
    parameter TITLE7  = 128'h88A40080061023FE2000000013F81040;
    parameter TITLE8  = 128'h102801001808409243FE000011081040;
    parameter TITLE9  = 128'hFE28FFFE7FFCF890F8201FF011101040;
    parameter TITLE10 = 128'h22100100010440904128101010901040;
    parameter TITLE11 = 128'h42100100092000900124101014A01040;
    parameter TITLE12 = 128'h64280100111019121A22101018401440;
    parameter TITLE13 = 128'h182801002108E112E422101010A01840;
    parameter TITLE14 = 128'h344405004504420E40A01FF003181040;
    parameter TITLE15 = 128'hC282020002000400004010100C060040;

    parameter WAVE0  = 80'h20400100002000000000;
    parameter WAVE1  = 80'h20A0010020207F840000;
    parameter WAVE2  = 80'h21102108102012040000;
    parameter WAVE3  = 80'hFA08210813FE12080000;
    parameter WAVE4  = 80'h25F62108822212100000;
    parameter WAVE5  = 80'h40002108422412220000;
    parameter WAVE6  = 80'h53C43FF84A2012020000;
    parameter WAVE7  = 80'h925401080BFCFFC40000;
    parameter WAVE8  = 80'hFA540100128412080000;
    parameter WAVE9  = 80'h13D40100128812103000;
    parameter WAVE10 = 80'h1A544104E24812223000;
    parameter WAVE11 = 80'hF2544104225012020000;
    parameter WAVE12 = 80'h53D44104222022043000;
    parameter WAVE13 = 80'h12444104245022083000;
    parameter WAVE14 = 80'h12547FFC248842100000;
    parameter WAVE15 = 80'h12C80004090682600000;

    parameter CTRL0  = 96'h100002001040040402000000;
    parameter CTRL1  = 96'h11FE01001020240401000000;
    parameter CTRL2  = 96'h50207FFC102024047FFE0000;
    parameter CTRL3  = 96'h5C40020013FE3FA440020000;
    parameter CTRL4  = 96'h51FC4444FA02442480040000;
    parameter CTRL5  = 96'h51042F88149404241FE00000;
    parameter CTRL6  = 96'hFF2411101108FFE400400000;
    parameter CTRL7  = 96'h012422481A04042400800000;
    parameter CTRL8  = 96'h11244FE43000042401000000;
    parameter CTRL9  = 96'h55240020D1FC3FA4FFFE3000;
    parameter CTRL10 = 96'h55240100102024A401003000;
    parameter CTRL11 = 96'h5544FFFE102024A401000000;
    parameter CTRL12 = 96'h845001001020268401003000;
    parameter CTRL13 = 96'h088801001020250401003000;
    parameter CTRL14 = 96'h3104010057FE041405000000;
    parameter CTRL15 = 96'hC20201002000040802000000;

    parameter THEORY0  = 96'h000000401000020008400000;
    parameter THEORY1  = 96'h01FC204011FE010008400000;
    parameter THEORY2  = 96'hFD2410A050207FFC0FFC0000;
    parameter THEORY3  = 96'h112410A05C40020010400000;
    parameter THEORY4  = 96'h11FC011051FC444410400000;
    parameter THEORY5  = 96'h1124020851042F8833F80000;
    parameter THEORY6  = 96'h1124F406FF24111032080000;
    parameter THEORY7  = 96'h7DFC11100124224853F80000;
    parameter THEORY8  = 96'h1020112011244FE492080000;
    parameter THEORY9  = 96'h102011405524002013F83000;
    parameter THEORY10 = 96'h11FC11805524010012083000;
    parameter THEORY11 = 96'h102011005544FFFE13F80000;
    parameter THEORY12 = 96'h1C2015048450010012083000;
    parameter THEORY13 = 96'hE02019040888010012083000;
    parameter THEORY14 = 96'h43FE10FC310401001FFE0000;
    parameter THEORY15 = 96'h00000000C202010010000000;

    parameter REAL0  = 96'h000400001000020008400000;
    parameter REAL1  = 96'h27C41FF011FE010008400000;
    parameter REAL2  = 96'h1444101050207FFC0FFC0000;
    parameter REAL3  = 96'h14541FF05C40020010400000;
    parameter REAL4  = 96'h8554101051FC444410400000;
    parameter REAL5  = 96'h4554FFFE51042F8833F80000;
    parameter REAL6  = 96'h45540000FF24111032080000;
    parameter REAL7  = 96'h15541FF00124224853F80000;
    parameter REAL8  = 96'h1554111011244FE492080000;
    parameter REAL9  = 96'h25541FF05524002013F83000;
    parameter REAL10 = 96'hE55411105524010012083000;
    parameter REAL11 = 96'h21041FF05544FFFE13F80000;
    parameter REAL12 = 96'h228401008450010012083000;
    parameter REAL13 = 96'h22441FF00888010012083000;
    parameter REAL14 = 96'h24140100310401001FFE0000;
    parameter REAL15 = 96'h08087FFCC202010010000000;

    parameter HZ0  = 16'h0000;
    parameter HZ1  = 16'h0000;
    parameter HZ2  = 16'h0000;
    parameter HZ3  = 16'h6600;
    parameter HZ4  = 16'h6600;
    parameter HZ5  = 16'h667E;
    parameter HZ6  = 16'h6606;
    parameter HZ7  = 16'h7E0C;
    parameter HZ8  = 16'h6618;
    parameter HZ9  = 16'h6630;
    parameter HZ10 = 16'h6660;
    parameter HZ11 = 16'h667E;
    parameter HZ12 = 16'h0000;
    parameter HZ13 = 16'h0000;
    parameter HZ14 = 16'h0000;
    parameter HZ15 = 16'h0000;

    parameter SINE0  = 64'h000000400020;
    parameter SINE1  = 64'h7FFCF8202020;
    parameter SINE2  = 64'h010008201020;
    parameter SINE3  = 64'h01000BFE13FE;
    parameter SINE4  = 64'h010008408222;
    parameter SINE5  = 64'h010078404224;
    parameter SINE6  = 64'h110040884A20;
    parameter SINE7  = 64'h11F841080BFC;
    parameter SINE8  = 64'h110043F01284;
    parameter SINE9  = 64'h110078201288;
    parameter SINE10 = 64'h11000840E248;
    parameter SINE11 = 64'h110008882250;
    parameter SINE12 = 64'h110009042220;
    parameter SINE13 = 64'h11000BFC2450;
    parameter SINE14 = 64'hFFFE51042488;
    parameter SINE15 = 64'h000020000906;

    parameter TRIANGLE0  = 64'h000008000020;
    parameter TRIANGLE1  = 64'h000008002020;
    parameter TRIANGLE2  = 64'h7FFC1FE01020;
    parameter TRIANGLE3  = 64'h0000202013FE;
    parameter TRIANGLE4  = 64'h000040408222;
    parameter TRIANGLE5  = 64'h0000BFF84224;
    parameter TRIANGLE6  = 64'h000021084A20;
    parameter TRIANGLE7  = 64'h3FF821080BFC;
    parameter TRIANGLE8  = 64'h00003FF81284;
    parameter TRIANGLE9  = 64'h000021081288;
    parameter TRIANGLE10 = 64'h00002108E248;
    parameter TRIANGLE11 = 64'h00003FF82250;
    parameter TRIANGLE12 = 64'h000021082220;
    parameter TRIANGLE13 = 64'hFFFE41082450;
    parameter TRIANGLE14 = 64'h000041282488;
    parameter TRIANGLE15 = 64'h000080100906;

    parameter SQUARE0  = 64'h020000000020;
    parameter SQUARE1  = 64'h010000002020;
    parameter SQUARE2  = 64'h010000001020;
    parameter SQUARE3  = 64'hFFFE000013FE;
    parameter SQUARE4  = 64'h040000008222;
    parameter SQUARE5  = 64'h040000004224;
    parameter SQUARE6  = 64'h040000004A20;
    parameter SQUARE7  = 64'h07F000000BFC;
    parameter SQUARE8  = 64'h041000001284;
    parameter SQUARE9  = 64'h041000001288;
    parameter SQUARE10 = 64'h04100000E248;
    parameter SQUARE11 = 64'h081000002250;
    parameter SQUARE12 = 64'h081000002220;
    parameter SQUARE13 = 64'h101000002450;
    parameter SQUARE14 = 64'h20A000002488;
    parameter SQUARE15 = 64'h404000000906;

    parameter SAWTOOTH0  = 64'h200001000020;
    parameter SAWTOOTH1  = 64'h23FC01002020;
    parameter SAWTOOTH2  = 64'h3A0411F81020;
    parameter SAWTOOTH3  = 64'h2204110013FE;
    parameter SAWTOOTH4  = 64'h43FC11008222;
    parameter SAWTOOTH5  = 64'h7A2011004224;
    parameter SAWTOOTH6  = 64'hA220FFFE4A20;
    parameter SAWTOOTH7  = 64'h23FE00000BFC;
    parameter SAWTOOTH8  = 64'hFA2021081284;
    parameter SAWTOOTH9  = 64'h222021081288;
    parameter SAWTOOTH10 = 64'h22FC2288E248;
    parameter SAWTOOTH11 = 64'h228424482250;
    parameter SAWTOOTH12 = 64'h2A8428282220;
    parameter SAWTOOTH13 = 64'h348420082450;
    parameter SAWTOOTH14 = 64'h24FC3FF82488;
    parameter SAWTOOTH15 = 64'h088400080906;

    reg [7:0] NUM0[0:9];
    reg [7:0] NUM1[0:9];
    reg [7:0] NUM2[0:9];
    reg [7:0] NUM3[0:9];
    reg [7:0] NUM4[0:9];
    reg [7:0] NUM5[0:9];
    reg [7:0] NUM6[0:9];
    reg [7:0] NUM7[0:9];
    reg [7:0] NUM8[0:9];
    reg [7:0] NUM9[0:9];
    reg [7:0] NUM10[0:9];
    reg [7:0] NUM11[0:9];
    reg [7:0] NUM12[0:9];
    reg [7:0] NUM13[0:9];
    reg [7:0] NUM14[0:9];
    reg [7:0] NUM15[0:9];

    reg [9:0] pix_h_pos, pix_v_pos; // 像素相对位置
    wire name_valid_area;
    wire title_valid_area;
    wire border_valid_area;
    wire wave_form_valid_area;
    wire freq_ctrl_valid_area;
    wire freq_theory_valid_area;
    wire freq_real_valid_area;
    wire wave_type_valid_area;
    wire hz_mark_1_valid_area;
    wire hz_mark_2_valid_area;
    wire freq_c_num_valid_area;
    wire freq_t_num_valid_area;
    wire freq_r_num_valid_area;

    assign name_valid_area = (h_pos >= `NAME_H_START && h_pos < `NAME_H_END && v_pos >= `NAME_V_START && v_pos < `NAME_V_END);
    assign title_valid_area = (h_pos >= `TITLE_H_START && h_pos < `TITLE_H_END && v_pos >= `TITLE_V_START && v_pos < `TITLE_V_END);
    assign border_valid_area = (h_pos >= `BORDER_H_START && h_pos < `BORDER_H_END && v_pos >= `BORDER_V_START && v_pos < `BORDER_V_END);
    assign wave_form_valid_area = (h_pos >= `WAVE_FORM_H_START && h_pos < `WAVE_FORM_H_END && v_pos >= `WAVE_FORM_V_START && v_pos < `WAVE_FORM_V_END);
    assign freq_ctrl_valid_area = (h_pos >= `FREQ_CTRL_H_START && h_pos < `FREQ_CTRL_H_END && v_pos >= `FREQ_CTRL_V_START && v_pos < `FREQ_CTRL_V_END);
    assign freq_theory_valid_area = (h_pos >= `FREQ_THEORY_H_START && h_pos < `FREQ_THEORY_H_END && v_pos >= `FREQ_THEORY_V_START && v_pos < `FREQ_THEORY_V_END);
    assign freq_real_valid_area = (h_pos >= `FREQ_REAL_H_START && h_pos < `FREQ_REAL_H_END && v_pos >= `FREQ_REAL_V_START && v_pos < `FREQ_REAL_V_END);
    assign wave_type_valid_area = (h_pos >= `WAVE_TYPE_H_START && h_pos < `WAVE_TYPE_H_END && v_pos >= `WAVE_TYPE_V_START && v_pos < `WAVE_TYPE_V_END);
    assign hz_mark_1_valid_area = (h_pos >= `HZ_MARK_1_H_START && h_pos < `HZ_MARK_1_H_END && v_pos >= `HZ_MARK_1_V_START && v_pos < `HZ_MARK_1_V_END);
    assign hz_mark_2_valid_area = (h_pos >= `HZ_MARK_2_H_START && h_pos < `HZ_MARK_2_H_END && v_pos >= `HZ_MARK_2_V_START && v_pos < `HZ_MARK_2_V_END);
    assign freq_c_num_valid_area = (h_pos >= `FREQ_C_NUM_H_START && h_pos < `FREQ_C_NUM_H_END && v_pos >= `FREQ_C_NUM_V_START && v_pos < `FREQ_C_NUM_V_END);
    assign freq_t_num_valid_area = (h_pos >= `FREQ_T_NUM_H_START && h_pos < `FREQ_T_NUM_H_END && v_pos >= `FREQ_T_NUM_V_START && v_pos < `FREQ_T_NUM_V_END);
    assign freq_r_num_valid_area = (h_pos >= `FREQ_R_NUM_H_START && h_pos < `FREQ_R_NUM_H_END && v_pos >= `FREQ_R_NUM_V_START && v_pos < `FREQ_R_NUM_V_END);

    always @(posedge clk_25MHz) begin
        NUM0 [0] <= 8'h00; NUM0 [1] <= 8'h00; NUM0 [2] <= 8'h00; NUM0 [3] <= 8'h00; NUM0 [4] <= 8'h00; NUM0 [5] <= 8'h00; NUM0 [6] <= 8'h00; NUM0 [7] <= 8'h00; NUM0 [8] <= 8'h00; NUM0 [9] <= 8'h00;
        NUM1 [0] <= 8'h00; NUM1 [1] <= 8'h00; NUM1 [2] <= 8'h00; NUM1 [3] <= 8'h00; NUM1 [4] <= 8'h00; NUM1 [5] <= 8'h00; NUM1 [6] <= 8'h00; NUM1 [7] <= 8'h00; NUM1 [8] <= 8'h00; NUM1 [9] <= 8'h00;
        NUM2 [0] <= 8'h00; NUM2 [1] <= 8'h00; NUM2 [2] <= 8'h00; NUM2 [3] <= 8'h00; NUM2 [4] <= 8'h00; NUM2 [5] <= 8'h00; NUM2 [6] <= 8'h00; NUM2 [7] <= 8'h00; NUM2 [8] <= 8'h00; NUM2 [9] <= 8'h00;
        NUM3 [0] <= 8'h3C; NUM3 [1] <= 8'h0C; NUM3 [2] <= 8'h3C; NUM3 [3] <= 8'h3C; NUM3 [4] <= 8'h30; NUM3 [5] <= 8'h7E; NUM3 [6] <= 8'h1C; NUM3 [7] <= 8'h7E; NUM3 [8] <= 8'h3C; NUM3 [9] <= 8'h3C;
        NUM4 [0] <= 8'h66; NUM4 [1] <= 8'h1C; NUM4 [2] <= 8'h66; NUM4 [3] <= 8'h66; NUM4 [4] <= 8'h30; NUM4 [5] <= 8'h60; NUM4 [6] <= 8'h18; NUM4 [7] <= 8'h06; NUM4 [8] <= 8'h66; NUM4 [9] <= 8'h66;
        NUM5 [0] <= 8'h6E; NUM5 [1] <= 8'h7C; NUM5 [2] <= 8'h66; NUM5 [3] <= 8'h66; NUM5 [4] <= 8'h36; NUM5 [5] <= 8'h60; NUM5 [6] <= 8'h30; NUM5 [7] <= 8'h0C; NUM5 [8] <= 8'h66; NUM5 [9] <= 8'h66;
        NUM6 [0] <= 8'h6E; NUM6 [1] <= 8'h0C; NUM6 [2] <= 8'h06; NUM6 [3] <= 8'h06; NUM6 [4] <= 8'h36; NUM6 [5] <= 8'h60; NUM6 [6] <= 8'h7C; NUM6 [7] <= 8'h0C; NUM6 [8] <= 8'h76; NUM6 [9] <= 8'h66;
        NUM7 [0] <= 8'h66; NUM7 [1] <= 8'h0C; NUM7 [2] <= 8'h0C; NUM7 [3] <= 8'h1C; NUM7 [4] <= 8'h36; NUM7 [5] <= 8'h7C; NUM7 [6] <= 8'h66; NUM7 [7] <= 8'h18; NUM7 [8] <= 8'h3C; NUM7 [9] <= 8'h66;
        NUM8 [0] <= 8'h76; NUM8 [1] <= 8'h0C; NUM8 [2] <= 8'h18; NUM8 [3] <= 8'h06; NUM8 [4] <= 8'h66; NUM8 [5] <= 8'h06; NUM8 [6] <= 8'h66; NUM8 [7] <= 8'h18; NUM8 [8] <= 8'h6E; NUM8 [9] <= 8'h3E;
        NUM9 [0] <= 8'h76; NUM9 [1] <= 8'h0C; NUM9 [2] <= 8'h30; NUM9 [3] <= 8'h66; NUM9 [4] <= 8'h7F; NUM9 [5] <= 8'h06; NUM9 [6] <= 8'h66; NUM9 [7] <= 8'h30; NUM9 [8] <= 8'h66; NUM9 [9] <= 8'h0C;
        NUM10[0] <= 8'h66; NUM10[1] <= 8'h0C; NUM10[2] <= 8'h60; NUM10[3] <= 8'h66; NUM10[4] <= 8'h06; NUM10[5] <= 8'h0C; NUM10[6] <= 8'h66; NUM10[7] <= 8'h30; NUM10[8] <= 8'h66; NUM10[9] <= 8'h18;
        NUM11[0] <= 8'h3C; NUM11[1] <= 8'h0C; NUM11[2] <= 8'h7E; NUM11[3] <= 8'h3C; NUM11[4] <= 8'h06; NUM11[5] <= 8'h78; NUM11[6] <= 8'h3C; NUM11[7] <= 8'h30; NUM11[8] <= 8'h3C; NUM11[9] <= 8'h38;
        NUM12[0] <= 8'h00; NUM12[1] <= 8'h00; NUM12[2] <= 8'h00; NUM12[3] <= 8'h00; NUM12[4] <= 8'h00; NUM12[5] <= 8'h00; NUM12[6] <= 8'h00; NUM12[7] <= 8'h00; NUM12[8] <= 8'h00; NUM12[9] <= 8'h00;
        NUM13[0] <= 8'h00; NUM13[1] <= 8'h00; NUM13[2] <= 8'h00; NUM13[3] <= 8'h00; NUM13[4] <= 8'h00; NUM13[5] <= 8'h00; NUM13[6] <= 8'h00; NUM13[7] <= 8'h00; NUM13[8] <= 8'h00; NUM13[9] <= 8'h00;
        NUM14[0] <= 8'h00; NUM14[1] <= 8'h00; NUM14[2] <= 8'h00; NUM14[3] <= 8'h00; NUM14[4] <= 8'h00; NUM14[5] <= 8'h00; NUM14[6] <= 8'h00; NUM14[7] <= 8'h00; NUM14[8] <= 8'h00; NUM14[9] <= 8'h00;
        NUM15[0] <= 8'h00; NUM15[1] <= 8'h00; NUM15[2] <= 8'h00; NUM15[3] <= 8'h00; NUM15[4] <= 8'h00; NUM15[5] <= 8'h00; NUM15[6] <= 8'h00; NUM15[7] <= 8'h00; NUM15[8] <= 8'h00; NUM15[9] <= 8'h00;
    end

    always @(posedge clk_25MHz or negedge rst_ ) begin
        if (!rst_) begin
            rgb_out <= `BLACK;
        end else begin
            if (name_valid_area) begin
                pix_h_pos = `NAME_H_END - h_pos - 1;
                pix_v_pos = v_pos - `NAME_V_START;
                case (pix_v_pos)
                    0:  rgb_out <= NAME0 [pix_h_pos] ? `OUTER_TEXT_COLOR : `MARGIN_COLOR;
                    1:  rgb_out <= NAME1 [pix_h_pos] ? `OUTER_TEXT_COLOR : `MARGIN_COLOR;
                    2:  rgb_out <= NAME2 [pix_h_pos] ? `OUTER_TEXT_COLOR : `MARGIN_COLOR;
                    3:  rgb_out <= NAME3 [pix_h_pos] ? `OUTER_TEXT_COLOR : `MARGIN_COLOR;
                    4:  rgb_out <= NAME4 [pix_h_pos] ? `OUTER_TEXT_COLOR : `MARGIN_COLOR;
                    5:  rgb_out <= NAME5 [pix_h_pos] ? `OUTER_TEXT_COLOR : `MARGIN_COLOR;
                    6:  rgb_out <= NAME6 [pix_h_pos] ? `OUTER_TEXT_COLOR : `MARGIN_COLOR;
                    7:  rgb_out <= NAME7 [pix_h_pos] ? `OUTER_TEXT_COLOR : `MARGIN_COLOR;
                    8:  rgb_out <= NAME8 [pix_h_pos] ? `OUTER_TEXT_COLOR : `MARGIN_COLOR;
                    9:  rgb_out <= NAME9 [pix_h_pos] ? `OUTER_TEXT_COLOR : `MARGIN_COLOR;
                    10: rgb_out <= NAME10[pix_h_pos] ? `OUTER_TEXT_COLOR : `MARGIN_COLOR;
                    11: rgb_out <= NAME11[pix_h_pos] ? `OUTER_TEXT_COLOR : `MARGIN_COLOR;
                    12: rgb_out <= NAME12[pix_h_pos] ? `OUTER_TEXT_COLOR : `MARGIN_COLOR;
                    13: rgb_out <= NAME13[pix_h_pos] ? `OUTER_TEXT_COLOR : `MARGIN_COLOR;
                    14: rgb_out <= NAME14[pix_h_pos] ? `OUTER_TEXT_COLOR : `MARGIN_COLOR;
                    15: rgb_out <= NAME15[pix_h_pos] ? `OUTER_TEXT_COLOR : `MARGIN_COLOR;
                endcase
            end else if (title_valid_area) begin
                pix_h_pos = `TITLE_H_END - h_pos - 1;
                pix_v_pos = v_pos - `TITLE_V_START;
                case (pix_v_pos)
                    0:  rgb_out <= TITLE0 [pix_h_pos] ? `OUTER_TEXT_COLOR : `MARGIN_COLOR;
                    1:  rgb_out <= TITLE1 [pix_h_pos] ? `OUTER_TEXT_COLOR : `MARGIN_COLOR;
                    2:  rgb_out <= TITLE2 [pix_h_pos] ? `OUTER_TEXT_COLOR : `MARGIN_COLOR;
                    3:  rgb_out <= TITLE3 [pix_h_pos] ? `OUTER_TEXT_COLOR : `MARGIN_COLOR;
                    4:  rgb_out <= TITLE4 [pix_h_pos] ? `OUTER_TEXT_COLOR : `MARGIN_COLOR;
                    5:  rgb_out <= TITLE5 [pix_h_pos] ? `OUTER_TEXT_COLOR : `MARGIN_COLOR;
                    6:  rgb_out <= TITLE6 [pix_h_pos] ? `OUTER_TEXT_COLOR : `MARGIN_COLOR;
                    7:  rgb_out <= TITLE7 [pix_h_pos] ? `OUTER_TEXT_COLOR : `MARGIN_COLOR;
                    8:  rgb_out <= TITLE8 [pix_h_pos] ? `OUTER_TEXT_COLOR : `MARGIN_COLOR;
                    9:  rgb_out <= TITLE9 [pix_h_pos] ? `OUTER_TEXT_COLOR : `MARGIN_COLOR;
                    10: rgb_out <= TITLE10[pix_h_pos] ? `OUTER_TEXT_COLOR : `MARGIN_COLOR;
                    11: rgb_out <= TITLE11[pix_h_pos] ? `OUTER_TEXT_COLOR : `MARGIN_COLOR;
                    12: rgb_out <= TITLE12[pix_h_pos] ? `OUTER_TEXT_COLOR : `MARGIN_COLOR;
                    13: rgb_out <= TITLE13[pix_h_pos] ? `OUTER_TEXT_COLOR : `MARGIN_COLOR;
                    14: rgb_out <= TITLE14[pix_h_pos] ? `OUTER_TEXT_COLOR : `MARGIN_COLOR;
                    15: rgb_out <= TITLE15[pix_h_pos] ? `OUTER_TEXT_COLOR : `MARGIN_COLOR;
                endcase
            end else if (wave_form_valid_area) begin
                pix_h_pos = `WAVE_FORM_H_END - h_pos - 1;
                pix_v_pos = v_pos - `WAVE_FORM_V_START;
                case (pix_v_pos)
                    0:  rgb_out <= WAVE0 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    1:  rgb_out <= WAVE1 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    2:  rgb_out <= WAVE2 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    3:  rgb_out <= WAVE3 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    4:  rgb_out <= WAVE4 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    5:  rgb_out <= WAVE5 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    6:  rgb_out <= WAVE6 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    7:  rgb_out <= WAVE7 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    8:  rgb_out <= WAVE8 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    9:  rgb_out <= WAVE9 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    10: rgb_out <= WAVE10[pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    11: rgb_out <= WAVE11[pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    12: rgb_out <= WAVE12[pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    13: rgb_out <= WAVE13[pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    14: rgb_out <= WAVE14[pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    15: rgb_out <= WAVE15[pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                endcase
            end else if (freq_ctrl_valid_area) begin
                pix_h_pos = `FREQ_CTRL_H_END - h_pos - 1;
                pix_v_pos = v_pos - `FREQ_CTRL_V_START;
                case (pix_v_pos)
                    0:  rgb_out <= CTRL0 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    1:  rgb_out <= CTRL1 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    2:  rgb_out <= CTRL2 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    3:  rgb_out <= CTRL3 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    4:  rgb_out <= CTRL4 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    5:  rgb_out <= CTRL5 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    6:  rgb_out <= CTRL6 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    7:  rgb_out <= CTRL7 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    8:  rgb_out <= CTRL8 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    9:  rgb_out <= CTRL9 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    10: rgb_out <= CTRL10[pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    11: rgb_out <= CTRL11[pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    12: rgb_out <= CTRL12[pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    13: rgb_out <= CTRL13[pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    14: rgb_out <= CTRL14[pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    15: rgb_out <= CTRL15[pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                endcase
            end else if (freq_theory_valid_area) begin
                pix_h_pos = `FREQ_THEORY_H_END - h_pos - 1;
                pix_v_pos = v_pos - `FREQ_THEORY_V_START;
                case (pix_v_pos)
                    0:  rgb_out <= THEORY0 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    1:  rgb_out <= THEORY1 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    2:  rgb_out <= THEORY2 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    3:  rgb_out <= THEORY3 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    4:  rgb_out <= THEORY4 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    5:  rgb_out <= THEORY5 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    6:  rgb_out <= THEORY6 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    7:  rgb_out <= THEORY7 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    8:  rgb_out <= THEORY8 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    9:  rgb_out <= THEORY9 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    10: rgb_out <= THEORY10[pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    11: rgb_out <= THEORY11[pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    12: rgb_out <= THEORY12[pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    13: rgb_out <= THEORY13[pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    14: rgb_out <= THEORY14[pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    15: rgb_out <= THEORY15[pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                endcase
            end else if (freq_real_valid_area) begin
                pix_h_pos = `FREQ_REAL_H_END - h_pos - 1;
                pix_v_pos = v_pos - `FREQ_REAL_V_START;
                case (pix_v_pos)
                    0:  rgb_out <= REAL0 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    1:  rgb_out <= REAL1 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    2:  rgb_out <= REAL2 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    3:  rgb_out <= REAL3 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    4:  rgb_out <= REAL4 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    5:  rgb_out <= REAL5 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    6:  rgb_out <= REAL6 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    7:  rgb_out <= REAL7 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    8:  rgb_out <= REAL8 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    9:  rgb_out <= REAL9 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    10: rgb_out <= REAL10[pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    11: rgb_out <= REAL11[pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    12: rgb_out <= REAL12[pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    13: rgb_out <= REAL13[pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    14: rgb_out <= REAL14[pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    15: rgb_out <= REAL15[pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                endcase
            end else if (wave_type_valid_area) begin
                pix_h_pos = `WAVE_TYPE_H_END - h_pos - 1;
                pix_v_pos = v_pos - `WAVE_TYPE_V_START;
                case (sw)
                    2'b00: begin
                        case (pix_v_pos)
                            0:  rgb_out <= SINE0 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            1:  rgb_out <= SINE1 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            2:  rgb_out <= SINE2 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            3:  rgb_out <= SINE3 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            4:  rgb_out <= SINE4 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            5:  rgb_out <= SINE5 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            6:  rgb_out <= SINE6 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            7:  rgb_out <= SINE7 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            8:  rgb_out <= SINE8 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            9:  rgb_out <= SINE9 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            10: rgb_out <= SINE10[pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            11: rgb_out <= SINE11[pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            12: rgb_out <= SINE12[pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            13: rgb_out <= SINE13[pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            14: rgb_out <= SINE14[pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            15: rgb_out <= SINE15[pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                        endcase
                    end
                    2'b01: begin
                        case (pix_v_pos)
                            0:  rgb_out <= TRIANGLE0 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            1:  rgb_out <= TRIANGLE1 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            2:  rgb_out <= TRIANGLE2 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            3:  rgb_out <= TRIANGLE3 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            4:  rgb_out <= TRIANGLE4 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            5:  rgb_out <= TRIANGLE5 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            6:  rgb_out <= TRIANGLE6 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            7:  rgb_out <= TRIANGLE7 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            8:  rgb_out <= TRIANGLE8 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            9:  rgb_out <= TRIANGLE9 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            10: rgb_out <= TRIANGLE10[pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            11: rgb_out <= TRIANGLE11[pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            12: rgb_out <= TRIANGLE12[pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            13: rgb_out <= TRIANGLE13[pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            14: rgb_out <= TRIANGLE14[pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            15: rgb_out <= TRIANGLE15[pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                        endcase
                    end
                    2'b10: begin
                        case (pix_v_pos)
                            0:  rgb_out <= SQUARE0 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            1:  rgb_out <= SQUARE1 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            2:  rgb_out <= SQUARE2 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            3:  rgb_out <= SQUARE3 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            4:  rgb_out <= SQUARE4 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            5:  rgb_out <= SQUARE5 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            6:  rgb_out <= SQUARE6 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            7:  rgb_out <= SQUARE7 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            8:  rgb_out <= SQUARE8 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            9:  rgb_out <= SQUARE9 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            10: rgb_out <= SQUARE10[pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            11: rgb_out <= SQUARE11[pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            12: rgb_out <= SQUARE12[pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            13: rgb_out <= SQUARE13[pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            14: rgb_out <= SQUARE14[pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            15: rgb_out <= SQUARE15[pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                        endcase
                    end
                    2'b11: begin
                        case (pix_v_pos)
                            0:  rgb_out <= SAWTOOTH0 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            1:  rgb_out <= SAWTOOTH1 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            2:  rgb_out <= SAWTOOTH2 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            3:  rgb_out <= SAWTOOTH3 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            4:  rgb_out <= SAWTOOTH4 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            5:  rgb_out <= SAWTOOTH5 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            6:  rgb_out <= SAWTOOTH6 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            7:  rgb_out <= SAWTOOTH7 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            8:  rgb_out <= SAWTOOTH8 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            9:  rgb_out <= SAWTOOTH9 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            10: rgb_out <= SAWTOOTH10[pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            11: rgb_out <= SAWTOOTH11[pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            12: rgb_out <= SAWTOOTH12[pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            13: rgb_out <= SAWTOOTH13[pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            14: rgb_out <= SAWTOOTH14[pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            15: rgb_out <= SAWTOOTH15[pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                        endcase
                    end
                endcase
            end else if (hz_mark_1_valid_area) begin
                pix_h_pos = `HZ_MARK_1_H_END - h_pos - 1;
                pix_v_pos = v_pos - `HZ_MARK_1_V_START;
                case (pix_v_pos)
                    0:  rgb_out <= HZ0 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    1:  rgb_out <= HZ1 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    2:  rgb_out <= HZ2 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    3:  rgb_out <= HZ3 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    4:  rgb_out <= HZ4 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    5:  rgb_out <= HZ5 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    6:  rgb_out <= HZ6 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    7:  rgb_out <= HZ7 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    8:  rgb_out <= HZ8 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    9:  rgb_out <= HZ9 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    10: rgb_out <= HZ10[pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    11: rgb_out <= HZ11[pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    12: rgb_out <= HZ12[pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    13: rgb_out <= HZ13[pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    14: rgb_out <= HZ14[pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    15: rgb_out <= HZ15[pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                endcase
            end else if (hz_mark_2_valid_area) begin
                pix_h_pos = `HZ_MARK_2_H_END - h_pos - 1;
                pix_v_pos = v_pos - `HZ_MARK_2_V_START;
                case (pix_v_pos)
                    0:  rgb_out <= HZ0 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    1:  rgb_out <= HZ1 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    2:  rgb_out <= HZ2 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    3:  rgb_out <= HZ3 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    4:  rgb_out <= HZ4 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    5:  rgb_out <= HZ5 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    6:  rgb_out <= HZ6 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    7:  rgb_out <= HZ7 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    8:  rgb_out <= HZ8 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    9:  rgb_out <= HZ9 [pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    10: rgb_out <= HZ10[pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    11: rgb_out <= HZ11[pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    12: rgb_out <= HZ12[pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    13: rgb_out <= HZ13[pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    14: rgb_out <= HZ14[pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                    15: rgb_out <= HZ15[pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                endcase
            end else if (freq_c_num_valid_area) begin
                pix_h_pos = `FREQ_C_NUM_H_END - h_pos - 1;
                pix_v_pos = v_pos - `FREQ_C_NUM_V_START;
                if (pix_h_pos < 8) begin
                    if (cen[2]) begin
                        case (pix_v_pos)
                            0:  rgb_out <= NUM0 [ctrl_num0][pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            1:  rgb_out <= NUM1 [ctrl_num0][pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            2:  rgb_out <= NUM2 [ctrl_num0][pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            3:  rgb_out <= NUM3 [ctrl_num0][pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            4:  rgb_out <= NUM4 [ctrl_num0][pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            5:  rgb_out <= NUM5 [ctrl_num0][pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            6:  rgb_out <= NUM6 [ctrl_num0][pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            7:  rgb_out <= NUM7 [ctrl_num0][pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            8:  rgb_out <= NUM8 [ctrl_num0][pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            9:  rgb_out <= NUM9 [ctrl_num0][pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            10: rgb_out <= NUM10[ctrl_num0][pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            11: rgb_out <= NUM11[ctrl_num0][pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            12: rgb_out <= NUM12[ctrl_num0][pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            13: rgb_out <= NUM13[ctrl_num0][pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            14: rgb_out <= NUM14[ctrl_num0][pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            15: rgb_out <= NUM15[ctrl_num0][pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                        endcase
                    end else begin
                        rgb_out <= `BACKGROUND_COLOR;
                    end
                end else if (pix_h_pos < 16) begin
                    if (cen[1]) begin
                        case (pix_v_pos)
                            0:  rgb_out <= NUM0 [ctrl_num1][pix_h_pos - 8] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            1:  rgb_out <= NUM1 [ctrl_num1][pix_h_pos - 8] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            2:  rgb_out <= NUM2 [ctrl_num1][pix_h_pos - 8] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            3:  rgb_out <= NUM3 [ctrl_num1][pix_h_pos - 8] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            4:  rgb_out <= NUM4 [ctrl_num1][pix_h_pos - 8] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            5:  rgb_out <= NUM5 [ctrl_num1][pix_h_pos - 8] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            6:  rgb_out <= NUM6 [ctrl_num1][pix_h_pos - 8] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            7:  rgb_out <= NUM7 [ctrl_num1][pix_h_pos - 8] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            8:  rgb_out <= NUM8 [ctrl_num1][pix_h_pos - 8] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            9:  rgb_out <= NUM9 [ctrl_num1][pix_h_pos - 8] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            10: rgb_out <= NUM10[ctrl_num1][pix_h_pos - 8] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            11: rgb_out <= NUM11[ctrl_num1][pix_h_pos - 8] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            12: rgb_out <= NUM12[ctrl_num1][pix_h_pos - 8] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            13: rgb_out <= NUM13[ctrl_num1][pix_h_pos - 8] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            14: rgb_out <= NUM14[ctrl_num1][pix_h_pos - 8] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            15: rgb_out <= NUM15[ctrl_num1][pix_h_pos - 8] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                        endcase
                    end else begin
                        rgb_out <= `BACKGROUND_COLOR;
                    end
                end else begin
                    if (cen[0]) begin
                        case (pix_v_pos)
                            0:  rgb_out <= NUM0 [ctrl_num2][pix_h_pos - 16] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            1:  rgb_out <= NUM1 [ctrl_num2][pix_h_pos - 16] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            2:  rgb_out <= NUM2 [ctrl_num2][pix_h_pos - 16] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            3:  rgb_out <= NUM3 [ctrl_num2][pix_h_pos - 16] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            4:  rgb_out <= NUM4 [ctrl_num2][pix_h_pos - 16] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            5:  rgb_out <= NUM5 [ctrl_num2][pix_h_pos - 16] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            6:  rgb_out <= NUM6 [ctrl_num2][pix_h_pos - 16] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            7:  rgb_out <= NUM7 [ctrl_num2][pix_h_pos - 16] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            8:  rgb_out <= NUM8 [ctrl_num2][pix_h_pos - 16] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            9:  rgb_out <= NUM9 [ctrl_num2][pix_h_pos - 16] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            10: rgb_out <= NUM10[ctrl_num2][pix_h_pos - 16] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            11: rgb_out <= NUM11[ctrl_num2][pix_h_pos - 16] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            12: rgb_out <= NUM12[ctrl_num2][pix_h_pos - 16] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            13: rgb_out <= NUM13[ctrl_num2][pix_h_pos - 16] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            14: rgb_out <= NUM14[ctrl_num2][pix_h_pos - 16] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            15: rgb_out <= NUM15[ctrl_num2][pix_h_pos - 16] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                        endcase
                    end else begin
                        rgb_out <= `BACKGROUND_COLOR;
                    end
                end
            end else if (freq_t_num_valid_area) begin
                pix_h_pos = `FREQ_T_NUM_H_END - h_pos - 1;
                pix_v_pos = v_pos - `FREQ_T_NUM_V_START;
                if (pix_h_pos < 8) begin
                    if (ten[4]) begin
                        case (pix_v_pos)
                            0:  rgb_out <= NUM0 [freq_t_num0][pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            1:  rgb_out <= NUM1 [freq_t_num0][pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            2:  rgb_out <= NUM2 [freq_t_num0][pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            3:  rgb_out <= NUM3 [freq_t_num0][pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            4:  rgb_out <= NUM4 [freq_t_num0][pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            5:  rgb_out <= NUM5 [freq_t_num0][pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            6:  rgb_out <= NUM6 [freq_t_num0][pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            7:  rgb_out <= NUM7 [freq_t_num0][pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            8:  rgb_out <= NUM8 [freq_t_num0][pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            9:  rgb_out <= NUM9 [freq_t_num0][pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            10: rgb_out <= NUM10[freq_t_num0][pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            11: rgb_out <= NUM11[freq_t_num0][pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            12: rgb_out <= NUM12[freq_t_num0][pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            13: rgb_out <= NUM13[freq_t_num0][pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            14: rgb_out <= NUM14[freq_t_num0][pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            15: rgb_out <= NUM15[freq_t_num0][pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                        endcase
                    end else begin
                        rgb_out <= `BACKGROUND_COLOR;
                    end
                end else if (pix_h_pos < 16) begin
                    if (ten[3]) begin
                        case (pix_v_pos)
                            0:  rgb_out <= NUM0 [freq_t_num1][pix_h_pos - 8] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            1:  rgb_out <= NUM1 [freq_t_num1][pix_h_pos - 8] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            2:  rgb_out <= NUM2 [freq_t_num1][pix_h_pos - 8] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            3:  rgb_out <= NUM3 [freq_t_num1][pix_h_pos - 8] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            4:  rgb_out <= NUM4 [freq_t_num1][pix_h_pos - 8] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            5:  rgb_out <= NUM5 [freq_t_num1][pix_h_pos - 8] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            6:  rgb_out <= NUM6 [freq_t_num1][pix_h_pos - 8] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            7:  rgb_out <= NUM7 [freq_t_num1][pix_h_pos - 8] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            8:  rgb_out <= NUM8 [freq_t_num1][pix_h_pos - 8] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            9:  rgb_out <= NUM9 [freq_t_num1][pix_h_pos - 8] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            10: rgb_out <= NUM10[freq_t_num1][pix_h_pos - 8] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            11: rgb_out <= NUM11[freq_t_num1][pix_h_pos - 8] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            12: rgb_out <= NUM12[freq_t_num1][pix_h_pos - 8] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            13: rgb_out <= NUM13[freq_t_num1][pix_h_pos - 8] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            14: rgb_out <= NUM14[freq_t_num1][pix_h_pos - 8] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            15: rgb_out <= NUM15[freq_t_num1][pix_h_pos - 8] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                        endcase
                    end else begin
                        rgb_out <= `BACKGROUND_COLOR;
                    end
                end else if (pix_h_pos < 24) begin
                    if (ten[2]) begin
                        case (pix_v_pos)
                            0:  rgb_out <= NUM0 [freq_t_num2][pix_h_pos - 16] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            1:  rgb_out <= NUM1 [freq_t_num2][pix_h_pos - 16] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            2:  rgb_out <= NUM2 [freq_t_num2][pix_h_pos - 16] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            3:  rgb_out <= NUM3 [freq_t_num2][pix_h_pos - 16] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            4:  rgb_out <= NUM4 [freq_t_num2][pix_h_pos - 16] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            5:  rgb_out <= NUM5 [freq_t_num2][pix_h_pos - 16] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            6:  rgb_out <= NUM6 [freq_t_num2][pix_h_pos - 16] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            7:  rgb_out <= NUM7 [freq_t_num2][pix_h_pos - 16] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            8:  rgb_out <= NUM8 [freq_t_num2][pix_h_pos - 16] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            9:  rgb_out <= NUM9 [freq_t_num2][pix_h_pos - 16] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            10: rgb_out <= NUM10[freq_t_num2][pix_h_pos - 16] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            11: rgb_out <= NUM11[freq_t_num2][pix_h_pos - 16] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            12: rgb_out <= NUM12[freq_t_num2][pix_h_pos - 16] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            13: rgb_out <= NUM13[freq_t_num2][pix_h_pos - 16] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            14: rgb_out <= NUM14[freq_t_num2][pix_h_pos - 16] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            15: rgb_out <= NUM15[freq_t_num2][pix_h_pos - 16] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                        endcase
                    end else begin
                        rgb_out <= `BACKGROUND_COLOR;
                    end
                end else if (pix_h_pos < 32) begin
                    if (ten[1]) begin
                        case (pix_v_pos)
                            0:  rgb_out <= NUM0 [freq_t_num3][pix_h_pos - 24] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            1:  rgb_out <= NUM1 [freq_t_num3][pix_h_pos - 24] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            2:  rgb_out <= NUM2 [freq_t_num3][pix_h_pos - 24] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            3:  rgb_out <= NUM3 [freq_t_num3][pix_h_pos - 24] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            4:  rgb_out <= NUM4 [freq_t_num3][pix_h_pos - 24] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            5:  rgb_out <= NUM5 [freq_t_num3][pix_h_pos - 24] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            6:  rgb_out <= NUM6 [freq_t_num3][pix_h_pos - 24] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            7:  rgb_out <= NUM7 [freq_t_num3][pix_h_pos - 24] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            8:  rgb_out <= NUM8 [freq_t_num3][pix_h_pos - 24] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            9:  rgb_out <= NUM9 [freq_t_num3][pix_h_pos - 24] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            10: rgb_out <= NUM10[freq_t_num3][pix_h_pos - 24] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            11: rgb_out <= NUM11[freq_t_num3][pix_h_pos - 24] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            12: rgb_out <= NUM12[freq_t_num3][pix_h_pos - 24] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            13: rgb_out <= NUM13[freq_t_num3][pix_h_pos - 24] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            14: rgb_out <= NUM14[freq_t_num3][pix_h_pos - 24] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            15: rgb_out <= NUM15[freq_t_num3][pix_h_pos - 24] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                        endcase
                    end else begin
                        rgb_out <= `BACKGROUND_COLOR;
                    end
                end else begin
                    if (ten[0]) begin
                        case (pix_v_pos)
                            0:  rgb_out <= NUM0 [freq_t_num4][pix_h_pos - 32] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            1:  rgb_out <= NUM1 [freq_t_num4][pix_h_pos - 32] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            2:  rgb_out <= NUM2 [freq_t_num4][pix_h_pos - 32] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            3:  rgb_out <= NUM3 [freq_t_num4][pix_h_pos - 32] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            4:  rgb_out <= NUM4 [freq_t_num4][pix_h_pos - 32] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            5:  rgb_out <= NUM5 [freq_t_num4][pix_h_pos - 32] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            6:  rgb_out <= NUM6 [freq_t_num4][pix_h_pos - 32] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            7:  rgb_out <= NUM7 [freq_t_num4][pix_h_pos - 32] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            8:  rgb_out <= NUM8 [freq_t_num4][pix_h_pos - 32] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            9:  rgb_out <= NUM9 [freq_t_num4][pix_h_pos - 32] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            10: rgb_out <= NUM10[freq_t_num4][pix_h_pos - 32] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            11: rgb_out <= NUM11[freq_t_num4][pix_h_pos - 32] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            12: rgb_out <= NUM12[freq_t_num4][pix_h_pos - 32] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            13: rgb_out <= NUM13[freq_t_num4][pix_h_pos - 32] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            14: rgb_out <= NUM14[freq_t_num4][pix_h_pos - 32] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            15: rgb_out <= NUM15[freq_t_num4][pix_h_pos - 32] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                        endcase
                    end else begin
                        rgb_out <= `BACKGROUND_COLOR;
                    end
                end
            end else if (freq_r_num_valid_area) begin
                pix_h_pos = `FREQ_R_NUM_H_END - h_pos - 1;
                pix_v_pos = v_pos - `FREQ_R_NUM_V_START;
                if (pix_h_pos < 8) begin
                    if (ren[4]) begin
                        case (pix_v_pos)
                            0:  rgb_out <= NUM0 [freq_r_num0][pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            1:  rgb_out <= NUM1 [freq_r_num0][pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            2:  rgb_out <= NUM2 [freq_r_num0][pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            3:  rgb_out <= NUM3 [freq_r_num0][pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            4:  rgb_out <= NUM4 [freq_r_num0][pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            5:  rgb_out <= NUM5 [freq_r_num0][pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            6:  rgb_out <= NUM6 [freq_r_num0][pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            7:  rgb_out <= NUM7 [freq_r_num0][pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            8:  rgb_out <= NUM8 [freq_r_num0][pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            9:  rgb_out <= NUM9 [freq_r_num0][pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            10: rgb_out <= NUM10[freq_r_num0][pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            11: rgb_out <= NUM11[freq_r_num0][pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            12: rgb_out <= NUM12[freq_r_num0][pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            13: rgb_out <= NUM13[freq_r_num0][pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            14: rgb_out <= NUM14[freq_r_num0][pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            15: rgb_out <= NUM15[freq_r_num0][pix_h_pos] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                        endcase
                    end else begin
                        rgb_out <= `BACKGROUND_COLOR;
                    end
                end else if (pix_h_pos < 16) begin
                    if (ren[3]) begin
                        case (pix_v_pos)
                            0:  rgb_out <= NUM0 [freq_r_num1][pix_h_pos - 8] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            1:  rgb_out <= NUM1 [freq_r_num1][pix_h_pos - 8] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            2:  rgb_out <= NUM2 [freq_r_num1][pix_h_pos - 8] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            3:  rgb_out <= NUM3 [freq_r_num1][pix_h_pos - 8] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            4:  rgb_out <= NUM4 [freq_r_num1][pix_h_pos - 8] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            5:  rgb_out <= NUM5 [freq_r_num1][pix_h_pos - 8] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            6:  rgb_out <= NUM6 [freq_r_num1][pix_h_pos - 8] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            7:  rgb_out <= NUM7 [freq_r_num1][pix_h_pos - 8] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            8:  rgb_out <= NUM8 [freq_r_num1][pix_h_pos - 8] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            9:  rgb_out <= NUM9 [freq_r_num1][pix_h_pos - 8] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            10: rgb_out <= NUM10[freq_r_num1][pix_h_pos - 8] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            11: rgb_out <= NUM11[freq_r_num1][pix_h_pos - 8] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            12: rgb_out <= NUM12[freq_r_num1][pix_h_pos - 8] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            13: rgb_out <= NUM13[freq_r_num1][pix_h_pos - 8] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            14: rgb_out <= NUM14[freq_r_num1][pix_h_pos - 8] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            15: rgb_out <= NUM15[freq_r_num1][pix_h_pos - 8] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                        endcase
                    end else begin
                        rgb_out <= `BACKGROUND_COLOR;
                    end
                end else if (pix_h_pos < 24) begin
                    if (ren[2]) begin
                        case (pix_v_pos)
                            0:  rgb_out <= NUM0 [freq_r_num2][pix_h_pos - 16] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            1:  rgb_out <= NUM1 [freq_r_num2][pix_h_pos - 16] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            2:  rgb_out <= NUM2 [freq_r_num2][pix_h_pos - 16] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            3:  rgb_out <= NUM3 [freq_r_num2][pix_h_pos - 16] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            4:  rgb_out <= NUM4 [freq_r_num2][pix_h_pos - 16] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            5:  rgb_out <= NUM5 [freq_r_num2][pix_h_pos - 16] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            6:  rgb_out <= NUM6 [freq_r_num2][pix_h_pos - 16] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            7:  rgb_out <= NUM7 [freq_r_num2][pix_h_pos - 16] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            8:  rgb_out <= NUM8 [freq_r_num2][pix_h_pos - 16] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            9:  rgb_out <= NUM9 [freq_r_num2][pix_h_pos - 16] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            10: rgb_out <= NUM10[freq_r_num2][pix_h_pos - 16] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            11: rgb_out <= NUM11[freq_r_num2][pix_h_pos - 16] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            12: rgb_out <= NUM12[freq_r_num2][pix_h_pos - 16] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            13: rgb_out <= NUM13[freq_r_num2][pix_h_pos - 16] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            14: rgb_out <= NUM14[freq_r_num2][pix_h_pos - 16] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            15: rgb_out <= NUM15[freq_r_num2][pix_h_pos - 16] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                        endcase
                    end else begin
                        rgb_out <= `BACKGROUND_COLOR;
                    end
                end else if (pix_h_pos < 32) begin
                    if (ren[1]) begin
                        case (pix_v_pos)
                            0:  rgb_out <= NUM0 [freq_r_num3][pix_h_pos - 24] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            1:  rgb_out <= NUM1 [freq_r_num3][pix_h_pos - 24] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            2:  rgb_out <= NUM2 [freq_r_num3][pix_h_pos - 24] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            3:  rgb_out <= NUM3 [freq_r_num3][pix_h_pos - 24] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            4:  rgb_out <= NUM4 [freq_r_num3][pix_h_pos - 24] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            5:  rgb_out <= NUM5 [freq_r_num3][pix_h_pos - 24] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            6:  rgb_out <= NUM6 [freq_r_num3][pix_h_pos - 24] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            7:  rgb_out <= NUM7 [freq_r_num3][pix_h_pos - 24] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            8:  rgb_out <= NUM8 [freq_r_num3][pix_h_pos - 24] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            9:  rgb_out <= NUM9 [freq_r_num3][pix_h_pos - 24] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            10: rgb_out <= NUM10[freq_r_num3][pix_h_pos - 24] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            11: rgb_out <= NUM11[freq_r_num3][pix_h_pos - 24] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            12: rgb_out <= NUM12[freq_r_num3][pix_h_pos - 24] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            13: rgb_out <= NUM13[freq_r_num3][pix_h_pos - 24] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            14: rgb_out <= NUM14[freq_r_num3][pix_h_pos - 24] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            15: rgb_out <= NUM15[freq_r_num3][pix_h_pos - 24] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                        endcase
                    end else begin
                        rgb_out <= `BACKGROUND_COLOR;
                    end
                end else begin
                    if (ren[0]) begin
                        case (pix_v_pos)
                            0:  rgb_out <= NUM0 [freq_r_num4][pix_h_pos - 32] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            1:  rgb_out <= NUM1 [freq_r_num4][pix_h_pos - 32] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            2:  rgb_out <= NUM2 [freq_r_num4][pix_h_pos - 32] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            3:  rgb_out <= NUM3 [freq_r_num4][pix_h_pos - 32] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            4:  rgb_out <= NUM4 [freq_r_num4][pix_h_pos - 32] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            5:  rgb_out <= NUM5 [freq_r_num4][pix_h_pos - 32] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            6:  rgb_out <= NUM6 [freq_r_num4][pix_h_pos - 32] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            7:  rgb_out <= NUM7 [freq_r_num4][pix_h_pos - 32] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            8:  rgb_out <= NUM8 [freq_r_num4][pix_h_pos - 32] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            9:  rgb_out <= NUM9 [freq_r_num4][pix_h_pos - 32] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            10: rgb_out <= NUM10[freq_r_num4][pix_h_pos - 32] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            11: rgb_out <= NUM11[freq_r_num4][pix_h_pos - 32] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            12: rgb_out <= NUM12[freq_r_num4][pix_h_pos - 32] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            13: rgb_out <= NUM13[freq_r_num4][pix_h_pos - 32] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            14: rgb_out <= NUM14[freq_r_num4][pix_h_pos - 32] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                            15: rgb_out <= NUM15[freq_r_num4][pix_h_pos - 32] ? `INNER_TEXT_COLOR : `BACKGROUND_COLOR;
                        endcase
                    end else begin
                        rgb_out <= `BACKGROUND_COLOR;
                    end
                end
            end else if (border_valid_area) begin
                rgb_out <= `BACKGROUND_COLOR;
            end else begin
                rgb_out <= `MARGIN_COLOR;
            end
        end
    end

endmodule
