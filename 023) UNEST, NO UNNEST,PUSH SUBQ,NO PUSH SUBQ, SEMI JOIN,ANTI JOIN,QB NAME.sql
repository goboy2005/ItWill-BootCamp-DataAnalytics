1.인덱스 SQL 튜닝 ( 8가지 엑세스 방법)
          1.index range scan
          2.index unique scan
          3.index full scan
          4.index fast full scan
          5.Index skip scan
          6.index merge scan
          7.Index bitmap merge scan
          8.Index join

2.조인 문장 튜닝 ( 조인순서,조인방법 3가지)
           1.nested lopp 조인 : use_nl         
           2.Hash join : use_hash
           3.sort merge 조인: use_merge 
3.서브쿼리 문장 튜닝
4.데이터 분석함수
5.자동 SQL 튜닝

§ 3.서브쿼리문장 튜닝

예제)
DALLAS 에서 근무하는 사원들의 이름과 월급을 출력하시오! 

select ename,sal
from emp
where deptno in (select deptno  
                              from dept
                                    where loc='DALLAS');
                           ↓
         
99.위의 서브쿼리문을 조인으로 수행해서 같은 결과를 보시오   
 DALLAS 에서 근무하는 사원들의 이름과 월급을 출력하시오 

select e.ename,e.sal
from emp e ,dept d
where e.deptno=d.deptno
and d.loc='DALLAS';

아래의 서브쿼리문의 실행계획을 보시오
select /*+ gather_plan_statistics*/ename,sal
from emp
where deptno in (select deptno
                         from dept     
                             where loc='DALLAS'); 

select *  from table(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));


설명: 위의 실행계획에 filter 가 보이면 위의  SQL을 서브쿼리문으로 수행한것
이고 hash join 이 실행계획에 보이면 조인문장으로
변경해서 수행한 것입니다. 우리는 서브쿼리문으로 작성했는데
옵티마이져가 조인으로 변경해서 수행한것입니다. 

*서브쿼리의 실행계획이 크게 두가지로 분류
1.순수하게 서브쿼리문으로 수행되게하는 방법 : no_unnest 
                  (강하게 감싸라~ 서브쿼리로 풀어라!)
                        -서브쿼리부터 수행해라~ : push_subq
                        -메인쿼리부터 수행해라~ : no_push_subq
      
2.조인으로 변경되어서 수행되게 하는 방법 : unnest 
  
  -세미조인( Semi join)
                    1.Nested loop semi join : nl_sj
                    2.hash semi join : hash_sj
                    3.merge semi join : merge_sj
      - 안티조인(anti join)
                         1.nested loop anti join : nl_aj
                         2.hash anti join : hash_aj
                         3.merge anti join : merge_aj
                 
unnest ----감싸지 말아라 ----조인으로 풀어 헤쳐라 서브로 감싸지말고
no_unnest ---- 감싸라 강하게 서브쿼리로 풀어라

100.아래의 SQL의 실행계획이 조인으로 풀리게 하시오!

select /*+ gather_plan_statistics*/ename,sal
from emp
where deptno in  (select /*+ unnest*/ deptno
                            from dept     
                               where loc='DALLAS'); 


설명: unnest 가 유리한 경우는 서브쿼리문의 실행계획이 filter 가 나오면서
성능이 너무 느릴때 조인의 방법중 가장 강력한 hash join으로
수행되게 하면서 성능을 높이고 싶을때 유리합니다. 

101.그러면 아래의 실행계획이 조인으로 풀리지 않고 filter가 실행계획에 
나오는 순수한 서브쿼리문으로 실행되게 하시오

select /*+ gather_plan_statistics*/ename,sal
from emp
where deptno in (select /*+ no_unnest*/  deptno
                         from dept     
                             where loc='DALLAS'); 

설명: no_unnest를 사용해서 순수하게 서브쿼리문으로 수행되었습니다.
그런데 버퍼의 갯수가 13개로 아까 hash join semi 로 수행되었을때 는 
7개였는데 약2배 가량 성능이 느려졌습니다.
위의 서브쿼리의 테이블 2개가 대용량 테이블인 경우는 unnest
를 써서 조인(해쉬조인)으로 수행되는게 유리하고
그렇지 않고 테이블이 작다면 굳이 메모리를 사용하는 해쉬조인으로
유도하지 말고 서브쿼리문의 실행계획(filter)로 수행되는게 유리합니다.

102.아래의 SQL의 실행계획을 확인하고 조인으로 변경되어서 수행되게 하시오!

select /*+ gather_plan_statistics*/ ename,sal
from emp 
  where deptno=(select deptno
                           from dept
                                where deptno =10);

실행순서는 안쪽 부터 1 ..2..3
설명: 위의 SQL을 순수하게 서브쿼리 문으로 수행한 SQL인데 서브쿼리와
메인쿼리중에 어느것을 먼저 수행했냐면 서브쿼리문부터 수행하였습니다.
                         ↓

select /*+ gather_plan_statistics*/ ename,sal
from emp 
  where deptno (select /*+ unnest*/ deptno
                           from dept
                                where deptno =10);

select *  from table(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));

이렇게 하면 안된다 = 로 풀면안되고 in을 사용해야 한다! 
                         ↓
select /*+ gather_plan_statistics*/ ename,sal
from emp 
  where deptno in (select /*+ unnest*/ deptno
                           from dept
                                where deptno =10);

select *  from table(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));

설명 : 위의 서브쿼리문과 메인 쿼리문 사이의 연산자를 = 로 하면
unnest 힌트가 먹히지 않습니다. 왜냐하면 서브쿼리에서 메인쿼리로
한건만 리턴한다고 하면 굳이 해쉬조인으로 풀지 않아도 되기 때문입니다.
그래서 만약 hash join으로 수행되게 하고 싶다면 연산자를 = 에서 
in 으로 바꿔줘야 합니다. 

103.아래의 SQL의 실행계획이 조인으로 풀리지 말고 서브쿼리문으로
수행되게 하는데 서브쿼리문부터 수행되게 하시오!

select /*+ gather_plan_statistics*/ ename,sal
 from emp
   where deptno = (select deptno
                              from dept
                                   where deptno=10);
                               ↓
                        
select /*+ gather_plan_statistics*/ ename,sal
 from emp
   where deptno = (select /*+ no_unnest push_subq*/ deptno
                              from dept
                                   where deptno=10);

                                 ↓

104.위의 SQL 의 실행계획이 이번에는 메인쿼리부터 수행되게 하시오!
(순수하게 서브쿼리로 수행되면서 메인쿼리로부터 수행되게 하시오! 


select /*+ gather_plan_statistics*/ ename,sal
 from emp
   where deptno = (select /*+ no_unnest no_push_subq*/ deptno
                              from dept
                                   where deptno=10);


filter 가 나왔단것은 메인서브쿼리부터 읽혔단 뜻이다. 

설명 : no_unnest 와 no_push_subq 는 서로 짝궁힌트 입니다.
no_unnest 는 조인으로 풀지 말고 서브쿼리문으로 수행해라 ~ 라는 
힌트이고 이 힌트를 먼저써줘야 조인으로 풀지않고 서브쿼리문으로
수행될수 있기 때문에 no_push_subq 힌트가 수행될 수 있었던 것입니다.
대체로 push_subq힌트가 서브쿼리문으로 수행되었을때는 더 유리한 힌트입니다.
왜냐하면 서브쿼리문 부터 수행하면서 데이터를 검색해 메인쿼리로 넘겨주기만 하면 되기 때문입니다. 그런데 만약에 메인 쿼리부터 수행된다면 메인 쿼리에 있는 
부서번호중에 서브쿼리에 있는 부서번호를 찾기 위해서 일일히 스캔하면서 찾는 작업(Fliter) 를 해야하기 때문에 대용량인 겅우는 성능이 많이 느려집니다. 

105.아래의 SQL이 순수하게 서브쿼리문으로 수행되게 하고
서브쿼리부터 수행되게 하시오!

select /*+ gather_plan_statistics */ ename,sal
 from emp
     where deptno in ( select deptno 
                              from dept) ;

select *  from table(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));

                                         ↓

select /*+ gather_plan_statistics */ ename,sal
 from emp
     where deptno in ( select /*+ no_unnest push_subq*/ deptno 
                              from dept) ;

select *  from table(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));



설명: no_unnest 는 서브쿼리로 수행해라~~ 라는 것이고
       push_subq는 서브쿼리부터 수행해라~~라는 것입니다. 


106.위의 SQL의 실행계획이 메인쿼리부터 수행되게 하세요

select /*+ gather_plan_statistics */ ename,sal
 from emp
     where deptno in ( select deptno 
                              from dept) ;

                                
 select /*+ gather_plan_statistics */ ename,sal
 from emp
     where deptno in ( select /*+ no_unnest no_push_subq*/ deptno 
                              from dept) ;

select *  from table(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));

        
Filter 라는 것은 메인부터 들어갔다 라는 것을 정의해준다. 

107.위의 SQL이 조인으로 수행되게하시오

select /*+ gather_plan_statistics */ ename,sal
 from emp
     where deptno in ( select deptno 
                              from dept) ;

                        ↓

select /*+ gather_plan_statistics */ ename,sal
 from emp
     where deptno in ( select/*+ unnest hash_sj*/ deptno 
                              from dept) ;




설명: semi 의 뜻은 절반이라는 뜻으로 조인을 했는데 완전한 조인을 한게
아니라 절반의 조인을 했습니. 왜 완전한 조인을 못하고 절반 조인을냐면 위의 SQL
이 조인문장이 아니라 서브쿼리문장이기 때문입니다.



108.위의 SQL의 실행계획이 dept가 메모리로 올라가게 하시오!
(dept 가 hash table이 되게하시오!) 

swap_join_inputs

select /*+ gather_plan_statistics */ ename,sal
 from emp
     where deptno in ( select/*+ unnest hash_sj swap_join_inputs(dept)*/ deptno 
                              from dept) ;

설명: emp와 dept 가 대용량 테이블이고 위와 같은 SQL이면
해쉬 세미조인으로 수행하되 작은 테이블이 메모리로 올라가게
힌트를 준 위의 힌트가 가장 모범적인 힌트입니다. 

109.그럼 위의 실행계획이 순수하게 서브쿼리문으로 수행되게 하는데
nested loop semi 조인이 되게 하시오

select /*+ gather_plan_statistics */ ename,sal
from emp
where deptno in
           (select / *+ unnest ? */deptno
                    from dept d) 
 
                           ↓
 
select /*+ gather_plan_statistics */ ename,sal
from emp
where deptno in
           (select / *+ unnest nl_sj */deptno
                    from dept d) ;

select *  from table(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));

설명 hash semi 조인때는 버퍼의 개수 7개였는데 nested loop semi 조인
때는 버퍼의 갯수가 46개로 훨씬 많이 늘어났습니다.
즉 hash semi 조인을 사용하는게 훨씬 성능에 유리합니다.

110.관리자인 사원들의 이름을 출력하시오!
(자기 밑에 직속부하가 한명이라도 있는 사원들) 

select ename
from emp
where empno  in ( select mgr from emp );


                                               
설명: 실행계획을 보면 둘다 emp 여서 메인쿼리부터 수행했는지 아니면
서브쿼리부터 수행했는지 확실히 알기가 어렵습니다. 

111.그래서 확실히 알수 있도록 QB_NAME 힌트를 써서 다시 실행하시오! 

select /*+ gather_plan_statistics QB_NAME(mainquery) * /ename
from emp
where empno in (select/* QB_NAME(subquery) * /mgr
                                            from emp); 

select * from table(dbms_xplan.display(format=>'basic') ) ; 

설명: format => 'advanced' 를 사용하게 되면 좀더 정보가 많은 실행계획을
확인 할 수 있습니다.  QB_NAME 힌트를 사용하면 그해당쿼리에 이름을 
지어주게 됩니다. 쿼리의 이름을 통해서 여기가 메인쿼리인지 서브쿼리인지
확을 할 수 있게 됩니다. 

113.아래의 쿼리의 실행계획이 해쉬세미조인으로 수행되게 하시오! 

select /*+ gather_plan_statistics */ ename
 from emp
     where empno in ( select/*+ unnest hash_sj* / mgr
                                     from emp) ;

select * from table(dbms_xplan.display(format=>'basic') ) ; 


114.위의 SQL의 실행계획을 보면 메인쿼리부터 수행했는지 서브쿼리부터 
수행했는지를 확인하기 위해 QB_NAME 힌트를 써서 수행하시오!

select /*+ gather_plan_statistics QB_NAME(main) */ ename
   from emp
     where empno in ( select/*+ QB_NAME(sub) unnest hash_sj* / mgr
                              from emp) ;

select * from table(dbms_xplan.display_cursor(format=>'advanced') );

설명: 세미조인은 무조건 메인쿼리부터 수행됩니다. 그런데 swap_join_inputs
를 쓰면 서브쿼리부터 수행되게 할 수 있습니다. 

115.위의 SQL이  subquery 부터 수행되는 hash semi join 이 되게하시오

select /*+ gather_plan_statistics QB_NAME(main) */ ename
 from emp
   where empno in ( select/*+ QB_NAME(sub) unnest hash_sj swap_join_inputs(emp@sub)* /                               mgr from emp) ;

select * from table(dbms_xplan.display_cursor(format=>'advanced') );

설명: 위와 같이 메인쿼리의 테이블과 서브쿼리의 테이블이 서로 같을때
해쉬 세미조인을 하는 경우 서브쿼리의 테이블 부터 수행되게 
하고 싶다면 QB_NAME(sub) 힌트를 이용해서 쿼리블럭의 이름을
sub라고 주고 swap_join_inputs 괄호안에 테이블 별칭으로 emp@sub
를 사용하면 됩니다. 그러면 실행계획이 서브쿼리의 테이블 부터 수행되면서
hash right semi join으로 수행됩니다. 

116.관리자가 아닌 사원들의 이름을 출력하시오!
(자기 밑에 직속부하가 한명도 없는 사원들)

select ename
from emp
where empno not in (select mgr
                      from emp where mgr is not null);
                        

117.의 실행계획이 서브쿼리로 풀리지 않고 조인으로 풀리게 하시오!

select /*+  gather_plan_statistics QB_NAME(main)  */ ename
from emp
where empno not in (select /*+ QB_NAME(sub) hash_aj*/ mgr
                                               from emp where mgr is not null);

not in 을 썻기 때문에 hash_aj (안티조인) 을 사용한다.

설명: not in 을 사용한 서브쿼리 문장의 성능을 높이기 위해서는
hash anti  조인을 사용하면 됩니다. 해쉬 안티 조인으로 수행되게 하기
위한 힌트는 unnest hash_aj 입니다.

118.위의 해쉬조인 실행계획의 조인순서가 서브쿼리 부터 수행되게 하시오! 

select /*+  gather_plan_statistics QB_NAME(main)  */ ename
from emp
where empno not in (select /*+ QB_NAME(sub) unnest hash_aj swap join_inputs(emp@sub)*/ mgr
                      emp where mgr is not null);

hash_sj

설명 : not in 을 사용한 서브쿼리 문장의 성능을 높이기 위해서는
해쉬 안티 조인으로 수행되게 하면 되는데 서브쿼리부터 수행되게 하려면
swap_join_inputs를 써서 hash right anti join 으로 수행되게 하면 됩니다.


*서브쿼리 튜닝을 정리하면

서브쿼리와 메인쿼리의 테이블이 대용량이 아니면?

"순수하게 서브쿼리 실행계획으로 실행되게 하세요

관련힌트  no_unnest 
no_unnest 와 짝꿍인 힌트?       push_subq
                                          no_push_subq 

서브쿼리와 메인쿼리의 테이블이 대용량이면?

*Hash semi 조인 또는 Hash Anti 조인으로 수행되게 하세요!

select ename
from emp
where empno in ( select mgr 
                            from emp) ;

   ↓ 관련 힌트
    /* = unnest hash_sj*/ 

select ename 
from emp
  where empno not in (select mgr from emp);
  
     ↓ 관련 힌트
    /* = unnest hash_aj*/ 


§ 4.데이터 분석함수를 이용한 튜닝

'앞에서는 SQL 튜닝을 할때 힌트를 이용해서 튜닝을 했는데
지금부터는 완전히 다른 SQL로 변경해서 튜닝하겠습니다.

튜닝전
 select detpno,sum(sal)
 from emp
group by deptno
                
union all
        
 select null as deptno,sum(sal)
 from emp;

                       ↓

select deptno,sum(sal)
from emp
group by rollup(deptno);


120.아래의 UNION SQL을 튜닝하시오! 

튜닝전 
select deptno,null as job,sum(sal)
from emp
group by deptno

union all

select null as deptno,job,sum(sal)
from emp
group by job
order by deptno asc,job asc;    ---------버퍼 8개
       
               ↓

select deptno,job,sum(sal)
from emp
group by grouping sets ( (deptno), (job) );             ----- 버퍼 

121.아래의 UNION 3단절을 튜닝하시오! 

튜닝전
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
                   ↓
튜닝후
select deptno,job,sum(sal)
from emp
group by grouping sets ( (deptno), (job) ,() );    

122.아래의 SQL을 튜닝 하시오! 

튜닝전
select empno,ename,sal(select sum(sal)
                                    from emp s
                                           where s.empno <=m.empno) 누적치
from emp m
order by empno asc;

(Scalar subquery 사용한 것임) 
                      
                             ↓
튜닝후 
select /*+ gather_plan_statistics*/ empno,ename,sal,
              sum(sal) over (order by empno asc) 누적치  
                     from emp; 

설명 : 튜닝전은 emp 테이블을 2번 엑세스 했으나 튜닝후는 한번만 
엑세스 했습니다.

123.아래의 SQL을 튜닝하시오
(누적 보여주는 Query)
select deptno,ename,sal (select sum(sal)
                   from emp s
                     where s.empno<=m.empno
                      and s.deptno=m.deptno) 누적치
                      from emp m
                      order by deptno asc,empno asc;

                        ↓

select deptno,empno,ename,sal, sum(sal) over (partition by deptno
                     order by empno asc) 누적치
 from emp;
