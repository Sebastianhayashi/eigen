.section .text
.global _start
_start:
    vsetvli x0, x0, e32,m8  # 设置向量长度
    ret
