# EvalBot-ESIEE
This project uses ARMv7 on Cortex-M3 processor of the [Stellaris LM3S9B92 EVALBOT](https://www.ti.com.cn/cn/lit/ug/spmu167/spmu167.pdf)
## Demo Videos



https://user-images.githubusercontent.com/70033490/198839580-2088f7d3-182c-4a9b-bd13-4e33d3cb3dd5.mp4



https://user-images.githubusercontent.com/70033490/198839608-03786e71-c32b-42da-ab91-25e70026f52e.mp4


## Report translated to english
There is Scratch for educational purposes to introduce algorithms to children. <br> 
Typical problems made with Scratch consist in implementing an algorithm with basic commands such as going straight, turning right, turning left, among others, 
which allow after a succession of iterations to go from a [point A to a point B](https://blockly.games/maze?lang=en&level=2&skin=0). <br><br>
The goal of this project is to simulate this with the EVALBOT by passing it a set of instructions through switches and bumpers that the EVALBOT then executes, 
when it is launched; thus, in the prelearning phase of programming, this is a concrete tool. <br>
To do this, an abstraction has been set up concerning the manipulation of the motors: there are four main commands; move_forward, move_backward, turn_right, turn_left.
These commands correspond successively to pressing switch1, switch2, bumper1, bumper2. 
Once the user has finished his sequence of instructions, pressing both switches at the same time launches the execution. <br>
<br>
Access to the instructions can be done because these have been stored in the memory in the following way: 
An array of predefined maximum size, each of its elements has the size of 8 bits. Forward is 1, backward is 3, rotate right is 2, rotate left is 4. 
It is true that better memory management requires to use only two bits (00, 01,10,11) to store these commands.
A single reading of a byte thus gives four commands, and using register R5 (number of commands entered) it is possible to parse the byte by applying a 
logical OR with 11, 1100, 110000, 11000000; however since there are no memory concerns we kept it simple here, and each byte only stores a single command.
This choice is not only undertaken for absence of a memory problem but also so that the code can support as much as possible future changes and additions: 
let's say that we now want to add four new commands, move forward diagonally right and diagonally left, either forwards or backwards; this would make a total 
of 8 commands, so stored in three bits with the method mentioned above, this complicates our task because 8 is not a multiple of 3; to solve this we can either  choose to combine the result of two readings of two successive bytes, or leave two empty bits. In conclusion, using 8 bits for a commande is much more versatile 
as an architecture. <br><br>
This is not the only point that demonstrates that the project has been structured in such a way that it supports future additions. 
Another point is the fact of turning on the motors at the start of each command and turning them off at the end of the command; 
this could be seen as a waste of energy since we currently only need to switch the motors on at the start of the program and switch them off at the end of the 
program. 
However, for potential changes, the commands must be the most independent of each other, hence the purpose of turning it on and off for each command currently present.
The project code has been separated into several files. The entry point is in main.s, it is also supposed to contain only the logic of the program, namely the acquisition and the execution. 
It's not supposed to contain anything "low level" (configuring the GPIOs) at all. So there must be external subroutines doing this work; 
the files cofig_ext.s, cong.s are responsible for motors configuration, and sw_bmp responsible for bumpers and switches configuration. 
A time.s file will contain all waiting subroutines.
