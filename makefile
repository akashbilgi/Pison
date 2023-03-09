DIR = bin
EXEC1 = $(DIR)/example1
EXEC2 = $(DIR)/example2
EXEC3 = $(DIR)/example3
EXEC4 = $(DIR)/example4
TARGET = $(EXEC1) ${EXEC2} ${EXEC3} ${EXEC4}

TEST1 = $(DIR)/test1
TESTTARGET = $(TEST1)
all: $(TARGET)
test: $(TESTTARGET)

CC = g++
CC_FLAGS = -O3 -std=c++11 -mavx -mavx2 -msse -msse2 -msse4 -msse4.2 -mpclmul
POST_FLAGS = -lpthread -mcmodel=medium -static-libstdc++

SOURCE1 = src/*.cpp example/example1.cpp
$(EXEC1): $(SOURCE1)
	mkdir -p $(DIR)
	$(CC) $(CC_FLAGS) -o $(EXEC1) $(SOURCE1) $(POST_FLAGS)

SOURCE2 = src/*.cpp example/example2.cpp
$(EXEC2): $(SOURCE2)
	mkdir -p $(DIR)
	$(CC) $(CC_FLAGS) -o $(EXEC2) $(SOURCE2) $(POST_FLAGS)

SOURCE3 = src/*.cpp example/example3.cpp
$(EXEC3): $(SOURCE3)
	mkdir -p $(DIR)
	$(CC) $(CC_FLAGS) -o $(EXEC3) $(SOURCE3) $(POST_FLAGS)

SOURCE4 = src/*.cpp example/example4.cpp
$(EXEC4): $(SOURCE4)
	mkdir -p $(DIR)
	$(CC) $(CC_FLAGS) -o $(EXEC4) $(SOURCE4) $(POST_FLAGS)

TESTSOURCE1 = src/*.cpp example/test1.cpp
$(TEST1): $(TESTSOURCE1)
	mkdir -p $(DIR)
	$(CC) $(CC_FLAGS) -o $(TEST1) $(TESTSOURCE1) $(POST_FLAGS)

clean:
	-$(RM) $(TARGET)
	-$(RM) $(TESTTARGET)