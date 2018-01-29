/*
1������Windows �ṩ��API�����ļ��Ĵ������򿪡�����д�Լ�ɾ���Ȳ�����
2�������ļ�ӳ��ʵ������ͨ�ţ����ƿ���̨����ʵ����������̨����ͬ����ʾ¼�����Ϣ����
*/
//�ŵ㣺���ش������һ��ר�ŵĴ����ļ�
//��������ָ���������ļ���Ϊ�����ڴ�
#include<stdio.h>
#include<iostream>
#include<string>
#include<Windows.h>
#include <conio.h>  
#include <tchar.h>  
#define BUF_SIZE 256
using namespace std;


LPCWSTR fname = L"TEXT.txt";
void file_operate()
{
	
	//setlocale(LC_ALL, "chs");
	BOOL ret;
	LPCWSTR filePath = fname;//�������ļ���
	DWORD dwDesiredAccess = GENERIC_READ | GENERIC_WRITE;//�Ը��ļ��ķ���ģʽ����д��
	DWORD dwShareMode = FILE_SHARE_READ;//����ģʽ��������
	LPSECURITY_ATTRIBUTES lpSecurityAttributes = NULL;
	DWORD dwCreationDisposition = OPEN_ALWAYS;//���ļ��������򴴽���
	DWORD dwFlagsAndAttributes = FILE_ATTRIBUTE_NORMAL; //�ļ����ԣ�Ĭ�����ԣ�
	HANDLE hTemplateFile = NULL;//��չ����

	//�ļ������ʹ�
	HANDLE handle = CreateFileW(filePath, dwDesiredAccess, dwShareMode, lpSecurityAttributes, dwCreationDisposition, dwFlagsAndAttributes, hTemplateFile);
	if (handle == NULL) 
	{
		cout << "CreateFile fail " << GetLastError() << endl;
	}
	else 
	{
		DWORD len;
		TCHAR *writeBuf = L"Hello World!";
		TCHAR readBuf[1024];
		/*
		ASCII:����ǰ׺�����д��unicode�ַ����������������룩
		Unicode:0xFEFF
		UTF8:0xEFBBBF
		*/
		WORD prefix = 0xFEFF;

		/*
		BOOL WriteFile(
		HANDLE  hFile,//�ļ����
		LPCVOID lpBuffer,//���ݻ�����ָ��
		DWORD   nNumberOfBytesToWrite,//��Ҫд���ֽ���
		LPDWORD lpNumberOfBytesWritten,//���ڱ���ʵ��д���ֽ����Ĵ洢�����ָ��
		LPOVERLAPPED lpOverlapped//OVERLAPPED�ṹ��ָ��
		);
		return ʧ�ܷ���0,�ɹ����ط�0
		*/
	
		//�ļ�д��
		ret = WriteFile(handle, writeBuf, lstrlen(writeBuf) * sizeof(TCHAR), &len, NULL);
		if (ret == 0) 
		{
			printf("WriteFile buf fail(%ld)\n", GetLastError());
		}

		/*
		һ���ļ������õ�ǰ�Ķ�ȡλ��
		DWORD SetFilePointer(
		HANDLE hFile,               // �ļ����
		LONG lDistanceToMove,       // ƫ����(��λ)
		PLONG lpDistanceToMoveHigh, // ƫ����(��λ)
		DWORD dwMoveMethod          // ��׼λ��FILE_BEGIN:�ļ���ʼλ�� FILE_CURRENT:�ļ���ǰλ�� FILE_END:�ļ�����λ��
		);
		*/
		DWORD pos = SetFilePointer(handle, 0, 0, FILE_BEGIN);
		if (pos == HFILE_ERROR) 
		{
			printf("SetFilePointer fail(%ld)\n", GetLastError());
		}
		
		/*
		BOOL ReadFile(
		HANDLE  hFile,                  //�ļ��ľ��
		LPVOID  lpBuffer,               //���ڱ���������ݵ�һ��������
		DWORD   nNumberOfBytesToRead,   //Ҫ������ֽ���
		LPDWORD lpNumberOfBytesRead,    //ָ��ʵ�ʶ�ȡ�ֽ�����ָ��
		LPOVERLAPPED lpOverlapped       //���ļ���ʱָ����FILE_FLAG_OVERLAPPED����ô���룬�������������һ������Ľṹ���ýṹ������һ���첽��ȡ����������Ӧ�����������ΪNULL
		);
		*/
		//�ļ���ȡ
		ret = ReadFile(handle, readBuf, 1024, &len, NULL);
		if (ret == 0) 
		{
			printf("ReadFile fail(%ld)\n", GetLastError());
		}
		else 
		{
			
			readBuf[len / sizeof(TCHAR)] = L'\0';
			printf("��������Ϊ��%ld, ����Ϊ��%ls\n", len, readBuf);
		}

		CloseHandle(handle);
	}

	cout << "�Ƿ�ɾ���ļ���y or n����";
	char answer;
	cin >> answer;
	if (answer == 'y')
	{
		BOOL ret = DeleteFile(fname);
		if (ret == 0)
		{
			printf("DeleteFile fail(%d)\n", GetLastError());
		}
	}
}

TCHAR szName[] = TEXT("Operating System");


//�ļ�ӳ��ͨ��
void read()
{
	HANDLE hMapFile;
	LPCTSTR pBuf;
	TCHAR szName[] = TEXT("Operating System");
	//��һ�����е��ļ�ӳ�����
	hMapFile = OpenFileMapping(
		FILE_MAP_READ, //Ȩ��
		FALSE,//��������̳�
		szName);//Ҫ�򿪵��ļ�ӳ���ں˶�������֡���������ֶ�Ӧ���ļ�ӳ���ں˶����Ѿ����򿪣����� dwDesiredAccessָ���İ�ȫȨ�޲���ͻ�Ļ������Գɹ��򿪷���ֵ������ɹ����򷵻�һ���򿪵��ļ�ӳ������ʧ���򷵻�NULL�����Ե���GetLastError()��ȡ��ϸ�Ĵ�����Ϣ��

	if (hMapFile == NULL)
	{
		_tprintf(TEXT("Could not open file mapping object (%d).\n"), GetLastError());
	}

	//��һ���ļ�ӳ���ں˶���ӳ�䵽���ý��̵ĵ�ַ�ռ��У�������ӳ�䵽���̵�ַ�е���ʼַ
	pBuf = (LPTSTR)MapViewOfFile(hMapFile, FILE_MAP_READ, 0, 0, BUF_SIZE);
	if (pBuf == NULL)
	{
		_tprintf(TEXT("Could not map view of file (%d).\n"), GetLastError());
		CloseHandle(hMapFile);
	}

	wcout << pBuf << endl;
}
void file_image_communication()
{
	//INVALID_HANDLE_VALUE:����ϵͳ���Ǵ������ļ�ӳ����������洢�����Ǵ����ϵ��ļ�������ϣ��ϵͳ��ҳ�����ļ��е�������洢����
	HANDLE hFile = CreateFileW(TEXT("TEXT.txt"), GENERIC_READ | GENERIC_WRITE,
		0, NULL, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL);
	if (hFile == NULL)
	{
		printf("create file error!");
	}
	HANDLE hMapFile;
	LPCTSTR pBuf;

	//�����ļ�ӳ���ں˶���
	hMapFile = CreateFileMapping(hFile,//ָ���������д���ӳ���һ���ļ����
		NULL,
		PAGE_READWRITE,//ָ���������д���ӳ���һ���ļ����
		0,
		BUF_SIZE,
		szName);//ָ���ļ�ӳ���������֡������������ֵ�һ��ӳ�䣬��������flProtectȨ����ͼȥ����������ֵ������ɹ����򷵻�һ���ļ�ӳ���ں˶�������

	if (hMapFile == NULL)
	{
		_tprintf(TEXT("Could not create file mapping object (%d).\n"),GetLastError());
	}

	//��һ���ļ�ӳ���ں˶���ӳ�䵽���ý��̵ĵ�ַ�ռ��У�������ӳ�䵽���̵�ַ�е���ʼַ
	pBuf = (LPTSTR)MapViewOfFile(hMapFile,
		FILE_MAP_ALL_ACCESS,
		0,
		0,
		BUF_SIZE);

	if (pBuf == NULL)
	{
		_tprintf(TEXT("Could not map view of file (%d). \n"),GetLastError());
		CloseHandle(hMapFile);
	}
	//char temp[]="";
	//cin >> temp;
	TCHAR szMsg[]=TEXT("");
	for (int i = 0; i < 5; i++)
	{
		wcin >> szMsg;
		CopyMemory((void*)pBuf, szMsg, (_tcslen(szMsg) * sizeof(TCHAR)));//����Ϣ�����ļ�ӳ���ں˶���
	}
	read();
	_getch();
	//�ڵ�ǰӦ�ó�����ڴ��ַ�ռ�����һ���ļ�ӳ������ӳ�䡣
	UnmapViewOfFile(pBuf);//������Ҫ���ļ�������ӳ�䵽���̵ĵ�ַ�ռ�ʱ����Ҫ����UnmapViewOfFile���ͷ��ڴ�����
	CloseHandle(hMapFile);
}


int main()
{
	file_image_communication();
	system("pause");
	return 0;
}