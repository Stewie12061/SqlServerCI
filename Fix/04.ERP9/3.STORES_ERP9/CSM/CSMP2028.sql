IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CSMP2028]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CSMP2028]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- In PSC
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hồng Thảo, Date: 11/06/2018
-- <Example>
---- 
/*-- <Example>
	CSMP2028 @DivisionID = 'VF', @UserID = ''

----*/
CREATE PROCEDURE CSMP2028
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50), 
	 @XML XML
)
AS 

DECLARE @sSQL NVARCHAR(MAX)

CREATE TABLE #CSMP2028(APK VARCHAR(50))
INSERT INTO #CSMP2028 (APK)
SELECT X.Data.query('APK').value('.', 'NVARCHAR(50)') AS APK
FROM @XML.nodes('//Data') AS X (Data)

BEGIN 
SET @sSQL =(
SELECT T1.Bounce,T1.VoucherNo,T1.DispatchID, T1.SerialNumber, T1.IMEINumber, T1.ProductID + ' - ' + T2.InventoryName AS ProductName, T1.Model+' - '+T3.ModelName AS ModelName,
 T1.WarrantyStatus +' - '+T4.WarrantyStatusName AS WarrantyStatusName, T1.CustomerGroupID,  
CASE WHEN ISNULL(T1.StoreID, '') <> '' THEN T6.ObjectName ELSE T5.ObjectName END AS ASPName,
CASE WHEN ISNULL(T1.StoreID, '') <> '' THEN T6.[Note1] ELSE T5.[Note1] END AS ShipTo,
CASE WHEN ISNULL(T1.StoreID, '') <> '' THEN T6.[Address] ELSE T5.[Address] END AS AddressASP,
CASE WHEN ISNULL(T1.StoreID, '') <> '' THEN T6.[PhoneNumber] ELSE T5.[PhoneNumber] END AS PhoneNumber,
T1.SymptomCode,T1.SymptomCode +' - '+ T7.ErrorName AS SymptomCodeName, T1.SymptomDescription,T8.AccessoriesID + T9.InventoryName AS AccessoriesName
FROM CSMT2010 T1 WITH (NOLOCK)
LEFT JOIN AT1302 T2   WITH (NOLOCK) ON T2.DivisionID IN (T1.DivisionID, '@@@') AND T1.ProductID = T2.InventoryID
LEFT JOIN CSMT1080 T3 WITH (NOLOCK) ON T3.DivisionID IN (T1.DivisionID, '@@@') AND T1.Model = T3.ModelID
LEFT JOIN CSMT1110 T4 WITH (NOLOCK) ON T4.DivisionID IN (T1.DivisionID, '@@@') AND T1.WarrantyStatus = T4.WarrantyStatusID
LEFT JOIN AT1202 T5   WITH (NOLOCK) ON T5.DivisionID IN (T1.DivisionID, '@@@') AND T1.AgencyID = T5.ObjectID ---- Đại lý
LEFT JOIN AT1202 T6   WITH (NOLOCK) ON T6.DivisionID IN  (T1.DivisionID, '@@@') AND T1.StoreID = T6.ObjectID ---- Cửa hàng 
LEFT JOIN CSMT1030 T7 WITH (NOLOCK) ON T7.DivisionID IN (T1.DivisionID, '@@@') AND T1.SymptomCode = T7.ErrorID AND T1.SymptomGroup = T7.GroupErrID 
LEFT JOIN CSMT2011 T8 WITH (NOLOCK) ON T1.APK = T8.APKMaster 
LEFT JOIN AT1302 T9 WITH (NOLOCK)   ON T9.DivisionID IN (T1.DivisionID,'@@@') AND T8.AccessoriesID = T9.InventoryID 
INNER JOIN #CSMP2028 T10 ON T1.APK = T10.APK 
WHERE T1.DivisionID = @DivisionID )
END 

--PRINT @sSQL
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO





  
  
  