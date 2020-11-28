SQL Day2 Problems

�� Q-314.  dept ���̺���  ����Ͻÿ� 

 create  table   dept_backup
 as
  select *
   from  dept; 

�� Q-315.  dept ���̺��� truncate �Ͻÿ� 

 truncate   table  dept; 

�� Q-316.  dept ���̺��� dept_backup ���̺��� �̿��ؼ� �����Ͻÿ� 

insert   into  dept
 select  *
   from  dept_backup;


�� Q-317.  ALLEN ���� �� �ʰ� �Ի��� ������� Ŀ�̼��� 9000���� 
�����Ͻÿ� !

update emp
set comm = 9000
where hiredate > (select hiredate
                         from emp
                         where ename ='ALLEN');

�� Q-318.  SMITH �� ���� ������ ���� ������� ������ 9800���� 
 �����Ͻÿ� ! �׷��� SMITH �� �����Ͻÿ� !

update emp
set sal = 9800
where job = (select job
		from emp
		where ename = 'SMITH') 
and ename != 'SMITH';

�� Q-319.  ALLEN �� ������  KING �� �������� �����Ͻÿ� !

 update  emp
   set  sal  =  (  select   sal 
                        from  emp
                        where  ename='KING' ) 
   where   ename='ALLEN';

�� Q-320.   JONES ���� ������ ���� ������� ������ MARTIN �� 
 �������� �����Ͻÿ� !

 update   emp
   set   job =  (select   job
                       from  emp
                       where  ename='MARTIN' )
  where   sal  > ( select  sal
                          from  emp
                          where  ename='JONES' );


�� Q-321.  ALLEN ���� �ʰ� �Ի��� ������� �����Ͻÿ� !

 delete  from  emp
  where  hiredate > ( select   hiredate
                               from  emp
                               where  ename='ALLEN' );
 rollback;

�� Q-322.  JONES �� ���� �μ���ȣ���� ���ϴ� ������� �����Ͻÿ� !
 �׷��� JONES �� ���ܽ�Ű�ÿ� 



�� Q-323.  �μ���ȣ, �μ���ȣ�� �ο����� ����Ͻÿ� !(���� ���)

 select  deptno, count(*)  �ο��� 
  from  emp
  group  by deptno; 

�� Q-324.  �μ����̺� cnt ��� �÷��� �߰��Ͻÿ� !

 alter   table  dept
   add   cnt    number(10);

 select   deptno, cnt
   from  dept; 

�� Q-325. ���� dept ���̺� �߰��� cnt �÷��� �ش� �μ���ȣ�� �ο�����
���� �����Ͻÿ� ! 

merge into dept d
using ( select  deptno, count(*)  �ο��� 
           from  emp
           group  by  deptno )  e
on ( e.deptno = d.deptno )
when matched then
update set d.cnt = e.�ο���;




����:  using ���� ����� ������������ ����� ��ġ ���̺�ó�� �� merge
        ������ ���ǰ� �ִ�. 
