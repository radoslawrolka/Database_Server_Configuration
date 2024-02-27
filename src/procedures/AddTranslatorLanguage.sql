CREATE PROCEDURE AddTranslatorLanguage
    @TranslatorID int,
    @Language varchar(30)
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT * FROM Translators WHERE TranslatorID = @TranslatorID)
    BEGIN
        PRINT 'Translator does not exist.';
        RETURN;
    END;

    IF NOT EXISTS (SELECT * FROM Languages WHERE Language = @Language)
    BEGIN
        EXEC AddLanguage @Language;
    END;


    DECLARE @LanguageID int;
    SELECT @LanguageID = LanguageID FROM Languages WHERE Language = @Language;

    -- Insert into TranslatorsLanguage table
    INSERT INTO TranslatorsLanguage (TranslatorID, LanguageID)
    VALUES (@TranslatorID, @LanguageID);

    PRINT 'Translator Language added successfully.';
END;
go

