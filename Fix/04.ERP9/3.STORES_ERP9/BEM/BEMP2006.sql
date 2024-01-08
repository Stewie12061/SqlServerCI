IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[BEMP2006]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[BEMP2006]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO









-- <Summary>
--- Load Detail cho màn hình Update - BEMF2001 (Cập nhật phiếu DNTT/DNTTTU/DNTU)
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Create by Vĩnh Tâm on 15/06/2020
---- Modified by Vĩnh Tâm on 10/07/2020: Bổ sung load các field Tài khoản có, Tài khoản nợ, Tài khoản trung gian
---- Modified by Vĩnh Tâm on 03/11/2020: Xử lý lỗi mở form khi có cùng người duyệt cho nhiều cấp
---- Modified by Vĩnh Tâm on 04/12/2020: Fix lỗi bị double dòng detail khi nhiều cấp duyệt có cùng một người duyệt
---- Modified by Vĩnh Tâm on 07/12/2020: Xóa điều kiện lọc Người duyệt theo user đăng nhập
---- Modified by Vĩnh Tâm on 11/12/2020: Load bổ sung cột Nhóm tài khoản theo TK Nợ
---- Modified by Trọng Kiên on 30/03/2021: Load bổ sung cột Số tiền công nợ qui đổi (ConvertedGeneralAmount)
---- Modified by Kiều Nga on 11/05/2023: Chỉnh lại tên cột ApproveLevel
---- Modified by Kiều Nga on 06/09/2023: [2023/09/IS/0018] Fix lỗi ConvertedSpendAmount bị null, duyệt đơn hàng loạt lỗi
/* <Example>
	EXEC BEMP2006 @DivisionID = 'DTI', @UserID = 'D41001', @APK = 'b69c8d96-2fdc-4c0a-d977-4887126e2641', @Type = ''
 */

CREATE PROCEDURE [dbo].[BEMP2006]
(
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@APK VARCHAR(50),
	@Type VARCHAR(50)
)
AS
BEGIN

	DECLARE @sSQL01 NVARCHAR(MAX),
			@sSQL02 NVARCHAR(MAX),
			@sWhere NVARCHAR(MAX) = '',
			@OrderBy VARCHAR(50) = '',
			@Level INT = 0,
			@sSQLSelect NVARCHAR (MAX) = '',
			@sSQLJoin NVARCHAR (MAX) = '',
			@i INT = 1, @s VARCHAR(2),
			@APK9000 VARCHAR(50) = @APK

	SET @OrderBy = 'B2.OrderNo '
	SET @sWhere = ' B1.DivisionID = ''' + @DivisionID + ''''
	SET @sWhere = @sWhere + ' AND (CONVERT(VARCHAR(50), B1.APK) = ''' + @APK + ''' OR CONVERT(VARCHAR(50), B1.APKMaster_9000) = ''' + @APK + ''')'
	
	IF ISNULL(@Type, '') = ''
		SELECT @APK9000 = APKMaster_9000 FROM BEMT2000 WITH (NOLOCK) WHERE APK = @APK

	-- Lấy cấp độ duyệt của phiếu hiện tại
	SELECT @Level = MAX(Levels) FROM BEMT2000 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND @APK IN (CONVERT(VARCHAR(50), APK), CONVERT(VARCHAR(50), APKMaster_9000))

	WHILE @i <= @Level
	BEGIN
		IF @i < 10 SET @s = '0' + CONVERT(VARCHAR, @i)
		ELSE SET @s = CONVERT(VARCHAR, @i)
		SET @sSQLSelect = @sSQLSelect + ' , APK9001' + @s + ', ApprovePerson' + @s + 'Status, ApprovePerson' + @s + 'StatusName, ApprovePerson' + @s + 'Note, ApprovePerson' + @s + 'Date'
		SET @sSQLJoin = @sSQLJoin + '
						LEFT JOIN (SELECT OOT1.APK AS APK9001' + @s + ', OOT1.APKMaster, OOT1.DivisionID, T94.APKDetail,
							ISNULL(T94.Status, 0) AS ApprovePerson' + @s + 'Status,
							O99.Description AS ApprovePerson' + @s + 'StatusName,
							T94.Note AS ApprovePerson' + @s + 'Note,
							T94.ApprovalDate AS ApprovePerson' + @s + 'Date
							FROM OOT9001 OOT1 WITH (NOLOCK)
								LEFT JOIN OOT9004 T94 WITH (NOLOCK) ON OOT1.APK = T94.APK9001 AND ISNULL(T94.DeleteFlag, 0) = 0
								LEFT JOIN OOT0099 O99 WITH (NOLOCK) ON O99.ID1 = ISNULL(T94.Status,0) AND O99.CodeMaster = ''Status''
							WHERE OOT1.APKMaster = ''' + @APK9000 + ''' AND OOT1.Level = ' + STR(@i) + '
						) APP' + @s + ' ON APP' + @s + '.DivisionID = O0.DivisionID AND APP' + @s + '.APKMaster = O0.APK '
						--AND CASE WHEN ISNULL(CONVERT(VARCHAR(50), APP' + @s + '.APKDetail), '''') <> '''' THEN APP' + @s + '.APKDetail ELSE B2.APK END = B2.APK'
		SET @i = @i + 1
	END

	BEGIN
		DECLARE @ReportExchangeRate DECIMAL(28, 8)
		CREATE TABLE #ExchangeData (CurrencyID VARCHAR(50), CurrencyName NVARCHAR(250), ExchangeRate DECIMAL(28, 8))
		INSERT INTO #ExchangeData
		EXEC BEMP2017 @DivisionID

		--SELECT @ReportExchangeRate = T1.ExchangeRate
		--FROM #ExchangeData T1
		--	INNER JOIN BEMT0000 B1 WITH (NOLOCK) ON T1.CurrencyID = B1.ReportCurrencyID AND B1.DivisionID = @DivisionID

		SELECT @ReportExchangeRate = T1.ExchangeRate
		FROM #ExchangeData T1
			INNER JOIN AT1101 B1 WITH (NOLOCK) ON T1.CurrencyID = B1.BaseCurrencyID AND B1.DivisionID = @DivisionID
	END

	print @ReportExchangeRate
	SET @sSQL01 = N'
		SELECT DISTINCT B2.APK, B2.APKMaster, B2.APKMaster_9000, B2.DivisionID, B2.APKMInherited, B2.APKDInherited, B2.InheritVoucherNo, B2.InheritType
			, B2.DepartmentAnaID, ISNULL(A1.AnaName, B2.DepartmentAnaID) AS DepartmentAnaName, B2.CostAnaID, ISNULL(A2.AnaName, B2.CostAnaID) AS CostAnaName
			, B2.Description, B2.RingiNo, B2.InvoiceNo, B2.InvoiceDate, B2.FeeID, ISNULL(B4.FeeName, B2.FeeID) AS FeeName
			, B2.CurrencyID, ISNULL(B2.ExchangeRate,0) ExchangeRate, ISNULL(B2.RequestAmount,0) RequestAmount, ISNULL(B2.ConvertedGeneralAmount,0) ConvertedGeneralAmount
			, IIF(ISNULL(B2.ConvertedRequestAmount, 0) = 0, ISNULL(ISNULL(B2.RequestAmount, 0) * ' + CONVERT(VARCHAR(50), @ReportExchangeRate) + ' / B1.ExchangeRate,0), ISNULL(B2.ConvertedRequestAmount,0)) AS ConvertedRequestAmount
			-- Trường hợp mở màn hình duyệt của Kế toán lần đầu tiên chưa có số tiền Chi thì lấy mặc định là số tiền Yêu cầu
			, COALESCE(ISNULL(B2.SpendAmount,0), ISNULL(B2.RequestAmount,0), 0) AS SpendAmount
			, IIF(ISNULL(B2.ConvertedSpendAmount, 0) = 0, ISNULL(ISNULL(B2.RequestAmount, 0) * ' + CONVERT(VARCHAR(50), @ReportExchangeRate) + ' / B1.ExchangeRate,0), ISNULL(B2.ConvertedSpendAmount,0)) AS ConvertedSpendAmount
			--, COALESCE(B2.ConvertedSpendAmount, B2.ConvertedRequestAmount, 0) AS ConvertedSpendAmount
			, B2.BankAccountID, A3.BankAccountNo, A3.BankName AS BankAccountName, B2.ApprovingLevel, B2.ApproveLevel
			, IIF(ISNULL(B2.DebitAccountID, '''') = '''', B5.AccountID, B2.DebitAccountID) AS DebitAccountID
			, B2.CreditAccountID, B2.MediumAccountID, A4.GroupID AS DebitAcccountGroupID, B2.ListAPKDInherited
			, B2.DeleteFlg, B2.OrderNo, B2.CreateDate, B2.CreateUserID, B2.LastModifyDate, B2.LastModifyUserID
			, O3.Note AS ApprovalNotes, ISNULL(O3.ApprovalDate, GETDATE()) AS ApprovalDate, ISNULL(O3.Status, 0) AS Status, B2.TVoucherID, B2.TBatchID
			' + @sSQLSelect + ' '
	SET @sSQL02 = N'
		INTO #TempBEMP2006
		FROM BEMT2000 B1 WITH (NOLOCK)
			INNER JOIN BEMT2001 B2 WITH (NOLOCK) ON B1.APK = B2.APKMaster
			INNER JOIN BEMT0000 B3 WITH (NOLOCK) ON B1.DivisionID = B3.DivisionID
			LEFT JOIN BEMT1000 B4 WITH (NOLOCK) ON B4.DivisionID IN (B1.DivisionID, ''@@@'') AND B4.FeeID = B2.FeeID
			LEFT JOIN BEMT0011 B5 WITH (NOLOCK) ON B5.DivisionID = B1.DivisionID AND ISNULL(B5.Disabled, 0) = 0 AND B2.DepartmentAnaID = B5.DepartmentAnaTypeID AND B2.CostAnaID = B5.CostAnaTypeID
			LEFT JOIN AT1011 A1 WITH (NOLOCK) ON A1.DivisionID = B3.DivisionID AND A1.AnaTypeID = B3.DepartmentAnaID AND A1.AnaID = B2.DepartmentAnaID
			LEFT JOIN AT1011 A2 WITH (NOLOCK) ON A2.DivisionID = B3.DivisionID AND A2.AnaTypeID = B3.CostAnaID AND A2.AnaID = B2.CostAnaID
			LEFT JOIN AT1016 A3 WITH (NOLOCK) ON A3.DivisionID IN (B1.DivisionID, ''@@@'') AND A3.BankAccountID = B2.BankAccountID
			LEFT JOIN AT1005 A4 WITH (NOLOCK) ON B2.DebitAccountID = A4.AccountID AND A4.DivisionID IN (B2.DivisionID, ''@@@'') AND ISNULL(A4.Disabled, 0) = 0
			LEFT JOIN OOT9000 O0 WITH (NOLOCK) ON B1.APKMaster_9000 = O0.APK
			-- Join bảng OOT9001 2 lần để lấy dòng có Level duyệt cao nhất trong trường hợp nhiều cấp cùng một người duyệt.
			LEFT JOIN OOT9001 O1 WITH (NOLOCK) ON B1.APKMaster_9000 = O1.APKMaster
			INNER JOIN OOT9001 O2 WITH (NOLOCK) ON O1.APKMaster = O2.APKMaster AND O1.Level > O2.Level
			LEFT JOIN OOT9004 O3 WITH (NOLOCK) ON O1.APK = O3.APK9001 AND O1.ApprovePersonID = O3.ApprovePersonID AND O3.APKDetail = B2.APK
			' + @sSQLJoin + '
		WHERE ' + @sWhere + '
		ORDER BY ' + @OrderBy + '

		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, COUNT(*) OVER () AS TotalRow, *
		FROM #TempBEMP2006 B2
		ORDER BY ' + @OrderBy

	EXEC (@sSQL01 + @sSQL02)
	--PRINT (@sSQL01)
	--PRINT (@sSQL02)

END








GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
