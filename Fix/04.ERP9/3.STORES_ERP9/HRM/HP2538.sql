IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP2538]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP2538]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


--------- 	Created by Hải Long, Date 08/12/2016
---------	Modify on 06/01/2014 by ...
---- EXEC HP2538 @DivisionID=N'MK',@LstDepartmentID=N'A000000,P000000',@LstTeamID=N'AHR0000,PE20000',@EmployeeID=N'',@TranMonth=11,@TranYear=2016,@Mode=1,@CreateUserID=N'ASOFTADMIN',@CreateDate='2016-12-19 13:07:57.797'

CREATE PROCEDURE [dbo].[HP2538]  
				@DivisionID as nvarchar(50),
				@LstDepartmentID as nvarchar(MAX),
				@LstTeamID as nvarchar(MAX),
				@EmployeeID as nvarchar(50),
				@TranMonth as int,
				@TranYear as int,
				@LastTranMonth INT,
				@LastTranYear INT, 
				@Mode as tinyint,
				@CreateDate as datetime,
				@CreateUserID as nvarchar(50)
				
AS
DECLARE @sSQL NVARCHAR(MAX),
		@sSQL1 NVARCHAR(MAX),
		@sWhere NVARCHAR(4000) = '',
		@sWhere1 NVARCHAR(4000) = '',
		@sWhere2 NVARCHAR(4000) = ''

IF ISNULL(@LstDepartmentID, '') <> '%' AND ISNULL(@LstDepartmentID, '') <> ''
BEGIN
	SET @sWhere = '
			AND HT1400.DepartmentID IN ('''+REPLACE(@LstDepartmentID, ',', ''',''')+''')' 
END

IF ISNULL(@LstTeamID, '') <> '%' AND ISNULL(@LstTeamID, '') <> ''
BEGIN
	SET @sWhere1 = '
			AND HT1400.TeamID IN ('''+REPLACE(@LstTeamID, ',', ''',''')+''')' 
END

IF ISNULL(@EmployeeID, '') <> '%' AND ISNULL(@EmployeeID, '') <> ''
BEGIN
	SET @sWhere2 = '
			AND HT1400.EmployeeID LIKE ''%'+@EmployeeID+'%'''
END

SET @sSQL = '
DECLARE @Cs_EmployeeID as nvarchar(50),
		@Cs_MethodVacationID as nvarchar(50),
		@Cs_DaysPrevMonth AS DECIMAL(28,8), 
		@Cs_DaysInYear AS DECIMAL(28,8), 
		@Cs_VacSeniorDays AS DECIMAL(28,8), 
		@Cs_AddDays AS DECIMAL(28,8), 
		@Cs_DaysRemained AS DECIMAL(28,8),
		@Cursor as CURSOR'

IF @Mode = 1	 --- 	ho so nhan su
  BEGIN
  	SET @sSQL1 = '
  		SET @Cursor = CURSOR SCROLL KEYSET FOR
		SELECT EmployeeID
		FROM HT1400 
		WHERE 	HT1400.DivisionID = ''' + @DivisionID + ''' 
			    ' + @sWhere + @sWhere1 + @sWhere2 + '
				AND HT1400.EmployeeID NOT IN (SELECT EmployeeID FROM HT2803 WITH (NOLOCK) WHERE DivisionID = ''' + @DivisionID + ''' AND TranMonth = ' + CONVERT(NVARCHAR(10), @TranMonth) + ' AND TranYear = ' + CONVERT(NVARCHAR(10), @TranYear) + ')
				AND (EmployeeStatus  = 1 or EmployeeStatus  = 2)

	OPEN @Cursor
	FETCH NEXT FROM @Cursor INTO  @Cs_EmployeeID

--print "1";
	WHILE @@FETCH_STATUS = 0
	  BEGIN	
		INSERT INTO HT2803 (DivisionID, EmpLoaMonthID, EmployeeID, TranMonth, TranYear,
				CreateDate, CreateUserID, LastModifyDate, LastModifyUserID)
			VALUES (''' + @DivisionID + ''', NEWID(), @Cs_EmployeeID, '+CONVERT(NVARCHAR(10), @TranMonth)+', '+CONVERT(NVARCHAR(10), @TranYear)+',
				'''+CONVERT(NVARCHAR(50), @CreateDate)+''', '''+@CreateUserID+''', '''+CONVERT(NVARCHAR(50), @CreateDate)+''', '''+@CreateUserID+''')

		FETCH NEXT FROM @Cursor INTO  @Cs_EmployeeID
	  END
	  	  
	CLOSE @Cursor
	DEALLOCATE @Cursor' 	  
  END
  
ELSE -- Mode = 2 Ho so phep  
  BEGIN
  	SET @sSQL1 = '
  		SET @Cursor = CURSOR SCROLL KEYSET FOR
		SELECT HT2803.EmployeeID, HT2803.MethodVacationID, HT2803.DaysPrevMonth, HT2803.DaysInYear, HT2803.VacSeniorDays, HT2803.AddDays, HT2803.DaysRemained
		FROM HT2803 
		LEFT JOIN HT1400 ON HT1400.DivisionID = HT2803.DivisionID AND HT1400.EmployeeID = HT2803.EmployeeID
		WHERE	HT2803.DivisionID = ''' + @DivisionID + '''
			    ' + @sWhere + @sWhere1 + @sWhere2 + '
				AND HT2803.EmployeeID NOT IN (SELECT EmployeeID FROM HT2803 WITH (NOLOCK) WHERE DivisionID = ''' + @DivisionID + ''' AND TranMonth = ' + CONVERT(NVARCHAR(10), @TranMonth) + ' AND TranYear = ' + CONVERT(NVARCHAR(10), @TranYear) + ')
				AND HT2803.TranMonth = ' + CONVERT(NVARCHAR(10),@LastTranMonth) + '
				AND HT2803.TranYear = ' + CONVERT(NVARCHAR(10),@LastTranYear) + '
		ORDER BY HT2803.EmployeeID

	OPEN @Cursor
	FETCH NEXT FROM @Cursor INTO  @Cs_EmployeeID, @Cs_MethodVacationID, @Cs_DaysPrevMonth, @Cs_DaysInYear, @Cs_VacSeniorDays, @Cs_AddDays, @Cs_DaysRemained

--print "1";
	WHILE @@FETCH_STATUS = 0
	  BEGIN
		INSERT INTO HT2803 (DivisionID, EmpLoaMonthID, EmployeeID, MethodVacationID, DaysPrevMonth, DaysInYear, 
							VacSeniorDays, TranMonth, TranYear, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID)
		VALUES (''' + @DivisionID + ''', NEWID(), @Cs_EmployeeID, @Cs_MethodVacationID, @Cs_DaysRemained, @Cs_DaysInYear, 
				@Cs_VacSeniorDays, '+CONVERT(NVARCHAR(10), @TranMonth)+', '+CONVERT(NVARCHAR(10), @TranYear)+', '''+CONVERT(NVARCHAR(50), @CreateDate)+''', '''+@CreateUserID+''', '''+CONVERT(NVARCHAR(50), @CreateDate)+''', '''+@CreateUserID+''')
				
		FETCH NEXT FROM @Cursor INTO  @Cs_EmployeeID, @Cs_MethodVacationID, @Cs_DaysPrevMonth, @Cs_DaysInYear, @Cs_VacSeniorDays, @Cs_AddDays, @Cs_DaysRemained
	  END
	  	  
	CLOSE @Cursor
	DEALLOCATE @Cursor'	  
  END
  
EXEC (@sSQL+@sSQL1) 
PRINT @sSQL
PRINT @sSQL1  
  
  
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO  
  