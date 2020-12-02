SQL Day 7 Problems 

■ Q-188. 직업, 직업별 토탈월급을 출력하시오 

select job, sum(sal)
   from  emp
       group  by  job;

■ Q-189. 그러면 위의 결과를 다시 출력하는데 맨 아래에 전체 토탈월급이
 출력되게하시오 

 select  job, sum(sal)
   from  emp
     group by rollup(job);

■ Q-190. 아래에 job 맨아에 null 로 나오는 부분에 토탈값: 이라고 한글로
 null 대신에 출력되게하시오 

JOB                  SUM(SAL)
------------------ ----------
ANALYST              6000
CLERK                 4150
MANAGER              8275
PRESIDENT            5000
SALESMAN             5600
Total:              29025

select  nvl(job,'Total'),sum(sal)
     from  emp
         group  by  rollup(job);

■ Q-191. 위의 결과를 다시 출력하는데 컬럼명이 아래와 같이 출력되게
 하시오 

 JOB                SUM(SAL)
------------------ ----------
ANALYST               6000
CLERK                 4150
MANAGER               8275
PRESIDENT             5000
SALESMAN              5600
Total                 29025

select  nvl( job, 'Total') as job, sum(sal)
       from  emp
            group  by  rollup(job);

■ Q-192. 위의 결과를 다시 출력하는데 아래와 같이 토탈월급 부분에
 천단위를 부여하시오 

 JOB                SUM(SAL)
------------------ ----------            
ANALYST               6,000
CLERK                 4,150
MANAGER               8,275
PRESIDENT             5,000
SALESMAN              5,600
토탈값                29,025

select  nvl( job, '토탈값') as job, to_char(sum(sal),'999,999')
       from  emp
            group  by  rollup(job);

■ Q-193. 직업, 직업별 토탈월급을 출력하는데 맨 아래에 전체 토탈월급이
 출력되게 하시오 ! 

select  job,  sum(sal)
  from  emp
    group  by  grouping  sets(  job, () ); 

■ Q-194.  부서번호와 직업을 출력하고 그 옆에 부서번호별 직업별 
 토탈월급을 출력하시오 

 select  deptno,  job,  sum(sal)
   from  emp
     group  by  deptno, job; 

■ Q-195. 부서번호와 직업을 출력하고 그 옆에 부서번호별 직업별 토탈월급
 을 출력하고 동시에 부서번호별 토탈월급도 중간중간 출력되게 하시오 

select   deptno,  job, sum(sal)
   from  emp
     group   by   grouping  sets (  (deptno, job), (deptno) );  

■ Q-196. 위의 결과의 맨 아래에 전체 토탈월급이 출력되게하시오

select   deptno,  job, sum(sal)
   from  emp
     group   by   grouping  sets ( (deptno, job), (deptno), ()  );  

■ Q-197. 사원번호,  사원 이름, 월급을 출력하는데  맨 아래에 전체토탈월급
 을 출력하시오 

 select  empno, ename, sum(sal)
   from   emp
     group  by grouping sets((empno,ename), () );

■ Q-198. 우리반 테이블에서 통신사, 이름, 나이를 출력하는데 
중간중간 통신사별 토탈나이가 출력되게하시오 

 select telecom, ename, sum(age)
  from emp12
    group  by  grouping sets( (telecom, ename), (telecom) )

& AND 

select telecom, ename, sum(age)
   from emp12
      group  by  grouping sets( (telecom, ename), (telecom), () );

■ Q-199.입사한 년도(4자리),  입사한 년도별 토탈월급을 출력하는데
전체 토탈월급이 맨 아래에 출력되게하시오 

1. rollup 

select  to_char(hiredate,'RRRR'), sum(sal)
  from  emp
     group  by  rollup( to_char(hiredate,'RRRR')  )

2. grouping sets 

select to_char(hiredate, 'RRRR'), sum(sal)
  from emp
     group by grouping sets ( to_char(hiredate, 'RRRR'), () );

■ Q-200.  위의 결과를 다시 출력하는데 아래와 같이 천단위를 부여해서 출력하시오

TO_CHAR(   SUM(SAL)
--------     ------------
1980           800
1981           22,825
1982           4,300
1983           1,100
               29,025

select to_char(hiredate, 'RRRR'), to_char( sum(sal), '999,999') 
  from emp
     group by grouping sets ( to_char(hiredate, 'RRRR'), () );

■ Q-201. 입사한 년도(4자리), 부서번호, 입사한 년도별 부서번호별 
토탈월급을 출력하시오 

select   to_char(hiredate,'RRRR'), deptno, sum(sal)
  from  emp
    group  by  to_char(hiredate,'RRRR'), deptno; 

■ Q-202. ( 점심시간 문제 )  zoom 으로 듣는 학생들은 카페에 올리고
 offline 도 카페에 올리고 식사하러 가세요 ~~
 입사한 년도(4자리), 부서번호, 입사한 년도(4자리)별 부서번호별 토탈월급
 을 출력하는데 중간중간 입사한 년도(4자리)별 토탈월급이 출력되게하고
 맨 아래에 전체 토탈월급이 출력되게 하시오! 

select to_char(hiredate,'RRRR'),deptno,sum(sal)
 from emp
  group by grouping sets ( (to_char(hiredate,'RRRR'), deptno) , (to_char(hiredate,'RRRR') ) ,() );
        
        
■ Q-203. 직업이 SALESMAN 인 사원들의 이름과 직업을 출력하는데
 row_number 함수를 사용해서 맨 앞에 직원번호가 차례대로 부여되게하시오!

select row_number()  over  ( order  by  empno asc ) 번호, ename,  job
   from   emp
      where  job='SALESMAN'; 

■ Q-204.  직업이 SALESMAN 인 사원들의 이름과 월급과 직업을 출력하는데
  맨 앞에 row_number() 함수를 써서 번호가 부여되게하시오
  (월급이 높은순서데로 출력되면서 번호가 부여되게하시오) 

select  row_number()  over  (order by sal desc) 번호, ename, sal, job
  from  emp
     where  job='SALESMAN'; 

select  *
  from  emp 
      where  rownum <= 10;  

■ Q-205.  직업이 SALESMAN 인 사원들의 데이터중 2개만 출력하시오 !
 ( 사원이름, 직업과 월급을 출력하시오)

select  rownum, ename, job, sal
  from   emp
    where  job='SALESMAN'  and  rownum <= 2;

■ Q-206. 위의 결과에서 한건만 출력되게하시오 !

 select  rownum, ename, job, sal
   from   emp
     where  job='SALESMAN'  and  rownum = 1;

아래의 SQL의 결과는 없습니다. (ERROR) 
 select  rownum, ename, job, sal
   from   emp
     where  job='SALESMAN'  and  rownum = 2;

 select  rownum, ename, job, sal
   from   emp                                  
     where  rownum between 2 and 5;

■ Q-207.  우리반 테이블의 데이터를 가져오는데 위의 3건만 가져와서 출력하시오!
 ( 모든 컬럼을 다 가져오세요 ~ )

select  *
  from  emp12
     where  rownum <= 3; 

■ Q-208. 우리반에 나이가 가장 많은 학생들의 이름과 나이를 출력하는데 한 5명만
출력하시오 

 select   ename,  age
   from   emp12
     order  by  age  desc
         fetch  first  5 rows  only; 

■ Q-209. 직업, 직업별 토탈월급을 출력하는데 직업별 토탈월급이 높은것부터 출력하고
 위쪽에 2개의 행만 출력하시오 

select  job,  sum(sal)
  from   emp
    group  by  job 
      order  by  sum(sal)  desc
         fetch  first  2 rows only;  

■ Q-210.  직업이 SALESMAN 인 사원들의 이름과 월급과 직업과 부서위치를 출력하시오!

 select  ename, sal, job, loc
    from   emp,  dept 
       where emp.deptno = dept.deptno and job='SALESMAN' ; 
              ↓                                                                     ↓                          
         조인조건 ( 두개의 테이블이 서로 연관이 있다라는 조건 )   검색조건 

■ Q-211.  월급이 2000 이상인 사원들의 이름과 월급과 부서위치를 출력하시오 !

select   ename, sal, loc
   from   emp,   dept  
     where   emp.deptno = dept.deptno  and  sal >= 2000; 

■ Q-212. 위의 결과에서 이름, 월급, 부서위치 옆에 부서번호도 같이 출력하시오 

select   emp.ename, emp.sal, dept.loc, emp.deptno 
   from   emp,   dept  
       where   emp.deptno = dept.deptno  and  sal >= 2000; 

■ Q-213.  월급이 1000 에서 3000 사이인 사원들의 이름과 월급과 부서위치를 출력하시오 !

select  e.ename,  e.sal,  d.loc
 from  emp  e,  dept  d
    where   e.deptno = d.deptno  and  e.sal  between  1000 and 3000;

■ Q-214.  사원번호가 7788, 7902, 7369번인 사원의 사원번호와 이름과 월급과 부서위치를
 출력하시오 

select  e.ename, e.sal, d.loc
  from   emp   e,   dept   d
     where   e.deptno = d.deptno  and   e.empno  in  ( 7788, 7902, 7369 );

■ Q-215.  이름의 첫번째 철자가 S 로 시작하는 사원의 이름과 월급과 부서위치를
출력하시오 

 select  e.ename, e.sal, d.loc
   from  emp  e,  dept   d
      where  e.deptno = d.deptno  and  e.ename  like  'S%';

■ Q-216. DALLAS 에서 근무하는 사원들의 이름과 직업과 부서위치를 출력하시오 

 select   e.ename,  e.job,  d.loc
   from   emp  e,  dept   d
      where   e.deptno = d.deptno  and  d.loc='DALLAS';

■ Q-217.   부서위치,  부서위치별 토탈월급을 출력하시오 

  select  d.loc,  sum(e.sal)
     from   emp  e,  dept   d
      where  e.deptno = d.deptno  
          group  by  d.loc; 

■ Q-218. (오늘의 마지막 문제)  답글로 검사 받으세요 

 부서위치, 부서위치별 평균월급을 출력하는데 소수점 이하는 안나오게 반올림을 하고
 부서위치별 평균월급이 높은것부터 출력하고 부서위치별 평균월급이 출력될때에
 천단위를 부여하시오 ~
 NOTEBOOK 은 양쪽에 싱글 쿼테이션 마크를 둘러주지 않아도 됩니다. 

select d.loc, to_char(round(avg(e.sal)),'999,999') 
 from emp e, dept d
   where e.deptno=d.deptno 
    group by d.loc
      order by to_char(round(avg(e.sal)),'999,999') desc;       
        
