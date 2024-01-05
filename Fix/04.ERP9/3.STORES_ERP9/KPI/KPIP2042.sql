IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[KPIP2042]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[KPIP2042]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO










-- <Summary>
---- Load đổ dữ liệu vào màn hình KPIF2042
---- 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by Truong Lam 28/08/2019
---- <Example>
---- 

CREATE PROCEDURE [dbo].[KPIP2042]
(
	@EmployeeID NVARCHAR(250),
	@TranMonth NVARCHAR(50),
	@TranYear NVARCHAR(50),
	@PageNumber INT,
	@PageSize INT	
) 
AS 
DECLARE @sSQL NVARCHAR(MAX),
		@sWhere NVARCHAR(MAX)

SET @sWhere = '1 = 1'

--Check Para DivisionIDList null then get DivisionID 

IF Isnull(@EmployeeID, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(EmployeeID,'''') LIKE N''%'+@EmployeeID+'%''  '

IF Isnull(@TranMonth, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(TranMonth,'''') IN ('''+@TranMonth+''')  '

IF Isnull(@TranYear, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(TranYear,'''') LIKE N''%'+@TranYear+'%''  '

SET @sSQL = '
SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY EmployeeID)) AS RowNum, COUNT(*) OVER () AS TotalRow, *
FROM
(
	SELECT APK, DivisionID, InSurID AS Content, EmployeeID, TranMonth, TranYear, BaseSalary AS PremiumRate, (SRate + TRate + HRate) AS InsurrancePercent
			, (SRate + TRate + HRate)/100 * BaseSalary AS InsurranceMoney
		FROM HT2461
		WHERE '+@sWhere+' 
	UNION
	SELECT APK, DivisionID, NULL AS Content, EmployeeID, TranMonth, TranYear, NULL, NULL AS InsurrancePercent
			, IncomeTax AS InsurranceMoney 
		FROM HT0338
		WHERE '+@sWhere+' 
	--ORDER BY EmployeeID
	
) A 	
ORDER BY EmployeeID
OFFSET ' + CONVERT(NVARCHAR(10), (@PageNumber - 1) * @PageSize) + ' ROWS
FETCH NEXT ' + CONVERT(NVARCHAR(10), @PageSize) + ' ROWS ONLY'	

PRINT @sSQL			
EXEC (@sSQL)










GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
