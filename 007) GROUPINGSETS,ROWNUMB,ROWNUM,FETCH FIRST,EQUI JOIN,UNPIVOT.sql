
�� Q-188.   ����, ������ ��Ż������ ����Ͻÿ� 

select  job,  sum(sal)
       from  emp
       group  by  job;

�� Q-189.  �׷��� ���� ����� �ٽ� ����ϴµ� �� �Ʒ��� ��ü ��Ż������
 ��µǰ��Ͻÿ� 

 select  job, sum(sal)
   from  emp
   group by rollup(job);

�� Q-190. �Ʒ��� job �Ǿƿ� null �� ������ �κп� ��Ż��: �̶�� �ѱ۷�
 null ��ſ� ��µǰ��Ͻÿ� 

JOB                  SUM(SAL)
------------------ ----------
ANALYST                6000
CLERK                    4150
MANAGER              8275
PRESIDENT             5000
SALESMAN             5600
��Ż��:                 29025

select  nvl( job, '��Ż��') , sum(sal)
        from  emp
           group  by  rollup(job);

�� Q-191. ���� ����� �ٽ� ����ϴµ� �÷����� �Ʒ��� ���� ��µǰ�
 �Ͻÿ� 

 JOB                SUM(SAL)
------------------ ----------
ANALYST                 6000
CLERK                     4150
MANAGER               8275
PRESIDENT              5000
SALESMAN              5600
��Ż��                   29025

select  nvl( job, '��Ż��') as job, sum(sal)
       from  emp
            group  by  rollup(job);

�� Q-192.  ���� ����� �ٽ� ����ϴµ� �Ʒ��� ���� ��Ż���� �κп�
 õ������ �ο��Ͻÿ� 

 JOB                SUM(SAL)
------------------ ----------            
ANALYST                 6,000
CLERK                     4,150
MANAGER               8,275
PRESIDENT              5,000
SALESMAN              5,600
��Ż��                   29,025

select  nvl( job, '��Ż��') as job, to_char(sum(sal),'999,999')
       from  emp
            group  by  rollup(job);

�� Q-193. ����, ������ ��Ż������ ����ϴµ� �� �Ʒ��� ��ü ��Ż������
 ��µǰ� �Ͻÿ� ! (grouping sets �� �̿��ؼ� ����

select  job,  sum(sal)
  from  emp
  group  by  grouping  sets(  job, () ); 

�� Q-194.  �μ���ȣ�� ������ ����ϰ� �� ���� �μ���ȣ�� ������ 
 ��Ż������ ����Ͻÿ� 

 select  deptno,  job,  sum(sal)
   from  emp
   group  by  deptno, job; 

�� Q-195. �μ���ȣ�� ������ ����ϰ� �� ���� �μ���ȣ�� ������ ��Ż����
 �� ����ϰ� ���ÿ� �μ���ȣ�� ��Ż���޵� �߰��߰� ��µǰ�
 �Ͻÿ� 

select   deptno,  job, sum(sal)
   from  emp
   group   by   grouping  sets (  (deptno, job), (deptno) );  

�� Q-196.  ���� ����� �� �Ʒ��� ��ü ��Ż������ ��µǰ��Ͻÿ�

select   deptno,  job, sum(sal)
   from  emp
   group   by   grouping  sets (  (deptno, job), (deptno), () );  

�� Q-197. �����ȣ,  ��� �̸�, ������ ����ϴµ�  �� �Ʒ��� ��ü��Ż����
 �� ����Ͻÿ� 

 select  empno, ename, sum(sal)
   from   emp
 group  by grouping sets((empno,ename),());

�� Q-198.  �츮�� ���̺��� ��Ż�, �̸�, ���̸� ����ϴµ� 
�߰��߰� ��Ż纰 ��Ż���̰� ��µǰ��Ͻÿ� 

 select telecom, ename, sum(age)
  from emp12
  group  by  grouping sets( (telecom, ename), (telecom) )

 select telecom, ename, sum(age)
  from emp12
  group  by  grouping sets( (telecom, ename), (telecom), () );

�� Q-199.  �Ի��� �⵵(4�ڸ�),  �Ի��� �⵵�� ��Ż������ ����ϴµ�
��ü ��Ż������ �� �Ʒ��� ��µǰ��Ͻÿ� 

1. rollup 

select  to_char(hiredate,'RRRR'), sum(sal)
  from  emp
  group  by  rollup( to_char(hiredate,'RRRR')  )

2. grouping sets 

select to_char(hiredate, 'RRRR'), sum(sal)
 from emp
 group by grouping sets ( to_char(hiredate, 'RRRR'), () );

�� Q-200.  ���� ����� �ٽ� ����ϴµ� �Ʒ��� ���� õ������ �ο��ؼ� ����Ͻÿ�

TO_CHAR(   SUM(SAL)
--------     ------------
1980              800
1981          22,825
1982           4,300
1983           1,100
                   29,025

select to_char(hiredate, 'RRRR'), to_char( sum(sal), '999,999') 
 from emp
 group by grouping sets ( to_char(hiredate, 'RRRR'), () );

�� Q-201.  �Ի��� �⵵(4�ڸ�), �μ���ȣ, �Ի��� �⵵�� �μ���ȣ�� 
��Ż������ ����Ͻÿ� 

select   to_char(hiredate,'RRRR'), deptno, sum(sal)
  from  emp
  group  by  to_char(hiredate,'RRRR'), deptno; 

�� Q-202. ( ���ɽð� ���� )  zoom ���� ��� �л����� ī�信 �ø���
 offline �� ī�信 �ø��� �Ļ��Ϸ� ������ ~~
 �Ի��� �⵵(4�ڸ�), �μ���ȣ, �Ի��� �⵵(4�ڸ�)�� �μ���ȣ�� ��Ż����
 �� ����ϴµ� �߰��߰� �Ի��� �⵵(4�ڸ�)�� ��Ż������ ��µǰ��ϰ�
 �� �Ʒ��� ��ü ��Ż������ ��µǰ� �Ͻÿ�! 


�� Q-203. ������ SALESMAN �� ������� �̸��� ������ ����ϴµ�
 row_number �Լ��� ����ؼ� �� �տ�  ��ȣ ���ʵ��� �ο��ǰ��Ͻÿ� !

select   row_number()  over  ( order  by  empno asc ) ��ȣ,
          ename,  job
   from   emp
   where  job='SALESMAN'; 

�� Q-204.  ������ SALESMAN �� ������� �̸��� ���ް� ������ ����ϴµ�
  �� �տ� row_number() �Լ��� �Ἥ ��ȣ�� �ο��ǰ��Ͻÿ�
  (������ ������������ ��µǸ鼭 ��ȣ�� �ο��ǰ��Ͻÿ�) 

select  row_number()  over  (order by sal desc) ��ȣ,
         ename, sal, job
  from  emp
  where  job='SALESMAN'; 

 select  *
  from  emp 
  where  rownum <= 10;  

�� Q-205.  ������ SALESMAN �� ������� �������� 2���� ����Ͻÿ� !
 ( ����̸�, ������ ������ ����Ͻÿ�)

select  rownum, ename, job, sal
  from   emp
  where  job='SALESMAN'  and  rownum <= 2;

�� Q-206.  ���� ������� �ѰǸ� ��µǰ��Ͻÿ� !

 select  rownum, ename, job, sal
   from   emp
   where  job='SALESMAN'  and  rownum = 1;

�Ʒ��� SQL�� ����� �����ϴ�. 
 select  rownum, ename, job, sal
   from   emp
   where  job='SALESMAN'  and  rownum = 2;

 select  rownum, ename, job, sal
   from   emp                                  
   where  rownum between  2 and 5;

�� Q-207.  �츮�� ���̺��� �����͸� �������µ� ���� 3�Ǹ� �����ͼ� ����Ͻÿ�!
 ( ��� �÷��� �� ���������� ~ )

select  *
  from  emp12
  where  rownum <= 3; 

�� Q-208. �츮�ݿ� ���̰� ���� ���� �л����� �̸��� ���̸� ����ϴµ� �� 5��
����Ͻÿ� 

 select   ename,  age
   from   emp12
   order  by  age  desc
   fetch  first  5 rows  only; 

�� Q-209.  ����, ������ ��Ż������ ����ϴµ�  ������ ��Ż������ �����ͺ��� ����ϰ�
 ���ʿ� 2���� �ุ ����Ͻÿ� 

select  job,  sum(sal)
  from   emp
  group  by  job 
  order  by  sum(sal)  desc
  fetch  first   2  rows  only;  

�� Q-210.  ������ SALESMAN �� ������� �̸��� ���ް� ������ �μ���ġ�� ����Ͻÿ�!

 select  ename, sal, job, loc
  from   emp,  dept 
  where emp.deptno = dept.deptno                  and  job='SALESMAN' ; 
              ��                                                                     ��                          
         �������� ( �ΰ��� ���̺��� ���� ������ �ִٶ�� ���� )   �˻����� 

�� Q-211.  ������ 2000 �̻��� ������� �̸��� ���ް� �μ���ġ�� ����Ͻÿ� !

select   ename, sal, loc
   from   emp,   dept  
  where   emp.deptno = dept.deptno  and  sal >= 2000; 

�� Q-212. ���� ������� �̸�, ����, �μ���ġ ���� �μ���ȣ�� ���� ����Ͻÿ� 

select   emp.ename, emp.sal, dept.loc, emp.deptno 
   from   emp,   dept  
  where   emp.deptno = dept.deptno  and  sal >= 2000; 

�� Q-213.  ������ 1000 ���� 3000 ������ ������� �̸��� ���ް� �μ���ġ�� ����Ͻÿ� !

select  e.ename,  e.sal,  d.loc
 from  emp  e,  dept  d
 where   e.deptno = d.deptno  and  e.sal  between  1000 and 3000;

�� Q-214.  �����ȣ�� 7788, 7902, 7369���� ����� �����ȣ�� �̸��� ���ް� �μ���ġ��
 ����Ͻÿ� 

select  e.ename, e.sal, d.loc
  from   emp   e,   dept   d
  where   e.deptno = d.deptno  and   e.empno  in  ( 7788, 7902, 7369 );

�� Q-215.  �̸��� ù��° ö�ڰ� S �� �����ϴ� ����� �̸��� ���ް� �μ���ġ��
����Ͻÿ� 

 select  e.ename, e.sal, d.loc
  from  emp  e,  dept   d
  where  e.deptno = d.deptno  and  e.ename  like  'S%';

�� Q-216. DALLAS ���� �ٹ��ϴ� ������� �̸��� ������ �μ���ġ�� ����Ͻÿ� 

 select   e.ename,  e.job,  d.loc
   from   emp  e,  dept   d
   where   e.deptno = d.deptno  and  d.loc='DALLAS';

�� Q-217.   �μ���ġ,  �μ���ġ�� ��Ż������ ����Ͻÿ� 

  select  d.loc,  sum(e.sal)
     from   emp  e,  dept   d
     where  e.deptno = d.deptno  
     group  by  d.loc; 

�� Q-218. (������ ������ ����)  ��۷� �˻� �������� ~~

 �μ���ġ, �μ���ġ�� ��տ����� ����ϴµ� �Ҽ��� ���ϴ� �ȳ����� �ݿø��� �ϰ�
 �μ���ġ�� ��տ����� �����ͺ��� ����ϰ� �μ���ġ�� ��տ����� ��µɶ���
 õ������ �ο��Ͻÿ� ~
 NOTEBOOK �� ���ʿ� �̱� �����̼� ��ũ�� �ѷ����� �ʾƵ� �˴ϴ�. 
