IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP2124]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP2124]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---- Load dữ liệu detail phiếu báo giá Sale
----Created by: Đình Hoà, date: 06/08/2021
----Edit by: Đình Hoà, date: 25/08/2021 : Bổ sung load cột còn thiếu

CREATE PROCEDURE [dbo].[SOP2124] 
				@DivisionID AS nvarchar(50),
				@APK AS varchar(50)
AS

DECLARE @sSQL0 NVARCHAR(MAX) ='',
		@sSQL NVARCHAR(MAX) =''

SET @sSQL0 = N' WITH OrderedOrders AS  
(  
	SELECT ROW_NUMBER() OVER(PARTITION BY R01.RelatedToID ORDER BY R01.RelatedToID ASC, R01.AttachID DESC) AS RowNumber,
	R01.DivisionID, R01.RelatedToID, R01.AttachID, R02.APK, R02.AttachName
	FROM CRMT00002_REL R01
	LEFT JOIN crmt00002 R02 ON R01.AttachID = R02.AttachID
)   
SELECT * 
INTO #TempAttack
FROM OrderedOrders 
WHERE RowNumber = 1;
'  
	

SET @sSQL = N'SELECT S2.APK, S2.InventoryID, S3.InventoryName, S3.Specification, S4.UnitName, S2.QuoQuantity, S2.UnitPrice, (S2.UnitPrice * S2.QuoQuantity) AS Amount
, S7.StandardName AS S02Name, S8.StandardName AS S03Name, S2.S02ID, S2.S03ID, S2.Area, S2.AttachFileName, S5.APK AS APK_REL
, S9.AnaName AS TradeMark, S10.AnaName AS InstallationArea, S2.FirePrice, S2.LengthSize, S2.WithSize, S2.HeightSize, S2.LipSize, (S2.WithSize * S2.HeightSize) / 1000000 AS AreaSize
FROM SOT2120 S1 WITH(NOLOCK)
LEFT JOIN SOT2121 S2 WITH(NOLOCK) ON S1.APK = S2.APKMaster AND S2.DivisionID = S1.DivisionID
LEFT JOIN AT1302 S3 WITH(NOLOCK) ON S2.InventoryID = S3.InventoryID AND S3.DivisionID IN (''@@@'', S1.DivisionID)
LEFT JOIN AT1304 S4 WITH(NOLOCK) ON S2.UnitID = S4.UnitID AND  S4.DivisionID IN(''@@@'', S1.DivisionID)
LEFT JOIN #TempAttack S5 WITH(NOLOCK) ON S2.APK = S5.RelatedToID AND S2.AttachFileName = S5.AttachName AND S5.DivisionID IN (''@@@'', S1.DivisionID)
LEFT JOIN AT0128 S6 WITH(NOLOCK) ON S2.S01ID = S6.StandardID AND S6.StandardTypeID = ''S01'' AND S6.DivisionID IN(''@@@'', S1.DivisionID)
LEFT JOIN AT0128 S7 WITH(NOLOCK) ON S2.S02ID = S7.StandardID AND S7.StandardTypeID = ''S02'' AND S7.DivisionID IN(''@@@'', S1.DivisionID)
LEFT JOIN AT0128 S8 WITH(NOLOCK) ON S2.S03ID = S8.StandardID AND S8.StandardTypeID = ''S03'' AND S8.DivisionID IN(''@@@'', S1.DivisionID)
LEFT JOIN AT1015 S9 WITH(NOLOCK) ON S3.I03ID = S9.AnaID AND S9.AnaTypeID = ''I03'' AND S9.DivisionID IN(''@@@'', S1.DivisionID)
LEFT JOIN AT1015 S10 WITH(NOLOCK) ON S3.I06ID = S10.AnaID  AND S10.AnaTypeID = ''I06'' AND S10.DivisionID IN(''@@@'', S1.DivisionID)
WHERE S1.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND CONVERT(VARCHAR(50), S1.APK) = ''' + @APK + '''
ORDER BY S2.OrderInv'


EXEC (@sSQL0 + @sSQL)
PRINT (@sSQL0 + @sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
