CREATE OR ALTER TRIGGER UPDATE_BONUS_TUTOR
ON CABIN
AFTER UPDATE
AS
BEGIN
    DECLARE @newEmployeeID INT = (SELECT EmployeeID FROM inserted)
    DECLARE @oldEmployeeID INT = (SELECT EmployeeID FROM deleted)
    DECLARE @cabinCount INT

    -- Actualizar TutorBonus del nuevo tutor asignado
    IF @newEmployeeID IS NOT NULL AND (@oldEmployeeID IS NULL OR @newEmployeeID != @oldEmployeeID)
    BEGIN
        SET @cabinCount = (SELECT COUNT(*) FROM CABIN WHERE EmployeeID = @newEmployeeID)

        UPDATE EMPLOYEE
        SET TutorBonus = @cabinCount * 40
        WHERE EmployeeID = @newEmployeeID
    END

    -- Recalcular TutorBonus del tutor anterior si fue reemplazado
    IF @oldEmployeeID IS NOT NULL AND (@newEmployeeID IS NULL OR @oldEmployeeID != @newEmployeeID)
    BEGIN
        SET @cabinCount = (SELECT COUNT(*) FROM CABIN WHERE EmployeeID = @oldEmployeeID)

        UPDATE EMPLOYEE
        SET TutorBonus = @cabinCount * 40
        WHERE EmployeeID = @oldEmployeeID
    END
END
