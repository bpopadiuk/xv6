#define NPROC        64  // maximum number of processes
#define KSTACKSIZE 4096  // size of per-process kernel stack
#define NCPU          8  // maximum number of CPUs
#define NOFILE       16  // open files per process
#define NFILE       100  // open files per system
#define NINODE       50  // maximum number of active i-nodes
#define NDEV         10  // maximum major device number
#define ROOTDEV       1  // device number of file system root disk
#define MAXARG       32  // max exec arguments
#define MAXOPBLOCKS  10  // max # of blocks any FS op writes
#define LOGSIZE      (MAXOPBLOCKS*3)  // max data blocks in on-disk log
#define NBUF         (MAXOPBLOCKS*3)  // size of disk block cache
// #define FSSIZE       1000  // size of file system in blocks
#define FSSIZE       2000  // size of file system in blocks  // CS333 requires a larger FS.

// UID_DEFAULT and GID_DEFAULT are used for both the first process and files 
// created by mkfs when the file system is built
#ifdef CS333_P2
#define UID_DEFAULT  0
#define GID_DEFAULT  0
#endif

// MODE_DEFAULT is used for files created by mkfs when file
// system is built
#ifdef CS333_P5
#define MODE_DEFAULT 0755
#endif

#ifdef CS333_P3P4
#define MAXPRIO 6
#define TICKS_TO_PROMOTE 1500
#define BUDGET 60
#endif
