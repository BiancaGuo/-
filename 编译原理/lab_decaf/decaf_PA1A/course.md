编译原理报告

我来给大家讲Decaf编译器的词法分析和语法分析部分

首先进行的是词法分析工作

是符合decaf语言规范的程序，xx页提供了一个例子，一个decaf程序是一个类定义的序列，每个类定义包含该类的完整描述

在decaf编译器中，它的词法分析工具是由lex工具自动生成的

基本的流程就是我们编写一个lex描述文件，然后通过自动化生成工具处理，就得到了最终的词法分析程序。

词法分析程序的工作方式

正规表达式其实就是我们之前用过的正则表达式，正则表达式就是记录文本规则的代码。使用很短的代码来匹配一系列符合某个语法规则的字符串。

它可以很方便的用很短的代码表示一类文本

. ：可以匹配除换行符外的任意字符

*：代表字符可以不出现，也可以出现一次或者多次
+：匹配前面的子表达式一次或多次。
？：匹配前面的子表达式零次或一次
$：匹配输入字符串的结尾位置。

\：将下一个字符标记为或特殊字符、或原义字符、或向后引用、或八进制转义符。（ 'n' 匹配字符 'n'。'\n' 匹配换行符。序列 '\\' 匹配 "\"，而 '\(' 则匹配 "("。）
^：匹配输入字符串的开始位置，除非在方括号表达式中使用，此时它表示不接受该字符集合。（匹配该字符列表之外的所有字符
|：两项之间任选其一

()：标记一个子表达式的开始和结束位置。() 是为了提取匹配的字符串。表达式中有几个()就有几个相应的匹配字符串。
[]：待匹配的字符列表。定义匹配的字符范围
{}：限定符表达式（匹配次数）{}一般用来表示匹配的长度


(0-9) 匹配 '0-9′ 本身。 [0-9]* 匹配数字（注意后面有 *，可以为空）[0-9]+ 匹配数字（注意后面有 +，不可以为空）{1-9} 写法错误。

[0-9]{0,9} 表示长度为 0 到 9 的数字字符串。


keyword():所执行的动作就是获得这个关键字的位置信息，并把这个词提供给yacc进行下一步处理
parser.yylval其实就是暴露给yacc的一个接口


这一段的规则比较特殊，是用来匹配输入的字符串。这个S是我们之前定义的开始条件，可以使用BEGIN来激活，拥有给定开始条件的规则被激活，不拥有开始条件的规则不被激活，直到下一个BEGIN执行时。

lex描述文件


介绍完Decaf编译器的词法分析部分，下面介绍语法分析部分

yacc也是需要我们导入相应的描述文件，才能最终得到语法分析程序

LALR(1)查看向前搜索符（解决冲突）并合并同心集来构造项目集和分析表

声明部分包含了一些函数声明、全局变量的定义、头文件、宏声明等

规则中每个文法符号以及语义动作本身都可以有自己动作对应的语义值，终结符的语义值由词法分析程序给出，保存在yylval中，非终结符的语义值在语义动作中获得。

这里使用的文法是在 Decaf语言规范中给出的参考文法

本实验中归约动作为生成相应的抽象语法树，以缩进格式体现父子关系

词法分析和语法分析的整体流程就是语法分析程序需要处理一个词时，就调用yylex()获取，然后按照语法制导的语义计算过程生成提供给语义分析适用的AST

语法分析程序对词法分析返回的终结符序列进行归约

