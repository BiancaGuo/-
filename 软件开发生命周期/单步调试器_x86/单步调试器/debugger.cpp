#include <windows.h>
#include <windows.h>
#include <stdio.h>
#include <tchar.h>
#include<iostream>
#include<sstream>
#include<iomanip>
#include<string>
#include <DbgHelp.h>
#pragma comment(lib,"dbghelp.lib")  
#include"debugger.h"
using namespace std;
void EnterDebugLoop(const LPDEBUG_EVENT);
DWORD OnCreateThreadDebugEvent(const LPDEBUG_EVENT) { printf("OnCreateThreadDebugEvent\n"); return 0; };
DWORD OnCreateProcessDebugEvent(const LPDEBUG_EVENT) { printf("OnCreateProcessDebugEvent\n"); return 0; };
DWORD OnExitThreadDebugEvent(const LPDEBUG_EVENT) { printf("OnExitThreadDebugEvent\n"); return 0; };
DWORD OnExitProcessDebugEvent(const LPDEBUG_EVENT) { printf("OnExitProcessDebugEvent\n"); return 0; };
DWORD OnLoadDllDebugEvent(const LPDEBUG_EVENT dv)
{
	printf("OnLoadDllDebugEvent %x\n", dv->u.LoadDll.hFile);
	return 0;
}
DWORD OnUnloadDllDebugEvent(const LPDEBUG_EVENT) { printf("OnUnloadDllDebugEvent\n"); return 0; };
DWORD OnOutputDebugStringEvent(const LPDEBUG_EVENT) { printf("OnOutputDebugStringEvent\n"); return 0; };
DWORD OnRipEvent(const LPDEBUG_EVENT) { printf("OnRipEvent\n"); return 0; };

STARTUPINFO si;          //ָ���½��̵����������Ե�һ���ṹ
PROCESS_INFORMATION pi;  //�ýṹ�����й��½��̼������̵߳���Ϣ
DEBUG_EVENT DebugEv;     //�ṹ�巵�ؽ��̵ĵ�����Ϣ



//��ȡ�����Խ��̵����̵߳������Ļ�����
void GetDebuggeeContext(CONTEXT* pContext) {

	pContext->ContextFlags = CONTEXT_FULL;

	if (GetThreadContext(pi.hThread, pContext) == FALSE) {//��ȡ�Ĵ�����ֵ

		std::wcout << TEXT("GetThreadContext failed: ") << GetLastError() << std::endl;
		exit(-1);
	}

}

//���ñ����Խ��̵����̵߳������Ļ���
void SetDebuggeeContext(CONTEXT* pContext) {

	if (SetThreadContext(pi.hThread, pContext) == FALSE) {

		std::wcout << TEXT("SetThreadContext failed: ") << GetLastError() << std::endl;
		exit(-1);
	}

}
char ByteToChar(BYTE byte) {

	if (byte >= 0x00 && byte <= 0x1F) {
		return '.';
	}


	if (byte >= 0x81 && byte <= 0xFF) {
		return '?';
	}

	return (char)byte;
}
void DumpHex(unsigned int address, unsigned int length) {
	//�洢ÿһ���ֽڶ�Ӧ��ASCII�ַ���
	char content[17] = { 0 };

	//����ʼ����ĵ�ַ���뵽16�ı�����
	unsigned int blankLen = address % 16;
	unsigned int startAddress = address - blankLen;

	unsigned int lineLen = 0;
	unsigned int contentLen = 0;

	//���������һ�еĿհס�
	if (blankLen != 0) {

		cout<< hex<< uppercase << setfill('0') << setw(8) << startAddress << TEXT("  ");
		startAddress += 16;
		for (unsigned int len = 0; len < blankLen; ++len) {

			cout << hex << uppercase << TEXT("   ");
			content[contentLen] = TEXT(' ');
			++contentLen;
			++lineLen;
		}
	}

	//����ֽڶ�ȡ�����Խ��̵��ڴ棬�������
	BYTE byte;

	for (unsigned int memLen = 0; memLen < length; ++memLen) {
		unsigned int curAddress = address + memLen;
		//�����ÿ�еĵ�һ���ֽڣ�����������ַ��
		if (lineLen % 16 == 0) {
			cout << hex << uppercase <<  setfill('0') << setw(8) << startAddress << TEXT("  ");
			startAddress += 16;
			lineLen = 0;
		}

		//��ȡ�ڴ棬����ɹ��Ļ�����ԭ�����������ȡ���Ӧ��ASCII�ַ���
		if (ReadProcessMemory(pi.hProcess, (LPCVOID)curAddress, &byte, 1, NULL) == TRUE) {
			cout << hex << uppercase << setfill('0') << setw(2) << byte << TEXT(' ');
			content[contentLen] = ByteToChar(byte);
		}
		//�����ȡʧ�ܣ����� ?? ���档
		else {
			cout << hex << uppercase << TEXT("?? ");
			content[contentLen] = TEXT('.');
		}

		//���һ������16���ֽڣ���������з������ڴ�0��ʼ����������������15�Ƚϡ�
		if (contentLen == 15) {
			cout << hex << uppercase << TEXT(' ') << content << std::endl;
		}

		++contentLen;
		contentLen %= 16;

		++lineLen;
	}

	//������һ�еĿհף�Ϊ��ʹ���һ�е�ASCII�ַ�������һ�С�
	for (unsigned int len = 0; len < 16 - lineLen; ++len) {

		cout << hex << uppercase << TEXT("   ");
	}

	//������һ�е�ASCII�ַ���
	cout << hex << uppercase << TEXT(' ');
	content[contentLen] = 0;
	cout << hex << uppercase << content;
	//cout << dumpStr.str() << endl;
}

/**
//��ʾ�ֲ���������Ĵ�������
//�����ʽΪ lv [expression]
//����expression��ʾ����ʾ����ָ��ͨ������ʽ�ı��������ʡ������ʾȫ��������

//��������һЩ������Ϣ�Ľṹ��
struct VARIABLE_INFO {
	DWORD address;
	DWORD modBase;
	DWORD size;
	DWORD typeID;
	string name;
};

//��ȡ���ŵ������ַ
//���������һ���ֲ��������߲�����
//pSymbol->Address�������EBP��ƫ�ƣ�
//��������Ӿ��Ƿ��ŵ������ַ
DWORD GetSymbolAddress(PSYMBOL_INFO pSymbolInfo) {

	if ((pSymbolInfo->Flags & SYMFLAG_REGREL) == 0) {
		return DWORD(pSymbolInfo->Address);
	}

	//�����ǰEIPָ�����ĵ�һ��ָ���EBP��ֵ��Ȼ������
	//��һ�������ģ����Դ�ʱ����ʹ��EBP����Ӧ��ʹ��ESP-4��
	//Ϊ���ŵĻ���ַ��

	CONTEXT context;
	GetDebuggeeContext(&context);

	//��ȡ��ǰ�����Ŀ�ʼ��ַ
	DWORD64 displacement;
	SYMBOL_INFO symbolInfo = { 0 };
	symbolInfo.SizeOfStruct = sizeof(SYMBOL_INFO);

	SymFromAddr(pi.hProcess,context.Eip,&displacement,&symbolInfo);

	//����Ǻ����ĵ�һ��ָ�����ʹ��EBP
	if (displacement == 0) {
		return DWORD(context.Esp - 4 + pSymbolInfo->Address);
	}

	return DWORD(context.Ebp + pSymbolInfo->Address);
}

BOOL CALLBACK EnumVariablesCallBack(PSYMBOL_INFO pSymInfo, ULONG SymbolSize, PVOID UserContext) {

	list<VARIABLE_INFO>* pVarInfoList = (list<VARIABLE_INFO>*)UserContext;

	VARIABLE_INFO varInfo;

	if (pSymInfo->Tag == SymTagData) {

		varInfo.address = GetSymbolAddress(pSymInfo);
		varInfo.modBase = (DWORD)pSymInfo->ModBase;
		varInfo.size = SymbolSize;
		varInfo.typeID = pSymInfo->TypeIndex;
		varInfo.name = pSymInfo->Name;

		pVarInfoList->push_back(varInfo);
	}

	return TRUE;
}

void OnShowLocalVariables() {

	//��ȡ��ǰ�����Ŀ�ʼ��ַ
	CONTEXT context;
	GetDebuggeeContext(&context);

	//����ջ֡
	IMAGEHLP_STACK_FRAME stackFrame = { 0 };
	stackFrame.InstructionOffset = context.Eip;

	if (SymSetContext(pi.hProcess, &stackFrame, NULL) == FALSE) {

		if (GetLastError() != ERROR_SUCCESS) {
			cout << "No debug info in current address." << endl;
			return;
		}
	}

	LPCWSTR expression = NULL;

	//ö�ٷ���
	list<VARIABLE_INFO> varInfoList;

	if (SymEnumSymbols(
		pi.hProcess,
		0,
		(PCSTR)expression,
		EnumVariablesCallBack,
		&varInfoList) == FALSE) {
		cout << "SymEnumSymbols failed: " << GetLastError() << endl;
	}
	
	for (list<VARIABLE_INFO>::iterator it = varInfoList.begin(); it != varInfoList.end(); ++it)
	{
		cout << it->address << " ";
		cout << it->modBase << " ";
		cout << it->size << " ";
		cout << it->typeID << " ";
		cout << it->name << " ";
	}
	cout << endl;
}

*/
//context.esp���Ǻ����ķ��ص�ַ��context.esp+4λ�õ�ֵ���Ǻ����ĵ�һ��������context.esp+8���ǵڶ����������������ƿ��Եõ�����Ҫ���κβ�������Ҫע�������Ϊ�������ڱ����Խ����е����ݣ����������ͨ��ReadProcessMemory�������ܵõ��� 

LONG GetEntryPointAddress() {

	HANDLE hProcess = GetCurrentProcess();
	SymInitialize(hProcess, NULL, TRUE);
	SymSetOptions(SYMOPT_EXACT_SYMBOLS);
	SetLastError(0);
	SYMBOL_INFO symbol = { 0 };
	symbol.SizeOfStruct = sizeof(symbol);
	BOOL result = SymFromName(hProcess, "main", &symbol);
	if (result == TRUE) 
	{
		printf("symbol : 0x%I64X\n", symbol.Address);
		printf("error : %u, result : %u\n", GetLastError(), result);
	}
	return 0;
}

void step_through(CONTEXT context)
{


	cout << "EIP :"<< uppercase << hex << context.Eip << endl;
	cout << endl;
	cout << "�Ĵ���ֵ :" << endl;
	cout << "eax��" << uppercase << hex << context.Eax << endl;
	cout << "ebx��" << uppercase << hex << context.Ebx << endl;
	cout << "ecx��" << uppercase << hex << context.Ecx << endl;
	cout << "edx��" << uppercase << hex << context.Edx << endl;
	cout << "esi��" << uppercase << hex << context.Esi << endl;
	cout << "edi��" << uppercase << hex << context.Edi << endl;
	cout << "esp��" << uppercase << hex << context.Esp << endl;
	cout << "ebp��" << uppercase << hex << context.Ebp << endl;
	
	//DWORD buf[4]; // ȡ4������
	//ReadProcessMemory(pi.hProcess, (void*)(context.Esp + 4), &buf, sizeof(buf),NULL);
	cout << endl;
	cout << "��ʾ�ڴ����ݣ�"<<endl;
	unsigned int address = 0;
	unsigned int length = 128;
	address = context.Eip;
	DumpHex(address, length);
	
	cout << endl << endl;
	/*
	cout << "��ʾ�ֲ�������" << endl;
	OnShowLocalVariables();
	cout << endl << endl;
	*/
}
HANDLE hProcess;

void main()
{

	ZeroMemory(&si, sizeof(si));
	//��С
	si.cb = sizeof(si);////����STARTUPINFO�ṹ�е��ֽ���
	ZeroMemory(&pi, sizeof(pi));


	// Start the child process. 
	
	if (CreateProcess(
		TEXT("fussing ����.exe"),
		//argv[1],
		NULL, // �������ַ��� 
		NULL,   //  ָ��һ��NULL��β�ġ�����ָ����ִ��ģ��Ŀ��ֽ��ַ���  
		NULL, //    ָ��һ��SECURITY_ATTRIBUTES�ṹ�壬����ṹ������Ƿ񷵻صľ�����Ա��ӽ��̼̳С�  
			  //NULL, //    ���lpProcessAttributes����Ϊ�գ�NULL������ô������ܱ��̳С�<ͬ��>  
		false,//    ָʾ�½����Ƿ�ӵ��ý��̴��̳��˾����   
			  //DEBUG_ONLY_THIS_PROCESS | CREATE_NEW_CONSOLE,  //  ָ�����ӵġ���������������ͽ��̵Ĵ����ı�  
			  //  CREATE_NEW_CONSOLE  �¿���̨���ӽ���  
			  //  CREATE_SUSPENDED    �ӽ��̴��������ֱ������ResumeThread����  
		DEBUG_PROCESS,
		NULL, //    ָ��һ���½��̵Ļ����顣����˲���Ϊ�գ��½���ʹ�õ��ý��̵Ļ���  
		NULL, //    ָ���ӽ��̵Ĺ���·��  
		&si, // �����½��̵������������ʾ��STARTUPINFO�ṹ��  
		&pi  // �����½��̵�ʶ����Ϣ��PROCESS_INFORMATION�ṹ��  
	) == FALSE)           // Pointer to PROCESS_INFORMATION structure
	{
		printf("CreateProcess failed (%d).\n", GetLastError());
		return;
	}

	// Wait until child process exits.	�ȴ��ӽ��̽������ر�handle��
	//WaitForSingleObject(pi.hProcess, INFINITE);
	EnterDebugLoop(&DebugEv);
	// Close process and thread handles. 


	CloseHandle(pi.hProcess);
	CloseHandle(pi.hThread);
}

void EnterDebugLoop(const LPDEBUG_EVENT DebugEv)
{
	DWORD dwContinueStatus = DBG_CONTINUE; // exception continuation 
	EXCEPTION_RECORD x;
	BOOL waitEvent = TRUE;
	CONTEXT context;
	
	GetDebuggeeContext(&context);
	cout << GetEntryPointAddress();


	//if (GetEntryPointAddress() == context.Eip)
	//{


		context.EFlags |= 0x100;
		SetDebuggeeContext(&context);
		int single = 0;
		for (;;)
		{
			// Wait for a debugging event to occur. The second parameter indicates
			// that the function does not return until a debugging event occurs. 

			WaitForDebugEvent(DebugEv, INFINITE);

			// Process the debugging event code. 

			switch (DebugEv->dwDebugEventCode)
			{
			case EXCEPTION_DEBUG_EVENT:
				// Process the exception code. When handling 
				// exceptions, remember to set the continuation 
				// status parameter (dwContinueStatus). This value 
				// is used by the ContinueDebugEvent function. 

				switch (DebugEv->u.Exception.ExceptionRecord.ExceptionCode)
				{
				case EXCEPTION_ACCESS_VIOLATION:
					single = 0;
					// First chance: Pass this on to the system. 
					// Last chance: Display an appropriate error. 
					/*definations*/
					//Exceptioncode:
					//ExceptionFlags:The exception flags.value:0 indicating a continuable exception;or EXCEPTION_NONCONTINUABLE, indicating a noncontinuable exception.
					//ExceptionAddress:The address where the exception occurred.
					//NumberParameters:The number of parameters associated with the exception
					//ExceptionInformation is an array,the first number's value indicates the error type.
					//If this value is zero, the thread attempted to read the inaccessible data.
					//If this value is 1, the thread attempted to write to an inaccessible address.

					//printf("ExceptionCode:%lu ExceptionFlags:%lu ExceptionAddress:%p NumberParameters:%lu ExceptionInformation:%lu\n", DebugEv->u.Exception.ExceptionRecord.ExceptionCode, DebugEv->u.Exception.ExceptionRecord.ExceptionFlags, DebugEv->u.Exception.ExceptionRecord.ExceptionAddress, DebugEv->u.Exception.ExceptionRecord.NumberParameters, DebugEv->u.Exception.ExceptionRecord.ExceptionInformation[0]);
					//cout << DebugEv->u.Exception.ExceptionRecord.ExceptionFlags;

					break;

				case EXCEPTION_BREAKPOINT:
					// First chance: Display the current 
					// instruction and register values. 
					//printf("EXCEPTION_BREAKPOINT\n");

					break;

				case EXCEPTION_DATATYPE_MISALIGNMENT:
					// First chance: Pass this on to the system. 
					// Last chance: Display an appropriate error. 
					break;

				case EXCEPTION_SINGLE_STEP:
					// First chance: Update the display of the 
					// current instruction and register values. 
					single = 1;
					step_through(context);
					break;

				case DBG_CONTROL_C:
					// First chance: Pass this on to the system. 
					// Last chance: Display an appropriate error. 
					break;

				default:
					// Handle other exceptions. 
					break;
				}

				break;

			case CREATE_THREAD_DEBUG_EVENT:
				single = 0;
				// As needed, examine or change the thread's registers 
				// with the GetThreadContext and SetThreadContext functions; 
				// and suspend and resume thread execution with the 
				// SuspendThread and ResumeThread functions. 

				//dwContinueStatus = OnCreateThreadDebugEvent(DebugEv);
				break;

			case CREATE_PROCESS_DEBUG_EVENT:
				single = 0;
				// As needed, examine or change the registers of the
				// process's initial thread with the GetThreadContext and
				// SetThreadContext functions; read from and write to the
				// process's virtual memory with the ReadProcessMemory and
				// WriteProcessMemory functions; and suspend and resume
				// thread execution with the SuspendThread and ResumeThread
				// functions. Be sure to close the handle to the process image
				// file with CloseHandle.

				//dwContinueStatus = OnCreateProcessDebugEvent(DebugEv);
				break;

			case EXIT_THREAD_DEBUG_EVENT:
				single = 0;
				// Display the thread's exit code. 

				//dwContinueStatus = OnExitThreadDebugEvent(DebugEv);
				break;

			case EXIT_PROCESS_DEBUG_EVENT:
				single = 0;
				// Display the process's exit code. 
				waitEvent = FALSE;
				//dwContinueStatus = OnExitProcessDebugEvent(DebugEv);
				break;

			case LOAD_DLL_DEBUG_EVENT:
				single = 0;
				// Read the debugging information included in the newly 
				// loaded DLL. Be sure to close the handle to the loaded DLL 
				// with CloseHandle.

				//dwContinueStatus = OnLoadDllDebugEvent(DebugEv);
				break;

			case UNLOAD_DLL_DEBUG_EVENT:
				single = 0;
				// Display a message that the DLL has been unloaded. 

				//dwContinueStatus = OnUnloadDllDebugEvent(DebugEv);
				break;

			case OUTPUT_DEBUG_STRING_EVENT:
				single = 0;
				// Display the output debugging string. 

				//dwContinueStatus = OnOutputDebugStringEvent(DebugEv);
				break;

			case RIP_EVENT:
				single = 0;
				//dwContinueStatus = OnRipEvent(DebugEv);
				break;
			}
			// Resume executing the thread that reported the debugging event. 
			char answer = 1;
			if (waitEvent == TRUE)
			{
				if (single == 1)
				{

					cout << "�Ƿ������ -y/n��";
					cin >> answer;
					single = 0;
					if (answer == 'y')
					{
						GetDebuggeeContext(&context);
						context.EFlags |= 0x100;
						SetDebuggeeContext(&context);
						ContinueDebugEvent(DebugEv->dwProcessId, DebugEv->dwThreadId, DBG_CONTINUE);
					}
					else if (answer == 'n')
					{
						cout << endl;
						cout << "���Խ�����" << endl;
						break;
					}
					
				}
				else
				{
					ContinueDebugEvent(DebugEv->dwProcessId, DebugEv->dwThreadId, DBG_CONTINUE);
				}

			}
			else
			{
				break;
			}

		}
	//}
}
