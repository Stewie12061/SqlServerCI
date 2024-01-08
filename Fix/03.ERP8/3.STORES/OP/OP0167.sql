IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP0167]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP0167]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----- Created by Hải Long.
---- Created Date Sunday 20/12/2016
---- Purpose: Update xuống đơn hàng bán khi lưu edit và thêm mới (Mạnh Phương)
---- Modified by Hải Long on 25/05/2017: Sửa danh mục dùng chung
---- Modified by Bả Anh on 13/04/2018: Bổ sung WITH (NOLOCK)
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
---- EXEC OP0167 @DivisionID = 'ANG', @SOrderID = 'TH/12/2016/0001', @Mode = 0

CREATE PROCEDURE [DBO].[OP0167]
(
	@DivisionID VARCHAR(50),
	@SOrderID VARCHAR(50),
	@Mode TINYINT  --0. Edit
				   --1. Sửa
)
AS
DECLARE @DeliveryStatus NVARCHAR(MAX),
		@DeliveryAddress NVARCHAR(MAX),
		@OrderNoAPP NVARCHAR(50),
		@OrderIDAPP NVARCHAR(50),
		@sSQL NVARCHAR(MAX),
		@Order_id NVARCHAR(50)

IF @Mode = 0 
BEGIN
	IF EXISTS 
	(
		SELECT TOP 1 1 FROM APT0001 WITH (NOLOCK)
		INNER JOIN OT2002 WITH (NOLOCK) ON APT0001.order_id = OT2002.AppInheritOrderID AND APT0001.APK = OT2002.ReAPK
		WHERE OT2002.DivisionID = @DivisionID AND OT2002.SOrderID = @SOrderID
	)
	BEGIN
		SELECT @OrderIDAPP = MAX(APT0001.order_id),
			   @DeliveryStatus = MAX(OT2002.Notes),
			   @DeliveryAddress = MAX(OT2001.DeliveryAddress)
		FROM APT0001 WITH (NOLOCK)
		INNER JOIN OT2002 WITH (NOLOCK) ON APT0001.order_id = OT2002.AppInheritOrderID AND APT0001.APK = OT2002.ReAPK
		INNER JOIN OT2001 WITH (NOLOCK) ON OT2001.DivisionID = OT2002.DivisionID AND OT2001.SOrderID = OT2002.SOrderID
		WHERE OT2001.DivisionID = @DivisionID
		AND OT2001.SOrderID = @SOrderID
	
		UPDATE APT0001
		SET DeliveryStatus = @DeliveryStatus,
			note		   = @DeliveryAddress
		WHERE order_id = @OrderIDAPP	
	
		UPDATE APT0001    
		SET quantity = OT2002.OrderQuantity   
		from APT0001
		INNER JOIN OT2002 WITH (NOLOCK) ON APT0001.order_id = OT2002.AppInheritOrderID AND APT0001.APK = OT2002.ReAPK
	
		PRINT @OrderIDAPP
		PRINT @DeliveryStatus
		PRINT @DeliveryAddress
	END	
END
ELSE
BEGIN
	-- Kiểm tra nếu có kế thừa từ appmobile thì xử lý
	IF EXISTS 
	(
		SELECT TOP 1 1 FROM APT0001 WITH (NOLOCK)
		INNER JOIN OT2002 WITH (NOLOCK) ON APT0001.order_id = OT2002.AppInheritOrderID AND APT0001.APK = OT2002.ReAPK
		WHERE OT2002.DivisionID = @DivisionID AND OT2002.SOrderID = @SOrderID
	)
	BEGIN
		SELECT @OrderIDAPP = MAX(APT0001.order_id),
			   @DeliveryStatus = MAX(OT2002.Notes),
			   @DeliveryAddress = MAX(OT2001.DeliveryAddress)
		FROM APT0001 WITH (NOLOCK)
		INNER JOIN OT2002 WITH (NOLOCK) ON APT0001.order_id = OT2002.AppInheritOrderID AND APT0001.APK = OT2002.ReAPK
		INNER JOIN OT2001 WITH (NOLOCK) ON OT2001.DivisionID = OT2002.DivisionID AND OT2001.SOrderID = OT2002.SOrderID
		WHERE OT2001.DivisionID = @DivisionID
		AND OT2001.SOrderID = @SOrderID
	
		UPDATE APT0001
		SET DeliveryStatus = @DeliveryStatus,
			note		   = @DeliveryAddress
		WHERE order_id = @OrderIDAPP	
	
		UPDATE APT0001    
		SET quantity = OT2002.OrderQuantity   
		from APT0001
		INNER JOIN OT2002 WITH (NOLOCK) ON APT0001.order_id = OT2002.AppInheritOrderID AND APT0001.APK = OT2002.ReAPK				
	END
	ELSE -- Kiểm tra nếu có chọn nhân viên thì tiến hành insert đơn hàng trên appmobile
	IF EXISTS (SELECT TOP 1 1 FROM OT2001 WITH (NOLOCK) WHERE OT2001.DivisionID = @DivisionID AND OT2001.SOrderID = @SOrderID AND ISNULL(Ana01ID, '') <> '')
	BEGIN
		-- Tạo số đơn hàng tiếp theo	
		SELECT @OrderNoAPP = MAX(order_no) FROM APT0001 WITH (NOLOCK) WHERE DivisionID = @DivisionID
		SET @OrderNoAPP = LEFT(@OrderNoAPP, LEN(@OrderNoAPP) - LEN(CONVERT(INT, @OrderNoAPP + 1))) + CONVERT(NVARCHAR(50), CONVERT(INT, @OrderNoAPP) + 1)
		
		SET @Order_id = NEWID()
		
		SET @sSQL = '
		INSERT INTO APT0001 (APK, DivisionID, [user_id], customer_id, order_id, order_no, order_created_date, discount_percent,
							 discount_money, note, product_id, quantity, unit, mode, CreateDate,
							 LastModifyDate, Orders, PriceListID, SalePrice, VATPercent, [Address], DeliveryStatus)
		SELECT OT2002.ReAPK, OT2002.DivisionID, OT2001.Ana01ID, OT2001.ObjectID, ''' + @Order_id + ''' AS order_id, ''' + @OrderNoAPP + ''' AS order_no, OT2001.OrderDate, OT2002.DiscountPercent,
		OT2002.DiscountConvertedAmount, OT2001.DeliveryAddress, OT2002.InventoryID, OT2002.OrderQuantity, OT2002.UnitID, OT2001.OrderStatus, OT2001.CreateDate,
		OT2001.CreateDate, OT2002.Orders, OT2001.PriceListID, OT2002.SalePrice, OT2002.VATPercent, AT1202.[Address], OT2002.Notes          
		FROM OT2001 WITH (NOLOCK)
		INNER JOIN OT2002 WITH (NOLOCK) ON OT2001.DivisionID = OT2002.DivisionID AND OT2001.SOrderID = OT2002.SOrderID
		LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND OT2001.ObjectID = AT1202.ObjectID
		WHERE OT2001.DivisionID = ''' + @DivisionID + '''
		AND OT2001.SOrderID = ''' + @SOrderID + ''''
		

		UPDATE OT2002
		SET AppInheritOrderID = @Order_id
		WHERE SOrderID = @SOrderID
	
		EXEC (@sSQL)
		--PRINT @sSQL		
	END
END	

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
