
�� Q-69.��� ���̺��� �̸��� ����ϰ� �� ���� �̸��� ��ö�ڸ� ����ϴµ� �� ö�ڸ� �ҹ��ڷ� ����Ͻÿ�

select ename,upper(substr(ename,-1,1))
from emp12;

�� Q-71.��� ���̺��� �̸� ������ ����ϴµ�, ������ ����Ҷ� ���� 0�� *�� ����Ͻÿ� 
select ename,replace(sal,0,'*')
from emp;

�� Q-72.�츮�� ���̺��� �̸��� ����ϰ� �׿��� �̸��� �ι�° ö�ڸ� ����Ͻÿ�! 

select substr(ename,2,1)
from emp12;

�� Q-73.�ƻ꺴���� �������� �����Ͻÿ�! (��*��,��*â)

select ename,replace(ename,substr(ename,2,1),'*')
from emp12;

�� Q-74.���üֹ� �����͸� ���ϰ� ����*�̷� ��µǰ� ���� SQL�� �ٽ� �ۼ��Ͻÿ� (73����)

select ename,replace(ename,substr(ename,-2,1),'*')
from emp12;

�� Q-75.��⵵�� ��� �л����� �̸��� �ּҸ� ����Ͻÿ� ! ���ϵ� ī�带 ���ʿ� ������� 
���� ���ʿ��� ����ؼ� ����Ͻÿ�. 

select ename,address
from emp12
where ltrim(address) like '��⵵%';

�� Q-76.��������а��� ������ �л��� �̸��� ���̿� ������ ����Ͻÿ�. 

select ename,age,major
from emp12
where trim(major) like '%��������а�%';

�� Q-77.�츮�� ������ ��հ��� ����Ͻÿ�. avg(age)

select avg(age)
from emp12;

�� Q-78.���� ����� �ݿø��ؼ� �Ҽ��� ���Ĵ� �ȳ����� �Ͻÿ�.
select round(avg(age),0) / �ƴϸ� �׳� �ݱ�.
from emp12;

�� Q-78.�츮�ݿ��� ���̰� ¦���� �л����� �̸��� ���̸� ����Ͻÿ� 

select ename,age,mod(age,2) 
from emp12
where mod(age,2)=0;

�� Q-80.select ename,sysdate-hiredate from emp; �̰������ �Ҽ��� ���ϴ� �ȳ�����
 �ݿø��Ͻÿ�.

select ename,round(sysdate-hiredate,0)
from emp

�� Q-81.�̸�,�Ի��� ��¥���� ���ñ��� �� ���� �ٹ��ߴ��� ����Ͻÿ� 

select ename,round(round(sysdate-hiredate,0)/7,0)
from emp;

�� Q-82.�̸�,�Ի��� ��¥���� ���ñ��� �� �� �� ���ߴ��� ����Ͻÿ� 

select ename, round(months_between(sysdate,hiredate))
  from emp;

�� Q-83. King�� 467���� �ٹ��߽��ϴ�. 

select ename||'��'||round(months_between(sysdate,hiredate))||'���� �ٹ��߽��ϴ�'
  from emp;

�� Q-84.���� ��¥���� 100�� �ڿ� ���ƿ��� ������� ��¥�� ����Ͻÿ�. 

select next_day(add_months(sysdate,100),'�����')
from dual;

�� Q-85.81/11/17 �Ͽ� �Ի��� ����� �̸��� �Ի����� ����Ͻÿ� .

select ename,hiredate
from emp
where hiredate='81/11/17';

�� Q-86.�̸�,�Ի���,�Ի��� ������ ����Ͻÿ�! 

select ename,hiredate,to_char(hiredate,'day')
from emp;

�� Q-87.�����Ͽ� �Ի��� ������� �̸��� �Ի����� ����Ͻÿ�.

select ename,hiredate,to_char(hiredate,'day')
from emp
where to_char(hiredate,'day') = '������'

�� Q-88.���� ���� ���Ͽ� �¾���� Ȯ���Ͻÿ�. (to_date�� ��ȯ�ϴ� ����� �˾ƾ���.)

select to_char(to_date('92/01/14','RR/MM/DD'),'day')
from dual;

�� Q-89.ī�信 ��۷� �ø�����~
�̸�,�Ի��� ������ ����ϴµ� 
�Ի��� ������ �Ͽ�ȭ������� ������ 

�� Q-90.���������� �̸����� ����ϰ� �� ���� �̸����� �������� ����Ͻÿ�. ex) gmail,naver 
select substr(email,instr(email,'@')+1, instr(email,'.'))
                 from emp12; 
