#include<stdio.h>
#include<tchar.h>
#include<iostream>
#include<windows.h>
#include<tlhelp32.h>
using namespace std;

//����������Ȩ�ޡ���>��ȡĿ����̵�PID����>���Ҫע����̵ľ������>��Զ�̽����п��ٳ�һ���ڴ桪��>��������������dll������д����һ�����ٳ����ڴ��С���>�ڱ�ע������д������̼߳��ظ�dll����>ж��ע���dll
//typedef unsigned long       DWORD;
//typedef __nullterminated CONST CHAR *LPCSTR, *PCSTR;
//typedef void *HANDLE;
DWORD getProcessHandle(LPCTSTR lpProcessName)//���ݽ��������ҽ���PID
{
	DWORD dwRet = 0;
	HANDLE hSnapShot = CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);/*CreateToolhelp32Snapshot����Ϊָ���Ľ��̡�
																	   ����ʹ�õĶ�[HEAP]��ģ��[MODULE]��
						   									   �߳�[THREAD]������һ������[snapshot]��*/
	if (hSnapShot == INVALID_HANDLE_VALUE)
	{
		//�����Ч
		printf("\n���PID=%s�Ľ��̿���ʧ��%d", lpProcessName, GetLastError());
		return dwRet;
	}

	//����ץȡ�ɹ�  
	PROCESSENTRY32 pe32;//����������ڶ���
	pe32.dwSize = sizeof(PROCESSENTRY32);//��������ڴ�С
	Process32First(hSnapShot, &pe32);//���������б�
	do
	{
		if (!lstrcmp(pe32.szExeFile, lpProcessName))
		{
			dwRet = pe32.th32ProcessID;
			break;
		}
	} while (Process32Next(hSnapShot, &pe32));
	CloseHandle(hSnapShot);
	return dwRet;

}


void EnableDebugPriv()
{
	HANDLE hToken;          // ���̷������Ƶľ��  
	LUID luid;              // ���ڴ洢����Ȩ��Ӧ�ľ�local unique identifier  
	TOKEN_PRIVILEGES tkp;   // Ҫ���õ�Ȩ��  
	//��ý��̷������Ƶľ������һ������Ҫ�޸ķ���Ȩ�޵Ľ��̾�����ڶ�������ָ��Ҫ���еĲ�������
	//��TOKEN_ADJUST_PRIVILEGES���޸����Ƶķ���Ȩ�ޣ�TOKEN_QUERY����ѯ���ƣ��������������Ƿ��صķ�������ָ��
	OpenProcessToken(GetCurrentProcess(), TOKEN_ADJUST_PRIVILEGES | TOKEN_QUERY, &hToken);
	// ��ȡ��������  
	LookupPrivilegeValue(NULL, SE_DEBUG_NAME, &luid);   // ��õ���Ȩ��luid  
	tkp.PrivilegeCount = 1; // ���õ���Ȩ  
	tkp.Privileges[0].Luid = luid;
	tkp.Privileges[0].Attributes = SE_PRIVILEGE_ENABLED;
	AdjustTokenPrivileges(hToken, FALSE, &tkp, sizeof tkp, NULL, NULL); // ʹ����ӵ�е���Ȩ  
	CloseHandle(hToken);
}

int main()
{
	EnableDebugPriv();//Ȩ������
	DWORD dwpid = getProcessHandle("cmd.exe");
	LPCSTR lpDllName = "D:\\fakedll.dll";

	//���Ҫע����̵ľ������ò��������ڴ�ռ��Ȩ�ޣ���ȡд�����ڴ�ռ��Ȩ��
	HANDLE hProcess = OpenProcess(PROCESS_VM_OPERATION | PROCESS_VM_WRITE, FALSE, dwpid);

	if (hProcess == NULL)
	{
		printf("\n��ȡ���̾������%d", GetLastError());
		return -1;
	}
	
	DWORD dwSize = strlen(lpDllName) + 1;
	LPVOID lpRemoteBuf = VirtualAllocEx(hProcess, NULL, dwSize, MEM_COMMIT, PAGE_READWRITE);//��Զ�̿ռ�����ַ

	DWORD dwHasWrite = 0;
	if (WriteProcessMemory(hProcess, lpRemoteBuf, lpDllName, dwSize,(SIZE_T*)&dwHasWrite))//д���ڴ溯��ִ�гɹ����ط���
	{
		if (dwHasWrite != dwSize)
		{
			//д���ڴ治�������ͷ��ڴ�
			VirtualFreeEx(hProcess, lpRemoteBuf, dwSize, MEM_COMMIT);
			CloseHandle(hProcess);
			return -1;
		}
	}
	else
	{
		printf("\nд��Զ�̽����ڴ�ռ����%d", GetLastError());
		CloseHandle(hProcess);
		return -1;
	}
	//д��ɹ�
	DWORD dwNewThreadId;
	LPVOID lpLoadDll = LoadLibraryA;//ʹ��LoadLibrary���������ض�̬���ӿ�
	//��LoadLibraryA��Ϊ�̺߳���,����ΪDll���������߳�
	HANDLE hNewRemoteThread = CreateRemoteThread(hProcess, NULL, 0, (LPTHREAD_START_ROUTINE)lpLoadDll, lpRemoteBuf, 0, &dwNewThreadId);
	//HANDLE hNewRemoteThread=
	if (hNewRemoteThread == NULL)
	{
		printf("\n����Զ���߳�ʧ��%d", GetLastError());
		CloseHandle(hProcess);
		return -1;
	}
	//�ȴ�����������
	WaitForSingleObject(hNewRemoteThread, INFINITE);

	CloseHandle(hNewRemoteThread);


	//׼��ж��֮ǰע���Dll 
	DWORD dwHandle, dwID;
	LPVOID pFunc = GetModuleHandleA;//�����Զ���߳��б�ע���Dll�ľ�� 
	HANDLE hThread = CreateRemoteThread(hProcess, NULL, 0, (LPTHREAD_START_ROUTINE)pFunc, lpRemoteBuf, 0, &dwID);
	WaitForSingleObject(hThread, INFINITE);
	GetExitCodeThread(hThread, &dwHandle);//�̵߳Ľ����뼴ΪDllģ����ľ�� 
	CloseHandle(hThread);
	pFunc = FreeLibrary;
	hThread = CreateRemoteThread(hThread, NULL, 0, (LPTHREAD_START_ROUTINE)pFunc, (LPVOID)dwHandle, 0, &dwID); //��FreeLibraryAע�뵽Զ���߳���ȥж��Dll 
	WaitForSingleObject(hThread, INFINITE);
	CloseHandle(hThread);
	CloseHandle(hProcess);

	system("pause");
	return 0;
}