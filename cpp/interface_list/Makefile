CC = g++
CPPFLAGS = -g -Wall -Wextra -I.

OBJECTS := $(patsubst %.cpp,%.o,$(wildcard *.cpp))

fire_em : $(OBJECTS)
	$(CC) $(CFLAGS) -o fire_em $(OBJECTS)

.PHONY : clean
clean :
	rm fire_em $(OBJECTS)
