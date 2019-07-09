# Assignment 2

Questions

1. What are 2 things that you learned from this assignment?

I learned how to manage processes in a polling model as well as how message passing works.

2. What are 2 mistakes that you made in this assignment, and how did you discover and fix these mistakes?

I made mistakes trying to awaken a parent processes from a child process. I fixed it by making it a global variable in my .h that was volatile because I could never get the proper parent pid to pass to a child. I also had issues getting message passing to work and it was because i wasn't calling the ring[process_index] to get the actual pid.

3. If you were restarting this assignment, what would you change about how you went about completing this assignment?

I would try to implement semaphores since martin talked about it a lot in lecture.
