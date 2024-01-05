IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP2061]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP2061]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Lưu thông tin detail phiếu báo giá
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
----Created by Kiều Nga on 04/11/2019
----Modified by Nhựt Trường on 09/08/2021: Bổ sung lưu thêm trường trường CurrencyID, ExchangeRate vào bảng detail OT2102.
-- <Example>
---- 
/*-- <Example>
	exec SOP2061 @DivisionID=N'DTI',@UserID=N'NGA',@ROrderID=N'YC/10/2019/0011',@PriceListID=NULL,@CurrencyID=N'VND',@VoucherDate=N'04/10/2019 00:00:00',@QuotationID=N'0c29f79e-e727-4a64-b1b5-41bade9d1c42',@Coefficient=0,@ExchangeRate=1,@APKMaster_9000=N'93162701-dba8-458f-86f1-23771436fe44'
----*/

CREATE PROCEDURE SOP2061
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @ROrderID NVARCHAR(MAX),
	 @PriceListID NVARCHAR(MAX) = '',
     @CurrencyID NVARCHAR(50) = '',
	 @VoucherDate NVARCHAR(50) = '',
	 @QuotationID  NVARCHAR(50) = '',
	 @Coefficient decimal (28,8),
	 @ExchangeRate decimal (28,8),
	 @APKMaster_9000 NVARCHAR(50) = '',
	 @APKlist NVARCHAR(MAX) = '',
	 @Ana06ID NVARCHAR(50) = ''
)
AS 

declare @Order INT =0, @ApproveLevel INT =0
SET @Order = (select ISNULL(MAX(Orders),0) from OT2102 where QuotationID =@QuotationID)

SET @ApproveLevel = (select ISNULL(MAX(Level),0) from OOT9001 where APKMaster =@APKMaster_9000)

-- Lấy dữ liệu kế thừa
create table #POP2006temp(
RowNum int,TotalRow int,APKMaster nvarchar(50),APK nvarchar(50),DivisionID nvarchar(50),ROrderID nvarchar(50),VoucherNo nvarchar(50),OrderDate datetime,ShipDate datetime,
PriorityID nvarchar(50),Description nvarchar(max),TransactionID nvarchar(50),InventoryID nvarchar(50), InventoryName nvarchar(max), OrderQuantity decimal, OriginalAmount decimal,ConvertedAmount decimal, 
UnitID nvarchar(50), UnitName nvarchar(50), Notes nvarchar(max), Ana01ID nvarchar(50),Ana01Name nvarchar(250),Ana02ID nvarchar(50), Ana02Name nvarchar(250), 
Ana03ID nvarchar(50),Ana03Name nvarchar(250),Ana04ID nvarchar(50),Ana04Name nvarchar(250), Ana05ID nvarchar(50),Ana05Name nvarchar(250), Ana06ID nvarchar(50),Ana06Name nvarchar(250),Ana07ID nvarchar(50)
,Ana07Name nvarchar(250), Ana08ID nvarchar(50),Ana08Name nvarchar(250),Ana09ID nvarchar(50),Ana09Name nvarchar(250),Ana10ID nvarchar(50),Ana10Name nvarchar(250),Specification nvarchar(max)
,CurrencyID nvarchar(50), ExchangeRate decimal, AccountID nvarchar(50), AccountName nvarchar(250),OpportunityID nvarchar(50),OpportunityName nvarchar(250),RequestPrice decimal
)
insert into #POP2006temp
exec SOP2062 @DivisionID=@DivisionID,@UserID=@UserID,@ROrderID=@ROrderID,@Mode=0,@ScreenID=N'SOF2061A',@PriceListID=@PriceListID,@CurrencyID=@CurrencyID,@VoucherDate=@VoucherDate,@APKlist=@APKlist,@QuotationID='',@CheckInherit=1

-- Tính toán và Lưu thông tin chi tiết báo giá
Insert into OT2102 (APK,TransactionID,Orders,DivisionID,QuotationID,InventoryID,QuoQuantity,UnitID,OriginalAmount,UnitPrice,InheritTableID,InheritVoucherID,InheritTransactionID,Coefficient,Specification,ConvertedAmount,VATGroupID,APKMaster_9000,ApproveLevel,Ana06ID, CurrencyID, ExchangeRate)

select NewID() as APK,NewID(),RowNum + @Order As Orders,DivisionID,@QuotationID, InventoryID, OrderQuantity As QuoQuantity,UnitID,CASE WHEN @Coefficient !=null THEN RequestPrice*OrderQuantity*@Coefficient ELSE RequestPrice*OrderQuantity END AS OriginalAmount,
RequestPrice as UnitPrice,'OT3101' as InheritTableID, ROrderID as InheritVoucherID, TransactionID as InheritTransactionID , @Coefficient,Specification,
CASE WHEN @ExchangeRate <> null THEN RequestPrice*OrderQuantity*@Coefficient*@ExchangeRate ELSE RequestPrice*OrderQuantity*@ExchangeRate END AS ConvertedAmount,'' AS VATGroupID,@APKMaster_9000,@ApproveLevel,CASE WHEN ISNULL(@Ana06ID,'') !='' then @Ana06ID else Ana06ID end,
CurrencyID, ExchangeRate
from #POP2006temp

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
