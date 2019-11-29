[1일차 수업]
1. 오라클 소프트웨어 다운로드

1.11g Express Edition  버전
https://www.oracle.com/database/technologies/xe-prior-releases.html

2.오라클 접속 툴 (무료버전)
https://www.oracle.com/tools/downloads/sqldev-v192-downloads.html

3. 설치 (관리자 권한 : SYSTEM , SYS 계정 >> 암호설정 : 1004)
    Port for 'Oracle Database Listener': 1521

4. 접속 (sqlplus 툴 : DOS 기반) >> UI 툴 설치

5. 오라클 제공 : SqlDeveloper 
   유료 :  토드 , 오렌지 , sqlgate
   무료 :  https://dbeaver.io/download/   


6.  Tool 접속
     SYSTEM : 1004 계정 접속  (관리자 권한)
     6.1 HR 계정 사용 (unlock)
     -- USER SQL
     ALTER USER "HR" IDENTIFIED BY "1004" 
     DEFAULT TABLESPACE "USERS"
     TEMPORARY TABLESPACE "TEMP"
     ACCOUNT UNLOCK ; 
    6.2  HR 계정으로  로그인 (테이블 조회)

7.  새로운 계정 만들기 (실습용 계정)
    bituser : 1004
   	 -- USER SQL
	CREATE USER bituser IDENTIFIED BY 1004 
	DEFAULT TABLESPACE "USERS"
	TEMPORARY TABLESPACE "TEMP";

	-- QUOTAS
	ALTER USER bituser QUOTA UNLIMITED ON USERS;

	-- ROLES
	GRANT "CONNECT" TO bituser WITH ADMIN OPTION;
	GRANT "RESOURCE" TO bituser WITH ADMIN OPTION;
	ALTER USER bituser DEFAULT ROLE "CONNECT","RESOURCE";

	-- SYSTEM PRIVILEGES

8. 실습 script 만들기
 CREATE TABLE EMP
(EMPNO number not null,
ENAME VARCHAR2(10),
JOB VARCHAR2(9),
MGR number ,
HIREDATE date,
SAL number ,
COMM number ,
DEPTNO number );
--alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';

INSERT INTO EMP VALUES
(7369,'SMITH','CLERK',7902,'1980-12-17',800,null,20);
INSERT INTO EMP VALUES
(7499,'ALLEN','SALESMAN',7698,'1981-02-20',1600,300,30);
INSERT INTO EMP VALUES
(7521,'WARD','SALESMAN',7698,'1981-02-22',1250,200,30);
INSERT INTO EMP VALUES
(7566,'JONES','MANAGER',7839,'1981-04-02',2975,30,20);
INSERT INTO EMP VALUES
(7654,'MARTIN','SALESMAN',7698,'1981-09-28',1250,300,30);
INSERT INTO EMP VALUES
(7698,'BLAKE','MANAGER',7839,'1981-04-01',2850,null,30);
INSERT INTO EMP VALUES
(7782,'CLARK','MANAGER',7839,'1981-06-01',2450,null,10);
INSERT INTO EMP VALUES
(7788,'SCOTT','ANALYST',7566,'1982-10-09',3000,null,20);
INSERT INTO EMP VALUES
(7839,'KING','PRESIDENT',null,'1981-11-17',5000,3500,10);
INSERT INTO EMP VALUES
(7844,'TURNER','SALESMAN',7698,'1981-09-08',1500,0,30);
INSERT INTO EMP VALUES
(7876,'ADAMS','CLERK',7788,'1983-01-12',1100,null,20);
INSERT INTO EMP VALUES
(7900,'JAMES','CLERK',7698,'1981-10-03',950,null,30);
INSERT INTO EMP VALUES
(7902,'FORD','ANALYST',7566,'1981-10-3',3000,null,20);
INSERT INTO EMP VALUES
(7934,'MILLER','CLERK',7782,'1982-01-23',1300,null,10);

COMMIT;

CREATE TABLE DEPT
(DEPTNO number,
DNAME VARCHAR2(14),
LOC VARCHAR2(13) );

INSERT INTO DEPT VALUES (10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPT VALUES (20,'RESEARCH','DALLAS');
INSERT INTO DEPT VALUES (30,'SALES','CHICAGO');
INSERT INTO DEPT VALUES (40,'OPERATIONS','BOSTON');

COMMIT;

=========================================================


CREATE TABLE SALGRADE
( GRADE number,
LOSAL number,
HISAL number );

INSERT INTO SALGRADE VALUES (1,700,1200);
INSERT INTO SALGRADE VALUES (2,1201,1400);
INSERT INTO SALGRADE VALUES (3,1401,2000);
INSERT INTO SALGRADE VALUES (4,2001,3000);
INSERT INTO SALGRADE VALUES (5,3001,9999);
COMMIT;

--[1일차]

SELECT [DISTINCT]  {*, column [alias], . . .}  
FROM  table_name   
[WHERE  condition]   
[ORDER BY {column, expression} [ASC | DESC]]; 
/*
DISTINCT  중복 행 제거 옵션 
*   테이블의 모든 column 출력 
alias   해당 column 에 대한 다른 이름 부여 
table_name 테이블명 질의 대상 테이블 이름 
WHERE   조건을 만족하는 행들만 검색 
condition  column, 표현식, 상수 및 비교 연산자 
ORDER BY  질의 결과 정렬을 위한 옵션(ASC:오름차순(Default),DESC 내림차순) 
*/
--1. 사원테이블에 있는 모든 데이터를 출력하세요
select * from emp;
SELECT * FROM EMP; --쿼리문은 대소문자 구분하지 않아요

--2. 특정 컬럼 데이터 추출하기
select empno, ename , job , sal from emp;

select empno  from emp;

select hiredate , deptno from emp;

--3 컬럼에 가명칭(alias) 부여하기
select empno 사번 ,  ename 이름
from emp;

--select empno 사   번 ,  ename 이름
--from emp;

select empno "사   번" ,  ename "이   름"
from emp;

--정식(ansi 표준) >> 권장

select empno as "사   번" ,  ename as "이   름"
from emp;

--Oracle : 문자열 데이터 (엄격하게 대소문자 구분)
--데이터 : a ,  A 다른 문자 취급
--문자열(문자) 데이터 :   '문자'
select * from emp where ename='king';
select * from emp where ename='KING';
select * from emp where ename='King';

--Oracle : 연산자(결합 연산자) >> || >> 'hello' || 'world' >> 결합 >> 'helloworld'
--java : + 산술 , 결합
--java : 10 + 10 (산술)
--java : "A" + "B" (결합)
--TIP) ms-sql: + (연산, 결합)

select '사원의 이름은' || ename || '입니다' as "ename"
from emp;

--java : class Emp {private int empno;}
--POINT : 오라클의 컬럼은 타입 정보를 갖는다
--현재 내가 가지고 있는  emp 정보를 보는 방법
desc emp; --emp 컬럼의 타입정보

select empno + ename as "결합"  -- [연산 수행] >> "invalid number"
from emp;

select empno || ename as "결합" --실제 (내부적으로 자동 형변환(숫자->문자) to_char()
from emp;

--사장님 우리 회사에 직종(job)이 몇개나 있나
--중복 데이터 제거 (키워드): distinct
select distinct job from emp;

select distinct deptno from emp;

--distinct 원리 (컬럼이 2개 이상) --grouping (그림 : 꾸러미 )
select distinct job , deptno from emp order by job;

select distinct deptno , job from emp order by deptno;

--오라클 언어(SQL)
--java 같은 언어다 (연산자)
--오라클도 연산자 java 와 거의 동일
--java (% 나머지) >> 오라클에서 [ % ] 검색패턴자원으로 활용 >> 나머지 함수를 만들었어요  Mod() 함수
--Oracle (+ , - , * , / ...) + 나머지 (Mod()함수)

--사원테이블에서 사원의 급여를 100달러 인상한 결과를 출력하세요
--전제 조건( + ) 컬럼의  타입: number
desc emp;
select empno, ename , sal, sal + 100 as "인상급여"
from emp;

----재미로 ^^------- 
select 100 + 100 from dual;  --데이터 TEST dual
select 100 || 100 from dual; -- || 결합연산자 (숫자 -> 문자 자동형변환)
select '100' + 100  from dual; -- + 산술연산 ('100' >> 숫자 형변환)
select 'A100' + 100  from dual; --Error  "invalid number"

--비교연산자
-- > , < , <= ....
--java 같다(==) , 할당(=)
--javascript  같다(===)
--oracle 같다(=) , (!=)

--논리연산자
--AND , OR ,NOT







/*
SELECT [DISTINCT]  {*, column [alias], . . .}  
FROM  table_name   
[WHERE  condition]   
[ORDER BY {column, expression} [ASC | DESC]]; 
*/

--조건절(원하는 row 만 가지고 오겠다)
--실행순서: select 절 , from 절 ,  where 절 
--
select *           --3  
from emp           --1 
where sal >= 3000; --2

--이상 , 이하 (= 포함)
--초과 , 미만

--사번이 7788번인 사원의 사번 , 이름 , 직종 , 입사일을 출력하세요
select empno, ename, job, hiredate
from emp
where empno=7788;

--사원의 이름이  KING 인 사원의 사번 , 이름 , 급여 정보를 출력하세요
select empno, ename, sal
from emp
where ename = 'KING';

--논리(AND , OR , NOT)
--급여가 2000달러 이상이면서 직종이 manager 인 사원의 모든 정보를 출력하세요
select *
from emp
where sal >= 2000 and job='MANAGER';

--급여가 2000달러 이상이거나 직종이 manager 인 사원의 모든 정보를 출력하세요
select *
from emp
where sal >= 2000 or job='MANAGER';

--오라클 날짜
--DB서버의 날짜
--시스템 : 날짜 가지고 있다 >> sysdate
select sysdate from dual;
--게시판 글쓰기 : insert into board(writer, title, content , regdate)
--               values('홍길동','방가방가','피곤해요',sysdate)
--TIP) ms-sql >> select getdate() ...

select hiredate from emp;
desc emp;  -- DATE
--오라클  [시스템정보]를 담고 테이블 별도로 관리
--환경설명
select * from SYS.NLS_SESSION_PARAMETERS;
--NLS_LANGUAGE	KOREAN
--NLS_DATE_FORMAT	RR/MM/DD  --변경도 가능
--NLS_DATE_LANGUAGE	KOREAN
--NLS_TIME_FORMAT	HH24:MI:SSXFF

select * from SYS.NLS_SESSION_PARAMETERS where parameter = 'NLS_DATE_FORMAT';
--POINT
--서버기준에 설정 변경 가능 (DBA)
--현재 접속한 사용자(session) 기준으로 적용
--다른 곳에서 bituser 로 접속하면 날짜형식 변경 ..그래로 

alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS'; --변경
select * from SYS.NLS_SESSION_PARAMETERS where parameter = 'NLS_DATE_FORMAT'; --변경확인

--NLS_DATE_FORMAT	YYYY-MM-DD HH24:MI:SS
select sysdate  from dual; --2019-09-24 11:51:38
select hiredate from emp;  --1980-12-17 00:00:00

select *
from emp
where hiredate='1980-12-17'; --날짜 형식 표현(문자 동일)

select *
from emp
where hiredate='1980/12/17'; --날짜 ( - 구분자 , / 구분자)

select * from emp;
select *
from emp where hiredate='80-12-17'; --날짜 형식 변경  (조회 안되요)
--RR-MM-DD --> YYYY-MM-DD

--사원의 급여가 2000이상이고 4000이하인 모든 사원의 정보를 출력하세요
select *
from emp
where sal >= 2000 and sal <= 4000;
--연산자 : 컬럼명 between A and B (= 포함)

select *
from emp
where sal between 2000 and 4000;

--사원의 급여가 2000초과 4000미만인 사원의 모든 정보를 출력하세요
select *
from emp
where sal > 2000 and sal < 4000;

--부서번호가 10번 또는 20번 또는 30번인 사원의 사번 , 이름 , 급여 , 부서번호를 출력하세요
select empno, ename, sal, deptno
from emp
where deptno=10 or deptno=20 or deptno=30;

--IN 연산자 (조건 or 조건 or ...)
select empno, ename, sal, deptno
from emp
where deptno in (10,20,30); --deptno=10 or deptno=20 or deptno=30

--부서번호가 10번 또는 20번이 아닌 사원의 사번 , 이름 , 급여 부서번호를 출력하세요
--10번도 아니고 20번이 아닌 ..
select empno, ename, sal, deptno
from emp
where deptno != 10 and deptno != 20;

--NOT IN  연산자 

select empno, ename, sal, deptno
from emp
where deptno not in(10,20); -- deptno != 10 and deptno != 20;

--POINT : 값이 없다 (데이터 없다) >> null
--null (필요악)
--JAVA : class Member {  private String userid .....}

create table member (
 userid varchar2(20) not null,
 name varchar2(20) not null,
 hobby varchar2(20)  --default >>  null  (null값을 허용) : 필수 입력 사항이 아니야
 );
select * from member; 

insert into member(userid, name) values('hong','홍길동');
select * from member;

insert into member(userid, hobby) values('kim','농구'); --오류
-- ORA-01400: cannot insert NULL into ("BITUSER"."MEMBER"."NAME")

insert into member(userid, name, hobby) values('park','박군','축구');
select * from member;

--실반영
commit;
select* from member;

--수당을 받지 않는 모든 사원의 정보를 출력하세요
select * from emp;

--null 은 다른 연산자  (is null)
--select * from emp where comm = null;  --(x)

--null 비교 (is null , is not null)
select * from emp where comm is null;

--수당을 받는 모든 사원의 정보를 출력하세요 (comm  데이터  null  이 아닌 사원)
select * from emp where comm is not null;

--사원테이블에서 사번 , 이름 , 급여 , 수당 , 총급여를 출력하세요
--총급여(급여 + 수당)
select empno , ename , sal , comm , sal + nvl(comm,0) as "총급여"
from emp;

--POINT (null)
--** null 과의 모든 연산은 그 결과가 : null
-- null을 만나면 대체값으로 바꾸어라 :  nvl() , nvl2()
--ms-sql : convert()
--my-sql : IFNULL()

select 1000 + null from dual;

select 1000 + nvl(null,0) from dual;

select 1000 + nvl(null,11111) from dual;

select comm, nvl(comm,0) from emp;

--사원의 급여가 1000 이상이고 수당을 받지 않는 사원의 사번,  이름 , 직종 , 급여 , 수당을 출력하세요
select empno,ename,job,sal,comm
from emp
where  sal >= 1000 and comm is null;

-----------------------------------------------------------------------------------------
--DQL (data query language) : SELECT
--DDL : create , alter , drop (객체 생성 수정 삭제)

create table board (
  boardid number not null , --필수입력
  title varchar2(20) not null, --필수입력 (영문자, 특수 , 공백: 1Byte  , 한글 2Byte)
  content varchar2(2000) not null, --필수입력
  hp varchar2(20)  -- null  --선택입력 (null)
);

--DML(데이터 조작어) : insert , update , delete 
--작업시에는[ 실제 반영 ]이나 취소처리를 위해 (commit, rollback) 반드시 사용
insert into board(boardid, title, content)
values(100,'오라클','참 쉽네');

select * from board;

commit; --실반영

insert into board(boardid, title, content)
values(200,'자바','그립다...');

select * from board;
rollback;

--insert , update , delete 작업 오라클 (무조건 commit , rollback 작업 반드시)
--ms-sql (Auto commit) >> default commit;  begin tran  ~~~ commit  or rollback 

select * from board;

select boardid , hp,  nvl(hp,'핸드폰 없어요') as "hp"  -- nvl 문자에도 적용 가능하다 ^^
from board;

--nvl 함수는 숫자 , 날짜 , 문자 모두 적용가능하다 

--문자열 검색
--주소검색 : '역삼' 검색하면 역삼 글자에 들어있는 주소가 다 나와요 
--문자열 패턴 검색( LIKE  연산자)

--like 연산자 ( 와일드 카드 문자 ( % : 모든 것(어떤 것도 상관없어요) ,  _ : 한문자) 결합

 select *
 from emp
 where ename like '%A%'; --A 가 들어있는 모든 이름 검색

 select *
 from emp
 where ename like 'A%'; 


 select *
 from emp
 where ename like '김%'; --김씨성 가진 사람 모두 검색
 

 select *
 from emp
 where ename like '%S'; --S 끝나는 이름을 가진 모든 사원을 검색

 select *
 from emp
 where ename like '%LL%'; 
 
 select *
 from emp
 where ename like '%A%A%';  --  AA   , ABA  
 
 select *
 from emp
 where ename like '_A%';  --   _ 한문자

 select *
 from emp
 where ename like '__A%';  --A 세번째 긃 글자 ....
 
--오라클 과제 (regexp_like) 상세한 패턴 검색
--select * from emp where regexp_like (ename, 정규표현식);
--오라클 정규표현사용 검색 패턴 만들기 (조별 3개) : 중간프로젝트 ...반영


--데이터 정렬하기
--order by 컬럼명(문자, 숫자, 날짜)   asc or desc
--오름차순 : asc 낮은순 (default)
--내림차순: desc 높은순

select *  from emp order by sal; -- asc 급여가 낮은 ...
select *  from emp order by sal asc;

--급여를 많이 받는 순으로 데이터를 정렬하세요
select * from emp order by sal desc;

select * from emp order by ename asc; --문자열 정렬 ...

--입사일이 가장 늦은 순으로 정렬해서 사번 , 이름 , 급여 , 입사일을 출력하세요
--처근에 입사한 사원 ....
select empno, ename, sal , hiredate
from emp
order by hiredate desc;

/*
SELECT       3                        
FROM          1                   
WHERE         2        
ORDER BY     4    (select 한 결과를 정렬 )  
*/ 

--문제 : 
--사원 테이블에서 직종이 manager인 사번 , 이름 , 급여 , 직종 , 입사일 출력하되 입사일 가장 늦은 순으로 출력하세요
select empno , ename , sal , job , hiredate
from emp
where job='MANAGER'
order by hiredate desc;


--해석
select deptno , job
from emp
order by deptno desc , job asc; --정렬 2개 ( grouping )

--연산자 
--합집합(union) : 테이블과 테이블의 데이터를 합쳐서 보여지는 것 (중복값은 배제)
--합집합(union all) : 중복값 허용

create table uta (name varchar2(20));
insert into uta(name) values('AAA');
insert into uta(name) values('BBB');
insert into uta(name) values('CCC');
insert into uta(name) values('DDD');
commit;
select * from uta;


create table ut (name varchar2(20));
insert into ut(name) values('AAA');
insert into ut(name) values('BBB');
insert into ut(name) values('CCC');
commit;
select * from ut;


select name from ut
union  --중복값 배제
select name from uta;


select name from ut
union all 
select name from uta;

--union  규칙
--1. 대응대는 컬럼의 타입이 동일
select empno, ename from emp
union
select dname ,deptno from dept; --(x)

select empno, ename from emp
union
select deptno ,dname from dept; 

--2. 대응대는 컬럼의 개수 동일 (null 착한일)

select empno , ename, job , sal from emp
union
select deptno, dname , loc , null from dept;

--오라클 함수 (pdf 48 page)
/*
단일행 함수
1) 문자형 함수 : 문자를 입력 받고 문자와 숫자 값 모두를 RETURN 할 수 있다. 
2) 숫자형 함수 : 숫자를 입력 받고 숫자를 RETURN 한다. 
3) 날짜형 함수 : 날짜형에 대해 수행하고 숫자를 RETURN 하는 MONTHS_BETWEEN 함수를 제외하고 모두 날짜 데이터형의 값을 RETURN 한다. 
4) 변환형 함수 : 어떤 데이터형의 값을 다른 데이터형으로 변환한다. 
5) 일반적인 함수 : NVL, DECODE 
*/
--문자열 함수

select initcap('the super man') from dual; --The Super Man

select lower('AAA') , upper('aaa') from dual;

select ename , lower(ename) as "ename" from emp;

select * from emp where lower(ename) = 'king';

--문자의 개수(length)
select length('abcd') from dual;
select length('홍길동바보') from dual;

select length('홍 길 동 ') from dual;

--결합 연산자 ||
--결합 함수
select 'a' || 'b' || 'c' from dual;

select concat('a','b') from dual;

select concat(ename, job) from  emp;
select ename || '   ' || job from emp;

--부분 문자열 추출
--java(substring)
--oracle(substr)

select substr('ABCDE',2,3) from dual; --BCD
select substr('ABCDE',1,1) from dual; --자기자신 A
select substr('ABCDE',3,1) from dual; --C

select substr('ABCDE',3) from dual;
select substr('ABCDE',-2,1) from dual;
select substr('ABCDE',-2,2) from dual; --DE

/*
사원테이블에서  ename  컬럼 데이터에 대해서 첫글자는 소문자로 나머지 문자는 대문자로 출력하되
하나의 컬럼 데이터로 출력하세요
컬럼의 가명칭 : fullname
첫글자와 나머지 문자 사이에 공백 하나 있어요
--SMITH  결과 : s MITH
*/
select lower(substr(ename,1,1)) from emp;

select upper(substr(ename,2)) from emp;

select lower(substr(ename,1,1))  ||  ' '  ||upper(substr(ename,2)) as "fullname"
from emp;

--lpad , rpad (채우기)

select lpad('ABC',10,'*') from dual;


select rpad('ABC',10,'#') from dual;

--Quiz 
--사용자 비번 : hong1006
--화면에 ho****** 로 출력하고 싶어요 (앞에 2글자 보여주고 그 나머지는 * 보여주고 싶어요

select rpad(substr('hong1006',1,2),length('hong1006'),'*') as "password" from dual;

--emp 테이블에서 ename  컬럼의 데이터를 출력하는 데 첫글만 출력하고 나머지는 * 로 출력하세요
select rpad(substr(ename,1,1),length(ename),'*') as "password" from emp;

create table member2(
  id number,
  jumin varchar2(14)
);

insert into member2(id,jumin) values(100,'123456-1234657');
insert into member2(id,jumin) values(200,'234567-1234567');
commit;

select * from member2;
--QUIZ
--출력결과
-- 100 : 123456-*******
-- 200: 234567-*******
--이 결과에 대한 가명칭 jumin
--푸시고 쉬세요

--------------------------------------------------------
select id || ' : ' || rpad(substr(jumin,1,7),length(jumin),'*') from member2; 

--rtrim 함수
--[오른쪽 문자] 지워라
select rtrim('MILLER','ER') from dual;

--ltrim  함수
select ltrim('MILLLLLLLLER','MIL') from dual; --주의

--치환함수
select ename , replace(ename,'A','와우')  from emp;

--[문자열 함수 END]

--[숫자 함수]
--round (반올림 함수)
--trunc (절사 함수)
--나머지 함수 mod()

--  -3  -2   -1  0(정수)  1  2  3
select round(12.345,0) as "r" from dual; --정수부만 남겨라(반올림)
select round(12.567,0) as "r" from dual; --13

select round(12.345,1) as "r" from dual; --12.3
select round(12.567,1) as "r" from dual; --12.6


select round(12.345,-1) as "r" from dual; --10자리  --10
select round(15.345,-1) as "r" from dual; --20
select round(15.345,-2) as "r" from dual; --0

-- trunc(반올림 처리하지 않아요)
select trunc(12.345,0) as "r" from dual; --12
select trunc(12.567,0) as "r" from dual; --12

select trunc(12.345,1) as "r" from dual; --12.3
select trunc(12.567,1) as "r" from dual; --12.5

select trunc(12.345,-1) as "r" from dual; --10자리  --10
select trunc(15.345,-1) as "r" from dual; --10
select trunc(15.345,-2) as "r" from dual; --0

--나머지
select 12/10 from dual; --1.2
select mod(12,10) from dual; --나머지
select mod(0,0) from dual;

--[숫자 함수 END]

--[날짜 함수]
--sysdate
--POINT  날짜 연산
select sysdate from dual;
alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';
select hiredate from emp;

--Date + Number >> Date 
--Date - Number >> Date
--Date - Date >> Number (일수)

--날짜 (round , trunc)

select months_between('2019-02-27','2010-02-27') from dual; --개월의 108개월

select round(months_between(sysdate,'2010-01-01'),0) from dual; --117개월
--116.795299805854241338112305854241338112
select trunc(months_between(sysdate,'2010-01-01'),0) from dual;  --116개월


select to_date('2015-01-01') + 1000 from dual;

select sysdate + 100 from dual;

--QUIZ
/*
1. 사원테이블에서 사원들의 입사일에서 현재날짜(sysdate)까지의 근속월수를 구하세요
--단 근속월수는 정수부분만 남기세요


2. 한달이 31일 이라고 가정하고 근속월수를 구하세요 (정수부만 남기세요)

*/
select ename, hiredate , trunc(months_between(sysdate,hiredate),0) as "근속월" ,
        trunc((sysdate - hiredate) /31,0) as "근속월2"
from emp;        
--[날짜 함수 END]
--문자함수
--숫자함수
--날짜함수

--[변환함수]  POINT
--Oracle : 문자 , 숫자 , 날짜 데이터
--to_char() : 숫자(10000) -> 문자($10000) (100,000) , 날짜('1900-01-01') -> 문자(1900년01월01일)
--형식정의

--to_date() : 문자 -> 날짜  >> select '2019-12-12' + 1000 >>  select to_date('2019-12-12') ..

--to_number() : 문자 -> 숫자 (자동형변환)
select '100' + 100 from dual;  --숫자형 문자
select to_number('100') + 100 from dual;

/*

오라클 기본 타입(데이터 타입)
create table 테이블명 (컬럼명  타입 ); 
create table member(age number); 100건 데이터 insert
--java > class member { int age } >> member m = new member(); 1건
--java > List<member> list = new ArrayList<>();   list.add(new member()) 여러건

문자 타입
--char(20) >> 20byte >> 한글10자,  영문자,특수문자,공백 20자  >> 고정길이문자열
--varchar2(20) >>  20byte >> 한글10자,  영문자,특수문자,공백 20자  >> 가변길이문자열

char(20) >> '홍길동' >> 20byte 모두 사용[홍길동                                   ] 
varchar2(20) >> '홍길동' >> 공간의 크기 >> 6byte[홍길동]

고정된데이터 : 남 , 여   >> 처리  >> char(2)
결국 >> varchar2(2) 

성능 상의 문제))
char() ..... varchar2() 보다 검색상 우선 ...

결국 문제는 [한글]
unicode (2byte) : 한글 , 영문자 , 특수문자 , 공백 >> 2byte
nchar(20) >> 20은 문자의 개수  >> 실제 byte *2 >> 40byte
nvarchar2(20) >> 20개의 문자 

한글 20자 , 영문자 20자

*/
--1. to_number() : 문자를 숫자로
select 1 + 1 from dual;

select '1' + 1 from dual; --자동 형변환

select to_number('1') +1 from dual;

select '1' + '1' from dual; --자동 형변환

select '1A' + '1' from dual;
--------------------------------------------------------------
--2. to_char() :  숫자 -> 문자(형식문자) , 날짜 -> 문자(형식문자)
select sysdate from dual;
--YYYY   YY   MM   DD .... 정의되어 있어요

select sysdate || '일'  from dual;  --자동 형변환 (날짜  와  문자가 결합 >> 문자)
--원칙
select to_char(sysdate) || '일' from dual;

select sysdate ,
to_char(sysdate,'YYYY') || '년' as "YYYY",
to_char(sysdate,'YEAR'),
to_char(sysdate,'MM'),
to_char(sysdate,'DD'),
to_char(sysdate,'DAY'),
to_char(sysdate,'DY')
from dual;

--Quiz (to_char() , to_number() , to_date()
--입사일 12월인 사원들의 사번 , 이름, 입사일, 입사년도 , 입사월을 출력하세요

select empno, ename, hiredate , to_char(hiredate,'YYYY') as "년", to_char(hiredate,'MM') as "월"
from emp
where to_char(hiredate,'MM') = '12';

select to_char(hiredate,'YYYY MM DD') from emp;

select to_char(hiredate,'YYYY"년" MM"월" DD"일"') from emp;

--to_char() : 숫자 -> 문자
--why : 10000000  -> $1,000,000,000  이런 형식의 문자데이터 to_char()
select '>' || to_char(12345,'999999999999') || '<' from dual;
select '>' || to_char(12345,'099999999999') || '<' from dual;
select '>' || to_char(12345,'000000000000') || '<' from dual;

select '>' || to_char(12345,'$9,999,999,999,999') || '<' from dual;


select to_char(sal,'$999,999') as "sal"
from emp;

--현재 접속 계정 : bituser--

--접속계정 HR ...
select * from employees;

사원테이블에서 사원의 이름은 last_name , first_name 합쳐서 fullname 별칭 부여해서 출력하고
입사일은  YYYY-MM-DD 형식으로 출력하고 연봉(급여 *12)을 구하고 연봉의 10%(연봉 * 1.1)인상한 값을 
출력하고 그 결과는 1000단위 콤마 처리해서 출력하세요
단 2005년 이후 입사자들만 출력하세요 그리고 연봉이 높은 순으로  출력하세요


select employee_id , first_name , last_name , hire_date , salary
from employees;

select   employee_id,
           first_name || last_name as "fullname",
           to_char(hire_date,'YYYY-MM-DD') as "hire_date",
           salary,
           salary * 12 as "연봉",
           to_char((salary * 12)*1.1,'$9,999,999,999') as "인상분",
           hire_date
from employees
where to_char(hire_date,'YYYY') >= '2005'
order by "연봉" desc; ---salary * 12 desc; -- order by 는 select 결과를 가지고 정렬  가명칭 사용 가능           

--
--문자
--숫자
--날짜
--변환(to_char 형식)

--[ 일반함수 ]
--프로그램밍 성향이 강한 ....
--nvl() , nvl2() --> null 
--decode() --> java if  유사
--case() --> java switch 유사

select comm, nvl(comm,0) from emp;

create table t_emp(
 id number(6),
 job varchar2(20)
);

insert into t_emp(id,job) values(100,'IT');
insert into t_emp(id,job) values(200,'SALES');
insert into t_emp(id,job) values(300,'MGR');
insert into t_emp(id) values(400);
insert into t_emp(id,job) values(500,'MGR');
commit;

select * from t_emp;

--1. nvl()
select id , job , nvl(job,'Empty....') from t_emp;

--2. nvl2()
select id, job , nvl2(job , job || ' 입니다' , 'empty..') from t_emp; 

select id , job , nvl2(job,'AAAA','BBBB') from t_emp;

--3. decode POINT (sql 언어 제어문이 없어요  if , for (x))
--decode(표현식 , 조건1 , 결과1 , 조건2 , 결과2 , 조건3 , 결과3 ...)
--통계 데이터 추출

select id, job, decode(id, 100,'IT...', 
                                 200,'SALES...', 
                                 300,'MGR...' ,
                                 'ETC...') as "decodejob"
from t_emp;

select job , decode(job,'IT',1) from t_emp; --decode 조건에 해당되지 않는 것은  null

select job , decode(job,'IT',1,1111) from t_emp; --default 값

--활용 (통계 데이터)
select decode(job,'IT',1) as "IT",  -- 컬럼 1개
         decode(job,'SALES',1) as "SALES", --컬럼 1개 
         decode(job,'MGR',1) as "MGR" --컬럼1개
from t_emp;


select count(decode(job,'IT',1)) as "IT",  -- 컬럼 1개
         count(decode(job,'SALES',1)) as "SALES", --컬럼 1개 
         count(decode(job,'MGR',1)) as "MGR" --컬럼1개
from t_emp;


select * from t_emp;

/*
emp 테이블에서 부서번호가 10이면 '인사부' , 20 '관리부' , 30 '회계부' 나머지 부서 번호는
'기타부서' 라고 출력하는 쿼리문을 만드세요
decode 를 사용해서
*/

select empno , ename , deptno , decode(deptno, 10, '인사부',
                                                                 20, '관리부',
                                                                 30, '회계부',
                                                                 '기타부서') as "부서이름"
from emp;                                                                 

create table t_emp2(
 id number(2),
 jumin char(7)
);

drop table t_emp2; --테이블 삭제  --다시 create
insert into t_emp2(id, jumin) values(1,'1234567');
insert into t_emp2(id, jumin) values(2,'2234567');
insert into t_emp2(id, jumin) values(3,'3234567');
insert into t_emp2(id, jumin) values(4,'4234567');
insert into t_emp2(id, jumin) values(5,'9234567');
commit;

select * from t_emp2;
/*
t_emp2 테이블에서 id, jumin 데이터를 출력하되 jumin 컬럼의 앞자리가 1이면 남성 , 2이면 여성 , 3이면 중성 
그 외는 기타 로 출력하세요
*/

select id, decode(substr(jumin,1,1) , 1, '남성',
                                            2, '여성',
                                            3, '중성',
                                            '기타' ) as "gender"
from t_emp2;                                

--난이도 중급
--java  if(){  if () {} }
--oracle : decode( decode() )

select  deptno , ename, decode(deptno,20, decode(ename, 'SMITH','HELLO',
                                                                              'WORLD'),
                                                    'ETC') as "decode"
from emp;                                                    



--CASE 문
--java : switch
/*
  CASE 조건 WHEN 결과1 THEN 출력1
                WHEN 결과2 THEN 출력2
                WHEN 결과3 THEN 출력3
                WHEN 결과4 THEN 출력4
                ELSE  출력5
  END "컬럼명"

*/

create table t_zip(
  zipcode number(10)
);
insert into t_zip(zipcode) values(2);
insert into t_zip(zipcode) values(31);
insert into t_zip(zipcode) values(32);
insert into t_zip(zipcode) values(33);
insert into t_zip(zipcode) values(41);
commit;
select * from t_zip;

select '0' || to_char(zipcode),  case zipcode when 2 then '서울'
                                                         when 31 then '경기'
                                                         when 32 then '강원'
                                                         when 41 then '제주'
                                                         else '기타지역'
                                       end "regionname"
from t_zip;                                       

/*
사원테이블에서 사원급여가 1000달러 이하면 4급   
1001 달러 2000달러 이하면 3급
2001 달러 3000달러 이하면 2급
3001 달러 4000달러 이하면 1급
4001 달러 이상이면 특급을 부여하는 데이터를 출력하세요

1.  case 컬럼명  when 결과 then 출력    (컬럼값 = 결과)
2. case when  컬럼명 조건비교  결과  then  (sal <= 200)

*/

select  case when sal <= 1000 then '4급'
                  when sal between 1001 and 2000 then '3급'
                  when sal between 2001 and 3000 then '2급'
                  when sal between 3001 and 4000 then '1급'
                  else '특급'
          end "급여등급" , empno, ename, sal
from emp;    

---
--문자 -> 숫자 -> 날짜 -> 변환(to_char, to_date, to_number) -> 일반함수(nvl() ~ case() 
--집계함수 그룹 함수(Multi Row Function)  pdf(75 page)

--[집계함수]
--1. count(*) , count(컬럼명) >> 데이터 건수
--2. sum()
--3. avg()
--4. max()
--5. min()
--등등
/*

1. POINT : 모든 집계함수는 null 값을 무시
2. POINT : select 절에 집계함수 이외에 다른 컬럼이 오면 반드시 group by 절에 명시

*/
select count(*) from emp; --row 수 

select count(empno) from emp; --데이터 건수 (null 무시)

select count(comm) from emp; ----데이터 건수 (null 무시)

select * from emp;

--null 건수 ....
select count(nvl(comm,0)) from emp;  --null 에 대한 처리 nvl()

--급여의 합 29025
select sum(sal) as "sum" from emp;

--평균 급여 (급여의 합 / 사원수)
select trunc(avg(sal),0) as "평균급여" from emp; --2073

--사장님이 우리 회사 수당이 총 얼마지급
select sum(comm) as "comm" from emp --4330
-- 평균수당
select trunc(avg(comm),0) as "avg" from emp; --721 


select  comm from emp;
select (300+200+30+300+3500+0) / 6 from dual; --721
--회사 사원 : 14명
--avg : 6명 .... (null 무시)


select (300+200+30+300+3500+0) / 14 from dual; --309
select sum(comm) /14 from emp;
select avg(nvl(comm,0)) from emp; --309

--둘다 맞아요
--회사 규정 : 전체 사원수 나눈다 : 309
--회사 규정 : 받는 사원수 기준 : 721

select count(comm) from emp where comm is not null;
select count(comm) from emp;

select max(sal) from emp;

select min(sal) from emp;

--POINT : 집계함수가 return  하는 값은 : 1개
select sum(sal) , avg(sal) , max(sal) , min(sal) ,count(sal) , count(*) from emp;

--부서별 평균 급여를 구하세요
select deptno, avg(sal) 
from emp
group by deptno; 

select avg(sal) from emp group by deptno; --실행가능 해석 불가능

--직종별 평균 급여 , 급여합 , 최대급여 , 최소급여 , 건수를 출력하세요
select job , avg(sal) , sum(sal) , max(sal) , min(sal), count(sal)
from emp
group by job;

/*
grouping 원리 (컬럼의 순서)
distinct 컬럼명1 , 컬러명2

order by 컬러명 asc , 컬럼명 desc

group by 컬럼명1, 컬럼명2

*/
--부서별 , 직종별 급여의 합을 구하세요

select deptno , job , sum(sal) , count(sal)
from emp
group by deptno , job
order by deptno asc;

/*
SELECT               4       
FROM                 1     
WHERE                2     
GROUP BY           3     
ORDER BY           5    
*/

--직종별 평균급여가 3000달러 이상인 사원의 직종과 평균급여를 출력하세요
--평균급여 >= 3000>> 평균급여 >> 시점 >> group by ....
-- where 평균급여 데이터 사용 못해요 ....
--group by 결과에 대한 조건 >> having 

--from 절의 조건절 : where
--group by  절의 조건절 : having

select job , avg(sal) as "avg"
from emp
group by job
having avg(sal) >= 3000;


/*
1개의 테이블에서 데이터를 조회할수 있는 방법

SELECT                 5     
FROM                   1   
WHERE                  2    
GROUP BY             3
HAVING                 4
ORDER BY              6
*/


/*
사원테이블에서 직종별 급여합을 출력하되 수당은 지급 받고 급여의 합이 5000 이상인 사원들의 목록을 출력하세요
--급여의 합이 낮은 순으로 출력하세요
*/
select job, sum(sal) as "sumsal"
from emp
where comm is not null
group by job
having sum(sal) >= 5000
order by "sumsal" asc;

/*
사원테이블에서 부서 인원이 4명보다 많은 부서의 부서번호 ,인원수 , 급여의 합을 출력하세요
*/
select deptno , count(*) as "부서별인원" , sum(sal) as "부서별 급여의 합"
from emp
group by deptno
having count(*) > 4;

/*
사원테이블에서 직종별 급여의 합이 5000를 초과하는 직종과 급여의 합을 출력하세요
단 판매직종(salesman) 은 제외하고 급여합으로 내림차순 정렬하세요
*/
select job, sum(sal) as "sumsal"
from emp
where job != 'SALESMAN'
group by job
having sum(sal) > 5000 
order by "sumsal" desc;

-----------------------------------------------------------------------------
--지금까지 SELECT 대상 하나의 테이블 ....
--RDBMS (최소 하나의 이상의 테이블로 이루어진 ...)

--java : class 작업 : 관계 (상속, 구현 , 연관 , ...)
--DB : Table Table 끼리 관계를 가지고 있다
--1:1 , 1:n , m:n 관계
--내가 원하는 데이터가 하나의 테이블있는 것이 아니고 1개 이상의 테이블에 나누어져 있다
--나누어진 테이블에서 원하는 데이터를 출력하는 방법 >> JOIN

--종류
--1. 등가조인(equi join) => 70%
--원테이블과 대응대는 테이블에 있는 컬럼의 데이터 1:1 매핑
--[ANSI 문법]
--문법 : join on~조건절 ,  [inner] join on~조건절

--2. 비등가조인(non-equi join) => 의미만 존재 => 문법은 등가 조인 
--원테이블과 대응대는 테이블에 있는 컬럼이 1:1 매핑되지 않는 경우
--emp , salgrade : sal 컬럼을 가지고 ... 2개의 컬럼(losal , hisal)

--3. 외부조인(outer join : null) >> equi join null 처리가 안되요
--outer join (두개의 테이블에서 주, 종 관계 파악)
--문법
-- left outer join (왼쪽 주 , 오른쪽 종)
-- right outer join (오른쪽 주 , 왼쪽 종) 
-- full outer join (left , right join >> union 하면)



--self join (자기참조) => 의미만 존재 => 등가조인
--emp 테이블에서 smith  사원의 관리자 이름은 무었입니까
--하나의 테이블에서 어떤 컬럼이 다른 컬럼을 참조 하는 경우에 
select * from emp;




create table M (M1 char(6) , M2 char(10));
create table S (S1 char(6) , S2 char(10));
create table X (X1 char(6) , X2 char(10));

insert into M values('A','1');
insert into M values('B','1');
insert into M values('C','3');
insert into M values(null,'3');
commit;

insert into S values('A','X');
insert into S values('B','Y');
insert into S values(null,'Z');
commit;

insert into X values('A','DATA');
commit;

select * from m;
select * from s;
select * from x;

---------------------------------------------------------------
--아래는 sql 조인 문법 (되도록이면 사용을 ..... 하지 .... 말아요)
select *
from m , s
where m.m1 = s.s1;

select m.m1 , m.m2 , s.s2
from m , s
where m.m1 = s.s1;

select emp.empno , emp.ename, emp.deptno , dept.dname
from emp , dept
where emp.deptno = dept.deptno;
---------------------------------------------------------------
--ANSI 문법
select *
from m join s
on m.m1 = s.s1;

select m.m1 , m.m2 , s.s2
from m inner join s
on m.m1 = s.s1;

select emp.empno , emp.ename, emp.deptno , dept.dname
from emp join dept
on emp.deptno = dept.deptno;



select e.empno , e.ename, e.deptno , d.dname
from emp e join dept d
on e.deptno = d.deptno;

-------------------------------------------
--SQL JOIN  어떤것이 from 조건이고 어떤것이 join  조건인지 판단 어려움
select *
from m , s
where m.m1 = s.s1 and m.m1 = 'A';

select *
from m join s on m.m1 = s.s1
where m.m1 ='A';  --권장사항 


select * 
from s join x
on s.s1 = x.x1;

--한개 이상의 테이블에서 JOIN 걸기
--oracle sql join 문법
select *
from m , s , x
where m.m1 = s.s1 and s.s1 = x.x1;

--ansi  문법
select m.m1 , m.m2 , s.s2 , x.x2
from m join s on m.m1 = s.s1 
           join x on s.s1 = x.x1 ;
--           join y on
--           join z on

--사번 , 이름 , 부서번호 , 부서명 , 급여 , 급여등급을 출력하세요

select e.empno , e.ename , e.deptno, d.dname , e.sal , s.grade
from emp e join dept d on e.deptno = d.deptno
                 join salgrade s on e.sal between s.losal and s.hisal
order by e.empno;  --비등가 ...문법 등가문법 



--1. HR 계정으로 이동
select * from employees;
select * from departments;
select * from locations;
--1.  사번 , 이름(last_name) , 부서번호 , 부서이름을 출력하세요
select e.employee_id , e.last_name , e.department_id, d.department_name
from employees e join departments d
on e.department_id = d.department_id
order by e.employee_id;

--문제점  사원수 107명 >> 현재 출력된 106 (누군가 누락)
--등가조인 문법 이 문제 해결 불가능 ..... >> 해결 (outer join)
--why ? null 일 것 같다


--2. 사번 , 이름(last_name) , 부서번호 , 부서이름 , 도시명을 출력하세요
select e.employee_id , e.last_name , e.department_id, d.department_name , d.location_id, l.city
from employees e  join departments d  on e.department_id = d.department_id
       join locations l on d.location_id = l.location_id 
order by e.employee_id;


select * from tabs;  --접속한 계정이 가지고 있는 Table 목록

--비등가 (1:1 매핑 되는 컬럼이 없어요)
select * from emp;
select * from salgrade;
--사번 , 이름 , 급여 , 급여등급을 출력  (등가 문법)
select e.empno , e.ename , e.deptno, d.dname , e.sal , s.grade
from emp e join dept d on e.deptno = d.deptno
                 join salgrade s on e.sal between s.losal and s.hisal
order by e.empno; 


--outer join : 내부적으로 등가조인 실행하고 (주, 종) 관계를 파악하고
--주인이 되는 테이블에 남아 있는 데이터를 가지고 오는 방법

select *
from m join s
on m.m1 = s.s1;

select *
from m left outer join s
on m.m1 = s.s1;


select *
from m right outer join s
on m.m1 = s.s1;

--접속 : HR
--1.  사번 , 이름(last_name) , 부서번호 , 부서이름을 출력하세요
select e.employee_id , e.last_name , e.department_id, d.department_name
from employees e join departments d
on e.department_id = d.department_id
order by e.employee_id;


select * from employees where department_id is null;
--Grant 부서 null  하더라도 107명의 사원이 나오길 원한다
select e.employee_id , e.last_name , e.department_id, d.department_name
from employees e left outer join departments d
on e.department_id = d.department_id
order by e.employee_id;


select e.employee_id , e.last_name , e.department_id, d.department_name , d.location_id, l.city
from employees e left outer  join departments d  on e.department_id = d.department_id
                         left outer  join locations l on d.location_id = l.location_id 
order by e.employee_id;
--178	Grant				

select *
from m full outer join s
on m.m1 = s.s1;

--self join 
select e.empno, e.ename , m.empno , m.ename
from emp e join emp m
on e.mgr = m.empno;

--사원 14명  .... 13명

select e.empno, e.ename , m.empno , m.ename
from emp e left outer join emp m
on e.mgr = m.empno;

------------------------------------------------
-- 1. 사원들의 이름, 부서번호, 부서이름을 출력하라.
SELECT E.ENAME, E.DEPTNO, D.DNAME
FROM EMP E  join DEPT D on E.DEPTNO=D.DEPTNO;
 
-- 2. DALLAS에서 근무하는 사원의 이름, 직위, 부서번호, 부서이름을
-- 출력하라.
SELECT E.ENAME, E.JOB, D.DEPTNO, D.DNAME
FROM EMP E  join DEPT D on E.DEPTNO=D.DEPTNO 
WHERE  D.LOC='DALLAS';
 
-- 3. 이름에 'A'가 들어가는 사원들의 이름과 부서이름을 출력하라.
SELECT E.ENAME, D.DNAME
FROM EMP E  join DEPT D  on D.DEPTNO=E.DEPTNO
WHERE  E.ENAME LIKE '%A%';
--WHERE Regexp_like(E.ENAME,'^A'); 
-- 4. 사원이름과 그 사원이 속한 부서의 부서명, 그리고 월급을
--출력하는데 월급이 3000이상인 사원을 출력하라.
SELECT E.ENAME, D.DNAME, E.SAL 
FROM EMP E  join DEPT D on E.DEPTNO=D.DEPTNO
WHERE E.SAL>=3000;
 
-- 5. 직위(직종)가 'SALESMAN'인 사원들의 직위와 그 사원이름, 그리고
-- 그 사원이 속한 부서 이름을 출력하라.
SELECT E.JOB, E.ENAME, D.DNAME
FROM EMP E  join DEPT D on E.DEPTNO=D.DEPTNO
WHERE E.JOB='SALESMAN';
 
-- 6. 커미션이 책정된 사원들의 사원번호, 이름, 연봉, 연봉+커미션,
-- 급여등급을 출력하되, 각각의 컬럼명을 '사원번호', '사원이름',
-- '연봉','실급여', '급여등급'으로 하여 출력하라.
--(비등가 ) 1 : 1 매핑 대는 컬럼이 없다
SELECT E.EMPNO AS "사원번호",
               E.ENAME AS "사원이름",
               E.SAL*12 AS "연봉",
           --E.SAL*12+NVL(COMM,0) AS "실급여",
               E.SAL*12+COMM AS "실급여",
               S.GRADE AS "급여등급"
FROM EMP E  join SALGRADE S on E.SAL BETWEEN S.LOSAL AND S.HISAL
WHERE E.Comm is not null;
 
-- 7. 부서번호가 10번인 사원들의 부서번호, 부서이름, 사원이름,
-- 월급, 급여등급을 출력하라.
-- inner 는 생략 가능
SELECT E.DEPTNO, D.DNAME, E.ENAME, E.SAL, S.GRADE
FROM EMP E   join DEPT D on E.DEPTNO=D.DEPTNO
                         join SALGRADE S on E.SAL BETWEEN S.LOSAL AND S.HISAL
WHERE E.DEPTNO=10;
 
SELECT * FROM SALGRADE;
 
 
-- 8. 부서번호가 10번, 20번인 사원들의 부서번호, 부서이름,
-- 사원이름, 월급, 급여등급을 출력하라. 그리고 그 출력된
-- 결과물을 부서번호가 낮은 순으로, 월급이 높은 순으로
-- 정렬하라.
-- inner 는 생략 가능
SELECT E.DEPTNO, D.DNAME, E.ENAME, E.SAL, S.GRADE
FROM EMP E  join DEPT D    on E.DEPTNO=D.DEPTNO
            join SALGRADE S    on E.SAL BETWEEN S.LOSAL AND S.HISAL
WHERE  E.DEPTNO<=20 --WHERE E.DEPTNO IN (10,20)  -- e.deptno = 10 or 
ORDER BY E.DEPTNO ASC,  E.SAL DESC;
 
 
-- 9. 사원번호와 사원이름, 그리고 그 사원을 관리하는 관리자의
-- 사원번호와 사원이름을 출력하되 각각의 컬럼명을 '사원번호',
-- '사원이름', '관리자번호', '관리자이름'으로 하여 출력하라.
--SELF JOIN (자기 자신테이블의 컬럼을 참조 하는 경우)
 
SELECT E.EMPNO, E.ENAME , M.EMPNO, M.ENAME
FROM EMP E  left outer join EMP M
on e.MGR = m.EMPNO;

--------------------------------------------------------------
--초급 개발자 : 함수 , 조인 
--------------------------------------------------------------
--[subquery]  pdf 100page
--sql 만능 해결사 >> sql 꽃 

--사원테이블에서 사원들의 평균 월급보다 더 많은 급여를 받는 사원의 사번 , 이름 , 급여를 출력하세요

--subquery
select avg(sal) from emp;  --2073

--main query
select *
from emp
where sal > 2073;

select *
from emp
where sal > (select avg(sal) from emp)

--쿼리 ...
--함수해결(단일) > 조인2개이상) > subquery(마지막 무기)

/*
subquery 
종류
하나의 컬럼으로 결과가 
1. single row subquery : subquery 의 결과가 1개 row(단일값) : 컬럼 1개
select sum(sal) from emp;


2. multi row subquery : subquery 의 결과가 1개 이상의 row(여러개값) : 컬럼 1개
select sal from emp;

구분하는 이유 (사용되는 연산자 틀리다)
--연산자 (in  , not in) (any , all) 다중데이터
--all : sal > 1000 and sal > 2000 and ...
--any : sal > 1000 or sal > 2000 or ...

문법(정의)
1. subquery 는 괄호안에 있어야 한다 >>  (select sal from emp)
2.subquery 는 단일 컬럼으로 구성 >> select sum(sal) , avg(sal) from emp (x)
3. subquery 는 단독으로 실행 가능해야 한다

subquery  를 가지는 쿼리 문은
1. subquery 선행
2. subquery 결과를 가지고 main  query  실행

*/

--사원테이블에서 jones의 급여보다 더 많은 급여를 받는 사원의 사번 , 이름 , 급여 출력하세요

select sal from emp where ename='JONES';

select empno , ename, sal
from emp
where sal > (select sal from emp where ename='JONES');


 select *
 from emp
 where sal = (select sal from emp where deptno=30); (x)
 
 select *
 from emp
 where sal in (select sal from emp where deptno=30);
 --where sal=2975 or sal =3000 or 
 
 select *
 from emp
 where sal not in (select sal from emp where deptno=30);
 --where sal != 2975 and sal !=3000 and   POINT
 
 --부하직원이 있는 사원의 사번과 이름을 출력하세요
 
 select empno , ename 
 from emp where empno in (select mgr from emp);
 --empno = 7839 or empno=7698 or empno is null or 
 --or 연산에서 null(x)
 
 --null 모든 연산은  null
 --부하직원이 없는 사원의 사번과  이름을 출력하세요

 select empno , ename 
 from emp where empno not in (select nvl(mgr,0) from emp);
 --empno != 7839 and empno!=7698 and empno is null and .... >>>>>>> null 
 
 
 --king  에게 보고하는 즉 직속상관이 king  인 사원의 사번 , 이름, 직종 , 관리자 사번을 출력하세요
 select empno from emp where ename='KING';
 
 select empno, ename, job , mgr
 from emp
 where mgr = (select empno from emp where ename='KING');
 
 --20번 부서의 사원중에서 가장 많은 급여를 받는 사원보다 더 많은 급여를 받는 사원의 
 --사번 , 이름 , 급여 ,부서번호를 출력하세요
 
 select max(sal) from emp where deptno=20;

 select empno, ename , sal , deptno
 from emp
 where sal > (select max(sal) from emp where deptno=20);
 
 
 select * from emp
 where deptno in (select deptno from emp where job='SALESMAN')
 and sal in (select sal from emp where job='SALESMAN');
 
 
 --30분
 --1. 'SMITH'보다 월급을 많이 받는 사원들의 이름과 월급을 출력하라.
SELECT ENAME, SAL
FROM EMP
WHERE SAL>(SELECT SAL
               FROM EMP
               WHERE ENAME='SMITH');
 
--2. 10번 부서의 사원들과 같은 월급을 받는 사원들의 이름, 월급,
-- 부서번호를 출력하라.
SELECT ENAME, SAL, DEPTNO
FROM EMP
WHERE SAL IN(SELECT SAL
                 FROM EMP
                 WHERE DEPTNO=10);
 
--3. 'BLAKE'와 같은 부서에 있는 사원들의 이름과 고용일을 뽑는데
-- 'BLAKE'는 빼고 출력하라.
SELECT ENAME, HIREDATE
FROM EMP
WHERE DEPTNO=(SELECT DEPTNO
                     FROM EMP
                     WHERE ENAME='BLAKE')
AND ENAME!='BLAKE';
 
--4. 평균급여보다 많은 급여를 받는 사원들의 사원번호, 이름, 월급을
-- 출력하되, 월급이 높은 사람 순으로 출력하라.
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL>(SELECT  AVG(SAL)  FROM EMP)
ORDER BY SAL DESC;
 
--5. 이름에 'T'를 포함하고 있는 사원들과 같은 부서에서 근무하고
-- 있는 사원의 사원번호와 이름을 출력하라.
SELECT EMPNO, ENAME
FROM EMP
WHERE DEPTNO IN(SELECT DEPTNO
                       FROM EMP
                       WHERE ENAME LIKE '%T%');
--where deptno = 20 or deptno= 30
--6. 30번 부서에 있는 사원들 중에서 가장 많은 월급을 받는 사원보다
-- 많은 월급을 받는 사원들의 이름, 부서번호, 월급을 출력하라.
--(단, ALL(and) 또는 ANY(or) 연산자를 사용할 것)
SELECT ENAME, DEPTNO, SAL
FROM EMP
WHERE SAL > (SELECT MAX(SAL)
                FROM EMP
                WHERE DEPTNO=30);
 
SELECT ENAME, DEPTNO, SAL
FROM EMP
WHERE SAL > ALL(SELECT SAL
  FROM EMP
  WHERE DEPTNO=30)
 
--where sal > 1600 and sal > 1250 and sal > 2850 and sal > 1500 and sal > 950
 
 
--7. 'DALLAS'에서 근무하고 있는 사원과 같은 부서에서 일하는 사원의
-- 이름, 부서번호, 직업을 출력하라.
SELECT ENAME, DEPTNO, JOB
FROM EMP
WHERE DEPTNO IN(SELECT DEPTNO    -- = 이 맞는데  IN
                      FROM DEPT
                      WHERE LOC='DALLAS');
 
--8. SALES 부서에서 일하는 사원들의  같은 부서번호, 이름, 직업을 갖는 사원정보를 출력하라.
SELECT DEPTNO, ENAME, JOB
FROM EMP
WHERE DEPTNO IN(SELECT DEPTNO
                      FROM DEPT
                      WHERE DNAME='SALES')
 
--9. 'KING'에게 보고하는 모든 사원의 이름과 급여를 출력하라
--king 이 사수인 사람 (mgr 데이터가 king 사번)
SELECT ENAME, SAL
FROM EMP
WHERE MGR=(SELECT EMPNO
                FROM EMP
                WHERE ENAME='KING');
 
--10. 자신의 급여가 평균 급여보다 많고, 이름에 'S'가 들어가는
-- 사원과 동일한 부서에서 근무하는 모든 사원의 사원번호, 이름,
-- 급여를 출력하라.
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL > (SELECT AVG(SAL)
                FROM EMP)
AND DEPTNO IN(SELECT DEPTNO
                   FROM EMP
                   WHERE ENAME LIKE '%S%');
 
--select * from emp
--where  deptno in  (
--                      select deptno from emp where sal > (select avg(sal) from emp)
--                      and ename like '%S%'
--                   )
 
--11. 커미션을 받는 사원과 부서번호, 월급이 같은 사원의
-- 이름, 월급, 부서번호를 출력하라.
SELECT ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO IN(SELECT DEPTNO
                      FROM EMP
                      WHERE COMM IS NOT NULL)
AND SAL IN( SELECT SAL
               FROM EMP
               WHERE COMM IS NOT NULL);
 
--12. 30번 부서 사원들과 월급과 커미션이 같지 않은
-- 사원들의 이름, 월급, 커미션을 출력하라.
SELECT ENAME, SAL, COMM
FROM EMP
WHERE SAL NOT IN(SELECT SAL
                        FROM EMP
                        WHERE DEPTNO=30)
AND COMM NOT IN(SELECT COMM
                         FROM EMP
                         WHERE DEPTNO=30 and comm is not null);
 
--SELECT NVL(COMM, 0)
--FROM EMP
--WHERE DEPTNO=30 and comm is not null;
 
--SELECT COMM
--FROM EMP
--WHERE DEPTNO=30 and comm is not null;

------------------------------------------------------------------------------
/*
select
from
where
group by
having
order by

기본함수 (문자 ~   일반함수)
다중테이블 (JOIN )
subquery 
+
DML(insert , update , delete)  암기 (필수사항)
*/

--[insert , update , delete]
/*
오라클 기준
DDL(데이터 정의어) : create , alter , drop , truncate (rename, modify) --> DBA
DML(데이터 조작어) : insert , update , delete -> 개발자
DQL(데이터 질의어) : select -> 개발자 (함수 , 조인 , 서브쿼리)
DCL(데이터 제어어) : 권한 (grant , revoke) -->  DBA
TCL(트랜잭션) : commit , rollback , savepoint --> 개발자
*/

--DML 작업
--오라클 내부적으로 트랜잭션 동반 :
--오라클 (begin tran...) 자동으로 ~~~ 처리 완료 (rollback , commit)  
--insert .. 실행

--트랜잭션(transaction) : 하나의 논리적인 작업 단위
--업무 (트랜잭션)
--은행 (A 계좌 돈의 1000 인출  B라는 계좌 입금)
--업무 (A 돈을 인출 ~~~~~~ B라는 계좌 입근) 하나의 업무
/*
  시작 .....
   A라는 계좌
   update  계좌
   set 잔액 = 잔액-출금액

   B라는 계좌
   update 계좌
   set 잔액 = 잔액 + 입금액
  끝  ... commit
  
  끝까지 오지 않고 문제가 하나라도 생기면 원점 : rollback
*/
--테이블 기본 정보
desc emp;

--오라클 (system 테이블 다양한 정보 제공)
select * from tab; --접속계정 다룰 수 있는  table 목록

select * from tab where tname='EMP'; --테이블 생성 여부 ... 있는지 없는지

select * from col where tname='EMP';

select * from user_tables; --관리자 , 튜닝
select * from user_tables where table_name='DEPT';


--DML(pdf > 168page)
/*
INSERT INTO table_name [(column1[, column2, . . . . . ])] 
VALUES  (value1[, value2, . . . . . . ]);
*/

create table temp(
  id number primary key , --id 컬럼에 데이터는 null(x) , 중복값도 (x) 강제하는 방법이 제약
  name varchar2(20) --default null
);

insert into temp(id , name)
values(100, '홍길동');

select * from temp;
--실반영
commit;

--2. 컬럼 리스트 생략하기
insert into temp  --컬럼리스트 생략 (생략하지 마세요)
values(200,'김유신');


select * from temp;
commit;

--1
insert into temp(id, name) 
values(100,'아무게');  --unique constraint (BITUSER.SYS_C007013) violated
                          --PK 제약 위반
                          
--2
insert into temp(name)
values('누구야'); --ORA-01400: cannot insert NULL into ("BITUSER"."TEMP"."ID")
                   --PK 제약 위반( null)

--재미 ^^
--sql 변수 , 제어문 (x)
--pl-sql (java 언어 처럼 사용)
create table temp2(id varchar2(20));

/*
BEGIN
  FOR i IN 1..1000 LOOP
     insert into temp2(id) values('A' || to_char(i));  
  END LOOP;
END;
*/
select * from temp2;
select count(*) from temp2;

----
create table temp3(
  memberid number(3) not null,
  name varchar2(10),  --default null
  regdate date default sysdate -- regdate  컬럼에 데이터를 insert  하지 않아도 ,,,,,
);

insert into temp3(memberid, name, regdate)
values(100,'홍길동','2019-09-27');

select * from temp3;
commit;

insert into temp3(memberid, name)
values(200,'김유신');

select * from temp3;
commit;

insert into temp3(memberid)
values(300);


select * from temp3;
commit;
--
--옵션 TIP
--1. 대량 데이터 삽입하기(INSERT)

create table temp4(id number);
create table temp5(num number);

insert into temp4(id) values(1);
insert into temp4(id) values(2);
insert into temp4(id) values(3);
insert into temp4(id) values(4);
insert into temp4(id) values(5);
insert into temp4(id) values(6);
insert into temp4(id) values(7);
insert into temp4(id) values(8);
insert into temp4(id) values(9);
insert into temp4(id) values(10);

commit;


select * from temp4;

--요구사항 : temp4 테이블에 있는 모든 데이터를 temp6에 넣고 싶어요
--insert into 테이블명(컬럼리스트)  select  구문 --values
--단 컬럼개수와 타입이 일치

insert into temp5(num)
select id from temp4;
--values

select * from temp5;
commit;


--2. Insert
--복사의 (clone) insert
--테이블이 없는 상황에서  [테이블 자동생성][대량 데이터 삽입]
--단 제약 정보 복사가 안되요

--emp >>  copyemp 테이블을 만들고 데이터 똑같이
drop table copyemp;

create table copyemp
as
    select * from  emp;
    
select * from copyemp;    


create table copyemp2
as
     select empno , ename , sal 
     from emp 
     where deptno=30;


select * from copyemp2;

--구조만 복사하고 데이터는 복사하고 싶지 않아요
create table copyemp3
as
    select * from emp where 1=2;
    
select * from copyemp3;    

commit;

--[INSERT END]

--[UPDATE]
/*
UPDATE  table_name 
SET  column1 = value1 [,column2 = value2,. . . . . . .]
[WHERE  condition]; 



UPDATE  table_name 
SET  (column1, column2, . . . . ) =   ( SELECT  column1,column2, . . .   subquery 올수 있다
                                             FROM   table_name    
                                             WHERE  coundition)
[WHERE  condition]; 
*/ 
 
select * from copyemp;
commit;

update copyemp
set sal = 0;

select * from copyemp;
rollback;

update copyemp
set job='NOT....'
where deptno=20;

select * from copyemp where deptno=20;
commit;

update copyemp
set sal = (select sum(sal) from emp)

select * from copyemp;
rollback;

update copyemp
set ename ='AAA' , job='BBB' , sal = (select sum(sal) from emp)
where deptno=10;

select * from copyemp where deptno=10;

commit;

--[UPDATE END]

--[DELETE]
delete from copyemp;

select * from copyemp;

rollback;

delete from copyemp where sal >= 3000

commit;

--[DELETE END]

/*
APP(java)  --> JDBC API  --> Oracle (Mysql , MS-sql...)

개발자 : CRUD 작업

Create  : insert 
Read    : select
Update : update
Delete  : delete

C U D >> 트랜잭션 동반 (commit , rollback)

--EMP 테이블  (Oracle)
--Java 
--삽입 , 수정 , 삭제 , 전체조회 , 조건조회(PK  where empno=7788)
--java 함수 5개

--public int insertEmp(Emp emp) {  insert into emp....     }
--public List<Emp> getEmpList(){  select * from emp  }
--public Emp getEmpListByEmpno(int empno) {  select ... where empno=7788 }

*/
--오라클 11g 가상컬럼(조합 컬럼)
--컬럼 : 국어 , 영어  , 수학 .....  >> 합 , 평균 
--컬럼 : 국어 , 영어  , 수학 , 합 , 평균  자동화
drop table vtable;

create table vtable(
   no1 number,
   no2 number,
   no3 number GENERATED ALWAYS as (no1 + no2) VIRTUAL
);

insert into vtable(no1, no2) values(100,200);
insert into vtable(no1, no2) values(80,50);

select * from vtable;
commit;

insert into vtable(no1, no2,no3) values(10,50,60); --(x)

select column_name , data_type, data_default
from user_tab_columns where table_name='VTABLE';

--실무에 사용되는 형식의 코드
--제품의 정보 (입고일) 기준으로 분기 (1~ 4분기)
--20190101  ,  20190520  
create table vtable2(
 no number, --순번
 p_code char(4), --제품코드(A001 , B002)
 p_date char(8), --입고일(20190909) --날짜 타입 ... 문자형식 ... 문자열 함수 사용 
 p_qty number, --수량
 p_bungi number(1) GENERATED ALWAYS as (
                            case when substr(p_date,5,2) in ('01','02','03') then 1
                                   when substr(p_date,5,2) in ('04','05','06') then 2
                                   when substr(p_date,5,2) in ('07','08','09') then 3
                                   else 4
                           end
                          ) VIRTUAL

);
select column_name , data_type, data_default
from user_tab_columns where table_name='VTABLE2';

insert into vtable2(p_date) values('20190101');
insert into vtable2(p_date) values('20190129');
insert into vtable2(p_date) values('20190404');
insert into vtable2(p_date) values('20191101');
insert into vtable2(p_date) values('20191201');
commit;
select * from vtable2;
select * from vtable2 where p_bungi=1


--
--DDL 테이블 다루기 
--pdf 138 page (제 9 장 테이블(TABLE) 생성 )

--1. 테이블 생성하기
create table temp6(
  id number
);

--2. 테이블 생성했는데 컬럼 .... 추가하는 방법
--기존 테이블에 컬럼 추가하기
alter table temp6
add ename varchar2(20);

desc temp6;

--3. 기존 테이블에 있는 컬럼의 이름 잘못표기 (ename -> username)
--기존 테이블에 있는 기존 컬럼의 이름 바꾸기 ( rename)
alter table temp6
rename column ename to username;

desc temp6;

--4. 기존 테이블 있는 기존 컬럼의 TYPE 수정
--(modify)
alter table temp6
modify (username varchar2(2000));

desc temp6;

--5, 기존 테이블에 있는 기존 컬럼 삭제
alter table temp6
drop column username;

desc temp6;

--6. delete : 데이블 데이터 삭제
-- 테이블 처음 만들면 처음 크기 >> 데이터 넣으면 >> 데이터 크기 
--ex) 처음 1M >> 10만건 >> 100M ---> 10건 데이터 delete >> 현재 테이블 크기 >> 101M
--테이블 데이터 삭제 , [공간의 크기] 처음 상태로
--truncate ( where 조건 (x))
--ex) 처음 1M >> 10만건 >> 100M ---> 10건 데이터 truncate >> 현재 테이블 크기 >>1M

--drop table temp6

--
--테이블 제약 설정하기
--pdf 144 page
--데이터 무결성 확보
--제약 (constraint) insert , update  주로 ,,,,
/*
NOT NULL(NN) 열은 NULL 값을 포함할 수 없습니다. 

UNIQUE key(UK) 테이블의 모든 행을 [유일하게 하는 값]을 가진 열(NULL 을 허용) 
--unique 제약은 null 가질 수 있다 >> null 값을 가지지 못하게 할려면 ( ename u , not null..)
--컬럼의 개수 만큼
a  u not
b  u not
c  u not


PRIMARY KEY(PK) 유일하게 테이블의 각행을 식별(NOT NULL 과 UNIQUE 조건을 만족) 
--not null 하고 unique  한 제약
--테이블 1개  (여러컬럼을 묶어서 하나로 : 복합키)
--주민번호 , 게시판 글번호 , 학번 , 핸드폰 번호
--index  자동생성 (빠른 검색)
--where boardid = 100

--진호 : 만화방 ... 50권 ... 주고객 ... 장사 ... 고객 열혈강호  고객 .... 
--진호 : 1000권 ...  
--진호 : 방안 .... 만화책 카테고리 (무협(가나다) , 소년만화(가나다))
--물리적인 (1개) ... ㄱ ㄴ ㄷ   다람쥐  ...

--논리적인 것 : 년도(2000) 가열 3행 (주소)

--도서관 : java : 위치 (가열 ....)

--index 관리 (주기적으로 업데이터) 비용  : DBA

FOREIGN KEY(FK) 열과 참조된 열 사이의 외래키 관계를 적용하고 설정합니다. 
(참조 제약) 테이블과 테이블간의 제약
:  EMP , DEPT  참조제약 필요한 데 지금은 (x)  ,,,데이터는 맞추어 놓았어요



CHECK(CK) 참이어야 하는 조건을 지정함(대부분 업무 규칙을 설정
내가 원하는 값만 받겠다 (gender  컬럼의 데이터  '남'  , '여' 만 받겠다)
나는 항상 체크 데이터를 
ex)  where gender in ('남' , '여')


5가지 제약을 만드는 시점
1. 테이블을 생성할때  바로 생성 (create table  구문안에서)
2. 테이블 생성 이후 (create table 생성 ,,,,, 추후에  alter table add constraint ....  (자동화된 툴)


*/
select* from user_constraints where table_name='EMP';

--간단 표기법(줄임) (권장 (x))
create table temp7
(
   --id number constraint pk_temp7_id primary key  --pk_temp7_id 제약 (관용)
   id number primary key,
   name varchar2(20) not null,
   addr varchar2(50)
);

--SYS_C007047  내부적으로 제약이름 SYS  고유번호  (시스템)
--SYS_C007048
--내가 원하는 대로 이름 설정 (full 표기)

select* from user_constraints where lower(table_name)='temp7';

insert into temp7(name, addr) values('홍길동','서울시 강남구'); --cannot insert NULL into ("BITUSER"."TEMP7"."ID")

insert into temp7(id, name, addr) values(10,'홍길동','서울시 강남구');

insert into temp7(id, name, addr) values(10,'김유신','서울시 강북구'); --"unique constraint (%s.%s) violated

--pK 건다는 건 (where id  자주 사용한다) - PK 걸면  그 컬럼에 대한 자동으로 index  검색 속도 향상
select * from temp7 where id = 10;

commit;

--테이블에 index 정보 확인하기
select * from user_indexes where table_name='TEMP7';

--정식 표현
create table temp8(
 id number constraint pk_temp8_id primary key,
 name varchar2(20) not null,
 jumin char(6) constraint uk_temp8_jumin unique, --not null  null 중복 가능
 --jumin char(6) not null constraint uk_temp8_jumin unique,
 addr varchar2(20)
)

select * from user_indexes where table_name='TEMP8';

insert into temp8(id, name, jumin, addr)
values(10,'홍길동','123456','서울시');

select * from temp8;
commit;


insert into temp8(id, name, jumin, addr)
values(10,'A','456789','서울시');  --unique constraint (BITUSER.PK_TEMP8_ID) violated  (PK)


insert into temp8( name, jumin, addr)
values('A','456789','서울시');     --cannot insert NULL into ("BITUSER"."TEMP8"."ID")


insert into temp8(id, name, jumin, addr)
values(20,'아무게','123456','서울시');  --unique constraint (BITUSER.UK_TEMP8_JUMIN) violated

insert into temp8(id, name, addr)
values(20,'아무게','서울시');

insert into temp8(id, name, addr)
values(30,'야무지게','서울시');   --unique (null 에 대한 중복 체크 하지 않아요)

select * from temp8;
commit;

--테이블 생성 후에 제약 걸기
create table temp9 (id number);

--기존 테이블 >>데이터 실습 >> 10, 10 2건 >> PK  제약 (데이터 검사) (x) >> 데이터 삭제 >> PK
alter table temp9
add constraint pk_temp9_id primary key(id);


--두개 컬럼을 묶어서 (1개)
--alter table temp9
--add constraint pk_temp9_id primary key(id,jumin);  중복키 (복합키)



select * from user_indexes where table_name='TEMP9';
select* from user_constraints where table_name='TEMP9';
desc temp9;

--ename 컬럼 추가
alter table temp9
add ename varchar2(20);

desc temp9;

--not null 추가하기
alter table temp9
modify(ename not null);

desc temp9;

--check
create table temp10(
 id number constraint pk_temp10_id primary key,
 name varchar2(20) not null,
 jumin char(6) constraint uk_temp10_jumin unique, --not null  null 중복 가능
 --jumin char(6) not null constraint uk_temp8_jumin unique,
 addr varchar2(20),
 age number constraint ck_temp10_age  check(age >= 19)       --where age >= 19 , gender in('남','여')
);


select* from user_constraints where table_name='TEMP10';

insert into temp10(id, name, jumin, addr , age)
values(100,'홍길동','123456','서울시',20);

select * from temp10;
commit;

insert into temp10(id, name, jumin, addr , age)
values(200,'김유신','789456','서울시',15);
-- check constraint (BITUSER.CK_TEMP10_AGE) violated

commit;


---------------
--참조제약  >> 테이블과 테이블과의 관계 >> RDB
create table c_emp
as
    select empno, ename, deptno from emp where 1=2;
 
create table c_dept
as
   select deptno , dname from dept where 1=2;


select* from user_constraints where table_name='C_EMP';

select* from user_constraints where table_name='C_DEPT';

--참조키 (c_emp(deptno) 컬럼은 c_dept(deptno) 컬럼은 참조 합니다
--c_dept(deptno) 컬럼은 c_emp(deptno) 컬럼의 참조를 당합니다

--2) 선핼 작업후 
alter table c_emp
add constraint fk_c_emp_deptno foreign key(deptno) references c_dept(deptno);

--참조를 당하는 테이블있는 컬럼은 (신용을 보장)
--PK . Unique 제약
--1. PK 설정
--2.FK 참조
--1)선행
alter table c_dept
add constraint pk_c_dept_deptno primary key(deptno);

select* from user_constraints where table_name='C_EMP';

select* from user_constraints where table_name='C_DEPT';

insert into c_dept(deptno, dname) values(100,'인사팀');
insert into c_dept(deptno, dname) values(200,'관리팀');
insert into c_dept(deptno, dname) values(300,'회계팀');
commit;

select * from c_dept;
select * from c_emp; 

--사원 입사 (참조 키)
insert into c_emp(empno,ename,deptno)
values(1,'신입이',500);  --integrity constraint (BITUSER.FK_C_EMP_DEPTNO) violated

insert into c_emp(empno,ename)
values(1,'신입이');

select * from c_emp;  

--우리 회사 신입사원은 무조건 부서를 가진다   (not null  fk)
--우리 회사 신입사원은 부서를 가질수도 안가질수 있다 

insert into c_emp(empno,ename,deptno)
values(1,'아무게',100); 
commit;

--두개의 관계에서 주 , 종 관계를 파악하면 ...
--fk_c_emp_deptno 관계에서 부모 :  관계  PK dept     FK emp 종 
--master(dept)  - child (emp)


select * from c_emp;

delete from c_dept where deptno=200; -- 삭제 

delete from c_dept where deptno=100; 
--100삭제
--c_emp 테이블에서 100 찿삭제 먼저하고 ..... c_dept 삭제


/*
column datatype [CONSTRAINT constraint_name]        
REFERENCES table_ name (column1[,column2,..] [ON DELETE CASCADE]) 


column datatype, . . . . . . . , [CONSTRAINT constraint_name] 
FOREIGN KEY (column1[,column2,..])        
REFERENCES table_name  (column1[,column2,..] [ON DELETE CASCADE]


[ON DELETE CASCADE]) : 부모의 테이블과 생명을 같이 하겠다
--delete from c_dept where deptno=100;  원칙은 삭제 ...불가능
--[ON DELETE CASCADE])  걸려있다면
--delete from c_dept where deptno=100;  실행
--c_emp deptno 100인 모든 사원데이터 같이 삭제 .....

*/

--교재 12장 ~ 14장
--DDL END--

create table department( --학과테이블
  departmentno number, --학과번호
  departmentname varchar(40) not null --학과명 null X
);
 
create table grade( --성적테이블
  no number, --학번
  name varchar2(20) not null, --이름 null X
  korean number default 0, --국어 null값허용, default 0
  english number default 0, --영어 null값허용, default 0
  math number default 0, --수학 null값허용, default 0
  sum number GENERATED ALWAYS as (korean+english+math) VIRTUAL, --총점 가상컬럼
  avg number GENERATED ALWAYS as ((korean+english+math)/3) VIRTUAL, --평균 가상컬럼
  departmentno number --학과코드
);
 
alter table grade --성적테이블에 학번 중복 X, null X
add CONSTRAINT pk_grade_no primary key(no);
 
alter table department --학과테이블에 학과코드 중복X, null X
add constraint pk_department_departmentno primary key(departmentno);
 
alter table grade --성적테이블의 학과코드는 학과테이블의 학과코드를 참조한다.
add constraint fk_grade_departmentno foreign key(departmentno) references department(departmentno);
 
select * from user_constraints where table_name='GRADE';
select * from user_constraints where table_name='DEPARTMENT';
 
insert into department(DEPARTMENTNO,DEPARTMENTNAME) values (100,'컴퓨터공학');
insert into department(DEPARTMENTNO,DEPARTMENTNAME) values (200,'전산회계');
insert into department(DEPARTMENTNO,DEPARTMENTNAME) values (300,'문예창작');
commit;
 
insert into grade(no,name,korean,math,departmentno) values(1010,'홍길동',80,70,100);
insert into grade(no,name,departmentno) values(2020,'김유신',300);
insert into grade(no,name,english,math,departmentno) values(3030,'아무개',80,100,200);
 
commit;
 
select e.no as "학번", e.name as "이름", e.sum as "총점", e.avg as "평균", e.departmentno as "학과코드", d.departmentname as "학과명"
from grade e join department d
on e.departmentno = d.departmentno;

--
--VIEW (가상테이블)
--pdf 192page
--가상테이블 (물리적 (x) ... 잠시 메모리에 ....)
--View 객체  (create ....
--create view 뷰이름 as [view 보는 목록 (select 구문 )]
--view 는 테이블처럼 사용 가능 (가상 테이블) => 실제 emp , dept 같은 테이블과 사용법이 동일
--view 는  메모리상에만 존재하는 가상 테이블 (subquery -> in line view -> 실제 테이블처리 고급)
--view sql 문장 덩어리

--사용법
--일반테이블과 동일    from 절  where 절
--DML >> view 통해서 물리적인 테이블에 접근 .. insert  , update , delete  가능

--view 장점
--개발자의 편리성(join , subquery) 쿼리문 쉽게
--복잡한 쿼리 단순화
--보안 (권한 별로 처리) 



create view v_001
as
    select empno, ename from emp;


select * from v_001;  --실제로 뷰 가지고 있는 sql 문장이 실행
--view 볼수 있는 데이터에 대해서 DML 가능   조거절 가능

select * from v_001 where empno=7788;


create view v_002
as
   select e.empno , e.ename , e.sal , e.deptno , d.dname
   from emp e join dept d
   on e.deptno = d.deptno

select * from v_002;


create view v_003
as
    select deptno , avg(sal) as avgsal
    from emp
    group by deptno

select * from v_003;






--만약에 부서별 평균 월급을 가지고 있는 테이블이 있다면 ...

--******  어 이거 테이블이 있으면 쉽게 할텐데*************************************
--View  를 만들면 ......

--in - line - view
--자기 부서의 평균 월급보다 더 많은 월급을 받는 사원의 사번 , 이름 , 부서번호  , 부서별 평균 월급을 출력하세요
select e.empno , e.ename , e.deptno , e.sal , trunc(s.avgsal,0)
from emp e join (select deptno , avg(sal) as avgsal from emp group by deptno) s
on e.deptno = s.deptno
where e.sal > s.avgsal;

select e.empno , e.ename , e.deptno , e.sal , trunc(s.avgsal,0)
from emp e join v_003 s
on e.deptno = s.deptno
where e.sal > s.avgsal;

--JOIN  처리 만약  원하는 값이 테이블로 존재한다면 ....... view
/*
CREATE  [OR  REPLACE]  [FORCE | NOFORCE]  VIEW view_name [(alias[,alias,...])] 
AS Subquery 
[WITH  CHECK  OPTION  [CONSTRAINT  constraint ]] 
[WITH  READ  ONLY]


OR  REPLACE  이미 존재한다면 다시 생성한다. 

FORCE   Base Table 유무에 관계없이 VIEW 을 만든다. 

NOFORCE  기본 테이블이 존재할 경우에만 VIEW 를 생성한다. 

view_name  VIEW 의 이름 
Alias   Subquery 를 통해 선택된 값에 대한 Column 명이 된다. 
Subquery  SELECT 문장을 기술한다. 

WITH CHECK OPTION VIEW 에 의해 액세스 될 수 있는 행만이 입력,갱신될 수 있다.  

Constraint  CHECK OPTON 제약 조건에 대해 지정된 이름이다. 

WITH READ ONLY  이 VIEW 에서 DML 이 수행될 수 없게 한다. 
 
*/
--기존에 만든 view 수정
--create or replace v_이름  (overwrite)

create  or replace view v_004
as
    select empno , ename ,sal from emp

drop view v_004;


create or replace view v_emp
as
    select empno, ename , deptno from emp where deptno=20

select * from v_emp;

select * from v_emp where deptno=10;

--view 가상 테이블 DML(insert , update, delete)
--view  통해서 바라볼 수 있는 데이터에 대해서 가능
--DML 작업 단일 테이블로 작업한 view

select * from v_emp;

delete from v_emp;

select * from emp where deptno=20; --실제로 view 가지고 있는 테이블에 가서 삭제

rollback;

--아래 데이터는 view 가 볼수 없어요
update v_emp
set ename = 'AAA'
where  deptno=30;

--1. 30번 부서 사원들의 직위, 이름, 월급을 담는 VIEW를 만들어라.
CREATE OR REPLACE  VIEW VIEW100
AS
  SELECT JOB, ENAME, SAL
  FROM EMP
  WHERE DEPTNO=30
 
SELECT * FROM VIEW100
 
 
 
--2. 30번 부서 사원들의  직위, 이름, 월급을 담는 VIEW를 만드는데,
-- 각각의 컬럼명을 직위, 사원이름, 월급으로 ALIAS를 주고 월급이
-- 300보다 많은 사원들만 추출하도록 하라.
 
CREATE OR REPLACE VIEW  VIEW101 ( 직위, 사원이름 ,월급 )
AS
 SELECT JOB , ENAME , SAL
 FROM EMP
 WHERE DEPTNO=30 AND SAL > 300;
 
SELECT * FROM VIEW101;
 
--3. 부서별 최대월급, 최소월급, 평균월급을 담는 VIEW를 만들어라.
CREATE OR REPLACE VIEW  VIEW102
AS
 SELECT DEPTNO, MAX(SAL) AS "최대월급",
  MIN(SAL) AS "최소월급",
  AVG(SAL) AS "평균월급"
 FROM EMP
 GROUP BY DEPTNO
 
 
SELECT * FROM VIEW102;
       
--4. 부서별 평균월급을 담는 VIEW를 만들되, 평균월급이 2000 이상인
-- 부서만 출력하도록 하라.
--from 조건 => where
--group by 조건 => having
 
CREATE OR REPLACE VIEW VIEW103
AS
 SELECT DEPTNO, AVG(SAL) AS "평균월급"
 FROM EMP
 GROUP BY DEPTNO
 HAVING AVG(SAL) >=2000;
 
select * from view103 
----------------------------------------
SELECT v.deptno,v.평균월급 , d.dname
FROM view103 v JOIN dept d
ON v.deptno = d.deptno;
-----------------------------------------
 
--5. 직위별 총월급을 담는 VIEW를 만들되, 직위가 MANAGER인
-- 사원들은 제외하고 총월급이 3000이상인 직위만 출력하도록 하라.
 
CREATE OR REPLACE VIEW VIEW104
AS
 SELECT JOB, SUM(SAL) AS "총월급"
 FROM EMP
 WHERE JOB!='MANAGER'
 GROUP BY JOB
 HAVING SUM(SAL)>=3000;
 
SELECT * FROM VIEW104;


--제 11 장 SEQUENCE  pdf 185page
--시퀀스 객체
--순번 추출 ( 채번기)
--자동으로 번호를 생성하는 전달 객체


/*
CREATE  SEQUENCE  sequence_name  
[INCREMENT  BY  n] 
[START  WITH  n]  
[{MAXVALUE n | NOMAXVALUE}] 
[{MINVALUE n | NOMINVALUE}] 
[{CYCLE | NOCYCLE}] 
[{CACHE | NOCACHE}]; 

sequence_name  SEQUENCE 의 이름입니다. 
INCREMENT  BY  n 정수 값인 n 으로 SEQUENCE 번호 사이의 간격을 지정. 
    이 절이 생략되면 SEQUENCE 는 1 씩 증가. 

START  WITH  n  생성하기 위해 첫번째 SEQUENCE 를 지정. 
    이 절이 생략되면 SEQUENCE 는 1 로 시작. 

MAXVALUE n  SEQUENCE 를 생성할 수 있는 최대 값을 지정. 

NOMAXVALUE   오름차순용 10^27 최대값과 내림차순용-1 의 최소값을 지정. 

MINVALUE n  최소 SEQUENCE 값을 지정. 

NOMINVALUE  오름차순용 1 과 내림차순용-(10^26)의 최소값을 지정. 

CYCLE | NOCYCLE  최대 또는 최소값에 도달한 후에 계속 값을 생성할 지의 여부를 
    지정. NOCYCLE 이 디폴트. 

CACHE | NOCACHE  얼마나 많은 값이 메모리에 오라클 서버가 미리 할당하고 유지 
    하는가를 지정. 디폴트로 오라클 서버는 20 을 CACHE. 
*/

--게시판
/*
 create table board(
   boardid number primary key,
   title varchar2(50)
)

boardid  글번호는 >> 중복값 ,  null (x)
내가 실수 없이 데이터를 넣을 수 있을 까

where boardid = 10 ... 하나의 row return 하는 것을 저장

질문)
insert into board ....    boardid  1  ,
insert into board ....    boardid  2  ,
insert into board ....    boardid  3  ,
*/

create table kboard(
  num number constraint pk_kboard_num primary key,
  title varchar2(50)
)

--처음 글
--num =1
--다음 글
--num =2


--방법 -1  (0)
insert into kboard(num , title)
values((select nvl(max(num),0) + 1 from kboard),'처음');

insert into kboard(num , title)
values((select nvl(max(num),0) + 1 from kboard),'두번');

insert into kboard(num , title)
values((select nvl(max(num),0) + 1 from kboard),'세번');

select * from kboard;

delete from kboard where num=1;

insert into kboard(num , title)
values((select nvl(max(num),0) + 1 from kboard),'네번');

select * from kboard;


--방법 -2
create table tboard(
  num number constraint pk_tboard_num primary key,
  title varchar2(50)
)

insert into tboard(num , title)
values((select count(num) + 1 from tboard),'처음');

insert into tboard(num , title)
values((select count(num) + 1 from tboard),'두번');

insert into tboard(num , title)
values((select count(num) + 1 from tboard),'세번');
commit;

--문제점 
--삭제 -> insert 기존 번호 충돌  > PK
delete from tboard where num=1;
select * from tboard;



insert into tboard(num , title)
values((select count(num) + 1 from tboard),'네번');


select * from kboard;
select * from tboard;

---번호를 추출 중복값이 안나오게 순차적인 값 전달

create sequence seq_num;

--내가 가지는 계정이 객체 확인
select * from user_sequences;


/*
NEXTVAL 과 CURRVAL 의사열 
가) 특징
1) NEXTVAL 는 다음 사용 가능한 SEQUENCE 값을 반환 한다. 
2) SEQUENCE 가 참조될 때 마다, 다른 사용자에게 조차도 유일한 값을 반환한다.
3) CURRVAL 은 현재 SEQUENCE 값을 얻는다. 
4) CURRVAL 이 참조되기 전에 NEXTVAL 이 사용되어야 한다. 
*/ 

--번호 추출 하기
select seq_num.nextval from dual;

--정보 확인하기 현재값 (마지막 추출된 순번 확인)
select seq_num.currval from dual;

 create table sboard(
  num number constraint pk_sboard_num primary key,
  title varchar2(50)
)

insert into sboard(num, title)
values(seq_num.nextval , '처음');

insert into sboard(num, title)
values(seq_num.nextval , '두번');

insert into sboard(num, title)
values(seq_num.nextval , '세번');

select * from sboard;

delete from sboard where num=8;

insert into sboard(num, title)
values(seq_num.nextval , '네번');

rollback;

commit;

/*
의사 컬럼(Pseudo-column)은 테이블의 [컬럼]처럼 동작하지만 
실제로 테이블에 저장되지 않는 컬럼을 의미한다.
SELECT 문에서는 의사컬럼을 사용할 수 있지만, DML 문장에서는 할 수 없다.
시퀀스에서 사용하는 NEXTVAL이나 CURRVAL 도 의사 컬럼의 일종이며, 
대표적인 예는 ROWNUM이다.
*/


--게시판 10개
--질문 게시판, 자유게시판 , 공지사항
--3개의 게시판 글번호를 따로 관리 하고 싶다
--sequence 3개
create sequence board_seq;
create sequence board_seq2;
create sequence board_seq3;
--1. q_num
--2. f_num
--3. k_num
insert into qboard() values(board_seq.nextval ,,,

insert into fboard() values(board_seq2.nextval ,,,

insert into kboard() values(board_seq3.nextval ,,,

----게시판 10개
--질문 게시판, 자유게시판 , 공지사항 하나의 글번호 통합
--sequence 1개
create sequence board_seq;


insert into qboard() values(board_seq.nextval ,,,

insert into fboard() values(board_seq.nextval ,,,

insert into kboard() values(board_seq.nextval ,,,

--1. sequence rollback 지원  않는다
select * from sboard;

insert into sboard(num, title)
values(seq_num.nextval , '안녕');

rollback;


--TIP)
--ms-sql
-- create table board (boardnum int identity(1,1) , title varchar(20))
--insert into board(title) values('MS');

--버전 : 2012버전 : 오라클 처럼 sequence

--my-sql
-- create table board(boardnum int auto_increment, title varchar(20))
--insert into board(title) values('mysql');

create sequence seq2_num
start with 10
increment by 2;

select seq2_num.nextval from dual;

select seq2_num.currval from dual;

select * from user_sequences;

/*
게시판 글번호
num
1
2
4
6
10
15

[최신글 순]으로 [목록]을 보여 주세요
게시판 만들면 
select * from board order by num desc 
*/
/*
의사 컬럼(Pseudo-column)은 테이블의 [컬럼]처럼 동작하지만 
실제로 테이블에 저장되지 않는 컬럼을 의미한다.
SELECT 문에서는 의사컬럼을 사용할 수 있지만, DML 문장에서는 할 수 없다.
시퀀스에서 사용하는 NEXTVAL이나 CURRVAL 도 의사 컬럼의 일종이며, 
대표적인 예는 ROWNUM이다.
*/
--개발자(sequence , rownum)
--rownum 의사커럼 
--rownum : 실제로 테이블 존재하지 않는 컬럼(행 번호)
--rowid : 주소값 (행이 실제로 저장되는 내부 (메모리) 주소값) 

select empno, ename from emp;

select rownum as 순번 , empno, ename from emp;

--Top-n 쿼리 사용 ...
--테이블에서 조건에 맞는 상위  Top 레코드(row)  n  개 추출
--근거 : 정렬된 데이터    기준 줄을 세우고 .... 

select * from emp order by sal desc;


--Top-n
-- ms-sql :  select top 10 , * from emp order by sal desc

--oracle : rownum(의사컬럼)

--1. 정렬쿼리를 만든다
--2. 쿼리에 순번(rownum)  부여하고 조건  (where rownum <= 10


--1.  기준 (번호)
select rownum as "num", e.*
from (
  select *
  from emp
  order by sal desc ) e;

--2 조건  10명

select rownum as "num" , e.*
from (
  select *
  from emp
  order by sal desc ) e
where rownum <= 10;



select rownum as "num" , e.*
from (
  select *
  from emp
  order by sal desc ) e
where rownum <= 2;

------------------------------------
select *
from (
        select rownum as "num" , e.*
        from (
                  select *
                  from emp
                  order by sal desc ) e
       ) n
where "num" <= 2     

-------------------------------------
--SQL 1차 학습 --END 
-------------------------------------
--3차 프로젝트 전에 수업
--SQL 2차 학습 
--고급쿼리
--PL-SQL : 변수 , 제어문 , 커서 , 함수 , 프로시져 , 트리거 , 스케줄


create view bitemp
as
    select empno , ename , job from emp;
    
   select * from bitemp; 
    
SELECT *  FROM USER_VIEWS;
    
    
    
    
    
    
    
    
    


