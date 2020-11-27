
■ Algorithm Q-1  
Sum of 1 to 10 

select sum(level)
  From dual
     Connect by level <= 100;

■ Algorithm Q-2  
1부터 10까지 숫자중 짝수만 출력 ! 

select level
  From dual
  where mod(level,2) = 0
     connect by level <= 10;

■ Algorithm Q-3 

select exp(sum(ln(level)))
from dual
connect by level <=10;

■ Algorithm Q-4  
계층형 질의문을 이용해서 삼각형을 출력하시오! 

Select lpad('★',level,'★')                          
                                                                   
From dual                                                
Connect by level <=10;




■ Algorithm Q-5 

아래와?같이?결과를?출력하시오?(?힌트:?union?all?사용하세요)
★???????????????
★★????????????
★★★??????????
★★★★
★★★★★
★★★★
★★★
★★
★
select?lpad('*',level,'*')
?from?dual
?connect?by?level<=5
?union?all
select?lpad('*',5-level,'*')
?from?dual
?connect?by?level<=4;


■ Algorithm Q-6  
동전을 10만번 던졌을때 
동전이 앞면이 나올 확률은 얼마인가? (0.5의 근사 값이나와야한다)
From 절의 서브쿼리를 사용하면 쉽게 구할수 있다.

select count(*)/100000
from (select round(dbms_random.value(0,1),0) as a
            from dual
              connect by level<=10000)
              where a=1;

■ Algorithm Q-7 
(SQL 알고리즘 문제8번) 구구단 전체를 출력하시오!

2 X 1 = 1
2 X 2= 4
9 x 9 =81 

select a.num1 || 'x' || b.num2 || '=' ||b.num2*a.num1
from (select level as num1
         from dual 
         where level != 1
         connect by level <=9) a,
       (select level as num2
         from dual
         connect by level <=9) b;

■ Algorithm Q-8 
주사위를 10만번 던져서 주사의위 눈이 6이 나올 확률은 어떻게  되는가….
    
select count(*)/10000 as  "주사위의 눈이 6이 나올 확률"
from (select round(dbms_random.value(0.5,6.5) ) as 주사위
               from dual
                connect by level<=100000)
                where 주사위 =6;

■ Algorithm Q-9
(SQL 알고리즘 10번) 두개의 주사위를 던져서 두개의 주사위의 눈의 합이 10이 되는 확률을 구하시오! 
           
select count(*)/ (6*6) as "주사위의 눈의 합이 10이 되는 확률"
      from ( select level as num1
               from dual
               connect by level <= 6 ) a, 
           ( select level as num2
               from dual
               connect by level <= 6 ) b 
       where a.num1 + b.num2 = 10;


■ Algorithm Q-10 
10사이의 숫자중 하나가 없다 그 수는 ?? emp705 를 쿼리해서??한번에 알아내시오 !

select?*
?from
????(select decode((rownum-숫자),0,0,rownum) as 뺐을때
?????????from?emp705)?g
?where g.뺐을때!=0
?fetch?first?1?rows?only;

■ Algorithm Q-11 
두개의 주사위를 동시에 던져서 주사위의 눈의 합이 짝수가 되는 확률이 어떻게 되는가

두개의 주사위를 동시에 던져서 주사위의 눈의 합이 짝수가 되는 확률이 어떻게 되는가

select count(*) / 100000
from (select round(dbms_random.value(0.5,6.5) ) as 주사위1,round(dbms_random.value(0.5,6.5) as 주사위2
from dual
connect by level<=100000)
where mod(주사위1+주사위2,2)=0;

사건 A에 속하는 원소수  (사건 A에 속하는 원소수) 
--------------------------    = P(A)                       v=
표본공간의 전체 원소수 (100,000) 

1~1.5 ----1
1.5~2 ----2


■ Algorithm Q-12  
주사위 하나와 동전 한개를 동시에 던져서 주사위의 눈은 
5가 나오고 동전은 앞면이 나올 확률은 어찌되느냐 ? 동전앞 0 동전뒤 1 

select?count(*)?/?100000
from?(select?round(dbms_random.value(0.5,6.5),0)?as?주사위5,
????????????round(dbms_random.value(0,1),0)?as?동전앞
???????????from?dual
???????????connect?by?level?<=?100000)
???????????where?주사위5=5?and?동전앞=0;

■ Algorithm Q-13
Factorioal  을 SQL로 구현하시오! 

undefine 숫자를_입력하세요
select &&숫자를_입력하세요 || ' 팩토리얼은 ' || round(exp(sum(ln(level)))) || '입니다.'
from?dual
connect by level <= &숫자를_입력하세요 ;


■ Algorithm Q-14 
Temp 써서 해결하기! 


@
@@
@@@
@@@@
@@@@@

with temp_table as (select level as num1
                           from dual
                              connect by level <=9)
select lpad('@',num1,'@')
from temp_table;

■ Algorithm Q-15    
이번에는?삼각형이?출력되게하시오?!

Undefine 숫자
With table1 as 
( select level as num1 
         from dual
               connect by level <=&&숫자)
Select lpad(' ',&숫자-num1,' ')||'☆'||lpad('☆',num1-1,'☆')
From table1;



■ Algorithm Q-16
아래와 같이 숫자를 물어보게하고 숫자를 입력하면 마름모가 출력되게하시오?

???????????????????★
??????????????????★★
?????????????????★★★
????????????????★★★★
???????????????★★★★★ 
????????????????★★★★
?????????????????★★★
??????????????????★★
???????????????????★


Undefine 숫자                     
accept 숫자 prompt '숫자를 입력하세요.'   
With table1 as 
( select level as num1
From dual
Connect by level <=&&숫자)
Select lpad(' ',&숫자-num1,' ')||'☆'||lpad('☆',num1-1,'☆')
From table1
union all
Select lpad(' ',num1-1,' ')||' '||lpad('☆',&숫자-num1,'☆')
From table1;

■ Algorithm Q-17 
아래와 같이 두 숫자를 각각 입력받아 사각형을 출력하시오!

가로의 숫자를 입력하세요~5
세로의 숫자를 입력하세요~4

힌트: accept p_num1 prompt '가로의 숫자를 …
       accept p_num2 prompt '세로의 숫자를…. 

 accept p_num1 prompt '가로의 숫자를 입력하세요 ~'

   accept p_num2 prompt '세로의 숫자를 입력하세요 ~'

   select lpad('★',&p_num1,'★')

      from dual

      connect by level <=&p_num2;    

ACCEPT p_num1 prompt '사원번호를 입력하세요 ~~' 
select empno,ename,sal
from emp
where empno=&p_num1;

■ Algorithm Q-18 
오늘의 마지막 문제. SQL로 최대공약수를  구현하시오 !
                                             

                            

<with 절 사용 x>
undefine?숫자
accept?p_num1?prompt?'첫번째?숫자를?입력하세요?~'
accept?p_num2?prompt?'두번째?숫자를?입력하세요?~'

'최대?공약수는?'?||max(level)||'입니다'
from dual
where?mod(&p_num1,level)=0?and?mod(&p_num2,level)=0
connect?by?level?<=&p_num1;

                                                    
undefine숫자
accept p_num 1 prompt '첫번째 숫자를 입력하세요~'
accept p_num 2 promp '두번째 숫자를 입력하세요~' 

select '최대 공약수는 ' || max(level)||; 입니다'
from dual
where mod(&p_num1,level)=0 and mod(&p_num2,level)=0
connecty by level<=&p_num1;


select '최대 공약수는 ' || max(level)||; 입니다'
from dual
where mod(&p_num1,level)=0 and mod(&p_num2,level)=0
connecty by level<=&p_num1;


■ Algorithm Q-19 
Pythagoras

밑변의 제곱 더하기 높이 제곱이 빗변의 제곱과 같다면 그 삼각형은 직각 삼각형입니다. 

밑변을 입력하세요~3
높이를 입력하세요 ~4
빗변을 입력하세요~5 

직각삼각형이 맞습니다.       틀리면 직각삼각형이 아닙니다. 

undefine?숫자
accept?p_num1?prompt?'밑변을 입력하세요?~'
accept?p_num2?prompt? '높이를 입력하세요?~'
accept?p_num3?prompt  ' 밑변을 입력하세요~'

select case when(&&p_num1*&&p_num1)+(&&p_num2*&&p_num2)=(&&p_num3*&&p_num3) then
'직각삼각형이 맞습니다' else '직각삼각형이 아닙니다' end as 내맘대로
from dual;

*select power(2,3)     -----2의 3제곱이란 뜻임
                       from dual;

select case when power(&p_num1,2)+power(&p_num2,2)=power(&p_num3,2) then
'직각삼각형이 맞습니다' else '직각삼각형이 아닙니다' end as 피타고라스
from dual;


■ Algorithm Q-20  (몬테카를로 알고리즘)
몬테카를로 알고리즘은 수많은 노가다를 통해 정답을 알아내는것을 말한다.
몬테카를로 알고리즘으로 원주율을 알아내세요~~

select count(*)/10000*4

        from (select dbms_random.value(0,1) as x,
                     dbms_random.value(0,1) as y
                     from dual
    connect by level<=10000)
 where power(x,2)+power(y,2)<=1;
   


■ Algorithm Q-21   자연상수의 근사값을 SQL로 구현하세요




■ Algorithm Q-22   
1부터 10000까지의 숫자중에서 숫자 8이 총 몇번나오는가?
8이 포함되어있는 숫자의 갯수를 카운팅하는게 아니라 8이라는 숫자를 모두 카운팅 해야 합니다. 
(예를들어 8808 은 3이고, 8888은 4로 카운팅 해야함) 
결과 : 4000 이나와야한다. 

힌트 : 계층형 질의문, Regexp_count 이용함
SELECT?sum(REGEXP_COUNT(level,8))
from?dual?
connect?by?level?<=?10000;


■ Algorithm Q-23  
?1과?10사이의?숫자?중에서?소수만?출력하시오?!?
??????????????????????????↓
소수는?1과?자기?자신의?수로만?나눌?수?있는?수?
2,?3,?5,?7

select a.prime1
from ( select level as prime1 
            from dual
               connect by level<=10) a ,
    (select level as prime2 
       from dual
           connect by level <=10) b
        where mod(a.prime1,b.prime2)=0
        group by a.prime1
        having count(*)=2;

