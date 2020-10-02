CC = g++
CPPFLAGS = -g -Wall -Wextra -I.

OBJECTS := $(patsubst %.cpp,%.o,$(wildcard *.cpp))

tmp_class : $(OBJECTS)
	$(CC) $(CFLAGS) -o tmp_class $(OBJECTS)

.PHONY : clean
clean :
	rm tmp_class $(OBJECTS)
