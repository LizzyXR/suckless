#ifndef CONFIG_H
#define CONFIG_H

// OLD BLOCKS
/*
X("", "aurora", 1800, 7)     \
X("", "musicplaying", 0, 11) \
*/


// String used to delimit block outputs in the status.
#define DELIMITER " | "

// Maximum number of Unicode characters that a block can output.
#define MAX_BLOCK_OUTPUT_LENGTH 45

// Control whether blocks are clickable.
#define CLICKABLE_BLOCKS 1

// Control whether a leading delimiter should be prepended to the status.
#define LEADING_DELIMITER 0

// Control whether a trailing delimiter should be appended to the status.
#define TRAILING_DELIMITER 0

// Define blocks for the status feed as X(icon, cmd, interval, signal).
#define BLOCKS(X)             \
	X("", "cat /tmp/recordingicon 2>/dev/null", 0, 3)   \
    X("", "cat /tmp/timericon 2>/dev/null", 0, 6)  \
    X("", "systemstats", 3, 4) \
    X("", "disks", 3600, 5) \
	X("", "weather", 1800, 1)	\
	X("", "flag", 0, 10) \
    X("", "timedate", 60, 2)  \

#endif  // CONFIG_H
