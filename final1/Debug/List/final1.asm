
;CodeVisionAVR C Compiler V3.12 Advanced
;(C) Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Build configuration    : Debug
;Chip type              : ATmega16
;Program type           : Application
;Clock frequency        : 8.000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 256 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': Yes
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: No
;Enhanced function parameter passing: Yes
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#define _MODEL_SMALL_

	#pragma AVRPART ADMIN PART_NAME ATmega16
	#pragma AVRPART MEMORY PROG_FLASH 16384
	#pragma AVRPART MEMORY EEPROM 512
	#pragma AVRPART MEMORY INT_SRAM SIZE 1024
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x60

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU GICR=0x3B
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0060
	.EQU __SRAM_END=0x045F
	.EQU __DSTACK_SIZE=0x0100
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	PUSH R26
	PUSH R27
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	POP  R27
	POP  R26
	ICALL
	.ENDM

	.MACRO __CALL2EX
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __EEPROMRDD
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z
	MOVW R30,R0
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _c=R4
	.DEF _c_msb=R5
	.DEF _i=R7

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  _ext_int0_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

;GLOBAL REGISTER VARIABLES INITIALIZATION
__REG_VARS:
	.DB  0x0,0x0,0x0,0x0

_0x3:
	.DB  0x1,0x2,0x4,0x8,0x10,0x20,0x40,0x80

__GLOBAL_INI_TBL:
	.DW  0x04
	.DW  0x04
	.DW  __REG_VARS*2

	.DW  0x08
	.DW  _ports
	.DW  _0x3*2

_0xFFFFFFFF:
	.DW  0

#define __GLOBAL_INI_TBL_PRESENT 1

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  GICR,R31
	OUT  GICR,R30
	OUT  MCUCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,__SRAM_START
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x160

	.CSEG
;
;#include <mega16.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;#include <delay.h>
;int c=0;
;
;unsigned char i =0;
;unsigned char ports[] = { 0x01,0x02,0x04,0x08,0x10,0x20,0x40,0x80 } ;

	.DSEG
;interrupt [EXT_INT0] void ext_int0_isr(void)
; 0000 0009 {

	.CSEG
_ext_int0_isr:
; .FSTART _ext_int0_isr
	ST   -Y,R0
	ST   -Y,R1
	ST   -Y,R15
	ST   -Y,R22
	ST   -Y,R23
	ST   -Y,R24
	ST   -Y,R25
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0000 000A 
; 0000 000B 
; 0000 000C       if(PIND.2==1 & c==0){
	RCALL SUBOPT_0x0
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	CALL __EQW12
	AND  R30,R0
	BREQ _0x4
; 0000 000D 
; 0000 000E       c++;
	MOVW R30,R4
	ADIW R30,1
	MOVW R4,R30
; 0000 000F 
; 0000 0010          for(i=0;i<8;i++)
	CLR  R7
_0x6:
	LDI  R30,LOW(8)
	CP   R7,R30
	BRSH _0x7
; 0000 0011        {
; 0000 0012        PORTA=ports[i];
	RCALL SUBOPT_0x1
	RCALL SUBOPT_0x2
; 0000 0013        delay_ms(30);
; 0000 0014        PORTB=0X00;
	OUT  0x18,R30
; 0000 0015        PORTA=0X00;
	LDI  R30,LOW(0)
	OUT  0x1B,R30
; 0000 0016 
; 0000 0017        }
	INC  R7
	RJMP _0x6
_0x7:
; 0000 0018           for(i=0;i<8;i++)
	CLR  R7
_0x9:
	LDI  R30,LOW(8)
	CP   R7,R30
	BRSH _0xA
; 0000 0019        {
; 0000 001A        PORTB=ports[i];
	RCALL SUBOPT_0x1
	RCALL SUBOPT_0x3
; 0000 001B        delay_ms(30);
; 0000 001C        PORTA=0X00;
; 0000 001D        PORTB=0X00;
; 0000 001E 
; 0000 001F        }
	INC  R7
	RJMP _0x9
_0xA:
; 0000 0020           for(i=0;i<8;i++)
	CLR  R7
_0xC:
	LDI  R30,LOW(8)
	CP   R7,R30
	BRSH _0xD
; 0000 0021        {
; 0000 0022        PORTB=ports[7-i];
	RCALL SUBOPT_0x4
	RCALL SUBOPT_0x3
; 0000 0023        delay_ms(30);
; 0000 0024        PORTA=0X00;
; 0000 0025        PORTB=0X00;
; 0000 0026 
; 0000 0027        }
	INC  R7
	RJMP _0xC
_0xD:
; 0000 0028           for(i=0;i<8;i++)
	CLR  R7
_0xF:
	LDI  R30,LOW(8)
	CP   R7,R30
	BRSH _0x10
; 0000 0029        {
; 0000 002A        PORTA=ports[7-i];
	RCALL SUBOPT_0x4
	RCALL SUBOPT_0x2
; 0000 002B        delay_ms(30);
; 0000 002C        PORTA=0X00;
	OUT  0x1B,R30
; 0000 002D        PORTB=0X00;
	LDI  R30,LOW(0)
	OUT  0x18,R30
; 0000 002E 
; 0000 002F        };
	INC  R7
	RJMP _0xF
_0x10:
; 0000 0030 
; 0000 0031       }
; 0000 0032         if(PIND.2==1 & c==1)
_0x4:
	RCALL SUBOPT_0x0
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	CALL __EQW12
	AND  R30,R0
	BREQ _0x11
; 0000 0033         {
; 0000 0034         c++;
	MOVW R30,R4
	ADIW R30,1
	MOVW R4,R30
; 0000 0035            for(i=0;i<8;i++)
	CLR  R7
_0x13:
	LDI  R30,LOW(8)
	CP   R7,R30
	BRSH _0x14
; 0000 0036        {
; 0000 0037        PORTA=ports[i];
	RCALL SUBOPT_0x1
	OUT  0x1B,R30
; 0000 0038        PORTB=ports[7-i];
	RCALL SUBOPT_0x4
	RCALL SUBOPT_0x5
; 0000 0039        delay_ms(30);
; 0000 003A        PORTB=0X00;
; 0000 003B        PORTA=0X00;
; 0000 003C 
; 0000 003D        }
	INC  R7
	RJMP _0x13
_0x14:
; 0000 003E           for(i=0;i<8;i++)
	CLR  R7
_0x16:
	LDI  R30,LOW(8)
	CP   R7,R30
	BRSH _0x17
; 0000 003F        {
; 0000 0040        PORTB=ports[i];
	RCALL SUBOPT_0x1
	OUT  0x18,R30
; 0000 0041        PORTA=ports[7-i];
	RCALL SUBOPT_0x4
	RCALL SUBOPT_0x2
; 0000 0042        delay_ms(30);
; 0000 0043        PORTA=0X00;
	OUT  0x1B,R30
; 0000 0044        PORTB=0X00;
	LDI  R30,LOW(0)
	OUT  0x18,R30
; 0000 0045 
; 0000 0046        }
	INC  R7
	RJMP _0x16
_0x17:
; 0000 0047 
; 0000 0048         }
; 0000 0049          if(PIND.2==1 & c==2){
_0x11:
	RCALL SUBOPT_0x0
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	CALL __EQW12
	AND  R30,R0
	BREQ _0x18
; 0000 004A         c=0;
	CLR  R4
	CLR  R5
; 0000 004B           for(i=0;i<4;i++)
	CLR  R7
_0x1A:
	LDI  R30,LOW(4)
	CP   R7,R30
	BRSH _0x1B
; 0000 004C 
; 0000 004D        {
; 0000 004E            if(i==0){
	TST  R7
	BRNE _0x1C
; 0000 004F            PORTA=0x0c;
	RCALL SUBOPT_0x6
; 0000 0050            PORTB=0x30;
; 0000 0051            delay_ms(40);
; 0000 0052            PORTB=0X00;
; 0000 0053            PORTA=0X00;
; 0000 0054 
; 0000 0055 
; 0000 0056            }
; 0000 0057            if(i==1){
_0x1C:
	LDI  R30,LOW(1)
	CP   R30,R7
	BRNE _0x1D
; 0000 0058            PORTA=0x0F;
	RCALL SUBOPT_0x7
; 0000 0059            PORTB=0xF0;
; 0000 005A            delay_ms(40);
; 0000 005B            PORTB=0X00;
; 0000 005C            PORTA=0X00;}
; 0000 005D            if(i==2){
_0x1D:
	LDI  R30,LOW(2)
	CP   R30,R7
	BRNE _0x1E
; 0000 005E            PORTA=0xCF;
	RCALL SUBOPT_0x8
; 0000 005F            PORTB=0xF3;
; 0000 0060            delay_ms(40);
; 0000 0061            PORTB=0X00;
; 0000 0062            PORTA=0X00;}
; 0000 0063            if(i==3){
_0x1E:
	LDI  R30,LOW(3)
	CP   R30,R7
	BRNE _0x1F
; 0000 0064            PORTA=0xFF;
	RCALL SUBOPT_0x9
; 0000 0065            PORTB=0xFF;
; 0000 0066            delay_ms(40);
; 0000 0067            PORTB=0X00;
; 0000 0068            PORTA=0X00;}
; 0000 0069 
; 0000 006A        }
_0x1F:
	INC  R7
	RJMP _0x1A
_0x1B:
; 0000 006B                for(i=0;i<4;i++)
	CLR  R7
_0x21:
	LDI  R30,LOW(4)
	CP   R7,R30
	BRSH _0x22
; 0000 006C        {
; 0000 006D            if(i==0){
	TST  R7
	BRNE _0x23
; 0000 006E 
; 0000 006F            PORTA=0xFF;
	RCALL SUBOPT_0x9
; 0000 0070            PORTB=0xFF;
; 0000 0071            delay_ms(40);
; 0000 0072            PORTB=0X00;
; 0000 0073            PORTA=0X00;
; 0000 0074 
; 0000 0075 
; 0000 0076            }
; 0000 0077            if(i==1){
_0x23:
	LDI  R30,LOW(1)
	CP   R30,R7
	BRNE _0x24
; 0000 0078 
; 0000 0079            PORTA=0xCF;
	RCALL SUBOPT_0x8
; 0000 007A            PORTB=0xF3;
; 0000 007B            delay_ms(40);
; 0000 007C            PORTB=0X00;
; 0000 007D            PORTA=0X00;}
; 0000 007E            if(i==2){
_0x24:
	LDI  R30,LOW(2)
	CP   R30,R7
	BRNE _0x25
; 0000 007F             PORTA=0x0F;
	RCALL SUBOPT_0x7
; 0000 0080            PORTB=0xF0;
; 0000 0081            delay_ms(40);
; 0000 0082            PORTB=0X00;
; 0000 0083            PORTA=0X00;}
; 0000 0084            if(i==3){
_0x25:
	LDI  R30,LOW(3)
	CP   R30,R7
	BRNE _0x26
; 0000 0085            PORTA=0x0c;
	RCALL SUBOPT_0x6
; 0000 0086            PORTB=0x30;;
; 0000 0087            delay_ms(40);
; 0000 0088            PORTB=0X00;
; 0000 0089            PORTA=0X00;}
; 0000 008A 
; 0000 008B        }
_0x26:
	INC  R7
	RJMP _0x21
_0x22:
; 0000 008C 
; 0000 008D 
; 0000 008E        }
; 0000 008F 
; 0000 0090 }
_0x18:
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	LD   R25,Y+
	LD   R24,Y+
	LD   R23,Y+
	LD   R22,Y+
	LD   R15,Y+
	LD   R1,Y+
	LD   R0,Y+
	RETI
; .FEND
;
;void main (void) {
; 0000 0092 void main (void) {
_main:
; .FSTART _main
; 0000 0093 
; 0000 0094   unsigned char j =0;
; 0000 0095 
; 0000 0096  DDRB=0x00;
;	j -> R17
	LDI  R17,0
	LDI  R30,LOW(0)
	OUT  0x17,R30
; 0000 0097  PORTB=0X00;
	OUT  0x18,R30
; 0000 0098  DDRA=0x00;
	OUT  0x1A,R30
; 0000 0099  PORTA=0X00;
	OUT  0x1B,R30
; 0000 009A  PORTC.0=0;
	CBI  0x15,0
; 0000 009B  DDRC.0=1;
	SBI  0x14,0
; 0000 009C  PORTD.0=0;
	CBI  0x12,0
; 0000 009D  DDRD.0=0;
	CBI  0x11,0
; 0000 009E  GICR=0X40;
	LDI  R30,LOW(64)
	OUT  0x3B,R30
; 0000 009F  MCUCR=0X03;
	LDI  R30,LOW(3)
	OUT  0x35,R30
; 0000 00A0  GIFR=0X40;
	LDI  R30,LOW(64)
	OUT  0x3A,R30
; 0000 00A1  #asm("sei")
	sei
; 0000 00A2 
; 0000 00A3 
; 0000 00A4    while (1)
_0x2F:
; 0000 00A5    {
; 0000 00A6        if(PINC.0==1)
	SBIS 0x13,0
	RJMP _0x32
; 0000 00A7        {
; 0000 00A8          j++;
	SUBI R17,-1
; 0000 00A9 
; 0000 00AA         if(j==1){
	CPI  R17,1
	BRNE _0x33
; 0000 00AB           for(i=0;i<8;i++)
	CLR  R7
_0x35:
	LDI  R30,LOW(8)
	CP   R7,R30
	BRSH _0x36
; 0000 00AC        {
; 0000 00AD        PORTA=ports[i];
	RCALL SUBOPT_0x1
	RCALL SUBOPT_0x2
; 0000 00AE        delay_ms(30);
; 0000 00AF        PORTB=0X00;
	OUT  0x18,R30
; 0000 00B0        PORTA=0X00;
	LDI  R30,LOW(0)
	OUT  0x1B,R30
; 0000 00B1 
; 0000 00B2        }
	INC  R7
	RJMP _0x35
_0x36:
; 0000 00B3           for(i=0;i<8;i++)
	CLR  R7
_0x38:
	LDI  R30,LOW(8)
	CP   R7,R30
	BRSH _0x39
; 0000 00B4        {
; 0000 00B5        PORTB=ports[i];
	RCALL SUBOPT_0x1
	RCALL SUBOPT_0x3
; 0000 00B6        delay_ms(30);
; 0000 00B7        PORTA=0X00;
; 0000 00B8        PORTB=0X00;
; 0000 00B9 
; 0000 00BA        }
	INC  R7
	RJMP _0x38
_0x39:
; 0000 00BB           for(i=0;i<8;i++)
	CLR  R7
_0x3B:
	LDI  R30,LOW(8)
	CP   R7,R30
	BRSH _0x3C
; 0000 00BC        {
; 0000 00BD        PORTB=ports[7-i];
	RCALL SUBOPT_0x4
	RCALL SUBOPT_0x3
; 0000 00BE        delay_ms(30);
; 0000 00BF        PORTA=0X00;
; 0000 00C0        PORTB=0X00;
; 0000 00C1 
; 0000 00C2        }
	INC  R7
	RJMP _0x3B
_0x3C:
; 0000 00C3           for(i=0;i<8;i++)
	CLR  R7
_0x3E:
	LDI  R30,LOW(8)
	CP   R7,R30
	BRSH _0x3F
; 0000 00C4        {
; 0000 00C5        PORTA=ports[7-i];
	RCALL SUBOPT_0x4
	RCALL SUBOPT_0x2
; 0000 00C6        delay_ms(30);
; 0000 00C7        PORTA=0X00;
	OUT  0x1B,R30
; 0000 00C8        PORTB=0X00;
	LDI  R30,LOW(0)
	OUT  0x18,R30
; 0000 00C9 
; 0000 00CA        }
	INC  R7
	RJMP _0x3E
_0x3F:
; 0000 00CB 
; 0000 00CC        }
; 0000 00CD 
; 0000 00CE         if(j==2)
_0x33:
	CPI  R17,2
	BRNE _0x40
; 0000 00CF         {
; 0000 00D0            for(i=0;i<8;i++)
	CLR  R7
_0x42:
	LDI  R30,LOW(8)
	CP   R7,R30
	BRSH _0x43
; 0000 00D1        {
; 0000 00D2        PORTA=ports[i];
	RCALL SUBOPT_0x1
	OUT  0x1B,R30
; 0000 00D3        PORTB=ports[7-i];
	RCALL SUBOPT_0x4
	RCALL SUBOPT_0x5
; 0000 00D4        delay_ms(30);
; 0000 00D5        PORTB=0X00;
; 0000 00D6        PORTA=0X00;
; 0000 00D7 
; 0000 00D8        }
	INC  R7
	RJMP _0x42
_0x43:
; 0000 00D9           for(i=0;i<8;i++)
	CLR  R7
_0x45:
	LDI  R30,LOW(8)
	CP   R7,R30
	BRSH _0x46
; 0000 00DA        {
; 0000 00DB        PORTB=ports[i];
	RCALL SUBOPT_0x1
	OUT  0x18,R30
; 0000 00DC        PORTA=ports[7-i];
	RCALL SUBOPT_0x4
	RCALL SUBOPT_0x2
; 0000 00DD        delay_ms(30);
; 0000 00DE        PORTA=0X00;
	OUT  0x1B,R30
; 0000 00DF        PORTB=0X00;
	LDI  R30,LOW(0)
	OUT  0x18,R30
; 0000 00E0 
; 0000 00E1        }
	INC  R7
	RJMP _0x45
_0x46:
; 0000 00E2 
; 0000 00E3         }
; 0000 00E4        if(j==3){
_0x40:
	CPI  R17,3
	BRNE _0x47
; 0000 00E5         j=0;
	LDI  R17,LOW(0)
; 0000 00E6           for(i=0;i<4;i++)
	CLR  R7
_0x49:
	LDI  R30,LOW(4)
	CP   R7,R30
	BRSH _0x4A
; 0000 00E7 
; 0000 00E8        {
; 0000 00E9            if(i==0){
	TST  R7
	BRNE _0x4B
; 0000 00EA            PORTA=0x0c;
	RCALL SUBOPT_0x6
; 0000 00EB            PORTB=0x30;
; 0000 00EC            delay_ms(40);
; 0000 00ED            PORTB=0X00;
; 0000 00EE            PORTA=0X00;
; 0000 00EF 
; 0000 00F0 
; 0000 00F1            }
; 0000 00F2            if(i==1){
_0x4B:
	LDI  R30,LOW(1)
	CP   R30,R7
	BRNE _0x4C
; 0000 00F3            PORTA=0x0F;
	RCALL SUBOPT_0x7
; 0000 00F4            PORTB=0xF0;
; 0000 00F5            delay_ms(40);
; 0000 00F6            PORTB=0X00;
; 0000 00F7            PORTA=0X00;}
; 0000 00F8            if(i==2){
_0x4C:
	LDI  R30,LOW(2)
	CP   R30,R7
	BRNE _0x4D
; 0000 00F9            PORTA=0xCF;
	RCALL SUBOPT_0x8
; 0000 00FA            PORTB=0xF3;
; 0000 00FB            delay_ms(40);
; 0000 00FC            PORTB=0X00;
; 0000 00FD            PORTA=0X00;}
; 0000 00FE            if(i==3){
_0x4D:
	LDI  R30,LOW(3)
	CP   R30,R7
	BRNE _0x4E
; 0000 00FF            PORTA=0xFF;
	RCALL SUBOPT_0x9
; 0000 0100            PORTB=0xFF;
; 0000 0101            delay_ms(40);
; 0000 0102            PORTB=0X00;
; 0000 0103            PORTA=0X00;}
; 0000 0104 
; 0000 0105        }
_0x4E:
	INC  R7
	RJMP _0x49
_0x4A:
; 0000 0106                for(i=0;i<4;i++)
	CLR  R7
_0x50:
	LDI  R30,LOW(4)
	CP   R7,R30
	BRSH _0x51
; 0000 0107        {
; 0000 0108            if(i==0){
	TST  R7
	BRNE _0x52
; 0000 0109 
; 0000 010A            PORTA=0xFF;
	RCALL SUBOPT_0x9
; 0000 010B            PORTB=0xFF;
; 0000 010C            delay_ms(40);
; 0000 010D            PORTB=0X00;
; 0000 010E            PORTA=0X00;
; 0000 010F 
; 0000 0110 
; 0000 0111            }
; 0000 0112            if(i==1){
_0x52:
	LDI  R30,LOW(1)
	CP   R30,R7
	BRNE _0x53
; 0000 0113 
; 0000 0114            PORTA=0xCF;
	RCALL SUBOPT_0x8
; 0000 0115            PORTB=0xF3;
; 0000 0116            delay_ms(40);
; 0000 0117            PORTB=0X00;
; 0000 0118            PORTA=0X00;}
; 0000 0119            if(i==2){
_0x53:
	LDI  R30,LOW(2)
	CP   R30,R7
	BRNE _0x54
; 0000 011A             PORTA=0x0F;
	RCALL SUBOPT_0x7
; 0000 011B            PORTB=0xF0;
; 0000 011C            delay_ms(40);
; 0000 011D            PORTB=0X00;
; 0000 011E            PORTA=0X00;}
; 0000 011F            if(i==3){
_0x54:
	LDI  R30,LOW(3)
	CP   R30,R7
	BRNE _0x55
; 0000 0120            PORTA=0x0c;
	RCALL SUBOPT_0x6
; 0000 0121            PORTB=0x30;;
; 0000 0122            delay_ms(40);
; 0000 0123            PORTB=0X00;
; 0000 0124            PORTA=0X00;}
; 0000 0125 
; 0000 0126        }
_0x55:
	INC  R7
	RJMP _0x50
_0x51:
; 0000 0127 
; 0000 0128 
; 0000 0129        }
; 0000 012A        }
_0x47:
; 0000 012B 
; 0000 012C 
; 0000 012D    }
_0x32:
	RJMP _0x2F
; 0000 012E 
; 0000 012F 
; 0000 0130 
; 0000 0131 
; 0000 0132 }
_0x56:
	RJMP _0x56
; .FEND
;

	.DSEG
_ports:
	.BYTE 0x8

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x0:
	LDI  R26,0
	SBIC 0x10,2
	LDI  R26,1
	LDI  R30,LOW(1)
	CALL __EQB12
	MOV  R0,R30
	MOVW R26,R4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:18 WORDS
SUBOPT_0x1:
	MOV  R30,R7
	LDI  R31,0
	SUBI R30,LOW(-_ports)
	SBCI R31,HIGH(-_ports)
	LD   R30,Z
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:17 WORDS
SUBOPT_0x2:
	OUT  0x1B,R30
	LDI  R26,LOW(30)
	LDI  R27,0
	CALL _delay_ms
	LDI  R30,LOW(0)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:18 WORDS
SUBOPT_0x3:
	OUT  0x18,R30
	LDI  R26,LOW(30)
	LDI  R27,0
	CALL _delay_ms
	LDI  R30,LOW(0)
	OUT  0x1B,R30
	OUT  0x18,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:60 WORDS
SUBOPT_0x4:
	MOV  R30,R7
	LDI  R31,0
	LDI  R26,LOW(7)
	LDI  R27,HIGH(7)
	CALL __SWAPW12
	SUB  R30,R26
	SBC  R31,R27
	SUBI R30,LOW(-_ports)
	SBCI R31,HIGH(-_ports)
	LD   R30,Z
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x5:
	OUT  0x18,R30
	LDI  R26,LOW(30)
	LDI  R27,0
	CALL _delay_ms
	LDI  R30,LOW(0)
	OUT  0x18,R30
	OUT  0x1B,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:27 WORDS
SUBOPT_0x6:
	LDI  R30,LOW(12)
	OUT  0x1B,R30
	LDI  R30,LOW(48)
	OUT  0x18,R30
	LDI  R26,LOW(40)
	LDI  R27,0
	CALL _delay_ms
	LDI  R30,LOW(0)
	OUT  0x18,R30
	OUT  0x1B,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:27 WORDS
SUBOPT_0x7:
	LDI  R30,LOW(15)
	OUT  0x1B,R30
	LDI  R30,LOW(240)
	OUT  0x18,R30
	LDI  R26,LOW(40)
	LDI  R27,0
	CALL _delay_ms
	LDI  R30,LOW(0)
	OUT  0x18,R30
	OUT  0x1B,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:27 WORDS
SUBOPT_0x8:
	LDI  R30,LOW(207)
	OUT  0x1B,R30
	LDI  R30,LOW(243)
	OUT  0x18,R30
	LDI  R26,LOW(40)
	LDI  R27,0
	CALL _delay_ms
	LDI  R30,LOW(0)
	OUT  0x18,R30
	OUT  0x1B,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:27 WORDS
SUBOPT_0x9:
	LDI  R30,LOW(255)
	OUT  0x1B,R30
	OUT  0x18,R30
	LDI  R26,LOW(40)
	LDI  R27,0
	CALL _delay_ms
	LDI  R30,LOW(0)
	OUT  0x18,R30
	OUT  0x1B,R30
	RET


	.CSEG
_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0x7D0
	wdr
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

__EQB12:
	CP   R30,R26
	LDI  R30,1
	BREQ __EQB12T
	CLR  R30
__EQB12T:
	RET

__EQW12:
	CP   R30,R26
	CPC  R31,R27
	LDI  R30,1
	BREQ __EQW12T
	CLR  R30
__EQW12T:
	RET

__SWAPW12:
	MOV  R1,R27
	MOV  R27,R31
	MOV  R31,R1

__SWAPB12:
	MOV  R1,R26
	MOV  R26,R30
	MOV  R30,R1
	RET

;END OF CODE MARKER
__END_OF_CODE:
