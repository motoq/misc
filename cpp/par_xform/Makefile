CC = g++
CPPFLAGS = -g -std=c++17 -Wall -Wextra -I.

OBJECTS := $(patsubst %.cpp,%.o,$(wildcard *.cpp))

xform : $(OBJECTS)
	$(CC) $(CFLAGS) -o xform $(OBJECTS)

.PHONY : clean
clean :
	rm xform $(OBJECTS)
