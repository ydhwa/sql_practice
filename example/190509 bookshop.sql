show tables;
desc book;
desc author;

-- getList(author)
select no, name from author;

-- insert(author)
insert into author values(null, '스테파니메이어');
insert into author values(null, '조정래');

-- insert(booK)
insert into book values(null, '트와일라잇', '대여가능', 1);
insert into book values(null, '뉴문', '대여가능', 1);
insert into book values(null, '이클립스', '대여가능', 1);
insert into book values(null, '브레이킹던', '대여가능', 1);

select b.title, a.name, b.status
from book b, author a
where b.author_no = a.no
order by b.no asc;

-- update(book status)
update book set status='대여가능' where no = 1;

select * from book;
