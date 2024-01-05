IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP21002]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP21002]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Import Excel yêu cầu khách hàng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created by Kiều Nga on 11/03/2020
---- Modified by on Kiều Nga 08/05/2020 cập nhật tăng tự động mã yêu cầu
---- Modified by on Hoài Bảo 06/09/2022: Cập nhật lấy mã chứng từ tự động theo version 2
---- Modified by on Kiều Nga 01/11/2022: Cập nhật lấy mã chứng từ tự động theo version 2
-- <Example>
/* 
 EXEC CRMP21002 @DivisionID, @UserID, @ImportTransTypeID, @XML
 */
 
CREATE PROCEDURE CRMP21002
( 
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),	
	@ImportTransTypeID VARCHAR(50),
	@XML XML
) 
AS
DECLARE @cCURSOR CURSOR,
		@sSQL NVARCHAR(MAX) ='',
		@sSQL2 NVARCHAR(MAX) ='',
		@ColID VARCHAR(50), 
		@ColSQLDataType VARCHAR(50)
		
CREATE TABLE #Data
(
	[Row] INT,
	Orders INT,
	VoucherDate1 DATETIME,
	ErrorMessage NVARCHAR(MAX) DEFAULT (''),
	ErrorColumn NVARCHAR(MAX) DEFAULT (''),
	CONSTRAINT [PK_#Data] PRIMARY KEY CLUSTERED 
	(
		Row ASC
	) ON [PRIMARY]	
)

SET @cCURSOR = CURSOR STATIC FOR
	SELECT A00065.ColID, A00065.ColSQLDataType
	FROM A01065 WITH (NOLOCK) 
	INNER JOIN A00065 WITH (NOLOCK) ON A01065.ImportTemplateID = A00065.ImportTransTypeID
	WHERE A01065.ImportTemplateID = @ImportTransTypeID
	ORDER BY A00065.OrderNum
			
OPEN @cCURSOR									
-- Tạo cấu trúc bảng tạm
FETCH NEXT FROM @cCURSOR INTO @ColID, @ColSQLDataType	
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @sSQL = 'ALTER TABLE #Data ADD ' + @ColID + ' ' + @ColSQLDataType + CASE WHEN @ColSQLDataType LIKE '%char%' THEN ' COLLATE SQL_Latin1_General_CP1_CI_AS' ELSE '' END + ' NULL'
	PRINT @sSQL
	EXEC (@sSQL)
	FETCH NEXT FROM @cCURSOR INTO @ColID, @ColSQLDataType
END 
CLOSE @cCURSOR

SET @sSQL =' ALTER TABLE #Data ADD APKMaster VARCHAR(50) NULL'
EXEC (@sSQL)

SELECT  X.Data.query('OrderNo').value('.', 'INT') AS [Row],
		X.Data.query('DivisionID').value('.', 'VARCHAR(50)') AS DivisionID,
		X.Data.query('VoucherTypeID').value('.', 'VARCHAR(50)') AS VoucherTypeID,
		X.Data.query('VoucherNo').value('.', 'VARCHAR(50)') AS VoucherNo,
		X.Data.query('VoucherDate').value('.', 'VARCHAR(50)') AS VoucherDate, 
		X.Data.query('ObjectID').value('.', 'VARCHAR(50)') AS ObjectID, 
		X.Data.query('DeliveryAddress').value('.', 'NVARCHAR(250)') AS DeliveryAddress, 
		X.Data.query('InventoryID').value('.', 'VARCHAR(50)') AS InventoryID, 
		X.Data.query('PaperTypeID').value('.', 'VARCHAR(50)') AS PaperTypeID, 
		X.Data.query('MarketID').value('.', 'NVARCHAR(250)') AS MarketID,
		(CASE WHEN X.Data.query('ActualQuantity').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('ActualQuantity').value('.', 'DECIMAL(28,8)') END) AS ActualQuantity,
		X.Data.query('ColorPrint01').value('.', 'NVARCHAR(250)') AS ColorPrint01, 
		X.Data.query('ColorPrint02').value('.', 'NVARCHAR(250)') AS ColorPrint02, 
		(CASE WHEN X.Data.query('Length').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('Length').value('.', 'DECIMAL(28,8)') END) AS [Length],
		(CASE WHEN X.Data.query('Width').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('Width').value('.', 'DECIMAL(28,8)') END) AS Width,
		(CASE WHEN X.Data.query('Height').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('Height').value('.', 'DECIMAL(28,8)') END) AS Height,
		(CASE WHEN X.Data.query('PrintSize').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('PrintSize').value('.', 'DECIMAL(28,8)') END) AS PrintSize,
		(CASE WHEN X.Data.query('CutSize').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('CutSize').value('.', 'DECIMAL(28,8)') END) AS CutSize,
		(CASE WHEN X.Data.query('LengthPaper').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('LengthPaper').value('.', 'DECIMAL(28,8)') END) AS LengthPaper,
		(CASE WHEN X.Data.query('WithPaper').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('WithPaper').value('.', 'DECIMAL(28,8)') END) AS WithPaper,
		X.Data.query('ProductQuality').value('.', 'NVARCHAR(250)') AS ProductQuality,
		X.Data.query('TransportAmount').value('.', 'NVARCHAR(250)') AS TransportAmount,
		(CASE WHEN X.Data.query('InvenPrintSheet').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('InvenPrintSheet').value('.', 'DECIMAL(28,8)') END) AS InvenPrintSheet,
		(CASE WHEN X.Data.query('InvenMold').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('InvenMold').value('.', 'DECIMAL(28,8)') END) AS InvenMold,
		X.Data.query('Pack').value('.', 'VARCHAR(25)') AS Pack,
		X.Data.query('OffsetPaper').value('.', 'VARCHAR(25)') AS OffsetPaper,
		X.Data.query('PrintNumber').value('.', 'VARCHAR(25)') AS PrintNumber,
		X.Data.query('FilmDate').value('.', 'VARCHAR(25)') AS FilmDate,
		(CASE WHEN X.Data.query('LengthFilm').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('LengthFilm').value('.', 'DECIMAL(28,8)') END) AS LengthFilm,
		(CASE WHEN X.Data.query('WidthFilm').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('WidthFilm').value('.', 'DECIMAL(28,8)') END) AS WidthFilm,
		X.Data.query('StatusFilm').value('.', 'VARCHAR(50)') AS StatusFilm,
		X.Data.query('StatusMold').value('.', 'VARCHAR(50)') AS StatusMold,
		X.Data.query('Structure1').value('.', 'VARCHAR(50)') AS Structure1,
		X.Data.query('Structure2').value('.', 'VARCHAR(50)') AS Structure2,
		X.Data.query('Structure3').value('.', 'VARCHAR(50)') AS Structure3,
		X.Data.query('Structure4').value('.', 'VARCHAR(50)') AS Structure4,
		X.Data.query('Structure5').value('.', 'VARCHAR(50)') AS Structure5,
		X.Data.query('Structure6').value('.', 'VARCHAR(50)') AS Structure6,
		X.Data.query('Structure7').value('.', 'VARCHAR(50)') AS Structure7,
		X.Data.query('Structure8').value('.', 'VARCHAR(50)') AS Structure8,
		X.Data.query('Structure9').value('.', 'VARCHAR(50)') AS Structure9,
		X.Data.query('Structure10').value('.', 'VARCHAR(50)') AS Structure10,
		NEWID() AS APKMaster,
		IDENTITY(int, 1, 1) AS Orders			
INTO #CRMT2100
FROM @XML.nodes('//Data') AS X (Data)
ORDER BY [Row]

INSERT INTO #Data ([Row],Orders,APKMaster, DivisionID, VoucherTypeID, VoucherNo, VoucherDate, ObjectID, DeliveryAddress,InventoryID,PaperTypeID,MarketID,ActualQuantity,ColorPrint01,ColorPrint02,
[Length],Width,Height,PrintSize,CutSize,LengthPaper,WithPaper,ProductQuality,TransportAmount,InvenPrintSheet,InvenMold,Pack,OffsetPaper,PrintNumber,FilmDate,LengthFilm,WidthFilm,StatusFilm,StatusMold,Structure1,Structure2,Structure3,Structure4,Structure5,Structure6,Structure7,Structure8,Structure9,Structure10,VoucherDate1)

SELECT [Row], Orders, APKMaster,DivisionID,  VoucherTypeID, VoucherNo,FORMAT(CONVERT(DATETIME, VoucherDate, 104), 'MM/yyyy'), ObjectID, DeliveryAddress,InventoryID,PaperTypeID,MarketID,ActualQuantity,ColorPrint01,ColorPrint02
,[Length],Width,Height,PrintSize,CutSize,LengthPaper,WithPaper,ProductQuality,TransportAmount,InvenPrintSheet,InvenMold,Pack,OffsetPaper,PrintNumber,CASE WHEN ISNULL(FilmDate, '') = '' THEN NULL ELSE CONVERT(datetime, FilmDate, 104) END AS FilmDate,LengthFilm,WidthFilm,StatusFilm,StatusMold,Structure1,Structure2,Structure3,Structure4,Structure5,Structure6,Structure7,Structure8,Structure9,Structure10
, CASE WHEN ISNULL(VoucherDate, '') = '' THEN NULL ELSE CONVERT(datetime, VoucherDate, 104) END AS VoucherDate1
FROM #CRMT2100 WITH (NOLOCK)

---------- Kiểm tra check code mặc định
EXEC CMNP8105 @ImportTemplateID = @ImportTransTypeID, @UserID = @UserID

---------- Kiểm tra trùng mã khối
--EXEC CMNP8100 @UserID = @UserID, @ImportTemplateID = @ImportTransTypeID, @CheckCode = 'CheckDuplicateData', @ColID = 'VoucherNo', @Param1 = 'Orders', @Param2 = 'CRMT2100', 
--@Param3 = 'VoucherNo'

-------- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ErrorMessage <> '')
BEGIN
		UPDATE #Data SET ErrorMessage = LEFT(ErrorMessage, LEN(ErrorMessage) -1),
							ErrorColumn = LEFT(ErrorColumn, LEN(ErrorColumn) -1)
		WHERE ErrorMessage <> ''

		GOTO LB_RESULT
END

BEGIN TRY
    BEGIN TRANSACTION

	DECLARE 
        @TableBusiness VARCHAR(10) = 'CRMT2100',
        @VoucherNo VARCHAR(50),
        @NewVoucherNo VARCHAR(50),
        @KeyString VARCHAR(50),
        @LastKey INT,
		@VoucherTypeID VARCHAR(50),
		@CurTemp CURSOR,
		@APKMaster VARCHAR(50),
		@InventoryID VARCHAR(50),
		@tempDivisionID VARCHAR(50),
		@VoucherDate1 Datetime

	---- BEGIN - Xử lý tăng số chứng từ tự động

	SELECT DISTINCT [Row], [Row] AS NewVoucherNo
	INTO #VoucherData
	FROM #Data
	ORDER BY [Row]

	WHILE EXISTS (SELECT TOP 1 1 FROM #VoucherData)
	BEGIN
		 SELECT @VoucherNo = [Row] FROM #VoucherData

		 -- Lấy mã chứng từ mặc định theo màn hình
		 SELECT @VoucherTypeID = VoucherTypeID FROM AT1007 WITH (NOLOCK) WHERE ScreenID = 'CRMF2101' AND ModuleID = 'CRM' AND DivisionID = @DivisionID

		EXEC GetVoucherNo_Ver2 @DivisionID, 'CRM', 'CRMF2101', @TableBusiness, @NewVoucherNo OUTPUT, @KeyString OUTPUT, @LastKey OUTPUT
		PRINT @NewVoucherNo

		-- Cập nhật mã chứng từ vào bảng dữ liệu import từ Excel
		UPDATE #Data SET VoucherTypeID = IIF(ISNULL(@VoucherTypeID, '') = '', VoucherTypeID, @VoucherTypeID) WHERE [Row] = @VoucherNo

		-- Cập nhật số chứng từ vào bảng dữ liệu import từ Excel
		UPDATE #Data SET VoucherNo = @NewVoucherNo WHERE [Row] = @VoucherNo

		-- Cập nhật LastKey cho bảng đăng ký số chứng từ tự động
		IF NOT EXISTS (SELECT TOP 1 1 FROM AT4444 WITH (NOLOCK) WHERE TableName = @TableBusiness AND KeyString = @KeyString)
		BEGIN
			INSERT INTO AT4444 (DivisionID,TABLENAME,KEYSTRING,LASTKEY)
			VALUES (@DivisionID,@TableBusiness,@KeyString,@LastKey)
		END
		ELSE
		BEGIN
			UPDATE AT4444 SET LastKey = @LastKey WHERE TableName = @TableBusiness AND KeyString = @KeyString
		END

		DELETE #VoucherData WHERE [Row] = @VoucherNo
	END

	---- Đẩy dữ liệu vào master yêu cầu khách hàng
	INSERT INTO CRMT2100 (APK, DivisionID,  VoucherTypeID, VoucherNo, VoucherDate, TranMonth, TranYear,ObjectID,DeliveryAddress, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	SELECT APKMaster,DivisionID,VoucherTypeID, VoucherNo, VoucherDate1, Month(VoucherDate1), YEAR(VoucherDate1), ObjectID, DeliveryAddress, @UserID AS CreateUserID,GETDATE() AS CreateDate, @UserID AS LastModifyUserID, GETDATE() AS LastModifyDate				
	FROM #Data WITH (NOLOCK)

	---- Đẩy dữ liệu vào detail yêu cầu khách hàng
	INSERT INTO CRMT2101 (APK, DivisionID, APKMaster, InventoryID, PaperTypeID, TranMonth, TranYear,MarketID,ActualQuantity,ColorPrint01,ColorPrint02
	,[Length],Width,Height,PrintSize,CutSize,LengthPaper,WidthPaper,ProductQuality,TransportAmount,InvenPrintSheet,InvenMold,Pack,OffsetPaper,PrintNumber,FilmDate,LengthFilm,WidthFilm,StatusFilm,StatusMold, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate,
	IsDiscCD, IsSampleInventoryID, IsSampleEmail, IsFilm, SideColor1, SideColor2)

	SELECT NEWID(),DivisionID,APKMaster, InventoryID, PaperTypeID, Month(VoucherDate1), YEAR(VoucherDate1),MarketID,ActualQuantity,ColorPrint01,ColorPrint02
	,[Length],Width,Height,PrintSize,CutSize,LengthPaper,WithPaper,ProductQuality,TransportAmount,InvenPrintSheet,InvenMold,Pack,OffsetPaper,PrintNumber,FilmDate,LengthFilm,WidthFilm,StatusFilm,StatusMold, @UserID AS CreateUserID,GETDATE() AS CreateDate, @UserID AS LastModifyUserID, GETDATE() AS LastModifyDate
	,0 as IsDiscCD,0 as IsSampleInventoryID,0 as IsSampleEmail ,0 as IsFilm ,Case when ISNULL(ColorPrint01,'') <> '' then 1 else 0  end as SideColor1 ,Case when ISNULL(ColorPrint01,'') <> '' then 1 else 0 end as SideColor2				
	FROM #Data WITH (NOLOCK)

	 --Đẩy dữ liệu vào CRMT2104 ---------
	CREATE TABLE #CRMP21011(	
		PhaseOrder INT
		,APK UNIQUEIDENTIFIER
		,APKNodeParent UNIQUEIDENTIFIER
		,NodeParent  UNIQUEIDENTIFIER
		,NodeOrder INT
		,UnitID  NVARCHAR(50)
		,UnitName NVARCHAR(250)
		,NodeTypeID VARCHAR(50)
		,NodeTypeName NVARCHAR(250)
		,InventoryID VARCHAR(50)
		,MaterialName NVARCHAR(250)
		,KindSuppliers NVARCHAR(50)
		,KindSupplierName NVARCHAR(250)
		,PhaseID VARCHAR(50)
		,PhaseName NVARCHAR(250)
		,DisplayName NVARCHAR(500)
		,DisplayMember NVARCHAR(250)
		,CreateUserID VARCHAR(50)
		,CreateDate DATETIME
		,LastModifyUserID VARCHAR(50)
		,LastModifyDate DATETIME)

	SET @CurTemp  = CURSOR SCROLL KEYSET FOR
	SELECT T1.DivisionID,T1.APKMaster,T1.InventoryID,T1.VoucherDate1
	FROM #Data T1 WITH (NOLOCK)
	WHERE T1.InventoryID IS NOT NULL
	OPEN @curTemp
	FETCH NEXT FROM @CurTemp INTO  @tempDivisionID,@APKMaster,@InventoryID,@VoucherDate1
	WHILE @@Fetch_Status = 0
	BEGIN
		INSERT INTO #CRMP21011 
		EXEC CRMP21011 @InventoryID

		INSERT INTO CRMT2104 (APK, DivisionID, APKMaster, TranMonth, TranYear,PhaseOrder,APKNodeParent,NodeParent,UnitID,NodeTypeID,
							 KindSuppliers,PhaseID,DisplayName,CreateUserID,CreateDate,LastModifyUserID,LastModifyDate)
		SELECT NEWID(),@tempDivisionID,@APKMaster,Month(@VoucherDate1), YEAR(@VoucherDate1),PhaseOrder,APKNodeParent,NodeParent,UnitID,NodeTypeID,
							KindSuppliers,PhaseID,DisplayName,CreateUserID,CreateDate,LastModifyUserID,LastModifyDate				
		FROM #CRMP21011 T1 

		DELETE FROM #CRMP21011
	FETCH NEXT FROM @CurTemp INTO @tempDivisionID,@APKMaster,@InventoryID,@VoucherDate1
	END            
	CLOSE @CurTemp
	DEALLOCATE @CurTemp

	DROP TABLE #CRMP21011

	--Đẩy dữ liệu vào CRMT2102 ---------
	DECLARE @varString VARCHAR(500) = (SELECT TOP 1 ClassifyID FROM CRMT00000 WITH (NOLOCK))
	SELECT VALUE AS AnaID INTO #tbl_tmp
	FROM dbo.StringSplit(@varString, ',')

	SELECT * 
		Into #AT1015
	FROM(
		-- Load chung loai cau truc
		SELECT AnaID, AnaName, 2 as AnaTypeID
		FROM AT1015 WITH (NOLOCK)
		WHERE DivisionID IN (@DivisionID, '@@@')
			AND Disabled = 0
			AND AnaTypeID = 'I02'
			AND AnaID IN (SELECT AnaID FROM #tbl_tmp)
		-- Load ket cau giay
		Union all
		SELECT AnaID, AnaName,3 as AnaTypeID
		FROM AT1015 WITH (NOLOCK)
		WHERE DivisionID IN (@DivisionID, '@@@')
			AND Disabled = 0
			AND AnaTypeID = 'I03' ) AS P

	DECLARE @i int =1
	WHILE (@i<=10)
	BEGIN
		SET @sSQL2 = N' 
		INSERT INTO CRMT2102 (APK, DivisionID, APKMaster, TranMonth, TranYear,Type,AnaID,AnaName,CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT NEWID(),T1.DivisionID,APKMaster,Month(VoucherDate1), YEAR(VoucherDate1),T2.AnaTypeID,T1.Structure'+ CONVERT(VARCHAR,@i)+',T2.AnaName, '''+@UserID+''' AS CreateUserID,GETDATE() AS CreateDate, '''+@UserID+''' AS LastModifyUserID, GETDATE() AS LastModifyDate				
		FROM #Data T1 
		LEFT JOIN #AT1015 T2 ON T1.Structure'+ CONVERT(VARCHAR,@i)+' = T2.AnaID
		WHERE ISNULL(T1.Structure'+CONVERT(VARCHAR,@i)+' ,'''') <> '''' '

		--print @sSQL2
		EXEC (@sSQL2)
		SET @i = @i+1
	END

	---------->Update mã tự động
	--DECLARE @cPKey AS CURSOR
	--DECLARE @Row AS INT,
	--	@StrDivisionID AS NVARCHAR(50),
	--	@VoucherTypeID AS NVARCHAR(50),
	--	@VoucherDate AS datetime,
	--	@TranMonth AS INT,
	--	@TranYear AS INT

	--SET @cPKey = CURSOR FOR
	--SELECT top 1 T1.Orders, T1.DivisionID as StrDivisionID, T1.VoucherTypeID, T1.VoucherDate1, Month(VoucherDate1) as TranMonth, Year(VoucherDate1) as TranYear
	--FROM	#Data T1
	--ORDER BY  T1.Row DESC
		
	--OPEN @cPKey
	--FETCH NEXT FROM @cPKey INTO @Row,@StrDivisionID, @VoucherTypeID, @VoucherDate, @TranMonth, @TranYear
	--WHILE @@FETCH_STATUS = 0
	--BEGIN
	--		DECLARE	@StringKey1 nvarchar(50), @StringKey2 nvarchar(50),@StringKey3 nvarchar(50), 
	--						@OutputLen int, @OutputOrder int,
	--						@Separated int, @Separator char(1),
	--						@Enabled1 tinyint, @Enabled2 tinyint, @Enabled3 tinyint,
	--						@S1 nvarchar(50), @S2 nvarchar(50),@S3 nvarchar(50),
	--						@S1Type tinyint, @S2Type tinyint,@S3Type tinyint,
	--						@KeyString AS NVARCHAR(50),
	--						@LastKey INT,
	--						@TableName NVARCHAR(50) ='CRMT2100'

	--				Select	@Enabled1=Enabled1, @Enabled2=Enabled2, @Enabled3=Enabled3, @S1=S1, @S2=S2, @S3=S3, @S1Type=S1Type, @S2Type=S2Type, @S3Type=S3Type
	--						, @OutputLen = OutputLength, @OutputOrder= OutputOrder,@Separated= Separated,@Separator= Separator
	--				FROM	AT1007 WITH (NOLOCK)
	--				WHERE	DivisionID = @DivisionID AND VoucherTypeID = @VoucherTypeID 
	--					If @Enabled1 = 1
	--						Set @StringKey1 = Case @S1Type When 1 Then Case When STR(@TranMonth) <10 Then '0' + ltrim(STR(@TranMonth)) Else ltrim(STR(@TranMonth)) End
	--														When 2 Then ltrim(STR(@TranYear))
	--														When 3 Then @VoucherTypeID
	--														When 4 Then @StrDivisionID
	--														When 5 Then @S1 Else '' End
	--					Else Set @StringKey1 = ''
	--					If @Enabled2 = 1
	--						Set @StringKey2 = Case @S2Type When 1 Then Case When STR(@TranMonth) <10 Then '0' + ltrim(STR(@TranMonth)) Else ltrim(STR(@TranMonth)) End
	--														When 2 Then ltrim(STR(@TranYear))
	--														When 3 Then @VoucherTypeID
	--														When 4 Then @StrDivisionID
	--														When 5 Then @S2 Else '' End
	--					Else Set @StringKey2 = ''
	--					If @Enabled3 = 1
	--						Set @StringKey3 = Case @S3Type When 1 Then Case When STR(@TranMonth) <10 Then '0'+ ltrim(STR(@TranMonth)) Else @TranMonth End
	--														When 2 Then ltrim(STR(@TranYear))
	--														When 3 Then @VoucherTypeID
	--														When 4 Then @StrDivisionID
	--														When 5 Then @S3
	--														Else '' End 

	--		SET @KeyString = @StringKey1 + @StringKey2 + @StringKey3

	--		print @KeyString

	--		IF NOT EXISTS (SELECT TOP 1 1 FROM AT4444 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND TableName = @TableName AND KeyString = @KeyString)
	--		INSERT INTO AT4444 (DivisionID, TableName, KeyString, LastKey) SELECT @DivisionID, @TableName, @KeyString, 0
	
	--		UPDATE AT4444 SET @LastKey = LastKey + 1, LastKey = LastKey + @Row
	--		WHERE DivisionID = @DivisionID AND TableName = @TableName AND KeyString = @KeyString
				
	--FETCH NEXT FROM @cPKey INTO  @Row,@StrDivisionID, @VoucherTypeID, @VoucherDate, @TranMonth, @TranYear
	--END	
	--CLOSE @cPKey

COMMIT
END TRY
BEGIN CATCH
    ROLLBACK
END CATCH

LB_RESULT:
SELECT [Row], ErrorColumn, ErrorMessage FROM #Data 
WHERE  ErrorColumn <> ''
ORDER BY [Row]

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
