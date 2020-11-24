3. ������ �м� �Լ� :        1. rank
                            2. dense_rank
                            3.  ntile
                            4.  cume_dist
                            5.  listagg
                            6. report_to_ratio
                            7. lag,  lead
                            8. sum(�÷���) over (����)  ���� ������ ����
                            9. rollup
                           10. cube
                           11. grouping  sets 

4.  ����(join) ���� 

    " �ϳ��� ���̺��� ���� �� �ִ� ������ �ƴ� �������� ���̺���
     ���� �� �ִ� ������ �ϳ��� ����� �����ֱ� ���ؼ� ���� ���� "                

��:  select   e.ename,  d.loc   <--  �÷��� 
         from  emp  e,  dept  d   <-- ���̺�� 
         where  e.deptno = d.deptno    and   d.loc='DALLAS'; 

                                        ��������       �˻����� 

   emp ----------------------  dept
                ����� 

219.������ 2700 �̻��� ������� �̸��� ���ް� �μ���ġ��
����Ͻÿ� ! 
                                                   
select   e.ename,  e.sal,  d.loc  
  from  emp  e ,  dept  d             
 where   e.deptno = d.deptno   and  e.sal >= 2700;

����: ���̺� ��Ī�� ����ؼ� SQL �ڵ��� �� �����ϰ� �ۼ��ϼ���.
       �׸��� �ݵ�� ���ι��� �ۼ��Ҷ� �÷��� �տ� ���̺� ��Ī��
       ����ϼ���. 

     1. �˻��ӵ� ��������.
     2. SQL ���������� ��������.  (������)

220.�̸��� �����ڰ� T �� ������ ������� �̸��� ���ް� �μ���ġ
�� �μ����� ����Ͻÿ� !

SELECT e.ename, e.sal, d.loc, d.dname
     from emp e, dept d
     where e.deptno = d.deptno and e.ename like '%T';

221.������ SALESMAN �̰� ������ 1200 �̻��� ������� 
            �̸��� ������ �μ���ġ�� ������ ����Ͻÿ� !

select  e.ename,  e.job, d.loc,  e.sal
  from  emp  e,  dept  d
  where   e.deptno = d.deptno  and   e.job ='SALESMAN'  
                                         and   e.sal >= 1200 ;
                     ��                              ��
                 ��������                      �˻����� 

222.�μ���ġ, �μ���ġ�� ��Ż������ ����ϴµ�
 DALLAS �� �����ϰ� ����Ͻÿ� !

select  d.loc,  sum(e.sal)
   from  emp  e,  dept  d
   where   e.deptno = d.deptno  and  d.loc !='DALLAS'
   group  by  d.loc;

223.���� ��µ� ����� �ٽ� ����ϴµ� ��Ż������ �����ͺ��� 
 ����Ͻÿ� !

select  d.loc,  sum(e.sal)
   from  emp  e,  dept  d
   where   e.deptno = d.deptno  and  d.loc !='DALLAS'
   group  by  d.loc
   order  by  sum(e.sal)  desc;

? 059 ���� ���̺��� �����͸� �����ؼ� ����ϱ� 2(NON EQUI JOIN)

 " �����Ϸ��� �ΰ��� ���̺� ���̿� ����� �÷��� �������� ����ϴ� ���� ����"

��:  salgrade ���̺��� ���� 
  
 �޿����   �ּҿ���   �ְ����
   ��              ��         ��
 GRADE      LOSAL      HISAL
   ------   ---------- ----------
     1        700       1200
     2       1201       1400
     3       1401       2000
     4       2001       3000
     5       3001       9999

����)
�̸�, ����,  grade(�޿����) �� ����Ͻÿ� !

            emp  -------------------  salgrade   

 select   e.ename,  e.sal,  s.grade 
   from   emp  e,  salgrade  s
   where   e.sal  between  s.losal  and  s.hisal;

224.���� ������� ����� 3����� ����鸸 ����Ͻÿ� !

 select   e.ename,  e.sal,  s.grade 
   from   emp  e,  salgrade  s
   where   e.sal  between  s.losal  and  s.hisal  and  s.grade = 3; 

����:   * ���� ������ ���� 2���� 
                1.  ����Ŭ ���� ���� :
                                                1. equi  join :  �ΰ��� ���̺� ���̿� ����� �÷���
                                                                   �־��� ���� ���� ��� 
                                                2. non equi join : �ΰ��� ���̺� ���̿� ����� 
                                                                       �÷��� ������ ���� ���ι��
                                                3. outer join :  �ΰ��� ���̺��� ����� �÷��� 
                                                  ������ �����Ϸ��� �÷��� �����Ͱ� ���� ��ġ����
                                                   ������ ����ϴ� ���� 
                                                4. self  join :  �ڱ� �ڽ��� ���̺�� �����ϴ� ����
                2.  1999  ansi ���� ���� 
                              ��
                          american  national  standard  institute  

225.�޿����(grade), �޿���޺��� �ش� �ϴ� ������� �̸��� ���η� ����Ͻÿ�

grade   ename 
 1      ADAMS, JAMES, SMITH 
 2       
 3
 4
 5     KING   

 select  s.grade , listagg( e.ename, ',')  within  group ( order  by e.ename asc) as �̸�
   from   emp  e,  salgrade  s
   where   e.sal  between  s.losal  and  s.hisal
   group  by  s.grade;  

1	ADAMS,JAMES,SMITH
2	MARTIN,MILLER,WARD
3	ALLEN,TURNER
4	BLAKE,CLARK,FORD,JONES,SCOTT
5	KING

226.���� ������� ���޵� ���� ���� ������ �Ͻÿ� !

1	ADAMS(950),JAMES(1100),SMITH(700)
2	MARTIN,MILLER,WARD
3	ALLEN,TURNER
4	BLAKE,CLARK,FORD,JONES,SCOTT
5	KING

select  s.grade , listagg( e.ename ||'(' || sal || ')', ',')  
                                within  group ( order  by e.ename asc) as �̸�
   from   emp  e,  salgrade  s
   where   e.sal  between  s.losal  and  s.hisal
   group  by  s.grade;  

1	ADAMS(1100),JAMES(950),SMITH(800)
2	MARTIN(1250),MILLER(1300),WARD(1250)
3	ALLEN(1600),TURNER(1500)
4	BLAKE(2850),CLARK(2450),FORD(3000),JONES(2975),SCOTT(3000)
5	KING(5000)

?  060 ���� ���̺��� �����͸� �����ؼ� ����ϱ� 3(OUTER JOIN)

  " �����Ϸ��� �� ���̺��� ����� �÷��� deptno �� �����Ͱ� 
    ���� �Ȱ��� ��ġ ���� ���� �� �����ϱ� ���ؼ� ����ϴ� ���� ��� "

��)
��� ���̺��� �μ���ȣ�� ����ϴµ� �ߺ������ؼ� ����Ͻÿ� !

  select   distinct   deptno
   from   emp;

  DEPTNO
--------
      30
      10
      20

��)
�μ�(dept) ���̺��� �μ���ȣ�� ����Ͻÿ� 

  select  deptno
  from  dept; 

227. emp �� dept �� ���� �����ؼ� �̸��� �μ���ġ�� �μ���ȣ�� ����Ͻÿ� !

 select   e.ename,  d.loc, e.deptno 
   from   emp  e,  dept   d
   where  e.deptno = d.deptno ; 

����: ���� ����� ���� 40���� ������ ���� �ʾƼ� ����� ��µ��� �ʾҽ��ϴ�.
       �� ������ �ȵǾ�����?   ��� ���̺� 40�� �μ���ȣ�� ��� �Դϴ�. 

 select   e.ename,  d.loc
   from   emp  e,  dept   d
   where  e.deptno(+) =d.deptno ; 

 ����:      outer join sign (+) ��  ����� ��µɶ� �����Ͱ� ���ڶ� �ʿ� �ٿ��ش�. 
            emp ���̺����� �μ���ȣ�� 10,20,30 ���ְ� 40���� �����ϴ�. 
            dept ���̺��� �μ���ȣ�� 10, 20, 30, 40 �� �ֽ��ϴ�. 

228.  �μ���ġ, �μ���ġ�� ��Ż������ ����Ͻÿ� !

 select  d.loc, sum(e.sal)
   from  emp  e,  dept  d
   where  e.deptno = d.deptno 
   group  by  d.loc; 

LOC                        SUM(E.SAL)
-------------------------- ----------
NEW YORK                         8750
DALLAS                          10875
CHICAGO                          9400

����:  ���� ���ε� ����� ���� �μ���ġ(loc) �ʿ� BOSTON �� �� ���Դϴ�.
        
229.���� ������� BOSTON �� �����ڱ� ���ι����� �����ϼ��� ~

 select  d.loc, sum(e.sal)
   from  emp  e,  dept  d
   where  e.deptno (+) = d.deptno 
   group  by  d.loc; 

LOC                        SUM(E.SAL)
-------------------------- ----------
NEW YORK                         8750
DALLAS                          10875
CHICAGO                          9400
BOSTON

* �츮�� ���̺�� �����ϱ� ���� ���̺��� ���� 
  ( ��Ż� �⺻ ��� ���̺� )

 drop  table  telecom_price;

  create  table   telecom_price
  (   telecom     varchar2(10),
      price         number(10),
     service_cnt   number(10) );

 insert  into   telecom_price   values('sk', 18500,  9 );
 insert  into   telecom_price   values('kt', 17000,  9 );
 insert  into   telecom_price   values('lg', 18000, 10 ); 
 commit; 

230.(���ɽð� ����)
�츮�� ���̺��  telecom_price ���̺��� �����ؼ�  �̸�, ����, ����, ��Ż�
��Ż� �⺻���(price) �� ����ϴµ�  ���̰� 27 �̻��� �л��鸸 ��µǰ��Ͻÿ�!

select e.ename, e.age, e.gender, e.telecom, t.price
   from emp12 e, telecom_price t
          where e.telecom=t.telecom and e.age >= 27;
         

? 061 ���� ���̺��� �����͸� �����ؼ� ����ϱ� 4(SELF JOIN)

     " �ڱ� �ڽ��� ���̺�� �����ϴ� ���� ���� " 

�� �ڱ� �ڽ��� ���̺�� ������ �ؾ��ϴ°� ?   ��� ���̺�� ���� ��� ����̸���
                                                                  �� ����� �����ϴ� �������� �̸���
                                                                    �ϳ��� ����� �� �� �ֱ� �����Դϴ�. 

 ��)
 �����ȣ, ����̸�, ������ ��ȣ(mgr) �� ����Ͻÿ� !

  select  empno, ename, mgr
    from  emp;

                   7839   KING  
                              ��
                 7566  JONES  
                          ��
              7902   FORD   
                       ��
           7369  SMITH 

����)
����̸�,  �ش� ����� �������� �̸��� ����Ͻÿ� ! 

  select   ���.ename,   ������.ename
   from   emp  ���,  emp  ������ 
   where   ���.mgr  = ������.empno; 

231.���� ����� �ٽ� ����ϴµ� �÷�����  �ѱ۷� ���, �����ڶ�� ��µǰ��Ͻÿ�

���                  ������ 
-------------------- -------
BLAKE                KING
CLARK                KING
JONES                KING
MARTIN               BLAKE
ALLEN                BLAKE

  select   ���.ename as  ���,   ������.ename  as  ������
   from   emp  ���,  emp  ������ 
   where   ���.mgr  = ������.empno; 

232.����̸�, �������, �������̸�, �������� ������ ����Ͻÿ� !

 select   ���.ename as  ���,  ���.sal  as �������,  
           ������.ename  as  ������,  ������.sal  as  "�������� ����"
        from   emp  ���,  emp  ������ 
   where   ���.mgr  = ������.empno; 

233.���� ����� �ٽ� ����ϴµ�  ����� ������ �������� ���޺��� �� ū �����
 �� ����Ͻÿ� ! 

 select   ���.ename as  ���,  ���.sal  as �������,  
           ������.ename  as  ������,  ������.sal  as  "�������� ����"
   from   emp  ���,  emp  ������ 
   where   ���.mgr  = ������.empno  and  ���.sal > ������.sal ;

234.�����ں��� ���� �Ի��� ������� ��� �̸��� ��� �Ի���, ������ �̸��� 
 �������� �Ի����� ����Ͻÿ� !

  select   ���.ename,  ���.hiredate,  ������.ename, ������.hiredate
    from   emp  ���,   emp  ������
    where   ���.mgr = ������.empno  and  ���.hiredate  <  ������.hiredate;  
  
235.�������̸��� ����ϰ�  �� ���� �ش� �����ڿ� ���� ������� �̸��� 
���η� ����Ͻÿ� !

select  ������.ename as  ������,  
                listagg(���.ename, ',')   within  group ( order by ���.ename)  as  ���
    from    emp   ���,  emp  ������
    where   ���.mgr = ������.empno
    group  by  ������.ename; 

BLAKE	ALLEN,JAMES,MARTIN,TURNER,WARD
CLARK	MILLER
FORD	SMITH
JONES	FORD,SCOTT
KING	BLAKE,CLARK,JONES
SCOTT	ADAMS


236.����, �̸�, ����, ������ ����ϴµ� ������ ������ ���� �������� ������
�ο��Ͻÿ� ! 

select  job, ename, sal, dense_rank()  over ( order  by  sal  desc ) ����
   from   emp ;

237.���� ����� �ٽ� ����ϴµ� ������ ���� ������ �ο��ǰ� �Ͻÿ� !

select  job, ename, sal, dense_rank()  over (  partition  by   job  
                                                         order  by  sal  desc ) ����
   from   emp ;

238.�μ���ġ, �̸�, ����, ������ ����ϴµ� �μ���ġ���� ���� ������ ������������ ������ �ο��Ͻÿ� ! 

select  d.loc,  e.ename, e.sal, 
          dense_rank()  over  ( partition  by  d.loc
                                     order  by   e.sal  desc) ����
     from  emp  e,  dept   d
     where  e.deptno = d.deptno; 


239.�μ���ġ, �μ���ġ���� ���� ������� �̸��� ���η� ����Ͻÿ� !

select  d.loc, 
         listagg( e.ename,',' )  within  group  ( order  by  e.ename  asc )  ���
  from  emp  e, dept  d
  where  e.deptno = d.deptno 
  group  by  d.loc; 

CHICAGO	ALLEN,BLAKE,JAMES,MARTIN,TURNER,WARD
DALLAS	            ADAMS,FORD,JONES,SCOTT,SMITH
NEW YORK	    CLARK,KING,MILLER
  
240.�μ���ġ, �μ���ġ�� ��Ż������ ����ϴµ� �� �Ʒ��� ��ü ��Ż������
��µǰ��Ͻÿ� 

select  d.loc,  sum(e.sal)
  from  emp  e, dept  d
  where  e.deptno = d.deptno
  group  by  rollup(d.loc) ;

241.����, ������ �ִ����, ������ �ּҿ���, ������ ��տ�����
����Ͻÿ� ! 

select   job,  max(sal), min(sal), avg(sal)
  from  emp
  group  by  job; 

242.�μ���ġ,  �μ���ġ�� �ִ����, �μ���ġ�� �ּҿ���, �μ���ġ�� �ο�����
 ����Ͻÿ� !

select  d.loc, max(e.sal), min(e.sal), count(*)
  from  emp  e,  dept  d
  where  e.deptno = d.deptno
  group  by  d.loc; 

? 062 ���� ���̺��� �����͸� �����ؼ� ����ϱ� 5(ON��)

  * ���� ����  2���� ?    1.  ����Ŭ ���� ����
                                                - equi  join
                                                - non equi  join
                                                - outer  join
                                                - self  join
                                2.  1999 ANSI ���� ���� 
                                                - on ���� ����� ����
                                                - using ���� ����� ���� 
                                                - natural  join
                                                - left/right/full  outer  ����
                                                - cross ���� 
��: 

 1. ����Ŭ equi  join                                   2. on ���� ����� ����
 
  select  e.ename,  d.loc                             select  e.ename, d.loc
    from  emp  e, dept  d                               from  emp  e  join   dept  d
   where  e.deptno = d.deptno ;                       on  ( e.deptno = d.deptno ) ;

243.�̸��� ���ް� �μ���ġ�� ����ϴµ� ������ 2400 �̻��� ����鸸 ���
�Ͻÿ� ! ( on ���� ����� ���� �������� ����)

select  e.ename, e.sal,  d.loc
  from   emp  e   join    dept   d
  on  (  e.deptno = d.deptno)  
  where   e.sal >= 2400 ;   

����: on ���� ����� ���� ������  ���������� on ���� �ְ� �Ǿ��ְ�
         �˻������� where ���� �ְڱ� ������ ���Ҵ�. 

244.DALLAS ���� �ٹ��ϴ� ������� �̸��� ���ް� �μ���ġ�� ������
����ϴµ� ON ���� ����� ���ι������� �����ϼ��� ~

select  e.ename, e.sal, d.loc, e.job
  from  emp  e  join  dept  d
  on  (  e.deptno = d.deptno )
  where   d.loc='DALLAS'; 
  
245.emp ���̺�� salgrade ���̺��� ���� �����ؼ� �̸�, ����, �޿����(grade)
  �� ����ϴµ�  2��޸� ��µǰ��ϰ�   on ���� ����� ���ι������� 
  �����Ͻÿ� !

select  e.ename,  e.sal,  s.grade
  from  emp  e  join  salgrade  s
  on  (  e.sal  between  s.losal  and  s.hisal )
  where   s.grade = 2; 

	?  063 ���� ���̺��� �����͸� �����ؼ� ����ϱ� 5(USING��)

����)
select  e.ename,  d.loc
           from  emp  e  join   dept   d
           using  ( deptno );

246.������ SALESMAN �� ������� �̸��� ���ް� ����, �μ���ġ�� ����ϴµ�
 USING ���� ����� ���ι������� �����Ͻÿ� !

select  e.ename, e.sal,  e.job,  d.loc
  from   emp  e   join  dept   d
  using  ( deptno )
  where  e.job='SALESMAN'; 

?  064 ���� ���̺��� �����͸� �����ؼ� ����ϱ� 6(NATURAL JOIN)

 ��)
 select  e.ename,  d.loc
          from  emp  e  natural  join  dept   d; 
          
����: where �� ���� �����ϰ� �����ϴ� ���� ���� 
        ����Ŭ�� �˾Ƽ� �� ���̺� ���̿� ����� �÷��� �ִ��� ã�ƺ��� �����Ѵ�. 
    
1.����Ŭ ���ι��� : 4���� ���� �� �˰� �־�� �մϴ�.
2. 1999 ansi ���� :  on ���� ����� ���� ������ ���ݺ��� ������ �ƿ��� ���� ������
                          �� �˰� �־�� �մϴ�. 

	?  065 ���� ���̺��� �����͸� �����ؼ� ����ϱ� 7(LEFT/RIGHT OUTER JOIN)

����)  

1. ����Ŭ ���� ����( �ƿ��� ���� )
  select   e.ename, d.loc
    from  emp  e,  dept  d
    where  e.deptno (+) = d.deptno; 

2. 1999 ANSI ���� ����

  select   e.ename,  d.loc
      from   emp  e   right  outer  join  dept   d
      on ( e.deptno = d.deptno ); 

insert   into  emp(empno, ename, sal, job, deptno )
  values( 1221, 'jack', 3500, 'SALESMAN', 70 );

commit;

1. ����Ŭ ���� ����( �ƿ��� ���� )
  select   e.ename, d.loc
    from  emp  e,  dept  d
    where  e.deptno  = d.deptno (+); 

����:dept ���̺��� 70�� �μ��� �����Ƿ� ������ �� equi ������ �ϰ� �Ǹ�
       ����� �ȳ����� outer join �� ����ؾ� �մϴ�. 

247.���� ����� 1999 ansi �������� �����Ͻÿ� !

  select   e.ename,  d.loc
      from   emp  e   left  outer  join  dept   d
      on ( e.deptno = d.deptno ); 

	?  066 ���� ���̺��� �����͸� �����ؼ� ����ϱ� 8(FULL OUTER JOIN)

 ����)
 select  e.ename, d.loc
           from  emp  e,   dept   d
           where  e.deptno (+) = d.deptno (+) ;
                                      *
3�࿡ ����:
ORA-01468: outer-join�� ���̺��� 1���� ������ �� �ֽ��ϴ�

���� ��� ����� �����ϰ� ���ִ� ���� ������ 1999 ANSI �� full outer join �Դϴ�.

select  e.ename,  d.loc
  from  emp  e   full  outer   join   dept   d
   on  ( e.deptno = d.deptno );
    
	* 1999 ansi ������  cross ���� �̶� ?

  where ������ �����ؼ� ��ü�� �� �����ϴ� ���� ���� �Դϴ�.

1. ����Ŭ ���� ����

   select  e.ename, d.loc
    from  emp  e,  dept  d ;

2. 1999 ANSI ����

   select  e.ename, d.loc
      from   emp  e   cross join  dept  d ;

  * ���� ����  2���� ?    1.  ����Ŭ ���� ����
                                                - equi  join
                                                - non equi  join
                                                - outer  join
                                                - self  join
                                2.  1999 ANSI ���� ���� 
                                                - on ���� ����� ����
                                                - using ���� ����� ���� 
                                                - natural  join
                                                - left/right/full  outer  ����
                                                - cross ���� 

248.�츮�� ���̺�� telecom_price �� ������ �ؼ�  �̸��� ������ �л���
 �̸��� ���̿� ��Ż�� ��ſ��(price) �� ����Ͻÿ� !  (ANSI ON�� ���) 

select  e.ename,  e.age,  e.telecom, t.price
  from  emp12  e  join  telecom_price  t
  on  ( e.telecom = t.telecom )
  where e.ename='������'; 

249.���̰� 28 �̻��� �л����� �̸��� ���̿� ��Ż�� ��ſ��(price) ��
 ����Ͻÿ� !


250. (������ ������ ����)   �μ���ġ, �μ���ġ�� ��Ż���� ���η� 
����Ͻÿ�!
 ������� 
NEW  YORK       DALLAS      CHICAGO      <--- �÷���
8750             10875          9400     <--- ������ 


select sum( decode (d.loc, 'NEW YORK', e.sal)) as "NEW YORK",
        sum( decode (d.loc, 'DALLAS', e.sal)) as "DALLAS",
         sum( decode (d.loc, 'CHICAGO', e.sal)) as "CHICAGO"
               from emp e, dept d
                        where e.deptno=d.deptno;