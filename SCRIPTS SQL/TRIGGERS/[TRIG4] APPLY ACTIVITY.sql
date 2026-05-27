CREATE OR ALTER TRIGGER APPLY_ACTIVITY
ON REGISTER
AFTER INSERT
AS
BEGIN
    DECLARE @childID INT = (SELECT ChildID FROM inserted)
    DECLARE @activityID INT = (SELECT ActivityID FROM inserted)
    DECLARE @childName VARCHAR(100) = (SELECT Name FROM CHILD WHERE ChildID = @childID)
    DECLARE @availableSpots INT = (SELECT AvailableSpots FROM ACTIVITY WHERE ActivityID = @activityID)
    DECLARE @registered INT = (SELECT COUNT(*) FROM REGISTER WHERE ActivityID = @activityID)
    DECLARE @timeSlot VARCHAR(50) = (SELECT TimeSlot FROM ACTIVITY WHERE ActivityID = @activityID)
    DECLARE @days VARCHAR(50) = (SELECT Days FROM ACTIVITY WHERE ActivityID = @activityID)
    DECLARE @totalActivities INT = (SELECT COUNT(*) FROM REGISTER WHERE ChildID = @childID)
    DECLARE @conflict INT = (SELECT COUNT(*) FROM REGISTER, ACTIVITY WHERE REGISTER.ActivityID = ACTIVITY.ActivityID 
                                                                        AND TimeSlot = @timeSlot AND Days = @days 
                                                                        AND REGISTER.ActivityID != @activityID
                                                                        AND ChildID = @childID)    
    -- 1. Comprobar plazas disponibles
    IF @registered > @availableSpots
    BEGIN
        PRINT 'There are not places enough'
        ROLLBACK
        RETURN
    END

    -- 2. Comprobar conflicto de horario del niño
    IF @conflict > 0
    BEGIN
        PRINT @childName + ' already applied for an activity at the same time and days'
        ROLLBACK
        RETURN
    END

    -- 3. Comprobar límite de 4 actividades
    IF @totalActivities > 4
    BEGIN
        PRINT @childName + ' already applied for 4 activities'
        ROLLBACK
        RETURN
    END
END