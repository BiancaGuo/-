#include<stdio.h>
#include<iostream>
#include<iomanip>
using namespace std;
#define maxsize 1000

int request[maxsize];//������Դ
int allocation[maxsize][maxsize];//�������
int MAX[maxsize][maxsize];//����������
int available[maxsize];//��������Դ����
int need[maxsize][maxsize];//�������


//ѭ��ʹ��
int request2[maxsize];
int allocation2[maxsize][maxsize];
int allocation3[maxsize][maxsize];
int available2[maxsize];
int available3[maxsize];
int need2[maxsize][maxsize];
int need3[maxsize][maxsize];
int N;//������
int M;//��Դ��


void destroy(int p)
{
	for (int j = 0; j < M; j++)
	{
			available2[j] += allocation2[p][j];
			need2[p][j] = 10000;
	}
}


int main()
{
	while (1)
	{
		cout << "���������������Դ��������" << endl << endl;
		cout << "��������" << endl;
		cin >> N;
		cout << "��Դ��������" << endl;
		cin >> M;

		cout << endl;
		cout << "�����������Դ�������� ";
		for (int i = 0; i < M; i++)
		{
			cin >> available[i];
		}

		cout << endl;
		cout << "������ÿ�����̶���Դ��������� " << endl;
		for (int i = 0; i < N; i++)
		{
			for (int j = 0; j < M; j++)
			{
				cin >> MAX[i][j];
			}
		}

		cout << endl;
		cout << "������ÿ�������Ѿ�����ĸ�����Դ����" << endl;
		for (int i = 0; i < N; i++)
		{
			for (int j = 0; j < M; j++)
			{
				cin >> allocation[i][j];
			}
		}

		//need
		for (int i = 0; i < N; i++)
		{
			for (int j = 0; j < M; j++)
			{
				need[i][j] = MAX[i][j] - allocation[i][j];
			}
		}

		//��available��ÿ����Դ��������
		for (int i = 0; i < N; i++)
		{

			for (int j = 0; j < M; j++)
			{
				available[j] = available[j] - allocation[i][j];
			}
		}

		cout << endl;


		//�Ƿ�ᷢ����������
		cout << "�Ƿ��а�ȫ���䷽ʽ���ԣ�" << endl;
		for (int i = 0; i < M; i++)
		{
			available2[i] = available[i];
		}

		for (int i = 0; i < N; i++)
		{
			for (int j = 0; j < M; j++)
			{
				allocation2[i][j] = allocation[i][j];
				need2[i][j] = need[i][j];
			}

		}
		int process_num = N;//��ʼ������
		while (process_num > 0)//�����̶�����ִ�����ʱ�˳�
		{
			int flag = 0;
			//available > MAX
			for (int i = 0; i < N; i++)//ѭ���������н���
			{
				int count = 0;
				for (int j = 0; j < M; j++)
				{
					if (available2[j] >= need2[i][j])//��Դ������>����������¼
					{
						count++;
					}
				}
				if (count == M)//������Դ�����������ڸý�����������ʱ���з���
				{
					cout << "����" << i << "����" << endl;
					flag = 1;
					destroy(i);//ִ�н��̲��ͷ���Դ
					process_num--;
				}
			}

			if (flag == 0)//�������ڽ���������Դ����ʱ����������
			{
				cout << "����������" << endl;
				break;
			}

		}//end while

		if (process_num == 0)//���н��̶�ִ�����
		{
			cout << "�������������" << endl;
		}

		cout << endl;




		//������̲���
		int proc = 0;
		cout << "������̲��ԣ�" << endl;//��������Ľ��̺�
		//��ʼ��
		for (int i = 0; i < M; i++)
		{
			available2[i] = available[i];
			available3[i] = available[i];
		}
		for (int i = 0; i < N; i++)
		{
			for (int j = 0; j < M; j++)
			{
				allocation2[i][j] = allocation[i][j];
				allocation3[i][j] = allocation[i][j];
				need2[i][j] = need[i][j];
				need3[i][j] = need[i][j];
			}
		}
		int que[maxsize] = { 0 };//�����Ƿ��Ѿ�ִ����ϣ�ִ����ϸ�ֵ1
		while (1)//ѭ������������Դ�Ľ�����Ϣ
		{
			int temp = 0;
			cout << "����������̣�-1ֹͣ���ԣ���" << endl;
			cin >> proc;
			if (proc == -1)
				break;
			int flag = 0;
			cout << "����������Դ��Ŀ��" << endl;
			for (int k = 0; k < M; k++)
			{
				cin >> request[k];
				//���������Դ������Ҫ����Դ����ڿ�����Դʱ�����ܸ��ý��̷���������Դ
				if (request[k] > need3[proc][k] || request[k] > available3[k])
				{
					cout << "����ʧ�ܣ�" << endl;
					temp = 1;
					break;
				}
			}
			if (temp == 1)
				continue;

			//���Է���
			for (int k = 0; k < M; k++)
			{
				allocation2[proc][k] += request[k];//���̷�����Դ=�ѷ�����Դ+�ô��������Դ
				need2[proc][k] = need2[proc][k] - request[k];//����������Դ=�ѷ�����Դ-�ô��������Դ
				available2[k] = available2[k] - request[k];//��ǰ������Դ=������Դ-�ô��������Դ
			}
			que[proc] = 1;
			destroy(proc);//����ִ�н�������Դ�ͷ�
			int num = 0;
			for (int i = 0; i < N; i++)//��ǰ�ȴ������еĽ�����
			{
				if (que[i] == 0)
					num++;
			}
			//��8��˼·��ͬ
			int process_num = num;
			while (process_num > 0)
			{
				int flag = 0;
				int i;
				int j;
				for (i = 0; i < N; i++)
				{
					if (que[i] == 0)//δ����Ľ���
					{
						int count = 0;
						for (j = 0; j < M; j++)
						{
							if (available2[j] >= need2[i][j])
							{
								count++;
							}
						}
						if (count == M)
						{
							cout << "����" << i << "����" << endl;
							flag = 1;
							destroy(i);
							process_num--;
						}
					}
				}
				if (flag == 0)
				{
					cout << "�������������ܽ���Դ�����" << proc << endl;
					//�����������շ�����Դ
					que[proc] = 0;
					for (int k = 0; k < M; k++)
					{
						allocation2[proc][k] -= request[k];
						need2[proc][k] = need3[proc][k];
						available2[k] = available3[k];
					}
					break;
				}
			}
			if (process_num == 0)
			{
				//������������������Դ����
				cout << "���ᷢ�����������Խ���Դ�����" << proc << endl;
				que[proc] = 1;
				for (int k = 0; k < M; k++)
				{
					available3[k] = available3[k] - request[k];
					need3[proc][k] = need3[proc][k] - request[k];
					available2[k] = available3[k];
				}
			}
			for (int i = 0; i < N; i++)
			{
				if (que[i] == 0)
				{
					for (int k = 0; k < M; k++)
					{
						need2[i][k] = need[i][k];
					}
				}
			}

		}
		return 0;
	}
}