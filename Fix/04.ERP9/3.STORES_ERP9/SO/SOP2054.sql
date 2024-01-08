IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP2054]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP2054]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO









-- <Summary>
---- Cảnh báo đơn hàng bán (customize DPT)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
-- <Example>
-- SOP2054 'DTI', 'HUULOI'
-- </Example>
----Created by Kiều Nga on 13/12/2021 : Cảnh báo đơn hàng bán có mặt hàng dưới mức giá tối thiểu.
----Update by Kiều Nga	on 15/12/2021 : Cảnh báo đơn hàng bán có số lượng tồn kho.
----Update by Văn Tài	on 15/12/2021 : Xóa dữ liệu thông báo cũ để khi update phiếu lại sẽ tính lại tồn kho.

CREATE PROC SOP2054
@DivisionID varchar(50),
@VoucherNo varchar(50),
@IsUpdated	TINYINT = 0
as
BEGIN TRY
	DECLARE @ListInventory nvarchar(max) = '',
			@ApprovePersonID nvarchar(50) ='',
			@SOrderID nvarchar(50) ='', 
			@PriceListID nvarchar(50) ='',
			@param nvarchar(max) = '',
			@IndexListInventory int =0,
			@TableCur CURSOR,
		    @APK_OOT9002 UNIQUEIDENTIFIER = NEWID(),
			@Delete_OOT9002 UNIQUEIDENTIFIER = NEWID(),
			@Title NVARCHAR(MAX)='', 
			@Description NVARCHAR(MAX)= '', 
			@ModuleID VARCHAR(50) = '',
			@ScreenID VARCHAR(50) = '',
			@UrlCustom NVARCHAR(500) = '',
			@CurrentDate Datetime = GETDATE(),
			@CurrentDateString Datetime = FORMAT(GETDATE(),'yyyyMMdd'),
			@ExpiryDate Datetime = DATEADD(MONTH,1,GETDATE()),
			@ShowType int = 1,
			@Parameters NVARCHAR(MAX) = '',
			@MessageType int = 1

	
	SET @SOrderID =(SELECT TOP 1 SOrderID FROM OT2001 T2 WITH (NOLOCK) WHERE VoucherNo = @VoucherNo AND DivisionID = @DivisionID)

	-- Trường hợp update cần xử lý thông báo và check lại tồn kho để sinh thông báo mới.
	IF @IsUpdated = 1
	BEGIN
		SET @Delete_OOT9002 = (SELECT TOP 1 APKMaster FROM OOT9002 WITH (NOLOCK) WHERE Parameters LIKE concat('WARNING_MinPrice_',@VoucherNo, '%'))

		DELETE OOT9003 WHERE DivisionID = @DivisionID AND APKMaster = @Delete_OOT9002
		DELETE OOT9002 WHERE APKMaster = @Delete_OOT9002
	END

	-- Cảnh báo đơn hàng dưới mức giá tối thiểu
	SET @ListInventory = stuff((
        select ','+convert(varchar(50),InventoryID) FROM OT2002 T1 WITH (NOLOCK) 
		WHERE  T1.DivisionID = @DivisionID AND T1.SOrderID = @SOrderID AND T1.MinPrice > T1.SalePrice
		GROUP BY InventoryID
        for xml path (''), type).value('.','nvarchar(max)')
      ,1,1,'')

	SET @param = concat('WARNING_MinPrice_',@VoucherNo)
	SET @IndexListInventory = LEN(@param)+2

	IF LEN(@ListInventory) > 0 AND NOT EXISTS (SELECT * FROM OOT9002 WITH (NOLOCK) 
	               WHERE CONVERT(NVARCHAR(50),APK) = (select TOP 1 APK from OOT9002 WHERE SUBSTRING([Parameters],1,LEN(@param)) = @param ORDER BY CreateDate DESC)
				    AND SUBSTRING([Parameters],@IndexListInventory,LEN([Parameters])) = @ListInventory)
	BEGIN	
		SET @PriceListID =(SELECT TOP 1 PriceListID FROM OT2001 T2 WITH (NOLOCK) WHERE VoucherNo = @VoucherNo AND DivisionID = @DivisionID)

		SET @TableCur = CURSOR SCROLL KEYSET FOR
		SELECT ApprovePersonID FROM OOT9001 T1 WITH (NOLOCK)
		INNER JOIN OT2001 T2 WITH (NOLOCK) ON T1.APKMaster = T2.APKMaster_9000
		WHERE T2.DivisionID = @DivisionID AND T2.SOrderID = @SOrderID
		GROUP BY ApprovePersonID

		OPEN @TableCur
		FETCH NEXT FROM @TableCur INTO @ApprovePersonID
		WHILE @@FETCH_STATUS = 0
		BEGIN	
			SET @APK_OOT9002= NEWID()
			SET	@Title = concat(N'Đơn hàng bán  ' ,@VoucherNo,N' có mặt hàng đơn giá dưới mức giá tối thiểu')
			SET	@Description = concat(N'Đơn hàng bán  ' ,@VoucherNo,N' có mặt hàng ',@ListInventory,N' đơn giá dưới mức giá tối thiểu trong bảng giá ',@PriceListID)
			SET	@ModuleID = 'SO'
			SET	@ScreenID = 'SOF2002'
			SET	@UrlCustom = concat('/ViewMasterDetail2/Index/SO/SOF2002?PK=',@SOrderID,'&Table=OT2001&key=SOrderID&DivisionID=',@DivisionID)
			SET	@CurrentDate = GETDATE()
			SET	@CurrentDateString = FORMAT(GETDATE(),'yyyyMMdd')
			SET	@ExpiryDate = DATEADD(MONTH,1,GETDATE())
			SET	@ShowType = 1
			SET	@Parameters = concat(@param,',',@ListInventory)
			SET	@MessageType= 1

			INSERT INTO OOT9002(APK, APKMaster, [Description], ModuleID, UrlCustom, [Parameters], CreateDate, EffectDate, ExpiryDate, Title,ShowType,ScreenID,MessageType)
			VALUES(@APK_OOT9002,@APK_OOT9002,@Description,@ModuleID,@UrlCustom,@Parameters,@CurrentDate,@CurrentDate,@ExpiryDate,@Title,@ShowType,@ScreenID,@MessageType)

			INSERT INTO OOT9003(APKMaster,UserID, DivisionID)
			VALUES(@APK_OOT9002,@ApprovePersonID,@DivisionID)

		FETCH NEXT FROM @TableCur INTO @ApprovePersonID
		CLOSE @TableCur
		END	
	END	
	--------------------------------------------

	-- Cảnh báo số lượng tồn kho
		SET @ListInventory = stuff((
        select ','+convert(varchar(50),OT22.InventoryID) FROM OT2001 OT21
					INNER JOIN OT2002 OT22 ON OT22.DivisionID = OT21.DivisionID AND OT22.SOrderID = OT21.SOrderID
					-- Lấy số lượng tồn kho
					LEFT JOIN (
							SELECT * FROM(
								SELECT ROW_NUMBER() OVER (PARTITION BY DivisionID, InventoryID ORDER BY TranYear,TranMonth DESC) AS rn, DivisionID, InventoryID,TranMonth, TranYear,SUM(EndQuantity) as EndQuantity
								FROM AT2008 WITH (NOLOCK) 
								GROUP BY DivisionID, InventoryID,TranMonth, TranYear) t
							WHERE t.rn = 1
					) A ON OT21.DivisionID = A.DivisionID AND OT22.InventoryID = A.InventoryID
					WHERE OT21.DivisionID = @DivisionID AND OT21.SOrderID = @SOrderID AND OT21.OrderType = 0
						  -- Mặt hàng không đủ số lượng
						  AND ISNULL(A.EndQuantity,0) < ISNULL(OT22.OrderQuantity,0)
        for xml path (''), type).value('.','nvarchar(max)')
      ,1,1,'')

	SET @param = concat('WARNING_EndQuantity_',@VoucherNo)
	SET @IndexListInventory = LEN(@param)+2

	IF LEN(@ListInventory) > 0 AND NOT EXISTS (SELECT * FROM OOT9002 WITH (NOLOCK) 
	               WHERE CONVERT(NVARCHAR(50),APK) = (select TOP 1 APK from OOT9002 WHERE SUBSTRING([Parameters],1,LEN(@param)) = @param ORDER BY CreateDate DESC)
				    AND SUBSTRING([Parameters],@IndexListInventory,LEN([Parameters])) = @ListInventory)
	BEGIN	

		SET @TableCur = CURSOR SCROLL KEYSET FOR
		SELECT ApprovePersonID FROM OOT9001 T1 WITH (NOLOCK)
		INNER JOIN OT2001 T2 WITH (NOLOCK) ON T1.APKMaster = T2.APKMaster_9000
		WHERE T2.DivisionID = @DivisionID AND T2.SOrderID = @SOrderID
		GROUP BY ApprovePersonID

		OPEN @TableCur
		FETCH NEXT FROM @TableCur INTO @ApprovePersonID
		WHILE @@FETCH_STATUS = 0
		BEGIN	
			SET @APK_OOT9002= NEWID()
			SET	@Title = concat(N'Đơn hàng bán  ' ,@VoucherNo,N' có mặt hàng không đủ số lượng tồn kho')
			SET	@Description = concat(N'Đơn hàng bán  ' ,@VoucherNo,N' có mặt hàng ',@ListInventory,N' không đủ số lượng tồn kho')
			SET	@ModuleID = 'SO'
			SET	@ScreenID = 'SOF2002'
			SET	@UrlCustom = concat('/ViewMasterDetail2/Index/SO/SOF2002?PK=',@SOrderID,'&Table=OT2001&key=SOrderID&DivisionID=',@DivisionID)
			SET	@CurrentDate = GETDATE()
			SET	@CurrentDateString = FORMAT(GETDATE(),'yyyyMMdd')
			SET	@ExpiryDate = DATEADD(MONTH,1,GETDATE())
			SET	@ShowType = 1
			SET	@Parameters = concat(@param,',',@ListInventory)
			SET	@MessageType= 1

			INSERT INTO OOT9002(APK, APKMaster, [Description], ModuleID, UrlCustom, [Parameters], CreateDate, EffectDate, ExpiryDate, Title,ShowType,ScreenID,MessageType)
			VALUES(@APK_OOT9002,@APK_OOT9002,@Description,@ModuleID,@UrlCustom,@Parameters,@CurrentDate,@CurrentDate,@ExpiryDate,@Title,@ShowType,@ScreenID,@MessageType)

			INSERT INTO OOT9003(APKMaster,UserID, DivisionID)
			VALUES(@APK_OOT9002,@ApprovePersonID,@DivisionID)

		FETCH NEXT FROM @TableCur INTO @ApprovePersonID
		CLOSE @TableCur
		END	
	END	
	--------------------------------------------

END TRY
BEGIN CATCH
	PRINT ERROR_MESSAGE()
END CATCH


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
