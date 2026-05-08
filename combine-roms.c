#include <stdio.h>
#include <stdlib.h>

int main(int argc, char* argv[]) {

  unsigned long int i, bufsize;
  unsigned char *buf;

  FILE *fin1, *fin2, *fout;

    if (argc != 5) {
	  printf("syntax: combine-roms [swap] [input1] [input2] [output]\n");
	  return(1);
	}

	fin1 = fopen(argv[2], "rb");
	if (!fin1) {
  	  printf("[input1] missing!\n");
	  return(1);
	} else {
      // ok
	}

	fin2 = fopen(argv[3], "rb");
	if (!fin2) {
  	  printf("[input2] missing!\n");
	  return(1);
	} else {
      // ok
	}

	fout = fopen(argv[4], "wb");
	if (!fout) {
	  printf("[output] error.\n");
	  return(1);
	} else {
	  printf("creating [output] file.\n");
	}
	
  fseek(fin1, 0, SEEK_END);
  bufsize = ftell(fin1);
  fseek(fin1, 0, SEEK_SET);

  printf("combining %u x2 bytes.\n", bufsize);
  buf = (unsigned char *)malloc(bufsize * 2);

  for(i=0; i < (bufsize/2); i++) {
	switch (atoi(argv[1])) {
		case 0:
          fread(&buf[(i*4) + 0], 1, 1, fin1);
	      fread(&buf[(i*4) + 1], 1, 1, fin1);
          fread(&buf[(i*4) + 2], 1, 1, fin2);
	      fread(&buf[(i*4) + 3], 1, 1, fin2);		  
		case 1:
          fread(&buf[(i*4) + 1], 1, 1, fin1);
	      fread(&buf[(i*4) + 0], 1, 1, fin1);
          fread(&buf[(i*4) + 3], 1, 1, fin2);
	      fread(&buf[(i*4) + 2], 1, 1, fin2);		  
	}
  }
  fwrite(&buf[0], 1, bufsize * 2, fout);
  
  free(buf);
  fclose(fout);
  fclose(fin2);
  fclose(fin1);
  
}
