# Meteor Rain

This project aims to exercise the fundamentals of the Computer Architecture area, namely programming in assembly language, peripherals and intermediaries. The objective of this project was to create a simulation game involving a rover defending Planet X, which must obtain energy from good meteors and destroy bad meteors, which are nothing more than robotic ships sent to invade the planet. The interface consists of a screen, a keyboard for controlling the game and a set of displays to show the rover's energy.

## Game Details

- The rover is at the bottom of the screen (surface of the planet) and can only move (by keys) left and right;
- Meteors coming from very far away appear from the top of the screen, so when they first appear they are just a gray pixel. These meteors descend vertically and increase in size as they approach the rover. In their second size (2 x 2 pixels) they are still distant and are gray and indistinct, but from then on they change shape and color depending on whether they are good meteors (green) or bad meteors (enemy ships, red);
- The objective of the rover is to destroy enemy ships (by firing a missile), to defend the planet, and to obtain energy from good meteors (allowing them to collide with you);
- The collision of a missile with a meteor (good or enemy ship) results in its destruction and that of the meteor, with an explosion effect. Please note that the missile has a limited range (it cannot reach distant meteors);
- Undestroyed enemy ships and unused good meteors are lost at the bottom of the screen. Whenever an enemy ship is destroyed, a good meteor collides with the rover or any of them are lost at the bottom, a new one is born on top, with type (good meteor or enemy ship) chosen pseudo-randomly (25% good meteor, 75% enemy ship);
- The rover has an initial energy (100%). This energy is used up over time, just because the rover is running. Firing a missile uses additional energy. However, colliding with a good meteor and destroying an enemy ship increases this energy;
- The game ends if an enemy ship collides with the rover or if the energy reaches zero. The objective of the game is to hold the rover for as long as possible, obtaining energy from good meteors and destroyed ships and avoiding colliding with an enemy ship;
- The player must have the ability to pause the game, restart after a pause, end the game at any time and start a new game after the previous one has ended.

---

### Commands

The game is controlled by the user using keys on a keyboard (actuated by mouse click), just like the one in the following figure:

![Screenshot_2](https://github.com/TiDeane/Meteor-Rain/assets/120483063/f793be80-473d-45a5-9dba-037c677ae903)
 
The assignment of keys to commands is as follows:
- Keys 0 and 2: move the rover left and right, respectively. Can be held for continuous movement;
- Key 1: fire the missile;
- C key: start the game (restarts the rover’s energy to 100%);
- D key: suspend/continue the game;
- E key: end the game (keeps the rover's final energy visible).

_Note: we were unable to implement the functionality of continuing the game after suspending it, or starting a new game after the previous one ends, before the deadline. Suspending it in the start screen also freezes the program._

---

### Timers

The evolution of the game requires 3 different timers:
- Movement of meteors (period of 400 milliseconds);
- Missile movement (period of 200 millisecond);
- Periodic decrease in rover energy (period of 3000 milliseconds, or 3 seconds).

The indicated periods, which mark the rhythm at which each of the events occur, are generated by 3 real-time clocks, which generate a one-bit signal that periodically varies between 0 and 1, with a given period. Without the real time marked by these clocks, the game would evolve much more quickly and in an uncontrollable way, depending only on the processing speed of the computer running the simulator.

---

### Processes

The following processes are used to support the game's diverse, apparently simultaneous, actions:
- Keyboard (scanning and reading the keys);
- Rover (to control movement);
- Missile (to control the firing and evolution of the missile in space and range);
- Meteor (to control the actions and evolution of each of the meteors, including checking for collision with the missile or rover as well as interacting with the rover's energy);
- Display (to control the display).

## Running Instructions

To run the program, simply run the simulator, drag the circuit `projeto60.cir` into it, click on the _simulation_ tab on the top left corner and then click on _start_ inside the PEPE-16 window.
