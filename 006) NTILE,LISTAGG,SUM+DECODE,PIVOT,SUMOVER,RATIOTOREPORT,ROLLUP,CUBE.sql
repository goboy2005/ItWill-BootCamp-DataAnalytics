*������ �м� �Լ� 

  ȸ���� ���� �ý����� ���� ( ������ ���� �κп� ���� ������ ����)

������ ���� ������
                                                           
           OLTP   ����                            DW  ���� 
             ��                                           �� 
   OnLine  Transaction processing         DataWare  house 
       
  �ǽð����� ������ �����͵��� ����       ���� �̷� ������

  ��: ���� �� ���� ���� �ܰ� ������   ��:  10���� ���� �� ���� �ܰ�
                                                           ������
                                                             ��
                                                        ������ �м��Լ� 

160.�̸�, �Ի���,  ������ ����ϴµ� ������
���� �Ի��� ��������� ������ �ο��Ͻÿ� ~

select  ename, hiredate,  
         rank()  over  ( order  by  hiredate  asc )  ����
   from   emp;

161. ����, �̸�, �Ի���, ������ ����ϴµ� ������
 �������� ���� ���� �Ի��� ��������� ������ �ο��Ͻÿ�

select  job, ename, hiredate,  
         rank()  over  ( partition  by  job
                            order  by  hiredate  asc )  ����
   from   emp;

162.  �̸�, ����, ������ ����ϴµ� ������ ������ ���� ����
 ���� ������ �ο��Ͻÿ� !

 select  ename, sal, dense_rank()  over ( order  by sal  desc )  ����
    from  emp;

163.  ������ 2975�� ������ �����ΰ� ?  

select   dense_rank(2975)  within  group ( order  by sal desc ) ����
   from   emp;

����:  within ~�̳��� 
        ������ ������������ ������ �׷� �ȿ��� 2975�� ������ ����
         �ΰ� ?

164.�츮�ݿ��� 34 ������ ������ ����Ͻÿ� !

 select   dense_rank(34)  within  group ( order  by age desc ) ����
   from  emp12;

165. 81�� 11�� 17�Ͽ� �Ի��� ����� ��� ���̺��� ���°��
 �Ի��� ����ΰ� ?

 select   
   dense_rank(to_date('81/11/17','RR/MM/DD')) 
                            within group (order by hiredate asc) ����
      from emp;


�� 043 ������ �м� �Լ��� ��� ����ϱ�(NTILE)

  " ����� ����ϴ� �Լ� "

����:  select  ename, sal, ntile(4)  over  ( order  by sal desc)  ���
           from  emp;

����:  ������ ���� ������ ������ �����͸� 4������� �����ڴ�. 

 0 ~ 25% 1��� 
25~ 50% 2���
50 ~ 75% 3���
75 ~ 100% 4��� 

166.�̸�, ����, ����� ����ϴµ� ����� 7������� ������
����Ͻÿ� (���̰� ���� �������� ����� �����ÿ�)

 select  ename, age,  ntile(7)  over  ( order  by  age  desc) ���
    from   emp12;

167.����, �̸�, ����, ����� ����ϴµ� ������ ����
 ����� 3������� �������� �Ͻÿ� !
              (����� ������ ���� ���������� ����Դϴ�.)

select  job, ename, sal,  ntile(3)  over ( partition by job 
                                                   order  by  sal  desc ) ���
    from  emp;

�� 044 ������ �м� �Լ��� ������ ���� ����ϱ�(CUME_DIST)

" ������ ���� ������ ����ϴ� ������ �м��Լ� " 

����)
select  ename, sal,  
           cume_dist()  over ( order  by  sal  desc ) ����
                from  emp;

KING	5000	0.0714285714285714285714285714285714285714
SCOTT	3000	0.2142857142857142857142857142857142857143
FORD	3000	0.2142857142857142857142857142857142857143
JONES	2975	0.2857142857142857142857142857142857142857
  :            :              : 

168.���� ������� �Ҽ��� ����°������ ��µǰڱ� 
�ݿø��Ͻÿ�

KING	5000	0.071
SCOTT	3000	0.214
  :            :             : 

select  ename, sal,  
        round( cume_dist()  over ( order  by  sal  desc ),3 ) as  ����
           from  emp;

�� 045 ������ �м� �Լ��� �����͸� ���η� ����ϱ�(LISTAGG)

 " �����͸� ���η� ����ϴ� �Լ� " 

����)
 select  deptno,  
     listagg(ename, ', ' )  within  group  ( order by  ename asc ) �̸�
   from   emp
   group  by  deptno; 

����: �̸��� ���η� ����ϴµ� �޸�(,) �� �����ؼ� ����ϰڴ�.
         �̸��� abcd  ������ ���ĵǾ ��µǰ� �ִ�. 
         listagg �� �ٸ� �м��Լ��ʹ� �ٸ��� group by ���� �ʿ��ϴ�.

10	CLARK,KING,MILLER
20	ADAMS,FORD,JONES,SCOTT,SMITH
30	ALLEN,BLAKE,JAMES,MARTIN,TURNER,WARD

169.����, �������� �ش��ϴ� ������� �̸��� ���η� ����Ͻÿ�

select  job,  
     listagg(ename, ',')  within  group ( order  by  ename asc) �̸�
  from  emp
  group  by job; 

170.�Ʒ��� ���� ����� ����Ͻÿ� !
ANALYST    	FORD(3000), SCOTT(3000)
CLERK	             ADAMS(1100), JAMES(950), MILLER, SMITH
MANAGER	BLAKE, CLARK, JONES
PRESIDENT	KING
SALESMAN	ALLEN, MARTIN, TURNER, WARD

select job,  
 listagg(ename || '(' || sal || ')' , ',') within group (order by ename asc) �̸� 
   from emp 
   group by job;  

171.����, ���̺��� �ش��ϴ� �л����� �̸��� ���η� 
 ����Ͻÿ�

select  age, 
 listagg(ename,',') within group ( order  by  ename  asc )  �̸�
  from   emp12
  group by age;

172-1. * ���ɽð� ���� Ǯ�� ���� ��Ż� skt �� SK ��  sk �� �����ϼ���.
             
update   emp12
  set  telecom ='sk'
  where  telecom  in ('skt', 'SK'); 

           commit;

select  telecom  from  emp12;

172-2.(���ɽð� ����)
 ��Ż縦 ����ϰ� ��Ż纰�� �ش� �ϴ� �л����� �̸��� ���
 �ϴµ� �̸� ���� ���̵� ���� ��µǰ� �ϰ� ���̰� ���� �л�����
 �� ��µǰ��Ͻÿ� !
kt    �Ѱ�(31), ��Ҷ�(29), ..............
lg    ���ֿ�(44), ������(28), ...........
sk    �Ǽ���(36), ������(35), ..............

select telecom,
          listagg(ename || '(' || age || ')' , ',') within group ( order by age desc) �̸�
                  from emp12
                     group by telecom;

�� 046 ������ �м� �Լ��� �ٷ� �� ��� ���� �� ����ϱ�
          (LAG, LEAD)

  "�ٷ� ������ ���� ������ �ϰų� �ٷ� �������� ���� ������
   �� �� ����ϴ� �Լ� "

��:  select  ename, sal,  lag(sal,1)  over ( order by sal asc) as  ����,
                          lead(sal,1)  over  ( order  by sal asc) as  ������
        from   emp; 

ENAME   SAL         ����     ������ 
SMITH	800		950
JAMES	950	800	1100
ADAMS	1100	950	1250
WARD	1250	1100	1250
MARTIN	1250	1250	1300
MILLER	1300	1250	1500

173.�̸�, �Ի���, �ٷ� ���� �Ի��� ����� �Ի���,
 �ٷ� ������ �Ի��� ����� �Ի�����  
 ����Ͻÿ� !

select  ename, hiredate,  
  lag(hiredate,1) over ( order by hiredate asc)   ����,
lead(hiredate,1) over ( order  by hiredate  asc ) ������
 from  emp;

�� 047 COLUMN�� ROW�� ����ϱ� 1(SUM+DECODE)

  ȸ�翡�� �����͸� �����ϴ� ���� ���� 2����

    OLTP  ����                                  DW ���� 
                                                       ��
                                                  �÷��� �ο�� ����ϴ� sum+decode 
����)
�μ���ȣ, �μ���ȣ�� ��Ż������ ����Ͻÿ� 

 select  deptno,  sum(sal)
  from  emp
  group  by  deptno; 

1.���� ��� :
 DEPTNO    SUM(SAL)   <--- �÷���
  10             8750  
  20            10870
  30             9400

2.���� ��� :

    10       20      30   <--- �÷���
  8750   10870  9400   <--- ������

����2)
�μ���ȣ,  �μ���ȣ�� 10���̸� ������ ��µǰ��ϰ� �ƴϸ� 0 �� ��µǰ�
 �Ͻÿ�

select  deptno,  decode( deptno, 10, sal , 0  )  
   from   emp;

 DEPTNO     DECODE( DEPTNO, 10, SAL, 0 )   <--- �÷��� 
   10                   1400
   20                       0
   20                       0
   10                    3000
   30                       0
    :                         :

����3)
���� ������� �μ���ȣ �÷��� �ȳ������Ͻÿ� !

select  decode( deptno, 10, sal , 0  )  
   from   emp;

DECODE( DEPTNO, 10, SAL, 0 )   <--- �÷��� 
 1400
   0
   0
  3000
   0
   : 

����)
������ ��µ� 14���� �����͸� �� SUM �Ͻÿ� ! 

select  sum( decode( deptno, 10, sal , 0  )  ) 
   from   emp;

SUM(DECODE( DEPTNO, 10, SAL, 0 ))   <--- �÷��� 
    8750

����5)
���� �÷����� �÷� ��Ī�� �Ἥ  ���� 10���� �����Ͻÿ� 

  10  <--- �÷��� 
 8750 

select  sum( decode( deptno, 10, sal , 0  )  )  as  "10"
   from   emp;

* ����Ŭ���� ���� �����̼� ��ũ�� ����ؾ��ϴ� ���

 �÷� ��Ī ����Ҷ� Ư������, ���鹮��, ��ҹ��� ����, ���ڸ� ����Ҷ�

select  sum( decode( deptno, 10, sal , 0  )  )  as  "10"
   from   emp;

  10  <--- �÷��� 
 8750 

����6)
���� �Ʒ��� ���� 20���� 30���� �� ���� ����Ͻÿ� !

    10       20      30   <--- �÷���
  8750   10870  9400   <--- ������

select  sum( decode( deptno, 10, sal , 0  )  )  as  "10",
         sum( decode( deptno, 20, sal , 0  )  )  as  "20",
         sum( decode( deptno, 30, sal , 0  )  )  as  "30"
   from   emp;

    10       20      30   <--- �÷���
  8750   10870  9400   <--- ������

174.��Ż�, ��Ż纰 ��Ż���̸� ����Ͻÿ� (�������)

select  telecom,  sum(age)
    from  emp
        group  by  telecom; 

����175. �̹����� �Ʒ��� ���� ���η� ����Ͻÿ� ! 
   sk     lg    kt
  322   126  411 

select  sum( decode( telecom, 'sk', age, 0  )  )  as  "sk",
         sum( decode( telecom, 'lg', age, 0  )  )  as  "lg",
         sum( decode( telecom, 'kt', age, 0  )  )  as  "kt"
               from   emp12;

176.�Ʒ��� SQL �ΰ��� ����� ������?

 " �׷��Լ��� null ���� �����Ѵ� "

 select   sum(comm)  from  emp;  --->  null ���� �ƴ� 4�Ǹ� �� ���ߴ�. 
  2200

 select   sum( nvl(comm,0) ) from  emp; --> null �� 0���� �����ϰ� 
  2200                                                sum �Ҷ� 0 �� ���꿡 ���Խ��״�

����: ���� SQL �� �� ������ ����.  �ֳĸ� null ���� sum ���꿡 ���Ե���
       �ʱ� �����̴�. 

177.�Ʒ��� SQL �� Ʃ���Ͻÿ� !  ��1200 ���� ~  2400 ����
Ʃ����:
select  sum( decode( telecom, 'sk', age, 0  )  )  as  "sk",
         sum( decode( telecom, 'lg', age, 0  )  )  as  "lg",
         sum( decode( telecom, 'kt', age, 0  )  )  as  "kt"
   from   emp12;

Ʃ����: 
select  sum( decode( telecom, 'sk', age )  )  as  "sk",
         sum( decode( telecom, 'lg', age,  null  )  )  as  "lg",
         sum( decode( telecom, 'kt', age,  null )  )  as  "kt"
   from   emp12;

   select  decode( telecom, 'sk', age,  null  ) 
   from  emp;

178.����, ������ ��Ż������ ����Ͻÿ� (���η� ���) 

select  job,  sum(sal)
  from  emp
  group  by  job;

179.  ����, ������ ��Ż������ ����Ͻÿ� (���η� ���)

 select   sum(decode( job, 'ANALYST', sal, null)) as  "ANALYST",
           sum(decode( job, 'CLERK', sal, null))  as  "CLERK",
           sum(decode( job, 'MANAGER', sal, null))  as  "MANAGER",
           sum(decode( job, 'PRESIDENT', sal, null))  as  "PRESIDENT",
           sum(decode( job, 'SALESMAN', sal, null))  as  "SALESMAN"
 from  emp; 

�� 048 COLUMN�� ROW�� ����ϱ� 2(PIVOT)

  " ���θ� ���η� ����ϴ� �Լ� "

��)
select   *       <-- pivot �� ����� ���� �׳� * �� ����. 
        from  ( select  deptno, sal  from  emp )  <-- ��� ���̺��� �׳� 
                      �μ���ȣ�� ���޸� �����´�.  emp ���̺�� �� ���� ����.
            ����� �������ؼ� �ʿ��� �÷��� �����ؼ� �����;� �˴ϴ�. 
             emp ���̺�� ���� ������ ���ϴ�. 
           �Ʒ��� ����� �������ؼ� ������ �ʿ������� �ʰ� �Ի����� �ʿ�����
            �� �ʽ��ϴ�. �׳� �μ���ȣ�ϰ� ���޸� ������ �˴ϴ�. 
        pivot   (  sum(sal)  for  deptno  in ( 10, 20, 30 )  )  ;
                       ��        
                    ��Ż������ ����ϰڴ�. � ��Ż����?  �μ���ȣ�� ���� 
                    � �μ���ȣ ?  10��, 20��, 30���� �μ���ȣ 

    10       20      30   <--- �÷���
  8750   10870  9400   <--- ������

180.��Ż�, ��Ż纰 ��Ż���̸� ���η� ����Ͻÿ� (pivot������)
   sk     lg    kt
  322   126  411 

select   *
  from  ( select   telecom,  age  from   emp12 )  ����� �׷��Լ��� ���� �ʴ´�.
  pivot  ( sum(age)  for  telecom  in ('sk' as  "sk", 
                                                'lg' as  "lg",
                                                'kt' as  "kt" )  ) ; 

181. ���� ����� ��Ż���̰� �ƴ϶� ��ճ��̷� ������ �Ͻÿ� !

select   *
  from  ( select   telecom,  age  from   emp12 )  
  pivot  ( avg(age)  for  telecom  in ('sk' as  "sk", 
                                                'lg' as  "lg",
                                                'kt' as  "kt" )  ) ; 

�� 050 ������ �м� �Լ��� ���� ������ ����ϱ�(SUM OVER)

  " �����͸� �����ؼ� �հ��ϴ� ������ �м� �Լ� "

����)
�����ȣ, �̸�, ����, ������ ����ġ�� ����Ͻÿ� ! 

select   empno, ename, sal,  sum(sal)  over ( order  by  empno  asc) ����ġ
    from   emp; 

182.�̸�, ����, ������ ����ġ�� ����Ͻÿ� 

select  ename, age,  sum(age)  over ( order  by  ename  asc ) ����ġ
   from   emp12;

183.����, �̸�, ����, ������ ����ġ�� ����ϴµ� �������� ���� 
             ������ ����ġ�� ��µǰ��Ͻÿ� !

select  job,  ename, sal,  sum(sal)  over  (  partition  by  job 
                                                       order  by  sal  asc  )  ����ġ
   from   emp;

 ANALYST                   3000   6000
 ANALYST                   3000   6000

184.��Ż�, �̸�, ����,  ������ ����ġ�� ����ϴµ�  ������ ����ġ��
��Ż纰�� ���� �����Ǿ ��µǰ��Ͻÿ� !

select  telecom,  ename,  age,  sum(age)  over ( partition  by  telecom
                                                               order  by  age  asc ) ����ġ
    from  emp12;

�� 051 ������ �м� �Լ��� ���� ����ϱ�(RATIO_TO_REPORT)

   �ڱ��� ������ ��ü �����߿����� ������ ��� �Ǵ��� Ȯ���ϴ� �Լ� 

 ����)
 select   ename, sal, round( ratio_to_report(sal)  over() ,2 )   as  ����
            from   emp
            where  job='SALESMAN' ;

�� 052 ������ �м� �Լ��� ���� ��� ����ϱ� 1(ROLLUP)

 " ������ ����� �� �Ʒ��ʿ� ����ϰ� ���� �� ����ϴ� �Լ� "

����)
�μ���ȣ, �μ���ȣ�� ��Ż������ ����Ͻÿ� !( ���� ���) 

 select  deptno, sum(sal)
  from  emp
   group  by   rollup(deptno); 


  �� �Ʒ��� �հ谡 ��µȴ�. 

����)
����, ������ ��Ż������ ����Ͻÿ� (���� ���)

 select  job,  sum(sal)
  from  emp
  group  by  job; 

����)
���� ������� ������ ��Ż������ �հ踦 �ǾƷ��� ����Ͻÿ� !

 select  job,  sum(sal)
  from  emp
  group  by  rollup( job ) ; 

�� 053 ������ �м� �Լ��� ���� ��� ����ϱ� 2(CUBE)

 " ���� ����� ���ʿ� ����ϴ� �Լ� "

����)
select   job,  sum(sal)
          from  emp
         group  by  cube( job );

185.��Ż�, ��Ż纰 ��Ż���̸� ����ϴµ� ������ ��ü ��Ż���̰� ��µǰ��Ͻÿ�

 select   telecom,  sum(age)
   from  emp12
   group  by  cube(telecom) ;

186.�Ի��� �⵵(4�ڸ�), �Ի��� �⵵�� ��Ż������ ����ϴµ� �� ���� ��ü��Ż������
����Ͻÿ� !

 select   telecom,  sum(age)
   from  emp12
       group  by  cube(telecom) ;

187.(������ ������ ����) ��۷� �ø����� ~  
  �Ի��� �⵵(4�ڸ�), �Ի��� �⵵�� ��Ż������ ����Ͻÿ� ! 
 1. ���� ���
 2. ���� ���( sum + decode ���) 

1.select to_char(hiredate,'RRRR'), sum(sal)
      from emp
      group by to_char(hiredate,'RRRR');

2.select sum(decode(to_char(hiredate,'RRRR'),'1980',sal,null)) as "1980",
           sum(decode(to_char(hiredate,'RRRR'),'1981',sal,null)) as "1981",
           sum(decode(to_char(hiredate,'RRRR'),'1982',sal,null)) as "1982",
           sum(decode(to_char(hiredate,'RRRR'),'1983',sal,null)) as "1983"
                 from emp;
                 