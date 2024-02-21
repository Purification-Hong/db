/*

where절에 사용되는 서브질의
1. 단일행 단일컬럼으로 조회되는 경우
    => 일반 데이터 입력하는 형식으로 사용한다
    
    'smith'사원과 같은 부서의 사원들 사원이름, 직급, 부서번호를 조회
    
    select ename, job, deptno
    from emp
    where deptno = (select deptno from emp where ename='SMITH') ;

2. 서브질의의 결과가 다중행 단일컬럼으로 조회되는 경우
    => 데이터가 여러개 조회되는 경우이므로 다중값 비교연산자로 처리해야 한다
    
    IN
    =>여러개의 데이터 중 하나만 맞으면 되는 경우
      사용할 수 있는 연산자는 없고 묵시적으로 동등비교연산을 한다
      
      +형식
      컬럼이름 IN (서브질의)
        
        
    ANY
    =>여러개의 데이터 중 하나만 맞으면 되는 경우
      사용할 수 있는 연산자는 모든 비교연산자를 사용할 수 있다
      
      +형식
      컬럼이름 =  ANY (다중행 단일컬럼 서브질의)
      컬럼이름 >= ANY (다중행 단일컬럼 서브질의)
      컬럼이름 < ANY (다중행 단일컬럼 서브질의) 
      ...
     
    ALL
    =>여러개의 데이터가 모두 조건에 맞아야 되는 경우
        +참고
        조건처리는 크다(>), 작다(<) 등과 같은 비교도 가능하다.


3. 다중행 다중컬럼으로 조회되는 경우
    exists
    =>서브질의의 결과가 존재하면 true로 처리되고 없으면 false로 처리되는 연산자.
      비교할 컬럼을 기술하지 않는다.














*/
--10번 부서 사원들과 같은 직급의 사원들의 사원이름, 직급 조회

SELECT ENAME, JOB 
FROM EMP
WHERE JOB IN (SELECT JOB FROM EMP WHERE DEPTNO=10);


--모든 부서의 평균급여보다 급여가 높은 사원의 사원이름, 직급, 급여를 조회
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





--이번달에 comm을 지급할 예정. 'smith'사원이 근무하고 있으면 모든 사원의 커미션을 20% 인상해서
--지급하고 없으면 지급하지 않는다. 단, 커미션이 없는 사원은 200으로 하고 계산하기로 한다.

SELECT
ename, sal, nvl2(comm, comm*1.2, 200*1.2) 지급커미션
FROM
emp
WHERE
exists ( select *
        from emp
        where ename='smith');


--직급이 'MANAGER'인 사원들보다 급여가 한명이라도 급여가 높은사원의 
--사원이름, 직급, 급여를 조회 

SELECT ENAME, JOB, SAL
FROM EMP
WHERE   SAL > ANY 
        (SELECT SAL
        FROM EMP
        WHERE JOB ='MANAGER') ;

--모든 직급이 'MANAGER'인 모든 사원들보다 급여보다 급여가 높은사원의 
--사원이름, 직급, 급여를 조회 


SELECT ENAME, JOB, SAL
FROM EMP
WHERE   SAL > ALL 
        (SELECT SAL
        FROM EMP
        WHERE JOB ='MANAGER') ;

--------------------------------------------------------------------
/* 
서브질의의 결과를 테이블 처럼 사용할 수 있다. 이렇게 from절에 포함된 서브질의를
가르켜 "인라인 뷰"라고 부른다

    +형식
    select 컬럼이름들...
    from (서브질의)[별칭] ;
    
    +참고
    인라인 뷰의 select절에 함수가 사용될때는 반드시 별칭을 부여해야 한다.
    인라인 뷰의 select절에 별칭들이 붙여지면 컬럼이름은 별칭으로 고정이 된다(원래 이름으로 조회불가)
    
  
*/


--부서별 부서번호, 급여합계, 평균급여, 최대급여, 최소급여, 사원수를
--인라인뷰를 이용해서 조회

select dno, a 급여합계 ,trunc(c,2) 평균급여 ,d,e
from 
(select deptno dno, sum(sal) a, avg(sal) c, max(sal) d, min(sal) e, count(*)  
from emp
group by deptno


);
 /*deptno를 dno로 꺼내겠다 */
--첫번째 select에서 sum(sal)로 할 수 없다. -> 이것은 함수 호출한다는 의미이다
--그래서 별칭을 사용해야한다


---------------------------------------------------------------------------
/*
조인 join
=>두 개 이상의 테이블에서 원하는 데이터를 조회하는 방법

데이터베이스 설계시 데이터의 무결성 확보를 위해서 테이블을 만들어 놓았다.
이때 분리된 데이터를 합쳐서 조회해야 하는 경우가 발생할 수 있다.
그때 분리된 데이터를 가져오는 방법이다.

+형식
select 컬럼이름들...
from 테이블1, 테이블2,..
where
조인조건식1 and 조인조건식2,..;


오라클은 관계형데이터베이스(rdbms)이다. 
관계형 데이터베이스는 엔티티 간의 관계를 형성해서 데이터를 보관하는 데이터베이스.
그래서 분리된 엔티티들에서 데이터를 꺼내오면 컴퓨터는 어떤 데이터가 연결되어있는 데이터인지를
알 수 없으므로 모든 가능한 조합을 만들어서 조회가 된다.
이 조회된 모든 가능한 조합의 결과를 Cartesian Product (데카르트 곱) 이런 조인을 cross join이라고 부른다

+조인의 종류
cross join
=>cartesian product를 조회하는 join, 일반적으로 사요하지 않는 조인

inner join
=>Cartesian product 내에서 걸러내서 하는 조인

outer join
=>cartesian product 내에 없는 데이터를 조회하는 조인

equi join
=>조인 조건을 동등비교연산으로 처리하는 조인

non equi join
=>조인 조건이 동등비교연산이 아닌 조인

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
    10, '빨강', '#FF0000'
);

INSERT INTO 
    kcolor
VALUES(
    20, '초록', '#00FF00'
);

INSERT INTO 
    kcolor
VALUES(
    30, '파랑', '#0000FF'
);

commit;


select * 
from ecolor e, kcolor k
where e.cno=k.cno;


select e.cno 칼라번호, ecname 영문칼라이름, kcname 한글칼라이름, k.code 칼라코드
from ecolor e, kcolor k
where e.cno=k.cno;


--사원들의 사원이름, 직급, 부서이름을 조회
select ename, job, d.deptno, dname
from emp e, dept d
where e.deptno=d.deptno
;



--일반조건과 같이 사용할 수 있다.
--81년 입사한 사원의 사원이름, 직급, 입사년도, 부서위치를 조회

select ename, job, to_char(hiredate,'YYYY') 입사년도, loc
from emp e, dept d
where
--조인조건
e.deptno=d.deptno and to_char(hiredate, 'YY')='81';

--NON EQUI JOIN 조인조건에 사용하는 연산자가 대소비교를 하는 경우
--사원들의 사원이름, 직급, 급여, 급여등급을 조회

SELECT ename, job, sal, grade, losal, hisal 
FROM emp, salgrade
WHERE --sal >= losal and sal <=hisal
sal between losal and hisal;


--여러개의 조인을 동시에 적용해서 조회할수 있다

/*
사원들의 사원이름, 직급, 급여, 부서번호, 부서이름, 급여등급을 조회하세요. */

select
ename, job, sal, d.deptno, dname, grade
from
emp e, dept d, salgrade
where  
--사원정보와 부서정보 조인
e.deptno=d.deptno 
and sal between losal and hisal;


--30번 부서 사원들의 사원이름, 직급, 부서위치, 급여, 급여등급 조회
select ename 사원이름, job 직급, loc 부서위치, sal 급여, grade 급여등급
from emp e, dept d, salgrade  
where --급여등급과 사원정보 조인
sal between losal and hisal 
--위 결과가 부서정보 조인
and e.deptno=d.deptno
--일반조건
and e.deptno=30;


--self join


--여기까지 모두 inner join 

--사원들의 사원이름, 직급, 상사번호, 상사이름을 조회

select
ename 사원이름, job 직급, mgr 상사번호,
(
select ename
from emp
where 
empno=e.mgr


)

from
 emp e;


--조인을 이용하는 방법


select
e.ename 사원이름, e.job 직급, e.mgr 상사번호, s.empno, s.ename 상사이름

from
emp e, --사원정보테이블
emp s --상사정보테이블

where e.mgr = s.empno(+);
 
--outer join - cartesian product내에 없는 데이터를 조인하기 위해서는 +를 붙여준다
    --   (null로 표현해야할 컬럼에)

/*  사원들의 사원이름, 직급, 입사년도, 부서번호, 부서이름, 직급, 급여등급, 
상사이름, 상사직급, 상사봉급을 조회. 단, 82년에 입사한 사람만 조회 */

select 
e.ename 사원이름, e.job 직급, to_char(e.hiredate,'YYYY') 입사년도, 
e.deptno 부서번호, dname 부서이름, 
e.sal 급여, grade 급여등급, 
s.ename 상사이름, s.job 상사직급, s.sal 상사봉급

from
emp e, --사원정보,
dept d, 
salgrade,
emp s   --상사정보

where
e.mgr=s.empno(+) and e.sal between losal and hisal 
and e.deptno=d.deptno and to_char(e.hiredate, 'YYYY') ='1982'
;








---------------------------------------------------------------------------------

--여기서부터 outer join
































