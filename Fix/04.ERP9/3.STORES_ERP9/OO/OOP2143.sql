IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2143]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2143]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Load thông tin master ??n xin phép ra ngoài
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: B?o Thy, Date: 09/12/2015
---- Modified by B?o Thy on 06/09/2016: L?y Kh?i, Phòng t? danh m?c phòng ban, t? nhóm
---- Modified by Ph??ng Th?o on 22/05/2017: S?a danh m?c dùng chung
-- <Example>
---- 
/*
 exec OOP2022 @DivisionID=N'MK',@UserID=N'ASOFTADMIN',@APKMaster=N'FD1F26A0-2736-46E3-B66D-1550730F0900',@tranMonth=8,@TranYear=2016
*/

CREATE PROCEDURE [dbo].[OOP2143]
( 
	@DivisionID VARCHAR(50),
	@ProjectID VARCHAR(50)
)
AS
DECLARE 
		@sql NVARCHAR(MAX),
		@ProjectAnaTypeID NVARCHAR(50),
		@sWhere NVARCHAR(MAX)
		
	
SET @DivisionID = 'DTI'
SET @ProjectID = 'DA0001'
SET @sWhere = ' AND ISNULL(O1.DivisionID, '''') = ''' + @DivisionID + ''''

SELECT @ProjectAnaTypeID = ProjectAnaTypeID FROM AT0000 WHERE DefDivisionID = @DivisionID
IF ISNULL(@ProjectAnaTypeID, '') != ''
BEGIN
	SET @sWhere = @sWhere + ' AND ISNULL(O2.' + REPLACE(@ProjectAnaTypeID, 'A', 'Ana') + 'ID, '''') = ''' + @ProjectID + ''''
END

SET @sql = '
SELECT ISNULL(SUM(O2.ConvertedAmount), 0) AS SumConvertedAmount
FROM OT3001 O1
	INNER JOIN OT3002 O2 ON O1.APK = O2.POrderID AND ISNULL(O2.Status, 0) = 1
WHERE ISNULL(O1.Status, 0) = 1 ' + @sWhere

PRINT(@sql)
EXEC(@sql)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
