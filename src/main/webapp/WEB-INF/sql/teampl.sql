-- tbl_user : 회원 정보를 담고 있는 테이블 
create table tbl_user (
    id varchar2(40) primary key,
    pwd varchar2(64) not null,
    email varchar2(50) not null, 
    isauth char(1) default 'N' check (isAuth in ('Y', 'N')) not null,
    regdate timestamp default sysdate,
    recentLog timestamp,
    point number default 0
);

select * from tbl_user;

-- 아이디 중복 체크 검사
-- 중복됨 : 1 
select count(id) from tbl_user
where id = 'cigr45';

-- 중복되지 않음 : 0 
select count(id) from tbl_user
where id = 'cigr46';

-- 비밀번호 : 1q2w3e4r
insert into tbl_user (id, pwd, email)
values ('cigr45', '72ab994fa2eb426c051ef59cad617750bfe06d7cf6311285ff79c19c32afd236', 'chul4450@naver.com');

-- 로그인 Transaction 

-- 1. 로그인 확인 : 회원 존재 -> 1, 회원 존재 X -> 0
select count(*) from tbl_user
where id = 'cigr45' and pwd = '72ab994fa2eb426c051ef59cad617750bfe06d7cf6311285ff79c19c32afd236';

-- 2. 로그인 일자 갱신 
update tbl_user set 
    recentLog = sysdate
    where id = 'cigr45' and pwd = '72ab994fa2eb426c051ef59cad617750bfe06d7cf6311285ff79c19c32afd236';
    
commit;

select * from tbl_recipe_ctg;

-- tbl_menu : 레시피 게시판에서 각 게시글에 대한 정보 담은 테이블 
-- 메뉴 레시피 게시글 -> 관리자가 따로 작성
-- 댓글 남기기, 후기 게시판의 게시글 올리기 -> 회원이 작성 
-- FK mno 삭제 정책 : cascade
create table tbl_menu (
    mno number primary key,
    mname varchar2(50) not null unique,
    mdesc varchar2(100) not null, -- menu description : 메뉴 간단 설명  
    mfilename varchar2(150) -- 각 메뉴당 등록된 이미지 중에서 대표 이미지의 파일 이름 
);

select rownum, x.* 
    from ( select m.*
           from tbl_menu m
           order by m.mno desc ) x;
           
-- startRow ~ endRow
select x.*
    from ( select rownum as rnum, m.*
           from tbl_menu m
           order by m.mno desc ) x
    where rnum between 10 and 18;
    
-- 검색 조건에 맞는 row 갯수 확인
-- searchType : 't', keyword : '목 - 3'
select x.*
    from ( select rownum as rnum, m.*
           from tbl_menu m
           where mname like '%목 - 3%' 
           order by m.mno desc ) x;
           
select count(*)
    from ( select rownum as rnum, m.*
           from tbl_menu m
           where mname like '%목 - 3%' 
           order by m.mno desc ) x;           
    

select * from tbl_menu;
delete from tbl_menu;

commit;

select mno from tbl_menu
where mname = 'catch me if you can';

SELECT * FROM  ALL_CONSTRAINTS
WHERE    TABLE_NAME = 'tbl_menu';

alter table tbl_menu drop column filename;  
alter table tbl_menu modify mname varchar2(100) unique;
alter table tbl_menu add mfilename varchar2(150);

commit;

desc tbl_menu;
create sequence seq_tbl_menu;

select * from tbl_menu
order by mno desc;

commit;

-- tbl_recipe_ctg : 레시피 카테고리에 대한 정보 담은 테이블 ( 레시피 게시판 참조 (mno) )
create table tbl_recipe_ctg (
    mno number references tbl_menu(mno) not null, 
    ctg varchar2(20) not null,
    ctg_value char(1) check (ctg_value in ('H', 'I', 'Y', 'N')) not null,
    constraint fk_tbl_recipe_ctg
        foreign key (mno)
        references tbl_menu (mno)
        on delete cascade
); 

alter table tbl_menu modify mname varchar2(100) unique;
select * from tbl_recipe_ctg;

insert into tbl_recipe_ctg (mno, ctg, ctg_value)
values (2, 'syrub', 'Y');

delete from tbl_recipe_ctg;
commit;

-- 특정 레시피의 재료들
create table tbl_ingredients (
    mno number references tbl_menu(mno) not null,
    i_element varchar2(150) not null,
    constraint fk_tbl_ingredients
        foreign key (mno)
        references tbl_menu (mno)
        on delete cascade
);

select * from tbl_ingredients;
delete from tbl_ingredients;

-- tbl_recipe_order : 특정 레시피 게시글에 대한 제조 순서
create table tbl_recipe (
    mno number references tbl_menu(mno) not null,
    ordernum number(2) not null,
    contents varchar2(500) not null, -- 각 ordernum에 대한 제조법 
    constraint fk_tbl_recipe
        foreign key (mno)
        references tbl_menu (mno)
        on delete cascade
);


select * from tbl_recipe;
delete from tbl_recipe;


create sequence seq_tbl_recipe;

-- 첨부파일 테이블
create table tbl_attach (
    category fleamarket
    mno number not null references tbl_menu(mno),
    filename varchar2(150) primary key,
    regdate timestamp default sysdate,
    constraint fk_tbl_attach
        foreign key (mno)
        references tbl_menu (mno)
        on delete cascade
);

drop table tbl_attach;

select * from tbl_attach;
delete from tbl_attach;
---------------- recipeService addMenu() 확인 ---------------

commit;

select * from tbl_menu;

-- 카테고리 조건 Test 
-- 381번 -> temp hot, syrub o , alcohol x, latte o, cream o, fruit x
-- 각 조건들에 대해서 and 
select * from tbl_recipe_ctg
order by mno desc;

-- 시럽 o 라떼 o hot 
select * from tbl_recipe_ctg
where (ctg = 'syrub' and ctg_value = 'Y')
      or (ctg = 'latte' and ctg_value = 'Y')
      or (ctg = 'temp' and ctg_value = 'H')
order by mno desc;

-- 시럽 o 라떼 o 온도 hot인 mno의 모임
select mno from tbl_recipe_ctg
where (ctg = 'syrub' and ctg_value = 'Y')
      or (ctg = 'latte' and ctg_value = 'Y')
      or (ctg = 'temp' and ctg_value = 'H')
group by mno
order by mno desc;

-- join대상 Table name Alias 'y'는 Mapper Dynamic Query로 생성 

select x.* 
    from ( select rownum as rnum, m.*
           from tbl_menu m
           order by m.mno desc ) x,
          ( select mno from tbl_recipe_ctg
            where ( ctg = 'temp' and ctg_value = 'H')
                or (ctg = 'latte' and ctg_value = 'Y')
                or (ctg = 'syrub' and ctg_value = 'Y')
            group by mno
            order by mno desc ) y  
    where (x.mno = y.mno)
    and rnum between 1 and 100;
    
select x.*
    from ( select rownum as rnum, m.*
           from tbl_menu m
           order by m.mno desc ) x,
           ( select mno from tbl_recipe_ctg
            group by mno
            order by mno desc ) y 
    where (x.mno = y.mno) 
    and (rnum between 1 and 100);

select rownum as rnum, m.*
           from tbl_menu m
           order by m.mno desc;
           
select mno from tbl_recipe_ctg
            group by mno
            order by mno desc;


select * from tbl_ingredients
order by mno desc;

select * from tbl_recipe
order by mno desc, ordernum asc;

select * from tbl_attach
order by mno desc;

delete from tbl_menu;
delete from tbl_recipe_ctg;
delete from tbl_ingredients;
delete from tbl_recipe;
delete from tbl_attach;

commit;

-- 레시피 게시판 내 특정 게시글에 대한 댓글 
create table tbl_recipe_reply (
    rrno number primary key,
    mno number references tbl_menu(mno) not null,
    rrwriter varchar2(40) not null,
    rrcontents varchar2(4000) not null,
    regdate timestamp default sysdate,
    updatedate timestamp
);

-- 회원 <-> 관리자 레시피 관련 QnA 

-- 레시피 게시판 각 게시글에 대한 회원들의 후기 작성 게시판
create table tbl_menu_review (
    mrno number primary key,
    mno number references tbl_menu(mno) not null,
    filename varchar2(300) not null
);

-- tbl_marketboard
create table tbl_marketboard (
    mbno number primary key,
    mbtitle varchar2(50) not null,
    mbcontents varchar2(4000) not null,
    mbwriter varchar2(40) not null, -- 작성자는 로그인 된 아이디 
    readcount number default 0,
    regdate timestamp default sysdate,
    solddate timestamp, -- (판매자) 게시글에 대한 판매 완료 처리 : solddate is not null
    filename varchar2(300)
);

-- 플리마켓 게시판 내 특정 게시글에 대한 댓글 
create table tbl_marketboard_reply (
    mbrno number primary key,
    mbno number references tbl_marketboard(mbno) not null,
    mbrwriter varchar2(40) not null,
    mbrcontents varchar2(4000) not null,
    regdate timestamp default sysdate,
    updatedate timestamp
);

-- 구매자 : 현재 브라우저에서 로그인 한 사용자
-- 판매자 : 판매 게시글 작성자 

-- 구매자 / 판매자 판별 
-- ( 로그인 한 아이디 )와 (판매 게시글의 작성자)를 비교
-- 같다 (true) : 판매자
-- 다르다 (false) : 구매자

-- 판매자, 구매자 1:1 대화 내역 테이블 
create table tbl_marketboard_dialog (
    mbdno number primary key,
    attendant varchar2(40) not null,
    role varchar2(30) not null,
    mbdcontents varchar2(4000) not null,
    regdate timestamp default sysdate
);


--------------------------------- 플리마켓 관련 Table ---------------------------------

create table tbl_market_attach(
    fullname varchar2(150) primary key,
    mbno number not null references tbl_marketboard(mbno),
    regdate timestamp default sysdate
);


--------------------------------------------------------------------------------------


select * from tbl_marketboard_reply;