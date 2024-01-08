IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP9021]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP9021]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Xử lý sinh động hóa đơn bán hàng, phiếu xuất kho
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 21/11/2023 by Kiều Nga
---- Modified on 18/12/2023 by Kiều Nga : Bổ sung thêm loại chứng từ SO-VAT, PQ-SO-VAT cho sinh động HDBH
---- Modified on 19/12/2023 by Kiều Nga : Xử lý thay đổi thứ tự sinh động hóa đơn bán hàng => Sinh động phiếu xuất kho
-- <Example>
---- 
CREATE PROCEDURE [DBO].[OP9021]
( 
	@DivisionID AS NVARCHAR(50),	
	@TranMonth AS INT,
	@TranYear AS INT,
	@VoucherTypeID AS NVARCHAR(50),
	@WareHouseID AS NVARCHAR(50),
	@SOrderID AS NVARCHAR(250),
	@UserID AS NVARCHAR(50) = ''
) 
AS
SET NOCOUNT ON

DECLARE @Status AS TINYINT,
		@MessageID AS NVARCHAR(50),
		@VoucherTypeID_XK AS NVARCHAR(50) ='',
		@VoucherTypeID_BH AS NVARCHAR(50) =''
		
--SET @Status = 0 -- Không thông báo
--SET @MessageID = ''

IF(@VoucherTypeID = 'SO')
BEGIN
	SET @VoucherTypeID_XK = 'XB'
	SET @VoucherTypeID_BH = 'BH'
END
ELSE IF(@VoucherTypeID = 'SO-02')
BEGIN
	SET @VoucherTypeID_XK = 'XB-02'
	SET @VoucherTypeID_BH = 'BH-02'
END
ELSE IF(@VoucherTypeID = 'PQ-SO')
BEGIN
	SET @VoucherTypeID_XK = 'PQ-XB'
	SET @VoucherTypeID_BH = 'PQ-BH'
END
ELSE IF(@VoucherTypeID = 'PQ-SO-02')
BEGIN
	SET @VoucherTypeID_XK = 'PQ-XB-02'
	SET @VoucherTypeID_BH = 'PQ-BH-02'
END
ELSE IF(@VoucherTypeID = 'SO-VAT')
BEGIN
	SET @VoucherTypeID_BH = 'VAT'
END
ELSE IF(@VoucherTypeID = 'PQ-SO-VAT')
BEGIN
	SET @VoucherTypeID_BH = 'PQ-VAT'
END

--- Sinh động hóa đơn bán hàng
EXEC OP9024 @DivisionID, @TranMonth, @TranYear, @SOrderID,@VoucherTypeID_BH,@UserID

--- Sinh động phiếu xuất kho
IF(@VoucherTypeID NOT IN ('SO-VAT','PQ-SO-VAT'))
BEGIN
EXEC OP9023 @DivisionID, @TranMonth, @TranYear, @SOrderID,@VoucherTypeID_XK,@WareHouseID,@UserID
END
		
--SELECT @Status AS Status, @MessageID AS MessageID
--ENDMESS:
	--SELECT @Status AS Status, @MessageID AS MessageID

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
