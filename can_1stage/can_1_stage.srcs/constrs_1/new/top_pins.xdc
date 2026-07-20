# Zybo Z7-20 Pmod JB 接口约束
# 将 Block Design 中的端口映射到物理引脚
# JE1 (V8) 和 JE2 (W8)

set_property -dict {PACKAGE_PIN V12 IOSTANDARD LVCMOS33} [get_ports CAN_0_0_tx]
set_property -dict {PACKAGE_PIN W16 IOSTANDARD LVCMOS33} [get_ports CAN_0_0_rx]