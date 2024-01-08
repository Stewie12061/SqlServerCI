IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP3031]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP3031]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







-- <Summary>
---- Store load dữ liệu Báo cáo lãi lỗ dự án
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
--	Created by: Vĩnh Tâm, Date: 26/12/2019
--	Modified by: Vĩnh Tâm, Date: 13/04/2020: Bổ sung các xử lý sau:
--								+ Nhân hệ số Sale vào tổng tiền báo giá
--								+ Bổ sung lấy phiếu xuất kho hàng hóa để tính chi phí dự án
--								+ Tính giá trị hàng hóa cho 2 Chi tiết nhóm chi không được khai báo tại Thiết lập dữ liệu mặc định: CPVT, HH
--	Modified by: Vĩnh Tâm, Date: 23/04/2020: Bổ sung các xử lý sau:
--								+ Fix lỗi sai CPVT và HH giữa KHCU và NC
--								+ Điều chỉnh các Mã phân tích Chi tiết chi phí theo MPT thiết lập mới
--								+ MPT Chi phí hoa hồng (CPHH) tách thành 2 MPT: Chi phí hoa hồng chủ đầu tư (CPHHCDT), Chi phí hoa hồng thầu (CPHHT)
--	Modified by: Vĩnh Tâm, Date: 25/04/2020: Thay đổi công thức tính:
--								Tổng tiền NC, KHCU, Dịch vụ KHCU của Chi nhánh Hà Nội được lấy từ phiếu báo giá chứ không lấy từ các phiếu thực chi
--	Modified by: Vĩnh Tâm, Date: 28/04/2020: Fix lỗi tính sai tổng tiền Chi phí vật tư (CPVT) và Hàng hóa (HH)
--	Modified by: Trọng Kiên, Date: 10/11/2020: Fix lỗi replace mã phân tích khi in báo cáo
--  Modified by: Nhựt Trường, Date: 18/06/2021:
--								+ Điều chỉnh lấy lên hết tất cả các khoản chi ở AT9000.
--								+ Bổ sung lấy dữ liệu phiếu bút toán tổng hợp (TransactionTypeID = T99).
--								+ Điều chỉnh lấy dữ liệu 'Tiền thu vào' (lấy dữ liệu cột TotalAfterTax).
-- Modified by Nhựt Trường, Date: 16/07/2021: Không lấy các phiếu chi đã được kế thùa từ phiếu thu dự án.
-- Modified by Nhựt Trường, Date: 21/07/2021: Bổ sung kiểm tra null/rỗng khi lấy dữ liệu phiếu thu.
-- Modified by Nhựt Trường, Date: 21/07/2021: Bổ sung check thêm trạng thái hoàn thành (QuotationStatus = 3) khi lấy toàn bộ dữ liệu detail của các phiếu báo giá được duyệt liên quan đến dự án.
-- Modified by Văn Tài	  , Date: 02/08/2021: Bổ sung lấy tỷ giá từ phiếu kế thừa: Vì phiếu NC, KHCU dùng ngoại tệ khi kế thừa xuống SALE.
-- Modified by Nhựt Trường, Date: 04/08/2021: Bổ sung lấy danh sách số chứng từ.
-- Modified by Nhựt Trường, Date: 13/06/2022: [2022/06/IS/0087] - Tính tổng lợi nhuận dự án theo công thức: 'Tổng GT hợp đồng chưa thuế' - 'Tổng chi phí dự án'.
-- <Example>
-- OOP3031 @DivisionID = 'DTI',@ListDivisionID = '', @ProjectID = 'B222019'

CREATE PROCEDURE [dbo].[OOP3031]
(
	@DivisionID VARCHAR(50),
	@ListDivisionID VARCHAR(MAX),
	@ProjectID VARCHAR(MAX)
)
AS

DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@ScreenID CHAR(7) = 'OOF3031',
		@LanguageID VARCHAR(10) = 'vi-VN',
		@BranchDefault VARCHAR(50) = 'HCM',
		@GroupType VARCHAR(10) = 'Group',
		@ListDVKHCU VARCHAR(MAX) = 'CPVCHN,CPVCVT,TC,CPTHLD,CPTHKD',
		@IsSubBranch TINYINT = 0

-- Bảng dữ liệu kết quả trả về cho Báo cáo lãi lỗ dự án
DECLARE @Result TABLE (
	DivisionID VARCHAR(50),
	VoucherNo VARCHAR(250),
	ProjectID VARCHAR(250),
	STT VARCHAR(10),
	ID NVARCHAR(MAX),
	Name NVARCHAR(MAX),
	AmountTotal DECIMAL(28, 8),
	Branch VARCHAR(50),
	TypeData VARCHAR(10),
	RecordType VARCHAR(10) DEFAULT 'Record',
	DTable VARCHAR(10),
	Row INT
)

-- ## Xử lý dữ liệu Giá trị hợp đồng ##
-- Sử dụng dữ liệu của nghiệp vụ Báo giá (SALE)
BEGIN
	-- Bảng tạm lưu dữ liệu chi tiết phiếu báo giá
	DECLARE @TableData TABLE(
		APK UNIQUEIDENTIFIER DEFAULT NEWID(),
		APK_QuotationID UNIQUEIDENTIFIER,
		APK_TransactionID UNIQUEIDENTIFIER,
		DivisionID VARCHAR(50),
		ProjectID VARCHAR(250),
		Specification NVARCHAR(MAX),
		InventoryID VARCHAR(50),
		UnitID VARCHAR(50),
		Quantity DECIMAL(28,8),						-- Số lượng
		UnitPrice DECIMAL(28,8),					-- Đơn giá
		ExchangeRate DECIMAL(28, 8),				-- Tỷ giá
		InheritTransactionID VARCHAR(50),
		OrderIndex INT,
		DiscountAmount DECIMAL(28,8),
		Coefficient DECIMAL(28,8),					-- Hệ số
		TaxCost DECIMAL(28,8),
		Branch VARCHAR(50)
	)

	DECLARE @QuotationData TABLE (
		APK UNIQUEIDENTIFIER DEFAULT NEWID(),
		DivisionID VARCHAR(50),
		ProjectID VARCHAR(250),
		TotalAfterTax DECIMAL(28,8),
		TotalBeforeTax DECIMAL(28,8),
		VATTax DECIMAL(28,8),
		Branch VARCHAR(50)
	)

	-- Lấy toàn bộ dữ liệu detail của các phiếu báo giá được duyệt liên quan đến dự án
	INSERT INTO @TableData
	(
		APK_QuotationID
		, APK_TransactionID
		, DivisionID
		, ProjectID
		, InventoryID
		, UnitID
		, Specification
		, Quantity
		, UnitPrice
		, ExchangeRate
		, InheritTransactionID
		, OrderIndex
		, Branch
		, Coefficient
		, DiscountAmount
		, TaxCost
	)
	SELECT O3.QuotationID
			, O3.TransactionID
			, O2.DivisionID
			, O1.ProjectID
			, O3.InventoryID
			, O3.UnitID
			, O3.Specification
			, O3.QuoQuantity
			, O3.UnitPrice
			, ISNULL(ISNULL(OT01.ExchangeRate, O2.ExchangeRate), 1)
				AS ExchangeRate
			, O3.InheritTransactionID
			, O3.Orders
			, O3.Ana06ID
			, O3.Coefficient
			, S1.DiscountAmount
			, S1.TaxCost
	FROM OOT2100 O1 WITH (NOLOCK)
		INNER JOIN CRMT20501 C1 WITH (NOLOCK) ON C1.DivisionID = O1.DivisionID
													AND O1.OpportunityID = C1.OpportunityID
		INNER JOIN OT2101 O2 WITH (NOLOCK) ON O2.DivisionID = O1.DivisionID
												AND C1.OpportunityID = O2.OpportunityID 
												AND ISNULL(O2.OrderStatus, 0) = 1 
												AND ISNULL(QuotationStatus, 0) = 3 
												AND O2.ClassifyID = 'SALE'
		
		INNER JOIN OT2102 O3 WITH (NOLOCK) ON O3.DivisionID = C1.DivisionID
												AND O2.QuotationID = O3.QuotationID
			-- MPT Nghiệp vụ số 6: Mã chi nhánh, báo giá phải xác định là chi nhánh nào
			-- thì mới tính lãi lỗ dự án và phân bổ chi phí được
					AND ISNULL(O3.Ana06ID, '') != ''
		-- Kết bảng để lấy dữ liệu Tiền giảm giá trên tổng tiền của báo giá
		INNER JOIN SOT2062 S1 WITH (NOLOCK) ON S1.APK_OT2101 = O2.APK
		-- Kết bảng báo giá kế thừa để lấy tỷ giá
		INNER JOIN OT2101 OT01 WITH (NOLOCK) ON OT01.DivisionID = O1.DivisionID
												AND OT01.QuotationID = O3.InheritVoucherID
	WHERE O1.ProjectID = @ProjectID
	ORDER BY O2.QuotationID

	-- TEST
	--SELECT 'TEST' AS TEST, * FROM @TableData

	-- Trường hợp bảng báo giá khai báo cho chi nhánh khác VPSG thì bật cờ để xử lý dữ liệu cho chi nhánh con
	IF EXISTS(SELECT TOP 1 1 FROM @TableData WHERE ISNULL(Branch, '') != @BranchDefault)
		SET @IsSubBranch = 1

	-- Nạp dữ liệu của Group A trong báo cáo
	INSERT INTO @QuotationData
	(
		DivisionID
		, ProjectID
		, Branch
		, TotalAfterTax
		, TotalBeforeTax
		, VATTax
	)
	SELECT DivisionID
			, ProjectID
			, Branch
			, ((SUM(ISNULL(Quantity, 0) * ISNULL(UnitPrice, 0) * ExchangeRate * Coefficient) - DiscountAmount) * 1.1) AS TotalAfterTax
			, (SUM(ISNULL(Quantity, 0) * ISNULL(UnitPrice, 0) * ExchangeRate * Coefficient) - DiscountAmount) AS TotalBeforeTax
			, ((SUM(ISNULL(Quantity, 0) * ISNULL(UnitPrice, 0) * ExchangeRate * Coefficient) - DiscountAmount) * 0.1) AS VATTax
	FROM @TableData
	GROUP BY DivisionID
			, ProjectID
			, Branch
			, DiscountAmount
	
	INSERT INTO @Result
	SELECT T1.DivisionID, NULL AS VoucherNo, T1.ProjectID
		, NULL AS STT
		, ISNULL(A1.Name, T1.Name) AS ID
		, ISNULL(A1.Name, T1.Name) AS Name
		, SUM(T1.AmountTotal) AS AmountTotal
		, T1.Branch
		, 'A' TypeData
		, CASE T1.Name
			WHEN 'TotalAfterTax' THEN @GroupType
			ELSE 'Record'
		  END AS RecordType
		, 'OOT2100' AS DTable
		, 0 AS Row
	FROM ( 
			SELECT DivisionID
					, ProjectID
					, Branch
					, TotalBeforeTax
					, VATTax
					, TotalAfterTax
			FROM @QuotationData) Q
			UNPIVOT (AmountTotal FOR Name IN (TotalBeforeTax, VATTax, TotalAfterTax)
		) AS T1
		LEFT JOIN A00001 A1 WITH (NOLOCK) ON A1.FormID = @ScreenID 
												AND LanguageID = @LanguageID 
												AND A1.ID = CONCAT(@ScreenID, T1.Name)
	Group by T1.DivisionID
			, T1.ProjectID
			, A1.Name
			, T1.Name
			, T1.Branch
END

-- ## Xử lý dữ liệu 3. Chi phí dự án ##
-- Sử dụng dữ liệu của nghiệp vụ Phiếu chi
BEGIN
	DECLARE @ProjectAnaTypeID VARCHAR(50),
			@CostAnaTypeID VARCHAR(50),
			@DepartmentAnaTypeID VARCHAR(50),
			@BranchAnaTypeID VARCHAR(50),
			@CostDetailID VARCHAR(50)

	-- Table chứ dữ liệu Get từ phiếu chi
	DECLARE @tbl_ResultTemp TABLE
	(
		DivisionID VARCHAR(50),
		VoucherID NVARCHAR(MAX),
		TranMonth INT,
		TranYear INT,
		VoucherDate DATETIME,
		TransactionTypeID NVARCHAR(MAX),
		ProjectAnaTypeID NVARCHAR(MAX), 
		CostAnaTypeID NVARCHAR(MAX),
		DepartmentAnaTypeID NVARCHAR(MAX),
		BranchAnaTypeID NVARCHAR(MAX),
		OriginalAmount DECIMAL(28, 8)
	)

	-- Lấy thiết lập Mã phân tích theo DivisionID
	SELECT TOP 1 @ProjectAnaTypeID = ProjectAnaTypeID
		, @CostAnaTypeID = CostAnaTypeID
		, @DepartmentAnaTypeID = DepartmentAnaTypeID
		, @BranchAnaTypeID = 'A06'
	FROM AT0000
	WHERE DefDivisionID = @DivisionID

	-- Lấy dữ liệu từ các phiếu chi của dự án
	IF ISNULL(@ProjectAnaTypeID, '') != '' 
		AND ISNULL(@CostAnaTypeID, '') != '' 
		AND ISNULL(@DepartmentAnaTypeID, '') != ''
	BEGIN
		SET @CostDetailID = @CostAnaTypeID
		SET @ProjectAnaTypeID = REPLACE(@ProjectAnaTypeID, 'A', 'Ana') + 'ID'
		SET @CostAnaTypeID = REPLACE(@CostAnaTypeID, 'A', 'Ana') + 'ID'
		SET @DepartmentAnaTypeID = REPLACE(@DepartmentAnaTypeID, 'A', 'Ana') + 'ID'
		SET @BranchAnaTypeID = REPLACE(@BranchAnaTypeID, 'A', 'Ana') + 'ID'

		--SET @sSQL = N'
		--SELECT T1.DivisionID
		--	   , ' + @ProjectAnaTypeID + ' AS ProjectID
		--	   , NULL AS STT
		--	   , ' + @CostAnaTypeID + ' AS ID
		--	   , UPPER(A1.AnaName) AS Name
		--	   , SUM(T1.ConvertedAmount) AS AmountTotal
		--	   , ' + @BranchAnaTypeID + ' AS BranchID
		--	   , ''C'' AS TypeData
		--	   , ''Record'' AS RecordType
		--	   , ''AT9000'' AS DTable
		--FROM AT9000 T1 WITH (NOLOCK)
		--INNER JOIN AT1011 A1 WITH (NOLOCK) ON A1.DivisionID = T1.DivisionID AND T1.' + @CostAnaTypeID + ' = A1.AnaID
		--INNER JOIN AT0000 A0 WITH (NOLOCK) ON A0.DefDivisionID = A1.DivisionID AND A0.CostAnaTypeID =  A1.AnaTypeID
		---- Lấy dữ liệu phiếu chi và phiếu xuất kho hàng hóa để tính chi phí dự án
		--WHERE (T1.TransactionTypeID IN (''T02'', ''T22'', ''T99'') OR T1.TableID = ''AT2006'')
		--	AND ' + @ProjectAnaTypeID + ' = ''' + @ProjectID + '''
		--	AND ' + @CostAnaTypeID + ' IS NOT NULL
		--	--AND ' + @DepartmentAnaTypeID + ' IS NOT NULL
		--	AND ' + @BranchAnaTypeID + ' IS NOT NULL
		--	AND VoucherID NOT IN (SELECT TVoucherID FROM AT9000 WHERE TransactionTypeID=''T01'' AND ' + @ProjectAnaTypeID + ' = ''' + @ProjectID + ''' AND ISNULL(TVoucherID,'''') <> '''')
		--GROUP BY T1.DivisionID, ' + @ProjectAnaTypeID + ', ' + @CostAnaTypeID + ', A1.AnaName, ' + @BranchAnaTypeID + ' '

		---- Insert toàn bộ dữ liệu phiếu chi vào bảng tạm
		--INSERT INTO @Result
		--EXEC (@sSQL)
		--PRINT(@sSQL)
		
		
		SET @sSQL = N'
		SELECT T1.DivisionID, VoucherNo
			   , ' + @ProjectAnaTypeID + ' AS ProjectID
			   , NULL AS STT
			   , ' + @CostAnaTypeID + ' AS ID
			   , UPPER(A1.AnaName) AS Name
			   , SUM(T1.ConvertedAmount) AS AmountTotal
			   , ' + @BranchAnaTypeID + ' AS BranchID
			   , ''C'' AS TypeData
			   , ''Record'' AS RecordType
			   , ''AT9000'' AS DTable
		INTO #Temp00
		FROM AT9000 T1 WITH (NOLOCK)
		INNER JOIN AT1011 A1 WITH (NOLOCK) ON A1.DivisionID = T1.DivisionID AND T1.' + @CostAnaTypeID + ' = A1.AnaID
		INNER JOIN AT0000 A0 WITH (NOLOCK) ON A0.DefDivisionID = A1.DivisionID AND A0.CostAnaTypeID =  A1.AnaTypeID
		-- Lấy dữ liệu phiếu chi và phiếu xuất kho hàng hóa để tính chi phí dự án
		WHERE (T1.TransactionTypeID IN (''T02'', ''T22'', ''T99'') OR T1.TableID = ''AT2006'')
			AND ' + @ProjectAnaTypeID + ' = ''' + @ProjectID + '''
			AND ' + @CostAnaTypeID + ' IS NOT NULL
			--AND ' + @DepartmentAnaTypeID + ' IS NOT NULL
			AND ' + @BranchAnaTypeID + ' IS NOT NULL
			AND VoucherID NOT IN (SELECT TVoucherID FROM AT9000 WHERE TransactionTypeID=''T01'' AND ' + @ProjectAnaTypeID + ' = ''' + @ProjectID + ''' AND ISNULL(TVoucherID,'''') <> '''')
		GROUP BY T1.DivisionID,  VoucherNo, ' + @ProjectAnaTypeID + ', ' + @CostAnaTypeID + ', A1.AnaName, ' + @BranchAnaTypeID + '
		
		SELECT  T00.*,
				(SELECT COUNT(ID) FROM #Temp00 WHERE ID = T00.ID GROUP BY ID) AS Row
		INTO #Temp01
		FROM #Temp00 T00
		
		SELECT * FROM #Temp01
		'
		INSERT INTO @Result
		EXEC (@sSQL)

		----- Xử lý lấy danh sách số chứng từ -----
		DECLARE @VoucherNoList NVARCHAR (MAX) = '',
				@Query NVARCHAR (MAX) = '',
				@VoucherNo NVARCHAR (250),
				@ID NVARCHAR (250)

		DECLARE cursorIDList CURSOR FOR
		SELECT ID FROM @Result WHERE Row > 0 GROUP BY ID
		open cursorIDList
		FETCH NEXT FROM cursorIDList INTO @ID
		WHILE @@FETCH_STATUS = 0
		BEGIN
		   DECLARE cursorVoucherNoList CURSOR FOR
		   SELECT VoucherNo FROM @Result WHERE ID = @ID
		   open cursorVoucherNoList
		   FETCH NEXT FROM cursorVoucherNoList INTO @VoucherNo
		   WHILE @@FETCH_STATUS = 0
		   BEGIN
			  PRINT @VoucherNo
			  SET @VoucherNoList = Concat(@VoucherNoList,@VoucherNo,', ')
		      
		      FETCH NEXT FROM cursorVoucherNoList
		             INTO @VoucherNo
		   END
		   
		   CLOSE cursorVoucherNoList
		   DEALLOCATE cursorVoucherNoList 

		   Update @Result
		   SET VoucherNo = SUBSTRING(@VoucherNoList,1,LEN(@VoucherNoList)-1)
		   WHERE ID = @ID
	       SET @VoucherNoList=''

		   FETCH NEXT FROM cursorIDList
		          INTO @ID
		END
		CLOSE cursorIDList
		DEALLOCATE cursorIDList 
	END
END

-- ## Cập nhật dữ liệu sau khi tổng hợp các dữ liệu thô
BEGIN
	-- Cập nhật mục Chi phí dự án
	INSERT INTO @Result 
	(
		DivisionID
		, ProjectID
		, STT
		, ID
		, Name
		, AmountTotal
		, Branch
		, TypeData
		, RecordType
	)
	SELECT T1.DivisionID
			, ProjectID
			, NULL AS STT
			, N'TotalProjectCost' AS ID
			, N'Tổng Chi phí dự án' AS Name
			, SUM(AmountTotal) AS AmountTotal
			, Branch
			, 'B'
			, 'Group'
	FROM @Result T1
	WHERE DTable = 'AT9000'
	GROUP BY T1.DivisionID, ProjectID, Branch

	-- Tiền thu vào
	SELECT DivisionID, ProjectID, Branch, SUM(AmountTotal) AS AmountTotal
	INTO #TableProceed
	FROM @Result
	WHERE ID IN ('TotalBeforeTax', 'Discount')
	GROUP BY DivisionID, ProjectID, Branch

	-- Tiền chi
	SELECT DivisionID, ProjectID, Branch, SUM(AmountTotal) AS AmountTotal
	INTO #TableSpend
	FROM @Result
	WHERE DTable = 'AT9000'
	GROUP BY DivisionID, ProjectID, Branch

	-- Tính tổng lợi nhuận dự án
	INSERT INTO @Result 
	(
		DivisionID
		, ProjectID
		, STT
		, ID
		, Name
		, AmountTotal
		, Branch
		, TypeData
		, RecordType
		, DTable
	)
	SELECT T1.DivisionID
			, T1.ProjectID
			, NULL AS STT
			, N'Profit' AS ID
			, N'Profit' AS Name
			, T1.AmountTotal - T2.AmountTotal
			, T1.Branch
			, 'D'
			, @GroupType
			, '' AS DTable
	FROM #TableProceed T1
		INNER JOIN #TableSpend T2 ON T1.DivisionID = T2.DivisionID 
										AND T1.ProjectID = T2.ProjectID 
										AND T1.Branch = T2.Branch

	-- Lấy ngôn ngữ các tiêu đề từ bảng A00001
	SELECT T1.DivisionID
			, T1.VoucherNo
			, T1.ProjectID
			, T1.STT
			, T1.ID
			, ISNULL(A1.Name, T1.Name) AS Name
			, T1.AmountTotal
			, T1.Branch
			, T1.TypeData
			, T1.RecordType
			, T1.DTable
			, T1.Row
	INTO #TempResult
	FROM @Result T1
		LEFT JOIN A00001 A1 WITH (NOLOCK) ON A1.FormID = @ScreenID 
												AND LanguageID = @LanguageID 
												AND A1.ID = CONCAT(@ScreenID, '.', T1.ID)

	DELETE @Result

	INSERT INTO @Result
	SELECT * FROM #TempResult
END

-- ## Trả kết quả về cho Report ##
BEGIN
	SELECT *
	INTO #TableResult
	FROM @Result

	DECLARE @ListBrand NVARCHAR(MAX)

	-- Lấy danh sách chi nhánh tồn tại trong dự án
	SELECT @ListBrand = STUFF((SELECT DISTINCT ',' + Branch FROM #TableResult FOR XML PATH('')), 1, 1, '')
	--PRINT (@ListBrand)

	SET @sSQL = '
	SELECT *
	FROM (
		SELECT T1.DivisionID
				, T1.VoucherNo
				, T1.ProjectID
				, O1.ProjectName
				, A1.FullName AS LeaderName
				, O1.StartDate
				, O1.EndDate
				, O1.CheckingDate
			    , ROW_NUMBER() OVER (ORDER BY T1.TypeData, T1.RecordType) AS STT
			    , T1.ID
				, T1.Name
				, SUM(T1.AmountTotal) AS AmountTotal
				, NULL AS TypeData
				, T1.RecordType
				, T1.Branch
		FROM #TableResult T1
			LEFT JOIN OOT2100 O1 WITH (NOLOCK) ON T1.ProjectID = O1.ProjectID
			LEFT JOIN AT1103 A1 WITH (NOLOCK) ON O1.LeaderID = A1.EmployeeID
		GROUP BY T1.DivisionID
				, T1.VoucherNo
				, T1.ProjectID
				, O1.ProjectName
				, A1.FullName
				, O1.StartDate
				, O1.EndDate
				, O1.CheckingDate
				, T1.TypeData, T1.RecordType
			    , T1.ID
				, T1.Name
				, T1.RecordType
				, T1.Branch
	) AS T1
	PIVOT 
	(
		MAX(AmountTotal)
		FOR Branch IN (' + @ListBrand + ')
	) AS T2
	ORDER BY T2.DivisionID, T2.STT, T2.ProjectID, T2.TypeData '

	EXEC (@sSQL)
	--PRINT(@sSQL)
END



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
