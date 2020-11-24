? 067 ���� �����ڷ� �����͸� ���Ʒ��� �����ϱ� 1(UNION ALL)

* �����͸� �����ؼ� ����ϴ� ��� 2���� 

 1. ����(join) : �����͸� �翷���� �����ؼ� ����ϴ� ���
 2. ���� ������ : �����͸� ���Ʒ��� �����ؼ� ����ϴ� ��� 

* ���� �������� ���� 4���� 
     1.  union  all
     2.  union
     3.  intersect
     4.  minus 

 ����)
 ����,������ ��Ż������ ����Ͻÿ� ! (���� ���) 

select    job,  sum(sal)
   from  emp  
   group  by   job; 

JOB                  SUM(SAL)
------------------ ----------
SALESMAN              9100
CLERK                    4150
ANALYST                6000
MANAGER              8275
PRESIDENT             5000

����)
��ü ��Ż������ ����Ͻÿ� !

 select  '��ü��Ż:'  as  job,  sum(sal)  
   from  emp; 

����)
���� SQL�� �ϳ��� ���ļ� �����Ͱ� ���Ʒ��� ��µǰ��Ͻÿ� !

select    job,  sum(sal)                   ������ Ÿ��(����)  3����
   from  emp                                1.  ������
   group  by   job                          2.  ������
union  all                                     3.  ��¥�� 
select  '��ü��Ż:' as  job,  sum(sal)
  from  emp
  

����: union all �� ���� �������� ����� �Ʒ��� �������� ����� �ϳ���
       ���ļ� ����ϰ� �ִ�. 

      * ���� �����ڸ� ����� �� ���� ������ ������ ����.
      1. ���� ������ �� �Ʒ��� �������� �÷��� ������ �����ؾ� �մϴ�.
      2. ���� ������ �� �Ʒ��� �������� �÷��� ������ Ÿ�Ե� �����ؾ��մϴ�.
      3. ���� ������ �� �Ʒ��� �������� �÷��� �÷����� �����ؾ� �մϴ�.
      4. order  by ���� �� �Ʒ����������� �ۼ��� �� �ֽ��ϴ�. 

251.�μ���ȣ, �μ���ȣ�� ��Ż������ ����ϴµ� �� �Ʒ��� ��ü��Ż
������ ��µǰ��Ͻÿ� !  (union all �� ����)

select   to_char(deptno) as deptno,  sum(sal)
  from  emp
  group  by deptno
union  all
select   '��ü��Ż'   as   deptno,  sum(sal)
  from  emp;

insert   into  emp(empno, ename, sal, job, deptno )
  values( 1221, 'jack', 3500, 'SALESMAN', 70 );


252.�Ի��� �⵵(4�ڸ�), �Ի��� �⵵�� ��Ż������ ����Ͻÿ� !

 select  to_char(hiredate, 'RRRR'), sum(sal)
    from   emp
    group  by  to_char(hiredate,'RRRR');

 delete  from   emp  where  hiredate  is  null; 
 commit;

253.�Ի��� �⵵(4�ڸ�), �Ի��� �⵵�� ��Ż������ ����ϴµ�
�� �Ʒ��� ��ü ��Ż������ ��µǰ��Ͻÿ� !

1981          22825
1983           1100
1980            800
1982           4300
��Ż:          29025  

 select  to_char(hiredate, 'RRRR') as hire_year, sum(sal)
    from   emp
    group  by  to_char(hiredate,'RRRR')
     union  all
    select  '��Ż:'   as  hire_year,  sum(sal) 
     from emp; 

����:union  all �� �Ʒ��� �������� �÷��� ������ ���� �����ؾ��ϰ�
         �÷��� ������ �����ؾ��ϰ� ������ ������ �����ؾ� �մϴ�.

254.�츮�� ���̺��� ��Ż�, ��Ż纰 �ο����� ����Ͻÿ� !

 select  telecom, count(*)
   from   emp12
  group  by  telecom;

255.�Ʒ��� ���� ��ü�ο����� �� �Ʒ��� ��µǰ��Ͻÿ� 

sk                                               11
lg                                                4
kt                                               15
��ü:                                           30 

select   telecom,  count(*)
  from   emp12
  group  by  telecom
union  all
 select  '��ü'  as  telecom, count(*)
  from emp12; 

256.���� 253���� ����� �����ؼ� ����Ͻÿ� ! 

1981          22825                            1980     800
1983           1100           ----------->   1981  22825
1980            800                             1982    4300
1982           4300                            1983    1100
��Ż:          29025                            ��Ż:  29025

 select  to_char(hiredate, 'RRRR') as hire_year, sum(sal)
    from   emp
    group  by  to_char(hiredate,'RRRR')
     union  all
    select  '��Ż:'   as  hire_year,  sum(sal) 
     from emp 
     order by  hire_year  asc; 

����:order by ���� �׻� �� �Ʒ��� ���������� ����ؾ� �մϴ�.

	?  068 ���� �����ڷ� �����͸� ���Ʒ��� �����ϱ� 2(UNION)

  " union ��  union  all �� ���� ������ �������ε� �������� 
    union �� order by ���� ������� �ʾƵ� ������ �Ͻ������� �����մϴ�.
   �׸��� �ߺ��� �����͸� �ϳ��� ����մϴ� "
��)
 select  to_char(hiredate, 'RRRR') as hire_year, sum(sal)
    from   emp
    group  by  to_char(hiredate,'RRRR')
     union
    select  '��Ż:'   as  hire_year,  sum(sal) 
     from emp ;

257.�μ���ȣ, �μ���ȣ�� ��Ż������ ����ϴµ� �� �Ʒ��� ��ü��Ż
������ ��µǰ��ϰ� �μ���ȣ�� 10, 20, 30�� ������ �����ؼ� 
��µǰ��Ͻÿ� !

select   to_char(deptno) as deptno, sum(sal)
 from emp
 group  by deptno
 union 
 select  '��ü��Ż:'  as  deptno,  sum(sal)
   from  emp;

10	8750
20	10875
30	9400
��ü��Ż:	29025

����)
union  �� �Ͻ������� ���� �۾��� �����ϱ� ������ ���� ���ĵ� �����
        �� �ʿ䰡 ���ٸ� union  all �� ����ϴ°� �� �˻� ���ɿ� �����ϴ�.

258.�μ���ġ, �μ���ġ�� ��Ż������ ����Ͻÿ� (���� ���) 

select  d.loc,  sum(e.sal)
  from  emp  e, dept  d
  where  e.deptno = d.deptno
  group  by  d.loc; 

259.�� �Ʒ��� ��ü ��Ż���޵� ��µǰ��Ͻÿ� !

LOC                        SUM(E.SAL)
-------------------------- ----------
NEW YORK                       8750
DALLAS                          10875
CHICAGO                          9400
��ü��Ż:                         29025 

select  d.loc,  sum(e.sal)
  from  emp  e, dept  d
  where  e.deptno = d.deptno
  group  by  d.loc
 union  all
select  '��ü��Ż'  as  loc, sum(sal)
  from  emp; 

260.���� ����� �ٽ� ����ϴµ� ������ ABCD �������� �����ؼ� ��µǰ��Ͻÿ�

select  d.loc,  sum(e.sal)
  from  emp  e, dept  d
  where  e.deptno = d.deptno
  group  by  d.loc
 union
select  '��ü��Ż'  as  loc, sum(sal)
  from  emp; 

����: ������ �� �ʿ䰡 ������ UNION  ALL �� ����ϰ� ������ �ʿ��ϸ� UNION 
        �� ����մϴ�.

261.����, ������ �ִ����, ������ �ּҿ���, ������ ��տ���, ������ �ο�����
����Ͻÿ� !

select   job,  max(sal), min(sal), avg(sal),  count(*)
  from  emp
  group  by  job; 

262.��� ���̺��� �ִ����, �ּҿ���, ��տ���, ��ü�ο����� ����Ͻÿ� !

select   max(sal), min(sal), avg(sal), count(*)
  from  emp;

263.����261���� ����� ����262���� ����� ���Ʒ��� �����ؼ� ����Ͻÿ� !

JOB                  MAX(SAL)   MIN(SAL)   AVG(SAL)   COUNT(*)
------------------       ---------- ---------- ---------- ----------
SALESMAN                1600       1250       1400           4
CLERK                      1300        800      1037.5           4
ANALYST                  3000       3000       3000            2
MANAGER                2975       2450      2758.33333     3
PRESIDENT                5000       5000       5000            1
��ü:                        5000        800 2073.21429         14

select   job,  max(sal), min(sal), avg(sal),  count(*)
  from  emp
  group  by  job
 union  all
select   '��ü:' as job  , max(sal), min(sal), avg(sal), count(*)
  from  emp;

264. (���ɽð� ���� ) ���� ������� ���ڿ� ���� õ������ �ο��ǰ� �Ͻÿ�!

JOB                  MAX(SAL)   MIN(SAL)   AVG(SAL)   COUNT(*)
------------------ ---------- ---------- ---------- ----------
SALESMAN                1,600       1,250       1,400          4
CLERK                      1,300        800       1,037.5          4
ANALYST                  3,000       3,000       3,000           2
MANAGER                2,975       2,450      2,758            3
PRESIDENT                5,000       5,000       5,000           1
��ü:                       5,000        800       2,073            14

? 069 ���� �����ڷ� �������� �������� ����ϱ�(INTERSECT)

 ���� ������ :  1. ������ ������ :  union all , union
                    2. ������ ������ :  intersect 
                    3. ������ ������ :  minus

����)
�츮�� ���̺��� ��� �Ͻÿ� !  

   create  table  emp12_backup
    as
     select  *
      from  emp12;

 
* �츮�� ���̺��� �达 �л��鸸 �����ͼ� emp_backup2 ���̺��� �����Ͻÿ� !

create  table  emp12_backup2
  as
   select  *
   from  emp12
  where  ename  like '��%';

 select  *  from  emp12_backup2; 

��)
select   ename, age, telecom
      from  emp12
    union  all
     select  ename, age, telecom
      from  emp12_backup2; 

   select   ename, age, telecom
      from  emp12
    union 
     select  ename, age, telecom
      from  emp12_backup2; 

 ����)
 union �� ������ �������ε� �ߺ��� �����͸� �����ϰ� �����۾��� �����մϴ�.

   select   ename, age, telecom
      from  emp12
     intersect  
     select  ename, age, telecom
      from  emp12_backup2; 

? 070 ���� �����ڷ� �������� ���̸� ����ϱ�(MINUS)

  " �������� ���ϴ� ���� ������ " 

����)
select   ename, age, telecom
          from  emp12
         minus
       select  ename, age, telecom
         from  emp12_backup2; 

����:�达 ���� �� ��µǾ����ϴ�. 

	? 071 ���� ���� ����ϱ� 1 (������ ��������)

����1)
��� ���̺��� �ִ������ �޴� ����� �̸��� ������ ����Ͻÿ� !

 select  ename, max(sal)
   from  emp;

����:  ����  SQL �� �����Ϸ��� ������������ ����ؾ� �մϴ�. 

����2)
JONES �� ������ ����Ͻÿ� !

select   sal
    from  emp
    where  ename='JONES';      2975

����3)
JONES �� ���޺��� �� ���� ������ �޴� ������� �̸��� ������ ����Ͻÿ�!

select  ename, sal
  from  emp
  where  sal >= ( select  sal
                          from  emp
                          where  ename='JONES' );

����: ������ �ι� ���� �������� ���� ���� ���� �ѹ��� ���� ���� !

265.SCOTT �� ���� ������ �޴� ������� �̸��� ������ ����Ͻÿ� !
SCOTT �� �����ϰ� ����Ͻÿ� !

select  ename, sal
  from   emp
  where  sal =  ( select  sal
                        from  emp
                        where  ename='SCOTT' )
  and  ename != 'SCOTT'; 

266.SMITH �� ������ ���� ������� �̸��� ������ ����ϴµ�
SMITH �� �����ϰ� ����Ͻÿ� !

select  ename,  job
   from  emp
   where  job  =  (  select  job
                             from  emp
                             where  ename='SMITH' )
   and  ename !='SMITH'; 

267.ALLEN ���� �ʰ� �Ի���  ������� �̸��� �Ի����� ����Ͻÿ� !

SELECT  ename, hiredate
  from  emp
  where  hiredate  > ( select  hiredate
                                 from  emp
                                 where  ename='ALLEN' );

268.������ SALESMAN �� ����� �ִ���޺��� �� ���� ������ �޴�
 ������� �̸��� ������ ����Ͻÿ� ! 

 select  ename, sal
   from   emp
   where  sal  > (  select  max(sal)
                          from  emp
                          where  job='SALESMAN' );

269.�ִ������ �޴� ����� �̸��� ������ ����Ͻÿ� !

 select  ename, sal
   from  emp
   where  sal =  (  select  max(sal)
                           from  emp  );

270.������ ��谡 ���ԵǾ����ִ� �л����߿����� �ִ볪���� �л��� �̸��� 
���̿� ������ ����Ͻÿ� !

 select  ename, age, major
  from  emp12
  where  age = ( select  max(age)
                         from  emp12
                         where  major  like  '%���%' )
 and major like '%���%' ;

271.KING ���� �����ϴ� ������� �̸��� ����Ͻÿ� !
            ( KING ���� ���� �ϴ� ������� KING �� ���� ���� ����� �Դϴ�.)
              KING �� ���� ���� ������� MGR ��ȣ�� KING �� EMPNO �Դϴ�.

 select  ename
   from  emp
   where   mgr  =  (  select  empno
                              from  emp
                              where  ename='KING') ;

?  072 ���� ���� ����ϱ� 2(���� �� ��������)

* ���������� ���� 3���� :
            
	    1. ������ ���� ���� : ������������ ���������� �ϳ��� ���� ���ϵǴ� ���
                 ������: =, >, <, >=, <=, !=, <>, ^=

             2. ������ ���� ���� : ������������ ���������� �������� ���� ���ϵǴ� ���
                 ������:  in, not in,  >all, <all, >any, <any

             3. ���� �÷� �������� : ������������ ���������� �������� �÷����� ���ϵǴ� ��� 

��)
������ SALESMAN �� ������ ������ ���� ������� �̸��� ������ ����Ͻÿ� !

1. ������ ��������
select  ename, sal
  from  emp
  where  sal >= ( select  sal
                          from  emp
                          where  ename='JONES' );

2. ������ �������� 
 select   ename, sal
  from  emp
  where  sal  in  ( select  sal
                         from  emp
                         where  job='SALESMAN');
                        
272.��Ż簡 sk �� �л���� ���̰� ���� �л����� �̸��� ���̿� ��Ż縦
����Ͻÿ� 

select  ename, age, telecom
  from  emp12
  where   age  in  ( select  age 
                           from  emp12
                           where  telecom ='sk' );

273.��Ż簡 sk �� �л���� ���̰� ���� ���� �л����� �̸��� ���̿� ��Ż縦
����Ͻÿ� ! 

select  ename, age, telecom
  from  emp12
  where   age  not in  ( select  age 
                               from  emp12
                               where  telecom ='sk' );

? 073 ���� ���� ����ϱ� 3(NOT IN)

��)
�������� ������� �̸��� ����Ͻÿ� !
        (  �ڱ� �ؿ� ���Ӻ��ϰ� �Ѹ��̶� �ִ� ���)
        (  �� �����ڵ��� �����ȣ�� ���Ӻ��� ������� mgr �Դϴ�. )

  select  ename
    from   emp
   where   empno   in  ( select   mgr
                                  from  emp  ); 

274.�����ڰ� �ƴ� ������� �̸��� ����Ͻÿ� ! 
 (�������� ����� 6���� �������Ƿ� �����ڰ� �ƴ� �������
 8 ���� ��µǾ�� �մϴ�. )

����� �� �ȳ������� Ȯ���ϰ� ������    45�б��� ������ !

  select  ename
    from   emp
   where   empno  not  in  ( select   mgr
                                      from  emp  ); 

�� ������������ not in ������ ���� ������ ���� !

   ������������ null ���� �ϳ��� ���ϵǸ� ����� ��µ��� �ʴ´� 

 select   ename
  from  emp
  where   empno not  in  ( 7839, 7902, 7566, null  );
                                                                  True   and  null      null  
  select  ename                                                             True      True
  from  emp                                                                 False      False 
  where  empno != 7839 and  empno != 7902  and  empno!= 7566  and  empno != null ;
   
  ����:  null �� �Ѱ� ������ ��ü�� �� null �� �Ǿ������ ����� ����� �ȵ� 

275.���� ������ ������ϱ� �����ڰ� �ƴ� ������� ����Ͻÿ� !
  ( �����ڰ� �ƴ� ������� 8���� �ִµ� 8���� ������� �մϴ�)
  null ������  ����� �ȵǾ����Ƿ� null �� ���ϵ��� �ʰ� ������մϴ�. 

 select   ename
  from  emp
  where   empno not  in  ( select  mgr
                                     from  emp
                                    where  mgr  is  not  null ) ; 

�� �߿伳��:  ���������� ���� not in �����ڸ� ����ϸ� �ݵ�� ������������ 
                 ���������� null ���� ���ϵ��� �ʵ��� ó���� ����� �մϴ�. 

	? 074 ���� ���� ����ϱ� 4(EXISTS�� NOT EXISTS)

   ��������������  exists �� not exists �� ����ؼ� ���������� �ִ� ������ �߿�
   ���������� �����ϴ��� ���� ������ �ľ��� �� ����ϴ� SQL ���� 

����)
emp ���̺�  �Ǽ��� �����͸� �Է��� �մϴ�.

    insert   into  emp(empno, ename, sal, job, deptno )
     values( 9877, '�Ǽ���',  6000, 'ANALYST', 20 );  
    commit;
    select  * from  emp; 

����)
�츮�� ���̺� �ִ� �л����߿� ��� ���̺��� �����ϴ� �л��� ������
          �̸��� ����Ͻÿ� !

   select  ename
    from  emp12    e12
    where   exists  (  select   *
                            from   emp   e
                            where  e.ename = e12.ename ) ;

����:exists ����  main query �÷��� �������� ������ ���鼭 ����˴ϴ�. 
         �׷��鼭 ���������� ������ �߿� ������������ ���� �����Ͱ� �����ϴ���
         ã�� ���ϴ�. 

276.�μ� ���̺� �μ���ȣ�� �μ���ġ�� ����ϴµ� �μ� ���̺� �ִºμ���ȣ�߿� ��� ���̺��� �����ϴ� �μ���ȣ�� ���Ѱ͸� ����Ͻÿ� !

select deptno,  loc
from dept d
where exists (select *
                    from emp e
	        where e.deptno = d.deptno);

277.�̹����� �������� �ʴ� �μ���ȣ�� �μ���ġ�� ����Ͻÿ� !

select deptno,  loc
from dept d
where not  exists (select *
                         from emp e
	             where e.deptno = d.deptno);

278.���� ������ ������ deptno �� ���� ����Ͻÿ� !

select e.deptno,  sum(decode(d.loc, 'NEW YORK', e.sal)) as "NEW YORK",
                    sum(decode(d.loc, 'DALLAS', e.sal)) as "DALLAS",
                    sum(decode(d.loc, 'CHICAGO', e.sal)) as "CHICAGO"
from emp e, dept d
where e.deptno=d.deptno
group  by e.deptno;
 
279. (������ ������ ����)  ���� ����� null �� ��ſ� 0 ���� ��µǰ��Ͻÿ� 
DEPTNO   NEW YORK     DALLAS    CHICAGO
------- ----------      ----------       ----------
  30        0                0              9400
  10       8750            0                0
  20         0            16875            0
      
      
select e. deptno, sum(decode(d.loc, 'NEW YORK', e.sal,0)) as "NEW YORK",
       sum(decode(d.loc, 'DALLAS', e.sal,0)) as "DALLAS",
       sum(decode(d.loc, 'CHICAGO', e.sal,0)) as "CHICAGO"
            from emp e, dept d
                where e.deptno=d.deptno
                    group by e.deptno;