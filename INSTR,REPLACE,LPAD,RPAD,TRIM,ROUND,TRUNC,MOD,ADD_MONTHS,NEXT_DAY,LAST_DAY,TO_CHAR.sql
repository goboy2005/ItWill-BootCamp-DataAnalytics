019 �ڿ��� Ư�� ö���� ��ġ ����ϱ�(INSTR)

���� : Ư�� ö���� �ڸ����� ����ϴ� �Լ�
����:instr('smith','m')  --- ���⿡ +,- ����?  
 
����) 
select instr('smith','m')
from dual; --- (dual ����� ������ Į���� �ƴ� Ư������ smith �� ����߱⶧���̴�)

����)
�츮�� ���̺� �̸����� ����ϰ� �׿��� �̸��Ͽ��� @�� ����� �ڸ��� �ִ��� ����Ͻÿ� 
select email,instr(email,'@')
from emp12;
����)
�츮�� ���̺��� �̸��Ͽ��� @ �տ������� ö�ڸ� �߶󳻽ÿ�
pumadd1277@gmail.com ------ pumadd1277  �̷�������

select substr(email,1,instr(email,'@')-1)
from emp12;

����: select replace('smith','m','k')
from dual; 

020 Ư�� ö�ڸ� �ٸ� ö�ڷ� �����ϱ� (REPLACE)

 " Ư�� ö�ڸ� �ٸ� ö�ڷ� �����ϴ� �Լ�"

����)
select  replace('smith', 'm', 'k')
          from   dual;

select  replace('smith', 'm', 'k')
 from  dual; 

select ename,  replace(sal, 0, '*')
  from  emp;

����:replace(�÷���, ��ü�� ����, ��ü�� ����)

 select ename,
      replace(ename, substr(ename, -2, 1), '*' )
	       from emp12;

021 Ư�� ö�ڸ� N�� ��ŭ ä���(LPAD, RPAD)
����: �׻� ������ �ڸ����� �����ϱ� ���� �ʿ��� �Լ� 
����: lpad(�÷���,��ü�ڸ���,ä��������)
	- �÷� left �ʿ� ä���־ ��ü�ڸ��� 10���� ������̴�. �ٵ� ä����������  

select sal, lpad(sal,10,'*')
from emp;

022 Ư�� ö�� �߶󳻱�(TRIM, RTRIM, LTRIM)

���� : ������ �߶󳾶� ���� ����ϴ� �Լ�
���� : �÷�(trim) , adress(rtrim), name(ltrim) 

���� ������ ������ �˻��� �ȴ´� ��찡 ���� �ֱ� ������ trim�Լ��� ���� ����մϴ�.

Rtrim : ���ʿ� �ִ� ������ �߶�����ڴ�.
rtrim : �����ʿ� �ִ� ������ �߶�����ڴ�.
trim : ���ʿ� �� ������ �߶�����ڴ�. 

1.�⺻ Selecrt �� 
      select  �÷���
        from ���̺��
           where �˻�����
              order by ������ �÷��� 

2.�Լ�  
    ������ �Լ� : ����,����,��¥,��ȯ,�Ϲ�
    ������ �Լ� :  max,min,avg,sum,count 


?   023 �ݿø��ؼ� ����ϱ�(ROUND)            

����)
select   round( 786.567,  -1 )
           from   dual; 

     7  8   6   .   5  6  7  
    -3 -2  -1  0  1  2  3
           
   790

����: �Ҽ��� ������ �ٷ� �� �ڸ����� �ݿø��Ѵ�. 

����)
�츮�� ������ ��հ��� ����Ͻÿ� ! (�ݿø��ؼ�) 

select    round( avg(age), 0 ) 
   from   emp12;		

024 ���ڸ� ������ ����ϱ�(TRUNC)
���� �Լ� 
   1. round : �ݿø��ϴ� �Լ�
   2. trunc : �߶󳻼� ������ �Լ�
   3.mod : ���� ���������� ����ϴ� �Լ� 

����: round(786.567,2) 
    
����)
select round(786.567,2) 
    from dual;   
����: �Ҽ��� ���� �ι�° �ڸ��� �������� �ΰ� �ڿ��� �ݿø��Ѵ�. 
      dual ���� ������ Ư�������� �������°�, �÷��̸� 14�� �� ������. 
@�Ҽ��� ������ �ٷ� ���ڸ����� �ݿø��Ѵ�.  �Ҽ��� ���Ŀ� �ٸ�.
@ truncate -1�� �ΰ� ������ ���ڸ��� ����� 0���� �ٲ�� ���ܵ�. 

����:trunc�� ������ �Լ��ε� �Ҽ��� ������ ������ �ڸ��� �����ؼ� ������ �Ҽ��� ���Ĵ� ������ �ڸ� ���ĺ��� ������. 

7 8 6   .  5 6 7 
-3-2-1 0 1 2 3 
0 = ��ġ�� . �̴� 

025 ���� ������ �� ����ϱ�(MOD)

����)
select mod(10,3)
    from dual; 

���̰� ¦������ Ȧ������ �����Ҷ� ����Ѵ�.    mod(8,2) mod(7,2) 

026 ��¥ �� ���� �� ����ϱ�(MONTHS_BETWEEN)

��¥ - ���� =��¥
��¥+���� = ��¥
��¥ -��¥ = ���� 

���� ��¥�� Ȯ���ϴ� ��� 
select sysdate / +1 �ϸ� ���� , -1 �ϸ� ���� 
from dual;

��¥���� ��¥�� ���°�� 
select ename,sysdate-hiredate
from emp;

����: months_between(sysdate,hiredate), ---�ֽų�¥,������¥


��¥�� ��¥ ������ �������� ��� 
--- ��¥�Լ� ----

1.month_between
2.add_months
3.next_day
4.last_day

027 ���� �� ���� ��¥ ����ϱ� (ADD_MONTHS)

���ú��� 100�� �ڿ� ���ƿ��� ��¥�� �����ΰ�. 
���� : add_months(sysdate,100) 
from dual;


028 Ư�� ��¥ �ڿ� ���� ���� ��¥ ����ϱ� (NEXT_DAY)

����:  next_day(sysdate,'������')
Ư�� ��¥ �ڿ� ���� ���ϳ�¥ ����ϱ� 
���� : ���ú��� ������ �ٷ� ���ƿ� �������� ��¥�� ����Ͻÿ�! 
select next_day(sysdate,'������') 
from dual; 

029 Ư�� ��¥�� �ִ� ���� ������ ��¥ ����ϱ� (LAST_DAY)
 
���� : select sysdate,last_day(sysdate)
            from dual;

�Լ� 
1.������ �Լ� : �����Լ�,   �����Լ�,          ��¥�Լ�,                ��ȯ�Լ�,�Ϲ��Լ� 
                     upper       round         months_between
                     lower        trunc             add_months 
                    initcap        mod               next_day
                     subsrt                            
                     instr
                     replace                 
                    lpad/rpad
                    trim/rtrim/ltrim
     
030 ���������� ������ ���� ��ȯ�ϱ� (TO_CHAR)

���� : ������ �����͸� ������ �����ͷ� ��ȯ�ϴ°� 

����: to_char(sysdate,'day')
'day' �� ������ ����ϰ� ���ִ°�
'sysdate' �� ���� ������ ��¥. 
��: ������ ���� �������� ����ϰ� �ʹٸ� select  to_char(sysdate,'day')
                                                           from dual;

����: to_date �Լ��� ��¥�� ��ȯ���־�� �մϴ�.)

                                   ���� ���� ������ ������ ��¥ ������ Ȯ�� 
                                    select*
                               from nls_session_parameters; ---National Language Support
                                nls_date_fromat 


*�̱��� ����Ŭ ȯ������ ��¥ ������ �����غ���. 
alter session set nls_date_format = 'RR/MM/DD';

�⵵ : RRRR.,YYYY,RR,YY
�� : MM,MON
�� : DD 
�ð� : HH,HH24 
�� : MI
�� : SS 
���� : day, dy, d 

select ename,hiredate, to_char(hiredate, 'day') =������ 
                              to_char(hiredate, 'dy') = ��
                              to_char(hiredate,'d') =����
 
      RR                                                 VS                                   YY 

      81                                                                                       81
1981  2081                                                                            1981     2081 
    2020 
���翬������ ����                                                                 YY �� ���� ����� �ν�   
����� ������ ����


69.��� ���̺��� �̸��� ����ϰ� �� ���� �̸��� ��ö�ڸ� ����ϴµ� �� ö�ڸ� �ҹ��ڷ� ����Ͻÿ�

select ename,upper(substr(ename,-1,1))
from emp12;
 
71.��� ���̺��� �̸� ������ ����ϴµ�, ������ ����Ҷ� ���� 0�� *�� ����Ͻÿ� 

select ename,replace(sal,0,'*')
from emp;

72.�츮�� ���̺��� �̸��� ����ϰ� �׿��� �̸��� �ι�° ö�ڸ� ����Ͻÿ�! 

select substr(ename,2,1)
from emp12;

73.�ƻ꺴���� �������� �����Ͻÿ�! (��*��,��*â)

select ename,replace(ename,substr(ename,2,1),'*')
from emp12;

74.���üֹ� �����͸� ���ϰ� ����*�̷� ��µǰ� ���� SQL�� �ٽ� �ۼ��Ͻÿ� (73����)

select ename,replace(ename,substr(ename,-2,1),'*')
from emp12;

75.��⵵�� ��� �л����� �̸��� �ּҸ� ����Ͻÿ� ! ���ϵ� ī�带 ���ʿ� ������� 
���� ���ʿ��� ����ؼ� ����Ͻÿ�

select ename,address
from emp12
where ltrim(address) like '��⵵%';

76.��������а��� ������ �л��� �̸��� ���̿� ������ ����Ͻÿ�

select ename,age,major
from emp12
where trim(major) like '%��������а�%';

77.�츮�� ������ ��հ��� ����Ͻÿ� avg(age)

select avg(age)
from emp12;

78.���� ����� �ݿø��ؼ� �Ҽ��� ���Ĵ� �ȳ����� �Ͻÿ�

select round(avg(age),0) / �ƴϸ� �׳� �ݱ�.
from emp12;

78.�츮�ݿ��� ���̰� ¦���� �л����� �̸��� ���̸� ����Ͻÿ� 

select ename,age,mod(age,2) 
from emp12
where mod(age,2)=0;

80.select ename,sysdate-hiredate from emp; �̰������ �Ҽ��� ���ϴ� �ȳ����� �ݿø��Ͻÿ�

select ename,round(sysdate-hiredate,0)
from emp;

81.�̸�,�Ի��� ��¥���� ���ñ��� �� ���� �ٹ��ߴ��� ����Ͻÿ� 

select ename,round(round(sysdate-hiredate,0)/7,0)
from emp;

82.�̸�,�Ի��� ��¥���� ���ñ��� �� �� �� ���ߴ��� ����Ͻÿ� 
select ename, round(months_between(sysdate,hiredate))
  from emp;

83. King�� 467���� �ٹ��߽��ϴ� 

select ename||'��'||round(months_between(sysdate,hiredate))||'���� �ٹ��߽��ϴ�'
  from emp;

84.���� ��¥���� 100�� �ڿ� ���ƿ��� ������� ��¥�� ����Ͻÿ�
select next_day(add_months(sysdate,100),'�����')
from dual;

85.81/11/17 �Ͽ� �Ի��� ����� �̸��� �Ի����� ����Ͻÿ� .
select ename,hiredate
from emp
where hiredate='81/11/17';

86.�̸�,�Ի���,�Ի��� ������ ����Ͻÿ�

select ename,hiredate,to_char(hiredate,'day')
from emp;

87.�����Ͽ� �Ի��� ������� �̸��� �Ի����� ����Ͻÿ�.

select ename,hiredate,to_char(hiredate,'day')
from emp
where to_char(hiredate,'day') = '������'

88.���� ���� ���Ͽ� �¾���� Ȯ���Ͻÿ�. (to_date�� ��ȯ�ϴ� ����� �˾ƾ���.)

select to_char(to_date('92/01/14','RR/MM/DD'),'day')
from dual;

89.ī�信 ��۷� �ø�����~
�̸�,�Ի��� ������ ����ϴµ� 
�Ի��� ������ �Ͽ�ȭ������� ������ 

90.���������� �̸����� ����ϰ� �� ���� �̸����� �������� ����Ͻÿ� ex) gmail,naver 

select substr(email,instr(email,'@')+1, instr(email,'.'))
                 from emp12; 