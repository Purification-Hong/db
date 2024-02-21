--[문자열 처리함수]
/*  REPLACE() 문자열의 특정부분을 다른 문자열로 대체해서 반환해주는 함수
        +형식
            REPLACE(데이터, 찾을 문자열, 대체문자열)
    TRIM() 문자열 중에서 앞 또는 뒤에 있는 지정한 문자를 모두 삭제하는 함수
        +형식
            TRIM(삭제할 문자 FROM 데이터)
        +참고
            같은 문자 앞, 뒤에 연속되어 있으면 모두 지울 수 있다
            가끔 데이터 앞 뒤에 공백 문자가 들어간 경우가 있는데, 이런 경우를 대비해서
            앞 뒤에 들어간 공백문자를 제거할 목적으로 많이 사용한다.
                1)LTRIM()
                2)RTRIM()
                    +형식
                        LTRIM(데이터, 삭제할문자) 
                        RTRIM도 동일
    ASCII() 문자에 해당하는 첫번째 ASCII 코드값을 반환해준다
        +형식
            ASCII(데이터)
    CHR() ASCII코드를 입력하면 코드에 해당하는 문자를 반환해주는 함수
    
            
    TRANSLATE() REPLACE() 함수와 마찬가지로 문자열 중 지정한 부분을 다른 문자열로
                대체해주는 함수
                
                차이점-REPLACE()함수는 바꿀 문자열의 형태가 정확하게 일치해야 하고
                      문자열 전체를 교체
                      
                      TRANSLATE()함수는 문자단위로 처리 한다
    
*/

-- REPLACE()
SELECT
    REPLACE('Hong Gill Dong', ' ','/') 
    
    FROM dual;



--TRIM()
SELECT
    TRIM(' 'FROM'            HONG GIL DONG           ')
FROM
    dual;


--ASCII() / CHR()
SELECT
    ASCII('HONG'),  --H의 아스키 72
    CONCAT(ASCII('HONG'),''), 
    CHR(ASCII('HONG'))
FROM
    dual;

--TRANSLATE()
SELECT 
    TRANSLATE('ABCDBAC', 'ABCD','1234')
FROM
    dual;
------------------------------------------------------------------------------
--[날짜 함수] 오라클에서 날짜 데이터는 1970년 1월 1일 0시 0분 0초를 기준으로 
            --숫자형식의 날짜 연번을 이용해서 관리한다
            
--  SYSDATE 예약어로 질의명령이 실행되는 순간의 날짜.시간을 기억하고 있는 변수
    
    --현재 시간 조회
    SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD HH:MI:SS')
    FROM dual;

    --사원들의 사원이름, 입사일, 근무일 수를 조회하세요.
    SELECT  ename, hiredate, FLOOR(SYSDATE-hiredate) "근무일 수"
    FROM emp;
    
    SELECT
    SYSDATE +11 "11일 후"
    FROM dual;

/*  +참고
        날짜-날짜 연산식은 허락한다. (날짜 연번끼리 연산을 한다)
        날짜+숫자 연산을 허락한다. 날짜연번의 낧수가 숫자이므로 날짜를 이용해서 연산한다
        따라서 날짜에서 숫자만큼 이동된 날짜를 조회하게 된다   */
        

--함수들
/*
ADD_MONTH() 현재 날짜에 지정한 개월수를 더하거나 뺀 날짜를 반환해준다
            +형식
                ADD_MONTHS(날짜데이터, 개월수)
            개월수가 음수면 해당 개월 수를 뺀 날짜를 반환
MONTHS_BETWEEN() 두 날짜 사이의 간격을 월단위로 알려주는 함수
            +형식
                MONTHS_BETWEEN(날짜, 날짜)
LAST_DAY() 입력한 날짜가 포함된 월의 마지막 날짜데이터를 반환
NEXT_DAY() 지정한 날짜가 포함된 월의 마지막 날짜데이터를 반환
            +형식
               NEXT_DAY(날짜, '요일')     
            +요일지정하는 방법
                1. 한글 셋팅이 된 오라클 이므로
                    '월', ' 화',...
                    '월요일', '화요일',...
                2.  영문권인 경우
                    'MON',...
                    'MONDAY',...
ROUND() 날짜를 지정한 기준으로 반올림해주는 함수
        +지정한 기준
            년,월,일, 시간, 분, 초
        +형식
            ROUND(날짜,'기준')
    
-------------------------------------------------------------------------*/

/*
[형변환 함수]
    오라클에서 함수는 데이터의 형태에 따라서 사용할 수 있는 함수가 달라진다. 
    만약 사용하려는 함수에 필요한 데이터가 아닌경우에는 문제가 생길 수 있다.
    이런 경우 사용하는 함수가 형변환함수이다.
    데이터의 형태를 바꿔서 특정 함수에 사용가능하도록 만들어주는 함수

    1. TO_CHAR() 날짜나 숫자를 문자 데이터로 변환해주는 함수
                +형식1
                    TO_CHAR(날짜 또는 숫자)
                    '2024/02/19'의 경우 공통적으로 사용하는 날짜 형식이므로
                    형식을 지정해주지 않아도 형변환을 해준다.
                    2024.02.19포함
                    2024-02-19포함
                +형식2 
                    TO_CHAR(날짜 또는 숫자, '형식문자')=>변환할때 원하는 형태의 문자로
                                                        변환해주는 방법
                                                        
                    ex) 현재 시간을 '월/일/두자리 년도'의 형식의 문자열로..
                    select TO_CHAR(SYSDATE, 'MM/DD/YY') 현재시간 FROM DUAL;
    2. TO_DATE() 날짜 형식의 문자데이터를 날짜데이터로 변환
                +형식1
                    TO_DATE(날짜형식 문자열)
                    공통적으로 사용되는 날짜 형식은 형식을 지정하지 않아도 형변환해준다
                +형식2
                    TO_DATE(날짜형식 문자열, '날짜형식')
                    형식이 일반적이지 않은 경우 날짜 형식을 지정해서 날짜데이터로 변환
                    [형식문자]
                    YYYY
                    MM
                    DD
                    
        [null처리함수]
        1.nvl(데이터, null일때 대체값)
        2. nvl2(컬럼이름, 컬럼연산식, null일 때 대체값)
        3. nullif()
            +형식 nullif(데이터1, 데이터2)
            +의미 [데이터1]과 [데이터2]가 같으면 [null]을 반환하고
            다르면 [데이터1]을 반환
        4.coalesce()
            +형식 
                
                
                
    [조건처리함수] 함수라기 보다는 명령에 가까운 것으로 자바의 switch-case, if를
    대신하기 위해서 만들어 놓은 것
    
    1. DECODE() 자바의 SWITCH문에 해당하는 함수
        +형식 DECODE(컬럼이름, 데이터1, 처리내용1, 데이터2, 처리내용2,...반환값 N)
        =>컬럼의 내용이 데이터1과 같으면 반환값2을반환하고 데이터2와 같으면 반환값2를 반환하고
        .... 맞는게 없으면 반환값N을 반환해준다.
        
    2. CASE WHEN THEN
        +형식1
            CASE WHEN 조건식1 THEN 처리내용1
                 WHEN 조건식2 THEN 처리내용2 ....ELSE 처리내용 N
                 
                 END
                 
        +형식2 (DECODE()와 같은 의미)
            CASE 컬럼이름 WHEN 데이터1 THEN 처리내용1
                         WHEN 데이터2 THEN 처리내용2
                         ELSE 처리내용 N
                         
                         END
        
    

*/

--오늘부터 5개월 후 날짜를 조회
SELECT
ADD_MONTHS(SYSDATE, 5)
FROM DUAL;

--사원들의 사원이름, 입사일, 근무 개월수를 조회하세요
SELECT ename, floor(MONTHS_BETWEEN(SYSDATE, hiredate)) "근무 개월 수",
FLOOR(MONTHS_BETWEEN(hiredate, SYSDATE)) "근무 개월 수2"
FROM emp;


--이번달 마지막 날
SELECT LAST_DAY(SYSDATE)
FROM dual ;


--사원들의 첫 달의 근무 일 수를 조회
/*  내가한 것
SELECT hiredate(SYSDATE-hiredate)
FROM emp;   */

select ename, hiredate, (last_day(hiredate)+1)-hiredate "입사월 근무일 수"
from emp ;



--오늘 이후 처음오는 불금의 날짜를 조회
SELECT NEXT_DAY(SYSDATE, '금') "다음 금요일",
        NEXT_DAY(SYSDATE, '월') "다음 월요일"
FROM DUAL;


--오늘을 년도를 기준으로 반올림한 날짜를 조회하세요
SELECT ROUND(SYSDATE, 'YEAR') "반올림한 년도"
FROM DUAL;


--7월 4일을 년도기준으로 반올림한 날짜를 조회하세요
SELECT ROUND(TO_DATE('2024/07/04', 'YYYY/MM/DD'), 'YEAR')
FROM DUAL;

--오늘날짜를 월 기준으로 반올림한 날짜
SELECT ROUND(SYSDATE, 'MONTH'),
        ROUND(SYSDATE, 'DD'),
        TO_CHAR(ROUND(SYSDATE, 'HH'), 'YYYY/MM/DD HH24:MI:SS')
FROM DUAL ;

--현재 시간을 'XXXX년 XX월 XX일 XX시 XX분 XX초'의 형식으로 조회
SELECT TO_CHAR(SYSDATE,'YYYY"년" MM"월" DD"일"  HH24"시" MI"분" SS"초" ' )현재시간
FROM DUAL;


SELECT TO_CHAR(1000, '9,999,999,999.99')숫자,
TO_CHAR(1000, '0,000,000,000.00')숫자2 FROM DUAL ;

--사원들의 이름, 입사요일을 조회하세요
SELECT ename, hiredate, TO_CHAR(hiredate, 'day') FROM EMP;

--문제> 토요일, 일요일에 입사한 사원들의 사원이름, 입사일, 급여, 커미션을 조회
--      (커미션은 200을 더한 값으로 조회)
--      (커미션이 없으면 300+200을 더한 값으로 조회)


--내가한것
/*select ename, hiredate, TO_CHAR(hiredate, day in '토' or '일'),
sal, comm+200, nvl(comm, 300+200)
from
emp;*/




SELECT
ename, hiredate, sal, NVL(comm, 300)+200
FROM emp
WHERE TO_CHAR(hiredate, 'DAY') IN ('토요일', '일요일') ;


SELECT TO_CHAR(SYSDATE, 'YY/MM/DD DAY'),
TO_CHAR(SYSDATE, 'YY/MM/D DY')
FROM DUAL;



SELECT 
TO_NUMBER('$2,345', '$9,999') FROM DUAL;



/* 예제) 사원들의 사원이름, 직급, 부서번호, 부서이름을 조회하세요
  부서이름은 10-영업부 20-총무부 30-전산부 그 이외는 '인턴'으로 조회하기로 한다 */
  
  SELECT
  ename, job, deptno,
  DECODE(deptno, 10, '영업부', 20, '총무부', 30, '전산부','인턴')부서이름,
  
  CASE deptno when 10 then '영업부'
             when 20 then '총무부'
             when 30 then '전산부'
             ELSE '인턴' END 부서명칭,
  CASE when deptno= 10 then '영업부'
             when deptno= 20 then '총무부'
             when deptno=30 then '전산부'
             ELSE '인턴' END 부서명
  FROM emp ;


/* 사원들의 사원이름, 직급, 부서번호, 보너스를 조회하세요. 보너스는 부서별로
10- 급여의 10% , 20-급여의 15%, 30-급여의 20% 그 이외에는 0으로 지급하기로 한다. */

SELECT
ename, job, deptno 부서번호,
DECODE(deptno, 10, sal*1.1,
               20, sal*1.15,
               30, sal*1.2,0)보너스,
CASE deptno when 10 then sal*1.1
            when 20 then sal*1.15
            when 30 then sal*1.2 else 0
            end 비자금

FROM emp ;



--추가문제

/*
    사원들의
        사원이름, 입사일, 근무년월수
    를 조회하세요.
    
    근무년월수는 
        총근무개월수를 12로 나눈 몫을 근무년수로하고
        나머지를 근무개월수로 하기로 한다.
*/

SELECT  ename, hiredate, FLOOR((SYSDATE-HIREDATE)/365)

FROM emp

;



/*
    사원들의
        사원이름, 입사일, 첫급여까지 근무일 수
    를 조회하세요.
    급여일은 매월 1일로 한다.
*/

SELECT ename, hiredate, sal 'yyyy/mm/01'
FROM emp
;









/*
    사원들의
        사원이름, 입사일, 첫토요일
    을 조회하세요.
*/

/*
    사원들의 근무년수는 입사한 달의 1일을 기준으로 하면
    사원들의
        사원이름, 입사일, 근무기준일
    을 조회하세요.
    16일 이후 입사자는 다음달 1일을 근무기준일로 하기로 한다.
*/

/*
    사원들의
        사원이름, 급여, 출력급여
    를 조회하세요.
    출력급여는 10자리로 하고
    남는 부분은 왼쪽에 '*'로 표현하기로 한다.
*/



/*
    사원들중 '월요일'에 입사한 사원들의
        사원이름, 입사일, 입사요일
    을 조회하세요. 
*/

/*
    급여의 100단위가 0인 사원들의
        사원이름, 급여
    를 조회하세요.
    형변환함수를 이용해서 처리하세요.
*/
select ename, sal 
from emp
where substr(to_char(sal),-3,1)= 0 ;




/*
    사원들의
        사원이름, 급여, 커미션
    을 조회하세요.
    커미션이 없는 사원은 'None' 으로 출력되게 하세요.
*/

select ename 사원이름, sal 급여, nvl(TO_CHAR(comm), 'NONE') 커미션 --COMM과 NONE의 타입이 다르니 TO _CHAR이용

from emp ;




/*
    입사년도를 기준으로
        80년도에 입사한 사원은 'A' 등급
        81년도 'B'등급
        82년도 'C'등급
        그외 년도에 입사한 사원은 'D'등급으로 조회되도록
    사원들의
        사원이름, 입사년도, 입사등급
    을 조회하세요.
*/

/*
    급여가 1000 미만이면 20% 인상하고
            1001 ~ 3000 이면 15% 인상
            3001 이상이면 10% 인상해서
    사원들의
        사원이름, 원급여, 인상급여
    를 조회하세요.
*/

/*
    사원들의 
        사원이름, 입사년도, 직급
    을 조회하세요.
    단, 사원이름은
        일반사원은 이름다음에 ' 사원' 을 붙이고
        사장님은 이름 다음에 ' 사장님'을 붙여서 조회하세요.
*/

/*
    부서번호가 10 또는 20번이면 급여 + 커미션으로
    (커미션이 없으면 커미션을 0으로 계산)
    그외 부서는 급여만 지급액으로 조회되도록
    사원들의
        사원이름, 부서번호, 급여, 커미션, 지급액
    을 조회하세요.
    
*/

/*
    입사요일이 토요일, 일요일이면 급여의 20%를 증가
    그외에 요일에 입사한 사원은 급여의 10%를 증가시켜서
    사원들의
        사원이름, 입사요일, 급여, 지급급여
    를 조회하세요.
*/

/*
    근무개월수가 500개월 이상이면 커미션을 500을 올려주고
    500개월 미만이면 현재 커미션만 지급하도록
    사원들의
        사원이름, 입사일, 근무개월수, 커미션, 지급커미션
    을 조회하세요.
    단, 커미션이 없으면 0으로 커미션을 계산하기로 한다.
*/

/*
    이름 글자수가 5글자 이상인 사원은 3글자***의 형식으로 
    4글자 이하면 그냥 이름이 보여지도록
        사원이름, 직급, 입사일
    을 조회하세요.
*/























