LIB_NAME = vcsFPService_preload
TARGET_LIB = $(LIB_NAME).so
SOURCE_FILES = preload.c
LIBS = -ldl

CFLAGS += -std=gnu99 -fPIC -Wall -Wextra
LDFLAGS += -shared

.PHONY: default
default: $(TARGET_LIB)

$(TARGET_LIB): $(SOURCE_FILES)
	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS)
