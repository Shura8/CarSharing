set ansi_nulls on
go
set ansi_padding on
go
set quoted_identifier on 
go

create database Car_Sharing
go

use Car_Sharing
go

create table Status_Car
(
	ID_Status int not null identity(1,1),
	Name_Status varchar(20) not null,
	constraint PK_Status primary key clustered (ID_Status ASC) on [PRIMARY],
	constraint UQ_Name_Status unique (Name_Status)
)

create table Class_Car
(
	ID_Class int not null identity(1,1),
	Name_Class varchar(20) not null,
	Day_Cost int not null,
	constraint PK_Class primary key clustered (ID_Class ASC) on [PRIMARY],
	constraint CH_Day_Cost check (Day_Cost > 0),
	constraint UQ_Name_Class unique (Name_Class)
)

create table Car
(
	ID_Car int not null identity(1,1),
	State_Number varchar(9) not null,
	Brand varchar(20) not null,
	Color varchar(20) not null,
	Class_ID int not null,
	Issue_Year int not null,
	Deposit int not null,
	Status_ID int not null,
	Passport varchar(10) not null,
	Location_Car varchar(max) not null,
	constraint PK_Car primary key clustered (ID_Car ASC) on [PRIMARY],
	constraint FK_Car_Car_Class foreign key (Class_ID) references Class_Car(ID_Class),
	constraint FK_Car_Car_Status foreign key (Status_ID) references Status_Car(ID_Status),
	constraint CH_Issue_Year check (Issue_Year like ('[0-9][0-9][0-9][0-9]')),
	constraint CH_Deposit check (Deposit > 0),
	constraint UQ_State_Number unique (State_Number),
	constraint UQ_Passport unique (Passport)
)

create table Maintenance
(
	ID_Maintenance int not null identity(1,1),
	Service_Cost int not null,
	Car_ID int not null,
	Date_Maintenance date not null,
	constraint PK_Maintenance primary key clustered (ID_Maintenance ASC) on [PRIMARY],
	constraint FK_Maintenance_Car foreign key (Car_ID) references Car(ID_Car),
	constraint CH_Service_Cost check (Service_Cost > 0),
	constraint CH_Date_Maintenance check (Date_Maintenance < Getdate())
)

create table Role_Users
(
	ID_Role int not null identity(1,1),
	Name_Role varchar(20) not null,
	constraint PK_Role primary key clustered (ID_Role ASC) on [PRIMARY],
	constraint UQ_Name_Role unique (Name_Role)
)


create table Users
(
	ID_Users int not null identity(1,1),
	Surname_Users varchar(50) not null,
	Name_Users varchar(50) not null,
	Father_Name varchar(50) null,
	Age int not null,
	Login_Users varchar(20) not null,
	Password_Users varchar(max) not null,
	Server_Password_Users varchar(max) null,
	Salt_Users varchar(max) not null,
	Phone_Users varchar(11) not null,
	Driver_License varchar(10) null,
	Role_ID int not null,
	constraint PK_Users primary key clustered (ID_Users ASC) on [PRIMARY],
	constraint FK_Role_User foreign key (Role_ID) references Role_Users(ID_Role),
	constraint CH_Age check (Age > 0),
	constraint UQ_Login_Users unique (Login_Users),
	constraint UQ_Phone_Users unique (Phone_Users)
)

create table Logging
(
	ID_Logging int not null identity(1,1),
	Describe varchar(max) not null
	constraint PK_Logging primary key clustered (ID_Logging ASC) on [PRIMARY]
)
create table Discount
(
	ID_Discount int not null identity(1,1),
	Name_Discount varchar(20) not null,
	Cost_Discount int not null,
	constraint PK_Discount primary key clustered (ID_Discount ASC) on [PRIMARY],
	constraint CH_Cost_Discount check (Cost_Discount >= 0),
	constraint UQ_Name_Discount unique (Name_Discount)
)

create table Fine
(
	ID_Fine int not null identity(1,1),
	Name_Fine varchar(20) not null,
	Cost_Fine int not null,
	constraint PK_Fine primary key clustered (ID_Fine ASC) on [PRIMARY],
	constraint CH_Cost_Fine check (Cost_Fine > 0),
	constraint UQ_Name_Fine unique (Name_Fine)
)

create table Rental
(
	ID_Rental int not null identity(1,1),
	Number_Rental varchar(20) not null,
	Users_ID int not null,
	Car_ID int not null,
	Discount_ID int not null,
	Date_Rental date not null,
	Days_Rental int not null,
	Total_Cost int not null,
	constraint PK_Rental primary key clustered (ID_Rental ASC) on [PRIMARY],
	constraint FK_Rental_User foreign key (Users_ID) references Users(ID_Users),
	constraint FK_Rental_Car foreign key (Car_ID) references Car(ID_Car),
	constraint FK_Rental_Discount foreign key (Discount_ID) references Discount(ID_Discount),
	constraint UQ_Number_Rental unique (Number_Rental),
	constraint CH_Date_Rental check (Date_Rental < Getdate()),
	constraint CH_Days_Rental check (Days_Rental > 0 and Days_Rental <= 7),
	constraint CH_Total_Cost check (Total_Cost > 0)
)

create table Rental_Fine
(
	ID_Rental_Fine int not null identity(1,1),
	Rental_ID int not null,
	Fine_ID int not null,
	constraint PK_Rental_Fine primary key clustered (ID_Rental_Fine ASC) on [PRIMARY],
	constraint FK_Rental_Rental_Fine foreign key (Rental_ID) references Rental(ID_Rental),
	constraint FK_Rental_Fine_Fine foreign key (Fine_ID) references Fine(ID_Fine)
)

create table History_Rental
(
	ID_History_Rental int not null identity(1,1),
	FIO varchar(max) not null,
	Phone_Users varchar(11) not null,
	Brand varchar(20) not null,
	Number_Rental varchar(20) not null,
	Days_Rental int not null,
	Date_Rental date not null,
	Total_Cost int not null,
	constraint PK_History_Rental primary key clustered (ID_History_Rental ASC) on [PRIMARY],
	constraint CH_Date_History_Rental check (Date_Rental < Getdate()),
	constraint CH_Days_History_Rental check (Days_Rental > 0 and Days_Rental <= 7),
	constraint CH_Total_Cost_History_Rental check (Total_Cost > 0)
)
create table Degree_Damage 
(
	ID_Degree_Damage int not null identity(1,1),
	Name_Degree_Damage varchar(20) not null,
	constraint PK_Degree_Damage primary key clustered (ID_Degree_Damage ASC) on [PRIMARY],
	constraint UQ_Name_Degree_Damage unique (Name_Degree_Damage)
)

create table Accident_Rental
(
	ID_Accident_Rental int not null identity(1,1),
	Date_Accident date not null,
	Degree_Damage_ID int not null,
	Discription varchar(max) not null,
	Rental_ID int not null,
	constraint PK_Accident_Rental primary key clustered (ID_Accident_Rental ASC) on [PRIMARY],
	constraint FK_Accident_Rental_Degree_Damage foreign key (Degree_Damage_ID) references Degree_Damage(ID_Degree_Damage),
	constraint FK_Rental_Accident_Rental foreign key (Rental_ID) references Rental(ID_Rental),
	constraint CH_Date_Accident check (Date_Accident < Getdate())
)

create table History_Accident
(
	ID_History_Accident int not null identity(1,1),
	Date_Accident date not null,
	Name_Degree_Damage varchar(20) not null,
	State_Number varchar(9) not null,
	Brand varchar(20) not null,
	constraint PK_History_Accident primary key clustered (ID_History_Accident ASC) on [PRIMARY],
	constraint CH_Date_Accident_History_Accident check (Date_Accident < Getdate()),
	constraint UQ_State_Number_History unique (State_Number),
	constraint UQ_Name_Degree_Damage_History unique (Name_Degree_Damage)
)

create or alter trigger [dbo].[History_Rental_Insert]
on Rental after insert
as
	insert into History_Rental (FIO, Phone_Users, Brand, Number_Rental, Days_Rental, Date_Rental, Total_Cost)
	values ((select concat([Surname_Users], ' ', [Name_Users], ' ', [Father_Name],';') from Users inner join Rental on Rental.Users_ID = Users.ID_Users
	where Rental.ID_Rental = (select ID_Rental from [inserted])),(select Phone_Users from Users inner join Rental on Rental.Users_ID = Users.ID_Users
	where Rental.ID_Rental = (select ID_Rental from [inserted])), (select Brand from Car inner join Rental on Rental.Car_ID = Car.ID_Car
	where Rental.ID_Rental = (select ID_Rental from [inserted])), (select Number_Rental from Rental where Rental.ID_Rental = (select ID_Rental from [inserted])),
	(select Days_Rental from Rental where Rental.ID_Rental = (select ID_Rental from [inserted])), (select Date_Rental from Rental where Rental.ID_Rental = (select ID_Rental from [inserted])),
	(select Total_Cost from Rental where Rental.ID_Rental = (select ID_Rental from [inserted])))
	print('Insert Record Complete!')
go

create or alter trigger [dbo].[History_Accident_Insert]
on Accident_Rental after insert
as
	insert into History_Accident (Date_Accident, Name_Degree_Damage, State_Number, Brand)
	values ((select Date_Accident from Accident_Rental where Accident_Rental.ID_Accident_Rental = (select ID_Accident_Rental from [inserted])),
	(select Name_Degree_Damage from Degree_Damage inner join Accident_Rental on Accident_Rental.Degree_Damage_ID = ID_Degree_Damage 
	where Accident_Rental.ID_Accident_Rental = (select ID_Accident_Rental from [inserted])),
	(select State_Number from Car inner join Rental on Rental.Car_ID = ID_Car inner join Accident_Rental on Accident_Rental.Rental_ID = Rental.ID_Rental
	where Accident_Rental.ID_Accident_Rental = (select ID_Accident_Rental from [inserted])),
	(select Brand from Car inner join Rental on Rental.Car_ID = ID_Car inner join Accident_Rental on Accident_Rental.Rental_ID = Rental.ID_Rental
	where Accident_Rental.ID_Accident_Rental = (select ID_Accident_Rental from [inserted]))
	)
	print('Insert Record Complete!')
go

create view Car_Price (Describe)
as select CONCAT('Марка: ', Brand,', Цвет: ', Color, ', Год выпуска: ', Issue_Year, ', Класс машины: ', Name_Class, ', Посуточная цена: ', Day_Cost)
from Car inner join Class_Car on Class_Car.ID_Class = Car.Class_ID 
go

create view User_Rental(Users, Car_Describe, Dates, Cost)
as select concat([Surname_Users], ' ', [Name_Users], ' ', [Father_Name],';'), 
CONCAT('Марка: ', Brand,', Цвет: ', Color, ', Год выпуска: ', Issue_Year),   
concat('Дата проката: ', Date_Rental, ', Количество дней проката: ', Days_Rental),
Total_Cost
from Users inner join Rental on Rental.Users_ID = Users.ID_Users inner join Car on Rental.Car_ID = ID_Car
go

create procedure Rental_Car
    @State_Number varchar(9)  
AS   
    SELECT [Number_Rental], CONCAT('ФИО клиента: ', [Surname_Users], ' ', [Name_Users], ' ', [Father_Name],';'), [Date_Rental]  
    FROM Car inner join Rental on Car.ID_Car = Rental.Car_ID inner join Users on Users.ID_Users = Rental.Users_ID
    WHERE [State_Number] = @State_Number
GO  

CREATE OR ALTER FUNCTION Car_Day_Cost (@carid int, @days int)
RETURNS TABLE
AS
RETURN
(
    SELECT Concat('Стоимость за отведенное время: ', Day_Cost * @days, ' руб.') as Calc
    FROM Car
    inner join Class_Car ON Class_Car.ID_Class = Car.Class_ID
    WHERE ID_Car = @carid
);
GO

SELECT * FROM Car_Day_Cost (2,6);


insert into Role_Users (Name_Role) values ('Администратор'), ('Пользователь'),('Менеджер автопарка')
go

insert into Users (Surname_Users, Name_Users, Father_Name, Age, Login_Users, Password_Users, Salt_Users, Phone_Users, Driver_License, Role_ID, Server_Password_Users)
values ('Бирюков','Глеб','Вадимович',18,'Shura121','1234','qwerty','89771170674','21AA765980',1, ''),
('аарфврав','ыавррав','ырварыва',18,'User','1234','qwerty','89771170675','21AA765980',2,'')
go

insert into Class_Car values 
('Бюджет', 1500),
('Комфорт', 2500),
('Бизнес',4000)

insert into Status_Car values 
('Доступен'),
('Занят'),
('Ремонт')
go

insert into Discount values
('Нет скидки',0),
('Скидка на 1 заказ', 500)
go

insert into Rental values 
('GHF241421',16,1,3,'2023-12-10',3,4000)
go
insert into Car values
('А690АВ039','Nissan','Красный',2,2016,5000,1,'27FKSD3287','42.353.13.5155.12'),
('Р333ПР117','Hundai','Бежевый',3,2019,10000,1,'98REMB9183','64.765.35.1425.82')

create login client with Password = '1234'
go

create user Client from login client
go

create login engineer with Password = '0987'
go

create user MainEngineer from login engineer
go

create login dealer with Password = '12345'
go
create user CarDealer from login dealer
go

grant select on [Car]
to Client
go

grant select on [Discount]
to Client
go

grant select on [Rental]
to Client
go

grant select on [Fine]
to Client
go

grant select on [Rental_Fine]
to Client
go

grant select, insert on [Users]
to Client
go

grant select, insert on [Class_Car]
to Client
go

grant select on [Car_Day_Cost]
to Client
go

grant select on [Car_Price]
to Client
go

grant select on [Car]
to MainEngineer
go

grant select, insert, update, delete on [Status_Car]
to MainEngineer
go

grant select on [Class_Car]
to MainEngineer
go

grant select, insert, update, delete on [Maintenance]
to MainEngineer
go

grant select on [History_Accident]
to MainEngineer
go

grant select on [Rental]
to MainEngineer
go

grant select, insert, update, delete on [Accident_Rental]
to MainEngineer
go

grant select, insert, update, delete on [Degree_Damage]
to MainEngineer
go

grant execute on [Rental_Car]
to MainEngineer
go

grant select, insert, update, delete on [Car]
to CarDealer
go

grant select on [Status_Car]
to CarDealer
go

grant select, insert, update, delete on [Class_Car]
to CarDealer
go

grant select on [Maintenance]
to CarDealer
go

grant select on [Car_Day_Cost]
to CarDealer
go

grant select on [Car_Price]
to CarDealer
go

CREATE MASTER KEY ENCRYPTION BY   
PASSWORD = 'MasterKeyCar2345'
go

SELECT *
FROM  sys.asymmetric_keys
go
select * from sys.symmetric_keys
go

CREATE ASYMMETRIC KEY Password_Key1  
    WITH ALGORITHM = RSA_2048  
    ENCRYPTION BY PASSWORD = 'SecurityPasswords';  
GO  

create or alter trigger [SecurityPass]
on Users FOR insert
as
	update Users
	SET Server_Password_Users = ENCRYPTBYASYMKEY(ASYMKEY_ID('Password_Key1'), Password_Users)
	FROM dbo.Users;
	GO
go

