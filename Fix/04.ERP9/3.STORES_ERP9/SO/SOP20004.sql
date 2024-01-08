IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP20004]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP20004]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---- Load dữ liệu master phiếu in kỹ thuật sản xuất (MECI)
---- Created by: Đình Hòa, date: 03/06/2021
---- exec SOP20004 @Divisionid=N'ANG',@APK=N''

CREATE PROCEDURE [dbo].[SOP20004] 
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
LEFT JOIN SOT2111 S5 WITH(NOLOCK) ON S5.DivisionID = S1.DivisionID AND S4.APK = S5.APKMaster
LEFT JOIN AT1302 S6 WITH(NOLOCK) ON S6.DivisionID IN (S1.DivisionID,'@@@') AND S4.InventoryID = S6.InventoryID
LEFT JOIN QCT1000 S7 WITH(NOLOCK) ON S7.DivisionID IN (S1.DivisionID,'@@@') AND S5.StandardID = S7.StandardID
WHERE S2.InheritVoucherID IS NOT NULL AND S3.InheritVoucherID IS NOT NULL AND S3.InheritTableID = 'SOT2110'
AND S1.SOrderID = ''+ @APK +'' AND S1.DivisionID IN ('@@@', '' + @DivisionID + '')) X

print @strStandardID

SET @sSQL = N'
SELECT DISTINCT *
FROM (SELECT S4.APK, S1.VoucherNo, S8.FullName, S1.ObjectName, S4.InventoryID, S6.InventoryName,  S2.OrderQuantity, A15.AnaName AS ColorName,S7.StandardName , ROUND(CAST(ISNULL(S5.StandardValue,''0'') AS FLOAT),2) AS StandardValue
	FROM OT2001 S1 WITH(NOLOCK)
	LEFT JOIN OT2002 S2 WITH(NOLOCK) ON S2.DivisionID  = S1.DivisionID AND S1.SOrderID = S2.SOrderID
	LEFT JOIN OT2102 S3 WITH(NOLOCK) ON S3.DivisionID  = S1.DivisionID   AND S2.InheritVoucherID = S3.QuotationID AND S2.InventoryID = S3.InventoryID AND S2.QuotationID = S3.TransactionID
	LEFT JOIN SOT2110 S4 WITH(NOLOCK) ON S4.DivisionID = S1.DivisionID AND S3.InheritVoucherID = CONVERT(VARCHAR(50),S4.APK) 
	LEFT JOIN SOT2111 S5 WITH(NOLOCK) ON S5.DivisionID = S1.DivisionID AND S4.APK = S5.APKMaster
	LEFT JOIN AT1302 S6 WITH(NOLOCK) ON S6.DivisionID IN (S1.DivisionID,''@@@'') AND S4.InventoryID = S6.InventoryID
	LEFT JOIN QCT1000 S7 WITH(NOLOCK) ON S7.DivisionID IN (S1.DivisionID,''@@@'') AND S5.StandardID = S7.StandardID
	LEFT JOIN AT1103 S8 WITH(NOLOCK) ON S8.DivisionID IN (S1.DivisionID,''@@@'') AND S8.EmployeeID = S1.CreateUserID	
	LEFT JOIN AT1015 A15 WITH(NOLOCK) ON S4.ColorID = A15.AnaID AND A15.AnaTypeID = ''I02'' AND A15.DivisionID IN (''@@@'',S4.DivisionID)
	WHERE S2.InheritVoucherID IS NOT NULL AND S3.InheritVoucherID IS NOT NULL AND S3.InheritTableID = ''SOT2110'' AND
	S1.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND CONVERT(VARCHAR(50), S1.SOrderID) = ''' + @APK + '''
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
