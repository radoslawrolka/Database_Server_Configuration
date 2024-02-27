create table Products
(
    ProductID     int identity
        primary key,
    ProductTypeID int   not null
        references ProductType,
    Price         money not null
        check ([Price] > 0)
)
go

grant delete, insert, select, update on Products to Administrator
go

grant delete, insert, select, update on Products to HeadAdministrator
go

