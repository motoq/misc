CC = g++
CPPFLAGS = -g -Wall -Wextra -I.

OBJECTS := $(patsubst %.cpp,%.o,$(wildcard *.cpp))

sp_const : $(OBJECTS)
	$(CC) $(CFLAGS) -o sp_const $(OBJECTS)

.PHONY : clean
clean :
	rm sp_const $(OBJECTS)
