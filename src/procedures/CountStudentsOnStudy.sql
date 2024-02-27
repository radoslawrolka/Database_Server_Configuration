CREATE PROCEDURE CountStudentsOnStudy
    @StudyID INT,
    @Count INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT @Count = COUNT(*) FROM Students AS S
    WHERE S.StudentID IN(
            SELECT O.StudentID FROM [Order] AS O
            WHERE O.OrderID IN(
                SELECT OD.OrderID FROM OrderDetails AS OD
                    WHERE OD.ProductID IN(
                        SELECT P.ProductID FROM Products AS P
                        WHERE P.ProductID IN(
                            SELECT StudyID FROM Studies
                            WHERE StudyID = @StudyID
                            )
                        )
                    )
            )
END;
grant execute on CountStudentsOnStudy to Director;
go

