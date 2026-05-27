CREATE OR ALTER PROCEDURE EMPLOYEES_SALARY
AS
BEGIN

	DECLARE @list varchar(max) = ''

	PRINT 'Name' + SPACE(15) + 'Phone N.' + SPACE(4) + 'Position' + SPACE(3) + 'Salary' + SPACE(3) + 'Bonus Act'
	+ SPACE(3) + 'Bonus Tutor'
	PRINT REPLICATE('-', 80)

	SELECT @list = @list + CAST(Name AS CHAR(19)) + CAST(Phone AS CHAR(12)) + CAST(Position AS CHAR(11)) 
	+ CAST(Salary AS CHAR(14)) + CAST(ActivitiesBonus AS CHAR(14)) + CAST(TutorBonus AS VARCHAR) + CHAR(10)
	FROM EMPLOYEE

	PRINT @list

END

--EXEC EMPLOYEES_SALARY