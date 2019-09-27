SELECT [DISTINCT]  {*, column [alias], . . .}   //[]생략가능함을 의미 {}안의 것이 반드시 있어야한다
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

Select * From emp;
SELECT * FROM EMP;--쿼리문 대소문자 구분하지 않아요

--2.특정 컬럼 데이터 추출하기
SELECT empno, ename, job, sal from emp;

select empno from emp;

select hiredate, deptno from emp;

--3. 컬럼에 가명칭(alias) 부여하기

select empno 사번, ename 이름
from emp;

--select empno 사 번, ename 이름 from emp;
select empno "사  번", ename "이 름"
from emp;

--정식(ansi 표준) >>권장
select empno  as "사  번", ename as "이 름"
from emp;

-- Oracle : 문자열 데이터 (엄격하게 대소문자 구분)
--데이터 : a, A 다른 문자 취급
--문자열(문자) 데이터 : '문자'
select * from emp where ename='king';
select * from emp where ename='KING';

--Oracle : 연산자(결합 연산자) >> || >> 'hello'||'world'>> 결합 >>'helloworld'
--java : + 산술, 결합
--java : 10+10(산술)
--java: "A" + "B"(결합)
--TIP) ms-sql: +(연산,결합)

select '사원의 이름은 ' || ename || '입니다' as "ename"
from emp;

--java : class Emp{private int empno;}
--POINT : 오라클의 컬럼은 타입 정보를 갖는다
--현재 내가 가지고 있는 emp 정보를 보는 방법
desc emp;--emp 컬럼의 타입정보

select empno + ename as "결합" -- 연산수행>> "invalid number"
from emp;

select empno || ename as "결합"--실제 (내부적으로 자동 형변환(숫자>>문자) to_char()
from emp;

--사장님 우리회사에 직종이 몇개나 있나
--중복 데이터 제거 (키워드): distinct
select distinct job from emp;

select distinct deptno from emp;

--distinct 원리 (컬림이 2개 이상) -- grouping (그림 : 꾸러미)
select distinct job, deptno from emp;

select DISTINCT job, deptno from emp order by job;

SELECT DISTINCT deptno, job from emp ORDER by deptno;

--오라클 언어(SQL)
--java 같은 언어다 (연산자)
--오라클도 연산자 java 와 거의 동일
--java (% 나머지) >> 오라클에서 [ % ] 검색패턴자원으로 활용 >> 나머지 함수를 만들었어요
--Oracle ( +, - ,* , / ...) + 나머지 (Mod()함수)

--사원테이블에서 사원의 급여를 100달러 인상한 결과를 출력하세요
--전제 조건( + ) 컬럼의 타입: number
desc emp;
select empno, ename , sal, sal+100 as "인상급여" 
from emp;

select 100 + 100 from dual; --데이터 TEST dual
select 100 || 100 from dual; -- || 결합연산자 (숫자 >> 문자 자동형변환)
select '100' + 100 from dual; -- + 산술연산 ('100' >> 숫자 형변환)
select 'A100' + 100 from dual; --Error "invalid number"

--비교연산자
-- >, < , <= ...
--java 같다(==) , 할당(=)
--javascript 같다(===)
--Oracle 같다(=) (!=)

--논리연산자 and or
/*
SELECT [DISTINCT]  {*, column [alias], . . .}   //[]생략가능함을 의미 {}안의 것이 반드시 있어야한다
FROM  table_name   
[WHERE  condition]   
[ORDER BY {column, expression} [ASC | DESC]]; 
*/

--조건절(원하는 row 만 가지고 오겠다
--실행순서: select 절, from 절, where 절
select *         --3
from emp         --1
where sal>=3000; --2

--이상, 이하 (=포함)
--초과, 미만

--사번이 7788번인 사원의 사번, 이름 ,직종, 입사일을 출력하세요
select empno, ename, job ,hiredate 
from emp 
where empno=7788; 

--사원의 이름이 KING 인 사원의 사번, 이름 ,금여 정보를 출력하세요
select empno , ename, sal
from emp
where ename = 'KING';

--급여가 2000달러 이상이면서 직종이 manager 인 사원의 모든 정보를 출력하세요
select *
from emp
where sal>2000 and job='MANAGER';

--급여가 200달러 이상이거나 직종이 manager인 사원의 모든 정보를 출력
select *
from emp
where sal>2000 or job='MANAGER';

--오라클 날짜
--DB서버의 날짜
--시스템 : 날짜 가지고 있다 >> sysdate

select sysdate from dual;
--게시판 글쓰기 : insert into board(writer, title, content, regdate)
--              values('홍길동','방가방가','피곤해요',sysdate)
--TIP ms-sql >> select getdate()

select hiredate from emp;
desc emp; --DATE
--오라클 [시스템정보]를 담고 테이블별도로 관리
--환경설정
select * from SYS.NLS_SESSION_PARAMETERS;
--NLS_LANGUAGE	KOREAN
--NLS_DATE_FORMAT	RR/MM/DD -- 변경 가능
--NLS_DATE_LANGUAGE	KOREAN
--NLS_TIME_FORMAT	HH24:MI:SSXFF
select * from SYS.NLS_SESSION_PARAMETERS where parameter = 'NLS_TIME_FORMAT';
--POINT
--서버기준에 설정 변경 가능(DBA)
--현재 접속한 사용자(session) 기준으로 적용
--다른 곳에서 bituser로 접속하면 날짜형식 변경 ..그대로

alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS'; --변경
select * from SYS.NLS_SESSION_PARAMETERS where parameter = 'NLS_DATE_FORMAT';

--NLS_DATE_FORMAT YYYY-MM-DD HH24:MI:SS
select sysdate from dual; --2019-09-24 11:51:38
select hiredate from emp; --1980-12-17 00:00:00

select *
from emp
where hiredate='1980-12-17'; --날짜 형식 표현(문자동일)
select *
from emp
where hiredate='1980/12/17';--날짜 (-구분자, /구분자)

select * from emp;
select * 
from emp
where hiredate='80-12-17';--날짜형식을 변경 (조회 안되요)
--RR-MM-DD >> YYYY-MM-DD

--사원의 급여가 2000달러 이상이고 4000달러 이하인 모든 사원의 정보 출력

select *
from emp
where 2000<=sal and sal<=4000;
--연산자 : 컬럼명 between A and B (=포함)
select *
from emp
where sal between 2000 and 4000;

--사원의 rmqdurk 2000초과 4000미만
select *
from emp
where 2000<sal and sal<4000;

--부서번호가 10번 또는 20번 또는 30번인 사원의 사번 이름 급여 부서번호를 출력하세요
select *
from emp
where deptno = 10 or deptno=20 or deptno=30
order by deptno;

--IN 연산자 (조건 or 조건 or ...)
select *
from emp
where deptno in (10,20,30)
order by deptno;

--부서번호가 10번 또는 20번이 아닌 사원의 사번, 이름, 급여 부서번호 출력

select empno, ename, sal, deptno
from emp
where deptno !=10 and deptno != 20;

--NOT IN 연산자

select empno, ename, sal, deptno
from emp
where deptno not in(10,20);

--POINT : 값이 없다(데이터 없다) >> null
--NULL (필요악)
--java : class Member{private String userid...}

create table member(
userid VARCHAR2(20) not null,
name varchar2(20) not null,
hobby varchar2(20) --default >> null (null값 허용):필수 입력 사항이 아니야
);
select * from member;
insert into member(userid,name) values('hong','홍길동');
select * from member;
insert into member(userid,hobby) values('kim','농구');--오류
--ORA-01400: cannot insert NULL into ("BITUSER"."MEMBER"."NAME")
insert into member(userid,name,hobby) values('park','박군','축구');
select * from member;

--실반영
commit;
select * from member;

--수당을 받지 않는 모든 사원의 정보를 출력하세요
select * 
from emp
where comm is null;

--null은 다른 연산자 (is null)
--select * from emp where comm = null; --(x)
select * from emp where comm is null;

--수당을 받는 모든 사원의 정보를 출력하세요
select *
from emp
where comm is not null
order by comm;

--사원테이블에서 사번, 이름,급여,수당,총급여를 출력하세요
--총급여(급여+수당)
select empno, ename, sal, comm, sal+comm as "총급여"
from emp;

--POINT(null)
--**null과의 모든 연산은 그결과가: null
--nvl()
--null을 만나면 대체값으로 바꾸어라: nvl(),vnl2()
--ms-sql:convert()
--my-sql:IFNULL()
select 1000+null from dual;

select 1000+nvl(null,111) from dual;

select 'A'||null from dual;

select comm,nvl(comm,0) from emp;

select empno, ename, sal, comm, sal+nvl(comm,0) as "총급여"
from emp;

--사원의 급여가 1000달러 이상이고 수당을 받지않는 사원의 이름,직종,급여,수당을 출력하세요

select ename, job, sal, comm
from emp
where comm is null and 1000<=sal;

--------------------------------------
--DQL (data query language): SELECT
--DDL : create, alter ,drop (객체 생성 수정 삭제)

create table board(
  boardid number not null,--필수입력
  title varchar2(20) not null,--필수입력(영문자, 특수,공백:1BYTE, 한글2BYTE)
  content varchar2(2000) not null,--필수입력
  hp varchar2(20)
);

--DML(데이터 조작어) : insert, update, delete
--작업시에는 [실제 반영]이나 취소최리를 위해(commit,rollback) 반드시 사용
insert into board(boardid,title,content)
values(100,'오라클','참쉽네');

select * from board;

commit;--실반영

insert into board(boardid,title,content)
values(100,'자바','그립다...');

SELECT * FROM board;
rollback;

--insert, update, delete 작업 오라클 (무조건 commit, rollback 작업 반드시)
--ms-sql (Auto commit) >> default commit; begin tran ~~ commit or rollback

select * from board;

select boardid, hp, nvl(hp,'핸드폰 없어요') as "hp"
from board;

--nvl 함수는 숫자, 날짜, 문자 모두 적용가능하다

--문자열검색
--주소검색:'역삼' 검색하면 역삼 글자에 들어있는 주소가 다 나와요
--문자열 패턴 검색(LIKE 연산자)

--like 연산자(와일드 카드 문자 (%: 모든 것, _:한문자)결합

select * 
from emp
where ename like '%A%';--A가 들어있는 모든 이름 검색

select *
from emp
where ename like 'A%';

select * 
from emp
where ename like '%S';

select *
from emp
where ename like'%A%A';

select *
from emp
where ename like'_A%';

select *
from emp
where ename like'__A%';

--오라클 과제 (regexp_like) 상세한 패턴 검색
--select * from emp where regexp_like (ename,정규표현식);
--오라클 정규표현사용 검색 패턴 만들기 (조별 3개): 중간프로젝트_반영

--데이터 정렬하기
--order by 컬럼명(문자,숫자,날짜) asc or desc
--오름차순: asc 낮은순(default)
--내림차순: desc 높은순

select * 
from emp
order by sal;--asc 급여가 낮은 순으로

select * 
from emp 
order by sal asc;

--급여를 많이 받는 순으로 데이터를 정렬하세요
select *
from emp
order by sal desc;

select *
from emp
order by ename;--문자열도 가능

--입사일이 가장 늦은 순으로 정렬 사번,이름,급여,입사일을 출력하세요
--최근에 입사한 사원...

select empno,ename,sal,hiredate
from emp
order by HIREDATE desc;
/*
SELECT   3
FROM     1
WHERE    2
ORDER BY 4 
*/

--문제: MANAGER들의 사번, 이름, 급여, 직종, 입사일을 입사일이 최근인순으로 정렬
--사원테이블에서 직종이 MANAGER인 사원 중에 입사일이 가장 늦은 순으로 정렬해서 사번,이름,급여,직종,입사일 출력
--실행순서대로 읽으면 좋다
SELECT empno, ename,sal,job,hiredate
from emp
where job='MANAGER'
ORDER by HIREDATE desc;

--문제
SELECT deptno, job
from emp
order by DEPTNO desc, job asc;--정렬2개 (grouping)

--연산자
--합집합(union) : 테이블과 테이블의 데이터를 하벼서 보여지는 것(중복값은 제외)
--합집합(union all): 중복값 허용

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

delete

SELECT * FROM ut;

select name from ut
UNION
select name from uta;

select name from ut
UNION all
select name from uta;

--union 규칙
--1.대응되는 컬럼의 타입이 동일
select empno, ename from emp
UNION
select dname,deptno from dept;--(x)

select empno,ename from emp
union
select deptno,dname from dept;

--2.대응되는 컬럼의 개수 동일(null 착한일)
select empno,ename,job,sal from emp
union
select deptno,dname,loc,null from dept;

--오라클 함수(pdf 48 page)
/*
단일행 함수
1) 문자형 함수 : 문자를 입력 받고 문자와 숫자 값 모두를 RETURN 할 수 있다. 
2) 숫자형 함수 : 숫자를 입력 받고 숫자를 RETURN 한다. 
3) 날짜형 함수 : 날짜형에 대해 수행하고 숫자를 RETURN 하는 MONTHS_BETWEEN 함수를 제외하고 모두 날짜 데이터형의 값을 RETURN 한다. 
4) 변환형 함수 : 어떤 데이터형의 값을 다른 데이터형으로 변환한다. 
5) 일반적인 함수 : NVL, DECODE 
*/
--문자열 함수
select initcap('the super man') from dual;

select lower('AAA'), UPpER('aaa') from dual;

select ename,lower(ename) as "enmae" from emp;

select* from emp where lower(ename) = 'king';

--문자의 개수(length)
select length('abcd') from dual;
select length('홍길동바보') from dual;
select length('홍 길 동') from dual;

--결합연산자 ||
--결합 함수
select 'a'||'b'||'c' from dual;

select concat('a','b') from dual;

select concat(ename,job) from emp;
select ename||' ' ||job from emp;

--부분문자열 추출
--java(substring)
--oracle(substr)

select substr('ABCDE',2,3) from dual;--BCD
select substr('ABCDE',1,1) from dual;--자기자신 A
select substr('ABCDE',3,1) from dual;

select substr('ABCDE',3) from dual;
select substr('ABCDE',-2,1) from dual;

/*
사원테이블에서 ename 컬럼 데이터에서 대해서 첫글자는 소문자로 나머지 문자는 대문자로 출력하되
하나의 컬럼데이터로 출력하세요
컬럼의 가명칭은: fullname
첫글자와 나머지 문자 사이에 공백 하나

*/
select lower(substr(ename,1,1))||' '||upper(substr(ename,2)) as "fullname"
from emp;

--lpad, rpad(채우기)

select lpad('ABC',10,'*') from dual;

select rpad('ABC',10,'#') from dual;

--Quiz
--사용자 비번:hong1006
--화면에 ho******로 출력하고 싶어요

select rpad(substr('hong1006',1,2),length('hong1006'),'*') from dual;

--emp 테이블에서 ename 컬럼의 데이터르 출력하는 데 첫글만 출력하고 나머지는 *로출력

select rpad(substr(ename,1,1),length(ename),'*') from emp;

create table member2(
id number,
jumin varchar2(14)
);

insert into member2(id,jumin) values(100,'123456-1234567');
insert into member2(id,jumin) values(200,'234567-1234567');
commit;

select * from member2;
--Quiz
--출력결과
--100: 123456-*******
--가명칭 jumin

select id, rpad(substr(jumin,1,7),length(jumin),'*') as "jumin"
from member2;

--rtrim 함수
--[오른쪽 문자] 지워라
select rtrim('MILLER','ER') from dual;
--ltrim 함수
select ltrim('MILLLLLLER','MIL') FROM dual;

--치환함수
select ename,replace(ename,'A','와우') from emp;

--[문자열함수 END]

--[숫자함수]
--round(반올림 함수)
--trunk(절사함수)
--나머지 함수 mod()

-- -3 -2 -1 0 1 2 3

select round(12.345,0) as "r" from dual;--12
select round(12.567,0) as "r" from dual;--13
select round(12.345,1) as "r" from dual;--12.3
select round(12.345,2) as "r" from dual;--12.35
select round(12.345,-1) as "r" from dual;--10

--trunc(반올림 처리하지 않아요)

select trunc(12.345,0) as "r" from dual;--12
select trunc(12.567,0) as "r" from dual;--13
select trunc(12.345,1) as "r" from dual;--12.3
select trunc(12.345,2) as "r" from dual;--12.35
select trunc(12.345,-1) as "r" from dual;--10

--나머지 12/10 from dual;--12
select 12/10 from dual;
slect mod(12,10) from dual;
slect mod(0,0) from dual;'
--[숫자 함수 END]

--[날짜함수]
--syndate
alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';
select hiredate from emp;

--DATE+Number >> DATE
--DATE-number >> DATE
--DATE-DATE >> Number(일수)

--날짜(round,trunc)

select months_between('2019-02-27','2010-02-27') from emp;

select months_between(sysdate,('2010-02-27')) from emp;

select to_date('2015-01-01') + 1000 frmo dual;

--Quiz 

select ename,hiredate,trunc((sysdate-hiredate)/31,0) as "근속월수",trunc(months_between(sysdate,hiredate),0) as "근속월수2" from emp;

--변환함수
--Oracle:문자,숫자,날짜 데이터
--to_char(): 숫자(10000)->문자로($10000)(100,000),날짜(1900-01-01')->문자(1900년01월01일)
--to_date(): 문자 -> 날짜 >> select '2019-12-12' >> to_date('2019-12-12')
--to_number():문자->숫자(자동형변환)
select '100' + 100 from dual;--숫자형 문자
select to_number('100') + 100 from dual;

--Quiz
--입사일 12월인 사원들의 사번 , 이름, 입사일, 입사년도 입사월을 출력하세요

select empno, ename, hiredate, to_char(hiredate,'YY') as "입사년도",to_char(hiredate,'MM') as "입사월"
from emp
where to_char(hiredate,'MM')=12;

select *
from emp;

select to_char(sal,'$999,999') as "sal"
from emp;

select * from employees;

select last_name || first_name as "fullname", to_char(hire_date,'YYYY-MM-DD') as "입사일",
to_char(salary*12,'$999,999,999') as "연봉", to_char(salary*12*1.1,'$999,999,999') as "인상된 연봉"
from employees
where to_char(hire_date,'YYYY')>=2005
order by "연봉" desc;