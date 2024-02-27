create table TranslatorsLanguage
(
    TranslatorsLanguageID int identity
        primary key,
    TranslatorID          int not null
        references Translators,
    LanguageID            int not null
        references Languages
)
go

grant delete, insert, select, update on TranslatorsLanguage to Administrator
go

grant delete, insert, select, update on TranslatorsLanguage to HeadAdministrator
go

