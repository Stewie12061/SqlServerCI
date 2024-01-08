IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0051]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0051]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



---- Xử lý Import chấm công theo Thang (ANGEL)
---- Created on 07/01/2017 Hải Long

CREATE PROCEDURE [DBO].[HP0051]
( 
	@DivisionID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50),	
	@TranMonth AS INT,
	@TranYear AS INT,
	@PeriodID AS NVARCHAR(50),
	@XML AS XML
) 
AS
DECLARE @Cursor AS CURSOR,
		@EmployeeID AS NVARCHAR(50), 
		@AbsentTypeID AS NVARCHAR(50),
		@AbsentAmount AS DECIMAL(28,3),
		@DepartmentID AS NVARCHAR(50), 
		@TeamID AS NVARCHAR(50)

SELECT	X.Data.query('EmployeeID').value('.', 'NVARCHAR(50)') AS EmployeeID,		
		X.Data.query('AbsentTypeID').value('.', 'VARCHAR(50)') AS AbsentTypeID,
		X.Data.query('AbsentAmount').value('.', 'DECIMAL(28,3)') AS AbsentAmount	
INTO #Data		
FROM @XML.nodes('//Data') AS X (Data)


UPDATE		DT
SET			AbsentAmount = ROUND(AbsentAmount, 2)
FROM		#Data DT

SET @Cursor = CURSOR SCROLL KEYSET FOR 
SELECT #Data.EmployeeID, AbsentTypeID, AbsentAmount, DepartmentID, TeamID
FROM #Data
INNER JOIN HT2400 ON HT2400.DivisionID = @DivisionID AND #Data.EmployeeID = HT2400.EmployeeID AND HT2400.TranMonth = @TranMonth AND HT2400.TranYear = @TranYear
OPEN @Cursor
FETCH NEXT FROM @Cursor INTO @EmployeeID, @AbsentTypeID, @AbsentAmount, @DepartmentID, @TeamID
WHILE @@FETCH_STATUS = 0
BEGIN
	IF EXISTS (SELECT TOP 1 1 FROM HT2402 WHERE DivisionID = @DivisionID AND EmployeeID = @EmployeeID AND TranMonth = @TranMonth AND TranYear = @TranYear AND AbsentTypeID = @AbsentTypeID AND PeriodID = @PeriodID)
	BEGIN
		UPDATE HT2402
		SET AbsentAmount = @AbsentAmount,
			LastModifyUserID = @UserID,
			LastModifyDate = GETDATE()
		FROM HT2402 
		WHERE DivisionID = @DivisionID 
		AND EmployeeID = @EmployeeID
		AND TranMonth = @TranMonth 
		AND TranYear = @TranYear 
		AND AbsentTypeID = @AbsentTypeID 
		AND PeriodID = @PeriodID
	END
	ELSE
	BEGIN
		INSERT INTO HT2402(DivisionID, EmployeeID, TranMonth, TranYear, DepartmentID, TeamID, AbsentTypeID, AbsentAmount, PeriodID, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		VALUES(@DivisionID, @EmployeeID, @TranMonth, @TranYear, @DepartmentID, @TeamID, @AbsentTypeID, @AbsentAmount, @PeriodID, @UserID, GETDATE(), @UserID, GETDATE())
	END
	
	FETCH NEXT FROM @Cursor INTO @EmployeeID, @AbsentTypeID, @AbsentAmount, @DepartmentID, @TeamID
END
CLOSE @Cursor
DEALLOCATE @Cursor


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
