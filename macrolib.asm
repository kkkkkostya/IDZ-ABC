# ���������� ��������

.macro fillel (%x) # ���������� ��������
   li a7, 5
   ecall
   mv %x, a0
.end_macro

.macro printel (%x) # ����� ��������
   mv a0, %x
   li a7, 1
   ecall
.end_macro

