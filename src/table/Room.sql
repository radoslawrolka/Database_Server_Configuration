create table Room
(
    RoomID   int identity
        primary key,
    RoomName varchar(50) not null
)
go

grant delete, insert, select, update on Room to Administrator
go

grant delete, insert, select, update on Room to Coordinator
go

grant delete, insert, select, update on Room to HeadAdministrator
go

