CC = g++
CPPFLAGS = -g -Wall -Wextra -I.

OBJECTS := $(patsubst %.cpp,%.o,$(wildcard *.cpp))

sp_factory : $(OBJECTS)
	$(CC) $(CFLAGS) -o sp_factory $(OBJECTS)

.PHONY : clean
clean :
	rm sp_factory $(OBJECTS)
