SQL Day 12 Problems 

   
�� Q-330.Emp ���̺� ������ SQL�� �ð�ȭ �Ͻÿ�! 

Select  rpad(' ',level*2) || ename as employee, level
 from emp
Start with ename='KING'
Connect by prior empno = mgr;



���� : rpad(' ',level2) �� ����(' ') �� level*2 ���ڸ�ŭ ä�����ڴ�.
Level�� Ŭ���� ������ ������������? �׷��� ������ ���� ��� �� �����ֵ�.
Rpad�� ������ ä���ְڴ�..�̷��Ŵ١�.

�� Q-331.���� ������� Blake �� �����ϰ� ����Ͻÿ�. 

Select  rpad('  ',level*2) ||  ename as employee, level
from emp
where ename != 'BLAKE'
Start with ename='KING'
Connect by prior empno = mgr;



Blake �� �����鸸 ���Ұ�..Blake �� ��������..�̰�  Blaek�� �Ʒ��� �ִ� �������� ������ �������ִ�



�� Q-332.���� ������� BLAKE �Ӹ� �ƴ϶� BLAKE�� ��������� ���� �����Ͻÿ�. 

Select  rpad('  ',level*2) ||  ename as employee, level
 from emp
    Start with ename='KING'
Connect by prior empno = mgr and ename !='BLAKE'



@����: ��������� ��� �����͸� ��µ��� �ʰ� �Ϸ��� where ���� �ƴ϶� Connect by ���� ������ �ָ� �˴ϴ�. 
Connect by ���� ��带 �����ϰڴٶ�� ���̴�..���� �̳��� 
ŷ�� ����� ���� ����̰� �̳�� ���� ���� ����̴�.! 
���� ����ε� ���� ��带 ���������ν� ���� ��尡 ��ü�� �ȳ����� �ϴ°��̴�.
Ư���� ���� �ȳ����� �ϰ� ������ where ���� ����ϸ� �Ǵµ� ��带 �����Ϸ���
Connect by  ������ �� ������ָ�ȴ�. 

�� Q-333. �ٽ� BLAKE �� BLAKE�� �������� ���Խ�Ų ������ ����ϴ� SQL�� �Ʒ��� ���� �����ϴµ� ������ ���� �������� ����Ͻÿ�! 
 
Select  rpad('  ',level*2) ||  ename as employee, level,sal
 from emp
    Start with ename='KING'
Connect by prior empno = mgr 
Order by sal desc;
    


@���� order by sal ������� ���ָ鼭 empno ���� ������ �ٱ�������.
���� ��� ������ ���� ������� ������ �Ǹ鼭 ������ ���ĵ� ����� ��������ȴ�.@

������ ������ �����ϱ� ���ؼ� ������ ���ĵ� ����� �����������.. 

�� Q-334.���� ����� �ٽ� ������ ���ĵ� ����� �����ϸ鼭 ������ ���� �������� ���ĵǼ� ��µǰ� �Ͻÿ�!   (SIBLINGS) 
 Select  rpad('  ',level*2) ||  ename as employee, sal
 from emp
    Start with ename='KING'
Connect by prior empno = mgr 
    
order siblings by sal desc;


����: ����� ���� ���� ���������� ������ ���� �������� ������ �ǰ� �ֽ��ϴ�.  ������ ���ǹ��� ����Ҷ�,  order by ���� ������ Siblings ��� Ű���带 ¦������ ����ؾ� �մϴ�. 

�� Q-335.�̸��� �Ի��ϰ� ���� ������ ����ϴµ� ���� �Ի��� ���� ������ �����ϸ鼭 ���������� ���� ���¸� �����ϸ鼭 ���� �Ի��� ������� ������ �Ǿ ��µǰ� �Ͻÿ�!  (KING�� 1���� �Ի��ߴ� ������) 

select rpad(' ',level*2) || ename,hiredate,level
from emp
start with ename ='KING'
connect by prior empno = mgr
order siblings by hiredate asc;



 

�� Q-336. ���� ������� ���� / �� �Ʒ��� ���� �߶�����ÿ�

KING        KING
JONES      KING/JONES 

select ename,ltrim(sys_connect_by_path (ename,'/'),'/') as path
From emp
Start with ename='KING'
Connect by prior empno=mgr; 


�� Q-337.�̸�,����,����,�޿����(grade)�� ����Ͻÿ�! 
     (*emp�� salgrade�� �����Ͻÿ�) 

select rpad(' ',level*2)|| e.ename,level,e.sal,s.grade
from emp e, salgrade s
where e.sal between s.losal and s.hisal
start with ename='KING'
connect by prior empno=mgr;




�� Q-338.���� ����� �ٽ� ����ϴµ� ������ ������ �����ϸ鼭 
������ �޿������ ���� ������� ��µǰ� �Ͻÿ�! 

select rpad(' ',level*2)|| e.ename as ������,level,e.sal,s.grade
from emp e, salgrade s
where e.sal between s.losal and s.hisal
start with ename='KING'
connect by prior empno=mgr
order siblings by sal desc;



�� Q-339.DALLAS���� �ٹ��ϴ� ������� �̸�,����,�μ���ġ�� ����Ͻÿ�! (������ ��ü ����� �������� ������ �ο��Ͻÿ�!) 

select rpad(' ',level*2)|| e.ename as ����������,level,d.loc
from emp e, dept d 
where e.deptno=d.deptno and d.loc='DALLAS'
start with ename='KING'
connect by prior empno=mgr;


Create table�� ���̺��� �����͸� �Է��ϴ� ���� �ƴϰ�, 
������ ������ Ÿ�Ե��� �������ִ°��̴�. 

	
343.emp 500���̺� �Ʒ��� �����͸� �Է��Ͻÿ�!
(1111 scott 3000
2222 smith 2900)

insert into emp 500(empno,ename,sal)
values(1111,'SCOTT',3000);

Insert into emp500(empno,ename,sal)
values(2222,'SMITH',2900);

344.�Ʒ��� ���̺��� �����ϴ� �̸��� 500�� �ؼ� �����Ͻÿ�

Empno
Ename
Sal
Hiredate 
Deptno

Insert into emp500(empno,ename,sal)
Values(2222,'SMITH',2900);


345.�Ʒ��� emp501 ���̺� �����͸� 2�� �Է��Ͻÿ�!
Create table emp501 

�����ȣ 7839 , �̸� KING, SAL 5000, Hiredate : 81/11/17, deptno 10 
           
Inset into emp501(empno,ename,sal,hiredate,deptno)
 Values(7839,'KING',5000,to_date('81/11/17','RR/MM/DD'),10);

Insert into emp501(empno,ename,sal,hiredate,deptno)
Values(7968,'BLAKE',2850,to_date('81/05/01','RR/MM/DD'),30);

����)
"Long ������ Ÿ���� ����ϴ� ��� �׽�Ʈ"
'Long ������ Ÿ���� ���� �� �ؽ�Ʈ �����͸� �Է��Ҷ� ����ϴ� ������ �����Դϴ�'

Create table profile2 
(ename varchar(20),
      self_intro long); 

insert into profile2 (ename,self_intro)
values('����ȣ','������� ���� �츮���� �����߾����ϴ�.
                �׸��� ��Ӵϴ� ¥����� �ȴٰ� �ϼ̽��ϴ�. ���� ������');
        

�� Q-346. �ܿ�ձ� �뺻�� �Է��ϱ� ���� ���̺��� winter_kingdom �̶�� �̸����� �����Ͻÿ�! 

create table winter_kingdom
(win_text varchar2(4000));


�� Q-347.��ȭ �ܿ�ձ� �뺻���� elsa �� ���� �����°�?, anna�� ���� �����°�? 

select sum(regexp_count(lower(win_text),'elsa') ) as cnt
from winter_kingdom;

*���Խ� �Լ��� regexp_count �� �̿��ϸ� ���� ������ �� �ֽ��ϴ�. 

����: win_text �� ���μҹ��ڷ� �����ϰ� regexp_count �� �̿��ؼ� ��ũ��Ʈ ���� ������ �� ������� elsa��� �ܾ ���ԵǾ��� ������ ī��Ʈ �Ѵ�.  �׸��� ī��Ʈ�� ���ڵ��� �� sum�Լ��� �̿��ؼ� �� ���Ѵ�. 


�� Q-349.�����ܾ �����ϱ� ���� ���̺��� Positive ��� �̸����� �Ʒ��� ���� �����Ͻÿ�

Create table Positive 
(p_text varchar2(2000));

�� Q-350.�����ܾ �����ϱ� ���� ���̺��� negative ��� �̸����� �Ʒ��� ���� �����Ͻÿ�

Create table negative
( n_text varchar2(2000));

�� Q-351.�����ܾ�� Positive ���̺� �ְ�, �����ܾ�� Negative �ܾ��忡 �־��
���� ���̺�â���� ������ ����Ʈ�� ��Ʈ���� ������~~  
(��� üũ �����ϰ�// ������ ��// ������ ����  �ѷ��α� ����) ���� �ϰ� 

select count(*)
from positive;

 
select count(*)
from negative;


�� Q-352.���� �����͸� ����Ŭ�� ���̺��� �����ͷ� �Է��Ͻÿ�! 
 (���� ���б� ��ϱ� ��Ȳ �����͸� ������ ���̺��� ���� �Ʒ��� ���� �����Ͻÿ�) 

ī�信 ���� ������ �Խ��ǿ� ���� UNIV data ��ũ��Ʈ ������~~

create table univ
(division      varchar2 (20),
 type          varchar2(20 ),
 university    varchar2(50),
 campus_type   varchar2( 40),
 admission_fee  number( 20),
 college_fee    number( 20),
 supporting_fee number( 20),
 tuition       number(20 ) ) ;

�̰��� ����� ���� ���� �����͸� �����!! 

�� Q-354.�츮���󿡼� ���е�ϱ��� ���� ����б��� ����ΰ�

select university,tuition,rank() over (order by tuition desc)
from univ;


�� Q-335.������ �Խ��ǿ� ���� �߻� ���� �����͸� �����޾�
���̺��� �����ϰ� �����͸� �Է��Ͻÿ�! 

create  table  crime_loc
( CRIME_TYPE     varchar2(50),                ��  ��������
  C_LOC             varchar2(50),                        ��  �������
  CNT              number(10) );                         ��  ���˰Ǽ�

�� Q-336.���������� ����ϴµ� �ߺ������ؼ� ����Ͻÿ�

select distinct crime_type 
from crime_loc;



�� Q-357.������ ���� ���� �Ͼ�� ��Ұ� ����Դϱ�.

select *
         from crime_loc 
         where crime_type = '����'                 
         order by cnt desc 
         fetch first 1 rows only; 



�� Q-358.������ ���� ���� �Ͼ�� ��Ұ� ������� 1������ 3������ ����Ͻÿ� 

select *
from crime_loc
where crime_type = '����'
order by cnt desc
fetch first 3 rows only;




�� Q-360.������ ����Ű�� ���� ū ������ �����ΰ� ? 

������ ----�÷� : Pivot ��
�÷�   ---- ������ : Unpivot �� 

���� ������ ���� ���� ���Ϸ��� �÷��� �����ͷ� �־�� �����ϴ�.
�Ʒ��� SQL�� as������ ������ �������� ����� Crime_Cause2�� ���� 

�װ��� ���� ��������� 

Select * from crime_cause2
Where crime_type = '����'
Order by cnt desc
Fetch first 1 rows only;
