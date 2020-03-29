CC = g++
CPPFLAGS = -g -Wall -I.

OBJECTS := $(patsubst %.cpp,%.o,$(wildcard *.cpp))

vec_ref : $(OBJECTS)
	$(CC) $(CFLAGS) -o vec_ref $(OBJECTS)

.PHONY : clean
clean :
	rm vec_ref $(OBJECTS)
