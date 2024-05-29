show tables;

create table member(
	idx int not null auto_increment,					/* 고유번호 */
	name varchar(10) not null,								/* 회원 이름 */
	mid varchar(10) not null,									/* 회원 아이디 */
	pwd varchar(100) not null,								/* 회원 비밀번호 */
	nickName varchar(10) not null,						/* 회원 닉네임 */
	birthday datetime default now(),					/* 생일 */
	email varchar(40) not null,								/* 이메일 */
	emailNews char(2) default 'OK',	/* 이메일 뉴스레터 구독여부(OK/NO) */
	phone varchar(15) not null,								/* 연락처 */
	address varchar(100),											/* 주소 */
	mGroup char(3),														/* 분류(개인/재직자) */
	cName varchar(20),			/* 재직자: 회사명 */
	cCategory varchar(20),	/* 재직자: 회사 업종 */
	cAddress varchar(100),	/* 재직자: 회사소재지 */
	cTel varchar(20),				/* 재직자: 회사연락처 */
	purpose varchar(100),											/* 가입목적 */
	level int default 1,											/* 회원등급(0:관리자, 1:일반회원, 2:기업회원) */
	point int default 100,										/* 회원포인트 */
	userDel char(2) default 'NO',							/* 탈퇴신청 여부 */
	startDate datetime default now(),					/* 최초 가입일 */
	lastDate datetime default now(),					/* 마지막 접속일 */
	primary key(idx),
	unique(mid)
);

desc member;
drop table member;
delete from member;

insert into member values(default,'관리자','admin','1234','관리자','1993-05-19','chst8937@hanmail.net',
default,'010-1234-5678','63309/제주시 영평동/1층/로비','재직자','그린엔지니어링','기타','63309/제주시 첨단로/1층/로비',
'043-123-4567','기타',default,default,default,default,default);

select * from member;
select emailNews from member;
select * from member where mid='hkd1234';