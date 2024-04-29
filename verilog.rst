=======================
System Verilog 学习笔记
=======================



阻塞赋值与非阻塞赋值
====================

原则1：时序电路建模时，用非阻塞赋值。
原则2：锁存器电路建模时，用非阻塞赋值。
原则3：用always块写组合逻辑时，采用阻塞赋值。
原则4：在同一个always块中同时建立时序和组合逻辑电路时，用非阻塞赋值。
原则5：在同一个always块中不要同时使用非阻塞赋值和阻塞赋值。

在描述组合逻辑电路的时候，使用阻塞赋值，比如assigin赋值语句和不带时钟的always赋值语句，这种电路结构只与输入电平的变化有关系。

.. code-block:: verilog
    // Demo1: assign赋值语句
    assign data = (data_en == 1'b1) ? 8'd255 : 8'd0;

    // Demo2: 不带时钟的always语句
    always @(*) begin
        if (en) begin
            a = a0;
            b = b0;
        end else begin
            a = a1;
            b = b1;
        end
    end

在描述时序逻辑的时候，使用非阻塞赋值，综合成时序逻辑的电路结构，比如带时钟的always语句；这种电路结构往往与触发沿有关系，只有在触发沿时才可能发生赋值的变化。

.. code-block:: verilog
    // Demo3:
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (!sys_rst_n) begin
            a <= 1'b0;
            b <= 1'b0;
        end else begin
            a <= c;
            b <= d;
        end
    end

有限状态机 -- Finite State Machine(FSM)
=======================================

状态机是许多数字系统的核心部件，是一类重要的时序逻辑电路。通常包括三个部分：一是下一个状态的逻辑电路，二是存储状态机当前状态的时序逻辑电路，三是输出组合逻辑电路。通常，状态的状态数量有限，称为有限状态机（FSM）。由于状态机所有触发器的时钟由同一脉冲边沿触发，故也称为同步状态机。

根据状态机的输出信号是否与电路的输入有关，分为Mealy型状态机和Moore型状态机。电路的输出信号不仅与电路当前状态有关，还与电路的输入有关，称为Mealy型状态机，而电路的输出仅仅与各触发器的状态有关，不受电路输入信号影响或无输入，称为Moore型状态机。

Basic SV3.1 Data Types
======================

.. code-block:: verilog

    reg r;      // 4-value Verilog-2001 single-bit datatype
    integer i;  // 4-value Verilog-2001 >= 32-bit datatype
    bit b;      // single bit 0 or 1
    logic w;    // 4-value logic, x 0 1 or z as in verilog
    byte b;     // 2-value, 8 bit signed integer
    int i;      // 2-value, 32-bit signed integer
    shortint s; // 2-value, 16-bit signed integer
    logint l;   // 2-value, 64-bit signed integer
