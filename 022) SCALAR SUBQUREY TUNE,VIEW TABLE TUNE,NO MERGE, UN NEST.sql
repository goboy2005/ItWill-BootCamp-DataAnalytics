? SQL 튜닝 목차로 복습

SQL 튜닝 목차로 복습                  
1.인덱스 튜닝                                                                     데이터분석가
2.조인문장 튜닝                                                              (데이터 사이언티스트)
3.서브쿼리문 튜닝
4.데이터 분석함수를 이용한 튜닝                                                        ↓
5.자동 SQL 튜닝                                                     SQL,파이썬,R코딩을 통해서 데이터분석

    
*조인문장 튜닝시 중요한 기술 2가지?

1.조인 순서 : 1.leading
                 2.Ordered

2.조인 방법:  Nested loop 조인 : use_nl : 적은양의 데이터로조인
                 Hash 조인 : use_hash : 대용량 데이터로 조인 
                 sort merge 조인 : use_merge : 대용량 데이터로 조인

   OLTP 서버                                                                      DW 서버

       ↓                                                                              ↓

실시간 조회 처리를 위한 데이터가                                     건강보험 심사평가원  
저장되어있는곳                                                           (우리나라 전 국민의 모든 의료기록)

                                                                                   10년정보,20년 정보저장



Nested loop 조인을 주로 사용                                                  해쉬조인,merge 조인
                                                                                          데이터 분석함수로 주로 사용               
                                                                                          파티션 테이블, 병렬처리


  조인순서의 중요성

조인순서에 따라서 수행성능이 달라질 수 있습니다.
조인순서는 조인하려는 시도횟수가 적은 테이블을 driving 테이블로
선정해서 조인순서를 고려하게 중요합니다.

nested loop
  table acess full dept---선행 테이블,driving 테이블
  table acess full emp--- 후행 테이블 ,driven 테이블

hash join 
table acess full dept -----hash table( 메모리로 올라가는 테이블 )
table acess full emp ---- probe table( 디스크에 있는 테이블 )        

어떤 조인이던 간에 먼저 읽는 테이블 크기가 작거나 
검색조건절에 의해서 엑세스되는 건수가 작은것을 먼저 읽는게
조인순서에 있어서 중요합니다.

*조인문장 튜닝하는 순서
예: select/+* gather_plan_statistics leading(d e)*/ e.ename,d.loc
     from emp e, dept d    ------  emp 14건 , dept4건 
    where e.deptno=d.deptno; 
     and e.job='SALESMAN'  ----4 건 
     and d.loc='CHICAGO' ------ 1건 


1.조인순서를 정한다.  ---- from 절의 테이블의 건수를 다 확인한다.
2.조인방법을 정한다.  ---- 접속한 서버의 종류가 뭔지 확인한다. 
                                   (OLTP 서버인지 DW 서버인지 확인한다)
                                   위와 같이 데이터건수를 확인해서 대용량이 
                                   아니면 nested loop 조인을 쓴다. 
              
                                                                     
74.아래의 SQL 조인문장의 조인순서와 조인방법을 결정하시오 !

select e.ename,d.loc,e.sal
  from emp e, dept d
  where e.deptno=d.deptno
  and e.name = 'KING' 
                  ↓
select /*+ gather_plan_statistics leading(e d) use_nl(d)* e.ename,d.loc,e.sal
  from emp e, dept d
  where e.deptno=d.deptno
  and e.ename = 'KING';
  
select *  from table(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));

75.emp dept 가 대용량 테이블이라고 가정하고 아래의 SQL의 조인순서와 조인방법을 결정하시오! 

select e.ename,d.loc
from emp e,dept d
where e.deptno = d.deptno; 
               ↓
select /*+ gather_plan_statistics leading (d e) use_hash(e)*/e.ename,d.loc
from emp e,dept d
where e.deptno =d.deptno ; 

select *  from table(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));

76.아래의 SQL의 조인순서와 조인방법을 결정하시오! (emp 와 salgrade 가 대용량 테이블 이라
가정하고 DW 서버에서 수행되는 SQL이라고 가정하고 하세요)

select e.ename,e.sal,s.grade
where emp e, salgrade s
where e.sal between s.losal and s.hisal
order by s.sal asc;
             ↓
select /*+ gather_plan_statistics leading(s e) use_merge(e)*/  e.ename,e.sal,s.grade
where emp e, salgrade s
where e.sal between s.losal and s.hisal;

? 5.Outer 조인의 튜닝방법

outer 조인의 조인순서는 outer 조인 sign 이 없는 쪽에서 있는쪽으로
순서가 고정이 됩니다. 그러다보니 조인 순서를 변경하기가 어려워
튜닝이 힘든데 이를 개선할 수 있는 힌트가 있습니다.

예)
insert into emp(empno,ename,sal,deptno)
values(2921,'JACK',4500,70);

select /*+ gather_plan_statistics*/e.ename,d.loc
from emp e, dept d
where e.deptno=d.detpno(+)'

77.아래의 조인순서를 dept---emp 순이 되게 하시오!

select /*+ gather_plan_statistics*/e.ename,d.loc
from emp e, dept d
where e.deptno=d.deptno(+);
       ↓
select /*+ gather_plan_statistics leading (d e) use_nl(e) */e.ename,d.loc
from emp e, dept d
where e.deptno=d.deptno(+);

select *  from table(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));

78.위의 outer 조인의 조인순서를 dept --- emp 순이 되게 하시오! (77연결)

select /*+ gather_plan_statistics*/e.ename,d.loc
from emp e, dept d
where e.deptno=d.deptno(+);
       ↓
select /*+ gather_plan_statistics leading (d e) use_hash(e) swap_join_inputs(d) */e.ename,d.loc
from emp e, dept d
where e.deptno=d.deptno(+);

select *  from table(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));

79.emp 와 bonus를 조인해서 이름과 comm2를 출력하는데
outer join을 이용해서 jack 도 출력될수 있도록 하시오! 

select e.enme,b.comm2
from emp e , bonus b
where e.empno=b.empno(+)

80.위의 조인순서가 bonus----emp 순이 되게하시오!

select e.enme,b.comm2
from emp e , bonus b
where e.empno=b.empno(+)
        ↓
select /*+ gather_plan_statistics leading (b e) use_hash(e) swap_join_inputs(b)*/ e.ename,b.comm2
from emp e , bonus b
where e.empno=b.empno(+);

select *  from table(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));

* 6.스칼라 서브쿼리를 이용한 조인

 select                          -서브쿼리 가능  : Scalar subquery
   from                         -서브쿼 가능 : in line view
     where                      -서브쿼리 가능: 
      group by                  -x
        having by              -서브쿼리 가능
            order by            -서브쿼리 가능 : scalar subquery

81.이름, 월급 사원 테이블서 최대월급을 출력하시오
(select 절의 서브쿼리인 스칼라 서브쿼리를 이용해서)

select ename,sal, (select max(sal) from emp) 최대월급)
from emp;

                     ↓    

select /*+ gather_plan_statistics*/ ename,sal,max(sal) over () 최대월급
from emp;

select *  from table(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));

튜닝후 버퍼가 줄어야하는데 버퍼가 그대로이다..근데 원리상 줄어드는것임.

82.아래의 SQL을 튜닝하시오!

select ename,sal,(select max(sal) from emp) 최대월급,  
                  (select min(sal) from emp) 최소월급 
        from emp
                   ↓
select  /*+ gather_plan_statistics*/ ename,sal,max(sal) over () 최대월급,
                 min(sal) over () 최소월급
from emp;

select *  from table(dbms_xplan.display_cursor(null,null,'ALLSTATS LAST'));

83.아래의 SQL을 튜닝하시오!
부서번호,이름 월급,자기가 속한 부서번호의 평균월급을 출력하는데 자기의 월급이
자기가 속한 부서번호의 평균월급보다 더 큰 사원들만 출력하시오!
(튜닝후 emp 테이블을 한번만 엑세스 해서 똑같은 결과가 출력되게 하시오!)

select e.deptno,e.ename,e.sal,v.부서평균
     from emp e, (select deptno,avg(sal) 부서평균 
                        from emp
                         group by deptno) v
where e.deptno=v.deptno and e.sal > v.부서평균 ;                      
    
                 ↓

튜닝후 emp 테이블을 한번만 엑세스 해서 똑같은 결과가 출력되게 하시오! 

select deptno,ename,sal,avg(sal) over (partition by deptno) 부서평균
from emp;

where sal> 부서평균 -----이거 에러난다 ( 이유 실행순서때문에)

*위의 SQL을 사용하려면 from 절의 서브쿼리인 in line view 를 사용해야 한다. 

select deptno,ename,sal,
from               (select, avg(sal) over (partition by deptno) 부서평균
                               from emp)
where sal>부서평균 ;


? DML 문을 이용한 서브쿼리문의 튜닝

예제: ALLEN 의 월급을 KING의 월급으로 변경하시오

update emp
set sal=(select sal from emp where ename='KING')
where ename='ALLEN';
(서브쿼리를 이용한 Update 문이다) 


85.사원 테이블에 loc 컬럼을 추가하고 해당 사원이 속하 부서위치로 값을 갱신하시오!

alter table emp
add loc varchar2(20);

Befrore 튜닝 
update emp e
set loc = (select loc 
                 from dept d
                   where e.deptno=d.deptno);


설명: emp 테이블의 컬럼이 서브쿼리 안으로 들어가게 되면 서브쿼리부터 수행되는게 아니라
메인 쿼리(update)문부터 실행됩니다. 
Update 문을 수행하는데 제일 먼저 맨위에 있는 KING 의 부서위치를 갱신하기 위해서 
KING 의 부서번호 10번을 서브쿼리 안으로 넣어서
서브쿼리에서 10번 부서번호의 부서위치를 출력하고 KING 의 부서위치를 NEW YORK으로 
갱신합니다. 그다음행의 BLAKE 도 똑같은 방법으로 갱신하면서 EMP 테이블의 14명의 사원들의 데이터를 이렇게 갱신합니다. 그러면 문제가 UPDATE가 14번이 수행됩니다. 

select ename,loc from emp; 

After 튜닝
(Merge 문을 사용해주면된다)

merge into emp e
using dept d
on (e.deptno=d.deptno)
when matched then
update set e.loc=d.loc; 

튜닝전과는 다르게 튜닝후는 데이터를 한번에 갱신합니다.

86.사원 테이블에 sal2 라는 컬럼을 추가하시오! 

alter table emp
  add sal2 number(10)

87.지금 추가한 sal2에 해당 사원의 월급으로 값을 갱신하시오.

update emp
set sal2=sal;

	
88.아래의 복합뷰를 생성하고 뷰를 쿼리하시오!

create view emp_dept 
as
  select e.ename,e.loc as emp_loc,d.loc as dept_loc
 from emp e, dept d
where e.deptno=d.deptno;

select * from emp_dept;

89.emp_dept 뷰를 수정해서 emp_loc값을 dept_loc의 값으로 갱신하시오! 

update emp_dept
   set emp_loc=dept_loc ;

하면 에러가난다!  ERROR 발생 

90.위의 Update 문이 수행되게 설정하시오!

위의 복합뷰를 갱신하려면 dept 테이블에 deptno 에 
Primary  Key 제약을 걸어주면 갱신됩니다
만약 dept 테이블에 deptno 에 pk 가없어서 20번이 여러개이고 30번이 여러 개 이면 뷰만들때 생성했던 뷰 쿼리문의 결과가 믿을 수 없는 결과가 됩니다. 
같은 20번인데 누구는 Dallas 이고 누구는 CHICAGO 이고 이렇게 뒤죽박죽 되버려서 뷰의 결과를
믿을수가 없게 되면 그 믿을 수 없는 데이터를 어떻게 또 갱신할수 있겠습니까?


alter table dept
add constraints dept_deptno_pk primary key(deptno)

update emp_dept
   set emp_loc=dept_loc ;

제한을 걸어주니 갱신 성공!! 

여기까지는 업데이트 하려면 VIEW 테이블을 만들어야한다는 전제 조건이 걸려있다.
통상 DB에 테이블 생성 요청하면 안만들어줄 가능성이 높으니 다른 방법을 사용한다.

91.만약 dba가 view를 안만들어줘서 view를 만들수없다면 어떻게 해야하는가?

update 문에서 서브쿼리를 쓸 수 있는절

update ← 서브쿼리 사용가능
set ← 서브쿼리 사용가능                      ----all 가능 
where ← 서브쿼리 사용가능 

update (  select e.ename,e.loc as emp_loc,d.loc as dept_loc
             from emp e, dept d
               where e.deptno=d.deptno)
set emp_loc = dept_loc;

설명: dba가 뷰를 만들어주지 않는다면 쿼리를 Update 에 서브쿼리를 사용해서
VIEW 의 쿼리문을 직접 작성하고 set 절에서 Update 하면 됩니다.

92.EMP 테이블에 dname 컬럼을 추가하고 해당사원의 부서명으로 값을 갱신하시오!

alter table emp
 add dname varchar2(10);

Update Subquery

Update (select e.ename,e.dname as emp_dname,
                               d.dname as dept_dname
                        from emp e, dept d
              where e.deptno=d.deptno )
set emp_dname=dept_dname;

Merge 사용! 

merge into emp e
using dept d
on (e.deptno=d.deptno)
when matched then
update set e.dname=d.dname;


튜닝전 --   현업에서 보게 될것들
update emp e
  set dname = (Select dname 
                       from dept d
                          where d.deptno=e.deptno);                      

                        
		 ↓

튜닝후 
merge into emp e
using dept d
on(e.deptno=d.deptno)
when matched then
update set e.dname=d.dname 

(요약  set 에다가 subquery 쓰는거 하지말고 merge로 한방에 작성해라 그게 더 빠르다.)

8.고급 조인문장 튜닝

"뷰안의 조인문의 조인순서를 변경하고자 할 때 사용하는 튜닝방법"

예: @demo 로 초기화 해주고

drop view emp_dept;

create view emp_dept
as
  select e.empno,e.ename,e.sal,d.loc
  from emp e, dept d
where e.deptno=d.deptno; 


93.emp_dept view 와 salgrade 테이블을 서로 조인해서 이름과 월급과 부서위치와 
급여등급(grade)를 력하시오

select v.ename,v.sal,v.loc,s.grade
       from emp_dept v, salgrade s
                 where v.sal between s.losal and s.hisal;

94.위의 SQL 의 실제 실행계획을 확인하시오! 

select /*+ gather_plan_statistics no_merge(v) leading (s v) une_nl(v)*/
v.ename,v.sal,v.loc,s.grade
   from emp_dept v, salgrade s   
      where v.sal between s.losal and s.hisal;

ERORR 난다.

설명: 위의 힌트에서는 nested loop 조인을 해라! 라고 했지만 실행계획에서는 nested loop 조인했다는게 없습니다. 왜 힌트를 무시했느냐? ! 이유는 View를 해체 해버려서 입니다.
view 가 해체되지 않았다면 실행계획에 view가 보입니다.

그래서 view를 해체하지 못하도록 힌틀를 줘야합니다

no_merge(v)   ----이 v가 d우리가 만든 

뷰가 나왔다는것은 뷰를 해체하지 않았다는 뜻이다.
저 네모는 뷰에 해당하는것이고 애를 한덩어리로 본다.
한덩어리로 보면 제일 안쪽이 여기 2번/3번이다..

뷰해체 안해서 힌트가 먹힌것.

실행계획 해석 : 먼저 Salgrade 를 full scan 하고 그리고 View 를 스캔하면서
nested loop조인을 수행했습니다. 

설명:  위의 힌트에서는 nested  loop 조인을 해라 ! 라고 했지만 
        실행계획에서는 nested loop 조인했다는게 없습니다. 
         왜 힌트를 무시했느냐면 view 를 해체해버려서 입니다. 
        view  가 해체되지 않았다면 실행계획에 view 가 보입니다. 
       그래서 view 를 해체하지 못하도록 힌트를 줘야합니다. 
        그 힌트가 바로 no_merge 입니다. 

 select  /*+ gather_plan_statistics  no_merge(v)  leading(s v) use_nl(v) */   
             v.ename, v.sal,  v.loc,  s.grade
       from  emp_dept   v,  salgrade   s
       where   v.sal  between   s.losal  and  s.hisal; 

설명:  힌트:   no_merge :   view 를 해체하지 말아라 ~
                        merge :   view 를 해체해라 ~

실행계획 해석:  먼저 salgrade 를 full scan 하고 그리고 view 를 스캔하면서
                              nested  loop 조인을 수행했습니다.

 뷰안의  조인 문장의 테이블의 조인순서는 어떻게 변경해야 하나요?

 select  /*+ gather_plan_statistics  no_merge(v)  leading(s v) use_nl(v) */   
             v.ename, v.sal,  v.loc,  s.grade
       from  emp_dept   v,  salgrade   s
       where   v.sal  between   s.losal  and  s.hisal; 

현재 view 안의 조인의 순서는  dept ---->  emp 순으로 읽고 있습니다. 
그런데 emp -----> dept  순으로 되게 할 수는 없나요 ?

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

95.위의 실행계획이 아래와 같이 나오게하시오 !

 select  /*+ gather_plan_statistics  no_merge(v)  leading(s v) use_nl(v) 
                leading(v.e  v.d)  use_nl(v.d)  */   
                      v.ename, v.sal,  v.loc,  s.grade
                        from  emp_dept   v,  salgrade   s
                             where   v.sal  between   s.losal  and  s.hisal; 
 
96. 위의 실행계획을 아래와 같이 출력되게하시오 !

 select  /*+ gather_plan_statistics  no_merge(v)  leading(v s) use_nl(s) 
               leading(v.e  v.d)  use_hash(v.d)  */   
             v.ename, v.sal,  v.loc,  s.grade
       from  emp_dept   v,  salgrade   s
       where   v.sal  between   s.losal  and  s.hisal; 

97.이번에는 아래와 같이 실행계획이 나오게하시오 !

 select  /*+ gather_plan_statistics  no_merge(v)  leading(s v) use_nl(v) 
               leading(v.d v.e)  use_hash(v.e)  */   
             v.ename, v.sal,  v.loc,  s.grade
         from  emp_dept   v,  salgrade   s
       where   v.sal  between   s.losal  and  s.hisal; 

설명:  view 를 사용하여 조인하는 어떤 SQL 문장의 성능이 느리다면 
        위와 같은 방법으로 튜닝을 하면 효과적으로 튜닝을 할 수 있습니다.

? 서브쿼리문 튜닝 

  select  ename, sal
       from  emp
       where  sal > ( select  sal
                             from  emp
                             where   ename='JONES');

 서브쿼리 문장 튜닝의 기술은 크게 2가지를 알면 됩니다
                                                                          힌트
   
    1.  순수하게 서브쿼리문으로 수행되게 하는 방법 :  no_unnest 
    2.  서브쿼리를 조인으로 변경해서 수행되게 하는 방법 :  unnest

   nest --> 감싸다
  unnest --> 감싸지 않고 풀어해친다. 
  no_unnest  --->  감싸라 !!!!!!!!