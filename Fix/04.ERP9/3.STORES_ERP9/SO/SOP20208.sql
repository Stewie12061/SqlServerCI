IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP20208]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP20208]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- In chào giá (chuẩn)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Lê Hoàng, Date: 19/10/2021
----Modified by Lê Hoàng on 19/10/2021 : Bổ sung trường % chiết khấu, CK nguyên tệ, CK quy đổi
----Modified by Kiều Nga on 23/12/2021 : Bổ sung orderby theo Orders
----Modified by Minh Hiếu on 07/02/2022 : Bổ sung trường thông tin ngân hàng
----Modified by Tấn Lộc on 01/07/2022 : Bổ sung load thêm dữ liệu các tham số detail
-- <Example>
---- 
/*-- <Example>
	SOP20208 @DivisionID = 'AIC', @UserID = 'ASOFTADMIN', @ROrderList = ''
----*/
CREATE PROCEDURE SOP20208
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @QuotationID VARCHAR(50)
)
AS 

DECLARE @sSQL NVARCHAR (MAX) = N'',
		@sSQL1 NVARCHAR (MAX) = N''

--Lấy OV2101
EXEC OP3004 @DivisionID, 1, 2020, @QuotationID,-1

Set @sSQL1 = ' 
				SELECT TypeID AS AnaTypeID,UserName,IsUsed FROM OT0005 WITH (NOLOCK) WHERE TypeID like ''%QD%'' AND IsUsed = 1 AND DivisionID = ''' + @DivisionID + ''''

SET @sSQL = N'SELECT T1.QuotationNo,T1.QuotationDate,T1.Attention1,T1.CurrencyID,T1.ExchangeRate,T1.Description,T1.DeliveryAddress,
A02.BankName as ObjectBankName, A02.BankAddress as ObjectBankAddress, A02.BankAccountNo as ObjectBankAccountNo,
T2.FullName,T2.DivisionName,T2.Email01,T2.Address01,T1.CreateDate,T1.CreateUserID,
T2.Tel01 as EmployeeTel,T2.Fax01,T2.Contactor,T2.ObjectName,T2.Email AS	ObjectEmail	,T2.ObjectAddress,T2.VATNo,
T2.Tel as PhoneContactor,A02.Phonenumber,T2.Fax,T2.InventoryID,T2.InventoryName,T2.StandardName04,T2.Notes,
isnull(T2.QuoQuantity,0) as QuoQuantity, 
T2.UnitName,T2.UnitPrice AS UnitPrice, T2.UnitID,
T2.OriginalAmount, T2.ConvertedAmount,isnull(T2.VATPercent,0) as VATPercent,isnull( T2.VATOriginalAmount,0) as VATOriginalAmount,T2.VATConvertedAmount,
T2.DiscountPercent, T2.DiscountConvertedAmount, T2.DiscountOriginalAmount,isnull(T2.TotalOriginalAmount,0) as TotalOriginalAmount,
T2.Attention2, A1.Director, A2.Image01ID AS Image, T2.Specification,AT1016.BankAccountNo , AT1016.BankName,
ISNULL(T2.QD01,0) AS QD01, ISNULL(T2.QD02,0) AS QD02, ISNULL(T2.QD03,0) AS QD03, ISNULL(T2.QD04,0) AS QD04, ISNULL(T2.QD05,0) AS QD05
FROM OT2101 T1 WITH (NOLOCK)
LEFT JOIN OV2101 T2 WITH(NOLOCK) ON T1.QuotationID = T2.QuotationID
INNER JOIN AT0001 A1 WITH(NOLOCK) ON T1.DivisionID = A1.DivisionID
left join AT1202 A02 WITH (NOLOCK) on A02.ObjectID = T1.ObjectID
LEFT JOIN A00003 A2 WITH(NOLOCK) ON T2.DivisionID IN (A2.DivisionID,''@@@'') AND T2.InventoryID = A2.InventoryID
left join AT1101 A11 WITH (NOLOCK) on A11.DivisionID = T1.DivisionID
left join AT1016 WITH (NOLOCK) on AT1016.BankAccountID = A11.BankAccountID AND AT1016.DivisionID = T1.DivisionID
WHERE T1.QuotationID = '''+@QuotationID +'''
ORDER BY T2.Orders'

PRINT (@sSQL + @sSQL1)
EXEC (@sSQL + @sSQL1)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
