CC = g++
CPPFLAGS = -g -Wall -Wextra -I.

OBJECTS := $(patsubst %.cpp,%.o,$(wildcard *.cpp))

cnst_itr : $(OBJECTS)
	$(CC) $(CFLAGS) -o cnst_itr $(OBJECTS)

.PHONY : clean
clean :
	rm cnst_itr $(OBJECTS)
