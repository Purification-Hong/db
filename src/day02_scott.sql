/*
----------------------------------------------   
    [오라클 구성]
1.DBMS(데이터베이스 관리 시스템)
명령을 받아서 실행하는 프로그램의 일종
2.Data Bank
데이터를 보관하는 장소를 관리하는 도구

 참고] 데이터베이스의 성능은 DBMS에 따라서 달라진다.
데이터베이스를 조작하는 명령은 DBMS에 따라서 달라진다.


+++++++++++++++++++++++++++++++++++++++++
CRUD(Creat(insert) 추가 / Read(select) 조회/ 
     Update(update) 수정/ Delete(delete) 삭제)
 - 데이터베이스를 공부하는데 반드시 알아야할 4가지 명령
데이터를 조작하는 4가지 명령 방법

+++++++++++++++++++++++++++++++++++++++++
오라클이 데이터를 보관하는 방법 
- 테이블(개체, entity) 단위로 데이터를 보관한다.
- 테이블이란 마치 엑셀처럼 줄과 칸으로 구성되어 데이터를 보관하는 것
- 결론적으로 테이블이란 컬럼(=필드)과 레코드(=행, row)로 구성된 데이터를
 보관하는 기본 단위
    
    필드 = 속성, attribute, column, field   ->같은 의미와 단위, 형태의 데이터 모임
    레코드 = 행 ->같은 목적을 가진 데이터 모임, 레코드 한개가 데이터 한개라고 생각하기
    
    오라클은 사용자 계정 내부에 테이블이 만들어진다.
   이때 사용자 계정 내부에 존재하는 모든 테이블을 조회하는 방법

   select tname from tab;
    */

   select tname from tab;

 --tab : 계정내부에 생성된 테이블의 정보를 가지고 있는 시스템이 관리하는 테이블

--tab 테이블의 모든 데이터 조회
   select tab.* from tab;
   
   
   
/*
데이터베이스에서는 명령어의 대소문자는 구분하지 않는다.

[특정 테이블의 간략한 구조를 확인하는 방법]
형식> 
  DESC 테이블이름;
  DESCRIBE 테이블이름;
*/

DESC emp;
DESCRIBE emp;

/*  SELECT 질의명령 : 테이블이 가지고 있는 데이터(내용, 레코드들)을 확인하는 명령
형식) SELECT 
       [DISTINCT] 컬럼이름
    FROM
       테이블 이름
       [
        옵션
          ]
            ;            
            
   [DISTINCT] 는 중복되는 데이터를 한번만 출력해주는 명령         
            */
            
--사원들의 직급을 조회하세요
SELECT job FROM emp;
--사원들의 직급을 조회하세요 (중복없이)
SELECT DISTINCT job FROM emp;
--사원들의 직급과 부서번호를 조회하세요. 단, 중복되는 데이터는 한번만 조회되게 하세요
SELECT DISTINCT job, deptno  FROM emp ORDER BY deptno ASC;

   /* ORDER BY 정렬기준 정하는 절 : 조회 결과를 정렬해서 조회하고 싶을 때 사용하는 절
   ASC 오름차순 정렬 
   DESC 내림차순 정렬 */
   
   
--위 결과를 조회하는데 부서번호가 낮은 것부터 조회하고 부서번호가 같으면 직급을 내림차순으로 정렬하세요
SELECT DISTINCT job, deptno FROM emp ORDER BY deptno ASC, job DESC ;
   
   
/*
참고> 원칙적으로 조회할때는 조회할 컬럼이름을 하나씩 나열해서 조회하는 것이 원칙이다.
  *를 사용하게 되면 모든 컬럼을 조회하는데, 이 방법은 실무에서는 절대 사용하지 않는 방법.
참고> 질의명령 내에는 연산식을 포함할 수 있다. 연산식이 포함되면 연산한 결과를 조회하게 된다.  */

--사원들의 이름과 급여를 조회하세요. 급여는 현재 급여에 10% 인상된 급여로 조회되게 하세요.
-- (급여가 높은 사원순으로 정렬되서 조회되게 하세요)
SELECT ename, sal, sal*1.1 FROM emp ORDER BY sal DESC;

/* 조회되는 컬럼의 이름을 별칭을 이용하여 다르게 조회할 수 있다. 
형식> SELECT 
        컬럼이름1 AS "별칭이름1", 컬럼이름2 AS "별칭이름2",...
      FROM
        테이블이름
        ;
참고> 별칭에 공백이 들어가는 경우는 반드시 " "로 감싸줘야 한다. 
AS는 생략할 수 있다. 별칭에 공백이 없으면 " "를 생략해도 된다.

예) SELECT ename AS "사원이름" FROM emp;
SELECT ename  "사원이름" FROM emp;
SELECT ename AS 사원이름 FROM emp;             */

/* NULL 데이터
: 컬럼에는 데이터가 기록되어야 하는데
가끔은 기록할 데이터가 준비되어있는 경우도 있다
이런경우 그 컬럼의 데이터는 비워서 한행을 입력할 것이다.
이처럼 컬럼의 데이터가 없는 상태를 NULL데이터라고 말한다.

(중요)NULL데이터는 모든 연산에서 제외가 된다   */

--사원들의 사원이름, 현재 커미션, 100을 더한 증가된 커미션을 조회하시오.
SELECT
ename 사원이름, comm "현재 커미션", comm+100 "증가된 커미션"
FROM
emp;


/* NULL 데이터 처리 함수- 
    NVL(컬럼이름, 데이터)  -> 컬럼내용이 NULL인 경우 "데이터"로 대체해서 조회
    */
    
    --사원들의 사원이름, 커미션을 조회하세요
    SELECT 
    ename 사원이름, NVL(comm,'커미션없음') 커미션
    FROM
    emp
    ;
--error발생 comm은 숫자형, '커미션없음'은 문자라서
   
--  사원들의 사원이름, 현재 커미션, 100을 더한 증가된 커미션을 조회하시오.
-- 단, 커미션이 없는 사원은 증가된 커미션을 50으로 조회되게 하세요
SELECT
ename 사원이름, comm 현재커미션, NVL(comm +100, 50) "증가된 커미션"
FROM
emp
;

--오라클에서 문자열 결합 사용시,
--두개의 컬럼을 결합 할 수 있고 하나의 컬럼과 다른 문자를 결합할 수 있다.

--사원들의 사원번호와 사원이름을 조회하세요
--(조회형태는 사원번호-사원이름의 형태로 조회되게 하세요)

SELECT
empno || ' - ' || ename 사원
FROM emp;
   
/* 테이블에서 조회할 때 연산식의 결과만 조회하는 경우 조회되는 행의 수는 데이터의
갯수만큼 조회된다 */

SELECT
2*42
FROM 
emp ;

--사원들의 사원번호, 사원이름을 조회하여라
--(사원이름 앞에 Mr. 가 붙여져서 조회하여라 _문자열 결합)
   
SELECT
|| 'Mr.'|| empno 사원번호, ename 사원이름
FROM
emp;               --error
   
SELECT
empno 사원번호, 'Mr.'|| ename 사원이름
FROM
emp;  

/* 조건에 맞는 데이터만 조회하기
형식] SELECT
      
      FROM
        WHERE
        ORDER BY
          정렬기준컬럼[ASC] || DESC, 컬럼이름 [ASC] || DESC,...
          ;
    =>WHERE절의 조건식의 결과는 반드시 TRUE 또는 FALSE 중 하나여야 한다
	조건식에는 자바에서와 마찬가지로 비교연산자, 논리연산자를 이용한다
    
 		비교연산자
		<, > , >= 등
		논리연산자
		AND, OR
        
    참고> 오라클은 데이터의 형태를 매우 중요시 한다.
    원칙적으로 문자는 문자(숫자도 숫자끼리)끼리 비교할 수 있다.
    예외인 경우, 날짜는 문자와 비교할 수 있다.
    
    참고> 문자데이터도 ASCII 코드값을 이용하여 크기비교 가능하다.
    즉, 'A'<'B'
       'AA' < 'AB'
       
    주의> 오라클은 명령은 대소문자를 구분하지 않지만 문제데이터는 반드시 
    대소문자를 구분해야 한다.    */
   
   SELECT
   empno 사원번호, ename 사원이름, sal 급여
   FROM
   emp
   WHERE 
   1<>1   --항상 FALSE 이다. => 조회 결과에 포함되는 행이 없다
   ;
   
   
   --'SMITH' 사원의 사원번호, 사원이름, 직급, 부서번호를 조회하세요
   
   SELECT
   empno 사원번호, ename 사원이름, job 직급, deptno 부서번호
   FROM emp
   WHERE ename='SMITH'
   ;
   
   
   --직급이 'MANAGER'인 사원들의 사원이름, 직급, 부서번호를 조회
   SELECT
   ename, job, deptno
   FROM emp
   WHERE job='MANAGER';
   
   --급여가 1500만원 이상인 사원들의 사원이름, 직급, 급여를 조회
   SELECT
   ename, job, sal
   FROM
   emp
   WHERE
   sal>=1500
   ;
   
   --문자도 비교가능하다
   
   --사원이름이 'M' 이후 문자로 시작하는 사원들의 --사원이름, 직급을 조회하여라
   
   SELECT
   ename, job
   FROM
   emp
   WHERE
   ename >= 'N'
   ;
   
   --입사일이 81년 11월 17일 이후인 사원들의 사원번호, 사원이름, 입사일을 조회하여라
   
   SELECT
   empno, ename, hiredate
   FROM
   emp
   WHERE
   hiredate >= '81/11/17'
   ;
   
   --직급이 'MANAGER' 이고 급여가 2500만원 이상인 사원들의
   --사원번호, 사원이름, 직급, 급여를 조회하세요
   
   SELECT empno, ename, job, sal
   FROM emp
   WHERE
   job='MANAGER' AND sal>=2500
   ;

   --사원들 중 급여가 1000만원에서 3000만원 사이인 사원들의
   --사원이름,직급,급여를 조회하세요
   
   SELECT
   ename, job, sal
   FROM
   emp
   WHERE
   sal>=1000 and sal <=3000    --동시비교 불가 ex) 1000 >= sal <=3000
   ;
   
   /* NOT연산자: 부정연산자 (조건식의 결과를 반대로 만들어주는 연산자)
 형식] 
  WHERE 
    NOT조건식    */
    
    --사원들 중 부서번호가 10번이 아닌 사원들의
    --사원이름, 직급, 급여, 부서번호를 조회하세요
    
   
   SELECT ename, job, sal, empno
   FROM emp
   WHERE
 --  deptno <> 10
 --  deptno != 10
 -- not deptno=10
 deptno NOT IN(10) ;
   
/*    특별한 조건 연산자 (다중값 비교연산자)
        1. BETWEEN-AND
        데이터가 특정 범위내에 있는지 확인하는 조건연산자
        
        형식> 컬럼이름(또는 연산식) BETWEEN 데이터1 AND 데이터2
        컬럼의 내용이 데이터1과 데이터2 사이에 있는지 검사
        
        주의> 데이터1이 데이터2보다 작아야 한다 
        
        참고> 이 연산자도 NOT 연산자와 함께 사용할 수 있다
        
        NOT 컬럼이름(또는 연산식) BETWEEN 데이터1 AND 데이터2
        컬럼이름(또는 연산식) NOT BETWEEN 데이터1 AND 데이터2
        */
        
        --급여가 1000만원 이상 3000만원 이하인 사원들의
        --사원이름,직급, 급여를 조회하세요
        SELECT ename, job, sal
        FROM emp  
        WHERE sal BETWEEN 1000 AND 3000 ;
        
        
        
    /*    2. IN   
            데이터가 주어진 데이터들 중 같은것이 있는지를 비교하는 연산자 
            + NOT연산자와도 사용가능
            형식> 
                컬럼이름(또는 연산식) IN (데이터1, 데이터2,...)   */
                
                
       --직급이 'SALESMAN'이거나 'CLERK'인 사원들의 사원이름, 직급, 부서번호를 조회하세요
       SELECT ename, job, deptno
       FROM emp  
       WHERE job IN('SALESMAN', 'CLERK')
       ;

       /* 3. LIKE     
            문자열 비교연산자(문자열을 처리하는 경우에만 사용된다.)
            문자열의 일부분을 와일드카드 처리해서 조건식을 제시하는 방법
            
            형식]
            컬럼이름(또는 데이터) LIKE '와일드카드 포함 문자열'
            => 데이터가 지정한 문자열과 동일한지를 비교
            
            참고]
                와일드 카드
                  _(언더바) : 한글자를 의미
                  % : 0글자 이상을 의미
            예]
              'M%'  : M으로 시작하는 모든 문자데이터 ('M' 한 글자 포함)
              '%S'  : S로 끝나는 모든 문자데이터
              '%A%' : A가 포함된 모든 문자데이터
              'S____' : 'S'로 시작하는 다서글자 문자데이터
              '__B_'  : 세번째 문자가 'B'인 네글자 문자데이터    */
   
  --이름이 다섯글자인 사원들의 사원이름, 직급, 부서번호를 조회
  SELECT ename, job, empno
  FROM emp  
  WHERE ename LIKE '_____'  ;
  
  --입사일이 1월인 사원들의 사원번호, 사원이름, 입사일을 조회
  SELECT empno, ename, hiredate
  FROM emp  
  WHERE -- hiredate LIKE '__/01/__' ;
        hiredate LIKE '%01/__';
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   