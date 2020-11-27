Day 1 Problems 

■ Q-3. emp 테이블의 컬럼이 무엇무엇이 있는지 확인 하시오!

describe emp

■ Q-4. 이름,월급,커미션을 출력하시오

select ename,sal,comm 
from emp;

■ Q-5. 이름,직업,입사일 부서번호를 출력하시오!

select ename,job,hiredate,deptno 
from emp;

■ Q-6. emp 테이블에 모든 컬럼을 검색하시오 

describe emp;

■ Q-7. dept 테이블의 모든 컬럼을 출력하시오

describe dept;

■ Q-9.이름과 월급을 출력하는데 컬럼명이 아래와 같이 출력되게 하시오! (Employee name, Salary )
 
select ename as 'Employee name' , sal as 'Salary' 
from emp;

■ Q-10.아래와 같이 결과를 출력하시오
(KING 의 직업은 PRESIDENT 입니다  
SCOTT 의 직업 ANALYST 입니다) 

select ename ||'의 직업은'|| job ||'입니다'
from emp;
                      
■ Q-11. 위의 과에서  출력되는 컬럼명을 사원정보라는 한글로 출력되게 하시오

select ename ||'의 직업은'|| job ||'입니다'  as 사원정보 
from emp;

■ Q-12. 부서번호를 출력하는데 중복을 제거해서 출력하시오.
 
select distinct deptno 
from emp;

■ Q-13.이름과 월급을 출력하는데 월급이 높은 사원부터 출력하시오
 
 select ename,sal
  from emp
    order by sal desc;

■ Q-14. 이름과 입사일을 출력하는데 최근에 입사한 사원부터 출력하시오

select ename,hiredate
 from emp
    order by hiredate desc;

■ Q-15.이름과 직업과 입사일을 출력하는데 직업은 ABCD 순으로 정렬해서 출력하고 직업을 ABCD 순으로 정렬한걸 기준으로 입사일을
먼저 입사한 사원부터 출력되게 하시오 (order by 는 한번만 입력하면 된다) 

select ename,job,hiredate
  from emp
    order by 2 asc, 3 asc;

■ Q-16.사원번호가 7788번인 사원의 사원번호와 이름과 월급을 출력하시오

select ename,empno,sal
  from emp
    where empno=7788;

■ Q-17.30번 부서번호에서 근무하는 사원들의 이름과 월급과 부서번호를 출력하시오

select ename,sal,deptno
 from emp
   where deptno=30;

■ Q-17-2. 위의 결과를 다시 출력하는데 월급이 높은 사원부터 출력하시오 (17연결)

select ename,empno,sal
  from emp
    where empno=7788
      order by sal desc;

■ Q-19.부서번호가 20번인 사원들의 이름과 입사일과 부서번호를 출력하는데 최근에 입사한 사원부터 출력하시오.

select ename,hiredate,deptno
 from emp
   where deptno=20
     order by hiredate desc;

■ Q-20.직업이 SALESMAN인 사원들의 이름과 월급과 직업을 출력하시오 
 select ename,sal,job
  from emp
    where job='SALESMAN';

■ Q-21.81년 11월 17일에 입사한 사원의 이름과 입사일을 출력하시오
 
 select ename,hiredate
  from emp
    where hiredate='81/11/17';

■ Q-22.이름과 연봉(sal*12)을 출력하는데 컬럼명을 한글로 이름,연봉으로 출력하시오

select ename as 이름, sal*12 as 연봉
 from emp;

■ Q-23.위의 결과를 다시 출력하는데 연봉이 36000인 사원들의 이름과 연봉을 출력하시오 (22연결)

select ename as 이름, sal*12 as 연봉
  from emp
    where sal*12=36000;

■ Q-24.이름과 연봉을 출력하는데 연봉이 높은 사원부터 출력하시오 

select ename as 이름, sal*12 as 연봉
  from emp
     order by 2 desc;

 ■ Q-25.커미션이 150 이상인 사원들의 이름과 커미션을 출력하시오 

select ename,sal
   from emp
     where sal<=2400
        order by sal desc;

■ Q-26.아래의 SQL 에서 더하기 가 먼저 실행되게 하려면?

select ename, (sal+200) * 20
from emp; 

■ Q-27.월급이 3000이상인 사원들의 이름과 월급을 출력하시오 
 
 select ename,sal
   from emp
     where sal>=3000;

■ Q-28.직업이 SALESMAN 이 아닌 사원들의 이름과 직업을 출력하시오

select ename,job
    from emp
       where job !='SALESMAN';

■ Q-29.월급이 2400 이하인 사원들의 이름고 월급을 력하는데 월급이 높은 사원부터 출력하시오.

select ename,sal
    from emp
     where sal<=2400
      order by sal desc;

■ Q-30.월급이 1000에서 3000사이인 사원들의 이름과 월급을 출력하시오 

select ename,sal
from emp
where sal between 1000 and 3000;
 또는
select ename,sal
from emp
Where sal>=1000 and sal <=3000;

■ Q-31 월급이 1000에서 3000사이가 아닌 사원들의 이름과 월급을 출력 하시오 

select ename,sal
   from emp
      where sal not between 1000 and 3000; 
        (not 을 사용하기) 

■ Q-32.1981년도에 입사한 사원들의 사원들의 이름과 입사일을 출력하시오.
 
 select ename,hiredate
  from emp
    where hiredate between '81/01/01' and '81/12/31';

■ Q-33.이름의 끝 글자가 T로 끝나는 사원들의 이름을 출력하시오 

select ename
    from emp
       where ename like '%T';

■ Q-34. 81년도에 입사한 사원들의 이름과 입사일을 출력하는데 between and 사용하지 말고 Like 로 

select ename
 from emp
   where hiredate like '81%';

■ Q-35.이름의 두번째 철자가 M인 사원들의 이름을 출력하시오!

select name
  from emp
    Where ename like '_M%';

■ Q-36.이름의 세번째 철자가 A인 사원들의이름. 

select ename 
  from emp
    where ename like '__M%';
