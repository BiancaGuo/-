#include<iostream>
#include<string>
using namespace std;

/********************************************************************************
*Course: ����ԭ��
*Name:   ������
*Aim��   ���ñ���˼��������������02�棨�ݹ��½�˼�룩
*Date:   2017-11-3
*********************************************************************************/

string s;//�û�����ı��ʽ
int i;//Ŀǰɨ���λ��
int error;//�Ƿ���ϱ��ʽ�ķ�


bool isdigit(char c)//�ж��Ƿ�������
{
	if (c >= '0'&&c <= '9')
		return true;
	else
		return false;
}



int lexer()//�ʷ�����
{
	int len = s.length();
	char num[20];//�ִ�
	int number;
	int count = 0;
	int j;
	for (j = i; j < len; j++)
	{
		if (s[j] >= '0'&&s[j] <= '9')
		{
			num[count++] = s[j];
		}
		else
		{
			num[count] = '\0';//���ַ���ĩβ����ַ���������
			number = atoi(num);//�ַ���ת��Ϊ����
			break;
		}
	}
	i = j ;
	return number;
}

/*
ʹ�õ��ķ�Ϊ��

E->TE'
E'->+TE'|��
T->FT'
T'->*FT'|��
F->i|(E)

*/
int E();
int E_();
int T();
int T_();
int F();


int main()
{
	while (cin >> s)
	{
		i = 0;//ɨ��λ��
		error = 0;
		s += '#';//���ʽ������
		cout<< E()<<endl;
		if (s[i] == '#'&&error!=1)//ɨ�赽ĩβ�ұ��ʽ�����ķ�
			cout <<"���ܣ�" << endl;
		s = "";
	}
	

	return 0;
}

int E()//�ӷ��������
{
	
	if (error == 0)
	{
	
		if (isdigit(s[i]) || s[i] == '('||s[i]=='#')
		{
			return T() + E_();
		}
		else
		{
			cout << "E() is error!" << endl;
			return 0;//�ӷ�����0
		}
	}
}

int E_()
{
	if (error == 0)
	{
		char temp = s[i];
		if (s[i] == '+')
		{
			++i;	
			return T()+E_();
		}
		else if (s[i] != '#'&&s[i] != ')')
		{
			cout << "E_()�ܾ���" << endl;
			error = 1;
		}
		else
		{
			return 0;//�ӷ�����0
		}
	}
}


int T()//�˷��������
{
	if (error == 0)
	{
		if (isdigit(s[i]) || s[i] == '(')
			return F()*T_();
		else
		{
			cout << "T() is error!" << endl;
			return 1;//�˷�����1
		}
	}
}

int T_()
{
	if (error == 0)
	{
		if (s[i] == '*')
		{
			++i;
			return F()*T_();
		}
		else if (s[i] != '#'&&s[i] != ')'&&s[i] != '+')
		{
			cout << "T_()�ܾ���" << endl;
			error = 1;
		}
		else
		{
			return 1;//�˷�����1
		}
	}
}



int F()
{
	int temp;
	if (error == 0)
	{
		if (s[i] == '(')
		{
			++i;
			temp=E();
			if (s[i] == ')')
				++i;
			else if (s[i] == '#')
			{
				cout << "P()1�ܾ���" << endl;
				error = 1;
			}
			return temp;//�����ڼ���
		}
		else if (isdigit(s[i]))
		{
			temp = lexer();//�õ�������
			//++i;
			return temp;
		}
		else
		{
			cout << "P()2�ܾ���" << endl;
			error = 1;
		}
	}
}

