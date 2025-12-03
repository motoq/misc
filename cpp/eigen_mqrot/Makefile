CC = g++
#CPPFLAGS = -I/usr/local/include/eigen3
CPPFLAGS = -g -std=c++20 -Wall -Wextra -I$(EIG_INC)
#CPPFLAGS = -g -Wall -Wextra -Wno-deprecated-copy -I$(EIG_INC)
#LFLAGS = -l$$MY_LIB -lm

OBJECTS := $(patsubst %.cpp,%.o,$(wildcard *.cpp))

eigen_mqrot : $(OBJECTS)
	$(CC) $(CPPFLAGS) -o eigen_mqrot $(OBJECTS)

#$(CC) $(CFLAGS) -o eigen_mqrot $(OBJECTS)  $LFLAGS

.PHONY : clean
clean :
	rm eigen_mqrot $(OBJECTS)
