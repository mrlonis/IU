/**
 * sys_info.c - sys_info
 *
 * Part of: Assignment 1
 *
 * Created By: Matthew Lonis
 * Created On: 15 January 2018
 * Last Modified By: Matthew Lonis
 * Last Modified On: 18 January 2018
 */

#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>

/*
 *------------------------------------------------------------------------
 * sys_info 
 * 
 * In this program, I create 2 processes using fork() system call.
 *
 * Each process should print it's process id and whether it is the
 * parent or child process.
 *
 * The program should take a path to another program as a command
 * line argument. Ex: /bin/date, /bin/uname, /bin/hostname, /bin/echo,
 * etc.
 *
 * The parent process will send the path to the child process by
 * using a pipe.
 *
 * The pipe is created with the pipe(int fd[2]) system call.
 *
 * The parent sends the first command line argument using the
 * write system call to write the string to the pipe's input
 * file descriptor.
 *
 * The child receives the first command line argument by
 * reading it using the read system call. Child process
 * should use execl() to run the program for the corresponding
 * argument sent by parent process.
 *------------------------------------------------------------------------
 */
int main(int nargs, char *args[]) {
    /* Check argument count for too many arguments */
    if (nargs > 2) {
        fprintf(stderr, "%s: too many arguments\n", args[0]);
        return 1;
    }
    
    /* Check argument count for too few arguments */
    if (nargs < 2) {
        fprintf(stderr, "%s: too few arguments\n", args[0]);
        return 1;
    }
    
    /* Execute Forks if arguments check out */
    if (nargs == 2) {
        printf("Parent PID : %d\n", getpid());

        int fd[2], status;
        pid_t childpid;
        char readbuffer[80];
        char *string = args[1];

        pipe(fd);
            
        if ((childpid = fork()) == -1) {
            perror("fork");
            exit(1);
        }

        if (childpid == 0) {
            /* Child process closes up output side of pipe */
            close(fd[1]);

            /* Read in a string from the pipe */
            read(fd[0], readbuffer, sizeof(readbuffer));
            printf("Child PID : %d\n", getpid());
            char * arguments = readbuffer;

            if (strcmp(arguments+5, "echo") == 0) {
                execl(readbuffer, arguments+5, "Hello World!", 0);
            } else {
                execl(readbuffer, arguments+5, 0, 0);
            }

            perror("execl() failure!\n");
            printf("This printf is after an execl() call and should not have been executed if execl() were successful!\n");

            exit(0);
        } else {
            /* Parent process closes up output side of pipe */
            close(fd[0]);

            /* Send "string" through the output side of pipe */
            write(fd[1], string, (strlen(string)+1));

            /* Wait for child to end */
            wait(&status);
        }
    }

    return 0;
}

/* end of file */
