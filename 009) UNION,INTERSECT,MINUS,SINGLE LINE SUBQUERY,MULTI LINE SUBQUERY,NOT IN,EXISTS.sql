? 067 집합 연산자로 데이터를 위아래로 연결하기 1(UNION ALL)

* 데이터를 연결해서 출력하는 방법 2가지 

 1. 조인(join) : 데이터를 양옆으로 연결해서 출력하는 방법
 2. 집합 연산자 : 데이터를 위아래로 연결해서 출력하는 방법 

* 집합 연산자의 종류 4가지 
     1.  union  all
     2.  union
     3.  intersect
     4.  minus 

 예제)
 직업,직업별 토탈월급을 출력하시오 ! (세로 출력) 

select    job,  sum(sal)
   from  emp  
   group  by   job; 

JOB                  SUM(SAL)
------------------ ----------
SALESMAN              9100
CLERK                    4150
ANALYST                6000
MANAGER              8275
PRESIDENT             5000

예제)
전체 토탈월급을 출력하시오 !

 select  '전체토탈:'  as  job,  sum(sal)  
   from  emp; 

예제)
위의 SQL을 하나로 합쳐서 데이터가 위아래로 출력되게하시오 !

select    job,  sum(sal)                   데이터 타입(유형)  3가지
   from  emp                                1.  문자형
   group  by   job                          2.  숫자형
union  all                                     3.  날짜형 
select  '전체토탈:' as  job,  sum(sal)
  from  emp
  

설명: union all 로 위의 쿼리문의 결과와 아래의 쿼리문의 결과를 하나로
       합쳐서 출력하고 있다. 

      * 집합 연산자를 사용할 때 주의 사항은 다음과 같다.
      1. 집합 연산자 위 아래의 쿼리문의 컬럼의 갯수가 동일해야 합니다.
      2. 집합 연산자 위 아래의 쿼리문의 컬럼의 데이터 타입도 동일해야합니다.
      3. 집합 연산자 위 아래의 쿼리문의 컬럼의 컬럼명이 동일해야 합니다.
      4. order  by 절은 맨 아래쿼리문에만 작성할 수 있습니다. 

251.부서번호, 부서번호별 토탈월급을 출력하는데 맨 아래에 전체토탈
월급이 출력되게하시오 !  (union all 로 수행)

select   to_char(deptno) as deptno,  sum(sal)
  from  emp
  group  by deptno
union  all
select   '전체토탈'   as   deptno,  sum(sal)
  from  emp;

insert   into  emp(empno, ename, sal, job, deptno )
  values( 1221, 'jack', 3500, 'SALESMAN', 70 );


252.입사한 년도(4자리), 입사한 년도별 토탈월급을 출력하시오 !

 select  to_char(hiredate, 'RRRR'), sum(sal)
    from   emp
    group  by  to_char(hiredate,'RRRR');

 delete  from   emp  where  hiredate  is  null; 
 commit;

253.입사한 년도(4자리), 입사한 년도별 토탈월급을 출력하는데
맨 아래에 전체 토탈월급이 출력되게하시오 !

1981          22825
1983           1100
1980            800
1982           4300
토탈:          29025  

 select  to_char(hiredate, 'RRRR') as hire_year, sum(sal)
    from   emp
    group  by  to_char(hiredate,'RRRR')
     union  all
    select  '토탈:'   as  hire_year,  sum(sal) 
     from emp; 

설명:union  all 위 아래로 쿼리문의 컬럼의 갯수가 서로 동일해야하고
         컬럼명도 가급적 동일해야하고 데이터 유형도 동일해야 합니다.

254.우리반 테이블에서 통신사, 통신사별 인원수를 출력하시오 !

 select  telecom, count(*)
   from   emp12
  group  by  telecom;

255.아래와 같이 전체인원수가 맨 아래에 출력되게하시오 

sk                                               11
lg                                                4
kt                                               15
전체:                                           30 

select   telecom,  count(*)
  from   emp12
  group  by  telecom
union  all
 select  '전체'  as  telecom, count(*)
  from emp12; 

256.문제 253번의 결과를 정렬해서 출력하시오 ! 

1981          22825                            1980     800
1983           1100           ----------->   1981  22825
1980            800                             1982    4300
1982           4300                            1983    1100
토탈:          29025                            토탈:  29025

 select  to_char(hiredate, 'RRRR') as hire_year, sum(sal)
    from   emp
    group  by  to_char(hiredate,'RRRR')
     union  all
    select  '토탈:'   as  hire_year,  sum(sal) 
     from emp 
     order by  hire_year  asc; 

설명:order by 절은 항상 맨 아래의 쿼리문에만 사용해야 합니다.

	?  068 집합 연산자로 데이터를 위아래로 연결하기 2(UNION)

  " union 은  union  all 과 같은 합집합 연산자인데 차이점은 
    union 은 order by 절을 사용하지 않아도 정렬을 암시적으로 수행합니다.
   그리고 중복된 데이터를 하나로 출력합니다 "
예)
 select  to_char(hiredate, 'RRRR') as hire_year, sum(sal)
    from   emp
    group  by  to_char(hiredate,'RRRR')
     union
    select  '토탈:'   as  hire_year,  sum(sal) 
     from emp ;

257.부서번호, 부서번호별 토탈월급을 출력하는데 맨 아래에 전체토탈
월급이 출력되게하고 부서번호를 10, 20, 30번 순으로 정렬해서 
출력되게하시오 !

select   to_char(deptno) as deptno, sum(sal)
 from emp
 group  by deptno
 union 
 select  '전체토탈:'  as  deptno,  sum(sal)
   from  emp;

10	8750
20	10875
30	9400
전체토탈:	29025

설명)
union  은 암시적으로 정렬 작업을 수행하기 때문에 굳이 정렬된 결과를
        볼 필요가 없다면 union  all 을 사용하는게 더 검색 성능에 좋습니다.

258.부서위치, 부서위치별 토탈월급을 출력하시오 (세로 출력) 

select  d.loc,  sum(e.sal)
  from  emp  e, dept  d
  where  e.deptno = d.deptno
  group  by  d.loc; 

259.맨 아래에 전체 토탈월급도 출력되게하시오 !

LOC                        SUM(E.SAL)
-------------------------- ----------
NEW YORK                       8750
DALLAS                          10875
CHICAGO                          9400
전체토탈:                         29025 

select  d.loc,  sum(e.sal)
  from  emp  e, dept  d
  where  e.deptno = d.deptno
  group  by  d.loc
 union  all
select  '전체토탈'  as  loc, sum(sal)
  from  emp; 

260.위의 결과를 다시 출력하는데 직업을 ABCD 순서데로 정렬해서 출력되게하시오

select  d.loc,  sum(e.sal)
  from  emp  e, dept  d
  where  e.deptno = d.deptno
  group  by  d.loc
 union
select  '전체토탈'  as  loc, sum(sal)
  from  emp; 

설명: 정렬을 할 필요가 없으면 UNION  ALL 을 사용하고 정렬이 필요하면 UNION 
        을 사용합니다.

261.직업, 직업별 최대월급, 직업별 최소월급, 직업별 평균월급, 직업별 인원수를
출력하시오 !

select   job,  max(sal), min(sal), avg(sal),  count(*)
  from  emp
  group  by  job; 

262.사원 테이블에서 최대월급, 최소월급, 평균월급, 전체인원수를 출력하시오 !

select   max(sal), min(sal), avg(sal), count(*)
  from  emp;

263.문제261번의 결과와 문제262번의 결과를 위아래로 연결해서 출력하시오 !

JOB                  MAX(SAL)   MIN(SAL)   AVG(SAL)   COUNT(*)
------------------       ---------- ---------- ---------- ----------
SALESMAN                1600       1250       1400           4
CLERK                      1300        800      1037.5           4
ANALYST                  3000       3000       3000            2
MANAGER                2975       2450      2758.33333     3
PRESIDENT                5000       5000       5000            1
전체:                        5000        800 2073.21429         14

select   job,  max(sal), min(sal), avg(sal),  count(*)
  from  emp
  group  by  job
 union  all
select   '전체:' as job  , max(sal), min(sal), avg(sal), count(*)
  from  emp;

264. (점심시간 문제 ) 위의 결과에서 숫자에 전부 천단위라 부여되게 하시오!

JOB                  MAX(SAL)   MIN(SAL)   AVG(SAL)   COUNT(*)
------------------ ---------- ---------- ---------- ----------
SALESMAN                1,600       1,250       1,400          4
CLERK                      1,300        800       1,037.5          4
ANALYST                  3,000       3,000       3,000           2
MANAGER                2,975       2,450      2,758            3
PRESIDENT                5,000       5,000       5,000           1
전체:                       5,000        800       2,073            14

? 069 집합 연산자로 데이터의 교집합을 출력하기(INTERSECT)

 집합 연산자 :  1. 합집합 연산자 :  union all , union
                    2. 교집합 연산자 :  intersect 
                    3. 차집합 연산자 :  minus

예제)
우리반 테이블을 백업 하시오 !  

   create  table  emp12_backup
    as
     select  *
      from  emp12;

 
* 우리반 테이블에서 김씨 학생들만 가져와서 emp_backup2 테이블을 생성하시오 !

create  table  emp12_backup2
  as
   select  *
   from  emp12
  where  ename  like '김%';

 select  *  from  emp12_backup2; 

예)
select   ename, age, telecom
      from  emp12
    union  all
     select  ename, age, telecom
      from  emp12_backup2; 

   select   ename, age, telecom
      from  emp12
    union 
     select  ename, age, telecom
      from  emp12_backup2; 

 설명)
 union 은 합집합 연산자인데 중복된 데이터를 제거하고 정렬작업도 수행합니다.

   select   ename, age, telecom
      from  emp12
     intersect  
     select  ename, age, telecom
      from  emp12_backup2; 

? 070 집합 연산자로 데이터의 차이를 출력하기(MINUS)

  " 차집합을 구하는 집합 연산자 " 

예제)
select   ename, age, telecom
          from  emp12
         minus
       select  ename, age, telecom
         from  emp12_backup2; 

설명:김씨 빼고 다 출력되었습니다. 

	? 071 서브 쿼리 사용하기 1 (단일행 서브쿼리)

예제1)
사원 테이블에서 최대월급을 받는 사원의 이름과 월급을 출력하시오 !

 select  ename, max(sal)
   from  emp;

설명:  위의  SQL 을 수행하려면 서브쿼리문을 사용해야 합니다. 

예제2)
JONES 의 월급을 출력하시오 !

select   sal
    from  emp
    where  ename='JONES';      2975

예제3)
JONES 의 월급보다 더 많은 월급을 받는 사원들의 이름과 월급을 출력하시오!

select  ename, sal
  from  emp
  where  sal >= ( select  sal
                          from  emp
                          where  ename='JONES' );

설명: 쿼리를 두번 각각 실행하지 말고 위와 같이 한번에 수행 하자 !

265.SCOTT 과 같은 월급을 받는 사원들의 이름과 월급을 출력하시오 !
SCOTT 은 제외하고 출력하시오 !

select  ename, sal
  from   emp
  where  sal =  ( select  sal
                        from  emp
                        where  ename='SCOTT' )
  and  ename != 'SCOTT'; 

266.SMITH 와 직업이 같은 사원들의 이름과 직업을 출력하는데
SMITH 는 제외하고 출력하시오 !

select  ename,  job
   from  emp
   where  job  =  (  select  job
                             from  emp
                             where  ename='SMITH' )
   and  ename !='SMITH'; 

267.ALLEN 보다 늦게 입사한  사원들의 이름과 입사일을 출력하시오 !

SELECT  ename, hiredate
  from  emp
  where  hiredate  > ( select  hiredate
                                 from  emp
                                 where  ename='ALLEN' );

268.직업이 SALESMAN 인 사원의 최대월급보다 더 많은 월급을 받는
 사원들의 이름과 월급을 출력하시오 ! 

 select  ename, sal
   from   emp
   where  sal  > (  select  max(sal)
                          from  emp
                          where  job='SALESMAN' );

269.최대월급을 받는 사원의 이름과 월급을 출력하시오 !

 select  ename, sal
   from  emp
   where  sal =  (  select  max(sal)
                           from  emp  );

270.전공에 통계가 포함되어져있는 학생들중에서의 최대나이인 학생의 이름과 
나이와 전공을 출력하시오 !

 select  ename, age, major
  from  emp12
  where  age = ( select  max(age)
                         from  emp12
                         where  major  like  '%통계%' )
 and major like '%통계%' ;

271.KING 에게 보고하는 사원들의 이름을 출력하시오 !
            ( KING 에게 보고 하는 사원들은 KING 의 직속 부하 사원들 입니다.)
              KING 의 직속 부하 사원들의 MGR 번호는 KING 의 EMPNO 입니다.

 select  ename
   from  emp
   where   mgr  =  (  select  empno
                              from  emp
                              where  ename='KING') ;

?  072 서브 쿼리 사용하기 2(다중 행 서브쿼리)

* 서브쿼리의 종류 3가지 :
            
	    1. 단일행 서브 쿼리 : 서브쿼리에서 메인쿼리로 하나의 값이 리턴되는 경우
                 연산자: =, >, <, >=, <=, !=, <>, ^=

             2. 다중행 서브 쿼리 : 서브쿼리에서 메인쿼리로 여러개의 값이 리턴되는 경우
                 연산자:  in, not in,  >all, <all, >any, <any

             3. 다중 컬럼 서브쿼리 : 서브쿼리에서 메인쿼리로 여러개의 컬럼값이 리턴되는 경우 

예)
직업이 SALESMAN 인 사원들과 월급이 같은 사원들의 이름과 월급을 출력하시오 !

1. 단일행 서브쿼리
select  ename, sal
  from  emp
  where  sal >= ( select  sal
                          from  emp
                          where  ename='JONES' );

2. 다중행 서브쿼리 
 select   ename, sal
  from  emp
  where  sal  in  ( select  sal
                         from  emp
                         where  job='SALESMAN');
                        
272.통신사가 sk 인 학생들과 나이가 같은 학생들의 이름과 나이와 통신사를
출력하시오 

select  ename, age, telecom
  from  emp12
  where   age  in  ( select  age 
                           from  emp12
                           where  telecom ='sk' );

273.통신사가 sk 인 학생들과 나이가 같지 않은 학생들의 이름과 나이와 통신사를
출력하시오 ! 

select  ename, age, telecom
  from  emp12
  where   age  not in  ( select  age 
                               from  emp12
                               where  telecom ='sk' );

? 073 서브 쿼리 사용하기 3(NOT IN)

예)
관리자인 사원들의 이름을 출력하시오 !
        (  자기 밑에 직속부하가 한명이라도 있는 사원)
        (  이 관리자들의 사원번호는 직속부하 사원들의 mgr 입니다. )

  select  ename
    from   emp
   where   empno   in  ( select   mgr
                                  from  emp  ); 

274.관리자가 아닌 사원들의 이름을 출력하시오 ! 
 (관리자인 사원이 6명이 나왔으므로 관리자가 아닌 사원들이
 8 명이 출력되어야 합니다. )

결과가 잘 안나오는지 확인하고 쉬세요    45분까지 쉬세요 !

  select  ename
    from   emp
   where   empno  not  in  ( select   mgr
                                      from  emp  ); 

※ 서브쿼리문에 not in 연산자 사용시 주의할 사항 !

   서브쿼리에서 null 값이 하나라도 리턴되면 결과가 출력되지 않는다 

 select   ename
  from  emp
  where   empno not  in  ( 7839, 7902, 7566, null  );
                                                                  True   and  null      null  
  select  ename                                                             True      True
  from  emp                                                                 False      False 
  where  empno != 7839 and  empno != 7902  and  empno!= 7566  and  empno != null ;
   
  설명:  null 딱 한개 때문에 전체가 다 null 이 되어버려서 결과가 출력이 안됨 

275.이제 설명을 들었으니까 관리자가 아닌 사원들을 출력하시오 !
  ( 관리자가 아닌 사원들이 8명이 있는데 8명이 나와줘야 합니다)
  null 때문에  출력이 안되었으므로 null 이 리턴되지 않게 해줘야합니다. 

 select   ename
  from  emp
  where   empno not  in  ( select  mgr
                                     from  emp
                                    where  mgr  is  not  null ) ; 

※ 중요설명:  서브쿼리문 사용시 not in 연산자를 사용하면 반드시 서브쿼리에서 
                 메인쿼리로 null 값이 리턴되지 않도록 처리를 해줘야 합니다. 

	? 074 서브 쿼리 사용하기 4(EXISTS와 NOT EXISTS)

   서브쿼리문에서  exists 와 not exists 를 사용해서 메인쿼리에 있는 데이터 중에
   서브쿼리에 존재하는지 존재 유무를 파악할 때 사용하는 SQL 문법 

예제)
emp 테이블에  권세원 데이터를 입력을 합니다.

    insert   into  emp(empno, ename, sal, job, deptno )
     values( 9877, '권세원',  6000, 'ANALYST', 20 );  
    commit;
    select  * from  emp; 

예제)
우리반 테이블에 있는 학생들중에 사원 테이블에도 존재하는 학생이 있으면
          이름을 출력하시오 !

   select  ename
    from  emp12    e12
    where   exists  (  select   *
                            from   emp   e
                            where  e.ename = e12.ename ) ;

설명:exists 문은  main query 컬럼이 서브쿼리 안으로 들어가면서 실행됩니다. 
         그러면서 메인쿼리의 데이터 중에 서브쿼리에도 같은 데이터가 존재하는지
         찾아 봅니다. 

276.부서 테이블에 부서번호와 부서위치를 출력하는데 부서 테이블에 있는부서번호중에 사원 테이블에도 존재하는 부서번호에 대한것만 출력하시오 !

select deptno,  loc
from dept d
where exists (select *
                    from emp e
	        where e.deptno = d.deptno);

277.이번에는 존재하지 않는 부서번호와 부서위치를 출력하시오 !

select deptno,  loc
from dept d
where not  exists (select *
                         from emp e
	             where e.deptno = d.deptno);

278.어제 마지막 문제에 deptno 도 같이 출력하시오 !

select e.deptno,  sum(decode(d.loc, 'NEW YORK', e.sal)) as "NEW YORK",
                    sum(decode(d.loc, 'DALLAS', e.sal)) as "DALLAS",
                    sum(decode(d.loc, 'CHICAGO', e.sal)) as "CHICAGO"
from emp e, dept d
where e.deptno=d.deptno
group  by e.deptno;
 
279. (오늘의 마지막 문제)  위의 결과에 null 값 대신에 0 으로 출력되게하시오 
DEPTNO   NEW YORK     DALLAS    CHICAGO
------- ----------      ----------       ----------
  30        0                0              9400
  10       8750            0                0
  20         0            16875            0
      
      
select e. deptno, sum(decode(d.loc, 'NEW YORK', e.sal,0)) as "NEW YORK",
       sum(decode(d.loc, 'DALLAS', e.sal,0)) as "DALLAS",
       sum(decode(d.loc, 'CHICAGO', e.sal,0)) as "CHICAGO"
            from emp e, dept d
                where e.deptno=d.deptno
                    group by e.deptno;