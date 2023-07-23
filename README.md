# snis-consoles

This repository contains some code and OpenSCAD designs for physical
consoles for the game <a href="https://spacenerdsinspace.com">Space Nerds in Space</a>.

It is still very much a work in progress.

The basic idea is to run snis_client on a Raspberry Pi 4B for some stations
(Navigation, Engineering, Science, Comms) and build a custom console for each
of these stations with buttons, toggle switches, potentiometer, faders, gauges,
etc.  An arduino (or maybe a Raspberry Pi pico) will marshal all these inputs
and control LEDs and so on, and be connected via USB to the Raspberry Pi 4B
running snis_client.

There are OpenSCAD designs for some 3D printable large illuminated push buttons
built around inexpensive tactile switches, some 3d printable panels to hold these
buttons and allow mounting into a "dashboard", some 3d printable panels for mounting
potentiometers and faders which can then mounted in a dashboard.

Here are some notes on my progress so far:

* [Notes](https://spacenerdsinspace.com/snis-consoles/notes.html)

