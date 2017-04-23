import random as rand

i = 0
j = 0
k = 0

while i < 50:
	a = rand.randint(0,50)
	b = rand.randint(0,50)

	if b > a:
		print "%d,%d" % (a,b)
		i+=1
		
print "#######"

while j < 50:
	a = rand.randint(0,50)
	b = rand.randint(0,50)

	if b < a:
		print "%d,%d" % (a,b)
		j+=1
print "#######"

while k < 50:
	a = rand.randint(0,50)
	b = rand.randint(0,50)

	print "%d,%d" % (a,b)

	k+=1
