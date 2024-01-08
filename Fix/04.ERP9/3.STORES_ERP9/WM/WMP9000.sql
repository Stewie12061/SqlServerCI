IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WMP9000]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WMP9000]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-- <Summary>
---- Kiểm tra xóa/sửa module kho ERP9.0
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Khả Vi, Date: 11/01/2018
----Modified by Bảo Thy on 06/03/2018: bổ sung kiểm tra sửa/xóa số dư đầu kỳ
----Modified by Phương Thảo on 29/03/2018: Bổ sung kiểm tra sửa/xóa phiếu kiểm kê (@FormID = 'WMF2050')
----Modified by Kim Thư on 26/07/2018: Chặn xóa phiếu nhập nếu serial trong phiếu đã được xuất hoặc VCNB hoặc phiếu đã đc ERP 8 kế thừa
--										Chặn xóa phiếu VCNB nếu serial trong phiếu đã được xuất hoặc phiếu đã đc ERP 8 kế thừa
--										Chặn xóa phiếu xuất nếu đã được ERP8 kế thừa
----Modified by Kim Thư on 27/07/2018: Bổ sung xóa phiếu số dư kế thừa tương ứng ở ERP8
----Modified by Kim Thư on 31/07/2018: Bổ sung check kỳ kế toán đã đóng trước khi sửa các phiếu
----Modified by Kim Thư on 01/08/2018: Bổ sung check sửa xóa phiếu yêu cầu nhập, xuất, VCNB
----Modified by Hoài Bảo on 25/08/2022: Cập nhật xóa dữ liệu nhập, xuất, chuyển comment các dòng xóa Lưu dữ liệu số phiếu, Thông tin serial/IMEI, Thông tin mặt hàng theo serial/vị trí WM-9.0
----Modified by Viết Toàn on 30/08/2023: Cập nhật xóa thông tin duyệt phiếu xuất kho (ở bảng OOT9000 và OOT9001)
----Modified by Hoàng Long on 18/10/2023: Bổ sung xóa thông tin phiếu xuất kho mã vạch(WMF2090,WMF2092)
----Modified by Thanh Luong on 19/10/2023: Bổ sung xóa thông tin phiếu chuyển kho mã vạch(WMF2300,WMF2302)
----Modified by Thanh Luong on 06/11/2023: Bổ sung check không cho xóa nếu số serial đã được xuất (Customize Gree)
----Modified by Hoàng Long on 10/11/2023: Bổ sung xóa thông tin phiếu lắp ráp(WMF2320,WMF2322)
----Modified by Trọng Phúc on 23/11/2023: Chỉnh sửa xóa phiếu ở màn hình WM2290 customize NKC
----Modified by Viết Toàn on 04/12/2023: Bổ sung xóa phiếu tiến độ giao hàng được sinh tự động từ phiếu YCXK tương ứng
----Modified by Thanh Nguyên on 11/12/2023: Xử lý lỗi Phiếu YCNK đã được duyệt nhưng vẫn cho phép xóa
----Modified by Thanh Lượng on 15/12/2023: [2023/12/IS/0168] - Bổ sung xử lý xóa phiếu nhập kho, nhập kho serial SELL-OUT (Cusotmize Gree).
----Modified by Hồng Thắm on 25/12/2023: Bổ sung xóa thông tin phiếu tháo dỡ(WMF2310,WMF2312)
----Modified by Nhật Thanh on 26/12/2023: Bổ sung check phiếu vận chuyển nội bộ
----Modified by Nhật Thanh on 27/12/2023: Xóa YCXK thì kiểm tra xem tiến độ giao hàng còn ngày khác thì không xóa cả phiếu
-- <Example>
---- 
/*-- <Example>
	WMP9000 @DivisionID = 'CH', @APK = '1B0C92E4-CFB5-47FA-867B-41291B513910', @APKList = '1B0C92E4-CFB5-47FA-867B-41291B513910', @FormID = 'WMF1012', 
	@Mode = 0 , @IsDisable = '', @UserID = 'ASOFTADMIN'

	WMP9000 @DivisionID, @APK, @APKList, @FormID, @Mode, @IsDisable, @UserID
----*/

CREATE PROCEDURE WMP9000
( 
	@DivisionID VARCHAR(50),
	@TranMonth INT = NULL,
	@TranYear INT = NULL,
	@APK VARCHAR(50), --Trường hợp sửa
	@APKList NVARCHAR(MAX), --Trường hợp xóa hoặc xử lý enable/disable
	@FormID VARCHAR(50),
	@Mode TINYINT, --0: Sửa, 1: Xóa; 2: Sửa (Disable/Enable)
	@IsDisable TINYINT, --1: Disable; 0: Enable
	@UserID NVARCHAR(50)
) 
AS 
DECLARE @sSQL NVARCHAR(MAX) = N'',
		@IDList NVARCHAR(MAX) = N'',
		@CustomerIndex INT

SELECT @CustomerIndex = CustomerName FROM CustomerIndex
/*********Danh mục vị trí kho*************/
IF @FormID IN ('WMF1010', 'WMF1012')
BEGIN
	SET @sSQL = N'
	CREATE TABLE #WMP9000_Errors (Status TINYINT, Params VARCHAR(50), MessageID VARCHAR(50), APK VARCHAR(50))

	SELECT APK, DivisionID, LocationID
	INTO #WMP9000
	FROM WMT1010 WITH (NOLOCK) WHERE APK IN ('''+CASE WHEN @FormID = 'WMF1010' THEN @APKList ELSE @APK END+''')
	
	IF EXISTS (SELECT TOP 1 1 FROM #WMP9000 WITH (NOLOCK) WHERE DivisionID <> '''+@DivisionID+''')	---- Kiểm tra khác đơn vị
	BEGIN
		INSERT INTO #WMP9000_Errors (Status, Params, MessageID, APK)
		SELECT 2 AS Status, LocationID AS Params, ''00ML000050''AS MessageID, APK
		FROM #WMP9000 WHERE DivisionID <> '''+@DivisionID+'''
	END '
	IF @Mode = 1 
	BEGIN 
		IF @CustomerIndex = 88 ---- VIETFIRST 
		BEGIN
			SET @sSQL = @sSQL + N'
			ELSE IF EXISTS (
				---- Nghiệp vụ PSC
				SELECT TOP 1 1 FROM CSMT2013 T1 WITH (NOLOCK) INNER JOIN #WMP9000 T2 ON T1.DivisionID = T2.DivisionID 
				AND (T1.ImLocationID = T2.LocationID OR T1.ExLocationID = T2.LocationID OR T1.KBBLocationID = T2.LocationID)
				UNION ALL 
				---- Nghiệp vụ nhập kho, xuất kho, VCNB
				SELECT TOP 1 1 FROM WMT2008 T1 WITH (NOLOCK) INNER JOIN #WMP9000 T2 ON T1.DivisionID = T2.DivisionID AND T1.LocationID = T2.LocationID)
			BEGIN
				INSERT INTO #WMP9000_Errors (Status, Params, MessageID, APK)
				SELECT 2 AS Status, LocationID AS Params, ''00ML000165''AS MessageID, APK
				FROM #WMP9000 
				WHERE EXISTS (
				SELECT TOP 1 1 FROM CSMT2013 T1 WITH (NOLOCK) INNER JOIN #WMP9000 T2 ON T1.DivisionID = T2.DivisionID 
				AND (T1.ImLocationID = T2.LocationID OR T1.ExLocationID = T2.LocationID OR T1.KBBLocationID = T2.LocationID)
				UNION ALL 
				---- Nghiệp vụ nhập kho, xuất kho, VCNB
				SELECT TOP 1 1 FROM WMT2008 T1 WITH (NOLOCK) INNER JOIN #WMP9000 T2 ON T1.DivisionID = T2.DivisionID AND T1.LocationID = T2.LocationID)
			END'
		END 

		SET @sSQL = @sSQL + N'
		DELETE T1 FROM WMT1010 T1 INNER JOIN #WMP9000 T2 ON T1.APK = T2.APK 
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #WMP9000_Errors T3 WITH(NOLOCK) WHERE T1.APK = T3.APK)'
	END
	ELSE IF @Mode = 2 
	BEGIN 
		SET @sSQL = @sSQL + N'
		UPDATE T1 SET T1.Disabled = '+CAST(@IsDisable AS VARCHAR(1))+' FROM WMT1010 T1 WITH (NOLOCK) 
		INNER JOIN #WMP9000 T2 ON T1.APK = T2.APK WHERE NOT EXISTS (SELECT TOP 1 1 FROM #WMP9000_Errors T3 WITH(NOLOCK) WHERE T1.APK = T3.APK)'
	END 

	SET @sSQL = @sSQL + N'
	SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
	SELECT '', '' + Params FROM #WMP9000_Errors T2 WITH(NOLOCK) WHERE  T1.MessageID = T2.MessageID FOR XML PATH ('''')), 1, 1, '''') AS Params 
	FROM #WMP9000_Errors T1 ORDER BY MessageID'
END 
/******============Kiểm tra sửa/xóa nghiệp vụ WM9.0============******/
IF @FormID IN ('WMF2010','WMF2012') --Số dư đầu kỳ  
BEGIN
	IF @Mode = 0 ---Sửa
	BEGIN
		SET @sSQL = '
		DECLARE @Status TINYINT,
				@MessageID NVARCHAR(1000),
				@DelDivisionID VARCHAR(50),
				@DelVoucherNo VARCHAR(50), 
				@DelTranMonth INT, 
				@DelTranYear INT,  
				@Params VARCHAR(MAX) = ''''

		SELECT @DelDivisionID = DivisionID, @DelVoucherNo = VoucherNo, @DelTranMonth = TranMonth, @DelTranYear = TranYear
		FROM WMT2016 WITH (NOLOCK)
		WHERE APK = '''+@APK+'''

		IF @DelDivisionID <> '''+@DivisionID+''' -- Kiểm tra khác đơn vị
		BEGIN
			SET @Params = @DelVoucherNo
			SET @MessageID = ''00ML000050''
			Goto EndMess
		END
		
		IF @DelTranMonth+@DelTranYear*100 <> '+STR(@TranMonth+@TranYear*100)+' -- Kiểm tra khác kỳ kế toán
		BEGIN
			SET @Params = @DelVoucherNo
			SET @MessageID = ''00ML000137''
			Goto EndMess
		END
		
		IF EXISTS (SELECT top 1 1 FROM WMT2016 T1 INNER JOIN WT9999 T2 ON T1.DivisionID=T2.DivisionID AND T1.TranMonth=T2.TranMonth AND T1.TranYear=T2.TranYear
							WHERE T1.APK= '''+@APK+''' AND T2.Closing = 1) -- Kiểm tra kỳ kế toán đã đóng thì không cho sửa
		BEGIN
			SET @Params = @DelVoucherNo
			SET @MessageID = ''WMFML000053''
			Goto EndMess
		END

		IF EXISTS (SELECT TOP 1 1 FROM WMT2007 WITH (NOLOCK) WHERE DivisionID = '''+@DivisionID+''' AND InheritAPKMaster = '''+@APK+''') ---Kiem tra da duoc ke thua chua
		BEGIN
			SET @Params = @DelVoucherNo
			SET @MessageID = ''00ML000052''
			Goto EndMess
		END

		EndMess:
		SELECT 2 AS Status, @MessageID AS MessageID, LEFT(@Params, LEN(@Params) -1) AS Params, '''+@FormID+''' AS FormID 
		WHERE ISNULL(@Params, '''') <> ''''
		'
	END
	ELSE
	IF @Mode = 1 ---Xóa
	BEGIN
		SET @sSQL = N'
		CREATE TABLE #WMP9000_Errors (VoucherNo Varchar(50), APK Varchar(50), MessageID Varchar(50))		

		SELECT APK, DivisionID, VoucherNo, TranMonth, TranYear
		INTO #WMP9000_WMT2016
		FROM WMT2016 WITH (NOLOCK) WHERE APK IN ('''+@APKList+''')

		IF EXISTS (SELECT TOP 1 1 FROM #WMP9000_WMT2016 WHERE DivisionID <> '''+@DivisionID+''')
		BEGIN 
			INSERT INTO #WMP9000_Errors (VoucherNo, APK, MessageID)
			SELECT 	VoucherNo, APK, ''00ML000050''
			FROM #WMP9000_WMT2016
			WHERE DivisionID <> '''+@DivisionID+'''
		END
		ELSE
		IF EXISTS (SELECT TOP 1 1 FROM #WMP9000_WMT2016 WHERE TranMonth+TranYear*100 <> '+STR(@TranMonth+@TranYear*100)+')
		BEGIN 
			INSERT INTO #WMP9000_Errors (VoucherNo, APK, MessageID)
			SELECT 	VoucherNo, APK, ''00ML000137''
			FROM #WMP9000_WMT2016
			WHERE TranMonth+TranYear*100 <> '+STR(@TranMonth+@TranYear*100)+'
		END
		ELSE
		IF EXISTS (SELECT top 1 1 FROM #WMP9000_WMT2016 T1 INNER JOIN WT9999 T2 ON T1.DivisionID=T2.DivisionID AND T1.TranMonth=T2.TranMonth AND T1.TranYear=T2.TranYear
							AND T2.Closing = 1) -- Kiểm tra kỳ kế toán đã đóng thì không cho xóa		
		BEGIN
			INSERT INTO #WMP9000_Errors (VoucherNo, APK, MessageID)
			SELECT 	T1.VoucherNo, T1.APK, ''WMFML000053''
			FROM #WMP9000_WMT2016 T1 WITH(NOLOCK) INNER JOIN WT9999 T2 ON T1.DivisionID=T2.DivisionID AND T1.TranMonth=T2.TranMonth AND T1.TranYear=T2.TranYear AND T2.Closing = 1					
		END
		ELSE
		IF EXISTS (	SELECT TOP 1 1 
					FROM WMT2007 WITH(NOLOCK) 
					INNER JOIN #WMP9000_WMT2016 ON WMT2007.DivisionID = #WMP9000_WMT2016.DivisionID AND WMT2007.InheritAPKMaster = #WMP9000_WMT2016.APK) ---Kiểm tra đã được kế thừa chưa
		BEGIN
			INSERT INTO #WMP9000_Errors (VoucherNo, APK, MessageID)
			SELECT 	VoucherNo, APK, ''00ML000052''
			FROM WMT2007 WITH(NOLOCK) 
			INNER JOIN #WMP9000_WMT2016 ON WMT2007.DivisionID = #WMP9000_WMT2016.DivisionID AND WMT2007.InheritAPKMaster = #WMP9000_WMT2016.APK									
		END

		DELETE T1 
		FROM WMT2018 T1 INNER JOIN #WMP9000_WMT2016 T2 ON T1.APKMaster = T2.APK		
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #WMP9000_Errors T3 WITH(NOLOCK) WHERE T1.APKMaster = T3.APK)

		DELETE T1 
		FROM WMT2017 T1 INNER JOIN #WMP9000_WMT2016 T2 ON T1.APKMaster = T2.APK		
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #WMP9000_Errors T3 WITH(NOLOCK) WHERE T1.APKMaster = T3.APK)

		DELETE T1 
		FROM WMT2016 T1 INNER JOIN #WMP9000_WMT2016 T2 ON T1.APK = T2.APK		
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #WMP9000_Errors T3 WITH(NOLOCK) WHERE T1.APK = T3.APK)

		--DELETE T1 
		--FROM WMT9009 T1 INNER JOIN #WMP9000_WMT2016 T2 ON T1.APKMaster = T2.APK		
		--WHERE NOT EXISTS (SELECT TOP 1 1 FROM #WMP9000_Errors T3 WITH(NOLOCK) WHERE T1.APKMaster = T3.APK)

		--DELETE T1 
		--FROM WMT9008 T1 INNER JOIN #WMP9000_WMT2016 T2 ON T1.APKMaster = T2.APK		
		--WHERE NOT EXISTS (SELECT TOP 1 1 FROM #WMP9000_Errors T3 WITH(NOLOCK) WHERE T1.APKMaster = T3.APK)
		
		-- XÓA PHIẾU SỐ DƯ ĐÃ KẾ THỪA Ở ERP8
		DELETE T1 
		FROM AT2016 T1 WHERE VoucherID IN (SELECT VoucherID FROM AT2016 T1 INNER JOIN #WMP9000_WMT2016 T2 ON T1.InheritAPK = T2.APK		
											WHERE NOT EXISTS (SELECT TOP 1 1 FROM #WMP9000_Errors T3 WITH(NOLOCK) WHERE T1.InheritAPK = T3.APK))
		
		DELETE T1 
		FROM AT2017 T1 WHERE VoucherID IN (SELECT VoucherID FROM AT2016 T1 INNER JOIN #WMP9000_WMT2016 T2 ON T1.InheritAPK = T2.APK		
											WHERE NOT EXISTS (SELECT TOP 1 1 FROM #WMP9000_Errors T3 WITH(NOLOCK) WHERE T1.InheritAPK = T3.APK))

				
		SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
					SELECT '', '' + VoucherNo 
					FROM #WMP9000_Errors T2 WITH(NOLOCK) 
					WHERE  T1.APK = T2.APK
					FOR XML PATH ('''')), 1, 1, ''''
					) AS Params, '''+@FormID+''' AS FormID
		FROM #WMP9000_Errors T1
		ORDER BY MessageID
		'
	END
END
ELSE
IF @FormID IN ('WMF2020','WMF2022') --Nhập kho  
BEGIN
	IF @Mode = 0 ---Sửa
	BEGIN
		SET @sSQL = '
		DECLARE @Status TINYINT,
				@MessageID NVARCHAR(1000),
				@DelDivisionID VARCHAR(50),
				@DelVoucherNo VARCHAR(50),
				@DelTranMonth INT, 
				@DelTranYear INT,  
				@Params VARCHAR(MAX) = ''''

		SELECT @DelDivisionID = DivisionID, @DelVoucherNo = VoucherNo, @DelTranMonth = TranMonth, @DelTranYear = TranYear
		FROM AT2006 WITH (NOLOCK)
		WHERE APK = '''+@APK+'''

		IF @DelDivisionID <> '''+@DivisionID+''' -- Kiểm tra khác đơn vị
		BEGIN
			SET @Params = @DelVoucherNo
			SET @MessageID = ''00ML000050''
			Goto EndMess
		END
		
		IF @DelTranMonth+@DelTranYear*100 <> '+STR(@TranMonth+@TranYear*100)+' -- Kiểm tra khác kỳ kế toán
		BEGIN
			SET @Params = @DelVoucherNo
			SET @MessageID = ''00ML000137''
			Goto EndMess
		END
		
		IF EXISTS (SELECT top 1 1 FROM AT2006 T1 INNER JOIN WT9999 T2 ON T1.DivisionID=T2.DivisionID AND T1.TranMonth=T2.TranMonth AND T1.TranYear=T2.TranYear
							WHERE T1.APK= '''+@APK+''' AND T1.KindVoucherID=1 AND T2.Closing = 1) -- Kiểm tra kỳ kế toán đã đóng thì không cho sửa
		BEGIN
			SET @Params = @DelVoucherNo
			SET @MessageID = ''WMFML000053''
			Goto EndMess
		END


		--IF EXISTS (SELECT TOP 1 1 FROM AT2007 WITH (NOLOCK) WHERE DivisionID = '''+@DivisionID+''' AND InheritAPKMaster = '''+@APK+''') ---Kiem tra da duoc ke thua chua
		--BEGIN
		--	SET @Params = @DelVoucherNo
		--	SET @MessageID = ''00ML000052''
		--	Goto EndMess
		--END

		EndMess:
		SELECT 2 AS Status, @MessageID AS MessageID, LEFT(@Params, LEN(@Params) -1) AS Params, '''+@FormID+''' AS FormID 
		WHERE ISNULL(@Params, '''') <> ''''
		'
	END
	ELSE
	IF @Mode = 1 ---Xóa
	BEGIN
		SET @sSQL = N'
		CREATE TABLE #WMP9000_Errors (VoucherNo Varchar(50), APK Varchar(50), MessageID Varchar(50))		

		SELECT APK, DivisionID, VoucherNo, TranMonth, TranYear
		INTO #WMP9000_AT2006
		FROM AT2006 WITH (NOLOCK) WHERE APK IN ('''+@APKList+''')

		IF EXISTS (SELECT TOP 1 1 FROM #WMP9000_AT2006 WHERE DivisionID <> '''+@DivisionID+''')
		BEGIN 
			INSERT INTO #WMP9000_Errors (VoucherNo, APK, MessageID)
			SELECT 	VoucherNo, APK, ''00ML000050''
			FROM #WMP9000_AT2006
			WHERE DivisionID <> '''+@DivisionID+'''
		END
		ELSE
		IF EXISTS (SELECT TOP 1 1 FROM #WMP9000_AT2006 WHERE TranMonth+TranYear*100 <> '+STR(@TranMonth+@TranYear*100)+')
		BEGIN 
			INSERT INTO #WMP9000_Errors (VoucherNo, APK, MessageID)
			SELECT 	VoucherNo, APK, ''00ML000137''
			FROM #WMP9000_AT2006
			WHERE TranMonth+TranYear*100 <> '+STR(@TranMonth+@TranYear*100)+'
		END

		IF ((SELECT CustomerName FROM CustomerIndex)=162) ---- Gree 
		BEGIN
			IF EXISTS (Select Top 1 1 From BT1002 with (nolock) 
			where KindVoucherID in (2,4,6,8) 
			and SeriNo in (select SeriNo from BT1002 where VoucherNO in (select VoucherNO from #WMP9000_AT2006) and DivisionID = (SELECT KeyValue FROM ST2101 WHERE KeyName = ''DealerDivisionID'') and 
			KindVoucherID in (1,3,5,7)))
			BEGIN 
				INSERT INTO #WMP9000_Errors (VoucherNo, APK, MessageID)
				SELECT 	VoucherNo, APK, ''WFML000290''
				FROM #WMP9000_AT2006
				WHERE VoucherNo in (Select VoucherNo From BT1002 with (nolock) 
			where KindVoucherID in (2,4,6,8) 
			and SeriNo in (select SeriNo from BT1002 where VoucherID in (select APK from #WMP9000_AT2006) and DivisionID in (SELECT KeyValue FROM ST2101 WHERE KeyName = ''DealerDivisionID'') and 
			KindVoucherID in (1,3,5,7)))
			END
		END
		--ELSE
		--IF EXISTS (	SELECT TOP 1 1 
		--			FROM WMT2007 WITH(NOLOCK) 
		--			INNER JOIN #WMP9000_WMT2006 ON WMT2007.DivisionID = #WMP9000_WMT2006.DivisionID AND WMT2007.InheritAPKMaster = #WMP9000_WMT2006.APK) ---Kiểm tra đã được kế thừa chưa
		--BEGIN
		--	INSERT INTO #WMP9000_Errors (VoucherNo, APK, MessageID)
		--	SELECT 	VoucherNo, APK, ''00ML000052''
		--	FROM WMT2007 WITH(NOLOCK) 
		--	INNER JOIN #WMP9000_WMT2006 ON WMT2007.DivisionID = #WMP9000_WMT2006.DivisionID AND WMT2007.InheritAPKMaster = #WMP9000_WMT2006.APK									
		--END
		--ELSE
		--IF EXISTS (SELECT top 1 1 FROM #WMP9000_AT2006 T1 INNER JOIN WT9999 T2 ON T1.DivisionID=T2.DivisionID AND T1.TranMonth=T2.TranMonth AND T1.TranYear=T2.TranYear
		--					AND T2.Closing = 1) -- Kiểm tra kỳ kế toán đã đóng thì không cho xóa		
		--BEGIN
		--	INSERT INTO #WMP9000_Errors (VoucherNo, APK, MessageID)
		--	SELECT 	T1.VoucherNo, T1.APK, ''WMFML000053''
		--	FROM #WMP9000_AT2006 T1 WITH(NOLOCK) INNER JOIN WT9999 T2 ON T1.DivisionID=T2.DivisionID AND T1.TranMonth=T2.TranMonth AND T1.TranYear=T2.TranYear AND T2.Closing = 1					
		--END

		-- CHECK SERIAL TRONG PHIẾU NHẬP ĐÃ ĐƯỢC XUẤT HAY CHƯA
		--SELECT '''+@DivisionID+''' as DivisionID, T1.APK, T1.VoucherDate, T1.ImWarehouseID, T2.InventoryID, T2.ActualQuantity, T4.IsSerialized, T3.SerialNo, T3.LocationID
		--INTO #TAM
		--FROM WMT2006 T1 INNER JOIN WMT2007 T2 ON T1.APK = T2.APKMaster and T1.DivisionID = T2.DivisionID
		--				--INNER JOIN WMT2008 T3 ON T1.APK = T3.APKMaster and T3.APKDetail = T2.APK and T1.DivisionID=T3.DivisionID
		--				INNER JOIN AT1302 T4 ON T2.InventoryID = T4.InventoryID and T1.DivisionID = T4.DivisionID
		--WHERE T1.DivisionID='''+@DivisionID+''' AND T1.APK IN ('''+@APKList+''')

		
		--IF EXISTS (SELECT TOP 1 1 FROM #TAM WHERE IsSerialized=1)
		--BEGIN
		--	-- check serial có nằm trong ds xuất hoặc VCNB hay ko, hoặc phiếu nhập có được kế thừa xuống ERP 8 hay ko
		--	INSERT INTO #WMP9000_Errors (VoucherNo, APK, MessageID)
		--	SELECT 	VoucherNo, APK, ''WFMF000175''
		--	FROM #WMP9000_WMT2006
		--	WHERE APK IN (SELECT APK FROM #TAM 
		--					WHERE SerialNo in (
		--										SELECT DISTINCT SerialNo
		--										FROM WMT2008 T1 INNER JOIN WMT2006 T2 ON T1.APKMaster=T2.APK
		--										WHERE T2.KindVoucherID in (2,3) AND SerialNo IS NOT NULL
		--										)
		--					)
		--	OR EXISTS (select top 1 1 from wmt2007 where apkmaster in ('''+@APKList+''') and ERP8VoucherID is not null)

		--	DELETE T1 FROM #TAM T1 INNER JOIN #WMP9000_Errors T2 ON T1.APK=T2.APK
		--END

		--DELETE T1 
		--FROM WMT2008 T1 INNER JOIN #WMP9000_WMT2006 T2 ON T1.APKMaster = T2.APK		
		--WHERE NOT EXISTS (SELECT TOP 1 1 FROM #WMP9000_Errors T3 WITH(NOLOCK) WHERE T1.APKMaster = T3.APK)

		DELETE T1
		FROM AT2007 T1 INNER JOIN #WMP9000_AT2006 T2 ON T1.VoucherID IN (SELECT TOP 1 VoucherID FROM AT2006 WHERE APK = T2.APK)
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #WMP9000_Errors T3 WITH(NOLOCK) WHERE T1.VoucherID = (SELECT TOP 1 VoucherID FROM AT2006 WHERE APK = T3.APK))

		DELETE T1 
		FROM AT2006 T1 INNER JOIN #WMP9000_AT2006 T2 ON T1.APK = T2.APK
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #WMP9000_Errors T3 WITH(NOLOCK) WHERE T1.APK = T3.APK)

		IF ((SELECT CustomerName FROM CustomerIndex)=162) ---- Gree Xóa phiếu nhập kho, SeriNo (SELL-OUT)
		BEGIN
			DELETE T1 
			FROM AT2006 T1 INNER JOIN #WMP9000_AT2006 T2 ON T1.VoucherNO = T2.VoucherNO
			WHERE T1.VoucherNo =T2.VoucherNO and T1.DivisionID = (SELECT KeyValue FROM ST2101 WHERE KeyName = ''DealerDivisionID'') 
			and NOT EXISTS (SELECT TOP 1 1 FROM #WMP9000_Errors T3 WITH(NOLOCK) WHERE T1.VoucherNO = T3.VoucherNO)

			DELETE T1 
			FROM BT1002 T1 INNER JOIN #WMP9000_AT2006 T2 ON T1.VoucherNO = T2.VoucherNO
			WHERE T1.VoucherNo =T2.VoucherNO and T1.DivisionID = (SELECT KeyValue FROM ST2101 WHERE KeyName = ''DealerDivisionID'') 
			and NOT EXISTS (SELECT TOP 1 1 FROM #WMP9000_Errors T3 WITH(NOLOCK) WHERE T1.VoucherNO = T3.VoucherNO)
		END

		--DELETE T1 
		--FROM WMT9009 T1 INNER JOIN #WMP9000_WMT2006 T2 ON T1.APKMaster = T2.APK
		--WHERE NOT EXISTS (SELECT TOP 1 1 FROM #WMP9000_Errors T3 WITH(NOLOCK) WHERE T1.APKMaster = T3.APK)

		--DELETE T1
		--FROM WMT9008 T1 INNER JOIN #WMP9000_WMT2006 T2 ON T1.APKMaster = T2.APK
		--WHERE NOT EXISTS (SELECT TOP 1 1 FROM #WMP9000_Errors T3 WITH(NOLOCK) WHERE T1.APKMaster = T3.APK)
								
		SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
					SELECT '', '' + VoucherNo 
					FROM #WMP9000_Errors T2 WITH(NOLOCK) 
					WHERE  T1.APK = T2.APK
					FOR XML PATH ('''')), 1, 1, ''''
					) AS Params, '''+@FormID+''' AS FormID
		FROM #WMP9000_Errors T1
		ORDER BY MessageID
		'
	END
END
ELSE
IF @FormID IN ('WMF2030','WMF2032') --Xuất kho  
BEGIN
	IF @Mode = 0 ---Sửa
	BEGIN
		SET @sSQL = '
		DECLARE @Status TINYINT,
				@MessageID NVARCHAR(1000),
				@DelDivisionID VARCHAR(50),
				@DelVoucherNo VARCHAR(50),
				@ImDivisionID VARCHAR(50),
				@IsTransferDivision TINYINT,
				@DelTranMonth INT, 
				@DelTranYear INT,  
				@Params VARCHAR(MAX) = ''''

		SELECT @DelDivisionID = DivisionID, @DelVoucherNo = VoucherNo, @IsTransferDivision = IsTransferDivision, @ImDivisionID = ImDivisionID, @DelTranMonth = TranMonth, @DelTranYear = TranYear
		FROM AT2006 WITH (NOLOCK)
		WHERE APK = '''+@APK+'''

		IF @DelDivisionID <> '''+@DivisionID+''' -- Kiểm tra khác đơn vị
		BEGIN
			SET @Params = @DelVoucherNo
			SET @MessageID = ''00ML000050''
			Goto EndMess
		END
		
		IF @DelTranMonth+@DelTranYear*100 <> '+STR(@TranMonth+@TranYear*100)+' -- Kiểm tra khác kỳ kế toán
		BEGIN
			SET @Params = @DelVoucherNo
			SET @MessageID = ''00ML000137''
			Goto EndMess
		END
		
		IF EXISTS (SELECT top 1 1 FROM AT2006 T1 INNER JOIN WT9999 T2 ON T1.DivisionID=T2.DivisionID AND T1.TranMonth=T2.TranMonth AND T1.TranYear=T2.TranYear
							WHERE T1.APK= '''+@APK+''' AND T1.KindVoucherID=2 AND T2.Closing = 1) -- Kiểm tra kỳ kế toán đã đóng thì không cho sửa
		BEGIN
			SET @Params = @DelVoucherNo
			SET @MessageID = ''WMFML000053''
			Goto EndMess
		END

		IF EXISTS (SELECT TOP 1 1 FROM WMT2080 T1 INNER JOIN WMT2081 T2 ON T1.APK=T2.APKMaster AND T1.DivisionID=T2.DivisionID AND T2.InheritTableID=''AT2006''
													INNER JOIN AT2006 T3 ON T1.DivisionID=T3.ImDivisionID AND T2.InheritAPKMaster=T3.APK
					WHERE T3.DivisionID='''+@DivisionID+''' AND T3.APK='''+@APK+''' AND T1.IsCheck=1) ---Kiem tra YCNK đã được duyệt khi chuyen xuyen don vi
		BEGIN
			SET @Params = @DelVoucherNo
			SET @MessageID = ''WMFML000017''
			Goto EndMess
		END

		EndMess:
		SELECT 2 AS Status, @MessageID AS MessageID, LEFT(@Params, LEN(@Params) -1) AS Params, '''+@FormID+''' AS FormID 
		WHERE ISNULL(@Params, '''') <> ''''
		'
	END
	ELSE
	IF @Mode = 1 ---Xóa
	BEGIN
		SET @sSQL = N'
		CREATE TABLE #WMP9000_Errors (VoucherNo Varchar(50), APK Varchar(50), MessageID Varchar(50))		

		SELECT APK, DivisionID, VoucherNo, TranMonth, TranYear
		INTO #WMP9000_AT2006
		FROM AT2006 WITH (NOLOCK) WHERE APK IN ('''+@APKList+''')

		IF EXISTS (SELECT TOP 1 1 FROM #WMP9000_AT2006 WHERE DivisionID <> '''+@DivisionID+''')
		BEGIN 
			INSERT INTO #WMP9000_Errors (VoucherNo, APK, MessageID)
			SELECT 	VoucherNo, APK, ''00ML000050''
			FROM #WMP9000_AT2006
			WHERE DivisionID <> '''+@DivisionID+'''
		END
		ELSE
		IF EXISTS (SELECT TOP 1 1 FROM #WMP9000_AT2006 WHERE TranMonth+TranYear*100 <> '+CONVERT(varchar(50),@TranMonth+@TranYear*100)+')
		BEGIN 
			INSERT INTO #WMP9000_Errors (VoucherNo, APK, MessageID)
			SELECT 	VoucherNo, APK, ''00ML000137''
			FROM #WMP9000_AT2006
			WHERE TranMonth+TranYear*100 <> '+CONVERT(varchar(50),@TranMonth+@TranYear*100)+'
		END
		--ELSE
		--IF EXISTS (SELECT top 1 1 FROM #WMP9000_AT2006 T1 INNER JOIN WT9999 T2 ON T1.DivisionID=T2.DivisionID AND T1.TranMonth=T2.TranMonth AND T1.TranYear=T2.TranYear
		--					AND T2.Closing = 1) -- Kiểm tra kỳ kế toán đã đóng thì không cho xóa		
		--BEGIN
		--	INSERT INTO #WMP9000_Errors (VoucherNo, APK, MessageID)
		--	SELECT 	T1.VoucherNo, T1.APK, ''WMFML000053''
		--	FROM #WMP9000_AT2006 T1 WITH(NOLOCK) INNER JOIN WT9999 T2 ON T1.DivisionID=T2.DivisionID AND T1.TranMonth=T2.TranMonth AND T1.TranYear=T2.TranYear AND T2.Closing = 1					
		--END
		ELSE
		IF EXISTS (SELECT TOP 1 1
					FROM WMT2080 T1 INNER JOIN WMT2081 T2 ON T1.APK=T2.APKMaster AND T1.DivisionID=T2.DivisionID AND T2.InheritTableID=''AT2006''
									INNER JOIN #WMP9000_AT2006 T3 ON T2.InheritAPKMaster=T3.APK
									INNER JOIN AT2006 T4 ON T3.DivisionID=T4.DivisionID AND T3.APK=T4.APK
					WHERE T4.DivisionID='''+@DivisionID+''' AND T1.IsCheck=1
					) ---Kiem tra YCNK đã được duyệt khi chuyen xuyen don vi
		BEGIN
			INSERT INTO #WMP9000_Errors (VoucherNo, APK, MessageID)
			SELECT 	T3.VoucherNo, T3.APK, ''WMFML000017''
			FROM WMT2080 T1 INNER JOIN WMT2081 T2 ON T1.APK=T2.APKMaster AND T1.DivisionID=T2.DivisionID AND T2.InheritTableID=''AT2006''
									INNER JOIN #WMP9000_AT2006 T3 ON T2.InheritAPKMaster=T3.APK
									INNER JOIN AT2006 T4 ON T3.DivisionID=T4.DivisionID AND T3.APK=T4.APK
			WHERE T4.DivisionID='''+@DivisionID+''' AND T1.IsCheck=1						
		END
			
		-- KIỂM TRA PHIẾU XUẤT CÓ ĐƯỢC BÊN ERP8 KẾ THỪA HAY CHƯA
		--IF EXISTS (SELECT TOP 1 1 FROM AT2006 T1 WITH (NOLOCK) INNER JOIN AT2007 T2 ON T1.DivisionID=T2.DivisionID AND T1.APK=T2.APKMaster
		--														INNER JOIN #WMP9000_AT2006 T3 ON T1.DivisionID=T3.DivisionID AND T1.APK=T3.APK
		--							WHERE T2.ERP8VoucherID IS NOT NULL)

		--BEGIN
		--	INSERT INTO #WMP9000_Errors (VoucherNo, APK, MessageID)
		--	SELECT 	VoucherNo, APK, ''WMFML000008''
		--	FROM #WMP9000_AT2006 T1 
		--	INNER JOIN AT2006 T2 WITH(NOLOCK)  ON T2.DivisionID = T1.DivisionID AND T2.APK = T1.APK
		--	INNER JOIN AT2007 T3 ON T1.DivisionID = T3.DivisionID AND T2.APK=T3.APKMaster AND T3.ERP8VoucherID IS NOT NULL					
		--END

		--DELETE T1 
		--FROM WMT2008 T1 INNER JOIN #WMP9000_AT2006 T2 ON T1.APKMaster = T2.APK		
		--WHERE NOT EXISTS (SELECT TOP 1 1 FROM #WMP9000_Errors T3 WITH(NOLOCK) WHERE T1.APKMaster = T3.APK)

		DELETE T1
		FROM AT2007 T1 INNER JOIN #WMP9000_AT2006 T2 ON T1.VoucherID IN (SELECT TOP 1 VoucherID FROM AT2006 WHERE APK = T2.APK)
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #WMP9000_Errors T3 WITH(NOLOCK) WHERE T1.VoucherID = (SELECT TOP 1 VoucherID FROM AT2006 WHERE APK = T3.APK))

		DELETE T1
		FROM AT2006 T1 INNER JOIN #WMP9000_AT2006 T2 ON T1.APK = T2.APK
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #WMP9000_Errors T3 WITH(NOLOCK) WHERE T1.APK = T3.APK)

		--DELETE T1 
		--FROM WMT9009 T1 INNER JOIN #WMP9000_AT2006 T2 ON T1.APKMaster = T2.APK		
		--WHERE NOT EXISTS (SELECT TOP 1 1 FROM #WMP9000_Errors T3 WITH(NOLOCK) WHERE T1.APKMaster = T3.APK)

		--DELETE T1 
		--FROM WMT9008 T1 INNER JOIN #WMP9000_AT2006 T2 ON T1.APKMaster = T2.APK		
		--WHERE NOT EXISTS (SELECT TOP 1 1 FROM #WMP9000_Errors T3 WITH(NOLOCK) WHERE T1.APKMaster = T3.APK)
								
		SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
					SELECT '', '' + VoucherNo 
					FROM #WMP9000_Errors T2 WITH(NOLOCK) 
					WHERE  T1.APK = T2.APK
					FOR XML PATH ('''')), 1, 1, ''''
					) AS Params, '''+@FormID+''' AS FormID
		FROM #WMP9000_Errors T1
		ORDER BY MessageID
		'
	END
END
ELSE
IF @FormID IN ('WMF2230', 'WMF2232') --Chuyển kho  
BEGIN
	IF @Mode = 0 ---Sửa
	BEGIN
		SET @sSQL = '
		DECLARE @Status TINYINT,
				@MessageID NVARCHAR(1000),
				@DelDivisionID VARCHAR(50),
				@DelVoucherNo VARCHAR(50),
				@ImDivisionID VARCHAR(50),
				@IsTransferDivision TINYINT,
				@DelTranMonth INT, 
				@DelTranYear INT,  
				@Params VARCHAR(MAX) = ''''

		SELECT @DelDivisionID = DivisionID, @DelVoucherNo = VoucherNo, @IsTransferDivision = IsTransferDivision, @ImDivisionID = ImDivisionID, @DelTranMonth = TranMonth, @DelTranYear = TranYear
		FROM WT0095 WITH (NOLOCK)
		WHERE APK = '''+@APK+'''

		IF @DelDivisionID <> '''+@DivisionID+''' -- Kiểm tra khác đơn vị
		BEGIN
			SET @Params = @DelVoucherNo
			SET @MessageID = ''00ML000050''
			Goto EndMess
		END
		
		IF @DelTranMonth+@DelTranYear*100 <> '+STR(@TranMonth+@TranYear*100)+' -- Kiểm tra khác kỳ kế toán
		BEGIN
			SET @Params = @DelVoucherNo
			SET @MessageID = ''00ML000137''
			Goto EndMess
		END
		
		IF EXISTS (SELECT top 1 1 FROM WT0095 T1 INNER JOIN WT9999 T2 ON T1.DivisionID=T2.DivisionID AND T1.TranMonth=T2.TranMonth AND T1.TranYear=T2.TranYear
							WHERE T1.APK= '''+@APK+''' AND T1.KindVoucherID=3 AND T2.Closing = 1) -- Kiểm tra kỳ kế toán đã đóng thì không cho sửa
		BEGIN
			SET @Params = @DelVoucherNo
			SET @MessageID = ''WMFML000053''
			Goto EndMess
		END

		--IF EXISTS (SELECT TOP 1 1 
		--			FROM WT0096 WITH(NOLOCK) 
		--			WHERE WT0096.DivisionID = @DelDivisionID AND WT0096.InheritAPKMaster = '''+@APK+''') ---Kiểm tra đã được kế thừa xuất kho
		--BEGIN
		--	SET @Params = @DelVoucherNo
		--	SET @MessageID = ''WMFML000008''
		--	Goto EndMess
		--END

		EndMess:
		SELECT 2 AS Status, @MessageID AS MessageID, LEFT(@Params, LEN(@Params) -1) AS Params, '''+@FormID+''' AS FormID 
		WHERE ISNULL(@Params, '''') <> ''''
		'
	END
	ELSE
	IF @Mode = 1 ---Xóa
	BEGIN
		SET @sSQL = N'
		CREATE TABLE #WMP9000_Errors (VoucherNo Varchar(50), APK Varchar(50), MessageID Varchar(50))		

		SELECT APK, DivisionID, VoucherNo, TranMonth, TranYear
		INTO #WMP9000_WT0095
		FROM AT2006 WITH (NOLOCK) WHERE APK IN ('''+@APKList+''')

		IF EXISTS (SELECT TOP 1 1 FROM #WMP9000_WT0095 WHERE DivisionID <> '''+@DivisionID+''')
		BEGIN 
			INSERT INTO #WMP9000_Errors (VoucherNo, APK, MessageID)
			SELECT 	VoucherNo, APK, ''00ML000050''
			FROM #WMP9000_WT0095
			WHERE DivisionID <> '''+@DivisionID+'''
		END
		ELSE
		IF EXISTS (SELECT TOP 1 1 FROM #WMP9000_WT0095 WHERE TranMonth+TranYear*100 <> '+STR(@TranMonth+@TranYear*100)+')
		BEGIN 
			INSERT INTO #WMP9000_Errors (VoucherNo, APK, MessageID)
			SELECT 	VoucherNo, APK, ''00ML000137''
			FROM #WMP9000_WT0095
			WHERE TranMonth+TranYear*100 <> '+STR(@TranMonth+@TranYear*100)+'
		END
		--ELSE
		--IF EXISTS (SELECT top 1 1 FROM #WMP9000_WT0095 T1 INNER JOIN WT9999 T2 ON T1.DivisionID=T2.DivisionID AND T1.TranMonth=T2.TranMonth AND T1.TranYear=T2.TranYear
		--					AND T2.Closing = 1) -- Kiểm tra kỳ kế toán đã đóng thì không cho xóa		
		--BEGIN
		--	INSERT INTO #WMP9000_Errors (VoucherNo, APK, MessageID)
		--	SELECT 	T1.VoucherNo, T1.APK, ''WMFML000053''
		--	FROM #WMP9000_WMT2006 T1 WITH(NOLOCK) INNER JOIN WT9999 T2 ON T1.DivisionID=T2.DivisionID AND T1.TranMonth=T2.TranMonth AND T1.TranYear=T2.TranYear AND T2.Closing = 1					
		--END
		--ELSE
		--IF EXISTS (	SELECT TOP 1 1 
		--			FROM WMT2007 WITH(NOLOCK) 
		--			INNER JOIN #WMP9000_WMT2006 ON WMT2007.DivisionID = #WMP9000_WMT2006.DivisionID AND WMT2007.InheritAPKMaster = #WMP9000_WMT2006.APK) ---Kiểm tra đã được kế thừa chưa
		--BEGIN
		--	INSERT INTO #WMP9000_Errors (VoucherNo, APK, MessageID)
		--	SELECT 	T1.VoucherNo, T1.APK, ''WMFML000008''
		--	FROM #WMP9000_WMT2006 T1 
		--	INNER JOIN WMT2007 T2 WITH(NOLOCK)  ON T2.DivisionID = T1.DivisionID AND T2.InheritAPKMaster = T1.APK									
		--END
			
		-- CHECK SERIAL TRONG PHIẾU VCNB ĐÃ ĐƯỢC XUẤT HAY CHƯA
		--SELECT '''+@DivisionID+''' as DivisionID, T1.APK, T1.VoucherDate, T1.ImWarehouseID, T2.InventoryID, T2.ActualQuantity, T4.IsSerialized --, T3.SerialNo, T3.LocationID
		--INTO #TAM
		--FROM WMT2006 T1 INNER JOIN WMT2007 T2 ON T1.APK = T2.APKMaster and T1.DivisionID = T2.DivisionID
		--				--INNER JOIN WMT2008 T3 ON T1.APK = T3.APKMaster and T3.APKDetail = T2.APK and T1.DivisionID=T3.DivisionID
		--				INNER JOIN AT1302 T4 ON T2.InventoryID = T4.InventoryID and T1.DivisionID = T4.DivisionID
		--WHERE T1.DivisionID='''+@DivisionID+''' AND T1.APK IN ('''+@APKList+''')

		--IF EXISTS (SELECT TOP 1 1 FROM #TAM WHERE IsSerialized=1)
		--BEGIN
		--	-- check serial có nằm trong ds xuất hay ko
		--	INSERT INTO #WMP9000_Errors (VoucherNo, APK, MessageID)
		--	SELECT 	VoucherNo, APK, ''WFMF000175''
		--	FROM #WMP9000_WMT2006
		--	WHERE APK IN (SELECT APK FROM #TAM 
		--					WHERE SerialNo in (
		--										SELECT DISTINCT SerialNo
		--										FROM WMT2008 T1 INNER JOIN WMT2006 T2 ON T1.APKMaster=T2.APK
		--										WHERE T2.KindVoucherID = 2 AND SerialNo IS NOT NULL
		--										)
		--					)
		--	OR EXISTS (select top 1 1 from wmt2007 where apkmaster in ('''+@APKList+''') and ERP8VoucherID is not null)

		--	DELETE T1 FROM #TAM T1 INNER JOIN #WMP9000_Errors T2 ON T1.APK=T2.APK
		--END

		--DELETE T1 
		--FROM WMT2008 T1 INNER JOIN #WMP9000_WMT2006 T2 ON T1.APKMaster = T2.APK		
		--WHERE NOT EXISTS (SELECT TOP 1 1 FROM #WMP9000_Errors T3 WITH(NOLOCK) WHERE T1.APKMaster = T3.APK)

		DELETE T1
		FROM AT2007 T1 INNER JOIN #WMP9000_WT0095 T2 ON T1.VoucherID IN (SELECT TOP 1 VoucherID FROM AT2006 WHERE APK = T2.APK)
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #WMP9000_Errors T3 WITH(NOLOCK) WHERE T1.VoucherID = (SELECT TOP 1 VoucherID FROM AT2006 WHERE APK = T3.APK))

		DELETE T1 
		FROM AT2006 T1 INNER JOIN #WMP9000_WT0095 T2 ON T1.APK = T2.APK
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #WMP9000_Errors T3 WITH(NOLOCK) WHERE T1.APK = T3.APK)

		--DELETE T1 
		--FROM WMT9009 T1 INNER JOIN #WMP9000_WMT2006 T2 ON T1.APKMaster = T2.APK		
		--WHERE NOT EXISTS (SELECT TOP 1 1 FROM #WMP9000_Errors T3 WITH(NOLOCK) WHERE T1.APKMaster = T3.APK)

		--DELETE T1 
		--FROM WMT9008 T1 INNER JOIN #WMP9000_WMT2006 T2 ON T1.APKMaster = T2.APK		
		--WHERE NOT EXISTS (SELECT TOP 1 1 FROM #WMP9000_Errors T3 WITH(NOLOCK) WHERE T1.APKMaster = T3.APK)
								
		SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
					SELECT '', '' + VoucherNo 
					FROM #WMP9000_Errors T2 WITH(NOLOCK) 
					WHERE  T1.APK = T2.APK
					FOR XML PATH ('''')), 1, 1, ''''
					) AS Params, '''+@FormID+''' AS FormID
		FROM #WMP9000_Errors T1
		ORDER BY MessageID
		'
	END
END
ELSE
IF @FormID IN ('WMF2050','WMF2052') --Kiểm kê
BEGIN
	IF @Mode = 0 ---Sửa
	BEGIN
		SET @sSQL = '
		DECLARE @Status TINYINT,
				@MessageID NVARCHAR(1000),
				@DelDivisionID VARCHAR(50),
				@DelVoucherNo VARCHAR(50), 
				@DelTranMonth INT, 
				@DelTranYear INT,  
				@Params VARCHAR(MAX) = ''''

		SELECT @DelDivisionID = DivisionID, @DelVoucherNo = VoucherNo, @DelTranMonth = TranMonth, @DelTranYear = TranYear
		FROM WMT2036 WITH (NOLOCK)
		WHERE APK = '''+@APK+'''

		IF @DelDivisionID <> '''+@DivisionID+''' -- Kiểm tra khác đơn vị
		BEGIN
			SET @Params = @DelVoucherNo
			SET @MessageID = ''00ML000050''
			Goto EndMess
		END

		IF @DelTranMonth+@DelTranYear*100 <> '+STR(@TranMonth+@TranYear*100)+' -- Kiểm tra khác kỳ kế toán
		BEGIN
			SET @Params = @DelVoucherNo
			SET @MessageID = ''00ML000137''
			Goto EndMess
		END

		IF EXISTS (SELECT top 1 1 FROM WMT2036 T1 INNER JOIN WT9999 T2 ON T1.DivisionID=T2.DivisionID AND T1.TranMonth=T2.TranMonth AND T1.TranYear=T2.TranYear
							WHERE T1.APK= '''+@APK+''' AND T2.Closing = 1) -- Kiểm tra kỳ kế toán đã đóng thì không cho sửa
		BEGIN
			SET @Params = @DelVoucherNo
			SET @MessageID = ''WMFML000053''
			Goto EndMess
		END

		IF NOT EXISTS (	 SELECT TOP 1 1 FROM WMT2037 WITH(NOLOCK) 
						 WHERE WMT2037.APKMaster = '''+@APK+'''  AND WMT2037.IsAdjust = 0 
					 ) ---Kiem tra da duoc ke thua tao phieu dieu chinh o tat ca cac dong mat hang có dieu chinh sl/ tien
		BEGIN
			SET @Params = @DelVoucherNo
			SET @MessageID = ''00ML000052''
			Goto EndMess
		END

		EndMess:
		SELECT 2 AS Status, @MessageID AS MessageID, LEFT(@Params, LEN(@Params) -1) AS Params, '''+@FormID+''' AS FormID 
		WHERE ISNULL(@Params, '''') <> ''''
		'
	END
	ELSE
	IF @Mode = 1 ---Xóa
	BEGIN
		SET @sSQL = N'
		
		CREATE TABLE #WMP9000_Errors (VoucherNo Varchar(50), APK Varchar(50), MessageID Varchar(50))		

		SELECT APK, DivisionID, VoucherNo, TranMonth, TranYear
		INTO #WMP9000_WMT2036
		FROM WMT2036 WITH (NOLOCK) WHERE APK IN ('''+@APKList+''')
		
		IF EXISTS (SELECT TOP 1 1 FROM #WMP9000_WMT2036 WHERE DivisionID <> '''+@DivisionID+''')
		BEGIN 
			INSERT INTO #WMP9000_Errors (VoucherNo, APK, MessageID)
			SELECT 	VoucherNo, APK, ''00ML000050''
			FROM #WMP9000_WMT2036
			WHERE DivisionID <> '''+@DivisionID+'''

		END
		ELSE
		IF EXISTS (SELECT TOP 1 1 FROM #WMP9000_WMT2036 WHERE TranMonth+TranYear*100 <> '+STR(@TranMonth+@TranYear*100)+')
		BEGIN 
			INSERT INTO #WMP9000_Errors (VoucherNo, APK, MessageID)
			SELECT 	VoucherNo, APK, ''00ML000137''
			FROM #WMP9000_WMT2036
			WHERE TranMonth+TranYear*100 <> '+STR(@TranMonth+@TranYear*100)+'
		END
		ELSE
		IF EXISTS (SELECT top 1 1 FROM #WMP9000_WMT2036 T1 INNER JOIN WT9999 T2 ON T1.DivisionID=T2.DivisionID AND T1.TranMonth=T2.TranMonth AND T1.TranYear=T2.TranYear
							AND T2.Closing = 1) -- Kiểm tra kỳ kế toán đã đóng thì không cho xóa		
		BEGIN
			INSERT INTO #WMP9000_Errors (VoucherNo, APK, MessageID)
			SELECT 	T1.VoucherNo, T1.APK, ''WMFML000053''
			FROM #WMP9000_WMT2036 T1 WITH(NOLOCK) INNER JOIN WT9999 T2 ON T1.DivisionID=T2.DivisionID AND T1.TranMonth=T2.TranMonth AND T1.TranYear=T2.TranYear AND T2.Closing = 1					
		END
		ELSE
		IF EXISTS (	SELECT TOP 1 1 
					FROM WMT2037 WITH(NOLOCK) 
					INNER JOIN #WMP9000_WMT2036 ON WMT2037.DivisionID = #WMP9000_WMT2036.DivisionID AND WMT2037.APKMaster = #WMP9000_WMT2036.APK
					WHERE  WMT2037.IsAdjust = 1 					
					 ) ---Kiem tra da duoc ke thua tao phieu dieu chinh
		BEGIN
			INSERT INTO #WMP9000_Errors (VoucherNo, APK, MessageID)
			SELECT 	#WMP9000_WMT2036.VoucherNo, #WMP9000_WMT2036.APK, ''00ML000052''
			FROM WMT2037 WITH(NOLOCK) 
			INNER JOIN #WMP9000_WMT2036 ON WMT2037.DivisionID = #WMP9000_WMT2036.DivisionID AND WMT2037.APKMaster = #WMP9000_WMT2036.APK
			WHERE  WMT2037.IsAdjust = 1 										
		END
		
		DELETE T1 
		FROM WMT2038 T1 INNER JOIN #WMP9000_WMT2036 T2 ON T1.APKMaster = T2.APK		
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #WMP9000_Errors T3 WITH(NOLOCK) 
						WHERE T1.APKMaster = T3.APK)

		DELETE T1 
		FROM WMT2037 T1 INNER JOIN #WMP9000_WMT2036 T2 ON T1.APKMaster = T2.APK		
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #WMP9000_Errors T3 WITH(NOLOCK) 
						WHERE T1.APKMaster = T3.APK)

		DELETE T1 
		FROM WMT2036 T1 INNER JOIN #WMP9000_WMT2036 T2 ON T1.APK = T2.APK		
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #WMP9000_Errors T3 WITH(NOLOCK) 
						WHERE T1.APK = T3.APK)

		--DELETE T1 
		--FROM WMT9009 T1 INNER JOIN #WMP9000_WMT2036 T2 ON T1.APKMaster = T2.APK		
		--WHERE NOT EXISTS (SELECT TOP 1 1 FROM #WMP9000_Errors T3 WITH(NOLOCK) 
		--				WHERE T1.APKMaster = T3.APK)
								
		SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
					SELECT '', '' + VoucherNo 
					FROM #WMP9000_Errors T2 WITH(NOLOCK) 
					WHERE  T1.APK = T2.APK
					FOR XML PATH ('''')), 1, 1, ''''
					) AS Params, '''+@FormID+''' AS FormID
		FROM #WMP9000_Errors T1
		ORDER BY MessageID

		'
	END
END
IF @FormID IN ('WMF2060','WMF2062') --Tháo dỡ
BEGIN
	IF @Mode = 0 ---Sửa
	BEGIN
		SET @sSQL = '
		DECLARE @Status TINYINT,
				@MessageID NVARCHAR(1000),
				@DelDivisionID VARCHAR(50),
				@DelVoucherNo VARCHAR(50), 
				@DelTranMonth INT, 
				@DelTranYear INT,  
				@Params VARCHAR(MAX) = ''''

		SELECT @DelDivisionID = DivisionID, @DelVoucherNo = VoucherNo, @DelTranMonth = TranMonth, @DelTranYear = TranYear
		FROM WMT2060 WITH (NOLOCK)
		WHERE APK = '''+@APK+'''

		IF @DelDivisionID <> '''+@DivisionID+''' -- Kiểm tra khác đơn vị
		BEGIN
			SET @Params = @DelVoucherNo
			SET @MessageID = ''00ML000050''
			Goto EndMess
		END

		IF @DelTranMonth+@DelTranYear*100 <> '+STR(@TranMonth+@TranYear*100)+' -- Kiểm tra khác kỳ kế toán
		BEGIN
			SET @Params = @DelVoucherNo
			SET @MessageID = ''00ML000137''
			Goto EndMess
		END

		IF EXISTS (SELECT top 1 1 FROM WMT2060 T1 INNER JOIN WT9999 T2 ON T1.DivisionID=T2.DivisionID AND T1.TranMonth=T2.TranMonth AND T1.TranYear=T2.TranYear
							WHERE T1.APK= '''+@APK+''' AND T2.Closing = 1) -- Kiểm tra kỳ kế toán đã đóng thì không cho sửa
		BEGIN
			SET @Params = @DelVoucherNo
			SET @MessageID = ''WMFML000053''
			Goto EndMess
		END
		
		IF EXISTS (SELECT TOP 1 1 FROM WMT2006 T1 WITH (NOLOCK) INNER JOIN WMT2007 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.APK = T2.APKMaster
		   WHERE T1.DivisionID = '''+@DivisionID+''' AND T2.InheritTableID = ''WMT2060'' AND T2.InheritAPKMaster = '''+@APK+''' AND T1.KindVoucherID = 1) ---Kiem tra da duoc ke thua tao phieu nhap chua
		BEGIN
			SET @Params = @DelVoucherNo
			SET @MessageID = ''00ML000052''
			Goto EndMess
		END

		EndMess:
		SELECT 2 AS Status, @MessageID AS MessageID, LEFT(@Params, LEN(@Params) -1) AS Params, '''+@FormID+''' AS FormID 
		WHERE ISNULL(@Params, '''') <> ''''
		'
	END
	ELSE
	IF @Mode = 1 ---Xóa
	BEGIN

		SET @sSQL = N'		
		CREATE TABLE #WMP9000_Errors (VoucherNo Varchar(50), APK Varchar(50), MessageID Varchar(50))		

		SELECT APK, DivisionID, VoucherNo, TranMonth, TranYear
		INTO #WMP9000_WMT2060
		FROM WMT2060 WITH (NOLOCK) WHERE APK IN ('''+@APKList+''')
		
		IF EXISTS (SELECT TOP 1 1 FROM #WMP9000_WMT2060 WHERE DivisionID <> '''+@DivisionID+''')
		BEGIN 
			INSERT INTO #WMP9000_Errors (VoucherNo, APK, MessageID)
			SELECT 	VoucherNo, APK, ''00ML000050''
			FROM #WMP9000_WMT2060
			WHERE DivisionID <> '''+@DivisionID+'''

		END
		ELSE
		IF EXISTS (SELECT TOP 1 1 FROM #WMP9000_WMT2060 WHERE TranMonth+TranYear*100 <> '+STR(@TranMonth+@TranYear*100)+')
		BEGIN 
			INSERT INTO #WMP9000_Errors (VoucherNo, APK, MessageID)
			SELECT 	VoucherNo, APK, ''00ML000137''
			FROM #WMP9000_WMT2060
			WHERE TranMonth+TranYear*100 <> '+STR(@TranMonth+@TranYear*100)+'
		END
		ELSE
		IF EXISTS (SELECT top 1 1 FROM #WMP9000_WMT2060 T1 INNER JOIN WT9999 T2 ON T1.DivisionID=T2.DivisionID AND T1.TranMonth=T2.TranMonth AND T1.TranYear=T2.TranYear
							AND T2.Closing = 1) -- Kiểm tra kỳ kế toán đã đóng thì không cho xóa		
		BEGIN
			INSERT INTO #WMP9000_Errors (VoucherNo, APK, MessageID)
			SELECT 	T1.VoucherNo, T1.APK, ''WMFML000053''
			FROM #WMP9000_WMT2060 T1 WITH(NOLOCK) INNER JOIN WT9999 T2 ON T1.DivisionID=T2.DivisionID AND T1.TranMonth=T2.TranMonth AND T1.TranYear=T2.TranYear AND T2.Closing = 1					
		END
		ELSE
		IF EXISTS (SELECT TOP 1 1 FROM WMT2006 T1 WITH (NOLOCK) INNER JOIN WMT2007 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.APK = T2.APKMaster
					INNER JOIN #WMP9000_WMT2060 T3 ON T1.DivisionID = T3.DivisionID AND T2.InheritAPKMaster = T3.APK
					WHERE T1.DivisionID = '''+@DivisionID+''' AND T2.InheritTableID = ''WMT2060'' AND T1.KindVoucherID = 1)
		BEGIN
			INSERT INTO #WMP9000_Errors (VoucherNo, APK, MessageID)
			SELECT 	VoucherNo, APK, ''00ML000137''
			FROM #WMP9000_WMT2060 Temp1
			INNER JOIN (SELECT DISTINCT T2.InheritAPKMaster, T1.DivisionID FROM WMT2006 T1 WITH (NOLOCK) INNER JOIN WMT2007 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.APK = T2.APKMaster
						WHERE T1.DivisionID = '''+@DivisionID+''' AND T2.InheritTableID = ''WMT2060'' AND T1.KindVoucherID = 1) Temp2
			ON Temp1.DivisionID = Temp2.DivisionID AND Temp2.InheritAPKMaster = Temp1.APK
		END
		
		SELECT DISTINCT T27.DivisionID, T27.APKMaster 
		INTO #Temp
		FROM WMT2007 T27 INNER JOIN #WMP9000_WMT2060 Temp ON T27.DivisionID = Temp.DivisionID AND T27.InheritAPKMaster = Temp.APK AND T27.InheritTableID = ''WMT2060''

		---Xoa phieu nhap, xuat
		--DELETE T1
		--FROM WMT2008 T1
		--INNER JOIN #Temp T2 ON T1.DivisionID = T2.DivisionID AND T1.APKMaster = T2.APKMaster
		
		DELETE T1
		FROM WMT2007 T1
		INNER JOIN #Temp T2 ON T1.DivisionID = T2.DivisionID AND T1.APKMaster = T2.APKMaster

		DELETE T1
		FROM WMT2006 T1
		INNER JOIN #Temp T2 ON T1.DivisionID = T2.DivisionID AND T1.APK = T2.APKMaster
		
		---Xoa phieu thao do
		DELETE T1 
		FROM WMT2062 T1 INNER JOIN #WMP9000_WMT2060 T2 ON T1.APKMaster = T2.APK		
		
		DELETE T1 
		FROM WMT2061 T1 INNER JOIN #WMP9000_WMT2060 T2 ON T1.APKMaster = T2.APK	

		DELETE T1 
		FROM WMT2060 T1 INNER JOIN #WMP9000_WMT2060 T2 ON T1.APK = T2.APK	

		--DELETE T1 
		--FROM WMT9009 T1 INNER JOIN #WMP9000_WMT2060 T2 ON T1.APKMaster = T2.APK	

		--DELETE T1 
		--FROM WMT9008 T1 INNER JOIN #WMP9000_WMT2060 T2 ON T1.APKMaster = T2.APK	
								
		SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
					SELECT '', '' + VoucherNo 
					FROM #WMP9000_Errors T2 WITH(NOLOCK) 
					WHERE  T1.APK = T2.APK
					FOR XML PATH ('''')), 1, 1, ''''
					) AS Params, '''+@FormID+''' AS FormID
		FROM #WMP9000_Errors T1
		ORDER BY MessageID

		'
	END
END
--IF @FormID IN ('WMF2080','WMF2082','WMF2090','WMF2092','WMF2100','WMF2102') --Phiếu yêu cầu nhập, xuất, VCNB
IF @FormID IN ('WMF2000','WMF2001','WMF2005','WMF2006','WMF2040','WMF2042') --Phiếu yêu cầu nhập, xuất, VCNB
BEGIN
	IF @Mode = 0 ---Sửa
	BEGIN
		SET @sSQL = '
		DECLARE @Status TINYINT,
				@MessageID NVARCHAR(1000),
				@DelDivisionID VARCHAR(50),
				@DelVoucherNo VARCHAR(50),
				@ImDivisionID VARCHAR(50),
				@IsTransferDivision TINYINT,
				@DelTranMonth INT, 
				@DelTranYear INT,  
				@Params VARCHAR(MAX) = ''''

		SELECT @DelDivisionID = DivisionID, @DelVoucherNo = VoucherNo, @DelTranMonth = TranMonth, @DelTranYear = TranYear
		FROM WT0095 WITH (NOLOCK)
		WHERE APK = '''+@APK+'''

		IF @DelDivisionID <> '''+@DivisionID+''' -- Kiểm tra khác đơn vị
		BEGIN
			SET @Params = @DelVoucherNo
			SET @MessageID = ''00ML000050''
			Goto EndMess
		END
		
		IF @DelTranMonth+@DelTranYear*100 <> '+STR(@TranMonth+@TranYear*100)+' -- Kiểm tra khác kỳ kế toán
		BEGIN
			SET @Params = @DelVoucherNo
			SET @MessageID = ''00ML000137''
			Goto EndMess
		END
		
		IF EXISTS (SELECT top 1 1 FROM WMT2080 T1 INNER JOIN WT9999 T2 ON T1.DivisionID=T2.DivisionID AND T1.TranMonth=T2.TranMonth AND T1.TranYear=T2.TranYear
							WHERE T1.APK= '''+@APK+''' AND T2.Closing = 1) -- Kiểm tra kỳ kế toán đã đóng thì không cho sửa
		BEGIN
			SET @Params = @DelVoucherNo
			SET @MessageID = ''WMFML000053''
			Goto EndMess
		END
		
		IF EXISTS (SELECT TOP 1 1 
					FROM WT0095 WITH(NOLOCK) 
					WHERE DivisionID = @DelDivisionID AND APK = '''+@APK+''' AND IsCheck=1) ---Kiểm tra đã được duyệt
		BEGIN
			SET @Params = @DelVoucherNo
			SET @MessageID = ''WFML000158''
			Goto EndMess
		END

		IF EXISTS (SELECT TOP 1 1 
					FROM WMT2080 WITH(NOLOCK) 
					WHERE DivisionID = @DelDivisionID AND APK = '''+@APK+''' AND IsCheck=1) ---Kiểm tra đã được duyệt
		BEGIN
			SET @Params = @DelVoucherNo
			SET @MessageID = ''WFML000158''
			Goto EndMess
		END

		IF EXISTS (SELECT TOP 1 1 
					FROM WMT2007 WITH(NOLOCK) 
					WHERE WMT2007.DivisionID = @DelDivisionID AND WMT2007.InheritAPKMaster = '''+@APK+''') ---Kiểm tra đã được kế thừa nhập, xuất, VCNB
		BEGIN
			SET @Params = @DelVoucherNo
			SET @MessageID = ''WFML000158''
			Goto EndMess
		END

		EndMess:
		SELECT 2 AS Status, @MessageID AS MessageID, LEFT(@Params, LEN(@Params) -1) AS Params, '''+@FormID+''' AS FormID 
		WHERE ISNULL(@Params, '''') <> ''''
		'
	END
	ELSE
	IF @Mode = 1 ---Xóa
	BEGIN
		SET @sSQL = N'
		CREATE TABLE #WMP9000_Errors (VoucherNo Varchar(50), APK Varchar(50), MessageID Varchar(50))		

		SELECT APK, DivisionID, VoucherNo, TranMonth, TranYear, APKMaster_9000
		INTO #WMP9000_WMT2080
		FROM WT0095 WITH (NOLOCK) WHERE VoucherID IN ('''+@APKList+''')

		IF EXISTS (SELECT TOP 1 1 FROM #WMP9000_WMT2080 WHERE DivisionID <> '''+@DivisionID+''')
		BEGIN 
			INSERT INTO #WMP9000_Errors (VoucherNo, APK, MessageID)
			SELECT 	VoucherNo, APK, ''00ML000050''
			FROM #WMP9000_WMT2080
			WHERE DivisionID <> '''+@DivisionID+'''
		END
		ELSE
		IF EXISTS (SELECT TOP 1 1 FROM #WMP9000_WMT2080 WHERE TranMonth+TranYear*100 <> '+STR(@TranMonth+@TranYear*100)+')
		BEGIN 
			INSERT INTO #WMP9000_Errors (VoucherNo, APK, MessageID)
			SELECT 	VoucherNo, APK, ''00ML000137''
			FROM #WMP9000_WMT2080
			WHERE TranMonth+TranYear*100 <> '+STR(@TranMonth+@TranYear*100)+'
		END
		--ELSE
		--IF EXISTS (SELECT top 1 1 FROM #WMP9000_WMT2080 T1 INNER JOIN WT9999 T2 ON T1.DivisionID=T2.DivisionID AND T1.TranMonth=T2.TranMonth AND T1.TranYear=T2.TranYear
		--					AND T2.Closing = 1) -- Kiểm tra kỳ kế toán đã đóng thì không cho xóa		
		--BEGIN
		--	INSERT INTO #WMP9000_Errors (VoucherNo, APK, MessageID)
		--	SELECT 	T1.VoucherNo, T1.APK, ''WMFML000053''
		--	FROM #WMP9000_WMT2080 T1 WITH(NOLOCK) INNER JOIN WT9999 T2 ON T1.DivisionID=T2.DivisionID AND T1.TranMonth=T2.TranMonth AND T1.TranYear=T2.TranYear AND T2.Closing = 1					
		--END
		
		ELSE
		IF EXISTS (SELECT TOP 1 1 
			FROM WT0095 WITH(NOLOCK) 
			WHERE DivisionID = '''+@DivisionID+''' AND APK IN ('''+@APKList+''') AND IsCheck=1) ---Kiểm tra đã được duyệt
		BEGIN
			INSERT INTO #WMP9000_Errors (VoucherNo, APK, MessageID)
			SELECT 	T1.VoucherNo, T1.APK, ''WFML000158''
			FROM #WMP9000_WMT2080 T1 INNER JOIN WT0095 T2 WITH(NOLOCK)  ON T2.DivisionID = T1.DivisionID AND T2.APK = T1.APK	
			WHERE T1.APK IN ('''+@APKList+''')	AND T2.IsCheck=1			
		END

		ELSE
		IF EXISTS (SELECT TOP 1 1 
			FROM WT0095 WITH(NOLOCK) 
			WHERE DivisionID = '''+@DivisionID+''' AND VoucherID IN ('''+@APKList+''') AND IsCheck=1) ---Kiểm tra đã được duyệt
		BEGIN
			INSERT INTO #WMP9000_Errors (VoucherNo, APK, MessageID)
			SELECT 	T1.VoucherNo, T1.APK, ''WFML000158''
			FROM #WMP9000_WMT2080 T1 INNER JOIN WMT2080 T2 WITH(NOLOCK)  ON T2.DivisionID = T1.DivisionID AND T2.APK = T1.APK	
			WHERE T1.APK IN ('''+@APKList+''')	AND T2.IsCheck=1			
		END
		ELSE
		IF EXISTS (	SELECT TOP 1 1 
					FROM WMT2007 WITH(NOLOCK) 
					INNER JOIN #WMP9000_WMT2080 ON WMT2007.DivisionID = #WMP9000_WMT2080.DivisionID AND WMT2007.InheritAPKMaster = #WMP9000_WMT2080.APK) ---Kiểm tra đã được kế thừa chưa
		BEGIN
			INSERT INTO #WMP9000_Errors (VoucherNo, APK, MessageID)
			SELECT 	T1.VoucherNo, T1.APK, ''WFML000158''
			FROM #WMP9000_WMT2080 T1 
			INNER JOIN WMT2007 T2 WITH(NOLOCK)  ON T2.DivisionID = T1.DivisionID AND T2.InheritAPKMaster = T1.APK									
		END

		IF (SELECT CustomerName FROM CustomerIndex) = 166 -- Xóa tiến độ giao hàng được sinh tự động từ phiếu YCXK tương ứng
		BEGIN
			SELECT DISTINCT W96.APK, O03.InheritTransactionID, O03.SOrderID
			INTO #WMP9000_OT2002
			FROM WT0096 W96
			INNER JOIN OT2003_MT O03 WITH (NOLOCK) ON O03.DInheritVoucherID = W96.APK
			INNER JOIN WT0095 W95 WITH (NOLOCK) ON W95.VoucherID = W96.VoucherID
			INNER JOIN #WMP9000_WMT2080 T1 ON T1.APK = W95.APK

			DELETE T1
			FROM OT2003_MT T1
			--INNER JOIN WT0096 W96 WITH (NOLOCK) ON W96.APK = T1.DInheritVoucherID
			--INNER JOIN WT0095 W95 WITH (NOLOCK) ON W95.VoucherID = W96.VoucherID
			WHERE T1.DInheritVoucherID IN (SELECT APK FROM #WMP9000_OT2002)

			DELETE T1
			FROM OT2003 T1
			WHERE T1.APK IN (SELECT InheritTransactionID FROM #WMP9000_OT2002)
			--INNER JOIN OT2003_MT T2 WITH (NOLOCK) ON T1.APK = T2.InheritTransactionID
			AND NOT EXISTS (
				SELECT TOP 1 1 
				FROM OT2003_MT T3
				WHERE T1.SOrderID IN (SELECT SOrderID FROM #WMP9000_OT2002)
			)
		END
			
		--DELETE T1 
		--FROM WMT2082 T1 INNER JOIN #WMP9000_WMT2080 T2 ON T1.APKMaster = T2.APK		
		--WHERE NOT EXISTS (SELECT TOP 1 1 FROM #WMP9000_Errors T3 WITH(NOLOCK) WHERE T1.APKMaster = T3.APK)

		DELETE T1 
		FROM WT0096 T1 INNER JOIN #WMP9000_WMT2080 T2 ON T1.VoucherID IN ( SELECT TOP 1 VoucherID FROM WT0096 WHERE APK = T2.APK)	
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #WMP9000_Errors T3 WITH(NOLOCK) WHERE T1.VoucherID = (SELECT TOP 1 VoucherID FROM AT2006 WHERE APK = T3.APK))

		DELETE T1 
		FROM WT0095 T1 INNER JOIN #WMP9000_WMT2080 T2 ON T1.APK = T2.APK		
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #WMP9000_Errors T3 WITH(NOLOCK) WHERE T1.APK = T3.APK)

		DELETE T1
		FROM OOT9000 T1
		WHERE APK IN (SELECT APKMaster_9000 FROM #WMP9000_WMT2080)

		DELETE T1
		FROM OOT9001 T1
		WHERE APKMaster IN (SELECT APKMaster_9000 FROM #WMP9000_WMT2080)


		--DELETE T1 
		--FROM WMT9009 T1 INNER JOIN #WMP9000_WMT2080 T2 ON T1.APKMaster = T2.APK		
		--WHERE NOT EXISTS (SELECT TOP 1 1 FROM #WMP9000_Errors T3 WITH(NOLOCK) WHERE T1.APKMaster = T3.APK)
								
		SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
					SELECT '', '' + VoucherNo 
					FROM #WMP9000_Errors T2 WITH(NOLOCK) 
					WHERE  T1.APK = T2.APK
					FOR XML PATH ('''')), 1, 1, ''''
					) AS Params, '''+@FormID+''' AS FormID
		FROM #WMP9000_Errors T1
		ORDER BY MessageID
		'

	END

END

IF @FormID IN ('WMF2250','WMF2252') --Phiếu điều chỉnh kiểm kê
BEGIN
	IF @Mode = 0 ---Sửa
	BEGIN
		SET @sSQL = '
		DECLARE @Status TINYINT,
				@MessageID NVARCHAR(1000),
				@DelDivisionID VARCHAR(50),
				@DelVoucherNo VARCHAR(50),
				@DelVoucherID VARCHAR(50),
				@ImDivisionID VARCHAR(50),
				@IsTransferDivision TINYINT,
				@DelTranMonth INT, 
				@DelTranYear INT,  
				@Params VARCHAR(MAX) = ''''

		SELECT @DelDivisionID = DivisionID, @DelVoucherNo = VoucherNo, @DelVoucherID = VoucherID, @DelTranMonth = TranMonth, @DelTranYear = TranYear
		FROM AT2006 WITH (NOLOCK)
		WHERE APK = '''+@APK+'''

		IF @DelDivisionID <> '''+@DivisionID+''' -- Kiểm tra khác đơn vị
		BEGIN
			SET @Params = @DelVoucherNo
			SET @MessageID = ''00ML000050''
			Goto EndMess
		END
		
		IF @DelTranMonth+@DelTranYear*100 <> '+STR(@TranMonth+@TranYear*100)+' -- Kiểm tra khác kỳ kế toán
		BEGIN
			SET @Params = @DelVoucherNo
			SET @MessageID = ''00ML000137''
			Goto EndMess
		END

		EndMess:
		SELECT 2 AS Status, @MessageID AS MessageID, LEFT(@Params, LEN(@Params) -1) AS Params, '''+@FormID+''' AS FormID 
		WHERE ISNULL(@Params, '''') <> ''''
		'
	END
	ELSE
	IF @Mode = 1 ---Xóa
	BEGIN
		SET @sSQL = N'
		CREATE TABLE #WMP9000_Errors (VoucherNo Varchar(50), APK Varchar(50), MessageID Varchar(50))		

		SELECT APK, DivisionID, VoucherNo, VoucherID, TranMonth, TranYear
		INTO #WMP9000_AT2006
		FROM AT2006 WITH (NOLOCK) WHERE APK IN ('''+@APKList+''')

		IF EXISTS (SELECT TOP 1 1 FROM #WMP9000_AT2006 WHERE DivisionID <> '''+@DivisionID+''')
		BEGIN 
			INSERT INTO #WMP9000_Errors (VoucherNo, APK, MessageID)
			SELECT 	VoucherNo, APK, ''00ML000050''
			FROM #WMP9000_AT2006
			WHERE DivisionID <> '''+@DivisionID+'''
		END
		ELSE
		IF EXISTS (SELECT TOP 1 1 FROM #WMP9000_AT2006 WHERE TranMonth+TranYear*100 <> '+STR(@TranMonth+@TranYear*100)+')
		BEGIN 
			INSERT INTO #WMP9000_Errors (VoucherNo, APK, MessageID)
			SELECT 	VoucherNo, APK, ''00ML000137''
			FROM #WMP9000_AT2006
			WHERE TranMonth+TranYear*100 <> '+STR(@TranMonth+@TranYear*100)+'
		END

		DELETE T1 
		FROM AT2006 T1 INNER JOIN #WMP9000_AT2006 T2 ON T1.APK = T2.APK
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #WMP9000_Errors T3 WITH (NOLOCK) WHERE T1.APK = T3.APK)

		DELETE T1 
		FROM AT2007 T1 INNER JOIN #WMP9000_AT2006 T2 ON T1.VoucherID = T2.VoucherID		
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #WMP9000_Errors T3 WITH (NOLOCK) WHERE T1.APK = T3.APK)
								
		SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
					SELECT '', '' + VoucherNo 
					FROM #WMP9000_Errors T2 WITH (NOLOCK) 
					WHERE  T1.APK = T2.APK
					FOR XML PATH ('''')), 1, 1, ''''
					) AS Params, '''+@FormID+''' AS FormID
		FROM #WMP9000_Errors T1
		ORDER BY MessageID
		'
	END
END

IF @FormID IN ('WMF2280','WMF2282','WMF2290','WMF2292','WMF2300','WMF2302') --Xuất/chuyển kho mã vạch
BEGIN
	IF @Mode = 0 ---Sửa
	BEGIN
		SET @sSQL = '
		DECLARE @Status TINYINT,
				@MessageID NVARCHAR(1000),
				@DelDivisionID VARCHAR(50),
				@DelVoucherNo VARCHAR(50),
				@ImDivisionID VARCHAR(50),
				@IsTransferDivision TINYINT,
				@DelTranMonth INT, 
				@DelTranYear INT,  
				@Params VARCHAR(MAX) = ''''

		SELECT @DelDivisionID = DivisionID, @DelVoucherNo = VoucherNo, @IsTransferDivision = IsTransferDivision, @ImDivisionID = ImDivisionID, @DelTranMonth = TranMonth, @DelTranYear = TranYear
		FROM BT1002 WITH (NOLOCK)
		WHERE APK = '''+@APK+'''

		IF @DelDivisionID <> '''+@DivisionID+''' -- Kiểm tra khác đơn vị
		BEGIN
			SET @Params = @DelVoucherNo
			SET @MessageID = ''00ML000050''
			Goto EndMess
		END
		
		IF @DelTranMonth+@DelTranYear*100 <> '+STR(@TranMonth+@TranYear*100)+' -- Kiểm tra khác kỳ kế toán
		BEGIN
			SET @Params = @DelVoucherNo
			SET @MessageID = ''00ML000137''
			Goto EndMess
		END
		
		IF EXISTS (SELECT top 1 1 FROM AT2006 T1 INNER JOIN WT9999 T2 ON T1.DivisionID=T2.DivisionID AND T1.TranMonth=T2.TranMonth AND T1.TranYear=T2.TranYear
							WHERE T1.APK= '''+@APK+''' AND T1.KindVoucherID=2 AND T2.Closing = 1) -- Kiểm tra kỳ kế toán đã đóng thì không cho sửa
		BEGIN
			SET @Params = @DelVoucherNo
			SET @MessageID = ''WMFML000053''
			Goto EndMess
		END

		IF EXISTS (SELECT TOP 1 1 FROM WMT2080 T1 INNER JOIN WMT2081 T2 ON T1.APK=T2.APKMaster AND T1.DivisionID=T2.DivisionID AND T2.InheritTableID=''AT2006''
													INNER JOIN AT2006 T3 ON T1.DivisionID=T3.ImDivisionID AND T2.InheritAPKMaster=T3.APK
					WHERE T3.DivisionID='''+@DivisionID+''' AND T3.APK='''+@APK+''' AND T1.IsCheck=1) ---Kiem tra YCNK đã được duyệt khi chuyen xuyen don vi
		BEGIN
			SET @Params = @DelVoucherNo
			SET @MessageID = ''WMFML000017''
			Goto EndMess
		END

		EndMess:
		SELECT 2 AS Status, @MessageID AS MessageID, LEFT(@Params, LEN(@Params) -1) AS Params, '''+@FormID+''' AS FormID 
		WHERE ISNULL(@Params, '''') <> ''''
		'
	END
	ELSE
	IF @Mode = 1 ---Xóa
	BEGIN
		SET @sSQL = N'
		CREATE TABLE #WMP9000_Errors (VoucherNo Varchar(50), APK Varchar(50), MessageID Varchar(50))		

		SELECT APK, DivisionID, VoucherNo, TranMonth, TranYear
		INTO #WMP9000_BT1002
		FROM BT1002 WITH (NOLOCK) WHERE APK IN ('''+@APKList+''')

		IF EXISTS (SELECT TOP 1 1 FROM #WMP9000_BT1002 WHERE DivisionID <> '''+@DivisionID+''')
		BEGIN 
			INSERT INTO #WMP9000_Errors (VoucherNo, APK, MessageID)
			SELECT 	VoucherNo, APK, ''00ML000050''
			FROM #WMP9000_BT1002
			WHERE DivisionID <> '''+@DivisionID+'''
		END
		ELSE
		IF EXISTS (SELECT TOP 1 1 FROM #WMP9000_BT1002 WHERE TranMonth+TranYear*100 <> '+CONVERT(varchar(50),@TranMonth+@TranYear*100)+')
		BEGIN 
			INSERT INTO #WMP9000_Errors (VoucherNo, APK, MessageID)
			SELECT 	VoucherNo, APK, ''00ML000137''
			FROM #WMP9000_BT1002
			WHERE TranMonth+TranYear*100 <> '+CONVERT(varchar(50),@TranMonth+@TranYear*100)+'
		END
		
		BEGIN
			INSERT INTO #WMP9000_Errors (VoucherNo, APK, MessageID)
			SELECT 	T3.VoucherNo, T3.APK, ''WMFML000017''
			FROM WMT2080 T1 INNER JOIN WMT2081 T2 ON T1.APK=T2.APKMaster AND T1.DivisionID=T2.DivisionID AND T2.InheritTableID=''AT2006''
									INNER JOIN #WMP9000_BT1002 T3 ON T2.InheritAPKMaster=T3.APK
									INNER JOIN BT1002 T4 ON T3.DivisionID=T4.DivisionID AND T3.APK=T4.APK
			WHERE T4.DivisionID='''+@DivisionID+''' AND T1.IsCheck=1						
		END

		DELETE T1
		FROM BT1002 T1 INNER JOIN #WMP9000_BT1002 T2 ON T1.APK = T2.APK
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #WMP9000_Errors T3 WITH(NOLOCK) WHERE T1.APK = T3.APK)

		SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
					SELECT '', '' + VoucherNo 
					FROM #WMP9000_Errors T2 WITH(NOLOCK) 
					WHERE  T1.APK = T2.APK
					FOR XML PATH ('''')), 1, 1, ''''
					) AS Params, '''+@FormID+''' AS FormID
		FROM #WMP9000_Errors T1
		ORDER BY MessageID
		'
	END
END

IF @FormID IN ('WMF2320','WMF2322','WMF2310','WMF2312') --Phiếu lắp ráp, Phiếu tháo dỡ 
BEGIN
	IF @Mode = 0 ---Sửa
	BEGIN
		SET @sSQL = '
		DECLARE @Status TINYINT,
				@MessageID NVARCHAR(1000),
				@DelDivisionID VARCHAR(50),
				@DelVoucherNo VARCHAR(50),
				@ImDivisionID VARCHAR(50),
				@IsTransferDivision TINYINT,
				@DelTranMonth INT, 
				@DelTranYear INT,  
				@Params VARCHAR(MAX) = ''''

		SELECT @DelDivisionID = DivisionID, @DelVoucherNo = VoucherNo, @IsTransferDivision = IsTransferDivision, @ImDivisionID = ImDivisionID, @DelTranMonth = TranMonth, @DelTranYear = TranYear
		FROM AT0112 WITH (NOLOCK)
		WHERE APK = '''+@APK+'''

		IF @DelDivisionID <> '''+@DivisionID+''' -- Kiểm tra khác đơn vị
		BEGIN
			SET @Params = @DelVoucherNo
			SET @MessageID = ''00ML000050''
			Goto EndMess
		END
		
		IF @DelTranMonth+@DelTranYear*100 <> '+STR(@TranMonth+@TranYear*100)+' -- Kiểm tra khác kỳ kế toán
		BEGIN
			SET @Params = @DelVoucherNo
			SET @MessageID = ''00ML000137''
			Goto EndMess
		END
		
		IF EXISTS (SELECT top 1 1 FROM AT0112 T1 INNER JOIN WT9999 T2 ON T1.DivisionID=T2.DivisionID AND T1.TranMonth=T2.TranMonth AND T1.TranYear=T2.TranYear
							WHERE T1.APK= '''+@APK+''' AND T1.KindVoucherID=2 AND T2.Closing = 1) -- Kiểm tra kỳ kế toán đã đóng thì không cho sửa
		BEGIN
			SET @Params = @DelVoucherNo
			SET @MessageID = ''WMFML000053''
			Goto EndMess
		END

		EndMess:
		SELECT 2 AS Status, @MessageID AS MessageID, LEFT(@Params, LEN(@Params) -1) AS Params, '''+@FormID+''' AS FormID 
		WHERE ISNULL(@Params, '''') <> ''''
		'
	END
	ELSE
	IF @Mode = 1 ---Xóa
	BEGIN
		SET @sSQL = N'
		CREATE TABLE #WMP9000_Errors (VoucherNo Varchar(50), APK Varchar(50), MessageID Varchar(50))		

		SELECT APK, DivisionID, VoucherNo, TranMonth, TranYear
		INTO #WMP9000_AT0112
		FROM AT0112 WITH (NOLOCK) WHERE APK IN ('''+@APKList+''')

		IF EXISTS (SELECT TOP 1 1 FROM #WMP9000_AT0112 WHERE DivisionID <> '''+@DivisionID+''')
		BEGIN 
			INSERT INTO #WMP9000_Errors (VoucherNo, APK, MessageID)
			SELECT 	VoucherNo, APK, ''00ML000050''
			FROM #WMP9000_AT0112
			WHERE DivisionID <> '''+@DivisionID+'''
		END
		ELSE
		IF EXISTS (SELECT TOP 1 1 FROM #WMP9000_AT0112 WHERE TranMonth+TranYear*100 <> '+CONVERT(varchar(50),@TranMonth+@TranYear*100)+')
		BEGIN 
			INSERT INTO #WMP9000_Errors (VoucherNo, APK, MessageID)
			SELECT 	VoucherNo, APK, ''00ML000137''
			FROM #WMP9000_AT0112
			WHERE TranMonth+TranYear*100 <> '+CONVERT(varchar(50),@TranMonth+@TranYear*100)+'
		END
		
		BEGIN
			INSERT INTO #WMP9000_Errors (VoucherNo, APK, MessageID)
			SELECT 	T3.VoucherNo, T3.APK, ''WMFML000017''
			FROM WMT2080 T1 INNER JOIN WMT2081 T2 ON T1.APK=T2.APKMaster AND T1.DivisionID=T2.DivisionID AND T2.InheritTableID=''AT2006''
									INNER JOIN #WMP9000_AT0112 T3 ON T2.InheritAPKMaster=T3.APK
									INNER JOIN AT0112 T4 ON T3.DivisionID=T4.DivisionID AND T3.APK=T4.APK
			WHERE T4.DivisionID='''+@DivisionID+''' AND T1.IsCheck=1						
		END

		DELETE T1
		FROM AT0112 T1 INNER JOIN #WMP9000_AT0112 T2 ON T1.APK = T2.APK
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #WMP9000_Errors T3 WITH(NOLOCK) WHERE T1.APK = T3.APK)

		SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
					SELECT '', '' + VoucherNo 
					FROM #WMP9000_Errors T2 WITH(NOLOCK) 
					WHERE  T1.APK = T2.APK
					FOR XML PATH ('''')), 1, 1, ''''
					) AS Params, '''+@FormID+''' AS FormID
		FROM #WMP9000_Errors T1
		ORDER BY MessageID
		'
	END
END

PRINT(@sSQL)
EXEC (@sSQL)







GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
