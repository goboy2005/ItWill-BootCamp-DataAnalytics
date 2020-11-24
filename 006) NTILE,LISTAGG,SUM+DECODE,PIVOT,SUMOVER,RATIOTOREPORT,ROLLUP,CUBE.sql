*데이터 분석 함수 

  회사의 전산 시스템의 구조 ( 데이터 저장 부분에 대한 서버의 종류)

구글의 전산 서버실
                                                           
           OLTP   서버                            DW  서버 
             ↓                                           ↓ 
   OnLine  Transaction processing         DataWare  house 
       
  실시간으로 봐야할 데이터들을 저장       과거 이력 데이터

  예: 지금 내 현재 통장 잔고 데이터   예:  10년전 과거 내 통장 잔고
                                                           데이터
                                                             ↓
                                                        데이터 분석함수 

160.이름, 입사일,  순위를 출력하는데 순위가
먼저 입사한 사원순으로 순위를 부여하시오 ~

select  ename, hiredate,  
         rank()  over  ( order  by  hiredate  asc )  순위
   from   emp;

161. 직업, 이름, 입사일, 순위를 출력하는데 순위가
 직업별로 각각 먼저 입사한 사원순으로 순위를 부여하시오

select  job, ename, hiredate,  
         rank()  over  ( partition  by  job
                            order  by  hiredate  asc )  순위
   from   emp;

162.  이름, 월급, 순위를 출력하는데 순위가 월급이 높은 순서
 데로 순위를 부여하시오 !

 select  ename, sal, dense_rank()  over ( order  by sal  desc )  순위
    from  emp;

163.  월급이 2975는 순위가 몇위인가 ?  

select   dense_rank(2975)  within  group ( order  by sal desc ) 순위
   from   emp;

설명:  within ~이내에 
        월급이 높은순서데로 정렬한 그룹 안에서 2975가 몇위의 순위
         인가 ?

164.우리반에서 34 나이의 순위를 출력하시오 !

 select   dense_rank(34)  within  group ( order  by age desc ) 순위
   from  emp12;

165. 81년 11월 17일에 입사한 사원은 사원 테이블에서 몇번째로
 입사한 사원인가 ?

 select   
   dense_rank(to_date('81/11/17','RR/MM/DD')) 
                            within group (order by hiredate asc) 순위
      from emp;


■ 043 데이터 분석 함수로 등급 출력하기(NTILE)

  " 등급을 출력하는 함수 "

예제:  select  ename, sal, ntile(4)  over  ( order  by sal desc)  등급
           from  emp;

설명:  월급이 높은 순으로 정렬한 데이터를 4등급으로 나누겠다. 

 0 ~ 25% 1등급 
25~ 50% 2등급
50 ~ 75% 3등급
75 ~ 100% 4등급 

166.이름, 나이, 등급을 출력하는데 등급을 7등급으로 나눠서
출력하시오 (나이가 높은 순서데로 등급을 나누시오)

 select  ename, age,  ntile(7)  over  ( order  by  age  desc) 등급
    from   emp12;

167.직업, 이름, 월급, 등급을 출력하는데 직업별 각각
 등급이 3등급으로 나눠지게 하시오 !
              (등급은 월급이 높은 순서데로의 등급입니다.)

select  job, ename, sal,  ntile(3)  over ( partition by job 
                                                   order  by  sal  desc ) 등급
    from  emp;

■ 044 데이터 분석 함수로 순위의 비율 출력하기(CUME_DIST)

" 순위에 대한 비율을 출력하는 데이터 분석함수 " 

예제)
select  ename, sal,  
           cume_dist()  over ( order  by  sal  desc ) 비율
                from  emp;

KING	5000	0.0714285714285714285714285714285714285714
SCOTT	3000	0.2142857142857142857142857142857142857143
FORD	3000	0.2142857142857142857142857142857142857143
JONES	2975	0.2857142857142857142857142857142857142857
  :            :              : 

168.위의 결과에서 소수점 세번째까지만 출력되겠금 
반올림하시오

KING	5000	0.071
SCOTT	3000	0.214
  :            :             : 

select  ename, sal,  
        round( cume_dist()  over ( order  by  sal  desc ),3 ) as  비율
           from  emp;

■ 045 데이터 분석 함수로 데이터를 가로로 출력하기(LISTAGG)

 " 데이터를 가로로 출력하는 함수 " 

예제)
 select  deptno,  
     listagg(ename, ', ' )  within  group  ( order by  ename asc ) 이름
   from   emp
   group  by  deptno; 

설명: 이름을 가로로 출력하는데 콤마(,) 로 구분해서 출력하겠다.
         이름이 abcd  순으로 정렬되어서 출력되고 있다. 
         listagg 는 다른 분석함수와는 다르게 group by 절이 필요하다.

10	CLARK,KING,MILLER
20	ADAMS,FORD,JONES,SCOTT,SMITH
30	ALLEN,BLAKE,JAMES,MARTIN,TURNER,WARD

169.직업, 직업별로 해당하는 사원들의 이름을 가로로 출력하시오

select  job,  
     listagg(ename, ',')  within  group ( order  by  ename asc) 이름
  from  emp
  group  by job; 

170.아래와 같이 결과를 출력하시오 !
ANALYST    	FORD(3000), SCOTT(3000)
CLERK	             ADAMS(1100), JAMES(950), MILLER, SMITH
MANAGER	BLAKE, CLARK, JONES
PRESIDENT	KING
SALESMAN	ALLEN, MARTIN, TURNER, WARD

select job,  
 listagg(ename || '(' || sal || ')' , ',') within group (order by ename asc) 이름 
   from emp 
   group by job;  

171.나이, 나이별로 해당하는 학생들의 이름을 가로로 
 출력하시오

select  age, 
 listagg(ename,',') within group ( order  by  ename  asc )  이름
  from   emp12
  group by age;

172-1. * 점심시간 문제 풀기 전에 통신사 skt 와 SK 를  sk 로 변경하세요.
             
update   emp12
  set  telecom ='sk'
  where  telecom  in ('skt', 'SK'); 

           commit;

select  telecom  from  emp12;

172-2.(점심시간 문제)
 통신사를 출력하고 통신사별로 해당 하는 학생들의 이름을 출력
 하는데 이름 옆에 나이도 같이 출력되게 하고 나이가 높은 학생순으
 로 출력되게하시오 !
kt    한결(31), 김소라(29), ..............
lg    김주원(44), 김정민(28), ...........
sk    권세원(36), 현지연(35), ..............

select telecom,
          listagg(ename || '(' || age || ')' , ',') within group ( order by age desc) 이름
                  from emp12
                     group by telecom;

■ 046 데이터 분석 함수로 바로 전 행과 다음 행 출력하기
          (LAG, LEAD)

  "바로 전행을 옆에 나오게 하거나 바로 다음행을 옆에 나오게
   할 때 사용하는 함수 "

예:  select  ename, sal,  lag(sal,1)  over ( order by sal asc) as  전행,
                          lead(sal,1)  over  ( order  by sal asc) as  다음행
        from   emp; 

ENAME   SAL         전행     다음행 
SMITH	800		950
JAMES	950	800	1100
ADAMS	1100	950	1250
WARD	1250	1100	1250
MARTIN	1250	1250	1300
MILLER	1300	1250	1500

173.이름, 입사일, 바로 전에 입사한 사원의 입사일,
 바로 다음에 입사한 사원의 입사일을  
 출력하시오 !

select  ename, hiredate,  
  lag(hiredate,1) over ( order by hiredate asc)   전행,
lead(hiredate,1) over ( order  by hiredate  asc ) 다음행
 from  emp;

■ 047 COLUMN을 ROW로 출력하기 1(SUM+DECODE)

  회사에서 데이터를 저장하는 서버 종류 2가지

    OLTP  서버                                  DW 서버 
                                                       ↓
                                                  컬럼을 로우로 출력하는 sum+decode 
예제)
부서번호, 부서번호별 토탈월급을 출력하시오 

 select  deptno,  sum(sal)
  from  emp
  group  by  deptno; 

1.세로 출력 :
 DEPTNO    SUM(SAL)   <--- 컬럼명
  10             8750  
  20            10870
  30             9400

2.가로 출력 :

    10       20      30   <--- 컬럼명
  8750   10870  9400   <--- 데이터

예제2)
부서번호,  부서번호가 10번이면 월급이 출력되게하고 아니면 0 이 출력되게
 하시오

select  deptno,  decode( deptno, 10, sal , 0  )  
   from   emp;

 DEPTNO     DECODE( DEPTNO, 10, SAL, 0 )   <--- 컬럼명 
   10                   1400
   20                       0
   20                       0
   10                    3000
   30                       0
    :                         :

예제3)
위의 결과에서 부서번호 컬럼은 안나오게하시오 !

select  decode( deptno, 10, sal , 0  )  
   from   emp;

DECODE( DEPTNO, 10, SAL, 0 )   <--- 컬럼명 
 1400
   0
   0
  3000
   0
   : 

예제)
위에서 출력된 14개의 데이터를 다 SUM 하시오 ! 

select  sum( decode( deptno, 10, sal , 0  )  ) 
   from   emp;

SUM(DECODE( DEPTNO, 10, SAL, 0 ))   <--- 컬럼명 
    8750

예제5)
위의 컬럼명을 컬럼 별칭을 써서  숫자 10으로 변경하시오 

  10  <--- 컬럼명 
 8750 

select  sum( decode( deptno, 10, sal , 0  )  )  as  "10"
   from   emp;

* 오라클에서 더블 쿼테이션 마크를 사용해야하는 경우

 컬럼 별칭 사용할때 특수문자, 공백문자, 대소문자 구분, 숫자를 사용할때

select  sum( decode( deptno, 10, sal , 0  )  )  as  "10"
   from   emp;

  10  <--- 컬럼명 
 8750 

예제6)
러면 아래와 같이 20번과 30번도 그 옆에 출력하시오 !

    10       20      30   <--- 컬럼명
  8750   10870  9400   <--- 데이터

select  sum( decode( deptno, 10, sal , 0  )  )  as  "10",
         sum( decode( deptno, 20, sal , 0  )  )  as  "20",
         sum( decode( deptno, 30, sal , 0  )  )  as  "30"
   from   emp;

    10       20      30   <--- 컬럼명
  8750   10870  9400   <--- 데이터

174.통신사, 통신사별 토탈나이를 출력하시오 (세로출력)

select  telecom,  sum(age)
    from  emp
        group  by  telecom; 

문제175. 이번에는 아래와 같이 가로로 출력하시오 ! 
   sk     lg    kt
  322   126  411 

select  sum( decode( telecom, 'sk', age, 0  )  )  as  "sk",
         sum( decode( telecom, 'lg', age, 0  )  )  as  "lg",
         sum( decode( telecom, 'kt', age, 0  )  )  as  "kt"
               from   emp12;

176.아래의 SQL 두개는 결과가 같을까?

 " 그룹함수는 null 값을 무시한다 "

 select   sum(comm)  from  emp;  --->  null 값이 아닌 4건만 다 더했다. 
  2200

 select   sum( nvl(comm,0) ) from  emp; --> null 을 0으로 변경하고 
  2200                                                sum 할때 0 을 연산에 포함시켰다

설명: 위의 SQL 이 더 성능이 좋다.  왜냐면 null 값은 sum 연산에 포함되지
       않기 때문이다. 

177.아래의 SQL 을 튜닝하시오 !  월1200 만원 ~  2400 만원
튜닝전:
select  sum( decode( telecom, 'sk', age, 0  )  )  as  "sk",
         sum( decode( telecom, 'lg', age, 0  )  )  as  "lg",
         sum( decode( telecom, 'kt', age, 0  )  )  as  "kt"
   from   emp12;

튜닝후: 
select  sum( decode( telecom, 'sk', age )  )  as  "sk",
         sum( decode( telecom, 'lg', age,  null  )  )  as  "lg",
         sum( decode( telecom, 'kt', age,  null )  )  as  "kt"
   from   emp12;

   select  decode( telecom, 'sk', age,  null  ) 
   from  emp;

178.직업, 직업별 토탈월급을 출력하시오 (세로로 출력) 

select  job,  sum(sal)
  from  emp
  group  by  job;

179.  직업, 직업별 토탈월급을 출력하시오 (가로로 출력)

 select   sum(decode( job, 'ANALYST', sal, null)) as  "ANALYST",
           sum(decode( job, 'CLERK', sal, null))  as  "CLERK",
           sum(decode( job, 'MANAGER', sal, null))  as  "MANAGER",
           sum(decode( job, 'PRESIDENT', sal, null))  as  "PRESIDENT",
           sum(decode( job, 'SALESMAN', sal, null))  as  "SALESMAN"
 from  emp; 

■ 048 COLUMN을 ROW로 출력하기 2(PIVOT)

  " 세로를 가로로 출력하는 함수 "

예)
select   *       <-- pivot 문 사용할 때는 그냥 * 를 쓴다. 
        from  ( select  deptno, sal  from  emp )  <-- 사원 테이블에서 그냥 
                      부서번호와 월급만 가져온다.  emp 테이블명만 딱 쓸수 없다.
            결과를 보기위해서 필요한 컬럼만 선별해서 가져와야 됩니다. 
             emp 테이블명만 쓰면 에러가 납니다. 
           아래의 결과를 보기위해서 직업이 필요하지도 않고 입사일이 필요하지
            도 않습니다. 그냥 부서번호하고 월급만 있으면 됩니다. 
        pivot   (  sum(sal)  for  deptno  in ( 10, 20, 30 )  )  ;
                       ↓        
                    토탈월급을 출력하겠다. 어떤 토탈월급?  부서번호를 위한 
                    어떤 부서번호 ?  10번, 20번, 30번의 부서번호 

    10       20      30   <--- 컬럼명
  8750   10870  9400   <--- 데이터

180.통신사, 통신사별 토탈나이를 가로로 출력하시오 (pivot문으로)
   sk     lg    kt
  322   126  411 

select   *
  from  ( select   telecom,  age  from   emp12 )  여기는 그룹함수를 쓰지 않는다.
  pivot  ( sum(age)  for  telecom  in ('sk' as  "sk", 
                                                'lg' as  "lg",
                                                'kt' as  "kt" )  ) ; 

181. 위의 결과를 토탈나이가 아니라 평균나이로 나오게 하시오 !

select   *
  from  ( select   telecom,  age  from   emp12 )  
  pivot  ( avg(age)  for  telecom  in ('sk' as  "sk", 
                                                'lg' as  "lg",
                                                'kt' as  "kt" )  ) ; 

■ 050 데이터 분석 함수로 누적 데이터 출력하기(SUM OVER)

  " 데이터를 누적해서 합계하는 데이터 분석 함수 "

예제)
사원번호, 이름, 월급, 월급의 누적치를 출력하시오 ! 

select   empno, ename, sal,  sum(sal)  over ( order  by  empno  asc) 누적치
    from   emp; 

182.이름, 나이, 나이의 누적치를 출력하시오 

select  ename, age,  sum(age)  over ( order  by  ename  asc ) 누적치
   from   emp12;

183.직업, 이름, 월급, 월급의 누적치를 출력하는데 직업별로 각각 
             월급의 누적치가 출력되게하시오 !

select  job,  ename, sal,  sum(sal)  over  (  partition  by  job 
                                                       order  by  sal  asc  )  누적치
   from   emp;

 ANALYST                   3000   6000
 ANALYST                   3000   6000

184.통신사, 이름, 나이,  나이의 누적치를 출력하는데  나이의 누적치가
통신사별로 각각 누적되어서 출력되게하시오 !

select  telecom,  ename,  age,  sum(age)  over ( partition  by  telecom
                                                               order  by  age  asc ) 누적치
    from  emp12;

■ 051 데이터 분석 함수로 비율 출력하기(RATIO_TO_REPORT)

   자기의 월급이 전체 월급중에서의 비율이 어떻게 되는지 확인하는 함수 

 예제)
 select   ename, sal, round( ratio_to_report(sal)  over() ,2 )   as  비율
            from   emp
            where  job='SALESMAN' ;

■ 052 데이터 분석 함수로 집계 결과 출력하기 1(ROLLUP)

 " 집계한 결과를 맨 아래쪽에 출력하고 싶을 때 사용하는 함수 "

예제)
부서번호, 부서번호별 토탈월급을 출력하시오 !( 세로 출력) 

 select  deptno, sum(sal)
  from  emp
   group  by   rollup(deptno); 

  맨 아래에 합계가 출력된다. 

예제)
직업, 직업별 토탈월급을 출력하시오 (세로 출력)

 select  job,  sum(sal)
  from  emp
  group  by  job; 

예제)
위의 결과에서 직업별 토탈월급의 합계를 맨아래에 출력하시오 !

 select  job,  sum(sal)
  from  emp
  group  by  rollup( job ) ; 

■ 053 데이터 분석 함수로 집계 결과 출력하기 2(CUBE)

 " 집계 결과를 위쪽에 출력하는 함수 "

예제)
select   job,  sum(sal)
          from  emp
         group  by  cube( job );

185.통신사, 통신사별 토탈나이를 출력하는데 맨위에 전체 토탈나이가 출력되게하시오

 select   telecom,  sum(age)
   from  emp12
   group  by  cube(telecom) ;

186.입사한 년도(4자리), 입사한 년도별 토탈월급을 출력하는데 맨 위에 전체토탈월급을
출력하시오 !

 select   telecom,  sum(age)
   from  emp12
       group  by  cube(telecom) ;

187.(오늘의 마지막 문제) 답글로 올리세요 ~  
  입사한 년도(4자리), 입사한 년도별 토탈월급을 출력하시오 ! 
 1. 세로 출력
 2. 가로 출력( sum + decode 사용) 

1.select to_char(hiredate,'RRRR'), sum(sal)
      from emp
      group by to_char(hiredate,'RRRR');

2.select sum(decode(to_char(hiredate,'RRRR'),'1980',sal,null)) as "1980",
           sum(decode(to_char(hiredate,'RRRR'),'1981',sal,null)) as "1981",
           sum(decode(to_char(hiredate,'RRRR'),'1982',sal,null)) as "1982",
           sum(decode(to_char(hiredate,'RRRR'),'1983',sal,null)) as "1983"
                 from emp;
                 
