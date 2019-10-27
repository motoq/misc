CC = g++
#CPPFLAGS = -I/usr/local/include/eigen3
CPPFLAGS = -g -Wall -Wextra -I$(EIG_INC)
#LFLAGS = -l$$MY_LIB -lm

OBJECTS := $(patsubst %.cpp,%.o,$(wildcard *.cpp))

coriolis : $(OBJECTS)
	$(CC) $(CPPFLAGS) -o coriolis $(OBJECTS)

#$(CC) $(CFLAGS) -o coriolis $(OBJECTS)  $LFLAGS

.PHONY : clean
clean :
	rm coriolis $(OBJECTS)
