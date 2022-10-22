CC = g++
CPPFLAGS = -g -std=c++20 -Wall -Wextra -I.

OBJECTS := $(patsubst %.cpp,%.o,$(wildcard *.cpp))

chi2 : $(OBJECTS)
	$(CC) $(CFLAGS) -o chi2 $(OBJECTS)

.PHONY : clean
clean :
	rm chi2 $(OBJECTS)
