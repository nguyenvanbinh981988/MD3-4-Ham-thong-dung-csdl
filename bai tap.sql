create database baitapHamThongDung;

create table department(
departmentid int not null primary key,
departmentname varchar(50)
);

create table class(
classid int not null primary key,
classname varchar(50),
departmentid int , foreign key (departmentid) references department(departmentid )
);


create table Student(
studentid int not null primary key,
Name varchar(50) not null,
birth datetime not null,
scholarship bit,
gender varchar(10) default('male'),
classid int, foreign key(classid) references class(classid)
);

create table subject(
subid int not null primary key,
subname varchar(50)
);

create table mark(
studentid int, foreign key (studentid) references student(studentid),
subid int,foreign key (subid) references subject(subid),
mark float
);


insert into department value (1,'ke toan'),(2,'kiem toan'),(3,'kinh doanh'),(4,'marketing');

insert into class value (1,'KT001',1),(2,'KT002',1),(3,'KT003',1),(4,'KIT001',2),(5,'KD001',3),(6,'KD002',3),(7,'MK001',4),(8,'MK002',4);

insert into student value (1,'Tran thi Anh','1999-08-09',1,'female',2),(2,'nguyen thi ngoc','2000-08-07',0,'female',6),
(3,'Tran Thanh Hai','2000-2-07',0,'male',1),(4,'nguyen Van Toan','2000-2-05',0,'male',4),(5,'nguyen thi Tinh','2000-12-12',0,'female',7),
(6,'nguyen thi nhung','2001-08-02',1,'female',3),(7,'nguyen Van Tung','2000-01-10',1,'male',8),(8,'nguyen thi nga','2000-05-09',0,'female',5);

insert into subject value (1,'Toan cao cap'),(2,'lich su dang');

insert into mark value (1,1,9),(2,1,7.5),(3,1,8),(4,1,5),(5,1,6),(6,1,8.5),(7,1,9.5),(8,1,4),
(1,2,8.5),(2,2,7),(3,2,6),(4,1,5),(5,2,7),(6,2,9),(7,2,9.5),(8,2,6);

--cau 5:
select * from student where name like '%Tran%';

--cau 6: 
select * from student where gender = 'female' and scholarship = 1;

--cau 7:
select * from student where gender = 'female' or scholarship = 1;

--cau 8:
select * from student where birth  between '1998-12-31' and '2001-01-01';

--cau 9:
 select * from student
 order by studentid ASC;
 
--cau 10:
 select * from student
 where scholarship = 1
 order by studentid DESC;
 
-- cau 12:
select  S.studentid,S.Name,S.birth,S.scholarship,S.gender,s.classid,D.departmentname,M.mark
From student S join mark M on S.studentid = M.studentid join class C on S.classid = C.classId join department D on C.departmentid = D.departmentid
 where scholarship = 1 and D.departmentid= 1;
 
-- cau 14:
select class.classname, count(studentid) as 'so sinh vien'
from class join student on class.classid = student.classid
group by class.classname;

--cau 15:
select  D.departmentname,count(studentid) as 'so sinh vien'
From student S join class C on S.classid = C.classId join department D on C.departmentid = D.departmentid
 group by D.departmentname;
 
-- cau 16:
select  D.departmentname,count(studentid) as 'so sinh vien'
From student S join class C on S.classid = C.classId join department D on C.departmentid = D.departmentid
where gender = 'female'
 group by D.departmentname;

-- cau 17: 
select  D.departmentname,count(studentid)*30000000 as 'Tong tien hoc bong'
From student S join class C on S.classid = C.classId join department D on C.departmentid = D.departmentid
where scholarship = 1;

-- cau 19: 
select  C.departmentid,D.departmentname,count(studentid) as 'so sinh vien'
From student S join class C on S.classid = C.classId join department D on C.departmentid = D.departmentid
where (select  count(studentid) as 'so sinh vien'
From student S join class C on S.classid = C.classId join department D on C.departmentid = D.departmentid) > 100
group by D.departmentname;

-- cau 20: 
select  C.departmentid,D.departmentname,count(studentid) as 'so sinh vien nu'
From student S join class C on S.classid = C.classId join department D on C.departmentid = D.departmentid
where gender = 'female' and (select  count(studentid) as 'so sinh vien'
From student S join class C on S.classid = C.classId join department D on C.departmentid = D.departmentid
where gender = 'female') > 50
group by D.departmentname;

-- cau 21: 
select S.studentid,S.Name,S.birth,S.gender,S.classid,D.departmentname,M.mark
From student S join mark M on S.studentid = M.studentid join class C on S.classid = C.classId join department D on C.departmentid = D.departmentid
 where mark = (select max(mark) from mark);
 
 --cau 23:
select S.studentid,S.Name,S.birth,S.gender,S.classid,D.departmentname,M.mark
From student S join mark M on S.studentid = M.studentid join class C on S.classid = C.classId join department D on C.departmentid = D.departmentid
 where M.subid = 1 and mark = (select max(mark) from mark);