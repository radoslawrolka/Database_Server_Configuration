CREATE PROCEDURE AddStudent
    @FirstName varchar(30),
    @LastName varchar(30),
    @BirthDate date,
    @Email varchar(50),
    @PhoneNumber varchar(12)
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if the email is unique before inserting
    IF NOT EXISTS (SELECT 1 FROM Students WHERE Email = @Email)
    BEGIN
        INSERT INTO Students (FirstName, LastName, BirthDate, Email, PhoneNumber)
        VALUES (@FirstName, @LastName, @BirthDate, @Email, @PhoneNumber);

        PRINT 'Student added successfully.';
    END
    ELSE
    BEGIN
        PRINT 'Error: Email already exists. Please use a unique email address.';
    END
END;
go

