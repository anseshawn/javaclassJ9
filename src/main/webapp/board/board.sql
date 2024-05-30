show tables;

create table freeBoard(
	idx int not null auto_increment,	/* 게시글 고유번호 */
	mid varchar(10) not null,					/* 작성자 아이디 */
	nickName varchar(10) not null,		/* 작성자 닉네임 */
	title varchar(50) not null,				/* 게시글 제목 */
	content text not null,						/* 게시글 내용 */
	hostIp varchar(40) not null,			/* 작성자 아이피 */
	readNum int default 0,						/* 조회수 */
	wDate datetime default now(),			/* 작성일 */
	good int default 0,								/* 좋아요 */
	report int default 0,							/* 신고(5번 신고하면 리스트에서 블라인드) */
	primary key(idx),
	foreign key(mid) references member(mid)
);

desc freeBoard;
drop table freeBoard;

insert into freeBoard values (default,'admin','관리자','자유게시판 서비스를 시작합니다.','많은 이용 부탁드립니다.','172.30.1.24',default,default,default,default);
select * from freeBoard;

create table reply(
	idx int not null auto_increment,	/* 댓글 고유번호 */
	board varchar(20) not null,				/* 게시판 종류 */
	boardIdx int not null,						/* 게시판 글 번호 */
	mid varchar(10) not null,					/* 댓글 작성자 아이디 */
	nickName varchar(10) not null,		/* 댓글 작성자 닉네임 */
	rDate datetime default now(),			/* 댓글 작성일 */
	hostIp varchar(40) not null,			/* 작성자 아이피 */
	content text not null,						/* 내용 */
	report int default 0,							/* 신고(5번 신고하면 리스트에서 블라인드) */
	primary key(idx)
	/* foreign key(mid) references member(mid) */
);
desc reply;
drop table reply;

create table reReply(
	reIdx int not null auto_increment,	/* 대댓글 고유번호 */
	replyIdx int not null,							/* 원본 댓글의 고유번호 */
	reMid varchar(10) not null,					/* 대댓글 작성자 아이디 */
	reNickName varchar(10) not null,		/* 작성자 닉네임 */
	reDate datetime default now(),			/* 작성일 */
	reHostIp varchar(50) not null,			/* 작성자IP */
	reContent text not null,						/* 대댓글 내용 */
	reReport int default 0,							/* 신고(5번 신고하면...) */
	primary key(reIdx),
	foreign key(replyIdx) references reply(idx)
	on update cascade
	on delete restrict
);
desc reReply;
drop table reReply;

insert into reply values(default,'freeBoard',1,'admin','관리자',default,'172.30.1.24','댓글 서비스를 시작합니다.',default);
insert into reply values(default,'freeBoard',2,'admin','관리자',default,'172.30.1.24','댓글 테스트',default);
insert into reply values(default,'freeBoard',2,'admin','관리자',default,'172.30.1.24','댓글 테스트',default);
insert into reply values(default,'freeBoard',2,'admin','관리자',default,'172.30.1.24','댓글 테스트',default);

insert into reReply values(default,1,'admin','관리자',default,'172.30.1.24','대댓글 테스트',default);
insert into reReply values(default,1,'admin','관리자',default,'172.30.1.24','대댓글 테스트',default);
insert into reReply values(default,1,'admin','관리자',default,'172.30.1.24','대댓글 테스트',default);
insert into reReply values(default,1,'admin','관리자',default,'172.30.1.24','대댓글 테스트',default);

delete from reply where boardIdx=2;

select * from reply;

select count(*) as cnt from freeBoard where report < 5;

select *, datediff(wDate, now()) as date_diff, timestampdiff(hour, wDate, now()) as hour_diff,
	(select count(*) from reply where board='freeBoard' and boardIdx = b.idx) as replyCnt from freeBoard b order by idx;