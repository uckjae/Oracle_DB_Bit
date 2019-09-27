SELECT [DISTINCT]  {*, column [alias], . . .}   //[]������������ �ǹ� {}���� ���� �ݵ�� �־���Ѵ�
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

Select * From emp;
SELECT * FROM EMP;--������ ��ҹ��� �������� �ʾƿ�

--2.Ư�� �÷� ������ �����ϱ�
SELECT empno, ename, job, sal from emp;

select empno from emp;

select hiredate, deptno from emp;

--3. �÷��� ����Ī(alias) �ο��ϱ�

select empno ���, ename �̸�
from emp;

--select empno �� ��, ename �̸� from emp;
select empno "��  ��", ename "�� ��"
from emp;

--����(ansi ǥ��) >>����
select empno  as "��  ��", ename as "�� ��"
from emp;

-- Oracle : ���ڿ� ������ (�����ϰ� ��ҹ��� ����)
--������ : a, A �ٸ� ���� ���
--���ڿ�(����) ������ : '����'
select * from emp where ename='king';
select * from emp where ename='KING';

--Oracle : ������(���� ������) >> || >> 'hello'||'world'>> ���� >>'helloworld'
--java : + ���, ����
--java : 10+10(���)
--java: "A" + "B"(����)
--TIP) ms-sql: +(����,����)

select '����� �̸��� ' || ename || '�Դϴ�' as "ename"
from emp;

--java : class Emp{private int empno;}
--POINT : ����Ŭ�� �÷��� Ÿ�� ������ ���´�
--���� ���� ������ �ִ� emp ������ ���� ���
desc emp;--emp �÷��� Ÿ������

select empno + ename as "����" -- �������>> "invalid number"
from emp;

select empno || ename as "����"--���� (���������� �ڵ� ����ȯ(����>>����) to_char()
from emp;

--����� �츮ȸ�翡 ������ ��� �ֳ�
--�ߺ� ������ ���� (Ű����): distinct
select distinct job from emp;

select distinct deptno from emp;

--distinct ���� (�ø��� 2�� �̻�) -- grouping (�׸� : �ٷ���)
select distinct job, deptno from emp;

select DISTINCT job, deptno from emp order by job;

SELECT DISTINCT deptno, job from emp ORDER by deptno;

--����Ŭ ���(SQL)
--java ���� ���� (������)
--����Ŭ�� ������ java �� ���� ����
--java (% ������) >> ����Ŭ���� [ % ] �˻������ڿ����� Ȱ�� >> ������ �Լ��� ��������
--Oracle ( +, - ,* , / ...) + ������ (Mod()�Լ�)

--������̺��� ����� �޿��� 100�޷� �λ��� ����� ����ϼ���
--���� ����( + ) �÷��� Ÿ��: number
desc emp;
select empno, ename , sal, sal+100 as "�λ�޿�" 
from emp;

select 100 + 100 from dual; --������ TEST dual
select 100 || 100 from dual; -- || ���տ����� (���� >> ���� �ڵ�����ȯ)
select '100' + 100 from dual; -- + ������� ('100' >> ���� ����ȯ)
select 'A100' + 100 from dual; --Error "invalid number"

--�񱳿�����
-- >, < , <= ...
--java ����(==) , �Ҵ�(=)
--javascript ����(===)
--Oracle ����(=) (!=)

--�������� and or
/*
SELECT [DISTINCT]  {*, column [alias], . . .}   //[]������������ �ǹ� {}���� ���� �ݵ�� �־���Ѵ�
FROM  table_name   
[WHERE  condition]   
[ORDER BY {column, expression} [ASC | DESC]]; 
*/

--������(���ϴ� row �� ������ ���ڴ�
--�������: select ��, from ��, where ��
select *         --3
from emp         --1
where sal>=3000; --2

--�̻�, ���� (=����)
--�ʰ�, �̸�

--����� 7788���� ����� ���, �̸� ,����, �Ի����� ����ϼ���
select empno, ename, job ,hiredate 
from emp 
where empno=7788; 

--����� �̸��� KING �� ����� ���, �̸� ,�ݿ� ������ ����ϼ���
select empno , ename, sal
from emp
where ename = 'KING';

--�޿��� 2000�޷� �̻��̸鼭 ������ manager �� ����� ��� ������ ����ϼ���
select *
from emp
where sal>2000 and job='MANAGER';

--�޿��� 200�޷� �̻��̰ų� ������ manager�� ����� ��� ������ ���
select *
from emp
where sal>2000 or job='MANAGER';

--����Ŭ ��¥
--DB������ ��¥
--�ý��� : ��¥ ������ �ִ� >> sysdate

select sysdate from dual;
--�Խ��� �۾��� : insert into board(writer, title, content, regdate)
--              values('ȫ�浿','�氡�氡','�ǰ��ؿ�',sysdate)
--TIP ms-sql >> select getdate()

select hiredate from emp;
desc emp; --DATE
--����Ŭ [�ý�������]�� ��� ���̺����� ����
--ȯ�漳��
select * from SYS.NLS_SESSION_PARAMETERS;
--NLS_LANGUAGE	KOREAN
--NLS_DATE_FORMAT	RR/MM/DD -- ���� ����
--NLS_DATE_LANGUAGE	KOREAN
--NLS_TIME_FORMAT	HH24:MI:SSXFF
select * from SYS.NLS_SESSION_PARAMETERS where parameter = 'NLS_TIME_FORMAT';
--POINT
--�������ؿ� ���� ���� ����(DBA)
--���� ������ �����(session) �������� ����
--�ٸ� ������ bituser�� �����ϸ� ��¥���� ���� ..�״��

alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS'; --����
select * from SYS.NLS_SESSION_PARAMETERS where parameter = 'NLS_DATE_FORMAT';

--NLS_DATE_FORMAT YYYY-MM-DD HH24:MI:SS
select sysdate from dual; --2019-09-24 11:51:38
select hiredate from emp; --1980-12-17 00:00:00

select *
from emp
where hiredate='1980-12-17'; --��¥ ���� ǥ��(���ڵ���)
select *
from emp
where hiredate='1980/12/17';--��¥ (-������, /������)

select * from emp;
select * 
from emp
where hiredate='80-12-17';--��¥������ ���� (��ȸ �ȵǿ�)
--RR-MM-DD >> YYYY-MM-DD

--����� �޿��� 2000�޷� �̻��̰� 4000�޷� ������ ��� ����� ���� ���

select *
from emp
where 2000<=sal and sal<=4000;
--������ : �÷��� between A and B (=����)
select *
from emp
where sal between 2000 and 4000;

--����� rmqdurk 2000�ʰ� 4000�̸�
select *
from emp
where 2000<sal and sal<4000;

--�μ���ȣ�� 10�� �Ǵ� 20�� �Ǵ� 30���� ����� ��� �̸� �޿� �μ���ȣ�� ����ϼ���
select *
from emp
where deptno = 10 or deptno=20 or deptno=30
order by deptno;

--IN ������ (���� or ���� or ...)
select *
from emp
where deptno in (10,20,30)
order by deptno;

--�μ���ȣ�� 10�� �Ǵ� 20���� �ƴ� ����� ���, �̸�, �޿� �μ���ȣ ���

select empno, ename, sal, deptno
from emp
where deptno !=10 and deptno != 20;

--NOT IN ������

select empno, ename, sal, deptno
from emp
where deptno not in(10,20);

--POINT : ���� ����(������ ����) >> null
--NULL (�ʿ��)
--java : class Member{private String userid...}

create table member(
userid VARCHAR2(20) not null,
name varchar2(20) not null,
hobby varchar2(20) --default >> null (null�� ���):�ʼ� �Է� ������ �ƴϾ�
);
select * from member;
insert into member(userid,name) values('hong','ȫ�浿');
select * from member;
insert into member(userid,hobby) values('kim','��');--����
--ORA-01400: cannot insert NULL into ("BITUSER"."MEMBER"."NAME")
insert into member(userid,name,hobby) values('park','�ڱ�','�౸');
select * from member;

--�ǹݿ�
commit;
select * from member;

--������ ���� �ʴ� ��� ����� ������ ����ϼ���
select * 
from emp
where comm is null;

--null�� �ٸ� ������ (is null)
--select * from emp where comm = null; --(x)
select * from emp where comm is null;

--������ �޴� ��� ����� ������ ����ϼ���
select *
from emp
where comm is not null
order by comm;

--������̺��� ���, �̸�,�޿�,����,�ѱ޿��� ����ϼ���
--�ѱ޿�(�޿�+����)
select empno, ename, sal, comm, sal+comm as "�ѱ޿�"
from emp;

--POINT(null)
--**null���� ��� ������ �װ����: null
--nvl()
--null�� ������ ��ü������ �ٲپ��: nvl(),vnl2()
--ms-sql:convert()
--my-sql:IFNULL()
select 1000+null from dual;

select 1000+nvl(null,111) from dual;

select 'A'||null from dual;

select comm,nvl(comm,0) from emp;

select empno, ename, sal, comm, sal+nvl(comm,0) as "�ѱ޿�"
from emp;

--����� �޿��� 1000�޷� �̻��̰� ������ �����ʴ� ����� �̸�,����,�޿�,������ ����ϼ���

select ename, job, sal, comm
from emp
where comm is null and 1000<=sal;

--------------------------------------
--DQL (data query language): SELECT
--DDL : create, alter ,drop (��ü ���� ���� ����)

create table board(
  boardid number not null,--�ʼ��Է�
  title varchar2(20) not null,--�ʼ��Է�(������, Ư��,����:1BYTE, �ѱ�2BYTE)
  content varchar2(2000) not null,--�ʼ��Է�
  hp varchar2(20)
);

--DML(������ ���۾�) : insert, update, delete
--�۾��ÿ��� [���� �ݿ�]�̳� ����ָ��� ����(commit,rollback) �ݵ�� ���
insert into board(boardid,title,content)
values(100,'����Ŭ','������');

select * from board;

commit;--�ǹݿ�

insert into board(boardid,title,content)
values(100,'�ڹ�','�׸���...');

SELECT * FROM board;
rollback;

--insert, update, delete �۾� ����Ŭ (������ commit, rollback �۾� �ݵ��)
--ms-sql (Auto commit) >> default commit; begin tran ~~ commit or rollback

select * from board;

select boardid, hp, nvl(hp,'�ڵ��� �����') as "hp"
from board;

--nvl �Լ��� ����, ��¥, ���� ��� ���밡���ϴ�

--���ڿ��˻�
--�ּҰ˻�:'����' �˻��ϸ� ���� ���ڿ� ����ִ� �ּҰ� �� ���Ϳ�
--���ڿ� ���� �˻�(LIKE ������)

--like ������(���ϵ� ī�� ���� (%: ��� ��, _:�ѹ���)����

select * 
from emp
where ename like '%A%';--A�� ����ִ� ��� �̸� �˻�

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

--����Ŭ ���� (regexp_like) ���� ���� �˻�
--select * from emp where regexp_like (ename,����ǥ����);
--����Ŭ ����ǥ����� �˻� ���� ����� (���� 3��): �߰�������Ʈ_�ݿ�

--������ �����ϱ�
--order by �÷���(����,����,��¥) asc or desc
--��������: asc ������(default)
--��������: desc ������

select * 
from emp
order by sal;--asc �޿��� ���� ������

select * 
from emp 
order by sal asc;

--�޿��� ���� �޴� ������ �����͸� �����ϼ���
select *
from emp
order by sal desc;

select *
from emp
order by ename;--���ڿ��� ����

--�Ի����� ���� ���� ������ ���� ���,�̸�,�޿�,�Ի����� ����ϼ���
--�ֱٿ� �Ի��� ���...

select empno,ename,sal,hiredate
from emp
order by HIREDATE desc;
/*
SELECT   3
FROM     1
WHERE    2
ORDER BY 4 
*/

--����: MANAGER���� ���, �̸�, �޿�, ����, �Ի����� �Ի����� �ֱ��μ����� ����
--������̺��� ������ MANAGER�� ��� �߿� �Ի����� ���� ���� ������ �����ؼ� ���,�̸�,�޿�,����,�Ի��� ���
--���������� ������ ����
SELECT empno, ename,sal,job,hiredate
from emp
where job='MANAGER'
ORDER by HIREDATE desc;

--����
SELECT deptno, job
from emp
order by DEPTNO desc, job asc;--����2�� (grouping)

--������
--������(union) : ���̺�� ���̺��� �����͸� �Ϻ��� �������� ��(�ߺ����� ����)
--������(union all): �ߺ��� ���

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

--union ��Ģ
--1.�����Ǵ� �÷��� Ÿ���� ����
select empno, ename from emp
UNION
select dname,deptno from dept;--(x)

select empno,ename from emp
union
select deptno,dname from dept;

--2.�����Ǵ� �÷��� ���� ����(null ������)
select empno,ename,job,sal from emp
union
select deptno,dname,loc,null from dept;

--����Ŭ �Լ�(pdf 48 page)
/*
������ �Լ�
1) ������ �Լ� : ���ڸ� �Է� �ް� ���ڿ� ���� �� ��θ� RETURN �� �� �ִ�. 
2) ������ �Լ� : ���ڸ� �Է� �ް� ���ڸ� RETURN �Ѵ�. 
3) ��¥�� �Լ� : ��¥���� ���� �����ϰ� ���ڸ� RETURN �ϴ� MONTHS_BETWEEN �Լ��� �����ϰ� ��� ��¥ ���������� ���� RETURN �Ѵ�. 
4) ��ȯ�� �Լ� : � ���������� ���� �ٸ� ������������ ��ȯ�Ѵ�. 
5) �Ϲ����� �Լ� : NVL, DECODE 
*/
--���ڿ� �Լ�
select initcap('the super man') from dual;

select lower('AAA'), UPpER('aaa') from dual;

select ename,lower(ename) as "enmae" from emp;

select* from emp where lower(ename) = 'king';

--������ ����(length)
select length('abcd') from dual;
select length('ȫ�浿�ٺ�') from dual;
select length('ȫ �� ��') from dual;

--���տ����� ||
--���� �Լ�
select 'a'||'b'||'c' from dual;

select concat('a','b') from dual;

select concat(ename,job) from emp;
select ename||' ' ||job from emp;

--�κй��ڿ� ����
--java(substring)
--oracle(substr)

select substr('ABCDE',2,3) from dual;--BCD
select substr('ABCDE',1,1) from dual;--�ڱ��ڽ� A
select substr('ABCDE',3,1) from dual;

select substr('ABCDE',3) from dual;
select substr('ABCDE',-2,1) from dual;

/*
������̺��� ename �÷� �����Ϳ��� ���ؼ� ù���ڴ� �ҹ��ڷ� ������ ���ڴ� �빮�ڷ� ����ϵ�
�ϳ��� �÷������ͷ� ����ϼ���
�÷��� ����Ī��: fullname
ù���ڿ� ������ ���� ���̿� ���� �ϳ�

*/
select lower(substr(ename,1,1))||' '||upper(substr(ename,2)) as "fullname"
from emp;

--lpad, rpad(ä���)

select lpad('ABC',10,'*') from dual;

select rpad('ABC',10,'#') from dual;

--Quiz
--����� ���:hong1006
--ȭ�鿡 ho******�� ����ϰ� �;��

select rpad(substr('hong1006',1,2),length('hong1006'),'*') from dual;

--emp ���̺��� ename �÷��� �����͸� ����ϴ� �� ù�۸� ����ϰ� �������� *�����

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
--��°��
--100: 123456-*******
--����Ī jumin

select id, rpad(substr(jumin,1,7),length(jumin),'*') as "jumin"
from member2;

--rtrim �Լ�
--[������ ����] ������
select rtrim('MILLER','ER') from dual;
--ltrim �Լ�
select ltrim('MILLLLLLER','MIL') FROM dual;

--ġȯ�Լ�
select ename,replace(ename,'A','�Ϳ�') from emp;

--[���ڿ��Լ� END]

--[�����Լ�]
--round(�ݿø� �Լ�)
--trunk(�����Լ�)
--������ �Լ� mod()

-- -3 -2 -1 0 1 2 3

select round(12.345,0) as "r" from dual;--12
select round(12.567,0) as "r" from dual;--13
select round(12.345,1) as "r" from dual;--12.3
select round(12.345,2) as "r" from dual;--12.35
select round(12.345,-1) as "r" from dual;--10

--trunc(�ݿø� ó������ �ʾƿ�)

select trunc(12.345,0) as "r" from dual;--12
select trunc(12.567,0) as "r" from dual;--13
select trunc(12.345,1) as "r" from dual;--12.3
select trunc(12.345,2) as "r" from dual;--12.35
select trunc(12.345,-1) as "r" from dual;--10

--������ 12/10 from dual;--12
select 12/10 from dual;
slect mod(12,10) from dual;
slect mod(0,0) from dual;'
--[���� �Լ� END]

--[��¥�Լ�]
--syndate
alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';
select hiredate from emp;

--DATE+Number >> DATE
--DATE-number >> DATE
--DATE-DATE >> Number(�ϼ�)

--��¥(round,trunc)

select months_between('2019-02-27','2010-02-27') from emp;

select months_between(sysdate,('2010-02-27')) from emp;

select to_date('2015-01-01') + 1000 frmo dual;

--Quiz 

select ename,hiredate,trunc((sysdate-hiredate)/31,0) as "�ټӿ���",trunc(months_between(sysdate,hiredate),0) as "�ټӿ���2" from emp;

--��ȯ�Լ�
--Oracle:����,����,��¥ ������
--to_char(): ����(10000)->���ڷ�($10000)(100,000),��¥(1900-01-01')->����(1900��01��01��)
--to_date(): ���� -> ��¥ >> select '2019-12-12' >> to_date('2019-12-12')
--to_number():����->����(�ڵ�����ȯ)
select '100' + 100 from dual;--������ ����
select to_number('100') + 100 from dual;

--Quiz
--�Ի��� 12���� ������� ��� , �̸�, �Ի���, �Ի�⵵ �Ի���� ����ϼ���

select empno, ename, hiredate, to_char(hiredate,'YY') as "�Ի�⵵",to_char(hiredate,'MM') as "�Ի��"
from emp
where to_char(hiredate,'MM')=12;

select *
from emp;

select to_char(sal,'$999,999') as "sal"
from emp;

select * from employees;

select last_name || first_name as "fullname", to_char(hire_date,'YYYY-MM-DD') as "�Ի���",
to_char(salary*12,'$999,999,999') as "����", to_char(salary*12*1.1,'$999,999,999') as "�λ�� ����"
from employees
where to_char(hire_date,'YYYY')>=2005
order by "����" desc;