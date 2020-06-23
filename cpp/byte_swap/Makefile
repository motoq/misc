CC = g++
CPPFLAGS = -g -Wall -Wextra -I.

OBJECTS := $(patsubst %.cpp,%.o,$(wildcard *.cpp))

byte_swap : $(OBJECTS)
	$(CC) $(CFLAGS) -o byte_swap $(OBJECTS)

.PHONY : clean
clean :
	rm byte_swap $(OBJECTS)
