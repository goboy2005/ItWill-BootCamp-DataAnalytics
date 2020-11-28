

■ Q-366.구구단 문제를 풀기위한 from 절의 서브쿼리문의 결과를 임시테이블로 각각 생성하시오! 

create global temporary table num1_9
(num1 nubmer(10))
on commit preserve rows;

insert into num1_9
(select level
  from dual 
     conncect by level <=9);
     
     select * from num1_9;

create global temporary table num2_9
(num2 nubmer(10))
on commit preserve rows;

insert into num2_9
(select level
  from dual 
     conncect by level <=9);
     
     select * from num2_9;


select a.num1,b.num2
from num1_9 a , num2_9 b


emp 테이블과는 별개의 또 다른 테이블이다.. 
*emp로 시작하는 내가 만든 테이블들이 뭐가있는지 확인하는 방법, 오직 emp로만 만들어진것만.. 방금만든 70
Select table_name
from user_tables
where table_name like 'EMP%';




■ Q-369.Dalls 에서 근무하는 사원들의 이름과 부서위치를  출력하시오! (조인)

select e.ename,d.loc
from ename e, dept d
where e.detpno=e.depno and d.loc='DALLAS';

■ Q-370.위의 결과 데이터를 담는 테이블 emp710 을 생성하시오! 
create table emp710
as                                                     
select e.ename,d.loc 
from ename e, dept d
where e.detpno=e.depno and d.loc='DALLAS';

■ Q-371.숫자1번부터 10번까지의 숫자를 담는 테이블을 emp705로 생성하시오! 
create table emp705
as
select level as num1
from dual
connect by level<=10;

■ Q-372.emp705의  숫자 데이터중에 임의로 아무거나 하나를 지우시오.

delete from emp705
where num1=4;


■ Q-374.직업,직업별 토탈월급을 출력하시오(세로 출력) 
select ename,sum(sal)
from emp
group by job;

■ Q-375.위의 결과를 출력하는 VIEW를 생성하시오! (VIEW 이름은 emp403) 

create view emp403
as
select job,sum(sal)                                                  as 궁부이                      ----- 이래야 생성 
from emp
group by job;



설명: view 생성할때 그룹함수를 사용하게 되면 컬럼별칭을 줘야합니다.!! 

■ Q-376.부서번호, (부서번호별 평균월급)을 출력하는 VIEW를 deptno_avg라는 이름으로 생성하시오! 

create view deptno_avg
as
select deptno,avg(sal) as 평균
from emp
group by deptno;

■ Q-377.emp와 지금 만든 deptno_avg view 와 조인해서 
이름,월급,부서번호,부서월급 평균 

select e.ename,e.sal,e.deptno,v.평균
from emp e, deptno_avg v
where e.deptno=v.deptno;

*뷰의 장점? 1 .민감한 컬럼을 감춰서 데이터를 제공할 수 있다.
                2. 복잡한 쿼리문을 단순하게 만들 수 있다. 
                
■ Q-378.이름,월급,부서번호,부서평균월급을 출력하는데 월급이 부서 평균보다 더 큰 사원들만 출력하시오

select e.ename,e.sal,e.deptno,v.부서평균월급
from emp e, deptno_avg v
where e.deptno=v.deptno and e.sal > v.부서평균월급

■ Q-379.emp 테이블에서 퇴사할것 같은 사원들을 예측하기 위해 자기의 월급이 자기가 속한 직업의
평균 월급보다 더작은 사원들의 이름과 월급과 직업평균을 출력하시오! 

(view 테이블 만들고) 

create view job_avg
as
select job,avg(sal) as 직업평균
from emp
group by job;

select*from job_avg;               -확인하고-

select e.ename,e.sal,e.job,v.직업평균
from emp e, job_avg v 
where e.job = v.job and e.sal < v.직업평균 ;

■ Q-380.직업,이름,월급,순위를 출력하는데 순위가 직업별로 각각 월급이 높은 순서대로 순위를 부여하시오! 

select ename,job,sal,dense_rank() over (partition by job order by sal desc) from emp;

위의 쿼리의 결과를 view 로 만들고 view 를 쿼리해서 순위가 1등인 사원들만 출력하시오

create view tabel WF 
as
select rank() over (partition by job order by sal desc) as 부서변월급순위 from emp;

select * 부서변월급순위 from WF;


■ Q-382.이름과 부서위치를 출력하는 VIEW를 ename_loc 라는 이름으로 생성하시오

create view ename_loc
as
select e.ename,d.loc
from ename e , dept d 
where e.deptno=d.deptno;

이건 테이블을 두개 사용해서 만들었으니 복합 뷰이다.!! 

select * from ename_loc

■ Q-383.ename_loc 의 데이터 중에 SCOTT 의 부서위치를 WASHINGTON  철자로 바꾸시오.! 

update ename_loc
set loc='washington'
where ename='SCOTT'
이거 안된다… dept 테이블에서 변경이 안되유…


(테이블 구조와 원칙상 update 안되고 해서는 안되는 것들.)

■ Q-384.문제375번에서 만든 emp403 view를 쿼리하고 결과를 보시오

create view emp403
as
select job,sum(sal) as 토탈
from emp
group by job;

select * from emp403;

update emp403
set 토탈 =2000 
where job='SALESMAN' 


■ Q-385.그동안 내가 만들 view들이 뭐가 들어있는지 확인하시오!

select view_name
   from user_views;

select view_name,text
from user_views;
text 넣었다 뻇다..이거하면 만든 Select 문장이 나오면서 만든 테이블이 무엇인지 테이블명도 볼수 있다요…
위와같이 조회하면 view를 만들었을때 사용한 테이블명도 볼 수 있습니다. 외부에서 온 데이터 분석가들은
위의 쿼리를 조회할수 있는 권한을 제한하는 경우가 많습니다. 



■ Q-385.사원 테이블에 월급에 인덱스를 거시오!

create index emp_sal -------인덱스 이름 내맘대로 저장,,, 의미있게      
  on emp(sal) ;   

■ Q-386.emp 테이블의 sal의 인덱스인 emp_sal의 구조를 확인하시오

select sal,rowid
 from emp
   where sal>0;



인덱스에서 데이터를 읽어왔기 떄문에 order by 절을 사용 안했는데 월급이 정렬이 되어서 출력되었습니다. 
