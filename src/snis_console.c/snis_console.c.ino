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
static const int mux_data[2] = { A2, A3 };

static int current_data[32] = { 0 };
static int old_data[32] = { 0 };

void setup()
{
	int i;

	Serial.begin(9600);

	/* Set up output pins for mux channel selection */
	for (i = 0; i < 4; i++)
		pinMode(mux_select[i], OUTPUT);

}

void select_mux_channel(int channel)
{
	for (int i = 0; i < 4; i++)
		digitalWrite(mux_select[i], (channel >> i) & 0x01);
}

void read_mux_data(int current_data[])
{
	for (int i = 0; i < 16; i++) {
		select_mux_channel(i);
		current_data[i] = analogRead(mux_data[0]);
		current_data[i + 16] = analogRead(mux_data[1]);
	}
}

void transmit_data(int datum, int value)
{
	Serial.print("Value ");
	Serial.print(datum);
	Serial.print(" changed to ");
	Serial.println(value);
	delay(1000);
}

void transmit_changed_data(int current_data[], int old_data[])
{
	int i;

	for (i = 0; i < 32; i++) {
		if (current_data[i] != old_data[i])
			transmit_data(i, current_data[i]);
	}
}

void loop() {

	read_mux_data(current_data);
	transmit_changed_data(current_data, old_data);
	memcpy(old_data, current_data, sizeof(old_data));
}
