■ 038 평균값 출력하기(AVG)

예제)
사원테이블의 총 월급을 출력하시오.
select sum(sal)
from emp;

@group함수로 조건을 줄때는 where  절에 사용하면 안되고 having 절에 사용해야 합니다. 
where 절에는 그룹함수를 사용하지 않은 일반적인 검색조건을 때 사용합니다. 

코딩순서 : select --- from--- where--- group by ---having --- order by 
실행순서: from ---- where---group by --- having --- select ---order by 

select 검색할 컬럼명
from 검색할 테이블명
where 검색조건
group by 그룹핑할 검색조건
having 그룹함수로 검색조건 줄 때 사용
order by 정렬할 컬럼명 

select job,sum(sal)
from emp
group by job
having sum(sal) >=6000 and job!='SALESMAN'    
order by sum(sal) desc;

이경우 검색속도가 느려진다. 되기는 하는데 검색조건을 having 절에 사용하면 검색속도가 느려지니까 
반드시 where 절에 작성해야 합니다. Having 절은 Group 함수 조건줄때만 사용하세요.

■ 040 건수 출력하기(COUNT)

예: 사원 테이블의 인원수를 확인하시오 
select count(empno) 
from emp

select count(*) 
from emp;

select count(comm)
from emp;
"그룹함수는 null값을 무시한다"

설명: select job,count(empno) from emp
group by job;

■ 041 데이터 분석 함수로 순위 출력하기 1(RANK)

데이터 석 함수 : 데이터 분석을 용이하게 하기 위해서 제공하는 함수 
그중에 rank는 순위를 출력하는 함수입니다.
예제: 이름,월급,월급에 대한 순위를 출력하시오. 

가로안에 있는 월급이 높은 순서대로 확장해서 순위를 출력하겠다. 

설명: Partition by 는 group by  하고 혼동하면 안된다.
partition by 는 데이터 분석함수에서 괄호안에 쓰는 문법으로
partiton by job 이라고 하면 직업별로 각각 파티션해서 나누겠다는 것이다.
그래서 아래의 뜻
rank() over (partition by job ----직업별로 파티션해서 
                order by sal desc) ---- 월급이 높은 순서대로 순위를 출력하겠다. 
예제)
select lower(substr(telecom,1,2)),ename,age,dense_rank() over (partition by lower(substr(telecom,1,2)) order by age desc) as 순위
from emp12;

월급이 같아서 순위가 여러 개 나오면 다음 순위가 그 다음 순위가 중복된 수만큼 더해서 출력되는 것이 rank 이고 중복되었더라도 바로 그 다음순위가 나오는것아 dense_rank()이다. 


117.직업이 ANALYST 인 사원들의 최대월급을 출력하시오.

select job,max(sal)
from emp
where job='ANALYST'
group by job;

118.직업별 최대월급을 출력하시오.

select max(sal),job
from emp
group by job;

119.직업별 최대월급이 높은것부터 나오게 해보시오

select job,max(sal)
from emp
group by job
order by max(sal) desc;

120.부서번호,부서번호별 최대월급을 출력하는데, 부서번호별 최대월급이 높은것부터 출력하시오.

select deptno,max(sal)
from emp
group by deptno
order by max(sal) desc nulls last 

121.이름과 연봉(sal*12)를 출력하는데 연봉을 출력할때 천단위와 백만단위가 표시되게 하시오!

select ename,to_char(sal*12,'999,999,999') as 연봉
from emp;

122.위의 결과를 다시 출력하는데 컬럼명을 한글로 연봉이라고 하고 연봉이 높은 사원부터 출력하시오 

select ename,to_char(sal*12,'999,999') as "$ 연봉"
from emp
where to_char(sal*12,'999,999') is not null
order by to_char(sal*12,'999,999') desc; 

123.직업별 최대 월급을 출력하는데 직업별 최대월급을 출력할때 천단위 콤마(,)가 출력되게 하시오

select job,to_char(max(sal),'9,999')
from emp
where job is not null
group by job;

124.직업,직업별  최소 월급을 출하시오! 

select job,min(sal)
from emp
where job is not null
group by job;

125.위의 결과를 다시 출력하는데 직업이 ABCD 순서대로 출력하시오! 

select job,min(sal)
from emp
where job is not null
group by job
order by job asc;

125.위의 결과에서 직업이 SALESMAN은 제외하고 출력하시오 

select job,min(sal)
from emp
where job is not null and job!='SALESMAN'
group by job
order by job asc;

127.우리반에서 최소 나이를 출력하시오 

select min(age)
from emp12;

128.서울에서 사는 학생중에 최소나이를 출력하시오 

select min(age)
from emp12
where address like '%서울%';

129.입사한 년도(4자리)를 출력하고 입사한 년도별 최소 월급을 출력하시오.

select min(sal),to_char(hiredate,'RRRR')
from emp
group by to_char(hiredate,'RRRR');

130.우리반 나이의 평균값을 출력하시오.

select round(avg(age),2)
from emp12;

131.사원 테이블의 월급의 평균값을 출력하시오!

select avg(sal)
from emp;
(설명: 월급을 다 더한후 14로 나눔)  

132.커미션의 평균값을 출력하시오. 

select avg(comm)
from emp;
(설명:커미션을 다 더한후 4로 나눈거...null은 제거를 한것! )

133.위의 결과를 다시 출력하는데 4로 나누지 않고 14로 나누게 하시오.

select avg(nvl(comm,0))
from emp;
설명: null 값을0으로 다 변경했기 때문에 4로 나누지 않고 14로 나누게 되었다

134.위의 결과에서 소수점 이하는 안나오게 반올림 하시오. 

select round(avg(nvl(comm,0)),0)
from emp;

135.직업,직업별 평균월급을 출력하시오 

select job,avg(sal)
from emp
where job is not null
group by job;

136.통신사,통신사별 평균나이를 출력하시오

select avg(age),lower(substr(telecom,1,2))
from emp12
where lower(substr(telecom,1,2)) in ('sk','lg','kt')
group by lower(substr(telecom,1,2));
or
select decode(lower(telecom),'skt','sk',lower(telecom)),avg(age)
from emp12
group by decode(lower(telecom),'skt','sk',lower(telecom));

137L. 전공을 출력하고 전공별 평균나이 출력하는데 전공이 ㄱ,ㄴ,ㄷ 순으로 출력되게 하시오! 

select ltrim(major),avg(age)
from emp12
group by major
order by major asc;

138.직업,직별 토탈월급을 출력하는데 직업 토탈월급이 높은것부터 출력하시오. 

select job,sum(sal)
from emp
group by job
order by sum(sal) desc;

139.위의 결과에서 직업이 SALESMAN은 제외하고 출력하시오!

select job,sum(sal)
from emp
where job!='SALESMAN'
group by job
order by sum(sal) desc;

140.위의 결과를 다시 출력하는데 토탈월급이 6000이상인것만 출력하시오 

select job,sum(sal)
from emp
where job!='SALESMAN' 
having  sum(sal)>=6000
group by job
order by sum(sal) desc;

141.직업,직업별,토탈월급을 출력하는데 직업이 SALESMAN은 제외하고 출력하고 직업별 토탈월급이 6000이상인것만 출력하고 직업별 토탈월급이 높은것부터 출력하시오! 

select job,sum(sal)
from emp
where job!='SALESMAN'
group by job
having sum(sal) >=6000
order by sum(sal) desc;

142.통신사,통신사별 토탈나이를 출력하시오 skt는 제외하고 출력하고 통신사별 토탈나이가 100살이상인 데이터만 출력하고 통신사별 토탈나이가 높은것부터 출력하시오 

select lower(telecom),sum(age)
from emp12
where lower(telecom)!='skt'
group by lower(telecom)
having sum(age)>=100
order by sum(age) desc;

143.위에 문제를 다시 푸는데 이번에는 skt를 sk에 포함시켜서 출력하시오.

select lower(substr(telecom,1,2)) , sum(age)
from emp12
group by lower(substr(telecom,1,2))
having sum(age) >= 100
order by sum(age) desc;

144.입사한 년도(4자리),입사한 년도별 토탈월급을 출력하는데, 토탈 월급을 출력할때 천단위 표시가 출력되게 하시오.

select to_char(hiredate,'RRRR'),to_char(sum(sal),'999,999')
from emp
group by to_char(hiredate,'RRRR');

145 직업,직업 인원수를 출력하시오 

select job,count(*) 
from emp
group by job;

146.나이,나이별 인원수를 출력하시오 ! 

select age,count(*)
from emp12
group by age; 

147.위의 결과를 다시 출력하는데 나이별 인원수가 높은것부터 출력하시오 

select count(*),age
from emp12
group by age
order by count(*) desc;

148.위의 결과를 다시 출력하는데 나이별 인원수가 두병이상인것 출력 

select count(*),age
from emp12
group by age
having count(*) >=2
order by count(*) desc;

149.통신사,통신사별 인원수를 출력하시오 

select lower(substr(telecom,1,2)), count(*)
from emp12
group by lower(substr(telecom,1,2));

150.이름,이메일 도메인만 출력하시오.

select ename, substr(email, instr(email, '@') +1, instr(email, '.', -1, 1) - instr(email, '@') -1)
  from emp12;

151.이메일 도메인,이메일 도메인별 인원수를 출력하시오.

select count(*), substr(email, instr(email, '@') +1, instr(email, '.', -1, 1) - instr(email, '@') -1)
  from emp12
  group by substr(email, instr(email, '@') +1, instr(email, '.', -1, 1) - instr(email, '@') -1);

153.이름,나이,순위를 출력하는데 나이가 높은 순서대로 순위를 출력하시오 

select ename,age,rank() over (order by age desc) as 순위
from emp12;

154.직업,이름,월급,순위를 출력하는데 직업별로 각각 월급이 높은 순서대로 순위가 출력되게 하시오. 

select job,ename,sal,rank() over (partition by job order by sal desc) as 순위
from emp;

155.부서번호,이름,입사일,순위를 출력하는데 순위가 부서번호별로 각각 먼저 입사한 사원순으로 순위가 부여되게 하시오. 

select deptno,ename,hiredate, rank() over (partition by deptno
                                           order by hiredate asc)
                                           from emp;

156.통신사,이름,나이,순위를 출력하는데 통신사별로 각각 나이 높은 학생순으로 출력. 

select lower(substr(telecom,1,2)),ename,age,rank() over (partition by lower(substr(telecom,1,2)) order by age desc) as 순위
from emp12;

157.이름,월급,순위를 출력하는데 dense_rank 를 써서 월급 순위가 1,2,3,4,5 등 전부 출력되게 하시오 

select ename,sal,dense_rank() over (order by sal desc) as 순위
from emp;

158.입사한 년도(4자리),이름,월급,순위를 출력하는데 순위가 입사한 년도 별로 각각 월급이 높은 서대로 순위를 출력하시오 .

select to_char(hiredate,'RRRR'),ename,sal,dense_rank() over 
(partition by to_char(hiredate,'RRRR') order by sal desc) as 순위
from emp;

159.이메일 도메인,이름,나이,순위를 출력하는데 순위가 이메일 도메인 별로 각각 나이가 높은 학생순으로 출력되게 하시오.  

select ename,age, substr(email, instr(email, '@') +1,
instr(email, '.', -1, 1) - instr(email, '@') -1),rank() over (partition by substr(email, instr(email, '@') +1,
instr(email, '.', -1, 1) - instr(email, '@') -1) order by age desc) 
from emp12;
