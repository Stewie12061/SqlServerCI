IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP2064]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP2064]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Lưu thông tin detail phiếu báo giá Sale
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
----Created by Kiều Nga on 06/11/2019
----Updated by Văn Tài  on 03/09/2020 - Xử lý các trường Decimal có (28, 8) nếu không mặc định là (28, 0)
----Updated by Văn Tài	on 30/06/2021 - Chuyển sang gọi store con SOP2065.
----Modified by Nhựt Trường on 09/08/2021: Bổ sung lưu thêm trường trường CurrencyID, ExchangeRate vào bảng detail OT2102.
-- <Example>
---- 
/*-- <Example>
	exec SOP2064 @DivisionID=N'DTI',@UserID=N'NGA',@ROrderID=N'YC/10/2019/0011',@PriceListID=NULL,@CurrencyID=N'VND',@VoucherDate=N'04/10/2019 00:00:00',@QuotationID=N'0c29f79e-e727-4a64-b1b5-41bade9d1c42',@Coefficient=0,@ExchangeRate=1,@APKMaster_9000=N'93162701-dba8-458f-86f1-23771436fe44'
----*/

CREATE PROCEDURE SOP2064
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @RQuotationID NVARCHAR(MAX), -- QuotationID kế thừa NC,KHCU
	 @QuotationID  NVARCHAR(50) = '',
	 @Coefficient decimal (28,8),
	 @ExchangeRate decimal (28,8),
	 @APKMaster_9000 NVARCHAR(50) = '',
	 @APKlist NVARCHAR(MAX) = '',
	 @Ana06ID NVARCHAR(MAX) = ''
)
AS 

declare @Order INT =0 , @ApproveLevel INT =0
DECLARE @CustomerIndex INT = (SELECT TOP 1 CustomerIndex.CustomerName FROM CustomerIndex WITH (NOLOCK))
SET @Order = (select ISNULL(MAX(Orders),0) from OT2102 where QuotationID =@QuotationID)

SET @ApproveLevel = (select ISNULL(MAX(Level),0) from OOT9001 where APKMaster =@APKMaster_9000)

-- Lấy dữ liệu kế thừa
CREATE TABLE #SOP2063temp
(
	RowNum INT
	,TotalRow INT
	, APK NVARCHAR(50)
	, APKMaster NVARCHAR(50)
	, DivisionID NVARCHAR(50)
	, TransactionID NVARCHAR(50)
	, QuotationID NVARCHAR(50)
	, InventoryID NVARCHAR(50)
	, InventoryName NVARCHAR(MAX)
	, QuoQuantity DECIMAL(28,8)
	, UnitPrice DECIMAL(28,8)
	, OriginalAmount DECIMAL(28,8)
	, ConvertedAmount DECIMAL(28,8)
	, Notes NVARCHAR(MAX)
	, VATPercent DECIMAL(28,8)
	, VATConvertedAmount DECIMAL(28,8)
	, VATOriginalAmount DECIMAL(28,8)
	, UnitID NVARCHAR(MAX)
	, Orders INT
	, DiscountPercent DECIMAL(28,8)
	, DiscountOriginalAmount DECIMAL(28,8)
	, DiscountConvertedAmount DECIMAL(28,8)
	, Ana03ID NVARCHAR(250)
	, Ana02ID NVARCHAR(250)
	, Ana01ID NVARCHAR(250)
	, Notes01 NVARCHAR(MAX)
	, Notes02 NVARCHAR(MAX)
	, Ana04ID NVARCHAR(250)
	, Ana05ID NVARCHAR(250)
	, VATGroupID NVARCHAR(250)
	, finish TINYINT
	, ConvertedQuantity DECIMAL(28,8) 
	, ConvertedSalePrice DECIMAL(28,8)
	, Barcode NVARCHAR(50)
	, Markup DECIMAL(28,8)
	, OriginalAmountOutput DECIMAL(28,8)
	, ConvertedSalepriceInput DECIMAL(28,8)
	, ReceiveDate DATETIME
	, Ana06ID NVARCHAR(250)
	, Ana07ID NVARCHAR(250)
	, Ana08ID NVARCHAR(250)
	, Ana09ID NVARCHAR(250)
	, Ana10ID NVARCHAR(250)
	, Parameter01 DECIMAL(28,8)
	, Parameter02 DECIMAL(28,8)
	, Parameter03 DECIMAL(28,8)
	, Parameter04 DECIMAL(28,8)
	, Parameter05 DECIMAL(28,8)
	, QuoQuantity01 DECIMAL(28,8)
	, QD01 NVARCHAR(250)
	, QD02 NVARCHAR(250)
	, QD03 NVARCHAR(250)
	, QD04 NVARCHAR(250)
	, QD05 NVARCHAR(250)
	, QD06 NVARCHAR(250)
	, QD07 NVARCHAR(250)
	, QD08 NVARCHAR(250)
	, QD09 NVARCHAR(250)
	, QD10 NVARCHAR(250)
	, ClassifyID NVARCHAR(250)
	, Specification NVARCHAR(MAX)
	, CurrencyID NVARCHAR(50)
	, ExchangeRate DECIMAL(28,8)
	, InheritCurrencyID NVARCHAR(50)
	, InheritExchangeRate DECIMAL(28,8)
)

IF(@CustomerIndex = 114) --  DUCTIN
BEGIN
	insert into #SOP2063temp
	exec SOP2065 @DivisionID= @DivisionID, @QuotationID = @RQuotationID, @APKlist = @APKlist
END
ELSE
BEGIN
	insert into #SOP2063temp
	exec SOP2063 @DivisionID= @DivisionID, @QuotationID = @RQuotationID, @APKlist = @APKlist
END

-- Tính toán và Lưu thông tin chi tiết báo giá
Insert into OT2102 (APK
	, TransactionID
	, Orders
	, DivisionID
	, QuotationID
	, InventoryID
	, QuoQuantity
	, UnitID
	, OriginalAmount
	, UnitPrice
	, InheritTableID
	, InheritVoucherID
	, InheritTransactionID
	, Coefficient
	, Specification
	, ConvertedAmount
	, VATGroupID
	, APKMaster_9000
	, VATPercent
	, VATConvertedAmount
	, VATOriginalAmount
	, ApproveLevel
	, Ana06ID
	, CurrencyID
	, ExchangeRate)

SELECT NewID() AS APK
, NewID()
, RowNum + @Order AS Orders
, DivisionID
, @QuotationID
, InventoryID
, QuoQuantity
, UnitID
, CASE WHEN @Coefficient != NULL THEN OriginalAmount * @Coefficient ELSE OriginalAmount END AS OriginalAmount
, UnitPrice
, ClassifyID AS InheritTableID
, QuotationID AS InheritVoucherID
, TransactionID AS InheritTransactionID
, @Coefficient
, Specification
, CASE WHEN InheritCurrencyID = 'VND' 
  THEN 
		CASE WHEN @Coefficient <> NULL THEN ConvertedAmount * @Coefficient ELSE ConvertedAmount END
  ELSE 
		CASE WHEN @Coefficient <> NULL THEN QuoQuantity * (UnitPrice * InheritExchangeRate) * @Coefficient ELSE QuoQuantity * (UnitPrice * InheritExchangeRate) END 
  END AS ConvertedAmount

, VATGroupID
, @APKMaster_9000
, VATPercent
, CASE WHEN InheritCurrencyID = 'VND' 
  THEN 
		 CASE WHEN @Coefficient <> NULL THEN VATConvertedAmount * @Coefficient ELSE VATConvertedAmount END
  ELSE 
		CASE WHEN @Coefficient != NULL THEN QuoQuantity * (UnitPrice * InheritExchangeRate) * @Coefficient * VATPercent ELSE QuoQuantity * (UnitPrice * InheritExchangeRate) * VATPercent END 
  END AS VATConvertedAmount

, CASE WHEN @ExchangeRate <> NULL THEN VATConvertedAmount * @Coefficient ELSE VATConvertedAmount END AS VATOriginalAmount

, @ApproveLevel
, CASE WHEN ISNULL(@Ana06ID,'') !='' THEN @Ana06ID ELSE Ana06ID END
, InheritCurrencyID
, InheritExchangeRate

FROM #SOP2063temp

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO


