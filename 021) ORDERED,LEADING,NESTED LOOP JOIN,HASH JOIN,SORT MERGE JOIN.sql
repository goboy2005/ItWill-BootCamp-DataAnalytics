�츮�� SQL Ʃ���� ������� ���� �ȴٰ� �ߴ�..SQL Ʃ�� ������ �ε��� SQL Ʃ��
SQL Ʃ�� ������ �ε��� SQL Ʃ��

	1. Index SQL Tunning
	2. Join SQL Tunning
	3. Subquery SQL Tunning
	4. ������ �м��Լ��� �̿��� Tunning
	5. �ڵ� SQL Tunning


2.���� SQL Ʃ�� 
SQL Ʃ���� ��κ��� �����̴�. �׷��� ������ �߾˾Ƶ־� �Ѵ�. �׷��� ������ �Ҹ����� ����.

@@ -44,6 +44,7 @@ SQL Ʃ�� �ð��� ���� ���� ��� 3����?
                                                         2.hash join
                                                         3. sort merge join


���� ����� �� �˾ƾ� �ϴ°�? ������ �ٸ��� �ҷ��� �˾ƾ� �մϴ�. 
�׷��� ��� �ѹ� ������ ���ؼ� ���� ����� �˷��ٰԿ�..

@@ -87,7 +88,6 @@ ordered �ص� ����� �޶����� �ʴ´�..������ ���� ������ ��
�����ȹ�� �����..�ٲ����? emp ���� �о���?? 



�̹����� emp ���̺� ���� �о��� ���۵� �����ߴ�..������ ������ ����� �����ߴ�.

�̰� �Ҷ��� �������̸� ���� �ѹ� ������ ����...�ȵ����� �ߵǸ� ���ΰ��..
@@ -101,17 +101,12 @@ where dept d, emp e
where d.deptno=e.deptno; 



���ǰ��� �������� Ʃ���Ѱ��ε�. ���� ordered ��Ŀ��� ��Ʈ�� ���ϱ� �ſ� �������� 
�������� ���� �ִ� ������ �������� ���� �տ��д°� Ŀ���� ������ �׷��� �̰��� Optimizer �� ������ �� �� �ְ� ���־����� ��������

*���μ��� ���� : emp �� Salgrade ���̺��� �����ؼ� �̸��� ���ް� �޿����(grade) �� ����Ͻÿ� ���μ��� ������ ������ �Ͻÿ�!!

select /*+ gather_plan_statistics ordered*/e.ename, e.sal, s.grade
from salgrade s, emp e
where e.sal between s.sal s.losal and s.hisal ;


���� ������ �����ϴ� ��Ʈ 2����?
                 1.ordered : from������ ����� ���̺� ������� �����ض�~
                 2.Leading: Leading ��Ʈ �ȿ� ����� ���̺� �������� �����ض�~
@@ -154,12 +149,13 @@ where e.sal between s.losal and s.hisal;

46. 45 �� ������ �����ȹ�� nested loop ������ �ǰ� ��Ʈ�� �ֽÿ�!!

Ʃ����
select/*+  gather_plan_statistics leading(s e)*/e.ename,e.sal,s.grade
from salgrade s, emp e
where e.sal between s.losal and s.hisal;

                   ��

Ʃ����
select/*+  gather_plan_statistics leading (e d) use_nl(e d)*/e.ename,e.sal,s.grade
from dept d, emp e
where d.dept=e.dept 
@@ -174,10 +170,12 @@ select *from table(dmbs_xplan.display_cursor(null,null,'ALLSTATS LAST)');

47. 46���� ������ ���� ������ �����ȹ�� nested loop ������ �ǵ��� �ϴ� ���μ����� dept -----emp ���� �ǵ��� �Ͻÿ�! 

Ʃ����
select /*+  gather_plan_statistics leading (e d) use_nl(e d)*/e.ename,e.sal,s.grade
from dept d, emp e
where d.dept=e.dept 
         ��
Ʃ����
select /*+ gather_plan_statistics leading (d e) use_nl(d e)*/e.sal,e.job,d.loc
from dept d, emp e
where d.deptno=e.deptno ;
@@ -195,9 +193,6 @@ where e.sal between s.losal and s.hisal;

select *  from table(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));




���� Ȯ���غ��� salgrade ���� Ž���ϰ� �״����� emp �� Ž���ϴ°��� ���� �ִ�.

49.�̸��� SCOTT�� ����� �̸��� ���ް� �μ���ġ�� ����ϴ� ���� ������ �ۼ��Ͻÿ�
@@ -225,11 +220,12 @@ where e.deptno=d.deptno and ename='SCOTT';
51.�Ʒ��� ���ι����� ���μ����� EMP ---- �� dept �� �����ϰ� ���� ����� 
nested loop ������ �ǵ��� ��Ʈ�� �ְ� Ʃ���Ͻÿ�! 

Ʃ����
select e.ename,e.sal,d.loc
from emp e , dept d
where e.deptno=d.deptno and e.ename = 'SCOTT';
                     ��

Ʃ����
select /*+ gather_plan_statistics leading (e d) use_nl(e d)*/e.ename,e.sal,d.loc
from emp e , dept d
where e.deptno=d.deptno and e.ename = 'SCOTT';
@@ -264,7 +260,7 @@ select /*+ gather_plan_statistics leading (d e) use _nl(e)*/e.ename,e.sal,d.loc
from dept d, emp e
where e.empno=d.deptno

���ɽð����� 53.  SQL Ʃ������ ���ٰԿ�! �Ʒ��� SQL�� ������ �����ȹ�� ���ü� �ֵ��� Ʃ���Ͻÿ�!
���ɽð����� 53.SQL Ʃ������ ���ٰԿ�! �Ʒ��� SQL�� ������ �����ȹ�� ���ü� �ֵ��� Ʃ���Ͻÿ�!

Select e.ename,e.sal,s.grade 
          from emp e, salgrade s
@@ -286,7 +282,7 @@ and s.grade=1;

���� : Leading ��Ʈ�� ����ߴ� ���̺� ��Ī�� �ι�° ��Ī�� use_nl �� ����ϸ� �˴ϴ�.

Ʃ����: 
Ʃ����
select /*+ gather_plan_statistics leading (s e) use_nl (e) */ e.ename,e.sal,s.grade
from emp e , salgrade s
where e.sal between s.losal and s.hisal
@@ -304,7 +300,7 @@ and e.sal between s.losal and s.hisal;
select e.ename,e.sal,d.loc,s.grade
from emp e ,dept d sal

55. ���� SQL �� ���� ������ ����� �Ʒ��� ���� �ǰ� �Ͻÿ�!  (3���� ���� Ʃ��)
55.���� SQL �� ���� ������ ����� �Ʒ��� ���� �ǰ� �Ͻÿ�!  (3���� ���� Ʃ��)

dept ----- salgrade -----emp  �� �̷��� ������ ���ϰ� ������ dept�� salgrade�� ��  
                                             �� ������� ��� �̷����ϸ� �ȵȴ�. 
@@ -343,8 +339,7 @@ from emp e, dept d, salgrade s
where e.deptno = d.deptno
and e.sal between s.losal and s.hisal; 

select *  from table(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));

select  *  from table(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));

������ �ƴ°��� �߿��ϴ١�.

@@ -367,7 +362,7 @@ AND ename='KING' ;
                       ��
                �� �ΰ��� ������ ����� ///       salgrade �� �����ϴ°���. 

59. ���� SQL �� ���� ������ �Ʒ��� �����ϰ� ���ι���� ���� nested loop join �ǰ� �Ͻÿ�!!!
59.���� SQL �� ���� ������ �Ʒ��� �����ϰ� ���ι���� ���� nested loop join �ǰ� �Ͻÿ�!!!

���� : emp ���̺��� ename �� KING �� �����Ͱ� 1���̹Ƿ� 1�Ǹ� �о dept ���̺�� �����ϰ� dept ���̺� �����ؼ� �μ���ġ�� �������� 
���������� salgrade ���̺� �����ؼ� �μ���ġ�� �������� emp �� dept ���̺�� ������ ����� salgrade ���̺�� �����մϴ�. 
@@ -379,8 +374,8 @@ where e.deptno=d.deptno
and e.sal between s.losal and s.hisal
AND ename='KING' ; 

select *  from table(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));

select *  from table(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));

60.CHICAGO ���� �ٹ��ϴ� ������� �̸��� �μ���ġ�� ���ް� �޿������ ����Ͻÿ�(SQL����)

@@ -434,7 +429,6 @@ from emp e , dept d
where e.deptno=d.deptno and e.job ='SALESMAN';



�ֳ׵��� ��� �μ����� ���ϴ��� �Ѹ� ���� Ȯ���� �Ѵ�.
�׷��� �뷮�� �����͸� ó���ϰԵǸ� ������ �������ٴ� ������ �����Ѵ�.
���������� �ϳ��� ó���ϴ� ����..ó������ martin�� �����ͷ� �����ϰ�
@@ -449,7 +443,7 @@ hash ������ �����̳�..�ؽ� ������ �ؽ� �˰����� �̿���

��뷮 �޸𸮸� �����Ҷ��� HASH ������ ������.

����
����)
select /*+ gather_plan_statistics leading(d e) use_hash(e)*/
e.ename , e.loc
from emp e ,dept d
@@ -458,7 +452,7 @@ where e.deptno=d.deptno

�ؽ������� �Ȱ��� ���� �ִ�.

HASH JOIN
*HASH JOIN

dept ���̺�� emp ���̺��� �Ѵ� �޸𸮷� �ö󰡴µ� �޸𸮿��ѹ���  �ö󰡴µ�
�Ѵ� �ѹ��� �� �ö󰡼� ������ �ϸ� �ʹ� ���� �ٵ� �׷��Դ� �ȵǰ�
@@ -486,7 +480,8 @@ table acess full emp ---- probe table(��ũ�� �ִ� ���̺�)
                             2. ��뷮�� ��쿡�� hash ���̺���! 

64.�Ʒ��� SQL�� Ʃ���ϴµ� �ؽ� ���εǰ� �ϰ� emp ���̺��� �޸𸮷� �ö󰡼� hash ���̺��� �ǰ��ϼ���.
                                       ��

				     ��

select /*+ gather_plan_statistics  leading(e d) use_hash(d)*/ 
e.ename,d.loc
@@ -631,7 +626,7 @@ sort merge join �� ����ϸ� �˴ϴ�.
�׷��� sort merge ���� �����ϸ� ������� �Ǵ� Ű �÷�(deptno)�� �����س��� 
������ �մϴ�.

����
����)
select /*+ gather_plan_statistics leading(d e) use_merge(e) */
e.ename,d.loc,e.deptno
from emp e,dept d
@@ -659,3 +654,4 @@ select /*+ gather_plan_statistics leading(s e) use_merge(e) */
e.ename,e.sal,s.grade
from emp e, salgrade s
where e.sal between s.losal and s.hisal