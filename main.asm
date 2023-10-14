.include "macrolib.asm"	

.data
n:	.word	0		# ����� ��������� ��������� �������
error:  .asciz  "incorrect n!\n"  # ��������� � ������������ �����
sep:    .asciz  "\n"    # ������-����������� (� \n � ���� � �����)
printNewArr: .asciz "New array: "
printOldArr: .asciz "Old array: "
array:  .space  40             # �������� 40 ����
prompt: .asciz  "n = "         # ��������� ��� ����� �����
arrsep: .asciz  " "	# separator

.text
.globl main
main:
	# �������� ����� �������� a0, 
	# � ������� ����� ���������� ����������� ��������
	fillel (a0)             # ��������� n
	mv      t3 a0           # ��������� ��������� � t3 (��� n)
        ble     t3 zero fail    # �� ������, ���� ������ 1
        li      t4 10           # ������ �������
        bgt     t3 t4 fail      # �� ������, ���� ������ 10
        
        la	t4 n		# ����� n � t4
        sw	t3 (t4)		# �������� n � ������ �� ��������
        
        la      t0 array        # ��������� ������� �������� �������
        
       	jal fillArr # ��������� ������
       	
       	lw	t3 n		# ����� ��������� �������
        la	t0 array
       	
       	la      a0 printOldArr
        li      a7 4
        ecall
        
        jal printArr		# ������� ������ A
       	
        lw	t3 n		# ����� ��������� �������
        la	t0 array
	
	jal createNewArr	# ������� ������ B �� ������ A
	
	
	lw	t3 n		# ����� ��������� �������
        la	t0 array
        
        
        la      a0 printNewArr          
        li      a7 4
        ecall
        
        jal printArr		# ������� ������ B 

        li      a7 10           # �������
        ecall
	
	
# ��������� ������, �������� �������� � ����������
fillArr:
	# � t0 ����� ������ �������
	# � t3 ����� n - ���-�� ��������� � �������
        fillel (t2)		# ��������� ������� � ������� �������
        
	sw      t2 (t0)         # ������ ����� �� ������ � t0
        addi    t0 t0 4         # �������� ����� �� ������ ����� � ������
        addi    t3 t3 -1        # �������� ���������� ���������� ��������� �� 1
        bnez    t3 fillArr         # ���� �������� ������ 0
        la      a0 sep          # ������� ������-�����������
        li      a7 4
        ecall
        ret
      
# ������� ������
printArr:
	# � t0 ����� ������ �������
	# � t3 ����� n - ���-�� ��������� � �������
	lw a0 (t0)         # ������ ����� �� ������ � t0
	
	printel (a0)       # ������� �������, ��������� ������
		
	la a0, arrsep		
	li a7, 4
   	ecall
	
        addi    t0 t0 4         # �������� ����� �� ������ ����� � ������
        
        
        addi    t3 t3 -1        # �������� ���������� ���������� ��������� �� 1
        bnez    t3 printArr         # ���� �������� ������ 0
        
        
        la      a0 sep          # ������� ������-�����������
        li      a7 4
        ecall
        ret


# �������� ����� ������, �� ������ �����������
createNewArr:
	# � t0 ����� ������ �������
	# � t3 ����� n - ���-�� ��������� � �������
	lw      a0 (t0)         # ������ ����� �� ������ � t0
	li t5, 5
	
	bgt a0,t5, more5	# �������� �������, ��� x>5
	li t5, -5
	blt a0,t5, less5	# �������� �������, ��� x<-5
	li a0, 0
	sw a0 (t0)
	
	cont:
	
        addi    t0 t0 4         # �������� ����� �� ������ ����� � ������
        
        
        addi    t3 t3 -1        # �������� ���������� ���������� ��������� �� 1
        bnez    t3 createNewArr         # ���� �������� ������ 0
        
        
        la      a0 sep          # ������� ������-�����������
        li      a7 4
        ecall
        ret
        
        
more5:		# ���������� 5 � ��������, ���� �� >5
	addi a0,a0,5
	sw a0 (t0)
	j cont
	
	
less5:		# �������� 5 �� ��������, ���� �� <-5
	addi a0,a0,-5
	sw a0 (t0)
	j cont
	
  
# ���� ������� ������������ �������� n
fail:
        la 	a0, error       # ��������� �� ������ ����� ����� ��������� �������
        li 	a7, 4           # ��������� ����� �4
        ecall
        li      a7 10           # �������
        ecall

        
        

	
	
