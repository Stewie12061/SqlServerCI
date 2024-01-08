IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0540]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0540]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load Grid form HF0528 (Chấm công nhân viên theo sản phẩm) (VIETFIRST)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Khả Vi, Date: 01/03/2018
/*-- <Example>
	HP0540 @DivisionID = 'VF', @UserID = 'ASOFTADMIN', @TranMonth = 12, @TranYear = 2017

	HP0540 @DivisionID, @UserID, @TranMonth, @TranYear
----*/

CREATE PROCEDURE HP0540
( 
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@TranMonth INT, 
	@TranYear INT 
)
AS 

DECLARE @sSQL NVARCHAR(MAX) = N''
		
SET @sSQL = @sSQL + N'
SELECT HT1126.APK, HT1126.DivisionID, HT1126.TranMonth, HT1126.TranYear, HT1126.ProductID, HT1015.ProductName, 
HT1126.CheckDate, HT1126.PriceSheetID, HT1902.PriceSheetName, 
HT1126.EmployeeID, CASE 
WHEN ISNULL(MiddleName,'''') = '''' THEN LTRIM(RTRIM(HT1400.LastName)) + '' '' + LTRIM(RTRIM(HT1400.FirstName))
WHEN ISNULL(MiddleName,'''') <> '''' THEN LTRIM(RTRIM(HT1400.LastName)) + '' '' + LTRIM(RTRIM(HT1400.MiddleName)) + '' '' + LTRIM(RTRIM(HT1400.FirstName))END AS EmployeeName, 
HT1126.Quantity, HT1126.TAT, HT1126.Bounce, HT1126.PercentAmount, HT1126.Amount, HT1126.TotalAmount AS Total, 
HT1126.CreateUserID, HT1126.CreateDate, HT1126.LastModifyUserID, HT1126.LastModifyDate
FROM HT1126	WITH (NOLOCK)
LEFT JOIN HT1015 WITH (NOLOCK) ON HT1126.DivisionID = HT1015.DivisionID AND HT1126.ProductID = HT1015.ProductID
LEFT JOIN HT1902 WITH (NOLOCK) ON HT1126.DivisionID = HT1902.DivisionID AND HT1126.PriceSheetID = HT1902.PriceSheetID
LEFT JOIN HT1400 WITH (NOLOCK) ON HT1126.DivisionID = HT1400.DivisionID AND HT1126.EmployeeID = HT1400.EmployeeID
WHERE HT1126.DivisionID = '''+@DivisionID+''' AND TranMonth + TranYear * 100 = '+STR(@TranMonth + @TranYear * 100)+'
'

--PRINT (@sSQL)
EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
