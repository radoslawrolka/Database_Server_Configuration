create table Studies
(
    StudyID       int          not null
        primary key,
    Name          varchar(50)  not null,
    Description   varchar(200) not null,
    CoordinatorID int          not null
        constraint Studies_Coordinator_CoordinatorID_fk
            references Coordinator,
    FieldID       int          not null
        constraint Studies_FieldType_FieldTypeID_fk
            references FieldType,
    studies_limit int
)
go

grant delete, insert, select, update on Studies to Administrator
go

grant delete, insert, select, update on Studies to Coordinator
go

grant delete, insert, select, update on Studies to HeadAdministrator
go

