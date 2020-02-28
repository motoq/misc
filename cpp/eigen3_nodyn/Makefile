CC = g++
#CPPFLAGS = -I/usr/local/include/eigen3
CPPFLAGS = -g -Wall -Wextra -Wno-deprecated-copy -I$(EIG_INC)
#LFLAGS = -l$$MY_LIB -lm

OBJECTS := $(patsubst %.cpp,%.o,$(wildcard *.cpp))

eigen3_nodyn : $(OBJECTS)
	$(CC) $(CPPFLAGS) -o eigen3_nodyn $(OBJECTS)

#$(CC) $(CFLAGS) -o eigen3_nodyn $(OBJECTS)  $LFLAGS

.PHONY : clean
clean :
	rm eigen3_nodyn $(OBJECTS)
