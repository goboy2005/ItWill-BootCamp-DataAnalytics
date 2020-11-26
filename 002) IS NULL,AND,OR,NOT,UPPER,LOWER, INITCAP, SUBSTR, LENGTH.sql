
■ Q-37.이름 첫번째 철자가 A로 시작하는 사원들의 이름과 월급을 출력하시오

select ename,sal
from emp
where ename like 'A%';

■ Q-38.이름이 SCOTT인 사원의 이름과 월급과 직업을 출력하시오

select ename,sal,job
from emp
where ename='SCOTT';

■ Q-39.이름의 끝에서 두번째 철자가 T인 사원들의 이름과 월급을 출력하시오

select ename,sal
from emp
where ename like '%T_';

■ Q-40.커미션이 null 인 사원들의 이름과 커미션을 출력하시오.

select ename,comm
from emp
where comm is null;

■ Q-41.커미션이 null이 아닌 사원들의 이름과 커미션을 출력하시오 

select ename,comm
from emp
where comm is not null;

■ Q-42.관리자의 사원번호 (mgr) 이 null 인 사원들의 이름과 직업을 출력하시오 

select ename,job,mgr
from emp
where mgr is null;
설명:사장 (President) 은 관리자가 번호 (mgr) 가 없다. (자기가 짱이니까)

■ Q-43.사원번호,이름,관리자의 번호 (mgr)을 출력하시오 

select ename,mgr
from emp;

■ Q-44.직업이 SALESMAN,ANALYST 인 사원들의 이름과 직업을 출력하시오.

select ename,job
from emp
where job in ('SALESMAN','ANALYST');

■ Q-45.직업이 SALESMAN,ANALYST 가 아닌 사원들의 이름과 직업을 출력하시오!

select ename,job
from emp
where job not in ('SALESMAN','ANALYST');

■ Q-46.직업이 SALESMAN 이 아닌 사원들의 이름과 월급과 직업을 출력하시오 !

select ename,sal,job
from emp
where job!='SALESMAN';

■ Q-47.위의 결과를 다시 출력하는데 월급이 높은 사원부터 출력하시오 (46연결)

select ename,job,sal
from emp
where job!='SALESMAN'
order by 3 desc,1 asc;

■ Q-48.우리반 테이블에서 이름과 나이를 출력하는데 나이가 높은 학생부터 출력하시오.

select ename,age
from emp12
order by age desc;

■ Q-49.이름과 나이와 주소를 출력하는데 30살 이상인 학생들만 출력하시오.

select ename,age,address
from emp12
where age>=30;

■ Q-50.성씨가 김씨인 학생들의 이름과 통신사를 출력하시오

select ename,telecom
from emp12
where ename like '김%';

■ Q-51.전공에 통계를 포함하고 있는 학생들의 이름과 전공을 출력하시오

select ename,major
from emp12
where major like '%통계%';

■ Q-52.우리반에gmail을 사용하는(포함과 같음) 학생들의 이름과 메일을 출력하시오 

select ename,email
from emp12
where email like '%gmail%';

■ Q-53.나이가 27에서 34사이인 학생들의 이름과 나이를 출력하시오.

select ename,age
from emp12
where age between 27 and 34

■ Q-54.나이가 27에서 34사이가 아닌 학생들의 이름과 나이를 출력하시오
select ename,age
from emp12
where age not between 27 and 34;

■ Q-55.주소가 경기도인 학생들의 이름과 나이와 주소를 출력하시오.

select ename,age,address
from emp12
where address like '%경기도%'

■ Q-56.통신사가 sk,lg인 학생들의 이름과 통신사를 출력하시오.

select ename,telecom
from emp12
where telecom in ('sk','lg');

■ Q-57.서울에서 사는 학생들의 이름과 나이와 전공을 출력하시오, 
나이가 높은 학생부터 출력.

select ename,age,major
from emp12
where address like '%서울%'
order by age desc;

■ Q-58.이메일이gmail이 아닌 학생들의 이름과 email을 출력하시오. 

select ename,email
from emp12
where email not like '%gmail%';

■ Q-59.아래와 같이 결과가 출력되게 하시오! 
    김주원 학생의 나이는 44 입니다. 
    (ename '학생의 나이는' age '입니다')

select ename||'학생의 나이는'||age||'입니다.' "
from emp12

■ Q-60.직업이 SALESMAN 이거나 ANALYST인 사원들의 이름과 월급,직업을 출력하시오. (2개 방법 존재)  

select ename,sal,job
from emp
where job='ANALYST' or job='SALESMAN';
이것도 되고
select ename,sal,job
from emp
where job in ('SALESMAN','ANALYST');

■ Q-61.성씨가 김씨,이씨가 아닌 학생들의 이름을 출력하시오. 

select ename
from emp12
where ename not like '김%' and ename not like '이%'

■ Q-62.이메일 gmail 과 naver 가 아닌 학생들의 이름과 이메일을 출력하시오 

select ename,email
from emp12
where email not like '%gmail%' and email not like '%naver%';

■ Q-63.우리반 테이블에서 통신사가 sk 와 관련된 통신사 이면 그 학생의 이름과 통신사를 출력하시오. 
정확하게 데이터가 출력이 되어지겠금, SQL을 작성하세요. (대문자 통합으로,소문자 통합으로 , 앞대문자, 뒤는 소문자 통합) 

select ename,telecom
from emp12
where upper(telecom) like '%SK%';
핵심 : Where upper(telecom) :  (telecom 데이터를 전부 대문자로 변경한해 버리기) 

■ Q-64.김,이,유 씨인 학생들의 이름과 나이를 출력하는데 like 쓰지 말고 in과 substr 써서 추출력하시오.  

select ename,age
from emp12
where substr(ename,1,1) in ('김','이','유');

■ Q-65.우리반 테이블에서 이메일과 이메일의 철자에 길이를 출력하는데 이메일 철자의 길이가 가장 긴것부터 출력하시오.

select ename,email,length(email)
from emp12
order by length(email) desc;

■ Q-66.emp테이블에서 ename 을 출력하고 그 옆에 ename의 첫번째 철자를 출력하시오

select ename,substr(ename,1,1) 
from emp ;

■ Q-67.위의 결과를 다시 출력하는데 이름의 첫번째 철자로 출력되는 부분을 소문자로 출력
하시오 

select ename,substr(lower(ename),1,1)
from emp;
Or
select ename,lower(substr(ename,1,1))
from emp;

■ Q-68.아래의 결과를 initcap쓰지 말고 upper,lower,substr, || 사용해서 출력하시오.
    (        select initcap(ename)   from emp;  ) 

select upper(substr(ename,1,1))||lower(substr(ename,2,10))as "INITCAP(ENAME)"
from emp;
