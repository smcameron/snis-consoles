
/*

             (x6, y6)
             *----------------------* (x5, y5)
             |__|                    .
             |
             |                         .
             |
             |                           .
             |
             |                             .
             |
             |                               .
             |                             a3
             |                          -------* (x4, y4)
             |                                         .
             |                                     a2          .
             |                                   ----------------------* (x3, y3)
             |
             |                                                        .
             |
             |__                                                     .
             |  |                                                        a1
             *------------------------------------------------------*-----
             (x1, y1)                                               (x2, y2)
             |<-------------------------- l0 ---------------------->|


	dist(x1, y1, x2, y2) == l0
	dist(x2,y2, x3, y3) == l5
        dist(x3, y3, x4, y4) == l1
        dist(x4, y4, x5, y5) == l2
        dist(x5, y5, x6, y6) == l3
	dist(x6, y6, x1, y1) == l4

	l1 = known
	l2 = known
	l3 = known
	l5 = known
	l0 = l5 * cos(a1) +
             l1 * cos(a2) +
             l2 * cos(a3) +
             l3
	l4 = y6 - y1;

        (x1, y1) = (0, 0)

        x2 == x1 + l0
	y2 == y1

	x3 = x2 + l5 * cos(a1)
	y3 = y2 + l5 * sin(a1)

	x4 = x3 - l1 * cos(a2)
	y4 = y3 + l1 * sin(a2)

	x5 = x4 - l2 * cos(a3)
	y5 = y4 + l2 * sin(a3)

	x6 = x1
	y6 = y5

*/

mm = 25.4; /* mm / inch */
pi = 3.1415927;

a1 = 75; /* degrees */
a2 = 15; /* degrees */
a3 = 70; /* degrees */

l1 = 200 + 10; /* mm */
l2 = 200 + 10; /* mm */
l3 = 200; /* mm */
l5 = 50; /* mm */
l0 = l5 * cos(a1) +
     l1 * cos(a2) +
     l2 * cos(a3) +
     l3;

x1 = 0;
y1 = 0;

x2 = x1 + l0;
y2 = y1;

x3 = x2 + l5 * cos(a1);
y3 = y2 + l5 * sin(a1);

x4 = x3 - l1 * cos(a2);
y4 = y3 + l1 * sin(a2);

x5 = x4 - l2 * cos(a3);
y5 = y4 + l2 * sin(a3);

x6 = x1;
y6 = y5;
l4 = y6 - y1;

echo("x1, y1 = ", x1, y1);
echo("x2, y2 = ", x2, y2);
echo("x3, y3 = ", x3, y3);
echo("x4, y4 = ", x4, y4);
echo("x5, y5 = ", x5, y5);
echo("x6, y6 = ", x6, y6);
echo("l0 = ", l0);
echo("l1 = ", l1);
echo("l2 = ", l2);
echo("l3 = ", l3);
echo("l4 = ", l4);
echo("l5 = ", l5);

polygon(points = [
		[x1, y1],
		[x2, y2],
		[x3, y3],
		[x4, y4],
		[x5, y5],
		[x6, y6]]);


