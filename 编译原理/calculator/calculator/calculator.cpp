#include<iostream>
#include<iomanip>
#include<string>
#include<cctype>
using namespace std;
#include<stack>
#include<stdio.h>
#include<stdlib.h>
stack <char> stk_postfix;
stack <double> stk_numbers;

bool isOperator(char c)
{
	if (c == '*' || c == '/' || c == '+' || c == '-')
		return true;
	else
		return false;
}
int operator_priority(char c)
{	
	int flag;
	switch (c)
	{
	case '&':
		flag = -1;
		break;
	case ')':
		flag = 0;
		break;
	case '+':
		flag = 1;
		break;
	case '-':
		flag = 1;
		break;
	case '*':
		flag = 2;
	case '/':
		flag = 2;
		break;
	case '(':
		flag = 3;
		break;
	default:
		break;
	}
	return flag;
}

void infix_to_postfix(string smath,char* psmath)
{
	
	int i = 0;
	int j = 0;
	while(i<smath.length())
	{
		if ((smath[i] >= '0'&&smath[i] <= '9')||smath[i]=='-')
		{
			while ((smath[i] >= '0'&& smath[i] <= '9') || smath[i] == '.'|| smath[i]=='-')
				psmath[j++] = smath[i++];
		}
		else if(isOperator(smath[i]))
		{
			psmath[j++] = ' ';
			while (operator_priority(smath[i]) <= operator_priority(stk_postfix.top()))
			{
				//cout << "stk_postfix.top():" << stk_postfix.top() << endl;
				psmath[j++] = stk_postfix.top();
				stk_postfix.pop();
			}
			stk_postfix.push(smath[i++]);
		}
		else if (smath[i] == '(')
		{
			stk_postfix.push(smath[i++]);
		}
		else if (smath[i] == ')')
		{
			while (operator_priority(smath[i]) < operator_priority(stk_postfix.top()) && stk_postfix.top()!='(')
			{
				psmath[j++] = stk_postfix.top();
				stk_postfix.pop();
			}
			if(stk_postfix.top()=='(')
				stk_postfix.pop();//������������������ƥ�䣬ƥ�䵽�����ź󵯳�ջ������Ҫ���
			i++;
		}
	}

	while (stk_postfix.top() != '&')
	{
		psmath[j++] = stk_postfix.top();
		stk_postfix.pop();
	}
		
	psmath[j] = '#';
}

double countTempResult(char pmath)
{
	double answer = 0.0;
	double a = stk_numbers.top();
	stk_numbers.pop();
	double b = stk_numbers.top();
	stk_numbers.pop();
	
	switch (pmath)
	{
	case '*':
		answer = b*a;
		break;
	case '/':
		if (a == 0)
		{
			cout << "ERROR������Ϊ0��\n";
			exit(-1);
		}
		else
		{
			answer = b / a;
		}	
		break;
	case '+':
		answer = b + a;
		break;
	case '-':
		answer = b - a;
		break;
	default:
		break;
	}
	return answer;
}
double countResult(char *pmath)
{
	int i = 0;
	string num = "";
	double number = 0.0;
	double answer = 0.0;

	while (!stk_numbers.empty())
		stk_numbers.pop();

	int dotflag = 0;
	int negative = 0;

	while (pmath[i] != '#')
	{
		if ((pmath[i] >= '0'&&pmath[i] <= '9')|| pmath[i] == '-')
		{
			while ((pmath[i] >= '0'&& pmath[i] <= '9') || pmath[i] == '.' || pmath[i] == '-')
			{
				
				if (pmath[i] == '.')
				{
					//num += pmath[i];
					dotflag = i;
				}
				else if (pmath[i] == '-')
				{
					negative = 1;
				}
				else
				{
					num += pmath[i];
				}
				i++;
			}
				
		}
		else 
		{
			if (num != "")
			{
				if (dotflag > 0)
				{
					for (int j = 0; j < num.length(); j++)
					{
						//����С����ʱ��ͨ��С����λ���жϸ�λ��Ӧ�ó���10�Ķ��ٴη�
						number += (num[j] - '0') * pow(10.0, dotflag - j - 1);
					}
					if (negative == 1)
					{
						number = -1 * number;
					}
					stk_numbers.push(number);
					
				}
				if (dotflag == 0)
				{
					for (int j = 0; j < num.length(); j++)
					{
						//������С����ʱ��ͨ���ַ��������жϸ�λ��Ϊ��λ����
						number += (num[j] - '0') * pow(10.0, num.length() - j - 1);

					}
					if (negative == 1)
					{
						number = -1 * number;
					}
					stk_numbers.push(number);
				}
				dotflag = 0;
			}
			
			

			if (isOperator(pmath[i]))
			{
				answer = countTempResult(pmath[i]);
				stk_numbers.push(answer);
				answer = 0;
			}
			i++;

			dotflag = 0;
			number = 0;
			num = "";
			negative = 0;
		}
		
	}
	
	return stk_numbers.top();
}

int main()
{
	
	string smath;
	char psmath[1000];
	
	double result = 0.0;
	cout << "��������ʽ��";
	cin >> smath;

	while (!stk_postfix.empty())
		stk_postfix.pop();

	stk_postfix.push('&');
	cout << "��׺���ʽΪ��" << smath << endl;

	cout << "��׺���ʽΪ��";

	infix_to_postfix(smath, psmath);//��׺���ʽת��׺���ʽ

	int i = 0;
	while (psmath[i] != '#')
	{
		cout << psmath[i];
		i++;
	}
	cout << endl;
	
	cout << "������Ϊ";

	result = countResult(psmath);
	cout << result << endl;

	system("pause");
	return 0;
}