/*
i = 0
while i < 10:
	print(i)
	++i
while true:
	break 
j = 1
while j < 10:
	break 
k = 0
while k < 10:
	print(k)
	++k
l = 0
while l < 10:
	print(l)
	l += 5
m = 0
while m < 10:
	print(m)
	m = (((5 + j) + k) + m)
f = 0.0F
while f < 10.0F:
	print(f)
	f += 1.0F
*/
for (var i=0; i<10; ++i) {
	print(i);
}
for (;;) {
	break;
}
j = 1;
for (; j < 10;) {
	break;
}
for (k=0; k<10; ++k) {
	print(k);
}
for (l=0; l<10; l+=5) {
	print(l);
}
for (m=0; m<10; m=5+j+k+m) {
	print(m);
}
for (f=0.0; f<10.0; f+=1.0) {
	print(f);
}
