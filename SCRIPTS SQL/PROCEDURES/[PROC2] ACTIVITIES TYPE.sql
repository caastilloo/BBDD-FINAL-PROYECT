CREATE OR ALTER PROCEDURE ACTIVITIES_TYPE @type varchar(20)
AS
BEGIN

	DECLARE @actID int, @name varchar(100), @description varchar(250), 
	@days varchar(15), @timeslot varchar(20), @available int
	DECLARE @coach1ID int, @coach1 varchar(100), @coach2 varchar(100)

	DECLARE @list varchar(max) = ''

	DECLARE cursor_activity CURSOR
	FOR SELECT ActivityID, Name, Description, Days, TimeSlot, AvailableSpots
	FROM ACTIVITY
	WHERE Type = @type

	OPEN cursor_activity
	FETCH NEXT FROM cursor_activity INTO @actID, @name, @description, @days, @timeslot, @available

	WHILE @@FETCH_STATUS = 0
	BEGIN

		PRINT REPLICATE('-', 50)

		PRINT @name + char(10) + @description + char(10) + @days + SPACE(4) + @timeslot + SPACE(4) 
		+ 'Available Spots: ' + cast(@available as varchar)

		SET @coach1ID = (SELECT TOP 1 IN_CHARGE.EmployeeID 
						FROM IN_CHARGE, EMPLOYEE 
						WHERE EMPLOYEE.EmployeeID = IN_CHARGE.EmployeeID
							AND ActivityID = @actID)

		SET @coach1 = (SELECT TOP 1 Name 
						FROM IN_CHARGE, EMPLOYEE 
						WHERE EMPLOYEE.EmployeeID = IN_CHARGE.EmployeeID
							AND ActivityID = @actID)

		SET @coach2 = (SELECT TOP 1 Name
						FROM EMPLOYEE, IN_CHARGE 
						WHERE EMPLOYEE.EmployeeID = IN_CHARGE.EmployeeID
							AND IN_CHARGE.ActivityID = @actID
							AND IN_CHARGE.EmployeeID != @coach1ID)

		PRINT 'Coach1: ' + @coach1 + CHAR(9) + 'Coach2: ' + @coach2

		PRINT REPLICATE('-', 50)
		PRINT 'CHILD           GENDER  AGE    PARENT1           PARENT2'

		SELECT @list = @list + CAST(CHILD.Name AS CHAR(18)) + CAST(CHILD.Gender AS CHAR(6)) +
		CAST(DATEDIFF(DAY, DateOfBirth, GETDATE())/365 AS CHAR(7)) + CAST(concat(PARENT.Name, ' ', PARENT.Surnames) AS varchar) + char(10)
		FROM CHILD, REGISTER, HAS_PARENT, PARENT
		WHERE CHILD.ChildID = REGISTER.ChildID
			AND CHILD.ChildID = HAS_PARENT.ChildID
			AND HAS_PARENT.ParentID = PARENT.ParentID
			AND ActivityID = @actID

		PRINT @list
		SET @list = ''

		FETCH NEXT FROM cursor_activity INTO @actID, @name, @description, @days, @timeslot, @available
	END

	CLOSE cursor_activity
	DEALLOCATE cursor_activity

END

--EXEC ACTIVITIES_TYPE 'Physical'
--EXEC ACTIVITIES_TYPE 'Recreational'
