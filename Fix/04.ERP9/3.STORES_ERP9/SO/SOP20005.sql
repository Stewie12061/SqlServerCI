IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP20005]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP20005]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---- Load dữ liệu detail phiếu in kỹ thuật sản xuất (MECI)
---- Created by: Đình Hòa, date: 03/06/2021
---- Modify by: Kiều Nga, date: 23/07/2021 Fix lỗi double dòng
---- exec SOP20005 @Divisionid=N'ANG',@APK=N''

CREATE PROCEDURE [dbo].[SOP20005] 
				@DivisionID AS nvarchar(50),
				@APK AS nvarchar(4000)
AS

DECLARE @sSQL NVARCHAR(MAX) ='',
		@strStandardID NVARCHAR (MAX)

SELECT @strStandardID = COALESCE(@strStandardID + '], [','') + X.StandardName
FROM (SELECT DISTINCT S7.StandardName
FROM OT2001 S1 WITH(NOLOCK)
LEFT JOIN OT2002 S2 WITH(NOLOCK) ON S2.DivisionID  = S1.DivisionID AND S1.SOrderID = S2.SOrderID
LEFT JOIN OT2102 S3 WITH(NOLOCK) ON S3.DivisionID  = S1.DivisionID   AND S2.InheritVoucherID = S3.QuotationID AND S2.InventoryID = S3.InventoryID AND S2.QuotationID = S3.TransactionID
LEFT JOIN SOT2110 S4 WITH(NOLOCK) ON S4.DivisionID = S1.DivisionID AND S3.InheritVoucherID = CONVERT(VARCHAR(50),S4.APK) 
LEFT JOIN SOT2112 S5 WITH(NOLOCK) ON S5.DivisionID = S1.DivisionID AND S4.APK = S5.APKMaster
LEFT JOIN SOT2113 S6 WITH(NOLOCK) ON S5.DivisionID = S1.DivisionID AND S5.APK = S6.APKMaster_SOT2112
LEFT JOIN QCT1000 S7 WITH(NOLOCK) ON S7.DivisionID IN (S1.DivisionID,'@@@') AND S6.StandardID = S7.StandardID
WHERE S2.InheritVoucherID IS NOT NULL AND S3.InheritVoucherID IS NOT NULL AND S3.InheritTableID = 'SOT2110'
AND S1.SOrderID = ''+ @APK +'' AND S1.DivisionID IN ('@@@', '' + @DivisionID + '')) X

SET @sSQL = N'
SELECT DISTINCT *
FROM (SELECT S4.APK, S5.NodeID, S5.NodeName, (S2.OrderQuantity * S5.Quantity) AS Quantity, S2.InventoryID, S7.StandardName, ROUND(CAST(ISNULL(S6.StandardValue,''0'') AS FLOAT),2) AS StandardValue
	FROM OT2001 S1 WITH(NOLOCK)
	LEFT JOIN OT2002 S2 WITH(NOLOCK) ON S2.DivisionID  = S1.DivisionID AND S1.SOrderID = S2.SOrderID
	LEFT JOIN OT2102 S3 WITH(NOLOCK) ON S3.DivisionID  = S1.DivisionID   AND S2.InheritVoucherID = S3.QuotationID AND S2.InventoryID = S3.InventoryID AND S2.QuotationID = S3.TransactionID
	LEFT JOIN SOT2110 S4 WITH(NOLOCK) ON S4.DivisionID = S1.DivisionID AND S3.InheritVoucherID = CONVERT(VARCHAR(50),S4.APK) 
	LEFT JOIN SOT2112 S5 WITH(NOLOCK) ON S5.DivisionID = S1.DivisionID AND S4.APK = S5.APKMaster
	LEFT JOIN SOT2113 S6 WITH(NOLOCK) ON S5.DivisionID = S1.DivisionID AND S5.APK = S6.APKMaster_SOT2112
	LEFT JOIN QCT1000 S7 WITH(NOLOCK) ON S7.DivisionID IN (S1.DivisionID,''@@@'') AND S6.StandardID = S7.StandardID
	WHERE S2.InheritVoucherID IS NOT NULL AND S3.InheritVoucherID IS NOT NULL AND S3.InheritTableID = ''SOT2110'' 
	AND S5.Quantity > 0 AND S1.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND CONVERT(VARCHAR(50), S1.SOrderID) = ''' + @APK + '''
) X
PIVOT  
(  
MAX (X.StandardValue)  
FOR X.StandardName IN  
([' + @strStandardID +  '])  
) AS Std'

EXEC (@sSQL)
PRINT (@sSQL)







GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
