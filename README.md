PinCodeProject
==============

Purpose:
  Much like on a phone, the user is allowed to create a pin code and be able to try and guess the pin code.
  This program allows for the microcontroller, Microchip's PIC18F45K22, to complete this very purpose through
  user inputs on the pins, either PORTC or PORTD of the microcontroller. In actual implementation, the MikroE's
  EasyPIC V7 Development board was used to simplify the hardware.

The EasyPIC V7 Development Board and MikroC overview:
  The EasyPIC V7 Development Board has many embedded hardware pieces allowing the user to easily transfer 
  data bytes between different electronic pieces including Liquid Crystal Displays, Graphical LCDs, and
  7 segment displays through the PIC microcontroller chosen to be used.
  
  MikroC is a C-like language that is meant for microcontroller based operations developed by
  MikroElectronica. It has many in built functions and examples of interfacing with some of the embedded
  hardware.

PIC18F45K22 overview:
  The PIC18F45K22 microcontroller is a digital and analog controller that is able to be used on the EasyPIC
  board chosen for implementation. Within it, the microcontroller has 5 ports (A,B,C,D, and E) along with
  TRIS registers (for determing input or outputs within the port), and a ANSEL registers (to determine if
  the port is Analog or Digital) for each port. In the implementation of this project, ports B,C, and D are 
  all digital ports where only ports C and D are inputs (for number input) and port B is the only output port
  (for interfacing the LCD module).
