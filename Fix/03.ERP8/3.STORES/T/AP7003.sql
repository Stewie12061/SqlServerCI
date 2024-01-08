IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP7003]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP7003]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
---- Created by Trần Kim Thư, Date 28/09/2018
---- Purpose:  Kiểm tra xuất kho âm khi xóa / sửa các phiếu nhập kho
--				Phiếu nhập kho (truyền VoucherID của phiếu nhập)
--				Phiếu chuyển kho (truyền VoucherID của phiếu chuyển)
--				Phiếu nhập kho thành phẩm (truyền VoucherID của kết quản sx thành phẩm)
--				Phiếu nhập kho hàng mua (truyền VoucherID của phiếu mua hàng)
--				Phiếu nhập kho hàng bán trả lại (truyền VoucherID của phiếu bán hàng trả lại)
---- Modified by Kim Thư on 16/10/2018: Bổ sung phần kiểm tra tồn kho / xuất kho âm cho mặt hàng trong hóa đơn bán hàng trước khi sinh phiếu xuất kho tự động
---- Modified by Kim Thư on 25/10/2018: Điều chỉnh tính EndQuantity khi edit phiếu
---- Modified by Kim Thư on 09/11/2018: Bổ sung store kiểm tra các chức năng trên đối với mặt hàng có quy cách
---- Modified by Kim Thư on 14/01/2019: Bổ sung show lỗi đối với hóa đơn bán hàng có sinh phiếu xuất
---- Modified by Kim Thư on 25/02/2019: Bổ sung xuất IsNegativeStock ra kết quả check
---- Modified by Kim Thư on 28/03/2019: Sửa lỗi  COLLATE SQL_Latin1_General_CP1_CI_AS
---- Modified by Kim Thư on 10/05/2019: Tính lại số lượng nhập bao gồm phiếu số dư đầu
---- Modified by Kim Thư on 27/05/2019: Cộng số lượng nếu có nhiều dòng cùng mặt hàng
---- Modified by Kim Thư on 13/06/2019: Bổ sung trường hợp xóa dòng trong phiếu nhập thì NewInventoryID của table #GET_DELETE_INFO có số lượng New=0
---- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.

-- EXAMPLE:
-- EXEC AP7003 @DivisionID, @UserID, @VoucherID, @ScreenID, @NewWarehouseID, @XML
-- EXEC AP7003 @DivisionID='KHV', @UserID='ASOFTADMIN', @VoucherID='ARbda595d1-f506-4fdc-b6df-4eb71460e4b9', @ScreenID='WF0008', @NewWarehouseID='KDL', @XML=NULL
--EXEC AP7003 @DivisionID='KHV', @UserID='ASOFTADMIN', @VoucherID='AR71d6b905-d163-4a6f-b965-9369af139335', @NewWarehouseID='KDL', @ScreenID='WF0008', 
--@XML =
--'<Data><NewInventoryID>MH2</NewInventoryID><NewQuantity>3</NewQuantity>
--			<S01ID></S01ID><S02ID></S02ID><S03ID></S03ID><S04ID></S04ID><S05ID></S05ID>
--			<S06ID></S06ID><S07ID></S07ID><S08ID></S08ID><S09ID></S09ID><S10ID></S10ID>
--			<S11ID></S11ID><S12ID></S12ID><S13ID></S13ID><S14ID></S14ID><S15ID></S15ID>
--			<S16ID></S16ID><S17ID></S17ID><S18ID></S18ID><S19ID></S19ID><S20ID></S20ID>
--</Data>'


CREATE PROCEDURE [dbo].[AP7003] 	
	@DivisionID AS VARCHAR(50),
	@UserID AS VARCHAR(50),
	@VoucherID AS VARCHAR(50),
	@ScreenID AS VARCHAR(50) = '',
	@NewWarehouseID AS VARCHAR(50),
	@XML XML
	
AS

IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
	EXEC AP7003_QC @DivisionID, @UserID, @VoucherID, @ScreenID, @NewWarehouseID, @XML
ELSE
BEGIN
	Declare @IsNegativeStock as tinyint, @KindVoucherID TINYINT, @WarehouseID VARCHAR(50)
	Select  @IsNegativeStock = IsNegativeStock From WT0000 WITH (NOLOCK)  Where DefDivisionID =@DivisionID  --- Cho phep xuat kho am hay khong
	Set @IsNegativeStock = isnull(@IsNegativeStock,0)
	Select @WarehouseID=WarehouseID FROM AT2006 WHERE VoucherID=@VoucherID

	IF @ScreenID ='AF0080' --Xóa phiếu mua hàng, tìm lại VoucherID của phiếu nhập kho của phiếu mua hàng này
	BEGIN
		SELECT @VoucherID=ISNULL(VoucherID,'') FROM AT2006 WHERE TableID='AT9000' AND KindVoucherID=5 and VoucherID=@VoucherID
	END
	ELSE IF @ScreenID ='AF0097' --Xóa phiếu hàng bán trả lại, tìm lại VoucherID của phiếu nhập kho của phiếu trả hàng này
	BEGIN
		SELECT @VoucherID=ISNULL(VoucherID,'') FROM AT2006 WHERE KindVoucherID=7 and VoucherID=@VoucherID
	END
	ELSE IF @ScreenID ='MF0017' --Xóa phiếu kết quả sản xuất thành phầm, tìm lại VoucherID của phiếu nhập kho của phiếu kết quả này
	BEGIN
		SELECT @VoucherID=ISNULL(VoucherID,'') FROM AT2006 WHERE TableID='MT0810' AND KindVoucherID=1 and VoucherID=@VoucherID
	END


	-- XÁC ĐỊNH LOẠI PHIẾU TRUYỀN VÀO
	SELECT @KindVoucherID= KindVoucherID FROM AT2006 WITH(NOLOCK) WHERE VoucherID=@VoucherID

	IF @KindVoucherID in (1,3,5,7)
	BEGIN
		CREATE TABLE #CHECK 
		(WarehouseID VARCHAR(50) COLLATE DATABASE_DEFAULT, InventoryID VARCHAR(100) COLLATE DATABASE_DEFAULT, ActualQuantity DECIMAL(28,8), ImQuantity DECIMAL(28,8), ExQuantity DECIMAL(28,8), EndQuantity DECIMAL(28,8), 
		Status TINYINT, Message VARCHAR(50), Params VARCHAR(50))

		IF @XML IS NULL -- Trường hợp xóa phiếu
		BEGIN
		
			INSERT INTO #CHECK (WarehouseID, InventoryID, ActualQuantity, ImQuantity, ExQuantity, EndQuantity)
			SELECT T1.WarehouseID, T2.InventoryID, SUM(T2.ActualQuantity) AS ActualQuantity, ISNULL(X.ImQuantity,0) AS ImQuantity, ISNULL(Y.ExQuantity,0) AS ExQuantity, (ISNULL(X.ImQuantity,0)-ISNULL(Y.ExQuantity,0)) AS EndQuantity
			FROM AT2006 T1 WITH(NOLOCK) INNER JOIN AT2007 T2 WITH(NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.VoucherID=T2.VoucherID 

			LEFT JOIN ( SELECT DivisionID, WareHouseID, InventoryID, SUM(ImQuantity) AS ImQuantity 
						FROM (SELECT A1.DivisionID, A1.WarehouseID, A2.InventoryID, SUM(A2.ActualQuantity) AS ImQuantity
								FROM AT2006 A1 WITH(NOLOCK) INNER JOIN AT2007 A2 WITH(NOLOCK) ON A1.DivisionID = A2.DivisionID AND A1.VoucherID=A2.VoucherID 
								WHERE A1.DivisionID = @DivisionID AND A1.VoucherID <> @VoucherID
								AND ((A1.KindVoucherID in (1,5,7,9) AND A1.WarehouseID = @WarehouseID) OR (A1.KindVoucherID =3 AND A1.WarehouseID = @WarehouseID))
								GROUP BY  A1.DivisionID, A1.WarehouseID, A2.InventoryID 
								UNION ALL
								SELECT A1.DivisionID, A1.WarehouseID, A2.InventoryID, SUM(A2.ActualQuantity) AS ImQuantity
								FROM AT2016 A1 WITH(NOLOCK) INNER JOIN AT2017 A2 WITH(NOLOCK) ON A1.DivisionID = A2.DivisionID AND A1.VoucherID=A2.VoucherID 
								WHERE A1.DivisionID = @DivisionID AND A1.VoucherID <> @VoucherID
									AND A1.WarehouseID = @WarehouseID
								GROUP BY  A1.DivisionID, A1.WarehouseID, A2.InventoryID 
							) TEMP
						GROUP BY DivisionID, WareHouseID, InventoryID
						)X ON T1.DivisionID = X.DivisionID AND T1.WarehouseID = X.WarehouseID AND T2.InventoryID = X.InventoryID

			LEFT JOIN (SELECT B1.DivisionID, CASE WHEN B1.KindVoucherID =3 THEN B1.WarehouseID2 ELSE B1.WarehouseID END AS WarehouseID, B2.InventoryID, SUM(B2.ActualQuantity) as ExQuantity
						FROM AT2006 B1 WITH(NOLOCK) INNER JOIN AT2007 B2 WITH(NOLOCK) ON B1.DivisionID = B2.DivisionID AND B1.VoucherID=B2.VoucherID 
						WHERE B1.DivisionID = @DivisionID AND ((B1.KindVoucherID in (2,4,6,8) AND B1.WarehouseID = @WarehouseID) OR (B1.KindVoucherID =3 AND B1.WarehouseID2 = @WarehouseID))
						GROUP BY B1.DivisionID, CASE WHEN B1.KindVoucherID =3 THEN B1.WarehouseID2 ELSE B1.WarehouseID END, B2.InventoryID )Y ON T1.DivisionID = Y.DivisionID AND T1.WarehouseID = Y.WarehouseID AND T2.InventoryID = Y.InventoryID
		
			WHERE T1.VoucherID=@VoucherID
			GROUP BY T1.WarehouseID, T2.InventoryID, X.ImQuantity, Y.ExQuantity

			UPDATE #CHECK
			SET Status=1, Message='WFML000256', Params=InventoryID
			WHERE EndQuantity < 0 AND @IsNegativeStock = 0

			UPDATE #CHECK
			SET Status=1, Message='WFML000257', Params=InventoryID
			WHERE EndQuantity < 0 AND @IsNegativeStock = 1

			UPDATE #CHECK
			SET Status=0, Message='', Params=''
			WHERE EndQuantity >= 0

			SELECT Status, Message, Params, @IsNegativeStock AS IsNegativeStock FROM #CHECK
		END
		ELSE --Trường hợp Edit phiếu
		BEGIN
			SELECT X.Data.query('NewInventoryID').value('.', 'VARCHAR(50)') AS NewInventoryID,
			X.Data.query('NewQuantity').value('.', 'DECIMAL(28,8)') AS NewQuantity
			INTO #TEMP2
			FROM @XML.nodes('//Data') AS X (Data)
	
			SELECT NewInventoryID, SUM(NewQuantity) AS NewQuantity
			INTO #TEMP
			FROM #TEMP2
			GROUP BY NewInventoryID

			CREATE TABLE #GET_DELETE_INFO
			(OldWarehouseID VARCHAR(50) COLLATE DATABASE_DEFAULT, NewWarehouseID VARCHAR(50) COLLATE DATABASE_DEFAULT, OldInventoryID VARCHAR(100) COLLATE DATABASE_DEFAULT, 
			NewInventoryID VARCHAR(100) COLLATE DATABASE_DEFAULT, OldQuantity DECIMAL(28,8), NewQuantity DECIMAL(28,8))

			INSERT INTO #GET_DELETE_INFO
			SELECT @WarehouseID AS OldWarehouseID, @NewWarehouseID AS NewWarehouseID, T2.InventoryID AS OldInventoryID, ISNULL(T3.NewInventoryID,T2.InventoryID) AS NewInventoryID, 
					--T2.ActualQuantity AS OldActualQuantity, T3.NewQuantity AS NewQuantity
					SUM(T2.ActualQuantity) AS OldActualQuantity, ISNULL(T3.NewQuantity,0) AS NewQuantity
			FROM AT2006 T1 WITH(NOLOCK) INNER JOIN AT2007 T2 WITH(NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.VoucherID=T2.VoucherID 
							FULL JOIN #TEMP T3 WITH(NOLOCK) ON T2.InventoryID = T3.NewInventoryID
			WHERE T1.DivisionID=@DivisionID AND T1.VoucherID=@VoucherID
			GROUP BY ISNULL(T3.NewInventoryID,T2.InventoryID), T2.InventoryID, ISNULL(T3.NewQuantity,0)

			IF NOT EXISTS (SELECT TOP 1 * FROM #GET_DELETE_INFO) -- Trường hợp edit thay đổi tất cả các dòng detial -> thông tin xóa là detail cũ của phiếu
			BEGIN
				INSERT INTO #CHECK (WarehouseID, InventoryID, ActualQuantity)
				SELECT T1.WarehouseID, T2.InventoryID, SUM(T2.ActualQuantity) AS ActualQuantity
				FROM AT2006 T1 WITH(NOLOCK) INNER JOIN AT2007 T2 WITH(NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.VoucherID=T2.VoucherID
				WHERE T1.DivisionID=@DivisionID AND T1.VoucherID=@VoucherID
				GROUP BY T1.WarehouseID, T2.InventoryID
			END
			ELSE
			BEGIN
				-- Trường hợp thay đổi thông tin kho
				INSERT INTO #CHECK (WarehouseID, InventoryID, ActualQuantity)
				SELECT @WarehouseID, OldInventoryID, OldQuantity
				FROM #GET_DELETE_INFO
				WHERE @WarehouseID<>@NewWarehouseID
		
				-- Trường hợp không thay đổi thông tin kho và mặt hàng nhưng có thay đổi giảm số lượng
				INSERT INTO #CHECK (WarehouseID, InventoryID, ActualQuantity)
				SELECT @WarehouseID, OldInventoryID, OldQuantity-NewQuantity
				FROM #GET_DELETE_INFO
				WHERE @WarehouseID=@NewWarehouseID AND OldInventoryID=NewInventoryID AND NewQuantity<OldQuantity
			END

			IF EXISTS (SELECT TOP 1 * FROM #CHECK) -- Khi đã có thông tin cần xóa khỏi phiếu nhập / chuyển
			BEGIN
				UPDATE T1
				SET T1.ImQuantity=ISNULL(X.ImQuantity,0)-T1.ActualQuantity, T1.ExQuantity=ISNULL(Y.ExQuantity,0), T1.EndQuantity= ISNULL(X.ImQuantity,0)-T1.ActualQuantity-ISNULL(Y.ExQuantity,0)
				FROM #CHECK T1 LEFT JOIN ( SELECT DivisionID, WareHouseID, InventoryID, SUM(ImQuantity) AS ImQuantity 
											FROM(	SELECT A1.DivisionID, A1.WarehouseID, A2.InventoryID, SUM(A2.ActualQuantity) AS ImQuantity
													FROM AT2006 A1 WITH(NOLOCK) INNER JOIN AT2007 A2 WITH(NOLOCK) ON A1.DivisionID = A2.DivisionID AND A1.VoucherID=A2.VoucherID 
													WHERE A1.DivisionID = @DivisionID --AND A1.VoucherID <> @VoucherID
													AND ((A1.KindVoucherID in (1,5,7,9) AND A1.WarehouseID = @WarehouseID) OR (A1.KindVoucherID =3 AND A1.WarehouseID = @WarehouseID))
													GROUP BY  A1.DivisionID, A1.WarehouseID, A2.InventoryID 
													UNION ALL
													SELECT A1.DivisionID, A1.WarehouseID, A2.InventoryID, SUM(A2.ActualQuantity) AS ImQuantity
													FROM AT2016 A1 WITH(NOLOCK) INNER JOIN AT2017 A2 WITH(NOLOCK) ON A1.DivisionID = A2.DivisionID AND A1.VoucherID=A2.VoucherID 
													WHERE A1.DivisionID = @DivisionID --AND A1.VoucherID <> @VoucherID
														AND A1.WarehouseID = @WarehouseID
													GROUP BY  A1.DivisionID, A1.WarehouseID, A2.InventoryID 
												)TEMP
											GROUP BY DivisionID, WareHouseID, InventoryID 
										)X ON T1.WarehouseID = X.WarehouseID AND T1.InventoryID = X.InventoryID

				LEFT JOIN (SELECT B1.DivisionID, CASE WHEN B1.KindVoucherID =3 THEN B1.WarehouseID2 ELSE B1.WarehouseID END AS WarehouseID, B2.InventoryID, SUM(B2.ActualQuantity) as ExQuantity
							FROM AT2006 B1 WITH(NOLOCK) INNER JOIN AT2007 B2 WITH(NOLOCK) ON B1.DivisionID = B2.DivisionID AND B1.VoucherID=B2.VoucherID 
							WHERE B1.DivisionID = @DivisionID AND ((B1.KindVoucherID in (2,4,6,8) AND B1.WarehouseID = @WarehouseID) OR (B1.KindVoucherID =3 AND B1.WarehouseID2 = @WarehouseID))
							GROUP BY B1.DivisionID, CASE WHEN B1.KindVoucherID =3 THEN B1.WarehouseID2 ELSE B1.WarehouseID END, B2.InventoryID )Y 
						ON T1.WarehouseID = Y.WarehouseID AND T1.InventoryID = Y.InventoryID
			
				UPDATE #CHECK
				SET Status=1, Message='WFML000256', Params=InventoryID
				WHERE EndQuantity < 0 AND @IsNegativeStock = 0

				UPDATE #CHECK
				SET Status=1, Message='WFML000257', Params=InventoryID
				WHERE EndQuantity < 0 AND @IsNegativeStock = 1

				UPDATE #CHECK
				SET Status=0, Message='', Params=''
				WHERE EndQuantity >= 0

				SELECT Status, Message, Params, @IsNegativeStock AS IsNegativeStock FROM #CHECK
			END
			ELSE
				SELECT 0 AS Status, '' AS Message, '' AS Params, @IsNegativeStock AS IsNegativeStock
		END
	END
	ELSE -- Kiểm tra tồn kho / xuất kho âm đối với hóa đơn bán hàng tự sinh phiếu xuất kho, lúc này chưa có phiếu xuất hoặc edit phiếu xuất (tự sinh) KindVoucherID=4
	BEGIN
		Delete AT7777 Where UserID =@UserID AND DivisionID = @DivisionID
		Delete AT7778 Where UserID =@UserID AND DivisionID = @DivisionID

		CREATE TABLE #AP7003 (TranMonth INT, TranYear INT, WarehouseID VARCHAR(50) COLLATE DATABASE_DEFAULT, InventoryID VARCHAR(50) COLLATE DATABASE_DEFAULT, OldQuantity DECIMAL(28,2), NewQuantity DECIMAL(28,2), VoucherDate DATETIME, CreditAccountID VARCHAR(10) COLLATE DATABASE_DEFAULT, 
								EndQuantity_ToVoucherDate DECIMAL(28,8), EndQuantity_ToNow DECIMAL(28,2), ReOrderQuantity DECIMAL(28,2), 
								Status TINYINT, MessageID VARCHAR(50), Params VARCHAR(50))
		INSERT INTO #AP7003 (TranMonth, TranYear, WarehouseID, InventoryID, OldQuantity, NewQuantity, VoucherDate, CreditAccountID)
		SELECT A1.TranMonth, A1.TranYear, @NewWarehouseID, A1.InventoryID, ISNULL(A3.ActualQuantity,0), A1.Quantity, A1.VoucherDate, A2.AccountID as CreditAccountID
		FROM AT9000 A1 WITH(NOLOCK) LEFT JOIN AT1302 A2 WITH(NOLOCK) ON A2.DivisionID IN (A1.DivisionID,'@@@') AND A1.InventoryID = A2.InventoryID 
						INNER JOIN AT2007 A3 WITH(NOLOCK) ON A1.VoucherID = A3.VoucherID AND A1.InventoryID = A3.InventoryID
		WHERE A1.VoucherID= @VoucherID AND A1.TransactionTypeID='T04'

		UPDATE T1
		Set T1.EndQuantity_ToVoucherDate =Isnull(T1.OldQuantity,0) + Isnull((Select SUM(SignQuantity) From AV7000 Where DivisionID = @DivisionID											
									and InventoryID =T1.InventoryID 
									and InventoryAccountID = T1.CreditAccountID
									and WareHouseID =@NewWarehouseID
									and VoucherDate <= T1.VoucherDate),0),
		T1.EndQuantity_ToNow =Isnull(T1.OldQuantity,0) + Isnull( (Select top 1 EndQuantity From AT2008 WITH (NOLOCK) Where DivisionID =@DivisionID and										
												InventoryID =T1.InventoryID and 
												InventoryAccountID = T1.CreditAccountID and
												WareHouseID =@NewWarehouseID
												Order by TranMonth + TranYear*12 DESC), 0),
		T1.ReOrderQuantity = Isnull((Select ReOrderQuantity From AT1314 WITH (NOLOCK) Where DivisionID = @DivisionID And TranMonth = T1.TranMonth And TranYear = T1.TranYear And InventoryID = T1.InventoryID And (case when WareHouseID = '%' then @NewWarehouseID else WareHouseID end) = @NewWarehouseID),0)
		FROM #AP7003 T1

		-- CẬP NHẬT MESSAGE LỖI
			UPDATE #AP7003
			SET Status =1,
				MessageID =N'WFML000132'
			WHERE NewQuantity > EndQuantity_ToNow and @IsNegativeStock=0
		
			Insert AT7777 (UserID, Status, Message, DivisionID, Value1, Value2, IsNegativeStock)
			SELECT @UserID, Status, MessageID, @DivisionID, InventoryID, @NewWarehouseID, @IsNegativeStock FROM #AP7003
			WHERE Status =1 AND MessageID =N'WFML000132'
			----------------------
			UPDATE #AP7003
			SET Status =2,
				MessageID =N'WFML000133'
			WHERE NewQuantity > EndQuantity_ToNow and  @IsNegativeStock=1

			Insert AT7777 (UserID, Status, Message, DivisionID, Value1, Value2, IsNegativeStock)
			SELECT @UserID, Status, MessageID, @DivisionID, InventoryID, @NewWarehouseID, @IsNegativeStock FROM #AP7003
			WHERE Status =2 AND MessageID =N'WFML000133'
			----------------------
			UPDATE #AP7003
			SET Status =1,
				MessageID =N'WFML000230'
			WHERE NewQuantity > EndQuantity_ToVoucherDate and  @IsNegativeStock=0

			Insert AT7777 (UserID, Status, Message, DivisionID, Value1, Value2, Value3, IsNegativeStock)
			SELECT @UserID, Status, MessageID, @DivisionID, convert(varchar(20),VoucherDate,103), InventoryID, @NewWarehouseID, @IsNegativeStock FROM #AP7003
			WHERE Status =1 AND MessageID =N'WFML000230'
			---------------------
			UPDATE #AP7003
			SET Status =2,
				MessageID =N'WFML000231'
			WHERE NewQuantity > EndQuantity_ToVoucherDate and  @IsNegativeStock=1
		
			Insert AT7777 (UserID, Status, Message, DivisionID, Value1, Value2, Value3, IsNegativeStock)
			SELECT @UserID, Status, MessageID, @DivisionID, convert(varchar(20),VoucherDate,103), InventoryID, @NewWarehouseID, @IsNegativeStock FROM #AP7003
			WHERE Status =2 AND MessageID =N'WFML000231'
			---------------------
			UPDATE #AP7003
			SET Status =0,
				MessageID =''
			WHERE ISNULL(Status,'')=''

			Insert AT7777 (UserID, Status, Message, DivisionID, IsNegativeStock)
			SELECT @UserID, Status, MessageID, @DivisionID, @IsNegativeStock FROM #AP7003
			WHERE Status =0 AND MessageID =''
			------------------------
			------- Kiem tra ton kho an toan
			UPDATE T1
			Set Status = 1, MessageID =N'WFML000244'
			FROM #AP7003 T1 LEFT JOIN AT1302 T2 ON T2.DivisionID IN (@DivisionID,'@@@') And T2.InventoryID = T1.InventoryID
			WHERE T1.EndQuantity_ToNow - T1.NewQuantity <= T1.ReOrderQuantity
			AND EXISTS (SELECT 1 FROM AT0011 WITH (NOLOCK) LEFT JOIN AT1402 WITH (NOLOCK) ON AT1402.DivisionID = AT0011.DivisionID AND AT1402.GroupID = AT0011.GroupID 
					WHERE AT0011.DivisionID = @DivisionID AND AT1402.UserID = @UserID AND WarningID = 3)
			AND ISNULL(T2.IsMinQuantity,0) = 1

			INSERT INTO AT7778 (UserID, [Status], [Message], DivisionID, Value1, Value2, IsNegativeStock)
			Select @UserID as UserID, Status, MessageID, @DivisionID as DivisionID, InventoryID as Value1, @NewWarehouseID as Value2, @IsNegativeStock FROM #AP7003
			WHERE Status = 1 AND MessageID =N'WFML000244'
			-------------------------------------------------------
			UPDATE T1
			Set Status = 1, MessageID =N'WFML000243'
			FROM #AP7003 T1 LEFT JOIN AT1302 T2 ON T2.DivisionID IN (@DivisionID,'@@@') And T2.InventoryID = T1.InventoryID
			WHERE T1.EndQuantity_ToVoucherDate - T1.NewQuantity <= T1.ReOrderQuantity
			AND EXISTS (SELECT 1 FROM AT0011 WITH (NOLOCK) LEFT JOIN AT1402 WITH (NOLOCK) ON AT1402.DivisionID = AT0011.DivisionID AND AT1402.GroupID = AT0011.GroupID 
					WHERE AT0011.DivisionID = @DivisionID AND AT1402.UserID = @UserID AND WarningID = 3)
			AND ISNULL(T2.IsMinQuantity,0) = 1
		
			INSERT INTO AT7778 (UserID, [Status], [Message], DivisionID, Value1, Value2, Value3, IsNegativeStock)
			Select @UserID as UserID, Status, MessageID, @DivisionID as DivisionID, InventoryID as Value1, @NewWarehouseID as Value2, convert(varchar(20),VoucherDate,103) as Value3, @IsNegativeStock FROM #AP7003
			WHERE Status = 1 AND MessageID =N'WFML000243'
			---------------------------------------------------------

			UPDATE T1
			Set Status = 0, MessageID =N''
			FROM #AP7003 T1
			WHERE ISNULL(Status,'')=''

			INSERT INTO AT7778 (UserID, [Status], [Message], DivisionID, IsNegativeStock)
			Select @UserID as UserID, Status, MessageID, @DivisionID as DivisionID, @IsNegativeStock FROM #AP7003
			WHERE Status = 0 AND MessageID =N''

			Select * from AT7777 WITH (NOLOCK) Where UserID = @UserID and DivisionID = @DivisionID
			Select * from AT7778 WITH (NOLOCK) Where UserID = @UserID and DivisionID = @DivisionID
	END
END
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
