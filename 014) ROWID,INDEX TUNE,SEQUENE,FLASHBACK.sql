SQL Day14 Problems 

■ Q-389.사원 테이블에 월급 인덱스를 생성하고 사원 테이블을 검색하는데 
월급이 3000인 사원들의 이름과 월급을 검색하시오

create index emp_sal
on emp(sal);

select rowid,sal,ename
from emp
where sal=3000;

■ Q-390.위의 SQL의 실행 계획을 확인하시오! ----SQL은 실행하기 위해서 계획을 세우고 SQL을 실행한다. 

explain plan for
select ename,sal
from emp
where sal>3000;

select* from table (dbms_xplan.display);

(이것도 가능하지만 F10눌러서 확인도 가능하다) 

■ Q-391.위의 SQL이 emp_sal의 인덱스를 통해서 데이터를 검색할수 있도록 힌트를줘라.

explain plan for
select/*+ index(emp emp_sal)*/ ename sal
from emp
where sal=3000;

select* from table(dbms_xplan.display);


■ Q-392.입사일에 index 를 생성하고 81년 11월17일에 입사한 사원의 이름과 입사일을 조회하시오

create index emp_hiredate
on emp(hiredate);

select ename,hiredate
from emp
where hiredate='81/11/17';

■ Q-393.위의 SQL의 실행 계획 확인하고 힌트 줘라

explain plan for
select /*+ index(emp emp_hiredate)*/ hiredate
from emp
where hiredate='81/11/17';

select*from table(dbms_xplan.display);


■ Q-394.이름과 월급을 출력하는데 월급이 높은 사원부터 출력하시오

select /*+ index_desc(emp emp_sal)*/ename,sal
from emp
where sal >= 0;
        ↑
INDEX 에 Where 절은 필수 이다! 

■ Q-395.아래의 SQL을 튜닝하시오! 
튜닝전 : select ename,hiredate
            from emp
            order by hiredate desc;

튜닝후 :
create index emp_hiredate
on emp(hiredate);

select /* index_desc(emp_hiredate)*/ ename,hiredate
from emp
where hiredate >= to_date('9999/12/31,'RR/MM/DD');


■ Q-396.사원 테이블에 직업에 인덱스를 생성하시오!
create index emp_job
on emo(job);

■ Q-397.아래의 SQL을 튜닝하시오 
튜닝전
select ename,job   
 FROM emp  
   WHERE substr(job,1,5) ='SALES' 
           ↓
튜닝후
select /* index(emp emp_job)*/ename,job


■ Q-400.나머지 인덱스들도 전부 drop 하시오
	
	drop index emp_job;
	
	drop index emp_sal;
            

■ Q-401. 백업받은 emp_backup_2020111의 데이터를 emp테이블에 입력하시오! 

백업파일을 만들고 다시 넣고 ...

create table emp_backup_20201111
as
select * from emp;

insert into emp
select * 
from emp_backup_20201111;

■ Q-402.아래와 같이 salgrade 테이블을 전부 delete 하고 commit 한후에 복구하시오!

create table salgrade_backup_20201111
as
select * from salgrade;                                                                        백업파일 만들고

delete from salgrade;
commit;                                                               삭제하고

insert into salgrade
select *                                                               백업파일로 값입력해주기 
from salgrade_backup_20201111;
