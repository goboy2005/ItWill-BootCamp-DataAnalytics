3. 데이터 분석 함수 :        1. rank
                            2. dense_rank
                            3.  ntile
                            4.  cume_dist
                            5.  listagg
                            6. report_to_ratio
                            7. lag,  lead
                            8. sum(컬럼명) over (문법)  으로 데이터 누적
                            9. rollup
                           10. cube
                           11. grouping  sets 

4.  조인(join) 문장 

    " 하나의 테이블에서 얻을 수 있는 정보가 아닌 여러개의 테이블에서
     얻을 수 있는 정보를 하나의 결과로 보여주기 위해서 만든 문법 "                

예:  select   e.ename,  d.loc   <--  컬럼명 
         from  emp  e,  dept  d   <-- 테이블명 
         where  e.deptno = d.deptno    and   d.loc='DALLAS'; 

                                        조인조건       검색조건 

   emp ----------------------  dept
                연결고리 

219.월급이 2700 이상인 사원들의 이름과 월급과 부서위치를
출력하시오 ! 
                                                   
select   e.ename,  e.sal,  d.loc  
  from  emp  e ,  dept  d             
 where   e.deptno = d.deptno   and  e.sal >= 2700;

설명: 테이블 별칭을 사용해서 SQL 코딩을 좀 심플하게 작성하세요.
       그리고 반드시 조인문장 작성할때 컬럼명 앞에 테이블 별칭을
       사용하세요. 

     1. 검색속도 빨라진다.
     2. SQL 유지보수가 쉬워진다.  (가독성)

220.이름의 끝글자가 T 로 끝나는 사원들의 이름과 월급과 부서위치
와 부서명을 출력하시오 !

SELECT e.ename, e.sal, d.loc, d.dname
     from emp e, dept d
     where e.deptno = d.deptno and e.ename like '%T';

221.직업이 SALESMAN 이고 월급이 1200 이상인 사원들의 
            이름과 직업과 부서위치와 월급을 출력하시오 !

select  e.ename,  e.job, d.loc,  e.sal
  from  emp  e,  dept  d
  where   e.deptno = d.deptno  and   e.job ='SALESMAN'  
                                         and   e.sal >= 1200 ;
                     ↑                              ↑
                 조인조건                      검색조건 

222.부서위치, 부서위치별 토탈월급을 출력하는데
 DALLAS 는 제외하고 출력하시오 !

select  d.loc,  sum(e.sal)
   from  emp  e,  dept  d
   where   e.deptno = d.deptno  and  d.loc !='DALLAS'
   group  by  d.loc;

223.지금 출력된 결과를 다시 출력하는데 토탈월급이 높은것부터 
 출력하시오 !

select  d.loc,  sum(e.sal)
   from  emp  e,  dept  d
   where   e.deptno = d.deptno  and  d.loc !='DALLAS'
   group  by  d.loc
   order  by  sum(e.sal)  desc;

? 059 여러 테이블의 데이터를 조인해서 출력하기 2(NON EQUI JOIN)

 " 조인하려는 두개의 테이블 사이에 공통된 컬럼이 없었을때 사용하는 조인 문법"

예:  salgrade 테이블을 생성 
  
 급여등급   최소월급   최고월급
   ↑              ↑         ↑
 GRADE      LOSAL      HISAL
   ------   ---------- ----------
     1        700       1200
     2       1201       1400
     3       1401       2000
     4       2001       3000
     5       3001       9999

예제)
이름, 월급,  grade(급여등급) 을 출력하시오 !

            emp  -------------------  salgrade   

 select   e.ename,  e.sal,  s.grade 
   from   emp  e,  salgrade  s
   where   e.sal  between  s.losal  and  s.hisal;

224.위의 결과에서 등급이 3등급인 사원들만 출력하시오 !

 select   e.ename,  e.sal,  s.grade 
   from   emp  e,  salgrade  s
   where   e.sal  between  s.losal  and  s.hisal  and  s.grade = 3; 

설명:   * 조인 문법의 종류 2가지 
                1.  오라클 조인 문법 :
                                                1. equi  join :  두개의 테이블 사이에 공통된 컬럼이
                                                                   있었을 때의 조인 방법 
                                                2. non equi join : 두개의 테이블 사이에 공통된 
                                                                       컬럼이 없었을 때의 조인방법
                                                3. outer join :  두개의 테이블의 공통된 컬럼은 
                                                  있으나 조인하려는 컬럼의 데이터가 서로 일치하지
                                                   않을때 사용하는 조인 
                                                4. self  join :  자기 자신의 테이블과 조인하는 조인
                2.  1999  ansi 조인 문법 
                              ↓
                          american  national  standard  institute  

225.급여등급(grade), 급여등급별로 해당 하는 사원들의 이름을 가로로 출력하시오

grade   ename 
 1      ADAMS, JAMES, SMITH 
 2       
 3
 4
 5     KING   

 select  s.grade , listagg( e.ename, ',')  within  group ( order  by e.ename asc) as 이름
   from   emp  e,  salgrade  s
   where   e.sal  between  s.losal  and  s.hisal
   group  by  s.grade;  

1	ADAMS,JAMES,SMITH
2	MARTIN,MILLER,WARD
3	ALLEN,TURNER
4	BLAKE,CLARK,FORD,JONES,SCOTT
5	KING

226.위의 결과에서 월급도 옆에 같이 나오게 하시오 !

1	ADAMS(950),JAMES(1100),SMITH(700)
2	MARTIN,MILLER,WARD
3	ALLEN,TURNER
4	BLAKE,CLARK,FORD,JONES,SCOTT
5	KING

select  s.grade , listagg( e.ename ||'(' || sal || ')', ',')  
                                within  group ( order  by e.ename asc) as 이름
   from   emp  e,  salgrade  s
   where   e.sal  between  s.losal  and  s.hisal
   group  by  s.grade;  

1	ADAMS(1100),JAMES(950),SMITH(800)
2	MARTIN(1250),MILLER(1300),WARD(1250)
3	ALLEN(1600),TURNER(1500)
4	BLAKE(2850),CLARK(2450),FORD(3000),JONES(2975),SCOTT(3000)
5	KING(5000)

?  060 여러 테이블의 데이터를 조인해서 출력하기 3(OUTER JOIN)

  " 조인하려는 두 테이블의 공통된 컬럼인 deptno 의 데이터가 
    서로 똑같이 일치 하지 않을 때 조인하기 위해서 사용하는 조인 방법 "

예)
사원 테이블에서 부서번호를 출력하는데 중복제거해서 출력하시오 !

  select   distinct   deptno
   from   emp;

  DEPTNO
--------
      30
      10
      20

예)
부서(dept) 테이블에서 부서번호를 출력하시오 

  select  deptno
  from  dept; 

227. emp 와 dept 를 서로 조인해서 이름과 부서위치와 부서번호를 출력하시오 !

 select   e.ename,  d.loc, e.deptno 
   from   emp  e,  dept   d
   where  e.deptno = d.deptno ; 

설명: 위의 결과를 보면 40번은 조인이 되지 않아서 결과로 출력되지 않았습니다.
       왜 조인이 안되었나요?   사원 테이블에 40번 부서번호가 없어서 입니다. 

 select   e.ename,  d.loc
   from   emp  e,  dept   d
   where  e.deptno(+) =d.deptno ; 

 설명:      outer join sign (+) 는  결과로 출력될때 데이터가 모자란 쪽에 붙여준다. 
            emp 테이블에서는 부서번호가 10,20,30 이있고 40번이 없습니다. 
            dept 테이블에는 부서번호가 10, 20, 30, 40 이 있습니다. 

228.  부서위치, 부서위치별 토탈월급을 출력하시오 !

 select  d.loc, sum(e.sal)
   from  emp  e,  dept  d
   where  e.deptno = d.deptno 
   group  by  d.loc; 

LOC                        SUM(E.SAL)
-------------------------- ----------
NEW YORK                         8750
DALLAS                          10875
CHICAGO                          9400

설명:  위의 조인된 결과를 보면 부서위치(loc) 쪽에 BOSTON 이 안 보입니다.
        
229.위의 결과에서 BOSTON 도 나오겠금 조인문법을 변경하세요 ~

 select  d.loc, sum(e.sal)
   from  emp  e,  dept  d
   where  e.deptno (+) = d.deptno 
   group  by  d.loc; 

LOC                        SUM(E.SAL)
-------------------------- ----------
NEW YORK                         8750
DALLAS                          10875
CHICAGO                          9400
BOSTON

* 우리반 테이블과 조인하기 위한 테이블을 생성 
  ( 통신사 기본 요금 테이블 )

 drop  table  telecom_price;

  create  table   telecom_price
  (   telecom     varchar2(10),
      price         number(10),
     service_cnt   number(10) );

 insert  into   telecom_price   values('sk', 18500,  9 );
 insert  into   telecom_price   values('kt', 17000,  9 );
 insert  into   telecom_price   values('lg', 18000, 10 ); 
 commit; 

230.(점심시간 문제)
우리반 테이블과  telecom_price 테이블을 조인해서  이름, 나이, 성별, 통신사
통신사 기본요금(price) 을 출력하는데  나이가 27 이상인 학생들만 출력되게하시오!

select e.ename, e.age, e.gender, e.telecom, t.price
   from emp12 e, telecom_price t
          where e.telecom=t.telecom and e.age >= 27;
         

? 061 여러 테이블의 데이터를 조인해서 출력하기 4(SELF JOIN)

     " 자기 자신의 테이블과 조인하는 조인 문법 " 

왜 자기 자신의 테이블과 조인을 해야하는가 ?   사원 테이블로 예를 들면 사원이름과
                                                                  그 사원을 관리하는 관리자의 이름을
                                                                    하나의 결과로 볼 수 있기 때문입니다. 

 예)
 사원번호, 사원이름, 관리자 번호(mgr) 를 출력하시오 !

  select  empno, ename, mgr
    from  emp;

                   7839   KING  
                              ↑
                 7566  JONES  
                          ↑
              7902   FORD   
                       ↑
           7369  SMITH 

예제)
사원이름,  해당 사원의 관리자의 이름을 출력하시오 ! 

  select   사원.ename,   관리자.ename
   from   emp  사원,  emp  관리자 
   where   사원.mgr  = 관리자.empno; 

231.위의 결과를 다시 출력하는데 컬럼명을  한글로 사원, 관리자라고 출력되게하시오

사원                  관리자 
-------------------- -------
BLAKE                KING
CLARK                KING
JONES                KING
MARTIN               BLAKE
ALLEN                BLAKE

  select   사원.ename as  사원,   관리자.ename  as  관리자
   from   emp  사원,  emp  관리자 
   where   사원.mgr  = 관리자.empno; 

232.사원이름, 사원월급, 관리자이름, 관리자의 월급을 출력하시오 !

 select   사원.ename as  사원,  사원.sal  as 사원월급,  
           관리자.ename  as  관리자,  관리자.sal  as  "관리자의 월급"
        from   emp  사원,  emp  관리자 
   where   사원.mgr  = 관리자.empno; 

233.위의 결과를 다시 출력하는데  사원의 월급이 관리자의 월급보다 더 큰 사원들
 만 출력하시오 ! 

 select   사원.ename as  사원,  사원.sal  as 사원월급,  
           관리자.ename  as  관리자,  관리자.sal  as  "관리자의 월급"
   from   emp  사원,  emp  관리자 
   where   사원.mgr  = 관리자.empno  and  사원.sal > 관리자.sal ;

234.관리자보다 먼저 입사한 사원들의 사원 이름과 사원 입사일, 관리자 이름과 
 관리자의 입사일을 출력하시오 !

  select   사원.ename,  사원.hiredate,  관리자.ename, 관리자.hiredate
    from   emp  사원,   emp  관리자
    where   사원.mgr = 관리자.empno  and  사원.hiredate  <  관리자.hiredate;  
  
235.관리자이름을 출력하고  그 옆에 해당 관리자에 속한 사원들의 이름을 
가로로 출력하시오 !

select  관리자.ename as  관리자,  
                listagg(사원.ename, ',')   within  group ( order by 사원.ename)  as  사원
    from    emp   사원,  emp  관리자
    where   사원.mgr = 관리자.empno
    group  by  관리자.ename; 

BLAKE	ALLEN,JAMES,MARTIN,TURNER,WARD
CLARK	MILLER
FORD	SMITH
JONES	FORD,SCOTT
KING	BLAKE,CLARK,JONES
SCOTT	ADAMS


236.직업, 이름, 월급, 순위를 출력하는데 순위가 월급이 높은 순서데로 순위를
부여하시오 ! 

select  job, ename, sal, dense_rank()  over ( order  by  sal  desc ) 순위
   from   emp ;

237.위의 결과를 다시 출력하는데 직업별 각각 순위가 부여되게 하시오 !

select  job, ename, sal, dense_rank()  over (  partition  by   job  
                                                         order  by  sal  desc ) 순위
   from   emp ;

238.부서위치, 이름, 월급, 순위를 출력하는데 부서위치별로 각각 월급이 높은순서데로 순위를 부여하시오 ! 

select  d.loc,  e.ename, e.sal, 
          dense_rank()  over  ( partition  by  d.loc
                                     order  by   e.sal  desc) 순위
     from  emp  e,  dept   d
     where  e.deptno = d.deptno; 


239.부서위치, 부서위치별로 속한 사원들의 이름을 가로로 출력하시오 !

select  d.loc, 
         listagg( e.ename,',' )  within  group  ( order  by  e.ename  asc )  사원
  from  emp  e, dept  d
  where  e.deptno = d.deptno 
  group  by  d.loc; 

CHICAGO	ALLEN,BLAKE,JAMES,MARTIN,TURNER,WARD
DALLAS	            ADAMS,FORD,JONES,SCOTT,SMITH
NEW YORK	    CLARK,KING,MILLER
  
240.부서위치, 부서위치별 토탈월급을 출력하는데 맨 아래에 전체 토탈월급이
출력되게하시오 

select  d.loc,  sum(e.sal)
  from  emp  e, dept  d
  where  e.deptno = d.deptno
  group  by  rollup(d.loc) ;

241.직업, 직업별 최대월급, 직업별 최소월급, 직업별 평균월급을
출력하시오 ! 

select   job,  max(sal), min(sal), avg(sal)
  from  emp
  group  by  job; 

242.부서위치,  부서위치별 최대월급, 부서위치별 최소월급, 부서위치별 인원수를
 출력하시오 !

select  d.loc, max(e.sal), min(e.sal), count(*)
  from  emp  e,  dept  d
  where  e.deptno = d.deptno
  group  by  d.loc; 

? 062 여러 테이블의 데이터를 조인해서 출력하기 5(ON절)

  * 조인 문법  2가지 ?    1.  오라클 조인 문법
                                                - equi  join
                                                - non equi  join
                                                - outer  join
                                                - self  join
                                2.  1999 ANSI 조인 문법 
                                                - on 절을 사용한 조인
                                                - using 절을 사용한 조인 
                                                - natural  join
                                                - left/right/full  outer  조인
                                                - cross 조인 
예: 

 1. 오라클 equi  join                                   2. on 절을 사용한 조인
 
  select  e.ename,  d.loc                             select  e.ename, d.loc
    from  emp  e, dept  d                               from  emp  e  join   dept  d
   where  e.deptno = d.deptno ;                       on  ( e.deptno = d.deptno ) ;

243.이름과 월급과 부서위치를 출력하는데 월급이 2400 이상인 사원들만 출력
하시오 ! ( on 절을 사용한 조인 문법으로 수행)

select  e.ename, e.sal,  d.loc
  from   emp  e   join    dept   d
  on  (  e.deptno = d.deptno)  
  where   e.sal >= 2400 ;   

설명: on 절을 사용한 조인 문법은  조인조건은 on 절에 주게 되어있고
         검색조건은 where 절에 주겠금 구분해 놓았다. 

244.DALLAS 에서 근무하는 사원들의 이름과 월급과 부서위치와 직업을
출력하는데 ON 절을 사용한 조인문법으로 수행하세요 ~

select  e.ename, e.sal, d.loc, e.job
  from  emp  e  join  dept  d
  on  (  e.deptno = d.deptno )
  where   d.loc='DALLAS'; 
  
245.emp 테이블과 salgrade 테이블을 서로 조인해서 이름, 월급, 급여등급(grade)
  를 출력하는데  2등급만 출력되게하고   on 절을 사용한 조인문법으로 
  수행하시오 !

select  e.ename,  e.sal,  s.grade
  from  emp  e  join  salgrade  s
  on  (  e.sal  between  s.losal  and  s.hisal )
  where   s.grade = 2; 

	?  063 여러 테이블의 데이터를 조인해서 출력하기 5(USING절)

예제)
select  e.ename,  d.loc
           from  emp  e  join   dept   d
           using  ( deptno );

246.직업이 SALESMAN 인 사원들의 이름과 월급과 직업, 부서위치를 출력하는데
 USING 절을 사용한 조인문법으로 수행하시오 !

select  e.ename, e.sal,  e.job,  d.loc
  from   emp  e   join  dept   d
  using  ( deptno )
  where  e.job='SALESMAN'; 

?  064 여러 테이블의 데이터를 조인해서 출력하기 6(NATURAL JOIN)

 예)
 select  e.ename,  d.loc
          from  emp  e  natural  join  dept   d; 
          
설명: where 절 없이 간단하게 조인하는 조인 문법 
        오라클이 알아서 두 테이블 사이에 공통된 컬럼이 있는지 찾아보고 조인한다. 
    
1.오라클 조인문법 : 4가지 전부 잘 알고 있어야 합니다.
2. 1999 ansi 문법 :  on 절을 사용한 조인 문법과 지금부터 보여줄 아우터 조인 문법을
                          잘 알고 있어야 합니다. 

	?  065 여러 테이블의 데이터를 조인해서 출력하기 7(LEFT/RIGHT OUTER JOIN)

예제)  

1. 오라클 조인 문법( 아우터 조인 )
  select   e.ename, d.loc
    from  emp  e,  dept  d
    where  e.deptno (+) = d.deptno; 

2. 1999 ANSI 조인 문법

  select   e.ename,  d.loc
      from   emp  e   right  outer  join  dept   d
      on ( e.deptno = d.deptno ); 

insert   into  emp(empno, ename, sal, job, deptno )
  values( 1221, 'jack', 3500, 'SALESMAN', 70 );

commit;

1. 오라클 조인 문법( 아우터 조인 )
  select   e.ename, d.loc
    from  emp  e,  dept  d
    where  e.deptno  = d.deptno (+); 

설명:dept 테이블에는 70번 부서가 없으므로 조인할 때 equi 조인을 하게 되면
       결과가 안나오고 outer join 을 사용해야 합니다. 

247.위의 결과를 1999 ansi 문법으로 구현하시오 !

  select   e.ename,  d.loc
      from   emp  e   left  outer  join  dept   d
      on ( e.deptno = d.deptno ); 

	?  066 여러 테이블의 데이터를 조인해서 출력하기 8(FULL OUTER JOIN)

 예제)
 select  e.ename, d.loc
           from  emp  e,   dept   d
           where  e.deptno (+) = d.deptno (+) ;
                                      *
3행에 오류:
ORA-01468: outer-join된 테이블은 1개만 지정할 수 있습니다

위의 결과 출력을 가능하게 해주는 조인 문법이 1999 ANSI 의 full outer join 입니다.

select  e.ename,  d.loc
  from  emp  e   full  outer   join   dept   d
   on  ( e.deptno = d.deptno );
    
	* 1999 ansi 문법의  cross 조인 이란 ?

  where 절없이 조인해서 전체를 다 조인하는 조인 문법 입니다.

1. 오라클 조인 문법

   select  e.ename, d.loc
    from  emp  e,  dept  d ;

2. 1999 ANSI 문법

   select  e.ename, d.loc
      from   emp  e   cross join  dept  d ;

  * 조인 문법  2가지 ?    1.  오라클 조인 문법
                                                - equi  join
                                                - non equi  join
                                                - outer  join
                                                - self  join
                                2.  1999 ANSI 조인 문법 
                                                - on 절을 사용한 조인
                                                - using 절을 사용한 조인 
                                                - natural  join
                                                - left/right/full  outer  조인
                                                - cross 조인 

248.우리반 테이블과 telecom_price 와 조인을 해서  이름이 김정민 학생의
 이름과 나이와 통신사와 통신요금(price) 을 출력하시오 !  (ANSI ON절 사용) 

select  e.ename,  e.age,  e.telecom, t.price
  from  emp12  e  join  telecom_price  t
  on  ( e.telecom = t.telecom )
  where e.ename='김정민'; 

249.나이가 28 이상인 학생들의 이름과 나이와 통신사와 통신요금(price) 를
 출력하시오 !


250. (오늘의 마지막 문제)   부서위치, 부서위치별 토탈월급 가로로 
출력하시오!
 가로출력 
NEW  YORK       DALLAS      CHICAGO      <--- 컬럼명
8750             10875          9400     <--- 데이터 


select sum( decode (d.loc, 'NEW YORK', e.sal)) as "NEW YORK",
        sum( decode (d.loc, 'DALLAS', e.sal)) as "DALLAS",
         sum( decode (d.loc, 'CHICAGO', e.sal)) as "CHICAGO"
               from emp e, dept d
                        where e.deptno=d.deptno;