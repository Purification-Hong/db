
/* 기본 문제들 */

-- 1) 사원들의 사원이름, 부서번호를 조회하세요
SELECT ename, empno
FROM emp ;



-- 2) 사원들의 부서번호를 조회 (단, 중복없음)
SELECT DISTINCT empno
FROM emp;



-- 3) 사원들의 사원이름, 직급, 연봉을 조회
--(연봉은 급여*12 으로 계산)
SELECT ename, job, sal*12
FROM emp;



-- 4)사원들의 사원이름, 급여, 커미션, 연봉을 조회
--(연봉은 급여 * 12 + 커미션 으로 계산. 
--커미션이 없는 사원은 커미션 50을 지급하시오 -  NVL()로 처리)
SELECT ename, sal, comm, sal*12+comm, NVL(comm, 50)
FROM emp;




--5) 사원들의 사원번호, 사원이름, 직급을 조회
--(사원이름은 이름뒤에 '사원'붙여져서 조회)

SELECT empno, ename||'사원', sal

FROM emp;




--------------------------------------------------------------------------

-- 6) 부서번호가 20번인 사원들의 사원번호, 사원이름, 직급, 부서번호를 조회

SELECT empno, ename, job, sal 
FROM emp
WHERE empno=20;


-- 7) 직급이 'SALESMAN'인 사원들의 사원이름, 직급, 부서번호를 조회
SELECT ename, job, empno
FROM emp
WHERE job='SALESMAN';


--8) 급여가 1000만원 미만인 사원들의 사원번호, 사원이름, 급여를 조회
SELECT empno, ename, sal 
FROM emp  
WHERE sal<1000;


--9) 입사일이 81년 9월 8일인 사원의 사원이름, 직급, 입사일을 조회
SELECT ename, job, hiredate
FROM emp
WHERE hiredate='81/09/08';

--10) 사원의 이름이 'M' 이후 문자로 시작하는 사원 중 급여가 
--1000만원 이상인 사원의 사원이름, 직급, 급여 조회
SELECT ename, job, sal
FROM emp
WHERE ename LIKE 'M%' and sal >=1000;



-- 11) 직급이 'MANAGER' 이고 급여가 1000만원 보다 높고 부서번호가 10번인
--사원의 사원이름, 직급, 급여, 부서번호를 조회
SELECT ename, job, sal, empno
FROM emp
WHERE job='MANAGER' and sal > 1000 and empno=10;



--12) 직급이 'MANAGER'가 아닌 사원들의 사원이름, 직급, 입사일을 조회
--(NOT연산자를 사용해서 처리)
SELECT ename, job, hiredate
FROM emp  
WHERE job NOT IN('MANAGER') ;


--13) 사원이름이 'C'로 시작하는 것보다 크고 'M'으로 시작하는 것보다 작은 사원의
--사원이름, 직급, 급여를 조회 (BETWEEN-AND 연산자 이요)
SELECT ename, job, sal
FROM emp
WHERE ename BETWEEN 'D' AND 'L';


-- 14) 급여가 800, 950만원이 아닌 사원들의 사원이름, 직급, 급여를 조회하세요
--(NOT IN 연산자 사용해서 처리)
SELECT ename, job, sal 
FROM emp
WHERE sal NOT IN(800, 950);




-- 15) 사원이름이 'S'로 시작하고 이름 글자수가 다섯글자인 사원들의 사원이름, 직급을 조회
SELECT ename, job 
FROM emp
WHERE ename LIKE 'S____';





-- 16)입사일이 3일인 사원들의 사원이름, 직급, 입사일을 조회하세요.
SELECT ename, job, hiredate
FROM emp 
WHERE hiredate LIKE '__/__/03';





--17)사원이름이 4글자 또는 5글자인 사원들의 사원이름, 직급, 급여를 조회하세요.
SELECT ename, job, sal
FROM emp  
WHERE ename LIKE '____' OR ename LIKE '_____';


--18)입사년도가 81년이거나 82년인 사원들의 사원이름, 급여, 입사일을 조회하세요.
    --(단, 그병는 현재급여보다 10% 인상된 급여로 조회하세요.)


SELECT ename, sal, hiredate
FROM emp  
WHERE hiredate LIKE '81/__/__' OR hiredate LIKE '82/__/__';



--19) 이름이 'S'로 끝나는 사원들의 사원이름, 급여, 커미션을 조회하세요.
--(단, 커미션은 현재 커미션보다 100 증가된 커미션으로 하고 커미션이 없는 사원은 50으로 조회되게 하세요.)

SELECT ename, sal, comm+100, NVL(comm, 50)
FROM emp  
WHERE ename LIKE '%S';






























