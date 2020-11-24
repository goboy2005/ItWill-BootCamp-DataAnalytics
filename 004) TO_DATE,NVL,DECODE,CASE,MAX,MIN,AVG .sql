? 031 ��¥������ ������ ���� ��ȯ�ϱ�(TO_DATE)

��ȯ�Լ� : to_date �Լ� to_date('81/11/17','RR/MM/DD');

"��¥�� �� ��ȯ�ϴ� �Լ�"
���� : select ename,hiredate
         from emp
      where hiredate = '81/11/17'; 
�̰� ������ ������ ��¥������ �� �¾Ƽ�! 

Where �� ���� ��¥�� = ��¥�� date = date 
                       ������ = ������ (sal = 3000)

to_date����ؼ� �ִ� Ȯ���� ��¥�� ��� �������ָ� �� ���ϴ�. 
����: ��¥�� �����͸� �˻��� ���� 
�ݵ�� to_date �Լ��� ����ϼ��� ^^ 

��ȯ�Լ� : ���ڷ� �� ��ȯ�ϴ� �Լ� 
������ 3000�� ����� �̸��� ������ ����Ͻÿ�!
select ename,sal
  from emp
     where sal = 3000 

������ : Varchar2
������ : number
��¥�� : date

select ename,sal
from emp
where sal ='3000';
sal �� �����̰� '3000'�� ���ڶ� ������ error�� ������ oralce ������ ���������� �������� ���������� ��ȭ�����ش�. 
(��� �˻�������, ���� �� ���ں�/ ��¥�� ��¥��/ ���ڴ� ���ں񱳰� ����) 

��ȯ�Լ� : 1. to_char : ���ڷ� �� ��ȯ�ϴ� �Լ� 
              2. to_number : ���ڷ� ����ȯ�ϴ� �Լ�
              3.to_date : ��¥�� �� ��ȯ�ϴ� �Լ� 
                                                                                                             
���� : where ���� �˻������� ���� �� ������ ������ ���� �÷��� �����͸� �˻��� ���� ���ڷ� �˻��ϰ� ���� �÷��� �����͸� �˻��� ���� ���ڷ� �˻��ؾ� �Ѵ�. 
���࿡ �������ε� ���������� �˻��ϰų� �������ε� ���������� �˻��ϸ�
����Ŭ�� ������ �ȳ����� �˻������� �������� �˴ϴ�. 
�׷��Ƿ� �ݵ�� �˻������� ������ ���� ������ ������� �մϴ�. 


? 033 NULL �� ��� �ٸ� ������ ����ϱ�(NVL, NVL2)

1.nvl �Լ�
2.decode �Լ� 
3.case �Լ� 

nvl �Լ� : null �� ��ſ� �ٸ����� ����ϰ� ���� �� ����ϴ� �Լ� 
null �� : �����Ͱ� ���� ���� �Ǵ� �� �� ���� ��  

����)
�̸�,����,Ŀ�̼�,����+Ŀ�̼��� ����Ͻÿ�.
select ename,sal,comm,nvl(comm,0)+sal as �ѹ�����
from emp;
���� data�� �ٲ���� �ƴ϶� ��µǴ� ���� 0���� �ٲ� ���̴�. 
����: nvl �Լ��� �ٸ������� ��ü�ؼ� ����ϴ� ������ ������ ���̺��� �����Ͱ� 0���� ����Ȱ��� �ƴϴ�. 

? 034 IF���� SQL�� �����ϱ� 1(DECODE)

If ���� SQL�� ������ �� ����Ҷ� �Լ�
���࿡ �������� �������� ��� �ൿ�ض� ��� ��ǻ�� ���α׷����� �ϴ°��ε� 
����: select ename,sal,job,
        decode(deptno,10,5600,
                             20,4500,        
                              0) as ���ʽ� 
from emp ; 

  �μ���ȣ�� 10���̸� 5600�� ����ϰ�
  �μ���ȣ�� 20���̸� 4500�� ����ϰ�                             
  ������ �μ���ȣ�� 0�� ����ض� ~~

? 035 IF���� SQL�� �����ϱ� 2(CASE)

@�߿伳�� decode�� ��ȣ (=) �񱳸� �����ϱ� ������ ���࿡ �ε�ȣ �񱳸� �Ϸ��� 
               case ���� ����ؾ� �Ѵ�. Case ���� ��ȣ�񱳿� �ε�ȣ �� �Ѵ� �����մϴ�.

select ename,sal,deptno, case when deptno = 10 then 500
                              when deptno = 20 then 300
                              else 0 end as ���ʽ�

? 036 �ִ밪 ����ϱ�(MAX) &  037 �ּҰ� ����ϱ�(MIN)

select max(sal)
from emp; 
*�ִ� ������ ����Ͻÿ� ! 
select min(sal)
from emp

? 038 ��հ� ����ϱ�(AVG)

select deptno, max(sal) ,�Ѱ��� ����Ϸ��� �ϱ⶧���� 
        ���� �� �������� 

where group by deptno;
group by ���� ���� �� �������ϴ� deptno �� grouping ���ش�. 
group by deptno; 


90.������ SALESMAN �� ������� �̸��� ���ް� ������ ����ϴµ� ������ ���� ������� ����Ͻÿ�

select ename,job,sal
from emp
where job = 'SALESMAN'
order by sal desc;

91.������ SALESMAN �� �ƴ� ������� �̸��� �Ի��ϰ� ������ ����ϴµ� �ֱٿ� �Ի��� ������� ����Ͻÿ� 

select ename,job,hiredate
from emp
where job not in ('SALESMAN')
order by hiredate desc;

92.������ 1000���� 3000������ ������� �̸��� ������ ����Ͻÿ�.

select ename,sal
from emp
where sal between 1000 and 3000;

93.�̸��� ����ϰ� �� ���� �̸��� ù��° ö�ڸ� ����ϴµ�
�ҹ��ڷ� ����Ͻÿ�

select ename,lower(substr(ename,1,1))
from emp;

94.�츮�� ���̺��� �̸��� �̸����� ����ϰ� �� ���� �̸��Ͽ��� @�� ���° ö������ ����Ͻÿ�.

select ename,email,instr(email,'@')
from emp12;

95.�̸��� �Ի���,�Ի��� �⵵�� 4�ڸ��� ����Ͻÿ� 

select ename,hiredate, to_char(hiredate,'RRRR') 
from emp;

96.11���� �Ի��� ������� �̸��� �Ի����� ����Ͻÿ�.

select ename,hiredate,to_char(hiredate,'MM')
from emp
where to_char(hiredate,'MM')=11; 

97.96���� to_char ������� ���� substr �� �����Ͻÿ�

select ename,hiredate
from emp
where substr(hiredate,4,2) like '11';

98.1981�⵵�� �Ի��� ������� �̸��� �Ի����� ����Ͻÿ� . 

to_char ���
select ename,hiredate
from emp
where to_char(hiredate,'RRRR') = '1981' ;
or
to_date ��� 
select ename
from emp
where hiredate between to_date('81/01/01','RR/MM/DD') and to_date('81/12/31','RR/MM/DD');

99.1981�⵵�� �Ի��� ����� �̸��� �Ի��� �⵵�� ����ϴµ�
�ֱٿ� �Ի��� ������� ����Ͻÿ�. 

select ename,hiredate
from emp
where hiredate between to_date('81/01/01','RR/MM/DD') and to_date('81/12/31','RR/MM/DD')
order by hiredate desc;

100.�̸�,Ŀ�̼��� ����Ͻÿ�

select ename,comm
from emp;

101.�̸� Ŀ�̼��� ����ϴµ� Ŀ�̼��� null�� ������� no comm�̶�� �۾��� ����Ͻÿ�. 
select ename,nvl(comm,'no comm')
from emp;
������ ����. ������ comm�� �������̰� 'no comm'�� ������ �̱⶧���̴�. 
���� : �������� ���������� ��ȯ�ؼ� ������ Ÿ���� ���� �����ϰ� �����ְ� ����ϸ� �ȴ�. 

select ename,nvl(to_char(comm),'no comm')
from emp;

102.Ŀ�̼��� null �� ����� �̸��� Ŀ�̼��� ����Ͻÿ�! is null ��� x
(�ڷῡ 0�� �־ 0�� ������ -1�� ��ü�ϱ� ����) 

select ename,comm
from emp
where nvl(comm,-1) = -1;

103.�̸�,����,����,���ʽ��� ����ϴµ� ���ʽ��� ������ SALESMAN �̸� 4500�� ����ϰ� ������ ANALYST �� 2400�� ����ϰ�
������ ������ 0 ����Ͻÿ�. 

select ename,sal,job,
decode(job,'SALESMAN',4500,
                        'ANALYST',2400,
                        0) as ���ʽ� 
                            from emp;

104.�̸�,�Ի��� �⵵ 4�ڸ��� ����Ͻÿ� 

select ename,hiredate,to_char(hiredate,'RRRR')
form emp;

105.�̸�, �Ի��� �⵵, ���ʽ���  ����ϴµ� ���ʽ���
�Ի��� 1980���̸� 5000�� ����ϰ� 1981���̸� 4000�� ����ϰ� ������ �⵵�� 0���� ����Ͻÿ� 

select ename,hiredate,to_date(hiredate,'RRRR'),
                 decode(to_date(hiredate,'RRRR'),'1981',5000,
                                                  '1980',4000,
                                                     0) as ���ʽ� 
                                                        from emp;

106.�̸�,����,���ʽ��� ����ϴµ� ���ʽ��� ������ 4000�̻��̸� 500��� 
                                        ������ 2000�̻��̸� 300 ���
                                    �ϰ� ������ ���޻������ 0�� ����Ͻÿ�  

select ename,sal,case when sal >= 4000 then 500
                             when sal>= 2000 then 300 
                              else 0 end as ���ʽ� 
                                    from emp;

107.�̸�,����,�μ���ȣ,���ʽ��� ����ϴµ� ���ʽ��� �μ���ȣ�� 10���̸�
500�� ����ϰ� �μ���ȣ�� 20���̸� 300�� ����ϰ� ������ �μ���ȣ�� 0�� ����Ͻÿ�.

select ename,sal,deptno, case when deptno = 10 then 500
                               when deptno = 20 then 300
                                 else 0 end as ���ʽ�
                                      from emp;

108.�츮�� ���̺��� �̸��� ����ϰ� �� ���� ���ʽ��� ����ϴµ� �̸��� ö�ڰ� 3�����̸� ���ʽ��� 7000�� ����ϰ�, �̸��� ö�ڰ� 2�����̸� ���ʽ��� 5000�� ���
�̸��� ö�ڰ� 4�����̸� ���ʽ��� 4000�� ���!        

select ename,case when length(ename)=4 then 4000
                 when length(ename)=3 then 7000
                  when length(ename)=2 then 5000
                                    end as ���ʽ�
                                          from emp12;

109.�̸� �����ڷθ� �̸��� ��� ���ڸ� * �� ����Ͻÿ� 

a)�̸��� ö���� ������ 3���ڿ� 2���ڴ� �Ʒ��� SQL�� ����
select ename,replace(ename,substr(ename,2,1),'*')
from emp12;
b)�̸��� ö���� ������ 4�����̸�
select replace(ename,substr(ename,-2,1),'*')
from emp12;

110.�츮�� ���̺��� �̸��� ö���� ������ ������� �ϰ������� �̸��� *�� �Ʒ��� ���� ��µǰ� �Ͻÿ� ! 

select ename,case when length(ename)=4 then replace(substr(ename,-2,1),'*')
                   when length(ename)=3 then replace(substr(ename,-2,1),'*')
                   when length(ename)=2 then replace(substr(ename,-1,1),'*') 
                                     end as ������ 
                                         from emp12;

111.emp(���)���̺��� �̸��� ����ϰ� �Ի��� ������ ����ϴµ�
             �Ի��� ������ ��ȭ��������� ������ ����Ͻÿ�
             
select ename,to_char(hiredate,'day')
    from emp
       order by replace(to_char(hiredate,'d'),1,8) asc;

112.������ SALESMAN�� ������� �ִ� ������ ����Ͻÿ� 

select max(sal)
from emp
where job='SALESMAN';

113.�츮�ݿ��� �ּ� ������ �л��� ���̸� ����Ͻÿ�.

select min(age)
from emp12;

114.��Ż簡 sk�� �л��� �߿��� �ִ� ������ �л��� ���̸� ����Ͻÿ� 

select max(age)
from emp12
where telecom like '%sk%';

115.30 �� �μ���ȣ�� �ִ������ ����Ͻÿ�

select max(sal)
from emp
where deptno=30;

116.(������ ������ ����) ����,������ �ִ������ ����ϴµ� ������ SALESMAN �� ����Ͻÿ� 

select job,max(sal)
from emp
where job='SALESMAN'
group by job;

