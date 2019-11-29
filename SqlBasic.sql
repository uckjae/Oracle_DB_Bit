[1���� ����]
1. ����Ŭ ����Ʈ���� �ٿ�ε�

1.11g Express Edition  ����
https://www.oracle.com/database/technologies/xe-prior-releases.html

2.����Ŭ ���� �� (�������)
https://www.oracle.com/tools/downloads/sqldev-v192-downloads.html

3. ��ġ (������ ���� : SYSTEM , SYS ���� >> ��ȣ���� : 1004)
    Port for 'Oracle Database Listener': 1521

4. ���� (sqlplus �� : DOS ���) >> UI �� ��ġ

5. ����Ŭ ���� : SqlDeveloper 
   ���� :  ��� , ������ , sqlgate
   ���� :  https://dbeaver.io/download/   


6.  Tool ����
     SYSTEM : 1004 ���� ����  (������ ����)
     6.1 HR ���� ��� (unlock)
     -- USER SQL
     ALTER USER "HR" IDENTIFIED BY "1004" 
     DEFAULT TABLESPACE "USERS"
     TEMPORARY TABLESPACE "TEMP"
     ACCOUNT UNLOCK ; 
    6.2  HR ��������  �α��� (���̺� ��ȸ)

7.  ���ο� ���� ����� (�ǽ��� ����)
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

8. �ǽ� script �����
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

--[1����]

SELECT [DISTINCT]  {*, column [alias], . . .}  
FROM  table_name   
[WHERE  condition]   
[ORDER BY {column, expression} [ASC | DESC]]; 
/*
DISTINCT  �ߺ� �� ���� �ɼ� 
*   ���̺��� ��� column ��� 
alias   �ش� column �� ���� �ٸ� �̸� �ο� 
table_name ���̺�� ���� ��� ���̺� �̸� 
WHERE   ������ �����ϴ� ��鸸 �˻� 
condition  column, ǥ����, ��� �� �� ������ 
ORDER BY  ���� ��� ������ ���� �ɼ�(ASC:��������(Default),DESC ��������) 
*/
--1. ������̺� �ִ� ��� �����͸� ����ϼ���
select * from emp;
SELECT * FROM EMP; --�������� ��ҹ��� �������� �ʾƿ�

--2. Ư�� �÷� ������ �����ϱ�
select empno, ename , job , sal from emp;

select empno  from emp;

select hiredate , deptno from emp;

--3 �÷��� ����Ī(alias) �ο��ϱ�
select empno ��� ,  ename �̸�
from emp;

--select empno ��   �� ,  ename �̸�
--from emp;

select empno "��   ��" ,  ename "��   ��"
from emp;

--����(ansi ǥ��) >> ����

select empno as "��   ��" ,  ename as "��   ��"
from emp;

--Oracle : ���ڿ� ������ (�����ϰ� ��ҹ��� ����)
--������ : a ,  A �ٸ� ���� ���
--���ڿ�(����) ������ :   '����'
select * from emp where ename='king';
select * from emp where ename='KING';
select * from emp where ename='King';

--Oracle : ������(���� ������) >> || >> 'hello' || 'world' >> ���� >> 'helloworld'
--java : + ��� , ����
--java : 10 + 10 (���)
--java : "A" + "B" (����)
--TIP) ms-sql: + (����, ����)

select '����� �̸���' || ename || '�Դϴ�' as "ename"
from emp;

--java : class Emp {private int empno;}
--POINT : ����Ŭ�� �÷��� Ÿ�� ������ ���´�
--���� ���� ������ �ִ�  emp ������ ���� ���
desc emp; --emp �÷��� Ÿ������

select empno + ename as "����"  -- [���� ����] >> "invalid number"
from emp;

select empno || ename as "����" --���� (���������� �ڵ� ����ȯ(����->����) to_char()
from emp;

--����� �츮 ȸ�翡 ����(job)�� ��� �ֳ�
--�ߺ� ������ ���� (Ű����): distinct
select distinct job from emp;

select distinct deptno from emp;

--distinct ���� (�÷��� 2�� �̻�) --grouping (�׸� : �ٷ��� )
select distinct job , deptno from emp order by job;

select distinct deptno , job from emp order by deptno;

--����Ŭ ���(SQL)
--java ���� ���� (������)
--����Ŭ�� ������ java �� ���� ����
--java (% ������) >> ����Ŭ���� [ % ] �˻������ڿ����� Ȱ�� >> ������ �Լ��� ��������  Mod() �Լ�
--Oracle (+ , - , * , / ...) + ������ (Mod()�Լ�)

--������̺��� ����� �޿��� 100�޷� �λ��� ����� ����ϼ���
--���� ����( + ) �÷���  Ÿ��: number
desc emp;
select empno, ename , sal, sal + 100 as "�λ�޿�"
from emp;

----��̷� ^^------- 
select 100 + 100 from dual;  --������ TEST dual
select 100 || 100 from dual; -- || ���տ����� (���� -> ���� �ڵ�����ȯ)
select '100' + 100  from dual; -- + ������� ('100' >> ���� ����ȯ)
select 'A100' + 100  from dual; --Error  "invalid number"

--�񱳿�����
-- > , < , <= ....
--java ����(==) , �Ҵ�(=)
--javascript  ����(===)
--oracle ����(=) , (!=)

--��������
--AND , OR ,NOT







/*
SELECT [DISTINCT]  {*, column [alias], . . .}  
FROM  table_name   
[WHERE  condition]   
[ORDER BY {column, expression} [ASC | DESC]]; 
*/

--������(���ϴ� row �� ������ ���ڴ�)
--�������: select �� , from �� ,  where �� 
--
select *           --3  
from emp           --1 
where sal >= 3000; --2

--�̻� , ���� (= ����)
--�ʰ� , �̸�

--����� 7788���� ����� ��� , �̸� , ���� , �Ի����� ����ϼ���
select empno, ename, job, hiredate
from emp
where empno=7788;

--����� �̸���  KING �� ����� ��� , �̸� , �޿� ������ ����ϼ���
select empno, ename, sal
from emp
where ename = 'KING';

--��(AND , OR , NOT)
--�޿��� 2000�޷� �̻��̸鼭 ������ manager �� ����� ��� ������ ����ϼ���
select *
from emp
where sal >= 2000 and job='MANAGER';

--�޿��� 2000�޷� �̻��̰ų� ������ manager �� ����� ��� ������ ����ϼ���
select *
from emp
where sal >= 2000 or job='MANAGER';

--����Ŭ ��¥
--DB������ ��¥
--�ý��� : ��¥ ������ �ִ� >> sysdate
select sysdate from dual;
--�Խ��� �۾��� : insert into board(writer, title, content , regdate)
--               values('ȫ�浿','�氡�氡','�ǰ��ؿ�',sysdate)
--TIP) ms-sql >> select getdate() ...

select hiredate from emp;
desc emp;  -- DATE
--����Ŭ  [�ý�������]�� ��� ���̺� ������ ����
--ȯ�漳��
select * from SYS.NLS_SESSION_PARAMETERS;
--NLS_LANGUAGE	KOREAN
--NLS_DATE_FORMAT	RR/MM/DD  --���浵 ����
--NLS_DATE_LANGUAGE	KOREAN
--NLS_TIME_FORMAT	HH24:MI:SSXFF

select * from SYS.NLS_SESSION_PARAMETERS where parameter = 'NLS_DATE_FORMAT';
--POINT
--�������ؿ� ���� ���� ���� (DBA)
--���� ������ �����(session) �������� ����
--�ٸ� ������ bituser �� �����ϸ� ��¥���� ���� ..�׷��� 

alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS'; --����
select * from SYS.NLS_SESSION_PARAMETERS where parameter = 'NLS_DATE_FORMAT'; --����Ȯ��

--NLS_DATE_FORMAT	YYYY-MM-DD HH24:MI:SS
select sysdate  from dual; --2019-09-24 11:51:38
select hiredate from emp;  --1980-12-17 00:00:00

select *
from emp
where hiredate='1980-12-17'; --��¥ ���� ǥ��(���� ����)

select *
from emp
where hiredate='1980/12/17'; --��¥ ( - ������ , / ������)

select * from emp;
select *
from emp where hiredate='80-12-17'; --��¥ ���� ����  (��ȸ �ȵǿ�)
--RR-MM-DD --> YYYY-MM-DD

--����� �޿��� 2000�̻��̰� 4000������ ��� ����� ������ ����ϼ���
select *
from emp
where sal >= 2000 and sal <= 4000;
--������ : �÷��� between A and B (= ����)

select *
from emp
where sal between 2000 and 4000;

--����� �޿��� 2000�ʰ� 4000�̸��� ����� ��� ������ ����ϼ���
select *
from emp
where sal > 2000 and sal < 4000;

--�μ���ȣ�� 10�� �Ǵ� 20�� �Ǵ� 30���� ����� ��� , �̸� , �޿� , �μ���ȣ�� ����ϼ���
select empno, ename, sal, deptno
from emp
where deptno=10 or deptno=20 or deptno=30;

--IN ������ (���� or ���� or ...)
select empno, ename, sal, deptno
from emp
where deptno in (10,20,30); --deptno=10 or deptno=20 or deptno=30

--�μ���ȣ�� 10�� �Ǵ� 20���� �ƴ� ����� ��� , �̸� , �޿� �μ���ȣ�� ����ϼ���
--10���� �ƴϰ� 20���� �ƴ� ..
select empno, ename, sal, deptno
from emp
where deptno != 10 and deptno != 20;

--NOT IN  ������ 

select empno, ename, sal, deptno
from emp
where deptno not in(10,20); -- deptno != 10 and deptno != 20;

--POINT : ���� ���� (������ ����) >> null
--null (�ʿ��)
--JAVA : class Member {  private String userid .....}

create table member (
 userid varchar2(20) not null,
 name varchar2(20) not null,
 hobby varchar2(20)  --default >>  null  (null���� ���) : �ʼ� �Է� ������ �ƴϾ�
 );
select * from member; 

insert into member(userid, name) values('hong','ȫ�浿');
select * from member;

insert into member(userid, hobby) values('kim','��'); --����
-- ORA-01400: cannot insert NULL into ("BITUSER"."MEMBER"."NAME")

insert into member(userid, name, hobby) values('park','�ڱ�','�౸');
select * from member;

--�ǹݿ�
commit;
select* from member;

--������ ���� �ʴ� ��� ����� ������ ����ϼ���
select * from emp;

--null �� �ٸ� ������  (is null)
--select * from emp where comm = null;  --(x)

--null �� (is null , is not null)
select * from emp where comm is null;

--������ �޴� ��� ����� ������ ����ϼ��� (comm  ������  null  �� �ƴ� ���)
select * from emp where comm is not null;

--������̺��� ��� , �̸� , �޿� , ���� , �ѱ޿��� ����ϼ���
--�ѱ޿�(�޿� + ����)
select empno , ename , sal , comm , sal + nvl(comm,0) as "�ѱ޿�"
from emp;

--POINT (null)
--** null ���� ��� ������ �� ����� : null
-- null�� ������ ��ü������ �ٲپ�� :  nvl() , nvl2()
--ms-sql : convert()
--my-sql : IFNULL()

select 1000 + null from dual;

select 1000 + nvl(null,0) from dual;

select 1000 + nvl(null,11111) from dual;

select comm, nvl(comm,0) from emp;

--����� �޿��� 1000 �̻��̰� ������ ���� �ʴ� ����� ���,  �̸� , ���� , �޿� , ������ ����ϼ���
select empno,ename,job,sal,comm
from emp
where  sal >= 1000 and comm is null;

-----------------------------------------------------------------------------------------
--DQL (data query language) : SELECT
--DDL : create , alter , drop (��ü ���� ���� ����)

create table board (
  boardid number not null , --�ʼ��Է�
  title varchar2(20) not null, --�ʼ��Է� (������, Ư�� , ����: 1Byte  , �ѱ� 2Byte)
  content varchar2(2000) not null, --�ʼ��Է�
  hp varchar2(20)  -- null  --�����Է� (null)
);

--DML(������ ���۾�) : insert , update , delete 
--�۾��ÿ���[ ���� �ݿ� ]�̳� ���ó���� ���� (commit, rollback) �ݵ�� ���
insert into board(boardid, title, content)
values(100,'����Ŭ','�� ����');

select * from board;

commit; --�ǹݿ�

insert into board(boardid, title, content)
values(200,'�ڹ�','�׸���...');

select * from board;
rollback;

--insert , update , delete �۾� ����Ŭ (������ commit , rollback �۾� �ݵ��)
--ms-sql (Auto commit) >> default commit;  begin tran  ~~~ commit  or rollback 

select * from board;

select boardid , hp,  nvl(hp,'�ڵ��� �����') as "hp"  -- nvl ���ڿ��� ���� �����ϴ� ^^
from board;

--nvl �Լ��� ���� , ��¥ , ���� ��� ���밡���ϴ� 

--���ڿ� �˻�
--�ּҰ˻� : '����' �˻��ϸ� ���� ���ڿ� ����ִ� �ּҰ� �� ���Ϳ� 
--���ڿ� ���� �˻�( LIKE  ������)

--like ������ ( ���ϵ� ī�� ���� ( % : ��� ��(� �͵� ��������) ,  _ : �ѹ���) ����

 select *
 from emp
 where ename like '%A%'; --A �� ����ִ� ��� �̸� �˻�

 select *
 from emp
 where ename like 'A%'; 


 select *
 from emp
 where ename like '��%'; --�达�� ���� ��� ��� �˻�
 

 select *
 from emp
 where ename like '%S'; --S ������ �̸��� ���� ��� ����� �˻�

 select *
 from emp
 where ename like '%LL%'; 
 
 select *
 from emp
 where ename like '%A%A%';  --  AA   , ABA  
 
 select *
 from emp
 where ename like '_A%';  --   _ �ѹ���

 select *
 from emp
 where ename like '__A%';  --A ����° �F ���� ....
 
--����Ŭ ���� (regexp_like) ���� ���� �˻�
--select * from emp where regexp_like (ename, ����ǥ����);
--����Ŭ ����ǥ����� �˻� ���� ����� (���� 3��) : �߰�������Ʈ ...�ݿ�


--������ �����ϱ�
--order by �÷���(����, ����, ��¥)   asc or desc
--�������� : asc ������ (default)
--��������: desc ������

select *  from emp order by sal; -- asc �޿��� ���� ...
select *  from emp order by sal asc;

--�޿��� ���� �޴� ������ �����͸� �����ϼ���
select * from emp order by sal desc;

select * from emp order by ename asc; --���ڿ� ���� ...

--�Ի����� ���� ���� ������ �����ؼ� ��� , �̸� , �޿� , �Ի����� ����ϼ���
--ó�ٿ� �Ի��� ��� ....
select empno, ename, sal , hiredate
from emp
order by hiredate desc;

/*
SELECT       3                        
FROM          1                   
WHERE         2        
ORDER BY     4    (select �� ����� ���� )  
*/ 

--���� : 
--��� ���̺��� ������ manager�� ��� , �̸� , �޿� , ���� , �Ի��� ����ϵ� �Ի��� ���� ���� ������ ����ϼ���
select empno , ename , sal , job , hiredate
from emp
where job='MANAGER'
order by hiredate desc;


--�ؼ�
select deptno , job
from emp
order by deptno desc , job asc; --���� 2�� ( grouping )

--������ 
--������(union) : ���̺�� ���̺��� �����͸� ���ļ� �������� �� (�ߺ����� ����)
--������(union all) : �ߺ��� ���

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
union  --�ߺ��� ����
select name from uta;


select name from ut
union all 
select name from uta;

--union  ��Ģ
--1. ������� �÷��� Ÿ���� ����
select empno, ename from emp
union
select dname ,deptno from dept; --(x)

select empno, ename from emp
union
select deptno ,dname from dept; 

--2. ������� �÷��� ���� ���� (null ������)

select empno , ename, job , sal from emp
union
select deptno, dname , loc , null from dept;

--����Ŭ �Լ� (pdf 48 page)
/*
������ �Լ�
1) ������ �Լ� : ���ڸ� �Է� �ް� ���ڿ� ���� �� ��θ� RETURN �� �� �ִ�. 
2) ������ �Լ� : ���ڸ� �Է� �ް� ���ڸ� RETURN �Ѵ�. 
3) ��¥�� �Լ� : ��¥���� ���� �����ϰ� ���ڸ� RETURN �ϴ� MONTHS_BETWEEN �Լ��� �����ϰ� ��� ��¥ ���������� ���� RETURN �Ѵ�. 
4) ��ȯ�� �Լ� : � ���������� ���� �ٸ� ������������ ��ȯ�Ѵ�. 
5) �Ϲ����� �Լ� : NVL, DECODE 
*/
--���ڿ� �Լ�

select initcap('the super man') from dual; --The Super Man

select lower('AAA') , upper('aaa') from dual;

select ename , lower(ename) as "ename" from emp;

select * from emp where lower(ename) = 'king';

--������ ����(length)
select length('abcd') from dual;
select length('ȫ�浿�ٺ�') from dual;

select length('ȫ �� �� ') from dual;

--���� ������ ||
--���� �Լ�
select 'a' || 'b' || 'c' from dual;

select concat('a','b') from dual;

select concat(ename, job) from  emp;
select ename || '   ' || job from emp;

--�κ� ���ڿ� ����
--java(substring)
--oracle(substr)

select substr('ABCDE',2,3) from dual; --BCD
select substr('ABCDE',1,1) from dual; --�ڱ��ڽ� A
select substr('ABCDE',3,1) from dual; --C

select substr('ABCDE',3) from dual;
select substr('ABCDE',-2,1) from dual;
select substr('ABCDE',-2,2) from dual; --DE

/*
������̺���  ename  �÷� �����Ϳ� ���ؼ� ù���ڴ� �ҹ��ڷ� ������ ���ڴ� �빮�ڷ� ����ϵ�
�ϳ��� �÷� �����ͷ� ����ϼ���
�÷��� ����Ī : fullname
ù���ڿ� ������ ���� ���̿� ���� �ϳ� �־��
--SMITH  ��� : s MITH
*/
select lower(substr(ename,1,1)) from emp;

select upper(substr(ename,2)) from emp;

select lower(substr(ename,1,1))  ||  ' '  ||upper(substr(ename,2)) as "fullname"
from emp;

--lpad , rpad (ä���)

select lpad('ABC',10,'*') from dual;


select rpad('ABC',10,'#') from dual;

--Quiz 
--����� ��� : hong1006
--ȭ�鿡 ho****** �� ����ϰ� �;�� (�տ� 2���� �����ְ� �� �������� * �����ְ� �;��

select rpad(substr('hong1006',1,2),length('hong1006'),'*') as "password" from dual;

--emp ���̺��� ename  �÷��� �����͸� ����ϴ� �� ù�۸� ����ϰ� �������� * �� ����ϼ���
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
--��°��
-- 100 : 123456-*******
-- 200: 234567-*******
--�� ����� ���� ����Ī jumin
--Ǫ�ð� ������

--------------------------------------------------------
select id || ' : ' || rpad(substr(jumin,1,7),length(jumin),'*') from member2; 

--rtrim �Լ�
--[������ ����] ������
select rtrim('MILLER','ER') from dual;

--ltrim  �Լ�
select ltrim('MILLLLLLLLER','MIL') from dual; --����

--ġȯ�Լ�
select ename , replace(ename,'A','�Ϳ�')  from emp;

--[���ڿ� �Լ� END]

--[���� �Լ�]
--round (�ݿø� �Լ�)
--trunc (���� �Լ�)
--������ �Լ� mod()

--  -3  -2   -1  0(����)  1  2  3
select round(12.345,0) as "r" from dual; --�����θ� ���ܶ�(�ݿø�)
select round(12.567,0) as "r" from dual; --13

select round(12.345,1) as "r" from dual; --12.3
select round(12.567,1) as "r" from dual; --12.6


select round(12.345,-1) as "r" from dual; --10�ڸ�  --10
select round(15.345,-1) as "r" from dual; --20
select round(15.345,-2) as "r" from dual; --0

-- trunc(�ݿø� ó������ �ʾƿ�)
select trunc(12.345,0) as "r" from dual; --12
select trunc(12.567,0) as "r" from dual; --12

select trunc(12.345,1) as "r" from dual; --12.3
select trunc(12.567,1) as "r" from dual; --12.5

select trunc(12.345,-1) as "r" from dual; --10�ڸ�  --10
select trunc(15.345,-1) as "r" from dual; --10
select trunc(15.345,-2) as "r" from dual; --0

--������
select 12/10 from dual; --1.2
select mod(12,10) from dual; --������
select mod(0,0) from dual;

--[���� �Լ� END]

--[��¥ �Լ�]
--sysdate
--POINT  ��¥ ����
select sysdate from dual;
alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';
select hiredate from emp;

--Date + Number >> Date 
--Date - Number >> Date
--Date - Date >> Number (�ϼ�)

--��¥ (round , trunc)

select months_between('2019-02-27','2010-02-27') from dual; --������ 108����

select round(months_between(sysdate,'2010-01-01'),0) from dual; --117����
--116.795299805854241338112305854241338112
select trunc(months_between(sysdate,'2010-01-01'),0) from dual;  --116����


select to_date('2015-01-01') + 1000 from dual;

select sysdate + 100 from dual;

--QUIZ
/*
1. ������̺��� ������� �Ի��Ͽ��� ���糯¥(sysdate)������ �ټӿ����� ���ϼ���
--�� �ټӿ����� �����κи� ���⼼��


2. �Ѵ��� 31�� �̶�� �����ϰ� �ټӿ����� ���ϼ��� (�����θ� ���⼼��)

*/
select ename, hiredate , trunc(months_between(sysdate,hiredate),0) as "�ټӿ�" ,
        trunc((sysdate - hiredate) /31,0) as "�ټӿ�2"
from emp;        
--[��¥ �Լ� END]
--�����Լ�
--�����Լ�
--��¥�Լ�

--[��ȯ�Լ�]  POINT
--Oracle : ���� , ���� , ��¥ ������
--to_char() : ����(10000) -> ����($10000) (100,000) , ��¥('1900-01-01') -> ����(1900��01��01��)
--��������

--to_date() : ���� -> ��¥  >> select '2019-12-12' + 1000 >>  select to_date('2019-12-12') ..

--to_number() : ���� -> ���� (�ڵ�����ȯ)
select '100' + 100 from dual;  --������ ����
select to_number('100') + 100 from dual;

/*

����Ŭ �⺻ Ÿ��(������ Ÿ��)
create table ���̺�� (�÷���  Ÿ�� ); 
create table member(age number); 100�� ������ insert
--java > class member { int age } >> member m = new member(); 1��
--java > List<member> list = new ArrayList<>();   list.add(new member()) ������

���� Ÿ��
--char(20) >> 20byte >> �ѱ�10��,  ������,Ư������,���� 20��  >> �������̹��ڿ�
--varchar2(20) >>  20byte >> �ѱ�10��,  ������,Ư������,���� 20��  >> �������̹��ڿ�

char(20) >> 'ȫ�浿' >> 20byte ��� ���[ȫ�浿                                   ] 
varchar2(20) >> 'ȫ�浿' >> ������ ũ�� >> 6byte[ȫ�浿]

�����ȵ����� : �� , ��   >> ó��  >> char(2)
�ᱹ >> varchar2(2) 

���� ���� ����))
char() ..... varchar2() ���� �˻��� �켱 ...

�ᱹ ������ [�ѱ�]
unicode (2byte) : �ѱ� , ������ , Ư������ , ���� >> 2byte
nchar(20) >> 20�� ������ ����  >> ���� byte *2 >> 40byte
nvarchar2(20) >> 20���� ���� 

�ѱ� 20�� , ������ 20��

*/
--1. to_number() : ���ڸ� ���ڷ�
select 1 + 1 from dual;

select '1' + 1 from dual; --�ڵ� ����ȯ

select to_number('1') +1 from dual;

select '1' + '1' from dual; --�ڵ� ����ȯ

select '1A' + '1' from dual;
--------------------------------------------------------------
--2. to_char() :  ���� -> ����(���Ĺ���) , ��¥ -> ����(���Ĺ���)
select sysdate from dual;
--YYYY   YY   MM   DD .... ���ǵǾ� �־��

select sysdate || '��'  from dual;  --�ڵ� ����ȯ (��¥  ��  ���ڰ� ���� >> ����)
--��Ģ
select to_char(sysdate) || '��' from dual;

select sysdate ,
to_char(sysdate,'YYYY') || '��' as "YYYY",
to_char(sysdate,'YEAR'),
to_char(sysdate,'MM'),
to_char(sysdate,'DD'),
to_char(sysdate,'DAY'),
to_char(sysdate,'DY')
from dual;

--Quiz (to_char() , to_number() , to_date()
--�Ի��� 12���� ������� ��� , �̸�, �Ի���, �Ի�⵵ , �Ի���� ����ϼ���

select empno, ename, hiredate , to_char(hiredate,'YYYY') as "��", to_char(hiredate,'MM') as "��"
from emp
where to_char(hiredate,'MM') = '12';

select to_char(hiredate,'YYYY MM DD') from emp;

select to_char(hiredate,'YYYY"��" MM"��" DD"��"') from emp;

--to_char() : ���� -> ����
--why : 10000000  -> $1,000,000,000  �̷� ������ ���ڵ����� to_char()
select '>' || to_char(12345,'999999999999') || '<' from dual;
select '>' || to_char(12345,'099999999999') || '<' from dual;
select '>' || to_char(12345,'000000000000') || '<' from dual;

select '>' || to_char(12345,'$9,999,999,999,999') || '<' from dual;


select to_char(sal,'$999,999') as "sal"
from emp;

--���� ���� ���� : bituser--

--���Ӱ��� HR ...
select * from employees;

������̺��� ����� �̸��� last_name , first_name ���ļ� fullname ��Ī �ο��ؼ� ����ϰ�
�Ի�����  YYYY-MM-DD �������� ����ϰ� ����(�޿� *12)�� ���ϰ� ������ 10%(���� * 1.1)�λ��� ���� 
����ϰ� �� ����� 1000���� �޸� ó���ؼ� ����ϼ���
�� 2005�� ���� �Ի��ڵ鸸 ����ϼ��� �׸��� ������ ���� ������  ����ϼ���


select employee_id , first_name , last_name , hire_date , salary
from employees;

select   employee_id,
           first_name || last_name as "fullname",
           to_char(hire_date,'YYYY-MM-DD') as "hire_date",
           salary,
           salary * 12 as "����",
           to_char((salary * 12)*1.1,'$9,999,999,999') as "�λ��",
           hire_date
from employees
where to_char(hire_date,'YYYY') >= '2005'
order by "����" desc; ---salary * 12 desc; -- order by �� select ����� ������ ����  ����Ī ��� ����           

--
--����
--����
--��¥
--��ȯ(to_char ����)

--[ �Ϲ��Լ� ]
--���α׷��� ������ ���� ....
--nvl() , nvl2() --> null 
--decode() --> java if  ����
--case() --> java switch ����

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
select id, job , nvl2(job , job || ' �Դϴ�' , 'empty..') from t_emp; 

select id , job , nvl2(job,'AAAA','BBBB') from t_emp;

--3. decode POINT (sql ��� ����� �����  if , for (x))
--decode(ǥ���� , ����1 , ���1 , ����2 , ���2 , ����3 , ���3 ...)
--��� ������ ����

select id, job, decode(id, 100,'IT...', 
                                 200,'SALES...', 
                                 300,'MGR...' ,
                                 'ETC...') as "decodejob"
from t_emp;

select job , decode(job,'IT',1) from t_emp; --decode ���ǿ� �ش���� �ʴ� ����  null

select job , decode(job,'IT',1,1111) from t_emp; --default ��

--Ȱ�� (��� ������)
select decode(job,'IT',1) as "IT",  -- �÷� 1��
         decode(job,'SALES',1) as "SALES", --�÷� 1�� 
         decode(job,'MGR',1) as "MGR" --�÷�1��
from t_emp;


select count(decode(job,'IT',1)) as "IT",  -- �÷� 1��
         count(decode(job,'SALES',1)) as "SALES", --�÷� 1�� 
         count(decode(job,'MGR',1)) as "MGR" --�÷�1��
from t_emp;


select * from t_emp;

/*
emp ���̺��� �μ���ȣ�� 10�̸� '�λ��' , 20 '������' , 30 'ȸ���' ������ �μ� ��ȣ��
'��Ÿ�μ�' ��� ����ϴ� �������� ���弼��
decode �� ����ؼ�
*/

select empno , ename , deptno , decode(deptno, 10, '�λ��',
                                                                 20, '������',
                                                                 30, 'ȸ���',
                                                                 '��Ÿ�μ�') as "�μ��̸�"
from emp;                                                                 

create table t_emp2(
 id number(2),
 jumin char(7)
);

drop table t_emp2; --���̺� ����  --�ٽ� create
insert into t_emp2(id, jumin) values(1,'1234567');
insert into t_emp2(id, jumin) values(2,'2234567');
insert into t_emp2(id, jumin) values(3,'3234567');
insert into t_emp2(id, jumin) values(4,'4234567');
insert into t_emp2(id, jumin) values(5,'9234567');
commit;

select * from t_emp2;
/*
t_emp2 ���̺��� id, jumin �����͸� ����ϵ� jumin �÷��� ���ڸ��� 1�̸� ���� , 2�̸� ���� , 3�̸� �߼� 
�� �ܴ� ��Ÿ �� ����ϼ���
*/

select id, decode(substr(jumin,1,1) , 1, '����',
                                            2, '����',
                                            3, '�߼�',
                                            '��Ÿ' ) as "gender"
from t_emp2;                                

--���̵� �߱�
--java  if(){  if () {} }
--oracle : decode( decode() )

select  deptno , ename, decode(deptno,20, decode(ename, 'SMITH','HELLO',
                                                                              'WORLD'),
                                                    'ETC') as "decode"
from emp;                                                    



--CASE ��
--java : switch
/*
  CASE ���� WHEN ���1 THEN ���1
                WHEN ���2 THEN ���2
                WHEN ���3 THEN ���3
                WHEN ���4 THEN ���4
                ELSE  ���5
  END "�÷���"

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

select '0' || to_char(zipcode),  case zipcode when 2 then '����'
                                                         when 31 then '���'
                                                         when 32 then '����'
                                                         when 41 then '����'
                                                         else '��Ÿ����'
                                       end "regionname"
from t_zip;                                       

/*
������̺��� ����޿��� 1000�޷� ���ϸ� 4��   
1001 �޷� 2000�޷� ���ϸ� 3��
2001 �޷� 3000�޷� ���ϸ� 2��
3001 �޷� 4000�޷� ���ϸ� 1��
4001 �޷� �̻��̸� Ư���� �ο��ϴ� �����͸� ����ϼ���

1.  case �÷���  when ��� then ���    (�÷��� = ���)
2. case when  �÷��� ���Ǻ�  ���  then  (sal <= 200)

*/

select  case when sal <= 1000 then '4��'
                  when sal between 1001 and 2000 then '3��'
                  when sal between 2001 and 3000 then '2��'
                  when sal between 3001 and 4000 then '1��'
                  else 'Ư��'
          end "�޿����" , empno, ename, sal
from emp;    

---
--���� -> ���� -> ��¥ -> ��ȯ(to_char, to_date, to_number) -> �Ϲ��Լ�(nvl() ~ case() 
--�����Լ� �׷� �Լ�(Multi Row Function)  pdf(75 page)

--[�����Լ�]
--1. count(*) , count(�÷���) >> ������ �Ǽ�
--2. sum()
--3. avg()
--4. max()
--5. min()
--���
/*

1. POINT : ��� �����Լ��� null ���� ����
2. POINT : select ���� �����Լ� �̿ܿ� �ٸ� �÷��� ���� �ݵ�� group by ���� ���

*/
select count(*) from emp; --row �� 

select count(empno) from emp; --������ �Ǽ� (null ����)

select count(comm) from emp; ----������ �Ǽ� (null ����)

select * from emp;

--null �Ǽ� ....
select count(nvl(comm,0)) from emp;  --null �� ���� ó�� nvl()

--�޿��� �� 29025
select sum(sal) as "sum" from emp;

--��� �޿� (�޿��� �� / �����)
select trunc(avg(sal),0) as "��ձ޿�" from emp; --2073

--������� �츮 ȸ�� ������ �� ������
select sum(comm) as "comm" from emp --4330
-- ��ռ���
select trunc(avg(comm),0) as "avg" from emp; --721 


select  comm from emp;
select (300+200+30+300+3500+0) / 6 from dual; --721
--ȸ�� ��� : 14��
--avg : 6�� .... (null ����)


select (300+200+30+300+3500+0) / 14 from dual; --309
select sum(comm) /14 from emp;
select avg(nvl(comm,0)) from emp; --309

--�Ѵ� �¾ƿ�
--ȸ�� ���� : ��ü ����� ������ : 309
--ȸ�� ���� : �޴� ����� ���� : 721

select count(comm) from emp where comm is not null;
select count(comm) from emp;

select max(sal) from emp;

select min(sal) from emp;

--POINT : �����Լ��� return  �ϴ� ���� : 1��
select sum(sal) , avg(sal) , max(sal) , min(sal) ,count(sal) , count(*) from emp;

--�μ��� ��� �޿��� ���ϼ���
select deptno, avg(sal) 
from emp
group by deptno; 

select avg(sal) from emp group by deptno; --���డ�� �ؼ� �Ұ���

--������ ��� �޿� , �޿��� , �ִ�޿� , �ּұ޿� , �Ǽ��� ����ϼ���
select job , avg(sal) , sum(sal) , max(sal) , min(sal), count(sal)
from emp
group by job;

/*
grouping ���� (�÷��� ����)
distinct �÷���1 , �÷���2

order by �÷��� asc , �÷��� desc

group by �÷���1, �÷���2

*/
--�μ��� , ������ �޿��� ���� ���ϼ���

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

--������ ��ձ޿��� 3000�޷� �̻��� ����� ������ ��ձ޿��� ����ϼ���
--��ձ޿� >= 3000>> ��ձ޿� >> ���� >> group by ....
-- where ��ձ޿� ������ ��� ���ؿ� ....
--group by ����� ���� ���� >> having 

--from ���� ������ : where
--group by  ���� ������ : having

select job , avg(sal) as "avg"
from emp
group by job
having avg(sal) >= 3000;


/*
1���� ���̺��� �����͸� ��ȸ�Ҽ� �ִ� ���

SELECT                 5     
FROM                   1   
WHERE                  2    
GROUP BY             3
HAVING                 4
ORDER BY              6
*/


/*
������̺��� ������ �޿����� ����ϵ� ������ ���� �ް� �޿��� ���� 5000 �̻��� ������� ����� ����ϼ���
--�޿��� ���� ���� ������ ����ϼ���
*/
select job, sum(sal) as "sumsal"
from emp
where comm is not null
group by job
having sum(sal) >= 5000
order by "sumsal" asc;

/*
������̺��� �μ� �ο��� 4���� ���� �μ��� �μ���ȣ ,�ο��� , �޿��� ���� ����ϼ���
*/
select deptno , count(*) as "�μ����ο�" , sum(sal) as "�μ��� �޿��� ��"
from emp
group by deptno
having count(*) > 4;

/*
������̺��� ������ �޿��� ���� 5000�� �ʰ��ϴ� ������ �޿��� ���� ����ϼ���
�� �Ǹ�����(salesman) �� �����ϰ� �޿������� �������� �����ϼ���
*/
select job, sum(sal) as "sumsal"
from emp
where job != 'SALESMAN'
group by job
having sum(sal) > 5000 
order by "sumsal" desc;

-----------------------------------------------------------------------------
--���ݱ��� SELECT ��� �ϳ��� ���̺� ....
--RDBMS (�ּ� �ϳ��� �̻��� ���̺�� �̷���� ...)

--java : class �۾� : ���� (���, ���� , ���� , ...)
--DB : Table Table ���� ���踦 ������ �ִ�
--1:1 , 1:n , m:n ����
--���� ���ϴ� �����Ͱ� �ϳ��� ���̺��ִ� ���� �ƴϰ� 1�� �̻��� ���̺� �������� �ִ�
--�������� ���̺��� ���ϴ� �����͸� ����ϴ� ��� >> JOIN

--����
--1. �����(equi join) => 70%
--�����̺�� ������� ���̺� �ִ� �÷��� ������ 1:1 ����
--[ANSI ����]
--���� : join on~������ ,  [inner] join on~������

--2. ������(non-equi join) => �ǹ̸� ���� => ������ � ���� 
--�����̺�� ������� ���̺� �ִ� �÷��� 1:1 ���ε��� �ʴ� ���
--emp , salgrade : sal �÷��� ������ ... 2���� �÷�(losal , hisal)

--3. �ܺ�����(outer join : null) >> equi join null ó���� �ȵǿ�
--outer join (�ΰ��� ���̺��� ��, �� ���� �ľ�)
--����
-- left outer join (���� �� , ������ ��)
-- right outer join (������ �� , ���� ��) 
-- full outer join (left , right join >> union �ϸ�)



--self join (�ڱ�����) => �ǹ̸� ���� => �����
--emp ���̺��� smith  ����� ������ �̸��� �����Դϱ�
--�ϳ��� ���̺��� � �÷��� �ٸ� �÷��� ���� �ϴ� ��쿡 
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
--�Ʒ��� sql ���� ���� (�ǵ����̸� ����� ..... ���� .... ���ƿ�)
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
--ANSI ����
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
--SQL JOIN  ����� from �����̰� ����� join  �������� �Ǵ� �����
select *
from m , s
where m.m1 = s.s1 and m.m1 = 'A';

select *
from m join s on m.m1 = s.s1
where m.m1 ='A';  --������� 


select * 
from s join x
on s.s1 = x.x1;

--�Ѱ� �̻��� ���̺��� JOIN �ɱ�
--oracle sql join ����
select *
from m , s , x
where m.m1 = s.s1 and s.s1 = x.x1;

--ansi  ����
select m.m1 , m.m2 , s.s2 , x.x2
from m join s on m.m1 = s.s1 
           join x on s.s1 = x.x1 ;
--           join y on
--           join z on

--��� , �̸� , �μ���ȣ , �μ��� , �޿� , �޿������ ����ϼ���

select e.empno , e.ename , e.deptno, d.dname , e.sal , s.grade
from emp e join dept d on e.deptno = d.deptno
                 join salgrade s on e.sal between s.losal and s.hisal
order by e.empno;  --�� ...���� ����� 



--1. HR �������� �̵�
select * from employees;
select * from departments;
select * from locations;
--1.  ��� , �̸�(last_name) , �μ���ȣ , �μ��̸��� ����ϼ���
select e.employee_id , e.last_name , e.department_id, d.department_name
from employees e join departments d
on e.department_id = d.department_id
order by e.employee_id;

--������  ����� 107�� >> ���� ��µ� 106 (������ ����)
--����� ���� �� ���� �ذ� �Ұ��� ..... >> �ذ� (outer join)
--why ? null �� �� ����


--2. ��� , �̸�(last_name) , �μ���ȣ , �μ��̸� , ���ø��� ����ϼ���
select e.employee_id , e.last_name , e.department_id, d.department_name , d.location_id, l.city
from employees e  join departments d  on e.department_id = d.department_id
       join locations l on d.location_id = l.location_id 
order by e.employee_id;


select * from tabs;  --������ ������ ������ �ִ� Table ���

--�� (1:1 ���� �Ǵ� �÷��� �����)
select * from emp;
select * from salgrade;
--��� , �̸� , �޿� , �޿������ ���  (� ����)
select e.empno , e.ename , e.deptno, d.dname , e.sal , s.grade
from emp e join dept d on e.deptno = d.deptno
                 join salgrade s on e.sal between s.losal and s.hisal
order by e.empno; 


--outer join : ���������� ����� �����ϰ� (��, ��) ���踦 �ľ��ϰ�
--������ �Ǵ� ���̺� ���� �ִ� �����͸� ������ ���� ���

select *
from m join s
on m.m1 = s.s1;

select *
from m left outer join s
on m.m1 = s.s1;


select *
from m right outer join s
on m.m1 = s.s1;

--���� : HR
--1.  ��� , �̸�(last_name) , �μ���ȣ , �μ��̸��� ����ϼ���
select e.employee_id , e.last_name , e.department_id, d.department_name
from employees e join departments d
on e.department_id = d.department_id
order by e.employee_id;


select * from employees where department_id is null;
--Grant �μ� null  �ϴ��� 107���� ����� ������ ���Ѵ�
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

--��� 14��  .... 13��

select e.empno, e.ename , m.empno , m.ename
from emp e left outer join emp m
on e.mgr = m.empno;

------------------------------------------------
-- 1. ������� �̸�, �μ���ȣ, �μ��̸��� ����϶�.
SELECT E.ENAME, E.DEPTNO, D.DNAME
FROM EMP E  join DEPT D on E.DEPTNO=D.DEPTNO;
 
-- 2. DALLAS���� �ٹ��ϴ� ����� �̸�, ����, �μ���ȣ, �μ��̸���
-- ����϶�.
SELECT E.ENAME, E.JOB, D.DEPTNO, D.DNAME
FROM EMP E  join DEPT D on E.DEPTNO=D.DEPTNO 
WHERE  D.LOC='DALLAS';
 
-- 3. �̸��� 'A'�� ���� ������� �̸��� �μ��̸��� ����϶�.
SELECT E.ENAME, D.DNAME
FROM EMP E  join DEPT D  on D.DEPTNO=E.DEPTNO
WHERE  E.ENAME LIKE '%A%';
--WHERE Regexp_like(E.ENAME,'^A'); 
-- 4. ����̸��� �� ����� ���� �μ��� �μ���, �׸��� ������
--����ϴµ� ������ 3000�̻��� ����� ����϶�.
SELECT E.ENAME, D.DNAME, E.SAL 
FROM EMP E  join DEPT D on E.DEPTNO=D.DEPTNO
WHERE E.SAL>=3000;
 
-- 5. ����(����)�� 'SALESMAN'�� ������� ������ �� ����̸�, �׸���
-- �� ����� ���� �μ� �̸��� ����϶�.
SELECT E.JOB, E.ENAME, D.DNAME
FROM EMP E  join DEPT D on E.DEPTNO=D.DEPTNO
WHERE E.JOB='SALESMAN';
 
-- 6. Ŀ�̼��� å���� ������� �����ȣ, �̸�, ����, ����+Ŀ�̼�,
-- �޿������ ����ϵ�, ������ �÷����� '�����ȣ', '����̸�',
-- '����','�Ǳ޿�', '�޿����'���� �Ͽ� ����϶�.
--(�� ) 1 : 1 ���� ��� �÷��� ����
SELECT E.EMPNO AS "�����ȣ",
               E.ENAME AS "����̸�",
               E.SAL*12 AS "����",
           --E.SAL*12+NVL(COMM,0) AS "�Ǳ޿�",
               E.SAL*12+COMM AS "�Ǳ޿�",
               S.GRADE AS "�޿����"
FROM EMP E  join SALGRADE S on E.SAL BETWEEN S.LOSAL AND S.HISAL
WHERE E.Comm is not null;
 
-- 7. �μ���ȣ�� 10���� ������� �μ���ȣ, �μ��̸�, ����̸�,
-- ����, �޿������ ����϶�.
-- inner �� ���� ����
SELECT E.DEPTNO, D.DNAME, E.ENAME, E.SAL, S.GRADE
FROM EMP E   join DEPT D on E.DEPTNO=D.DEPTNO
                         join SALGRADE S on E.SAL BETWEEN S.LOSAL AND S.HISAL
WHERE E.DEPTNO=10;
 
SELECT * FROM SALGRADE;
 
 
-- 8. �μ���ȣ�� 10��, 20���� ������� �μ���ȣ, �μ��̸�,
-- ����̸�, ����, �޿������ ����϶�. �׸��� �� ��µ�
-- ������� �μ���ȣ�� ���� ������, ������ ���� ������
-- �����϶�.
-- inner �� ���� ����
SELECT E.DEPTNO, D.DNAME, E.ENAME, E.SAL, S.GRADE
FROM EMP E  join DEPT D    on E.DEPTNO=D.DEPTNO
            join SALGRADE S    on E.SAL BETWEEN S.LOSAL AND S.HISAL
WHERE  E.DEPTNO<=20 --WHERE E.DEPTNO IN (10,20)  -- e.deptno = 10 or 
ORDER BY E.DEPTNO ASC,  E.SAL DESC;
 
 
-- 9. �����ȣ�� ����̸�, �׸��� �� ����� �����ϴ� ��������
-- �����ȣ�� ����̸��� ����ϵ� ������ �÷����� '�����ȣ',
-- '����̸�', '�����ڹ�ȣ', '�������̸�'���� �Ͽ� ����϶�.
--SELF JOIN (�ڱ� �ڽ����̺��� �÷��� ���� �ϴ� ���)
 
SELECT E.EMPNO, E.ENAME , M.EMPNO, M.ENAME
FROM EMP E  left outer join EMP M
on e.MGR = m.EMPNO;

--------------------------------------------------------------
--�ʱ� ������ : �Լ� , ���� 
--------------------------------------------------------------
--[subquery]  pdf 100page
--sql ���� �ذ�� >> sql �� 

--������̺��� ������� ��� ���޺��� �� ���� �޿��� �޴� ����� ��� , �̸� , �޿��� ����ϼ���

--subquery
select avg(sal) from emp;  --2073

--main query
select *
from emp
where sal > 2073;

select *
from emp
where sal > (select avg(sal) from emp)

--���� ...
--�Լ��ذ�(����) > ����2���̻�) > subquery(������ ����)

/*
subquery 
����
�ϳ��� �÷����� ����� 
1. single row subquery : subquery �� ����� 1�� row(���ϰ�) : �÷� 1��
select sum(sal) from emp;


2. multi row subquery : subquery �� ����� 1�� �̻��� row(��������) : �÷� 1��
select sal from emp;

�����ϴ� ���� (���Ǵ� ������ Ʋ����)
--������ (in  , not in) (any , all) ���ߵ�����
--all : sal > 1000 and sal > 2000 and ...
--any : sal > 1000 or sal > 2000 or ...

����(����)
1. subquery �� ��ȣ�ȿ� �־�� �Ѵ� >>  (select sal from emp)
2.subquery �� ���� �÷����� ���� >> select sum(sal) , avg(sal) from emp (x)
3. subquery �� �ܵ����� ���� �����ؾ� �Ѵ�

subquery  �� ������ ���� ����
1. subquery ����
2. subquery ����� ������ main  query  ����

*/

--������̺��� jones�� �޿����� �� ���� �޿��� �޴� ����� ��� , �̸� , �޿� ����ϼ���

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
 
 --���������� �ִ� ����� ����� �̸��� ����ϼ���
 
 select empno , ename 
 from emp where empno in (select mgr from emp);
 --empno = 7839 or empno=7698 or empno is null or 
 --or ���꿡�� null(x)
 
 --null ��� ������  null
 --���������� ���� ����� �����  �̸��� ����ϼ���

 select empno , ename 
 from emp where empno not in (select nvl(mgr,0) from emp);
 --empno != 7839 and empno!=7698 and empno is null and .... >>>>>>> null 
 
 
 --king  ���� �����ϴ� �� ���ӻ���� king  �� ����� ��� , �̸�, ���� , ������ ����� ����ϼ���
 select empno from emp where ename='KING';
 
 select empno, ename, job , mgr
 from emp
 where mgr = (select empno from emp where ename='KING');
 
 --20�� �μ��� ����߿��� ���� ���� �޿��� �޴� ������� �� ���� �޿��� �޴� ����� 
 --��� , �̸� , �޿� ,�μ���ȣ�� ����ϼ���
 
 select max(sal) from emp where deptno=20;

 select empno, ename , sal , deptno
 from emp
 where sal > (select max(sal) from emp where deptno=20);
 
 
 select * from emp
 where deptno in (select deptno from emp where job='SALESMAN')
 and sal in (select sal from emp where job='SALESMAN');
 
 
 --30��
 --1. 'SMITH'���� ������ ���� �޴� ������� �̸��� ������ ����϶�.
SELECT ENAME, SAL
FROM EMP
WHERE SAL>(SELECT SAL
               FROM EMP
               WHERE ENAME='SMITH');
 
--2. 10�� �μ��� ������ ���� ������ �޴� ������� �̸�, ����,
-- �μ���ȣ�� ����϶�.
SELECT ENAME, SAL, DEPTNO
FROM EMP
WHERE SAL IN(SELECT SAL
                 FROM EMP
                 WHERE DEPTNO=10);
 
--3. 'BLAKE'�� ���� �μ��� �ִ� ������� �̸��� ������� �̴µ�
-- 'BLAKE'�� ���� ����϶�.
SELECT ENAME, HIREDATE
FROM EMP
WHERE DEPTNO=(SELECT DEPTNO
                     FROM EMP
                     WHERE ENAME='BLAKE')
AND ENAME!='BLAKE';
 
--4. ��ձ޿����� ���� �޿��� �޴� ������� �����ȣ, �̸�, ������
-- ����ϵ�, ������ ���� ��� ������ ����϶�.
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL>(SELECT  AVG(SAL)  FROM EMP)
ORDER BY SAL DESC;
 
--5. �̸��� 'T'�� �����ϰ� �ִ� ������ ���� �μ����� �ٹ��ϰ�
-- �ִ� ����� �����ȣ�� �̸��� ����϶�.
SELECT EMPNO, ENAME
FROM EMP
WHERE DEPTNO IN(SELECT DEPTNO
                       FROM EMP
                       WHERE ENAME LIKE '%T%');
--where deptno = 20 or deptno= 30
--6. 30�� �μ��� �ִ� ����� �߿��� ���� ���� ������ �޴� �������
-- ���� ������ �޴� ������� �̸�, �μ���ȣ, ������ ����϶�.
--(��, ALL(and) �Ǵ� ANY(or) �����ڸ� ����� ��)
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
 
 
--7. 'DALLAS'���� �ٹ��ϰ� �ִ� ����� ���� �μ����� ���ϴ� �����
-- �̸�, �μ���ȣ, ������ ����϶�.
SELECT ENAME, DEPTNO, JOB
FROM EMP
WHERE DEPTNO IN(SELECT DEPTNO    -- = �� �´µ�  IN
                      FROM DEPT
                      WHERE LOC='DALLAS');
 
--8. SALES �μ����� ���ϴ� �������  ���� �μ���ȣ, �̸�, ������ ���� ��������� ����϶�.
SELECT DEPTNO, ENAME, JOB
FROM EMP
WHERE DEPTNO IN(SELECT DEPTNO
                      FROM DEPT
                      WHERE DNAME='SALES')
 
--9. 'KING'���� �����ϴ� ��� ����� �̸��� �޿��� ����϶�
--king �� ����� ��� (mgr �����Ͱ� king ���)
SELECT ENAME, SAL
FROM EMP
WHERE MGR=(SELECT EMPNO
                FROM EMP
                WHERE ENAME='KING');
 
--10. �ڽ��� �޿��� ��� �޿����� ����, �̸��� 'S'�� ����
-- ����� ������ �μ����� �ٹ��ϴ� ��� ����� �����ȣ, �̸�,
-- �޿��� ����϶�.
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
 
--11. Ŀ�̼��� �޴� ����� �μ���ȣ, ������ ���� �����
-- �̸�, ����, �μ���ȣ�� ����϶�.
SELECT ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO IN(SELECT DEPTNO
                      FROM EMP
                      WHERE COMM IS NOT NULL)
AND SAL IN( SELECT SAL
               FROM EMP
               WHERE COMM IS NOT NULL);
 
--12. 30�� �μ� ������ ���ް� Ŀ�̼��� ���� ����
-- ������� �̸�, ����, Ŀ�̼��� ����϶�.
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

�⺻�Լ� (���� ~   �Ϲ��Լ�)
�������̺� (JOIN )
subquery 
+
DML(insert , update , delete)  �ϱ� (�ʼ�����)
*/

--[insert , update , delete]
/*
����Ŭ ����
DDL(������ ���Ǿ�) : create , alter , drop , truncate (rename, modify) --> DBA
DML(������ ���۾�) : insert , update , delete -> ������
DQL(������ ���Ǿ�) : select -> ������ (�Լ� , ���� , ��������)
DCL(������ �����) : ���� (grant , revoke) -->  DBA
TCL(Ʈ�����) : commit , rollback , savepoint --> ������
*/

--DML �۾�
--����Ŭ ���������� Ʈ����� ���� :
--����Ŭ (begin tran...) �ڵ����� ~~~ ó�� �Ϸ� (rollback , commit)  
--insert .. ����

--Ʈ�����(transaction) : �ϳ��� ������ �۾� ����
--���� (Ʈ�����)
--���� (A ���� ���� 1000 ����  B��� ���� �Ա�)
--���� (A ���� ���� ~~~~~~ B��� ���� �Ա�) �ϳ��� ����
/*
  ���� .....
   A��� ����
   update  ����
   set �ܾ� = �ܾ�-��ݾ�

   B��� ����
   update ����
   set �ܾ� = �ܾ� + �Աݾ�
  ��  ... commit
  
  ������ ���� �ʰ� ������ �ϳ��� ����� ���� : rollback
*/
--���̺� �⺻ ����
desc emp;

--����Ŭ (system ���̺� �پ��� ���� ����)
select * from tab; --���Ӱ��� �ٷ� �� �ִ�  table ���

select * from tab where tname='EMP'; --���̺� ���� ���� ... �ִ��� ������

select * from col where tname='EMP';

select * from user_tables; --������ , Ʃ��
select * from user_tables where table_name='DEPT';


--DML(pdf > 168page)
/*
INSERT INTO table_name [(column1[, column2, . . . . . ])] 
VALUES  (value1[, value2, . . . . . . ]);
*/

create table temp(
  id number primary key , --id �÷��� �����ʹ� null(x) , �ߺ����� (x) �����ϴ� ����� ����
  name varchar2(20) --default null
);

insert into temp(id , name)
values(100, 'ȫ�浿');

select * from temp;
--�ǹݿ�
commit;

--2. �÷� ����Ʈ �����ϱ�
insert into temp  --�÷�����Ʈ ���� (�������� ������)
values(200,'������');


select * from temp;
commit;

--1
insert into temp(id, name) 
values(100,'�ƹ���');  --unique constraint (BITUSER.SYS_C007013) violated
                          --PK ���� ����
                          
--2
insert into temp(name)
values('������'); --ORA-01400: cannot insert NULL into ("BITUSER"."TEMP"."ID")
                   --PK ���� ����( null)

--��� ^^
--sql ���� , ��� (x)
--pl-sql (java ��� ó�� ���)
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
  regdate date default sysdate -- regdate  �÷��� �����͸� insert  ���� �ʾƵ� ,,,,,
);

insert into temp3(memberid, name, regdate)
values(100,'ȫ�浿','2019-09-27');

select * from temp3;
commit;

insert into temp3(memberid, name)
values(200,'������');

select * from temp3;
commit;

insert into temp3(memberid)
values(300);


select * from temp3;
commit;
--
--�ɼ� TIP
--1. �뷮 ������ �����ϱ�(INSERT)

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

--�䱸���� : temp4 ���̺� �ִ� ��� �����͸� temp6�� �ְ� �;��
--insert into ���̺��(�÷�����Ʈ)  select  ���� --values
--�� �÷������� Ÿ���� ��ġ

insert into temp5(num)
select id from temp4;
--values

select * from temp5;
commit;


--2. Insert
--������ (clone) insert
--���̺��� ���� ��Ȳ����  [���̺� �ڵ�����][�뷮 ������ ����]
--�� ���� ���� ���簡 �ȵǿ�

--emp >>  copyemp ���̺��� ����� ������ �Ȱ���
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

--������ �����ϰ� �����ʹ� �����ϰ� ���� �ʾƿ�
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
SET  (column1, column2, . . . . ) =   ( SELECT  column1,column2, . . .   subquery �ü� �ִ�
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

������ : CRUD �۾�

Create  : insert 
Read    : select
Update : update
Delete  : delete

C U D >> Ʈ����� ���� (commit , rollback)

--EMP ���̺�  (Oracle)
--Java 
--���� , ���� , ���� , ��ü��ȸ , ������ȸ(PK  where empno=7788)
--java �Լ� 5��

--public int insertEmp(Emp emp) {  insert into emp....     }
--public List<Emp> getEmpList(){  select * from emp  }
--public Emp getEmpListByEmpno(int empno) {  select ... where empno=7788 }

*/
--����Ŭ 11g �����÷�(���� �÷�)
--�÷� : ���� , ����  , ���� .....  >> �� , ��� 
--�÷� : ���� , ����  , ���� , �� , ���  �ڵ�ȭ
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

--�ǹ��� ���Ǵ� ������ �ڵ�
--��ǰ�� ���� (�԰���) �������� �б� (1~ 4�б�)
--20190101  ,  20190520  
create table vtable2(
 no number, --����
 p_code char(4), --��ǰ�ڵ�(A001 , B002)
 p_date char(8), --�԰���(20190909) --��¥ Ÿ�� ... �������� ... ���ڿ� �Լ� ��� 
 p_qty number, --����
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
--DDL ���̺� �ٷ�� 
--pdf 138 page (�� 9 �� ���̺�(TABLE) ���� )

--1. ���̺� �����ϱ�
create table temp6(
  id number
);

--2. ���̺� �����ߴµ� �÷� .... �߰��ϴ� ���
--���� ���̺� �÷� �߰��ϱ�
alter table temp6
add ename varchar2(20);

desc temp6;

--3. ���� ���̺� �ִ� �÷��� �̸� �߸�ǥ�� (ename -> username)
--���� ���̺� �ִ� ���� �÷��� �̸� �ٲٱ� ( rename)
alter table temp6
rename column ename to username;

desc temp6;

--4. ���� ���̺� �ִ� ���� �÷��� TYPE ����
--(modify)
alter table temp6
modify (username varchar2(2000));

desc temp6;

--5, ���� ���̺� �ִ� ���� �÷� ����
alter table temp6
drop column username;

desc temp6;

--6. delete : ���̺� ������ ����
-- ���̺� ó�� ����� ó�� ũ�� >> ������ ������ >> ������ ũ�� 
--ex) ó�� 1M >> 10���� >> 100M ---> 10�� ������ delete >> ���� ���̺� ũ�� >> 101M
--���̺� ������ ���� , [������ ũ��] ó�� ���·�
--truncate ( where ���� (x))
--ex) ó�� 1M >> 10���� >> 100M ---> 10�� ������ truncate >> ���� ���̺� ũ�� >>1M

--drop table temp6

--
--���̺� ���� �����ϱ�
--pdf 144 page
--������ ���Ἲ Ȯ��
--���� (constraint) insert , update  �ַ� ,,,,
/*
NOT NULL(NN) ���� NULL ���� ������ �� �����ϴ�. 

UNIQUE key(UK) ���̺��� ��� ���� [�����ϰ� �ϴ� ��]�� ���� ��(NULL �� ���) 
--unique ������ null ���� �� �ִ� >> null ���� ������ ���ϰ� �ҷ��� ( ename u , not null..)
--�÷��� ���� ��ŭ
a  u not
b  u not
c  u not


PRIMARY KEY(PK) �����ϰ� ���̺��� ������ �ĺ�(NOT NULL �� UNIQUE ������ ����) 
--not null �ϰ� unique  �� ����
--���̺� 1��  (�����÷��� ��� �ϳ��� : ����Ű)
--�ֹι�ȣ , �Խ��� �۹�ȣ , �й� , �ڵ��� ��ȣ
--index  �ڵ����� (���� �˻�)
--where boardid = 100

--��ȣ : ��ȭ�� ... 50�� ... �ְ� ... ��� ... �� ������ȣ  �� .... 
--��ȣ : 1000�� ...  
--��ȣ : ��� .... ��ȭå ī�װ� (����(������) , �ҳ⸸ȭ(������))
--�������� (1��) ... �� �� ��   �ٶ���  ...

--������ �� : �⵵(2000) ���� 3�� (�ּ�)

--������ : java : ��ġ (���� ....)

--index ���� (�ֱ������� ��������) ���  : DBA

FOREIGN KEY(FK) ���� ������ �� ������ �ܷ�Ű ���踦 �����ϰ� �����մϴ�. 
(���� ����) ���̺�� ���̺��� ����
:  EMP , DEPT  �������� �ʿ��� �� ������ (x)  ,,,�����ʹ� ���߾� ���Ҿ��



CHECK(CK) ���̾�� �ϴ� ������ ������(��κ� ���� ��Ģ�� ����
���� ���ϴ� ���� �ްڴ� (gender  �÷��� ������  '��'  , '��' �� �ްڴ�)
���� �׻� üũ �����͸� 
ex)  where gender in ('��' , '��')


5���� ������ ����� ����
1. ���̺��� �����Ҷ�  �ٷ� ���� (create table  �����ȿ���)
2. ���̺� ���� ���� (create table ���� ,,,,, ���Ŀ�  alter table add constraint ....  (�ڵ�ȭ�� ��)


*/
select* from user_constraints where table_name='EMP';

--���� ǥ���(����) (���� (x))
create table temp7
(
   --id number constraint pk_temp7_id primary key  --pk_temp7_id ���� (����)
   id number primary key,
   name varchar2(20) not null,
   addr varchar2(50)
);

--SYS_C007047  ���������� �����̸� SYS  ������ȣ  (�ý���)
--SYS_C007048
--���� ���ϴ� ��� �̸� ���� (full ǥ��)

select* from user_constraints where lower(table_name)='temp7';

insert into temp7(name, addr) values('ȫ�浿','����� ������'); --cannot insert NULL into ("BITUSER"."TEMP7"."ID")

insert into temp7(id, name, addr) values(10,'ȫ�浿','����� ������');

insert into temp7(id, name, addr) values(10,'������','����� ���ϱ�'); --"unique constraint (%s.%s) violated

--pK �Ǵٴ� �� (where id  ���� ����Ѵ�) - PK �ɸ�  �� �÷��� ���� �ڵ����� index  �˻� �ӵ� ���
select * from temp7 where id = 10;

commit;

--���̺� index ���� Ȯ���ϱ�
select * from user_indexes where table_name='TEMP7';

--���� ǥ��
create table temp8(
 id number constraint pk_temp8_id primary key,
 name varchar2(20) not null,
 jumin char(6) constraint uk_temp8_jumin unique, --not null  null �ߺ� ����
 --jumin char(6) not null constraint uk_temp8_jumin unique,
 addr varchar2(20)
)

select * from user_indexes where table_name='TEMP8';

insert into temp8(id, name, jumin, addr)
values(10,'ȫ�浿','123456','�����');

select * from temp8;
commit;


insert into temp8(id, name, jumin, addr)
values(10,'A','456789','�����');  --unique constraint (BITUSER.PK_TEMP8_ID) violated  (PK)


insert into temp8( name, jumin, addr)
values('A','456789','�����');     --cannot insert NULL into ("BITUSER"."TEMP8"."ID")


insert into temp8(id, name, jumin, addr)
values(20,'�ƹ���','123456','�����');  --unique constraint (BITUSER.UK_TEMP8_JUMIN) violated

insert into temp8(id, name, addr)
values(20,'�ƹ���','�����');

insert into temp8(id, name, addr)
values(30,'�߹�����','�����');   --unique (null �� ���� �ߺ� üũ ���� �ʾƿ�)

select * from temp8;
commit;

--���̺� ���� �Ŀ� ���� �ɱ�
create table temp9 (id number);

--���� ���̺� >>������ �ǽ� >> 10, 10 2�� >> PK  ���� (������ �˻�) (x) >> ������ ���� >> PK
alter table temp9
add constraint pk_temp9_id primary key(id);


--�ΰ� �÷��� ��� (1��)
--alter table temp9
--add constraint pk_temp9_id primary key(id,jumin);  �ߺ�Ű (����Ű)



select * from user_indexes where table_name='TEMP9';
select* from user_constraints where table_name='TEMP9';
desc temp9;

--ename �÷� �߰�
alter table temp9
add ename varchar2(20);

desc temp9;

--not null �߰��ϱ�
alter table temp9
modify(ename not null);

desc temp9;

--check
create table temp10(
 id number constraint pk_temp10_id primary key,
 name varchar2(20) not null,
 jumin char(6) constraint uk_temp10_jumin unique, --not null  null �ߺ� ����
 --jumin char(6) not null constraint uk_temp8_jumin unique,
 addr varchar2(20),
 age number constraint ck_temp10_age  check(age >= 19)       --where age >= 19 , gender in('��','��')
);


select* from user_constraints where table_name='TEMP10';

insert into temp10(id, name, jumin, addr , age)
values(100,'ȫ�浿','123456','�����',20);

select * from temp10;
commit;

insert into temp10(id, name, jumin, addr , age)
values(200,'������','789456','�����',15);
-- check constraint (BITUSER.CK_TEMP10_AGE) violated

commit;


---------------
--��������  >> ���̺�� ���̺���� ���� >> RDB
create table c_emp
as
    select empno, ename, deptno from emp where 1=2;
 
create table c_dept
as
   select deptno , dname from dept where 1=2;


select* from user_constraints where table_name='C_EMP';

select* from user_constraints where table_name='C_DEPT';

--����Ű (c_emp(deptno) �÷��� c_dept(deptno) �÷��� ���� �մϴ�
--c_dept(deptno) �÷��� c_emp(deptno) �÷��� ������ ���մϴ�

--2) ���� �۾��� 
alter table c_emp
add constraint fk_c_emp_deptno foreign key(deptno) references c_dept(deptno);

--������ ���ϴ� ���̺��ִ� �÷��� (�ſ��� ����)
--PK . Unique ����
--1. PK ����
--2.FK ����
--1)����
alter table c_dept
add constraint pk_c_dept_deptno primary key(deptno);

select* from user_constraints where table_name='C_EMP';

select* from user_constraints where table_name='C_DEPT';

insert into c_dept(deptno, dname) values(100,'�λ���');
insert into c_dept(deptno, dname) values(200,'������');
insert into c_dept(deptno, dname) values(300,'ȸ����');
commit;

select * from c_dept;
select * from c_emp; 

--��� �Ի� (���� Ű)
insert into c_emp(empno,ename,deptno)
values(1,'������',500);  --integrity constraint (BITUSER.FK_C_EMP_DEPTNO) violated

insert into c_emp(empno,ename)
values(1,'������');

select * from c_emp;  

--�츮 ȸ�� ���Ի���� ������ �μ��� ������   (not null  fk)
--�츮 ȸ�� ���Ի���� �μ��� �������� �Ȱ����� �ִ� 

insert into c_emp(empno,ename,deptno)
values(1,'�ƹ���',100); 
commit;

--�ΰ��� ���迡�� �� , �� ���踦 �ľ��ϸ� ...
--fk_c_emp_deptno ���迡�� �θ� :  ����  PK dept     FK emp �� 
--master(dept)  - child (emp)


select * from c_emp;

delete from c_dept where deptno=200; -- ���� 

delete from c_dept where deptno=100; 
--100����
--c_emp ���̺��� 100 �O���� �����ϰ� ..... c_dept ����


/*
column datatype [CONSTRAINT constraint_name]        
REFERENCES table_ name (column1[,column2,..] [ON DELETE CASCADE]) 


column datatype, . . . . . . . , [CONSTRAINT constraint_name] 
FOREIGN KEY (column1[,column2,..])        
REFERENCES table_name  (column1[,column2,..] [ON DELETE CASCADE]


[ON DELETE CASCADE]) : �θ��� ���̺�� ������ ���� �ϰڴ�
--delete from c_dept where deptno=100;  ��Ģ�� ���� ...�Ұ���
--[ON DELETE CASCADE])  �ɷ��ִٸ�
--delete from c_dept where deptno=100;  ����
--c_emp deptno 100�� ��� ��������� ���� ���� .....

*/

--���� 12�� ~ 14��
--DDL END--

create table department( --�а����̺�
  departmentno number, --�а���ȣ
  departmentname varchar(40) not null --�а��� null X
);
 
create table grade( --�������̺�
  no number, --�й�
  name varchar2(20) not null, --�̸� null X
  korean number default 0, --���� null�����, default 0
  english number default 0, --���� null�����, default 0
  math number default 0, --���� null�����, default 0
  sum number GENERATED ALWAYS as (korean+english+math) VIRTUAL, --���� �����÷�
  avg number GENERATED ALWAYS as ((korean+english+math)/3) VIRTUAL, --��� �����÷�
  departmentno number --�а��ڵ�
);
 
alter table grade --�������̺� �й� �ߺ� X, null X
add CONSTRAINT pk_grade_no primary key(no);
 
alter table department --�а����̺� �а��ڵ� �ߺ�X, null X
add constraint pk_department_departmentno primary key(departmentno);
 
alter table grade --�������̺��� �а��ڵ�� �а����̺��� �а��ڵ带 �����Ѵ�.
add constraint fk_grade_departmentno foreign key(departmentno) references department(departmentno);
 
select * from user_constraints where table_name='GRADE';
select * from user_constraints where table_name='DEPARTMENT';
 
insert into department(DEPARTMENTNO,DEPARTMENTNAME) values (100,'��ǻ�Ͱ���');
insert into department(DEPARTMENTNO,DEPARTMENTNAME) values (200,'����ȸ��');
insert into department(DEPARTMENTNO,DEPARTMENTNAME) values (300,'����â��');
commit;
 
insert into grade(no,name,korean,math,departmentno) values(1010,'ȫ�浿',80,70,100);
insert into grade(no,name,departmentno) values(2020,'������',300);
insert into grade(no,name,english,math,departmentno) values(3030,'�ƹ���',80,100,200);
 
commit;
 
select e.no as "�й�", e.name as "�̸�", e.sum as "����", e.avg as "���", e.departmentno as "�а��ڵ�", d.departmentname as "�а���"
from grade e join department d
on e.departmentno = d.departmentno;

--
--VIEW (�������̺�)
--pdf 192page
--�������̺� (������ (x) ... ��� �޸𸮿� ....)
--View ��ü  (create ....
--create view ���̸� as [view ���� ��� (select ���� )]
--view �� ���̺�ó�� ��� ���� (���� ���̺�) => ���� emp , dept ���� ���̺�� ������ ����
--view ��  �޸𸮻󿡸� �����ϴ� ���� ���̺� (subquery -> in line view -> ���� ���̺�ó�� ���)
--view sql ���� ���

--����
--�Ϲ����̺�� ����    from ��  where ��
--DML >> view ���ؼ� �������� ���̺� ���� .. insert  , update , delete  ����

--view ����
--�������� ����(join , subquery) ������ ����
--������ ���� �ܼ�ȭ
--���� (���� ���� ó��) 



create view v_001
as
    select empno, ename from emp;


select * from v_001;  --������ �� ������ �ִ� sql ������ ����
--view ���� �ִ� �����Ϳ� ���ؼ� DML ����   ������ ����

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






--���࿡ �μ��� ��� ������ ������ �ִ� ���̺��� �ִٸ� ...

--******  �� �̰� ���̺��� ������ ���� ���ٵ�*************************************
--View  �� ����� ......

--in - line - view
--�ڱ� �μ��� ��� ���޺��� �� ���� ������ �޴� ����� ��� , �̸� , �μ���ȣ  , �μ��� ��� ������ ����ϼ���
select e.empno , e.ename , e.deptno , e.sal , trunc(s.avgsal,0)
from emp e join (select deptno , avg(sal) as avgsal from emp group by deptno) s
on e.deptno = s.deptno
where e.sal > s.avgsal;

select e.empno , e.ename , e.deptno , e.sal , trunc(s.avgsal,0)
from emp e join v_003 s
on e.deptno = s.deptno
where e.sal > s.avgsal;

--JOIN  ó�� ����  ���ϴ� ���� ���̺�� �����Ѵٸ� ....... view
/*
CREATE  [OR  REPLACE]  [FORCE | NOFORCE]  VIEW view_name [(alias[,alias,...])] 
AS Subquery 
[WITH  CHECK  OPTION  [CONSTRAINT  constraint ]] 
[WITH  READ  ONLY]


OR  REPLACE  �̹� �����Ѵٸ� �ٽ� �����Ѵ�. 

FORCE   Base Table ������ ������� VIEW �� �����. 

NOFORCE  �⺻ ���̺��� ������ ��쿡�� VIEW �� �����Ѵ�. 

view_name  VIEW �� �̸� 
Alias   Subquery �� ���� ���õ� ���� ���� Column ���� �ȴ�. 
Subquery  SELECT ������ ����Ѵ�. 

WITH CHECK OPTION VIEW �� ���� �׼��� �� �� �ִ� �ุ�� �Է�,���ŵ� �� �ִ�.  

Constraint  CHECK OPTON ���� ���ǿ� ���� ������ �̸��̴�. 

WITH READ ONLY  �� VIEW ���� DML �� ����� �� ���� �Ѵ�. 
 
*/
--������ ���� view ����
--create or replace v_�̸�  (overwrite)

create  or replace view v_004
as
    select empno , ename ,sal from emp

drop view v_004;


create or replace view v_emp
as
    select empno, ename , deptno from emp where deptno=20

select * from v_emp;

select * from v_emp where deptno=10;

--view ���� ���̺� DML(insert , update, delete)
--view  ���ؼ� �ٶ� �� �ִ� �����Ϳ� ���ؼ� ����
--DML �۾� ���� ���̺�� �۾��� view

select * from v_emp;

delete from v_emp;

select * from emp where deptno=20; --������ view ������ �ִ� ���̺� ���� ����

rollback;

--�Ʒ� �����ʹ� view �� ���� �����
update v_emp
set ename = 'AAA'
where  deptno=30;

--1. 30�� �μ� ������� ����, �̸�, ������ ��� VIEW�� ������.
CREATE OR REPLACE  VIEW VIEW100
AS
  SELECT JOB, ENAME, SAL
  FROM EMP
  WHERE DEPTNO=30
 
SELECT * FROM VIEW100
 
 
 
--2. 30�� �μ� �������  ����, �̸�, ������ ��� VIEW�� ����µ�,
-- ������ �÷����� ����, ����̸�, �������� ALIAS�� �ְ� ������
-- 300���� ���� ����鸸 �����ϵ��� �϶�.
 
CREATE OR REPLACE VIEW  VIEW101 ( ����, ����̸� ,���� )
AS
 SELECT JOB , ENAME , SAL
 FROM EMP
 WHERE DEPTNO=30 AND SAL > 300;
 
SELECT * FROM VIEW101;
 
--3. �μ��� �ִ����, �ּҿ���, ��տ����� ��� VIEW�� ������.
CREATE OR REPLACE VIEW  VIEW102
AS
 SELECT DEPTNO, MAX(SAL) AS "�ִ����",
  MIN(SAL) AS "�ּҿ���",
  AVG(SAL) AS "��տ���"
 FROM EMP
 GROUP BY DEPTNO
 
 
SELECT * FROM VIEW102;
       
--4. �μ��� ��տ����� ��� VIEW�� �����, ��տ����� 2000 �̻���
-- �μ��� ����ϵ��� �϶�.
--from ���� => where
--group by ���� => having
 
CREATE OR REPLACE VIEW VIEW103
AS
 SELECT DEPTNO, AVG(SAL) AS "��տ���"
 FROM EMP
 GROUP BY DEPTNO
 HAVING AVG(SAL) >=2000;
 
select * from view103 
----------------------------------------
SELECT v.deptno,v.��տ��� , d.dname
FROM view103 v JOIN dept d
ON v.deptno = d.deptno;
-----------------------------------------
 
--5. ������ �ѿ����� ��� VIEW�� �����, ������ MANAGER��
-- ������� �����ϰ� �ѿ����� 3000�̻��� ������ ����ϵ��� �϶�.
 
CREATE OR REPLACE VIEW VIEW104
AS
 SELECT JOB, SUM(SAL) AS "�ѿ���"
 FROM EMP
 WHERE JOB!='MANAGER'
 GROUP BY JOB
 HAVING SUM(SAL)>=3000;
 
SELECT * FROM VIEW104;


--�� 11 �� SEQUENCE  pdf 185page
--������ ��ü
--���� ���� ( ä����)
--�ڵ����� ��ȣ�� �����ϴ� ���� ��ü


/*
CREATE  SEQUENCE  sequence_name  
[INCREMENT  BY  n] 
[START  WITH  n]  
[{MAXVALUE n | NOMAXVALUE}] 
[{MINVALUE n | NOMINVALUE}] 
[{CYCLE | NOCYCLE}] 
[{CACHE | NOCACHE}]; 

sequence_name  SEQUENCE �� �̸��Դϴ�. 
INCREMENT  BY  n ���� ���� n ���� SEQUENCE ��ȣ ������ ������ ����. 
    �� ���� �����Ǹ� SEQUENCE �� 1 �� ����. 

START  WITH  n  �����ϱ� ���� ù��° SEQUENCE �� ����. 
    �� ���� �����Ǹ� SEQUENCE �� 1 �� ����. 

MAXVALUE n  SEQUENCE �� ������ �� �ִ� �ִ� ���� ����. 

NOMAXVALUE   ���������� 10^27 �ִ밪�� ����������-1 �� �ּҰ��� ����. 

MINVALUE n  �ּ� SEQUENCE ���� ����. 

NOMINVALUE  ���������� 1 �� ����������-(10^26)�� �ּҰ��� ����. 

CYCLE | NOCYCLE  �ִ� �Ǵ� �ּҰ��� ������ �Ŀ� ��� ���� ������ ���� ���θ� 
    ����. NOCYCLE �� ����Ʈ. 

CACHE | NOCACHE  �󸶳� ���� ���� �޸𸮿� ����Ŭ ������ �̸� �Ҵ��ϰ� ���� 
    �ϴ°��� ����. ����Ʈ�� ����Ŭ ������ 20 �� CACHE. 
*/

--�Խ���
/*
 create table board(
   boardid number primary key,
   title varchar2(50)
)

boardid  �۹�ȣ�� >> �ߺ��� ,  null (x)
���� �Ǽ� ���� �����͸� ���� �� ���� ��

where boardid = 10 ... �ϳ��� row return �ϴ� ���� ����

����)
insert into board ....    boardid  1  ,
insert into board ....    boardid  2  ,
insert into board ....    boardid  3  ,
*/

create table kboard(
  num number constraint pk_kboard_num primary key,
  title varchar2(50)
)

--ó�� ��
--num =1
--���� ��
--num =2


--��� -1  (0)
insert into kboard(num , title)
values((select nvl(max(num),0) + 1 from kboard),'ó��');

insert into kboard(num , title)
values((select nvl(max(num),0) + 1 from kboard),'�ι�');

insert into kboard(num , title)
values((select nvl(max(num),0) + 1 from kboard),'����');

select * from kboard;

delete from kboard where num=1;

insert into kboard(num , title)
values((select nvl(max(num),0) + 1 from kboard),'�׹�');

select * from kboard;


--��� -2
create table tboard(
  num number constraint pk_tboard_num primary key,
  title varchar2(50)
)

insert into tboard(num , title)
values((select count(num) + 1 from tboard),'ó��');

insert into tboard(num , title)
values((select count(num) + 1 from tboard),'�ι�');

insert into tboard(num , title)
values((select count(num) + 1 from tboard),'����');
commit;

--������ 
--���� -> insert ���� ��ȣ �浹  > PK
delete from tboard where num=1;
select * from tboard;



insert into tboard(num , title)
values((select count(num) + 1 from tboard),'�׹�');


select * from kboard;
select * from tboard;

---��ȣ�� ���� �ߺ����� �ȳ����� �������� �� ����

create sequence seq_num;

--���� ������ ������ ��ü Ȯ��
select * from user_sequences;


/*
NEXTVAL �� CURRVAL �ǻ翭 
��) Ư¡
1) NEXTVAL �� ���� ��� ������ SEQUENCE ���� ��ȯ �Ѵ�. 
2) SEQUENCE �� ������ �� ����, �ٸ� ����ڿ��� ������ ������ ���� ��ȯ�Ѵ�.
3) CURRVAL �� ���� SEQUENCE ���� ��´�. 
4) CURRVAL �� �����Ǳ� ���� NEXTVAL �� ���Ǿ�� �Ѵ�. 
*/ 

--��ȣ ���� �ϱ�
select seq_num.nextval from dual;

--���� Ȯ���ϱ� ���簪 (������ ����� ���� Ȯ��)
select seq_num.currval from dual;

 create table sboard(
  num number constraint pk_sboard_num primary key,
  title varchar2(50)
)

insert into sboard(num, title)
values(seq_num.nextval , 'ó��');

insert into sboard(num, title)
values(seq_num.nextval , '�ι�');

insert into sboard(num, title)
values(seq_num.nextval , '����');

select * from sboard;

delete from sboard where num=8;

insert into sboard(num, title)
values(seq_num.nextval , '�׹�');

rollback;

commit;

/*
�ǻ� �÷�(Pseudo-column)�� ���̺��� [�÷�]ó�� ���������� 
������ ���̺� ������� �ʴ� �÷��� �ǹ��Ѵ�.
SELECT �������� �ǻ��÷��� ����� �� ������, DML ���忡���� �� �� ����.
���������� ����ϴ� NEXTVAL�̳� CURRVAL �� �ǻ� �÷��� �����̸�, 
��ǥ���� ���� ROWNUM�̴�.
*/


--�Խ��� 10��
--���� �Խ���, �����Խ��� , ��������
--3���� �Խ��� �۹�ȣ�� ���� ���� �ϰ� �ʹ�
--sequence 3��
create sequence board_seq;
create sequence board_seq2;
create sequence board_seq3;
--1. q_num
--2. f_num
--3. k_num
insert into qboard() values(board_seq.nextval ,,,

insert into fboard() values(board_seq2.nextval ,,,

insert into kboard() values(board_seq3.nextval ,,,

----�Խ��� 10��
--���� �Խ���, �����Խ��� , �������� �ϳ��� �۹�ȣ ����
--sequence 1��
create sequence board_seq;


insert into qboard() values(board_seq.nextval ,,,

insert into fboard() values(board_seq.nextval ,,,

insert into kboard() values(board_seq.nextval ,,,

--1. sequence rollback ����  �ʴ´�
select * from sboard;

insert into sboard(num, title)
values(seq_num.nextval , '�ȳ�');

rollback;


--TIP)
--ms-sql
-- create table board (boardnum int identity(1,1) , title varchar(20))
--insert into board(title) values('MS');

--���� : 2012���� : ����Ŭ ó�� sequence

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
�Խ��� �۹�ȣ
num
1
2
4
6
10
15

[�ֽű� ��]���� [���]�� ���� �ּ���
�Խ��� ����� 
select * from board order by num desc 
*/
/*
�ǻ� �÷�(Pseudo-column)�� ���̺��� [�÷�]ó�� ���������� 
������ ���̺� ������� �ʴ� �÷��� �ǹ��Ѵ�.
SELECT �������� �ǻ��÷��� ����� �� ������, DML ���忡���� �� �� ����.
���������� ����ϴ� NEXTVAL�̳� CURRVAL �� �ǻ� �÷��� �����̸�, 
��ǥ���� ���� ROWNUM�̴�.
*/
--������(sequence , rownum)
--rownum �ǻ�Ŀ�� 
--rownum : ������ ���̺� �������� �ʴ� �÷�(�� ��ȣ)
--rowid : �ּҰ� (���� ������ ����Ǵ� ���� (�޸�) �ּҰ�) 

select empno, ename from emp;

select rownum as ���� , empno, ename from emp;

--Top-n ���� ��� ...
--���̺��� ���ǿ� �´� ����  Top ���ڵ�(row)  n  �� ����
--�ٰ� : ���ĵ� ������    ���� ���� ����� .... 

select * from emp order by sal desc;


--Top-n
-- ms-sql :  select top 10 , * from emp order by sal desc

--oracle : rownum(�ǻ��÷�)

--1. ���������� �����
--2. ������ ����(rownum)  �ο��ϰ� ����  (where rownum <= 10


--1.  ���� (��ȣ)
select rownum as "num", e.*
from (
  select *
  from emp
  order by sal desc ) e;

--2 ����  10��

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
--SQL 1�� �н� --END 
-------------------------------------
--3�� ������Ʈ ���� ����
--SQL 2�� �н� 
--�������
--PL-SQL : ���� , ��� , Ŀ�� , �Լ� , ���ν��� , Ʈ���� , ������


create view bitemp
as
    select empno , ename , job from emp;
    
   select * from bitemp; 
    
SELECT *  FROM USER_VIEWS;
    
    
    
    
    
    
    
    
    


