#include <stdio.h>
#include <conio.h>
#include <windows.h>
#include <conio.h>

#pragma comment(lib,"./../sendrecv.lib")

__declspec(dllimport) int __stdcall QuickSend(char* request, int reqLen, char* response_buffer, int response_buflen);
__declspec(dllimport) int __stdcall LastError(char* buffer, int buflen);
__declspec(dllimport) void __stdcall qsConfig(char* _server, int _port, int _timeout=12000, short partialRespOk = 1);
 
void main(void){

	char* http = "GET /tools.php HTTP/1.0\r\n" 
                "Host: sandsprite.com\r\n" 
                "User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:45.0)\r\n" 
                "Accept-Encoding: none\r\n" 
                "Connection: close\r\n" 
                "\r\n\r\n";

	int h, sz;
	char* server;
	char buf[100];

	memset(buf,0,sizeof(buf));

	h = (int)LoadLibrary("sendrecv.dll");
	if(h==0) h = (int)LoadLibrary("./../sendrecv.dll");
	if(h==0) h = (int)LoadLibrary("./../../sendrecv.dll");

	if(h==0){
		MessageBox(0,"Could not locate sendrecv.dll","",0);
		return;
	}

	server = "sandsprite.com";
	//char* server = "192.168.0.10";

	qsConfig(server,80);
	sz = QuickSend(http,strlen(http), buf, sizeof(buf));
	
	if(sz > 0){
		printf("%s",buf);
	}else{
		printf("Error:");
	}

	printf("\n\n");
	if( LastError(buf, sizeof(buf)) > 0) printf("%s\n",buf);
	printf("press any key to exit...\n");
	getch();

}