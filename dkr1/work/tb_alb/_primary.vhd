library verilog;
use verilog.vl_types.all;
entity tb_alb is
    generic(
        W               : integer := 10
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of W : constant is 1;
end tb_alb;
