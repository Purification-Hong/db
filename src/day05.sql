--[�׷��Լ�]
--�������� �����͸� �ϳ��� ���� �����ϰ� ����� �˷��ִ� �Լ�

/* 
    +����
        �׷� �Լ��� ����� ���� �Ѱ��� ������ �ȴ�. ���� �׷��Լ��� ����� ������
        ������ ���� ȥ���ؼ� ����� �� ����. ���� �������� ����� �������θ� 
        ������ �Ͱ��� ����� �� �ִ�.
        
    ��)
        select ename from emp; - 14���� ���� �߻�
        select sum(sal)from emp; - sum(sal) : ������� �޿��� �հ踦 ����ؼ� ��ȯ���ִ� �Լ�
                                ���� ������� �հ�� �������� ������ ���ϰ����� ���Ǿ
                                ������� ���̴�.
        ����
        select sal, sum(sal) from emp; �� ����� �� ����.
        
    ��) 
        select ename, sum(sal) from emp; �� ���Ǹ�� ���� �Ұ����ϴ�.
        
    +���� �׷��Լ������� ���� ����� �� �ִ�
    
            1. sum() 
                �հ�.
                +����
                    sum(�÷��̸�)
            2. avg()
                �������� ����� ���ϴ� �Լ�
                +����
                     avg(�÷��̸�)
                +����
                    null �������� ���� ����� ����ϴ� ���꿡�� ������ ���ܵȴ�
            3. count()
                ������ �ʵ� �߿��� �����Ͱ� �����ϴ� �÷��� ���� �˷��ش�
                +����
                    �����Ϳ� '*'�� �Է��ϸ� ���� ���� ��ȸ�Ѵ�.
            4. max() / min()
                �ִ�/�ּҰ��� �˷��ִ� �Լ�
                +����
                    max(�÷��̸�)
            5. stddev()
                ǥ������ ��ȯ���ִ� �Լ�
                
            6. variance()
                �л� ��ȯ���ִ� �Լ�

*/


--������� �ѱ޿��� ��ձ޿��� ��ȸ
select sum(sal), trunc(avg(sal), 2)
from emp;

--������� ���Ŀ�̼� ��ȸ
select avg(comm)   --null�����ʹ� ��� ���꿡�� ���ܵǹǷ� �̷��� ��ȸ�ϸ� �ȵȴ�
from emp;          --���⼭�� �ǹ̴� Ŀ�̼��� �޴� ������� ���Ŀ�̼��� �ȴ�


--������� Ŀ�̼��� �޴� ����� ���� ��ȸ
select count(*)
from emp
where comm is not null ;

select count(comm) from emp ;  --count�� null�� �ڵ� ����


--�ִ�޿�, �ּұ޿� ��ȸ
select max(sal), min(sal) from emp;


--���ڵ� �ִ�,�ּ� ��ȸ ����
select max(ename), min(ename) from emp;


--������� ������ ������ ��ȸ�ϼ���. (������ �ߺ����� ����� �׷����� ������ ��ȸ)

-- select * from emp;

select  count(distinct job) from emp;

---------------------------------------------------------------------------

/*

[group by ��] �׷��Լ��� ������ �׷��� �����ϴ� ��

        ��) �μ��� �޿��� �հ踦 ��ȸ�ϼ���.
            ���޺� �޿��� ����� ��ȸ�ϼ���.
        +����
            select �÷��̸�1, �÷��̸�2, �׷��Լ���...
            from ���̺��̸�
            [where ���ǽ�]
            group by �÷��̸�1, �÷��̸�2,... ;
            
        +���� 
            �׷�ȭ ������ �Ǵ� (group by ���� �����) �÷���� �׷��Լ��� ���� ��ȸ�� �� �ִ�.
        +����
            �������� �̿��ؼ� �׷��Լ���꿡 ����� �����͸� �� �� �ִ�.
        +����
            �׷�ȭ ������ �÷���ü�� �ƴϾ �ȴ�. �÷� �� �Ϻκ��� �̿��ص� �׷�ȭ�� �����ϴ�.



*/


   /*  [HAVING ��]
   �׷�ȭ�� ��� ���� �׷� �߿��� ��ȸ�� ���Խ�ų �׷��� �����ϴ� ������ GROUP BY �� ����
   �ܵ����� ����� �� ����. �ݵ�� GROUP BY ���� ���� ����ؾ� �Ѵ�.
   (�׷�ȭ�� ����� �ɷ����� ��)
    +����
            SELECT �׷��Լ���..
            FROM ���̺��̸�
            [WHERE ���ǽ�]
            GROUP BY �׷�ȭ�����÷�
            [HAVING ���ǽ�] ���ǽ��� ������ ������ ��� ��������(and / or) �� ó�����ش�
            [order by �÷��̸� asc �Ǵ� desc, �÷��̸� asc �Ǵ� desc,...]
            ;
   
   
   
    */


--�μ��� �μ���ȣ, �ִ�޿�, �ּұ޿�, ��ձ޿�, �޿��հ�, ������� ��ȸ
select deptno, max(sal), min(sal), trunc(avg(sal),2), sum(sal), count(*) �����
from emp
group by deptno;

-- ���޺��� ������� ��ȸ

select count(ename)
from emp
group by job;

-- �μ��� �ּұ޿�

select min(sal)
from emp
group by deptno;




--�� ���޺� �޿��հ�, ��ձ޿� ��ȸ

select sum(sal), avg(sal)
from emp
group by job;

--�Ի�⵵�� �Ի�⵵, ��ձ޿�, �޿��հ�,�Ի���� ��ȸ
select to_char(hiredate, 'yyyy'), avg(sal), sum(sal), count(ename)
from emp
group by to_char(hiredate, 'yyyy');        --year(hiredate) �ƴ�




--������� �̸� ���ڼ��� 4,5������ ����� ��ȸ
--1. �׷�ȭ�����ʰ� ��ȸ�ϼ���
--2. (group by���� �̿��ؼ� ó��)

select count(*)
from emp
where length(ename) in (4,5) ;

select
from
group by ename 

--�μ����� ��� �޿��� ��ȸ�ϼ���. ��, �μ���ձ޿��� 2000�̻��� �μ��� ��ȸ
select deptno, avg(sal)
from emp
where avg(sal)>=2000   --�׷��Լ��� where���� ����Ҽ�����  error
group by deptno
;


select deptno �μ���ȣ, avg(sal) �μ���ձ޿�
from emp
group by deptno                --�׷�ȭ�Լ��� �ɷ����� �� having��
having avg(sal) >= 2000
;

-- 30�� �μ� ������� ���޺� �޿���� ��ȸ

select job, trunc(avg(sal),2)
from emp
where deptno=30   --where ��ü ������ �ɷ����� ����? 
group by job;

--���޺��� ������� ��ȸ (��, ������� 1���� ������ ��ȸ���� ����)

select job, count(*) �����
from emp
group by job
having count(*) <> 1 ;


--81�⵵ �Ի��� ������� �޿��հ踦 ���޺��� ��ȸ
--��, ���޺� ��ձ޿��� 1000�̸��� ������ ��ȸ���� �ʰ� �ϼ���

select sum(sal), job,  to_char(hiredate, 'yyyy') 
from emp
group by job

having avg(sal) >1000;



--81�⵵ �Ի��� ������� �޿��հ踦 ������� �̸����̺��� �׷�ȭ�ϼ���
--(��, �� �޿� �հ谡 2000�̸��� �׷��� ��ȸ���� �����ϼ���)
--(�޿��հ谡 ���� �������� ��ȸ�ǰ� �ϼ���)

select 
from





--������� �̸� ���̰� 4,5������ ������� �μ��� ������� ��ȸ�ϼ���
--(��, ������� 0�� �μ��� ��ȸ���� �����ϼ���)
--(�μ���ȣ ���� �������� �����ϼ���)


select count(to_char(ename) in 4,5)

from emp;

order by deptno asc;






--����� �� ù ���ں��� �׷�ȭ�ؼ� ù����,  �޿��� �հ踦 ��ȸ

SELECT SUBSTR(ENAME, 1,1) ,SUM(SAL)
FROM EMP GROUP BY SUBSTR(ENAME, 1,1);
-------------------------------------------------------------------------

--[ decode�Լ��� �׷��Լ��� ����]

--�μ����� �޿��� ���,
--10�� �μ��� ���, 20�� �μ��� �޿��հ�, 30�� �μ��� �ִ�޿� ��ȸ


select deptno, decode(deptno, 10, avg(sal),
                              20, sum(sal),
                              30, max(sal)) �μ����޿�
from emp group by deptno ;


--------------------------------------------------------------------------


/*
  [�������� sub query, ������] ���Ǹ�� ���� �ٽ� ���Ǹ���� ���Ե� �� �ִµ� �� ���Ե�
                            ���Ǹ���� �������Ƕ� �Ѵ�.
 +����
 
                            


*/
--SMITH ����� ���� �μ� ������� ����̸�, �μ���ȣ, ���� ��ȸ

SELECT ENAME, DEPTNO, JOB
FROM EMP
WHERE DEPTNO=20;  



SELECT DEPTNO
FROM EMP
WHERE ENAME='SMITH';



SELECT
    ENAME, DEPTNO, JOB
FROM
    EMP
WHERE 
    DEPTNO= (SELECT DEPTNO
                FROM EMP
                WHERE ENAME='SMITH');


SELECT ename, job (select JOB
                    from emp
                    where ename='MILLER'
                     ) ����
FROM EMP
WHERE ename='KING'
;


--select ���� ���Ե� ��������
--�ݵ�� ������ �����÷����� ��ȸ�Ǿ�� �Ѵ�
--'SMITH'�� ����̸�, ����, �μ���ȣ, �ҼӺμ���ձ޿��� ��ȸ�ϼ���.


SELECT
ename, job, deptno,
(SELECT avg(sal)
FROM emp
WHERE deptno= (select deptno from emp where ename = 'SMITH'))

)
FROM emp

;


--SMITH ����� �μ���ձ޿�
SELECT avg(sal)
FROM emp
WHERE deptno= (select deptno from emp where ename = 'SMITH');



--������� ����̸�, �μ���ȣ, �μ��ִ�޿�, �μ������� ��ȸ�ϼ���

SELECT
    e.ename, e.deptno,
            ( select max(sal)
            from emp
             where deptno=e.deptno )�μ��ִ�޿�, 
           
            (select count(*)
            from emp
            where deptno=e.deptno) �μ�����
FROM emp e ;


---------------------------------------------------------------------------

--����� �� �ҼӺμ� ��ձ޿����� �޿��� ���� ������� ����̸�, �μ���ȣ,
--�μ���ձ޿��� ��ȸ

--(where������ group�Լ� ������)


select e.ename, e.deptno, e.sal �޿�,
        ( select trunc(avg(sal), 1)
          from emp
          where deptno=e.deptno ) �μ���ձ޿�
from emp e
where sal < (select avg(sal)
             from emp
             where deptno=e.deptno  );











