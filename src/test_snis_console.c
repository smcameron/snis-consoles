#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>

#define A2 0
#define A3 1

#define INPUT 0
#define OUTPUT 1
#define HIGH 1
#define LOW 0

int analog_values[] = {
	0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31,
};


int emu_mux_select_pin[] = { 4, 5, 6, 7, };
int emu_mux_select = 0;
int emu_mux_input[] = { A2, A3 };

/* Shift register control pins */
static const int emu_sr_data = 8;
static const int emu_sr_clock = 9;
static const int emu_sr_latch = 10;
static int sr_data_value = 0;
static int sr_clock_value = 0;
static int sr_latch_value = 0;
uint16_t shift_register = 0;
uint16_t shift_register_output = 0;

typedef void (*intfunc)(int x);
typedef int (*intvoidfunc)(void);

static int analogRead(int pin)
{
	printf("Analog read %d\n", pin);

	if (pin == emu_mux_input[0]) {
		printf("Reading mux input 0, emu_mux_select = %d, returning %d\n",
				emu_mux_select, analog_values[emu_mux_select]);
		return analog_values[emu_mux_select];
	} else if (pin == emu_mux_input[1]) {
		printf("Reading mux input 1, emu_mux_select = %d, returning %d\n",
				emu_mux_select, analog_values[emu_mux_select + 16]);
		return analog_values[emu_mux_select + 16];
	}  
	return 0;
}

static void digitalWrite(int pin, int value)
{
	int i;

	printf("digital write pin/value: %d/%d\n", pin, value);

	for (i = 0; i < 4; i++) {
		if (pin == emu_mux_select_pin[i]) {
			emu_mux_select = ((emu_mux_select & ~(0x01 << i)) | (value << i));
			return;
		}
	}

	if (pin == emu_sr_data) {
		sr_data_value = value & 0x01;
	} else if (pin == emu_sr_clock) {
		if (value == HIGH && sr_clock_value == LOW) {
			shift_register = (shift_register << 1) & 0xfffe;
			shift_register |= (sr_data_value & 0x01);
		}
		sr_clock_value = value;
	} else if (pin == emu_sr_latch) {
		if (value == HIGH && sr_latch_value == LOW) {
			shift_register_output = shift_register;
			printf("Latched shift register value: %04x\n", shift_register_output);
		}
		sr_latch_value = value;
	}
}

static void Serial_Begin(int x)
{
	printf("Serial.Begin(%d);\n", x);
}

static void Serial_printint(int x)
{
	printf("%d", x);
}

static void Serial_printintln(int x)
{
	printf("%d\n", x);
}

static void Serial_printchar(int x)
{
	printf("%c", x);
}

static int Serial_read(void)
{
	static int p = 0;
	const char *led_data = "LBEEF";
	int x;

	x = led_data[p];
	p = (p + 1) % 5;
	return x;
}

static int Serial_available(void)
{
	return 1;
}

static void pinMode(int a, int b)
{
	return;
}

struct serial {
	intfunc begin;
	intfunc printint;
	intfunc printintln;
	intfunc printchar;
	intvoidfunc read;
	intvoidfunc available;
} Serial = {
	Serial_Begin,
	Serial_printint,
	Serial_printintln,
	Serial_printchar,
	Serial_read,
	Serial_available,
};

#define TEST_SNIS_CONSOLE

#include "snis_console.c/snis_console.c.ino"

int main(int argc, char *argv[])
{
	printf("Test code for snis_console...\n");
	setup();
	do {
		loop();
	} while (1);
}
