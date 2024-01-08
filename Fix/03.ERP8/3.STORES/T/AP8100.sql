IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP8100]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP8100]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Xử lý kiểm tra dữ liệu Import có hợp lệ
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 05/10/2011 by Nguyễn Bình Minh
---- Modified on 19/09/2013 by Bảo Anh: Bổ sung kiểm tra đơn vị và kỳ kế toán cho ASOFT-HRM
---- Modified on 24/11/2015 by Phương Thảo: Sửa lỗi kiểm tra bắt buộc nhập
---- Modified by Bảo Thy on 30/05/2016: Bổ sung WITH (NOLOCK)
---- Modified by Phương Thảo on 04/01/2017: Chỉnh sửa kiểm tra đồng nhất dữ liệu (bổ sung order by fix lỗi nếu dòng dữ liệu không liên tiếp)
---- Modified by Bảo Anh on 27/05/2017: Sửa danh mục dùng chung
---- Modified by Hải Long on 21/08/2017: Bổ sung kiểm tra có phải kỳ kế toán đầu tiên hay không
---- Modified by Hải Long on 08/03/2018: Fix bug kiểm tra kỳ kế toán có phải kỳ đầu tiên hay không
---- Modified on 07/06/2018 by Bảo Anh: Bổ sung kiểm tra CreditAccountID phải là TK tồn kho không
---- Modified on 02/07/2019 by Kim Thư: Bổ sung kiểm tra CreditAccountID ở table AT1312 - DS tài khoản thêm
---- Modified on 22/07/2019 by Kim Thư: Bổ sung kiểm tra Đối tượng có thuộc Division hiện tại hay không
---- Modified on 30/06/2020 by Huỳnh Thử: Bổ sung kiểm tra nhân viên đã có trong hồ sơ tính lương, Kiểm tra nhân viên duplicate, Kiểm tra nhân viên đã có trong bảng công tháng chưa
---- Modified on 03/08/2020 by Lê Hoàng: Bổ sung kiểm tra tài khoản Chi phí trả trước trong khai báo phân bổ AF0052 thuộc danh mục định nghĩa Tài khoản phân bổ Chi phí trả trước AF0007
---- Modified on 21/08/2020 by Thành Luân: Fix kiểu dữ liệu @CustomerName từ TINYINT => INT. Do TINYINT sẽ bị lỗi khi CustomerIndex = -1.
---- Modified on 04/09/2020 by Huỳnh Thử: Where theo Division lấy trong file Execl. Cải thiện tốc độ
---- Modified on 04/09/2020 by Lê Hoàng: Kiểm tra trùng mã Công cụ dụng cụ
---- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
---- Modified by Đức Thông   on 06/01/2021: 2020/12/IS/0249: [NKTTN] Cải tiến xử lí kiểm tra trùng sct
---- Modified by Đức Thông   on 25/01/2021: 2021/01/IS/0115: [Phúc Long] Bỏ sung kiểm tra trùng số chứng từ phiếu xuất kho
---- Nodified by Nhựt Trường on 19/04/2021: Customer MEKIO: Thêm cột Invoicecheck vào bảng tạm #data để check đối tượng + hóa đơn + serial thì mới đồng bộ thông tin.\
---- Modified on 02/06/2021 by Lê Hoàng: Bổ sung CheckDuplicateInTable-Kiểm tra trùng mã trong bảng(ColID: cột Mã trong file import, Param1: Bảng cần kiểm tra, Param2: cột mã trong bảng Param1)
---- Modified on 12/07/2021 by Huỳnh Thử: Cải tiến tốc độ -- CheckDuplicateOtherVoucherNo -- CASE WHEN @Param2 = 'AT9000' THEN '#AT9000' ELSE @Param2 END

-- <Example>
---- 
CREATE PROCEDURE [DBO].[AP8100]
(	
	@UserID AS NVARCHAR(50),
	@ImportTemplateID AS NVARCHAR(50),
	@CheckCode AS NVARCHAR(200),
	@Module AS NVARCHAR(200) = 'ASOFT-T',
	@ColID AS NVARCHAR(50),	 		
	@Param1 AS NVARCHAR(1000) = '',
	@Param2 AS NVARCHAR(1000) = '', 
	@Param3 AS NVARCHAR(1000) = '', 
	@Param4 AS NVARCHAR(1000) = '', 
	@Param5 AS NVARCHAR(1000) = '',
	@ObligeCheck AS TINYINT = 0, -- Nếu = 0, thì nếu cột đó = Null hoặc rỗng sẽ không kiểm tra
	@SQLWhere AS NVARCHAR(4000) = '', -- Điều kiện lọc trên #DATA
	@SQLFilter AS NVARCHAR(4000) = '' -- Điều kiện lọc trên dữ liệu chi tiết
)
AS
SET NOCOUNT ON
DECLARE @ColumnName AS NVARCHAR(50)
DECLARE @sSQL AS NVARCHAR(MAX)
DECLARE @ParamList VARCHAR(8000),
		@SetParamList VARCHAR(8000),
		@ParamCondit VARCHAR(8000),
		@sSQLTemp VARCHAR(8000),
		@CustomerName INT,
		@DivisionID NVARCHAR(50)

SELECT @CustomerName = CustomerName FROM dbo.CustomerIndex



SELECT		TLD.ColID, TLD.DataCol, BTL.ColSQLDataType 
INTO		#Columns
FROM		A01066 TLD WITH (NOLOCK)
INNER JOIN	A01065 TL WITH (NOLOCK)
		ON	TL.ImportTemplateID = TLD.ImportTemplateID
INNER JOIN	A00065 BTL WITH (NOLOCK)
		ON	BTL.ImportTransTypeID = TL.ImportTransTypeID AND BTL.ColID = TLD.ColID
WHERE		TL.ImportTemplateID = @ImportTemplateID
		
SELECT	TOP 1 @ColumnName = DataCol
FROM	A01066 WITH (NOLOCK)
WHERE	ImportTemplateID = @ImportTemplateID AND ColID = @ColID

--IF @CheckCode NOT IN ('')
--	RETURN
-- Thêm cột Invoicecheck vào bảng tạm #data để check đối tượng + hóa đơn + serial thì mới đồng bộ thông tin.
IF(@ColID = 'InvoiceCheck')
	INSERT INTO #Columns VALUES ('InvoiceCheck', '', 'nvarchar(500)')
	
-------- Kiểm tra đơn vị
IF @CheckCode = 'CheckValidDivision'
BEGIN
	SET @sSQL = 
	'	UPDATE	#DATA 
		SET		ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '''' THEN ''\n'' ELSE '''' END + ''ASML000071 {0}=''''' + @ColumnName + '''''''
		WHERE	' + @ColID + ' NOT IN (SELECT DivisionID FROM ' + CASE	WHEN @Module  = 'ASOFT-T' THEN 'AT9999' 
																			WHEN @Module  = 'ASOFT-FA' THEN 'FT9999 WITH (NOLOCK)'
																			WHEN @Module  = 'ASOFT-M' THEN 'MT9999 WITH (NOLOCK)'
																			WHEN @Module  = 'ASOFT-OP' THEN 'OT9999 WITH (NOLOCK)'
																			WHEN @Module  = 'ASOFT-WM' THEN 'WT9999 WITH (NOLOCK)'
																			WHEN @Module  = 'ASOFT-HRM' THEN 'HT9999 WITH (NOLOCK)'
																		ELSE 'AT9999 WITH (NOLOCK)' END + '
		     	                           WHERE Closing = 0 ' + CASE WHEN @SQLFilter <> '' THEN ' AND ' + @SQLFilter ELSE '' END + ')
		     	' + CASE WHEN @SQLWhere <> '' THEN ' AND (' + @SQLWhere + ')' ELSE '' END
END

-------- Kiểm tra kỳ kế toán
IF @CheckCode = 'CheckValidPeriod'
BEGIN
	SET @sSQL = 
	'	UPDATE	#DATA
		SET		ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '''' THEN ''\n'' ELSE '''' END + ''ASML000072 {0}=''''' + @ColumnName + '''''''
		WHERE	' + @ColID + ' NOT IN (SELECT REPLACE(STR(TranMonth, 2), '' '', ''0'') + ''/'' + STR(TranYear, 4)
		     	                           FROM ' + CASE	WHEN @Module  = 'ASOFT-T' THEN 'AT9999  WITH (NOLOCK)' 
															WHEN @Module  = 'ASOFT-FA' THEN 'FT9999  WITH (NOLOCK)'
															WHEN @Module  = 'ASOFT-M' THEN 'MT9999  WITH (NOLOCK)'
															WHEN @Module  = 'ASOFT-OP' THEN 'OT9999  WITH (NOLOCK)'
															WHEN @Module  = 'ASOFT-WM' THEN 'WT9999  WITH (NOLOCK)'
															WHEN @Module  = 'ASOFT-HRM' THEN 'HT9999  WITH (NOLOCK)'
													ELSE 'AT9999  WITH (NOLOCK)' END + '
											WHERE Closing = 0 ' + CASE WHEN @SQLFilter <> '' THEN ' AND ' + @SQLFilter ELSE '' END + ')
		     	' + CASE WHEN @SQLWhere <> '' THEN ' AND (' + @SQLWhere + ')' ELSE '' END
END

-------- Kiểm tra loại phiếu
IF @CheckCode = 'CheckValidVoucherType'
BEGIN
	SET @sSQL = 
	'	UPDATE	DT
		SET		ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '''' THEN ''\n'' ELSE '''' END + ''ASML000073 {0}=''''' + @ColumnName + '''''''
	 	FROM	#DATA DT		
	 	WHERE	NOT EXISTS (SELECT	TOP 1 1  
		     	            FROM	AT1007 V  WITH (NOLOCK) 
		     	            WHERE	V.Disabled = 0 AND V.DivisionID = DT.DivisionID AND V.VoucherTypeID = DT.' + @ColID 
		     									+ CASE WHEN @SQLFilter <> '' THEN ' AND ' + @SQLFilter ELSE '' END + ')
		     	' + CASE WHEN @SQLWhere <> '' THEN ' AND (' + @SQLWhere + ')' ELSE '' END
END

-------- Kiểm tra ngày phiếu
IF @CheckCode = 'CheckValidVoucherDate'
BEGIN
	SET @sSQL = 
	'	UPDATE	#DATA
		SET		ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '''' THEN ''\n'' ELSE '''' END + ''ASML000074 {0}=''''' + @ColumnName + '''''''
		WHERE	RIGHT(CONVERT(VARCHAR(10),' + @ColID + ', 103), 7) <> Period
				' + CASE WHEN @SQLWhere <> '' THEN ' AND (' + @SQLWhere + ')' ELSE '' END
END

-------- Kiểm tra nhân viên
IF @CheckCode = 'CheckValidEmployee'
BEGIN
	SET @sSQL = 
	'	UPDATE	DT
		SET		ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '''' THEN ''\n'' ELSE '''' END + ''ASML000075 {0}=''''' + @ColumnName + '''''''
	 	FROM	#DATA DT		
		WHERE	' + CASE WHEN @ObligeCheck = 0 THEN 'ISNULL(' + @ColID + ', '''') <> '''' AND ' ELSE '' END +
				' NOT EXISTS (SELECT	TOP 1 1
				              FROM		AT1103 E  WITH (NOLOCK)
				              WHERE		E.Disabled = 0 AND E.EmployeeID = DT.' + @ColID
				                   + CASE WHEN @SQLFilter <> '' THEN ' AND ' + @SQLFilter ELSE '' END + ')
		     	' + CASE WHEN @SQLWhere <> '' THEN ' AND (' + @SQLWhere + ')' ELSE '' END
END

-------- Kiểm tra nhân viên
IF @CheckCode = 'CheckValidEmployee' AND @ImportTemplateID ='TimekeepingMonth'
BEGIN

	SET @sSQL = 
	'	UPDATE	DT
		SET		ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '''' THEN ''\n'' ELSE '''' END + ''ASML000075 {0}=''''' + @ColumnName + '''''''
	 	FROM	#DATA DT		
		WHERE	' + CASE WHEN @ObligeCheck = 0 THEN 'ISNULL(' + @ColID + ', '''') <> '''' AND ' ELSE '' END +
				' NOT EXISTS (SELECT	TOP 1 1
				              FROM		HT2400 E  WITH (NOLOCK)
				              WHERE		E.EmployeeID = DT.' + @ColID +' AND E.TranMonth = CONVERT(INT, SUBSTRING(DT.Period,0,3))
																		AND E.TranYear =  CONVERT(INT, SUBSTRING(DT.Period,4,4))'
				                   + CASE WHEN @SQLFilter <> '' THEN ' AND ' + @SQLFilter ELSE '' END + ')
		     	' + CASE WHEN @SQLWhere <> '' THEN ' AND (' + @SQLWhere + ')' ELSE '' END
END

-------- Kiểm tra nhân viên duplicate
IF @CheckCode = 'CheckValidEmployeeDuplicate' AND @ImportTemplateID ='TimekeepingMonth'
BEGIN
SET @sSQL = '
	SELECT		MIN(Row) AS Row, ' + @ColID + '
	INTO		#AP8100
	FROM		#DATA
	GROUP BY	' + @ColID + '

	UPDATE		DT 
	SET			ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '''' THEN ''\n'' ELSE '''' END + ''ASML000087 {0}=''''' + @ColumnName + '''''''
	FROM		#DATA DT
	INNER JOIN	#AP8100 VN
			ON	VN.' + @ColID + ' = DT.' + @ColID + ' AND VN.Row < DT.Row'
	+ CASE WHEN @SQLWhere <> '' THEN ' WHERE ' + @SQLWhere ELSE '' END
END

-------- Kiểm tra nhân viên đã có trong bảng công tháng chưa
IF @CheckCode = 'CheckValidEmployeeHT2402' AND @ImportTemplateID ='TimekeepingMonth'
BEGIN
SET @sSQL = '
	
	UPDATE		DT 
	SET			ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '''' THEN ''\n'' ELSE '''' END + ''ASML000017 {0}=''''' + @ColumnName + '''''''
	FROM		#DATA DT
	INNER JOIN	HT2402M'+SUBSTRING(@Param1,0,3)+SUBSTRING(@Param1,4,4)+' VN
			ON	VN.' + @ColID + ' = DT.' + @ColID + ''
	+ CASE WHEN @SQLWhere <> '' THEN ' WHERE ' + @SQLWhere ELSE '' END
END

-------- Kiểm tra đối tượng
IF @CheckCode = 'CheckValidObject'
BEGIN
	SET @sSQL = 
	'	UPDATE	DT
		SET		ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '''' THEN ''\n'' ELSE '''' END + ''ASML000076 {0}=''''' + @ColumnName + '''''''
	 	FROM	#DATA DT 		
		WHERE	' + CASE WHEN @ObligeCheck = 0 THEN 'ISNULL(' + @ColID + ', '''') <> '''' AND ' ELSE '' END +
				'NOT EXISTS (SELECT TOP 1 1
				             FROM	AT1202 O WITH (NOLOCK) 
				             WHERE	O.DivisionID IN (DT.DivisionID,''@@@'') AND O.Disabled = 0 AND O.ObjectID = DT.' + @ColID
									+ CASE WHEN @SQLFilter <> '' THEN ' AND ' + @SQLFilter ELSE '' END + ')
		     	' + CASE WHEN @SQLWhere <> '' THEN ' AND (' + @SQLWhere + ')' ELSE '' END
END

-------- Kiểm tra loại tiền
IF @CheckCode = 'CheckValidCurrency'
BEGIN
	SET @sSQL = 
	'	UPDATE	DT
		SET		ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '''' THEN ''\n'' ELSE '''' END + ''ASML000077 {0}=''''' + @ColumnName + '''''''
	 	FROM	#DATA DT		
		WHERE	' + CASE WHEN @ObligeCheck = 0 THEN 'ISNULL(' + @ColID + ', '''') <> '''' AND ' ELSE '' END +
				' NOT EXISTS(SELECT TOP 1 1
				             FROM	AT1004 C  WITH (NOLOCK)
				             WHERE	C.Disabled = 0 AND C.CurrencyID = DT.' + @ColID
									+ CASE WHEN @SQLFilter <> '' THEN ' AND ' + @SQLFilter ELSE '' END + ')
		     	' + CASE WHEN @SQLWhere <> '' THEN ' AND (' + @SQLWhere + ')' ELSE '' END
END

-------- Kiểm tra tài khoản
IF @CheckCode = 'CheckValidAccount'
BEGIN
	SET @sSQL = 
	'	UPDATE	DT
		SET		ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '''' THEN ''\n'' ELSE '''' END + ''ASML000078 {0}=''''' + @ColumnName + '''''''
	 	FROM	#DATA DT 		
		WHERE	' + CASE WHEN @ObligeCheck = 0 THEN 'ISNULL(' + @ColID + ', '''') <> '''' AND ' ELSE '' END +
				' NOT EXISTS (SELECT TOP 1 1 
				              FROM AT1005 A WITH (NOLOCK)
				              WHERE A.Disabled = 0 AND A.AccountID = DT.' + @ColID
									+ CASE WHEN @SQLFilter <> '' THEN ' AND ' + @SQLFilter ELSE '' END + ')
		     	' + CASE WHEN @SQLWhere <> '' THEN ' AND (' + @SQLWhere + ')' ELSE '' END
END

-------- Kiểm tra loại hóa đơn
IF @CheckCode = 'CheckValidVATType'
BEGIN
	SET @sSQL = 
	'	UPDATE	DT
		SET		ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '''' THEN ''\n'' ELSE '''' END + ''ASML000079 {0}=''''' + @ColumnName + '''''''
	 	FROM	#DATA DT		
		WHERE	' + CASE WHEN @ObligeCheck = 0 THEN 'ISNULL(' + @ColID + ', '''') <> '''' AND ' ELSE '' END +
				' NOT EXISTS (SELECT TOP 1 1
				              FROM	AT1009 V  WITH (NOLOCK)
				              WHERE V.Disabled = 0 AND V.VATTypeID = DT.' + @ColID
									+ CASE WHEN @SQLFilter <> '' THEN ' AND ' + @SQLFilter ELSE '' END + ')
		     	' + CASE WHEN @SQLWhere <> '' THEN ' AND (' + @SQLWhere + ')' ELSE '' END
END

-------- Kiểm tra nhóm thuế
IF @CheckCode = 'CheckValidVATGroup'
BEGIN
	SET @sSQL = 
	'	UPDATE	DT
		SET		ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '''' THEN ''\n'' ELSE '''' END + ''ASML000080 {0}=''''' + @ColumnName + '''''''
	 	FROM	#DATA DT		
		WHERE	' + CASE WHEN @ObligeCheck = 0 THEN 'ISNULL(' + @ColID + ', '''') <> '''' AND ' ELSE '' END +
				' NOT EXISTS(SELECT TOP 1 1
				             FROM AT1010 V  WITH (NOLOCK)
				             WHERE V.Disabled = 0 AND V.VatGroupID = DT.' + @ColID
									+ CASE WHEN @SQLFilter <> '' THEN ' AND ' + @SQLFilter ELSE '' END + ')
		     	' + CASE WHEN @SQLWhere <> '' THEN ' AND (' + @SQLWhere + ')' ELSE '' END				                   
END

-------- Kiểm tra khoản mục
IF @CheckCode LIKE 'CheckValidAna0[1-9]' OR @CheckCode LIKE 'CheckValidAna10'
BEGIN
	SET @sSQL = 
	'	UPDATE	DT
		SET		ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '''' THEN ''\n'' ELSE '''' END + ''ASML000081 {0}=''''' + @ColumnName + '''''''
	 	FROM	#DATA DT	
		WHERE	' + CASE WHEN @ObligeCheck = 0 THEN 'ISNULL(' + @ColID + ', '''') <> '''' AND ' ELSE '' END +
				'NOT EXISTS (SELECT	TOP 1 1 
				         FROM	AT1011 A WITH (NOLOCK)
				         WHERE	A.Disabled = 0 AND A.AnaTypeID = ''A' + RIGHT(@CheckCode, 2) + ''' AND A.AnaID = DT.' + @ColID
									+ CASE WHEN @SQLFilter <> '' THEN ' AND ' + @SQLFilter ELSE '' END + ')
		     	' + CASE WHEN @SQLWhere <> '' THEN ' AND (' + @SQLWhere + ')' ELSE '' END				                   
END

-------- Kiểm tra dữ liệu này bắt buộc nhập
IF @CheckCode LIKE 'CheckObligatoryInput'
BEGIN
	SET @sSQL = 
	'	UPDATE	#DATA
		SET		ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '''' THEN ''\n'' ELSE '''' END + ''ASML000082 {0}=''''' + @ColumnName + '''''''
		WHERE	(' + @ColID + ' IS NULL OR Convert(NVarchar(500),' + @ColID +') = '''')
				' + CASE WHEN @SQLWhere <> '' THEN ' AND (' + @SQLWhere + ')' ELSE '' END
print @sSQL
END

-------- Kiểm tra dữ liệu không đồng nhất 
---- VD: Cần kiểm tra phần import master, các phần này phân biệt qua cột VoucherNo, nếu VoucherNo giống nhau thì tất cả các phần VoucherNo, VoucherTypeID, VoucherDate, VDescription cần phải giống nhau
--- EXEC AP8100 @UserID = 'ASOFTADMIN', @ImportTemplateID = '?', @CheckCode = 'CheckIdenticalValues', @ColID = 'VoucherNo', @Param1 = 'VoucherNo, VoucherTypeID, VoucherDate, VDescription', @Param5 = 'ASML000083'
IF @CheckCode = 'CheckIdenticalValues'
BEGIN			
	SET @sSQL = 
	'	
	SET ANSI_NULLS OFF
	DECLARE @cList CURSOR
	DECLARE @Row INT
	DECLARE @bIsFirst TINYINT
	DECLARE @ColumnName VARCHAR(8000)
	'
	SELECT @ParamList = '', @SetParamList = '', @ParamCondit = ''
	SELECT	@ParamCondit = @ParamCondit + CASE WHEN @ParamCondit = '' THEN '' ELSE ' AND ' END + '@' + ColID + ' = @OLD__' + ColID
	FROM	#Columns
	WHERE	CHARINDEX(',' + ColID + ',', REPLACE(',' + @ColID + ',', ' ', '')) > 0
	SET @ParamCondit = 'IF (' + @ParamCondit + ') AND @bIsFirst = 0
			BEGIN
		'

	SELECT	@sSQL = @sSQL + '
	DECLARE @' + ColID + ' ' + ColSQLDataType + '
	DECLARE @OLD__' + ColID + ' ' + ColSQLDataType,
			@ParamList = @ParamList + CASE WHEN @ParamList = '' THEN '' ELSE ',' END + '@' + ColID,
			@SetParamList = @SetParamList + CASE WHEN @SetParamList = '' THEN '' ELSE ',' END + '@OLD__' + ColID + ' = @' + ColID,
			@ParamCondit = @ParamCondit + 
				CASE WHEN CHARINDEX(',' + ColID + ',', REPLACE(',' + @ColID + ',', ' ', '')) > 0 THEN '' ELSE '
				IF @OLD__' + ColID + ' <> @' + ColID + '
					SET @ColumnName = @ColumnName + CASE WHEN @ColumnName = '''' THEN '''' ELSE '', '' END + ''' + DataCol + ''''
				END					
	FROM	#Columns
	WHERE	CHARINDEX(',' + ColID + ',', REPLACE(',' + @ColID + ',', ' ', '')) > 0


	SELECT	@sSQL = @sSQL + '
	DECLARE @' + ColID + ' ' + ColSQLDataType + '
	DECLARE @OLD__' + ColID + ' ' + ColSQLDataType,
			@ParamList = @ParamList + CASE WHEN @ParamList = '' THEN '' ELSE ',' END + '@' + ColID,
			@SetParamList = @SetParamList + CASE WHEN @SetParamList = '' THEN '' ELSE ',' END + '@OLD__' + ColID + ' = @' + ColID,
			@ParamCondit = @ParamCondit + 
				CASE WHEN CHARINDEX(',' + ColID + ',', REPLACE(',' + @ColID + ',', ' ', '')) > 0 THEN '' ELSE '
				IF @OLD__' + ColID + ' <> @' + ColID + '
					SET @ColumnName = @ColumnName + CASE WHEN @ColumnName = '''' THEN '''' ELSE '', '' END + ''' + DataCol + ''''
				END					
	FROM	#Columns
	WHERE	CHARINDEX(',' + ColID + ',', REPLACE(',' + @Param1 + ',', ' ', '')) > 0
	AND CHARINDEX(',' + ColID + ',', REPLACE(',' + @ColID + ',', ' ', '')) = 0

	SET @ParamCondit = @ParamCondit + '
				IF @ColumnName <> ''''
					UPDATE	#DATA 
					SET		ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '''' THEN ''\n'' ELSE '''' END + ''ASML000083 {0}='''''' + @ColumnName + ''''''''
					WHERE	(Row = @Row)' + CASE WHEN @SQLWhere <> '' THEN ' AND (' + @SQLWhere + ')' ELSE '' END + '
			END'
	
	SET @sSQL = @sSQL + '
	SET @bIsFirst = 1	
	SET @cList = CURSOR FAST_FORWARD READ_ONLY FOR
		SELECT		Row, ' + REPLACE(@ParamList, '@', '') + '
		FROM		#DATA
		' + CASE WHEN @SQLWhere <> '' THEN ' WHERE ' + @SQLWhere ELSE '' END + '
		ORDER BY	' + REPLACE(@ParamList, '@', '') + ', Row
	OPEN @cList
	FETCH NEXT FROM @cList INTO @Row, ' + @ParamList + '
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @ColumnName = ''''
		' + @ParamCondit + '
		ELSE
			SELECT ' + @SetParamList + '
		SET @bIsFirst = 0
			
		FETCH NEXT FROM @cList INTO @Row, ' + @ParamList + '
	END
	'	
--print @sSQL
END

-- Kiểm tra trùng phiếu
---- VD: Cần kiểm tra phần VoucherNo, khóa liên quan đến VoucherNo là VoucherID
--- EXEC AP8100 @UserID = 'ASOFTADMIN', @ImportTemplateID = '?', @CheckCode = 'CheckDuplicateVoucherNo', @ColID = 'VoucherNo', @Param1 = 'VoucherID'
IF @CheckCode = 'CheckDuplicateVoucherNo'
BEGIN
	-- Where Theo Division
	SELECT @DivisionID = DivisionID FROM #DATA
	SET @sSQL = '
	SELECT		MIN(Row) AS Row, ' + @ColID + CASE WHEN @Param1 <> '' THEN ',' + @Param1 ELSE '' END + '
	INTO		#AP8100
	FROM		#DATA
	GROUP BY	' + @ColID + CASE WHEN @Param1 <> '' THEN ',' + @Param1 ELSE '' END 
	
	IF @Param1 <> ''
		SET @sSQL = @sSQL + '
	UPDATE		DT 
	SET			ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '''' THEN ''\n'' ELSE '''' END + ''ASML000084 {0}=''''' + @ColumnName + '''''''
	FROM		#DATA DT
	INNER JOIN	#AP8100 VN
			ON	VN.' + @ColID + ' = DT.' + @ColID + ' AND VN.' + @Param1 + ' <> DT.' + @Param1 + ' AND VN.Row > DT.Row'
	+ CASE WHEN @SQLWhere <> '' THEN ' WHERE ' + @SQLWhere ELSE '' END
	
	SET @sSQL = @sSQL + '
	UPDATE		DT  
	SET			ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '''' THEN ''\n'' ELSE '''' END + ''ASML000085 {0}=''''' + @ColumnName + '''''''
	FROM		#DATA DT
	WHERE		EXISTS(SELECT TOP 1 1 FROM AT9000 AT WITH (NOLOCK) WHERE AT.DivisionID = '''+@DivisionID+''' AND AT.VoucherNo = DT.' + @ColID + CASE WHEN @SQLFilter <> '' THEN ' AND ' + @SQLFilter ELSE '' END + ')' 
	+ CASE WHEN @SQLWhere <> '' THEN ' AND (' + @SQLWhere + ')' ELSE '' END
		
END

-------- Kiểm tra tài khoản ngân hàng
IF @CheckCode = 'CheckValidBankAccount'
BEGIN
	SET @sSQL = 
	'	UPDATE	DT
		SET		ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '''' THEN ''\n'' ELSE '''' END + ''ASML000086 {0}=''''' + @ColumnName + '''''''
	 	FROM	#DATA DT		
	 	WHERE	' + CASE WHEN @ObligeCheck = 0 THEN 'ISNULL(' + @ColID + ', '''') <> '''' AND ' ELSE '' END +
	 			'NOT EXISTS (SELECT	TOP 1 1  
		     	            FROM	AT1016 B  WITH (NOLOCK)
		     	            WHERE	B.Disabled = 0 AND B.BankAccountID = DT.' + @ColID 
		     									+ CASE WHEN @SQLFilter <> '' THEN ' AND ' + @SQLFilter ELSE '' END + ')
		     	' + CASE WHEN @SQLWhere <> '' THEN ' AND (' + @SQLWhere + ')' ELSE '' END
END

-- Kiểm tra trùng mã tài sản
---- VD: Cần kiểm tra phần AssetID
--- EXEC AP8100 @UserID = 'ASOFTADMIN', @ImportTemplateID = '?', @CheckCode = 'CheckDuplicateAsset', @ColID = 'AssetID', @Param1 = 'AssetID'
IF @CheckCode = 'CheckDuplicateAsset'
BEGIN
	SET @sSQL = '
	SELECT		MIN(Row) AS Row, ' + @ColID + '
	INTO		#AP8100
	FROM		#DATA
	GROUP BY	' + @ColID + '

	UPDATE		DT 
	SET			ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '''' THEN ''\n'' ELSE '''' END + ''ASML000087 {0}=''''' + @ColumnName + '''''''
	FROM		#DATA DT
	INNER JOIN	#AP8100 VN
			ON	VN.' + @ColID + ' = DT.' + @ColID + ' AND VN.Row > DT.Row'
	+ CASE WHEN @SQLWhere <> '' THEN ' WHERE ' + @SQLWhere ELSE '' END
	
	SET @sSQL = @sSQL + '
	UPDATE		DT  
	SET			ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '''' THEN ''\n'' ELSE '''' END + ''ASML000088 {0}=''''' + @ColumnName + '''''''
	FROM		#DATA DT
	WHERE		EXISTS(SELECT TOP 1 1 FROM AT1503 F WITH (NOLOCK) WHERE F.DivisionID = DT.DivisionID AND F.AssetID = DT.' + @ColID + CASE WHEN @SQLFilter <> '' THEN ' AND ' + @SQLFilter ELSE '' END + ')' 
	+ CASE WHEN @SQLWhere <> '' THEN ' AND (' + @SQLWhere + ')' ELSE '' END		
END

-- Kiểm tra trùng mã Công cụ dụng cụ
IF @CheckCode = 'CheckDuplicateTool'
BEGIN
	SET @sSQL = '
	UPDATE		DT  
	SET			ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '''' THEN ''\n'' ELSE '''' END + ''ASML000088 {0}=''''' + @ColumnName + '''''''
	FROM		#DATA DT
	WHERE		EXISTS(SELECT TOP 1 1 FROM AT1603 F WITH (NOLOCK) WHERE F.DivisionID = DT.DivisionID AND F.ToolID = DT.' + @ColID + CASE WHEN @SQLFilter <> '' THEN ' AND ' + @SQLFilter ELSE '' END + ')' 
	+ CASE WHEN @SQLWhere <> '' THEN ' AND (' + @SQLWhere + ')' ELSE '' END		
END

-- Kiểm tra trùng mã trong bảng
IF @CheckCode = 'CheckDuplicateInTable'
BEGIN
	SET @sSQL = '
	UPDATE		DT  
	SET			ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '''' THEN ''\n'' ELSE '''' END + ''ASML000088 {0}=''''' + @ColumnName + '''''''
	FROM		#DATA DT
	WHERE		EXISTS(SELECT TOP 1 1 FROM '+@Param1+' F WITH (NOLOCK) WHERE F.DivisionID = DT.DivisionID AND F.'+@Param2+' = DT.' + @ColID + CASE WHEN @SQLFilter <> '' THEN ' AND ' + @SQLFilter ELSE '' END + ')' 
	+ CASE WHEN @SQLWhere <> '' THEN ' AND (' + @SQLWhere + ')' ELSE '' END		
END

-- Kiểm tra dữ liệu có trong danh sách
---- VD: Cần kiểm tra trạng thái và giá trị trong 0, 1, 2, 3
--- EXEC AP8100 @UserID = 'ASOFTADMIN', @ImportTemplateID = '?', @CheckCode = 'CheckValueInList', @ColID = 'Status', @Param1 = '0, 1, 2, 3'
IF @CheckCode = 'CheckValueInList'
BEGIN
	SET @sSQL = '
	UPDATE		DT  
	SET			ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '''' THEN ''\n'' ELSE '''' END + ''ASML000089 {0}=''''' + @ColumnName + '''''''
	FROM		#DATA DT
	WHERE		' + CASE WHEN @ObligeCheck = 0 THEN 'ISNULL(' + @ColID + ', '''') <> '''' AND ' ELSE '' END +
	 			'NOT DT.' + @ColID + ' IN (' + @Param1 + ')'
	+ CASE WHEN @SQLWhere <> '' THEN ' AND (' + @SQLWhere + ')' ELSE '' END
END 

-- Kiểm tra dữ liệu có trong bảng danh mục, danh sách này lấy dữ liệu từ 1 bảng
---- VD: Cần kiểm tra dữ liệu trong danh sách lý do hình thành tài sản
--- EXEC AP8100 @UserID = 'ASOFTADMIN', @ImportTemplateID = '?', @CheckCode = 'CheckValueInTableList', @ColID = 'CauseID', @Param1 = 'AT6000', @Param2 = 'Code'
IF @CheckCode = 'CheckValueInTableList'
BEGIN		
	SET @sSQL = '
	UPDATE		DT 
	SET			ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '''' THEN ''\n'' ELSE '''' END + ''ASML000090 {0}=''''' + @ColumnName + '''''''
	FROM		#DATA DT
	WHERE		' + CASE WHEN @ObligeCheck = 0 THEN 'ISNULL(' + @ColID + ', '''') <> '''' AND ' ELSE '' END +
				'NOT EXISTS(SELECT TOP 1 1 FROM ' + @Param1 + ' TL WITH (NOLOCK) WHERE ' + CASE WHEN ISNULL(COL_LENGTH(@Param1, 'DivisionID'), 0) > 0 THEN ' (TL.DivisionID = DT.DivisionID OR TL.DivisionID = ''@@@'') AND ' ELSE '' END + 'TL.' + @Param2 + ' = DT.' + @ColID + CASE WHEN @SQLFilter <> '' THEN ' AND ' + @SQLFilter ELSE '' END + ')' 
	+ CASE WHEN @SQLWhere <> '' THEN ' AND (' + @SQLWhere + ')' ELSE '' END
END 

-------- Kiểm tra đối tượng
IF @CheckCode = 'CheckValidDepartment'
BEGIN
	SET @sSQL = 
	'	UPDATE	DT
		SET		ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '''' THEN ''\n'' ELSE '''' END + ''ASML000091 {0}=''''' + @ColumnName + '''''''
	 	FROM	#DATA DT 		
		WHERE	' + CASE WHEN @ObligeCheck = 0 THEN 'ISNULL(' + @ColID + ', '''') <> '''' AND ' ELSE '' END +
				'NOT EXISTS (SELECT TOP 1 1
				             FROM	AT1102 D WITH (NOLOCK) 
				             WHERE	D.Disabled = 0 AND D.DepartmentID = DT.' + @ColID
									+ CASE WHEN @SQLFilter <> '' THEN ' AND ' + @SQLFilter ELSE '' END + ')
		     	' + CASE WHEN @SQLWhere <> '' THEN ' AND (' + @SQLWhere + ')' ELSE '' END
END

-------- Kiểm tra tháng năm hợp lệ
IF @CheckCode = 'CheckValidMonthYear'
BEGIN
	SET @sSQL = 
	'	UPDATE	#DATA
		SET		ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '''' THEN ''\n'' ELSE '''' END + ''ASML000092 {0}=''''' + @ColumnName + '''''''
		WHERE	' + CASE WHEN @ObligeCheck = 0 THEN 'ISNULL(' + @ColID + ', '''') <> '''' AND ' ELSE '' END +
	 			'(' + @ColID + ' NOT LIKE ''[0-1][0-9]/[2-9][0-9][0-9][0-9]'' OR ' + @ColID + ' LIKE ''00%'')
		     	' + CASE WHEN @SQLWhere <> '' THEN ' AND (' + @SQLWhere + ')' ELSE '' END
END

-- Kiểm tra trùng mã phân bổ
---- VD: Cần kiểm tra phần JobID
--- EXEC AP8100 @UserID = 'ASOFTADMIN', @ImportTemplateID = '?', @CheckCode = 'CheckDuplicateJob', @ColID = 'JobID', @Param1 = 'JobID'
IF @CheckCode = 'CheckDuplicateJob'
BEGIN
	SET @sSQL = '
	SELECT		MIN(Row) AS Row, ' + @ColID + '
	INTO		#AP8100
	FROM		#DATA
	GROUP BY	' + @ColID + '

	UPDATE		DT 
	SET			ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '''' THEN ''\n'' ELSE '''' END + ''ASML000087 {0}=''''' + @ColumnName + '''''''
	FROM		#DATA DT
	INNER JOIN	#AP8100 VN
			ON	VN.' + @ColID + ' = DT.' + @ColID + ' AND VN.Row > DT.Row'
	+ CASE WHEN @SQLWhere <> '' THEN ' WHERE ' + @SQLWhere ELSE '' END
	
	SET @sSQL = @sSQL + '
	UPDATE		DT  
	SET			ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '''' THEN ''\n'' ELSE '''' END + ''ASML000088 {0}=''''' + @ColumnName + '''''''
	FROM		#DATA DT
	WHERE		EXISTS(SELECT TOP 1 1 FROM AT1703 J WITH (NOLOCK) WHERE J.DivisionID = DT.DivisionID AND J.JobID = DT.' + @ColID + CASE WHEN @SQLFilter <> '' THEN ' AND ' + @SQLFilter ELSE '' END + ')' 
	+ CASE WHEN @SQLWhere <> '' THEN ' AND (' + @SQLWhere + ')' ELSE '' END
		
END

-------- Kiểm tra kho
IF @CheckCode = 'CheckValidWareHouse'
BEGIN
	SET @sSQL = 
	'	UPDATE	DT
		SET		ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '''' THEN ''\n'' ELSE '''' END + ''ASML000094 {0}=''''' + @ColumnName + '''''''
	 	FROM	#DATA DT		
	 	WHERE	' + CASE WHEN @ObligeCheck = 0 THEN 'ISNULL(' + @ColID + ', '''') <> '''' AND ' ELSE '' END +
	 			'NOT EXISTS (SELECT	TOP 1 1
		     				FROM	AT1303 W  WITH (NOLOCK)
		     	            WHERE	W.Disabled = 0 AND W.WareHouseID = DT.' + @ColID 
		     									+ CASE WHEN @SQLFilter <> '' THEN ' AND ' + @SQLFilter ELSE '' END + ')
		     	' + CASE WHEN @SQLWhere <> '' THEN ' AND (' + @SQLWhere + ')' ELSE '' END
END


-- Kiểm tra trùng phiếu khác với bảng AT9000
---- VD: Cần kiểm tra phần VoucherNo của phiếu kiểm kê, khóa liên quan đến VoucherNo là VoucherID, bảng là AT2036 khóa bảng là VoucherNo
--- EXEC AP8100 @UserID = 'ASOFTADMIN', @ImportTemplateID = '?', @CheckCode = 'CheckDuplicateVoucherNo', @ColID = 'VoucherNo', @Param1 = 'VoucherID', @Param2 = 'AT2036', @Param3 = 'VoucherNo'
IF @CheckCode = 'CheckDuplicateOtherVoucherNo'
BEGIN
	SET @sSQL = '
	SELECT		MIN(Row) AS Row, ' + @ColID + CASE WHEN @Param1 <> '' THEN ',' + @Param1 ELSE '' END + '
	INTO		#AP8100
	FROM		#DATA
	GROUP BY	' + @ColID + CASE WHEN @Param1 <> '' THEN ',' + @Param1 ELSE '' END 
	
	IF @Param1 <> ''
		SET @sSQL = @sSQL + '
	UPDATE		DT 
	SET			ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '''' THEN ''\n'' ELSE '''' END + ''ASML000084 {0}=''''' + @ColumnName + '''''''
	FROM		#DATA DT
	INNER JOIN	#AP8100 VN
			ON	VN.' + @ColID + ' = DT.' + @ColID + ' AND VN.' + @Param1 + ' <> DT.' + @Param1 + ' AND VN.Row > DT.Row'
	+ CASE WHEN @SQLWhere <> '' THEN ' WHERE ' + @SQLWhere ELSE '' END
	
	SET @sSQL = @sSQL + '
	-- Thực hiện kiểm tra sct đã có trong dữ liệu chưa
	SELECT DivisionID, VoucherNo
	INTO #AT9000
	FROM AT9000 WITH (NOLOCK)
	WHERE VoucherNo IN (
	SELECT VoucherNo FROM #DATA)
	
	-- Cập nhập msg lỗi cho dữ liệu
	UPDATE		DT
	SET			ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '''' THEN ''\n'' ELSE '''' END + ''ASML000085 {0}=''''' + @ColumnName + '''''''
	FROM		#DATA DT
	WHERE		EXISTS(SELECT TOP 1 1 FROM ' + CASE WHEN @Param2 = 'AT9000' THEN '#AT9000' ELSE @Param2 end + ' AT WITH (NOLOCK) WHERE AT.DivisionID = DT.DivisionID AND AT.' + @Param3 + ' = DT.' + @ColID + CASE WHEN @SQLFilter <> '' THEN ' AND ' + @SQLFilter ELSE '' END + ')' 
	+ CASE WHEN @SQLWhere <> '' THEN ' AND (' + @SQLWhere + ')' ELSE '' END		
END

IF @CheckCode = 'DuplicateVoucherNoWareHouse'
BEGIN
	SET @sSQL = '
	SELECT		MIN(Row) AS Row, ' + @ColID + CASE WHEN @Param1 <> '' THEN ',' + @Param1 ELSE '' END + '
	INTO		#AP8100
	FROM		#DATA
	GROUP BY	' + @ColID + CASE WHEN @Param1 <> '' THEN ',' + @Param1 ELSE '' END 
	
	SET @sSQL = @sSQL + '
	-- Thực hiện kiểm tra sct đã có trong dữ liệu chưa
	SELECT DivisionID, VoucherNo
	INTO #AT2006
	FROM AT2006 WITH (NOLOCK)
	WHERE VoucherNo IN (
	SELECT VoucherNo FROM #DATA)
	
	-- @Param2: Bảng để so sánh dữ liệu
	-- @Param3: Trường dữ liệu cần so sánh

	-- Cập nhập msg lỗi cho dữ liệu
	UPDATE		DT
	SET			ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '''' THEN ''\n'' ELSE '''' END + ''ASML000085 {0}=''''' + @ColumnName + '''''''
	FROM		#DATA DT
	WHERE		EXISTS(SELECT TOP 1 1 FROM ' + @Param2 + ' AT WITH (NOLOCK) WHERE AT.DivisionID = DT.DivisionID AND AT.' + @Param3 + ' = DT.' + @ColID + CASE WHEN @SQLFilter <> '' THEN ' AND ' + @SQLFilter ELSE '' END + ')' 
	+ CASE WHEN @SQLWhere <> '' THEN ' AND (' + @SQLWhere + ')' ELSE '' END		
END

-- Kiểm tra trùng giá trị trong dữ liệu
-- Nếu không có khóa để phân biệt thì khóa sẽ là ColID
---- VD: Cần kiểm tra phần InventoryID của phiếu kiểm kê, khóa để kiểm tra trùng là VoucherNo
--- EXEC AP8100 @UserID = 'ASOFTADMIN', @ImportTemplateID = '?', @CheckCode = 'CheckDuplicateVoucherNo', @ColID = 'InventoryID', @Param1 = 'VoucherNo'
IF @CheckCode = 'CheckDuplicateValue'
BEGIN
	SET @sSQL = '
	SELECT		MIN(Row) AS Row, ' + @ColID + CASE WHEN @Param1 <> '' THEN ',' + @Param1 ELSE '' END + '
	INTO		#AP8100
	FROM		#DATA
	GROUP BY	' + @ColID + CASE WHEN @Param1 <> '' THEN ',' + @Param1 ELSE '' END 
	+ CASE WHEN @SQLWhere <> '' THEN ' WHERE ' + @SQLWhere ELSE '' END
END

-------- Kiểm tra kỳ kế toán đầu tiên
IF @CheckCode = 'CheckFirstPeriod'
BEGIN
	SET @sSQL = 
	'	UPDATE	#DATA
		SET		ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '''' THEN ''\n'' ELSE '''' END + ''ASML000072 {0}=''''' + @ColumnName + '''''''
		WHERE	Period <> (SELECT TOP 1 REPLACE(STR(TranMonth, 2), '' '', ''0'') + ''/'' + STR(TranYear, 4)
		     	                           FROM ' + CASE	WHEN @Module  = 'ASOFT-T' THEN 'AT9999  WITH (NOLOCK)' 
															WHEN @Module  = 'ASOFT-FA' THEN 'FT9999  WITH (NOLOCK)'
															WHEN @Module  = 'ASOFT-M' THEN 'MT9999  WITH (NOLOCK)'
															WHEN @Module  = 'ASOFT-OP' THEN 'OT9999  WITH (NOLOCK)'
															WHEN @Module  = 'ASOFT-WM' THEN 'WT9999  WITH (NOLOCK)'
															WHEN @Module  = 'ASOFT-HRM' THEN 'HT9999  WITH (NOLOCK)'
													ELSE 'AT9999  WITH (NOLOCK)' END + '
											WHERE Closing = 0 
		     								ORDER BY TranMonth + TranYear*100 ' + CASE WHEN @SQLFilter <> '' THEN ' AND ' + @SQLFilter ELSE '' END + ')
		     	' + CASE WHEN @SQLWhere <> '' THEN ' AND (' + @SQLWhere + ')' ELSE '' END
END

-------- Kiểm tra CreditAccountID phải là TK tồn kho không - Bổ sung kiểm tra tài khoản thêm ở AT1312
IF @CheckCode = 'CheckValidInventoryAccount'
BEGIN
	SET @sSQL = 
	'	UPDATE	DT
		SET		ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '''' THEN ''\n'' ELSE '''' END + ''WFML000254 {0}=''''' + @ColumnName + '''''''
	 	FROM	#DATA DT 		
		WHERE	NOT EXISTS (SELECT 1
				              FROM AT1302 A WITH (NOLOCK)
				              WHERE A.DivisionID IN ('''+@DivisionID+''',''@@@'') AND A.InventoryID = DT.' + @Param1 + ' AND A.AccountID = DT.' + @ColID + ')
				AND NOT EXISTS (SELECT 1
				              FROM AT1312 B WITH (NOLOCK)
				              WHERE B.InventoryID = DT.' + @Param1 + ' AND B.GroupID = ''G05'' AND B.AccountID = DT.' + @ColID + ')			  '
		     	
END


IF @CustomerName = 50 -- MeiKo
BEGIN
	IF @CheckCode = 'CheckValidPaymentTerm'
	BEGIN
		SET @sSQL = 
		'	UPDATE	DT
			SET		ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '''' THEN ''\n'' ELSE '''' END + ''ASML000098 {0}=''''' + @ColumnName + '''''''
	 		FROM	#DATA DT		
	 		WHERE	' + CASE WHEN @ObligeCheck = 0 THEN 'ISNULL(' + @ColID + ', '''') <> '''' AND ' ELSE '' END +
	 				'NOT EXISTS (SELECT	TOP 1 1  
		     					FROM	AT1208 B  WITH (NOLOCK)
		     					WHERE	B.Disabled = 0 AND B.PaymentTermID = DT.' + @ColID 
		     										+ CASE WHEN @SQLFilter <> '' THEN ' AND ' + @SQLFilter ELSE '' END + ')
		     		' + CASE WHEN @SQLWhere <> '' THEN ' AND (' + @SQLWhere + ')' ELSE '' END
	END

END 
-------- Kiểm tra điều khoản thanh toán

-----Kiểm tra TK Chi phí trả trước trong Khai báo phân bổ CP trả trước AF0052 phải thuộc trong danh sách khai báo Phân bổ CP trả trước AF0007
IF @CheckCode = 'CheckValidPrepaidExpensesAccount'
BEGIN
	SET @sSQL = 
	'   UPDATE	DT
		SET		ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '''' THEN ''\n'' ELSE '''' END + ''AFML000600 {0}=''''' + @ColumnName + '''''''
	 	FROM	#DATA DT 		
		WHERE	NOT EXISTS (SELECT TOP 1 1
							FROM AT0006 WITH(NOLOCK) INNER JOIN AT1005 WITH(NOLOCK) ON AT0006.AccountID = AT1005.AccountID
							WHERE AT0006.D_C = ''D''
							AND AT0006.DivisionID = DT.DivisionID
							AND AT1005.IsNotShow = 0
							AND AT0006.AccountID = DT.' + @ColID + ')	  
	'
END


-- Kiểm tra trùng mã Danh mục phân bổ
---- VD: Cần kiểm tra phần Allocation 
--- EXEC AP8100 @UserID = 'ASOFTADMIN', @ImportTemplateID = '?', @CheckCode = 'CheckDuplicateJob', @ColID = 'JobID', @Param1 = 'JobID'
IF @CheckCode = 'CheckDuplicateAllocation'
BEGIN
	SET @sSQL = '
	SELECT		MIN(Row) AS Row, ' + @ColID + '
	INTO		#AP8100
	FROM		#DATA
	GROUP BY	' + @ColID + '

	UPDATE		DT 
	SET			ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '''' THEN ''\n'' ELSE '''' END + ''ASML000087 {0}=''''' + @ColumnName + '''''''
	FROM		#DATA DT
	INNER JOIN	#AP8100 VN
			ON	VN.' + @ColID + ' = DT.' + @ColID + ' AND VN.Row > DT.Row'
	+ CASE WHEN @SQLWhere <> '' THEN ' WHERE ' + @SQLWhere ELSE '' END
	
	SET @sSQL = @sSQL + '
	UPDATE		DT  
	SET			ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '''' THEN ''\n'' ELSE '''' END + ''ASML000088 {0}=''''' + @ColumnName + '''''''
	FROM		#DATA DT
	WHERE		EXISTS(SELECT TOP 1 1 FROM '+@Param1+' J WITH (NOLOCK) WHERE J.DivisionID = DT.DivisionID AND J.' + @Param2 + ' = DT.' + @ColID + CASE WHEN @SQLFilter <> '' THEN ' AND ' + @SQLFilter ELSE '' END + ')' 
	+ CASE WHEN @SQLWhere <> '' THEN ' AND (' + @SQLWhere + ')' ELSE '' END
		
END

--PRINT @sSQL
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO