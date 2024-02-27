CREATE PROCEDURE AddLanguage
    @Language varchar(20)
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if the language already exists
    IF EXISTS (SELECT 1 FROM Languages WHERE Language = @Language)
    BEGIN
        PRINT 'Error: Language ' + @Language + ' already exists.';
        RETURN;
    END

    -- Insert into Languages table
    INSERT INTO Languages (Language)
    VALUES (@Language);

    PRINT 'Language added successfully.';
END;
grant execute on dbo.AddGrade to Coordinator;
go

