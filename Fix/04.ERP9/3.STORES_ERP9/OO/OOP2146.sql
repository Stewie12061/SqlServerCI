IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2146]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2146]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


















-- <Summary>
---- Get giá trị từ thiết lập dữ liệu mặc định
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
-- Create on 22/10/2019 by Đình Ly
-- Modified on 18/03/2020 by Vĩnh Tâm: Sử dụng cột OT2102.InheritTableID để phân biệt dữ liệu của KHCU hay NC và tính tổng giá trị hàng hóa cho KHCU và NC
-- Modified on 25/03/2020 by Vĩnh Tâm: Lấy Mã phân tích bộ phận được lưu tại cột Ghi chú của MPT Chi tiết nhóm chi
-- Modified on 06/11/2021 by Nhựt Trường: Bổ sung Group By khi Get tất cả dữ liệu định mức (Master + Detail).
-- Modified on 15/06/2021 by Nhựt Trường: Điều chỉnh LEFT JOIN thành INNER JOIN khi JOIN bảng AT1302 trường hợp Tính giá Hàng hóa (HH).
-- Modified on 01/06/2022 by Nhựt Trường: [2022/05/IS/0098] - Fix lỗi bị dup dữ liệu khi lấy giá trị định mức của các Mặt hàng có khai báo MPT.
-- <Example> Exec OOP2146 @QuotationNo = 'BPC/11/2019/00006'

CREATE PROCEDURE [dbo].[OOP2146]
(
	@QuotationNo NVARCHAR(100)
)
AS
	BEGIN
		SET NOCOUNT ON
		-- Khai báo biến dùng 
		DECLARE @sSQL NVARCHAR(MAX),
				@Result NVARCHAR(MAX),
				@Key_Loop NVARCHAR(50),
				@Key_Loop1 DECIMAL(28, 8)

		-- Khai báo bảng tạm chứa dữ liệu định mức
		DECLARE @tbl_Result TABLE
		(
			CostGroup NVARCHAR(MAX),
			CostGroupName NVARCHAR(MAX),
			CostGroupDetail NVARCHAR(MAX),
			CostGroupDetailName NVARCHAR(MAX),
			ColumnName NVARCHAR(MAX),
			Money DECIMAL(28, 8), 
			ActualMoney DECIMAL(28, 8)
		)
		-- Tạo cấu trúc cho bảng tạm
		SELECT TOP 0 CAST('' AS VARCHAR(50)) AS ColumnName, CAST(0 AS DECIMAL(28,8)) AS Money INTO #tblResult

		SELECT A1.ReAnaID AS CostGroup, A2.AnaName AS CostGroupName
			, M1.Value AS CostGroupDetail, A1.AnaName AS CostGroupDetailName, M1.ColumnID
			, A3.AnaID AS AnaDepartmentID, A3.AnaName AS AnaDepartmentName
			, CAST(NULL AS DECIMAL(28, 8)) AS Money, CAST(NULL AS DECIMAL(28, 8)) AS ActualMoney
			, M0.ScreenID AS QuotaType, IsConstitute = 1
		INTO #tbl_ResultMain
		FROM CMNT0011 M1 WITH (NOLOCK)
			INNER JOIN CMNT0010 M0 WITH (NOLOCK) ON M1.APKMaster = M0.APK
			INNER JOIN AT0000 A0 WITH (NOLOCK) ON A0.DefDivisionID = M1.DivisionID
			INNER JOIN AT1011 A1 WITH (NOLOCK) ON A1.AnaTypeID = A0.CostDetailAnaTypeID AND A1.AnaID = M1.Value
			INNER JOIN AT1011 A2 WITH (NOLOCK) ON A2.AnaTypeID = A0.CostAnaTypeID AND A2.AnaID = A1.ReAnaID
			LEFT JOIN AT1011 A3 WITH (NOLOCK) ON A3.AnaTypeID = A0.DepartmentAnaTypeID AND A3.AnaID = A1.Notes
			INNER JOIN OT2101 O1 WITH (NOLOCK) ON O1.QuotationNo = @QuotationNo
			LEFT JOIN SOT2062 S1 WITH (NOLOCK) ON O1.APK = S1.APK_OT2101
		WHERE O1.QuotationNo = @QuotationNo
		GROUP BY A1.ReAnaID, M1.Value, A1.AnaName, A2.AnaName, M1.ColumnID, M0.ScreenID, A1.AnaTypeID, A3.AnaID, A3.AnaName

		-- Tạo bảng tạm chứa ColumnID
		SELECT ColumnID AS ColumnName INTO #tbl_Loop
		FROM #tbl_ResultMain
		-- Duyệt từng dòng bằng WHILE
		WHILE EXISTS(SELECT TOP 1 1 FROM #tbl_Loop)
		BEGIN
			-- Gán dữ liệu vào key tạm
			SELECT TOP 1 @Key_Loop = ColumnName FROM #tbl_Loop
			IF (CHARINDEX(@Key_Loop, 'InternalShipCost/TaxImport/CustomsCost/CustomsInspectionCost/TT_Cost/LC_Open/LC_Receice/WarrantyCost') > 0)
			BEGIN
				SET @sSQL = '
					INSERT INTO #tblResult
					SELECT ''' + @Key_Loop + ''', R03.' + @Key_Loop + ' * R02.ExchangeRate
					FROM OT2101 M WITH (NOLOCK)
						INNER JOIN (SELECT DISTINCT QuotationID, InheritVoucherID
									FROM OT2102 WITH (NOLOCK)
									) R01 ON M.QuotationID = R01.QuotationID
						INNER JOIN OT2101 R02 WITH (NOLOCK) ON R01.InheritVoucherID = R02.QuotationID AND R02.ClassifyID = ''NC''
						INNER JOIN SOT2062 R03 ON R01.InheritVoucherID = R03.APK_OT2101
					WHERE M.QuotationNo = @QuotationNo'
			END
			ELSE IF(CHARINDEX(@Key_Loop, 'ProfileCost') > 0)
			BEGIN
				SET @sSQL = '
					INSERT INTO #tblResult
					SELECT ''' + @Key_Loop + ''', R03.' + @Key_Loop + '
					FROM OT2101 M WITH (NOLOCK)
						INNER JOIN (SELECT DISTINCT QuotationID, InheritVoucherID
									FROM OT2102	WITH (NOLOCK)
									) R01 ON  M.QuotationID = R01.QuotationID
						INNER JOIN OT2101 R02 WITH (NOLOCK) ON R01.InheritVoucherID = R02.QuotationID AND R02.ClassifyID = ''KHCU''
						INNER JOIN SOT2062 R03 ON R01.InheritVoucherID = R03.APK_OT2101
					WHERE M.QuotationNo = @QuotationNo'
			END
			ELSE
			BEGIN
				SET @sSQL =
					'INSERT INTO #tblResult
					SELECT ''' + @Key_Loop + ''', S1.' + @Key_Loop + ' * O1.ExchangeRate
					FROM OT2101 O1 WITH (NOLOCK)
						LEFT JOIN SOT2062 S1 WITH (NOLOCK) ON O1.APK = S1.APK_OT2101
						INNER JOIN (SELECT DISTINCT QuotationID, InheritVoucherID
									FROM OT2102 WITH (NOLOCK)
									) O2 ON O1.QuotationID = O2.QuotationID
					WHERE O1.QuotationNo = @QuotationNo'
			END
			--PRINT @sSQL
			EXEC SP_EXECUTESQL @sSQL, N'@QuotationNo VARCHAR(50)', @QuotationNo = @QuotationNo
			-- Xóa dần dữ liệu bảng tạm chứa ColumnID tròng vòng While
			DELETE FROM #tbl_Loop WHERE ColumnName = @Key_Loop
		END
		DROP TABLE #tbl_Loop
	END
	-- Update dữ liệu vào bảng chính 
	UPDATE #tbl_ResultMain 
	SET Money = R.Money, ActualMoney = R.Money
	FROM #tblResult R 
	WHERE #tbl_ResultMain.ColumnID = R.ColumnName

	IF (@QuotationNo != '')
	BEGIN
		-- Bảng tạm lấy ra tất cả Báo giá NC đã kế thừa xuống Báo giá SALE
		SELECT DISTINCT O2.QuotationID, O2.InheritVoucherID
		INTO #Temp_NC
		FROM OT2101 O1 WITH (NOLOCK)
		INNER JOIN OT2102 O2 WITH (NOLOCK) ON O1.QuotationID = O2.QuotationID AND O2.InheritTableID = 'NC'
		WHERE O1.QuotationNo = @QuotationNo
		-- Bảng tạm lấy ra tất cả Báo giá KHCU đã kế thừa xuống Báo giá SALE
		SELECT DISTINCT O2.QuotationID, O2.InheritVoucherID
		INTO #Temp_KHCU
		FROM OT2101 O1 WITH (NOLOCK)
		INNER JOIN OT2102 O2 WITH (NOLOCK) ON O1.QuotationID = O2.QuotationID AND O2.InheritTableID = 'KHCU'
		WHERE O1.QuotationNo = @QuotationNo
		-- Bảng tạm lấy ra tất cả Báo giá KHCU đã kế thừa xuống Báo giá SALE
		SELECT DISTINCT O2.QuotationID, O2.InheritVoucherID
		INTO #Temp_SALE
		FROM OT2101 O1 WITH (NOLOCK)
		INNER JOIN OT2102 O2 WITH (NOLOCK) ON O1.QuotationID = O2.QuotationID
		WHERE O1.QuotationNo = @QuotationNo

		-- Insert định mức detail từ báo giá
		INSERT INTO #tbl_ResultMain

		-- Tính giá Hàng hóa (HH)
		SELECT A2.ReAnaID, A3.AnaName AS CostGroupName
				, A2.AnaID AS CostGroupDetail, A2.AnaName AS CostGroupDetailName, NULL AS ColumnID
				, A4.AnaID AS AnaDepartmentID, A4.AnaName AS AnaDepartmentName
				-- O3.QuoQuantity: Số lượng mặt hàng tại Báo giá SALE, O5.UnitPrice: Giá tại bảng giá gốc
				, ISNULL(SUM(O3.QuoQuantity * O5.UnitPrice * O4.ExchangeRate), 0) AS Money
				, ISNULL(SUM(O3.QuoQuantity * O5.UnitPrice * O4.ExchangeRate), 0) AS ActualMoney
				, 'SOF2061A' AS QuotaType -- NỘI CHÍNH (NC)
				, 1 AS IsConstitute
		FROM OT2101 O1 WITH (NOLOCK)
			-- Lấy ra tất cả Báo giá NC đã kế thừa xuống Báo giá SALE
			LEFT JOIN #Temp_NC O2 ON O1.QuotationID = O2.QuotationID
			-- Chi tiết báo giá SALE
			LEFT JOIN OT2102 O3 WITH (NOLOCK) ON O1.QuotationID = O3.QuotationID AND O3.InheritTableID = 'NC'
			-- Master báo giá NC
			LEFT JOIN OT2101 O4 WITH (NOLOCK) ON O2.InheritVoucherID = O4.QuotationID
			-- Detail báo giá NC mà SALE đã kế thừa để tạo báo giá SALE
			LEFT JOIN OT2102 O5 WITH (NOLOCK) ON O4.QuotationID = O5.QuotationID AND O3.InventoryID = O5.InventoryID AND O3.InheritTransactionID = O5.TransactionID
			-- Đọc dữ liệu thiết lập Mã phân tích của Division hiện tại
			INNER JOIN AT0000 A0 WITH (NOLOCK) ON A0.DefDivisionID = O1.DivisionID
			-- Chỉ lấy những mặt hàng không có gắn MPT nghiệp vụ (cột A1.I05ID)
			INNER JOIN AT1302 A1 WITH (NOLOCK) ON O3.InventoryID = A1.InventoryID AND A1.I05ID IS NULL
			-- Set cứng MPT nghiệp vụ Chi tiết phiếu chi: Hàng hóa (HH)
			INNER JOIN AT1011 A2 WITH (NOLOCK) ON A2.AnaTypeID = A0.CostDetailAnaTypeID AND A2.AnaID = 'HH' AND A2.DivisionID = O1.DivisionID
			LEFT JOIN AT1011 A3 WITH (NOLOCK) ON A3.AnaTypeID = A0.CostAnaTypeID AND A3.AnaID = A2.ReAnaID AND A2.DivisionID = O1.DivisionID
			LEFT JOIN AT1011 A4 WITH (NOLOCK) ON A4.AnaTypeID = A0.DepartmentAnaTypeID AND A2.Notes = A4.AnaID
		GROUP BY A2.ReAnaID, A2.AnaID, A2.AnaName, A3.AnaName, A4.AnaID, A4.AnaName
		UNION

		-- Tính giá Chi phí vật tư (KHCU)
		SELECT A2.ReAnaID, A3.AnaName AS CostGroupName
				, A2.AnaID AS CostGroupDetail, A2.AnaName AS CostGroupDetailName, NULL AS ColumnID
				, A4.AnaID AS AnaDepartmentID, A4.AnaName AS AnaDepartmentName
				-- O3.QuoQuantity: Số lượng mặt hàng tại Báo giá SALE, O5.UnitPrice: Giá tại bảng giá gốc
				, ISNULL(SUM(O3.QuoQuantity * O5.UnitPrice * O4.ExchangeRate), 0) AS Money
				, ISNULL(SUM(O3.QuoQuantity * O5.UnitPrice * O4.ExchangeRate), 0) AS ActualMoney
				, 'SOF2061C' AS QuotaType -- KẾ HOẠCH CUNG ỨNG (KHCU)
				, 1 AS IsConstitute
		FROM OT2101 O1 WITH (NOLOCK)
			-- Lấy ra tất cả Báo giá KHCU đã kế thừa xuống Báo giá SALE
			INNER JOIN #Temp_KHCU O2 ON O1.QuotationID = O2.QuotationID
			-- Chi tiết báo giá SALE
			INNER JOIN OT2102 O3 WITH (NOLOCK) ON O1.QuotationID = O3.QuotationID AND O3.InheritTableID = 'KHCU'
			-- Master báo giá KHCU
			INNER JOIN OT2101 O4 WITH (NOLOCK) ON O2.InheritVoucherID = O4.QuotationID
			-- Detail báo giá KHCU mà SALE đã kế thừa để tạo báo giá SALE
			INNER JOIN OT2102 O5 WITH (NOLOCK) ON O4.QuotationID = O5.QuotationID AND O3.InventoryID = O5.InventoryID AND O3.InheritTransactionID = O5.TransactionID
			-- Đọc dữ liệu thiết lập Mã phân tích của Division hiện tại
			INNER JOIN AT0000 A0 WITH (NOLOCK) ON A0.DefDivisionID = O1.DivisionID
			-- Chỉ lấy những mặt hàng không có gắn MPT nghiệp vụ (cột A1.I05ID)
			INNER JOIN AT1302 A1 WITH (NOLOCK) ON O3.InventoryID = A1.InventoryID AND A1.I05ID IS NULL
			-- Set cứng MPT nghiệp vụ Chi tiết phiếu chi: Chi phí vật tư (CPVT)
			INNER JOIN AT1011 A2 WITH (NOLOCK) ON A2.AnaTypeID = A0.CostDetailAnaTypeID AND A2.AnaID = 'CPVT' AND A2.DivisionID = O1.DivisionID
			LEFT JOIN AT1011 A3 WITH (NOLOCK) ON A3.AnaTypeID = A0.CostAnaTypeID AND A3.AnaID = A2.ReAnaID AND A2.DivisionID = O1.DivisionID
			LEFT JOIN AT1011 A4 WITH (NOLOCK) ON A4.AnaTypeID = A0.DepartmentAnaTypeID AND A2.Notes = A4.AnaID
		GROUP BY A2.ReAnaID, A2.AnaID, A2.AnaName, A3.AnaName, A4.AnaID, A4.AnaName
		UNION

		-- Lấy giá trị định mức của các Mặt hàng có khai báo MPT

		SELECT ReAnaID, CostGroupName, CostGroupDetail, CostGroupDetailName, ColumnID, AnaDepartmentID, AnaDepartmentName,
		       SUM(QuoQuantity * Amount) AS Money, SUM(QuoQuantity * Amount) AS ActualMoney, QuotaType, IsConstitute
		FROM (
				SELECT A2.ReAnaID, A3.AnaName AS CostGroupName
						, A2.AnaID AS CostGroupDetail, A2.AnaName AS CostGroupDetailName, NULL AS ColumnID
						, A4.AnaID AS AnaDepartmentID, A4.AnaName AS AnaDepartmentName
						-- O3.QuoQuantity: Số lượng mặt hàng tại Báo giá SALE
						, O3.QuoQuantity
						, 'SOF2061C' AS QuotaType -- KHCU
						, 1 AS IsConstitute
						-- OT2102.UnitPrice: Giá tại bảng giá gốc
						, (SELECT TOP 1 OT2102.UnitPrice * OT2101.ExchangeRate
						   -- Master báo giá KHCU
						   FROM OT2101 WITH(NOLOCK)
						   -- Detail báo giá KHCU mà SALE đã kế thừa để tạo báo giá SALE
						   INNER JOIN OT2102 WITH (NOLOCK) ON OT2102.QuotationID = OT2101.QuotationID
						   WHERE OT2101.QuotationID = O2.InheritVoucherID AND InventoryID = O3.InventoryID) AS Amount
				FROM OT2101 O1 WITH (NOLOCK)
					-- Lấy ra tất cả Báo giá KHCU đã kế thừa xuống Báo giá SALE
					INNER JOIN #Temp_SALE AS O2 ON O1.QuotationID = O2.QuotationID
					-- Chi tiết báo giá SALE
					INNER JOIN OT2102 O3 WITH (NOLOCK) ON O1.QuotationID = O3.QuotationID
					INNER JOIN AT0000 A0 WITH (NOLOCK) ON A0.DefDivisionID = O1.DivisionID
					INNER JOIN AT1302 A1 WITH (NOLOCK) ON O3.InventoryID = A1.InventoryID AND A1.I05ID IS NOT NULL
					INNER JOIN AT1011 A2 WITH (NOLOCK) ON A2.AnaTypeID = A0.CostDetailAnaTypeID AND A2.AnaID = A1.I05ID AND A2.DivisionID = O1.DivisionID
					INNER JOIN AT1011 A3 WITH (NOLOCK) ON A3.AnaTypeID = A0.CostAnaTypeID AND A3.AnaID = A2.ReAnaID AND A2.DivisionID = O1.DivisionID
					INNER JOIN SOT2062 R03 WITH (NOLOCK) ON O3.InheritVoucherID = R03.APK_OT2101
					LEFT JOIN AT1011 A4 WITH (NOLOCK) ON A4.AnaTypeID = A0.DepartmentAnaTypeID AND A2.Notes = A4.AnaID
				WHERE O1.QuotationNo = @QuotationNo) OT2101
		GROUP BY ReAnaID, CostGroupName, CostGroupDetail, CostGroupDetailName, ColumnID, AnaDepartmentID, AnaDepartmentName, QuotaType, IsConstitute

	END

	-- Get tất cả dữ liệu định mức (Master + Detail)
	SELECT CostGroup, CostGroupName, CostGroupDetail, CostGroupDetailName, ColumnID, AnaDepartmentID, AnaDepartmentName,
		   SUM(ISNULL(Money,0)) AS Money,
		   SUM(ISNULL(ActualMoney,0)) AS ActualMoney,
		   QuotaType, IsConstitute
	FROM #tbl_ResultMain 
	GROUP BY CostGroup, CostGroupName, CostGroupDetail, CostGroupDetailName, ColumnID, AnaDepartmentID, AnaDepartmentName, QuotaType, IsConstitute


















GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
