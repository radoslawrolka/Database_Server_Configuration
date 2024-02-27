create table Postponed
(
    PostponedID   int   not null
        primary key,
    OrderID       int   not null
        references OrderDetails,
    PostponedDate date default getdate(),
    Price         money not null
        check ([Price] > 0),
    PricePaid     money not null
)
go

grant delete, insert, select, update on Postponed to Administrator
go

grant delete, insert, select, update on Postponed to Director
go

grant delete, insert, select, update on Postponed to HeadAdministrator
go

