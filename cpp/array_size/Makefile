CC = g++
CPPFLAGS = -g -Wall -I.

OBJECTS := $(patsubst %.cpp,%.o,$(wildcard *.cpp))

array_size : $(OBJECTS)
	$(CC) $(CFLAGS) -o array_size $(OBJECTS)

.PHONY : clean
clean :
	rm array_size $(OBJECTS)
