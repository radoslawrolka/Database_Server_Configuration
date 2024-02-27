CREATE PROCEDURE BuyCourse
    @StudentEmail varchar(50),
    @CourseTitle varchar(50),
    @OrderID int,
    @Paid money = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Declare variables
    DECLARE @StudentID int, @CourseID int, @Price money;

        -- Check if the specified student exists
        IF NOT EXISTS (SELECT 1 FROM Students WHERE Email = @StudentEmail)
        BEGIN
            PRINT 'Error: Student with email ' + @StudentEmail + ' does not exist.';
        END

        -- Check if the specified webinar exists
        IF NOT EXISTS (
            SELECT 1
            FROM Courses AS C
            INNER JOIN Products AS P ON C.CourseID = P.ProductID
            WHERE C.Title = @CourseTitle
        )
        BEGIN
            PRINT 'Error: Webinar with title ' + @CourseTitle + ' does not exist.';
        END

        -- Get StudentID
        SELECT @StudentID = StudentID FROM Students WHERE Email = @StudentEmail;

        -- Get WebinarID and Price
        SELECT @CourseID = C.CourseID, @Price = P.Price
        FROM Courses AS C
        INNER JOIN Products AS P ON C.CourseID = P.ProductID
        WHERE C.Title = @CourseTitle;

        IF EXISTS (
            select 1
            FROM [Order] AS O
            inner join OrderDetails OD on O.OrderID = OD.OrderID
            where O.StudentID = @StudentID and OD.ProductID = @CourseID
            )
        begin
            print 'Error: Student with email ' + @StudentEmail + ' already bought webinar with title ' + @CourseTitle + '.';
        end

    -- Start the transaction
    BEGIN TRANSACTION;

    BEGIN TRY
        -- Insert into OrderDetails
        INSERT INTO OrderDetails (OrderID, ProductID, Price)
        VALUES (@OrderID, @CourseID, @Price);

        -- Commit the transaction
        COMMIT;
        PRINT 'Course purchased successfully.';
    END TRY
    BEGIN CATCH
        -- Rollback the transaction if an error occurs
        ROLLBACK;
        PRINT 'Transaction rolled back. An error occurred during the purchase process.';
    END CATCH;
END;
go

grant execute on BuyCourse to Student
go

