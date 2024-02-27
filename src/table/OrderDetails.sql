create table OrderDetails
(
    OrderDetailsID int identity
        primary key,
    OrderID        int   not null
        references [Order],
    ProductID      int   not null
        references Products,
    Price          money not null
        check ([Price] >= 0)
)
go

exec sp_addextendedproperty 'Column_Description', '>=0', 'SCHEMA', 'dbo', 'TABLE', 'OrderDetails', 'COLUMN', 'Price'
go

grant delete, insert, select, update on OrderDetails to Administrator
go

grant delete, insert, select, update on OrderDetails to HeadAdministrator
go

