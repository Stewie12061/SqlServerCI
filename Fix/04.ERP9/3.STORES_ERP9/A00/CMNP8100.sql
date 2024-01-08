IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CMNP8100]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CMNP8100]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Xử lý kiểm tra dữ liệu Import có hợp lệ (ERP9)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 16/04/2018 by Trương Ngọc Phương Thảo
---- Modified on 23/04/2020 by Vĩnh Tâm: Bổ sung check Kỳ kế toán cho module BEM
-- <Example>
---- 
CREATE PROCEDURE [DBO].[CMNP8100]
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
DECLARE @ColumnName AS NVARCHAR(50),
		@ColName AS NVARCHAR(50)
DECLARE @sSQL AS NVARCHAR(MAX)
DECLARE @ParamList VARCHAR(8000),
		@SetParamList VARCHAR(8000),
		@ParamCondit VARCHAR(8000),
		@sSQLTemp VARCHAR(8000),
		@allowedPattern VARCHAR(100) = '%[^a-z0-9./_-]%' 

SELECT		BTL.ColID, BTL.DataCol, BTL.ColSQLDataType 
INTO		#Columns
FROM		A00065 BTL WITH (NOLOCK)		
WHERE		BTL.ImportTransTypeID = @ImportTemplateID
		
SELECT	TOP 1	@ColumnName = DataCol,
				@ColName = ColName
FROM	A00065 WITH (NOLOCK)
WHERE	ImportTransTypeID = @ImportTemplateID AND ColID = @ColID

--IF @CheckCode NOT IN ('')
--	RETURN
	PRINT(@CheckCode)
-------- Kiểm tra đơn vị (Master)
IF @CheckCode = 'CheckValidDivision'
BEGIN
	SET @sSQL = 
	'	UPDATE	#DATA 
		SET		ErrorMessage = ErrorMessage + '''+@ColumnName +''' +''-00ML000114,'',
				ErrorColumn = ErrorColumn + '''+@ColID+'''+'',''
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

-------- Kiểm tra đơn vị (Detail)
IF @CheckCode = 'CheckValidDivisionDetail'
BEGIN
	SET @sSQL = 
	'	UPDATE	#DATA 
		SET		ErrorMessage = ErrorMessage + '''+@ColumnName +'''+ LTRIM(RTRIM(STR([Row]))) +''-00ML000114,'',
				ErrorColumn = ErrorColumn + '''+@ColID+'''+'',''
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

-------- Kiểm tra kỳ kế toán (Master)
IF @CheckCode = 'CheckValidPeriod'
BEGIN
	SET @sSQL = 
	'	UPDATE	#DATA
		SET		ErrorMessage = ErrorMessage + '''+@ColumnName +''' +''-00ML000138,'',
				ErrorColumn = ErrorColumn + '''+@ColID+'''+'',''
		WHERE	' + @ColID + ' NOT IN (SELECT REPLACE(STR(TranMonth, 2), '' '', ''0'') + ''/'' + STR(TranYear, 4)
		     	                           FROM ' + CASE	WHEN @Module  = 'ASOFT-T' THEN 'AT9999  WITH (NOLOCK)' 
															WHEN @Module  = 'ASOFT-FA' THEN 'FT9999  WITH (NOLOCK)'
															WHEN @Module  = 'ASOFT-M' THEN 'MT9999  WITH (NOLOCK)'
															WHEN @Module  = 'ASOFT-OP' THEN 'OT9999  WITH (NOLOCK)'
															WHEN @Module  = 'ASOFT-WM' THEN 'WT9999  WITH (NOLOCK)'
															WHEN @Module  = 'ASOFT-HRM' THEN 'HT9999  WITH (NOLOCK)'
															WHEN @Module  = 'ASOFT-BEM' THEN 'BEMT9999  WITH (NOLOCK)'
													ELSE 'AT9999  WITH (NOLOCK)' END + '
											WHERE Closing = 0 ' + CASE WHEN @SQLFilter <> '' THEN ' AND ' + @SQLFilter ELSE '' END + ')
		     	' + CASE WHEN @SQLWhere <> '' THEN ' AND (' + @SQLWhere + ')' ELSE '' END
END

-------- Kiểm tra kỳ kế toán (Detail)
IF @CheckCode = 'CheckValidPeriodDetail'
BEGIN
	SET @sSQL = 
	'	UPDATE	#DATA
		SET		ErrorMessage = ErrorMessage + '''+@ColumnName +''' + LTRIM(RTRIM(STR([Row]))) +''-00ML000138,'',
				ErrorColumn = ErrorColumn + '''+@ColID+'''+'',''
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


-------- Kiểm tra loại phiếu (Master)
IF @CheckCode = 'CheckValidVoucherType'
BEGIN
	SET @sSQL = 
	'	UPDATE	DT
		SET		ErrorMessage = ErrorMessage + '''+@ColumnName +''' +''-00ML000139,'',
				ErrorColumn = ErrorColumn + '''+@ColID+'''+'',''
	 	FROM	#DATA DT		
	 	WHERE	NOT EXISTS (SELECT	TOP 1 1  
		     	            FROM	AT1007 V  WITH (NOLOCK) 
		     	            WHERE	V.Disabled = 0 AND V.DivisionID = DT.DivisionID AND V.VoucherTypeID = DT.' + @ColID 
		     									+ CASE WHEN @SQLFilter <> '' THEN ' AND ' + @SQLFilter ELSE '' END + ')
		     	' + CASE WHEN @SQLWhere <> '' THEN ' AND (' + @SQLWhere + ')' ELSE '' END
END

-------- Kiểm tra loại phiếu (Detail)
IF @CheckCode = 'CheckValidVoucherTypeDetail'
BEGIN
	SET @sSQL = 
	'	UPDATE	DT
		SET		ErrorMessage = ErrorMessage +  LTRIM(RTRIM(STR([Row]))) + '''+@ColumnName +''' +''-00ML000139,'',
				ErrorColumn = ErrorColumn + '''+@ColID+'''+'',''
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
		SET		ErrorMessage = ErrorMessage + '''+@ColumnName +''' +  LTRIM(RTRIM(STR([Row]))) +''-00ML000140,'',
				ErrorColumn = ErrorColumn + '''+@ColID+'''+'',''
		WHERE	RIGHT(CONVERT(VARCHAR(10),' + @ColID + ', 103), 7) <> Period
				' + CASE WHEN @SQLWhere <> '' THEN ' AND (' + @SQLWhere + ')' ELSE '' END
END

-------- Kiểm tra nhân viên
IF @CheckCode = 'CheckValidEmployee'
BEGIN
	SET @sSQL = 
	'	UPDATE	DT
		SET		ErrorMessage = ErrorMessage + '''+@ColumnName +''' +  LTRIM(RTRIM(STR([Row]))) +''-00ML000141,'',
				ErrorColumn = ErrorColumn + '''+@ColID+'''+'',''
	 	FROM	#DATA DT		
		WHERE	' + CASE WHEN @ObligeCheck = 0 THEN 'ISNULL(' + @ColID + ', '''') <> '''' AND ' ELSE '' END +
				' NOT EXISTS (SELECT	TOP 1 1
				              FROM		AT1103 E  WITH (NOLOCK)
				              WHERE		E.Disabled = 0 AND E.EmployeeID = DT.' + @ColID
				                   + CASE WHEN @SQLFilter <> '' THEN ' AND ' + @SQLFilter ELSE '' END + ')
		     	' + CASE WHEN @SQLWhere <> '' THEN ' AND (' + @SQLWhere + ')' ELSE '' END
END
--PRINT @sSQL
-------- Kiểm tra đối tượng
IF @CheckCode = 'CheckValidObject'
BEGIN
	SET @sSQL = 
	'	UPDATE	DT
		SET		ErrorMessage = ErrorMessage + '''+@ColumnName +''' +  LTRIM(RTRIM(STR([Row]))) +''-00ML000142,'',
				ErrorColumn = ErrorColumn + '''+@ColID+'''+'',''
	 	FROM	#DATA DT 		
		WHERE	' + CASE WHEN @ObligeCheck = 0 THEN 'ISNULL(' + @ColID + ', '''') <> '''' AND ' ELSE '' END +
				'NOT EXISTS (SELECT TOP 1 1
				             FROM	AT1202 O WITH (NOLOCK) 
				             WHERE	O.Disabled = 0 AND O.ObjectID = DT.' + @ColID
									+ CASE WHEN @SQLFilter <> '' THEN ' AND ' + @SQLFilter ELSE '' END + ')
		     	' + CASE WHEN @SQLWhere <> '' THEN ' AND (' + @SQLWhere + ')' ELSE '' END
END
--print @sSQL 
-------- Kiểm tra loại tiền
IF @CheckCode = 'CheckValidCurrency'
BEGIN
	SET @sSQL = 
	'	UPDATE	DT
		SET		ErrorMessage = ErrorMessage + '''+@ColumnName +''' +  LTRIM(RTRIM(STR([Row]))) +''-00ML000143,'',
				ErrorColumn = ErrorColumn + '''+@ColID+'''+'',''
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
		SET		ErrorMessage = ErrorMessage +'''+@ColumnName +''' +  LTRIM(RTRIM(STR([Row]))) +''-00ML000144,'',
				ErrorColumn = ErrorColumn + '''+@ColID+'''+'',''
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
		SET		ErrorMessage = ErrorMessage + '''+@ColumnName +''' +  LTRIM(RTRIM(STR([Row]))) +''-00ML000145,'',
				ErrorColumn = ErrorColumn + '''+@ColID+'''+'',''
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
		SET		ErrorMessage = ErrorMessage + '''+@ColumnName +''' +  LTRIM(RTRIM(STR([Row]))) +''-00ML000146,'',
				ErrorColumn = ErrorColumn + '''+@ColID+'''+'',''
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
		SET		ErrorMessage = ErrorMessage + '''+@ColumnName +''' +  LTRIM(RTRIM(STR([Row]))) +''-00ML000147,'',
				ErrorColumn = ErrorColumn + '''+@ColID+'''+'',''
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
		SET		ErrorMessage = ErrorMessage + '''+@ColumnName +''' +  LTRIM(RTRIM(STR([Row]))) +''-00ML000148,'',
				ErrorColumn = ErrorColumn + '''+@ColID+'''+'',''
		WHERE	(' + @ColID + ' IS NULL OR Convert(NVarchar(500),' + @ColID +') = '''')
				' + CASE WHEN @SQLWhere <> '' THEN ' AND (' + @SQLWhere + ')' ELSE '' END

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
					SET @ColumnName = @ColumnName + CASE WHEN @ColumnName = '''' THEN '''' ELSE '', '' END + ''' + ColID + ''''
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
					SET @ColumnName = @ColumnName + CASE WHEN @ColumnName = '''' THEN '''' ELSE '', '' END + ''' + ColID + ''''
				END					
	FROM	#Columns
	WHERE	CHARINDEX(',' + ColID + ',', REPLACE(',' + @Param1 + ',', ' ', '')) > 0
	AND CHARINDEX(',' + ColID + ',', REPLACE(',' + @ColID + ',', ' ', '')) = 0

	SET @ParamCondit = @ParamCondit + '
				IF @ColumnName <> ''''
					UPDATE	#DATA 
					SET		ErrorMessage =  ErrorMessage + '''+@ColumnName +''' + LTRIM(RTRIM(STR([Row]))) +''-00ML000149,'',				
							ErrorColumn = ErrorColumn + @ColumnName+'',''
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
--IF @CheckCode = 'CheckDuplicateVoucherNo'
--BEGIN
--	DECLARE @Tablename Varchar(20)

--	IF @Module = ''

--	SET @sSQL = '
--	SELECT		MIN(Row) AS Row, ' + @ColID + CASE WHEN @Param1 <> '' THEN ',' + @Param1 ELSE '' END + '
--	INTO		#AP8100
--	FROM		#DATA
--	GROUP BY	' + @ColID + CASE WHEN @Param1 <> '' THEN ',' + @Param1 ELSE '' END 
	
--	IF @Param1 <> ''
--		SET @sSQL = @sSQL + '
--	UPDATE		DT 
--	SET			ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '''' THEN ''\n'' ELSE '''' END + ''ASML000084 {0}=''''' + @ColumnName + '''''''
--	FROM		#DATA DT
--	INNER JOIN	#AP8100 VN
--			ON	VN.' + @ColID + ' = DT.' + @ColID + ' AND VN.' + @Param1 + ' <> DT.' + @Param1 + ' AND VN.Row > DT.Row'
--	+ CASE WHEN @SQLWhere <> '' THEN ' WHERE ' + @SQLWhere ELSE '' END
	
--	SET @sSQL = @sSQL + '
--	UPDATE		DT  
--	SET			ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '''' THEN ''\n'' ELSE '''' END + ''ASML000085 {0}=''''' + @ColumnName + '''''''
--	FROM		#DATA DT
--	WHERE		EXISTS(SELECT TOP 1 1 FROM AT9000 AT WITH (NOLOCK) WHERE AT.DivisionID = DT.DivisionID AND AT.VoucherNo = DT.' + @ColID + CASE WHEN @SQLFilter <> '' THEN ' AND ' + @SQLFilter ELSE '' END + ')' 
--	+ CASE WHEN @SQLWhere <> '' THEN ' AND (' + @SQLWhere + ')' ELSE '' END
		
--END

-------- Kiểm tra tài khoản ngân hàng
IF @CheckCode = 'CheckValidBankAccount'
BEGIN
	SET @sSQL = 
	'	UPDATE	DT
		SET		ErrorMessage = ErrorMessage + '''+@ColumnName +'''+  LTRIM(RTRIM(STR([Row]))) +''-00ML000150,'',
				ErrorColumn = ErrorColumn + '''+@ColID+'''+'',''
	 	FROM	#DATA DT		
	 	WHERE	' + CASE WHEN @ObligeCheck = 0 THEN 'ISNULL(' + @ColID + ', '''') <> '''' AND ' ELSE '' END +
	 			'NOT EXISTS (SELECT	TOP 1 1  
		     	            FROM	AT1016 B  WITH (NOLOCK)
		     	            WHERE	B.Disabled = 0 AND B.BankAccountID = DT.' + @ColID 
		     									+ CASE WHEN @SQLFilter <> '' THEN ' AND ' + @SQLFilter ELSE '' END + ')
		     	' + CASE WHEN @SQLWhere <> '' THEN ' AND (' + @SQLWhere + ')' ELSE '' END
END

---- Kiểm tra trùng mã tài sản
------ VD: Cần kiểm tra phần AssetID
----- EXEC AP8100 @UserID = 'ASOFTADMIN', @ImportTemplateID = '?', @CheckCode = 'CheckDuplicateAsset', @ColID = 'AssetID', @Param1 = 'AssetID'
--IF @CheckCode = 'CheckDuplicateAsset'
--BEGIN
--	SET @sSQL = '
--	SELECT		MIN(Row) AS Row, ' + @ColID + '
--	INTO		#AP8100
--	FROM		#DATA
--	GROUP BY	' + @ColID + '

--	UPDATE		DT 
--	SET			ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '''' THEN ''\n'' ELSE '''' END + ''ASML000087 {0}=''''' + @ColumnName + '''''''
--	FROM		#DATA DT
--	INNER JOIN	#AP8100 VN
--			ON	VN.' + @ColID + ' = DT.' + @ColID + ' AND VN.Row > DT.Row'
--	+ CASE WHEN @SQLWhere <> '' THEN ' WHERE ' + @SQLWhere ELSE '' END
	
--	SET @sSQL = @sSQL + '
--	UPDATE		DT  
--	SET			ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '''' THEN ''\n'' ELSE '''' END + ''ASML000088 {0}=''''' + @ColumnName + '''''''
--	FROM		#DATA DT
--	WHERE		EXISTS(SELECT TOP 1 1 FROM AT1503 F WITH (NOLOCK) WHERE F.DivisionID = DT.DivisionID AND F.AssetID = DT.' + @ColID + CASE WHEN @SQLFilter <> '' THEN ' AND ' + @SQLFilter ELSE '' END + ')' 
--	+ CASE WHEN @SQLWhere <> '' THEN ' AND (' + @SQLWhere + ')' ELSE '' END		
--END

-- Kiểm tra dữ liệu có trong danh sách
---- VD: Cần kiểm tra trạng thái và giá trị trong 0, 1, 2, 3
--- EXEC AP8100 @UserID = 'ASOFTADMIN', @ImportTemplateID = '?', @CheckCode = 'CheckValueInList', @ColID = 'Status', @Param1 = '0, 1, 2, 3'
IF @CheckCode = 'CheckValueInList'
BEGIN
	SET @sSQL = '
	UPDATE		DT  
	SET			ErrorMessage = ErrorMessage + '''+@ColumnName +'''+  LTRIM(RTRIM(STR([Row]))) +''-00ML000151,'',
				ErrorColumn = ErrorColumn + '''+@ColID+'''+'',''
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
	SET			ErrorMessage = ErrorMessage + '''+@ColumnName +''' +  LTRIM(RTRIM(STR([Row]))) +''-00ML000152,'',
				ErrorColumn = ErrorColumn + '''+@ColID+'''+'',''
	FROM		#DATA DT
	WHERE		' + CASE WHEN @ObligeCheck = 0 THEN 'ISNULL(' + @ColID + ', '''') <> '''' AND ' ELSE '' END +
				'NOT EXISTS(SELECT TOP 1 1 FROM ' + @Param1 + ' TL WITH (NOLOCK) WHERE ' + CASE WHEN ISNULL(COL_LENGTH(@Param1, 'DivisionID'), 0) > 0 THEN ' (TL.DivisionID = DT.DivisionID OR TL.DivisionID = ''@@@'') AND ' ELSE '' END + 'TL.' + @Param2 + ' = DT.' + @ColID + CASE WHEN @SQLFilter <> '' THEN ' AND ' + @SQLFilter ELSE '' END + ')' 
	+ CASE WHEN @SQLWhere <> '' THEN ' AND (' + @SQLWhere + ')' ELSE '' END
print @sSQL
END 
-------- Kiểm tra dữ liệu chuỗi phải là số
IF @CheckCode = 'CheckIsNumeric'
BEGIN
	SET @sSQL = '
	UPDATE		DT 
	SET			ErrorMessage = ErrorMessage + '''+@ColumnName +''' +  LTRIM(RTRIM(STR([Row]))) +''-00ML000300,'',
				ErrorColumn = ErrorColumn + '''+@ColID+'''+'',''
	FROM		#DATA DT
	WHERE		' + CASE WHEN @ObligeCheck = 0 THEN 'ISNULL(' + @ColID + ', '''') <> '''' AND ' ELSE '' END +
				'' + CASE WHEN @SQLFilter <> '' THEN '' + @SQLFilter ELSE '' END + '' 
	+ CASE WHEN @SQLWhere <> '' THEN ' AND (' + @SQLWhere + ')' ELSE '' END
print @sSQL
END 
-------- Kiểm tra dữ liệu chứa ký tự đặt biệt: a-zA-Z0-9._/-
IF @CheckCode = 'CheckCharactersAllowed'
BEGIN
	SET @sSQL = 
	'	UPDATE	DT
		SET		ErrorMessage = ErrorMessage + '''+@ColumnName +''' +  LTRIM(RTRIM(STR([Row]))) +''-00ML000217,'',
				ErrorColumn = ErrorColumn + '''+@ColID+'''+'',''
	 	FROM	#DATA DT 
		WHERE	CONVERT(VARCHAR(10),' + @ColID + ', 103) <> dbo.RemoveNotAllowedCharacter(CONVERT(VARCHAR(10),' + @ColID + ', 103),'+ ''''+@allowedPattern+'''' + ','''')'
				 + CASE WHEN @SQLWhere <> '' THEN ' AND (' + @SQLWhere + ')' ELSE '' END                                  
--print @sSQL
END
-------- Kiểm tra phòng ban
IF @CheckCode = 'CheckValidDepartment'
BEGIN
	SET @sSQL = 
	'	UPDATE	DT
		SET		ErrorMessage = ErrorMessage + '''+@ColumnName +''' +  LTRIM(RTRIM(STR([Row]))) +''-00ML000153,'',
				ErrorColumn = ErrorColumn + '''+@ColID+'''+'',''
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
		SET		ErrorMessage = ErrorMessage +'''+@ColumnName +''' +  LTRIM(RTRIM(STR([Row]))) +''-00ML000154,'',
				ErrorColumn = ErrorColumn + '''+@ColID+'''+'',''
		WHERE	' + CASE WHEN @ObligeCheck = 0 THEN 'ISNULL(' + @ColID + ', '''') <> '''' AND ' ELSE '' END +
	 			'(' + @ColID + ' NOT LIKE ''[0-1][0-9]/[2-9][0-9][0-9][0-9]'' OR ' + @ColID + ' LIKE ''00%'')
		     	' + CASE WHEN @SQLWhere <> '' THEN ' AND (' + @SQLWhere + ')' ELSE '' END
END

-- Kiểm tra trùng mã phân bổ
---- VD: Cần kiểm tra phần JobID
--- EXEC AP8100 @UserID = 'ASOFTADMIN', @ImportTemplateID = '?', @CheckCode = 'CheckDuplicateJob', @ColID = 'JobID', @Param1 = 'JobID'
--IF @CheckCode = 'CheckDuplicateJob'
--BEGIN
--	SET @sSQL = '
--	SELECT		MIN(Row) AS Row, ' + @ColID + '
--	INTO		#AP8100
--	FROM		#DATA
--	GROUP BY	' + @ColID + '

--	UPDATE		DT 
--	SET			ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '''' THEN ''\n'' ELSE '''' END + ''ASML000087 {0}=''''' + @ColumnName + '''''''
--	FROM		#DATA DT
--	INNER JOIN	#AP8100 VN
--			ON	VN.' + @ColID + ' = DT.' + @ColID + ' AND VN.Row > DT.Row'
--	+ CASE WHEN @SQLWhere <> '' THEN ' WHERE ' + @SQLWhere ELSE '' END
	
--	SET @sSQL = @sSQL + '
--	UPDATE		DT  
--	SET			ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '''' THEN ''\n'' ELSE '''' END + ''ASML000088 {0}=''''' + @ColumnName + '''''''
--	FROM		#DATA DT
--	WHERE		EXISTS(SELECT TOP 1 1 FROM AT1703 J WITH (NOLOCK) WHERE J.DivisionID = DT.DivisionID AND J.JobID = DT.' + @ColID + CASE WHEN @SQLFilter <> '' THEN ' AND ' + @SQLFilter ELSE '' END + ')' 
--	+ CASE WHEN @SQLWhere <> '' THEN ' AND (' + @SQLWhere + ')' ELSE '' END
		
--END


-------- Kiểm tra kho
IF @CheckCode = 'CheckValidWareHouse'
BEGIN
	SET @sSQL = 
	'	UPDATE	DT
		SET		ErrorMessage = ErrorMessage + '''+@ColumnName +''' +  LTRIM(RTRIM(STR([Row]))) +''-00ML000155,'',
				ErrorColumn = ErrorColumn + '''+@ColID+'''+'',''
	 	FROM	#DATA DT		
	 	WHERE	' + CASE WHEN @ObligeCheck = 0 THEN 'ISNULL(' + @ColID + ', '''') <> '''' AND ' ELSE '' END +
	 			'NOT EXISTS (SELECT	TOP 1 1
		     				FROM	AT1303 W  WITH (NOLOCK)
		     	            WHERE	W.Disabled = 0 AND W.WareHouseID = DT.' + @ColID 
		     									+ CASE WHEN @SQLFilter <> '' THEN ' AND ' + @SQLFilter ELSE '' END + ')
		     	' + CASE WHEN @SQLWhere <> '' THEN ' AND (' + @SQLWhere + ')' ELSE '' END
END


-- Kiểm tra trùng dữ liệu: bao gồm cả trùng dữ liệu trên file import và DB
--- EXEC CMNP8100 @UserID = 'ASOFTADMIN', @ImportTemplateID = '?', @CheckCode = 'CheckDuplicateVoucherNo', @ColID = 'VoucherNo', @Param1 = 'VoucherID', @Param2 = 'AT2036', @Param3 = 'VoucherNo'
IF @CheckCode = 'CheckDuplicateData'
BEGIN
	SET @sSQL = '
	SELECT		MIN(Row) AS Row, ' + @ColID + CASE WHEN @Param1 <> '' THEN ',' + @Param1 ELSE '' END + '
	INTO		#AP8100
	FROM		#DATA
	GROUP BY	' + @ColID + CASE WHEN @Param1 <> '' THEN ',' + @Param1 ELSE '' END 
	
	IF @Param1 <> ''
		SET @sSQL = @sSQL + '	
	UPDATE		DT 
	SET			ErrorMessage = ErrorMessage + '''+@ColumnName +''' + LTRIM(RTRIM(STR(DT.[Row]))) +''-00ML000156,'',
				ErrorColumn = ErrorColumn + '''+@ColID+'''+'',''
	FROM		#DATA DT
	INNER JOIN	#AP8100 VN
			ON	VN.' + @ColID + ' = DT.' + @ColID + ' AND VN.' + @Param1 + ' <> DT.' + @Param1 + ' AND VN.Row > DT.Row'
	+ CASE WHEN @SQLWhere <> '' THEN ' WHERE ' + @SQLWhere ELSE '' END
	
	SET @sSQL = @sSQL + '
	UPDATE		DT  
	SET			ErrorMessage = ErrorMessage + '''+@ColumnName +''' + LTRIM(RTRIM(STR(DT.[Row]))) +''-00ML000157,'',
				ErrorColumn = ErrorColumn + '''+@ColID+'''+'',''
	FROM		#DATA DT
	WHERE		EXISTS(SELECT TOP 1 1 FROM ' + @Param2 + ' AT WITH (NOLOCK) WHERE AT.DivisionID = DT.DivisionID AND AT.' + @Param3 + ' = DT.' + @ColID + CASE WHEN @SQLFilter <> '' THEN ' AND ' + @SQLFilter ELSE '' END + ')' 
	+ CASE WHEN @SQLWhere <> '' THEN ' AND (' + @SQLWhere + ')' ELSE '' END		
END
--print @sSQL
-------- Kiểm tra kỳ kế toán đầu tiên
IF @CheckCode = 'CheckFirstPeriod'
BEGIN
	SET @sSQL = 
	'	UPDATE	#DATA
		SET		ErrorMessage = ErrorMessage + '''+@ColumnName +''' +  LTRIM(RTRIM(STR([Row]))) +''-00ML000138,'',
				ErrorColumn = ErrorColumn + '''+@ColID+'''+'',''
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



---Modify on 04/10/2019 by Hồng Thảo: Check trùng mã trong toàn bộ table 
-- Kiểm tra trùng dữ liệu: bao gồm cả trùng dữ liệu trên file import và DB cho trường hợp không check theo division 
--- EXEC CMNP8100 @UserID = 'ASOFTADMIN', @ImportTemplateID = '?', @CheckCode = 'CheckDuplicateVoucherNo', @ColID = 'VoucherNo', @Param1 = 'VoucherID', @Param2 = 'AT2036', @Param3 = 'VoucherNo'
IF @CheckCode = 'CheckDuplicateData1'
BEGIN
	SET @sSQL = '
	SELECT		MIN(Row) AS Row, ' + @ColID + CASE WHEN @Param1 <> '' THEN ',' + @Param1 ELSE '' END + '
	INTO		#AP8100
	FROM		#DATA
	GROUP BY	' + @ColID + CASE WHEN @Param1 <> '' THEN ',' + @Param1 ELSE '' END 
	
	IF @Param1 <> ''
		SET @sSQL = @sSQL + '	
	UPDATE		DT 
	SET			ErrorMessage = ErrorMessage + '''+@ColumnName +''' + LTRIM(RTRIM(STR(DT.[Row]))) +''-00ML000156,'',
				ErrorColumn = ErrorColumn + '''+@ColID+'''+'',''
	FROM		#DATA DT
	INNER JOIN	#AP8100 VN
			ON	VN.' + @ColID + ' = DT.' + @ColID + ' AND VN.' + @Param1 + ' <> DT.' + @Param1 + ' AND VN.Row > DT.Row'
	+ CASE WHEN @SQLWhere <> '' THEN ' WHERE ' + @SQLWhere ELSE '' END
	
	SET @sSQL = @sSQL + '
	UPDATE		DT  
	SET			ErrorMessage = ErrorMessage + '''+@ColumnName +''' + LTRIM(RTRIM(STR(DT.[Row]))) +''-00ML000157,'',
				ErrorColumn = ErrorColumn + '''+@ColID+'''+'',''
	FROM		#DATA DT
	WHERE		EXISTS(SELECT TOP 1 1 FROM ' + @Param2 + ' AT WITH (NOLOCK) WHERE AT.' + @Param3 + ' = DT.' + @ColID + CASE WHEN @SQLFilter <> '' THEN ' AND ' + @SQLFilter ELSE '' END + ')' 
	+ CASE WHEN @SQLWhere <> '' THEN ' AND (' + @SQLWhere + ')' ELSE '' END		
END
 


--PRINT @sSQL
EXEC (@sSQL)





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
