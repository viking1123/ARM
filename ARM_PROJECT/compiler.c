#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define reg_limit 20000
//---------------------------------stack-------------------------------------
struct stack
{
	int data;
	struct stack* next;
};
//--------------------------------Node---------------------------
struct node
{
	int number;
	int is_operand;
	struct node *next;
};
//------------------------To push value into stack---------------------------------------
void push(int data,struct stack **st1)
{
	struct stack *temp=(struct stack *) malloc(sizeof(struct stack));
	temp->data=data;
	temp->next=*st1;
	*st1=temp;
}
//------------------------------To pop value into stack-------------------------------------
int pop(struct stack **st1)
{
	if(*st1==NULL)
		return -1;        
	struct stack *temp=*st1;
	*st1=(*st1)->next;
	int data=temp->data;
	free(temp);
		return data;	//If the stack is not empty we return the data
}
//-------------------------CREATES LINKED LIST TO EVALUATE THE POSTFIX FOR THE input_expr----------------------------------------
void append(int data,int is_operand,struct node **start,struct node **end)
{
struct node *temp=(struct node *) malloc(sizeof(struct node));
temp->number=data;
temp->is_operand=is_operand;
temp->next=NULL;
if((*end)==NULL)
{
(*end)=temp;
(*start)=temp;
}
else
{
(*end)->next=temp;
(*end)=(*end)->next;
}
}

//-------------------------------------------RETURNS THE top OF STACK--------------------------------------
char top_of_stack(struct stack **st1)
{
return (*st1)->data;
}

//---------------------------------------------CHECKS IF STACK IS EMPTY--------------------------------------------
int is_stack_empty(struct stack **st1)
{
	if((*st1)==NULL)
	return 1;
	else
	return 0;
}

//----------------------------------------------------RETURNS THE PRECEDENCE OF OPERATORS-------------------------------------
int precedence_table(char ch)
{
if(ch=='(')
	{
		return 1;
	}
if(ch=='+'||ch=='-')
		return 2;
if(ch=='*'||ch=='/')
		return 3;
}

//-------------------------------------------------CREATES ASSEMBLY code---------------------------------
void assembly_code(struct node **start)
{
struct node *temp=*start;
struct stack **operand_stack=(struct stack **) malloc(sizeof(struct stack *));

char c;		//For the opearator selection
int operand1,operand2,reg=0;
FILE *fp=fopen("assembly_code.s","w");
if(fp==NULL)
{
printf("Error in opening the file\n");
exit(1);
}
fprintf(fp,"\tAREA appcode, CODE, READONLY\n\tEXPORT __main\n\tIMPORT print_1\n\tENTRY\n__main FUNCTION\n");
while((temp)!=NULL)
{
if(temp->is_operand==0)			// while appending we made sure that 0-->operand 1-->operator
push(temp->number,operand_stack);	// if we have a operand we push it into operand stack
else
{
c=temp->number;
switch(c)				// C has the operator
{ 
	case '+':
	
// less than reg_limit -> number, if it is >reg_limit it is a register. reg variable is used to know the current 	   	registers under use. This is mainly used to preserve the number of registers. 
		if((operand1=pop(operand_stack))<reg_limit)
			fprintf(fp,"\t\tMOV R%d,#%d\n",reg++,operand1);
		if((operand2=pop(operand_stack))<reg_limit)
			fprintf(fp,"\t\tMOV R%d,#%d\n",reg++,operand2);
		
		if(operand1<reg_limit && operand2<reg_limit)
		{
			fprintf(fp,"\t\tADD R%d,R%d\n",reg-2,reg-1);
			reg--;
			push(reg_limit+(reg-1),operand_stack);
		}

		if(operand1<reg_limit && operand2>=reg_limit)
		{
			fprintf(fp,"\t\tADD R%d,R%d\n",operand2-reg_limit,reg-1);
			reg--;
			push(operand2,operand_stack);
		}
                if(operand1>=reg_limit && operand2<reg_limit)
                {
                	fprintf(fp,"\t\tADD R%d,R%d\n",operand1-reg_limit,reg-1);
                	reg--;
                	push(operand1,operand_stack);
                }
		if(operand1>=reg_limit && operand2>=reg_limit)
		{
			fprintf(fp,"\t\tADD R%d,R%d\n",operand2-reg_limit,operand1-reg_limit);
			reg--;
			push(operand2,operand_stack);
		}
		break;
		
	case '-':
		operand1=pop(operand_stack);
		operand2=pop(operand_stack);

		if(operand2<reg_limit)
			fprintf(fp,"\t\tMOV R%d,#%d\n",reg++,operand2);
		if(operand1<reg_limit)
			fprintf(fp,"\t\tMOV R%d,#%d\n",reg++,operand1);
		if(operand1<reg_limit && operand2<reg_limit)
		{
			fprintf(fp,"\t\tSUB R%d,R%d\n",reg-2,reg-1);
			reg--;
			push(reg_limit+(reg-1),operand_stack);
		}
		if(operand1<reg_limit && operand2>=reg_limit)
		{
			fprintf(fp,"\t\tSUB R%d,R%d\n",reg-1,operand2-reg_limit);
			reg--;
			push(operand2,operand_stack);
		}
                if(operand1>=reg_limit && operand2<reg_limit)
                {
                	fprintf(fp,"\t\tSUB R%d,R%d\n",reg-1,operand1-reg_limit);
                	reg--;
                	push(operand1,operand_stack);
                }
		if(operand1>=reg_limit && operand2>=reg_limit)
		{
			fprintf(fp,"\t\tSUB R%d,R%d\n",operand2-reg_limit,operand1-reg_limit);
			reg--;
			push(operand2,operand_stack);
		}
		break;
		
	case '*':
		if((operand1=pop(operand_stack))<reg_limit)
			fprintf(fp,"\t\tMOV R%d,#%d\n",reg++,operand1);
		if((operand2=pop(operand_stack))<reg_limit)
			fprintf(fp,"\t\tMOV R%d,#%d\n",reg++,operand2);
		if(operand1<reg_limit && operand2<reg_limit)
		{
			fprintf(fp,"\t\tMUL R%d,R%d\n",reg-2,reg-1);
			reg--;
			push(reg_limit+(reg-1),operand_stack);
		}
		if(operand1<reg_limit && operand2>=reg_limit)
		{
			fprintf(fp,"\t\tMUL R%d,R%d\n",operand2-reg_limit,reg-1);
			reg--;
			push(operand2,operand_stack);
		}
                if(operand1>=reg_limit && operand2<reg_limit)
                {
                	fprintf(fp,"\t\tMUL R%d,R%d\n",operand1-reg_limit,reg-1);
                	reg--;
                	push(operand1,operand_stack);
                }
		if(operand1>=reg_limit && operand2>=reg_limit)
		{
			fprintf(fp,"\t\tMUL R%d,R%d\n",operand2-reg_limit,operand1-reg_limit);
			reg--;
			push(operand2,operand_stack);
		}
		break;
		
	case '/':
		operand1=pop(operand_stack);
		operand2=pop(operand_stack);

		if(operand2<reg_limit)
			fprintf(fp,"\t\tMOV R%d,#%d\n",reg++,operand2);
		if(operand1<reg_limit)
			fprintf(fp,"\t\tMOV R%d,#%d\n",reg++,operand1);
		if(operand1<reg_limit && operand2<reg_limit)
		{
			fprintf(fp,"\t\tSDIV R%d,R%d\n",reg-2,reg-1);
		reg--;
			push(reg_limit+(reg-1),operand_stack);
		}
		if(operand1<reg_limit && operand2>=reg_limit)
		{
			fprintf(fp,"\t\tSDIV R%d,R%d\n",reg-1,operand2-reg_limit);
			reg--;
			push(operand2,operand_stack);
		}
                if(operand1>=reg_limit && operand2<reg_limit)
                {
                	fprintf(fp,"\t\tSDIV R%d,R%d\n",reg-1,operand1-reg_limit);
                	reg--;
                	push(operand1,operand_stack);
                }
		if(operand1>=reg_limit && operand2>=reg_limit)
		{
			fprintf(fp,"\t\tSDIV R%d,R%d\n",operand2-reg_limit,operand1-reg_limit);
			reg--;
			push(operand2,operand_stack);
		}
		break;
}
}
temp=temp->next;
}
fprintf(fp,"stop B stop\n\tENDFUNC\n\tEND\n");
fclose(fp);
}

//-------------------------MAIN_FUNCTION------------------------------------------------
int main()
{

struct node **list_end=(struct node **)malloc(sizeof(struct node*));
struct node **list_start=(struct node **)malloc(sizeof(struct node*));
struct stack **operator_stack=(struct stack **)malloc(sizeof(struct stack*));

char expr[100],c;
int i,number=0,j;

printf("Enter the expr:\n");

scanf("%s",expr);			//We read the expr written in infix-form as a string

for(i=0;i<strlen(expr);i++)
{

//If the characters in expr typed are alphabets print them in post-fix format but in assembly code treat their ascii values
	
	if((expr[i]>='A'&& expr[i]<='Z')||(expr[i]>='a'&& expr[i]<='z'))
	{
		printf("%c",expr[i]);
		append(expr[i],0,list_start,list_end);
	}

	if((expr[i]>='0'&& expr[i]<='9'))
	{
		j=i;
		while((expr[j]>='0'&& expr[j]<='9'))//Till we are reading a number i.e an operand this loop is run
		{
			
			number=(number*10)+(expr[j]-'0'); //To convert into integer so that we donot consider the ascii values 
			j++;
		}
		i=j-1;
		printf("%d",number);			//Finally the operand is printed on screen
		append(number,0,list_start,list_end);	//A '0' is appended to reflect that an operand entry has been completed	
		number=0;
		
	}
	if(expr[i]=='(')
		push('(',operator_stack);		//Pushing open brackets into stack
	if(expr[i]==')')				//If we encounter a ')' we pop all contents of operator stack until '(' is obtained
	{
		while((c=pop(operator_stack))!='(')
			{
			printf("%c",c);			//Printing the output of pop function which are the popped operators
			append(c,1,list_start,list_end);
			}
	}
	if((expr[i]=='+')||(expr[i]=='-')||(expr[i]=='*')||(expr[i]=='/'))
	{
		if(!is_stack_empty(operator_stack))

	//Whenever a new operator arrives we check if the priority of this is more than that on top of stack
	//If it is less than that, then we pop the operator in stack and append to the post-fix expr
	//Else we just push it onto the operator stack.
		while(precedence_table(top_of_stack(operator_stack))>=precedence_table(expr[i]))
		{
		c=pop(operator_stack);
		printf("%c",c);
		append(c,1,list_start,list_end);
		if(is_stack_empty(operator_stack))
		break;
		}
		push(expr[i],operator_stack);
	}
   
}
while((c=pop(operator_stack))!=-1)
{
printf("%c",c);
append(c,1,list_start,list_end);
}
printf("\n");
assembly_code(list_start);
return 0;
}
