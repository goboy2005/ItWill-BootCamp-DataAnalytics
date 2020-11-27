SQL Day 9 Problems

■ Q-251.  부서번호, 부서번호별 토탈월급을 출력하는데 맨 아래에 전체토탈
월급이 출력되게하시오 !  (union all 로 수행)

select   to_char(deptno) as deptno,  sum(sal)
  from  emp
   group  by deptno
union  all
select   '전체토탈'   as   deptno,  sum(sal)
   from  emp;

■ Q-252. 입사한 년도(4자리), 입사한 년도별 토탈월급을 출력하시오 !

 select  to_char(hiredate, 'RRRR'), sum(sal)
    from   emp
      group  by  to_char(hiredate,'RRRR');

■ Q-253. 입사한 년도(4자리), 입사한 년도별 토탈월급을 출력하는데
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
     select '토탈:' as hire_year, sum(sal) 
        from emp; 

■ Q-254.우리반 테이블에서 통신사, 통신사별 인원수를 출력하시오 !

 select  telecom, count(*)
    from   emp12
     group  by  telecom;

■ Q-255. 아래와 같이 전체인원수가 맨 아래에 출력되게하시오 

sk                              11
lg                              4
kt                              15
전체:                           30 
 
select   telecom,  count(*)
 from   emp12
   group  by  telecom
union  all
 select  '전체'  as  telecom, count(*)
   from emp12; 

■ Q-256.문제 253번의 결과를 정렬해서 출력하시오 ! 

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

■ Q-257. 부서번호, 부서번호별 토탈월급을 출력하는데 맨 아래에 전체토탈
월급이 출력되게하고 부서번호를 10, 20, 30번 순으로 정렬해서 
출력되게하시오 !

select   to_char(deptno) as deptno, sum(sal)
 from emp
   group by deptno
union all
select  '전체토탈:'  as  deptno,  sum(sal)
   from  emp;

10	8750
20	10875
30	9400
전체토탈:	29025

설명: union  은 암시적으로 정렬 작업을 수행하기 때문에 굳이 정렬된 결과를
        볼 필요가 없다면 union  all 을 사용하는게 더 검색 성능에 좋습니다.

■ Q-258. 부서위치, 부서위치별 토탈월급을 출력하시오 (세로 출력) 

select  d.loc,  sum(e.sal)
  from  emp  e, dept  d
   where  e.deptno = d.deptno
      group  by  d.loc; 

■ Q-259. 맨 아래에 전체 토탈월급도 출력되게하시오 !

LOC                        SUM(E.SAL)
-------------------------- ----------
NEW YORK                       8750
DALLAS                         10875
CHICAGO                        9400
전체토탈:                       29025 

select  d.loc,  sum(e.sal)
  from  emp  e, dept  d
    where  e.deptno = d.deptno
      group  by  d.loc
union 
select  '전체토탈'  as  loc, sum(sal)
   from  emp; 

■ Q-260.위의 결과를 다시 출력하는데 직업을 ABCD 순서데로 정렬해서 출력되게하시오

select  d.loc,  sum(e.sal)
  from  emp  e, dept  d
    where  e.deptno = d.deptno
    group  by  d.loc
union 
select  '전체토탈'  as  loc, sum(sal)
  from  emp; 


■ Q-261. 직업, 직업별 최대월급, 직업별 최소월급, 직업별 평균월급, 직업별 인원수를
출력하시오 !

select   job,  max(sal), min(sal), avg(sal),  count(*)
  from  emp
    group  by  job; 

■ Q-262. 사원 테이블에서 최대월급, 최소월급, 평균월급, 전체인원수를 출력하시오 !

select   max(sal), min(sal), avg(sal), count(*)
   from  emp;

■ Q-263. 261번의 결과와 문제262번의 결과를 위아래로 연결해서 출력하시오 !

JOB                  MAX(SAL)   MIN(SAL)   AVG(SAL)   COUNT(*)
------------------       ---------- ---------- ---------- ----------
SALESMAN                1600       1250       1400         4
CLERK                   1300        800      1037.5        4
ANALYST                 3000       3000       3000         2
MANAGER                 2975       2450      2758.33       3
PRESIDENT               5000       5000       5000         1
전체:                   5000        800     2073.21        14

select   job,  max(sal), min(sal), avg(sal),  count(*)
  from  emp
    group  by  job
union  all
select   '전체:' as job  , max(sal), min(sal), avg(sal), count(*)
   from  emp;

■ Q-264.(위의 결과에서 숫자에 전부 천단위라 부여되게 하시오!

JOB                  MAX(SAL)   MIN(SAL)   AVG(SAL)   COUNT(*)
------------------ ---------- ---------- ---------- ----------
SALESMAN               1,600       1,250       1,400           4
CLERK                  1,300        800       1,037.5          4
ANALYST                3,000       3,000       3,000           2
MANAGER                2,975       2,450      2,758            3
PRESIDENT              5,000       5,000       5,000           1
전체:                  5,000        800       2,073            14


	 
	 
	 
	 
■ Q-265.SCOTT 과 같은 월급을 받는 사원들의 이름과 월급을 출력하시오 !
SCOTT 은 제외하고 출력하시오 !

select  ename, sal
  from   emp
    where  sal =  (select  sal
                        from  emp
                            where  ename='SCOTT' )
    and  ename != 'SCOTT'; 

■ Q-266. SMITH 와 직업이 같은 사원들의 이름과 직업을 출력하는데
SMITH 는 제외하고 출력하시오 !

select  ename,  job
   from  emp
     where  job  =  ( select  job
                           from  emp
                              where  ename='SMITH' )
     and  ename !='SMITH'; 

■ Q-267. ALLEN 보다 늦게 입사한  사원들의 이름과 입사일을 출력하시오 !

SELECT  ename, hiredate
  from  emp
    where  hiredate  > (select hiredate
                              from  emp
                                  where  ename='ALLEN' );

■ Q-268.직업이 SALESMAN 인 사원의 최대월급보다 더 많은 월급을 받는
 사원들의 이름과 월급을 출력하시오 ! 

 select  ename, sal
   from   emp
      where  sal  > ( select  max(sal)
                          from  emp
                             where  job='SALESMAN' );

■ Q-269. 최대월급을 받는 사원의 이름과 월급을 출력하시오 !

 select  ename, sal
   from  emp
      where sal = ( select max(sal)
                           from  emp );

■ Q-270. 전공에 통계가 포함되어져있는 학생들중에서의 최대나이인 학생의 이름과 
나이와 전공을 출력하시오 !

 select  ename, age, major
   from  emp12
      where  age = (select max(age)
                       from  emp12
                          where  major  like  '%통계%' )
      and major like '%통계%' ;

■ Q-271. KING 에게 보고하는 사원들의 이름을 출력하시오 !
( KING 에게 보고 하는 사원들은 KING 의 직속 부하 사원들 입니다.)
 KING 의 직속 부하 사원들의 MGR 번호는 KING 의 EMPNO 입니다.

 select  ename
   from  emp
     where mgr  = (  select  empno
                           from  emp
                              where  ename='KING') ;
                
■ Q-272. 통신사가 sk 인 학생들과 나이가 같은 학생들의 이름과 나이와 통신사를
출력하시오 

select  ename, age, telecom
  from  emp12
     where age in (select age 
                        from  emp12
                           where  telecom ='sk' );

■ Q-273. 통신사가 sk 인 학생들과 나이가 같지 않은 학생들의 이름과 나이와 통신사를
출력하시오 ! 

select  ename, age, telecom
  from  emp12
     where age not in (select age 
                         from  emp12
                             where  telecom ='sk' );

■ Q-274. 관리자가 아닌 사원들의 이름을 출력하시오 ! 
 (관리자인 사원이 6명이 나왔으므로 관리자가 아닌 사원들이
 8 명이 출력되어야 합니다. )

 select  ename
   from   emp
      where  empno not in (select mgr
                               from emp); 
(An error occurs  
설명:  null 딱 한개 때문에 전체가 다 null 이 되어버려서 결과가 출력이 안됨) 

■ Q-275. 이제 설명을 들었으니까 관리자가 아닌 사원들을 출력하시오 !
  ( 관리자가 아닌 사원들이 8명이 있는데 8명이 나와줘야 합니다)
  null 때문에  출력이 안되었으므로 null 이 리턴되지 않게 해줘야합니다. 

 select   ename
  from  emp
    where empno not in (select mgr
                             from  emp
                                 where  mgr  is  not  null ) ; 

■ Q-276. 부서 테이블에 부서번호와 부서위치를 출력하는데 부서 테이블에 있는부서번호중에 사원 테이블에도 존재하는 부서번호에 대한것만 출력하시오 !

select deptno, loc
  from dept d
     where exists (select *
                      from emp e
	                 where e.deptno = d.deptno);

■ Q-277. 이번에는 존재하지 않는 부서번호와 부서위치를 출력하시오 !

select deptno, loc
  from dept d
     where not exists (select *
                          from emp e
	                     where e.deptno = d.deptno);

■ Q-278. 어제 마지막 문제에 deptno 도 같이 출력하시오 !

select e.deptno, sum(decode(d.loc, 'NEW YORK', e.sal)) as "NEW YORK",
                  sum(decode(d.loc, 'DALLAS', e.sal)) as "DALLAS",
                  sum(decode(d.loc, 'CHICAGO', e.sal)) as "CHICAGO"
                        from emp e, dept d
                           where e.deptno=d.deptno
                                  group  by e.deptno;
 
■ Q-279. 위의 결과에 null 값 대신에 0 으로 출력되게하시오 

  DEPTNO   NEW YORK     DALLAS    CHICAGO
    -------- ----------      ----------       ----------
      30        0                0              9400
      10       8750            0                0
      20         0            16875            0
