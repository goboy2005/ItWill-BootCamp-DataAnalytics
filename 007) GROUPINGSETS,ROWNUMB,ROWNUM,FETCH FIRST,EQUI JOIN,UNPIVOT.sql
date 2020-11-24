1. 기본 select 문장 6가지절 

  5 select    보고싶은 컬럼명
  1 from     데이터가 들어있는 테이블명 
  2 where     검색조건 
  3 group by   그룹핑할 컬럼명
  4 having     그룹함수로 만든 검색 조건 
  6 order  by  정렬할 컬럼명 

2. 함수 :   단일행함수:  문자,숫자, 날짜, 변환, 일반
             복수행함수: max, min, avg, sum, count
             (그룹함수)

그룹함수의 특징?  1. null 값을 무시한다.
                 2. where 절의 조건이 거짓이어도 결과를 리턴 한다.

예)
select  sum(sal)
        from  emp
           where  1 = 2;     

 그룹함수 작성시에는 where 절의 조건을 잘 명시해야 합니다. 

3. 데이터 분석 함수:          1. rank    :  순위 출력
                             2. dense_rank : 순위 출력
                             3. ntile  :  등급 출력
                             4. cume_dist :  비율출력
                             5. listagg   :  데이터를 가로로 출력
                             6. sum(컬럼명) over (문법) : 누적 데이터 출력
                             7. ratio_to_report : 비율출력
                             8. rollup :   집계 결과를 맨 아래에 출력
                             9. cube  :   집계 결과를 맨 위에 출력 
 
 데이터 분석함수를 이용하면 우리가 현업에서 필수로 검색해야하는 
 데이터를 긴 SQL 로 작성하지 않고 간단한 함수를 이용해서 볼 수가 
 있습니다.

오라클 버전의 히스토리 
8 --> 8i -->9i --> 10g -->11g --> 12c --> 18c --> 19c
         ↑              ↑                   ↑
    internet          grid                cloud
                         
                 ↑
                성능이 보통인 여러개의 컴퓨터를 여러대 붙여서 
               마치 성능이 아주 좋은 큰 서버처럼 운영하는 기술

188.직업, 직업별 토탈월급을 출력하시오 !

SQL> select  job,  sum(sal)
       from  emp
       group  by  job;

189.그러면 위의 결과를 다시 출력하는데 맨 아래에 전체 토탈월급이
 출력되게하시오 !

select  job, sum(sal)
  from  emp
     group by rollup(job);

190.아래에 job 맨아에 null 로 나오는 부분에 토탈값: 이라고 한글로
 null 대신에 출력되게하시오 !

JOB                  SUM(SAL)
------------------ ----------
ANALYST                6000
CLERK                    4150
MANAGER              8275
PRESIDENT             5000
SALESMAN             5600
토탈값:                 29025

select  nvl( job, '토탈값') , sum(sal)
       from  emp
          group  by  rollup(job);

191.위의 결과를 다시 출력하는데 컬럼명이 아래와 같이 출력되게
 하시오 !

 JOB                SUM(SAL)
------------------ ----------
ANALYST                 6000
CLERK                     4150
MANAGER               8275
PRESIDENT              5000
SALESMAN              5600
토탈값                   29025

select  nvl( job, '토탈값') as job, sum(sal)
       from  emp
          group  by  rollup(job);

192.위의 결과를 다시 출력하는데 아래와 같이 토탈월급 부분에
 천단위를 부여하시오 !

 JOB                SUM(SAL)
------------------ ----------            
ANALYST                 6,000
CLERK                     4,150
MANAGER               8,275
PRESIDENT              5,000
SALESMAN              5,600
토탈값                   29,025

select  nvl( job, '토탈값') as job, to_char(sum(sal),'999,999')
       from  emp
       group  by  rollup(job);

■ 054 데이터 분석 함수로 집계 결과 출력하기 3(GROUPING SETS)

     " 집계결과를 출력하는 데이터 분석 함수입니다."

예제)
select   deptno,  sum(sal)
          from   emp
          group  by  grouping  sets( deptno,  () )  ; 
                                               ↑       ↑
                                            부서번호  전체 
 DEPTNO   SUM(SAL)
------- ----------
     10       8750
     20      10875
     30       9400
              29025

193.직업, 직업별 토탈월급을 출력하는데 맨 아래에 전체 토탈월급이
 출력되게 하시오 ! (grouping sets 를 이용해서 수행)

select  job,  sum(sal)
  from  emp
  group  by  grouping  sets(  job, () ); 

194.부서번호와 직업을 출력하고 그 옆에 부서번호별 직업별 
 토탈월급을 출력하시오 !

 select  deptno,  job,  sum(sal)
   from  emp
     group  by  deptno, job; 

설명: select 절 에 그룹함수와 함께 나열한 컬럼들은 반드시 group by 절에
        명시해줘야 에러가 나지 않고 출력될 수 있다. 

195.부서번호와 직업을 출력하고 그 옆에 부서번호별 직업별 토탈월급
 을 출력하고 동시에 부서번호별 토탈월급도 중간중간 출력되게
 하시오 !

select   deptno,  job, sum(sal)
    from  emp
        group   by   grouping  sets (  (deptno, job), (deptno) );  

196.위의 결과의 맨 아래에 전체 토탈월급이 출력되게하시오 !

select   deptno,  job, sum(sal)
   from  emp
     group   by   grouping  sets (  (deptno, job), (deptno), () );  

197.사원번호,  사원 이름, 월급을 출력하는데  맨 아래에 전체토탈월급
 을 출력하시오 !

 select  empno, ename, sum(sal)
   from   emp
 group  by grouping sets((empno,ename),());

 그룹함수와 grouping sets 는 서로 짝꿍이어서 grouping sets 를 썼는데
  select 절에 group 함수를 안쓰면 안된다. 

설명:  사원번호는 중복되지 않기 때문에 grouping sets 함수에 
        괄호안에 grouping 결과로 넣어도 그냥 자기 월급이 출력되게 된다.
       왜냐하면 딱 한건이기 때문이다.  그 한건을 집계해봐야 그 값이 된다.
       그래서 자신있게 (empno, ename) 이라고 작성한것이다. 
       그리고 맨 끝에 () 은 전체 토탈월급을 출력하는것 입니다. 

198. 우리반 테이블에서 통신사, 이름, 나이를 출력하는데 
중간중간 통신사별 토탈나이가 출력되게하시오 !

 select telecom, ename, sum(age)
  from emp12
  group  by  grouping sets( (telecom, ename), (telecom) )

 select telecom, ename, sum(age)
  from emp12
  group  by  grouping sets( (telecom, ename), (telecom), () );

199.입사한 년도(4자리),  입사한 년도별 토탈월급을 출력하는데
전체 토탈월급이 맨 아래에 출력되게하시오 !

1. rollup 

select  to_char(hiredate,'RRRR'), sum(sal)
  from  emp
    group  by  rollup( to_char(hiredate,'RRRR')  )

2. grouping sets 

select to_char(hiredate, 'RRRR'), sum(sal)
 from emp
    group by grouping sets ( to_char(hiredate, 'RRRR'), () );

200. 위의 결과를 다시 출력하는데 아래와 같이 천단위를 부여해서 출력하시오
TO_CHAR(   SUM(SAL)
--------     ------------
1980              800
1981            22,825
1982            4,300
1983            1,100
                29,025

select to_char(hiredate, 'RRRR'), to_char( sum(sal), '999,999') 
 from emp
   group by grouping sets ( to_char(hiredate, 'RRRR'), () );

201.입사한 년도(4자리), 부서번호, 입사한 년도별 부서번호별 
토탈월급을 출력하시오 !

select   to_char(hiredate,'RRRR'), deptno, sum(sal)
  from  emp
     group  by  to_char(hiredate,'RRRR'), deptno; 

202.( 점심시간 문제 )  zoom 으로 듣는 학생들은 카페에 올리고
 offline 도 카페에 올리고 식사하러 가세요 ~~

   입사한 년도(4자리), 부서번호, 입사한 년도(4자리)별 부서번호별 토탈월급
  을 출력하는데 중간중간 입사한 년도(4자리)별 토탈월급이 출력되게하고
  맨 아래에 전체 토탈월급이 출력되게 하시오! 

올리신 분들은 점심식사 하시고 ~   1시 40분에 시작하겠습니다.  

■ 055 데이터 분석 함수로 출력 결과 넘버링 하기(ROW_NUMBER)

 "출력결과의 행 앞에 숫자를 차례데로 부여하는 함수"

예)
select   row_number()  over (order by empno) , empno, ename
            from  emp;

 이렇게 row_number() 함수를 사용하면 언제 유용하냐면 
 출력되는 행의 맨위의 3개의 행만 가져와라 또는 맨위에 하나의 행만
 가져와라 라고 검색할 때 유용하다.  인라인뷰(from 절의 서브쿼리) 를
 배우면 검색 할 수 있습니다.

203.직업이 SALESMAN 인 사원들의 이름과 직업을 출력하는데
 row_number 함수를 사용해서 맨 앞에  번호 차례데로 부여되게하시오 !

select row_number()  over  ( order  by  empno asc ) 번호,ename,  job
   from   emp
      where  job='SALESMAN'; 

설명: order by 다음에 empno 를써도 되고 ename 을 써도 되고 
        정렬하고 싶은데로 컬럼을 기술하면 된다. 
        order by empno 다음에 asc 를 안쓰면 기본값이 asc 이다. 

204.직업이 SALESMAN 인 사원들의 이름과 월급과 직업을 출력하는데
  맨 앞에 row_number() 함수를 써서 번호가 부여되게하시오
  (월급이 높은순서데로 출력되면서 번호가 부여되게하시오) 

select  row_number()  over  (order by sal desc) 번호,
         ename, sal, job
           from  emp
              where  job='SALESMAN'; 

설명: 위의 결과에서 번호 1번만 출력하는것은 인라인뷰를 배워야
        할 수 있습니다.

■ 056 출력되는 행 제한하기 1(ROWNUM)

  "rownum 을 이용하면 출력되는 행의 갯수를 제한할 수 있습니다 "

예제)
select   rownum,  empno, ename, sal
            from  emp; 

설명:  row_number() 함수와는 다르게 인라인뷰(from 절의 서브쿼리)를 사용하지 않고도
        위의 3개의 행만 가져와라 같은 데이터 검색을 할 수 있다.

select  rownum,  empno, ename, sal
  from  emp
 where   rownum <= 3;  

대용량 테이블의 데이터가 있는 테이블의 내용을 살짝 보고 싶다면  rownum 을 사용해서
몇건의 데이터만 살펴 보시오 ! 

 select  *
  from  emp 
  where  rownum <= 10;  

205. 직업이 SALESMAN 인 사원들의 데이터중 2개만 출력하시오 !
 ( 사원이름, 직업과 월급을 출력하시오)

select  rownum, ename, job, sal
  from   emp
  where  job='SALESMAN'  and  rownum <= 2;

206. 위의 결과에서 한건만 출력되게하시오 !

 select  rownum, ename, job, sal
   from   emp
   where  job='SALESMAN'  and  rownum = 1;

아래의 SQL의 결과는 없습니다. 
 select  rownum, ename, job, sal
    from   emp
      where  job='SALESMAN'  and  rownum = 2;

왜냐하면?  rownum 쓸때는 부등호 비교와 같이 사용해야 합니다.
              등호 비교는 숫자 1만 비교 됩니다.  

만약에 우리 건물앞에 강남역을 가는 미니버스가 있는데 앞에 광장에
사람들에게 이 버스에 탈 사람중 제일 먼저 탈 사람은 타세요 ~ 라고 하면
제일먼저 달려간 사람이 타면 된다. 그런데 이 버스에 2번째로 탈 사람 
타세요~ 라고 하면 다 머뭇거리고 못탈것 입니다. 누군가 한명이 먼저 가야
두번째로 갈 수 있습니다. 

 select  rownum, ename, job, sal
   from   emp                                  
     where  rownum between  2 and 5;

설명:실제로 위의 SQL 의 결과를 보려면 인라인뷰를 사용해야 합니다. 


207.우리반 테이블의 데이터를 가져오는데 위의 3건만 가져와서 출력하시오!
 ( 모든 컬럼을 다 가져오세요 ~ )

select  *
  from  emp12
  where  rownum <= 3; 

■ 057 출력되는 행 제한하기 2(Simple TOP-n Queries)

  " order by 절까지 사용해서 검색하는 SELECT 문의 출력되는 행의
    일부를 가져올 때 사용하는 문법 "

예)
select   rownum , empno, ename, sal
       from  emp
       order  by   sal  desc; 

설명: order by 가 수행되기 전에  rownum 이 부여되어서 번호가 뒤죽박죽
       섞였다. 

예제)
사원 테이블에 월급이 높은 사원 4명만 출력하시오. 이름과 월급을 출력하시오!
         
3 select  rownum, ename,  sal
  1 from  emp
  2 where  rownum <= 4
  4 order by  sal  desc; 

설명:  제대로 출력되지 않았다.  왜 출력되지 않았냐면 실행 순서 때문입니다. 
        emp 테이블에서 맨위의 4명만 가져와서 그 4명만으로 월급이 높은 순서데로
        정렬했기 때문입니다. 위의 결과를 제대로 볼려면 아래와 같이 top n query 를
        작성해야 합니다. 

4      select  ename, sal
 1     from   emp
 2     order  by  sal   desc
 3     fetch  first  4  rows  only;  

설명:  fetch 는 검색으로 가져오는 데이터를 가져와라 라는 뜻이다. 
       first  4 rows  only  는 문법인데 그중에 4개의 행만 가져와라 ~ 라는 뜻입니다.

208.우리반에 나이가 가장 많은 학생들의 이름과 나이를 출력하는데 한 5명만
출력하시오 !

 select   ename,  age
   from   emp12
   order  by  age  desc
   fetch  first  5 rows  only; 

209.  직업, 직업별 토탈월급을 출력하는데  직업별 토탈월급이 높은것부터 출력하고
 위쪽에 2개의 행만 출력하시오 ! 

select  job,  sum(sal)
  from   emp
  group  by  job 
  order  by  sum(sal)  desc
  fetch  first   2  rows  only;  

■ 058 여러 테이블의 데이터를 조인해서 출력하기 1(EQUI JOIN)

  " 조인을 이용하면 두개 이상의 테이블들의 컬럼들을 하나의 결과로 모아서 볼 수 가
    있습니다. " 

예제:  select  *
           from  dept;   <--- 부서 테이블 

  deptno : 부서번호
  dname :  부서명
  loc      : 부서위치

예제)
이름, 부서위치를 출력하시오 !

  select  ename,  loc
    from  emp,  dept  ; 
 
설명: 14건  x  4 건 = 56 건 이 되어서 다 조인한 결과 입니다.

  select  ename,  loc
    from  emp,  dept  
    where  emp.deptno = dept.deptno ;  <--- 조인 조건을 where 절에 기술해야
                                                           정확한 결과를 볼 수 있습니다. 

설명:  조인조건을 줘야 조인을 할 수 있습니다. 
        emp 테이블의 deptno 는 dept 테이블에 deptno 와 같습니다. 라고 오라클에게
       알려주면서  이 컬럼으로 두개의 테이블을 서로 조인(join) 하는 것입니다. 

210.직업이 SALESMAN 인 사원들의 이름과 월급과 직업과 부서위치를 출력하시오!

 select  ename, sal, job, loc
  from   emp,  dept 
  where emp.deptno = dept.deptno                  and  job='SALESMAN' ; 
              ↓                                                                     ↓                          
         조인조건 ( 두개의 테이블이 서로 연관이 있다라는 조건 )   검색조건 

211.월급이 2000 이상인 사원들의 이름과 월급과 부서위치를 출력하시오 !

select   ename, sal, loc
   from   emp,   dept  
  where   emp.deptno = dept.deptno  and  sal >= 2000; 

212.위의 결과에서 이름, 월급, 부서위치 옆에 부서번호도 같이 출력하시오 !

select   emp.ename, emp.sal, dept.loc, emp.deptno 
   from   emp,   dept  
  where   emp.deptno = dept.deptno  and  sal >= 2000; 

설명:  emp.deptno 라고 작성함으로써 emp 테이블에 있는 부서번호를 가져와라 ~
        라고 해줘야합니다.
        에러가 나지 않는다고 컬럼명 앞에 테이블명을 적지 않는 습관을 버리고
        무조건 조인문장에서는 컬럼명 앞에  테이블명을 적어줍니다.
        테이블명.컬럼명 으로 작성해줘야 검색속도가 더 빨라집니다. 

select   emp.ename, emp.sal, dept.loc, emp.deptno 
   from   emp,   dept  
  where   emp.deptno = dept.deptno  and  sal >= 2000; 

      ↓ 코드를 좀더 간결하게 작성 

select   e.ename, e.sal, d.loc, e.deptno 
   from   emp   e ,   dept    d
  where   e.deptno = d.deptno  and  e.sal >= 2000; 

설명:  emp 는 e 라고 하고 dept 는 d 라고 별칭을 주어서 별칭을 사용해서 코딩을 하면
        좀더 간결하게 조인문장을 작성할 수 있습니다.

select   emp.ename, e.sal, d.loc, e.deptno 
   from   emp   e ,   dept    d
      where   e.deptno = d.deptno  and  e.sal >= 2000; 

설명: 위의 문장은 에러가 납니다. 왜냐하면 emp 는 e 로 변경되었기 때문입니다.

213.월급이 1000 에서 3000 사이인 사원들의 이름과 월급과 부서위치를 출력하시오 !

select  e.ename,  e.sal,  d.loc
 from  emp  e,  dept  d
 where   e.deptno = d.deptno  and  e.sal  between  1000 and 3000;

214.사원번호가 7788, 7902, 7369번인 사원의 사원번호와 이름과 월급과 부서위치를
 출력하시오 !

select  e.ename, e.sal, d.loc
  from   emp   e,   dept   d
  where   e.deptno = d.deptno  and   e.empno  in  ( 7788, 7902, 7369 );

설명: 하나의 값을 비교할 때는 = 을 사용하지만 여러개의 값을 검색해서 비교하려면
         in 을 사용해야 합니다. 

215.이름의 첫번째 철자가 S 로 시작하는 사원의 이름과 월급과 부서위치를
출력하시오 !

 select  e.ename, e.sal, d.loc
  from  emp  e,  dept   d
  where  e.deptno = d.deptno  and  e.ename  like  'S%';


                  조인조건                       검색조건 

설명: 두개 이상의 테이블을 조인(합치기)을 하려면 반드시 조인조건을 where 절에
       기술해야 합니다.         
                               

216.DALLAS 에서 근무하는 사원들의 이름과 직업과 부서위치를 출력하시오 

 select   e.ename,  e.job,  d.loc
   from   emp  e,  dept   d
   where   e.deptno = d.deptno  and  d.loc='DALLAS';

217.부서위치,  부서위치별 토탈월급을 출력하시오 ! 

  select  d.loc,  sum(e.sal)
     from   emp  e,  dept   d
     where  e.deptno = d.deptno  
     group  by  d.loc; 

218.부서위치, 부서위치별 평균월급을 출력하는데 소수점 이하는 안나오게 반올림을 하고
    부서위치별 평균월급이 높은것부터 출력하고 부서위치별 평균월급이 출력될때에
    천단위를 부여하시오 ~

select d.loc, to_char(round(avg(e.sal)), '999,999')
 from emp e, dept d
 where d.deptno = e.deptno
 group by d.loc
 order by 2 desc;

■ 049 ROW를 COLUMN으로 출력하기(UNPIVOT)

 Pivot 문 :  세로 ----> 가로
 unPivot 문:   가로 ----> 세로 

* order2 라는 테이블을 생성하고 데이터를 3건 입력한다. 

1. 테이블 생성 스크립트
create table order2
( ename  varchar2(10),
  bicycle  number(10),
  camera   number(10),
  notebook  number(10) );

2. 데이터 입력 스크립트 
insert  into  order2  values('SMITH', 2,3,1);
insert  into  order2  values('ALLEN',1,2,3 );
insert  into  order2  values('KING',3,2,2 );
commit;

3. order2 를 검색해본다.

select  * from  order2; 

예제)
select  *
    from  order2
        unpivot ( 건수  for   물품  in ( BICYCLE  ,  CAMERA ,  NOTEBOOK )  );

설명: 가로(컬럼) ---> 세로(데이터)
        위의 SQL 에서 건수와 물품은 SQL 작성자가 마음데로 이름을 명명해도 되는데
        이름 짓는데로 그대로 컬럼명으로 출력이 된다. 그리고  BICYCLE  ,  CAMERA , 
         NOTEBOOK 은 양쪽에 싱글 쿼테이션 마크를 둘러주지 않아도 됩니다. 
