CREATE OR ALTER TRIGGER UPDATE_EMPLOYEE_ACTIVITY
ON ACTIVITY
AFTER INSERT
AS
BEGIN
    DECLARE @activityID INT = (SELECT ActivityID FROM inserted)
    DECLARE @timeSlot VARCHAR(50) = (SELECT TimeSlot FROM inserted)
    DECLARE @days VARCHAR(50) = (SELECT Days FROM inserted)
    DECLARE @emp1 INT
    DECLARE @emp2 INT
    DECLARE @leastLoadedCoach INT

    -- Primer empleado: sin conflicto de horario, con menos actividades
    SET @emp1 = (SELECT TOP 1 EmployeeID 
                FROM EMPLOYEE 
                WHERE Position = 'Coach' 
                    AND EmployeeID NOT IN (
                        SELECT IN_CHARGE.EmployeeID
                        FROM IN_CHARGE, ACTIVITY
                        WHERE IN_CHARGE.ActivityID = ACTIVITY.ActivityID
                            AND ACTIVITY.TimeSlot = @timeSlot 
                            AND ACTIVITY.Days = @days)
                        ORDER BY (SELECT COUNT(*) FROM IN_CHARGE WHERE IN_CHARGE.EmployeeID = EMPLOYEE.EmployeeID) ASC)

    IF @emp1 IS NULL
    BEGIN
        PRINT 'No available employee for first assignment'
        ROLLBACK
        RETURN
    END

    -- Segundo empleado: distinto al primero, sin conflicto de horario
    SET @emp2 = (SELECT TOP 1 EmployeeID 
                FROM EMPLOYEE
                WHERE Position = 'Coach'
                AND EmployeeID != @emp1
                AND EmployeeID NOT IN (
                    SELECT IN_CHARGE.EmployeeID
                    FROM IN_CHARGE, ACTIVITY 
                    WHERE IN_CHARGE.ActivityID = ACTIVITY.ActivityID
                        AND ACTIVITY.TimeSlot = @timeSlot 
                        AND ACTIVITY.Days = @days)
                    ORDER BY (SELECT COUNT(*) FROM IN_CHARGE WHERE IN_CHARGE.EmployeeID = EMPLOYEE.EmployeeID) ASC)

    IF @emp2 IS NULL
    BEGIN
        PRINT 'No available second employee for assignment'
        ROLLBACK
        RETURN
    END

    -- Insertar ambos en IN_CHARGE con bonus de 50
    INSERT INTO IN_CHARGE (EmployeeID, ActivityID, Bonus)
    VALUES (@emp1, @activityID, 50)

    INSERT INTO IN_CHARGE (EmployeeID, ActivityID, Bonus)
    VALUES (@emp2, @activityID, 50)

    -- Actualizar ActivitiesBonus +50 a ambos empleados
    UPDATE EMPLOYEE
    SET ActivitiesBonus = ISNULL(ActivitiesBonus, 0) + 50
    WHERE EmployeeID IN (@emp1, @emp2)

    -- Asignar como tutor al coach con menos actividades a la cabana con menos carga
    SET @leastLoadedCoach = (SELECT TOP 1 EmployeeID
                            FROM EMPLOYEE
                            WHERE Position = 'Coach'
                            ORDER BY (SELECT COUNT(*) FROM IN_CHARGE WHERE IN_CHARGE.EmployeeID = EMPLOYEE.EmployeeID) ASC)

    UPDATE TOP (1) CABIN
    SET EmployeeID = @leastLoadedCoach
    WHERE EmployeeID NOT IN (SELECT EmployeeID
                            FROM EMPLOYEE 
                            WHERE Position = 'Coach')
END
