*비교연산자 
>,<,<=,>=,!=,<>,

*기타 비교연산자 4가지 
1.between …and 
2.like
3.is null
4.in  

013 비교 연산자 배우기 4 (IS NULL)

null 값을 조회할때 사용하는 연산자가  is null 이다. 
null 값은 데이터가 없는 상태 또는 알 수없는 값 ( Unknown ) 입니다. 
설명 : null은 알수 없기 때문에 비교연산자 (=) 로 알수 없기에 대신 is null을 사용해준다. 
Not 가능 

예제 : 이름과 월급 커미션을 출력하시오 
여기서 null 이뜨는 사람들은 커미션 책정이 안된사람들이다. 
@설명:사장 (President) 은 관리자의 번호 (mgr) 가 없다. (자기가 사장 이니까)

014 비교 연산자 배우기 5 (IN)

Where절의 검색조건에서 여러개의 행을 비교할 때는 in을 사용해야 합니다. 
예제: 사원번호가7788,7902인 사원들의 사원번호와 이름을 조회하시오! 
Select empno,ename
From emp
Where empno = x /하지만  in 을 사용해주면 여러 개 비교 가능, 대신 () 쳐줘야한다. 

@포함하고 또한 like를 사용하며, '%통계%'
설명: like연산자를 사용할 때 특정 단어를 포함하고 있는 데이터를 
검색하려면 '%단어%' 라고 하면 됩니다.

015 논리 연산자 배우기 (AND, OR, NOT)

오라클 연산자의 종류3가지

1.산술연산자: */+-
2.비교연산자 : <,>,<=,>=,!=,<>,^=
  기타 비교연산자 : between…and
                         like
                         is null
                         in 
3.논리 연산자: and, or , not 

예제)
직업이 SALESMAN 이고 월급이 1200이상인 사원들의 이름과 월급과 
직업을 출력하시오
Select ename,sal,job
From emp
Where job='SALESMAN' and sal>=1200;  
                  True                    True 

True and true 이면 True 이기 때문에 출력이된다.
False and true 이면 False 이기 때문에 출력이안된다

하지만!
False or True 이면 True 이기 때문에 출력이 된다. (or 는 하나만 True 여도 True 이다) 


016 대소문자 변환 함수 배우기 (UPPER, LOWER, INITCAP)

함수 (function)? 어떤 특정 기능을 구현해 높은 코드의 집합. 
입력값---함수---출력값 (언제나 출력이  나온다)

함수를 사용하는 이유? 함수를 이용하면 좀 더 복잡한 데이터 검색을 할 수 있다.
예: 영화 겨울 왕국에는 elsa가 많이 나올까 anna가 많이 나올까? 

예제)
select upper(ename),lower(ename),initcap(ename)
From emp;



017 문자에서 특정 철자 추출하기 (SUBSTR)

문법: select ename,substr(ename,1,1)
예제)
성씨가 이씨인 학생들의 이름을 출력하시오!
like 쓰지말고 in 과 substr 을 써서 출력하시오 

@select 라인에 들어간 Susbstr(ename,1,1) 은 짤라서 보여주기만 한다. 
(select substr(ename,1,1) from emp12;)

where 라인에 substr 써서 짤라내고 in ,= 사용해서 검색한다. 
where substr(ename,1,1) = '이';

	
018 문자열의 길이를 출력하기 (LENGTH)
	
문법 : Length(ename) 
             
select length(ename) from emp;
                                                            숫자형태로 나온다


37.이름 첫번째 철자가 A로 시작하는 사원들의 이름과 월급을 출력하시오

select ename,sal
from emp
where ename like 'A%';

38.이름이 SCOTT인 사원의 이름과 월급과 직업을 출력하시오

select ename,sal,job
from emp
where ename='SCOTT';

39.이름의 끝에서 두번째 철자가 T인 사원들의 이름과 월급을 출력하시오

select ename,sal
from emp
where ename like '%T_';

40.커미션이 null 인 사원들의 이름과 커미션을 출력하시오

select ename,comm
from emp
where comm is null;

41.커미션이 null이 아닌 사원들의 이름과 커미션을 출력하시오 

select ename,comm
from emp
where comm is not null;

42.관리자의 사원번호 (mgr) 이 null 인 사원들의 이름과 직업을 출력하시오 

select ename,job,mgr
from emp
where mgr is null;
설명:사장 (President) 은 관리자가 번호 (mgr) 가 없다. (자기가 짱이니까)

43.사원번호,이름,관리자의 번호 (mgr)을 출력하시오 

select ename,mgr
from emp;

44.직업이 SALESMAN,ANALYST 인 사원들의 이름과 직업을 출력하시오

select ename,job
from emp
where job in ('SALESMAN','ANALYST');

45.직업이 SALESMAN,ANALYST 가 아닌 사원들의 이름과 직업을 출력하시오!

select ename,job
from emp
where job not in ('SALESMAN','ANALYST');

46.직업이 SALESMAN 이 아닌 사원들의 이름과 월급과 직업을 출력하시오 !

select ename,sal,job
from emp
where job!='SALESMAN';

47.위의 결과를 다시 출력하는데 월급이 높은 사원부터 출력하시오 (46연결)

select ename,job,sal
from emp
where job!='SALESMAN'
order by 3 desc,1 asc;

48.우리반 테이블에서 이름과 나이를 출력하는데 나이가 높은 학생부터 출력하시오

select ename,age
from emp12
order by age desc;

49.이름과 나이와 주소를 출력하는데 30살 이상인 학생들만 출력하시오

select ename,age,address
from emp12
where age>=30;

50.성씨가 김씨인 학생들의 이름과 통신사를 출력하시오

select ename,telecom
from emp12
where ename like '김%';

51.전공에 통계를 포함하고 있는 학생들의 이름과 전공을 출력하시오

select ename,major
from emp12
where major like '%통계%';

52.우리반에gmail을 사용하는(포함과 같음) 학생들의 이름과 메일을 출력하시오 

select ename,email
from emp12
where email like '%gmail%';

53.나이가 27에서 34사이인 학생들의 이름과 나이를 출력하시오

select ename,age
from emp12
where age between 27 and 34

54.나이가 27에서 34사이가 아닌 학생들의 이름과 나이를 출력하시오

select ename,age
from emp12
where age not between 27 and 34;

55.주소가 경기도인 학생들의 이름과 나이와 주소를 출력하시오

select ename,age,address
from emp12
where address like '%경기도%'

56.통신사가 sk,lg인 학생들의 이름과 통신사를 출력하시오

select ename,telecom
from emp12
where telecom in ('sk','lg');

57.서울에서 사는 학생들의 이름과 나이와 전공을 출력하시오, 나이가 높은 학생부터 출력.

select ename,age,major
from emp12
where address like '%서울%'
order by age desc;

58.이메일이gmail이 아닌 학생들의 이름과 email을 출력하시오. 

select ename,email
from emp12
where email not like '%gmail%';

59.아래와 같이 결과가 출력되게 하시오
김주원 학생의 나이는 44 입니다. 
(ename '학생의 나이는' age '입니다')

select ename||'학생의 나이는'||age||'입니다.' "
from emp12

60.직업이 SALESMAN 이거나 ANALYST인 사원들의 이름과 월급,직업을 출력하시오 (2개 방법 존재)  

select ename,sal,job
from emp
where job='ANALYST' or job='SALESMAN';
or
select ename,sal,job
from emp
where job in ('SALESMAN','ANALYST');

61.성씨가 김씨,이씨가 아닌 학생들의 이름을 출력하시오. 

select ename
from emp12
where ename not like '김%' and ename not like '이%'

62.이메일 gmail 과 naver 가 아닌 학생들의 이름과 이메일을 출력하시오 

select ename,email
from emp12
where email not like '%gmail%' and email not like '%naver%';

63.우리반 테이블에서 통신사가 sk 와 관련된 통신사 이면 그 학생의 이름과 통신사를 출력하시오. 정확하게 데이터가 출력이 되어지겠금, SQL을 작성하세요. (대문자 통합으로,소문자 통합으로 , 앞대문자, 뒤는 소문자 통합) 

select ename,telecom
from emp12
where upper(telecom) like '%SK%';
(핵심 : Where upper(telecom) :  (telecom 데이터를 전부 대문자로 변경한해 버리기) 

64.김,이,유 씨인 학생들의 이름과 나이를 출력하는데 like 쓰지 말고 in과 substr 써서 추출력하시오.  
select ename,age
from emp12
where substr(ename,1,1) in ('김','이','유');

65.우리반 테이블에서 이메일과 이메일의 철자에 길이를 출력하는데 이메일 철자의 길이가 가장 긴것부터 출력하시오.
select ename,email,length(email)
from emp12
order by length(email) desc;

66.emp테이블에서 ename 을 출력하고 그 옆에 ename의 첫번째 철자를 출력하시오
select ename,substr(ename,1,1) 
from emp ;

67.위의 결과를 다시 출력하는데 이름의 첫번째 철자로 출력되는 부분을 소문자로 출력 하시오 

select ename,substr(lower(ename),1,1)
from emp;
Or
select ename,lower(substr(ename,1,1))
from emp;

68.아래의 결과를 initcap쓰지 말고 upper,lower,substr, || 사용해서 출력하시오.

(select initcap(ename)   from emp;  ) 
select upper(substr(ename,1,1))||lower(substr(ename,2,10))as "INITCAP(ENAME)"
from emp;
