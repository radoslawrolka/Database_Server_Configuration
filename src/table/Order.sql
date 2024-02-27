create table [Order]
(
    OrderID   int identity
        primary key,
    StudentID int   not null
        references Students,
    Paid      money not null,
    Date      date  not null
        check (datepart(year, [Date]) >= 2019),
    PaidDate  date default getdate()
)
go

exec sp_addextendedproperty 'Column_Description', '>=0', 'SCHEMA', 'dbo', 'TABLE', 'Order', 'COLUMN', 'Paid'
go

grant delete, insert, select, update on [Order] to Administrator
go

grant delete, insert, select, update on [Order] to HeadAdministrator
go

