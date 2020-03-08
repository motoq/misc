CC = g++
CPPFLAGS = -g -Wall -Wextra -I.

OBJECTS := $(patsubst %.cpp,%.o,$(wildcard *.cpp))

range_for : $(OBJECTS)
	$(CC) $(CFLAGS) -o range_for $(OBJECTS)

.PHONY : clean
clean :
	rm range_for $(OBJECTS)
