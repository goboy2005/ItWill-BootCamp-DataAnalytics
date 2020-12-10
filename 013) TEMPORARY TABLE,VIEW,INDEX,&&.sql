SQL Day 13 Problems 

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

■ Q-369.Dalls 에서 근무하는 사원들의 이름과 부서위치를  출력하시오! (조인)

select e.ename,d.loc
  from ename e, dept d
    where e.detpno=e.depno and d.loc='DALLAS';

■ Q-370.위의 결과 데이터를 담는 테이블 emp710 을 생성하시오! 

create table emp710 as                                                     
 select e.ename,d.loc 
  from ename e, dept d
    where e.detpno=e.depno and d.loc='DALLAS';

■ Q-371.숫자1번부터 10번까지의 숫자를 담는 테이블을 emp705로 생성하시오! 

create table emp705 as
 select level as num1
   from dual
     connect by level<=10;

■ Q-372.emp705의 숫자 데이터중에 임의로 아무거나 하나를 지우시오.

delete from emp705
where num1=4;

■ Q-374.직업,직업별 토탈월급을 출력하시오(세로 출력) 

select ename,sum(sal)
  from emp
    group by job;

■ Q-375.위의 결과를 출력하는 VIEW를 생성하시오! (VIEW 이름은 emp403) 

create view emp403 as
select job,sum(sal) as Total
 from emp
   group by job;

(in order to make a view table with group you must make a name for it)

■ Q-376.부서번호, (부서번호별 평균월급)을 출력하는 VIEW를 deptno_avg라는 이름으로 생성하시오! 

create view deptno_avg as
select deptno,avg(sal) as 평균
 from emp 
    group by deptno;

■ Q-377.emp와 지금 만든 deptno_avg view 와 조인해서 
이름,월급,부서번호,부서월급 평균 

select e.ename,e.sal,e.deptno,v.평균
 from emp e, deptno_avg v
    where e.deptno=v.deptno;

*Benefit of the view table 1 .민감한 컬럼을 감춰서 데이터를 제공할 수 있다.
                           2. 복잡한 쿼리문을 단순하게 만들 수 있다. 
                
■ Q-378.이름,월급,부서번호,부서평균월급을 출력하는데 월급이 부서 평균보다 더 큰 사원들만 출력하시오

select e.ename,e.sal,e.deptno,v.부서평균월급
 from emp e, deptno_avg v
   where e.deptno=v.deptno and e.sal > v.부서평균월급

■ Q-379.emp 테이블에서 퇴사할것 같은 사원들을 예측하기 위해 자기의 월급이 자기가 속한 직업의
평균 월급보다 더작은 사원들의 이름과 월급과 직업평균을 출력하시오! 

(First make a view table) 

create view job_avg as
 select job,avg(sal) as 직업평균
  from emp
    group by job;

select*from job_avg;               → check whether the table is made 

select e.ename,e.sal,e.job,v.직업평균
  from emp e, job_avg v 
      where e.job = v.job and e.sal < v.직업평균 ;

■ Q-380.직업,이름,월급,순위를 출력하는데 순위가 직업별로 각각 월급이 높은 순서대로 순위를 부여하시오! 

select ename,job,sal,dense_rank() over (partition by job order by sal desc) from emp;

위의 쿼리의 결과를 view 로 만들고 view 를 쿼리해서 순위가 1등인 사원들만 출력하시오

create view tabel as WF
select rank() over (partition by job order by sal desc) as rank
    from emp;

select * rank from WF;

■ Q-382.이름과 부서위치를 출력하는 VIEW를 ename_loc 라는 이름으로 생성하시오

create view ename_loc as
select e.ename,d.loc
  from ename e , dept d 
     where e.deptno=d.deptno;

(This used two tables so it is a double view) 

select * from ename_loc

■ Q-383.ename_loc 의 데이터 중에 SCOTT 의 부서위치를 WASHINGTON  철자로 바꾸시오.! 

update ename_loc
set loc='washington'
where ename='SCOTT'

※ An error occurs 

(테이블 구조와 원칙상 update 안되고 해서는 안되는 것들.)

■ Q-384.문제375번에서 만든 emp403 view를 쿼리하고 결과를 보시오

create view emp403 as
select job,sum(sal) as 토탈
  from emp
     group by job;

select * from emp403 ;

update emp403
 set 토탈 =2000 
   where job='SALESMAN' 


■ Q-385.그동안 내가 만들 view들이 뭐가 들어있는지 확인하시오!

select view_name
   from user_views;

 &

 select view_name,text
    from user_views;

(If you put text in you can see the original table that was used to make the view table
By restricting the acesss of this, data analyst from outside can only see the admitted range of data.)

■ Q-385.사원 테이블에 월급에 인덱스를 거시오!

create index emp_sal -------make a name of an index    
  on emp(sal) ;   

■ Q-386.emp 테이블의 sal의 인덱스인 emp_sal의 구조를 확인하시오

select sal,rowid
 from emp
   where sal>0;

(Because it reads from the index, it automatically reads as order) 
