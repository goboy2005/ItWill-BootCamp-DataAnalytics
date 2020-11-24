? 075 ���� ���� ����ϱ� 5(HAVING���� ���� ����)

* select ���忡��  ���������� �� �� �ִ� �� 

select       �������� ��밡�� ( scalar  subquery )
  from      �������� ��밡�� ( in  line  view  ) 
  where     �������� ��밡��
  group by        X  
  having    �������� ��밡��
  order  by  �������� ��밡��  ( scalar  subquery )

280.   JAMES ���� �� ���� ������ �޴� ������� �̸��� ������ ����Ͻÿ�

select    ename, sal
    from   emp
   where   sal  > (  select   sal
                         from  emp
                         where  ename='JAMES' );

281.  ����, ������ ��Ż������ ����Ͻÿ� ! (���� ���) 

select  job,  sum(sal)
  from  emp
  group  by  job;

JOB                  SUM(SAL)
------------------ ----------
SALESMAN               5600
CLERK                     4150
ANALYST                 12000
MANAGER                8275
PRESIDENT                5000

282. ���� ����� �ٽ� ����ϴµ� ������ SALESMAN �� ��Ż���޺��� 
 �� ū �͸� ����Ͻÿ� !  

select  job,  sum(sal)
  from  emp
  group  by  job
  having  sum(sal) >  ( select  sum(sal)
                                 from  emp
                                where  job='SALESMAN') 

����:  �׷��Լ��� ������ �ִ� ���� having �� �Դϴ�. 
        where ���� �ۼ��ϸ� ������ �߻� �մϴ�. 

283.  �μ���ȣ�� �μ���ȣ�� �ο����� ����ϴµ� 10�� �μ���ȣ�� �ο������� 
�� ū�͸� ����Ͻÿ� 

select   deptno,  count(*)
  from   emp
  group  by  deptno 
  having  count(*)  > ( select  count(*)
                               from  emp
                               where   deptno = 10 );

	? 076 ���� ���� ����ϱ� 6 (FROM���� ���� ����)

  " from ������ ���������� ����� �� �ֽ��ϴ�. from ���� ���������� in line view 
    ��� �մϴ� "

����:   �̸�, ����, ������ ����ϴµ� ������ ������ ���� ��������� ������ �ο��Ͻÿ�

 select  ename,  sal,  dense_rank()  over ( order  by  sal  desc ) ����
   from  emp;

����:  ���� ������� ������ 4���� ����� ����Ͻÿ� !

 select  ename,  sal,  dense_rank()  over ( order  by  sal  desc ) ����
   from  emp
   where  ���� = 4; 

����:  ���� SQL �� ������ ���ϴ�. �ֳ��ϸ� ���� ���� �����Դϴ�.
        FROM  �� �����ϰ� WHERE ���� �����ϱ� ������ emp ���̺���
        ������� �÷��� ���⶧���� ������ ���ϴ�.

    ������ 4���� ����� �̸��� ���ް� ������ ����Ϸ���  from ���� ���������� 
    ����ؾ��մϴ�. 

 select  * 
    from ( select  ename,  sal,  dense_rank()  over ( order  by  sal  desc ) ����
              from  emp 
            ) 
   where   ���� = 4;  

����:  from ���� ������������ ����� ��ġ �ϳ��� ���̺�ó�� ��������� 
        ������������ ��� �����Ͱ� �޸𸮿� �ö󰡰� �˴ϴ�. 
       �޸𸮿� �÷����� ������ �߿� ������ 4���� �����͸� �����´�. 

ENAME                       SAL       ����
-------------------- ---------- ----------
�Ǽ���                     6000          1
KING                       5000          2
FORD                       3000          3
SCOTT                      3000          3
JONES                      2975          4
BLAKE                      2850          5

284. ����, �̸�, ����,  ������ ����ϴµ� ������ �������� ���� ������ ���� ����
���� ������ �ο��Ͻÿ� !

select  job,  ename, sal,  dense_rank()   over  ( partition  by  job
                                                            order  by  sal  desc )  ����
      from   emp;

285. ���� ������� ������ 1���� ����鸸 ����Ͻÿ� !

select  *
  from  (  select  job,  ename, sal,  dense_rank()   over  ( partition  by  job
                                                            order  by  sal  desc )  ����
               from   emp ) 

 where   ���� = 1 ;
 
286.  �츮�� ���̺��� ��Ż纰�� ���̰� ���� ���� �л��� �̸��� ���̿� 
��Ż�� ������ ������ ����Ͻÿ� !

select  *
  from  (  select  telecom, ename,  age, 
                                  dense_rank()  over (  partition  by  telecom
                                                             order  by   age  desc ) ����
               from  emp12
           )
  where  ���� = 1; 

287.  price ���̺��� ��ü �Ǽ��� ��� �Ǵ��� Ȯ���Ͻÿ� !

  select  count(*) 
   from price; 

 M_NAME :  ��Ʈ �̸� �Ǵ� �����̸� 
 A_NAME : �ķ�ǰ �̸� 
 A_PRICE : �ķ�ǰ ���� 

288.( ���ɽð� ���� )  ����ÿ��� ���� ��� �ķ�ǰ�� �̸��� ���ݰ� �Ĵ� ����
 ����Ͻÿ� ! 


	? 77 ���� ���� ����ϱ� 7 (SELECT���� ���� ����)

" select ���� ���������� ����� �� �ִµ� select ���� ���������� scalar subquery
  ��� �մϴ�. "

����:  �̸�, ����,  ������̺��� ��տ����� ����Ͻÿ� !
  �ڱ��� ���ް� ��տ����� ���غ��� ���ؼ� )

 select   ename, sal,  ( select   avg(sal)
                                   from  emp   )   ��տ���
   from  emp ;
                                      
289.   ����̸�, ����, ��� ���̺��� �ִ����, ��� ���̺��� �ּҿ�����
����Ͻÿ� !

 select  ename, sal,  (  select  max(sal), min(sal)
                                 from  emp  )   
  from   emp;

�߿伳��:  select ���� ���������� ��Į�� ���������� Ư¡ ?

               ��Į�� ���������� �� �Ѱ��� �� ���� �� �� �ִ�. 

select  ename, sal,  ( select  max(sal)
                              from  emp  )  �ִ�, 
                          ( select  min(sal)
                              from  emp  ) �ּ� 
   from   emp;

290.   �̸�, ����,  �츮�� ������ ��ճ��̸� ����Ͻÿ� !

 select   ename,  age,   ( select   avg(age)
                                    from  emp12  )   ��ճ���
   from   emp12; 

291.  ���� ����� �Ҽ��� ���ϰ� �ȳ����� �ݿø��Ͻÿ� ! 

 select   ename,  age,   ( select   round(avg(age) )
                                    from  emp12  )   ��ճ���
   from   emp12; 

292. (���̵� ��) ���� ������� �л��� ���̰� ��ճ��̺��� �� ū 
 �л����� �̸��� ���̿� ��ճ��̸� ����Ͻÿ� !

    ���� ����� �ٽ� ����ϴµ� �츮�� ��ճ��̺��� �� ���� �л��鸸
    ����Ͻÿ� !

select *
  from ( select   ename,  age,   ( select   round(avg(age) )
                                              from  emp12  )   ��ճ���
                  from   emp12 )
  
where   age > ��ճ��� ;

293.  ��� ���̺��� �̸�, ����, ��� ���̺��� �ִ����,
                                                  ��� ���̺��� �ּҿ���,
                                                  ��� ���̺��� ��տ����� ����Ͻÿ�!

Ʃ����:
select  ename, sal,  (  select  max(sal) from  emp ) �ִ����,
                          (  select  min(sal) from  emp ) �ּҿ���,
                          (  select  avg(sal) from  emp ) ��տ���
   from   emp; 

Ʃ����:         
select  ename, sal,  max(sal)  over   ()  �ִ����,
                          min(sal)  over   ()  �ּҿ���,
                          avg(sal)  over   ()  ��տ���
  from   emp; 

294.   �츮�� ���̺��� �̸�, ����,  �츮�� ������ �ִ볪��,
                                                      �츮�� ������ �ּҳ���,
                                                      �츮�� ������ ��ճ���,
                                                      �츮�� �л����� �ο�����
              ����Ͻÿ� !

select  ename, age,  max(age)  over  ()  �ִ볪��,
                           min(age)  over  ()  �ּҳ���,
                           round( avg(age)   over  (), 0 )  ��ճ���,
                           count(*)   over  ()  �ο���
  from   emp12; 

����:   select ���� ���������� ��Į�� ���������� ������ �����Ƿ�
         ���� ���� ������ �м��Լ��� �̿��ؼ� Ʃ���� �ϸ� ������ 
         ��뷮 �������� �����͸� �˻� �� �� �ֽ��ϴ�. 


	? 078 ������ �Է��ϱ�(INSERT)

 " ���̺� �����͸� �Է��ϴ� SQL ���� "

��:   insert   into   emp(empno, ename, sal )
                       values ( 1234, 'jack', 4500 );

    ���� �÷� �������� ���� ���   ������ �Է��� �÷��� ���
       ; �� ���� ���� SQL ������ �����ض� ~~

295.  ��� ���̺� �Ʒ��� �����͸� �Է��Ͻÿ� !

    �����ȣ: 2939
    ����̸�: jane
    ����  :   4700
   �Ի��� :  ���ó�¥

delete from  emp  where  empno = 2939; 

 insert   into   emp( empno, ename, sal, hiredate )
   values( 2939, 'jane', 4700,  sysdate );

296. ���� �Ի��� ����� �̸��� �Ի����� ����Ͻÿ� !

 select   ename, hiredate
  from   emp
  where  hiredate = sysdate ;

����:  �� ��ȸ�� ���� �ʴ°� ?  sysdate �� ��¥ �Ӹ� �ƴ϶� �ú��ʵ� ���
        �Ǳ� ������ �Ʊ� �Է������� �ú��ʿ� ���� ��ȸ������ �ú��ʰ�
        ���� �ٸ��� ������ ��ȸ���� ���� �� �Դϴ�. 

delete from  emp  where  empno = 2939; 

 insert   into   emp( empno, ename, sal, hiredate )
               values( 2939, 'jane', 4700,  to_date('20/11/05', 'RR/MM/DD')   );

�߿伳��:  ��¥�� �Է��� ���� to_date �� ����ؼ� �Է��ϼ��� ~
              �������� �ʰ� Ȯ���ϰ� ��¥ �����͸� �Է��ϴ� ����Դϴ�. 
              ���� ���� ��¥�� �Է��ϸ� ��¥�� ��Ȯ�ϰ� 2020�� 11�� 05�Ϸ�
              �Է��� �ǰ� �ú��ʴ� 00�� 00�� 00 �ʷ� �Էµ˴ϴ�. 

297. 2020�� 11�� 05�Ͽ� �Ի��� ����� �̸��� �Ի����� ����Ͻÿ�!

 select  ename, hiredate
  from  emp
  where   hiredate  =  to_date('2020/11/05', 'RRRR/MM/DD') ;

 where  to_char(hiredate,'RRRR/MM/DD') ='2020/11/05'; 

 where   hiredate  

����:  where ���� �÷����ʿ� ������ �Լ��� ������� �ʰ� �˻��ϴ°���
        �� ������ �����͸� �˻��� �� �ִ� ��� �Դϴ�. 

  where hiredate=to_date(sysdate,'rr/mm/dd');

298.  �Ʒ��� �����͸� ��� ���̺� �Է��Ͻÿ� !

insert  into  emp(empno, ename, sal, deptno)
 values( 4945, 'mike    ',  3000, 20 ) ;

299.  �̸��� mike �� ����� �̸��� ������ ����Ͻÿ� !

Ʃ����:
select  ename, sal
  from   emp
  where  rtrim(ename)='mike'; 
               ��
Ʃ����:
  select  ename, sal
  from   emp  
  where  ename  like  'mike%'; 

����:   where ���� �÷����� �Լ��� ������ ������� �ʾƼ� �˻� ������
         ���� ���ϴ�. 

300.  �Ʒ��� �����͸� �츮�� ���̺� �Է��Ͻÿ� !

   �̸�:  ����ȣ
   ����:  ��
   �̸���:  abcd1234@gmail.com
   �ּ� :   ����� ������ ���ﵿ ������� 4��
   
	? 079 ������ �����ϱ�(UPDATE)

 " �����͸� �����ϴ� SQL �� "

����:    update   emp
              set   sal = 0
           where  ename='SCOTT' ;

����:  SCOTT �� ������ 0 �� �����ϴ� update ���� 

301.  KING �� ������ 9000 ���� �����Ͻÿ� !

update  emp
  set  sal = 9000
  where  ename='KING';

commit;  --->  ���ݱ��� ������ ��� �۾��� �� database �� ������ ����
                    �ϰڴ�.

rollback;  ---> commit ���Ŀ� �۾��� ��� ��������� ����ϰڴ�. 

302.  ������ SALESMAN �� ������� Ŀ�̼��� 9500 ���� �����Ͻÿ� !

update  emp
  set  comm = 9500
  where   job ='SALESMAN'; 

rollback;

	? 080 ������ �����ϱ�(DELETE, TRUNCATE, DROP)

 * ����Ŭ���� �����͸� �����ϴ� ��� 3���� ?

      1. delete 
      2. truncate
      3. drop 

����:  delete  from  emp
        where  empno = 7788;  

 ����:  �����ȣ�� 7788 ���� ����� �����ϰڴ�. 

303.  ������ SALESMAN �� ������� �����Ͻÿ� ! 

 delete  from   emp
  where  job='SALESMAN'; 

 delete  from  emp ;
 commit;

 truncate  ��ɾ� 

 1.  ������ ��� ����
 2.  rollback �ȵ� 
 3.  flashback �ȵ� 
 4. ���̺� ������ ����� �� �����. 

       �����      --------------------- �׽�Ʈ ���� 
      �� ���̺�                            �� ���̺�

truncate   table  emp; 


* drop ��ɾ� 

 1. ��� ������ ����
 2. ���̺� �������� �� ����
 3. rollback �ȵ� 
 4. ������ ����� �־ flashback �� ���� �մϴ�.

 drop   table  emp;

 select * from emp; 

 show  recyclebin;   <-- ������ӿ� �ִ� ������ Ȯ�� 

 flashback  table  emp  to  before  drop;  <-- �����뿡�� �����ϴ� ��ɾ�

  select * from emp; 


* Ÿ�Ӹӽ� ����� �̿��ؼ� ���ŷ� emp ���̺� �ǵ����ϴ�. 

1. emp ���̺��� flashback �� ������ ���·� �����Ѵ�. 
   ( Ÿ�Ӹӽ� ����� �� �� �ֵ��� �����Ѵ�.) 

alter  table  emp   enable    row   movement; 

2. ����ð��� 10�������� emp ���̺��� �ǵ�����.

flashback  table  emp   to   timestamp  
( systimestamp  -  interval  '10' minute );

select * from emp;

commit;

��� Ÿ���� 15���̹Ƿ� 15�� �ȿ� �ؾ� �մϴ�.

show parameter  undo_retention


304.  �μ���ȣ, �μ���ȣ�� ��Ż������ ����ϴµ� ���η� ����Ͻÿ� 
 ( sum + decode �̿� )

 select   job, sum ( decode( deptno, 10, sal )   )  as "10",
                 sum ( decode( deptno, 20, sal )  )   as  "20",
                 sum ( decode( deptno, 30, sal )  )  as  "30"
  from  emp
  group  by  job; 

305.  (������ ������ ����)  ���� ������� �������� �Ʒ��� ���� 
����Ͻÿ� !   ��۷� �˻�������� ~

JOB                            10         20         30      ��Ż��
------------------ ---------- ---------- ----------  -------------
SALESMAN                                         5600     5600
CLERK                     1300       1900         950     4150 
ANALYST                              6000                   6000
MANAGER               2450       2975       2850      8275
PRESIDENT              5000                                 5000
��ü��Ż:                8750      10875      8400      29025  
        
select job, sum(decode(deptno, 10,sal)) as "10",
sum(decode(deptno, 20, sal)) as "20",
sum(decode(deptno, 30, sal)) as "30", sum(sal) as ��Ż��
from emp
group by job

union all

select '��ü��Ż' as job , sum(decode(deptno, 10,sal)) as "10",
sum(decode(deptno, 20, sal)) as "20",
sum(decode(deptno, 30, sal)) as "30", sum(sal) as ��Ż��
from emp;
