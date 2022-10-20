CC = g++
CPPFLAGS = -g -std=c++20 -Wall -Wextra -I.

OBJECTS := $(patsubst %.cpp,%.o,$(wildcard *.cpp))

kappa.c : $(OBJECTS)
	$(CC) $(CFLAGS) -o kappa.c $(OBJECTS)

.PHONY : clean
clean :
	rm kappa.c $(OBJECTS)
