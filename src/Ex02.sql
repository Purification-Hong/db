
/* �⺻ ������ */

-- 1) ������� ����̸�, �μ���ȣ�� ��ȸ�ϼ���
SELECT ename, empno
FROM emp ;



-- 2) ������� �μ���ȣ�� ��ȸ (��, �ߺ�����)
SELECT DISTINCT empno
FROM emp;



-- 3) ������� ����̸�, ����, ������ ��ȸ
--(������ �޿�*12 ���� ���)
SELECT ename, job, sal*12
FROM emp;



-- 4)������� ����̸�, �޿�, Ŀ�̼�, ������ ��ȸ
--(������ �޿� * 12 + Ŀ�̼� ���� ���. 
--Ŀ�̼��� ���� ����� Ŀ�̼� 50�� �����Ͻÿ� -  NVL()�� ó��)
SELECT ename, sal, comm, sal*12+comm, NVL(comm, 50)
FROM emp;




--5) ������� �����ȣ, ����̸�, ������ ��ȸ
--(����̸��� �̸��ڿ� '���'�ٿ����� ��ȸ)

SELECT empno, ename||'���', sal

FROM emp;




--------------------------------------------------------------------------

-- 6) �μ���ȣ�� 20���� ������� �����ȣ, ����̸�, ����, �μ���ȣ�� ��ȸ

SELECT empno, ename, job, sal 
FROM emp
WHERE empno=20;


-- 7) ������ 'SALESMAN'�� ������� ����̸�, ����, �μ���ȣ�� ��ȸ
SELECT ename, job, empno
FROM emp
WHERE job='SALESMAN';


--8) �޿��� 1000���� �̸��� ������� �����ȣ, ����̸�, �޿��� ��ȸ
SELECT empno, ename, sal 
FROM emp  
WHERE sal<1000;


--9) �Ի����� 81�� 9�� 8���� ����� ����̸�, ����, �Ի����� ��ȸ
SELECT ename, job, hiredate
FROM emp
WHERE hiredate='81/09/08';

--10) ����� �̸��� 'M' ���� ���ڷ� �����ϴ� ��� �� �޿��� 
--1000���� �̻��� ����� ����̸�, ����, �޿� ��ȸ
SELECT ename, job, sal
FROM emp
WHERE ename LIKE 'M%' and sal >=1000;



-- 11) ������ 'MANAGER' �̰� �޿��� 1000���� ���� ���� �μ���ȣ�� 10����
--����� ����̸�, ����, �޿�, �μ���ȣ�� ��ȸ
SELECT ename, job, sal, empno
FROM emp
WHERE job='MANAGER' and sal > 1000 and empno=10;



--12) ������ 'MANAGER'�� �ƴ� ������� ����̸�, ����, �Ի����� ��ȸ
--(NOT�����ڸ� ����ؼ� ó��)
SELECT ename, job, hiredate
FROM emp  
WHERE job NOT IN('MANAGER') ;


--13) ����̸��� 'C'�� �����ϴ� �ͺ��� ũ�� 'M'���� �����ϴ� �ͺ��� ���� �����
--����̸�, ����, �޿��� ��ȸ (BETWEEN-AND ������ �̿�)
SELECT ename, job, sal
FROM emp
WHERE ename BETWEEN 'D' AND 'L';


-- 14) �޿��� 800, 950������ �ƴ� ������� ����̸�, ����, �޿��� ��ȸ�ϼ���
--(NOT IN ������ ����ؼ� ó��)
SELECT ename, job, sal 
FROM emp
WHERE sal NOT IN(800, 950);




-- 15) ����̸��� 'S'�� �����ϰ� �̸� ���ڼ��� �ټ������� ������� ����̸�, ������ ��ȸ
SELECT ename, job 
FROM emp
WHERE ename LIKE 'S____';





-- 16)�Ի����� 3���� ������� ����̸�, ����, �Ի����� ��ȸ�ϼ���.
SELECT ename, job, hiredate
FROM emp 
WHERE hiredate LIKE '__/__/03';





--17)����̸��� 4���� �Ǵ� 5������ ������� ����̸�, ����, �޿��� ��ȸ�ϼ���.
SELECT ename, job, sal
FROM emp  
WHERE ename LIKE '____' OR ename LIKE '_____';


--18)�Ի�⵵�� 81���̰ų� 82���� ������� ����̸�, �޿�, �Ի����� ��ȸ�ϼ���.
    --(��, �׺��� ����޿����� 10% �λ�� �޿��� ��ȸ�ϼ���.)


SELECT ename, sal, hiredate
FROM emp  
WHERE hiredate LIKE '81/__/__' OR hiredate LIKE '82/__/__';



--19) �̸��� 'S'�� ������ ������� ����̸�, �޿�, Ŀ�̼��� ��ȸ�ϼ���.
--(��, Ŀ�̼��� ���� Ŀ�̼Ǻ��� 100 ������ Ŀ�̼����� �ϰ� Ŀ�̼��� ���� ����� 50���� ��ȸ�ǰ� �ϼ���.)

SELECT ename, sal, comm+100, NVL(comm, 50)
FROM emp  
WHERE ename LIKE '%S';






























