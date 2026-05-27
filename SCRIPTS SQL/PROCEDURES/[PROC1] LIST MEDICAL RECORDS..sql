CREATE OR ALTER PROCEDURE LIST_MEDICAL_RECORDS
AS
BEGIN

	DECLARE @childID int, @name varchar(100), @gender char(1), @dateOfBirth date
	DECLARE @list varchar(max) = ''

	DECLARE cursor_child CURSOR
	FOR SELECT DISTINCT MEDICAL_ISSUE.ChildID, Name, Gender, DateOfBirth
	FROM CHILD, MEDICAL_ISSUE
	WHERE CHILD.ChildID = MEDICAL_ISSUE.ChildID

	OPEN cursor_child
	FETCH NEXT FROM cursor_child INTO @childID, @name, @gender, @dateOfBirth

	WHILE @@FETCH_STATUS = 0
	BEGIN
		
		PRINT 
			'Name: ' + @name + '  ' + 
			CASE 
				WHEN @gender = 'F' THEN 'Female' 
				WHEN @gender = 'M' THEN 'Male'
			END
			+ '  Age: ' + cast(DATEDIFF(DAY, @dateOfBirth, GETDATE())/365 AS VARCHAR)

		PRINT REPLICATE('-', 40)

		SELECT @list = @list + CHAR(9) + cast(Number as char(4)) + CAST(IssueDescription AS CHAR(55)) + CHAR(10) +
		CHAR(9) + CHAR(9) + 'Medication: ' + CAST(ISNULL(Medication, 'None') AS CHAR(25)) + CHAR(10) +
		CHAR(9) + CHAR(9) + 'Special Needs: ' + CAST(ISNULL(SpecialNeeds, 'None') AS CHAR(35)) + CHAR(10) + CHAR(10)
		FROM MEDICAL_ISSUE
		WHERE ChildID = @childID

		PRINT @list
		SET @list = ''

		FETCH NEXT FROM cursor_child INTO @childID, @name, @gender, @dateOfBirth
	END

	CLOSE cursor_child
	DEALLOCATE cursor_child

END

--EXEC LIST_MEDICAL_RECORDS