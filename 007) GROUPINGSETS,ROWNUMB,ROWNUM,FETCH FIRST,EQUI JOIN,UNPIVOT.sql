1. �⺻ select ���� 6������ 

  5 select    ������� �÷���
  1 from     �����Ͱ� ����ִ� ���̺�� 
  2 where     �˻����� 
  3 group by   �׷����� �÷���
  4 having     �׷��Լ��� ���� �˻� ���� 
  6 order  by  ������ �÷��� 

2. �Լ� :   �������Լ�:  ����,����, ��¥, ��ȯ, �Ϲ�
             �������Լ�: max, min, avg, sum, count
             (�׷��Լ�)

�׷��Լ��� Ư¡?  1. null ���� �����Ѵ�.
                 2. where ���� ������ �����̾ ����� ���� �Ѵ�.

��)
select  sum(sal)
        from  emp
           where  1 = 2;     

 �׷��Լ� �ۼ��ÿ��� where ���� ������ �� ����ؾ� �մϴ�. 

3. ������ �м� �Լ�:          1. rank    :  ���� ���
                             2. dense_rank : ���� ���
                             3. ntile  :  ��� ���
                             4. cume_dist :  �������
                             5. listagg   :  �����͸� ���η� ���
                             6. sum(�÷���) over (����) : ���� ������ ���
                             7. ratio_to_report : �������
                             8. rollup :   ���� ����� �� �Ʒ��� ���
                             9. cube  :   ���� ����� �� ���� ��� 
 
 ������ �м��Լ��� �̿��ϸ� �츮�� �������� �ʼ��� �˻��ؾ��ϴ� 
 �����͸� �� SQL �� �ۼ����� �ʰ� ������ �Լ��� �̿��ؼ� �� ���� 
 �ֽ��ϴ�.

����Ŭ ������ �����丮 
8 --> 8i -->9i --> 10g -->11g --> 12c --> 18c --> 19c
         ��              ��                   ��
    internet          grid                cloud
                         
                 ��
                ������ ������ �������� ��ǻ�͸� ������ �ٿ��� 
               ��ġ ������ ���� ���� ū ����ó�� ��ϴ� ���

188.����, ������ ��Ż������ ����Ͻÿ� !

SQL> select  job,  sum(sal)
       from  emp
       group  by  job;

189.�׷��� ���� ����� �ٽ� ����ϴµ� �� �Ʒ��� ��ü ��Ż������
 ��µǰ��Ͻÿ� !

select  job, sum(sal)
  from  emp
     group by rollup(job);

190.�Ʒ��� job �Ǿƿ� null �� ������ �κп� ��Ż��: �̶�� �ѱ۷�
 null ��ſ� ��µǰ��Ͻÿ� !

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

191.���� ����� �ٽ� ����ϴµ� �÷����� �Ʒ��� ���� ��µǰ�
 �Ͻÿ� !

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

192.���� ����� �ٽ� ����ϴµ� �Ʒ��� ���� ��Ż���� �κп�
 õ������ �ο��Ͻÿ� !

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

? 054 ������ �м� �Լ��� ���� ��� ����ϱ� 3(GROUPING SETS)

     " �������� ����ϴ� ������ �м� �Լ��Դϴ�."

����)
select   deptno,  sum(sal)
          from   emp
          group  by  grouping  sets( deptno,  () )  ; 
                                               ��       ��
                                            �μ���ȣ  ��ü 
 DEPTNO   SUM(SAL)
------- ----------
     10       8750
     20      10875
     30       9400
              29025

193.����, ������ ��Ż������ ����ϴµ� �� �Ʒ��� ��ü ��Ż������
 ��µǰ� �Ͻÿ� ! (grouping sets �� �̿��ؼ� ����)

select  job,  sum(sal)
  from  emp
  group  by  grouping  sets(  job, () ); 

194.�μ���ȣ�� ������ ����ϰ� �� ���� �μ���ȣ�� ������ 
 ��Ż������ ����Ͻÿ� !

 select  deptno,  job,  sum(sal)
   from  emp
     group  by  deptno, job; 

����: select �� �� �׷��Լ��� �Բ� ������ �÷����� �ݵ�� group by ����
        �������� ������ ���� �ʰ� ��µ� �� �ִ�. 

195.�μ���ȣ�� ������ ����ϰ� �� ���� �μ���ȣ�� ������ ��Ż����
 �� ����ϰ� ���ÿ� �μ���ȣ�� ��Ż���޵� �߰��߰� ��µǰ�
 �Ͻÿ� !

select   deptno,  job, sum(sal)
    from  emp
        group   by   grouping  sets (  (deptno, job), (deptno) );  

196.���� ����� �� �Ʒ��� ��ü ��Ż������ ��µǰ��Ͻÿ� !

select   deptno,  job, sum(sal)
   from  emp
     group   by   grouping  sets (  (deptno, job), (deptno), () );  

197.�����ȣ,  ��� �̸�, ������ ����ϴµ�  �� �Ʒ��� ��ü��Ż����
 �� ����Ͻÿ� !

 select  empno, ename, sum(sal)
   from   emp
 group  by grouping sets((empno,ename),());

 �׷��Լ��� grouping sets �� ���� ¦���̾ grouping sets �� ��µ�
  select ���� group �Լ��� �Ⱦ��� �ȵȴ�. 

����:  �����ȣ�� �ߺ����� �ʱ� ������ grouping sets �Լ��� 
        ��ȣ�ȿ� grouping ����� �־ �׳� �ڱ� ������ ��µǰ� �ȴ�.
       �ֳ��ϸ� �� �Ѱ��̱� �����̴�.  �� �Ѱ��� �����غ��� �� ���� �ȴ�.
       �׷��� �ڽ��ְ� (empno, ename) �̶�� �ۼ��Ѱ��̴�. 
       �׸��� �� ���� () �� ��ü ��Ż������ ����ϴ°� �Դϴ�. 

198. �츮�� ���̺��� ��Ż�, �̸�, ���̸� ����ϴµ� 
�߰��߰� ��Ż纰 ��Ż���̰� ��µǰ��Ͻÿ� !

 select telecom, ename, sum(age)
  from emp12
  group  by  grouping sets( (telecom, ename), (telecom) )

 select telecom, ename, sum(age)
  from emp12
  group  by  grouping sets( (telecom, ename), (telecom), () );

199.�Ի��� �⵵(4�ڸ�),  �Ի��� �⵵�� ��Ż������ ����ϴµ�
��ü ��Ż������ �� �Ʒ��� ��µǰ��Ͻÿ� !

1. rollup 

select  to_char(hiredate,'RRRR'), sum(sal)
  from  emp
    group  by  rollup( to_char(hiredate,'RRRR')  )

2. grouping sets 

select to_char(hiredate, 'RRRR'), sum(sal)
 from emp
    group by grouping sets ( to_char(hiredate, 'RRRR'), () );

200. ���� ����� �ٽ� ����ϴµ� �Ʒ��� ���� õ������ �ο��ؼ� ����Ͻÿ�
TO_CHAR(   SUM(SAL)
--------     ------------
1980              800
1981            22,825
1982            4,300
1983            1,100
                29,025

select to_char(hiredate, 'RRRR'), to_char( sum(sal), '999,999') 
 from emp
   group by grouping sets ( to_char(hiredate, 'RRRR'), () );

201.�Ի��� �⵵(4�ڸ�), �μ���ȣ, �Ի��� �⵵�� �μ���ȣ�� 
��Ż������ ����Ͻÿ� !

select   to_char(hiredate,'RRRR'), deptno, sum(sal)
  from  emp
     group  by  to_char(hiredate,'RRRR'), deptno; 

202.( ���ɽð� ���� )  zoom ���� ��� �л����� ī�信 �ø���
 offline �� ī�信 �ø��� �Ļ��Ϸ� ������ ~~

   �Ի��� �⵵(4�ڸ�), �μ���ȣ, �Ի��� �⵵(4�ڸ�)�� �μ���ȣ�� ��Ż����
  �� ����ϴµ� �߰��߰� �Ի��� �⵵(4�ڸ�)�� ��Ż������ ��µǰ��ϰ�
  �� �Ʒ��� ��ü ��Ż������ ��µǰ� �Ͻÿ�! 

�ø��� �е��� ���ɽĻ� �Ͻð� ~   1�� 40�п� �����ϰڽ��ϴ�.  

? 055 ������ �м� �Լ��� ��� ��� �ѹ��� �ϱ�(ROW_NUMBER)

 "��°���� �� �տ� ���ڸ� ���ʵ��� �ο��ϴ� �Լ�"

��)
select   row_number()  over (order by empno) , empno, ename
            from  emp;

 �̷��� row_number() �Լ��� ����ϸ� ���� �����ϳĸ� 
 ��µǴ� ���� ������ 3���� �ุ �����Ͷ� �Ǵ� ������ �ϳ��� �ุ
 �����Ͷ� ��� �˻��� �� �����ϴ�.  �ζ��κ�(from ���� ��������) ��
 ���� �˻� �� �� �ֽ��ϴ�.

203.������ SALESMAN �� ������� �̸��� ������ ����ϴµ�
 row_number �Լ��� ����ؼ� �� �տ�  ��ȣ ���ʵ��� �ο��ǰ��Ͻÿ� !

select row_number()  over  ( order  by  empno asc ) ��ȣ,ename,  job
   from   emp
      where  job='SALESMAN'; 

����: order by ������ empno ���ᵵ �ǰ� ename �� �ᵵ �ǰ� 
        �����ϰ� �������� �÷��� ����ϸ� �ȴ�. 
        order by empno ������ asc �� �Ⱦ��� �⺻���� asc �̴�. 

204.������ SALESMAN �� ������� �̸��� ���ް� ������ ����ϴµ�
  �� �տ� row_number() �Լ��� �Ἥ ��ȣ�� �ο��ǰ��Ͻÿ�
  (������ ������������ ��µǸ鼭 ��ȣ�� �ο��ǰ��Ͻÿ�) 

select  row_number()  over  (order by sal desc) ��ȣ,
         ename, sal, job
           from  emp
              where  job='SALESMAN'; 

����: ���� ������� ��ȣ 1���� ����ϴ°��� �ζ��κ並 �����
        �� �� �ֽ��ϴ�.

? 056 ��µǴ� �� �����ϱ� 1(ROWNUM)

  "rownum �� �̿��ϸ� ��µǴ� ���� ������ ������ �� �ֽ��ϴ� "

����)
select   rownum,  empno, ename, sal
            from  emp; 

����:  row_number() �Լ��ʹ� �ٸ��� �ζ��κ�(from ���� ��������)�� ������� �ʰ�
        ���� 3���� �ุ �����Ͷ� ���� ������ �˻��� �� �� �ִ�.

select  rownum,  empno, ename, sal
  from  emp
 where   rownum <= 3;  

��뷮 ���̺��� �����Ͱ� �ִ� ���̺��� ������ ��¦ ���� �ʹٸ�  rownum �� ����ؼ�
����� �����͸� ���� ���ÿ� ! 

 select  *
  from  emp 
  where  rownum <= 10;  

205. ������ SALESMAN �� ������� �������� 2���� ����Ͻÿ� !
 ( ����̸�, ������ ������ ����Ͻÿ�)

select  rownum, ename, job, sal
  from   emp
  where  job='SALESMAN'  and  rownum <= 2;

206. ���� ������� �ѰǸ� ��µǰ��Ͻÿ� !

 select  rownum, ename, job, sal
   from   emp
   where  job='SALESMAN'  and  rownum = 1;

�Ʒ��� SQL�� ����� �����ϴ�. 
 select  rownum, ename, job, sal
    from   emp
      where  job='SALESMAN'  and  rownum = 2;

�ֳ��ϸ�?  rownum ������ �ε�ȣ �񱳿� ���� ����ؾ� �մϴ�.
              ��ȣ �񱳴� ���� 1�� �� �˴ϴ�.  

���࿡ �츮 �ǹ��տ� �������� ���� �̴Ϲ����� �ִµ� �տ� ���忡
����鿡�� �� ������ Ż ����� ���� ���� Ż ����� Ÿ���� ~ ��� �ϸ�
���ϸ��� �޷��� ����� Ÿ�� �ȴ�. �׷��� �� ������ 2��°�� Ż ��� 
Ÿ����~ ��� �ϸ� �� �ӹ��Ÿ��� ��Ż�� �Դϴ�. ������ �Ѹ��� ���� ����
�ι�°�� �� �� �ֽ��ϴ�. 

 select  rownum, ename, job, sal
   from   emp                                  
     where  rownum between  2 and 5;

����:������ ���� SQL �� ����� ������ �ζ��κ並 ����ؾ� �մϴ�. 


207.�츮�� ���̺��� �����͸� �������µ� ���� 3�Ǹ� �����ͼ� ����Ͻÿ�!
 ( ��� �÷��� �� ���������� ~ )

select  *
  from  emp12
  where  rownum <= 3; 

? 057 ��µǴ� �� �����ϱ� 2(Simple TOP-n Queries)

  " order by ������ ����ؼ� �˻��ϴ� SELECT ���� ��µǴ� ����
    �Ϻθ� ������ �� ����ϴ� ���� "

��)
select   rownum , empno, ename, sal
       from  emp
       order  by   sal  desc; 

����: order by �� ����Ǳ� ����  rownum �� �ο��Ǿ ��ȣ�� ���׹���
       ������. 

����)
��� ���̺� ������ ���� ��� 4�� ����Ͻÿ�. �̸��� ������ ����Ͻÿ�!
         
3 select  rownum, ename,  sal
  1 from  emp
  2 where  rownum <= 4
  4 order by  sal  desc; 

����:  ����� ��µ��� �ʾҴ�.  �� ��µ��� �ʾҳĸ� ���� ���� �����Դϴ�. 
        emp ���̺��� ������ 4�� �����ͼ� �� 4������ ������ ���� ��������
        �����߱� �����Դϴ�. ���� ����� ����� ������ �Ʒ��� ���� top n query ��
        �ۼ��ؾ� �մϴ�. 

4      select  ename, sal
 1     from   emp
 2     order  by  sal   desc
 3     fetch  first  4  rows  only;  

����:  fetch �� �˻����� �������� �����͸� �����Ͷ� ��� ���̴�. 
       first  4 rows  only  �� �����ε� ���߿� 4���� �ุ �����Ͷ� ~ ��� ���Դϴ�.

208.�츮�ݿ� ���̰� ���� ���� �л����� �̸��� ���̸� ����ϴµ� �� 5��
����Ͻÿ� !

 select   ename,  age
   from   emp12
   order  by  age  desc
   fetch  first  5 rows  only; 

209.  ����, ������ ��Ż������ ����ϴµ�  ������ ��Ż������ �����ͺ��� ����ϰ�
 ���ʿ� 2���� �ุ ����Ͻÿ� ! 

select  job,  sum(sal)
  from   emp
  group  by  job 
  order  by  sum(sal)  desc
  fetch  first   2  rows  only;  

? 058 ���� ���̺��� �����͸� �����ؼ� ����ϱ� 1(EQUI JOIN)

  " ������ �̿��ϸ� �ΰ� �̻��� ���̺���� �÷����� �ϳ��� ����� ��Ƽ� �� �� ��
    �ֽ��ϴ�. " 

����:  select  *
           from  dept;   <--- �μ� ���̺� 

  deptno : �μ���ȣ
  dname :  �μ���
  loc      : �μ���ġ

����)
�̸�, �μ���ġ�� ����Ͻÿ� !

  select  ename,  loc
    from  emp,  dept  ; 
 
����: 14��  x  4 �� = 56 �� �� �Ǿ �� ������ ��� �Դϴ�.

  select  ename,  loc
    from  emp,  dept  
    where  emp.deptno = dept.deptno ;  <--- ���� ������ where ���� ����ؾ�
                                                           ��Ȯ�� ����� �� �� �ֽ��ϴ�. 

����:  ���������� ��� ������ �� �� �ֽ��ϴ�. 
        emp ���̺��� deptno �� dept ���̺� deptno �� �����ϴ�. ��� ����Ŭ����
       �˷��ָ鼭  �� �÷����� �ΰ��� ���̺��� ���� ����(join) �ϴ� ���Դϴ�. 

210.������ SALESMAN �� ������� �̸��� ���ް� ������ �μ���ġ�� ����Ͻÿ�!

 select  ename, sal, job, loc
  from   emp,  dept 
  where emp.deptno = dept.deptno                  and  job='SALESMAN' ; 
              ��                                                                     ��                          
         �������� ( �ΰ��� ���̺��� ���� ������ �ִٶ�� ���� )   �˻����� 

211.������ 2000 �̻��� ������� �̸��� ���ް� �μ���ġ�� ����Ͻÿ� !

select   ename, sal, loc
   from   emp,   dept  
  where   emp.deptno = dept.deptno  and  sal >= 2000; 

212.���� ������� �̸�, ����, �μ���ġ ���� �μ���ȣ�� ���� ����Ͻÿ� !

select   emp.ename, emp.sal, dept.loc, emp.deptno 
   from   emp,   dept  
  where   emp.deptno = dept.deptno  and  sal >= 2000; 

����:  emp.deptno ��� �ۼ������ν� emp ���̺� �ִ� �μ���ȣ�� �����Ͷ� ~
        ��� ������մϴ�.
        ������ ���� �ʴ´ٰ� �÷��� �տ� ���̺���� ���� �ʴ� ������ ������
        ������ ���ι��忡���� �÷��� �տ�  ���̺���� �����ݴϴ�.
        ���̺��.�÷��� ���� �ۼ������ �˻��ӵ��� �� �������ϴ�. 

select   emp.ename, emp.sal, dept.loc, emp.deptno 
   from   emp,   dept  
  where   emp.deptno = dept.deptno  and  sal >= 2000; 

      �� �ڵ带 ���� �����ϰ� �ۼ� 

select   e.ename, e.sal, d.loc, e.deptno 
   from   emp   e ,   dept    d
  where   e.deptno = d.deptno  and  e.sal >= 2000; 

����:  emp �� e ��� �ϰ� dept �� d ��� ��Ī�� �־ ��Ī�� ����ؼ� �ڵ��� �ϸ�
        ���� �����ϰ� ���ι����� �ۼ��� �� �ֽ��ϴ�.

select   emp.ename, e.sal, d.loc, e.deptno 
   from   emp   e ,   dept    d
      where   e.deptno = d.deptno  and  e.sal >= 2000; 

����: ���� ������ ������ ���ϴ�. �ֳ��ϸ� emp �� e �� ����Ǿ��� �����Դϴ�.

213.������ 1000 ���� 3000 ������ ������� �̸��� ���ް� �μ���ġ�� ����Ͻÿ� !

select  e.ename,  e.sal,  d.loc
 from  emp  e,  dept  d
 where   e.deptno = d.deptno  and  e.sal  between  1000 and 3000;

214.�����ȣ�� 7788, 7902, 7369���� ����� �����ȣ�� �̸��� ���ް� �μ���ġ��
 ����Ͻÿ� !

select  e.ename, e.sal, d.loc
  from   emp   e,   dept   d
  where   e.deptno = d.deptno  and   e.empno  in  ( 7788, 7902, 7369 );

����: �ϳ��� ���� ���� ���� = �� ��������� �������� ���� �˻��ؼ� ���Ϸ���
         in �� ����ؾ� �մϴ�. 

215.�̸��� ù��° ö�ڰ� S �� �����ϴ� ����� �̸��� ���ް� �μ���ġ��
����Ͻÿ� !

 select  e.ename, e.sal, d.loc
  from  emp  e,  dept   d
  where  e.deptno = d.deptno  and  e.ename  like  'S%';


                  ��������                       �˻����� 

����: �ΰ� �̻��� ���̺��� ����(��ġ��)�� �Ϸ��� �ݵ�� ���������� where ����
       ����ؾ� �մϴ�.         
                               

216.DALLAS ���� �ٹ��ϴ� ������� �̸��� ������ �μ���ġ�� ����Ͻÿ� 

 select   e.ename,  e.job,  d.loc
   from   emp  e,  dept   d
   where   e.deptno = d.deptno  and  d.loc='DALLAS';

217.�μ���ġ,  �μ���ġ�� ��Ż������ ����Ͻÿ� ! 

  select  d.loc,  sum(e.sal)
     from   emp  e,  dept   d
     where  e.deptno = d.deptno  
     group  by  d.loc; 

218.�μ���ġ, �μ���ġ�� ��տ����� ����ϴµ� �Ҽ��� ���ϴ� �ȳ����� �ݿø��� �ϰ�
    �μ���ġ�� ��տ����� �����ͺ��� ����ϰ� �μ���ġ�� ��տ����� ��µɶ���
    õ������ �ο��Ͻÿ� ~

select d.loc, to_char(round(avg(e.sal)), '999,999')
 from emp e, dept d
 where d.deptno = e.deptno
 group by d.loc
 order by 2 desc;

? 049 ROW�� COLUMN���� ����ϱ�(UNPIVOT)

 Pivot �� :  ���� ----> ����
 unPivot ��:   ���� ----> ���� 

* order2 ��� ���̺��� �����ϰ� �����͸� 3�� �Է��Ѵ�. 

1. ���̺� ���� ��ũ��Ʈ
create table order2
( ename  varchar2(10),
  bicycle  number(10),
  camera   number(10),
  notebook  number(10) );

2. ������ �Է� ��ũ��Ʈ 
insert  into  order2  values('SMITH', 2,3,1);
insert  into  order2  values('ALLEN',1,2,3 );
insert  into  order2  values('KING',3,2,2 );
commit;

3. order2 �� �˻��غ���.

select  * from  order2; 

����)
select  *
    from  order2
        unpivot ( �Ǽ�  for   ��ǰ  in ( BICYCLE  ,  CAMERA ,  NOTEBOOK )  );

����: ����(�÷�) ---> ����(������)
        ���� SQL ���� �Ǽ��� ��ǰ�� SQL �ۼ��ڰ� �������� �̸��� ����ص� �Ǵµ�
        �̸� ���µ��� �״�� �÷������� ����� �ȴ�. �׸���  BICYCLE  ,  CAMERA , 
         NOTEBOOK �� ���ʿ� �̱� �����̼� ��ũ�� �ѷ����� �ʾƵ� �˴ϴ�. 