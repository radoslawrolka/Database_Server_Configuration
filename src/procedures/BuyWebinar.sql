CREATE PROCEDURE BuyWebinar
    @StudentEmail varchar(50),
    @WebinarTitle varchar(50),
    @Paid money = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Declare variables
    DECLARE @StudentID int, @WebinarID int, @Price money;
    DECLARE @OrderID int;


        -- Check if the specified student exists
        IF NOT EXISTS (SELECT 1 FROM Students WHERE Email = @StudentEmail)
        BEGIN
            PRINT 'Error: Student with email ' + @StudentEmail + ' does not exist.';
        END

        -- Check if the specified webinar exists
        IF NOT EXISTS (
            SELECT 1
            FROM Webinars AS W
            INNER JOIN Products AS P ON W.WebinarID = P.ProductID
            WHERE W.Title = @WebinarTitle
        )
        BEGIN
            PRINT 'Error: Webinar with title ' + @WebinarTitle + ' does not exist.';
        END

        -- Get StudentID
        SELECT @StudentID = StudentID FROM Students WHERE Email = @StudentEmail;

        -- Get WebinarID and Price
        SELECT @WebinarID = W.WebinarID, @Price = P.Price
        FROM Webinars AS W
        INNER JOIN Products AS P ON W.WebinarID = P.ProductID
        WHERE W.Title = @WebinarTitle;

        -- Set @Paid to 0 if it is NULL
        IF @Paid IS NULL SET @Paid = 0;
    -- Start the transaction
    BEGIN TRANSACTION;

    BEGIN TRY
        -- Insert into Order
        INSERT INTO [Order] (StudentID, Paid, Date, PaidDate)
        VALUES (@StudentID, @Paid, GETDATE(), GETDATE());

        -- Get the OrderID of the recently inserted order
        SET @OrderID = SCOPE_IDENTITY();

        -- Insert into OrderDetails
        INSERT INTO OrderDetails (OrderID, ProductID, Price)
        VALUES (@OrderID, @WebinarID, @Price);

        -- Commit the transaction
        COMMIT;
        PRINT 'Webinar purchased successfully.';
    END TRY
    BEGIN CATCH
        -- Rollback the transaction if an error occurs
        ROLLBACK;
        PRINT 'Transaction rolled back. An error occurred during the purchase process.';
    END CATCH;
END;
go

grant execute on BuyWebinar to Student
go

