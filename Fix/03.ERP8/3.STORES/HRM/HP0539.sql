IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0539]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0539]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load form cập nhật chấm công nhân viên theo sản phẩm khi edit (VIETFIRST) 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Khả Vi, Date: 27/02/2018
/*-- <Example>
	HP0539 @DivisionID = 'VF', @UserID = 'ASOFTADMIN', @TranMonth = 12, @TranYear = 2017, @ProductID = 'IP5'

	HP0539 @DivisionID, @UserID, @TranMonth, @TranYear, @ProductID
----*/

CREATE PROCEDURE HP0539
( 
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@ProductID VARCHAR(50), 
	@TranMonth INT,
	@TranYear INT 
)

AS 
DECLARE @sSQL NVARCHAR(MAX) = N'', 
		@Period INT = 0

SET @Period = (@TranMonth + @TranYear * 100)

SET @sSQL = @sSQL + N'
SELECT HT1126.APK, HT1126.DivisionID, HT1126.ProductID, HT1015.ProductName, HT1126.CheckDate, HT1126.NormID, HT1123.[Description], 
HT1126.PriceSheetID, HT1902.PriceSheetName, 
HT1126.EmployeeID, CASE WHEN ISNULL(MiddleName,'''') = '''' THEN LTRIM(RTRIM(HT1400.LastName)) + '' '' + LTRIM(RTRIM(HT1400.FirstName))
WHEN ISNULL(MiddleName,'''') <> '''' THEN LTRIM(RTRIM(HT1400.LastName)) + '' '' + LTRIM(RTRIM(HT1400.MiddleName)) + '' '' + LTRIM(RTRIM(HT1400.FirstName))END AS EmployeeName, 
HT1126.Quantity, HT1126.TAT, HT1126.Bounce
FROM HT1126 WITH (NOLOCK) 
LEFT JOIN HT1123 WITH (NOLOCK) ON HT1126.DivisionID = HT1123.DivisionID AND HT1126.NormID = HT1123.NormID
LEFT JOIN HT1015 WITH (NOLOCK) ON HT1126.DivisionID = HT1015.DivisionID AND HT1126.ProductID = HT1015.ProductID
LEFT JOIN HT1902 WITH (NOLOCK) ON HT1126.DivisionID = HT1902.DivisionID AND HT1126.PriceSheetID = HT1902.PriceSheetID
LEFT JOIN HT1400 WITH (NOLOCK) ON HT1126.DivisionID = HT1400.DivisionID AND HT1126.EmployeeID = HT1400.EmployeeID
WHERE HT1126.DivisionID = '''+@DivisionID+''' AND (HT1126.TranMonth + HT1126.TranYear * 100) = '+STR(@Period)+'
AND HT1126.ProductID = '''+@ProductID+'''
'

--PRINT @sSQL
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
