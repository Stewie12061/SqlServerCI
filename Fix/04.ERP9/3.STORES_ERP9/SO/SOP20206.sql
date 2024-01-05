IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP20206]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP20206]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- In chào giá trong -ngoài nước
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Kiều Nga, Date: 28/02/2020
----Modify by: Kiều Nga, Date: 26/05/2020 Lấy view OV2101 từ store OP3004
----Modify by: Đình Hoà, Date: 14/07/2020 Lấy thếm đơn vị cho tiền tệ và số lượng, lấy tên giám đốc
----Modify by: Kiều Nga, Date: 23/12/2021 [2021/12/IS/0104] Bổ sung các thông tin bị thiếu

-- <Example>
---- 
/*-- <Example>
	SOP20206 @DivisionID = 'AIC', @UserID = 'ASOFTADMIN', @ROrderList = ''
----*/
CREATE PROCEDURE SOP20206
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @QuotationID VARCHAR(50)
)
AS 

DECLARE @sSQL NVARCHAR (MAX) = N''

--Lấy OV2101
EXEC OP3004 @DivisionID, 1, 2020, @QuotationID,-1

SET @sSQL = N'SELECT T1.QuotationNo,T1.QuotationDate,T2.FullName,T2.DivisionName,T2.Email01,T2.Address01,
T2.Tel01 as EmployeeTel,T2.Fax01,T2.Contactor,T2.ObjectName,T2.Email,T2.ObjectAddress,
T2.Tel as PhoneContactor,T2.Fax,T2.InventoryID,T2.InventoryName,T2.StandardName04,T2.Notes,
CONCAT(FORMAT(T2.QuoQuantity,''N0''),'' '' ,T2.UnitName) AS QuoQuantity,CONCAT(FORMAT(T2.UnitPrice,''N0''),'' '' ,T2.CurrencyID) AS UnitPrice,
T2.Attention2,T2.Description, A1.Director, T2.VATPercent,T2.UnitName,T2.Specification,T2.OriginalAmount,T2.ConvertedAmount,T2.DiscountPercent,
T2.DiscountConvertedAmount,T2.DiscountOriginalAmount,T1.ExchangeRate,T1.CurrencyID,T2.Image01ID,T2.VATConvertedAmount
FROM OT2101 T1 WITH (NOLOCK)
LEFT JOIN OV2101 T2 WITH(NOLOCK) ON T1.QuotationID = T2.QuotationID
INNER JOIN AT0001 A1 WITH(NOLOCK) ON T1.DivisionID = A1.DivisionID
WHERE T1.QuotationID = '''+@QuotationID +'''
ORDER BY T2.Orders'

PRINT @sSQL
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
