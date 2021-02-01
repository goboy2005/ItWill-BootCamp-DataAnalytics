SQL Day 11 Problems

■ Q-314.  dept 테이블을  백업하시오 

 create  table   dept_backup
 as
  select *
   from  dept; 

■ Q-315.  dept 테이블을 truncate 하시오 

 truncate   table  dept; 

■ Q-316.  dept 테이블을 dept_backup 테이블을 이용해서 복구하시오 

insert   into  dept
 select  *
   from  dept_backup;


■ Q-317.  ALLEN 보다 더 늦게 입사한 사원들의 커미션을 9000으로 
수정하시오 !

update emp
set comm = 9000
where hiredate > (select hiredate
                         from emp
                         where ename ='ALLEN');

■ Q-318.  SMITH 와 같은 직업을 갖는 사원들의 월급을 9800으로 
 변경하시오 ! 그런데 SMITH 는 제외하시오 !

update emp
set sal = 9800
where job = (select job
		from emp
		where ename = 'SMITH') 
and ename != 'SMITH';

■ Q-319.  ALLEN 의 월급을  KING 의 월급으로 변경하시오 !

 update  emp
   set  sal  =  (  select   sal 
                        from  emp
                        where  ename='KING' ) 
   where   ename='ALLEN';

■ Q-320.   JONES 보다 월급이 많은 사원들의 직업을 MARTIN 의 
 직업으로 변경하시오 !

 update   emp
   set   job =  (select   job
                       from  emp
                       where  ename='MARTIN' )
  where   sal  > ( select  sal
                          from  emp
                          where  ename='JONES' );


■ Q-321.  ALLEN 보다 늦게 입사한 사원들을 삭제하시오 !

 delete  from  emp
  where  hiredate > ( select   hiredate
                               from  emp
                               where  ename='ALLEN' );
 rollback;

■ Q-322.  JONES 와 같은 부서번호에서 일하는 사원들을 삭제하시오 !
 그런데 JONES 는 제외시키시오 



■ Q-323.  부서번호, 부서번호별 인원수를 출력하시오 !(세로 출력)

 select  deptno, count(*)  인원수 
  from  emp
  group  by deptno; 

■ Q-324.  부서테이블에 cnt 라는 컬럼을 추가하시오 !

 alter   table  dept
   add   cnt    number(10);

 select   deptno, cnt
   from  dept; 

■ Q-325. 지금 dept 테이블에 추가한 cnt 컬럼에 해당 부서번호에 인원수로
값을 갱신하시오 ! 

merge into dept d
using ( select  deptno, count(*)  인원수 
           from  emp
           group  by  deptno )  e
on ( e.deptno = d.deptno )
when matched then
update set d.cnt = e.인원수;




설명:  using 절에 사용한 서브쿼리문의 결과가 마치 테이블처럼 이 merge
        문에서 사용되고 있다. 
