
�� Algorithm Problems 1  
Sum of 1 to 10 

select sum(level)
From dual
??? ???Connect by level <= 100;
?
�� Algorithm Problems 2  
1���� 10���� ������  ¦���� ��� ! 

select level
??? From dual
??? where mod(level,2) = 0
??? connect by level <= 10;
?
�� Algorithm Problems 3 



select exp(sum(ln(level)))
from dual
connect by level <=10;

�� Algorithm Problems 4  
������ ���ǹ��� �̿��ؼ� �ﰢ���� ����Ͻÿ�! 

Select lpad('��',level,'��')                           -- ����:   �� �� ����ϴµ� level ����ŭ �ڸ��� ��� 
                                                                       ���� ����ϰ� ������ �ڸ��� ���� ä���־�� 
From dual                                                
Connect by level <=10;



�� Algorithm Problems 5  ?
���ɽð�?����?��۷�?�ø���?�Ļ��Ϸ�������.!
�Ʒ���?����?�����?����Ͻÿ�?(?��Ʈ:?union?all?����ϼ���)
��???????????????
�ڡ�????????????
�ڡڡ�??????????
�ڡڡڡ�
�ڡڡڡڡ�
�ڡڡڡ�
�ڡڡ�
�ڡ�
��
select?lpad('*',level,'*')
?from?dual
?connect?by?level<=5
?union?all
select?lpad('*',5-level,'*')
?from?dual
?connect?by?level<=4;

�� Algorithm Problems 6 
������ 10���� �������� 
������ �ո��� ���� Ȯ���� ���ΰ�? (0.5�� �ٻ� ���̳��;��Ѵ�)
From ���� ���������� ����ϸ� ���� ���Ҽ� �ִ�.

select count(*)/100000
from (select round(dbms_random.value(0,1),0) as a
            from dual
              connect by level<=10000)
              where a=1;

�� Algorithm Problems  7
(SQL �˰��� ����8��) ������ ��ü�� ����Ͻÿ�!

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

�� Algorithm Problems 8  
�ֻ����� 10���� ������ �ֻ����� ���� 6�� ���� Ȯ���� ���  �Ǵ°���.
    
select count(*)/10000 as  "�ֻ����� ���� 6�� ���� Ȯ��"
from (select round(dbms_random.value(0.5,6.5) ) as �ֻ���
               from dual
                connect by level<=100000)
                where �ֻ��� =6;

�� Algorithm Problems 9 
(SQL �˰��� 10��) �ΰ��� �ֻ����� ������ �ΰ��� �ֻ����� ���� ���� 10�� �Ǵ� Ȯ���� ���Ͻÿ�! 
           
select count(*)/ (6*6) as "�ֻ����� ���� ���� 10�� �Ǵ� Ȯ��"
      from ( select level as num1
               from dual
               connect by level <= 6 ) a, 
           ( select level as num2
               from dual
               connect by level <= 6 ) b 
       where a.num1 + b.num2 = 10;

�� Algorithm Problems 10
10������ ������ �ϳ��� ���� �� ���� ?? emp705 �� �����ؼ�??�ѹ��� �˾Ƴ��ÿ� !

select?*
?from
????(select decode((rownum-����),0,0,rownum) as ������
?????????from?emp705)?g
?where g.������!=0
?fetch?first?1?rows?only;

�� Algorithm Problems 11 
�ΰ��� �ֻ����� ���ÿ� ������ �ֻ����� ���� ���� ¦���� �Ǵ� Ȯ���� ��� �Ǵ°�

�ΰ��� �ֻ����� ���ÿ� ������ �ֻ����� ���� ���� ¦���� �Ǵ� Ȯ���� ��� �Ǵ°�

select count(*) / 100000
from (select round(dbms_random.value(0.5,6.5) ) as �ֻ���1,round(dbms_random.value(0.5,6.5) as �ֻ���2
from dual
connect by level<=100000)
where mod(�ֻ���1+�ֻ���2,2)=0;

��� A�� ���ϴ� ���Ҽ�  (��� A�� ���ϴ� ���Ҽ�) 
--------------------------    = P(A)                       v=
ǥ�������� ��ü ���Ҽ� (100,000) 

1~1.5 ----1
1.5~2 ----2

�� Algorithm Problems 12 
�ֻ��� �ϳ��� ���� �Ѱ��� ���ÿ� ������ �ֻ����� ���� 
5�� ������ ������ �ո��� ���� Ȯ���� ����Ǵ��� ? ������ 0 ������ 1 

select?count(*)?/?100000
from?(select?round(dbms_random.value(0.5,6.5),0)?as?�ֻ���5,
????????????round(dbms_random.value(0,1),0)?as?������
???????????from?dual
???????????connect?by?level?<=?100000)
???????????where?�ֻ���5=5?and?������=0;

�� Algorithm Problems 13
Factorioal  �� SQL�� �����Ͻÿ�! 

undefine ���ڸ�_�Է��ϼ���
select &&���ڸ�_�Է��ϼ��� || ' ���丮���� ' || round(exp(sum(ln(level)))) || '�Դϴ�.'
from?dual
connect by level <= &���ڸ�_�Է��ϼ��� ;

�� Algorithm Problems 14  
Temp �Ἥ �ذ��ϱ�! 


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

�� Algorithm Problems 15  
�̹�����?�ﰢ����?��µǰ��Ͻÿ�?!

Undefine ����
With table1 as 
( select level as num1 
         from dual
               connect by level <=&&����)
Select lpad(' ',&����-num1,' ')||'��'||lpad('��',num1-1,'��')
From table1;


�� Algorithm Problems 16  
�Ʒ��� ���� ���ڸ� ������ϰ� ���ڸ� �Է��ϸ� ������ ��µǰ��Ͻÿ�?

?���ڸ�?�Է��ϼ���??~??5?

???????????????????��
??????????????????�ڡ�
?????????????????�ڡڡ�
????????????????�ڡڡڡ�
???????????????�ڡڡڡڡ�???????<----------?5��?
????????????????�ڡڡڡ�
?????????????????�ڡڡ�
??????????????????�ڡ�
???????????????????��


Undefine ����                     
accept ���� prompt '���ڸ� �Է��ϼ���.'   
With table1 as 
( select level as num1
From dual
Connect by level <=&&����)
Select lpad(' ',&����-num1,' ')||'��'||lpad('��',num1-1,'��')
From table1
union all
Select lpad(' ',num1-1,' ')||' '||lpad('��',&����-num1,'��')
From table1;

�� Algorithm Problems 17 
�Ʒ��� ���� �� ���ڸ� ���� �Է¹޾� �簢���� ����Ͻÿ�!

������ ���ڸ� �Է��ϼ���~5
������ ���ڸ� �Է��ϼ���~4

��Ʈ: accept p_num1 prompt '������ ���ڸ� ��
       accept p_num2 prompt '������ ���ڸ���. 

 accept p_num1 prompt '������ ���ڸ� �Է��ϼ��� ~'

   accept p_num2 prompt '������ ���ڸ� �Է��ϼ��� ~'

   select lpad('��',&p_num1,'��')

      from dual

      connect by level <=&p_num2;    

ACCEPT p_num1 prompt '�����ȣ�� �Է��ϼ��� ~~' 
select empno,ename,sal
from emp
where empno=&p_num1;


�� Algorithm Problems 18 
������ ������ ����. SQL�� �ִ�������  �����Ͻÿ� !
                                             

                            

<with �� ��� x>
undefine?����
accept?p_num1?prompt?'ù��°?���ڸ�?�Է��ϼ���?~'
accept?p_num2?prompt?'�ι�°?���ڸ�?�Է��ϼ���?~'
?????
??select??'�ִ�?�������?'?||max(level)||'�Դϴ�'
?????from?dual
????? where?mod(&p_num1,level)=0?and?mod(&p_num2,level)=0
?????   connect?by?level?<=&p_num1;

undefine����
accept p_num 1 prompt 'ù��° ���ڸ� �Է��ϼ���~'
accept p_num 2 promp '�ι�° ���ڸ� �Է��ϼ���~' 

select '�ִ� ������� ' || max(level)||; �Դϴ�'
from dual
where mod(&p_num1,level)=0 and mod(&p_num2,level)=0
connecty by level<=&p_num1;


select '�ִ� ������� ' || max(level)||; �Դϴ�'
from dual
where mod(&p_num1,level)=0 and mod(&p_num2,level)=0
connecty by level<=&p_num1;


�� Algorithm Problems 19 Pythagoras
�غ��� ���� ���ϱ� ���� ������ ������ ������ ���ٸ� �� �ﰢ���� ���� �ﰢ���Դϴ�. 

�غ��� �Է��ϼ���~3
���̸� �Է��ϼ��� ~4
������ �Է��ϼ���~5 

�����ﰢ���� �½��ϴ�.       Ʋ���� �����ﰢ���� �ƴմϴ�. 

undefine?����
accept?p_num1?prompt?'�غ��� �Է��ϼ���?~'
accept?p_num2?prompt? '���̸� �Է��ϼ���?~'
accept?p_num3?prompt  ' �غ��� �Է��ϼ���~'

select case when(&&p_num1*&&p_num1)+(&&p_num2*&&p_num2)=(&&p_num3*&&p_num3) then
'�����ﰢ���� �½��ϴ�' else '�����ﰢ���� �ƴմϴ�' end as �������
from dual;

*select power(2,3)     -----2�� 3�����̶� ����
                       from dual;

select case when power(&p_num1,2)+power(&p_num2,2)=power(&p_num3,2) then
'�����ﰢ���� �½��ϴ�' else '�����ﰢ���� �ƴմϴ�' end as ��Ÿ���
from dual;


�� Algorithm Problems 20 (����ī���� �˰���)
����ī���� �˰����� ������ �밡�ٸ� ���� ������ �˾Ƴ��°��� ���Ѵ�.
����ī���� �˰������� �������� �˾Ƴ�����~~

select count(*)/10000*4

        from (select dbms_random.value(0,1) as x,
                     dbms_random.value(0,1) as y
                     from dual
    connect by level<=10000)
 where power(x,2)+power(y,2)<=1;
   

�� Algorithm Problems 21 �ڿ������ �ٻ簪�� SQL�� �����ϼ���




�� Algorithm Problems 22 ���� �Ի� ���� 
1���� 10000������ �����߿��� ���� 8�� �� ��������°�?
8�� ���ԵǾ��ִ� ������ ������ ī�����ϴ°� �ƴ϶� 8�̶�� ���ڸ� ��� ī���� �ؾ� �մϴ�. 
(������� 8808 �� 3�̰�, 8888�� 4�� ī���� �ؾ���) 
��� : 4000 �̳��;��Ѵ�. 

��Ʈ : ������ ���ǹ�, Regexp_count �̿���
SELECT?sum(REGEXP_COUNT(level,8))
from?dual?
connect?by?level?<=?10000;



�� Algorithm Problems 23 
?1��?10������?����?�߿���?�Ҽ���?����Ͻÿ�?!?
??????????????????????????��
�Ҽ���?1��?�ڱ�?�ڽ���?���θ�?����?��?�ִ�?��?
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


