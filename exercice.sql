create database game;
use game;

create table if not exists wl(
date date NOT NULL,
res varchar(6) NOT NULL
) ;
insert into wl (date,res) values
('2017-01-01','win'),
('2017-01-01','win'),
('2017-01-01','lose'),
('2017-01-01','lose'),
('2017-01-01','win'),
('2017-01-02', 'win'),
('2017-01-02', 'win'),
('2017-01-02', 'lose'),
('2017-01-02', 'lose'),
('2017-01-03', 'lose'),
('2017-01-02', 'lose')
;

#查询每天win和lose的次数
#方法一
select distinct date ,
sum(case res when res='win'then 1 else 0 end) as win, 
sum(case res when res='lose' then 1 else 0 end ) as lose 
from wl group by date;


#方法二

select a.date,coalesce(a.win,0) win,coalesce(b.lose,0) lose from 
(select date, count(res) win from wl where res='win' group by date ) a 
left join 
(select date, count(res) lose from wl where res='lose' group by date) b 
on a.date=b.date
union
select b.date,coalesce(a.win,0) win,coalesce(b.lose,0) lose from 
(select date, count(res) win from wl where res='win' group by date ) a 
right join 
(select date, count(res) lose from wl where res='lose' group by date) b 
on a.date=b.date ;