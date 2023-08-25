-- tbl_user : ȸ�� ������ ��� �ִ� ���̺� 
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

-- ���̵� �ߺ� üũ �˻�
-- �ߺ��� : 1 
select count(id) from tbl_user
where id = 'cigr45';

-- �ߺ����� ���� : 0 
select count(id) from tbl_user
where id = 'cigr46';

-- ��й�ȣ : 1q2w3e4r
insert into tbl_user (id, pwd, email)
values ('cigr45', '72ab994fa2eb426c051ef59cad617750bfe06d7cf6311285ff79c19c32afd236', 'chul4450@naver.com');

-- �α��� Transaction 

-- 1. �α��� Ȯ�� : ȸ�� ���� -> 1, ȸ�� ���� X -> 0
select count(*) from tbl_user
where id = 'cigr45' and pwd = '72ab994fa2eb426c051ef59cad617750bfe06d7cf6311285ff79c19c32afd236';

-- 2. �α��� ���� ���� 
update tbl_user set 
    recentLog = sysdate
    where id = 'cigr45' and pwd = '72ab994fa2eb426c051ef59cad617750bfe06d7cf6311285ff79c19c32afd236';
    
commit;

select * from tbl_recipe_ctg;

-- tbl_menu : ������ �Խ��ǿ��� �� �Խñۿ� ���� ���� ���� ���̺� 
-- �޴� ������ �Խñ� -> �����ڰ� ���� �ۼ�
-- ��� �����, �ı� �Խ����� �Խñ� �ø��� -> ȸ���� �ۼ� 
-- FK mno ���� ��å : cascade
create table tbl_menu (
    mno number primary key,
    mname varchar2(50) not null unique,
    mdesc varchar2(100) not null, -- menu description : �޴� ���� ����  
    mfilename varchar2(150) -- �� �޴��� ��ϵ� �̹��� �߿��� ��ǥ �̹����� ���� �̸� 
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
    
-- �˻� ���ǿ� �´� row ���� Ȯ��
-- searchType : 't', keyword : '�� - 3'
select x.*
    from ( select rownum as rnum, m.*
           from tbl_menu m
           where mname like '%�� - 3%' 
           order by m.mno desc ) x;
           
select count(*)
    from ( select rownum as rnum, m.*
           from tbl_menu m
           where mname like '%�� - 3%' 
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

-- tbl_recipe_ctg : ������ ī�װ��� ���� ���� ���� ���̺� ( ������ �Խ��� ���� (mno) )
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

-- Ư�� �������� ����
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

-- tbl_recipe_order : Ư�� ������ �Խñۿ� ���� ���� ����
create table tbl_recipe (
    mno number references tbl_menu(mno) not null,
    ordernum number(2) not null,
    contents varchar2(500) not null, -- �� ordernum�� ���� ������ 
    constraint fk_tbl_recipe
        foreign key (mno)
        references tbl_menu (mno)
        on delete cascade
);


select * from tbl_recipe;
delete from tbl_recipe;


create sequence seq_tbl_recipe;

-- ÷������ ���̺�
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
---------------- recipeService addMenu() Ȯ�� ---------------

commit;

select * from tbl_menu;

-- ī�װ� ���� Test 
-- 381�� -> temp hot, syrub o , alcohol x, latte o, cream o, fruit x
-- �� ���ǵ鿡 ���ؼ� and 
select * from tbl_recipe_ctg
order by mno desc;

-- �÷� o �� o hot 
select * from tbl_recipe_ctg
where (ctg = 'syrub' and ctg_value = 'Y')
      or (ctg = 'latte' and ctg_value = 'Y')
      or (ctg = 'temp' and ctg_value = 'H')
order by mno desc;

-- �÷� o �� o �µ� hot�� mno�� ����
select mno from tbl_recipe_ctg
where (ctg = 'syrub' and ctg_value = 'Y')
      or (ctg = 'latte' and ctg_value = 'Y')
      or (ctg = 'temp' and ctg_value = 'H')
group by mno
order by mno desc;

-- join��� Table name Alias 'y'�� Mapper Dynamic Query�� ���� 

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

-- ������ �Խ��� �� Ư�� �Խñۿ� ���� ��� 
create table tbl_recipe_reply (
    rrno number primary key,
    mno number references tbl_menu(mno) not null,
    rrwriter varchar2(40) not null,
    rrcontents varchar2(4000) not null,
    regdate timestamp default sysdate,
    updatedate timestamp
);

-- ȸ�� <-> ������ ������ ���� QnA 

-- ������ �Խ��� �� �Խñۿ� ���� ȸ������ �ı� �ۼ� �Խ���
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
    mbwriter varchar2(40) not null, -- �ۼ��ڴ� �α��� �� ���̵� 
    readcount number default 0,
    regdate timestamp default sysdate,
    solddate timestamp, -- (�Ǹ���) �Խñۿ� ���� �Ǹ� �Ϸ� ó�� : solddate is not null
    filename varchar2(300)
);

-- �ø����� �Խ��� �� Ư�� �Խñۿ� ���� ��� 
create table tbl_marketboard_reply (
    mbrno number primary key,
    mbno number references tbl_marketboard(mbno) not null,
    mbrwriter varchar2(40) not null,
    mbrcontents varchar2(4000) not null,
    regdate timestamp default sysdate,
    updatedate timestamp
);

-- ������ : ���� ���������� �α��� �� �����
-- �Ǹ��� : �Ǹ� �Խñ� �ۼ��� 

-- ������ / �Ǹ��� �Ǻ� 
-- ( �α��� �� ���̵� )�� (�Ǹ� �Խñ��� �ۼ���)�� ��
-- ���� (true) : �Ǹ���
-- �ٸ��� (false) : ������

-- �Ǹ���, ������ 1:1 ��ȭ ���� ���̺� 
create table tbl_marketboard_dialog (
    mbdno number primary key,
    attendant varchar2(40) not null,
    role varchar2(30) not null,
    mbdcontents varchar2(4000) not null,
    regdate timestamp default sysdate
);


--------------------------------- �ø����� ���� Table ---------------------------------

create table tbl_market_attach(
    fullname varchar2(150) primary key,
    mbno number not null references tbl_marketboard(mbno),
    regdate timestamp default sysdate
);


--------------------------------------------------------------------------------------


select * from tbl_marketboard_reply;