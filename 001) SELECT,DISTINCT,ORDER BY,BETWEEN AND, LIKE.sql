�� SQL �ۼ��� ���ǻ���! 

1. SQL �� ��ҹ��ڸ� �������� �ʴ´�. (But DATA does) 
��) SELECT ENAME,SAL FROM EMP; -- ���� 
    Select ename,sal from emp; -- ���� 
2. SQL �� ���ٷ� �ۼ����� ����   
     ���� ���� �������� �и��ؼ� �ۼ��Ѵ�. 
     
3. �鿩���⸦ �ؼ� SQL �� �������� ���δ�.

@��� ȭ���� ���λ����� �����ϴ� ��ɾ� : Set lines 300
@ / �ϰ� ���� �� ġ�� ��� �����ߴ� SQL �� �����Ҽ� �ִ�
@��� ȭ�鿡�� ���� ������ �����ϴ� ��ɾ� : set pages 400
@���̺� ��� �� (COLLUM)  ����ϱ� : select *
(*�� asterisk ��� �ϰ� ��� �÷��� �� ������ �� ���.)

@describe �� "*" ���̸� �����ϱ� 

�� ���� dept�� �μ� ���̺��̰� �÷��� 3���� �ִµ� ������ �����ϴ�. 
Deptno : �μ���ȣ
Dname : �μ���
Loc : �μ���ġ

? 001 ���̺��� Ư�� �� (COLUMN�����ϱ�) 

select : ��ȸ�ض�, �����ض�
ename, sal : COLUMN
from : �κ���
emp : ���̺� 

? 002 ���̺� ��� Columm ��� 

select * from emp

? 003 �÷� ��Ī�� ����Ͽ� ��µǴ� �÷��� �����ϱ� (������ ������ �ʴ´�)

"�÷� ��Ī�� �÷��� ��ſ� �ٸ� �÷����� ������ �� ����ϴ� �����Դϴ�"
��: select ename as �̸�, sal as ���� 
�� �÷��� �ڿ� as �� ���� �׸��� �÷���Ī�� �ۼ��Ѵ�.
   ����� ��µ� �� �÷���Ī�� ��µȴ�.
    as�� ���� �����մϴ�. 

�� ����: �÷���Ī�� ��ҹ��ڸ� �����ϰ� �ʹٰų� 
          ���鹮�ڳ� Ư�����ڸ� �������� ���ʿ�
          Dobule �����̼� ��ũ�� �ѷ��־�� �Ѵ�. 

? 004 ���� ������ ����ϱ� (||)

"���� �����ڴ� �� Columm �� �����͸� �����ؼ� ����ϴ� ������"
 select ename || '�� ������' || sal from emp;

@edit or ed : �޸��� ����--- ���� 

? 005 �ߺ��� �����͸� �����ؼ� ����ϱ� (distinct) 

'distinct' Ű���带 �÷��� �տ� �ۼ��ϰ� �����ϸ� �ߺ��� �����͸� �����ϰ� ����� �� �ֽ��ϴ�.
select distinct job from emp;

��: select job
From emp;   --- �ߺ��Ȱ��� ���´�. 

select distinct job, sal, ename 
from emp;

? 006�����͸� �����ؼ� ����ϱ� (order by)

order by ���� �����͸� �����ϴ� ���̰� select ���� �� �������� ����մϴ�.
��) select ename, sal 

    from emp
        order by sal asc; 
                     ��
               ������ �÷��� 
���Ĺ�� 1. asc : ���������� ������������ 
        2. desc : ���������� ����������

*Order by ���� �÷��� �������� �ۼ��� ���ִ�. 

Select ename,deptno,sal
From emp
Order by deptno asc, sal desc;
(order by 2 asc, 3 desc;)
Select ������ ������� ���ڸ� �Է��ϸ� ��.
�ΰ��� �Ἥ ������ �� �� �ִ�. �ΰ��� ����   

? 007 Where �� ���� 1 (���� ������ �˻�)

"where ���� ����ϸ� Ư�� ���� ���� �����͸� �����ؼ� ����Ҽ� �ִ�"
��)
select ename,sal
From emp
where sal=3000;

? 008 Where �� ���� 2 (���ڿ� ��¥ �˻�)

where ���� �����͸� �˻��� �� ���ڿʹ� �ٸ��� 
���ڿ� ���ʿ� �̱� ��Ƽ�̼� ��ũ�� �ѷ�����մϴ�.
��)select ename,sal
from emp
where ename='SCOTT';

��SQL�� ��ҹ��ڸ� �������� ������ �����ʹ� ��ҹ��ڸ� �����մϴ�. 
�̱� �����̼� ��ũ�ȿ� �ִ� �����ʹ� ���� �Ǵ� ��¥�̴� ��� ����Ŭ���� �˷��ִ� ����. 

@ ��¥ �˻��� �Ҷ��� �⵵/��/�� ������ �˻��� �ϸ� �Ǵµ�
���󸶴� ������ �ٸ� �� �ִ�. �̱��̳� ���������� ��¥ �˻���    
��/��/�⵵ ���� �Դϴ�. 

? 009 ��� ������ ���� (*, /, +, -)

��) select ename,sal, (sal + 3000) * 12 
From emp;

? 010 �� ������ ���� 1 (��, ��, ��=,��=, =, !=,����, ^=)
                                    �� 3���� ���� �ʴٸ� �ǹ��� 

�� ���� �����̼� ��ũ�� ����Ŭ ��ü�� ��Ʋ�� �� �ѹ��� ���Ǵµ� 
�÷���Ī ����Ҷ� ���鹮��,Ư������,��ҹ��ڸ� �����ؼ� �÷���Ī��  ����ϰ��� �Ҷ��� ����Ѵ�. ������ ���� �� �̱��Դϴ�. 

*SQL developer ��ġ
������ �������� �̿����� �ʰ� ����Ŭ�� �����ؼ� �޸��尰�� ȭ�鿡�� ���ϰ� SQL�� �ۼ��� �� �ְ� �ϴ� ���̴�. 

? 011 �� ������ ���� 2 (BETWEEN AND)
Between ����,����,��¥ AND ����,����,��¥

? 012 �� ������ ���� 3 (LIKE)
���� : �̸��� ù���ڰ� S�� �����ϴ� ������� �̸��� ����Ͻÿ�!
Select ename
From emp
Where ename like 's%';

���� : Like �� ~�� �Ͱ��� �̶�� ���� ��ó�� �̸��� ù��° ö�ڰ� S�� �����Ұ� ������ �������̴�. 
       %�� ���ϵ� ī��� ���ڸ��� ���� �͵� ���� ����.
       �� ö���� ������ ��� �ǵ� ���谡����.

Like �� ���� ���� �ִ� Ű���� 2�� 
% : ���ϵ� ī�� : ���ڸ��� ���� �͵� ���� ���� �װ����� ��� �Ǵ� �������.
_ : ����� : ���ڸ��� ���� �͵� ������µ� �ڸ����� �Ѱ����� �Ѵ�. 


����Ŭ�� ������ �ϱ� ���ؼ��� ���� ������ �˾ƾ� �մϴ�. 
1.������ ���̽� ������ IP�ּ�(�ǹ� �ּ�) (HOST=127.0.0.1)
2.��Ʈ��ȣ(�ǹ����� ��� ��ȣ)  (PORT=1521)
3.����Ŭ �ν��Ͻ� �̸�(SID) (�ǹ����� Ư�� ȸ�� �̸�) orcl

���� ������ �˾Ƴ��� ��ɾ� : ����â�� ���� lsnrctl status -- enter 

�ǹ��� �ִ� ���� ���������� ����� �ȴ�. 
����â�� ���� lsnrctl status

Developer 
����--ȯ�漳��--�۲� (��¥ ũ�� ���氡��)
Control --Enter  



3.  emp ���̺��� �÷��� ���������� �ִ��� Ȯ�� �Ͻÿ�!

describe emp

4. �̸�,����,Ŀ�̼��� ����Ͻÿ�

select ename,sal,comm from emp;

5. �̸�,����,�Ի��� �μ���ȣ�� ����Ͻÿ�!
select ename,job,hiredate,deptno from emp;

6. emp ���̺� ��� �÷��� �˻��Ͻÿ� 

describe emp;

7. dept ���̺��� ��� �÷��� ����Ͻÿ�

describe dept;

9.�̸��� ������ ����ϴµ� �÷����� �Ʒ��� ���� ��µǰ� �Ͻÿ�! (Employee name, Salary )
 
 select ename as 'Employee name'
      sal as 'Salary' from emp;

10.�Ʒ��� ���� ����� ����Ͻÿ�
(KING �� ������ PRESIDENT �Դϴ�  
SCOTT �� ���� ANALYST �Դϴ�) 

select ename ||'�� ������'|| job ||'�Դϴ�' from emp;
                      
11. ���� ������  ��µǴ� �÷����� ���������� �ѱ۷� ��µǰ� �Ͻÿ�

select ename ||'�� ������'|| job ||'�Դϴ�'  as ������� from emp;

12. �μ���ȣ�� ����ϴµ� �ߺ��� �����ؼ� ����Ͻÿ�.
 
select distinct deptno from emp;

13.�̸��� ������ ����ϴµ� ������ ���� ������� ����Ͻÿ�
 
 select ename,sal
  from emp
    order by sal desc;

14. �̸��� �Ի����� ����ϴµ� �ֱٿ� �Ի��� ������� ����Ͻÿ�

select ename,hiredate
 from emp
    order by hiredate desc;

15.�̸��� ������ �Ի����� ����ϴµ� ������ ABCD ������ �����ؼ� ����ϰ� ������ ABCD ������ �����Ѱ� �������� �Ի�����
���� �Ի��� ������� ��µǰ� �Ͻÿ� (order by �� �ѹ��� �Է��ϸ� �ȴ�) 

select ename,job,hiredate
  from emp
    order by 2 asc, 3 asc;

16.�����ȣ�� 7788���� ����� �����ȣ�� �̸��� ������ ����Ͻÿ�

select ename,empno,sal
  from emp
    where empno=7788;

17.30�� �μ���ȣ���� �ٹ��ϴ� ������� �̸��� ���ް� �μ���ȣ�� ����Ͻÿ�

select ename,sal,deptno
 from emp
   where deptno=30;

18. ���� ����� �ٽ� ����ϴµ� ������ ���� ������� ����Ͻÿ� (17����)

select ename,empno,sal
  from emp
  where empno=7788
   order by sal desc;

19.�μ���ȣ�� 20���� ������� �̸��� �Ի��ϰ� �μ���ȣ�� ����ϴµ� �ֱٿ� �Ի��� ������� ����Ͻÿ�.

select ename,hiredate,deptno
 from emp
   where deptno=20
     order by hiredate desc;

20.������ SALESMAN�� �������  �̸��� ���ް� ������ ����Ͻÿ� 
 select ename,sal,job
  from emp
    where job='SALESMAN';

21.81�� 11�� 17�Ͽ� �Ի��� ����� �̸��� �Ի����� ����Ͻÿ�
 
 select ename,hiredate
  from emp
    where hiredate='81/11/17';

22.�̸��� ����(sal*12)�� ����ϴµ� �÷����� �ѱ۷� �̸�,�������� ����Ͻÿ�

select ename as �̸�, sal*12 as ����
 from emp;

23.���� ����� �ٽ� ����ϴµ� ������ 36000�� ������� �̸��� ������ ����Ͻÿ� (22����)

select ename as �̸�, sal*12 as ����
    from emp
   where sal*12=36000;

24.�̸��� ������ ����ϴµ� ������ ���� ������� ����Ͻÿ� 

select ename as �̸�, sal*12 as ����
  from emp
  order by 2 desc;
  �ڵ����� : select ---from---order by
  ������� : from---select---order by
 
 25. Ŀ�̼��� 150 �̻��� ������� �̸��� Ŀ�̼��� ����Ͻÿ� 

select ename,sal
   from emp
  where sal<=2400
    order by sal desc;

26.�Ʒ��� SQL ���� ���ϱ� �� ���� ����ǰ� �Ϸ���?

select ename, (sal +200) * 20
From emp; 

27.������ 3000�̻��� ������� �̸��� ������ ����Ͻÿ� 
 
 select ename,sal
   from emp
   where sal>=3000;

28.������ SALESMAN �� �ƴ� ������� �̸��� ������ ����Ͻÿ�

select ename,job
    from emp
   where job<>'SALESMAN';

29.������ 2400 ������ ������� �̸��� ������ ���ϴµ� ������ ���� ������� ����Ͻÿ�.

select ename,sal
    from emp
    where sal<=2400
  order by sal desc;

30.������ 1000���� 3000������ ������� �̸��� ������ ����Ͻÿ� 

Select ename,sal
From emp
Where sal between 1000 and 3000;
 �Ǵ�
Select ename,sal
From emp
Where sal>=1000 and sal <=3000;

31.������ 1000���� 3000���̰� �ƴ� ������� �̸��� ������ ��� �Ͻÿ� 

select ename,sal
   from emp
   where sal not between 1000 and 3000; 
     (not �� ����ϱ�) 

32.1981�⵵�� �Ի��� ������� ������� �̸��� �Ի����� ����Ͻÿ�.
 
 select ename,hiredate
  from emp
  where hiredate between '81/01/01' and '81/12/31';

33.�̸��� �� ���ڰ� T�� ������ ������� �̸��� ����Ͻÿ� 

select ename
    from emp
  where ename like '%T';

34. 81�⵵�� �Ի��� ������� �̸��� �Ի����� ����ϴµ� between and ������� ���� Like �� 

select ename
from emp
 where hiredate like '81%';

35.�̸��� �ι�° ö�ڰ� M�� ������� �̸��� ����Ͻÿ�!

Select name
  From emp
    Where ename like '_M%';

36.�̸��� ����° ö�ڰ� A�� ��������̸�. 

select ename 
  from emp
    where ename like '__M%';