우리가 SQL 튜닝을 목차대로 배우면 된다고 했다..SQL 튜닝 갯수를 인덱스 SQL 튜닝
SQL 튜닝 갯수를 인덱스 SQL 튜닝

	1. Index SQL Tunning
	2. Join SQL Tunning
	3. Subquery SQL Tunning
	4. 데이터 분석함수를 이용한 Tunning
	5. 자동 SQL Tunning


2.조인 SQL 튜닝 
SQL 튜닝의 대부분은 조인이다. 그래서 조인을 잘알아둬야 한다. 그래서 조인의 소목차를 보자.

@@ -44,6 +44,7 @@ SQL 튜닝 시간에 배우는 조인 방법 3가지?
                                                         2.hash join
                                                         3. sort merge join


조인 방법을 왜 알아야 하는가? 조인을 바르게 할려면 알아야 합니다. 
그래서 요기 한번 문제를 통해서 조인 방법을 알려줄게요..

@@ -87,7 +88,6 @@ ordered 해도 결과는 달라지지 않는다..하지만 조인 순서가 바
실행계획을 보면다..바뀌었지? emp 부터 읽었죠?? 



이번에는 emp 테이블 부터 읽었고 버퍼도 증가했다..버퍼의 갯수가 상당히 증가했다.

이거 할때는 가급적이면 데모를 한번 돌리면 좋다...안돌려도 잘되면 냅두고요..
@@ -101,17 +101,12 @@ where dept d, emp e
where d.deptno=e.deptno; 



위의것은 선생님이 튜닝한것인데. 기존 ordered 방식에서 힌트를 뺴니까 매우 빨라졌다 
그이유는 앞의 있던 순서가 많아짐에 따라 앞에읽는게 커져서 느려짐 그래서 이것을 Optimizer 가 스스로 할 수 있게 뺴주었더니 빨라졌다

*조인순서 연습 : emp 와 Salgrade 테이블을 조인해서 이름과 월급과 급여등급(grade) 를 출력하시오 조인순서 성능이 좋도록 하시오!!

select /*+ gather_plan_statistics ordered*/e.ename, e.sal, s.grade
from salgrade s, emp e
where e.sal between s.sal s.losal and s.hisal ;


조인 순서를 결정하는 힌트 2가지?
                 1.ordered : from절에서 기술한 테이블 순서대로 조인해라~
                 2.Leading: Leading 힌트 안에 사용한 테이블 순서데로 조인해라~
@@ -154,12 +149,13 @@ where e.sal between s.losal and s.hisal;

46. 45 번 쿼리의 실행계획이 nested loop 조인이 되게 힌트를 주시오!!

튜닝전
select/*+  gather_plan_statistics leading(s e)*/e.ename,e.sal,s.grade
from salgrade s, emp e
where e.sal between s.losal and s.hisal;

                   ↓

튜닝후
select/*+  gather_plan_statistics leading (e d) use_nl(e d)*/e.ename,e.sal,s.grade
from dept d, emp e
where d.dept=e.dept 
@@ -174,10 +170,12 @@ select *from table(dmbs_xplan.display_cursor(null,null,'ALLSTATS LAST)');

47. 46번의 쿼리의 조인 문장의 실행계획이 nested loop 조인이 되도록 하는 조인순서는 dept -----emp 순이 되도록 하시오! 

튜닝전
select /*+  gather_plan_statistics leading (e d) use_nl(e d)*/e.ename,e.sal,s.grade
from dept d, emp e
where d.dept=e.dept 
         ↓
튜닝후
select /*+ gather_plan_statistics leading (d e) use_nl(d e)*/e.sal,e.job,d.loc
from dept d, emp e
where d.deptno=e.deptno ;
@@ -195,9 +193,6 @@ where e.sal between s.losal and s.hisal;

select *  from table(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));




여기 확인해보면 salgrade 먼저 탐색하고 그다음에 emp 를 탐색하는것을 볼수 있다.

49.이름이 SCOTT인 사원의 이름과 월급과 부서위치를 출력하는 조인 문장을 작성하시오
@@ -225,11 +220,12 @@ where e.deptno=d.deptno and ename='SCOTT';
51.아래의 조인문장의 조인순서는 EMP ---- → dept 로 조인하고 조인 방법은 
nested loop 조인이 되도록 힌트를 주고 튜닝하시오! 

튜닝전
select e.ename,e.sal,d.loc
from emp e , dept d
where e.deptno=d.deptno and e.ename = 'SCOTT';
                     ↓

튜닝후
select /*+ gather_plan_statistics leading (e d) use_nl(e d)*/e.ename,e.sal,d.loc
from emp e , dept d
where e.deptno=d.deptno and e.ename = 'SCOTT';
@@ -264,7 +260,7 @@ select /*+ gather_plan_statistics leading (d e) use _nl(e)*/e.ename,e.sal,d.loc
from dept d, emp e
where e.empno=d.deptno

점심시간문제 53.  SQL 튜닝으로 내줄게요! 아래의 SQL이 적절한 실행계획이 나올수 있도록 튜닝하시오!
점심시간문제 53.SQL 튜닝으로 내줄게요! 아래의 SQL이 적절한 실행계획이 나올수 있도록 튜닝하시오!

Select e.ename,e.sal,s.grade 
          from emp e, salgrade s
@@ -286,7 +282,7 @@ and s.grade=1;

설명 : Leading 힌트에 사용했던 테이블 별칭중 두번째 별칭을 use_nl 에 기술하면 됩니다.

튜닝전: 
튜닝전
select /*+ gather_plan_statistics leading (s e) use_nl (e) */ e.ename,e.sal,s.grade
from emp e , salgrade s
where e.sal between s.losal and s.hisal
@@ -304,7 +300,7 @@ and e.sal between s.losal and s.hisal;
select e.ename,e.sal,d.loc,s.grade
from emp e ,dept d sal

55. 위의 SQL 의 조인 순서와 방법을 아래와 같이 되게 하시오!  (3개의 조인 튜닝)
55.위의 SQL 의 조인 순서와 방법을 아래와 같이 되게 하시오!  (3개의 조인 튜닝)

dept ----- salgrade -----emp  ← 이렇게 순서를 정하고 싶지만 dept와 salgrade가 서  
                                             로 연결고리가 없어서 이렇게하면 안된다. 
@@ -343,8 +339,7 @@ from emp e, dept d, salgrade s
where e.deptno = d.deptno
and e.sal between s.losal and s.hisal; 

select *  from table(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));

select  *  from table(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));

순서를 아는것이 중요하다….

@@ -367,7 +362,7 @@ AND ename='KING' ;
                       ↑
                이 두개랑 조인한 결과랑 ///       salgrade 가 조인하는것임. 

59. 위의 SQL 의 조인 순서를 아래와 같이하고 조인방법은 전부 nested loop join 되게 하시오!!!
59.위의 SQL 의 조인 순서를 아래와 같이하고 조인방법은 전부 nested loop join 되게 하시오!!!

설명 : emp 테이블에서 ename 이 KING 인 데이터가 1건이므로 1건만 읽어서 dept 테이블과 조인하고 dept 테이블 조인해서 부서위치를 가져오고 
마지막으로 salgrade 테이블 조인해서 부서위치를 가져오고 emp 와 dept 테이블과 조인한 결과가 salgrade 테이블과 조인합니다. 
@@ -379,8 +374,8 @@ where e.deptno=d.deptno
and e.sal between s.losal and s.hisal
AND ename='KING' ; 

select *  from table(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));

select *  from table(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));

60.CHICAGO 에서 근무하는 사원들의 이름과 부서위치와 월급과 급여등급을 출력하시오(SQL문제)

@@ -434,7 +429,6 @@ from emp e , dept d
where e.deptno=d.deptno and e.job ='SALESMAN';



애네들이 어디 부서에서 일하는지 한명씩 가서 확인을 한다.
그래서 대량의 데이터를 처리하게되면 성능이 느려진다는 단점이 존재한다.
순차적으로 하나씩 처리하다 보니..처음에는 martin의 데이터로 조인하고
@@ -449,7 +443,7 @@ hash 조인은 무엇이냐..해쉬 조인은 해쉬 알고리즘을 이용해

대용량 메모리를 조인할때는 HASH 조인을 해주자.

예제
예제)
select /*+ gather_plan_statistics leading(d e) use_hash(e)*/
e.ename , e.loc
from emp e ,dept d
@@ -458,7 +452,7 @@ where e.deptno=d.deptno

해쉬조인이 된것을 볼수 있다.

HASH JOIN
*HASH JOIN

dept 테이블과 emp 테이블이 둘다 메모리로 올라가는데 메모리에한번에  올라가는데
둘다 한번에 다 올라가서 조인을 하면 너무 좋을 텐데 그렇게는 안되고
@@ -486,7 +480,8 @@ table acess full emp ---- probe table(디스크에 있는 테이블)
                             2. 대용량일 경우에는 hash 테이블사용! 

64.아래의 SQL을 튜닝하는데 해쉬 조인되게 하고 emp 테이블이 메모리로 올라가서 hash 테이블이 되게하세요.
                                       ↓

				     ↓

select /*+ gather_plan_statistics  leading(e d) use_hash(d)*/ 
e.ename,d.loc
@@ -631,7 +626,7 @@ sort merge join 을 사용하면 됩니다.
그래서 sort merge 조인 수행하면 연결고리가 되는 키 컬럼(deptno)를 정렬해놓고 
조인을 합니다.

예제
예제)
select /*+ gather_plan_statistics leading(d e) use_merge(e) */
e.ename,d.loc,e.deptno
from emp e,dept d
@@ -659,3 +654,4 @@ select /*+ gather_plan_statistics leading(s e) use_merge(e) */
e.ename,e.sal,s.grade
from emp e, salgrade s
where e.sal between s.losal and s.hisal