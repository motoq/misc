CC = g++
CPPFLAGS = -g -Wall -Wextra -I.

OBJECTS := $(patsubst %.cpp,%.o,$(wildcard *.cpp))

explicit : $(OBJECTS)
	$(CC) $(CFLAGS) -o explicit $(OBJECTS)

.PHONY : clean
clean :
	rm explicit $(OBJECTS)
