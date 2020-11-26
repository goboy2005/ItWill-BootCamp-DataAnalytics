
■ Q-160.  이름, 입사일,  순위를 출력하는데 순위가
먼저 입사한 사원순으로 순위를 부여하시오 ~

select  ename, hiredate,  
         rank()  over  ( order  by  hiredate  asc )  순위
   from   emp;

■ Q-161. 직업, 이름, 입사일, 순위를 출력하는데 순위가
 직업별로 각각 먼저 입사한 사원순으로 순위를 부여하시오

select  job, ename, hiredate,  
         rank()  over  ( partition  by  job
                            order  by  hiredate  asc )  순위
   from   emp;

■ Q-162.  이름, 월급, 순위를 출력하는데 순위가 월급이 높은 순서
 데로 순위를 부여하시오 !

 select  ename, sal, dense_rank()  over ( order  by sal  desc )  순위
    from  emp;

■ Q-163.  월급이 2975는 순위가 몇위인가 ?  

select   dense_rank(2975)  within  group ( order  by sal desc ) 순위
   from   emp;

설명:  within ~이내에 
        월급이 높은순서데로 정렬한 그룹 안에서 2975가 몇위의 순위
       인가 ?

■ Q-164.  우리반에서 34 나이의 순위를 출력하시오 !

 select   dense_rank(34)  within  group ( order  by age desc ) 순위
   from  emp12;

■ Q-165. 81년 11월 17일에 입사한 사원은 사원 테이블에서 몇번째로
 입사한 사원인가 ?

 select   
   dense_rank(to_date('81/11/17','RR/MM/DD')) 
                            within group (order by hiredate asc) 순위
   from emp;


■ Q-166.  이름, 나이, 등급을 출력하는데 등급을 7등급으로 나눠서
출력하시오 (나이가 높은 순서데로 등급을 나누시오)

 select  ename, age,  ntile(7)  over  ( order  by  age  desc) 등급
    from   emp12;

■ Q-167.  직업, 이름, 월급, 등급을 출력하는데 직업별 각각
 등급이 3등급으로 나눠지게 하시오 !
              (등급은 월급이 높은 순서데로의 등급입니다.)

select  job, ename, sal,  ntile(3)  over ( partition by job 
                                                   order  by  sal  desc ) 등급
    from  emp;

■ Q-168.  위의 결과에서 소수점 세번째까지만 출력되겠금 
반올림하시오

KING	5000	0.071
SCOTT	3000	0.214
  :            :             : 

select  ename, sal,  
        round( cume_dist()  over ( order  by  sal  desc ),3 ) as  비율
         from  emp;

■ Q-169. 직업, 직업별로 해당하는 사원들의 이름을 가로로 출력하시오

select  job,  
     listagg(ename, ',')  within  group ( order  by  ename asc) 이름
  from  emp
  group  by job; 


■ Q-170.  아래와 같이 결과를 출력하시오 !

ANALYST    	FORD(3000), SCOTT(3000)
CLERK	             ADAMS(1100), JAMES(950), MILLER, SMITH
MANAGER	BLAKE, CLARK, JONES
PRESIDENT	KING
SALESMAN	ALLEN, MARTIN, TURNER, WARD

select job,  
 listagg(ename || '(' || sal || ')' , ',') within group (order by ename asc) 이름 
   from emp 
   group by job;  

■ Q-171. 나이, 나이별로 해당하는 학생들의 이름을 가로로 
 출력하시오

select  age, 
 listagg(ename,',') within group ( order  by  ename  asc )  이름
  from   emp12
  group by age;

■ Q-172-1. * 점심시간 문제 풀기 전에 통신사 skt 와 SK 를  sk 로 변경하세요.
             
update   emp12
  set  telecom ='sk'
  where  telecom  in ('skt', 'SK'); 

commit;

select  telecom  from  emp12;

■ Q-172-2. (점심시간 문제)  답글로 달고 라인 검사 입니다. 
 통신사를 출력하고 통신사별로 해당 하는 학생들의 이름을 출력
 하는데 이름 옆에 나이도 같이 출력되게 하고 나이가 높은 학생순으
 로 출력되게하시오 !

kt    한결(31), 김소라(29), ..............
lg    김주원(44), 김정민(28), ...........
sk    권세원(36), 현지연(35), ..............

■ Q-173.  이름, 입사일, 바로 전에 입사한 사원의 입사일,
 바로 다음에 입사한 사원의 입사일을  
 출력하시오 !

select  ename, hiredate,  
  lag(hiredate,1) over ( order by hiredate asc)   전행,
       lead(hiredate,1) over ( order  by hiredate  asc ) 다음행
           from  emp;

■ Q-174.   통신사, 통신사별 토탈나이를 출력하시오 (세로출력)

select  telecom,  sum(age)
  from  emp
  group  by  telecom; 

  sk   322
  lg   126
  kt   411 

■ Q-175. 이번에는 아래와 같이 가로로 출력하시오 ! 

   sk     lg    kt
  322   126  411 

select  sum( decode( telecom, 'sk', age, 0  )  )  as  "sk",
         sum( decode( telecom, 'lg', age, 0  )  )  as  "lg",
         sum( decode( telecom, 'kt', age, 0  )  )  as  "kt"
   from   emp12;

■ Q-176. 아래의 SQL 두개는 결과가 같을까?

 " 그룹함수는 null 값을 무시한다 "

 select   sum(comm)  from  emp; 
  2200

 select   sum( nvl(comm,0) ) from  emp; --> 
  2200                                          

설명: 위의 SQL 이 더 성능이 좋다.  왜냐면 null 값은 sum 연산에 포함되지
       않기 때문이다. 

■ Q-177. 아래의 SQL 을 튜닝하시오 !  월1200 만원 ~  2400 만원
튜닝전
select  sum( decode( telecom, 'sk', age, 0  )  )  as  "sk",
         sum( decode( telecom, 'lg', age, 0  )  )  as  "lg",
         sum( decode( telecom, 'kt', age, 0  )  )  as  "kt"
   from   emp12;

               ↓

튜닝후
select  sum( decode( telecom, 'sk', age )  )  as  "sk",
         sum( decode( telecom, 'lg', age,  null  )  )  as  "lg",
         sum( decode( telecom, 'kt', age,  null )  )  as  "kt"
   from   emp12;

 select  decode( telecom, 'sk', age,  null  ) 
   from  emp;

■ Q-178.   직업,  직업별 토탈월급을 출력하시오 ( 세로로 출력) 

select  job,  sum(sal)
  from  emp
  group  by  job;

■ Q-179.  직업, 직업별 토탈월급을 출력하시오 (가로로 출력)

 select   sum(decode( job, 'ANALYST', sal, null)) as  "ANALYST",
           sum(decode( job, 'CLERK', sal, null))  as  "CLERK",
           sum(decode( job, 'MANAGER', sal, null))  as  "MANAGER",
           sum(decode( job, 'PRESIDENT', sal, null))  as  "PRESIDENT",
           sum(decode( job, 'SALESMAN', sal, null))  as  "SALESMAN"
 from  emp; 


■ Q-180.  통신사, 통신사별 토탈나이를 가로로 출력하시오 ( pivot문으로)

   sk     lg    kt
  322   126  411 

select   *
  from  ( select   telecom,  age  from   emp12 )  여기는 그룹함수를 쓰지 않는다.
  pivot  ( sum(age)  for  telecom  in ('sk' as  "sk", 
                                                'lg' as  "lg",
                                                'kt' as  "kt" )  ) ; 


■ Q-181. 위의 결과를 토탈나이가 아니라 평균나이로 나오게 하시오 !

select   *
  from  ( select   telecom,  age  from   emp12 )  
  pivot  ( avg(age)  for  telecom  in ('sk' as  "sk", 
                                                'lg' as  "lg",
                                                'kt' as  "kt" )  ) ; 

■ Q-182. 이름, 나이, 나이의 누적치를 출력하시오 

select  ename, age,  sum(age)  over ( order  by  ename  asc ) 누적치
   from   emp12;

■ Q-183.  직업, 이름, 월급, 월급의 누적치를 출력하는데 직업별로 각각 
             월급의 누적치가 출력되게하시오 !

select  job,  ename, sal,  sum(sal)  over  (  partition  by  job 
                                                       order  by  sal  asc  )  누적치
   from   emp;

■ Q-184.  통신사, 이름, 나이,  나이의 누적치를 출력하는데  나이의 누적치가
통신사별로 각각 누적되어서 출력되게하시오 !

select  telecom,  ename,  age,  sum(age)  over ( partition  by  telecom
                                                               order  by  age  asc ) 누적치
    from  emp12;


■ Q-185.  통신사, 통신사별 토탈나이를 출력하는데 맨위에 전체 토탈나이가 출력되게하시오

 select   telecom,  sum(age)
   from  emp12
   group  by  cube(telecom) ;

■ Q-186.  입사한 년도(4자리), 입사한 년도별 토탈월급을 출력하는데 맨 위에 전체토탈월급을
출력하시오 !

  

■ Q-187.(오늘의 마지막 문제) 답글로 올리세요 ~  

  입사한 년도(4자리), 입사한 년도별 토탈월급을 출력하시오 ! 

 1. 세로 출력
 2. 가로 출력( sum + decode 사용) 
