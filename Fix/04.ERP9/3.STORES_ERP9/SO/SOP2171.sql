IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP2171]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP2171]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----<Summary>
----Kiểm tra xóa điều phối
----<Param>
---- 
----<Return>
---- 
----<Reference>
----
----<History>
----<Created by>: Kiều Nga, Date: 15/09/2022
---- <Example>
---- exec SOP2171 @DivisionID=N'AS',@TableName=N'SOT2170',@VoucherIDList=N'0690c35d-20ab-47c0-a7c7-294d0dcb0f38',@VoucherID=NULL,@Mode=1

CREATE PROCEDURE SOP2171
		( @DivisionID varchar(50),--Trường hợp @DivisionID đúng với DivisionID đăng nhập thì cho xóa
		  @TranMonth INT,
		  @TranYear INT,
		  @VoucherIDList NVARCHAR(MAX) = '', 
		  @VoucherID VARCHAR(50) = '',
		  @Mode tinyint                 -- 0: Sửa, 1: Xóa, 2: Hủy đơn.
		) 
AS 

DECLARE @sSQL NVARCHAR(MAX)	

IF @Mode = 0 ---Sửa
BEGIN
	SET @sSQL = '
	DECLARE @Status TINYINT,
			@MessageID NVARCHAR(1000),
			@DelDivisionID VARCHAR(50),
			@DelVoucherNo VARCHAR(50), 
			@DelTranMonth INT, 
			@DelTranYear INT,
			@DelStatus INT, 
			@Params VARCHAR(MAX) = ''''

	SELECT @DelDivisionID = DivisionID, @DelVoucherNo = VoucherNo, @DelTranMonth = TranMonth, @DelTranYear = TranYear
	FROM SOT2170 WITH (NOLOCK)
	WHERE APK = '''+@VoucherID+'''

	IF @DelDivisionID <> '''+@DivisionID+''' -- Kiểm tra khác đơn vị
	BEGIN
		SET @Params = @DelVoucherNo
		SET @MessageID = ''00ML000050''
		Goto EndMess
	END
	ELSE 
	IF @DelTranMonth+@DelTranYear*100 <> '+STR(@TranMonth+@TranYear*100)+' -- Kiểm tra khác kỳ kế toán
	BEGIN
		SET @Params = @DelVoucherNo
		SET @MessageID = ''00ML000137''
		Goto EndMess
	END

	EndMess:
	SELECT 2 AS Status, @MessageID AS MessageID, LEFT(@Params, LEN(@Params) -1) AS Params
	WHERE ISNULL(@Params, '''') <> ''''
	'


END
ELSE
IF @Mode = 1 ---Xóa
BEGIN
	SET @sSQL = N'
	
	CREATE TABLE #SOP2171_Errors 
	(
		VoucherNo Varchar(50), 
		APK Varchar(50), 
		MessageID Varchar(50)
	)

	SELECT APK
			, DivisionID
			, VoucherNo
			, TranMonth
			, TranYear
	INTO #SOP2171_SOT2170
	FROM SOT2170 WITH (NOLOCK) WHERE APK IN (''' + @VoucherIDList + ''')
	
	IF EXISTS (SELECT TOP 1 1 FROM #SOP2171_SOT2170 WHERE DivisionID <> ''' + @DivisionID + ''')
	BEGIN 
		INSERT INTO #SOP2171_Errors (VoucherNo, APK, MessageID)
		SELECT VoucherNo, APK, ''00ML000050''
		FROM #SOP2171_SOT2170
		WHERE DivisionID <> '''+@DivisionID+'''
	END
	ELSE
	IF EXISTS (SELECT TOP 1 1 FROM #SOP2171_SOT2170 WHERE TranMonth + TranYear * 100 <> ' + STR(@TranMonth + @TranYear * 100) + ')
	BEGIN 
		INSERT INTO #SOP2171_Errors 
		(
			VoucherNo
			, APK
			, MessageID
		)
		SELECT 	VoucherNo
			, APK
			, ''00ML000137''
		FROM #SOP2171_SOT2170
		WHERE TranMonth + TranYear * 100 <> ' + STR(@TranMonth + @TranYear * 100) + '

	END

	IF NOT EXISTS (SELECT TOP 1 1 FROM #SOP2171_Errors)
	BEGIN

		-- Xoa lo trinh tai xe
		DELETE ST02
		FROM SOT2202 ST02
		INNER JOIN SOT2170 ST70 WITH (NOLOCK) ON ST70.DivisionID = ST02.DivisionID AND ST70.TransactionID = ST02.TransactionVoucher
		INNER JOIN #SOP2171_SOT2170 ST170 WITH (NOLOCK) ON ST170.DivisionID = ST02.DivisionID AND ST170.APK = ST70.APK
		
		-- Xoa lo trinh tai xe
		DELETE ST01
		FROM SOT2201 ST01
		WHERE NOT EXISTS 
				(
					SELECT TOP 1 1 
					FROM SOT2202 ST02 WITH (NOLOCK) 
					WHERE ST02.DivisionID = ST01.DivisionID
							AND ST02.MonitorID = ST01.MonitorID
				)

		--- Cuoi cung la xoa thong tin Dieu phoi.
		DELETE T1 FROM SOT2170 T1 INNER JOIN #SOP2171_SOT2170 T2 ON T1.APK = T2.APK	
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #SOP2171_Errors T3 WITH (NOLOCK) WHERE T1.APK = T3.APK)
		
	END
	ELSE
	BEGIN					
			SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
						SELECT '', '' + VoucherNo 
						FROM #SOP2171_Errors T2 WITH(NOLOCK) 
						WHERE  T1.APK = T2.APK
						FOR XML PATH ('''')), 1, 1, ''''
						) AS Params
			FROM #SOP2171_Errors T1
			ORDER BY MessageID
	END
	'
	

	PRINT @sSQL
	EXEC (@sSQL)

END
IF @Mode = 2 --- Kiểm tra và hủy đơn.
BEGIN

	CREATE TABLE #SOP2171_Errors 
	(
		VoucherNo Varchar(50), 
		APK Varchar(50), 
		MessageID Varchar(50),
		Params VARCHAR(50)
	)

	--- Cắt dữ liệu VoucherID vào bảng.
	SELECT [Name] AS APK
	INTO #SOP2171_APK
	FROM SplitString(@VoucherIDList, ',')

	--- Dữ liệu Điều phối cần kiểm tra có Hủy đơn được không.
	SELECT APK
			, ST70.DivisionID
			, ST70.VoucherNo
			, ST70.OrderNo
			, ST70.TranMonth
			, ST70.TranYear
			, ST70.[Status]
	INTO #SOP2171_SOT2170
	FROM SOT2170 ST70 WITH (NOLOCK) 
	WHERE ST70.DivisionID = @DivisionID
			AND ST70.APK IN (SELECT APK FROM #SOP2171_APK)

	-- Xử lý kiểm tra
	BEGIN
		--- Kiểm tra trạng thái phù hợp hủy đơn không:
		--- Trạng thái áp dụng Hủy đơn:
		--- 0: Chờ nhận hàng.
		--- 2: Từ chối.
		--- 3: Đã hủy đơn trước đó.
		INSERT INTO #SOP2171_Errors 
			(
				VoucherNo
				, APK
				, MessageID
				, Params
			)
			SELECT VoucherNo
				, APK
				, 'SOFML000045'
				, OrderNo
			FROM #SOP2171_SOT2170 ST70
			WHERE ISNULL(ST70.[Status], 0) NOT IN (0, 2, 4)
	END

	--select * From #SOP2171_SOT2170

	--- Xử lý dữ liệu nếu không phát sinh lỗi.
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM #SOP2171_Errors)
		BEGIN
		
			UPDATE ST70
				SET ST70.[Status] = 4 -- Hủy đơn.
			FROM SOT2170 ST70 WITH (NOLOCK)
			INNER JOIN #SOP2171_SOT2170 ST71 ON ST71.APK = ST70.APK

			--- Cập nhật trạng thái bên Details Lộ trình của Tài xế.
			UPDATE ST02
				SET ST02.[Status] = 4 -- Hủy đơn.
			FROM SOT2202 ST02 WITH (NOLOCK)
			INNER JOIN SOT2170 ST70 WITH (NOLOCK) ON ST70.DivisionID = @DivisionID
														AND ST70.TransactionID = ST02.TransactionVoucher
			INNER JOIN #SOP2171_SOT2170 ST71 ON ST71.APK = ST70.APK
			
			--- Cập nhật trạng thái bên Master Lộ trình của Tài xế.
			--- Nếu trường hợp đơn cuối của Tài xế.
			UPDATE ST01
				SET ST01.[Status] = 1 -- Hoàn thành
			FROM SOT2201 ST01 WITH (NOLOCK)
			INNER JOIN #SOP2171_SOT2170 ST71 ON ST71.OrderNo = ST01.DVoucherNo
			--- Không còn phiếu nào khác đang trong quá trình giao hàng của Lộ trình Tài xế.
			OUTER APPLY 
			(
				--- Tìm hiện trạng Lộ trình vẫn đang: chờ nhận hàng, Đang giao hàng.
				SELECT TOP 1 ST11.*
						FROM SOT2202 ST22 WITH (NOLOCK)
						INNER JOIN SOT2201 ST11 WITH (NOLOCK) ON ST11.DivisionID = ST01.DivisionID
																	AND ST11.MonitorID = ST01.MonitorID
						WHERE ST22.[Status] IN (0, 3)
			) ST11
			WHERE ST01.DivisionID = @DivisionID
					-- Không có thì mới cho phép update.
					AND ST11.APK IS NULL

		END
	END
	
	-- Trả về kết quả.
	SELECT * FROM #SOP2171_Errors


END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
