*�񱳿����� 
>,<,<=,>=,!=,<>,

*��Ÿ �񱳿����� 4���� 
1.between ��and 
2.like
3.is null
4.in  

? 013 �� ������ ���� 4 (IS NULL)

null ���� ��ȸ�Ҷ� ����ϴ� �����ڰ�  is null �̴�. 
null ���� �����Ͱ� ���� ���� �Ǵ� �� ������ �� ( Unknown ) �Դϴ�. 
���� : null�� �˼� ���� ������ �񱳿����� (=) �� �˼� ���⿡ ��� is null�� ������ش�. 
Not ���� 

���� : �̸��� ���� Ŀ�̼��� ����Ͻÿ� 
���⼭ null �̶ߴ� ������� Ŀ�̼� å���� �ȵȻ�����̴�. 
@����:���� (President) �� �������� ��ȣ (mgr) �� ����. (�ڱⰡ ���� �̴ϱ�)

? 014 �� ������ ���� 5 (IN)

Where���� �˻����ǿ��� �������� ���� ���� ���� in�� ����ؾ� �մϴ�. 
����: �����ȣ��7788,7902�� ������� �����ȣ�� �̸��� ��ȸ�Ͻÿ�! 
Select empno,ename
From emp
Where empno = x /������  in �� ������ָ� ���� �� �� ����, ��� () ������Ѵ�. 

@�����ϰ� ���� like�� ����ϸ�, '%���%'
����: like�����ڸ� ����� �� Ư�� �ܾ �����ϰ� �ִ� �����͸� 
�˻��Ϸ��� '%�ܾ�%' ��� �ϸ� �˴ϴ�.

? 015 �� ������ ���� (AND, OR, NOT)

����Ŭ �������� ����3����

1.���������: */+-
2.�񱳿����� : <,>,<=,>=,!=,<>,^=
  ��Ÿ �񱳿����� : between��and
                         like
                         is null
                         in 
3.�� ������: and, or , not 

����)
������ SALESMAN �̰� ������ 1200�̻��� ������� �̸��� ���ް� 
������ ����Ͻÿ�
Select ename,sal,job
From emp
Where job='SALESMAN' and sal>=1200;  
                  True                    True 

True and true �̸� True �̱� ������ ����̵ȴ�.
False and true �̸� False �̱� ������ ����̾ȵȴ�

������!
False or True �̸� True �̱� ������ ����� �ȴ�. (or �� �ϳ��� True ���� True �̴�) 


? 016 ��ҹ��� ��ȯ �Լ� ���� (UPPER, LOWER, INITCAP)

�Լ� (function)? � Ư�� ����� ������ ���� �ڵ��� ����. 
�Է°�---�Լ�---��°� (������ �����  ���´�)

�Լ��� ����ϴ� ����? �Լ��� �̿��ϸ� �� �� ������ ������ �˻��� �� �� �ִ�.
��: ��ȭ �ܿ� �ձ����� elsa�� ���� ���ñ� anna�� ���� ���ñ�? 

����)
select upper(ename),lower(ename),initcap(ename)
From emp;



? 017 ���ڿ��� Ư�� ö�� �����ϱ� (SUBSTR)

����: select ename,substr(ename,1,1)
����)
������ �̾��� �л����� �̸��� ����Ͻÿ�!
like �������� in �� substr �� �Ἥ ����Ͻÿ� 

@select ���ο� �� Susbstr(ename,1,1) �� ©�� �����ֱ⸸ �Ѵ�. 
(select substr(ename,1,1) from emp12;)

where ���ο� substr �Ἥ ©�󳻰� in ,= ����ؼ� �˻��Ѵ�. 
where substr(ename,1,1) = '��';

	
? 018 ���ڿ��� ���̸� ����ϱ� (LENGTH)
	
���� : Length(ename) 
             
select length(ename) from emp;
                                                            �������·� ���´�


37.�̸� ù��° ö�ڰ� A�� �����ϴ� ������� �̸��� ������ ����Ͻÿ�

select ename,sal
from emp
where ename like 'A%';

38.�̸��� SCOTT�� ����� �̸��� ���ް� ������ ����Ͻÿ�

select ename,sal,job
from emp
where ename='SCOTT';

39.�̸��� ������ �ι�° ö�ڰ� T�� ������� �̸��� ������ ����Ͻÿ�

select ename,sal
from emp
where ename like '%T_';

40.Ŀ�̼��� null �� ������� �̸��� Ŀ�̼��� ����Ͻÿ�

select ename,comm
from emp
where comm is null;

41.Ŀ�̼��� null�� �ƴ� ������� �̸��� Ŀ�̼��� ����Ͻÿ� 

select ename,comm
from emp
where comm is not null;

42.�������� �����ȣ (mgr) �� null �� ������� �̸��� ������ ����Ͻÿ� 

select ename,job,mgr
from emp
where mgr is null;
����:���� (President) �� �����ڰ� ��ȣ (mgr) �� ����. (�ڱⰡ ¯�̴ϱ�)

43.�����ȣ,�̸�,�������� ��ȣ (mgr)�� ����Ͻÿ� 

select ename,mgr
from emp;

44.������ SALESMAN,ANALYST �� ������� �̸��� ������ ����Ͻÿ�

select ename,job
from emp
where job in ('SALESMAN','ANALYST');

45.������ SALESMAN,ANALYST �� �ƴ� ������� �̸��� ������ ����Ͻÿ�!

select ename,job
from emp
where job not in ('SALESMAN','ANALYST');

46.������ SALESMAN �� �ƴ� ������� �̸��� ���ް� ������ ����Ͻÿ� !

select ename,sal,job
from emp
where job!='SALESMAN';

47.���� ����� �ٽ� ����ϴµ� ������ ���� ������� ����Ͻÿ� (46����)

select ename,job,sal
from emp
where job!='SALESMAN'
order by 3 desc,1 asc;

48.�츮�� ���̺��� �̸��� ���̸� ����ϴµ� ���̰� ���� �л����� ����Ͻÿ�

select ename,age
from emp12
order by age desc;

49.�̸��� ���̿� �ּҸ� ����ϴµ� 30�� �̻��� �л��鸸 ����Ͻÿ�

select ename,age,address
from emp12
where age>=30;

50.������ �达�� �л����� �̸��� ��Ż縦 ����Ͻÿ�

select ename,telecom
from emp12
where ename like '��%';

51.������ ��踦 �����ϰ� �ִ� �л����� �̸��� ������ ����Ͻÿ�

select ename,major
from emp12
where major like '%���%';

52.�츮�ݿ�gmail�� ����ϴ�(���԰� ����) �л����� �̸��� ������ ����Ͻÿ� 

select ename,email
from emp12
where email like '%gmail%';

53.���̰� 27���� 34������ �л����� �̸��� ���̸� ����Ͻÿ�

select ename,age
from emp12
where age between 27 and 34

54.���̰� 27���� 34���̰� �ƴ� �л����� �̸��� ���̸� ����Ͻÿ�

select ename,age
from emp12
where age not between 27 and 34;

55.�ּҰ� ��⵵�� �л����� �̸��� ���̿� �ּҸ� ����Ͻÿ�

select ename,age,address
from emp12
where address like '%��⵵%'

56.��Ż簡 sk,lg�� �л����� �̸��� ��Ż縦 ����Ͻÿ�

select ename,telecom
from emp12
where telecom in ('sk','lg');

57.���￡�� ��� �л����� �̸��� ���̿� ������ ����Ͻÿ�, ���̰� ���� �л����� ���.

select ename,age,major
from emp12
where address like '%����%'
order by age desc;

58.�̸�����gmail�� �ƴ� �л����� �̸��� email�� ����Ͻÿ�. 

select ename,email
from emp12
where email not like '%gmail%';

59.�Ʒ��� ���� ����� ��µǰ� �Ͻÿ�
���ֿ� �л��� ���̴� 44 �Դϴ�. 
(ename '�л��� ���̴�' age '�Դϴ�')

select ename||'�л��� ���̴�'||age||'�Դϴ�.' "
from emp12

60.������ SALESMAN �̰ų� ANALYST�� ������� �̸��� ����,������ ����Ͻÿ� (2�� ��� ����)  

select ename,sal,job
from emp
where job='ANALYST' or job='SALESMAN';
or
select ename,sal,job
from emp
where job in ('SALESMAN','ANALYST');

61.������ �达,�̾��� �ƴ� �л����� �̸��� ����Ͻÿ�. 

select ename
from emp12
where ename not like '��%' and ename not like '��%'

62.�̸��� gmail �� naver �� �ƴ� �л����� �̸��� �̸����� ����Ͻÿ� 

select ename,email
from emp12
where email not like '%gmail%' and email not like '%naver%';

63.�츮�� ���̺��� ��Ż簡 sk �� ���õ� ��Ż� �̸� �� �л��� �̸��� ��Ż縦 ����Ͻÿ�. ��Ȯ�ϰ� �����Ͱ� ����� �Ǿ����ڱ�, SQL�� �ۼ��ϼ���. (�빮�� ��������,�ҹ��� �������� , �մ빮��, �ڴ� �ҹ��� ����) 

select ename,telecom
from emp12
where upper(telecom) like '%SK%';
(�ٽ� : Where upper(telecom) :  (telecom �����͸� ���� �빮�ڷ� �������� ������) 

64.��,��,�� ���� �л����� �̸��� ���̸� ����ϴµ� like ���� ���� in�� substr �Ἥ ������Ͻÿ�.  
select ename,age
from emp12
where substr(ename,1,1) in ('��','��','��');

65.�츮�� ���̺��� �̸��ϰ� �̸����� ö�ڿ� ���̸� ����ϴµ� �̸��� ö���� ���̰� ���� ��ͺ��� ����Ͻÿ�.
select ename,email,length(email)
from emp12
order by length(email) desc;

66.emp���̺��� ename �� ����ϰ� �� ���� ename�� ù��° ö�ڸ� ����Ͻÿ�
select ename,substr(ename,1,1) 
from emp ;

67.���� ����� �ٽ� ����ϴµ� �̸��� ù��° ö�ڷ� ��µǴ� �κ��� �ҹ��ڷ� ��� �Ͻÿ� 

select ename,substr(lower(ename),1,1)
from emp;
Or
select ename,lower(substr(ename,1,1))
from emp;

68.�Ʒ��� ����� initcap���� ���� upper,lower,substr, || ����ؼ� ����Ͻÿ�.

(select initcap(ename)   from emp;  ) 
select upper(substr(ename,1,1))||lower(substr(ename,2,10))as "INITCAP(ENAME)"
from emp;
