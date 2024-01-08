IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0210_MK]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0210_MK]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Ket chuyen cham cong ca sang ngay
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 21/08/2013 by Le Thi Thu Hien
---- 
---- Modified on 08/10/2013 by Le Thi Thu Hien 
---- Modified on 08/11/2016 by Bảo Thy: Bổ sung xử lý tách bảng nghiệp vụ
-- <Example>
---- EXEC HP0210_MK N'CTY','ASOFTADMIN',3,2013,'%','%',N'%',N'%',N'%','2013-3-01','2013-3-31'
CREATE PROCEDURE HP0210_MK
( 
		@DivisionID AS nvarchar(50),
		@UserID AS nvarchar(50),
		@TranMonth AS int,
		@TranYear AS int,
		@FromDepartmentID AS nvarchar(50),
		@ToDepartmentID AS nvarchar(50),
		@TeamID AS nvarchar(50),
		@EmployeeID AS nvarchar(50),
		@AbsentTypeID AS nvarchar(50),		
		@BeginDate AS Datetime,
		@EndDate AS Datetime
) 
AS 
DECLARE @sSQL1 AS nvarchar(MAX),
		@sSQL2 AS nvarchar(MAX),
		@sSQL3 AS nvarchar(MAX),
		@sWHERE AS NVARCHAR(MAX),
		@sGroupBy AS NVARCHAR(MAX),
		@TimeConvert AS decimal(28,8),
		@sSQL001 Nvarchar(4000) ='',
		@TableHT2401 Varchar(50),
		@sTranMonth Varchar(2)

SET @sWHERE = N''
		
SELECT @sTranMonth = CASE WHEN @TranMonth >9 THEN Convert(Varchar(2),@TranMonth) ELSE '0'+Convert(Varchar(1),@TranMonth) END

IF EXISTS (SELECT TOP 1 1 FROM AT0001 WITH (NOLOCK) WHERE IsSplitTable = 1)	
BEGIN
	SELECT  @TableHT2401 = 'HT2401M'+@sTranMonth+Convert(Varchar(4),@TranYear)
END
ELSE
BEGIN
	SELECT  @TableHT2401 = 'HT2401'
END

-------- Giờ công cho 1 ngày
IF NOT EXISTS (SELECT ISNULL(TimeConvert,8) FROM HT0000 WHERE DivisionID = @DivisionID)									
	SET @TimeConvert = 8
ELSE
	SET @TimeConvert = (SELECT ISNULL(TimeConvert,8) FROM HT0000 WHERE DivisionID = @DivisionID)
	
IF @FromDepartmentID <> '' AND @FromDepartmentID <> '%' AND @ToDepartmentID <> '' AND @ToDepartmentID <> '%'
	SET @sWHERE = @sWHERE + '
			AND T01.DepartmentID BETWEEN '''+@FromDepartmentID+''' AND '''+@ToDepartmentID+'''			'
			
------- Lay du lieu cham cong ca	
Set @sSQL1 = N'
SELECT		T01.DivisionID, T01.DepartmentID, ISNULL(T01.TeamID,'''') AS TeamID, 
			T01.EmployeeID, T01.TranMonth, T01.TranYear, 
			T01.AbsentTypeID, T01.AbsentDate,
			SUM(ISNULL(T01.AbsentAmount,0) * ISNULL(T13.ConvertUnit,0)) AS AbsentAmount 
					
INTO		#CHAMCONGCA
FROM		HT0284 T01 
INNER JOIN	HT1013 T13 
	ON		T01.DivisionID = T13.DivisionID
			AND T01.AbsentTypeID = T13.AbsentTypeID 
WHERE		T01.DivisionID = ''' + @DivisionID + ''' 
			AND T01.TranMonth = ' + cast(@TranMonth AS nvarchar(2)) + ' 
			AND	T01.TranYear = ' + cast(@TranYear AS nvarchar(4)) + ' 			
			AND	ISNULL(T01.TeamID,'''') LIKE ISNULL(''' + @TeamID + ''', ''' + ''') 
			AND	T01.EmployeeID LIKE ''' + @EmployeeID + ''' 
			AND T01.AbsentDate BETWEEN ''' + ltrim(month(@BeginDate)) + '/' + ltrim(Day(@BeginDate)) + '/' + ltrim(Year(@BeginDate)) + ''' And ''' 
			+ ltrim(month(@EndDate)) + '/' + ltrim(Day(@EndDate)) + '/' + ltrim(Year(@EndDate)) + ''' 
			AND T13.IsMonth = 0 '+ @sWHERE
SET @sGroupBy = N'
GROUP BY	T01.DivisionID, T01.DepartmentID, ISNULL(T01.TeamID,''''), 
			T01.EmployeeID, T01.TranMonth, T01.TranYear, 
			T01.AbsentTypeID, T01.AbsentDate
'
SET @sSQL2 = N'
DECLARE @cursor AS cursor,
		@TimeConvert AS decimal(28,8),
		@AbsentDate AS DATETIME,	
		@AbsentAmount AS decimal(28,8),
		@TeamID1 nvarchar(50),
		@DepartmentID1 nvarchar(50),
		@EmployeeID1 NVARCHAR(50),
		@TranMonth1 INT,
		@TranYear1 INT,
		@AbsentTypeID1 NVARCHAR(50)

SET @cursor = Cursor scroll keyset for
		SELECT	DepartmentID, TeamID, EmployeeID, TranMonth, TranYear, 
				AbsentTypeID, AbsentDate, AbsentAmount
		FROM	#CHAMCONGCA 
		WHERE	DivisionID = '''+@DivisionID+'''

	OPEN @cursor
	FETCH NEXT FROM @cursor INTO @DepartmentID1, @TeamID1, @EmployeeID1,@TranMonth1, @TranYear1, 
					@AbsentTypeID1, @AbsentDate, @AbsentAmount

	WHILE @@FETCH_STATUS = 0

	  BEGIN
	  	IF NOT EXISTS(SELECT TOP 1 1 FROM '+@TableHT2401+' 
	  	              WHERE		DivisionID = '''+@DivisionID+''' 
								AND EmployeeID = @EmployeeID1 							
								AND TranMonth = @TranMonth1 
								AND TranYear = @TranYear1
								AND AbsentTypeID = @AbsentTypeID1
								AND AbsentDate = @AbsentDate 
								AND DepartmentID = @DepartmentID1 
								AND isnull(TeamID,'''')  = isnull(@TeamID1,'''')) 
											
		INSERT INTO '+@TableHT2401+' ( EmployeeID, TranMonth, TranYear, DivisionID, DepartmentID, TeamID, 
							AbsentTypeID, AbsentDate, AbsentAmount, 
							CreateUserID, CreateDate, LastModifyUserID, LastModifyDate )
		VALUES (@EmployeeID1, @TranMonth1, @TranYear1, '''+@DivisionID+''',@DepartmentID1, @TeamID1, 
				@AbsentTypeID1, @AbsentDate , @AbsentAmount, 
				'''+@UserID+''', GETDATE(), '''+@UserID+''', GETDATE())
	ELSE
		UPDATE	'+@TableHT2401+' 
		SET		AbsentAmount = @AbsentAmount 
		WHERE	DivisionID = '''+@DivisionID+'''
				AND EmployeeID = @EmployeeID1 							
				AND TranMonth = @TranMonth1 
				AND TranYear = @TranYear1
				AND AbsentTypeID = @AbsentTypeID1 
				AND AbsentDate = @AbsentDate
				AND DepartmentID = @DepartmentID1 
				AND isnull(TeamID,'''')  = isnull(@TeamID1,'''')
				
	FETCH NEXT FROM @cursor into @DepartmentID1, @TeamID1, @EmployeeID1,@TranMonth1, @TranYear1, 
					@AbsentTypeID1, @AbsentDate, @AbsentAmount
	END
	CLOSE @cursor
	DEALLOCATE @cursor
	'
EXEC (@sSQL1+@sWHERE+@sGroupBy+@sSQL2)	  				
--PRINT(@sSQL1)
--PRINT(@sWHERE)
--PRINT(@sGroupBy)
--PRINT(@sSQL2)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
