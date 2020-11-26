Day 4 problems 

■ Q-90.직업이 SALESMAN 인 사원들의 이름과 월급과 직업을 출력하는데 월급이 높은 사원부터 출력하시오!

select ename,job,sal
from emp
where job = 'SALESMAN'
order by sal desc;

■ Q-91.직업이 SALESMAN 이 아닌 사원들의 이름과 입사일과 직업을 출력하는데 최근에 입사한 사원부터 출력하시오 

select ename,job,hiredate
from emp
where job not in ('SALESMAN')
order by hiredate desc;

■ Q-92.월급이 1000에서 3000사이인 사원들의 이름과 월급을 출력하시오.

select ename,sal
from emp
where sal between 1000 and 3000;

■ Q-93.이름을 출력하고 그 옆에 이름의 첫번째 철자만 출력하는데
소문자로 출력하시오

select ename,lower(substr(ename,1,1))
from emp;

■ Q-94.우리반 테이블에서 이름과 이메일을 출력하고 그 옆에 이메일에서 @가 몇번째 철자인지 출력하시오.

select ename,email,instr(email,'@')
from emp12;

■ Q-95.이름과 입사일,입사한 년도를 4자리로 출력하시오 

select ename,hiredate, to_char(hiredate,'RRRR') 
from emp;

■ Q-96.11월에 입사한 사원들의 이름과 입사일을 출력하시오.

select ename,hiredate,to_char(hiredate,'MM')
from emp
where to_char(hiredate,'MM')=11; 

■ Q-97.96번을 to_char 사용하지 말고 substr 로 수행하시오

select ename,hiredate
from emp
where substr(hiredate,4,2) like '11';

■ Q-98.1981년도에 입사한 사원들의 이름과 입사일을 출력하시오 . 
to_char 사용

select ename,hiredate
from emp
where to_char(hiredate,'RRRR') = '1981' ;
or
to_date 사용 
select ename
from emp
where hiredate between to_date('81/01/01','RR/MM/DD') and to_date('81/12/31','RR/MM/DD');

■ Q-99. 1981년도에 입사한 사원들 이름과 입사한 년도를 출력하는데
최근에 입사한 사원부터 출력하시오. 

select ename,hiredate
from emp
where hiredate between to_date('81/01/01','RR/MM/DD') and to_date('81/12/31','RR/MM/DD')
order by hiredate desc;

■ Q-100.이름,커미션을 출력하시오

select ename,comm
from emp;

■ Q-101.이름 커미션을 출력하는데 커미션이 null인 사원들은 no comm이라는 글씨로 출력하시오. 

select ename,nvl(comm,'no comm')
from emp;
에러가 난다. 이유는 comm은 숫자형이고 'no comm'은 문자형 이기때문이다. 
설명 : 숫자형을 문자형으로 변환해서 데이터 타입을 서로 동일하게 맞춰주고 출력하면 된다. 
select ename,nvl(to_char(comm),'no comm')
from emp;

■ Q-102.커미션이 null 인 사원의 이름과 커미션을 출력하시오! is null 사용 x
(자료에 0이 있어서 0은 못쓰고 -1로 대체하기 개능) 

select ename,comm
from emp
where nvl(comm,-1) = -1;

■ Q-103.이름,월급,직업,보너스를 출력하는데 보너스가 직업이 SALESMAN 이면 4500을 출력하고 
직업이 ANALYST 면 2400을 출력하고,나머지 직업을 0 출력하시오. 

select ename,sal,job,
decode(job,'SALESMAN',4500,
                        'ANALYST',2400,
                        0) as 보너스 
 from emp;

■ Q-104.이름,입사한 년도 4자리로 출력하시오 

select ename,hiredate,to_char(hiredate,'RRRR')
form emp;

■ Q-105.이름, 입사한 년도, 보너스를  출력하는데 보너스가
입사한 1980년이면 5000을 출력하고 1981년이면 4000을 출력하고 나머지 년도는 0으로 출력하시오 

select ename,hiredate,to_date(hiredate,'RRRR'),
decode(to_date(hiredate,'RRRR'),'1981',5000,
                                                  '1980',4000,
                                                     0) as 보너스 
      from emp;

■ Q-106.이름,월급,보너스를 출력하는데 보너스를 월급이 4000이상이면 500출력 
                                                           월급이 2000이상이면 300 출력
                                                           하고 나머지 월급사원들은 0을 출력하시오  

select ename,sal,case when sal >= 4000 then 500
                             when sal>= 2000 then 300 
                         else 0 end as 보너스 
from emp;

■ Q-107.이름,월급,부서번호,보너스를 출력하는데 보너스가 부서번호가 10번이면
500을 출력하고 부서번호가 20번이면 300을 출력하고 나머지 부서번호면 0을 출력하시오.
select ename,sal,deptno, case when deptno = 10 then 500
                                              when deptno = 20 then 300
                                                                 else 0 end as 보너스
 from emp;

■ Q-108.우리반 테이블에서 이름을 출력하고 그 옆에 보너스를 출력하는데 이름의 철자가 3글자이면 보너스를 7000을 출력하고, 이름의 철자가 2글자이면 보너스를 5000을 출력
이름의 철자가 4글자이면 보너스를 4000을 출력!        

select ename,case when length(ename)=4 then 4000
                 when length(ename)=3 then 7000
                  when length(ename)=2 then 5000
                                    end as 보너스
from emp12;

■ Q-109.이름 세글자로만 이름의 가운데 글자를 * 로 출력하시오 
a)이름의 철자의 갯수가 3글자와 2글자는 아래의 SQL로 수행

select ename,replace(ename,substr(ename,2,1),'*')
from emp12;
b)이름의 철자의 갯수가 4글자이면
select replace(ename,substr(ename,-2,1),'*')
from emp12;

■ Q-110.우리반 테이블의 이름의 철자의 갯수와 관계없이 일괄적으로 이름이 *이 아래와 같이 출력되게 하시오 ! 

select ename,case when length(ename)=4 then replace(substr(ename,-2,1),'*')
                   when length(ename)=3 then replace(substr(ename,-2,1),'*')
                   when length(ename)=2 then replace(substr(ename,-1,1),'*') 
                                    end as 전광판 
from emp12;

■ Q-111. emp(사원)테이블에서 이름을 출력하고 입사한 요일을 출력하는데
             입사한 요일이 월화수목금토일 순으로 출력하시오! 

■ Q-112.직업이 SALESMAN인 사원들의 최대 월급을 출력하시오 ! 

select max(sal)
from emp
where job='SALESMAN';

■ Q-113.우리반에서 최소 나이인 학생의 나이를 출력하시오.

select min(age)
from emp12;

■ Q-114.통신사가 sk인 학생들 중에서 최대 나이인 학생의 나이를 출력하시오 

select max(age)
from emp12
where telecom like '%sk%';

■ Q-115.30 번 부서번호의 최대월급을 출력하시오! 

select max(sal)
from emp
where deptno=30;

■ Q-116.(오늘의 마지막 문제) 직업,직업별 최대월급을 출력하는데 직업이 SALESMAN 만 출력하시오 ! 

select job,max(sal)
from emp
where job='SALESMAN'
group by job;
