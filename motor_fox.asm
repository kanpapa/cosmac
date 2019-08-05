*
* Motor driver program for COSMAC-fox
* SB-Assembler
*
* BUS0 --- AIN1 台車モーターに接続。両キャタピラが逆回転になる接続なのでその場でぐるぐる回る。
* BUS1 --- AIN2
* BUS2 --- BIN1 後部クランクモーターに接続。しっぽを振る。
* BUS3 --- BIN2
* Q    --- PWMA/B
*
* 動作
* (1) PUSH SWを押すまで待機
* (2) BUS0-BUS3をカウントアップし、AINとBINに出力。
* (3) モーターの動きが規則的に変化するため、見た目だとうろうろしているように見える。
* (4) 無限ループとしているので止めたいときはトグルスイッチを切ればモータへの電源供給が止まる。
* (5) COSMACはそのまま動かすかRTにする。
* 
*
        .CR     1802    ;To load the 1802 cross overlay
        .OR     $0000
*
START   LDI     #IOR    ;#IOR -> D
        PLO     3       ;D -> R(3).0
        SEX     3       ;3 -> X
*
        SEQ		;1 -> Q
*
LOOP1	BN4     LOOP1   ;IF EF4=0 LOOP1 (EF4=Vcc)
LOOP2	GLO     4       ;R(4).0 -> D
        STR     3       ;D -> M(R(3))
        OUT     4       ;M(R(3)) -> BUS; R(3)++
        DEC     3       ;R(3)--
        INC     4       ;R(4)++
*
	LDI	#128
	PHI	2
WAIT1   DEC     2	;R(2)--
        GHI     2	;R(2).1 -> D
        BNZ     WAIT1	;IF D!=0 WAIT1
*
        BR      LOOP2   ;Branch to LOOP2
*
IOR     .DB     0       ;IO Register

        .EN
