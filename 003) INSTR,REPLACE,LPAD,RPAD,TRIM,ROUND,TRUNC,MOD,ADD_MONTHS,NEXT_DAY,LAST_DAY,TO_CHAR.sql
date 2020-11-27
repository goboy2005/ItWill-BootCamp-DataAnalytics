Day 3 Problems 

■ Q-69.사원 테이블에서 이름을 출력하고 그 옆에 이름의 끝철자를 출력하는데 끝 철자를 소문자로 출력하시오

select ename,lower(substr(ename,-1,1))
   from emp12;

■ Q-71.사원 테이블에서 이름 월급을 출력하는데, 월급을 출력할때 숫자 0을 *로 출력하시오 

                          select ename,replace(sal,0,'*')
   from emp;

■ Q-72.우리반 테이블에서 이름을 출력하고 그옆에 이름에 두번째 철자를 출력하시오! 

select substr(ename,2,1)
   from emp12;

■ Q-73.아산병원의 전광판을 구현하시오! (유*수,성*창)

select ename,replace(ename,substr(ename,2,1),'*')
   from emp12;

■ Q-74.남궁솔미 데이터를 입하고 남궁*미로 출력되게 위의 SQL을 다시 작성하시오 (73연결)

select ename,replace(ename,substr(ename,-2,1),'*')
   from emp12;

■ Q-75.경기도에 사는 학생들의 이름과 주소를 출력하시오! 와일드 카드를 양쪽에 사용하지 
말고 한쪽에만 사용해서 출력하시오. 

select ename,address
  from emp12
      where ltrim(address) like '경기도%';

■ Q-76.정보통계학과가 전공인 학생의 이름과 나이와 전공을 출력하시오. 

select ename,age,major
  from emp12
     where trim(major) like '%정보통계학과%';

■ Q-77.우리반 나이의 평균값을 출력하시오. avg(age)

select avg(age)
  from emp12;

■ Q-78.위의 결과를 반올림해서 소수점 이후는 안나오게 하시오.
select round(avg(age),0)  / or just close it with ")"   
   from emp12;

■ Q-78.우리반에서 나이가 짝수인 학생들의 이름과 나이를 출력하시오 

select ename,age,mod(age,2) 
  from emp12
     where mod(age,2)=0;

■ Q-80.select ename,sysdate-hiredate from emp; 이결과에서 소수점 이하는 안나오게
 반올림하시오.

select ename,round(sysdate-hiredate,0)
   from emp:

■ Q-81.이름,입사한 날짜부터 오늘까지 총 몇주 근무했는지 출력하시오 

select ename,round(round(sysdate-hiredate,0)/7,0)
   from emp;

■ Q-82.이름,입사한 날짜부터 오늘까지 총 몇 달 무했는지 출력하시오 

select ename, round(months_between(sysdate,hiredate))
  from emp;

■ Q-83. King은 467달을 근무했습니다를 출력하시오! 

select ename||'은'||round(months_between(sysdate,hiredate))||'달을 근무했습니다'
  from emp;

■ Q-84.오늘 날짜에서 100달 뒤에 돌아오는 목요일의 날짜를 출력하시오. 

select next_day(add_months(sysdate,100),'목요일')
   from dual;

■ Q-85.81/11/17 일에 입사한 사원의 이름과 입사일을 출력하시오 .

select ename,hiredate
   from emp
     where hiredate='81/11/17';

■ Q-86.이름,입사일,입사한 요일을 출력하시오! 

select ename,hiredate,to_char(hiredate,'day')
   from emp;

(It will appear as Monday because you used 'day')                                       
                                       
■ Q-87.수요일에 입사한 사원들의 이름과 입사일을 출력하시오.

select ename,hiredate,to_char(hiredate,'day')
  from emp
     where to_char(hiredate,'day') = 'Monday'

■ Q-88.내가 무슨 요일에 태어났는지 확인하시오. 
(to_date 로변환해서 'RR/MM/DD' 형식만들기)    

select to_char(to_date('92/01/14','RR/MM/DD'),'day')
    from dual;

■ Q-89.카페에 답글로 올리세요~
이름,입사한 요일을 출력하는데 
입사한 요일이 일월화수목금토 순으로 

■ Q-90.마지막문제 이메일을 출력하고 그 옆에 이메일의 도메인을 출력하시오. ex) gmail,naver 

select substr(email,instr(email,'@')+1, instr(email,'.'))
     from emp12; 
