#ifdef CS333_P5
#include "types.h"
#include "user.h"
int
main(int argc, char *argv[])
{
    int i;
    int mode, error;
    char *path;
    

    if(argc != 3) {
        printf(1, "chmod failed -- wrong number of arguments\n");
        printf(1, "Usage: chmod MODE TARGET\n");
        exit();  
    }

    if(strlen(argv[1]) != 4) {
        printf(1, "chmod failed -- mode must be 4 digits");
        printf(1, "Usage: chmod MODE TARGET\n");
        exit();
    }

    if((argv[1][0] - 48) < 0 || (argv[1][0] - 48) > 1) {
        printf(1, "chmod failed -- setuid bit not 0 or 1: %d\n");
        printf(1, "Usage: chmod MODE TARGET\n");
        exit();
    }

    for(i = 1; i < 4; i++) {
        if((argv[1][i] - 48) < 0 || (argv[1][i] - 48) > 7) {
            printf(1, "chmod failed -- mode bit out of range\n");
            printf(1, "Usage: chmod MODE TARGET\n");
            exit();
        }
    }   

    mode = atoo(argv[1]);
    path = argv[2];
    error = chmod(path, mode);
    if(error != 0) {
        printf(1, "chmod failed -- invalid path\n");
        exit();
    }
     
    exit();
}

#endif
