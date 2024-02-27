CREATE PROCEDURE BuyStudy
    @StudentEmail varchar(50),
    @StudyTitle varchar(50),
    @OrderID int,
    @Paid money = NULL
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @StudentID int, @StudyID int, @Price money;

        -- Check if the specified student exists
        IF NOT EXISTS (SELECT 1 FROM Students WHERE Email = @StudentEmail)
        BEGIN
            PRINT 'Error: Student with email ' + @StudentEmail + ' does not exist.';
        END

        -- Check if the specified study exists
        IF NOT EXISTS (
            SELECT S.StudyID
            FROM Studies AS S
            INNER JOIN Products AS P ON S.StudyID = P.ProductID
            WHERE S.Name = @StudyTitle
        )
        BEGIN
            PRINT 'Error: Webinar with title ' + @StudyTitle + ' does not exist.';
        END

        -- Get StudentID
        SELECT @StudentID = StudentID FROM Students WHERE Email = @StudentEmail;

        -- Get StudyID and Price
        SELECT @StudyID = S.StudyID, @Price = P.Price
        FROM Studies AS S
        INNER JOIN Products AS P ON S.StudyID = P.ProductID
        WHERE S.Name = @StudyTitle;

        --Check if studies are still available to buy
        DECLARE @StudyBegin date;
        SELECT TOP 1 Date = @StudyBegin FROM Lecture AS L
            WHERE L.MeetingID IN
                (SELECT M.MeetingID FROM Meetings as M
                WHERE M.StudyID = @StudyID)
        ORDER BY Date;

        IF NOT (DATEADD(DAY, 3, @StudyBegin) <= GETDATE())
        BEGIN
            PRINT 'It is too late to sign in for ' + @StudyTitle + '.';
        END

        --Check limit
        DECLARE @Count int;
        EXEC CountStudentsOnStudy @StudyID, @Count;
        IF NOT (@Count < (SELECT studies_limit FROM Studies WHERE StudyID = @StudyID))
        BEGIN
            PRINT 'There are too many student signed for' + @StudyTitle + '.';
        END

        -- Set @Paid to 0 if it is NULL
        IF @Paid IS NULL SET @Paid = 0;
    -- Start the transaction
    BEGIN TRANSACTION;

    BEGIN TRY
        -- Insert into OrderDetails
        INSERT INTO OrderDetails (OrderID, ProductID, Price)
        VALUES (@OrderID, @StudyID, @Price);

        -- Commit the transaction
        COMMIT;
        PRINT 'Study purchased successfully.';
    END TRY
    BEGIN CATCH
        -- Rollback the transaction if an error occurs
        ROLLBACK;
        PRINT 'Transaction rolled back. An error occurred during the purchase process.';
    END CATCH;
END;
go

grant execute on BuyStudy to Student
go

