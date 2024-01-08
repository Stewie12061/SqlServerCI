IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP20021]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP20021]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Export Phiếu báo giá
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>

-- <History>
----Create on 11/02/2022 by Minh Hiếu
-- <Example> 
CREATE PROCEDURE SOP20021
 ( 
    @DivisionID AS nvarchar(50),
	@QuotationID AS nvarchar(4000)
) 
AS 

DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX)

SET @sSQL = 'SELECT M.QuotationID
				  , M.QuotationNo
				  , M.QuotationDate
				  , M.ObjectName
				  , M.Address AS AddressN
				  , M.ContactorID
				  , M.Description
				  , M.Attention1
				  , M.Attention2
				  , M.Dear
				  , C01.TitleContact AS DutyID
				  , C01.ContactName AS ContactorName		  
				  , O02.InventoryID
				  , O02.QuoQuantity
				  , O02.UnitPrice
				  , O02.VATPercent
				  , O02.OriginalAmount
				  , A12.Tel AS TelephoneN
				  , A12.VATNo
				  , A13.InventoryName
				  , A13.Specification
				  , A03.Image01ID AS Image
				  , A05.PaymentID, A05.PaymentName
				  , A08.PaymentTermID, A08.PaymentTermName
			FROM OT2101 M WITH (NOLOCK)
			LEFT JOIN OT2102 O02 WITH (NOLOCK) ON M.QuotationID = O02.QuotationID AND M.DivisionID = O02.DivisionID
			LEFT JOIN CRMT10001 C01 WITH (NOLOCK) ON M.ContactorID = C01.ContactID
			LEFT JOIN AT1202 A12 WITH (NOLOCK) ON M.ObjectID = A12.ObjectID
			LEFT JOIN AT1302 A13 WITH (NOLOCK) ON M.DivisionID = A13.DivisionID AND O02.InventoryID = A13.InventoryID
			LEFT JOIN A00003 A03 WITH (NOLOCK) ON M.DivisionID = A13.DivisionID AND O02.InventoryID = A03.InventoryID
			LEFT JOIN AT1205 A05 WITH (NOLOCK) ON M.PaymentID = A05.PaymentID
			LEFT JOIN AT1208 A08 WITH (NOLOCK) ON M.DivisionID = A08.DivisionID AND M.PaymentTermID = A08.PaymentTermID
			WHERE M.QuotationID = '''+@QuotationID +'''
			ORDER BY M.QuotationID'

PRINT(@sSQL)		
EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO