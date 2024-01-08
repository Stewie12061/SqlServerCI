IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0552]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0552]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Xem thông tin chi tiết chấm công (MAITHU)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Lê Hoàng, Date: 20/05/2021
/*-- <Example>
	HP0552 @DivisionID = 'VF', @StrDivisionID = '', @UserID = 'ASOFTADMIN', @TranMonth = 12, @TranYear = 2017, @DepartmentID = '', @TeamID = '', @EmployeeID = '', 
	@FromProductID = '', @ToProductID = ''

	HP0552 @DivisionID, @UserID, @StrDivisionID, @TranMonth, @TranYear, @DepartmentID, @TeamID, @EmployeeID, @FromProductID, @ToProductID
----*/

CREATE PROCEDURE HP0552
( 
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50), 
	@ProducingProcessID VARCHAR(MAX),
	@PhaseID VARCHAR(50),
	@IsAllProcess INT,
	@IsDate INT,
	@TranMonth INT,
	@TranYear INT,
	@Date DATETIME
)

AS 
DECLARE @sSQL NVARCHAR(MAX) = N'', 
		@sWhere NVARCHAR(MAX) = N''

IF @IsDate = 0
BEGIN
	SET @sWhere = @sWhere + N' 
	AND H94.TranMonth = ' + STR(@TranMonth) + ' AND H94.TranYear = ' + STR(@TranYear) + ' ' 
END
ELSE
BEGIN
	SET @sWhere = @sWhere + N' 
	AND CONVERT(DATE,H94.TimekeepingDate) = ''' + CONVERT(NVARCHAR(50), CONVERT(DATE,@Date)) + '''' 
END

IF @IsAllProcess = 0
BEGIN
	SET @sWhere = @sWhere + N'
	AND H94.PhaseID = ''' + @PhaseID + ''' ' 
END

SET @sSQL = N'SELECT H94.APK,H94.DivisionID,H94.ProductID,H01.ProductName,H94.PriceSheetID,
		H94.ProducingProcessID,H94.PhaseID,A01.PhaseName,H94.UnitID,A02.UnitName,
		H94.TranMonth,H94.TranYear,H94.PeriodID,H94.DepartmentID,
		H94.TeamID,H94.EmployeeID,H94.Employee,
		STUFF(( SELECT DISTINCT '','' + CASE WHEN CONCAT('','',H94.Employee,'','') LIKE CONCAT(''%,'',A13.EmployeeID,'',%'') THEN A13.FullName ELSE H14.FullName END
			        FROM AT1103 A13, HV1400 H14 WITH(NOLOCK) WHERE CONCAT('','',H94.Employee,'','') LIKE CONCAT(''%,'',A13.EmployeeID,'',%'') OR CONCAT('','',H94.Employee,'','') LIKE CONCAT(''%,'',H14.EmployeeID,'',%'')
			        FOR XML PATH('''')
			        ), 1, 1, '''') EmployeeName,
		H94.ProduceDate,H94.ProduceQuantity,
		H94.Values01,H94.Quantity01,H94.UnitPrice01,
		H94.Values02,H94.Quantity02,H94.UnitPrice02,
		H94.Values03,H94.Quantity03,H94.UnitPrice03,
		H94.Values04,H94.Quantity04,H94.UnitPrice04,
		H94.Values05,H94.Quantity05,H94.UnitPrice05,H94.Properties01,H94.Properties02,H94.Properties03,
		H94.Quantity,H94.UnitPrice,H94.Amount,H94.MoldID,H02.ProductName MoldName,H94.MoldAmount,H94.Total,H94.Notes,
		H94.CreateDate,H94.CreateUserID,H94.LastModifyDate,H94.LastModifyUserID
		FROM HT1904_MT H94 WITH(NOLOCK)
		LEFT JOIN HT1015 H01 WITH(NOLOCK) ON H94.DivisionID = H01.DivisionID AND H01.ProductID = H94.ProductID
		LEFT JOIN AT0126 A01 WITH(NOLOCK) ON H94.DivisionID = A01.DivisionID AND A01.PhaseID = H94.PhaseID
		LEFT JOIN AT1304 A02 WITH(NOLOCK) ON H94.DivisionID = A02.DivisionID AND A02.UnitID = H94.UnitID
		LEFT JOIN HT1015 H02 WITH(NOLOCK) ON H94.DivisionID = H02.DivisionID AND H02.ProductID = H94.MoldID
		WHERE H94.DivisionID = '''+ @DivisionID +''' AND H94.ProducingProcessID = '''+ @ProducingProcessID +''' ' + @sWhere

PRINT (@sSQL)
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
