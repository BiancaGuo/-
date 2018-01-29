#include<string>
#include<iostream>
#include<stack>
#include<iomanip>
using namespace std;

bool is_digital(char a)//�ж��Ƿ�������
{
	if (a >= '0'&&a <= '9')
	{
		return true;
	}
	else
		return false;
}
bool is_terminal_symbol(char a)//�ж��Ƿ����ս��
{
	if (a == '#' || a == '+' || a == '-' || a == '*' || a == '/' || a == '^' || a == 'i' || a == '(' || a == ')')
	{
		return true;
	}
	else
	{
		return false;
	}

}


int chartoint(char c)//�����ս��ת��Ϊ�����±�
{
	int temp;
	if (is_digital(c))
	{
		temp = 4;
		return temp;
	}
	switch (c)
	{
	case '+':temp = 0;
		break;
	case '*':temp = 1;
		break;
	case '(':temp = 2;
		break;
	case ')':temp = 3;
		break;
	case 'i':temp = 4;
		break;
	case '#':temp = 5;
		break;
	default:temp = 6;
		break;
	}
	return temp;
}
//LR������
//S�ƽ���r��Լ
string LR_table[11][6] = { 
	{"&","&","S2","&","S3","&" },
	{ "S4","S5","&","&","&","acc" },
	{ "&","&","S2","&","S3","&" },
	{ "r4","r4","&","r4","&","r4" },
	{ "&","&","S2","&","S3","&" },
	{ "&","&","S2","&","S3","&" },
	{ "S4","S5","&","S9","&","&" },
	{ "r1","S5","&","r1","&","r1" },
	{ "r2","r2","&","r2","&","r2" },
	{ "r3","r3","&","r3","&","r3" },
	{ "&","&","&","&","&","&" }
};

int E[] = { 1,-1,6,-1,7,8,-1,-1,-1,-1 };
int pop_num[] = { 3,3,3,1 };

stack<int>statue;//״̬ջ
stack<char>symbol;//����ջ
string token; //������ʽ����#��β
int slen = 0;   //������ʽ�ĳ���
int sign = 1;
int position = 0;

char num[20];//�ִ�
int number;
int counts;

void lexer()//�ʷ�����
{
	int len = token.length();
	counts = 0;
	int j;
	for (j = position; j < len; j++)
	{
		if (token[j] >= '0' && token[j] <= '9')
		{
			num[counts++] = token[j];
		}
		else
		{
			//num[count] = '\0';//���ַ���ĩβ����ַ���������
			//number = atoi(num);//�ַ���ת��Ϊ����
			break;
		}
	}
	position = j;


}


void reduction(char proc)
{
	
	if (proc == '4')
	{
		num[counts] = '\0';//���ַ���ĩβ����ַ���������
		number = atoi(num);//�ַ���ת��Ϊ����
		symbol.push(number+'0');
	}
	else
	{

		if (proc == '1')
		{
			int a = symbol.top() - '0';
			symbol.pop();
			char opera = symbol.top();
			symbol.pop();
			int b = symbol.top() - '0';
			symbol.pop();
			symbol.push(a + b + '0');
		}
		else if (proc == '2')
		{
			int a = symbol.top() - '0';
			symbol.pop();
			char opera = symbol.top();
			symbol.pop();
			int b = symbol.top() - '0';
			symbol.pop();
			symbol.push(a * b + '0');
		}
		else if (proc == '3')
		{
			char r = symbol.top();
			symbol.pop();
			char re = symbol.top();
			symbol.pop();
			char l = symbol.top();
			symbol.pop();
			symbol.push(re);
		}
	}
	
}

void LR_calculate()
{  
	int step = 1;
	int top = -1;

	int a = 10;
	int b = 0;
	int c = 0;


	//cout << token << endl;
	/*
	cout << "------------------------------------------------------------------------------------------" << endl;
	cout << "|    ����    |    ״̬ջ    |    ����ջ    |    ���봮    |   Action      |     GOTO     |" << endl;
	cout << "------------------------------------------------------------------------------------------" << endl;
	*/
	while (LR_table[a][b]!= "acc")
	{
		
		cout << " (" << step << ")"<<"   ";//����
		stack<int>statue2 = statue;//״̬ջ
		stack<char>symbol2 = symbol;//����ջ
	
		while (!statue2.empty())//״̬ջ
		{
			cout << statue2.top();
			statue2.pop();
		}
		cout << "     ";
		
		while (!symbol2.empty())//����ջ
		{
			cout << symbol2.top();
			symbol2.pop();
		}
		cout << "     ";
		for (int i = position; i < token.length(); i++)//���봮
		{
			cout << token[i];
		}
		cout << "     ";

		a = statue.top();
		b = chartoint(token[position]);
		c = symbol.top();
		if (LR_table[a][b][0]=='S')//�ƽ�
		{
			if (is_digital(token[position]))
			{
				lexer();
				statue.push(LR_table[a][b][1] - '0');
			}
			else
			{
				statue.push(LR_table[a][b][1] - '0');
				symbol.push(token[position]);
				position++;
			}
			

		}
		else if (LR_table[a][b][0] == 'r')//��Լ
		{
			int num = pop_num[(LR_table[a][b][1]-'0') - 1];

			for (int i = 0; i < num; i++)
			{
				statue.pop();
				//symbol.pop();
			}
			top = statue.top();
			statue.push(E[top]);
			//symbol.push('E');
			reduction(LR_table[a][b][1]);
		}
		else if (LR_table[a][b][0] == 'a')
		{

		}
		else 
		{
			sign = 0;
			break;
		}

		cout << LR_table[a][b]<<"     ";//Action

		if (top != -1)
			cout << E[top];//Goto

		step++;
		top = -1;
		cout << endl;
	}


}

int main()
{

	while (cin >> token)//������ʽ����
	{
		while (!statue.empty())
		{
			statue.pop();
		}
		while (!symbol.empty())//��ղ�����ջ
		{
			symbol.pop();
		}
		
		position = 0;
		token += "#";
		symbol.push('#');
		statue.push(0);
		LR_calculate();//������ʽ
		cout << endl;
		cout << "result=" << symbol.top()-'0' << endl << endl;//���������
		if (sign == 1)
			cout << endl << "�����ɹ�" << endl << endl;
		else
			cout << endl << "����ʧ��" << endl << endl;
	}

	return 0;
}