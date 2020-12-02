SQL Day14 Problems 

389.��� ���̺� ���� �ε����� �����ϰ� ��� ���̺��� �˻��ϴµ� 
������ 3000�� ������� �̸��� ������ �˻��Ͻÿ�

create index emp_sal
on emp(sal);

select rowid,sal,ename
from emp
where sal=3000;

390.���� SQL�� ���� ��ȹ�� Ȯ���Ͻÿ�! ----SQL�� �����ϱ� ���ؼ� ��ȹ�� ����� SQL�� �����Ѵ�. 

explain plan for
select ename,sal
from emp
where sal>3000;

select* from table (dbms_xplan.display);

(�̰͵� ���������� F10������ Ȯ�ε� �����ϴ�) 

391.���� SQL�� emp_sal�� �ε����� ���ؼ� �����͸� �˻��Ҽ� �ֵ��� ��Ʈ�����.

explain plan for
select/*+ index(emp emp_sal)*/ ename sal
from emp
where sal=3000;

select* from table(dbms_xplan.display);


392.�Ի��Ͽ� index �� �����ϰ� 81�� 11��17�Ͽ� �Ի��� ����� �̸��� �Ի����� ��ȸ�Ͻÿ�

create index emp_hiredate
on emp(hiredate);

select ename,hiredate
from emp
where hiredate='81/11/17';

392.�Ի��Ͽ� index �� �����ϰ� 81�� 11��17�Ͽ� �Ի��� ����� �̸��� �Ի����� ��ȸ�Ͻÿ�

explain plan for
select hiredate
from emp
where hiredate='81/11/17';

393.���� SQL�� ���� ��ȹ Ȯ���ϰ� ��Ʈ ���

explain plan for
select /*+ index(emp emp_hiredate)*/ hiredate
from emp
where hiredate='81/11/17';

select*from table(dbms_xplan.display);


394.�̸��� ������ ����ϴµ� ������ ���� ������� ����Ͻÿ�

select /*+ index_desc(emp emp_sal)*/ename,sal
from emp
where sal >= 0;
        ��
INDEX �� Where ���� �ʼ� �̴�! 

395.�Ʒ��� SQL�� Ʃ���Ͻÿ�! 
Ʃ���� : select ename,hiredate
            from emp
            order by hiredate desc;

Ʃ���� :
create index emp_hiredate
on emp(hiredate);

select /* index_desc(emp_hiredate)*/ ename,hiredate
from emp
where hiredate >= to_date('9999/12/31,'RR/MM/DD');

select*from ta


396.��� ���̺� ������ �ε����� �����Ͻÿ�!
create index emp_job
on emo(job);

397.�Ʒ��� SQL�� Ʃ���Ͻÿ� 
Ʃ����
select ename,job   
 FROM emp  
WHERE substr(job,1,5) ='SALES' 
           ��
Ʃ����
select /* index(emp emp_job)*/ename,job


400.������ �ε����鵵 ���� drop �Ͻÿ�
	
	drop index emp_job;
	
	drop index emp_sal;
            


401. ������� emp_backup_2020111�� �����͸� emp���̺� �Է��Ͻÿ�! 

��������� ����� �ٽ� �ְ� ...

create table emp_backup_20201111
as
select * from emp;


insert into emp
select * 
from emp_backup_20201111;

402.�Ʒ��� ���� salgrade ���̺��� ���� delete �ϰ� commit ���Ŀ� �����Ͻÿ�!

create table salgrade_backup_20201111
as
select * from salgrade;                                                                        ������� �����

delete from salgrade;
commit;                                                               �����ϰ�

insert into salgrade
select *                                                               ������Ϸ� ���Է����ֱ� 
from salgrade_backup_20201111;
