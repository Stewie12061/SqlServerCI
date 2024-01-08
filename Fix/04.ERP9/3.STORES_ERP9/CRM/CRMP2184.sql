IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP2184]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP2184]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-- <Summary>
---- Tính giá tiền theo sản phẩm
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Tấn Lộc, Date 28/04/2021
-- <Example>

CREATE PROCEDURE CRMP2184 
( 
	@AmountInventory INT,
	@UnitPrice_TablePrice Decimal(28,8),
	@Discountamount Decimal(28,8)
) 
AS 

DECLARE @sSQL NVARCHAR (MAX), 
		@sWhere NVARCHAR(MAX),
		@totalPrice Decimal(28,8),
		@curDiscountamount Decimal(28,8),
		@curUnitPrice_Discountamount Decimal(28,8),
		@lastUnitPrice Decimal(28,8)

-- Tính giá trị của Chiết khấu (Chiết khấu / 100)
set @curDiscountamount = @Discountamount / 100
print(@curDiscountamount)

-- Tính số tiền đơn giá theo chiết khấu (Đơn giá * Chiết khấu)
set @curUnitPrice_Discountamount = @UnitPrice_TablePrice * @curDiscountamount
print(@curUnitPrice_Discountamount)

-- Tính đơn giá của sản phẩm (Đơn giá - số tiền chiết khấu theo đơn giá)
set @lastUnitPrice = @UnitPrice_TablePrice - @curUnitPrice_Discountamount
print(@lastUnitPrice)

-- Tính giá thành tiền sản phẩm theo đơn giá cuối cùng (Đơn giá đã từ đi chiết khấu)
Set @totalPrice =  @AmountInventory * @lastUnitPrice


SELECT (@totalPrice) AS TotalPrice





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
