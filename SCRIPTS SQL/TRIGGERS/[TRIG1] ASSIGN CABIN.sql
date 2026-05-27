CREATE OR ALTER TRIGGER ASSIGN_CABIN
ON CHILD
AFTER INSERT
AS
BEGIN
    DECLARE @childID INT
    DECLARE @gender VARCHAR(1)
    DECLARE @cabinID INT

    DECLARE cursor_children CURSOR
    FOR SELECT ChildID, Gender 
    FROM inserted

    OPEN cursor_children
    FETCH NEXT FROM cursor_children INTO @childID, @gender

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @cabinID = (SELECT TOP 1 CABIN.CabinID
                        FROM CABIN
                        LEFT JOIN CHILD 
                        ON CHILD.CabinID = CABIN.CabinID
                        WHERE Type = @gender
                        GROUP BY CABIN.CabinID, Spots
                        HAVING COUNT(ChildID) < Spots)

        IF @cabinID IS NULL
        BEGIN
            PRINT 'No cabins available'
            ROLLBACK
            RETURN
        END

        UPDATE CHILD
        SET CabinID = @cabinID
        WHERE ChildID = @childID

        FETCH NEXT FROM cursor_children INTO @childID, @gender
    END

    CLOSE cursor_children
    DEALLOCATE cursor_children
END