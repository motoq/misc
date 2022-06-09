CC = g++
CPPFLAGS = -g -Wall -Wextra -I.

OBJECTS := $(patsubst %.cpp,%.o,$(wildcard *.cpp))

perms : $(OBJECTS)
	$(CC) $(CFLAGS) -o perms $(OBJECTS)

.PHONY : clean
clean :
	rm perms $(OBJECTS)
