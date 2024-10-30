.section .text
.global _start
_start:
    vsetvli x0, x0, e32, m1   # 设置向量长度为 32 位，向量寄存器为 1
    ret
