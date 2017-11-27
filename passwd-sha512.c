#define _XOPEN_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

int main(int argc, char *argv[]) {
  if ( argc < 3 || (int) strlen(argv[2]) > 16 ) {
    printf("usage: %s password salt\n", argv[0]);
    printf("--salt must not larger than 16 characters\n");
    return;
  }

  char salt[21];
  sprintf(salt, "$6$%s$", argv[2]);

  printf("%s\n", crypt((char*) argv[1], (char*) salt));
  return;
}
