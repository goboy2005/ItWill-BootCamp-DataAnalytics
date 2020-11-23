1.�ε��� SQL Ʃ�� ( 8���� ������ ���)
          1.index range scan
          2.index unique scan
          3.index full scan
          4.index fast full scan
          5.Index skip scan
          6.index merge scan
          7.Index bitmap merge scan
          8.Index join

2.���� ���� Ʃ�� ( ���μ���,���ι�� 3����)
           1.nested lopp ���� : use_nl         
           2.Hash join : use_hash
           3.sort merge ����: use_merge 
3.�������� ���� Ʃ��
4.������ �м��Լ�
5.�ڵ� SQL Ʃ��

�� 3.������������ Ʃ��

����)
DALLAS ���� �ٹ��ϴ� ������� �̸��� ������ ����Ͻÿ�! 

select ename,sal
from emp
where deptno in (select deptno  
                              from dept
                                    where loc='DALLAS');
                           ��
         
99.���� ������������ �������� �����ؼ� ���� ����� ���ÿ�   
 DALLAS ���� �ٹ��ϴ� ������� �̸��� ������ ����Ͻÿ� 

select e.ename,e.sal
from emp e ,dept d
where e.deptno=d.deptno
and d.loc='DALLAS';

�Ʒ��� ������������ �����ȹ�� ���ÿ�
select /*+ gather_plan_statistics*/ename,sal
from emp
where deptno in (select deptno
                         from dept     
                             where loc='DALLAS'); 

select *  from table(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));


����: ���� �����ȹ�� filter �� ���̸� ����  SQL�� �������������� �����Ѱ�
�̰� hash join �� �����ȹ�� ���̸� ���ι�������
�����ؼ� ������ ���Դϴ�. �츮�� �������������� �ۼ��ߴµ�
��Ƽ�������� �������� �����ؼ� �����Ѱ��Դϴ�. 

*���������� �����ȹ�� ũ�� �ΰ����� �з�
1.�����ϰ� �������������� ����ǰ��ϴ� ��� : no_unnest 
                  (���ϰ� ���ζ�~ ���������� Ǯ���!)
                        -������������ �����ض�~ : push_subq
                        -������������ �����ض�~ : no_push_subq
      
2.�������� ����Ǿ ����ǰ� �ϴ� ��� : unnest 
  
  -��������( Semi join)
                    1.Nested loop semi join : nl_sj
                    2.hash semi join : hash_sj
                    3.merge semi join : merge_sj
      - ��Ƽ����(anti join)
                         1.nested loop anti join : nl_aj
                         2.hash anti join : hash_aj
                         3.merge anti join : merge_aj
                 
unnest ----������ ���ƶ� ----�������� Ǯ�� ���Ķ� ����� ����������
no_unnest ---- ���ζ� ���ϰ� ���������� Ǯ���

100.�Ʒ��� SQL�� �����ȹ�� �������� Ǯ���� �Ͻÿ�!

select /*+ gather_plan_statistics*/ename,sal
from emp
where deptno in  (select /*+ unnest*/ deptno
                            from dept     
                               where loc='DALLAS'); 


����: unnest �� ������ ���� ������������ �����ȹ�� filter �� �����鼭
������ �ʹ� ������ ������ ����� ���� ������ hash join����
����ǰ� �ϸ鼭 ������ ���̰� ������ �����մϴ�. 

101.�׷��� �Ʒ��� �����ȹ�� �������� Ǯ���� �ʰ� filter�� �����ȹ�� 
������ ������ �������������� ����ǰ� �Ͻÿ�

select /*+ gather_plan_statistics*/ename,sal
from emp
where deptno in (select /*+ no_unnest*/  deptno
                         from dept     
                             where loc='DALLAS'); 

����: no_unnest�� ����ؼ� �����ϰ� �������������� ����Ǿ����ϴ�.
�׷��� ������ ������ 13���� �Ʊ� hash join semi �� ����Ǿ����� �� 
7�����µ� ��2�� ���� ������ ���������ϴ�.
���� ���������� ���̺� 2���� ��뷮 ���̺��� ���� unnest
�� �Ἥ ����(�ؽ�����)���� ����Ǵ°� �����ϰ�
�׷��� �ʰ� ���̺��� �۴ٸ� ���� �޸𸮸� ����ϴ� �ؽ���������
�������� ���� ������������ �����ȹ(filter)�� ����Ǵ°� �����մϴ�.

102.�Ʒ��� SQL�� �����ȹ�� Ȯ���ϰ� �������� ����Ǿ ����ǰ� �Ͻÿ�!

select /*+ gather_plan_statistics*/ ename,sal
from emp 
  where deptno=(select deptno
                           from dept
                                where deptno =10);

��������� ���� ���� 1 ..2..3
����: ���� SQL�� �����ϰ� �������� ������ ������ SQL�ε� ����������
���������߿� ������� ���� �����߳ĸ� �������������� �����Ͽ����ϴ�.
                         ��

select /*+ gather_plan_statistics*/ ename,sal
from emp 
  where deptno (select /*+ unnest*/ deptno
                           from dept
                                where deptno =10);

select *  from table(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));

�̷��� �ϸ� �ȵȴ� = �� Ǯ��ȵǰ� in�� ����ؾ� �Ѵ�! 
                         ��
select /*+ gather_plan_statistics*/ ename,sal
from emp 
  where deptno in (select /*+ unnest*/ deptno
                           from dept
                                where deptno =10);

select *  from table(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));

���� : ���� ������������ ���� ������ ������ �����ڸ� = �� �ϸ�
unnest ��Ʈ�� ������ �ʽ��ϴ�. �ֳ��ϸ� ������������ ����������
�ѰǸ� �����Ѵٰ� �ϸ� ���� �ؽ��������� Ǯ�� �ʾƵ� �Ǳ� �����Դϴ�.
�׷��� ���� hash join���� ����ǰ� �ϰ� �ʹٸ� �����ڸ� = ���� 
in ���� �ٲ���� �մϴ�. 

103.�Ʒ��� SQL�� �����ȹ�� �������� Ǯ���� ���� ��������������
����ǰ� �ϴµ� �������������� ����ǰ� �Ͻÿ�!

select /*+ gather_plan_statistics*/ ename,sal
 from emp
   where deptno = (select deptno
                              from dept
                                   where deptno=10);
                               ��
                        
select /*+ gather_plan_statistics*/ ename,sal
 from emp
   where deptno = (select /*+ no_unnest push_subq*/ deptno
                              from dept
                                   where deptno=10);

                                 ��

104.���� SQL �� �����ȹ�� �̹����� ������������ ����ǰ� �Ͻÿ�!
(�����ϰ� ���������� ����Ǹ鼭 ���������κ��� ����ǰ� �Ͻÿ�! 


select /*+ gather_plan_statistics*/ ename,sal
 from emp
   where deptno = (select /*+ no_unnest no_push_subq*/ deptno
                              from dept
                                   where deptno=10);


filter �� ���Դܰ��� ���μ����������� ������ ���̴�. 

���� : no_unnest �� no_push_subq �� ���� ¦����Ʈ �Դϴ�.
no_unnest �� �������� Ǯ�� ���� �������������� �����ض� ~ ��� 
��Ʈ�̰� �� ��Ʈ�� ��������� �������� Ǯ���ʰ� ��������������
����ɼ� �ֱ� ������ no_push_subq ��Ʈ�� ����� �� �־��� ���Դϴ�.
��ü�� push_subq��Ʈ�� �������������� ����Ǿ������� �� ������ ��Ʈ�Դϴ�.
�ֳ��ϸ� ���������� ���� �����ϸ鼭 �����͸� �˻��� ���������� �Ѱ��ֱ⸸ �ϸ� �Ǳ� �����Դϴ�. �׷��� ���࿡ ���� �������� ����ȴٸ� ���� ������ �ִ� 
�μ���ȣ�߿� ���������� �ִ� �μ���ȣ�� ã�� ���ؼ� ������ ��ĵ�ϸ鼭 ã�� �۾�(Fliter) �� �ؾ��ϱ� ������ ��뷮�� �Ͽ�� ������ ���� �������ϴ�. 

105.�Ʒ��� SQL�� �����ϰ� �������������� ����ǰ� �ϰ�
������������ ����ǰ� �Ͻÿ�!

select /*+ gather_plan_statistics */ ename,sal
 from emp
     where deptno in ( select deptno 
                              from dept) ;

select *  from table(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));

                                         ��

select /*+ gather_plan_statistics */ ename,sal
 from emp
     where deptno in ( select /*+ no_unnest push_subq*/ deptno 
                              from dept) ;

select *  from table(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));



����: no_unnest �� ���������� �����ض�~~ ��� ���̰�
       push_subq�� ������������ �����ض�~~��� ���Դϴ�. 


106.���� SQL�� �����ȹ�� ������������ ����ǰ� �ϼ���

select /*+ gather_plan_statistics */ ename,sal
 from emp
     where deptno in ( select deptno 
                              from dept) ;

                                
 select /*+ gather_plan_statistics */ ename,sal
 from emp
     where deptno in ( select /*+ no_unnest no_push_subq*/ deptno 
                              from dept) ;

select *  from table(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));

        
Filter ��� ���� ���κ��� ���� ��� ���� �������ش�. 

107.���� SQL�� �������� ����ǰ��Ͻÿ�

select /*+ gather_plan_statistics */ ename,sal
 from emp
     where deptno in ( select deptno 
                              from dept) ;

                        ��

select /*+ gather_plan_statistics */ ename,sal
 from emp
     where deptno in ( select/*+ unnest hash_sj*/ deptno 
                              from dept) ;




����: semi �� ���� �����̶�� ������ ������ �ߴµ� ������ ������ �Ѱ�
�ƴ϶� ������ ������ �߽���. �� ������ ������ ���ϰ� ���� �������ĸ� ���� SQL
�� ���ι����� �ƴ϶� �������������̱� �����Դϴ�.



108.���� SQL�� �����ȹ�� dept�� �޸𸮷� �ö󰡰� �Ͻÿ�!
(dept �� hash table�� �ǰ��Ͻÿ�!) 

swap_join_inputs

select /*+ gather_plan_statistics */ ename,sal
 from emp
     where deptno in ( select/*+ unnest hash_sj swap_join_inputs(dept)*/ deptno 
                              from dept) ;

����: emp�� dept �� ��뷮 ���̺��̰� ���� ���� SQL�̸�
�ؽ� ������������ �����ϵ� ���� ���̺��� �޸𸮷� �ö󰡰�
��Ʈ�� �� ���� ��Ʈ�� ���� ������� ��Ʈ�Դϴ�. 

109.�׷� ���� �����ȹ�� �����ϰ� �������������� ����ǰ� �ϴµ�
nested loop semi ������ �ǰ� �Ͻÿ�

select /*+ gather_plan_statistics */ ename,sal
from emp
where deptno in
           (select / *+ unnest ? */deptno
                    from dept d) 
 
                           ��
 
select /*+ gather_plan_statistics */ ename,sal
from emp
where deptno in
           (select / *+ unnest nl_sj */deptno
                    from dept d) ;

select *  from table(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));

���� hash semi ���ζ��� ������ ���� 7�����µ� nested loop semi ����
���� ������ ������ 46���� �ξ� ���� �þ���ϴ�.
�� hash semi ������ ����ϴ°� �ξ� ���ɿ� �����մϴ�.

110.�������� ������� �̸��� ����Ͻÿ�!
(�ڱ� �ؿ� ���Ӻ��ϰ� �Ѹ��̶� �ִ� �����) 

select ename
from emp
where empno  in ( select mgr from emp );


                                               
����: �����ȹ�� ���� �Ѵ� emp ���� ������������ �����ߴ��� �ƴϸ�
������������ �����ߴ��� Ȯ���� �˱Ⱑ ��ƽ��ϴ�. 

111.�׷��� Ȯ���� �˼� �ֵ��� QB_NAME ��Ʈ�� �Ἥ �ٽ� �����Ͻÿ�! 

select /*+ gather_plan_statistics QB_NAME(mainquery) * /ename
from emp
where empno in (select/* QB_NAME(subquery) * /mgr
                                            from emp); 

select * from table(dbms_xplan.display(format=>'basic') ) ; 

����: format => 'advanced' �� ����ϰ� �Ǹ� ���� ������ ���� �����ȹ��
Ȯ�� �� �� �ֽ��ϴ�.  QB_NAME ��Ʈ�� ����ϸ� ���ش������� �̸��� 
�����ְ� �˴ϴ�. ������ �̸��� ���ؼ� ���Ⱑ ������������ ������������
Ȯ�� �� �� �ְ� �˴ϴ�. 

113.�Ʒ��� ������ �����ȹ�� �ؽ������������� ����ǰ� �Ͻÿ�! 

select /*+ gather_plan_statistics */ ename
 from emp
     where empno in ( select/*+ unnest hash_sj* / mgr
                                     from emp) ;

select * from table(dbms_xplan.display(format=>'basic') ) ; 


114.���� SQL�� �����ȹ�� ���� ������������ �����ߴ��� ������������ 
�����ߴ����� Ȯ���ϱ� ���� QB_NAME ��Ʈ�� �Ἥ �����Ͻÿ�!

select /*+ gather_plan_statistics QB_NAME(main) */ ename
   from emp
     where empno in ( select/*+ QB_NAME(sub) unnest hash_sj* / mgr
                              from emp) ;

select * from table(dbms_xplan.display_cursor(format=>'advanced') );

����: ���������� ������ ������������ ����˴ϴ�. �׷��� swap_join_inputs
�� ���� ������������ ����ǰ� �� �� �ֽ��ϴ�. 

115.���� SQL��  subquery ���� ����Ǵ� hash semi join �� �ǰ��Ͻÿ�

select /*+ gather_plan_statistics QB_NAME(main) */ ename
 from emp
   where empno in ( select/*+ QB_NAME(sub) unnest hash_sj swap_join_inputs(emp@sub)* /                               mgr from emp) ;

select * from table(dbms_xplan.display_cursor(format=>'advanced') );

����: ���� ���� ���������� ���̺�� ���������� ���̺��� ���� ������
�ؽ� ���������� �ϴ� ��� ���������� ���̺� ���� ����ǰ� 
�ϰ� �ʹٸ� QB_NAME(sub) ��Ʈ�� �̿��ؼ� �������� �̸���
sub��� �ְ� swap_join_inputs ��ȣ�ȿ� ���̺� ��Ī���� emp@sub
�� ����ϸ� �˴ϴ�. �׷��� �����ȹ�� ���������� ���̺� ���� ����Ǹ鼭
hash right semi join���� ����˴ϴ�. 

116.�����ڰ� �ƴ� ������� �̸��� ����Ͻÿ�!
(�ڱ� �ؿ� ���Ӻ��ϰ� �Ѹ� ���� �����)

select ename
from emp
where empno not in (select mgr
                      from emp where mgr is not null);
                        

117.�� �����ȹ�� ���������� Ǯ���� �ʰ� �������� Ǯ���� �Ͻÿ�!

select /*+  gather_plan_statistics QB_NAME(main)  */ ename
from emp
where empno not in (select /*+ QB_NAME(sub) hash_aj*/ mgr
                                               from emp where mgr is not null);

not in �� ���� ������ hash_aj (��Ƽ����) �� ����Ѵ�.

����: not in �� ����� �������� ������ ������ ���̱� ���ؼ���
hash anti  ������ ����ϸ� �˴ϴ�. �ؽ� ��Ƽ �������� ����ǰ� �ϱ�
���� ��Ʈ�� unnest hash_aj �Դϴ�.

118.���� �ؽ����� �����ȹ�� ���μ����� �������� ���� ����ǰ� �Ͻÿ�! 

select /*+  gather_plan_statistics QB_NAME(main)  */ ename
from emp
where empno not in (select /*+ QB_NAME(sub) unnest hash_aj swap join_inputs(emp@sub)*/ mgr
                      emp where mgr is not null);

hash_sj

���� : not in �� ����� �������� ������ ������ ���̱� ���ؼ���
�ؽ� ��Ƽ �������� ����ǰ� �ϸ� �Ǵµ� ������������ ����ǰ� �Ϸ���
swap_join_inputs�� �Ἥ hash right anti join ���� ����ǰ� �ϸ� �˴ϴ�.


*�������� Ʃ���� �����ϸ�

���������� ���������� ���̺��� ��뷮�� �ƴϸ�?

"�����ϰ� �������� �����ȹ���� ����ǰ� �ϼ���

������Ʈ  no_unnest 
no_unnest �� ¦���� ��Ʈ?       push_subq
                                          no_push_subq 

���������� ���������� ���̺��� ��뷮�̸�?

*Hash semi ���� �Ǵ� Hash Anti �������� ����ǰ� �ϼ���!

select ename
from emp
where empno in ( select mgr 
                            from emp) ;

   �� ���� ��Ʈ
    /* = unnest hash_sj*/ 

select ename 
from emp
  where empno not in (select mgr from emp);
  
     �� ���� ��Ʈ
    /* = unnest hash_aj*/ 


�� 4.������ �м��Լ��� �̿��� Ʃ��

'�տ����� SQL Ʃ���� �Ҷ� ��Ʈ�� �̿��ؼ� Ʃ���� �ߴµ�
���ݺ��ʹ� ������ �ٸ� SQL�� �����ؼ� Ʃ���ϰڽ��ϴ�.

Ʃ����
 select detpno,sum(sal)
 from emp
group by deptno
                
union all
        
 select null as deptno,sum(sal)
 from emp;

                       ��

select deptno,sum(sal)
from emp
group by rollup(deptno);


120.�Ʒ��� UNION SQL�� Ʃ���Ͻÿ�! 

Ʃ���� 
select deptno,null as job,sum(sal)
from emp
group by deptno

union all

select null as deptno,job,sum(sal)
from emp
group by job
order by deptno asc,job asc;    ---------���� 8��
       
               ��

select deptno,job,sum(sal)
from emp
group by grouping sets ( (deptno), (job) );             ----- ���� 

121.�Ʒ��� UNION 3������ Ʃ���Ͻÿ�! 

Ʃ����
select deptno,null as job,sum(sal)
from emp
group by deptno

union all

select null as deptno,job,sum(sal)
from emp
group by job

union all

select null as deptno,null as job,sum(sal)
from emp
order by deptno asc,job asc
                   ��
Ʃ����
select deptno,job,sum(sal)
from emp
group by grouping sets ( (deptno), (job) ,() );    

122.�Ʒ��� SQL�� Ʃ�� �Ͻÿ�! 

Ʃ����
select empno,ename,sal(select sum(sal)
                                    from emp s
                                           where s.empno <=m.empno) ����ġ
from emp m
order by empno asc;

(Scalar subquery ����� ����) 
                      
                             ��
Ʃ���� 
select /*+ gather_plan_statistics*/ empno,ename,sal,
              sum(sal) over (order by empno asc) ����ġ  
                     from emp; 

���� : Ʃ������ emp ���̺��� 2�� ������ ������ Ʃ���Ĵ� �ѹ��� 
������ �߽��ϴ�.

123.�Ʒ��� SQL�� Ʃ���Ͻÿ�
(���� �����ִ� Query)
select deptno,ename,sal (select sum(sal)
                   from emp s
                     where s.empno<=m.empno
                      and s.deptno=m.deptno) ����ġ
                      from emp m
                      order by deptno asc,empno asc;

                        ��

select deptno,empno,ename,sal, sum(sal) over (partition by deptno
                     order by empno asc) ����ġ
 from emp;
