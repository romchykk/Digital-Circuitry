library verilog;
use verilog.vl_types.all;
entity Lab4_Variant is
    port(
        x3              : in     vl_logic;
        x2              : in     vl_logic;
        x1              : in     vl_logic;
        f_ddnf          : out    vl_logic;
        f_dknf          : out    vl_logic
    );
end Lab4_Variant;
