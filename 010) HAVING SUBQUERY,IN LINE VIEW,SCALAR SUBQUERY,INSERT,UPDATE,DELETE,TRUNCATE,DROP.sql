■ 075 서브 쿼리 사용하기 5(HAVING절의 서브 쿼리)

* select 문장에서  서브쿼리를 쓸 수 있는 절 

select       서브쿼리 사용가능 ( scalar  subquery )
  from      서브쿼리 사용가능 ( in  line  view  ) 
  where     서브쿼리 사용가능
  group by        X  
  having    서브쿼리 사용가능
  order  by  서브쿼리 사용가능  ( scalar  subquery )

280.   JAMES 보다 더 많은 월급을 받는 사원들의 이름과 월급을 출력하시오

select    ename, sal
    from   emp
   where   sal  > (  select   sal
                         from  emp
                         where  ename='JAMES' );

281.  직업, 직업별 토탈월급을 출력하시오 ! (세로 출력) 

select  job,  sum(sal)
  from  emp
  group  by  job;

JOB                  SUM(SAL)
------------------ ----------
SALESMAN               5600
CLERK                     4150
ANALYST                 12000
MANAGER                8275
PRESIDENT                5000

282. 위의 결과를 다시 출력하는데 직업이 SALESMAN 의 토탈월급보다 
 더 큰 것만 출력하시오 !  

select  job,  sum(sal)
  from  emp
  group  by  job
  having  sum(sal) >  ( select  sum(sal)
                                 from  emp
                                where  job='SALESMAN') 

설명:  그룹함수로 조건을 주는 절은 having 절 입니다. 
        where 절에 작성하면 에러가 발생 합니다. 

283.  부서번호와 부서번호별 인원수를 출력하는데 10번 부서번호의 인원수보다 
더 큰것만 출력하시오 

select   deptno,  count(*)
  from   emp
  group  by  deptno 
  having  count(*)  > ( select  count(*)
                               from  emp
                               where   deptno = 10 );


■ 076 서브 쿼리 사용하기 6 (FROM절의 서브 쿼리)

  " from 절에도 서브쿼리를 사용할 수 있습니다. from 절의 서브쿼리는 in line view 
    라고 합니다 "

예제:   이름, 월급, 순위를 출력하는데 순위가 월급이 높은 사원순으로 순위를 부여하시오

 select  ename,  sal,  dense_rank()  over ( order  by  sal  desc ) 순위
   from  emp;

예제:  위의 결과에서 순위가 4등인 사원만 출력하시오 !

 select  ename,  sal,  dense_rank()  over ( order  by  sal  desc ) 순위
   from  emp
   where  순위 = 4; 

설명:  위의 SQL 은 에러가 납니다. 왜냐하면 실행 순서 때문입니다.
        FROM  절 실행하고 WHERE 절을 실행하기 때문에 emp 테이블에는
        순위라는 컬럼이 없기때문에 에러가 납니다.

    순위가 4등인 사원의 이름과 월급과 순위를 출력하려면  from 절의 서브쿼리를 
    사용해야합니다. 

 select  * 
    from ( select  ename,  sal,  dense_rank()  over ( order  by  sal  desc ) 순위
              from  emp 
            ) 
   where   순위 = 4;  

설명:  from 절의 서브쿼리문의 결과가 마치 하나의 테이블처럼 만들어져서 
        서브쿼리문의 결과 데이터가 메모리에 올라가게 됩니다. 
       메모리에 올려놓은 데이터 중에 순위가 4등인 데이터를 가져온다. 

ENAME                       SAL       순위
-------------------- ---------- ----------
권세원                     6000          1
KING                       5000          2
FORD                       3000          3
SCOTT                      3000          3
JONES                      2975          4
BLAKE                      2850          5

284. 직업, 이름, 월급,  순위를 출력하는데 순위가 직업별로 각각 월급이 높은 순서
데로 순위를 부여하시오 !

select  job,  ename, sal,  dense_rank()   over  ( partition  by  job
                                                            order  by  sal  desc )  순위
      from   emp;

285. 위의 결과에서 순위가 1등인 사원들만 출력하시오 !

select  *
  from  (  select  job,  ename, sal,  dense_rank()   over  ( partition  by  job
                                                            order  by  sal  desc )  순위
               from   emp ) 

 where   순위 = 1 ;
 
286.  우리반 테이블에서 통신사별로 나이가 가장 많은 학생의 이름과 나이와 
통신사와 나이의 순위를 출력하시오 !

select  *
  from  (  select  telecom, ename,  age, 
                                  dense_rank()  over (  partition  by  telecom
                                                             order  by   age  desc ) 순위
               from  emp12
           )
  where  순위 = 1; 

287.  price 테이블의 전체 건수가 어떻게 되는지 확인하시오 !

  select  count(*) 
   from price; 

 M_NAME :  마트 이름 또는 시장이름 
 A_NAME : 식료품 이름 
 A_PRICE : 식료품 가격 

288.( 점심시간 문제 )  서울시에서 가장 비싼 식료품의 이름과 가격과 파는 곳을
 출력하시오 ! 


■ 77 서브 쿼리 사용하기 7 (SELECT절의 서브 쿼리)

" select 절에 서브쿼리를 사용할 수 있는데 select 절의 서브쿼리를 scalar subquery
  라고 합니다. "

예제:  이름, 월급,  사원테이블의 평균월급을 출력하시오 !
  자기의 월급과 평균월급을 비교해보기 위해서 )

 select   ename, sal,  ( select   avg(sal)
                                   from  emp   )   평균월급
   from  emp ;
                                      
289.   사원이름, 월급, 사원 테이블의 최대월급, 사원 테이블의 최소월급을
출력하시오 !

 select  ename, sal,  (  select  max(sal), min(sal)
                                 from  emp  )   
  from   emp;

중요설명:  select 절의 서브쿼리인 스칼라 서브쿼리의 특징 ?

               스칼라 서브쿼리는 단 한개값 만 리턴 할 수 있다. 

select  ename, sal,  ( select  max(sal)
                              from  emp  )  최대, 
                          ( select  min(sal)
                              from  emp  ) 최소 
   from   emp;

290.   이름, 나이,  우리반 나이의 평균나이를 출력하시오 !

 select   ename,  age,   ( select   avg(age)
                                    from  emp12  )   평균나이
   from   emp12; 

291.  위의 결과를 소수점 이하가 안나오게 반올림하시오 ! 

 select   ename,  age,   ( select   round(avg(age) )
                                    from  emp12  )   평균나이
   from   emp12; 

292. (난이도 상) 위의 결과에서 학생의 나이가 평균나이보다 더 큰 
 학생들의 이름과 나이와 평균나이를 출력하시오 !

    위의 결과를 다시 출력하는데 우리반 평균나이보다 더 많은 학생들만
    출력하시오 !

select *
  from ( select   ename,  age,   ( select   round(avg(age) )
                                              from  emp12  )   평균나이
                  from   emp12 )
  
where   age > 평균나이 ;

293.  사원 테이블에서 이름, 월급, 사원 테이블의 최대월급,
                                                  사원 테이블의 최소월급,
                                                  사원 테이블의 평균월급을 출력하시오!

튜닝전:
select  ename, sal,  (  select  max(sal) from  emp ) 최대월급,
                          (  select  min(sal) from  emp ) 최소월급,
                          (  select  avg(sal) from  emp ) 평균월급
   from   emp; 

튜닝후:         
select  ename, sal,  max(sal)  over   ()  최대월급,
                          min(sal)  over   ()  최소월급,
                          avg(sal)  over   ()  평균월급
  from   emp; 

294.   우리반 테이블에서 이름, 나이,  우리반 나이의 최대나이,
                                                      우리반 나이의 최소나이,
                                                      우리반 나이의 평균나이,
                                                      우리반 학생들의 인원수를
              출력하시오 !

select  ename, age,  max(age)  over  ()  최대나이,
                           min(age)  over  ()  최소나이,
                           round( avg(age)   over  (), 0 )  평균나이,
                           count(*)   over  ()  인원수
  from   emp12; 

설명:   select 절의 서브쿼리인 스칼라 서브쿼리가 성능이 느리므로
         위와 같이 데이터 분석함수를 이용해서 튜닝을 하면 빠르게 
         대용량 데이터의 데이터를 검색 할 수 있습니다. 


■ 078 데이터 입력하기(INSERT)

 " 테이블에 데이터를 입력하는 SQL 문장 "

예:   insert   into   emp(empno, ename, sal )
                       values ( 1234, 'jack', 4500 );

    위의 컬럼 순서데로 값을 기술   데이터 입력할 컬럼들 기술
       ; 의 뜻은 앞의 SQL 문장을 실행해라 ~~

295.  사원 테이블에 아래의 데이터를 입력하시오 !

    사원번호: 2939
    사원이름: jane
    월급  :   4700
   입사일 :  오늘날짜

delete from  emp  where  empno = 2939; 

 insert   into   emp( empno, ename, sal, hiredate )
   values( 2939, 'jane', 4700,  sysdate );

296. 오늘 입사한 사원의 이름과 입사일을 출력하시오 !

 select   ename, hiredate
  from   emp
  where  hiredate = sysdate ;

설명:  왜 조회가 되지 않는가 ?  sysdate 는 날짜 뿐만 아니라 시분초도 출력
        되기 때문에 아까 입력했을때 시분초와 지금 조회했을때 시분초가
        서로 다르기 때문에 조회되지 않은 것 입니다. 

delete from  emp  where  empno = 2939; 

 insert   into   emp( empno, ename, sal, hiredate )
               values( 2939, 'jane', 4700,  to_date('20/11/05', 'RR/MM/DD')   );

중요설명:  날짜를 입력할 때는 to_date 를 사용해서 입력하세요 ~
              실패하지 않고 확실하게 날짜 데이터를 입력하는 방법입니다. 
              위와 같이 날짜를 입력하면 날짜는 정확하게 2020년 11월 05일로
              입력이 되고 시분초는 00시 00분 00 초로 입력됩니다. 

297. 2020년 11월 05일에 입사한 사원의 이름과 입사일을 출력하시오!

 select  ename, hiredate
  from  emp
  where   hiredate  =  to_date('2020/11/05', 'RRRR/MM/DD') ;

 where  to_char(hiredate,'RRRR/MM/DD') ='2020/11/05'; 

 where   hiredate  

설명:  where 절에 컬럼명쪽에 가급적 함수를 사용하지 않고 검색하는것이
        더 빠르게 데이터를 검색할 수 있는 방법 입니다. 

  where hiredate=to_date(sysdate,'rr/mm/dd');

298.  아래의 데이터를 사원 테이블에 입력하시오 !

insert  into  emp(empno, ename, sal, deptno)
 values( 4945, 'mike    ',  3000, 20 ) ;

299.  이름이 mike 인 사원의 이름과 월급을 출력하시오 !

튜닝전:
select  ename, sal
  from   emp
  where  rtrim(ename)='mike'; 
               ↓
튜닝후:
  select  ename, sal
  from   emp  
  where  ename  like  'mike%'; 

설명:   where 절에 컬럼에는 함수를 가급적 사용하지 않아서 검색 성능이
         좋아 집니다. 

300.  아래의 데이터를 우리반 테이블에 입력하시오 !

   이름:  김인호
   성별:  남
   이메일:  abcd1234@gmail.com
   주소 :   서울시 강남구 역삼동 삼원빌딩 4층
   
	? 079 데이터 수정하기(UPDATE)

 " 데이터를 수정하는 SQL 문 "

예제:    update   emp
              set   sal = 0
           where  ename='SCOTT' ;

설명:  SCOTT 의 월급을 0 로 수정하는 update 문장 

301.  KING 의 월급을 9000 으로 변경하시오 !

update  emp
  set  sal = 9000
  where  ename='KING';

commit;  --->  지금까지 변경한 모든 작업을 다 database 에 영구히 저장
                    하겠다.

rollback;  ---> commit 이후에 작업한 모든 변경사항을 취소하겠다. 

302.  직업이 SALESMAN 인 사원들의 커미션을 9500 으로 수정하시오 !

update  emp
  set  comm = 9500
  where   job ='SALESMAN'; 

rollback;

■ 080 데이터 삭제하기(DELETE, TRUNCATE, DROP)

 * 오라클에서 데이터를 삭제하는 방법 3가지 ?

      1. delete 
      2. truncate
      3. drop 

예제:  delete  from  emp
        where  empno = 7788;  

 설명:  사원번호가 7788 번인 사원을 삭제하겠다. 

303.  직업이 SALESMAN 인 사원들을 삭제하시오 ! 

 delete  from   emp
  where  job='SALESMAN'; 

 delete  from  emp ;
 commit;

 truncate  명령어 

 1.  데이터 모두 삭제
 2.  rollback 안됨 
 3.  flashback 안됨 
 4. 테이블 구조만 남기고 다 지운다. 

       운영서버      --------------------- 테스트 서버 
      고객 테이블                            고객 테이블

truncate   table  emp; 


* drop 명령어 

 1. 모든 데이터 삭제
 2. 테이블 구조까지 다 삭제
 3. rollback 안됨 
 4. 휴지통 기능이 있어서 flashback 은 가능 합니다.

 drop   table  emp;

 select * from emp; 

 show  recyclebin;   <-- 휴지통속에 있는 데이터 확인 

 flashback  table  emp  to  before  drop;  <-- 휴지통에서 복원하는 명령어

  select * from emp; 


* 타임머신 기능을 이용해서 과거로 emp 테이블만 되돌립니다. 

1. emp 테이블을 flashback 이 가능한 상태로 변경한다. 
   ( 타임머신 기능을 쓸 수 있도록 설정한다.) 

alter  table  emp   enable    row   movement; 

2. 현재시간에 10분전으로 emp 테이블을 되돌린다.

flashback  table  emp   to   timestamp  
( systimestamp  -  interval  '10' minute );

select * from emp;

commit;

골든 타임이 15분이므로 15분 안에 해야 합니다.

show parameter  undo_retention


304.  부서번호, 부서번호별 토탈월급을 출력하는데 가로로 출력하시오 
 ( sum + decode 이용 )

 select   job, sum ( decode( deptno, 10, sal )   )  as "10",
                 sum ( decode( deptno, 20, sal )  )   as  "20",
                 sum ( decode( deptno, 30, sal )  )  as  "30"
  from  emp
  group  by  job; 

305.  (오늘의 마지막 문제)  위의 결과에서 집계결과를 아래와 같이 
출력하시오 !   답글로 검사받으세요 ~

JOB                            10         20         30      토탈값
------------------ ---------- ---------- ----------  -------------
SALESMAN                                         5600     5600
CLERK                     1300       1900         950     4150 
ANALYST                              6000                   6000
MANAGER               2450       2975       2850      8275
PRESIDENT              5000                                 5000
전체토탈:                8750      10875      8400      29025  
        
select job, sum(decode(deptno, 10,sal)) as "10",
sum(decode(deptno, 20, sal)) as "20",
sum(decode(deptno, 30, sal)) as "30", sum(sal) as 토탈값
from emp
group by job

union all

select '전체토탈' as job , sum(decode(deptno, 10,sal)) as "10",
sum(decode(deptno, 20, sal)) as "20",
sum(decode(deptno, 30, sal)) as "30", sum(sal) as 토탈값
from emp;
