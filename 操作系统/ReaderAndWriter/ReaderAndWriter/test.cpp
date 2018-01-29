#include "stdafx.h"
#include "windows.h"
#include <conio.h>
#include <stdlib.h>
#include <fstream>
#include <io.h>
#include <string.h>
#include <stdio.h>
#include<iostream>

#define INTE_PER_SEC    100 
#define MAX_THREAD_NUM  64
#define MAX_FILE_NUM    10
#define READER 'R'
#define WRITER 'W'
#define SEM_MAX_FULL 64

using namespace std;

struct ThreadInfo//�߳���Ϣ
{
	int    serial;//�̱߳��
	char   entity;//�߳�����
	double delay;//�߳�ת��ʱ��
	double persist;//�߳�ִ��ʱ��
};

int  buff_num;
CRITICAL_SECTION mutex; //�������ٽ���
HANDLE W_mutex;//��д���⣬дд���⡣
//CRITICAL_SECTION W_mutex;
int read_count=0;//���߸���


void  ReaderAndWriter(char *file);
void  Thread_Reader(void *p);
void  Thread_Writer(void *p);


int main(int argc, char* argv[])
{
	ReaderAndWriter("rw_data.txt");
	return 0;
}


void ReaderAndWriter(char *file)
{
	DWORD n_thread = 0;
	DWORD thread_ID;
	HANDLE		h_Thread[MAX_THREAD_NUM];
	ThreadInfo  thread_info[MAX_THREAD_NUM];

	//read_count = 0;

	ifstream inFile;
	inFile.open(file);
	puts("Read Data File \n");
	//inFile >> buff_num; //���ļ����ж������� д��buff_num�����̸�����
	while (inFile)
	{
		inFile >> thread_info[n_thread].serial;
		inFile >> thread_info[n_thread].entity;
		inFile >> thread_info[n_thread].delay;
		inFile >> thread_info[n_thread].persist;
		n_thread++;
		inFile.get();
	}


	for (int i = 0; i<(int)(n_thread)-1; i++)
	{
		if (thread_info[i].entity == READER)

			h_Thread[i] = CreateThread(NULL, 0, (LPTHREAD_START_ROUTINE)(Thread_Reader),
				&thread_info[i], 0, &thread_ID);   
		else
		{
			if (thread_info[i].entity == WRITER)

				h_Thread[i] = CreateThread(NULL, 0, (LPTHREAD_START_ROUTINE)(Thread_Writer),
					&thread_info[i], 0, &thread_ID);

			else
			{
				puts("Bad File\n");
				exit(0);
			}

		}
	}

	//printf("Buff  %d\n", buff_num);

	//��ʼ���ź������ٽ���
	InitializeCriticalSection(&mutex);
	//InitializeCriticalSection(&W_mutex);
	W_mutex = CreateSemaphore(NULL, 1, SEM_MAX_FULL, "W_mutex");


	WaitForMultipleObjects(n_thread, h_Thread, TRUE, -1);//�����߳���ֹ��������ִ��
	printf("Task is Finished!\n");
	_getch();
}



void  Thread_Reader(void *p)
{
	int	  m_serial;
	DWORD m_delay;
	DWORD m_persist;
	DWORD wait_for_mutex;

	//������
	m_serial = ((ThreadInfo*)(p))->serial;
	m_delay = (DWORD)(((ThreadInfo*)(p))->delay*INTE_PER_SEC);
	m_persist = (DWORD)(((ThreadInfo*)(p))->persist*INTE_PER_SEC);
	while (TRUE)
	{
		printf("R thread %d delay %d \n", m_serial, m_delay);
		Sleep(m_delay);
		printf("R thread %d send the R require\n", m_serial);

		EnterCriticalSection(&mutex);
		read_count++;
		if (read_count == 1)
		{
			WaitForSingleObject(W_mutex, INFINITE);//wait(W_mutex)�����޵ȴ�����ȡ�ź���
			//EnterCriticalSection(&W_mutex);
		}
		LeaveCriticalSection(&mutex);
	    //////////////���ļ�/////////////////////////////////////////
		printf("R thread %d Begin to Read\n", m_serial);
		printf("R thread %d persist %d \n", m_serial, m_persist);
		Sleep(m_persist);
		printf("R thread %d Finish Read.\n", m_serial);
		/////////////////////////////////////////////////////////////
		EnterCriticalSection(&mutex);
		read_count--;
		if (read_count == 0)
		{
			ReleaseSemaphore(W_mutex, 1, NULL);//signal(mutex),�ͷ��ź���
			//LeaveCriticalSection(&W_mutex);
		}
		LeaveCriticalSection(&mutex);
		
	}

}


void  Thread_Writer(void *p)
{

	DWORD	m_delay;
	DWORD	m_persist;
	int		m_serial;

	m_serial = ((ThreadInfo*)(p))->serial;
	m_delay = (DWORD)(((ThreadInfo*)(p))->delay*INTE_PER_SEC);
	m_persist = (DWORD)(((ThreadInfo*)(p))->persist*INTE_PER_SEC);

	while (TRUE)
	{
		printf("W thread %d delay %d \n", m_serial, m_delay);
		Sleep(m_delay);
		printf("W thread %d send the W require\n", m_serial);
		WaitForSingleObject(W_mutex, INFINITE);
		/////////////////////////д�ļ�//////////////////////////////////////////////////////////////
		printf("W thread %d Begin to Write\n", m_serial);
		printf("W thread %d persist %d \n", m_serial, m_persist);
		Sleep(m_persist);
		printf("W thread %d Finish W\n", m_serial);
		///////////////////////////////////////////////////////////////////////////////////////////////
		ReleaseSemaphore(W_mutex, 1, NULL);
		
	}
}