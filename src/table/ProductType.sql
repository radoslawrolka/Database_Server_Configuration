create table ProductType
(
    ProductTypeID int identity
        primary key,
    Name          varchar(20) not null
)
go

grant delete, insert, select, update on ProductType to Administrator
go

grant delete, insert, select, update on ProductType to HeadAdministrator
go

