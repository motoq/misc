CC = g++
CPPFLAGS = -g -Wall -I$$SOFA_INC
#CPPFLAGS = -g -std=c++11 -Wall -I$$SOFA_INC
LFLAGS = -L$$SOFA_LIB -lsofa_c

OBJECTS := $(patsubst %.cpp,%.o,$(wildcard *.cpp))

cognition : $(OBJECTS)
	$(CC) $(CFLAGS) -o cognition $(OBJECTS) $(LFLAGS)

.PHONY : clean
clean :
	rm cognition $(OBJECTS)
