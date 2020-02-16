/*
	Copyright (C) 2020 Stephen M. Cameron
	Author: Stephen M. Cameron

	This file is part of Spacenerds In Space.

	Spacenerds in Space is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 2 of the License, or
	(at your option) any later version.

	Spacenerds in Space is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with Spacenerds in Space; if not, write to the Free Software
	Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
*/

/* Multiplexer selector pins */
static const int mux_select[4] = { 4, 5, 6, 7 };
static const int mux_input[2] = { A2, A3 };

/* Shift register control pins */
static const int sr_data = 8;
static const int sr_clock = 9;
static const int sr_latch = 10;

/* Changes below +/- 3 won't register... cuts down on spurious triggers
 * Might be able to tighten this up when no longer using the breadboard
 * when the real circuit is built. */
#define MUX_SIGNAL_THRESHOLD 3

static int current_input[32] = { 0 };
static int old_input[32] = { 0 };
static int indicator_led[16] = { 0 };



#define ENGINEERING 1

#ifdef ENGINEERING
#define CONSOLE_CHAR 'E'
#endif
#ifdef WEAPONS
#define CONSOLE_CHAR 'W'
#endif
#ifdef NAVIGATION
#define CONSOLE_CHAR 'N'
#endif
#ifdef COMMS
#define CONSOLE_CHAR 'C'
#endif
#ifdef SCIENCE
#define CONSOLE_CHAR 'S'
#endif
#ifdef DEMON
#define CONSOLE_CHAR 'D'
#endif

void setup()
{
	int i;

	Serial.begin(9600);

	/* Set up output pins for mux channel selection */
	for (i = 0; i < 4; i++)
		pinMode(mux_select[i], OUTPUT);
	pinMode(mux_input[0], INPUT);
	pinMode(mux_input[1], INPUT);
	pinMode(sr_data, OUTPUT);
	pinMode(sr_clock, OUTPUT);
	pinMode(sr_latch, OUTPUT);
	digitalWrite(sr_data, LOW);
	digitalWrite(sr_latch, LOW);
	digitalWrite(sr_clock, LOW);
}

void select_mux_channel(int channel)
{
	for (int i = 0; i < 4; i++)
		digitalWrite(mux_select[i], (channel >> i) & 0x01);
}

void read_mux_input(int current_input[])
{
	for (int i = 0; i < 16; i++) {
		select_mux_channel(i);
		current_input[i] = analogRead(mux_input[0]);
		current_input[i + 16] = analogRead(mux_input[1]);
	}
}

void transmit_input(int datum, int value)
{
	Serial.print(CONSOLE_CHAR);
	Serial.print(datum);
	Serial.print("=");
	Serial.println(value);
}

void transmit_changed_input(int current_input[], int old_input[])
{
	int i;

	for (i = 0; i < 32; i++) {
		if (abs(current_input[i] - old_input[i]) > MUX_SIGNAL_THRESHOLD) {
			transmit_input(i, current_input[i]);
			old_input[i] = current_input[i];
		}
	}
}

void read_indicator_data_from_snis_client(void)
{
	/* TODO: Read indicator data from snis_client, if any */
}

void update_indicator_leds(void)
{
	int i;

	for (i = 0; i < 16; i++) { /* Shift out 16 bits of LED indicator data to turn on/off 16 indicator LEDs */
		digitalWrite(sr_clock, LOW);
		digitalWrite(sr_data, indicator_led[i] ? HIGH : LOW);
		digitalWrite(sr_clock, HIGH);
	}
	digitalWrite(sr_latch, HIGH); /* Latch the data so it appears on the outputs of the shift registers */
	digitalWrite(sr_latch, LOW);
}

void loop() {

	read_mux_input(current_input);
	transmit_changed_input(current_input, old_input);
	read_indicator_data_from_snis_client();
	update_indicator_leds();
}
