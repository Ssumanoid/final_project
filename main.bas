'******** 2�� ����κ� �ʱ� ���� ���α׷� ********

DIM I AS BYTE
DIM J AS BYTE
DIM MODE AS BYTE
DIM A AS BYTE
DIM A_old AS BYTE
DIM B AS BYTE
DIM C AS BYTE
DIM ����ӵ� AS BYTE
DIM �¿�ӵ� AS BYTE
DIM �¿�ӵ�2 AS BYTE
DIM ������� AS BYTE
DIM �������� AS BYTE
DIM ����üũ AS BYTE
DIM ����ONOFF AS BYTE
DIM ���̷�ONOFF AS BYTE
DIM ����յ� AS INTEGER
DIM �����¿� AS INTEGER

DIM ����� AS BYTE

DIM �Ѿ���Ȯ�� AS BYTE
DIM ����Ȯ��Ƚ�� AS BYTE
DIM ����Ƚ�� AS BYTE
DIM ����COUNT AS BYTE

DIM ���ܼ��Ÿ���  AS BYTE

DIM S11  AS BYTE
DIM S16  AS BYTE
'************************************************
DIM NO_0 AS BYTE
DIM NO_1 AS BYTE
DIM NO_2 AS BYTE
DIM NO_3 AS BYTE
DIM NO_4 AS BYTE

DIM NUM AS BYTE

DIM BUTTON_NO AS INTEGER
DIM SOUND_BUSY AS BYTE
DIM TEMP_INTEGER AS INTEGER

'**** ���⼾����Ʈ ���� ****
CONST �յڱ���AD��Ʈ = 0
CONST �¿����AD��Ʈ = 1
CONST ����Ȯ�νð� = 20  'ms

CONST ���ܼ�AD��Ʈ  = 4
7

CONST min = 61	'�ڷγѾ�������
CONST max = 107	'�����γѾ�������
CONST COUNT_MAX = 3


CONST �Ӹ��̵��ӵ� = 10
'************************************************



PTP SETON 				'�����׷캰 ���������� ����
PTP ALLON				'��ü���� ������ ���� ����

DIR G6A,1,0,0,1,0,0		'����0~5��
DIR G6D,0,1,1,0,1,1		'����18~23��
DIR G6B,1,1,1,1,1,1		'����6~11��
DIR G6C,0,0,0,0,1,0		'����12~17��

'************************************************

OUT 52,0	'�Ӹ� LED �ѱ�
'***** �ʱ⼱�� '************************************************

������� = 0
����üũ = 0
����Ȯ��Ƚ�� = 0
����Ƚ�� = 1
����ONOFF = 0

'****�ʱ���ġ �ǵ��*****************************


TEMPO 230
MUSIC "cdefg"



SPEED 5
GOSUB MOTOR_ON

S11 = MOTORIN(11)
S16 = MOTORIN(16)

SERVO 11, 100
SERVO 16, S16

SERVO 16, 100


GOSUB �����ʱ��ڼ�
GOSUB �⺻�ڼ�


GOSUB ���̷�INIT
GOSUB ���̷�MID
GOSUB ���̷�ON



PRINT "VOLUME 200 !"
PRINT "SOUND 12 !" '�ȳ��ϼ���

GOSUB All_motor_mode3


'************************************************
DIM �ݺ�Ƚ�� AS BYTE
DIM arrow AS INTEGER
arrow=0
DIM dis AS INTEGER
DIM dis_old AS INTEGER
dis=0
dis_old=0
DIM go AS BYTE
go=0


GOTO MAIN	'�ø��� ���� ��ƾ��

MAIN:
	IF go=0 THEN
		ERX 4800,A,MAIN
		IF A=128  THEN
			PRINT "SOUND 12 !"
			go=1
		ENDIF
	ENDIF
	
    IF arrow=0 THEN
    	dis_old=dis
    	dis=0
    	GOSUB ���ܼ��Ÿ�����Ȯ��
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

CHECKLINE:
	
	ERX 4800,A,CHECKLINE
	A_old = A
	
	
	IF A=160 THEN
   		����Ƚ��= 1
     	GOTO ����Ƚ������50
    ELSEIF A=161 THEN
    	GOTO ������10
    ELSEIF A=162 THEN
    	GOTO ��������10
	ELSEIF A=163 THEN
    	GOTO ���ӿ��ʿ�����70
    ELSEIF A=164 THEN
    	GOTO ���ӿ����ʿ�����70
    ELSE
    	GOTO MAIN
	ENDIF
	

CHECKALPHA:
	ERX 4800,A,CHECKALPHA
	
	IF A=140 THEN
     	GOTO East
    ELSEIF A=141 THEN
    	GOTO West
    ELSEIF A=142 THEN
    	GOTO South
	ELSEIF A=143 THEN
    	GOTO North
    ELSE
    	GOTO MAIN
	ENDIF
    
East:
	MOVE G6A,100, 56, 182, 76, 100, 100
    MOVE G6D,100, 56, 182, 76, 100, 100
    MOVE G6B,100,  30,  80
	MOVE G6C,190,  30,  80
	GOTO MAIN
West:
	MOVE G6A,100, 56, 182, 76, 100, 100
    MOVE G6D,100, 56, 182, 76, 100, 100
    MOVE G6B,190,  30,  80
	MOVE G6C,100,  30,  80
	GOTO MAIN
North:
	MOVE G6A,100, 56, 182, 76, 100, 100
    MOVE G6D,100, 56, 182, 76, 100, 100
    MOVE G6B,190,  30,  80
	MOVE G6C,190,  30,  80
	GOTO MAIN
South:
	MOVE G6A,100, 56, 182, 76, 100, 100
    MOVE G6D,100, 56, 182, 76, 100, 100
    MOVE G6B,10,  30,  80
	MOVE G6C,10,  30,  80
	GOTO MAIN
    
    '************************************* 
����Ƚ������50:
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
    '*********************************************
������10:
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2
    SPEED 5
    MOVE G6A,97,  86, 145,  83, 103, 100
    MOVE G6D,97,  66, 145,  103, 103, 100
    WAIT

    SPEED 12
    MOVE G6A,94,  86, 145,  83, 101, 100
    MOVE G6D,94,  66, 145,  103, 101, 100
    WAIT

    SPEED 6
    MOVE G6A,101,  76, 146,  93, 98, 100
    MOVE G6D,101,  76, 146,  93, 98, 100
    WAIT
    DELAY 300
    'ERX 4800,A,������10     
    'IF A <> A_old THEN
    	
     '   GOTO MAIN     
    'ENDIF
  	GOTO MAIN
    GOTO ������10

    '**********************************************
��������10:
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2
    SPEED 5
    MOVE G6A,97,  66, 145,  103, 103, 100
    MOVE G6D,97,  86, 145,  83, 103, 100
    WAIT

    SPEED 12
    MOVE G6A,94,  66, 145,  103, 101, 100
    MOVE G6D,94,  86, 145,  83, 101, 100
    WAIT
    SPEED 6
    MOVE G6A,101,  76, 146,  93, 98, 100
    MOVE G6D,101,  76, 146,  93, 98, 100
    WAIT
    DELAY 300
    'ERX 4800,A,��������10
    'IF A <> A_old THEN
    	
     '   GOTO MAIN     
    'ENDIF
    GOTO MAIN
    GOTO ��������10
    
    '********************************************** 
������20:
    GOSUB Leg_motor_mode2     
    SPEED 8
    MOVE G6A,95,  96, 145,  73, 105, 100
    MOVE G6D,95,  56, 145,  113, 105, 100
    MOVE G6B,110
    MOVE G6C,90
    WAIT     
    SPEED 12
    MOVE G6A,93,  96, 145,  73, 105, 100     
    MOVE G6D,93,  56, 145,  113, 105, 100     
    WAIT
    SPEED 6
    MOVE G6A,101,  76, 146,  93, 98, 100
    MOVE G6D,101,  76, 146,  93, 98, 100
    MOVE G6B,100,  30,  80
    MOVE G6C,100,  30,  80
    WAIT
    GOSUB Leg_motor_mode1     
    GOTO MAIN

'********************************************** 
��������20:
    GOSUB Leg_motor_mode2     
    SPEED 8
    MOVE G6A,95,  56, 145,  113, 105, 100
    MOVE G6D,95,  96, 145,  73, 105, 100
    MOVE G6B,90
    MOVE G6C,110
    WAIT     
    SPEED 12
    MOVE G6A,93,  56, 145,  113, 105, 100     
    MOVE G6D,93,  96, 145,  73, 105, 100     
    WAIT
    SPEED 6
    MOVE G6A,101,  76, 146,  93, 98, 100
    MOVE G6D,101,  76, 146,  93, 98, 100
    MOVE G6B,100,  30,  80
    MOVE G6C,100,  30,  80
    WAIT
    GOSUB Leg_motor_mode1     
    GOTO MAIN
    '**********************************************
���ӿ����ʿ�����70:
    SPEED 5
    MOVE G6D, 90,  90, 120, 105, 110, 100
    MOVE G6A,100,  76, 146,  93, 107, 100
    MOVE G6B,100,  40
    MOVE G6C,100,  40
    WAIT     
    SPEED 5
    MOVE G6D, 102,  76, 147, 93, 100, 100     
    MOVE G6A,83,  78, 140,  96, 115, 100     
    WAIT
    SPEED 5
    MOVE G6D,98,  76, 146,  93, 100, 100     
    MOVE G6A,98,  76, 146,  93, 100, 100     
    WAIT
    SPEED 5
    MOVE G6A,100,  76, 145,  93, 100, 100     
    MOVE G6D,100,  76, 145,  93, 100, 100     
    WAIT
    DELAY 300 
    GOTO MAIN     
    GOTO ���ӿ����ʿ�����70     
 	 '*************
���ӿ��ʿ�����70:     
	SPEED 5
    MOVE G6A, 90,  90, 120, 105, 110, 100
    MOVE G6D,100,  76, 146,  93, 107, 100
    MOVE G6B,100,  40
    MOVE G6C,100,  40
    WAIT     
    SPEED 5
    MOVE G6A, 102,  76, 147, 93, 100, 100     
    MOVE G6D,83,  78, 140,  96, 115, 100     
    WAIT
    SPEED 5
    MOVE G6A,98,  76, 146,  93, 100, 100     
    MOVE G6D,98,  76, 146,  93, 100, 100     
    WAIT
    SPEED 5
    MOVE G6A,100,  76, 145,  93, 100, 100     
    MOVE G6D,100,  76, 145,  93, 100, 100     
    WAIT
    DELAY 300 
                
    GOTO MAIN     
    GOTO ���ӿ��ʿ�����70
'************************************************  
    
    
    
	'************************************* 
Leg_motor_mode3:
    MOTORMODE G6A,3,3,3,3,3     
    MOTORMODE G6D,3,3,3,3,3     
    RETURN
    '*************************************
 
Leg_motor_mode2:
    MOTORMODE G6A,2,2,2,2,2     
    MOTORMODE G6D,2,2,2,2,2
    RETURN

 '*************************************
Leg_motor_mode1:
    MOTORMODE G6A,1,1,1,1,1     
    MOTORMODE G6D,1,1,1,1,1     
    RETURN
    '*******�⺻�ڼ�����********************
�⺻�ڼ�:
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6B,100,  30,  80, 100, 100, 100
    MOVE G6C,100,  30,  80, 100, 100, 100
    WAIT     
    RETURN
    '*************************************
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

    '************************************************
    '����Ʈ�������ͻ�뼳��
MOTOR_OFF:

    MOTOROFF G6B
    MOTOROFF G6C
    MOTOROFF G6A
    MOTOROFF G6D
    ����ONOFF = 1	
    GOSUB MOTOR_GET	
    GOSUB ������	
    RETURN
    '************************************************
    '��ġ���ǵ��
MOTOR_GET:
    GETMOTORSET G6A,1,1,1,1,1,0
    GETMOTORSET G6B,1,1,1,0,0,1
    GETMOTORSET G6C,1,1,1,0,1,0
    GETMOTORSET G6D,1,1,1,1,1,0
    RETURN

    '************************************************
    '��ġ���ǵ��
MOTOR_SET:
    GETMOTORSET G6A,1,1,1,1,1,0
    GETMOTORSET G6B,1,1,1,0,0,1
    GETMOTORSET G6C,1,1,1,0,1,0
    GETMOTORSET G6D,1,1,1,1,1,0
    RETURN

    '************************************************
All_motor_Reset:

    MOTORMODE G6A,1,1,1,1,1,1
    MOTORMODE G6D,1,1,1,1,1,1
    MOTORMODE G6B,1,1,1,,,1
    MOTORMODE G6C,1,1,1,,1

    RETURN
    '************************************************
All_motor_mode2:

    MOTORMODE G6A,2,2,2,2,2
    MOTORMODE G6D,2,2,2,2,2
    MOTORMODE G6B,2,2,2,,,2
    MOTORMODE G6C,2,2,2,,2

    RETURN
    '************************************************
All_motor_mode3:

    MOTORMODE G6A,3,3,3,3,3
    MOTORMODE G6D,3,3,3,3,3
    MOTORMODE G6B,3,3,3,,,3
    MOTORMODE G6C,3,3,3,,3

    RETURN
    
   '************************************************
  
�����ʱ��ڼ�:
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6B,100,  35,  90,
    MOVE G6C,100,  35,  90
    WAIT
    mode = 0
    RETURN
    '************************************************
����ȭ�ڼ�:
    MOVE G6A,98,  76, 145,  93, 101, 100
    MOVE G6D,98,  76, 145,  93, 101, 100
    MOVE G6B,100,  35,  90,
    MOVE G6C,100,  35,  90
    WAIT
    mode = 0

    RETURN
    '**** ���̷ΰ��� ���� ****
���̷�INIT:

    GYRODIR G6A, 0, 0, 1, 0,0
    GYRODIR G6D, 1, 0, 1, 0,0

    GYROSENSE G6A,200,150,30,150,0
    GYROSENSE G6D,200,150,30,150,0

    RETURN
    '***********************************************
    '**** ���̷ΰ��� ���� ****
���̷�MAX:

    GYROSENSE G6A,250,180,30,180,0
    GYROSENSE G6D,250,180,30,180,0

    RETURN
    '***********************************************
���̷�MID:

    GYROSENSE G6A,200,150,30,150,0
    GYROSENSE G6D,200,150,30,150,0

    RETURN
    '***********************************************
���̷�MIN:

    GYROSENSE G6A,200,100,30,100,0
    GYROSENSE G6D,200,100,30,100,0
    RETURN
    '***********************************************
���̷�ON:

    GYROSET G6A, 4, 3, 3, 3, 0
    GYROSET G6D, 4, 3, 3, 3, 0

    ���̷�ONOFF = 1

    RETURN
    '***********************************************
���̷�OFF:

    GYROSET G6A, 0, 0, 0, 0, 0
    GYROSET G6D, 0, 0, 0, 0, 0
    ���̷�ONOFF = 0
    RETURN

    '************************************************
'************************************************
������:
    TEMPO 220
    MUSIC "O23EAB7EA>3#C"
    RETURN
    '************************************************
������:
    TEMPO 220
    MUSIC "O38GD<BGD<BG"
    RETURN
���ܼ��Ÿ�����Ȯ��:
    ���ܼ��Ÿ��� = AD(���ܼ�AD��Ʈ)
    IF ���ܼ��Ÿ��� > 50 THEN '50 = ���ܼ��Ÿ��� = 25cm
    	dis=���ܼ��Ÿ���
        MUSIC "C"
        DELAY 200
    ENDIF

    RETURN