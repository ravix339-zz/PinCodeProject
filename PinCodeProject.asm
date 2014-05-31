
_main:

;PIN Code Project.c,94 ::                 void main() {
;PIN Code Project.c,95 ::                 ANSELB = 0x00;            //PORTB has all digital bits
        CLRF        ANSELB+0 
;PIN Code Project.c,96 ::                 ANSELC = 0x00;            //PORTC has all digital bits
        CLRF        ANSELC+0 
;PIN Code Project.c,97 ::                 ANSELD = 0x00;            //PORTD has all digital bits
        CLRF        ANSELD+0 
;PIN Code Project.c,98 ::                 TRISB = 0x00;            // PORTB is output only for the LCD
        CLRF        TRISB+0 
;PIN Code Project.c,99 ::                 TRISC = 0xFF;            //PORTC is input only
        MOVLW       255
        MOVWF       TRISC+0 
;PIN Code Project.c,100 ::                 TRISD = 0xFF;            //PORTD is input only
        MOVLW       255
        MOVWF       TRISD+0 
;PIN Code Project.c,101 ::                 PORTB = 0x00;
        CLRF        PORTB+0 
;PIN Code Project.c,102 ::                 PORTD = 0x00;
        CLRF        PORTD+0 
;PIN Code Project.c,103 ::                 PORTC = 0x00;
        CLRF        PORTC+0 
;PIN Code Project.c,104 ::                 Lcd_Init();              //initialize and clear LCD
        CALL        _Lcd_Init+0, 0
;PIN Code Project.c,105 ::                 Lcd_Cmd(_LCD_CLEAR);
        MOVLW       1
        MOVWF       FARG_Lcd_Cmd_out_char+0 
        CALL        _Lcd_Cmd+0, 0
;PIN Code Project.c,106 ::                 Lcd_Cmd(_LCD_CURSOR_OFF);
        MOVLW       12
        MOVWF       FARG_Lcd_Cmd_out_char+0 
        CALL        _Lcd_Cmd+0, 0
;PIN Code Project.c,108 ::                 ByteToStr(EEPROM_READ(0x00), str); //covert(0x00) to a string
        CLRF        FARG_EEPROM_Read_address+0 
        CALL        _EEPROM_Read+0, 0
        MOVF        R0, 0 
        MOVWF       FARG_ByteToStr_input+0 
        MOVLW       _str+0
        MOVWF       FARG_ByteToStr_output+0 
        MOVLW       hi_addr(_str+0)
        MOVWF       FARG_ByteToStr_output+1 
        CALL        _ByteToStr+0, 0
;PIN Code Project.c,109 ::                 if(str[0] == '2' & str[1] == '5' & str[2] == '5') //compare (0x00) to 255
        MOVF        _str+0, 0 
        XORLW       50
        MOVLW       1
        BTFSS       STATUS+0, 2 
        MOVLW       0
        MOVWF       R1 
        MOVF        _str+1, 0 
        XORLW       53
        MOVLW       1
        BTFSS       STATUS+0, 2 
        MOVLW       0
        MOVWF       R0 
        MOVF        R0, 0 
        ANDWF       R1, 1 
        MOVF        _str+2, 0 
        XORLW       53
        MOVLW       1
        BTFSS       STATUS+0, 2 
        MOVLW       0
        MOVWF       R0 
        MOVF        R1, 0 
        ANDWF       R0, 1 
        BTFSC       STATUS+0, 2 
        GOTO        L_main0
;PIN Code Project.c,111 ::                 EEPROM_WRITE(0x00, 0x00);         //set (0x00) to 0x00 to symbolize that this is not the first bootup
        CLRF        FARG_EEPROM_Write_address+0 
        CLRF        FARG_EEPROM_Write_data_+0 
        CALL        _EEPROM_Write+0, 0
;PIN Code Project.c,112 ::                 EEPROM_WRITE(0x01, 0x00);         //set initial code to 0123
        MOVLW       1
        MOVWF       FARG_EEPROM_Write_address+0 
        CLRF        FARG_EEPROM_Write_data_+0 
        CALL        _EEPROM_Write+0, 0
;PIN Code Project.c,113 ::                 EEPROM_WRITE(0x02, 0x01);
        MOVLW       2
        MOVWF       FARG_EEPROM_Write_address+0 
        MOVLW       1
        MOVWF       FARG_EEPROM_Write_data_+0 
        CALL        _EEPROM_Write+0, 0
;PIN Code Project.c,114 ::                 EEPROM_WRITE(0x03, 0x02);
        MOVLW       3
        MOVWF       FARG_EEPROM_Write_address+0 
        MOVLW       2
        MOVWF       FARG_EEPROM_Write_data_+0 
        CALL        _EEPROM_Write+0, 0
;PIN Code Project.c,115 ::                 EEPROM_WRITE(0x04, 0x03);
        MOVLW       4
        MOVWF       FARG_EEPROM_Write_address+0 
        MOVLW       3
        MOVWF       FARG_EEPROM_Write_data_+0 
        CALL        _EEPROM_Write+0, 0
;PIN Code Project.c,116 ::                 }
L_main0:
;PIN Code Project.c,117 ::                 Lcd_Out(1,1,str);
        MOVLW       1
        MOVWF       FARG_Lcd_Out_row+0 
        MOVLW       1
        MOVWF       FARG_Lcd_Out_column+0 
        MOVLW       _str+0
        MOVWF       FARG_Lcd_Out_text+0 
        MOVLW       hi_addr(_str+0)
        MOVWF       FARG_Lcd_Out_text+1 
        CALL        _Lcd_Out+0, 0
;PIN Code Project.c,118 ::                 BYTETOSTR(EEPROM_READ(0x01), str);
        MOVLW       1
        MOVWF       FARG_EEPROM_Read_address+0 
        CALL        _EEPROM_Read+0, 0
        MOVF        R0, 0 
        MOVWF       FARG_ByteToStr_input+0 
        MOVLW       _str+0
        MOVWF       FARG_ByteToStr_output+0 
        MOVLW       hi_addr(_str+0)
        MOVWF       FARG_ByteToStr_output+1 
        CALL        _ByteToStr+0, 0
;PIN Code Project.c,119 ::                 Ltrim(str);
        MOVLW       _str+0
        MOVWF       FARG_Ltrim_string+0 
        MOVLW       hi_addr(_str+0)
        MOVWF       FARG_Ltrim_string+1 
        CALL        _Ltrim+0, 0
;PIN Code Project.c,120 ::                 Lcd_Out(1,1,str);
        MOVLW       1
        MOVWF       FARG_Lcd_Out_row+0 
        MOVLW       1
        MOVWF       FARG_Lcd_Out_column+0 
        MOVLW       _str+0
        MOVWF       FARG_Lcd_Out_text+0 
        MOVLW       hi_addr(_str+0)
        MOVWF       FARG_Lcd_Out_text+1 
        CALL        _Lcd_Out+0, 0
;PIN Code Project.c,121 ::                 original[0] = str[0];                    //take (0x01) and place it in original
        MOVF        _str+0, 0 
        MOVWF       _original+0 
;PIN Code Project.c,122 ::                 BYTETOSTR(EEPROM_READ(0x02), str);
        MOVLW       2
        MOVWF       FARG_EEPROM_Read_address+0 
        CALL        _EEPROM_Read+0, 0
        MOVF        R0, 0 
        MOVWF       FARG_ByteToStr_input+0 
        MOVLW       _str+0
        MOVWF       FARG_ByteToStr_output+0 
        MOVLW       hi_addr(_str+0)
        MOVWF       FARG_ByteToStr_output+1 
        CALL        _ByteToStr+0, 0
;PIN Code Project.c,123 ::                 Ltrim(str);
        MOVLW       _str+0
        MOVWF       FARG_Ltrim_string+0 
        MOVLW       hi_addr(_str+0)
        MOVWF       FARG_Ltrim_string+1 
        CALL        _Ltrim+0, 0
;PIN Code Project.c,124 ::                 Lcd_Out(1,1,str);
        MOVLW       1
        MOVWF       FARG_Lcd_Out_row+0 
        MOVLW       1
        MOVWF       FARG_Lcd_Out_column+0 
        MOVLW       _str+0
        MOVWF       FARG_Lcd_Out_text+0 
        MOVLW       hi_addr(_str+0)
        MOVWF       FARG_Lcd_Out_text+1 
        CALL        _Lcd_Out+0, 0
;PIN Code Project.c,125 ::                 original[1] = str[0];                    //take (0x02) and place it in original
        MOVF        _str+0, 0 
        MOVWF       _original+1 
;PIN Code Project.c,126 ::                 BYTETOSTR(EEPROM_READ(0x03), str);
        MOVLW       3
        MOVWF       FARG_EEPROM_Read_address+0 
        CALL        _EEPROM_Read+0, 0
        MOVF        R0, 0 
        MOVWF       FARG_ByteToStr_input+0 
        MOVLW       _str+0
        MOVWF       FARG_ByteToStr_output+0 
        MOVLW       hi_addr(_str+0)
        MOVWF       FARG_ByteToStr_output+1 
        CALL        _ByteToStr+0, 0
;PIN Code Project.c,127 ::                 Ltrim(str);
        MOVLW       _str+0
        MOVWF       FARG_Ltrim_string+0 
        MOVLW       hi_addr(_str+0)
        MOVWF       FARG_Ltrim_string+1 
        CALL        _Ltrim+0, 0
;PIN Code Project.c,128 ::                 Lcd_Out(1,1,str);
        MOVLW       1
        MOVWF       FARG_Lcd_Out_row+0 
        MOVLW       1
        MOVWF       FARG_Lcd_Out_column+0 
        MOVLW       _str+0
        MOVWF       FARG_Lcd_Out_text+0 
        MOVLW       hi_addr(_str+0)
        MOVWF       FARG_Lcd_Out_text+1 
        CALL        _Lcd_Out+0, 0
;PIN Code Project.c,129 ::                 original[2] = str[0];                //take (0x03) and place it in original
        MOVF        _str+0, 0 
        MOVWF       _original+2 
;PIN Code Project.c,130 ::                 BYTETOSTR(EEPROM_READ(0x04), str);
        MOVLW       4
        MOVWF       FARG_EEPROM_Read_address+0 
        CALL        _EEPROM_Read+0, 0
        MOVF        R0, 0 
        MOVWF       FARG_ByteToStr_input+0 
        MOVLW       _str+0
        MOVWF       FARG_ByteToStr_output+0 
        MOVLW       hi_addr(_str+0)
        MOVWF       FARG_ByteToStr_output+1 
        CALL        _ByteToStr+0, 0
;PIN Code Project.c,131 ::                 Ltrim(str);
        MOVLW       _str+0
        MOVWF       FARG_Ltrim_string+0 
        MOVLW       hi_addr(_str+0)
        MOVWF       FARG_Ltrim_string+1 
        CALL        _Ltrim+0, 0
;PIN Code Project.c,132 ::                 Lcd_Out(1,1,str);
        MOVLW       1
        MOVWF       FARG_Lcd_Out_row+0 
        MOVLW       1
        MOVWF       FARG_Lcd_Out_column+0 
        MOVLW       _str+0
        MOVWF       FARG_Lcd_Out_text+0 
        MOVLW       hi_addr(_str+0)
        MOVWF       FARG_Lcd_Out_text+1 
        CALL        _Lcd_Out+0, 0
;PIN Code Project.c,133 ::                 original[3] = str[0];               //take (0x04) and place it in original
        MOVF        _str+0, 0 
        MOVWF       _original+3 
;PIN Code Project.c,134 ::                 Lcd_Cmd(_LCD_CLEAR);
        MOVLW       1
        MOVWF       FARG_Lcd_Cmd_out_char+0 
        CALL        _Lcd_Cmd+0, 0
;PIN Code Project.c,136 ::                 while(1)
L_main1:
;PIN Code Project.c,138 ::                 Lcd_Out(1,1, "   Welcome to the ");
        MOVLW       1
        MOVWF       FARG_Lcd_Out_row+0 
        MOVLW       1
        MOVWF       FARG_Lcd_Out_column+0 
        MOVLW       ?lstr1_PIN_32Code_32Project+0
        MOVWF       FARG_Lcd_Out_text+0 
        MOVLW       hi_addr(?lstr1_PIN_32Code_32Project+0)
        MOVWF       FARG_Lcd_Out_text+1 
        CALL        _Lcd_Out+0, 0
;PIN Code Project.c,139 ::                 Lcd_Out(2,3,"Pin Code Checker");
        MOVLW       2
        MOVWF       FARG_Lcd_Out_row+0 
        MOVLW       3
        MOVWF       FARG_Lcd_Out_column+0 
        MOVLW       ?lstr2_PIN_32Code_32Project+0
        MOVWF       FARG_Lcd_Out_text+0 
        MOVLW       hi_addr(?lstr2_PIN_32Code_32Project+0)
        MOVWF       FARG_Lcd_Out_text+1 
        CALL        _Lcd_Out+0, 0
;PIN Code Project.c,140 ::                 PORTD = 0x00;
        CLRF        PORTD+0 
;PIN Code Project.c,141 ::                 PORTC = 0x00;
        CLRF        PORTC+0 
;PIN Code Project.c,142 ::                 while(1)
L_main3:
;PIN Code Project.c,144 ::                 if(PORTD.B7)
        BTFSS       PORTD+0, 7 
        GOTO        L_main5
;PIN Code Project.c,145 ::                 develop();
        CALL        _develop+0, 0
L_main5:
;PIN Code Project.c,146 ::                 if(PORTD.B6)
        BTFSS       PORTD+0, 6 
        GOTO        L_main6
;PIN Code Project.c,147 ::                 instruction();
        CALL        _instruction+0, 0
L_main6:
;PIN Code Project.c,148 ::                 for(i = 0; i < 4; i++)
        CLRF        _i+0 
        CLRF        _i+1 
L_main7:
        MOVLW       128
        XORWF       _i+1, 0 
        MOVWF       R0 
        MOVLW       128
        SUBWF       R0, 0 
        BTFSS       STATUS+0, 2 
        GOTO        L__main108
        MOVLW       4
        SUBWF       _i+0, 0 
L__main108:
        BTFSC       STATUS+0, 0 
        GOTO        L_main8
;PIN Code Project.c,150 ::                 guess[i] = '\0';              //remove all characters from guess[] and digits[]
        MOVLW       _guess+0
        ADDWF       _i+0, 0 
        MOVWF       FSR1 
        MOVLW       hi_addr(_guess+0)
        ADDWFC      _i+1, 0 
        MOVWF       FSR1H 
        CLRF        POSTINC1+0 
;PIN Code Project.c,151 ::                 digits[i] = '\0';
        MOVLW       _digits+0
        ADDWF       _i+0, 0 
        MOVWF       FSR1 
        MOVLW       hi_addr(_digits+0)
        ADDWFC      _i+1, 0 
        MOVWF       FSR1H 
        CLRF        POSTINC1+0 
;PIN Code Project.c,148 ::                 for(i = 0; i < 4; i++)
        INFSNZ      _i+0, 1 
        INCF        _i+1, 1 
;PIN Code Project.c,152 ::                 }
        GOTO        L_main7
L_main8:
;PIN Code Project.c,153 ::                 if(PORTD.B3)                        //button to program a pin
        BTFSS       PORTD+0, 3 
        GOTO        L_main10
;PIN Code Project.c,155 ::                 for(i = 0; i < 4; i++)
        CLRF        _i+0 
        CLRF        _i+1 
L_main11:
        MOVLW       128
        XORWF       _i+1, 0 
        MOVWF       R0 
        MOVLW       128
        SUBWF       R0, 0 
        BTFSS       STATUS+0, 2 
        GOTO        L__main109
        MOVLW       4
        SUBWF       _i+0, 0 
L__main109:
        BTFSC       STATUS+0, 0 
        GOTO        L_main12
;PIN Code Project.c,157 ::                 original[i] = '\0';        //Clear original[]
        MOVLW       _original+0
        ADDWF       _i+0, 0 
        MOVWF       FSR1 
        MOVLW       hi_addr(_original+0)
        ADDWFC      _i+1, 0 
        MOVWF       FSR1H 
        CLRF        POSTINC1+0 
;PIN Code Project.c,155 ::                 for(i = 0; i < 4; i++)
        INFSNZ      _i+0, 1 
        INCF        _i+1, 1 
;PIN Code Project.c,158 ::                 }
        GOTO        L_main11
L_main12:
;PIN Code Project.c,159 ::                 Lcd_Cmd(_LCD_CLEAR);
        MOVLW       1
        MOVWF       FARG_Lcd_Cmd_out_char+0 
        CALL        _Lcd_Cmd+0, 0
;PIN Code Project.c,160 ::                 Lcd_Out(1,4, "Enter your pin");
        MOVLW       1
        MOVWF       FARG_Lcd_Out_row+0 
        MOVLW       4
        MOVWF       FARG_Lcd_Out_column+0 
        MOVLW       ?lstr3_PIN_32Code_32Project+0
        MOVWF       FARG_Lcd_Out_text+0 
        MOVLW       hi_addr(?lstr3_PIN_32Code_32Project+0)
        MOVWF       FARG_Lcd_Out_text+1 
        CALL        _Lcd_Out+0, 0
;PIN Code Project.c,161 ::                 for(i = 0; i < 3; i ++)
        CLRF        _i+0 
        CLRF        _i+1 
L_main14:
        MOVLW       128
        XORWF       _i+1, 0 
        MOVWF       R0 
        MOVLW       128
        SUBWF       R0, 0 
        BTFSS       STATUS+0, 2 
        GOTO        L__main110
        MOVLW       3
        SUBWF       _i+0, 0 
L__main110:
        BTFSC       STATUS+0, 0 
        GOTO        L_main15
;PIN Code Project.c,163 ::                 Lcd_Cmd(_LCD_SHIFT_RIGHT);  //shift displayed text 3 places to the right
        MOVLW       28
        MOVWF       FARG_Lcd_Cmd_out_char+0 
        CALL        _Lcd_Cmd+0, 0
;PIN Code Project.c,164 ::                 Delay_ms(167);
        MOVLW       2
        MOVWF       R11, 0
        MOVLW       178
        MOVWF       R12, 0
        MOVLW       193
        MOVWF       R13, 0
L_main17:
        DECFSZ      R13, 1, 1
        BRA         L_main17
        DECFSZ      R12, 1, 1
        BRA         L_main17
        DECFSZ      R11, 1, 1
        BRA         L_main17
;PIN Code Project.c,161 ::                 for(i = 0; i < 3; i ++)
        INFSNZ      _i+0, 1 
        INCF        _i+1, 1 
;PIN Code Project.c,165 ::                 }
        GOTO        L_main14
L_main15:
;PIN Code Project.c,166 ::                 for(i = 0; i < 6; i++)
        CLRF        _i+0 
        CLRF        _i+1 
L_main18:
        MOVLW       128
        XORWF       _i+1, 0 
        MOVWF       R0 
        MOVLW       128
        SUBWF       R0, 0 
        BTFSS       STATUS+0, 2 
        GOTO        L__main111
        MOVLW       6
        SUBWF       _i+0, 0 
L__main111:
        BTFSC       STATUS+0, 0 
        GOTO        L_main19
;PIN Code Project.c,168 ::                 Lcd_Cmd(_LCD_SHIFT_LEFT);   //shift displayed text 6 places to the left
        MOVLW       24
        MOVWF       FARG_Lcd_Cmd_out_char+0 
        CALL        _Lcd_Cmd+0, 0
;PIN Code Project.c,169 ::                 Delay_ms(166);
        MOVLW       2
        MOVWF       R11, 0
        MOVLW       176
        MOVWF       R12, 0
        MOVLW       39
        MOVWF       R13, 0
L_main21:
        DECFSZ      R13, 1, 1
        BRA         L_main21
        DECFSZ      R12, 1, 1
        BRA         L_main21
        DECFSZ      R11, 1, 1
        BRA         L_main21
        NOP
        NOP
;PIN Code Project.c,166 ::                 for(i = 0; i < 6; i++)
        INFSNZ      _i+0, 1 
        INCF        _i+1, 1 
;PIN Code Project.c,170 ::                 }
        GOTO        L_main18
L_main19:
;PIN Code Project.c,171 ::                 for(i = 0; i < 3; i ++)
        CLRF        _i+0 
        CLRF        _i+1 
L_main22:
        MOVLW       128
        XORWF       _i+1, 0 
        MOVWF       R0 
        MOVLW       128
        SUBWF       R0, 0 
        BTFSS       STATUS+0, 2 
        GOTO        L__main112
        MOVLW       3
        SUBWF       _i+0, 0 
L__main112:
        BTFSC       STATUS+0, 0 
        GOTO        L_main23
;PIN Code Project.c,173 ::                 Lcd_Cmd(_LCD_SHIFT_RIGHT);  //shift displayed text 3 places to the right
        MOVLW       28
        MOVWF       FARG_Lcd_Cmd_out_char+0 
        CALL        _Lcd_Cmd+0, 0
;PIN Code Project.c,174 ::                 Delay_ms(167);
        MOVLW       2
        MOVWF       R11, 0
        MOVLW       178
        MOVWF       R12, 0
        MOVLW       193
        MOVWF       R13, 0
L_main25:
        DECFSZ      R13, 1, 1
        BRA         L_main25
        DECFSZ      R12, 1, 1
        BRA         L_main25
        DECFSZ      R11, 1, 1
        BRA         L_main25
;PIN Code Project.c,171 ::                 for(i = 0; i < 3; i ++)
        INFSNZ      _i+0, 1 
        INCF        _i+1, 1 
;PIN Code Project.c,175 ::                 }
        GOTO        L_main22
L_main23:
;PIN Code Project.c,176 ::                 i =0;
        CLRF        _i+0 
        CLRF        _i+1 
;PIN Code Project.c,177 ::                 program();
        CALL        _program+0, 0
;PIN Code Project.c,178 ::                 numentered = 1;
        MOVLW       1
        MOVWF       _numentered+0 
        MOVLW       0
        MOVWF       _numentered+1 
;PIN Code Project.c,179 ::                 for(i =0; i < 4; i++)
        CLRF        _i+0 
        CLRF        _i+1 
L_main26:
        MOVLW       128
        XORWF       _i+1, 0 
        MOVWF       R0 
        MOVLW       128
        SUBWF       R0, 0 
        BTFSS       STATUS+0, 2 
        GOTO        L__main113
        MOVLW       4
        SUBWF       _i+0, 0 
L__main113:
        BTFSC       STATUS+0, 0 
        GOTO        L_main27
;PIN Code Project.c,181 ::                 digits[i] = '\0';        //reinitialize digits[]
        MOVLW       _digits+0
        ADDWF       _i+0, 0 
        MOVWF       FSR1 
        MOVLW       hi_addr(_digits+0)
        ADDWFC      _i+1, 0 
        MOVWF       FSR1H 
        CLRF        POSTINC1+0 
;PIN Code Project.c,179 ::                 for(i =0; i < 4; i++)
        INFSNZ      _i+0, 1 
        INCF        _i+1, 1 
;PIN Code Project.c,182 ::                 }
        GOTO        L_main26
L_main27:
;PIN Code Project.c,183 ::                 Lcd_Cmd(_LCD_CLEAR);
        MOVLW       1
        MOVWF       FARG_Lcd_Cmd_out_char+0 
        CALL        _Lcd_Cmd+0, 0
;PIN Code Project.c,184 ::                 break;
        GOTO        L_main4
;PIN Code Project.c,185 ::                 }
L_main10:
;PIN Code Project.c,186 ::                 else if(PORTD.B2)                  //button to test a pin
        BTFSS       PORTD+0, 2 
        GOTO        L_main30
;PIN Code Project.c,188 ::                 Lcd_Cmd(_LCD_CLEAR);
        MOVLW       1
        MOVWF       FARG_Lcd_Cmd_out_char+0 
        CALL        _Lcd_Cmd+0, 0
;PIN Code Project.c,189 ::                 break;
        GOTO        L_main4
;PIN Code Project.c,190 ::                 }
L_main30:
;PIN Code Project.c,191 ::                 }
        GOTO        L_main3
L_main4:
;PIN Code Project.c,192 ::                 i=0;
        CLRF        _i+0 
        CLRF        _i+1 
;PIN Code Project.c,193 ::                 test();
        CALL        _test+0, 0
;PIN Code Project.c,194 ::                 Lcd_Cmd(_LCD_CLEAR);
        MOVLW       1
        MOVWF       FARG_Lcd_Cmd_out_char+0 
        CALL        _Lcd_Cmd+0, 0
;PIN Code Project.c,195 ::                 Lcd_Out(1,3, "Pin is correct!");
        MOVLW       1
        MOVWF       FARG_Lcd_Out_row+0 
        MOVLW       3
        MOVWF       FARG_Lcd_Out_column+0 
        MOVLW       ?lstr4_PIN_32Code_32Project+0
        MOVWF       FARG_Lcd_Out_text+0 
        MOVLW       hi_addr(?lstr4_PIN_32Code_32Project+0)
        MOVWF       FARG_Lcd_Out_text+1 
        CALL        _Lcd_Out+0, 0
;PIN Code Project.c,196 ::                 for(i = 0; i < 3; i ++)
        CLRF        _i+0 
        CLRF        _i+1 
L_main31:
        MOVLW       128
        XORWF       _i+1, 0 
        MOVWF       R0 
        MOVLW       128
        SUBWF       R0, 0 
        BTFSS       STATUS+0, 2 
        GOTO        L__main114
        MOVLW       3
        SUBWF       _i+0, 0 
L__main114:
        BTFSC       STATUS+0, 0 
        GOTO        L_main32
;PIN Code Project.c,198 ::                 Lcd_Cmd(_LCD_SHIFT_RIGHT);  //shift displayed text 3 places to the right
        MOVLW       28
        MOVWF       FARG_Lcd_Cmd_out_char+0 
        CALL        _Lcd_Cmd+0, 0
;PIN Code Project.c,199 ::                 Delay_ms(166);
        MOVLW       2
        MOVWF       R11, 0
        MOVLW       176
        MOVWF       R12, 0
        MOVLW       39
        MOVWF       R13, 0
L_main34:
        DECFSZ      R13, 1, 1
        BRA         L_main34
        DECFSZ      R12, 1, 1
        BRA         L_main34
        DECFSZ      R11, 1, 1
        BRA         L_main34
        NOP
        NOP
;PIN Code Project.c,196 ::                 for(i = 0; i < 3; i ++)
        INFSNZ      _i+0, 1 
        INCF        _i+1, 1 
;PIN Code Project.c,200 ::                 }
        GOTO        L_main31
L_main32:
;PIN Code Project.c,201 ::                 for(i = 0; i < 5; i++)
        CLRF        _i+0 
        CLRF        _i+1 
L_main35:
        MOVLW       128
        XORWF       _i+1, 0 
        MOVWF       R0 
        MOVLW       128
        SUBWF       R0, 0 
        BTFSS       STATUS+0, 2 
        GOTO        L__main115
        MOVLW       5
        SUBWF       _i+0, 0 
L__main115:
        BTFSC       STATUS+0, 0 
        GOTO        L_main36
;PIN Code Project.c,203 ::                 Lcd_Cmd(_LCD_SHIFT_LEFT);   //shift displayed text 5 places to the left
        MOVLW       24
        MOVWF       FARG_Lcd_Cmd_out_char+0 
        CALL        _Lcd_Cmd+0, 0
;PIN Code Project.c,204 ::                 Delay_ms(167);
        MOVLW       2
        MOVWF       R11, 0
        MOVLW       178
        MOVWF       R12, 0
        MOVLW       193
        MOVWF       R13, 0
L_main38:
        DECFSZ      R13, 1, 1
        BRA         L_main38
        DECFSZ      R12, 1, 1
        BRA         L_main38
        DECFSZ      R11, 1, 1
        BRA         L_main38
;PIN Code Project.c,201 ::                 for(i = 0; i < 5; i++)
        INFSNZ      _i+0, 1 
        INCF        _i+1, 1 
;PIN Code Project.c,205 ::                 }
        GOTO        L_main35
L_main36:
;PIN Code Project.c,206 ::                 for(i = 0; i < 3; i ++)
        CLRF        _i+0 
        CLRF        _i+1 
L_main39:
        MOVLW       128
        XORWF       _i+1, 0 
        MOVWF       R0 
        MOVLW       128
        SUBWF       R0, 0 
        BTFSS       STATUS+0, 2 
        GOTO        L__main116
        MOVLW       3
        SUBWF       _i+0, 0 
L__main116:
        BTFSC       STATUS+0, 0 
        GOTO        L_main40
;PIN Code Project.c,208 ::                 Lcd_Cmd(_LCD_SHIFT_RIGHT);  //shift displayed text 3 places to the right
        MOVLW       28
        MOVWF       FARG_Lcd_Cmd_out_char+0 
        CALL        _Lcd_Cmd+0, 0
;PIN Code Project.c,209 ::                 Delay_ms(167);
        MOVLW       2
        MOVWF       R11, 0
        MOVLW       178
        MOVWF       R12, 0
        MOVLW       193
        MOVWF       R13, 0
L_main42:
        DECFSZ      R13, 1, 1
        BRA         L_main42
        DECFSZ      R12, 1, 1
        BRA         L_main42
        DECFSZ      R11, 1, 1
        BRA         L_main42
;PIN Code Project.c,206 ::                 for(i = 0; i < 3; i ++)
        INFSNZ      _i+0, 1 
        INCF        _i+1, 1 
;PIN Code Project.c,210 ::                 }
        GOTO        L_main39
L_main40:
;PIN Code Project.c,211 ::                 Delay_ms(1000);
        MOVLW       11
        MOVWF       R11, 0
        MOVLW       38
        MOVWF       R12, 0
        MOVLW       93
        MOVWF       R13, 0
L_main43:
        DECFSZ      R13, 1, 1
        BRA         L_main43
        DECFSZ      R12, 1, 1
        BRA         L_main43
        DECFSZ      R11, 1, 1
        BRA         L_main43
        NOP
        NOP
;PIN Code Project.c,212 ::                 Lcd_Cmd(_LCD_CLEAR);
        MOVLW       1
        MOVWF       FARG_Lcd_Cmd_out_char+0 
        CALL        _Lcd_Cmd+0, 0
;PIN Code Project.c,213 ::                 }
        GOTO        L_main1
;PIN Code Project.c,214 ::                 }
L_end_main:
        GOTO        $+0
; end of _main

_program:

;PIN Code Project.c,220 ::                 void program()
;PIN Code Project.c,222 ::                 do
L_program44:
;PIN Code Project.c,224 ::                 if(!PORTC & !PORTD.B0 & !PORTD.B1) //only allow input when no other buttons are pressed
        MOVF        PORTC+0, 1 
        MOVLW       1
        BTFSS       STATUS+0, 2 
        MOVLW       0
        MOVWF       R1 
        BTFSC       PORTD+0, 0 
        GOTO        L__program118
        BSF         4056, 0 
        GOTO        L__program119
L__program118:
        BCF         4056, 0 
L__program119:
        CLRF        R0 
        BTFSC       4056, 0 
        INCF        R0, 1 
        MOVF        R0, 0 
        ANDWF       R1, 1 
        BTFSC       PORTD+0, 1 
        GOTO        L__program120
        BSF         4056, 0 
        GOTO        L__program121
L__program120:
        BCF         4056, 0 
L__program121:
        CLRF        R0 
        BTFSC       4056, 0 
        INCF        R0, 1 
        MOVF        R1, 0 
        ANDWF       R0, 1 
        BTFSC       STATUS+0, 2 
        GOTO        L_program47
;PIN Code Project.c,225 ::                 numentered = 0;
        CLRF        _numentered+0 
        CLRF        _numentered+1 
L_program47:
;PIN Code Project.c,226 ::                 if(numentered == 0){              //if statement to determine what the pin input is
        MOVLW       0
        XORWF       _numentered+1, 0 
        BTFSS       STATUS+0, 2 
        GOTO        L__program122
        MOVLW       0
        XORWF       _numentered+0, 0 
L__program122:
        BTFSS       STATUS+0, 2 
        GOTO        L_program48
;PIN Code Project.c,227 ::                 if(PORTC.B0)
        BTFSS       PORTC+0, 0 
        GOTO        L_program49
;PIN Code Project.c,229 ::                 original[i] = '0';
        MOVLW       _original+0
        ADDWF       _i+0, 0 
        MOVWF       FSR1 
        MOVLW       hi_addr(_original+0)
        ADDWFC      _i+1, 0 
        MOVWF       FSR1H 
        MOVLW       48
        MOVWF       POSTINC1+0 
;PIN Code Project.c,230 ::                 numentered = 1;
        MOVLW       1
        MOVWF       _numentered+0 
        MOVLW       0
        MOVWF       _numentered+1 
;PIN Code Project.c,231 ::                 digits[i] = '*';
        MOVLW       _digits+0
        ADDWF       _i+0, 0 
        MOVWF       FSR1 
        MOVLW       hi_addr(_digits+0)
        ADDWFC      _i+1, 0 
        MOVWF       FSR1H 
        MOVLW       42
        MOVWF       POSTINC1+0 
;PIN Code Project.c,232 ::                 i++;
        INFSNZ      _i+0, 1 
        INCF        _i+1, 1 
;PIN Code Project.c,233 ::                 }
        GOTO        L_program50
L_program49:
;PIN Code Project.c,234 ::                 else if(PORTC.B1)
        BTFSS       PORTC+0, 1 
        GOTO        L_program51
;PIN Code Project.c,236 ::                 original[i] = '1';
        MOVLW       _original+0
        ADDWF       _i+0, 0 
        MOVWF       FSR1 
        MOVLW       hi_addr(_original+0)
        ADDWFC      _i+1, 0 
        MOVWF       FSR1H 
        MOVLW       49
        MOVWF       POSTINC1+0 
;PIN Code Project.c,237 ::                 numentered = 1;
        MOVLW       1
        MOVWF       _numentered+0 
        MOVLW       0
        MOVWF       _numentered+1 
;PIN Code Project.c,238 ::                 digits[i] = '*';
        MOVLW       _digits+0
        ADDWF       _i+0, 0 
        MOVWF       FSR1 
        MOVLW       hi_addr(_digits+0)
        ADDWFC      _i+1, 0 
        MOVWF       FSR1H 
        MOVLW       42
        MOVWF       POSTINC1+0 
;PIN Code Project.c,239 ::                 i++;
        INFSNZ      _i+0, 1 
        INCF        _i+1, 1 
;PIN Code Project.c,240 ::                 }
        GOTO        L_program52
L_program51:
;PIN Code Project.c,241 ::                 else if(PORTC.B2)
        BTFSS       PORTC+0, 2 
        GOTO        L_program53
;PIN Code Project.c,243 ::                 original[i] = '2';
        MOVLW       _original+0
        ADDWF       _i+0, 0 
        MOVWF       FSR1 
        MOVLW       hi_addr(_original+0)
        ADDWFC      _i+1, 0 
        MOVWF       FSR1H 
        MOVLW       50
        MOVWF       POSTINC1+0 
;PIN Code Project.c,244 ::                 numentered = 1;
        MOVLW       1
        MOVWF       _numentered+0 
        MOVLW       0
        MOVWF       _numentered+1 
;PIN Code Project.c,245 ::                 digits[i] = '*';
        MOVLW       _digits+0
        ADDWF       _i+0, 0 
        MOVWF       FSR1 
        MOVLW       hi_addr(_digits+0)
        ADDWFC      _i+1, 0 
        MOVWF       FSR1H 
        MOVLW       42
        MOVWF       POSTINC1+0 
;PIN Code Project.c,246 ::                 i++;
        INFSNZ      _i+0, 1 
        INCF        _i+1, 1 
;PIN Code Project.c,247 ::                 }
        GOTO        L_program54
L_program53:
;PIN Code Project.c,248 ::                 else if(PORTC.B3)
        BTFSS       PORTC+0, 3 
        GOTO        L_program55
;PIN Code Project.c,250 ::                 original[i] = '3';
        MOVLW       _original+0
        ADDWF       _i+0, 0 
        MOVWF       FSR1 
        MOVLW       hi_addr(_original+0)
        ADDWFC      _i+1, 0 
        MOVWF       FSR1H 
        MOVLW       51
        MOVWF       POSTINC1+0 
;PIN Code Project.c,251 ::                 numentered = 1;
        MOVLW       1
        MOVWF       _numentered+0 
        MOVLW       0
        MOVWF       _numentered+1 
;PIN Code Project.c,252 ::                 digits[i] = '*';
        MOVLW       _digits+0
        ADDWF       _i+0, 0 
        MOVWF       FSR1 
        MOVLW       hi_addr(_digits+0)
        ADDWFC      _i+1, 0 
        MOVWF       FSR1H 
        MOVLW       42
        MOVWF       POSTINC1+0 
;PIN Code Project.c,253 ::                 i++;
        INFSNZ      _i+0, 1 
        INCF        _i+1, 1 
;PIN Code Project.c,254 ::                 }
        GOTO        L_program56
L_program55:
;PIN Code Project.c,255 ::                 else if(PORTC.B4)
        BTFSS       PORTC+0, 4 
        GOTO        L_program57
;PIN Code Project.c,257 ::                 original[i] = '4';
        MOVLW       _original+0
        ADDWF       _i+0, 0 
        MOVWF       FSR1 
        MOVLW       hi_addr(_original+0)
        ADDWFC      _i+1, 0 
        MOVWF       FSR1H 
        MOVLW       52
        MOVWF       POSTINC1+0 
;PIN Code Project.c,258 ::                 numentered = 1;
        MOVLW       1
        MOVWF       _numentered+0 
        MOVLW       0
        MOVWF       _numentered+1 
;PIN Code Project.c,259 ::                 digits[i] = '*';
        MOVLW       _digits+0
        ADDWF       _i+0, 0 
        MOVWF       FSR1 
        MOVLW       hi_addr(_digits+0)
        ADDWFC      _i+1, 0 
        MOVWF       FSR1H 
        MOVLW       42
        MOVWF       POSTINC1+0 
;PIN Code Project.c,260 ::                 i++;
        INFSNZ      _i+0, 1 
        INCF        _i+1, 1 
;PIN Code Project.c,261 ::                 }
        GOTO        L_program58
L_program57:
;PIN Code Project.c,262 ::                 else if(PORTC.B5)
        BTFSS       PORTC+0, 5 
        GOTO        L_program59
;PIN Code Project.c,264 ::                 original[i] = '5';
        MOVLW       _original+0
        ADDWF       _i+0, 0 
        MOVWF       FSR1 
        MOVLW       hi_addr(_original+0)
        ADDWFC      _i+1, 0 
        MOVWF       FSR1H 
        MOVLW       53
        MOVWF       POSTINC1+0 
;PIN Code Project.c,265 ::                 numentered = 1;
        MOVLW       1
        MOVWF       _numentered+0 
        MOVLW       0
        MOVWF       _numentered+1 
;PIN Code Project.c,266 ::                 digits[i] = '*';
        MOVLW       _digits+0
        ADDWF       _i+0, 0 
        MOVWF       FSR1 
        MOVLW       hi_addr(_digits+0)
        ADDWFC      _i+1, 0 
        MOVWF       FSR1H 
        MOVLW       42
        MOVWF       POSTINC1+0 
;PIN Code Project.c,267 ::                 i++;
        INFSNZ      _i+0, 1 
        INCF        _i+1, 1 
;PIN Code Project.c,268 ::                 }                    //
        GOTO        L_program60
L_program59:
;PIN Code Project.c,269 ::                 else if(PORTC.B6)
        BTFSS       PORTC+0, 6 
        GOTO        L_program61
;PIN Code Project.c,271 ::                 original[i] = '6';
        MOVLW       _original+0
        ADDWF       _i+0, 0 
        MOVWF       FSR1 
        MOVLW       hi_addr(_original+0)
        ADDWFC      _i+1, 0 
        MOVWF       FSR1H 
        MOVLW       54
        MOVWF       POSTINC1+0 
;PIN Code Project.c,272 ::                 numentered = 1;
        MOVLW       1
        MOVWF       _numentered+0 
        MOVLW       0
        MOVWF       _numentered+1 
;PIN Code Project.c,273 ::                 digits[i] = '*';
        MOVLW       _digits+0
        ADDWF       _i+0, 0 
        MOVWF       FSR1 
        MOVLW       hi_addr(_digits+0)
        ADDWFC      _i+1, 0 
        MOVWF       FSR1H 
        MOVLW       42
        MOVWF       POSTINC1+0 
;PIN Code Project.c,274 ::                 i++;
        INFSNZ      _i+0, 1 
        INCF        _i+1, 1 
;PIN Code Project.c,275 ::                 }
        GOTO        L_program62
L_program61:
;PIN Code Project.c,276 ::                 else if(PORTC.B7)
        BTFSS       PORTC+0, 7 
        GOTO        L_program63
;PIN Code Project.c,278 ::                 original[i] = '7';
        MOVLW       _original+0
        ADDWF       _i+0, 0 
        MOVWF       FSR1 
        MOVLW       hi_addr(_original+0)
        ADDWFC      _i+1, 0 
        MOVWF       FSR1H 
        MOVLW       55
        MOVWF       POSTINC1+0 
;PIN Code Project.c,279 ::                 numentered = 1;
        MOVLW       1
        MOVWF       _numentered+0 
        MOVLW       0
        MOVWF       _numentered+1 
;PIN Code Project.c,280 ::                 digits[i] = '*';
        MOVLW       _digits+0
        ADDWF       _i+0, 0 
        MOVWF       FSR1 
        MOVLW       hi_addr(_digits+0)
        ADDWFC      _i+1, 0 
        MOVWF       FSR1H 
        MOVLW       42
        MOVWF       POSTINC1+0 
;PIN Code Project.c,281 ::                 i++;
        INFSNZ      _i+0, 1 
        INCF        _i+1, 1 
;PIN Code Project.c,282 ::                 }
        GOTO        L_program64
L_program63:
;PIN Code Project.c,283 ::                 else if(PORTD.B0)
        BTFSS       PORTD+0, 0 
        GOTO        L_program65
;PIN Code Project.c,285 ::                 original[i] = '8';
        MOVLW       _original+0
        ADDWF       _i+0, 0 
        MOVWF       FSR1 
        MOVLW       hi_addr(_original+0)
        ADDWFC      _i+1, 0 
        MOVWF       FSR1H 
        MOVLW       56
        MOVWF       POSTINC1+0 
;PIN Code Project.c,286 ::                 numentered = 1;
        MOVLW       1
        MOVWF       _numentered+0 
        MOVLW       0
        MOVWF       _numentered+1 
;PIN Code Project.c,287 ::                 digits[i] = '*';
        MOVLW       _digits+0
        ADDWF       _i+0, 0 
        MOVWF       FSR1 
        MOVLW       hi_addr(_digits+0)
        ADDWFC      _i+1, 0 
        MOVWF       FSR1H 
        MOVLW       42
        MOVWF       POSTINC1+0 
;PIN Code Project.c,288 ::                 i++;
        INFSNZ      _i+0, 1 
        INCF        _i+1, 1 
;PIN Code Project.c,289 ::                 }
        GOTO        L_program66
L_program65:
;PIN Code Project.c,290 ::                 else if(PORTD.B1)
        BTFSS       PORTD+0, 1 
        GOTO        L_program67
;PIN Code Project.c,292 ::                 original[i] = '9';
        MOVLW       _original+0
        ADDWF       _i+0, 0 
        MOVWF       FSR1 
        MOVLW       hi_addr(_original+0)
        ADDWFC      _i+1, 0 
        MOVWF       FSR1H 
        MOVLW       57
        MOVWF       POSTINC1+0 
;PIN Code Project.c,293 ::                 numentered = 1;
        MOVLW       1
        MOVWF       _numentered+0 
        MOVLW       0
        MOVWF       _numentered+1 
;PIN Code Project.c,294 ::                 digits[i] = '*';
        MOVLW       _digits+0
        ADDWF       _i+0, 0 
        MOVWF       FSR1 
        MOVLW       hi_addr(_digits+0)
        ADDWFC      _i+1, 0 
        MOVWF       FSR1H 
        MOVLW       42
        MOVWF       POSTINC1+0 
;PIN Code Project.c,295 ::                 i++;
        INFSNZ      _i+0, 1 
        INCF        _i+1, 1 
;PIN Code Project.c,296 ::                 }
        GOTO        L_program68
L_program67:
;PIN Code Project.c,297 ::                 else;
L_program68:
L_program66:
L_program64:
L_program62:
L_program60:
L_program58:
L_program56:
L_program54:
L_program52:
L_program50:
;PIN Code Project.c,298 ::                 Lcd_Out(2, 9, digits);   //output stars according to how many inputs there have been.
        MOVLW       2
        MOVWF       FARG_Lcd_Out_row+0 
        MOVLW       9
        MOVWF       FARG_Lcd_Out_column+0 
        MOVLW       _digits+0
        MOVWF       FARG_Lcd_Out_text+0 
        MOVLW       hi_addr(_digits+0)
        MOVWF       FARG_Lcd_Out_text+1 
        CALL        _Lcd_Out+0, 0
;PIN Code Project.c,299 ::                 }
        GOTO        L_program69
L_program48:
;PIN Code Project.c,300 ::                 else;
L_program69:
;PIN Code Project.c,301 ::                 } while(i<4);
        MOVLW       128
        XORWF       _i+1, 0 
        MOVWF       R0 
        MOVLW       128
        SUBWF       R0, 0 
        BTFSS       STATUS+0, 2 
        GOTO        L__program123
        MOVLW       4
        SUBWF       _i+0, 0 
L__program123:
        BTFSS       STATUS+0, 0 
        GOTO        L_program44
;PIN Code Project.c,302 ::                 Lcd_Cmd(_LCD_CLEAR);
        MOVLW       1
        MOVWF       FARG_Lcd_Cmd_out_char+0 
        CALL        _Lcd_Cmd+0, 0
;PIN Code Project.c,303 ::                 Lcd_Out(1,4, "Enter your pin");
        MOVLW       1
        MOVWF       FARG_Lcd_Out_row+0 
        MOVLW       4
        MOVWF       FARG_Lcd_Out_column+0 
        MOVLW       ?lstr5_PIN_32Code_32Project+0
        MOVWF       FARG_Lcd_Out_text+0 
        MOVLW       hi_addr(?lstr5_PIN_32Code_32Project+0)
        MOVWF       FARG_Lcd_Out_text+1 
        CALL        _Lcd_Out+0, 0
;PIN Code Project.c,304 ::                 Lcd_Out(2,9, "****");
        MOVLW       2
        MOVWF       FARG_Lcd_Out_row+0 
        MOVLW       9
        MOVWF       FARG_Lcd_Out_column+0 
        MOVLW       ?lstr6_PIN_32Code_32Project+0
        MOVWF       FARG_Lcd_Out_text+0 
        MOVLW       hi_addr(?lstr6_PIN_32Code_32Project+0)
        MOVWF       FARG_Lcd_Out_text+1 
        CALL        _Lcd_Out+0, 0
;PIN Code Project.c,305 ::                 EEPROM_WRITE(0x01, original[0]-48u);
        MOVLW       1
        MOVWF       FARG_EEPROM_Write_address+0 
        MOVLW       48
        SUBWF       _original+0, 0 
        MOVWF       FARG_EEPROM_Write_data_+0 
        CALL        _EEPROM_Write+0, 0
;PIN Code Project.c,306 ::                 EEPROM_WRITE(0x02, original[1]-48u);
        MOVLW       2
        MOVWF       FARG_EEPROM_Write_address+0 
        MOVLW       48
        SUBWF       _original+1, 0 
        MOVWF       FARG_EEPROM_Write_data_+0 
        CALL        _EEPROM_Write+0, 0
;PIN Code Project.c,307 ::                 EEPROM_WRITE(0x03, original[2]-48u);
        MOVLW       3
        MOVWF       FARG_EEPROM_Write_address+0 
        MOVLW       48
        SUBWF       _original+2, 0 
        MOVWF       FARG_EEPROM_Write_data_+0 
        CALL        _EEPROM_Write+0, 0
;PIN Code Project.c,308 ::                 EEPROM_WRITE(0x04, original[3]-48u);
        MOVLW       4
        MOVWF       FARG_EEPROM_Write_address+0 
        MOVLW       48
        SUBWF       _original+3, 0 
        MOVWF       FARG_EEPROM_Write_data_+0 
        CALL        _EEPROM_Write+0, 0
;PIN Code Project.c,309 ::                 Delay_ms(500);
        MOVLW       6
        MOVWF       R11, 0
        MOVLW       19
        MOVWF       R12, 0
        MOVLW       173
        MOVWF       R13, 0
L_program70:
        DECFSZ      R13, 1, 1
        BRA         L_program70
        DECFSZ      R12, 1, 1
        BRA         L_program70
        DECFSZ      R11, 1, 1
        BRA         L_program70
        NOP
        NOP
;PIN Code Project.c,310 ::                 return;
;PIN Code Project.c,311 ::                 }
L_end_program:
        RETURN      0
; end of _program

_test:

;PIN Code Project.c,317 ::                 void test()                                            //similar to program() with some additions
;PIN Code Project.c,319 ::                 while (1)
L_test71:
;PIN Code Project.c,321 ::                 Lcd_Cmd(_LCD_CLEAR);
        MOVLW       1
        MOVWF       FARG_Lcd_Cmd_out_char+0 
        CALL        _Lcd_Cmd+0, 0
;PIN Code Project.c,322 ::                 Lcd_Out(1,4, "Guess the Pin!");
        MOVLW       1
        MOVWF       FARG_Lcd_Out_row+0 
        MOVLW       4
        MOVWF       FARG_Lcd_Out_column+0 
        MOVLW       ?lstr7_PIN_32Code_32Project+0
        MOVWF       FARG_Lcd_Out_text+0 
        MOVLW       hi_addr(?lstr7_PIN_32Code_32Project+0)
        MOVWF       FARG_Lcd_Out_text+1 
        CALL        _Lcd_Out+0, 0
;PIN Code Project.c,323 ::                 i = 0;
        CLRF        _i+0 
        CLRF        _i+1 
;PIN Code Project.c,324 ::                 do
L_test73:
;PIN Code Project.c,326 ::                 if(!PORTC & !PORTD.B0 & !PORTD.B1)
        MOVF        PORTC+0, 1 
        MOVLW       1
        BTFSS       STATUS+0, 2 
        MOVLW       0
        MOVWF       R1 
        BTFSC       PORTD+0, 0 
        GOTO        L__test125
        BSF         4056, 0 
        GOTO        L__test126
L__test125:
        BCF         4056, 0 
L__test126:
        CLRF        R0 
        BTFSC       4056, 0 
        INCF        R0, 1 
        MOVF        R0, 0 
        ANDWF       R1, 1 
        BTFSC       PORTD+0, 1 
        GOTO        L__test127
        BSF         4056, 0 
        GOTO        L__test128
L__test127:
        BCF         4056, 0 
L__test128:
        CLRF        R0 
        BTFSC       4056, 0 
        INCF        R0, 1 
        MOVF        R1, 0 
        ANDWF       R0, 1 
        BTFSC       STATUS+0, 2 
        GOTO        L_test76
;PIN Code Project.c,327 ::                 numentered = 0;
        CLRF        _numentered+0 
        CLRF        _numentered+1 
L_test76:
;PIN Code Project.c,328 ::                 if(numentered == 0){
        MOVLW       0
        XORWF       _numentered+1, 0 
        BTFSS       STATUS+0, 2 
        GOTO        L__test129
        MOVLW       0
        XORWF       _numentered+0, 0 
L__test129:
        BTFSS       STATUS+0, 2 
        GOTO        L_test77
;PIN Code Project.c,329 ::                 if(PORTC.B0)
        BTFSS       PORTC+0, 0 
        GOTO        L_test78
;PIN Code Project.c,331 ::                 guess[i] = '0';
        MOVLW       _guess+0
        ADDWF       _i+0, 0 
        MOVWF       FSR1 
        MOVLW       hi_addr(_guess+0)
        ADDWFC      _i+1, 0 
        MOVWF       FSR1H 
        MOVLW       48
        MOVWF       POSTINC1+0 
;PIN Code Project.c,332 ::                 numentered = 1;
        MOVLW       1
        MOVWF       _numentered+0 
        MOVLW       0
        MOVWF       _numentered+1 
;PIN Code Project.c,333 ::                 digits[i] = '0';
        MOVLW       _digits+0
        ADDWF       _i+0, 0 
        MOVWF       FSR1 
        MOVLW       hi_addr(_digits+0)
        ADDWFC      _i+1, 0 
        MOVWF       FSR1H 
        MOVLW       48
        MOVWF       POSTINC1+0 
;PIN Code Project.c,334 ::                 i++;
        INFSNZ      _i+0, 1 
        INCF        _i+1, 1 
;PIN Code Project.c,335 ::                 }
        GOTO        L_test79
L_test78:
;PIN Code Project.c,336 ::                 else if(PORTC.B1)
        BTFSS       PORTC+0, 1 
        GOTO        L_test80
;PIN Code Project.c,338 ::                 guess[i] = '1';
        MOVLW       _guess+0
        ADDWF       _i+0, 0 
        MOVWF       FSR1 
        MOVLW       hi_addr(_guess+0)
        ADDWFC      _i+1, 0 
        MOVWF       FSR1H 
        MOVLW       49
        MOVWF       POSTINC1+0 
;PIN Code Project.c,339 ::                 numentered = 1;
        MOVLW       1
        MOVWF       _numentered+0 
        MOVLW       0
        MOVWF       _numentered+1 
;PIN Code Project.c,340 ::                 digits[i] = '1';
        MOVLW       _digits+0
        ADDWF       _i+0, 0 
        MOVWF       FSR1 
        MOVLW       hi_addr(_digits+0)
        ADDWFC      _i+1, 0 
        MOVWF       FSR1H 
        MOVLW       49
        MOVWF       POSTINC1+0 
;PIN Code Project.c,341 ::                 i++;
        INFSNZ      _i+0, 1 
        INCF        _i+1, 1 
;PIN Code Project.c,342 ::                 }
        GOTO        L_test81
L_test80:
;PIN Code Project.c,343 ::                 else if(PORTC.B2)
        BTFSS       PORTC+0, 2 
        GOTO        L_test82
;PIN Code Project.c,345 ::                 guess[i] = '2';
        MOVLW       _guess+0
        ADDWF       _i+0, 0 
        MOVWF       FSR1 
        MOVLW       hi_addr(_guess+0)
        ADDWFC      _i+1, 0 
        MOVWF       FSR1H 
        MOVLW       50
        MOVWF       POSTINC1+0 
;PIN Code Project.c,346 ::                 numentered = 1;
        MOVLW       1
        MOVWF       _numentered+0 
        MOVLW       0
        MOVWF       _numentered+1 
;PIN Code Project.c,347 ::                 digits[i] = '2';
        MOVLW       _digits+0
        ADDWF       _i+0, 0 
        MOVWF       FSR1 
        MOVLW       hi_addr(_digits+0)
        ADDWFC      _i+1, 0 
        MOVWF       FSR1H 
        MOVLW       50
        MOVWF       POSTINC1+0 
;PIN Code Project.c,348 ::                 i++;
        INFSNZ      _i+0, 1 
        INCF        _i+1, 1 
;PIN Code Project.c,349 ::                 }
        GOTO        L_test83
L_test82:
;PIN Code Project.c,350 ::                 else if(PORTC.B3)
        BTFSS       PORTC+0, 3 
        GOTO        L_test84
;PIN Code Project.c,352 ::                 guess[i] = '3';
        MOVLW       _guess+0
        ADDWF       _i+0, 0 
        MOVWF       FSR1 
        MOVLW       hi_addr(_guess+0)
        ADDWFC      _i+1, 0 
        MOVWF       FSR1H 
        MOVLW       51
        MOVWF       POSTINC1+0 
;PIN Code Project.c,353 ::                 numentered = 1;
        MOVLW       1
        MOVWF       _numentered+0 
        MOVLW       0
        MOVWF       _numentered+1 
;PIN Code Project.c,354 ::                 digits[i] = '3';
        MOVLW       _digits+0
        ADDWF       _i+0, 0 
        MOVWF       FSR1 
        MOVLW       hi_addr(_digits+0)
        ADDWFC      _i+1, 0 
        MOVWF       FSR1H 
        MOVLW       51
        MOVWF       POSTINC1+0 
;PIN Code Project.c,355 ::                 i++;
        INFSNZ      _i+0, 1 
        INCF        _i+1, 1 
;PIN Code Project.c,356 ::                 }
        GOTO        L_test85
L_test84:
;PIN Code Project.c,357 ::                 else if(PORTC.B4)
        BTFSS       PORTC+0, 4 
        GOTO        L_test86
;PIN Code Project.c,359 ::                 guess[i] = '4';
        MOVLW       _guess+0
        ADDWF       _i+0, 0 
        MOVWF       FSR1 
        MOVLW       hi_addr(_guess+0)
        ADDWFC      _i+1, 0 
        MOVWF       FSR1H 
        MOVLW       52
        MOVWF       POSTINC1+0 
;PIN Code Project.c,360 ::                 numentered = 1;
        MOVLW       1
        MOVWF       _numentered+0 
        MOVLW       0
        MOVWF       _numentered+1 
;PIN Code Project.c,361 ::                 digits[i] = '4';
        MOVLW       _digits+0
        ADDWF       _i+0, 0 
        MOVWF       FSR1 
        MOVLW       hi_addr(_digits+0)
        ADDWFC      _i+1, 0 
        MOVWF       FSR1H 
        MOVLW       52
        MOVWF       POSTINC1+0 
;PIN Code Project.c,362 ::                 i++;
        INFSNZ      _i+0, 1 
        INCF        _i+1, 1 
;PIN Code Project.c,363 ::                 }
        GOTO        L_test87
L_test86:
;PIN Code Project.c,364 ::                 else if(PORTC.B5)
        BTFSS       PORTC+0, 5 
        GOTO        L_test88
;PIN Code Project.c,366 ::                 guess[i] = '5';
        MOVLW       _guess+0
        ADDWF       _i+0, 0 
        MOVWF       FSR1 
        MOVLW       hi_addr(_guess+0)
        ADDWFC      _i+1, 0 
        MOVWF       FSR1H 
        MOVLW       53
        MOVWF       POSTINC1+0 
;PIN Code Project.c,367 ::                 numentered = 1;
        MOVLW       1
        MOVWF       _numentered+0 
        MOVLW       0
        MOVWF       _numentered+1 
;PIN Code Project.c,368 ::                 digits[i] = '5';
        MOVLW       _digits+0
        ADDWF       _i+0, 0 
        MOVWF       FSR1 
        MOVLW       hi_addr(_digits+0)
        ADDWFC      _i+1, 0 
        MOVWF       FSR1H 
        MOVLW       53
        MOVWF       POSTINC1+0 
;PIN Code Project.c,369 ::                 i++;
        INFSNZ      _i+0, 1 
        INCF        _i+1, 1 
;PIN Code Project.c,370 ::                 }
        GOTO        L_test89
L_test88:
;PIN Code Project.c,371 ::                 else if(PORTC.B6)
        BTFSS       PORTC+0, 6 
        GOTO        L_test90
;PIN Code Project.c,373 ::                 guess[i] = '6';
        MOVLW       _guess+0
        ADDWF       _i+0, 0 
        MOVWF       FSR1 
        MOVLW       hi_addr(_guess+0)
        ADDWFC      _i+1, 0 
        MOVWF       FSR1H 
        MOVLW       54
        MOVWF       POSTINC1+0 
;PIN Code Project.c,374 ::                 numentered = 1;
        MOVLW       1
        MOVWF       _numentered+0 
        MOVLW       0
        MOVWF       _numentered+1 
;PIN Code Project.c,375 ::                 digits[i] = '6';
        MOVLW       _digits+0
        ADDWF       _i+0, 0 
        MOVWF       FSR1 
        MOVLW       hi_addr(_digits+0)
        ADDWFC      _i+1, 0 
        MOVWF       FSR1H 
        MOVLW       54
        MOVWF       POSTINC1+0 
;PIN Code Project.c,376 ::                 i++;
        INFSNZ      _i+0, 1 
        INCF        _i+1, 1 
;PIN Code Project.c,377 ::                 }
        GOTO        L_test91
L_test90:
;PIN Code Project.c,378 ::                 else if(PORTC.B7)
        BTFSS       PORTC+0, 7 
        GOTO        L_test92
;PIN Code Project.c,380 ::                 guess[i] = '7';
        MOVLW       _guess+0
        ADDWF       _i+0, 0 
        MOVWF       FSR1 
        MOVLW       hi_addr(_guess+0)
        ADDWFC      _i+1, 0 
        MOVWF       FSR1H 
        MOVLW       55
        MOVWF       POSTINC1+0 
;PIN Code Project.c,381 ::                 numentered = 1;
        MOVLW       1
        MOVWF       _numentered+0 
        MOVLW       0
        MOVWF       _numentered+1 
;PIN Code Project.c,382 ::                 digits[i] = '7';
        MOVLW       _digits+0
        ADDWF       _i+0, 0 
        MOVWF       FSR1 
        MOVLW       hi_addr(_digits+0)
        ADDWFC      _i+1, 0 
        MOVWF       FSR1H 
        MOVLW       55
        MOVWF       POSTINC1+0 
;PIN Code Project.c,383 ::                 i++;
        INFSNZ      _i+0, 1 
        INCF        _i+1, 1 
;PIN Code Project.c,384 ::                 }
        GOTO        L_test93
L_test92:
;PIN Code Project.c,385 ::                 else if(PORTD.B0)
        BTFSS       PORTD+0, 0 
        GOTO        L_test94
;PIN Code Project.c,387 ::                 guess[i] = '8';
        MOVLW       _guess+0
        ADDWF       _i+0, 0 
        MOVWF       FSR1 
        MOVLW       hi_addr(_guess+0)
        ADDWFC      _i+1, 0 
        MOVWF       FSR1H 
        MOVLW       56
        MOVWF       POSTINC1+0 
;PIN Code Project.c,388 ::                 numentered = 1;
        MOVLW       1
        MOVWF       _numentered+0 
        MOVLW       0
        MOVWF       _numentered+1 
;PIN Code Project.c,389 ::                 digits[i] = '8';
        MOVLW       _digits+0
        ADDWF       _i+0, 0 
        MOVWF       FSR1 
        MOVLW       hi_addr(_digits+0)
        ADDWFC      _i+1, 0 
        MOVWF       FSR1H 
        MOVLW       56
        MOVWF       POSTINC1+0 
;PIN Code Project.c,390 ::                 i++;
        INFSNZ      _i+0, 1 
        INCF        _i+1, 1 
;PIN Code Project.c,391 ::                 }
        GOTO        L_test95
L_test94:
;PIN Code Project.c,392 ::                 else if(PORTD.B1)
        BTFSS       PORTD+0, 1 
        GOTO        L_test96
;PIN Code Project.c,394 ::                 guess[i] = '9';
        MOVLW       _guess+0
        ADDWF       _i+0, 0 
        MOVWF       FSR1 
        MOVLW       hi_addr(_guess+0)
        ADDWFC      _i+1, 0 
        MOVWF       FSR1H 
        MOVLW       57
        MOVWF       POSTINC1+0 
;PIN Code Project.c,395 ::                 numentered = 1;
        MOVLW       1
        MOVWF       _numentered+0 
        MOVLW       0
        MOVWF       _numentered+1 
;PIN Code Project.c,396 ::                 digits[i] = '9';
        MOVLW       _digits+0
        ADDWF       _i+0, 0 
        MOVWF       FSR1 
        MOVLW       hi_addr(_digits+0)
        ADDWFC      _i+1, 0 
        MOVWF       FSR1H 
        MOVLW       57
        MOVWF       POSTINC1+0 
;PIN Code Project.c,397 ::                 i++;
        INFSNZ      _i+0, 1 
        INCF        _i+1, 1 
;PIN Code Project.c,398 ::                 }
        GOTO        L_test97
L_test96:
;PIN Code Project.c,399 ::                 else;
L_test97:
L_test95:
L_test93:
L_test91:
L_test89:
L_test87:
L_test85:
L_test83:
L_test81:
L_test79:
;PIN Code Project.c,400 ::                 Lcd_Out(2, 9, digits);
        MOVLW       2
        MOVWF       FARG_Lcd_Out_row+0 
        MOVLW       9
        MOVWF       FARG_Lcd_Out_column+0 
        MOVLW       _digits+0
        MOVWF       FARG_Lcd_Out_text+0 
        MOVLW       hi_addr(_digits+0)
        MOVWF       FARG_Lcd_Out_text+1 
        CALL        _Lcd_Out+0, 0
;PIN Code Project.c,401 ::                 }
        GOTO        L_test98
L_test77:
;PIN Code Project.c,402 ::                 else;
L_test98:
;PIN Code Project.c,403 ::                 } while(i<4);
        MOVLW       128
        XORWF       _i+1, 0 
        MOVWF       R0 
        MOVLW       128
        SUBWF       R0, 0 
        BTFSS       STATUS+0, 2 
        GOTO        L__test130
        MOVLW       4
        SUBWF       _i+0, 0 
L__test130:
        BTFSS       STATUS+0, 0 
        GOTO        L_test73
;PIN Code Project.c,404 ::                 if(original[0] == guess[0] & original[1] == guess[1] & original[2] == guess[2] & original[3] == guess[3]) // test equality
        MOVF        _original+0, 0 
        XORWF       _guess+0, 0 
        MOVLW       1
        BTFSS       STATUS+0, 2 
        MOVLW       0
        MOVWF       R1 
        MOVF        _original+1, 0 
        XORWF       _guess+1, 0 
        MOVLW       1
        BTFSS       STATUS+0, 2 
        MOVLW       0
        MOVWF       R0 
        MOVF        R0, 0 
        ANDWF       R1, 1 
        MOVF        _original+2, 0 
        XORWF       _guess+2, 0 
        MOVLW       1
        BTFSS       STATUS+0, 2 
        MOVLW       0
        MOVWF       R0 
        MOVF        R0, 0 
        ANDWF       R1, 1 
        MOVF        _original+3, 0 
        XORWF       _guess+3, 0 
        MOVLW       1
        BTFSS       STATUS+0, 2 
        MOVLW       0
        MOVWF       R0 
        MOVF        R1, 0 
        ANDWF       R0, 1 
        BTFSC       STATUS+0, 2 
        GOTO        L_test99
;PIN Code Project.c,406 ::                 break; //break if equal
        GOTO        L_test72
;PIN Code Project.c,407 ::                 }
L_test99:
;PIN Code Project.c,410 ::                 Lcd_Cmd(_LCD_CLEAR);
        MOVLW       1
        MOVWF       FARG_Lcd_Cmd_out_char+0 
        CALL        _Lcd_Cmd+0, 0
;PIN Code Project.c,411 ::                 Lcd_Out(1,4,"Incorrect Pin!");
        MOVLW       1
        MOVWF       FARG_Lcd_Out_row+0 
        MOVLW       4
        MOVWF       FARG_Lcd_Out_column+0 
        MOVLW       ?lstr8_PIN_32Code_32Project+0
        MOVWF       FARG_Lcd_Out_text+0 
        MOVLW       hi_addr(?lstr8_PIN_32Code_32Project+0)
        MOVWF       FARG_Lcd_Out_text+1 
        CALL        _Lcd_Out+0, 0
;PIN Code Project.c,412 ::                 Delay_ms(1000);
        MOVLW       11
        MOVWF       R11, 0
        MOVLW       38
        MOVWF       R12, 0
        MOVLW       93
        MOVWF       R13, 0
L_test101:
        DECFSZ      R13, 1, 1
        BRA         L_test101
        DECFSZ      R12, 1, 1
        BRA         L_test101
        DECFSZ      R11, 1, 1
        BRA         L_test101
        NOP
        NOP
;PIN Code Project.c,413 ::                 PORTD = 0x00;
        CLRF        PORTD+0 
;PIN Code Project.c,414 ::                 PORTC = 0x00;
        CLRF        PORTC+0 
;PIN Code Project.c,415 ::                 for(i = 0; i < 4; i++)
        CLRF        _i+0 
        CLRF        _i+1 
L_test102:
        MOVLW       128
        XORWF       _i+1, 0 
        MOVWF       R0 
        MOVLW       128
        SUBWF       R0, 0 
        BTFSS       STATUS+0, 2 
        GOTO        L__test131
        MOVLW       4
        SUBWF       _i+0, 0 
L__test131:
        BTFSC       STATUS+0, 0 
        GOTO        L_test103
;PIN Code Project.c,417 ::                 guess[i] = '\0';
        MOVLW       _guess+0
        ADDWF       _i+0, 0 
        MOVWF       FSR1 
        MOVLW       hi_addr(_guess+0)
        ADDWFC      _i+1, 0 
        MOVWF       FSR1H 
        CLRF        POSTINC1+0 
;PIN Code Project.c,418 ::                 digits[i] = '\0';
        MOVLW       _digits+0
        ADDWF       _i+0, 0 
        MOVWF       FSR1 
        MOVLW       hi_addr(_digits+0)
        ADDWFC      _i+1, 0 
        MOVWF       FSR1H 
        CLRF        POSTINC1+0 
;PIN Code Project.c,415 ::                 for(i = 0; i < 4; i++)
        INFSNZ      _i+0, 1 
        INCF        _i+1, 1 
;PIN Code Project.c,419 ::                 }
        GOTO        L_test102
L_test103:
;PIN Code Project.c,421 ::                 }
        GOTO        L_test71
L_test72:
;PIN Code Project.c,422 ::                 return;
;PIN Code Project.c,423 ::                 }
L_end_test:
        RETURN      0
; end of _test

_develop:

;PIN Code Project.c,429 ::                 void develop()
;PIN Code Project.c,431 ::                 Lcd_Cmd(_LCD_CLEAR);
        MOVLW       1
        MOVWF       FARG_Lcd_Cmd_out_char+0 
        CALL        _Lcd_Cmd+0, 0
;PIN Code Project.c,432 ::                 Lcd_Out(1, 3, "4 Digit Pin Lock");
        MOVLW       1
        MOVWF       FARG_Lcd_Out_row+0 
        MOVLW       3
        MOVWF       FARG_Lcd_Out_column+0 
        MOVLW       ?lstr9_PIN_32Code_32Project+0
        MOVWF       FARG_Lcd_Out_text+0 
        MOVLW       hi_addr(?lstr9_PIN_32Code_32Project+0)
        MOVWF       FARG_Lcd_Out_text+1 
        CALL        _Lcd_Out+0, 0
;PIN Code Project.c,433 ::                 Lcd_Out(2, 2, "4th Marking Period");
        MOVLW       2
        MOVWF       FARG_Lcd_Out_row+0 
        MOVLW       2
        MOVWF       FARG_Lcd_Out_column+0 
        MOVLW       ?lstr10_PIN_32Code_32Project+0
        MOVWF       FARG_Lcd_Out_text+0 
        MOVLW       hi_addr(?lstr10_PIN_32Code_32Project+0)
        MOVWF       FARG_Lcd_Out_text+1 
        CALL        _Lcd_Out+0, 0
;PIN Code Project.c,434 ::                 Lcd_Out(3, 4, "Ravi Sinha 2014");
        MOVLW       3
        MOVWF       FARG_Lcd_Out_row+0 
        MOVLW       4
        MOVWF       FARG_Lcd_Out_column+0 
        MOVLW       ?lstr11_PIN_32Code_32Project+0
        MOVWF       FARG_Lcd_Out_text+0 
        MOVLW       hi_addr(?lstr11_PIN_32Code_32Project+0)
        MOVWF       FARG_Lcd_Out_text+1 
        CALL        _Lcd_Out+0, 0
;PIN Code Project.c,435 ::                 Lcd_Out(4,6, "Version 5.9");
        MOVLW       4
        MOVWF       FARG_Lcd_Out_row+0 
        MOVLW       6
        MOVWF       FARG_Lcd_Out_column+0 
        MOVLW       ?lstr12_PIN_32Code_32Project+0
        MOVWF       FARG_Lcd_Out_text+0 
        MOVLW       hi_addr(?lstr12_PIN_32Code_32Project+0)
        MOVWF       FARG_Lcd_Out_text+1 
        CALL        _Lcd_Out+0, 0
;PIN Code Project.c,436 ::                 Delay_ms(2500);
        MOVLW       26
        MOVWF       R11, 0
        MOVLW       94
        MOVWF       R12, 0
        MOVLW       110
        MOVWF       R13, 0
L_develop105:
        DECFSZ      R13, 1, 1
        BRA         L_develop105
        DECFSZ      R12, 1, 1
        BRA         L_develop105
        DECFSZ      R11, 1, 1
        BRA         L_develop105
        NOP
;PIN Code Project.c,437 ::                 Lcd_Cmd(_LCD_CLEAR);
        MOVLW       1
        MOVWF       FARG_Lcd_Cmd_out_char+0 
        CALL        _Lcd_Cmd+0, 0
;PIN Code Project.c,438 ::                 Lcd_Out(1,4, "Welcome to the ");
        MOVLW       1
        MOVWF       FARG_Lcd_Out_row+0 
        MOVLW       4
        MOVWF       FARG_Lcd_Out_column+0 
        MOVLW       ?lstr13_PIN_32Code_32Project+0
        MOVWF       FARG_Lcd_Out_text+0 
        MOVLW       hi_addr(?lstr13_PIN_32Code_32Project+0)
        MOVWF       FARG_Lcd_Out_text+1 
        CALL        _Lcd_Out+0, 0
;PIN Code Project.c,439 ::                 Lcd_Out(2,3,"Pin Code Checker");
        MOVLW       2
        MOVWF       FARG_Lcd_Out_row+0 
        MOVLW       3
        MOVWF       FARG_Lcd_Out_column+0 
        MOVLW       ?lstr14_PIN_32Code_32Project+0
        MOVWF       FARG_Lcd_Out_text+0 
        MOVLW       hi_addr(?lstr14_PIN_32Code_32Project+0)
        MOVWF       FARG_Lcd_Out_text+1 
        CALL        _Lcd_Out+0, 0
;PIN Code Project.c,440 ::                 return;
;PIN Code Project.c,441 ::                 }
L_end_develop:
        RETURN      0
; end of _develop

_instruction:

;PIN Code Project.c,447 ::                 void instruction()
;PIN Code Project.c,449 ::                 Lcd_Cmd(_LCD_CLEAR);
        MOVLW       1
        MOVWF       FARG_Lcd_Cmd_out_char+0 
        CALL        _Lcd_Cmd+0, 0
;PIN Code Project.c,450 ::                 Lcd_Out(1, 1, "RC0 -> RC7 = 0 -> 7");
        MOVLW       1
        MOVWF       FARG_Lcd_Out_row+0 
        MOVLW       1
        MOVWF       FARG_Lcd_Out_column+0 
        MOVLW       ?lstr15_PIN_32Code_32Project+0
        MOVWF       FARG_Lcd_Out_text+0 
        MOVLW       hi_addr(?lstr15_PIN_32Code_32Project+0)
        MOVWF       FARG_Lcd_Out_text+1 
        CALL        _Lcd_Out+0, 0
;PIN Code Project.c,451 ::                 Lcd_Out(2, 1, "RD0 -> RD1 = 8 -> 9");
        MOVLW       2
        MOVWF       FARG_Lcd_Out_row+0 
        MOVLW       1
        MOVWF       FARG_Lcd_Out_column+0 
        MOVLW       ?lstr16_PIN_32Code_32Project+0
        MOVWF       FARG_Lcd_Out_text+0 
        MOVLW       hi_addr(?lstr16_PIN_32Code_32Project+0)
        MOVWF       FARG_Lcd_Out_text+1 
        CALL        _Lcd_Out+0, 0
;PIN Code Project.c,452 ::                 Lcd_Out(3, 1, "RD2 = Guess the pin");
        MOVLW       3
        MOVWF       FARG_Lcd_Out_row+0 
        MOVLW       1
        MOVWF       FARG_Lcd_Out_column+0 
        MOVLW       ?lstr17_PIN_32Code_32Project+0
        MOVWF       FARG_Lcd_Out_text+0 
        MOVLW       hi_addr(?lstr17_PIN_32Code_32Project+0)
        MOVWF       FARG_Lcd_Out_text+1 
        CALL        _Lcd_Out+0, 0
;PIN Code Project.c,453 ::                 Lcd_Out(4,1, "RD3 = Create the pin");
        MOVLW       4
        MOVWF       FARG_Lcd_Out_row+0 
        MOVLW       1
        MOVWF       FARG_Lcd_Out_column+0 
        MOVLW       ?lstr18_PIN_32Code_32Project+0
        MOVWF       FARG_Lcd_Out_text+0 
        MOVLW       hi_addr(?lstr18_PIN_32Code_32Project+0)
        MOVWF       FARG_Lcd_Out_text+1 
        CALL        _Lcd_Out+0, 0
;PIN Code Project.c,454 ::                 Delay_ms(2500);
        MOVLW       26
        MOVWF       R11, 0
        MOVLW       94
        MOVWF       R12, 0
        MOVLW       110
        MOVWF       R13, 0
L_instruction106:
        DECFSZ      R13, 1, 1
        BRA         L_instruction106
        DECFSZ      R12, 1, 1
        BRA         L_instruction106
        DECFSZ      R11, 1, 1
        BRA         L_instruction106
        NOP
;PIN Code Project.c,455 ::                 Lcd_Cmd(_LCD_CLEAR);
        MOVLW       1
        MOVWF       FARG_Lcd_Cmd_out_char+0 
        CALL        _Lcd_Cmd+0, 0
;PIN Code Project.c,456 ::                 Lcd_Out(1,4, "Welcome to the ");
        MOVLW       1
        MOVWF       FARG_Lcd_Out_row+0 
        MOVLW       4
        MOVWF       FARG_Lcd_Out_column+0 
        MOVLW       ?lstr19_PIN_32Code_32Project+0
        MOVWF       FARG_Lcd_Out_text+0 
        MOVLW       hi_addr(?lstr19_PIN_32Code_32Project+0)
        MOVWF       FARG_Lcd_Out_text+1 
        CALL        _Lcd_Out+0, 0
;PIN Code Project.c,457 ::                 Lcd_Out(2,3,"Pin Code Checker");
        MOVLW       2
        MOVWF       FARG_Lcd_Out_row+0 
        MOVLW       3
        MOVWF       FARG_Lcd_Out_column+0 
        MOVLW       ?lstr20_PIN_32Code_32Project+0
        MOVWF       FARG_Lcd_Out_text+0 
        MOVLW       hi_addr(?lstr20_PIN_32Code_32Project+0)
        MOVWF       FARG_Lcd_Out_text+1 
        CALL        _Lcd_Out+0, 0
;PIN Code Project.c,458 ::                 return;
;PIN Code Project.c,459 ::                 }
L_end_instruction:
        RETURN      0
; end of _instruction
