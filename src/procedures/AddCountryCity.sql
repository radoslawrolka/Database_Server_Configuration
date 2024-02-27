CREATE PROCEDURE AddCountryCity
    @Country varchar(30),
    @City varchar(30)
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT @Country IN (
       SELECT CountryName FROM Countries
   )
   BEGIN
       INSERT INTO Countries (CountryName)
        VALUES (@Country)
   END

   IF NOT @City IN (
       SELECT CityName FROM Cities
   )
    BEGIN
         INSERT INTO Cities (CityName)
          VALUES (@City)
    END

    SET @Country = (SELECT CountryID FROM Countries WHERE CountryName = @Country)
    SET @City = (SELECT CityID FROM Cities WHERE CityName = @City)

    IF NOT EXISTS (
        SELECT * FROM CountryCity
        WHERE CountryID = @Country AND CityID = @City
    )
    BEGIN
        INSERT INTO CountryCity (CountryID, CityID)
        VALUES (@Country, @City)
    END


END;
go

