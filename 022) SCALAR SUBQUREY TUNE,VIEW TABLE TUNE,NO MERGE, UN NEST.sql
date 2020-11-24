? SQL Ʃ�� ������ ����

SQL Ʃ�� ������ ����                  
1.�ε��� Ʃ��                                                                     �����ͺм���
2.���ι��� Ʃ��                                                              (������ ���̾�Ƽ��Ʈ)
3.���������� Ʃ��
4.������ �м��Լ��� �̿��� Ʃ��                                                        ��
5.�ڵ� SQL Ʃ��                                                     SQL,���̽�,R�ڵ��� ���ؼ� �����ͺм�

    
*���ι��� Ʃ�׽� �߿��� ��� 2����?

1.���� ���� : 1.leading
                 2.Ordered

2.���� ���:  Nested loop ���� : use_nl : �������� �����ͷ�����
                 Hash ���� : use_hash : ��뷮 �����ͷ� ���� 
                 sort merge ���� : use_merge : ��뷮 �����ͷ� ����

   OLTP ����                                                                      DW ����

       ��                                                                              ��

�ǽð� ��ȸ ó���� ���� �����Ͱ�                                     �ǰ����� �ɻ��򰡿�  
����Ǿ��ִ°�                                                           (�츮���� �� ������ ��� �Ƿ���)

                                                                                   10������,20�� ��������



Nested loop ������ �ַ� ���                                                  �ؽ�����,merge ����
                                                                                          ������ �м��Լ��� �ַ� ���               
                                                                                          ��Ƽ�� ���̺�, ����ó��


  ���μ����� �߿伺

���μ����� ���� ���༺���� �޶��� �� �ֽ��ϴ�.
���μ����� �����Ϸ��� �õ�Ƚ���� ���� ���̺��� driving ���̺��
�����ؼ� ���μ����� ����ϰ� �߿��մϴ�.

nested loop
  table acess full dept---���� ���̺�,driving ���̺�
  table acess full emp--- ���� ���̺� ,driven ���̺�

hash join 
table acess full dept -----hash table( �޸𸮷� �ö󰡴� ���̺� )
table acess full emp ---- probe table( ��ũ�� �ִ� ���̺� )        

� �����̴� ���� ���� �д� ���̺� ũ�Ⱑ �۰ų� 
�˻��������� ���ؼ� �������Ǵ� �Ǽ��� �������� ���� �д°�
���μ����� �־ �߿��մϴ�.

*���ι��� Ʃ���ϴ� ����
��: select/+* gather_plan_statistics leading(d e)*/ e.ename,d.loc
     from emp e, dept d    ------  emp 14�� , dept4�� 
    where e.deptno=d.deptno; 
     and e.job='SALESMAN'  ----4 �� 
     and d.loc='CHICAGO' ------ 1�� 


1.���μ����� ���Ѵ�.  ---- from ���� ���̺��� �Ǽ��� �� Ȯ���Ѵ�.
2.���ι���� ���Ѵ�.  ---- ������ ������ ������ ���� Ȯ���Ѵ�. 
                                   (OLTP �������� DW �������� Ȯ���Ѵ�)
                                   ���� ���� �����ͰǼ��� Ȯ���ؼ� ��뷮�� 
                                   �ƴϸ� nested loop ������ ����. 
              
                                                                     
74.�Ʒ��� SQL ���ι����� ���μ����� ���ι���� �����Ͻÿ� !

select e.ename,d.loc,e.sal
  from emp e, dept d
  where e.deptno=d.deptno
  and e.name = 'KING' 
                  ��
select /*+ gather_plan_statistics leading(e d) use_nl(d)* e.ename,d.loc,e.sal
  from emp e, dept d
  where e.deptno=d.deptno
  and e.ename = 'KING';
  
select *  from table(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));

75.emp dept �� ��뷮 ���̺��̶�� �����ϰ� �Ʒ��� SQL�� ���μ����� ���ι���� �����Ͻÿ�! 

select e.ename,d.loc
from emp e,dept d
where e.deptno = d.deptno; 
               ��
select /*+ gather_plan_statistics leading (d e) use_hash(e)*/e.ename,d.loc
from emp e,dept d
where e.deptno =d.deptno ; 

select *  from table(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));

76.�Ʒ��� SQL�� ���μ����� ���ι���� �����Ͻÿ�! (emp �� salgrade �� ��뷮 ���̺� �̶�
�����ϰ� DW �������� ����Ǵ� SQL�̶�� �����ϰ� �ϼ���)

select e.ename,e.sal,s.grade
where emp e, salgrade s
where e.sal between s.losal and s.hisal
order by s.sal asc;
             ��
select /*+ gather_plan_statistics leading(s e) use_merge(e)*/  e.ename,e.sal,s.grade
where emp e, salgrade s
where e.sal between s.losal and s.hisal;

? 5.Outer ������ Ʃ�׹��

outer ������ ���μ����� outer ���� sign �� ���� �ʿ��� �ִ�������
������ ������ �˴ϴ�. �׷��ٺ��� ���� ������ �����ϱⰡ �����
Ʃ���� ���絥 �̸� ������ �� �ִ� ��Ʈ�� �ֽ��ϴ�.

��)
insert into emp(empno,ename,sal,deptno)
values(2921,'JACK',4500,70);

select /*+ gather_plan_statistics*/e.ename,d.loc
from emp e, dept d
where e.deptno=d.detpno(+)'

77.�Ʒ��� ���μ����� dept---emp ���� �ǰ� �Ͻÿ�!

select /*+ gather_plan_statistics*/e.ename,d.loc
from emp e, dept d
where e.deptno=d.deptno(+);
       ��
select /*+ gather_plan_statistics leading (d e) use_nl(e) */e.ename,d.loc
from emp e, dept d
where e.deptno=d.deptno(+);

select *  from table(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));

78.���� outer ������ ���μ����� dept --- emp ���� �ǰ� �Ͻÿ�! (77����)

select /*+ gather_plan_statistics*/e.ename,d.loc
from emp e, dept d
where e.deptno=d.deptno(+);
       ��
select /*+ gather_plan_statistics leading (d e) use_hash(e) swap_join_inputs(d) */e.ename,d.loc
from emp e, dept d
where e.deptno=d.deptno(+);

select *  from table(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));

79.emp �� bonus�� �����ؼ� �̸��� comm2�� ����ϴµ�
outer join�� �̿��ؼ� jack �� ��µɼ� �ֵ��� �Ͻÿ�! 

select e.enme,b.comm2
from emp e , bonus b
where e.empno=b.empno(+)

80.���� ���μ����� bonus----emp ���� �ǰ��Ͻÿ�!

select e.enme,b.comm2
from emp e , bonus b
where e.empno=b.empno(+)
        ��
select /*+ gather_plan_statistics leading (b e) use_hash(e) swap_join_inputs(b)*/ e.ename,b.comm2
from emp e , bonus b
where e.empno=b.empno(+);

select *  from table(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));

* 6.��Į�� ���������� �̿��� ����

 select                          -�������� ����  : Scalar subquery
   from                         -������ ���� : in line view
     where                      -�������� ����: 
      group by                  -x
        having by              -�������� ����
            order by            -�������� ���� : scalar subquery

81.�̸�, ���� ��� ���̺� �ִ������ ����Ͻÿ�
(select ���� ���������� ��Į�� ���������� �̿��ؼ�)

select ename,sal, (select max(sal) from emp) �ִ����)
from emp;

                     ��    

select /*+ gather_plan_statistics*/ ename,sal,max(sal) over () �ִ����
from emp;

select *  from table(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));

Ʃ���� ���۰� �پ���ϴµ� ���۰� �״���̴�..�ٵ� ������ �پ��°���.

82.�Ʒ��� SQL�� Ʃ���Ͻÿ�!

select ename,sal,(select max(sal) from emp) �ִ����,  
                  (select min(sal) from emp) �ּҿ��� 
        from emp
                   ��
select  /*+ gather_plan_statistics*/ ename,sal,max(sal) over () �ִ����,
                 min(sal) over () �ּҿ���
from emp;

select *  from table(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));

83.�Ʒ��� SQL�� Ʃ���Ͻÿ�!
�μ���ȣ,�̸� ����,�ڱⰡ ���� �μ���ȣ�� ��տ����� ����ϴµ� �ڱ��� ������
�ڱⰡ ���� �μ���ȣ�� ��տ��޺��� �� ū ����鸸 ����Ͻÿ�!
(Ʃ���� emp ���̺��� �ѹ��� ������ �ؼ� �Ȱ��� ����� ��µǰ� �Ͻÿ�!)

select e.deptno,e.ename,e.sal,v.�μ����
     from emp e, (select deptno,avg(sal) �μ���� 
                        from emp
                         group by deptno) v
where e.deptno=v.deptno and e.sal > v.�μ���� ;                      
    
                 ��

Ʃ���� emp ���̺��� �ѹ��� ������ �ؼ� �Ȱ��� ����� ��µǰ� �Ͻÿ�! 

select deptno,ename,sal,avg(sal) over (partition by deptno) �μ����
from emp;

where sal> �μ���� -----�̰� �������� ( ���� �������������)

*���� SQL�� ����Ϸ��� from ���� ���������� in line view �� ����ؾ� �Ѵ�. 

select deptno,ename,sal,
from               (select, avg(sal) over (partition by deptno) �μ����
                               from emp)
where sal>�μ���� ;


? DML ���� �̿��� ������������ Ʃ��

����: ALLEN �� ������ KING�� �������� �����Ͻÿ�

update emp
set sal=(select sal from emp where ename='KING')
where ename='ALLEN';
(���������� �̿��� Update ���̴�) 


85.��� ���̺� loc �÷��� �߰��ϰ� �ش� ����� ���� �μ���ġ�� ���� �����Ͻÿ�!

alter table emp
add loc varchar2(20);

Befrore Ʃ�� 
update emp e
set loc = (select loc 
                 from dept d
                   where e.deptno=d.deptno);


����: emp ���̺��� �÷��� �������� ������ ���� �Ǹ� ������������ ����Ǵ°� �ƴ϶�
���� ����(update)������ ����˴ϴ�. 
Update ���� �����ϴµ� ���� ���� ������ �ִ� KING �� �μ���ġ�� �����ϱ� ���ؼ� 
KING �� �μ���ȣ 10���� �������� ������ �־
������������ 10�� �μ���ȣ�� �μ���ġ�� ����ϰ� KING �� �μ���ġ�� NEW YORK���� 
�����մϴ�. �״������� BLAKE �� �Ȱ��� ������� �����ϸ鼭 EMP ���̺��� 14���� ������� �����͸� �̷��� �����մϴ�. �׷��� ������ UPDATE�� 14���� ����˴ϴ�. 

select ename,loc from emp; 

After Ʃ��
(Merge ���� ������ָ�ȴ�)

merge into emp e
using dept d
on (e.deptno=d.deptno)
when matched then
update set e.loc=d.loc; 

Ʃ�������� �ٸ��� Ʃ���Ĵ� �����͸� �ѹ��� �����մϴ�.

86.��� ���̺� sal2 ��� �÷��� �߰��Ͻÿ�! 

alter table emp
  add sal2 number(10)

87.���� �߰��� sal2�� �ش� ����� �������� ���� �����Ͻÿ�.

update emp
set sal2=sal;

	
88.�Ʒ��� ���պ並 �����ϰ� �並 �����Ͻÿ�!

create view emp_dept 
as
  select e.ename,e.loc as emp_loc,d.loc as dept_loc
 from emp e, dept d
where e.deptno=d.deptno;

select * from emp_dept;

89.emp_dept �並 �����ؼ� emp_loc���� dept_loc�� ������ �����Ͻÿ�! 

update emp_dept
   set emp_loc=dept_loc ;

�ϸ� ����������!  ERROR �߻� 

90.���� Update ���� ����ǰ� �����Ͻÿ�!

���� ���պ並 �����Ϸ��� dept ���̺� deptno �� 
Primary  Key ������ �ɾ��ָ� ���ŵ˴ϴ�
���� dept ���̺� deptno �� pk ����� 20���� �������̰� 30���� ���� �� �̸� �丸�鶧 �����ߴ� �� �������� ����� ���� �� ���� ����� �˴ϴ�. 
���� 20���ε� ������ Dallas �̰� ������ CHICAGO �̰� �̷��� ���׹��� �ǹ����� ���� �����
�������� ���� �Ǹ� �� ���� �� ���� �����͸� ��� �� �����Ҽ� �ְڽ��ϱ�?


alter table dept
add constraints dept_deptno_pk primary key(deptno)

update emp_dept
   set emp_loc=dept_loc ;

������ �ɾ��ִ� ���� ����!! 

��������� ������Ʈ �Ϸ��� VIEW ���̺��� �������Ѵٴ� ���� ������ �ɷ��ִ�.
��� DB�� ���̺� ���� ��û�ϸ� �ȸ������ ���ɼ��� ������ �ٸ� ����� ����Ѵ�.

91.���� dba�� view�� �ȸ�����༭ view�� ��������ٸ� ��� �ؾ��ϴ°�?

update ������ ���������� �� �� �ִ���

update �� �������� ��밡��
set �� �������� ��밡��                      ----all ���� 
where �� �������� ��밡�� 

update (  select e.ename,e.loc as emp_loc,d.loc as dept_loc
             from emp e, dept d
               where e.deptno=d.deptno)
set emp_loc = dept_loc;

����: dba�� �並 ��������� �ʴ´ٸ� ������ Update �� ���������� ����ؼ�
VIEW �� �������� ���� �ۼ��ϰ� set ������ Update �ϸ� �˴ϴ�.

92.EMP ���̺� dname �÷��� �߰��ϰ� �ش����� �μ������� ���� �����Ͻÿ�!

alter table emp
 add dname varchar2(10);

Update Subquery

Update (select e.ename,e.dname as emp_dname,
                               d.dname as dept_dname
                        from emp e, dept d
              where e.deptno=d.deptno )
set emp_dname=dept_dname;

Merge ���! 

merge into emp e
using dept d
on (e.deptno=d.deptno)
when matched then
update set e.dname=d.dname;


Ʃ���� --   �������� ���� �ɰ͵�
update emp e
  set dname = (Select dname 
                       from dept d
                          where d.deptno=e.deptno);                      

                        
		 ��

Ʃ���� 
merge into emp e
using dept d
on(e.deptno=d.deptno)
when matched then
update set e.dname=d.dname 

(���  set ���ٰ� subquery ���°� �������� merge�� �ѹ濡 �ۼ��ض� �װ� �� ������.)

8.��� ���ι��� Ʃ��

"����� ���ι��� ���μ����� �����ϰ��� �� �� ����ϴ� Ʃ�׹��"

��: @demo �� �ʱ�ȭ ���ְ�

drop view emp_dept;

create view emp_dept
as
  select e.empno,e.ename,e.sal,d.loc
  from emp e, dept d
where e.deptno=d.deptno; 


93.emp_dept view �� salgrade ���̺��� ���� �����ؼ� �̸��� ���ް� �μ���ġ�� 
�޿����(grade)�� ���Ͻÿ�

select v.ename,v.sal,v.loc,s.grade
       from emp_dept v, salgrade s
                 where v.sal between s.losal and s.hisal;

94.���� SQL �� ���� �����ȹ�� Ȯ���Ͻÿ�! 

select /*+ gather_plan_statistics no_merge(v) leading (s v) une_nl(v)*/
v.ename,v.sal,v.loc,s.grade
   from emp_dept v, salgrade s   
      where v.sal between s.losal and s.hisal;

ERORR ����.

����: ���� ��Ʈ������ nested loop ������ �ض�! ��� ������ �����ȹ������ nested loop �����ߴٴ°� �����ϴ�. �� ��Ʈ�� �����ߴ���? ! ������ View�� ��ü �ع����� �Դϴ�.
view �� ��ü���� �ʾҴٸ� �����ȹ�� view�� ���Դϴ�.

�׷��� view�� ��ü���� ���ϵ��� ��Ʋ�� ����մϴ�

no_merge(v)   ----�� v�� d�츮�� ���� 

�䰡 ���Դٴ°��� �並 ��ü���� �ʾҴٴ� ���̴�.
�� �׸�� �信 �ش��ϴ°��̰� �ָ� �ѵ���� ����.
�ѵ���� ���� ���� ������ ���� 2��/3���̴�..

����ü ���ؼ� ��Ʈ�� ������.

�����ȹ �ؼ� : ���� Salgrade �� full scan �ϰ� �׸��� View �� ��ĵ�ϸ鼭
nested loop������ �����߽��ϴ�. 

����:  ���� ��Ʈ������ nested  loop ������ �ض� ! ��� ������ 
        �����ȹ������ nested loop �����ߴٴ°� �����ϴ�. 
         �� ��Ʈ�� �����ߴ��ĸ� view �� ��ü�ع����� �Դϴ�. 
        view  �� ��ü���� �ʾҴٸ� �����ȹ�� view �� ���Դϴ�. 
       �׷��� view �� ��ü���� ���ϵ��� ��Ʈ�� ����մϴ�. 
        �� ��Ʈ�� �ٷ� no_merge �Դϴ�. 

 select  /*+ gather_plan_statistics  no_merge(v)  leading(s v) use_nl(v) */   
             v.ename, v.sal,  v.loc,  s.grade
       from  emp_dept   v,  salgrade   s
       where   v.sal  between   s.losal  and  s.hisal; 

����:  ��Ʈ:   no_merge :   view �� ��ü���� ���ƶ� ~
                        merge :   view �� ��ü�ض� ~

�����ȹ �ؼ�:  ���� salgrade �� full scan �ϰ� �׸��� view �� ��ĵ�ϸ鼭
                              nested  loop ������ �����߽��ϴ�.

 �����  ���� ������ ���̺��� ���μ����� ��� �����ؾ� �ϳ���?

 select  /*+ gather_plan_statistics  no_merge(v)  leading(s v) use_nl(v) */   
             v.ename, v.sal,  v.loc,  s.grade
       from  emp_dept   v,  salgrade   s
       where   v.sal  between   s.losal  and  s.hisal; 

���� view ���� ������ ������  dept ---->  emp ������ �а� �ֽ��ϴ�. 
�׷��� emp -----> dept  ������ �ǰ� �� ���� ������ ?

 select  /*+ gather_plan_statistics  no_merge(v)  leading(s v) use_nl(v) 
               leading(v.e  v.d)  use_hash(v.d)  */   
             v.ename, v.sal,  v.loc,  s.grade
       from  emp_dept   v,  salgrade   s
       where   v.sal  between   s.losal  and  s.hisal; 
 
 create   view   emp_dept
  as
     select  e.empno, e.ename, e.sal,  e.deptno, d.loc
        from  emp   e,  dept  d
        where  e.deptno = d.deptno; 

95.���� �����ȹ�� �Ʒ��� ���� �������Ͻÿ� !

 select  /*+ gather_plan_statistics  no_merge(v)  leading(s v) use_nl(v) 
                leading(v.e  v.d)  use_nl(v.d)  */   
                      v.ename, v.sal,  v.loc,  s.grade
                        from  emp_dept   v,  salgrade   s
                             where   v.sal  between   s.losal  and  s.hisal; 
 
96. ���� �����ȹ�� �Ʒ��� ���� ��µǰ��Ͻÿ� !

 select  /*+ gather_plan_statistics  no_merge(v)  leading(v s) use_nl(s) 
               leading(v.e  v.d)  use_hash(v.d)  */   
             v.ename, v.sal,  v.loc,  s.grade
       from  emp_dept   v,  salgrade   s
       where   v.sal  between   s.losal  and  s.hisal; 

97.�̹����� �Ʒ��� ���� �����ȹ�� �������Ͻÿ� !

 select  /*+ gather_plan_statistics  no_merge(v)  leading(s v) use_nl(v) 
               leading(v.d v.e)  use_hash(v.e)  */   
             v.ename, v.sal,  v.loc,  s.grade
         from  emp_dept   v,  salgrade   s
       where   v.sal  between   s.losal  and  s.hisal; 

����:  view �� ����Ͽ� �����ϴ� � SQL ������ ������ �����ٸ� 
        ���� ���� ������� Ʃ���� �ϸ� ȿ�������� Ʃ���� �� �� �ֽ��ϴ�.

? ���������� Ʃ�� 

  select  ename, sal
       from  emp
       where  sal > ( select  sal
                             from  emp
                             where   ename='JONES');

 �������� ���� Ʃ���� ����� ũ�� 2������ �˸� �˴ϴ�
                                                                          ��Ʈ
   
    1.  �����ϰ� �������������� ����ǰ� �ϴ� ��� :  no_unnest 
    2.  ���������� �������� �����ؼ� ����ǰ� �ϴ� ��� :  unnest

   nest --> ���δ�
  unnest --> ������ �ʰ� Ǯ����ģ��. 
  no_unnest  --->  ���ζ� !!!!!!!!