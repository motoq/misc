CC = g++
CPPFLAGS = -g -Wall -Wextra -I.

OBJECTS := $(patsubst %.cpp,%.o,$(wildcard *.cpp))

cnst_sp : $(OBJECTS)
	$(CC) $(CFLAGS) -o cnst_sp $(OBJECTS)

.PHONY : clean
clean :
	rm cnst_sp $(OBJECTS)
