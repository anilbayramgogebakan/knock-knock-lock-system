[logo1]: https://github.com/anilbayramgogebakan/knock-knock-lock-system/blob/main/Figures/Figure_1.png
# Knock Knock Lock System
&nbsp;&nbsp;&nbsp;&nbsp; As a term project of Digital Electronics course, I designed a password system which we use almost everywhere in our lives. However, the unique part of my project is the way of taking inputs. The system takes its inputs as vibration through a vibration sensor which screwed on a piece of wood. My design consists of two parts. The first part is the vibration sensor and a piece of wood which sensor is screwed as I mentioned. The sensor gives “1” if it detects vibration. In the second part, BASYS takes inputs and processes that data. In this lock system, the user also might determine de password if the lock is “unlocked”.

[Youtube link of the project](https://youtu.be/MY8MbwSpRx4)

##  Project's design specification plan
&nbsp;&nbsp;&nbsp;&nbsp; After I decided on this project, I realize that taking as clean data as possible from the vibration sensor is one of the most important things in my design process. Because even if my codes work properly and well enough, bad inputs might cause problems in the last part of my process. In this case, I even wouldn’t understand where the problem is most probably. So I screwed the vibration sensor on a piece of wood to ensure the condition that I mentioned. Although it isn’t the most practical way of using a lock system, I decided that it will fulfill the requirements of my final project. In addition to that, I design the coding part to show both inputs and password through LEDs. It is also not practical for any lock system but I thought that it is the best way of showing my work.

## Project's design methodology
&nbsp;&nbsp;&nbsp;&nbsp;In my project, the most important part of this design is taking and processing proper inputs. I take inputs from the vibration sensor every 1ms. However, 1ms is a very short time-lapse compare to the time between every knock. So, I decided to check time intervals of every 256 ms, not 1 ms. To do that I create a very long vector which is “samples”. Although it can be applied with different values for different hardware equipment, I create this vector as 256*6 = 1536 bites to fit the restriction of BASYS (e.g number of LEDs, etc.). In this equation, 256 represents the time interval and 6 represents the number of LEDs which can be also called memory.

 _Sample length (1536) = bit length (256) * sequence length (6)_

&nbsp;&nbsp;&nbsp;&nbsp; My program checks the 256 digits of the sample vector. If there is at least one ‘1’, the corresponding digit of the sequence will be ‘1’.

&nbsp;&nbsp;&nbsp;&nbsp; In the memory part, I determine a push button to assign a password if the system is in “unlocked” condition. If the system is in unlock condition and the push button has been pressed, the sequence at that moment will be assigned a password. Also, I assigned another push button to make the system “locked” if the condition is “unlocked”


![Figure-1][logo1]

&nbsp;&nbsp;&nbsp;&nbsp;As can be observed in the figure, the first 6 LEDs from the right side show a sequence vector whose inputs have taken for 1536 ms. The next 6 LEDs show the password vector. The next LED shows the clock whose frequency is 256 ms and the next LED shows that whether the system is locked (0) or unlocked (1). 
