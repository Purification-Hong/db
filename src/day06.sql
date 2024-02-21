/*

where���� ���Ǵ� ��������
1. ������ �����÷����� ��ȸ�Ǵ� ���
    => �Ϲ� ������ �Է��ϴ� �������� ����Ѵ�
    
    'smith'����� ���� �μ��� ����� ����̸�, ����, �μ���ȣ�� ��ȸ
    
    select ename, job, deptno
    from emp
    where deptno = (select deptno from emp where ename='SMITH') ;

2. ���������� ����� ������ �����÷����� ��ȸ�Ǵ� ���
    => �����Ͱ� ������ ��ȸ�Ǵ� ����̹Ƿ� ���߰� �񱳿����ڷ� ó���ؾ� �Ѵ�
    
    IN
    =>�������� ������ �� �ϳ��� ������ �Ǵ� ���
      ����� �� �ִ� �����ڴ� ���� ���������� ����񱳿����� �Ѵ�
      
      +����
      �÷��̸� IN (��������)
        
        
    ANY
    =>�������� ������ �� �ϳ��� ������ �Ǵ� ���
      ����� �� �ִ� �����ڴ� ��� �񱳿����ڸ� ����� �� �ִ�
      
      +����
      �÷��̸� =  ANY (������ �����÷� ��������)
      �÷��̸� >= ANY (������ �����÷� ��������)
      �÷��̸� < ANY (������ �����÷� ��������) 
      ...
     
    ALL
    =>�������� �����Ͱ� ��� ���ǿ� �¾ƾ� �Ǵ� ���
        +����
        ����ó���� ũ��(>), �۴�(<) ��� ���� �񱳵� �����ϴ�.


3. ������ �����÷����� ��ȸ�Ǵ� ���
    exists
    =>���������� ����� �����ϸ� true�� ó���ǰ� ������ false�� ó���Ǵ� ������.
      ���� �÷��� ������� �ʴ´�.














*/
--10�� �μ� ������ ���� ������ ������� ����̸�, ���� ��ȸ

SELECT ENAME, JOB 
FROM EMP
WHERE JOB IN (SELECT JOB FROM EMP WHERE DEPTNO=10);


--��� �μ��� ��ձ޿����� �޿��� ���� ����� ����̸�, ����, �޿��� ��ȸ
SELECT AVG(SAL)
FROM EMP
GROUP BY DEPTNO ;


SELECT ename, job, sal 
FROM emp 
WHERE sal > any 
(select avg(sal) 
from emp 
group by deptno);

select * from emp;

select avg(sal) 
from emp 
group by deptno;





SELECT ename, job, sal 
FROM emp 
WHERE sal > all 
(select avg(sal) 
from emp 
group by deptno);





--�̹��޿� comm�� ������ ����. 'smith'����� �ٹ��ϰ� ������ ��� ����� Ŀ�̼��� 20% �λ��ؼ�
--�����ϰ� ������ �������� �ʴ´�. ��, Ŀ�̼��� ���� ����� 200���� �ϰ� ����ϱ�� �Ѵ�.

SELECT
ename, sal, nvl2(comm, comm*1.2, 200*1.2) ����Ŀ�̼�
FROM
emp
WHERE
exists ( select *
        from emp
        where ename='smith');


--������ 'MANAGER'�� ����麸�� �޿��� �Ѹ��̶� �޿��� ��������� 
--����̸�, ����, �޿��� ��ȸ 

SELECT ENAME, JOB, SAL
FROM EMP
WHERE   SAL > ANY 
        (SELECT SAL
        FROM EMP
        WHERE JOB ='MANAGER') ;

--��� ������ 'MANAGER'�� ��� ����麸�� �޿����� �޿��� ��������� 
--����̸�, ����, �޿��� ��ȸ 


SELECT ENAME, JOB, SAL
FROM EMP
WHERE   SAL > ALL 
        (SELECT SAL
        FROM EMP
        WHERE JOB ='MANAGER') ;

--------------------------------------------------------------------
/* 
���������� ����� ���̺� ó�� ����� �� �ִ�. �̷��� from���� ���Ե� �������Ǹ�
������ "�ζ��� ��"��� �θ���

    +����
    select �÷��̸���...
    from (��������)[��Ī] ;
    
    +����
    �ζ��� ���� select���� �Լ��� ���ɶ��� �ݵ�� ��Ī�� �ο��ؾ� �Ѵ�.
    �ζ��� ���� select���� ��Ī���� �ٿ����� �÷��̸��� ��Ī���� ������ �ȴ�(���� �̸����� ��ȸ�Ұ�)
    
  
*/


--�μ��� �μ���ȣ, �޿��հ�, ��ձ޿�, �ִ�޿�, �ּұ޿�, �������
--�ζ��κ並 �̿��ؼ� ��ȸ

select dno, a �޿��հ� ,trunc(c,2) ��ձ޿� ,d,e
from 
(select deptno dno, sum(sal) a, avg(sal) c, max(sal) d, min(sal) e, count(*)  
from emp
group by deptno


);
 /*deptno�� dno�� �����ڴ� */
--ù��° select���� sum(sal)�� �� �� ����. -> �̰��� �Լ� ȣ���Ѵٴ� �ǹ��̴�
--�׷��� ��Ī�� ����ؾ��Ѵ�


---------------------------------------------------------------------------
/*
���� join
=>�� �� �̻��� ���̺��� ���ϴ� �����͸� ��ȸ�ϴ� ���

�����ͺ��̽� ����� �������� ���Ἲ Ȯ���� ���ؼ� ���̺��� ����� ���Ҵ�.
�̶� �и��� �����͸� ���ļ� ��ȸ�ؾ� �ϴ� ��찡 �߻��� �� �ִ�.
�׶� �и��� �����͸� �������� ����̴�.

+����
select �÷��̸���...
from ���̺�1, ���̺�2,..
where
�������ǽ�1 and �������ǽ�2,..;


����Ŭ�� �����������ͺ��̽�(rdbms)�̴�. 
������ �����ͺ��̽��� ��ƼƼ ���� ���踦 �����ؼ� �����͸� �����ϴ� �����ͺ��̽�.
�׷��� �и��� ��ƼƼ�鿡�� �����͸� �������� ��ǻ�ʹ� � �����Ͱ� ����Ǿ��ִ� ������������
�� �� �����Ƿ� ��� ������ ������ ���� ��ȸ�� �ȴ�.
�� ��ȸ�� ��� ������ ������ ����� Cartesian Product (��ī��Ʈ ��) �̷� ������ cross join�̶�� �θ���

+������ ����
cross join
=>cartesian product�� ��ȸ�ϴ� join, �Ϲ������� ������� �ʴ� ����

inner join
=>Cartesian product ������ �ɷ����� �ϴ� ����

outer join
=>cartesian product ���� ���� �����͸� ��ȸ�ϴ� ����

equi join
=>���� ������ ����񱳿������� ó���ϴ� ����

non equi join
=>���� ������ ����񱳿����� �ƴ� ����

self join
=>



*/---------------------------------------------------------------------


create table ecolor(
cno number (5)
    constraint ECOLOR_NO_PK primary key,
ecname varchar2(20 char)
    constraint ECOLOR_NAME_UK unique
    constraint ECOLOR_NAME_NN not null,
code char(7)
    constraint ECOLOR_CODE_UK unique
    constraint ECOLOR_CODE_NN not null);




create table kcolor(
cno number (5)
    constraint KCOLOR_NO_PK primary key,
kcname varchar2(20 char)
    constraint KCOLOR_NAME_UK unique
    constraint KCOLOR_NAME_NN not null,
code char(7)
    constraint KCOLOR_CODE_UK unique
    constraint KCOLOR_CODE_NN not null
);

INSERT INTO 
    ecolor
VALUES(
    10, 'RED', '#FF0000'
);

INSERT INTO 
    ecolor
VALUES(
    20, 'GREEN', '#00FF00'
);

INSERT INTO 
    ecolor
VALUES(
    30, 'BLUE', '#0000FF'
);


INSERT INTO 
    kcolor
VALUES(
    10, '����', '#FF0000'
);

INSERT INTO 
    kcolor
VALUES(
    20, '�ʷ�', '#00FF00'
);

INSERT INTO 
    kcolor
VALUES(
    30, '�Ķ�', '#0000FF'
);

commit;


select * 
from ecolor e, kcolor k
where e.cno=k.cno;


select e.cno Į���ȣ, ecname ����Į���̸�, kcname �ѱ�Į���̸�, k.code Į���ڵ�
from ecolor e, kcolor k
where e.cno=k.cno;


--������� ����̸�, ����, �μ��̸��� ��ȸ
select ename, job, d.deptno, dname
from emp e, dept d
where e.deptno=d.deptno
;



--�Ϲ����ǰ� ���� ����� �� �ִ�.
--81�� �Ի��� ����� ����̸�, ����, �Ի�⵵, �μ���ġ�� ��ȸ

select ename, job, to_char(hiredate,'YYYY') �Ի�⵵, loc
from emp e, dept d
where
--��������
e.deptno=d.deptno and to_char(hiredate, 'YY')='81';

--NON EQUI JOIN �������ǿ� ����ϴ� �����ڰ� ��Һ񱳸� �ϴ� ���
--������� ����̸�, ����, �޿�, �޿������ ��ȸ

SELECT ename, job, sal, grade, losal, hisal 
FROM emp, salgrade
WHERE --sal >= losal and sal <=hisal
sal between losal and hisal;


--�������� ������ ���ÿ� �����ؼ� ��ȸ�Ҽ� �ִ�

/*
������� ����̸�, ����, �޿�, �μ���ȣ, �μ��̸�, �޿������ ��ȸ�ϼ���. */

select
ename, job, sal, d.deptno, dname, grade
from
emp e, dept d, salgrade
where  
--��������� �μ����� ����
e.deptno=d.deptno 
and sal between losal and hisal;


--30�� �μ� ������� ����̸�, ����, �μ���ġ, �޿�, �޿���� ��ȸ
select ename ����̸�, job ����, loc �μ���ġ, sal �޿�, grade �޿����
from emp e, dept d, salgrade  
where --�޿���ް� ������� ����
sal between losal and hisal 
--�� ����� �μ����� ����
and e.deptno=d.deptno
--�Ϲ�����
and e.deptno=30;


--self join


--������� ��� inner join 

--������� ����̸�, ����, ����ȣ, ����̸��� ��ȸ

select
ename ����̸�, job ����, mgr ����ȣ,
(
select ename
from emp
where 
empno=e.mgr


)

from
 emp e;


--������ �̿��ϴ� ���


select
e.ename ����̸�, e.job ����, e.mgr ����ȣ, s.empno, s.ename ����̸�

from
emp e, --����������̺�
emp s --����������̺�

where e.mgr = s.empno(+);
 
--outer join - cartesian product���� ���� �����͸� �����ϱ� ���ؼ��� +�� �ٿ��ش�
    --   (null�� ǥ���ؾ��� �÷���)

/*  ������� ����̸�, ����, �Ի�⵵, �μ���ȣ, �μ��̸�, ����, �޿����, 
����̸�, �������, �������� ��ȸ. ��, 82�⿡ �Ի��� ����� ��ȸ */

select 
e.ename ����̸�, e.job ����, to_char(e.hiredate,'YYYY') �Ի�⵵, 
e.deptno �μ���ȣ, dname �μ��̸�, 
e.sal �޿�, grade �޿����, 
s.ename ����̸�, s.job �������, s.sal ������

from
emp e, --�������,
dept d, 
salgrade,
emp s   --�������

where
e.mgr=s.empno(+) and e.sal between losal and hisal 
and e.deptno=d.deptno and to_char(e.hiredate, 'YYYY') ='1982'
;








---------------------------------------------------------------------------------

--���⼭���� outer join
































