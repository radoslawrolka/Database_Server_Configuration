CREATE PROCEDURE AddMeeting
    @StudyID int,
    @Limit int,
    @Price money
AS
BEGIN
    SET NOCOUNT ON;

    IF @StudyID NOT IN (SELECT StudyID FROM Studies)
    BEGIN
        PRINT 'Study does not exist.';
        RETURN;
    END;

    IF @Limit < 1
    BEGIN
        PRINT 'Limit must be greater than 0.';
        RETURN;
    END;

    INSERT INTO Products (ProductTypeID, Price)
    VALUES (
        (SELECT ProductTypeID FROM ProductType WHERE Name = 'Meeting'),
        @Price
    );

    DECLARE @MeetingID int;
    SET @MeetingID = SCOPE_IDENTITY(); -- Get the identity value of the recently inserted row

    INSERT INTO Meetings (MeetingID, StudyID, Limit)
    VALUES (@MeetingID, @StudyID, @Limit);



    PRINT 'Meeting added successfully.';
END;
grant execute on dbo.AddGrade to Coordinator;
go

