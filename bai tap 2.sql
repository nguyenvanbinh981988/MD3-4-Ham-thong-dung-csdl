create database baitapHamthongdung2;

create table nhacungcap(
manhacc int not null primary key,
tennhacc varchar(50),
diachi varchar(50),
Sodt varchar (20),
masothue varchar(30),
dongxecc varchar(50), foreign key (dongxecc) references dongxe(dongxe)
);

create table loaidichvu(
maloaiDV int not null primary key,
tenloaidv varchar(50)
);

create table mucphi(
mamucphi int not null primary key,
dongia int,
mota varchar(50)
);

create table dongxe(
dongxe varchar(50) primary key not null,
hangxe varchar(50),
songuoingoi int
);

create table Dangkycungcap(
maDKCC int not null primary key,
manhacc int,foreign key (manhacc) references nhacungcap(manhacc),
maloaidv int, foreign key (maloaidv) references loaidichvu(maloaidv),
mamucphi int, foreign key (mamucphi) references mucphi(mamucphi),
dongxe varchar(50), foreign key (dongxe) references dongxe(dongxe),
BdCCdate datetime,
ktccdate datetime,
SLxeDK int
);

insert into nhacungcap value (1,'nha xe duy manh','Ha Noi','077777777','1111','xe cho khach 29 cho ngoi '),(2,'nha xe thai thuy','Hai phong','0888888888','2222','xe cho khach 36 cho ngoi '),(3,'nha xe Hoi Anh','Hai phong','0111111111','3333','xe cho khach 45 cho ngoi '),
(4,'nha xe Viet Tinh','Ha noi','0555555555','5555','xe cho khach 29 cho ngoi '),(5,'nha xe Tinh Thuong','Ha noi','06666666666','6666','xe cho khach 29 cho ngoi ');

insert into loaidichvu value (1,'cho thue theo thang'),(2,'cho thue dai han'),(3,'cho thue thue kem lai');

insert into Mucphi value (1,30000000,'1 thang khong kem lai xe'),(2,25000000,'1 thang khong kem lai xe'),(3,45000000,'1 thang kem lai xe');

insert into dongxe value ('xe cho khach 29 cho ngoi ','toyota',29),('xe cho khach 36 cho ngoi ','honda',36),('xe cho khach 45 cho ngoi ','kia',45),('xe cho khach 16 cho ngoi ','toyota',16);

insert into dangkycungcap value (1,1,1,1,'xe cho khach 29 cho ngoi ','2020-01-01','2022-01-01',10),(2,3,3,3,'xe cho khach 45 cho ngoi ','2019-01-01','2021-01-01',12),
(3,2,1,1,'xe cho khach 36 cho ngoi ','2018-01-01','2022-06-01',5),(4,4,2,1,'xe cho khach 29 cho ngoi ','2018-01-01','2025-06-01',4);

--cau 3: 
select * from dongxe where songuoingoi > 5;

--cau 4:
select N.manhacc, N.tennhacc,N.diachi,N.Sodt,N.masothue,N.dongxecc,D.hangxe
from nhacungcap N join dongxe D on N.dongxecc = D.dongxe
where D.hangxe = 'toyota';

-- cau 5:
select * from nhacungcap
order by tennhacc ASC;

select * from nhacungcap
order by masothue DESC;

-- cau 6:
select  N.manhacc,N.tennhacc,count(maDKcc) as 'so lan dang ky cung cap'
From dangkycungcap DKCC join nhacungcap N on DKCC.manhacc= N.manhacc
where DKCC.BdCCdate > '2019-12-15'
group by N.manhacc;

--cau 7:
select dongxe.hangxe from dongxe group by dongxe.hangxe;

--cau 8:
select DKCC.MaDKCC, DKCC.MaNhaCC, NCC.TenNhaCC, NCC.DiaChi, NCC.MaSoThue, LDV.TenLoaiDV, MP.DonGia,DX.HangXe, DKCC.bdccdate, DKCC.ktccdate,count(maDKCC)
from dangkycungcap DKCC join Nhacungcap NCC on DKCC.manhacc = NCC.manhacc and DKCC.dongxe = NCC.dongxecc join dongxe DX on DKCC.dongxe = DX.dongxe join loaidichvu LDV on DKCC.maloaidv = LDV.maloaiDV join mucphi MP on DKCC.mamucphi = MP.mamucphi
group by NCC.manhacc;

-- cau 9: 
select DKCC.MaDKCC, DKCC.MaNhaCC, NCC.TenNhaCC, NCC.DiaChi, NCC.MaSoThue, LDV.TenLoaiDV, MP.DonGia,DX.HangXe, DKCC.bdccdate, DKCC.ktccdate
from dangkycungcap DKCC join Nhacungcap NCC on DKCC.manhacc = NCC.manhacc and DKCC.dongxe = NCC.dongxecc join dongxe DX on DKCC.dongxe = DX.dongxe join loaidichvu LDV on DKCC.maloaidv = LDV.maloaiDV join mucphi MP on DKCC.mamucphi = MP.mamucphi
where DX.dongxe = 'xe cho khach 36 cho ngoi ';

-- cau 10:
select * from nhacungcap
where not exists (select NCC.TenNhaCC, NCC.DiaChi, NCC.MaSoThue from dangkycungcap DKCC join Nhacungcap NCC on DKCC.manhacc = NCC.manhacc and DKCC.dongxe = NCC.dongxecc 
where NCC.manhacc = DKCC.manhacc );






