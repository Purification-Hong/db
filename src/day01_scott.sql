select *  from emp ; --오라클에서 단일행 주석
                    /*  sqldeveloper에서 사용하는 다중행 주석
                    여러줄 주석처리..... */
                    
/*자바에서 마찬가지로 모든 것을 의미하는 문자는  * 를 사용한다
그리고 sql에서는 명령어가 대소문자를 구분하지 않는다.
하지만 데이터는 대소문자를 꼭 구부해야한다.

자바에서는 문자와 문자열을 구분했지만 데이터베이스에서는 구분하지 않는다.
데이터 표현은  '' 을 이용해서 표현한다.

오라클에서도 자바와 마찬가지로 명령의 구분은 토큰;으로 구분한다. */

select 'abc'from DUAL;

select 1+2 from DUAL;
                
   /* 데이터 조회명령
    
    형식)
       select 컬럼이름1, 컬럼이름2,...
      from 테이블이름
      [where  조건]
       [group by 그룹기준
      [having]]
       [order by]  ;*/
       
--사원들의 사원이름, 급여를 조회하세요. 

select ENAME, SAL from emp;   
/* 쿼리문 (QUERY) : 조회하거나 데이터베이스 작업을 하는 
  명룽(문장들)을 쿼리문, 질의명령이라고 말한다.  */

/*  scott 계정이 소유하는 테이블들
    emp - 사원정보테이블
       empno 사원번호
       ename 사원이름
       job 직급
       mgr 상사의 사원번호
       hiredate 입사일
       sal 급여
       comm 커미션
       deptno 부서번호
       
    dept - 부서정보테이블
    salgrade - 급여등급테이블
    bonus -보너스테이블  
 
   






















