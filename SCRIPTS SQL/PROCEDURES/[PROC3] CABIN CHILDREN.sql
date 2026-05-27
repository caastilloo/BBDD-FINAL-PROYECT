CREATE OR ALTER PROCEDURE CABIN_CHILDREN @type char(1)
AS
BEGIN
	
	DECLARE @cabinID int, @name varchar(80), @tutor varchar(100), @slots int
	DECLARE @list varchar(max) = ''

	DECLARE cursor_cabin CURSOR
	FOR SELECT CabinID , CABIN.Name, EMPLOYEE.Name, Spots
	FROM CABIN, EMPLOYEE
	WHERE CABIN.EmployeeID = EMPLOYEE.EmployeeID
		AND Type = @type

	OPEN cursor_cabin 
	FETCH NEXT FROM cursor_cabin INTO @cabinID, @name, @tutor, @slots

	WHILE @@FETCH_STATUS = 0
	BEGIN
		
		PRINT 'Name: ' + @name + SPACE(5) + 'Tutor: ' + @tutor + SPACE(5) + 'N. Slots: ' + CAST(@slots AS VARCHAR)
		PRINT REPLICATE('-', 50)

		SELECT @list = @list + CHILD.Name + ' - ' + CAST(DateOfBirth AS VARCHAR) + CHAR(10) + SPACE(20) +
		STRING_AGG(ACTIVITY.Name, CHAR(10) + SPACE(20)) + CHAR(10) + CHAR(10)
		FROM CHILD, REGISTER, ACTIVITY
		WHERE CHILD.ChildID = REGISTER.ChildID
			AND REGISTER.ActivityID = ACTIVITY.ActivityID
			AND CabinID = @cabinID
		GROUP BY CHILD.Name, DateOfBirth

		PRINT @list

		FETCH NEXT FROM cursor_cabin INTO @cabinID, @name, @tutor, @slots
	END

	CLOSE cursor_cabin
	DEALLOCATE cursor_cabin
END

--EXEC CABIN_CHILDREN 'F'