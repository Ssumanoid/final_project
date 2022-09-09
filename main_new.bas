PTP SETON 				'�����׷캰 ���������� ����
PTP ALLON				'��ü���� ������ ���� ����

DIR G6A,1,0,0,1,0,0		'����0~5��
DIR G6D,0,1,1,0,1,1		'����18~23��
DIR G6B,1,1,1,1,1,1		'����6~11��
DIR G6C,0,0,0,0,1,0		'����12~17��

OUT 52,0	'�Ӹ� LED �ѱ�

SPEED 5
GOSUB MOTOR_ON

S11=MOTORIN(11)
S16=MOTORIN(16)

SERVO 11,100
SERVO 16, S16
SERVO 16,100

GOSUB �����ʱ��ڼ�
GOSUB �⺻�ڼ�


GOSUB ���̷�INIT
GOSUB ���̷�MID
GOSUB ���̷�ON

PRINT "VOLUME 100 !"
PRINT "SOUND 12 !" '�ȳ��ϼ���

GOSUB All_motor_mode3


MOTOR_ON: '����Ʈ�������ͻ�뼳��

    GOSUB MOTOR_GET

    MOTOR G6B
    DELAY 50
    MOTOR G6C
    DELAY 50
    MOTOR G6A
    DELAY 50
    MOTOR G6D

    ����ONOFF = 0
    GOSUB ������	
    RETURN
    

�����ʱ��ڼ�:
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6B,100,  35,  90,
    MOVE G6C,100,  35,  90
    WAIT
    mode = 0
    RETURN
    
    
���̷�INIT:

    GYRODIR G6A, 0, 0, 1, 0,0
    GYRODIR G6D, 1, 0, 1, 0,0

    GYROSENSE G6A,200,150,30,150,0
    GYROSENSE G6D,200,150,30,150,0

    RETURN
    

���̷�MID:

    GYROSENSE G6A,200,150,30,150,0
    GYROSENSE G6D,200,150,30,150,0

    RETURN
    
    
���̷�ON:

    GYROSET G6A, 4, 3, 3, 3, 0
    GYROSET G6D, 4, 3, 3, 3, 0

    ���̷�ONOFF = 1

    RETURN
    
    
All_motor_mode3:

    MOTORMODE G6A,3,3,3,3,3
    MOTORMODE G6D,3,3,3,3,3
    MOTORMODE G6B,3,3,3,,,3
    MOTORMODE G6C,3,3,3,,3

    RETURN
    
'*********�������� �����*********

DIM ready AS BYTE
DIM _rx AS BYTE
DIM dis AS INTEGER

ready=0

'******************************

GOTO MAIN


�⺻�ڼ�:
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6B,100,  30,  80, 100, 100, 100
    MOVE G6C,100,  30,  80, 100, 100, 100
    WAIT     
    RETURN
    
    
����Ƚ������50:'�Լ� ȣ��ø��� ����Ƚ�� �� �����ʿ�
    �ݺ�Ƚ�� = 0
    GOSUB Leg_motor_mode3     
    IF ������� = 0 THEN
        ������� = 1         
        SPEED 3         '�����ʱ���
        MOVE G6A, 88,  71, 152,  91, 110
        MOVE G6D,108,  76, 146,  93,  94
        MOVE G6B,100,35
        MOVE G6C,100,35,80, 100, 25, 100     
        WAIT
        SPEED 10'����ӵ�         '�޹ߵ��
        MOVE G6A, 90, 100, 115, 105, 114
        MOVE G6D,113,  78, 146,  93,  94
        MOVE G6B,90
        MOVE G6C,110
        WAIT
        GOTO ����Ƚ������50_1     
    ELSE
        ������� = 0         
        SPEED 3         '���ʱ���
        MOVE G6D,  88,  71, 152,  91, 110
        MOVE G6A, 108,  76, 146,  93,  94
        MOVE G6C, 100,35,80, 100, 25, 100
        MOVE G6B, 100,35
        WAIT
        SPEED 10'����ӵ�         '�����ߵ��
        MOVE G6D, 90, 100, 115, 105, 114
        MOVE G6A,113,  78, 146,  93,  94
        MOVE G6C,90
        MOVE G6B,110
        WAIT
        GOTO ����Ƚ������50_2
    ENDIF
    RETURN
    
      
����Ƚ������50_1:
    �ݺ�Ƚ�� = �ݺ�Ƚ�� + 1     
    SPEED 10
    '�޹߻�������
    MOVE G6A, 85,  44, 163, 113, 114     
    MOVE G6D,110,  77, 146,  93,  94     
    WAIT
    SPEED 4     '�޹��߽��̵�
    MOVE G6A,110,  76, 144, 100,  93     
    MOVE G6D,85, 93, 155,  71, 112     
    WAIT
    SPEED 10     '�����ߵ��10
    MOVE G6A,111,  77, 146,  93, 94
    MOVE G6D,90, 100, 105, 110, 114
    MOVE G6B,110
    MOVE G6C,90
    WAIT
    IF �ݺ�Ƚ�� >= ����Ƚ�� THEN         
        HIGHSPEED SETOFF         
        SPEED 5
        '���ʱ���2
        MOVE G6A, 106,  76, 146,  93,  96
        MOVE G6D,  88,  71, 152,  91, 106
        MOVE G6B, 100,35
        MOVE G6C, 100,35
        WAIT
        SPEED 3
        'GOSUB �⺻�ڼ�         
        GOSUB Leg_motor_mode1
        GOTO MAIN     
    ENDIF
    RETURN
    
    
����Ƚ������50_2:
    �ݺ�Ƚ�� = �ݺ�Ƚ�� + 1     
    SPEED 10
    '�����߻�������
    MOVE G6D,85,  44, 163, 113, 114     
    MOVE G6A,110,  77, 146,  93,  94     
    WAIT
    SPEED 4
    '�������߽��̵�
    MOVE G6D,110,  76, 144, 100,  93     
    MOVE G6A, 85, 93, 155,  71, 112     
    WAIT
    SPEED 10     '�޹ߵ��10
    MOVE G6A, 90, 100, 105, 110, 114
    MOVE G6D,111,  77, 146,  93,  94
    MOVE G6B, 90
    MOVE G6C,110
    WAIT
    IF �ݺ�Ƚ�� >= ����Ƚ�� THEN
        HIGHSPEED SETOFF      
        SPEED 5
        '�����ʱ���2
        MOVE G6D, 106,  76, 146,  93,  96
        MOVE G6A,  88,  71, 152,  91, 106
        MOVE G6C, 100,35
        MOVE G6B, 100,35
        WAIT
        SPEED 3
        'GOSUB �⺻�ڼ�     
        GOSUB Leg_motor_mode1         
        GOTO MAIN
    ENDIF
    GOTO ����Ƚ������50_1


'�κ����������� goto�� �Լ����� return���� ��� ��� �Ǵ°�? 
'���� �ֱ� gosub�� ȣ���� �κ����� ���ư��ٰ� �����ϰ� �ڵ�
GET_RX_FAILED:
	_rx=0
	RETURN


GET_RX:'save rx value to variable _rx
	ERX 4800,_rx,GET_RX_FAILED
	RETURN


MAIN:
	GOSUB GET_RX
	
	IF _rx=1 THEN
		IF ready=0 THEN
			ready=1
			PRINT "SOUND 12 !"
		ELSE
			ready=0
		ENDIF
	ENDIF
	
	IF ready=1 THEN
    	dis=AD(4)
    	IF dis>50 THEN
    		GOSUB �⺻�ڼ�
    		ETX 4800,151
    		GOTO CHECKALPHA
    	ELSE
    		IF dis_old>50 THEN
    			MOVE G6C,100,  30,  80, 100, 25, 100
    		ENDIF
    		ETX 4800,150
    		GOTO CHECKLINE
    	ENDIF
	ENDIF
	
	GOTO MAIN
	
	







