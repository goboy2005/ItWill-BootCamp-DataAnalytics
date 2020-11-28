SQL Day 12 Problems 

   
■ Q-330.Emp 테이블에 서열을 SQL로 시각화 하시오! 

Select  rpad(' ',level*2) || ename as employee, level
 from emp
Start with ename='KING'
Connect by prior empno = mgr;



설명 : rpad(' ',level2) 은 공백(' ') 을 level*2 숫자만큼 채워놓겠다.
Level이 클수록 공백이 높아지겠지…? 그래서 서열을 눈에 띄게 딱 볼수있따.
Rpad는 공백을 채워넣겠다..이런거다….

■ Q-331.위의 결과에서 Blake 는 제외하고 출력하시오. 

Select  rpad('  ',level*2) ||  ename as employee, level
from emp
where ename != 'BLAKE'
Start with ename='KING'
Connect by prior empno = mgr;



Blake 의 팀원들만 남았고..Blake 는 없어졌다..이게  Blaek의 아래에 있는 직원들은 여전히 나오고있다



■ Q-332.위의 결과에서 BLAKE 뿐만 아니라 BLAKE의 팀원들까지 전부 제외하시오. 

Select  rpad('  ',level*2) ||  ename as employee, level
 from emp
    Start with ename='KING'
Connect by prior empno = mgr and ename !='BLAKE'



@설명: 하위노드의 모든 데이터를 출력되지 않게 하려면 where 절이 아니라 Connect by 절에 조건을 주면 됩니다. 
Connect by 절의 노드를 제거하겠다라는 뜻이다..지금 이노드는 
킹과 가까운 상위 노드이고 이노드 들은 하위 노드이다.! 
하위 노드인데 상위 노드를 제거함으로써 하위 노드가 전체가 안나오게 하는것이다.
특정한 절만 안나오게 하고 싶으면 where 절을 사용하면 되는데 노드를 제가하려며
Connect by  절에다 가 기술해주면된다. 

■ Q-333. 다시 BLAKE 와 BLAKE의 팀원들을 포함시킨 서열을 출력하는 SQL을 아래와 같이 실행하는데 월급이 높은 순서데로 출력하시오! 
 
Select  rpad('  ',level*2) ||  ename as employee, level,sal
 from emp
    Start with ename='KING'
Connect by prior empno = mgr 
Order by sal desc;
    


@지금 order by sal 순서대로 써주면서 empno 관련 서열이 다깨져버림.
위의 결는 월급이 높은 순서대로 정렬이 되면서 서열로 정렬된 결과가 사라져버렸다.@

원래는 서열로 정렬하기 위해서 서열로 정렬된 결과가 사라져버린것.. 

■ Q-334.위의 결과를 다시 서열로 정렬된 결과를 유지하면서 월급이 높은 순서데로 정렬되서 출력되게 하시오!   (SIBLINGS) 
 Select  rpad('  ',level*2) ||  ename as employee, sal
 from emp
    Start with ename='KING'
Connect by prior empno = mgr 
    
order siblings by sal desc;


설명: 결과를 보면 같은 서열내에서 월급이 높은 순서데로 정렬이 되고 있습니다.  계층형 질의문을 사용할때,  order by 절을 쓸때는 Siblings 라는 키워드를 짝꿍으로 사용해야 합니다. 

■ Q-335.이름과 입사일과 서열 순위를 출력하는데 먼저 입사한 서열 순위를 유지하면서 서열순위의 정렬 상태를 유지하면서 먼저 입사한 사원수로 정렬이 되어서 출력되게 하시오!  (KING이 1빠로 입사했다 가정함) 

select rpad(' ',level*2) || ename,hiredate,level
from emp
start with ename ='KING'
connect by prior empno = mgr
order siblings by hiredate asc;



 

■ Q-336. 위의 결과에서 앞의 / 를 아래와 같이 잘라버리시오

KING        KING
JONES      KING/JONES 

select ename,ltrim(sys_connect_by_path (ename,'/'),'/') as path
From emp
Start with ename='KING'
Connect by prior empno=mgr; 


■ Q-337.이름,서열,월급,급여등금(grade)을 출력하시오! 
     (*emp와 salgrade를 조인하시오) 

select rpad(' ',level*2)|| e.ename,level,e.sal,s.grade
from emp e, salgrade s
where e.sal between s.losal and s.hisal
start with ename='KING'
connect by prior empno=mgr;




■ Q-338.위의 결과를 다시 출력하는데 서열의 정렬을 유지하면서 
월급이 급여등급이 높은 사원부터 출력되게 하시오! 

select rpad(' ',level*2)|| e.ename as 서열도,level,e.sal,s.grade
from emp e, salgrade s
where e.sal between s.losal and s.hisal
start with ename='KING'
connect by prior empno=mgr
order siblings by sal desc;



■ Q-339.DALLAS에서 근무하는 사원들의 이름,서열,부서위치를 출력하시오! (서열은 전체 사원을 기준으로 서열을 부여하시오!) 

select rpad(' ',level*2)|| e.ename as 직원서열도,level,d.loc
from emp e, dept d 
where e.deptno=d.deptno and d.loc='DALLAS'
start with ename='KING'
connect by prior empno=mgr;


Create table의 테이블의 데이터를 입력하는 것은 아니고, 
구조와 데이터 타입등을 지정해주는것이다. 

	
343.emp 500테이블에 아래의 데이터를 입력하시오!
(1111 scott 3000
2222 smith 2900)

insert into emp 500(empno,ename,sal)
values(1111,'SCOTT',3000);

Insert into emp500(empno,ename,sal)
values(2222,'SMITH',2900);

344.아래의 테이블을 생성하는 이름을 500로 해서 생성하시오

Empno
Ename
Sal
Hiredate 
Deptno

Insert into emp500(empno,ename,sal)
Values(2222,'SMITH',2900);


345.아래의 emp501 테이블에 데이터를 2건 입력하시오!
Create table emp501 

사원번호 7839 , 이름 KING, SAL 5000, Hiredate : 81/11/17, deptno 10 
           
Inset into emp501(empno,ename,sal,hiredate,deptno)
 Values(7839,'KING',5000,to_date('81/11/17','RR/MM/DD'),10);

Insert into emp501(empno,ename,sal,hiredate,deptno)
Values(7968,'BLAKE',2850,to_date('81/05/01','RR/MM/DD'),30);

예제)
"Long 데이터 타입을 사용하는 방법 테스트"
'Long 데이터 타입은 아주 긴 텍스트 데이터를 입력할때 사용하는 데이터 유형입니다'

Create table profile2 
(ename varchar(20),
      self_intro long); 

insert into profile2 (ename,self_intro)
values('김인호','어렸을때 부터 우리집은 가난했었습니다.
                그리고 어머니는 짜장면이 싫다고 하셨습니다. 야히 야히야');
        

■ Q-346. 겨울왕국 대본을 입력하기 위한 테이블을 winter_kingdom 이라는 이름으로 생성하시오! 

create table winter_kingdom
(win_text varchar2(4000));


■ Q-347.영화 겨울왕국 대본에는 elsa 가 많이 나오는가?, anna가 많이 나오는가? 

select sum(regexp_count(lower(win_text),'elsa') ) as cnt
from winter_kingdom;

*정규식 함수인 regexp_count 를 이용하면 쉽게 구혈할 수 있습니다. 

설명: win_text 를 전부소문자로 변경하고 regexp_count 를 이용해서 스크립트 한행 한행을 다 살펴봐서 elsa라는 단어가 포함되어져 있으면 카운트 한다.  그리고 카운트된 숫자들을 다 sum함수를 이용해서 다 더한다. 


■ Q-349.긍정단어를 저장하기 위한 테이블을 Positive 라는 이름으로 아래와 같이 생성하시오

Create table Positive 
(p_text varchar2(2000));

■ Q-350.부정단어를 저장하기 위한 테이블을 negative 라는 이름으로 아래와 같이 생성하시오

Create table negative
( n_text varchar2(2000));

■ Q-351.긍정단어는 Positive 테이블에 넣고, 부정단어는 Negative 단어장에 넣어라
옆에 테이블창들어가서 데이터 임포트로 노트장을 넣으샘~~  
(헤더 체크 해제하고// 구분자 탭// 오른쪽 왼쪽  둘러싸기 없음) 으로 하고 

select count(*)
from positive;

 
select count(*)
from negative;


■ Q-352.엑셀 데이터를 오라클의 테이블의 데이터로 입력하시오! 
 (전국 대학교 등록금 현황 데이터를 저장할 테이블을 먼저 아래와 같이 생성하시오) 

카페에 가서 데이터 게시판에 가서 UNIV data 스크립트 붙혀용~~

create table univ
(division      varchar2 (20),
 type          varchar2(20 ),
 university    varchar2(50),
 campus_type   varchar2( 40),
 admission_fee  number( 20),
 college_fee    number( 20),
 supporting_fee number( 20),
 tuition       number(20 ) ) ;

이것을 만들고 이제 엑셀 데이터를 만든다!! 

■ Q-354.우리나라에서 대학등록금이 가장 비싼학교가 어디인가

select university,tuition,rank() over (order by tuition desc)
from univ;


■ Q-335.데이터 게시판에 범죄 발생 지역 데이터를 내려받아
테이블을 생성하고 데이터를 입력하시오! 

create  table  crime_loc
( CRIME_TYPE     varchar2(50),                ←  범죄유형
  C_LOC             varchar2(50),                        ←  범죄장소
  CNT              number(10) );                         ←  범죄건수

■ Q-336.범죄유형을 출력하는데 중복제거해서 출력하시오

select distinct crime_type 
from crime_loc;



■ Q-357.살인이 가장 많이 일어나는 장소가 어디입니까.

select *
         from crime_loc 
         where crime_type = '살인'                 
         order by cnt desc 
         fetch first 1 rows only; 



■ Q-358.절도가 가장 많이 일어나는 장소가 어디인지 1위부터 3위까지 출력하시오 

select *
from crime_loc
where crime_type = '절도'
order by cnt desc
fetch first 3 rows only;




■ Q-360.살인을 일으키는 가장 큰 원인은 무엇인가 ? 

데이터 ----컬럼 : Pivot 문
컬럼   ---- 데이터 : Unpivot 문 

위의 질문에 대한 답을 구하려면 컬럼을 데이터로 넣어야 가능하다.
아래의 SQL은 as다음에 나오는 쿼리문의 결과를 Crime_Cause2로 들어가서 

그것을 쉽게 만들기위해 

Select * from crime_cause2
Where crime_type = '살인'
Order by cnt desc
Fetch first 1 rows only;
