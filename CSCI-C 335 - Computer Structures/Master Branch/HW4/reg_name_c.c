/**
 * reg_name_c.c
 *
 * Created By: Matthew Lonis
 * Created On: 11 November 2017
 * Last Modified By: Matthew Lonis
 * Last Modified On: 11 November 2017
 *
 * Part of: Homework 4
 */

char * names[16] = {"r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7", "r8", "r9", "r10", "r11", "r12", "r13", "r14", "r15"};

char * reg_name_c(unsigned int x) {
  return names[x];
}
