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

struct serial_input_data {
	int active_command;
#define NO_COMMAND 0;
#define LED_STATUS_COMMAND 'L';
	int index;
	int value_count;
	uint8_t led_values[2];
	uint8_t *value_ptr;
} sid = { 0 };

void read_indicator_data_from_snis_client(void)
{
	/* Sat Feb 22 15:15:14 EST 2020 -- this function is completely untested. */

	int i, inchar, value;
	uint16_t v;

	if (Serial.available() <= 0)
		return;

	/* Read a character... */
	inchar = Serial.read();
	if (inchar == -1) /* no data */
		return;

	switch (inchar) {
	/* LED status values, expect 2 more bytes to indicate status of 16 LEDs */
	case 'L':
		sid.value_ptr = &sid.led_values[0];
		sid.value_count = 2;
		sid.active_command = LED_STATUS_COMMAND;
		return;
	default:
		/* If no active command, or we already have the data for the active command
		 * ignore this character and continue.
		 */
		if (sid.active_command == 0 || sid.value_count <= 0)
			return;

		/* Convert value to integer */
		if (inchar >= '0' && inchar <= '9')
			value = inchar - '0';
		else if (inchar >= 'A' && inchar <= 'F')
			value = inchar - 'A' + 10;
		else
			value = -1;

		/* If we did not get a good value, ignore it. */
		if (value < 0)
			return;
		/* We got a good value, store it */
		*sid.value_ptr = (uint8_t) value;
		sid.value_ptr++;
		sid.value_count--;
		break;
	}

	/* If we have still more data to read continue reading more.  */
	if (sid.value_count != 0)
		return;

	/* We have all the data for the active command, so process it. */
	switch (sid.active_command) {
	case 'L': /* Update the indicator LED status values with the data */
		sid.active_command = NO_COMMAND;
		memcpy(&v, sid.led_values, sizeof(v));
		for (i = 0; i < 16; i++)
			indicator_led[i] = v & (0x1 << i);
		return;
	default:
		/* Unknown command... */
		return;
	}
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
