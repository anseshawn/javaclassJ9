show tables;

/* 신고테이블 */
create table report(
	idx int not null auto_increment,	/* 신고 테이블 고유번호 */
	board varchar(20) not null,				/* 게시판 종류 */
	boardIdx int not null,						/* 게시판 글 번호 */
	rpMid varchar(10) not null,				/* 신고자 아이디 */
	rpContent text not null,					/* 신고 내용 */
	rpDate datetime default now(),		/* 신고 날짜 */
	primary key(idx)
);
desc report;

insert into report values (default,'freeBoard',24,'admin','기타/테스트',default);