IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[BEMP2023]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[BEMP2023]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Load dữ liệu In phiếu thanh toán đi lại.
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
----Created by	Đình Ly	on 13/06/2020
----Modified by Tấn Thành on 26/08/2020: Bổ sung load Nội dung và Số tiền quy đổi trên Detail phiếu in
----Modified by Vĩnh Tâm on 15/10/2020: Fix lỗi không lấy được dữ liệu Loại phí khi Loại phí là Dùng chung
----Modified by Vĩnh Tâm on 15/10/2020: Bổ sung dòng tính tổng tiền theo từng loại phí
-- <Example>

CREATE PROCEDURE [dbo].[BEMP2023]
(
	@PK VARCHAR(50),
	@DivisionID VARCHAR(50)
)
AS 
BEGIN
	-- Get danh sách loại phí
	DECLARE @Cur CURSOR,
			@sSQL VARCHAR(MAX),
			@FeeID VARCHAR(50),
			@ListSum NVARCHAR(MAX) = '',
			@ListFeeID NVARCHAR(MAX) = '',
			@ListSelect NVARCHAR(MAX) = '',
			@FeeIDReplace NVARCHAR(MAX) = ''

	SET @Cur = CURSOR SCROLL KEYSET FOR
	SELECT DISTINCT B1.FeeID 
	FROM BEMT1000 B1 WITH(NOLOCK) 
		INNER JOIN BEMT2020 B2 WITH(NOLOCK) ON B1.DivisionID IN (B2.DivisionID, '@@@')
		INNER JOIN BEMT2021 B3 WITH(NOLOCK) ON B3.APKMaster = B2.APK AND B3.DivisionID = B2.DivisionID AND B3.FeeID = B1.FeeID
	WHERE B1.DivisionID IN (@DivisionID, '@@@') AND B2.APK = @PK
	ORDER BY FeeID
	OPEN @Cur
		FETCH NEXT FROM @Cur INTO @FeeID
		WHILE @@FETCH_STATUS = 0
		BEGIN
			SET @FeeIDReplace = REPLACE(@FeeID, '.', '')
			SET @ListFeeID = @ListFeeID + ',' + @FeeIDReplace
			SET @ListSelect = @ListSelect + ', T2.' + @FeeIDReplace + ' AS Currency' + @FeeIDReplace + ',
			T1.' + @FeeIDReplace + ' AS Amount' + @FeeIDReplace + ', T3.' + @FeeIDReplace + ' AS AmountConvert' + @FeeIDReplace + ''
			SET @ListSum = @ListSum + ', NULL AS Currency' + @FeeIDReplace + ', SUM(Amount' + @FeeIDReplace + '), SUM(AmountConvert' + @FeeIDReplace + ')'
			FETCH NEXT FROM @Cur INTO @FeeID
		END
	CLOSE @Cur

	-- Loại bỏ dấu phẩy (,) dư ở đầu chuỗi danh sách loại phí.
	SET @ListFeeID = SUBSTRING(@ListFeeID, 2, LEN(@ListFeeID))

	-- Loại bỏ dấy phẩy (,) dư ở đầu chuỗi danh sách cột select.
	SET @ListSelect = SUBSTRING(@ListSelect, 2, LEN(@ListSelect))
	SET @ListSum = SUBSTRING(@ListSum, 2, LEN(@ListSum))

	SET @sSQL = N'
	-- Số tiền
	SELECT P2.* INTO #TableFee
	FROM
	(
		SELECT B1.APK, B1.Date, B1.Amount, REPLACE(B1.FeeID, ''.'', '''') AS FeeID
		FROM BEMT2020 B0 WITH (NOLOCK)
			INNER JOIN BEMT2021 B1 WITH (NOLOCK) ON B1.APKMaster = B0.APK
		WHERE B0.APK = ''' + @PK + ''' 
	) AS P1
	PIVOT
	(
		SUM(P1.Amount) FOR P1.FeeID IN (' + @ListFeeID + ')
	) AS P2

	-- Loại tiền phí
	SELECT P2.* INTO #TablePay
	FROM
	(
		SELECT B1.APK, B1.Date, B1.CurrencyID, REPLACE(B1.FeeID, ''.'', '''') AS FeeID
		FROM BEMT2020 B0 WITH (NOLOCK)
			INNER JOIN BEMT2021 B1 WITH (NOLOCK) ON B1.APKMaster = B0.APK
		WHERE B0.APK = ''' + @PK + '''
	) AS P1
	PIVOT
	(
		MAX(P1.CurrencyID) FOR P1.FeeID IN (' + @ListFeeID + ')
	) AS P2


	-- Số tiền quy đổi
	SELECT P2.* INTO #TablePayConvert
	FROM
	(
		SELECT B1.APK, B1.Date, B1.CurrencyID, REPLACE(B1.FeeID, ''.'', '''') AS FeeID
			 , B1.ConvertedAmount  AS AmountConvert
		FROM BEMT2020 B0 WITH (NOLOCK)
			INNER JOIN BEMT2021 B1 WITH (NOLOCK) ON B1.APKMaster = B0.APK
			LEFT JOIN BEMT0000 B2 WITH (NOLOCK) ON B2.DivisionID = B1.DivisionID
			INNER JOIN AT1004 A2 WITH (NOLOCK) ON A2.CurrencyID = B2.ReportCurrencyID
		WHERE B0.APK = ''' + @PK + '''
	) AS P1
	PIVOT
	(
		MAX(P1.AmountConvert) FOR P1.FeeID  IN (' + @ListFeeID + ')
	) AS P2
	
	SELECT CONVERT(VARCHAR(10), T1.Date, 103) AS Date, B1.Contents, ' + @ListSelect + '
	INTO #ResultBEMP2023
	FROM #TableFee T1 WITH (NOLOCK)
		LEFT JOIN #TablePay T2 ON T2.APK = T1.APK
		LEFT JOIN #TablePayConvert T3 ON T3.APK = T1.APK
		LEFT JOIN BEMT2021 B1 WITH (NOLOCK) ON B1.Date = T1.Date AND B1.APK = T1.APK

	INSERT INTO #ResultBEMP2023
	SELECT ''Total'' AS Date, NULL AS Contents, ' + @ListSum + '
	FROM #ResultBEMP2023

	SELECT *
	FROM #ResultBEMP2023
	'

	EXEC (@sSQL)
	PRINT(@sSQL)
END






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
