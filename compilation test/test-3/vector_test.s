.section .text
.global _start
_start:
    vsetvli x0, x0, e8, m1   # 设置元素宽度为8位，向量寄存器为1
    ret
