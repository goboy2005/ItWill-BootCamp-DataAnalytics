
�� Q-37.�̸� ù��° ö�ڰ� A�� �����ϴ� ������� �̸��� ������ ����Ͻÿ�

select ename,sal
from emp
where ename like 'A%';

�� Q-38.�̸��� SCOTT�� ����� �̸��� ���ް� ������ ����Ͻÿ�

select ename,sal,job
from emp
where ename='SCOTT';

�� Q-39.�̸��� ������ �ι�° ö�ڰ� T�� ������� �̸��� ������ ����Ͻÿ�

select ename,sal
from emp
where ename like '%T_';

�� Q-40.Ŀ�̼��� null �� ������� �̸��� Ŀ�̼��� ����Ͻÿ�.

select ename,comm
from emp
where comm is null;

�� Q-41.Ŀ�̼��� null�� �ƴ� ������� �̸��� Ŀ�̼��� ����Ͻÿ� 

select ename,comm
from emp
where comm is not null;

�� Q-42.�������� �����ȣ (mgr) �� null �� ������� �̸��� ������ ����Ͻÿ� 

select ename,job,mgr
from emp
where mgr is null;
����:���� (President) �� �����ڰ� ��ȣ (mgr) �� ����. (�ڱⰡ ¯�̴ϱ�)

�� Q-43.�����ȣ,�̸�,�������� ��ȣ (mgr)�� ����Ͻÿ� 

select ename,mgr
from emp;

�� Q-44.������ SALESMAN,ANALYST �� ������� �̸��� ������ ����Ͻÿ�.

select ename,job
from emp
where job in ('SALESMAN','ANALYST');

�� Q-45.������ SALESMAN,ANALYST �� �ƴ� ������� �̸��� ������ ����Ͻÿ�!

select ename,job
from emp
where job not in ('SALESMAN','ANALYST');

�� Q-46.������ SALESMAN �� �ƴ� ������� �̸��� ���ް� ������ ����Ͻÿ� !

select ename,sal,job
from emp
where job!='SALESMAN';

�� Q-47.���� ����� �ٽ� ����ϴµ� ������ ���� ������� ����Ͻÿ� (46����)

select ename,job,sal
from emp
where job!='SALESMAN'
order by 3 desc,1 asc;

�� Q-48.�츮�� ���̺��� �̸��� ���̸� ����ϴµ� ���̰� ���� �л����� ����Ͻÿ�.

select ename,age
from emp12
order by age desc;

�� Q-49.�̸��� ���̿� �ּҸ� ����ϴµ� 30�� �̻��� �л��鸸 ����Ͻÿ�.

select ename,age,address
from emp12
where age>=30;

�� Q-50.������ �达�� �л����� �̸��� ��Ż縦 ����Ͻÿ�

select ename,telecom
from emp12
where ename like '��%';

�� Q-51.������ ��踦 �����ϰ� �ִ� �л����� �̸��� ������ ����Ͻÿ�

select ename,major
from emp12
where major like '%���%';

�� Q-52.�츮�ݿ�gmail�� ����ϴ�(���԰� ����) �л����� �̸��� ������ ����Ͻÿ� 

select ename,email
from emp12
where email like '%gmail%';

�� Q-53.���̰� 27���� 34������ �л����� �̸��� ���̸� ����Ͻÿ�.

select ename,age
from emp12
where age between 27 and 34

�� Q-54.���̰� 27���� 34���̰� �ƴ� �л����� �̸��� ���̸� ����Ͻÿ�
select ename,age
from emp12
where age not between 27 and 34;

�� Q-55.�ּҰ� ��⵵�� �л����� �̸��� ���̿� �ּҸ� ����Ͻÿ�.

select ename,age,address
from emp12
where address like '%��⵵%'

�� Q-56.��Ż簡 sk,lg�� �л����� �̸��� ��Ż縦 ����Ͻÿ�.

select ename,telecom
from emp12
where telecom in ('sk','lg');

�� Q-57.���￡�� ��� �л����� �̸��� ���̿� ������ ����Ͻÿ�, 
���̰� ���� �л����� ���.

select ename,age,major
from emp12
where address like '%����%'
order by age desc;

�� Q-58.�̸�����gmail�� �ƴ� �л����� �̸��� email�� ����Ͻÿ�. 

select ename,email
from emp12
where email not like '%gmail%';

�� Q-59.�Ʒ��� ���� ����� ��µǰ� �Ͻÿ�! 
    ���ֿ� �л��� ���̴� 44 �Դϴ�. 
    (ename '�л��� ���̴�' age '�Դϴ�')

select ename||'�л��� ���̴�'||age||'�Դϴ�.' "
from emp12

�� Q-60.������ SALESMAN �̰ų� ANALYST�� ������� �̸��� ����,������ ����Ͻÿ�. (2�� ��� ����)  

select ename,sal,job
from emp
where job='ANALYST' or job='SALESMAN';
�̰͵� �ǰ�
select ename,sal,job
from emp
where job in ('SALESMAN','ANALYST');

�� Q-61.������ �达,�̾��� �ƴ� �л����� �̸��� ����Ͻÿ�. 

select ename
from emp12
where ename not like '��%' and ename not like '��%'

�� Q-62.�̸��� gmail �� naver �� �ƴ� �л����� �̸��� �̸����� ����Ͻÿ� 

select ename,email
from emp12
where email not like '%gmail%' and email not like '%naver%';

�� Q-63.�츮�� ���̺��� ��Ż簡 sk �� ���õ� ��Ż� �̸� �� �л��� �̸��� ��Ż縦 ����Ͻÿ�. ��Ȯ�ϰ� �����Ͱ� ����� �Ǿ����ڱ�, SQL�� �ۼ��ϼ���. (�빮�� ��������,�ҹ��� �������� , �մ빮��, �ڴ� �ҹ��� ����) 

select ename,telecom
from emp12
where upper(telecom) like '%SK%';
�ٽ� : Where upper(telecom) :  (telecom �����͸� ���� �빮�ڷ� �������� ������) 

�� Q-64.��,��,�� ���� �л����� �̸��� ���̸� ����ϴµ� like ���� ���� in�� substr �Ἥ ������Ͻÿ�.  

select ename,age
from emp12
where substr(ename,1,1) in ('��','��','��');

�� Q-65.�츮�� ���̺��� �̸��ϰ� �̸����� ö�ڿ� ���̸� ����ϴµ� �̸��� ö���� ���̰� ���� ��ͺ��� ����Ͻÿ�.

select ename,email,length(email)
from emp12
order by length(email) desc;

�� Q-66.emp���̺��� ename �� ����ϰ� �� ���� ename�� ù��° ö�ڸ� ����Ͻÿ�

select ename,substr(ename,1,1) 
from emp ;

�� Q-67.���� ����� �ٽ� ����ϴµ� �̸��� ù��° ö�ڷ� ��µǴ� �κ��� �ҹ��ڷ� ���
�Ͻÿ� 

select ename,substr(lower(ename),1,1)
from emp;
Or
select ename,lower(substr(ename,1,1))
from emp;

�� Q-68.�Ʒ��� ����� initcap���� ���� upper,lower,substr, || ����ؼ� ����Ͻÿ�.
    (        select initcap(ename)   from emp;  ) 

select upper(substr(ename,1,1))||lower(substr(ename,2,10))as "INITCAP(ENAME)"
from emp;
