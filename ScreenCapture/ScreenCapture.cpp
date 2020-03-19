#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/ioctl.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <unistd.h>

#include "fb.h"
#include <gflags/gflags.h>

#define FB_PATH					"/dev/fb0"

int fd_fb = -1;
struct fb_var_screeninfo screeninfo;
unsigned int *fb_buffer = NULL;
unsigned int *raw_data_buffer = NULL;

#pragma pack(push, 1)

using namespace std;

typedef struct{
    unsigned short type;        //default 0x4D42 'BM'
    unsigned int total_size;    //file total size
    unsigned short reserved1;   //unused default 0
    unsigned short reserved2;   //unused default 0
    unsigned int offset;        //raw pic data offset
} bmpheader; 

typedef struct{
    unsigned info_size;         //bmp info size 
    int width;                  //pic width pexel
    int height;                 //pic height pexel
    unsigned short planes;      //default 1
    unsigned short bits;        //bits per pels, 16 , 24 ,32
    unsigned int compression;   //
    unsigned int size_image;
    int xpelspermeter;
    int ypelspermeter;
    unsigned int clrused;
    unsigned int clr_important;
} bmpinfo;

#pragma pack(pop)
int BGRA2ARGB(unsigned char *BGRA)
{
	unsigned char data;
	
	data = BGRA[0];
	BGRA[0] = BGRA[3];
	BGRA[3] = data;
	
	data = BGRA[1];
	BGRA[1] = BGRA[2];
	BGRA[2] = data;
	
	return 0;
}

long RGB32ToBmp(const char* const file, const int width, const int height)
{
    FILE *fp;
    bmpheader h = {0};
    bmpinfo info = {0};
    int i;
    
    if (NULL == (fp = (fopen(file, "wb"))))
    {
        printf("failed when open bmp file\n");
        return -1;
    }
    
    h.type = 0x4D42;
    h.total_size = 4*width*height + 54; 
    h.offset = 54;    
    fwrite(&h, sizeof h, 1, fp);
    
    info.info_size = 40;
    info.width = width;
    info.height = -height;
    info.planes = 1;
    info.bits = 32;
    fwrite(&info, sizeof info, 1, fp);
    
	/*for (i = 0; i < width*height; i++)
	{
		BGRA2ARGB((unsigned char *)(raw_data_buffer + i));		
	}*/
	
	fwrite(raw_data_buffer, sizeof(unsigned int), width*height, fp);
    
    fflush(fp);
    fsync(fileno(fp));
    fclose(fp);
    return 0;
}

int dumpBGRA(const char* const file, unsigned int *buffer, int size){
	int fd_data = open(file, O_RDWR | O_CREAT);
    if (fd_data < 0) {
		printf("create data file fail.\n");
		return -1;
	}	

	write(fd_data, buffer, size);
	close(fd_data);
	
	return size;
}

string genRandomString(){
    int t = time(NULL);
    
    return std::to_string(t);
}

DEFINE_string(dst, "xxxx.bmp", "dst bmp file");
int main(int argc, char *argv[])
{
	int ret = 0;
    int screensize = 0;
    
    gflags::ParseCommandLineFlags(&argc, &argv, true);

    if (FLAGS_dst == "xxxx.bmp"){
        FLAGS_dst = genRandomString() + ".bmp";
    }

    fd_fb = open(FB_PATH, O_RDWR);
    if (fd_fb < 0) {
		printf("open frame buffer fail.\n");
		return -1;
	}	

	/* Retrieve fixed informations like video ram size */
	if (ioctl(fd_fb, FBIOGET_VSCREENINFO, &screeninfo) < 0) {
		printf("get screen info fail.\n");
		ret = -1;
		goto end;
	}

	screensize = screeninfo.xres * screeninfo.yres * screeninfo.bits_per_pixel / 8;
	fb_buffer = (unsigned int *)mmap(0, screensize, PROT_READ | PROT_WRITE, MAP_SHARED, fd_fb, 0);	
	
	raw_data_buffer = (unsigned int *)malloc(screensize);
	
	memcpy(raw_data_buffer, fb_buffer, screensize);
	
	RGB32ToBmp(FLAGS_dst.c_str(), (int)screeninfo.xres, (int)screeninfo.yres);
	
	munmap(fb_buffer, screensize);

end:
	close(fd_fb);

	return ret;
}
