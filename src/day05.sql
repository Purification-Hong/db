--[그룹함수]
--여러행의 데이터를 하나로 만들어서 연산하고 결과를 알려주는 함수

/* 
    +참고
        그룹 함수는 결과가 오직 한개만 나오게 된다. 따라서 그룹함수는 결과가 여러개
        나오는 경우와 혼용해서 사용할 수 없다. 오직 여러행의 결과가 한행으로만 
        나오는 것과만 사용할 수 있다.
        
    예)
        select ename from emp; - 14개의 행이 발생
        select sum(sal)from emp; - sum(sal) : 사원들의 급여의 합계를 계산해서 반환해주는 함수
                                따라서 사원들의 합계는 여러행의 값들이 단일값으로 계산되어서
                                만들어질 것이다.
        따라서
        select sal, sum(sal) from emp; 는 사용할 수 없다.
        
    예) 
        select ename, sum(sal) from emp; 이 질의명령 역시 불가능하다.
        
    +참고 그룹함수끼리는 같이 사용할 수 있다
    
            1. sum() 
                합계.
                +형식
                    sum(컬럼이름)
            2. avg()
                데이터의 평균을 구하는 함수
                +형식
                     avg(컬럼이름)
                +참고
                    null 데이터의 경우는 평균을 계산하는 연산에서 완전히 제외된다
            3. count()
                지정한 필드 중에서 데이터가 존재하는 컬럼의 수를 알려준다
                +참고
                    데이터에 '*'를 입력하면 행의 수를 조회한다.
            4. max() / min()
                최대/최소값을 알려주는 함수
                +형식
                    max(컬럼이름)
            5. stddev()
                표준편차 반환해주는 함수
                
            6. variance()
                분산 반환해주는 함수

*/


--사원들의 총급여와 평균급여를 조회
select sum(sal), trunc(avg(sal), 2)
from emp;

--사원들의 평균커미션 조회
select avg(comm)   --null데이터는 평균 연산에서 제외되므로 이렇게 조회하면 안된다
from emp;          --여기서의 의미는 커미션을 받는 사원들의 평균커미션이 된다


--사원들중 커미션을 받는 사원의 수를 조회
select count(*)
from emp
where comm is not null ;

select count(comm) from emp ;  --count는 null은 자동 제외


--최대급여, 최소급여 조회
select max(sal), min(sal) from emp;


--문자도 최대,최소 조회 가능
select max(ename), min(ename) from emp;


--사원들의 직급의 갯수를 조회하세요. (직급을 중복없이 만들고 그런다음 갯수를 조회)

-- select * from emp;

select  count(distinct job) from emp;

---------------------------------------------------------------------------

/*

[group by 절] 그룹함수에 적용할 그룹을 지정하는 절

        예) 부서별 급여의 합계를 조회하세요.
            직급별 급여의 평균을 조회하세요.
        +형식
            select 컬럼이름1, 컬럼이름2, 그룹함수들...
            from 테이블이름
            [where 조건식]
            group by 컬럼이름1, 컬럼이름2,... ;
            
        +참고 
            그룹화 기준이 되는 (group by 절에 기술한) 컬럼들과 그룹함수는 같이 조회될 수 있다.
        +참고
            조건절을 이용해서 그룹함수계산에 적용된 데이터를 고를 수 있다.
        +참고
            그룹화 기준은 컬럼전체가 아니어도 된다. 컬럼 중 일부분을 이용해도 그룹화가 가능하다.



*/


   /*  [HAVING 절]
   그룹화한 경우 계산된 그룹 중에서 조회에 포함시킬 그룹을 지정하는 조건절 GROUP BY 절 없이
   단독으로 사용할 수 없다. 반드시 GROUP BY 절과 같이 사용해야 한다.
   (그룹화한 결과를 걸러내는 절)
    +형식
            SELECT 그룹함수들..
            FROM 테이블이름
            [WHERE 조건식]
            GROUP BY 그룹화기준컬럼
            [HAVING 조건식] 조건식이 여러개 나열될 경우 논리연산자(and / or) 로 처리해준다
            [order by 컬럼이름 asc 또는 desc, 컬럼이름 asc 또는 desc,...]
            ;
   
   
   
    */


--부서별 부서번호, 최대급여, 최소급여, 평균급여, 급여합계, 사원수를 조회
select deptno, max(sal), min(sal), trunc(avg(sal),2), sum(sal), count(*) 사원수
from emp
group by deptno;

-- 직급별로 사원수를 조회

select count(ename)
from emp
group by job;

-- 부서별 최소급여

select min(sal)
from emp
group by deptno;




--각 직급별 급여합계, 평균급여 조회

select sum(sal), avg(sal)
from emp
group by job;

--입사년도별 입사년도, 평균급여, 급여합계,입사원수 조회
select to_char(hiredate, 'yyyy'), avg(sal), sum(sal), count(ename)
from emp
group by to_char(hiredate, 'yyyy');        --year(hiredate) 아님




--사원들의 이름 글자수가 4,5글자인 사원수 조회
--1. 그룹화하지않고 조회하세요
--2. (group by절을 이용해서 처리)

select count(*)
from emp
where length(ename) in (4,5) ;

select
from
group by ename 

--부서별로 평균 급여를 조회하세요. 단, 부서평균급여가 2000이상인 부서만 조회
select deptno, avg(sal)
from emp
where avg(sal)>=2000   --그룹함수는 where절에 사용할수없다  error
group by deptno
;


select deptno 부서번호, avg(sal) 부서평균급여
from emp
group by deptno                --그룹화함수를 걸러내는 건 having절
having avg(sal) >= 2000
;

-- 30번 부서 사원들의 직급별 급여평균 조회

select job, trunc(avg(sal),2)
from emp
where deptno=30   --where 전체 데이터 걸러내는 역할? 
group by job;

--직급별로 사원수를 조회 (단, 사원수가 1명인 직급은 조회에서 제외)

select job, count(*) 사원수
from emp
group by job
having count(*) <> 1 ;


--81년도 입사한 사원들의 급여합계를 직급별로 조회
--단, 직급별 평균급여가 1000미만인 직급은 조회되지 않게 하세요

select sum(sal), job,  to_char(hiredate, 'yyyy') 
from emp
group by job

having avg(sal) >1000;



--81년도 입사한 사원들의 급여합계를 사원들의 이름길이별로 그룹화하세요
--(단, 총 급여 합계가 2000미만인 그룹은 조회에서 제외하세요)
--(급여합계가 높은 순서먼저 조회되게 하세요)

select 
from





--사원들의 이름 길이가 4,5글자인 사원들의 부서별 사원수를 조회하세요
--(단, 사원수가 0인 부서는 조회에서 제외하세요)
--(부서번호 기준 오름차순 정렬하세요)


select count(to_char(ename) in 4,5)

from emp;

order by deptno asc;






--사원들 중 첫 문자별로 그룹화해서 첫문자,  급여의 합계를 조회

SELECT SUBSTR(ENAME, 1,1) ,SUM(SAL)
FROM EMP GROUP BY SUBSTR(ENAME, 1,1);
-------------------------------------------------------------------------

--[ decode함수와 그룹함수의 조합]

--부서별로 급여를 계산,
--10번 부서는 평균, 20번 부서는 급여합계, 30번 부서는 최대급여 조회


select deptno, decode(deptno, 10, avg(sal),
                              20, sum(sal),
                              30, max(sal)) 부서통계급여
from emp group by deptno ;


--------------------------------------------------------------------------


/*
  [서브질의 sub query, 부질의] 질의명령 내에 다시 질의명령이 포함될 수 있는데 이 포함된
                            질의명령을 서브질의라 한다.
 +참고
 
                            


*/
--SMITH 사원과 같은 부서 사원들의 사원이름, 부서번호, 직급 조회

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
                     ) 동료
FROM EMP
WHERE ename='KING'
;


--select 절에 포함된 서브질의
--반드시 단일행 단일컬럼으로 조회되어야 한다
--'SMITH'의 사원이름, 직급, 부서번호, 소속부서평균급여를 조회하세요.


SELECT
ename, job, deptno,
(SELECT avg(sal)
FROM emp
WHERE deptno= (select deptno from emp where ename = 'SMITH'))

)
FROM emp

;


--SMITH 사원의 부서평균급여
SELECT avg(sal)
FROM emp
WHERE deptno= (select deptno from emp where ename = 'SMITH');



--사원들의 사원이름, 부서번호, 부서최대급여, 부서원수를 조회하세요

SELECT
    e.ename, e.deptno,
            ( select max(sal)
            from emp
             where deptno=e.deptno )부서최대급여, 
           
            (select count(*)
            from emp
            where deptno=e.deptno) 부서원수
FROM emp e ;


---------------------------------------------------------------------------

--사원들 중 소속부서 평균급여보다 급여가 적은 사원들의 사원이름, 부서번호,
--부서평균급여를 조회

--(where절에는 group함수 사용못함)


select e.ename, e.deptno, e.sal 급여,
        ( select trunc(avg(sal), 1)
          from emp
          where deptno=e.deptno ) 부서평균급여
from emp e
where sal < (select avg(sal)
             from emp
             where deptno=e.deptno  );











