? 038 ��հ� ����ϱ�(AVG)

����)
������̺��� �� ������ ����Ͻÿ�.
select sum(sal)
from emp;

@group�Լ��� ������ �ٶ��� where  ���� ����ϸ� �ȵǰ� having ���� ����ؾ� �մϴ�. 
where ������ �׷��Լ��� ������� ���� �Ϲ����� �˻������� �� ����մϴ�. 

�ڵ����� : select --- from--- where--- group by ---having --- order by 
�������: from ---- where---group by --- having --- select ---order by 

select �˻��� �÷���
from �˻��� ���̺��
where �˻�����
group by �׷����� �˻�����
having �׷��Լ��� �˻����� �� �� ���
order by ������ �÷��� 

select job,sum(sal)
from emp
group by job
having sum(sal) >=6000 and job!='SALESMAN'    
order by sum(sal) desc;

�̰�� �˻��ӵ��� ��������. �Ǳ�� �ϴµ� �˻������� having ���� ����ϸ� �˻��ӵ��� �������ϱ� 
�ݵ�� where ���� �ۼ��ؾ� �մϴ�. Having ���� Group �Լ� �����ٶ��� ����ϼ���.

? 040 �Ǽ� ����ϱ�(COUNT)

��: ��� ���̺��� �ο����� Ȯ���Ͻÿ� 
select count(empno) 
from emp

select count(*) 
from emp;

select count(comm)
from emp;
"�׷��Լ��� null���� �����Ѵ�"

����: select job,count(empno) from emp
group by job;

? 041 ������ �м� �Լ��� ���� ����ϱ� 1(RANK)

������ �� �Լ� : ������ �м��� �����ϰ� �ϱ� ���ؼ� �����ϴ� �Լ� 
���߿� rank�� ������ ����ϴ� �Լ��Դϴ�.
����: �̸�,����,���޿� ���� ������ ����Ͻÿ�. 

���ξȿ� �ִ� ������ ���� ������� Ȯ���ؼ� ������ ����ϰڴ�. 

����: Partition by �� group by  �ϰ� ȥ���ϸ� �ȵȴ�.
partition by �� ������ �м��Լ����� ��ȣ�ȿ� ���� ��������
partiton by job �̶�� �ϸ� �������� ���� ��Ƽ���ؼ� �����ڴٴ� ���̴�.
�׷��� �Ʒ��� ��
rank() over (partition by job ----�������� ��Ƽ���ؼ� 
                order by sal desc) ---- ������ ���� ������� ������ ����ϰڴ�. 
����
select lower(substr(telecom,1,2)),ename,age,dense_rank() over (partition by lower(substr(telecom,1,2)) order by age desc) as ����
from emp12;

������ ���Ƽ� ������ ���� �� ������ ���� ������ �� ���� ������ �ߺ��� ����ŭ ���ؼ� ��µǴ� ���� rank �̰� �ߺ��Ǿ����� �ٷ� �� ���������� �����°;� dense_rank()�̴�. 


117.������ ANALYST �� ������� �ִ������ ����Ͻÿ�.

select job,max(sal)
from emp
where job='ANALYST'
group by job;

118.������ �ִ������ ����Ͻÿ�.

select max(sal),job
from emp
group by job;

119.������ �ִ������ �����ͺ��� ������ �غ��ÿ�

select job,max(sal)
from emp
group by job
order by max(sal) desc;

120.�μ���ȣ,�μ���ȣ�� �ִ������ ����ϴµ�, �μ���ȣ�� �ִ������ �����ͺ��� ����Ͻÿ�.

select deptno,max(sal)
from emp
group by deptno
order by max(sal) desc nulls last 

121.�̸��� ����(sal*12)�� ����ϴµ� ������ ����Ҷ� õ������ �鸸������ ǥ�õǰ� �Ͻÿ�!

select ename,to_char(sal*12,'999,999,999') as ����
from emp;

122.���� ����� �ٽ� ����ϴµ� �÷����� �ѱ۷� �����̶�� �ϰ� ������ ���� ������� ����Ͻÿ� 

select ename,to_char(sal*12,'999,999') as "$ ����"
from emp
where to_char(sal*12,'999,999') is not null
order by to_char(sal*12,'999,999') desc; 

123.������ �ִ� ������ ����ϴµ� ������ �ִ������ ����Ҷ� õ���� �޸�(,)�� ��µǰ� �Ͻÿ�

select job,to_char(max(sal),'9,999')
from emp
where job is not null
group by job;

124.����,������  �ּ� ������ ���Ͻÿ�! 

select job,min(sal)
from emp
where job is not null
group by job;

125.���� ����� �ٽ� ����ϴµ� ������ ABCD ������� ����Ͻÿ�! 

select job,min(sal)
from emp
where job is not null
group by job
order by job asc;

125.���� ������� ������ SALESMAN�� �����ϰ� ����Ͻÿ� 

select job,min(sal)
from emp
where job is not null and job!='SALESMAN'
group by job
order by job asc;

127.�츮�ݿ��� �ּ� ���̸� ����Ͻÿ� 

select min(age)
from emp12;

128.���￡�� ��� �л��߿� �ּҳ��̸� ����Ͻÿ� 

select min(age)
from emp12
where address like '%����%';

129.�Ի��� �⵵(4�ڸ�)�� ����ϰ� �Ի��� �⵵�� �ּ� ������ ����Ͻÿ�.

select min(sal),to_char(hiredate,'RRRR')
from emp
group by to_char(hiredate,'RRRR');

130.�츮�� ������ ��հ��� ����Ͻÿ�.

select round(avg(age),2)
from emp12;

131.��� ���̺��� ������ ��հ��� ����Ͻÿ�!

select avg(sal)
from emp;
(����: ������ �� ������ 14�� ����)  

132.Ŀ�̼��� ��հ��� ����Ͻÿ�. 

select avg(comm)
from emp;
(����:Ŀ�̼��� �� ������ 4�� ������...null�� ���Ÿ� �Ѱ�! )

133.���� ����� �ٽ� ����ϴµ� 4�� ������ �ʰ� 14�� ������ �Ͻÿ�.

select avg(nvl(comm,0))
from emp;
����: null ����0���� �� �����߱� ������ 4�� ������ �ʰ� 14�� ������ �Ǿ���

134.���� ������� �Ҽ��� ���ϴ� �ȳ����� �ݿø� �Ͻÿ�. 

select round(avg(nvl(comm,0)),0)
from emp;

135.����,������ ��տ����� ����Ͻÿ� 

select job,avg(sal)
from emp
where job is not null
group by job;

136.��Ż�,��Ż纰 ��ճ��̸� ����Ͻÿ�

select avg(age),lower(substr(telecom,1,2))
from emp12
where lower(substr(telecom,1,2)) in ('sk','lg','kt')
group by lower(substr(telecom,1,2));
or
select decode(lower(telecom),'skt','sk',lower(telecom)),avg(age)
from emp12
group by decode(lower(telecom),'skt','sk',lower(telecom));

137L. ������ ����ϰ� ������ ��ճ��� ����ϴµ� ������ ��,��,�� ������ ��µǰ� �Ͻÿ�! 

select ltrim(major),avg(age)
from emp12
group by major
order by major asc;

138.����,���� ��Ż������ ����ϴµ� ���� ��Ż������ �����ͺ��� ����Ͻÿ�. 

select job,sum(sal)
from emp
group by job
order by sum(sal) desc;

139.���� ������� ������ SALESMAN�� �����ϰ� ����Ͻÿ�!

select job,sum(sal)
from emp
where job!='SALESMAN'
group by job
order by sum(sal) desc;

140.���� ����� �ٽ� ����ϴµ� ��Ż������ 6000�̻��ΰ͸� ����Ͻÿ� 

select job,sum(sal)
from emp
where job!='SALESMAN' 
having  sum(sal)>=6000
group by job
order by sum(sal) desc;

141.����,������,��Ż������ ����ϴµ� ������ SALESMAN�� �����ϰ� ����ϰ� ������ ��Ż������ 6000�̻��ΰ͸� ����ϰ� ������ ��Ż������ �����ͺ��� ����Ͻÿ�! 

select job,sum(sal)
from emp
where job!='SALESMAN'
group by job
having sum(sal) >=6000
order by sum(sal) desc;

142.��Ż�,��Ż纰 ��Ż���̸� ����Ͻÿ� skt�� �����ϰ� ����ϰ� ��Ż纰 ��Ż���̰� 100���̻��� �����͸� ����ϰ� ��Ż纰 ��Ż���̰� �����ͺ��� ����Ͻÿ� 

select lower(telecom),sum(age)
from emp12
where lower(telecom)!='skt'
group by lower(telecom)
having sum(age)>=100
order by sum(age) desc;

143.���� ������ �ٽ� Ǫ�µ� �̹����� skt�� sk�� ���Խ��Ѽ� ����Ͻÿ�.

select lower(substr(telecom,1,2)) , sum(age)
from emp12
group by lower(substr(telecom,1,2))
having sum(age) >= 100
order by sum(age) desc;

144.�Ի��� �⵵(4�ڸ�),�Ի��� �⵵�� ��Ż������ ����ϴµ�, ��Ż ������ ����Ҷ� õ���� ǥ�ð� ��µǰ� �Ͻÿ�.

select to_char(hiredate,'RRRR'),to_char(sum(sal),'999,999')
from emp
group by to_char(hiredate,'RRRR');

145 ����,���� �ο����� ����Ͻÿ� 

select job,count(*) 
from emp
group by job;

146.����,���̺� �ο����� ����Ͻÿ� ! 

select age,count(*)
from emp12
group by age; 

147.���� ����� �ٽ� ����ϴµ� ���̺� �ο����� �����ͺ��� ����Ͻÿ� 

select count(*),age
from emp12
group by age
order by count(*) desc;

148.���� ����� �ٽ� ����ϴµ� ���̺� �ο����� �κ��̻��ΰ� ��� 

select count(*),age
from emp12
group by age
having count(*) >=2
order by count(*) desc;

149.��Ż�,��Ż纰 �ο����� ����Ͻÿ� 

select lower(substr(telecom,1,2)), count(*)
from emp12
group by lower(substr(telecom,1,2));

150.�̸�,�̸��� �����θ� ����Ͻÿ�.

select ename, substr(email, instr(email, '@') +1, instr(email, '.', -1, 1) - instr(email, '@') -1)
  from emp12;

151.�̸��� ������,�̸��� �����κ� �ο����� ����Ͻÿ�.

select count(*), substr(email, instr(email, '@') +1, instr(email, '.', -1, 1) - instr(email, '@') -1)
  from emp12
  group by substr(email, instr(email, '@') +1, instr(email, '.', -1, 1) - instr(email, '@') -1);

153.�̸�,����,������ ����ϴµ� ���̰� ���� ������� ������ ����Ͻÿ� 

select ename,age,rank() over (order by age desc) as ����
from emp12;

154.����,�̸�,����,������ ����ϴµ� �������� ���� ������ ���� ������� ������ ��µǰ� �Ͻÿ�. 

select job,ename,sal,rank() over (partition by job order by sal desc) as ����
from emp;

155.�μ���ȣ,�̸�,�Ի���,������ ����ϴµ� ������ �μ���ȣ���� ���� ���� �Ի��� ��������� ������ �ο��ǰ� �Ͻÿ�. 

select deptno,ename,hiredate, rank() over (partition by deptno
                                           order by hiredate asc)
                                           from emp;

156.��Ż�,�̸�,����,������ ����ϴµ� ��Ż纰�� ���� ���� ���� �л������� ���. 

select lower(substr(telecom,1,2)),ename,age,rank() over (partition by lower(substr(telecom,1,2)) order by age desc) as ����
from emp12;

157.�̸�,����,������ ����ϴµ� dense_rank �� �Ἥ ���� ������ 1,2,3,4,5 �� ���� ��µǰ� �Ͻÿ� 

select ename,sal,dense_rank() over (order by sal desc) as ����
from emp;

158.�Ի��� �⵵(4�ڸ�),�̸�,����,������ ����ϴµ� ������ �Ի��� �⵵ ���� ���� ������ ���� ����� ������ ����Ͻÿ� .

select to_char(hiredate,'RRRR'),ename,sal,dense_rank() over 
(partition by to_char(hiredate,'RRRR') order by sal desc) as ����
from emp;

159.�̸��� ������,�̸�,����,������ ����ϴµ� ������ �̸��� ������ ���� ���� ���̰� ���� �л������� ��µǰ� �Ͻÿ�.  

select ename,age, substr(email, instr(email, '@') +1,
instr(email, '.', -1, 1) - instr(email, '@') -1),rank() over (partition by substr(email, instr(email, '@') +1,
instr(email, '.', -1, 1) - instr(email, '@') -1) order by age desc) 
from emp12;