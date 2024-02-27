CREATE PROCEDURE AddWebinar
    @Title varchar(50),
    @Description varchar(200),
    @TeacherEmail varchar(50),
    @Price money,
    @CreatedDate date = Null,
    @Language varchar(20) = Null,
    @TranslatorEmail varchar(50) = Null,
    @RecordingLink nvarchar(255) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if the specified teacher exists
    IF NOT EXISTS (SELECT 1 FROM Teachers WHERE Email = @TeacherEmail)
    BEGIN
        PRINT 'Error: Teacher ' + @TeacherEmail + ' does not exist.';
        RETURN;
    END

    -- Check if the specified translator exists (if provided)
    IF @TranslatorEmail IS NOT NULL AND NOT EXISTS (
        SELECT 1
        FROM Translators AS T
        INNER JOIN TranslatorsLanguage AS TL ON T.TranslatorID = TL.TranslatorID
        INNER JOIN Languages AS L ON TL.LanguageID = L.LanguageID
        WHERE T.Email = @TranslatorEmail AND L.Language = @Language
    )
    BEGIN
        PRINT 'Error: Translator ' + @TranslatorEmail + ' for language ' + @Language + ' does not exist.';
        RETURN;
    END

    -- Insert into Products table
    INSERT INTO Products (ProductTypeID, Price)
    VALUES (
        (SELECT ProductTypeID FROM ProductType WHERE Name = 'Webinar'),
        @Price
    );

    DECLARE @WebinarID int;
    SET @WebinarID = SCOPE_IDENTITY(); -- Get the identity value of the recently inserted row

    if @CreatedDate IS NULL
        SET @CreatedDate = GETDATE();

    -- Insert into Webinars table
    INSERT INTO Webinars (WebinarID, Title, Description, CreatedDate, TeacherID, TranslatorsLanguageID, RecordingLink)
    VALUES (
        @WebinarID,
        @Title,
        @Description,
        @CreatedDate,
        (SELECT TeacherID FROM Teachers WHERE Email = @TeacherEmail),
        (SELECT TL.TranslatorsLanguageID
         FROM TranslatorsLanguage AS TL
         INNER JOIN Translators AS T ON TL.TranslatorID = T.TranslatorID
         INNER JOIN Languages AS L ON TL.LanguageID = L.LanguageID
         WHERE T.Email = @TranslatorEmail AND L.Language = @Language),
        @RecordingLink
    );

    PRINT 'Webinar added successfully.';
END;
grant execute on dbo.AddGrade to Coordinator;
go

