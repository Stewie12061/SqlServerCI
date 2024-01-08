IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP7001]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP7001]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
---- Created by Nguyen Van Nhan, Date 13/06/2003
---- Purpose:  Kiem tra co duoc phep xuat kho hay khong.
---- Duoc goi khi AddNew va Edit phieu xuat kho
---- Edit by B.Anh, date 01/06/2010	Sua loi canh bao sai khi dung DVT quy doi (truoc day lay @NewQuantity * @ConversionFactor so sanh voi @EndQuantity_ToNow)
---- Edit by B.Anh, date 11/06/2014	Chỉ lấy lượng tồn tính đến ngày @VoucherDate
---- Modified by Tiểu Mai on 22/02/2016: Bổ sung kiểm tra hàng theo quy cách
---- Modified by Tiểu Mai on 03/06/2016: Bổ sung WITH (NOLOCK)
---- Edit by B.Anh, date 07/03/2017	Lấy lượng tồn tính đến thời điểm hiện tại chứ không lấy đến ngày @VoucherDate
---- Edit by B.Anh, date 07/04/2017	Kiểm tra tồn 2 trường hợp: tính đến hiện tại và tính đến ngày xuất kho
---- Edit by B.Anh, date 19/04/2017	Kiểm tra tồn kho theo vị trí (Chí Thành)
---- Modified by Bảo Thy on 25/07/2017: Bổ sung @ScreenID
---- Edit by B.Anh, date 03/01/2018	Kiểm tra tồn kho an toàn
---- Modified by Kim Thư on 17/9/2018: Đưa tất cả mặt hàng cần kiểm tra vào biến XML (cải thiện tốc độ check tồn kho)
---- Modified by Kim Thư on 23/10/2018: Điều chỉnh insert bảng WT8003 check xuất đích danh
---- Modified by Kim Thư on 25/10/2018: Thay đổi load view AV7000 cải thiện tốc độ
---- Modified by Kim Thư on 20/11/2018: Sửa lỗi  COLLATE SQL_Latin1_General_CP1_CI_AS
---- Modified by Kim Thư on 07/12/2018: Bổ sung ưu tiên báo lỗi tính đến thời điểm hiện tại trước, nếu hiện tại đủ số lượng thì thông báo đến thời điểm voucherdate.
----									Bổ sung cột IsNegativeStock vào bảng báo lỗi -> phân biệt loại message
---- Modified by Kim Thư on 15/03/2019: sửa isnull tính tồn kho
---- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.

/********************************************
'* Edited by: [GS] [Thanh Nguyen] [01/08/2010]
'********************************************/
CREATE PROCEDURE [dbo].[AP7001] 	
	@DivisionID AS VARCHAR(50),
	@UserID AS VARCHAR(50),
	@TranMonth AS INT,
	@TranYear AS INT,
	@WareHouseID AS VARCHAR(50),
	@VoucherDate AS DATETIME,
	@ScreenID AS VARCHAR(50) = '',
	@XML XML
	
 AS

Declare @Message as nvarchar(250),
		@Status as tinyint,
		@IsNegativeStock as tinyint,
		@CustomerName INT

--Tao bang tam kiem tra khach hang customize
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

Select  @IsNegativeStock = IsNegativeStock From WT0000 WITH (NOLOCK)  Where DefDivisionID =@DivisionID  --- Cho phep xuat kho am hay khong

Set @IsNegativeStock = isnull(@IsNegativeStock,0)

Set Nocount on
Delete AT7777 Where UserID =@UserID AND DivisionID = @DivisionID
Delete AT7778 Where UserID =@UserID AND DivisionID = @DivisionID

IF @XML IS NOT NULL
BEGIN
	CREATE TABLE #AP7001 (InventoryID VARCHAR(50) COLLATE DATABASE_DEFAULT NULL, UnitID VARCHAR(5) COLLATE DATABASE_DEFAULT NULL, 
	ConversionFactor DECIMAL(28,8), IsSource TINYINT, IsLimitDate TINYINT, 
	CreditAccountID VARCHAR(10) COLLATE DATABASE_DEFAULT NULL, ReOldVoucherID NVARCHAR(50) COLLATE DATABASE_DEFAULT NULL, 
	ReOldTransactionID NVARCHAR(50) COLLATE DATABASE_DEFAULT NULL, ReNewVoucherID NVARCHAR(50) COLLATE DATABASE_DEFAULT NULL, 
	ReNewTransactionID NVARCHAR(50) COLLATE DATABASE_DEFAULT NULL,
	OldQuantity DECIMAL(28,8), NewQuantity DECIMAL(28,8), AllowOverShip TINYINT, MethodID TINYINT,
	S01ID NVARCHAR(50) COLLATE DATABASE_DEFAULT NULL, S02ID NVARCHAR(50) COLLATE DATABASE_DEFAULT NULL, 
	S03ID NVARCHAR(50) COLLATE DATABASE_DEFAULT NULL, S04ID NVARCHAR(50) COLLATE DATABASE_DEFAULT NULL, 
	S05ID NVARCHAR(50) COLLATE DATABASE_DEFAULT NULL, S06ID NVARCHAR(50) COLLATE DATABASE_DEFAULT NULL, 
	S07ID NVARCHAR(50) COLLATE DATABASE_DEFAULT NULL, S08ID NVARCHAR(50) COLLATE DATABASE_DEFAULT NULL, 
	S09ID NVARCHAR(50) COLLATE DATABASE_DEFAULT NULL, S10ID NVARCHAR(50) COLLATE DATABASE_DEFAULT NULL, 
	S11ID NVARCHAR(50) COLLATE DATABASE_DEFAULT NULL, S12ID NVARCHAR(50) COLLATE DATABASE_DEFAULT NULL, 
	S13ID NVARCHAR(50) COLLATE DATABASE_DEFAULT NULL, S14ID NVARCHAR(50) COLLATE DATABASE_DEFAULT NULL, 
	S15ID NVARCHAR(50) COLLATE DATABASE_DEFAULT NULL, S16ID NVARCHAR(50) COLLATE DATABASE_DEFAULT NULL, 
	S17ID NVARCHAR(50) COLLATE DATABASE_DEFAULT NULL, S18ID NVARCHAR(50) COLLATE DATABASE_DEFAULT NULL, 
	S19ID NVARCHAR(50) COLLATE DATABASE_DEFAULT NULL, S20ID NVARCHAR(50) COLLATE DATABASE_DEFAULT NULL, 
	Ana01ID NVARCHAR(50) COLLATE DATABASE_DEFAULT NULL, EndQuantity_ToNow DECIMAL(28,8), EndQuantity_ToVoucherDate DECIMAL(28,8), ReOrderQuantity DECIMAL(28,8),
	Status TINYINT, Message VARCHAR(50), Params VARCHAR(MAX))
	
	SELECT X.Data.query('InventoryID').value('.', 'VARCHAR(50)') AS InventoryID,
		   X.Data.query('UnitID').value('.', 'VARCHAR(5)') AS UnitID,
		   X.Data.query('ConversionFactor').value('.','DECIMAL(28,8)') AS ConversionFactor,
		   X.Data.query('IsSource').value('.','TINYINT') AS IsSource,
		   X.Data.query('IsLimitDate').value('.','TINYINT') AS IsLimitDate,
		   X.Data.query('CreditAccountID').value('.', 'VARCHAR(10)') AS CreditAccountID,
		   X.Data.query('ReOldVoucherID').value('.', 'NVARCHAR(50)') AS ReOldVoucherID,
		   X.Data.query('ReOldTransactionID').value('.', 'NVARCHAR(50)') AS ReOldTransactionID,
		   X.Data.query('ReNewVoucherID').value('.', 'NVARCHAR(50)') AS ReNewVoucherID,
		   X.Data.query('ReNewTransactionID').value('.', 'NVARCHAR(50)') AS ReNewTransactionID,
		   (CASE WHEN X.Data.query('OldQuantity').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('OldQuantity').value('.', 'DECIMAL(28,8)') END) AS OldQuantity,
		   (CASE WHEN X.Data.query('NewQuantity').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('NewQuantity').value('.', 'DECIMAL(28,8)') END) AS NewQuantity,
		   X.Data.query('AllowOverShip').value('.','TINYINT') AS AllowOverShip,
		   X.Data.query('MethodID').value('.','TINYINT') AS MethodID,
		   X.Data.query('S01ID').value('.', 'NVARCHAR(50)') AS S01ID,
		   X.Data.query('S02ID').value('.', 'NVARCHAR(50)') AS S02ID,
		   X.Data.query('S03ID').value('.', 'NVARCHAR(50)') AS S03ID,
		   X.Data.query('S04ID').value('.', 'NVARCHAR(50)') AS S04ID,
		   X.Data.query('S05ID').value('.', 'NVARCHAR(50)') AS S05ID,
		   X.Data.query('S06ID').value('.', 'NVARCHAR(50)') AS S06ID,
		   X.Data.query('S07ID').value('.', 'NVARCHAR(50)') AS S07ID,
		   X.Data.query('S08ID').value('.', 'NVARCHAR(50)') AS S08ID,
		   X.Data.query('S09ID').value('.', 'NVARCHAR(50)') AS S09ID,
		   X.Data.query('S10ID').value('.', 'NVARCHAR(50)') AS S10ID,
		   X.Data.query('S11ID').value('.', 'NVARCHAR(50)') AS S11ID,
		   X.Data.query('S12ID').value('.', 'NVARCHAR(50)') AS S12ID,
		   X.Data.query('S13ID').value('.', 'NVARCHAR(50)') AS S13ID,
		   X.Data.query('S14ID').value('.', 'NVARCHAR(50)') AS S14ID,
		   X.Data.query('S15ID').value('.', 'NVARCHAR(50)') AS S15ID,
		   X.Data.query('S16ID').value('.', 'NVARCHAR(50)') AS S16ID,
		   X.Data.query('S17ID').value('.', 'NVARCHAR(50)') AS S17ID,
		   X.Data.query('S18ID').value('.', 'NVARCHAR(50)') AS S18ID,
		   X.Data.query('S19ID').value('.', 'NVARCHAR(50)') AS S19ID,
		   X.Data.query('S20ID').value('.', 'NVARCHAR(50)') AS S20ID,
		   X.Data.query('Ana01ID').value('.', 'NVARCHAR(50)') AS Ana01ID
	INTO #TEMP
	FROM @XML.nodes('//Data') AS X (Data)
	
	INSERT INTO #AP7001 (InventoryID, UnitID, ConversionFactor, IsSource, IsLimitDate, CreditAccountID, ReOldVoucherID, ReOldTransactionID, ReNewVoucherID, ReNewTransactionID,
	OldQuantity, NewQuantity, AllowOverShip, MethodID, S01ID, S02ID, S03ID, S04ID,  S05ID, S06ID, S07ID, S08ID, S09ID, S10ID, S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID,
	S18ID, S19ID, S20ID, Ana01ID)
	SELECT DISTINCT InventoryID, UnitID, ConversionFactor, IsSource, IsLimitDate, CreditAccountID, ReOldVoucherID, ReOldTransactionID, ReNewVoucherID, ReNewTransactionID,
	SUM(OldQuantity) as OldQuantity, SUM(NewQuantity) as NewQuantity, 
	AllowOverShip, MethodID, S01ID, S02ID, S03ID, S04ID,  S05ID, S06ID, S07ID, S08ID, S09ID, S10ID, S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID,
	S18ID, S19ID, S20ID, Ana01ID
	FROM #TEMP
	GROUP BY InventoryID, UnitID, ConversionFactor, IsSource, IsLimitDate, CreditAccountID, ReOldVoucherID, ReOldTransactionID, ReNewVoucherID, ReNewTransactionID,
	AllowOverShip, MethodID, S01ID, S02ID, S03ID, S04ID,  S05ID, S06ID, S07ID, S08ID, S09ID, S10ID, S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID,
	S18ID, S19ID, S20ID, Ana01ID

	--Bảng tạm chứa dữ liệu check tồn kho xuất đích danh theo lô
	Delete WT8003 Where UserID = @UserID AND DivisionID = @DivisionID

	---Lấy dữ liệu Xuat dich danh, theo Lo - ngay het han
	INSERT INTO WT8003 (DivisionID, UserID, InventoryID, UnitID, ConversionFactor, ReOldVoucherID, ReOldTransactionID, ReNewVoucherID, ReNewTransactionID, OldQuantity, NewQuantity)
	SELECT @DivisionID, @UserID, InventoryID, UnitID, ConversionFactor, ReOldVoucherID, ReOldTransactionID, ReNewVoucherID, ReNewTransactionID, 
	SUM(OldQuantity), SUM(NewQuantity)
	FROM #AP7001
	WHERE IsSource<>0 or IsLimitDate<>0 or MethodID = 3
	GROUP BY InventoryID, UnitID, ConversionFactor, ReOldVoucherID, ReOldTransactionID, ReNewVoucherID, ReNewTransactionID

		--BẢNG TẠM THAY VIEW AV7000
	SELECT * INTO #AV7000
	FROM (
		SELECT D17.DivisionID, D17.InventoryID, D17.DebitAccountID as InventoryAccountID, D16.WarehouseID, D16.VoucherDate, D17.ActualQuantity as SignQuantity,
		ISNULL(W89.S01ID,'') AS S01ID, ISNULL(W89.S02ID,'') AS S02ID, ISNULL(W89.S03ID,'') AS S03ID, ISNULL(W89.S04ID,'') AS S04ID, ISNULL(W89.S05ID,'') AS S05ID, 
		ISNULL(W89.S06ID,'') AS S06ID, ISNULL(W89.S07ID,'') AS S07ID, ISNULL(W89.S08ID,'') AS S08ID, ISNULL(W89.S09ID,'') AS S09ID, ISNULL(W89.S10ID,'') AS S10ID,
		ISNULL(W89.S11ID,'') AS S11ID, ISNULL(W89.S12ID,'') AS S12ID, ISNULL(W89.S13ID,'') AS S13ID, ISNULL(W89.S14ID,'') AS S14ID, ISNULL(W89.S15ID,'') AS S15ID, 
		ISNULL(W89.S16ID,'') AS S16ID, ISNULL(W89.S17ID,'') AS S17ID, ISNULL(W89.S18ID,'') AS S18ID, ISNULL(W89.S19ID,'') AS S19ID, ISNULL(W89.S20ID,'') AS S20ID
		From AT2017 AS D17 WITH (NOLOCK) 
		INNER JOIN AT2016 AS D16 WITH (NOLOCK) ON D16.VoucherID = D17.VoucherID AND D16.DivisionID = D17.DivisionID
		LEFT JOIN WT8899 W89 WITH (NOLOCK) ON W89.DivisionID = D17.DivisionID AND W89.TransactionID = D17.TransactionID AND  W89.VoucherID = D17.VoucherID
		Where isnull(D17.DebitAccountID,'') <>''
		UNION ALL
		SELECT D17.DivisionID, D17.InventoryID, D17.CreditAccountID as InventoryAccountID, D16.WarehouseID, D16.VoucherDate, -D17.ActualQuantity as SignQuantity,
		ISNULL(W89.S01ID,'') AS S01ID, ISNULL(W89.S02ID,'') AS S02ID, ISNULL(W89.S03ID,'') AS S03ID, ISNULL(W89.S04ID,'') AS S04ID, ISNULL(W89.S05ID,'') AS S05ID, 
		ISNULL(W89.S06ID,'') AS S06ID, ISNULL(W89.S07ID,'') AS S07ID, ISNULL(W89.S08ID,'') AS S08ID, ISNULL(W89.S09ID,'') AS S09ID, ISNULL(W89.S10ID,'') AS S10ID,
		ISNULL(W89.S11ID,'') AS S11ID, ISNULL(W89.S12ID,'') AS S12ID, ISNULL(W89.S13ID,'') AS S13ID, ISNULL(W89.S14ID,'') AS S14ID, ISNULL(W89.S15ID,'') AS S15ID, 
		ISNULL(W89.S16ID,'') AS S16ID, ISNULL(W89.S17ID,'') AS S17ID, ISNULL(W89.S18ID,'') AS S18ID, ISNULL(W89.S19ID,'') AS S19ID, ISNULL(W89.S20ID,'') AS S20ID
		From AT2017 AS D17 WITH (NOLOCK) 
		INNER JOIN AT2016 AS D16 WITH (NOLOCK) ON D16.VoucherID = D17.VoucherID AND D16.DivisionID = D17.DivisionID
		LEFT JOIN WT8899 W89 WITH (NOLOCK) ON W89.DivisionID = D17.DivisionID AND W89.TransactionID = D17.TransactionID AND  W89.VoucherID = D17.VoucherID
		Where isnull(D17.CreditAccountID,'') <>''
		UNION ALL
		SELECT D07.DivisionID, D07.InventoryID, D07.DebitAccountID as InventoryAccountID, D06.WarehouseID, D06.VoucherDate, D07.ActualQuantity as SignQuantity,
		ISNULL(W89.S01ID,'') AS S01ID, ISNULL(W89.S02ID,'') AS S02ID, ISNULL(W89.S03ID,'') AS S03ID, ISNULL(W89.S04ID,'') AS S04ID, ISNULL(W89.S05ID,'') AS S05ID, 
		ISNULL(W89.S06ID,'') AS S06ID, ISNULL(W89.S07ID,'') AS S07ID, ISNULL(W89.S08ID,'') AS S08ID, ISNULL(W89.S09ID,'') AS S09ID, ISNULL(W89.S10ID,'') AS S10ID,
		ISNULL(W89.S11ID,'') AS S11ID, ISNULL(W89.S12ID,'') AS S12ID, ISNULL(W89.S13ID,'') AS S13ID, ISNULL(W89.S14ID,'') AS S14ID, ISNULL(W89.S15ID,'') AS S15ID, 
		ISNULL(W89.S16ID,'') AS S16ID, ISNULL(W89.S17ID,'') AS S17ID, ISNULL(W89.S18ID,'') AS S18ID, ISNULL(W89.S19ID,'') AS S19ID, ISNULL(W89.S20ID,'') AS S20ID
		From AT2007 AS D07 WITH (NOLOCK) 
		INNER JOIN AT2006 AS D06 WITH (NOLOCK) ON D06.VoucherID = D07.VoucherID AND D06.DivisionID = D07.DivisionID
		LEFT JOIN WT8899 W89 WITH (NOLOCK) ON W89.DivisionID = D07.DivisionID AND W89.TransactionID = D07.TransactionID AND  W89.VoucherID = D07.VoucherID
		WHERE D06.KindVoucherID in (1,3,5,7,9,15,17) AND Isnull(D06.TableID,'') <> 'AT0114' ------- Phiếu nhập bù của ANGEL
		UNION ALL
		SELECT D07.DivisionID, D07.InventoryID, D07.CreditAccountID as InventoryAccountID, CASE WHEN D06.KindVoucherID = 3 then D06.WareHouseID2 Else  D06.WareHouseID End AS WareHouseID, 
		D06.VoucherDate, -D07.ActualQuantity as SignQuantity,
		ISNULL(W89.S01ID,'') AS S01ID, ISNULL(W89.S02ID,'') AS S02ID, ISNULL(W89.S03ID,'') AS S03ID, ISNULL(W89.S04ID,'') AS S04ID, ISNULL(W89.S05ID,'') AS S05ID, 
		ISNULL(W89.S06ID,'') AS S06ID, ISNULL(W89.S07ID,'') AS S07ID, ISNULL(W89.S08ID,'') AS S08ID, ISNULL(W89.S09ID,'') AS S09ID, ISNULL(W89.S10ID,'') AS S10ID,
		ISNULL(W89.S11ID,'') AS S11ID, ISNULL(W89.S12ID,'') AS S12ID, ISNULL(W89.S13ID,'') AS S13ID, ISNULL(W89.S14ID,'') AS S14ID, ISNULL(W89.S15ID,'') AS S15ID, 
		ISNULL(W89.S16ID,'') AS S16ID, ISNULL(W89.S17ID,'') AS S17ID, ISNULL(W89.S18ID,'') AS S18ID, ISNULL(W89.S19ID,'') AS S19ID, ISNULL(W89.S20ID,'') AS S20ID
		From AT2007 AS D07 WITH (NOLOCK) 
		INNER JOIN AT2006 AS D06 WITH (NOLOCK) ON D06.VoucherID = D07.VoucherID AND D06.DivisionID = D07.DivisionID
		LEFT JOIN WT8899 W89 WITH (NOLOCK) ON W89.DivisionID = D07.DivisionID AND W89.TransactionID = D07.TransactionID AND  W89.VoucherID = D07.VoucherID
		Where D06.KindVoucherID in (2,3,4,6,8,10,14,20) 
	)TEMP
	WHERE TEMP.DivisionID=@DivisionID
	AND WareHouseID = @WarehouseID


	IF EXISTS (SELECT TOP 1 * FROM WT8003 WHERE UserID = @UserID AND DivisionID = @DivisionID)
		--Xuat dich danh, theo Lo - ngay het han
		EXEC AP8003 @UserID, @DivisionID, @TranMonth, @TranYear, @WareHouseID, @ScreenID
	ELSE
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1) -- Quy cách
		BEGIN
			UPDATE T1
			SET T1.EndQuantity_ToVoucherDate =Isnull(T1.OldQuantity,0) + ISNULL((Select SUM(Isnull(SignQuantity,0)) From #AV7000											
											Where InventoryID =T1.InventoryID 
											AND InventoryAccountID = T1.CreditAccountID
											AND VoucherDate <= @VoucherDate
											AND ISNULL(S01ID,'') = ISNULL(T1.S01ID,'')
											AND ISNULL(S02ID,'') = ISNULL(T1.S02ID,'')
											AND ISNULL(S03ID,'') = ISNULL(T1.S03ID,'')
											AND ISNULL(S04ID,'') = ISNULL(T1.S04ID,'')
											AND ISNULL(S05ID,'') = ISNULL(T1.S05ID,'')
											AND ISNULL(S06ID,'') = ISNULL(T1.S06ID,'')
											AND ISNULL(S07ID,'') = ISNULL(T1.S07ID,'')
											AND ISNULL(S08ID,'') = ISNULL(T1.S08ID,'')
											AND ISNULL(S09ID,'') = ISNULL(T1.S09ID,'')
											AND ISNULL(S10ID,'') = ISNULL(T1.S10ID,'')
											AND ISNULL(S11ID,'') = ISNULL(T1.S11ID,'')
											AND ISNULL(S12ID,'') = ISNULL(T1.S12ID,'')
											AND ISNULL(S13ID,'') = ISNULL(T1.S13ID,'')
											AND ISNULL(S14ID,'') = ISNULL(T1.S14ID,'')
											AND ISNULL(S15ID,'') = ISNULL(T1.S15ID,'')
											AND ISNULL(S16ID,'') = ISNULL(T1.S16ID,'')
											AND ISNULL(S17ID,'') = ISNULL(T1.S17ID,'')
											AND ISNULL(S18ID,'') = ISNULL(T1.S18ID,'')
											AND ISNULL(S19ID,'') = ISNULL(T1.S19ID,'')
											AND ISNULL(S20ID,'') = ISNULL(T1.S20ID,'')),0),

			T1.EndQuantity_ToNow =Isnull(T1.OldQuantity,0) +  ISNULL((Select top 1 Isnull(EndQuantity,0) From AT2008_QC WITH (NOLOCK) Where DivisionID =@DivisionID and										
													InventoryID =T1.InventoryID and 
													InventoryAccountID = T1.CreditAccountID and
													WareHouseID =@WareHouseID
													AND ISNULL(S01ID,'') = ISNULL(T1.S01ID,'')
													AND ISNULL(S02ID,'') = ISNULL(T1.S02ID,'')
													AND ISNULL(S03ID,'') = ISNULL(T1.S03ID,'')
													AND ISNULL(S04ID,'') = ISNULL(T1.S04ID,'')
													AND ISNULL(S05ID,'') = ISNULL(T1.S05ID,'')
													AND ISNULL(S06ID,'') = ISNULL(T1.S06ID,'')
													AND ISNULL(S07ID,'') = ISNULL(T1.S07ID,'')
													AND ISNULL(S08ID,'') = ISNULL(T1.S08ID,'')
													AND ISNULL(S09ID,'') = ISNULL(T1.S09ID,'')
													AND ISNULL(S10ID,'') = ISNULL(T1.S10ID,'')
													AND ISNULL(S11ID,'') = ISNULL(T1.S11ID,'')
													AND ISNULL(S12ID,'') = ISNULL(T1.S12ID,'')
													AND ISNULL(S13ID,'') = ISNULL(T1.S13ID,'')
													AND ISNULL(S14ID,'') = ISNULL(T1.S14ID,'')
													AND ISNULL(S15ID,'') = ISNULL(T1.S15ID,'')
													AND ISNULL(S16ID,'') = ISNULL(T1.S16ID,'')
													AND ISNULL(S17ID,'') = ISNULL(T1.S17ID,'')
													AND ISNULL(S18ID,'') = ISNULL(T1.S18ID,'')
													AND ISNULL(S19ID,'') = ISNULL(T1.S19ID,'')
													AND ISNULL(S20ID,'') = ISNULL(T1.S20ID,'')
													Order by TranMonth + TranYear*12 DESC),0),

			T1.ReOrderQuantity = ISNULL((Select Isnull(ReOrderQuantity,0) From AT1314 WITH (NOLOCK) Where DivisionID = @DivisionID And InventoryID = T1.InventoryID And (case when WareHouseID = '%' then @WareHouseID else WareHouseID end) = @WareHouseID
									AND ISNULL(S01ID,'') = ISNULL(T1.S01ID,'')
									AND ISNULL(S02ID,'') = ISNULL(T1.S02ID,'')
									AND ISNULL(S03ID,'') = ISNULL(T1.S03ID,'')
									AND ISNULL(S04ID,'') = ISNULL(T1.S04ID,'')
									AND ISNULL(S05ID,'') = ISNULL(T1.S05ID,'')
									AND ISNULL(S06ID,'') = ISNULL(T1.S06ID,'')
									AND ISNULL(S07ID,'') = ISNULL(T1.S07ID,'')
									AND ISNULL(S08ID,'') = ISNULL(T1.S08ID,'')
									AND ISNULL(S09ID,'') = ISNULL(T1.S09ID,'')
									AND ISNULL(S10ID,'') = ISNULL(T1.S10ID,'')
									AND ISNULL(S11ID,'') = ISNULL(T1.S11ID,'')
									AND ISNULL(S12ID,'') = ISNULL(T1.S12ID,'')
									AND ISNULL(S13ID,'') = ISNULL(T1.S13ID,'')
									AND ISNULL(S14ID,'') = ISNULL(T1.S14ID,'')
									AND ISNULL(S15ID,'') = ISNULL(T1.S15ID,'')
									AND ISNULL(S16ID,'') = ISNULL(T1.S16ID,'')
									AND ISNULL(S17ID,'') = ISNULL(T1.S17ID,'')
									AND ISNULL(S18ID,'') = ISNULL(T1.S18ID,'')
									AND ISNULL(S19ID,'') = ISNULL(T1.S19ID,'')
									AND ISNULL(S20ID,'') = ISNULL(T1.S20ID,'')
								),0)
			FROM #AP7001 T1

		END
		ELSE
		BEGIN
			If @CustomerName = 76 --- Chí Thành
			Begin
				UPDATE T1
				Set T1.EndQuantity_ToVoucherDate =Isnull(OldQuantity,0) + ISNULL((Select SUM(Isnull(SignQuantity,0)) From #AV7000										
											Where InventoryID =T1.InventoryID 
											and InventoryAccountID = T1.CreditAccountID
											and Isnull(Ana01ID,'') = T1.Ana01ID
											and VoucherDate <= @VoucherDate),0),
				T1.EndQuantity_ToNow =Isnull(T1.OldQuantity,0) + ISNULL((Select SUM(Isnull(SignQuantity,0)) From #AV7000  									
											Where InventoryID =T1.InventoryID 
											and InventoryAccountID = T1.CreditAccountID
											and Isnull(Ana01ID,'') = T1.Ana01ID),0),
				T1.ReOrderQuantity = ISNULL((Select Isnull(ReOrderQuantity,0) From AT1314 WITH (NOLOCK) Where DivisionID = @DivisionID And InventoryID = T1.InventoryID And (case when WareHouseID = '%' then @WareHouseID else WareHouseID end) = @WareHouseID),0)
				FROM #AP7001 T1
			End
			Else
			Begin
				UPDATE T1
				Set T1.EndQuantity_ToVoucherDate =Isnull(T1.OldQuantity,0) + ISNULL((Select SUM(Isnull(SignQuantity,0)) From #AV7000										
											Where InventoryID =T1.InventoryID 
											and InventoryAccountID = T1.CreditAccountID
											and VoucherDate <= @VoucherDate),0),
				T1.EndQuantity_ToNow =Isnull(T1.OldQuantity,0) +  ISNULL((Select top 1 Isnull(EndQuantity,0) From AT2008 WITH (NOLOCK) Where DivisionID =@DivisionID and										
														InventoryID =T1.InventoryID and 
														InventoryAccountID = T1.CreditAccountID and
														WareHouseID =@WareHouseID
														Order by TranMonth + TranYear*12 DESC),0),
				T1.ReOrderQuantity = ISNULL((Select Isnull(ReOrderQuantity,0) From AT1314 WITH (NOLOCK) Where DivisionID = @DivisionID And TranMonth = @TranMonth And TranYear = @TranYear And InventoryID = T1.InventoryID And (case when WareHouseID = '%' then @WareHouseID else WareHouseID end) = @WareHouseID),0)
				FROM #AP7001 T1
			End
		END

		UPDATE #AP7001
		SET Status =1,
			Message =N'WFML000132'
		WHERE NewQuantity > EndQuantity_ToNow and @IsNegativeStock=0
		
		Insert AT7777 (UserID, Status, Message, DivisionID, Value1, Value2, IsNegativeStock)
		SELECT @UserID, Status, Message, @DivisionID, InventoryID, @WareHouseID, @IsNegativeStock FROM #AP7001
		WHERE Status =1 AND Message =N'WFML000132'
		----------------------
		UPDATE #AP7001
		SET Status =2,
			Message =N'WFML000133'
		WHERE NewQuantity > EndQuantity_ToNow and  @IsNegativeStock=1

		Insert AT7777 (UserID, Status, Message, DivisionID, Value1, Value2, IsNegativeStock)
		SELECT @UserID, Status, Message, @DivisionID, InventoryID, @WareHouseID, @IsNegativeStock FROM #AP7001
		WHERE Status =2 AND Message =N'WFML000133'
		----------------------
		UPDATE #AP7001
		SET Status =1,
			Message =N'WFML000230'
		WHERE NewQuantity > EndQuantity_ToVoucherDate and  @IsNegativeStock=0 and ISNULL(Message,'') = ''

		Insert AT7777 (UserID, Status, Message, DivisionID, Value1, Value2, Value3, IsNegativeStock)
		SELECT @UserID, Status, Message, @DivisionID, convert(varchar(20),@VoucherDate,103), InventoryID, @WareHouseID, @IsNegativeStock FROM #AP7001
		WHERE Status =1 AND Message =N'WFML000230'
		---------------------
		UPDATE #AP7001
		SET Status =2,
			Message =N'WFML000231'
		WHERE NewQuantity > EndQuantity_ToVoucherDate and  @IsNegativeStock=1 and ISNULL(Message,'') = ''
		
		Insert AT7777 (UserID, Status, Message, DivisionID, Value1, Value2, Value3, IsNegativeStock)
		SELECT @UserID, Status, Message, @DivisionID, convert(varchar(20),@VoucherDate,103), InventoryID, @WareHouseID, @IsNegativeStock FROM #AP7001
		WHERE Status =2 AND Message =N'WFML000231'
		---------------------
		UPDATE #AP7001
		SET Status =0,
			Message =''
		WHERE Status=NULL

		Insert AT7777 (UserID, Status, Message, DivisionID, IsNegativeStock)
		SELECT @UserID, Status, Message, @DivisionID, @IsNegativeStock FROM #AP7001
		WHERE Status =0 AND Message =''
		------------------------
		------- Kiem tra ton kho an toan
		UPDATE T1
		Set Status = 1, Message =N'WFML000244'
		FROM #AP7001 T1 LEFT JOIN AT1302 T2 ON T2.DivisionID IN (@DivisionID,'@@@') And T2.InventoryID = T1.InventoryID
		WHERE T1.EndQuantity_ToNow - T1.NewQuantity <= T1.ReOrderQuantity
		AND EXISTS (SELECT 1 FROM AT0011 WITH (NOLOCK) LEFT JOIN AT1402 WITH (NOLOCK) ON AT1402.DivisionID = AT0011.DivisionID AND AT1402.GroupID = AT0011.GroupID 
				WHERE AT0011.DivisionID = @DivisionID AND AT1402.UserID = @UserID AND WarningID = 3)
		AND ISNULL(T2.IsMinQuantity,0) = 1

		INSERT INTO AT7778 (UserID, [Status], [Message], DivisionID, Value1, Value2, IsNegativeStock)
		Select @UserID as UserID, Status, Message, @DivisionID as DivisionID, InventoryID as Value1, @WareHouseID as Value2, @IsNegativeStock FROM #AP7001
		WHERE Status = 1 AND Message =N'WFML000244'
		-------------------------------------------------------
		UPDATE T1
		Set Status = 1, Message =N'WFML000243'
		FROM #AP7001 T1 LEFT JOIN AT1302 T2 ON T2.DivisionID IN (@DivisionID,'@@@') And T2.InventoryID = T1.InventoryID
		WHERE T1.EndQuantity_ToVoucherDate - T1.NewQuantity <= T1.ReOrderQuantity
		AND EXISTS (SELECT 1 FROM AT0011 WITH (NOLOCK) LEFT JOIN AT1402 WITH (NOLOCK) ON AT1402.DivisionID = AT0011.DivisionID AND AT1402.GroupID = AT0011.GroupID 
				WHERE AT0011.DivisionID = @DivisionID AND AT1402.UserID = @UserID AND WarningID = 3)
		AND ISNULL(T2.IsMinQuantity,0) = 1 AND ISNULL(Message,'') = ''
		
		INSERT INTO AT7778 (UserID, [Status], [Message], DivisionID, Value1, Value2, Value3, IsNegativeStock)
		Select @UserID as UserID, Status, Message, @DivisionID as DivisionID, InventoryID as Value1, @WareHouseID as Value2, convert(varchar(20),@VoucherDate,103) as Value3, @IsNegativeStock FROM #AP7001
		WHERE Status = 1 AND Message =N'WFML000243'
		---------------------------------------------------------

		UPDATE T1
		Set Status = 0, Message =N''
		FROM #AP7001 T1
		WHERE Message NOT IN (N'WFML000244',N'WFML000243')

		INSERT INTO AT7778 (UserID, [Status], [Message], DivisionID)
		Select @UserID as UserID, Status, Message, @DivisionID as DivisionID FROM #AP7001
		WHERE Status = 0 AND Message =N''
		
		Set Nocount off
		Select * from AT7777 WITH (NOLOCK) Where UserID = @UserID and DivisionID = @DivisionID
		Select * from AT7778 WITH (NOLOCK) Where UserID = @UserID and DivisionID = @DivisionID
	END
END



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO