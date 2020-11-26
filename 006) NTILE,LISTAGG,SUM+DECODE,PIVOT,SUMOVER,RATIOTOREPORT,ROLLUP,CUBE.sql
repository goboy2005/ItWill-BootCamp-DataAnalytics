
�� Q-160.  �̸�, �Ի���,  ������ ����ϴµ� ������
���� �Ի��� ��������� ������ �ο��Ͻÿ� ~

select  ename, hiredate,  
         rank()  over  ( order  by  hiredate  asc )  ����
   from   emp;

�� Q-161. ����, �̸�, �Ի���, ������ ����ϴµ� ������
 �������� ���� ���� �Ի��� ��������� ������ �ο��Ͻÿ�

select  job, ename, hiredate,  
         rank()  over  ( partition  by  job
                            order  by  hiredate  asc )  ����
   from   emp;

�� Q-162.  �̸�, ����, ������ ����ϴµ� ������ ������ ���� ����
 ���� ������ �ο��Ͻÿ� !

 select  ename, sal, dense_rank()  over ( order  by sal  desc )  ����
    from  emp;

�� Q-163.  ������ 2975�� ������ �����ΰ� ?  

select   dense_rank(2975)  within  group ( order  by sal desc ) ����
   from   emp;

����:  within ~�̳��� 
        ������ ������������ ������ �׷� �ȿ��� 2975�� ������ ����
       �ΰ� ?

�� Q-164.  �츮�ݿ��� 34 ������ ������ ����Ͻÿ� !

 select   dense_rank(34)  within  group ( order  by age desc ) ����
   from  emp12;

�� Q-165. 81�� 11�� 17�Ͽ� �Ի��� ����� ��� ���̺��� ���°��
 �Ի��� ����ΰ� ?

 select   
   dense_rank(to_date('81/11/17','RR/MM/DD')) 
                            within group (order by hiredate asc) ����
   from emp;


�� Q-166.  �̸�, ����, ����� ����ϴµ� ����� 7������� ������
����Ͻÿ� (���̰� ���� �������� ����� �����ÿ�)

 select  ename, age,  ntile(7)  over  ( order  by  age  desc) ���
    from   emp12;

�� Q-167.  ����, �̸�, ����, ����� ����ϴµ� ������ ����
 ����� 3������� �������� �Ͻÿ� !
              (����� ������ ���� ���������� ����Դϴ�.)

select  job, ename, sal,  ntile(3)  over ( partition by job 
                                                   order  by  sal  desc ) ���
    from  emp;

�� Q-168.  ���� ������� �Ҽ��� ����°������ ��µǰڱ� 
�ݿø��Ͻÿ�

KING	5000	0.071
SCOTT	3000	0.214
  :            :             : 

select  ename, sal,  
        round( cume_dist()  over ( order  by  sal  desc ),3 ) as  ����
         from  emp;

�� Q-169. ����, �������� �ش��ϴ� ������� �̸��� ���η� ����Ͻÿ�

select  job,  
     listagg(ename, ',')  within  group ( order  by  ename asc) �̸�
  from  emp
  group  by job; 


�� Q-170.  �Ʒ��� ���� ����� ����Ͻÿ� !

ANALYST    	FORD(3000), SCOTT(3000)
CLERK	             ADAMS(1100), JAMES(950), MILLER, SMITH
MANAGER	BLAKE, CLARK, JONES
PRESIDENT	KING
SALESMAN	ALLEN, MARTIN, TURNER, WARD

select job,  
 listagg(ename || '(' || sal || ')' , ',') within group (order by ename asc) �̸� 
   from emp 
   group by job;  

�� Q-171. ����, ���̺��� �ش��ϴ� �л����� �̸��� ���η� 
 ����Ͻÿ�

 45�б��� ������ ~~

select  age, 
 listagg(ename,',') within group ( order  by  ename  asc )  �̸�
  from   emp12
  group by age;

�� Q-172-1. * ���ɽð� ���� Ǯ�� ���� ��Ż� skt �� SK ��  sk �� �����ϼ���.
             
update   emp12
  set  telecom ='sk'
  where  telecom  in ('skt', 'SK'); 

commit;

select  telecom  from  emp12;

�� Q-172-2. (���ɽð� ����)  ��۷� �ް� ���� �˻� �Դϴ�. 
 ��Ż縦 ����ϰ� ��Ż纰�� �ش� �ϴ� �л����� �̸��� ���
 �ϴµ� �̸� ���� ���̵� ���� ��µǰ� �ϰ� ���̰� ���� �л�����
 �� ��µǰ��Ͻÿ� !

kt    �Ѱ�(31), ��Ҷ�(29), ..............
lg    ���ֿ�(44), ������(28), ...........
sk    �Ǽ���(36), ������(35), ..............

�� Q-173.  �̸�, �Ի���, �ٷ� ���� �Ի��� ����� �Ի���,
 �ٷ� ������ �Ի��� ����� �Ի�����  
 ����Ͻÿ� !

select  ename, hiredate,  
  lag(hiredate,1) over ( order by hiredate asc)   ����,
       lead(hiredate,1) over ( order  by hiredate  asc ) ������
           from  emp;


�� Q-174.   ��Ż�, ��Ż纰 ��Ż���̸� ����Ͻÿ� (�������)

select  telecom,  sum(age)
  from  emp
  group  by  telecom; 

  sk   322
  lg   126
  kt   411 

�� Q-175. �̹����� �Ʒ��� ���� ���η� ����Ͻÿ� ! 

   sk     lg    kt
  322   126  411 

select  sum( decode( telecom, 'sk', age, 0  )  )  as  "sk",
         sum( decode( telecom, 'lg', age, 0  )  )  as  "lg",
         sum( decode( telecom, 'kt', age, 0  )  )  as  "kt"
   from   emp12;

�� Q-176. �Ʒ��� SQL �ΰ��� ����� ������?

 " �׷��Լ��� null ���� �����Ѵ� "

 select   sum(comm)  from  emp; 
  2200

 select   sum( nvl(comm,0) ) from  emp; --> 
  2200                                          

����: ���� SQL �� �� ������ ����.  �ֳĸ� null ���� sum ���꿡 ���Ե���
       �ʱ� �����̴�. 

�� Q-177. �Ʒ��� SQL �� Ʃ���Ͻÿ� !  ��1200 ���� ~  2400 ����
Ʃ����
select  sum( decode( telecom, 'sk', age, 0  )  )  as  "sk",
         sum( decode( telecom, 'lg', age, 0  )  )  as  "lg",
         sum( decode( telecom, 'kt', age, 0  )  )  as  "kt"
   from   emp12;

               ��

Ʃ����
select  sum( decode( telecom, 'sk', age )  )  as  "sk",
         sum( decode( telecom, 'lg', age,  null  )  )  as  "lg",
         sum( decode( telecom, 'kt', age,  null )  )  as  "kt"
   from   emp12;

 select  decode( telecom, 'sk', age,  null  ) 
   from  emp;

�� Q-178.   ����,  ������ ��Ż������ ����Ͻÿ� ( ���η� ���) 

select  job,  sum(sal)
  from  emp
  group  by  job;

�� Q-179.  ����, ������ ��Ż������ ����Ͻÿ� (���η� ���)

 select   sum(decode( job, 'ANALYST', sal, null)) as  "ANALYST",
           sum(decode( job, 'CLERK', sal, null))  as  "CLERK",
           sum(decode( job, 'MANAGER', sal, null))  as  "MANAGER",
           sum(decode( job, 'PRESIDENT', sal, null))  as  "PRESIDENT",
           sum(decode( job, 'SALESMAN', sal, null))  as  "SALESMAN"
 from  emp; 


�� Q-180.  ��Ż�, ��Ż纰 ��Ż���̸� ���η� ����Ͻÿ� ( pivot������)

   sk     lg    kt
  322   126  411 

select   *
  from  ( select   telecom,  age  from   emp12 )  ����� �׷��Լ��� ���� �ʴ´�.
  pivot  ( sum(age)  for  telecom  in ('sk' as  "sk", 
                                                'lg' as  "lg",
                                                'kt' as  "kt" )  ) ; 


�� Q-181. ���� ����� ��Ż���̰� �ƴ϶� ��ճ��̷� ������ �Ͻÿ� !

select   *
  from  ( select   telecom,  age  from   emp12 )  
  pivot  ( avg(age)  for  telecom  in ('sk' as  "sk", 
                                                'lg' as  "lg",
                                                'kt' as  "kt" )  ) ; 


�� Q-182. �̸�, ����, ������ ����ġ�� ����Ͻÿ� 

select  ename, age,  sum(age)  over ( order  by  ename  asc ) ����ġ
   from   emp12;

�� Q-183.  ����, �̸�, ����, ������ ����ġ�� ����ϴµ� �������� ���� 
             ������ ����ġ�� ��µǰ��Ͻÿ� !

select  job,  ename, sal,  sum(sal)  over  (  partition  by  job 
                                                       order  by  sal  asc  )  ����ġ
   from   emp;

�� Q-184.  ��Ż�, �̸�, ����,  ������ ����ġ�� ����ϴµ�  ������ ����ġ��
��Ż纰�� ���� �����Ǿ ��µǰ��Ͻÿ� !

select  telecom,  ename,  age,  sum(age)  over ( partition  by  telecom
                                                               order  by  age  asc ) ����ġ
    from  emp12;


�� Q-185.  ��Ż�, ��Ż纰 ��Ż���̸� ����ϴµ� ������ ��ü ��Ż���̰� ��µǰ��Ͻÿ�

 select   telecom,  sum(age)
   from  emp12
   group  by  cube(telecom) ;

�� Q-186.  �Ի��� �⵵(4�ڸ�), �Ի��� �⵵�� ��Ż������ ����ϴµ� �� ���� ��ü��Ż������
����Ͻÿ� !

  

�� Q-187.(������ ������ ����) ��۷� �ø����� ~  

  �Ի��� �⵵(4�ڸ�), �Ի��� �⵵�� ��Ż������ ����Ͻÿ� ! 

 1. ���� ���
 2. ���� ���( sum + decode ���) 
