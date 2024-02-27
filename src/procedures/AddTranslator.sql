CREATE PROCEDURE AddTranslator
   @FirstName varchar(30),
   @LastName varchar(30),
   @BirthDate date,
   @HireDate date,
   @Address varchar(30),
   @City varchar(30),
   @Country varchar(30),
   @PostalCode varchar(10),
   @Email varchar(50),
   @PhoneNumber varchar(12),
    @Language varchar(30)
AS
BEGIN
   SET NOCOUNT ON;

   IF EXISTS (
       SELECT 1
       FROM Translators
       WHERE Email = @Email
   )
   BEGIN
       PRINT 'Error: Translator with the same email already exists.';
       RETURN;
   END

   IF EXISTS (
       SELECT 1
       FROM Translators
       WHERE PhoneNumber = @PhoneNumber
   )
    BEGIN
         PRINT 'Error: Translator with the same phone number already exists.';
         RETURN;
    END

    IF YEAR(@BirthDate) < 1900
    BEGIN
        PRINT 'Error: Birth date is invalid.';
        RETURN;
    END

    IF YEAR(@HireDate) < 2019
    BEGIN
        PRINT 'Error: Hire date is invalid.';
        RETURN;
    END

    SET @City = (SELECT CityID FROM Cities WHERE CityName = @City);
    SET @Country = (SELECT CountryID FROM Countries WHERE CountryName = @Country);

    IF NOT EXISTS (
        SELECT *
        FROM CountryCity
        WHERE CityID = @City AND CountryID = @Country
    )
    BEGIN
        EXEC AddCountryCity @City, @Country;
    END


    DECLARE @CityCountryID int;
    SET @CityCountryID = (SELECT CountryCityID FROM CountryCity WHERE CityID = @City AND CountryID = @Country);

   INSERT INTO Translators (FirstName, LastName, BirthDate, HireDate, Adress, CountryCityID, PostalCode, Email, PhoneNumber)
   VALUES (@FirstName, @LastName, @BirthDate, @HireDate, @Address, @CityCountryID, @PostalCode, @Email, @PhoneNumber);

   DECLARE @TranslatorID int;
    SET @TranslatorID = (SELECT TranslatorID FROM Translators WHERE Email = @Email);
   EXEC AddTranslatorLanguage @TranslatorID, @Language;


   PRINT 'Translator added successfully.';
END;
go

