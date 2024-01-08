IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP1012]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP1012]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Load Form OOF1012: Xem thông tin loại bất thường
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Bảo Thy, Date: 27/11/2015
--- Modified on 30/08/2018 by Bảo Anh: Bổ sung FromDate, ToDate, AbsentTypeID, AbsentTypeName, RowNum
--- Modified on 03/10/2022 by Xuân Nguyên: Sửa định dạng của FromDate và ToDate
/*-- <Example>
	OOP1012 'NTY','NTVN0021', 'B32DDAA4-9463-4C02-845E-2EF8B5C9D8D7',1,25
----*/


CREATE PROCEDURE OOP1012
( 
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@APK VARCHAR(50),
	@PageNumber INT = 1,
	@PageSize INT = 25
)
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@TotalRow NVARCHAR(50) = ''

SET @TotalRow = ''
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

SET @sSQL = N'
SELECT	ROW_NUMBER() OVER (ORDER BY OOT1011.FromDate) AS RowNum, '+@TotalRow+' AS TotalRow,
		OOT1011.APK,OOT1011.APKMaster,OOT1010.DivisionID, OOT1010.UnusualTypeID, OOT1010.[Description],OOT1010.DescriptionE, OOT1010.HandleMethodID, OOT0099.[Description] AS HandleMethodName,OOT1010.Note, OOT1010.[Disabled],
		OOT1010.IsDefault, DAY(OOT1011.FromDate) as FromDate, DAY(OOT1011.ToDate) as ToDate, OOT1011.AbsentTypeID, HT1013.AbsentName AS AbsentTypeName

FROM OOT1010
LEFT JOIN OOT1011 WITH (NOLOCK) ON OOT1010.DivisionID = OOT1011.DivisionID AND OOT1010.APK = OOT1011.APKMaster
LEFT JOIN OOT0099 ON HandleMethodID=ID AND CodeMaster=''Applying''
LEFT JOIN HT1013 ON OOT1011.DivisionID = HT1013.DivisionID AND OOT1011.AbsentTypeID = HT1013.AbsentTypeID
WHERE OOT1010.APK = ''' + @APK + '''

ORDER BY OOT1011.FromDate
OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'

EXEC (@sSQL)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
