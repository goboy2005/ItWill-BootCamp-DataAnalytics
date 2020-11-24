■ 031 날짜형으로 데이터 유형 변환하기(TO_DATE)

변환함수 : to_date 함수 to_date('81/11/17','RR/MM/DD');

"날짜로 형 변환하는 함수"
예제 : select ename,hiredate
         from emp
      where hiredate = '81/11/17'; 
이게 나오는 이유는 날짜형식이 딱 맞아서! 

Where 문 사용시 날짜형 = 날짜형 date = date 
                       숫자형 = 숫자형 (sal = 3000)

to_date사용해서 애는 확실히 날짜다 라고 정의해주면 더 편하당. 
설명: 날짜형 데이터를 검색할 때는 
반드시 to_date 함수를 사용하세요 ^^ 

변환함수 : 숫자로 형 변환하는 함수 
월급이 3000인 사원의 이름과 월급을 출력하시오!
select ename,sal
  from emp
     where sal = 3000 

문자형 : Varchar2
숫자형 : number
날짜형 : date

select ename,sal
from emp
where sal ='3000';
sal 은 숫자이고 '3000'은 문자라서 원래는 error가 나지만 oralce 에서는 내부적으로 문자형을 숫자형으로 변화시켜준다. 
(대신 검색느려짐, 숫자 는 숫자비교/ 날짜는 날짜비교/ 문자는 문자비교가 좋다) 

변환함수 : 1. to_char : 문자로 형 변환하는 함수 
              2. to_number : 숫자로 형변환하는 함수
              3.to_date : 날짜로 형 변환하는 함수 
                                                                                                             
설명 : where 절에 검색조건을 적을 때 주의할 사항은 문자 컬럼의 데이터를 검색할 때는 문자로 검색하고 숫자 컬럼의 데이터를 검색할 때는 숫자로 검색해야 한다. 
만약에 문자형인데 숫자형으로 검색하거나 숫자형인데 문자형으로 검색하면
오라클은 에러는 안나지만 검색성능이 느려지게 됩니다. 
그러므로 반드시 검색조건을 적을때 위의 사항을 지켜줘야 합니다. 


■ 033 NULL 값 대신 다른 데이터 출력하기(NVL, NVL2)

1.nvl 함수
2.decode 함수 
3.case 함수 

nvl 함수 : null 값 대신에 다른값을 출력하고 싶을 때 사용하는 함수 
null 값 : 데이터가 없는 상태 또는 알 수 없는 값  

예제)
이름,월급,커미션,월급+커미션을 출력하시오.
select ename,sal,comm,nvl(comm,0)+sal as 총받을돈
from emp;
실제 data가 바뀐것이 아니라 출력되는 곳만 0으로 바뀐 것이다. 
설명: nvl 함수로 다른값으로 대체해서 출력하는 것이지 실제로 테이블의 데이터가 0으로 변경된것은 아니다. 

■ 034 IF문을 SQL로 구현하기 1(DECODE)

If 문을 SQL로 구현할 때 사용할때 함수
만약에 무슨일이 벌어지면 어떻게 행동해라 라고 컴퓨터 프로그래밍을 하는것인데 
예제: select ename,sal,job,
        decode(deptno,10,5600,
                             20,4500,        
                              0) as 보너스 
from emp ; 

  부서번호가 10번이면 5600을 출력하고
  부서번호가 20번이면 4500을 출력하고                             
  나머지 부서번호는 0을 출력해라 ~~

■ 035 IF문을 SQL로 구현하기 2(CASE)

@중요설명 decode는 등호 (=) 비교만 가능하기 때문에 만약에 부등호 비교를 하려면 
               case 문을 사용해야 한다. Case 문은 등호비교와 부등호 비교 둘다 가능합니다.

select ename,sal,deptno, case when deptno = 10 then 500
                              when deptno = 20 then 300
                              else 0 end as 보너스

■ 036 최대값 출력하기(MAX) &  037 최소값 출력하기(MIN)

select max(sal)
from emp; 
*최대 월급을 출력하시오 ! 
select min(sal)
from emp

■ 038 평균값 출력하기(AVG)

select deptno, max(sal) ,한개만 출력하려고 하기때문에 
        여러 개 나오려함 

where group by deptno;
group by 절이 여러 개 나오려하는 deptno 를 grouping 해준다. 
group by deptno; 


90.직업이 SALESMAN 인 사원들의 이름과 월급과 직업을 출력하는데 월급이 높은 사원부터 출력하시오

select ename,job,sal
from emp
where job = 'SALESMAN'
order by sal desc;

91.직업이 SALESMAN 이 아닌 사원들의 이름과 입사일과 직업을 출력하는데 최근에 입사한 사원부터 출력하시오 

select ename,job,hiredate
from emp
where job not in ('SALESMAN')
order by hiredate desc;

92.월급이 1000에서 3000사이인 사원들의 이름과 월급을 출력하시오.

select ename,sal
from emp
where sal between 1000 and 3000;

93.이름을 출력하고 그 옆에 이름의 첫번째 철자만 출력하는데
소문자로 출력하시오

select ename,lower(substr(ename,1,1))
from emp;

94.우리반 테이블에서 이름과 이메일을 출력하고 그 옆에 이메일에서 @가 몇번째 철자인지 출력하시오.

select ename,email,instr(email,'@')
from emp12;

95.이름과 입사일,입사한 년도를 4자리로 출력하시오 

select ename,hiredate, to_char(hiredate,'RRRR') 
from emp;

96.11월에 입사한 사원들의 이름과 입사일을 출력하시오.

select ename,hiredate,to_char(hiredate,'MM')
from emp
where to_char(hiredate,'MM')=11; 

97.96번을 to_char 사용하지 말고 substr 로 수행하시오

select ename,hiredate
from emp
where substr(hiredate,4,2) like '11';

98.1981년도에 입사한 사원들의 이름과 입사일을 출력하시오 . 

to_char 사용
select ename,hiredate
from emp
where to_char(hiredate,'RRRR') = '1981' ;
or
to_date 사용 
select ename
from emp
where hiredate between to_date('81/01/01','RR/MM/DD') and to_date('81/12/31','RR/MM/DD');

99.1981년도에 입사한 사원들 이름과 입사한 년도를 출력하는데
최근에 입사한 사원부터 출력하시오. 

select ename,hiredate
from emp
where hiredate between to_date('81/01/01','RR/MM/DD') and to_date('81/12/31','RR/MM/DD')
order by hiredate desc;

100.이름,커미션을 출력하시오

select ename,comm
from emp;

101.이름 커미션을 출력하는데 커미션이 null인 사원들은 no comm이라는 글씨로 출력하시오. 
select ename,nvl(comm,'no comm')
from emp;
에러가 난다. 이유는 comm은 숫자형이고 'no comm'은 문자형 이기때문이다. 
설명 : 숫자형을 문자형으로 변환해서 데이터 타입을 서로 동일하게 맞춰주고 출력하면 된다. 

select ename,nvl(to_char(comm),'no comm')
from emp;

102.커미션이 null 인 사원의 이름과 커미션을 출력하시오! is null 사용 x
(자료에 0이 있어서 0은 못쓰고 -1로 대체하기 개능) 

select ename,comm
from emp
where nvl(comm,-1) = -1;

103.이름,월급,직업,보너스를 출력하는데 보너스가 직업이 SALESMAN 이면 4500을 출력하고 직업이 ANALYST 면 2400을 출력하고
나머지 직업을 0 출력하시오. 

select ename,sal,job,
decode(job,'SALESMAN',4500,
                        'ANALYST',2400,
                        0) as 보너스 
                            from emp;

104.이름,입사한 년도 4자리로 출력하시오 

select ename,hiredate,to_char(hiredate,'RRRR')
form emp;

105.이름, 입사한 년도, 보너스를  출력하는데 보너스가
입사한 1980년이면 5000을 출력하고 1981년이면 4000을 출력하고 나머지 년도는 0으로 출력하시오 

select ename,hiredate,to_date(hiredate,'RRRR'),
                 decode(to_date(hiredate,'RRRR'),'1981',5000,
                                                  '1980',4000,
                                                     0) as 보너스 
                                                        from emp;

106.이름,월급,보너스를 출력하는데 보너스를 월급이 4000이상이면 500출력 
                                        월급이 2000이상이면 300 출력
                                    하고 나머지 월급사원들은 0을 출력하시오  

select ename,sal,case when sal >= 4000 then 500
                             when sal>= 2000 then 300 
                              else 0 end as 보너스 
                                    from emp;

107.이름,월급,부서번호,보너스를 출력하는데 보너스가 부서번호가 10번이면
500을 출력하고 부서번호가 20번이면 300을 출력하고 나머지 부서번호면 0을 출력하시오.

select ename,sal,deptno, case when deptno = 10 then 500
                               when deptno = 20 then 300
                                 else 0 end as 보너스
                                      from emp;

108.우리반 테이블에서 이름을 출력하고 그 옆에 보너스를 출력하는데 이름의 철자가 3글자이면 보너스를 7000을 출력하고, 이름의 철자가 2글자이면 보너스를 5000을 출력
이름의 철자가 4글자이면 보너스를 4000을 출력!        

select ename,case when length(ename)=4 then 4000
                 when length(ename)=3 then 7000
                  when length(ename)=2 then 5000
                                    end as 보너스
                                          from emp12;

109.이름 세글자로만 이름의 가운데 글자를 * 로 출력하시오 

a)이름의 철자의 갯수가 3글자와 2글자는 아래의 SQL로 수행
select ename,replace(ename,substr(ename,2,1),'*')
from emp12;
b)이름의 철자의 갯수가 4글자이면
select replace(ename,substr(ename,-2,1),'*')
from emp12;

110.우리반 테이블의 이름의 철자의 갯수와 관계없이 일괄적으로 이름이 *이 아래와 같이 출력되게 하시오 ! 

select ename,case when length(ename)=4 then replace(substr(ename,-2,1),'*')
                   when length(ename)=3 then replace(substr(ename,-2,1),'*')
                   when length(ename)=2 then replace(substr(ename,-1,1),'*') 
                                     end as 전광판 
                                         from emp12;

111.emp(사원)테이블에서 이름을 출력하고 입사한 요일을 출력하는데
             입사한 요일이 월화수목금토일 순으로 출력하시오
             
select ename,to_char(hiredate,'day')
    from emp
       order by replace(to_char(hiredate,'d'),1,8) asc;

112.직업이 SALESMAN인 사원들의 최대 월급을 출력하시오 

select max(sal)
from emp
where job='SALESMAN';

113.우리반에서 최소 나이인 학생의 나이를 출력하시오.

select min(age)
from emp12;

114.통신사가 sk인 학생들 중에서 최대 나이인 학생의 나이를 출력하시오 

select max(age)
from emp12
where telecom like '%sk%';

115.30 번 부서번호의 최대월급을 출력하시오

select max(sal)
from emp
where deptno=30;

116.(오늘의 마지막 문제) 직업,직업별 최대월급을 출력하는데 직업이 SALESMAN 만 출력하시오 

select job,max(sal)
from emp
where job='SALESMAN'
group by job;

