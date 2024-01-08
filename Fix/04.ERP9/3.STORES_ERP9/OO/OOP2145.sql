IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2145]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2145]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO















-- <Summary>
---- Get dữ liệu thực chi cho báo cáo định mức dự án
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
-- Create on 22/10/2019 by Đình Ly
-- Modified on 25/03/2020 by Vĩnh Tâm:
--	+ Lấy dữ liệu thông tin dự án
--	+ Lấy thêm sản phẩm từ Phiếu xuất kho tại AT9000 (TableID = AT2006)
-- Modified on 10/11/2020 by Trọng Kiên: Fix lỗi replace mã phân tích khi in báo cáo
-- Modified on 17/06/2021 by Nhựt Trường: Lấy thêm sản phẩm từ phiếu bút toán tổng hợp tại AT9000 (TransactionTypeID = T99) khi lấy dữ liệu chi thực tế.
-- Modified on 16/07/2021 by Nhựt Trường: Không lấy các phiếu chi đã được kế thùa từ phiếu thu dự án.
-- Modified on 21/07/2021 by Nhựt Trường: Bổ sung kiểm tra null/rỗng khi lấy dữ liệu phiếu thu.
-- <Example> Exec OOP21400 @QuotationNo = 'BPC/11/2019/00006'

CREATE PROCEDURE [dbo].[OOP2145]
(
	@DivisionID VARCHAR(50),
	@ProjectID VARCHAR(50)
)
AS
	DECLARE @ProjectAnaTypeID VARCHAR(50),
		@CostDetailAnaTypeID VARCHAR(50),
		@DepartmentAnaTypeID VARCHAR(50),
		@sSQL NVARCHAR(MAX) = ''

	-- Table chứ dữ liệu Get từ phiếu chi
	DECLARE @tbl_ResultTemp TABLE
	(
		VoucherID NVARCHAR(MAX),
		TranMonth INT,
		TranYear INT,
		VoucherDate DATETIME,
		TransactionTypeID NVARCHAR(MAX),
		ProjectAnaTypeID NVARCHAR(MAX), 
		CostDetailAnaTypeID NVARCHAR(MAX),
		DepartmentAnaTypeID NVARCHAR(MAX),
		OriginalAmount DECIMAL(28, 8)
	)

	DECLARE @tbl_Result TABLE
	(
		VoucherID NVARCHAR(MAX),
		CostDetailAnaTypeID NVARCHAR(MAX),
		OriginalAmount DECIMAL(28, 8),
		TypeData INT
	)

	-- Lấy thêm thông tin Mã dự án, Tên dự án để hiển thị lên báo cáo
	INSERT INTO @tbl_Result (CostDetailAnaTypeID, OriginalAmount, TypeData)
	SELECT O1.ProjectID + ' - ' + O1.ProjectName, 0.0, 0
	FROM OOT2100 O1 WITH (NOLOCK)
	WHERE O1.ProjectID = @ProjectID

	SELECT TOP 1 @ProjectAnaTypeID = ProjectAnaTypeID
		, @CostDetailAnaTypeID = CostDetailAnaTypeID
		, @DepartmentAnaTypeID = DepartmentAnaTypeID
	FROM AT0000 WITH (NOLOCK)
	WHERE DefDivisionID = @DivisionID

	IF ISNULL(@ProjectAnaTypeID, '') != ''
	AND ISNULL(@CostDetailAnaTypeID, '') != ''
	AND ISNULL(@DepartmentAnaTypeID, '') != ''
	BEGIN
		SET @ProjectAnaTypeID = REPLACE(@ProjectAnaTypeID, 'A', 'Ana') + 'ID'
		SET @CostDetailAnaTypeID = REPLACE(@CostDetailAnaTypeID, 'A', 'Ana') + 'ID'
		SET @DepartmentAnaTypeID = REPLACE(@DepartmentAnaTypeID, 'A', 'Ana') + 'ID'

		SET @sSQL = N'
		SELECT VoucherID, TranMonth, TranYear, VoucherDate, TransactionTypeID
			, ' + @ProjectAnaTypeID + ' AS ProjectAnaTypeID
			, ' + @CostDetailAnaTypeID + ' AS CostDetailAnaTypeID
			, ' + @DepartmentAnaTypeID + ' AS DepartmentAnaTypeID
			, OriginalAmount
			--, Ana01ID, Ana04ID, Ana07ID
		FROM AT9000 A1 WITH (NOLOCK)
		WHERE (A1.TransactionTypeID IN (''T02'', ''T22'', ''T99'') OR A1.TableID = ''AT2006'')
			AND ' + @ProjectAnaTypeID + ' = ''' + @ProjectID + '''
			AND ' + @CostDetailAnaTypeID + ' IS NOT NULL
			--AND ' + @DepartmentAnaTypeID + ' IS NOT NULL
			AND VoucherID NOT IN (SELECT TVoucherID FROM AT9000 WHERE TransactionTypeID=''T01'' AND ' + @ProjectAnaTypeID + ' = ''' + @ProjectID + ''' AND ISNULL(TVoucherID,'''') <> '''')
		ORDER BY TranMonth, TranYear, VoucherDate, VoucherNo'

		INSERT INTO @tbl_ResultTemp 
		EXEC (@sSQL)

		-- Get dữ liệu lần chi thứ 1
		SELECT TOP 1 VoucherID, CostDetailAnaTypeID, OriginalAmount, '1' AS TypeData INTO #OneTime 
		FROM @tbl_ResultTemp
		-- Insert dữ liệu lần chi thứ 1
		INSERT INTO @tbl_Result
		SELECT O1.VoucherID, O1.CostDetailAnaTypeID, SUM(O1.OriginalAmount), O2.TypeData
		FROM @tbl_ResultTemp O1
			INNER JOIN #OneTime O2 ON O1.VoucherID = O2.VoucherID
		WHERE O1.VoucherID = O2.VoucherID
		GROUP BY O1.VoucherID, O1.CostDetailAnaTypeID, TypeData

		-- Get dữ liệu lần chi thứ 2
		SELECT TOP 1 VoucherID, CostDetailAnaTypeID, OriginalAmount, '2' AS TypeData INTO #TwoTime 
		FROM @tbl_ResultTemp
		WHERE VoucherID != (SELECT VoucherID FROM #OneTime) 
		-- Insert dữ liệu lần chi thứ 2
		INSERT INTO @tbl_Result
		SELECT O1.VoucherID, O1.CostDetailAnaTypeID, SUM(O1.OriginalAmount), O2.TypeData
		FROM @tbl_ResultTemp O1
			INNER JOIN #TwoTime O2 ON O1.VoucherID = O2.VoucherID
		WHERE O1.VoucherID = O2.VoucherID
		GROUP BY O1.VoucherID, O1.CostDetailAnaTypeID, TypeData
		
		-- Get dữ liệu lần chi thứ 3 (tổng những lần còn lại) vào bảng tạm
		INSERT INTO @tbl_Result(CostDetailAnaTypeID, OriginalAmount, TypeData)
		SELECT O1.CostDetailAnaTypeID, SUM(O1.OriginalAmount), '3' AS TypeData 
		FROM @tbl_ResultTemp O1
		WHERE O1.VoucherID != (SELECT TOP 1 VoucherID FROM #OneTime)
		  AND O1.VoucherID != (SELECT TOP 1 VoucherID FROM #TwoTime)
		GROUP BY O1.CostDetailAnaTypeID

		-- Get dữ liệu cột tổng
		INSERT INTO @tbl_Result(CostDetailAnaTypeID, OriginalAmount, TypeData)
		SELECT CostDetailAnaTypeID, SUM(OriginalAmount), '4' AS TypeData 
		FROM @tbl_Result
		WHERE ISNULL(TypeData, 0) != 0
		GROUP BY CostDetailAnaTypeID

		-- Select all dữ liệu
		SELECT * FROM @tbl_Result
	END



















GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
