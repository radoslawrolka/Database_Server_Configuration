create table FieldType
(
    FieldTypeID int identity
        primary key,
    Name        varchar(30) not null
)
go

grant delete, insert, select, update on FieldType to Administrator
go

grant delete, insert, select, update on FieldType to Coordinator
go

grant delete, insert, select, update on FieldType to HeadAdministrator
go

