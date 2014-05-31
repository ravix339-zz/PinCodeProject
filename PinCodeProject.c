/*
 *
 * 4 Digit Pin Lock Programmer/Checker  Version 5.9
 *
 * Ravi Sinha 2014
 * 4th Marking Period Assembly Language Project
 *
 * Purpose:
 *
 * Much like on a phone, the user is allowed to create a pin code and
 * be able to try and guess the pin code. This program allows for the
 * microcontroller, Microchip's PIC18F45K22, to complete this very purpose
 * through user inputs on the pins, either PORTC or PORTD of the micro-
 * controller. In actual implementation, the MikroE's EasyPIC V7 Development
 * board was used to simplify the hardware.
 *
 * Program overview:
 *
 * The following program contains five functions: main(), program(), test(),
 * develop(), and instruction(). Before entering any functions, the program reads
 * the EEPROM within the microcontroller and if this use is not the first time
 * since the last programming, the previously stored code (via program() ) would
 * be the default code. If this is the first usage since the last software download,
 * then the default code is "0123". In the function program(), the user programs
 * the desired pin they'd like. It stores the code into the EEPROM. Test() is a 
 * function that allows the user to infinitely try to guess the pin stored via
 *  program(). The main()function is used to create a common place to activate 
 * and enter the otherfour functions allowing for a functional program for the 
 * microcontroller. The develop() function allows the user to see the version of
 * the program and other program information. The instruction() function informs the
 * user which pins on the microcontroller control the what (for the actual pin 
 * portion of the code).
 *
 * Versions
 *
 * Version 1: Program Function added and tested through LEDs.
 * Version 2: User interface through LCD module
 * Version 3: Test function added and tested through LCD.
 * Version 4: Added Development and Instruction section.
 * Version 5: Added storage within EEPROM
 *
 */

//LCD Module Connections taken from example code Lcd.c (via MikroElectronica)
sbit LCD_RS at LATB4_bit;
sbit LCD_EN at LATB5_bit;
sbit LCD_D4 at LATB0_bit;
sbit LCD_D5 at LATB1_bit;
sbit LCD_D6 at LATB2_bit;
sbit LCD_D7 at LATB3_bit;

sbit LCD_RS_Direction at TRISB4_bit;
sbit LCD_EN_Direction at TRISB5_bit;
sbit LCD_D4_Direction at TRISB0_bit;
sbit LCD_D5_Direction at TRISB1_bit;
sbit LCD_D6_Direction at TRISB2_bit;
sbit LCD_D7_Direction at TRISB3_bit;

//Declarations
char original[4]= "   ";  //user input pin
char guess[4]= "   ";     //user input for guessing
char digits[4] = "   ";   // number to be displayed onto the LCD Module (4x20)
int i =0;                 //incrementer
int numentered = 0;       //determine if number has already been entered to eliminate repetition of numbers
char str[4];              //string version of value in EEPROM

//Function definitions
void program();      //choose the input
void test();         //guess the input
void develop();      //shows version number and developer
void instruction();
void main() {
     ANSELB = 0x00;            //PORTB has all digital bits
     ANSELC = 0x00;            //PORTC has all digital bits
     ANSELD = 0x00;            //PORTD has all digital bits
     TRISB = 0x00;            // PORTB is output only for the LCD
     TRISC = 0xFF;            //PORTC is input only
     TRISD = 0xFF;            //PORTD is input only
     PORTB = 0x00;
     PORTD = 0x00;
     PORTC = 0x00;
     Lcd_Init();              //initialize and clear LCD
     Lcd_Cmd(_LCD_CLEAR);
     Lcd_Cmd(_LCD_CURSOR_OFF);
     
     ByteToStr(EEPROM_READ(0x00), str); //covert(0x00) to a string
     if(str[0] == '2' & str[1] == '5' & str[2] == '5') //compare (0x00) to 255
     {
              EEPROM_WRITE(0x00, 0x00);         //set (0x00) to 0x00 to symbolize that this is not the first bootup
              EEPROM_WRITE(0x01, 0x00);         //set initial code to 0123
              EEPROM_WRITE(0x02, 0x01);
              EEPROM_WRITE(0x03, 0x02);
              EEPROM_WRITE(0x04, 0x03);
     }
     Lcd_Out(1,1,str);
     BYTETOSTR(EEPROM_READ(0x01), str);
     Ltrim(str);
     Lcd_Out(1,1,str);
     original[0] = str[0];                    //take (0x01) and place it in original
     BYTETOSTR(EEPROM_READ(0x02), str);
     Ltrim(str);
     Lcd_Out(1,1,str);
     original[1] = str[0];                    //take (0x02) and place it in original
     BYTETOSTR(EEPROM_READ(0x03), str);
     Ltrim(str);
     Lcd_Out(1,1,str);
     original[2] = str[0];                //take (0x03) and place it in original
     BYTETOSTR(EEPROM_READ(0x04), str);
     Ltrim(str);
     Lcd_Out(1,1,str);
     original[3] = str[0];               //take (0x04) and place it in original
     Lcd_Cmd(_LCD_CLEAR);

     while(1)
     {
              Lcd_Out(1,1, "   Welcome to the ");
              Lcd_Out(2,3,"Pin Code Checker");
              PORTD = 0x00;
              PORTC = 0x00;
              while(1)
              {
                    if(PORTD.B7)
                          develop();
                    if(PORTD.B6)
                          instruction();
                    for(i = 0; i < 4; i++)
                    {
                          guess[i] = '\0';              //remove all characters from guess[] and digits[]
                          digits[i] = '\0';
                    }
                    if(PORTD.B3)                        //button to program a pin
                    {
                         for(i = 0; i < 4; i++)
                         {
                              original[i] = '\0';        //Clear original[]
                         }
                         Lcd_Cmd(_LCD_CLEAR);
                         Lcd_Out(1,4, "Enter your pin");
                         for(i = 0; i < 3; i ++)
                         {
                               Lcd_Cmd(_LCD_SHIFT_RIGHT);  //shift displayed text 3 places to the right
                               Delay_ms(167);
                         }
                         for(i = 0; i < 6; i++)
                         {
                               Lcd_Cmd(_LCD_SHIFT_LEFT);   //shift displayed text 6 places to the left
                               Delay_ms(166);
                         }
                         for(i = 0; i < 3; i ++)
                         {
                               Lcd_Cmd(_LCD_SHIFT_RIGHT);  //shift displayed text 3 places to the right
                               Delay_ms(167);
                         }
                         i =0;
                         program();
                         numentered = 1;
                         for(i =0; i < 4; i++)
                         {
                               digits[i] = '\0';        //reinitialize digits[]
                         }
                         Lcd_Cmd(_LCD_CLEAR);
                         break;
                    }
                    else if(PORTD.B2)                  //button to test a pin
                    {
                         Lcd_Cmd(_LCD_CLEAR);
                         break;
                    }
              }
              i=0;
              test();
              Lcd_Cmd(_LCD_CLEAR);
              Lcd_Out(1,3, "Pin is correct!");
              for(i = 0; i < 3; i ++)
              {
                         Lcd_Cmd(_LCD_SHIFT_RIGHT);  //shift displayed text 3 places to the right
                         Delay_ms(166);
              }
              for(i = 0; i < 5; i++)
              {
                         Lcd_Cmd(_LCD_SHIFT_LEFT);   //shift displayed text 5 places to the left
                         Delay_ms(167);
              }
              for(i = 0; i < 3; i ++)
              {
                         Lcd_Cmd(_LCD_SHIFT_RIGHT);  //shift displayed text 3 places to the right
                         Delay_ms(167);
              }
              Delay_ms(1000);
              Lcd_Cmd(_LCD_CLEAR);
     }
}
/*
*
*  Program()
*
*/
void program()
{
     do
     {
           if(!PORTC & !PORTD.B0 & !PORTD.B1) //only allow input when no other buttons are pressed
                    numentered = 0;
           if(numentered == 0){              //if statement to determine what the pin input is
                 if(PORTC.B0)
                 {
                      original[i] = '0';
                      numentered = 1;
                      digits[i] = '*';
                      i++;
                 }
                 else if(PORTC.B1)
                 {
                      original[i] = '1';
                      numentered = 1;
                      digits[i] = '*';
                      i++;
                 }
                 else if(PORTC.B2)
                 {
                      original[i] = '2';
                      numentered = 1;
                      digits[i] = '*';
                      i++;
                 }
                 else if(PORTC.B3)
                 {
                      original[i] = '3';
                      numentered = 1;
                      digits[i] = '*';
                      i++;
                 }
                 else if(PORTC.B4)
                 {
                      original[i] = '4';
                      numentered = 1;
                      digits[i] = '*';
                      i++;
                 }
                 else if(PORTC.B5)
                 {
                      original[i] = '5';
                      numentered = 1;
                      digits[i] = '*';
                      i++;
                 }                    //
                 else if(PORTC.B6)
                 {
                      original[i] = '6';
                      numentered = 1;
                      digits[i] = '*';
                      i++;
                 }
                 else if(PORTC.B7)
                 {
                      original[i] = '7';
                      numentered = 1;
                      digits[i] = '*';
                      i++;
                 }
                 else if(PORTD.B0)
                 {
                      original[i] = '8';
                      numentered = 1;
                      digits[i] = '*';
                      i++;
                 }
                 else if(PORTD.B1)
                 {
                      original[i] = '9';
                      numentered = 1;
                      digits[i] = '*';
                      i++;
                 }
                 else;
                 Lcd_Out(2, 9, digits);   //output stars according to how many inputs there have been.
           }
           else;
     } while(i<4);
     Lcd_Cmd(_LCD_CLEAR);
     Lcd_Out(1,4, "Enter your pin");
     Lcd_Out(2,9, "****");
     EEPROM_WRITE(0x01, original[0]-48u);         //Subtract 48 to bring the ascii value to whatever the digit is (ie. 57 is the ascii value for 9
     EEPROM_WRITE(0x02, original[1]-48u);         //57-48 = 9. Store 9 into the EEPROM to be read at the start of the program.
     EEPROM_WRITE(0x03, original[2]-48u);
     EEPROM_WRITE(0x04, original[3]-48u);
     Delay_ms(500);
     return;
}
/*
*
*  test()
*
*/
void test()                                            //similar to program() with some additions
{
     while (1)
     {
          Lcd_Cmd(_LCD_CLEAR);
          Lcd_Out(1,4, "Guess the Pin!");
          i = 0;
          do
          {
                  if(!PORTC & !PORTD.B0 & !PORTD.B1)
                           numentered = 0;
                  if(numentered == 0){
                           if(PORTC.B0)
                           {
                                  guess[i] = '0';
                                  numentered = 1;
                                  digits[i] = '0';
                                  i++;
                           }
                           else if(PORTC.B1)
                           {
                                  guess[i] = '1';
                                  numentered = 1;
                                  digits[i] = '1';
                                  i++;
                           }
                           else if(PORTC.B2)
                           {
                                  guess[i] = '2';
                                  numentered = 1;
                                  digits[i] = '2';
                                  i++;
                           }
                           else if(PORTC.B3)
                           {
                                  guess[i] = '3';
                                  numentered = 1;
                                  digits[i] = '3';
                                  i++;
                           }
                           else if(PORTC.B4)
                           {
                                  guess[i] = '4';
                                  numentered = 1;
                                  digits[i] = '4';
                                  i++;
                           }
                           else if(PORTC.B5)
                           {
                                  guess[i] = '5';
                                  numentered = 1;
                                  digits[i] = '5';
                                  i++;
                           }
                           else if(PORTC.B6)
                           {
                                  guess[i] = '6';
                                  numentered = 1;
                                  digits[i] = '6';
                                  i++;
                      }
                           else if(PORTC.B7)
                           {
                                  guess[i] = '7';
                                  numentered = 1;
                                  digits[i] = '7';
                                  i++;
                           }
                           else if(PORTD.B0)
                           {
                                  guess[i] = '8';
                                  numentered = 1;
                                  digits[i] = '8';
                                  i++;
                           }
                           else if(PORTD.B1)
                           {
                                  guess[i] = '9';
                                  numentered = 1;
                                  digits[i] = '9';
                                  i++;
                          }
                          else;
                          Lcd_Out(2, 9, digits);
                      }
                  else;
          } while(i<4);
         if(original[0] == guess[0] & original[1] == guess[1] & original[2] == guess[2] & original[3] == guess[3]) // test equality
         {
                  break; //break if equal
         }
         else               //reset all pertinent variables and restart test()
         {
             Lcd_Cmd(_LCD_CLEAR);
             Lcd_Out(1,4,"Incorrect Pin!");
             Delay_ms(1000);
             PORTD = 0x00;
             PORTC = 0x00;
             for(i = 0; i < 4; i++)
             {
                   guess[i] = '\0';
                   digits[i] = '\0';
             }
         }
     }
     return;
}
/*
*
*  develop()
*
*/
void develop()
{
     Lcd_Cmd(_LCD_CLEAR);
     Lcd_Out(1, 3, "4 Digit Pin Lock");
     Lcd_Out(2, 2, "4th Marking Period");
     Lcd_Out(3, 4, "Ravi Sinha 2014");
     Lcd_Out(4,6, "Version 5.9");
     Delay_ms(2500);
     Lcd_Cmd(_LCD_CLEAR);
     Lcd_Out(1,4, "Welcome to the ");
     Lcd_Out(2,3,"Pin Code Checker");
     return;
}
/*
*
*  instruction()
*
*/
void instruction()
{
     Lcd_Cmd(_LCD_CLEAR);
     Lcd_Out(1, 1, "RC0 -> RC7 = 0 -> 7");
     Lcd_Out(2, 1, "RD0 -> RD1 = 8 -> 9");
     Lcd_Out(3, 1, "RD2 = Guess the pin");
     Lcd_Out(4,1, "RD3 = Create the pin");
     Delay_ms(2500);
     Lcd_Cmd(_LCD_CLEAR);
     Lcd_Out(1,4, "Welcome to the ");
     Lcd_Out(2,3,"Pin Code Checker");
     return;
}
