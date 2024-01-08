IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP0034]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP0034]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Lưu dữ liệu duyệt đơn hàng bán - OF0034
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 14/09/2011 by Nguyễn Bình Minh: Kiểm tra tồn kho sẵn sàng trước khi duyệt
---- 
---- Modified on 04/10/2011 by Lê Thị Thu Hiền
---- Modified on 01/10/2013 by Bảo Anh: Dùng bảng OT0034 thay cho bảng tạm #ReadyQuantityList để cải thiện tốc độ
---- Modified on 31/03/2015 by Mai Trí Thiện: Lưu thêm thông tin LastModifyUserID và LastModifyDate
---- Modified on 10/03/2016 by Thị Phượng : chuyển sang Select VoucherNo thay vì Select SOrderID trong message
---- Modified on 28/04/2016 by Phương Thảo: Cải tiến tốc độ
---- Modified on 09/05/2017 by Phương Thảo : Bổ sung tự động sinh ĐHSX khi duyệt ĐH bán
---- Modified on 01/09/2017 by Phương Thảo : Bổ sung lưu quy cách cho ĐHSX khi sinh tự động
---- Modified on 17/05/2018 by Bảo Anh: Bổ sung sinh tự động phiếu bán hàng và xuất kho khi duyệt đơn hàng bán
---- Modified on 21/08/2018 by Bảo Anh: Không cho bỏ duyệt khi đơn hàng đã kế thừa qua AsoftT
---- Modified on 21/01/2019 by Kim Thư: Tạo bảng tạm thay cho View OV2800 cải thiện tốc độ
---- Modified on 19/07/2019 by Kim Thư: Kiểm tra tồn kho đến thời điểm hiện tại trước khi duyệt (Customize = 67 - Kim Hoàn Vũ)
---- Modified on 16/03/2020 by Văn Tài: Bổ sung WITH(NOLOCK), thứ tự join theo index.
---- Modified on 23/06/2021 by Huỳnh Thử: Kiểm tra đã kế thừa Đơn hàng bán
-- <Example>
---- 
CREATE PROCEDURE [DBO].[OP0034]
( 
	@DivisionID AS NVARCHAR(50),	
	@SOrderID AS NVARCHAR(250),
	@DescriptionConfirm AS NVARCHAR(250),
	@IsConfirm AS TINYINT,
	@ActionMode AS TINYINT = 0, -- ActionMode = 1 là luôn lưu
	@UserID AS NVARCHAR(50) = '',
	@ClassifyID AS NVARCHAR(50) = '',
	@SIVoucherTypeID AS NVARCHAR(50) = '',	--- Loại chứng từ HĐBH dùng cho sinh tự động phiếu bán hàng của Mạnh Phương
	@DEVoucherTypeID AS NVARCHAR(50) = '',	--- Loại chứng từ phiếu xuất dùng cho sinh tự động phiếu xuất kho của Mạnh Phương
	@LastModifyDate AS DATETIME = NULL
) 
AS
SET NOCOUNT ON

DECLARE @InventoryID AS NVARCHAR(50),
		@Status AS TINYINT,
		@Status1 AS TINYINT,
		@MessageID AS NVARCHAR(50),
		@WarehouseID AS NVARCHAR(50),
		@InventoryIDAllow AS NVARCHAR(50),
		@CustomerIndex int,
		@IsAutoMO AS Tinyint		,
		@MOVoucherTypeID NVarchar(50),
		@TranMonth AS INT,
		@TranYear AS INT
		
SET @Status = 0 -- Không thông báo
SET @Status1 = 0 -- Không thông báo, biến này chỉ dùng ghi nhận cho Mạnh Phương
SET @MessageID = ''


SELECT TOP 1 @CustomerIndex = CustomerName From CustomerIndex WITH (NOLOCK)
IF(@CustomerIndex = 73) --- KH Đông Dương
BEGIN
	SELECT	@MOVoucherTypeID = VoucherTypeID 
	FROM	OT1001 WITH (NOLOCK)
	WHERE	DivisionID = @DivisionID AND ClassifyID = @ClassifyID
END

IF(@CustomerIndex = 69 AND @LastModifyDate <> (SELECT TOP 1 LastModifyDate FROM OT2001 WITH (NOLOCK) WHERE SOrderID = @SOrderID))
BEGIN
	SET @Status = 3
	SET @MessageID = 'OFML000082'
	GOTO ENDMESS
END

SELECT	@IsAutoMO = IsAutoMO,
		@MOVoucherTypeID = CASE WHEN ISNULL(@MOVoucherTypeID,'') = '' THEN AutoMOVoucherTypeID ELSE @MOVoucherTypeID END
FROM	OT0000 WITH (NOLOCK)

IF @IsConfirm <> 1 -- Nếu không duyệt thì không kiểm tra tồn kho sẵn sàng
BEGIN
	IF @CustomerIndex = 69	--- Mạnh Phương: xóa HĐBH và phiếu xuất sinh tự động theo đơn hàng
	BEGIN
		IF EXISTS (SELECT 1 FROM AT9000 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND OrderID = @SOrderID)
		BEGIN
			SET @Status = 3
			SET @Status1 = 1
		END	
		ELSE
		BEGIN
			UPDATE		OT2001 
			SET			IsConfirm = @IsConfirm,
						DescriptionConfirm = @DescriptionConfirm, 
						OrderStatus = 0,
						LastModifyUserID = @UserID, --Lưu vết bỏ duyệt
						LastModifyDate = GETDATE() --Lưu vết bỏ duyệt
			WHERE		DivisionID = @DivisionID AND SOrderID = @SOrderID
		END		
	END
	ELSE
	BEGIN
	    -- Kiểm tra đã kế thừa Đơn hàng bán
		IF EXISTS (SELECT 1 FROM OT2002 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND InheritVoucherID = @SOrderID)
		BEGIN
			SET @Status = 2
		    SET @MessageID =  'OFML000261'
			GOTO ENDMESS
		END
		UPDATE		OT2001 
		SET			IsConfirm = @IsConfirm,
					DescriptionConfirm = @DescriptionConfirm, 
					OrderStatus = 0,
					LastModifyUserID = @UserID, --Lưu vết bỏ duyệt
					LastModifyDate = GETDATE() --Lưu vết bỏ duyệt
		WHERE		DivisionID = @DivisionID AND SOrderID = @SOrderID

		-- Neu huy duyet thi tu dong xoa DHSX tu dong sinh
		IF(@IsAutoMO = 1)
		BEGIN
			DELETE T1
			FROM OT2002 T1
			INNER JOIN OT2001 T2 WITH (NOLOCK) ON T1.SOrderID  = T2.SOrderID AND T2.OrderType = 1
			WHERE T1.DivisionID = @DivisionID AND T1.InheritVoucherID = @SOrderID 

			DELETE OT2001
			WHERE DivisionID = @DivisionID AND InheritSOrderID = @SOrderID AND OrderType = 1
		END
	END	
END
ELSE --- Duyet 
	BEGIN
		IF @ActionMode = 0
			BEGIN
			-- Tạo bảng tạm thay cho View OV2800 - cải thiện tốc độ - Begin ------------------------------
			
			-- Bảng tạm giao hàng
			Select T00.OrderID, InventoryID, sum(ActualQuantity) AS ActualQuantity,
				ISNULL(W89.S01ID,'') AS S01ID, ISNULL(W89.S02ID,'') AS S02ID, ISNULL(W89.S03ID,'') AS S03ID, ISNULL(W89.S04ID,'') AS S04ID, ISNULL(W89.S05ID,'') AS S05ID, 
				ISNULL(W89.S06ID,'') AS S06ID, ISNULL(W89.S07ID,'') AS S07ID, ISNULL(W89.S08ID,'') AS S08ID, ISNULL(W89.S09ID,'') AS S09ID, ISNULL(W89.S10ID,'') AS S10ID,
				ISNULL(W89.S11ID,'') AS S11ID, ISNULL(W89.S12ID,'') AS S12ID, ISNULL(W89.S13ID,'') AS S13ID, ISNULL(W89.S14ID,'') AS S14ID, ISNULL(W89.S15ID,'') AS S15ID, 
				ISNULL(W89.S16ID,'') AS S16ID, ISNULL(W89.S17ID,'') AS S17ID, ISNULL(W89.S18ID,'') AS S18ID, ISNULL(W89.S19ID,'') AS S19ID, ISNULL(W89.S20ID,'') AS S20ID
			INTO #T02
			FROM AT2007 T00  WITH (NOLOCK) inner join AT2006 T01 WITH (NOLOCK) ON T01.DivisionID = T00.DivisionID AND T00.VoucherID = T01.VoucherID
				LEFT JOIN WT8899 W89 WITH (NOLOCK) ON T00.DivisionID = W89.DivisionID AND T00.TransactionID = W89.TransactionID AND T00.VoucherID = W89.VoucherID
			Where KindVoucherID in (2, 4) and isnull(T00.OrderID, '') <> ''
			Group by T00.OrderID, InventoryID, ISNULL(W89.S01ID,''), ISNULL(W89.S02ID,''), ISNULL(W89.S03ID,''), ISNULL(W89.S04ID,''), ISNULL(W89.S05ID,''), 
				ISNULL(W89.S06ID,''), ISNULL(W89.S07ID,''), ISNULL(W89.S08ID,''), ISNULL(W89.S09ID,''), ISNULL(W89.S10ID,''),
				ISNULL(W89.S11ID,''), ISNULL(W89.S12ID,''), ISNULL(W89.S13ID,''), ISNULL(W89.S14ID,''), ISNULL(W89.S15ID,''), 
				ISNULL(W89.S16ID,''), ISNULL(W89.S17ID,''), ISNULL(W89.S18ID,''), ISNULL(W89.S19ID,''), ISNULL(W89.S20ID,'')
			
			-- Bảng tạm nhập hàng
			Select T00.OrderID, InventoryID, sum(ActualQuantity) as ActualQuantity,
				ISNULL(W89.S01ID,'') AS S01ID, ISNULL(W89.S02ID,'') AS S02ID, ISNULL(W89.S03ID,'') AS S03ID, ISNULL(W89.S04ID,'') AS S04ID, ISNULL(W89.S05ID,'') AS S05ID, 
				ISNULL(W89.S06ID,'') AS S06ID, ISNULL(W89.S07ID,'') AS S07ID, ISNULL(W89.S08ID,'') AS S08ID, ISNULL(W89.S09ID,'') AS S09ID, ISNULL(W89.S10ID,'') AS S10ID,
				ISNULL(W89.S11ID,'') AS S11ID, ISNULL(W89.S12ID,'') AS S12ID, ISNULL(W89.S13ID,'') AS S13ID, ISNULL(W89.S14ID,'') AS S14ID, ISNULL(W89.S15ID,'') AS S15ID, 
				ISNULL(W89.S16ID,'') AS S16ID, ISNULL(W89.S17ID,'') AS S17ID, ISNULL(W89.S18ID,'') AS S18ID, ISNULL(W89.S19ID,'') AS S19ID, ISNULL(W89.S20ID,'') AS S20ID
			INTO #T03
			From AT2007 T00  WITH (NOLOCK) inner join AT2006 T01  WITH (NOLOCK) ON T01.DivisionID = T00.DivisionID AND T00.VoucherID = T01.VoucherID
				LEFT JOIN WT8899 W89  WITH (NOLOCK) on T00.DivisionID = W89.DivisionID AND T00.TransactionID = W89.TransactionID AND T00.VoucherID = W89.VoucherID
			Where KindVoucherID in (1, 5, 7) and isnull(T00.OrderID, '') <> ''
			Group by T00.OrderID, InventoryID, ISNULL(W89.S01ID,''), ISNULL(W89.S02ID,''), ISNULL(W89.S03ID,''), ISNULL(W89.S04ID,''), ISNULL(W89.S05ID,''), 
				ISNULL(W89.S06ID,''), ISNULL(W89.S07ID,''), ISNULL(W89.S08ID,''), ISNULL(W89.S09ID,''), ISNULL(W89.S10ID,''),
				ISNULL(W89.S11ID,''), ISNULL(W89.S12ID,''), ISNULL(W89.S13ID,''), ISNULL(W89.S14ID,''), ISNULL(W89.S15ID,''), 
				ISNULL(W89.S16ID,''), ISNULL(W89.S17ID,''), ISNULL(W89.S18ID,''), ISNULL(W89.S19ID,''), ISNULL(W89.S20ID,'')


			Select 'SO' as TypeID, T01.DivisionID, T00.SOrderID as OrderID, T00.InventoryID, WareHouseID, ObjectID,EmployeeID,OrderDate,
				sum(isnull(OrderQuantity, 0)) as OrderQuantity, 
				sum(isnull(AdjustQuantity,0)) as AdjustQuantity,
				avg(isnull(ActualQuantity, 0)) as ActualQuantity,
				T00.Finish, T01.Tranmonth, T01.Tranyear,
				ISNULL(O89.S01ID,'') AS S01ID, ISNULL(O89.S02ID,'') AS S02ID, ISNULL(O89.S03ID,'') AS S03ID, ISNULL(O89.S04ID,'') AS S04ID, ISNULL(O89.S05ID,'') AS S05ID, 
				ISNULL(O89.S06ID,'') AS S06ID, ISNULL(O89.S07ID,'') AS S07ID, ISNULL(O89.S08ID,'') AS S08ID, ISNULL(O89.S09ID,'') AS S09ID, ISNULL(O89.S10ID,'') AS S10ID,
				ISNULL(O89.S11ID,'') AS S11ID, ISNULL(O89.S12ID,'') AS S12ID, ISNULL(O89.S13ID,'') AS S13ID, ISNULL(O89.S14ID,'') AS S14ID, ISNULL(O89.S15ID,'') AS S15ID, 
				ISNULL(O89.S16ID,'') AS S16ID, ISNULL(O89.S17ID,'') AS S17ID, ISNULL(O89.S18ID,'') AS S18ID, ISNULL(O89.S19ID,'') AS S19ID, ISNULL(O89.S20ID,'') AS S20ID
			INTO #OV2800
			FROM  OT2002 T00  WITH (NOLOCK) inner join OT2001 T01  WITH (NOLOCK) ON T01.DivisionID = T00.DivisionID AND T00.SOrderID = T01.SOrderID 
			LEFT JOIN OT8899 O89  WITH (NOLOCK) ON T00.DivisionID = O89.DivisionID AND T00.TransactionID = O89.TransactionID AND T00.SOrderID = O89.VoucherID
			LEFT JOIN #T02 T02 ON T02.InventoryID = T00.InventoryID and T02.OrderID = T00.SOrderID
			AND ISNULL(T02.S01ID,'') = isnull(O89.S01ID,'') AND ISNULL(T02.S02ID,'') = isnull(O89.S02ID,'')
			AND ISNULL(T02.S03ID,'') = isnull(O89.S03ID,'') AND ISNULL(T02.S04ID,'') = isnull(O89.S04ID,'') 
			AND ISNULL(T02.S05ID,'') = isnull(O89.S05ID,'') AND ISNULL(T02.S06ID,'') = isnull(O89.S06ID,'') 
			AND ISNULL(T02.S07ID,'') = isnull(O89.S07ID,'') AND ISNULL(T02.S08ID,'') = isnull(O89.S08ID,'') 
			AND ISNULL(T02.S09ID,'') = isnull(O89.S09ID,'') AND ISNULL(T02.S10ID,'') = isnull(O89.S10ID,'') 
			AND ISNULL(T02.S11ID,'') = isnull(O89.S11ID,'') AND ISNULL(T02.S12ID,'') = isnull(O89.S12ID,'') 
			AND ISNULL(T02.S13ID,'') = isnull(O89.S13ID,'') AND ISNULL(T02.S14ID,'') = isnull(O89.S14ID,'') 
			AND ISNULL(T02.S15ID,'') = isnull(O89.S15ID,'') AND ISNULL(T02.S16ID,'') = isnull(O89.S16ID,'') 
			AND ISNULL(T02.S17ID,'') = isnull(O89.S17ID,'') AND ISNULL(T02.S18ID,'') = isnull(O89.S18ID,'') 
			AND ISNULL(T02.S19ID,'') = isnull(O89.S19ID,'') AND ISNULL(T02.S20ID,'') = isnull(O89.S20ID,'')
			Where OrderStatus not in (0, 3, 4, 9) and T00.IsPicking = 1  and T01.Disabled = 0
			Group by T01.DivisionID,  T00.SOrderID, T00.InventoryID, WareHouseID, T00.Finish, ObjectID,EmployeeID,OrderDate,T01.Tranmonth, T01.Tranyear,
			ISNULL(O89.S01ID,''), ISNULL(O89.S02ID,''), ISNULL(O89.S03ID,''), ISNULL(O89.S04ID,''), ISNULL(O89.S05ID,''), 
			ISNULL(O89.S06ID,''), ISNULL(O89.S07ID,''), ISNULL(O89.S08ID,''), ISNULL(O89.S09ID,''), ISNULL(O89.S10ID,''),
			ISNULL(O89.S11ID,''), ISNULL(O89.S12ID,''), ISNULL(O89.S13ID,''), ISNULL(O89.S14ID,''), ISNULL(O89.S15ID,''), 
			ISNULL(O89.S16ID,''), ISNULL(O89.S17ID,''), ISNULL(O89.S18ID,''), ISNULL(O89.S19ID,''), ISNULL(O89.S20ID,'')

			Union All

			--Giu cho DN như giu cho SO  (Phieu giao viec- Delivery Note)
			Select  'DN' as TypeID, z.DivisionID, z.OrderID, z.InventoryID, z.WareHouseID, z.ObjectID, z.EmployeeID, z.VoucherDate
				, sum(z.OrderQuantity) as OrderQuantity  --Giữ chỗ
				, 0 as AdjustQuantity --Điều chỉnh
				, sum(z.ActualQuantity) as ActualQuantity --Thực xuất			
				, z.Finish, z.Tranmonth, z.Tranyear,
				CONVERT(VARCHAR(50),'') AS S01ID, CONVERT(VARCHAR(50),'') AS S02ID, CONVERT(VARCHAR(50),'') AS S03ID, CONVERT(VARCHAR(50),'') AS S04ID, CONVERT(VARCHAR(50),'') AS S05ID, 
				CONVERT(VARCHAR(50),'') AS S06ID, CONVERT(VARCHAR(50),'') AS S07ID, CONVERT(VARCHAR(50),'') AS S08ID, CONVERT(VARCHAR(50),'') AS S09ID, CONVERT(VARCHAR(50),'') AS S10ID,
				CONVERT(VARCHAR(50),'') AS S11ID, CONVERT(VARCHAR(50),'') AS S12ID, CONVERT(VARCHAR(50),'') AS S13ID, CONVERT(VARCHAR(50),'') AS S14ID, CONVERT(VARCHAR(50),'') AS S15ID, 
				CONVERT(VARCHAR(50),'') AS S16ID, CONVERT(VARCHAR(50),'') AS S17ID, CONVERT(VARCHAR(50),'') AS S18ID, CONVERT(VARCHAR(50),'') AS S19ID, CONVERT(VARCHAR(50),'') AS S20ID
			
			From 
			(
					Select D.DivisionID, M.VoucherID as OrderID, D.RInventoryID as InventoryID, D.WareHouseID, M.ObjectID,M.EmployeeID,M.VoucherDate,
						1 as OrderQuantity, 
						0 as AdjustQuantity,
						isnull(A.ActualQuantity, 0) as ActualQuantity,
						0 as Finish, M.Tranmonth, M.Tranyear
					From  MT2007 M  WITH (NOLOCK) inner join MT2008 D  WITH (NOLOCK) ON M.DivisionID = D.DivisionID AND M.VoucherID = D.VoucherID 
									Left join AT2007 A  WITH (NOLOCK)  ON A.DivisionID = D.DivisionID AND A.InheritVoucherID = D.VoucherID AND A.InheritTransactionID = D.TransactionID
									left join AT2006 B WITH (NOLOCK)  ON A.DivisionID = B.DivisionID AND A.VoucherID = B.VoucherID
									and KindVoucherID in (2, 4)
					Where D.InventoryID is not null and D.WareHouseID is not null
			) z
			Group by z.DivisionID, z.OrderID, z.InventoryID, z.WareHouseID, z.ObjectID, z.EmployeeID, z.VoucherDate, z.Finish, z.Tranmonth, z.Tranyear

			Union All

			--Hang dang ve PO
			Select 'PO' as TypeID, T01.DivisionID, T00.POrderID, T00.InventoryID, WareHouseID, ObjectID,EmployeeID,OrderDate,
				sum(isnull(OrderQuantity, 0)) as OrderQuantity, 
				sum(isnull(AdjustQuantity,0)) as AdjustQuantity,
				avg(isnull(ActualQuantity,0)) as ActualQuantity,
				T00.Finish	,T01.Tranmonth, T01.Tranyear,
				ISNULL(O89.S01ID,'') AS S01ID, ISNULL(O89.S02ID,'') AS S02ID, ISNULL(O89.S03ID,'') AS S03ID, ISNULL(O89.S04ID,'') AS S04ID, ISNULL(O89.S05ID,'') AS S05ID, 
				ISNULL(O89.S06ID,'') AS S06ID, ISNULL(O89.S07ID,'') AS S07ID, ISNULL(O89.S08ID,'') AS S08ID, ISNULL(O89.S09ID,'') AS S09ID, ISNULL(O89.S10ID,'') AS S10ID,
				ISNULL(O89.S11ID,'') AS S11ID, ISNULL(O89.S12ID,'') AS S12ID, ISNULL(O89.S13ID,'') AS S13ID, ISNULL(O89.S14ID,'') AS S14ID, ISNULL(O89.S15ID,'') AS S15ID, 
				ISNULL(O89.S16ID,'') AS S16ID, ISNULL(O89.S17ID,'') AS S17ID, ISNULL(O89.S18ID,'') AS S18ID, ISNULL(O89.S19ID,'') AS S19ID, ISNULL(O89.S20ID,'') AS S20ID
			From  OT3002 T00  WITH (NOLOCK) inner join OT3001 T01  WITH (NOLOCK) ON T01.DivisionID = T00.DivisionID AND T00.POrderID = T01.POrderID
			LEFT JOIN OT8899 O89  WITH (NOLOCK) ON T00.DivisionID = O89.DivisionID AND T00.TransactionID = O89.TransactionID AND T00.POrderID = O89.VoucherID
			LEFT JOIN #T03 T03 ON T03.OrderID = T00.POrderID and T03.InventoryID = T00.InventoryID
			AND ISNULL(T03.S01ID,'') = ISNULL(O89.S01ID,'') AND ISNULL(T03.S02ID,'') = isnull(O89.S02ID,'')
			AND ISNULL(T03.S03ID,'') = ISNULL(O89.S03ID,'') AND ISNULL(T03.S04ID,'') = isnull(O89.S04ID,'') 
			AND ISNULL(T03.S05ID,'') = ISNULL(O89.S05ID,'') AND ISNULL(T03.S06ID,'') = isnull(O89.S06ID,'') 
			AND ISNULL(T03.S07ID,'') = ISNULL(O89.S07ID,'') AND ISNULL(T03.S08ID,'') = isnull(O89.S08ID,'') 
			AND ISNULL(T03.S09ID,'') = ISNULL(O89.S09ID,'') AND ISNULL(T03.S10ID,'') = isnull(O89.S10ID,'') 
			AND ISNULL(T03.S11ID,'') = ISNULL(O89.S11ID,'') AND ISNULL(T03.S12ID,'') = isnull(O89.S12ID,'') 
			AND ISNULL(T03.S13ID,'') = ISNULL(O89.S13ID,'') AND ISNULL(T03.S14ID,'') = isnull(O89.S14ID,'') 
			AND ISNULL(T03.S15ID,'') = ISNULL(O89.S15ID,'') AND ISNULL(T03.S16ID,'') = isnull(O89.S16ID,'') 
			AND ISNULL(T03.S17ID,'') = ISNULL(O89.S17ID,'') AND ISNULL(T03.S18ID,'') = isnull(O89.S18ID,'') 
			AND ISNULL(T03.S19ID,'') = ISNULL(O89.S19ID,'') AND ISNULL(T03.S20ID,'') = isnull(O89.S20ID,'')

			Where OrderStatus not in (0, 3,4, 9) and T00.IsPicking = 1  and T01.Disabled = 0
			Group by T01.DivisionID, T00.POrderID, T00.InventoryID, WareHouseID, T00.Finish	,ObjectID,EmployeeID,OrderDate,T01.Tranmonth, T01.Tranyear,
			ISNULL(O89.S01ID,''), ISNULL(O89.S02ID,''), ISNULL(O89.S03ID,''), ISNULL(O89.S04ID,''), ISNULL(O89.S05ID,''), 
			ISNULL(O89.S06ID,''), ISNULL(O89.S07ID,''), ISNULL(O89.S08ID,''), ISNULL(O89.S09ID,''), ISNULL(O89.S10ID,''),
			ISNULL(O89.S11ID,''), ISNULL(O89.S12ID,''), ISNULL(O89.S13ID,''), ISNULL(O89.S14ID,''), ISNULL(O89.S15ID,''), 
			ISNULL(O89.S16ID,''), ISNULL(O89.S17ID,''), ISNULL(O89.S18ID,''), ISNULL(O89.S19ID,''), ISNULL(O89.S20ID,'')


			Union All

			--Giu cho du tru ES
			Select 'ES' as TypeID, T01.DivisionID,  T00.EstimateID as OrderID, MaterialID as InventoryID, T01.WareHouseID, '' as  ObjectID,EmployeeID, null as OrderDate,
				sum(isnull(MaterialQuantity, 0)) as OrderQuantity, 
				0 as AdjustQuantity, avg(isnull(ActualQuantity,0)) as ActualQuantity,
				0 as Finish, T01.Tranmonth, T01.Tranyear,
				CONVERT(VARCHAR(50),'') AS S01ID, CONVERT(VARCHAR(50),'') AS S02ID, CONVERT(VARCHAR(50),'') AS S03ID, CONVERT(VARCHAR(50),'') AS S04ID, CONVERT(VARCHAR(50),'') AS S05ID, 
				CONVERT(VARCHAR(50),'') AS S06ID, CONVERT(VARCHAR(50),'') AS S07ID, CONVERT(VARCHAR(50),'') AS S08ID, CONVERT(VARCHAR(50),'') AS S09ID, CONVERT(VARCHAR(50),'') AS S10ID,
				CONVERT(VARCHAR(50),'') AS S11ID, CONVERT(VARCHAR(50),'') AS S12ID, CONVERT(VARCHAR(50),'') AS S13ID, CONVERT(VARCHAR(50),'') AS S14ID, CONVERT(VARCHAR(50),'') AS S15ID, 
				CONVERT(VARCHAR(50),'') AS S16ID, CONVERT(VARCHAR(50),'') AS S17ID, CONVERT(VARCHAR(50),'') AS S18ID, CONVERT(VARCHAR(50),'') AS S19ID, CONVERT(VARCHAR(50),'') AS S20ID
			From  OT2203 T00  WITH (NOLOCK) inner join OT2201 T01  WITH (NOLOCK) ON T01.DivisionID = T00.DivisionID AND T00.EstimateID = T01.EstimateID
				left join (--Xuat hang ES
				Select T00.OrderID, InventoryID, sum(ActualQuantity) as ActualQuantity
				From AT2007 T00 WITH (NOLOCK)  inner join AT2006 T01 WITH (NOLOCK)  ON T01.DivisionID = T00.DivisionID AND T00.VoucherID = T01.VoucherID
				Where KindVoucherID in (2, 4) and isnull(T00.OrderID, '') <> ''
				Group by T00.DivisionID, T00.OrderID, InventoryID
				) T03 on T03.OrderID = T00.EstimateID and T03.InventoryID = T00.MaterialID 
			Where OrderStatus not in (0, 2, 9) and T00.IsPicking = 1 -- and T01.Disabled = 0
			Group by T01.DivisionID, T00.EstimateID, MaterialID, T01.WareHouseID,EmployeeID,T01.Tranmonth, T01.Tranyear

			-- Tạo bảng tạm thay cho View OV2800 - cải thiện tốc độ - End ------------------------------
			
				Select @InventoryID = InventoryID FROM OT2002 WITH (NOLOCK) WHERE SOrderID = @SOrderID
				Select @WarehouseID = WarehouseID FROM OT2002 WITH (NOLOCK) WHERE SOrderID = @SOrderID
			
				SELECT	OP.DivisionID,
						ISNULL(OP.WareHouseID, WH.WareHouseID) AS WareHouseID,
						ISNULL(OP.InventoryID, WH.InventoryID) AS InventoryID,
						SUM(CASE WHEN OP.TypeID <> 'PO' AND OP.Finish <> 1 THEN OP.OrderQuantity - OP.ActualQuantity ELSE 0 END) AS SQuantity,
						SUM(CASE WHEN TypeID = 'PO' AND OP.Finish <> 1 THEN OP.OrderQuantity - OP.ActualQuantity ELSE 0 END) AS PQuantity,
						SUM(ISNULL(WH.DebitQuantity, 0)) - SUM(ISNULL(WH.CreditQuantity, 0)) AS EndQuantity
				INTO		#ReadyQuantityList
				FROM		#OV2800 OP
				FULL JOIN	OV2401 WH
						ON	WH.DivisionID = OP.DivisionID AND WH.WareHouseID = OP.WareHouseID AND WH.InventoryID = OP.InventoryID
				WHERE		 ISNULL(OP.WareHouseID, WH.WareHouseID) = @WarehouseID AND ISNULL(OP.InventoryID, WH.InventoryID)= @InventoryID
				GROUP BY	OP.DivisionID, ISNULL(OP.WareHouseID, WH.WareHouseID),	ISNULL(OP.InventoryID, WH.InventoryID)
			
				----- Tồn kho sẵn sàng = Tồn kho thực tế (EndQuantity) - Giữ chỗ (SQuantity) + Đang về (PQuantity)
				SELECT		TOP 1 @InventoryIDAllow = SOD.InventoryID
				FROM		OT2001 SO WITH (NOLOCK)
				INNER JOIN 	OT2002 SOD WITH (NOLOCK)
						ON	SO.DivisionID = SOD.DivisionID AND SO.SOrderID = SOD.SOrderID
				LEFT JOIN	#ReadyQuantityList RQ
						ON	RQ.DivisionID = SOD.DivisionID AND ISNULL(RQ.WareHouseID, '') = ISNULL(SOD.WareHouseID, '') AND RQ.InventoryID = SOD.InventoryID
				WHERE		SO.DivisionID = @DivisionID AND SO.SOrderID = @SOrderID
							AND ISNULL(RQ.EndQuantity - RQ.SQuantity + RQ.PQuantity, 0) < SOD.OrderQuantity
			
				DROP TABLE #ReadyQuantityList

				IF ISNULL(@InventoryIDAllow, '') <> ''
					BEGIN
						SET @Status = (	SELECT TOP 1 ISNULL(SOCheckWH, 0) 
							FROM	OT0001 WITH (NOLOCK)
       						WHERE	DivisionID = @DivisionID 
       								AND TypeID = 'SO'
						)
					END
			
				IF @Status = 0
				BEGIN
					IF @CustomerIndex = 69	--- Mạnh Phương: Kiểm tra nếu ky kế toán ở T và WM chưa khóa thì tự sinh HĐBH và phiếu xuất kho
					BEGIN
						SELECT @TranMonth = TranMonth, @TranYear = TranYear
						FROM OT2001 WITH (NOLOCK)
						WHERE DivisionID = @DivisionID AND SOrderID = @SOrderID

						IF (Select Closing From AT9999 WITH (NOLOCK) Where DivisionID = @DivisionID AND TranMonth = @TranMonth AND TranYear = @TranYear) = 0
							AND (Select Closing From WT9999 WITH (NOLOCK) Where DivisionID = @DivisionID AND TranMonth = @TranMonth AND TranYear = @TranYear) = 0
							BEGIN
								UPDATE		OT2001
								SET			IsConfirm = @IsConfirm,
											DescriptionConfirm = @DescriptionConfirm, 
											OrderStatus = 1,
											LastModifyUserID = @UserID,
											LastModifyDate = GETDATE()
								WHERE		DivisionID = @DivisionID 
											AND SOrderID = @SOrderID

								EXEC OP9014 @DivisionID, @TranMonth, @TranYear, @SOrderID, @SIVoucherTypeID, @DEVoucherTypeID
							END
						ELSE
							BEGIN
								SET @Status = 3
								SET @Status1 = 2	
								SET @InventoryIDAllow = ''
							END
					END
					ELSE
					BEGIN
						UPDATE		OT2001 
						SET			IsConfirm = @IsConfirm,
									DescriptionConfirm = @DescriptionConfirm, 
									OrderStatus = 1,
									LastModifyUserID = @UserID,
									LastModifyDate = GETDATE()
						WHERE		DivisionID = @DivisionID 
									AND SOrderID = @SOrderID
					END
				END
				
				-- Customize Kim Hoàn Vũ
				IF @CustomerIndex=67
				BEGIN
					DECLARE @Cur Cursor, @Quantity DECIMAL(28,8)
					SET @Cur  = Cursor Scroll KeySet FOR 
						SELECT DISTINCT InventoryID, SUM(OrderQuantity) as Quantity FROM OT2002 WHERE SOrderID=@SOrderID GROUP BY InventoryID
					OPEN @Cur
					FETCH NEXT FROM @Cur INTO @InventoryID, @Quantity
					WHILE @@Fetch_Status = 0
					BEGIN
						SELECT @InventoryID AS InventoryID, @Quantity AS Quantity,
								(SELECT Sum(EndQuantity) as EndQuantity FROM AT2008 WITH (NOLOCK)
								WHERE DivisionID=@DivisionID and InventoryID=@InventoryID
								GROUP BY InventoryID) AS EndQuantity
						INTO #TEMP
					FETCH NEXT FROM @Cur INTO  @InventoryID, @Quantity
					END            
					CLOSE @Cur
					DEALLOCATE @Cur

					IF EXISTS (SELECT TOP 1 1 FROM #TEMP WHERE Quantity > EndQuantity)
						SET @Status=4

				END

			END	---	@ActionMode = 0
			
		ELSE ---IF @ActionMode = 1 ---- Luon luon Luu
			BEGIN
				UPDATE		OT2001 
				SET			IsConfirm = @IsConfirm,
							DescriptionConfirm = @DescriptionConfirm, 
							OrderStatus = 1,
							LastModifyUserID = @UserID,
							LastModifyDate = GETDATE()
				WHERE		DivisionID = @DivisionID 
							AND SOrderID = @SOrderID
			END	

		-- Tự động sinh đơn hàng sản xuất
		IF(@IsAutoMO = 1)
		BEGIN
			DECLARE @VoucherNo NVarchar(50), @S1 Varchar(10),  @S2 Varchar(10),  @S3 Varchar(10), 
			@OutputLength int, @Seperator varchar(3), @Seperated int, @OutputOrder int

			Select @S1 = S1, @S2 = S2, @S3 = S3, @OutputLength = OutputLength, @Seperator = Separator, 
			@Seperated = Separated, @OutputOrder = OutputOrder
			from AT1007 WITH (NOLOCK) where VoucherTypeID = @MOVoucherTypeID


			--- Sinh so phieu VoucherNo
			EXEC AP0000 @DivisionID = @DivisionID, @NewKey = @VoucherNo OUTPUT, @TableName = 'AT2001', @StringKey1 = @S1, @StringKey2 = @S2, @StringKey3 = @S3, @OutputLen = @OutputLength,
					@OutputOrder = @OutputOrder, @Seperated = @Seperated, @Seperator = @Seperator	

			INSERT INTO OT2001(
      						DivisionID, SOrderID, VoucherTypeID, VoucherNo, OrderDate, ClassifyID, OrderType, ObjectID, DeliveryAddress,
      						Notes, Disabled, OrderStatus, QuotationID,
      						CreateDate, CreateUserID, LastModifyUserID, LastModifyDate,
      						Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID, 
							Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID,       
							CurrencyID, ExchangeRate, InventoryTypeID, TranMonth, TranYear,
      						EmployeeID, Transport, PaymentID, ObjectName,
      						VatNo, Address, IsPeriod, IsPlan,
      						DepartmentID, ShipDate, InheritSOrderID, IsInherit, IsConfirm,	      					
      						PeriodID )
			SELECT	T1.DivisionID, @VoucherNo, T1.VoucherTypeID, @VoucherNo, T1.OrderDate, @ClassifyID, 1 AS OrderType, T1.ObjectID, T1.DeliveryAddress,
      				T1.Notes, T1.Disabled, Isnull(T2.OrderStatus,0), T1.QuotationID,
      				GETDATE() AS CreateDate, @UserID AS CreateUserID, @UserID AS LastModifyUserID, GETDATE() AS LastModifyDate,
      				T1.Ana01ID, T1.Ana02ID, T1.Ana03ID, T1.Ana04ID, T1.Ana05ID, 
					T1.Ana06ID, T1.Ana07ID, T1.Ana08ID, T1.Ana09ID, T1.Ana10ID,       
					T1.CurrencyID, T1.ExchangeRate, T1.InventoryTypeID, T1.TranMonth, T1.TranYear,
      				T1.EmployeeID, T1.Transport, T1.PaymentID, T1.ObjectName,
      				T1.VatNo, T1.Address, 0 AS IsPeriod, 0 AS IsPlan,
      				T1.DepartmentID, T1.ShipDate, SOrderID AS InheritSOrderID, 0 AS IsInherit, 0 AS IsConfirm, T1.PeriodID
			FROM	OT2001 T1 WITH (NOLOCK)
			LEFT JOIN OT0001 T2 WITH (NOLOCK) On T1.DivisionID = T2.DivisionID AND T2.TypeID = 'MO'
			WHERE	T1.DivisionID = @DivisionID AND T1.SOrderID = @SOrderID

			INSERT INTO OT2002(
      					DivisionID, TransactionID, SOrderID, InventoryID, MethodID, OrderQuantity, 
      					IsPicking, WareHouseID, DiscountOriginalAmount,LinkNo,
      					EndDate, Orders, Description, RefInfor, 
						Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID,      					
						Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID,
      					UnitID, Finish, Notes, Notes01, Notes02,
      					QuotationID, QuoTransactionID, ConvertedQuantity,      					      					
      					RefSOrderID, RefSTransactionID, 
						InheritTableID, InheritVoucherID, InheritTransactionID,
						[nvarchar01], [nvarchar02], [nvarchar03], [nvarchar04], [nvarchar05],
						[nvarchar06], [nvarchar07], [nvarchar08], [nvarchar09], [nvarchar10]      					
					) 
			SELECT
				DivisionID, NEWID(), @VoucherNo, InventoryID, MethodID, OrderQuantity, 
      			IsPicking, WareHouseID, DiscountOriginalAmount,LinkNo,
      			EndDate, Orders, Description, RefInfor, 
				Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID,      					
				Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID,
      			UnitID, Finish, Notes, Notes01, Notes02,
      			QuotationID, QuoTransactionID, ConvertedQuantity,      					      					
      			SOrderID AS RefSOrderID, TransactionID AS RefSTransactionID, 
				'OT2001' AS InheritTableID, SOrderID AS InheritVoucherID, TransactionID AS InheritTransactionID,				
				[nvarchar01], [nvarchar02], [nvarchar03], [nvarchar04], [nvarchar05],
				[nvarchar06], [nvarchar07], [nvarchar08], [nvarchar09], [nvarchar10]
					 
			FROM OT2002 WITH (NOLOCK)
			WHERE	DivisionID = @DivisionID AND SOrderID = @SOrderID

			INSERT INTO OT8899(
      					DivisionID, VoucherID, TransactionID, TableID, 
						[S01ID],
						[S02ID],
						[S03ID],
						[S04ID],
						[S05ID],
						[S06ID],
						[S07ID],
						[S08ID],
						[S09ID],
						[S10ID],
						[S11ID],
						[S12ID],
						[S13ID],
						[S14ID],
						[S15ID],
						[S16ID],
						[S17ID],
						[S18ID],
						[S19ID],
						[S20ID] ,
						[SUnitPrice01],
						[SUnitPrice02],
						[SUnitPrice03],
						[SUnitPrice04],
						[SUnitPrice05],
						[SUnitPrice06],
						[SUnitPrice07],
						[SUnitPrice08],
						[SUnitPrice09],
						[SUnitPrice10],
						[SUnitPrice11],
						[SUnitPrice12],
						[SUnitPrice13],
						[SUnitPrice14],
						[SUnitPrice15],
						[SUnitPrice16],
						[SUnitPrice17],
						[SUnitPrice18],
						[SUnitPrice19],
						[SUnitPrice20],
						UnitPriceStandard     					
					) 
			SELECT
				DHSX.DivisionID, DHSX.SOrderID, DHSX.TransactionID, DHB.TableID,
				DHB.[S01ID],
				DHB.[S02ID],
				DHB.[S03ID],
				DHB.[S04ID],
				DHB.[S05ID],
				DHB.[S06ID],
				DHB.[S07ID],
				DHB.[S08ID],
				DHB.[S09ID],
				DHB.[S10ID],
				DHB.[S11ID],
				DHB.[S12ID],
				DHB.[S13ID],
				DHB.[S14ID],
				DHB.[S15ID],
				DHB.[S16ID],
				DHB.[S17ID],
				DHB.[S18ID],
				DHB.[S19ID],
				DHB.[S20ID],
				DHB.[SUnitPrice01],
				DHB.[SUnitPrice02],
				DHB.[SUnitPrice03],
				DHB.[SUnitPrice04],
				DHB.[SUnitPrice05],
				DHB.[SUnitPrice06],
				DHB.[SUnitPrice07],
				DHB.[SUnitPrice08],
				DHB.[SUnitPrice09],
				DHB.[SUnitPrice10],
				DHB.[SUnitPrice11],
				DHB.[SUnitPrice12],
				DHB.[SUnitPrice13],
				DHB.[SUnitPrice14],
				DHB.[SUnitPrice15],
				DHB.[SUnitPrice16],
				DHB.[SUnitPrice17],
				DHB.[SUnitPrice18],
				DHB.[SUnitPrice19],
				DHB.[SUnitPrice20],
				DHB.UnitPriceStandard   
			FROM OT2002 DHSX WITH (NOLOCK)
			INNER JOIN OT8899 DHB WITH (NOLOCK) ON DHSX.DivisionID = DHB.DivisionID AND DHSX.InheritVoucherID = DHB.VoucherID AND DHSX.InheritTransactionID = DHB.TransactionID
			INNER JOIN OT2001 WITH (NOLOCK) ON DHSX.DivisionID = OT2001.DivisionID AND DHSX.SOrderID = OT2001.SOrderID
			WHERE	DHSX.DivisionID = @DivisionID AND DHB.VoucherID = @SOrderID AND OT2001.OrderType = 1

		END
			
	END

--OFML000199 : Số lượng tồn kho sẵn sàng của mặt hàng [{0}] trong đơn hàng số [{1}] không đủ. /n Bạn không thể duyệt cho đơn hàng này !.
IF @Status = 2
	SET @MessageID =  'OFML000199' 
IF @Status = 1
	SET @MessageID =  'OFML000200'
IF @Status = 3	--- Mạnh Phương
BEGIN
	IF @Status1 = 1	--- thông báo đã kế thừa qua AsoftT thì không cho bỏ duyệt
		SET @MessageID =  'OFML000261'

	IF @Status1 = 2	--- thông báo đã khóa sổ ở T và WM thì không cho duyệt/bỏ duyệt
		SET @MessageID =  'OFML000282'
END

IF @Status=4 -- Kim Hoàn Vũ
	SET @MessageID =  'OFML000287'
		
SELECT @Status AS Status, @MessageID AS MessageID, @InventoryIDAllow AS InventoryID, (Select VoucherNo From OT2001 WITH (NOLOCK) Where DivisionID = @DivisionID And SOrderID =@SOrderID) AS SOrderID

ENDMESS:
	SELECT @Status AS Status, @MessageID AS MessageID, @InventoryIDAllow AS InventoryID, (Select VoucherNo From OT2001 WITH (NOLOCK) Where DivisionID = @DivisionID And SOrderID =@SOrderID) AS SOrderID;


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
