IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP7620_ERP9]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP7620_ERP9]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-------------------Created by Nguyen Van Nhan.  
------------------ Created Date 14/06/2006  
----------------- Purpose: In bao cao bang ket qua kinh doanh. theo ma phan tich  
----------------- Last updated by Van Nhan, date 24/01/2008  
----------------- Edit by: Dang Le Bao Quynh; Date 05/08/2008  
----------------- Sua lai cac quy tac cap nhat dong theo cac toan tu + - * /  
----------------- Edit by: Nguyen Quoc Huy; Date 10/10/2008  
---- Modified by on 11/10/2012 by Lê Thị Thu Hiền : Bổ sung thêm strDivisionID  
---- Modified on 17/04/2013 by Lê Thị Thu Hiền : Amount21, Amount22, Amount23, Amount24,  
---- Modified on 24/05/2013 by Đặng Lê Bảo Quỳnh : Bổ sung 24 cột kỳ trước  
---- Modified on 22/10/2013 by Khanh Van: Fix lỗi
---- Modified on 24/12/2013 by Bảo Anh : Sửa lỗi dữ liệu lên sai ở chỉ tiêu được tính từ các chỉ tiêu khác (Vimec)
---- Modified on 20/01/2014 by Khanh Van: Thêm customize index cho Sieu Thanh   
---- Modified on 05/03/2014 by Le Thi Thu Hien : Bo sung phan quyen xem du lieu cua nguoi khac
---- Modified on 28/09/2016 by Phuong Thao: Bo sung dieu kien loc theo ma phan tich
---- Modified on 26/06/2017 by Phuong Thao: Sửa danh mục dùng chung
---- Modified on 21/11/2018 by Hoàng Vũ: Xử lý phân biệt xuất excel và In theo thời gian search (Tháng/Quý/năm) => Xuất Excel cho khách hàng ATTOM và OKIA
---- Modified on 12/08/2019 by Trà Giang: Bổ sung gọi view AV9090_AT, MPT Ana04ID cho ATTOM (98). 
---- Modified on 10/02/2020 by Văn Tài: Bổ sung chú ý: Store này được dùng chung trên hệ thống ERP 9.
---- <Example>
---- 
---- <Summary>
CREATE PROCEDURE [dbo].[AP7620_ERP9]   
  @DivisionID AS nvarchar(50),   
  @ReportCode AS nvarchar(50),   
  @FromMonth int,   
  @FromYear  int,   
  @ToMonth int,   
  @ToYear  int,  
  @ValueID AS xml,   
  @StrDivisionID AS NVARCHAR(4000) = '' ,
  @UserID AS VARCHAR(50) = '' ,
  @FromSelection01 AS VARCHAR(50) = '',
  @ToSelection01 AS VARCHAR(50) = '',
  @FromSelection02 AS VARCHAR(50) = '',
  @ToSelection02 AS VARCHAR(50) = '',
  @FromSelection03 AS VARCHAR(50) = '',
  @ToSelection03 AS VARCHAR(50) = '',
  @FromSelection04 AS VARCHAR(50) = '',
  @ToSelection04 AS VARCHAR(50) = '',
  @FromSelection05 AS VARCHAR(50) = '',
  @ToSelection05 AS VARCHAR(50) = '',
  @IsExcelorPrint tinyint = NULL, --1: In; 2: Xuất Excel
  @IsPeriod int = NULL	--1: Theo kỳ; 2: Theo Quý; 3: Năm
  
AS
BEGIN
	
		DECLARE @ReportID NVARCHAR(50)
		SET @ReportID = (SELECT ReportID FROM AT7620 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND ReportCode = @ReportCode)

		SET NOCOUNT ON  
		Declare @FieldID AS NVARCHAR(50),  
				@ChildSign  AS NVARCHAR(5),  
				@sSQL AS NVARCHAR(4000),  
				@FilterMaster AS NVARCHAR(50),  
				@FilterDetail AS NVARCHAR(50),  
				@LineID AS NVARCHAR(50),  
				@LevelID AS INT,    
				@Sign AS NVARCHAR(5),   
				@AccuLineID AS NVARCHAR(50),   
				@CaculatorID AS NVARCHAR(50),   
				@FromAccountID AS NVARCHAR(50),   
				@ToAccountID AS NVARCHAR(50),   
				@FromCorAccountID AS NVARCHAR(50),   
				@ToCorAccountID AS NVARCHAR(50),    
				@AnaTypeID AS NVARCHAR(50),    
				@FromAnaID AS NVARCHAR(50),     
				@ToAnaID AS NVARCHAR(50),  
				@BudgetID AS NVARCHAR(50),   
				@Cur_LevelID AS CURSOR,  
				@Cur AS CURSOR,  
				@Cur_Ana AS CURSOR,  				
				@Amount AS DECIMAL(28,8),  
				@AmountLastPeriod AS DECIMAL(28,8),  
				@AmountA AS DECIMAL(28,8),  
				@AmountALastPeriod AS DECIMAL(28,8), 		
				@AnaID AS NVARCHAR(50),  
				@I  AS INT,  
				@FromMonthLastPeriod INT,   
				@FromYearLastPeriod  INT,   
				@ToMonthLastPeriod INT,   
				@ToYearLastPeriod  INT  ,
				@CustomerName INT,
				-- Tổng số lượng các cột Amount để đáp ứng danh sách value.
				@ColumnCount INT
		----------------->>>>>> Phân quyền xem chứng từ của người dùng khác		
		DECLARE @sSQLPer AS NVARCHAR(MAX),
				@sWHEREPer AS NVARCHAR(MAX),
				@Selection01 AS Nvarchar(50),
				@Selection02 AS Nvarchar(50),
				@Selection03 AS Nvarchar(50),
				@Selection04 AS Nvarchar(50),
				@Selection05 AS Nvarchar(50),
				@Temp AS NVARCHAR(MAX),		
				@strSQLFilter AS NVARCHAR(MAX) = '',			
				@strWhere AS NVARCHAR(MAX) = '',
				@strSelect AS NVARCHAR(MAX) = '',		
				@strTable AS NVARCHAR(MAX) = ''	,

				@strUpdateAT7622Temp AS NVARCHAR(MAX) = '',
				@strUpdateAT7622Row AS NVARCHAR(MAX) = '',
				@strUpdateRowAmount AS NVARCHAR(MAX) = '',
				@strUpdateRowAmountLastPeriod AS NVARCHAR(MAX) = '',
				@strUpdateRowAmountA AS NVARCHAR(MAX) = '',
				@strUpdateRowAmountALastPeriod AS NVARCHAR(MAX) = ''

		SET @sSQLPer = ''
		SET @sWHEREPer = ''		

--BEGIN: Load dữ liệu từ xml params:
	IF EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[tmpValue]') AND TYPE IN (N'U'))
						DROP TABLE tmpValue
	CREATE TABLE tmpValue
	(
		 ValueID varchar(50)
	)

	INSERT INTO	tmpValue		
	SELECT	X.D.value('.', 'VARCHAR(50)') AS ValueID
	FROM	@ValueID.nodes('//D') AS X (D)

	SET @ColumnCount = (SELECT COUNT(ValueID) FROM tmpValue)
--END: Load dữ liệu từ xml params-----

--BEGIN: Xây dựng cấu trúc bảng tạm để tính toán.
	DECLARE @colIndex INT = 1
	DECLARE @strAmountList VARCHAR(MAX) = ''
	DECLARE @strAmountLastPeriodList VARCHAR(MAX) = ''
	DECLARE @strAmountAList VARCHAR(MAX) = ''
	DECLARE @strAmountALastPeriodList VARCHAR(MAX) = ''
	DECLARE @strUpdateTable01 NVARCHAR(MAX) = ''
	DECLARE @strUpdateTable02 NVARCHAR(MAX) = ''
	DECLARE @strUpdateTable03 NVARCHAR(MAX) = ''
	DECLARE @strUpdateTable04 NVARCHAR(MAX) = ''

	-- Bảng tạm dữ liệu báo cáo
	CREATE TABLE #AT7622 (
		[APK] UNIQUEIDENTIFIER NULL,
		[DivisionID] NVARCHAR(50) NULL,
		[ReportCode] NVARCHAR(50) NULL,
		[LineID] NVARCHAR(50) NULL, 
		[LineCode] NVARCHAR(50) NULL,
		[LineDescription] NVARCHAR(250) NULL,
		[LevelID] TINYINT NULL	
	)
	
	-- Bảng tạm lưu danh sách các biến theo cột để tính toán.
	CREATE TABLE #AT7622Row (
		[APK] UNIQUEIDENTIFIER NULL,
		[DivisionID] NVARCHAR(50) NULL,
		[ReportCode] NVARCHAR(50) NULL,
		[LineID] NVARCHAR(50) NULL, 
		[LineCode] NVARCHAR(50) NULL,
		[LineDescription] NVARCHAR(250) NULL,
		[LevelID] TINYINT NULL,
		[Sign] NVARCHAR(5) NULL,
		[AccuLineID] NVARCHAR(50) NULL, 
	)

	WHILE (@colIndex <= @ColumnCount)
	BEGIN
		
		IF(@colIndex < @ColumnCount)
		BEGIN
		SET @strAmountList = @strAmountList + CASE WHEN @colIndex < 10 
							 THEN N' Amount0' + CAST(@colIndex AS VARCHAR(5)) + ' DECIMAL(28,8) NULL DEFAULT 0, 
							 '
							 ELSE N' Amount' + CAST(@colIndex AS VARCHAR(5)) + ' DECIMAL(28,8) NULL DEFAULT 0, 
							 '
							 END
		SET @strAmountLastPeriodList = @strAmountLastPeriodList + CASE WHEN @colIndex < 10
							 THEN N' Amount0' + CAST(@colIndex AS VARCHAR(5)) + 'LastPeriod DECIMAL(28, 8) NULL DEFAULT 0, 
							 '
							 ELSE N' Amount' + CAST(@colIndex AS VARCHAR(5)) + 'LastPeriod DECIMAL(28, 8) NULL DEFAULT 0, 
							 '
							 END
		SET @strAmountAList = @strAmountAList + CASE WHEN @colIndex < 10 
							 THEN N' Amount0' + CAST(@colIndex AS VARCHAR(5)) + 'A DECIMAL(28, 8) NULL DEFAULT 0, 
							 '
							 ELSE N' Amount' + CAST(@colIndex AS VARCHAR(5)) + 'A DECIMAL(28, 8) NULL DEFAULT 0, 
							 '
							 END
		SET @strAmountALastPeriodList = @strAmountALastPeriodList + CASE WHEN @colIndex < 10 
							THEN N' Amount0' + CAST(@colIndex AS VARCHAR(5)) + 'ALastPeriod DECIMAL(28, 8) NULL DEFAULT 0, 
							 '
							 ELSE N' Amount' + CAST(@colIndex AS VARCHAR(5)) + 'ALastPeriod DECIMAL(28, 8) NULL DEFAULT 0, 
							 '
							 END
		END
		ELSE
		BEGIN
		SET @strAmountList = @strAmountList + CASE WHEN @colIndex < 10 
							 THEN N' Amount0' + CAST(@colIndex AS VARCHAR(5)) + ' DECIMAL(28, 8) NULL DEFAULT 0; 
							 '
							 ELSE N' Amount' + CAST(@colIndex AS VARCHAR(5)) + ' DECIMAL(28, 8) NULL DEFAULT 0;
							 '
							 END
		SET @strAmountLastPeriodList = @strAmountLastPeriodList + CASE WHEN @colIndex < 10
							 THEN N' Amount0' + CAST(@colIndex AS VARCHAR(5)) + 'LastPeriod DECIMAL(28, 8) NULL DEFAULT 0;
							 '
							 ELSE N' Amount' + CAST(@colIndex AS VARCHAR(5)) + 'LastPeriod DECIMAL(28, 8) NULL DEFAULT 0;
							 '
							 END
		SET @strAmountAList = @strAmountAList + CASE WHEN @colIndex < 10 
							 THEN N' Amount0' + CAST(@colIndex AS VARCHAR(5)) + 'A DECIMAL(28, 8) NULL DEFAULT 0;
							 '
							 ELSE N' Amount' + CAST(@colIndex AS VARCHAR(5)) + 'A DECIMAL(28, 8) NULL DEFAULT 0;
							 '
							 END
		SET @strAmountALastPeriodList = @strAmountALastPeriodList + CASE WHEN @colIndex < 10 
							THEN N' Amount0' + CAST(@colIndex AS VARCHAR(5)) + 'ALastPeriod DECIMAL(28, 8) NULL DEFAULT 0; 
							 '
							 ELSE N' Amount' + CAST(@colIndex AS VARCHAR(5)) + 'ALastPeriod DECIMAL(28, 8) NULL DEFAULT 0; 
							 '
							 END
		END

		SET @colIndex = @colIndex + 1
	END

	SET @strUpdateTable01 = 'ALTER TABLE #AT7622 
	ADD
	' + @strAmountList

	SET @strUpdateTable02 = ' ALTER TABLE #AT7622 
	ADD
	' + @strAmountLastPeriodList

	SET @strUpdateTable03 = ' ALTER TABLE #AT7622 
	ADD
	' + @strAmountAList

	SET @strUpdateTable04 = ' ALTER TABLE #AT7622 
	ADD
	' + @strAmountALastPeriodList

	EXEC (@strUpdateTable01)
	EXEC (@strUpdateTable02)
	EXEC (@strUpdateTable03)
	EXEC (@strUpdateTable04)
		 
	--PRINT (@strUpdateTable01)
	--PRINT (@strUpdateTable02)
	--PRINT (@strUpdateTable03)
	--PRINT (@strUpdateTable04)

	SET @strUpdateTable01 = 'ALTER TABLE #AT7622Row 
	ADD
	' + @strAmountList

	SET @strUpdateTable02 = ' ALTER TABLE #AT7622Row
	ADD
	' + @strAmountLastPeriodList

	SET @strUpdateTable03 = ' ALTER TABLE #AT7622Row
	ADD
	' + @strAmountAList

	SET @strUpdateTable04 = ' ALTER TABLE #AT7622Row 
	ADD
	' + @strAmountALastPeriodList

	EXEC (@strUpdateTable01)
	EXEC (@strUpdateTable02)
	EXEC (@strUpdateTable03)
	EXEC (@strUpdateTable04)
	EXEC ('INSERT INTO #AT7622Row(APK)
			VALUES (NEWID());')
		 
	--PRINT (@strUpdateTable01)
	--PRINT (@strUpdateTable02)
	--PRINT (@strUpdateTable03)
	--PRINT (@strUpdateTable04)
	--PRINT ('INSERT INTO #AT7622Row(APK)
	--		VALUES (NEWID());')

	--SELECT * FROM #AT7622

--END: Xây dựng cấu trúc bảng tạm để tính toán.

	-- Bổ sung phân quyền người dùng.
	IF EXISTS (SELECT TOP 1 1 FROM AT0000 WHERE DefDivisionID = @DivisionID AND IsPermissionView = 1 ) -- Nếu check Phân quyền xem dữ liệu tại Thiết lập hệ thống thì mới thực hiện
		BEGIN
			SET @sSQLPer = ' LEFT JOIN AT0010 ON AT0010.DivisionID = AV9090.DivisionID 
												AND AT0010.AdminUserID = ''' + @UserID + ''' 
												AND AT0010.UserID = AV9090.CreateUserID '
			SET @sWHEREPer = 'AND (AV9090.CreateUserID = AT0010.UserID
									OR  AV9090.CreateUserID = ''' + @UserID + ''') '		
		END

	-----------------<<<<<< Phân quyền xem chứng từ của người dùng khác	
	CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
	INSERT #CustomerName EXEC AP4444
	SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

	IF ISNULL(@IsExcelorPrint, 1) = 1
	BEGIN   

		-- Xác định tháng, năm cuối kỳ trước
		SELECT @FromMonthLastPeriod = FromMonth,  
			@FromYearLastPeriod = FromYear,  
			@ToMonthLastPeriod = ToMonth,  
			@ToYearLastPeriod = ToYear  
		FROM dbo.GetLastPeriod(@FromMonth, @FromYear, @ToMonth, @ToYear)  
     
		SELECT	@FieldID = FieldID ,
				@Selection01 = Selection01,
				@Selection02 = Selection02,
				@Selection03 = Selection03,
				@Selection04 = Selection04,
				@Selection05 = Selection05
		FROM AT7620   
		WHERE ReportCode = @ReportCode   
			AND DivisionID = @DivisionID  

		EXEC AP4700  @FieldID, @FilterMaster output   

		---Print @FilterMaster  
		--- Buoc 1 ------------------------  
		DELETE #AT7622   
		WHERE ReportCode =@ReportCode
		--WHERE DivisionID = @DivisionID  --- Xoa du lieu bang tam  
  
		--- Buoc 2 Insert du lieu vao bang tam ------------------------  
		INSERT #AT7622 (DivisionID, ReportCode, LineID, LineCode, LevelID, LineDescription)  
		SELECT DivisionID, @ReportCode, LineID, LineCode, LevelID, LineDescription   
		FROM AT7621   
		WHERE DivisionID = @DivisionID 
			AND ReportCode = @ReportCode
		ORDER BY LineID

		--SELECT * FROM #AT7622
			
		----Buoc 3 duyet tung cap tu lon den nho  
		SET @strSelect = ' 0 AS SignAmount2, '
		SET @strTable = 'AV9090'	  
  
		SET @Cur_LevelID = CURSOR SCROLL KEYSET FOR   
			SELECT DISTINCT LevelID   
			FROM AT7621  
			WHERE ReportCode = @ReportCode and DivisionID = @DivisionID  
			ORDER BY LevelID Desc  
  
		OPEN @Cur_LevelID  
		FETCH NEXT FROM @Cur_LevelID INTO  @LevelID  
		WHILE @@Fetch_Status = 0  
		BEGIN   
   
			---- Buoc 4  Tinh toan va update du lieu bang bang tam ------------------------  
			SET @Cur = CURSOR SCROLL KEYSET FOR   
				SELECT LineID, Sign, AccuLineID, CaculatorID , FromAccountID, ToAccountID, FromCorAccountID,ToCorAccountID,   
					ISNULL(AnaTypeID,''), ISNULL(FromAnaID,''), ISNULL(ToAnaID,''), BudgetID  
				FROM AT7621  
				WHERE ReportCode = @ReportCode and  LevelID = @LevelID and DivisionID = @DivisionID
				---Order by LineID 
  
			OPEN @Cur  
			FETCH NEXT FROM @Cur INTO  @LineID, @Sign, @AccuLineID, @CaculatorID, @FromAccountID, @ToAccountID, @FromCorAccountID, @ToCorAccountID,  
				@AnaTypeID,@FromAnaID , @ToAnaID, @BudgetID  
			WHILE @@Fetch_Status = 0  
			BEGIN   
  
				IF ISNULL(@AnaTypeID, '') <> ''  
				Begin  
					Exec AP4700  @AnaTypeID, @FilterDetail OUTPUT   
					SET @sSQL =' 
					SELECT	Ana01ID, Ana02ID, Ana03ID,Ana04ID, ObjectID, PeriodID, TranMonth, TranYear,   
							AV9090.DivisionID, AccountID, CorAccountID, D_C, SignAmount,' + @strSelect + '   
							SignQuantity, BudgetID, TransactionTypeID,  
							'+@FilterMaster+' AS FilterMaster,  
							'+@FilterDetail+' AS FilterDetail
					FROM	' + @strTable + @sSQLPer + '
					WHERE 1= 1 ' + @sWHEREPer + @strWhere + '		
					'  
				END  
				ELSE  
				BEGIN
					SET @sSQL =' 
					SELECT	Ana01ID, Ana02ID, Ana03ID,Ana04ID, ObjectID, PeriodID, TranMonth, TranYear,   
							AV9090.DivisionID, AccountID, CorAccountID, D_C, SignAmount,' + @strSelect + '   
							SignQuantity, BudgetID, TransactionTypeID,  
							'+@FilterMaster+' AS FilterMaster,  
							'''' AS FilterDetail  
					FROM	' + @strTable + @sSQLPer + '
					WHERE 1= 1 ' + @sWHEREPer + @strWhere + '		
					'  	 	
				END	
	 
				IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WHERE NAME = 'AV9091' AND XTYPE ='V')  
					EXEC ('  CREATE VIEW AV9091 AS ' + @sSQL)  
				ELSE  
					EXEC ('  ALTER VIEW AV9091  AS ' + @sSQL)  
				   
				SET @i = 1  
				SET @Amount = 0  
				SET @AmountLastPeriod = 0  
				SET @AmountA = 0  
				SET @AmountALastPeriod = 0  	   
		
				--- Reset row giữ biến
				DELETE FROM #AT7622Row
				INSERT INTO #AT7622Row (APK)
				VALUES (NEWID())

				SET @Cur_Ana = CURSOR SCROLL KEYSET FOR    
				SELECT SelectionID FROM AV6666  
				WHERE SelectionType = @FieldID   		
				AND Orderby IN (SELECT orderby FROM AV6666 WHERE SelectionType = @FieldID 
								AND DivisionID IN (@DivisionID,'@@@') 
								AND SelectionID IN (SELECT ValueID FROM tmpValue ))
				AND DivisionID IN (@DivisionID,'@@@') 
					ORDER BY Orderby 
				
				--- Tính toán theo từng ValueID
				OPEN @Cur_Ana  
				FETCH NEXT FROM @Cur_Ana INTO @AnaID  
				--- Khoi tao gia tri dau  
				WHILE @@Fetch_Status = 0 and @i <= @ColumnCount
				BEGIN  	
				
					EXEC AP7619 @DivisionID, @FromMonth, @FromYear, @ToMonth, @ToYear,
					  @CaculatorID, @FromAccountID, @ToAccountID, @FromCorAccountID, @ToCorAccountID,  
					  @AnaTypeID, @FromAnaID, @ToAnaID, @FieldID, @AnaID, @BudgetID, 
					  @Amount OUTPUT, @AmountA OUTPUT, @StrDivisionID  
     
					EXEC AP7619 @DivisionID, @FromMonthLastPeriod, @FromYearLastPeriod, @ToMonthLastPeriod, @ToYearLastPeriod,  
					  @CaculatorID, @FromAccountID, @ToAccountID, @FromCorAccountID, @ToCorAccountID,  
					  @AnaTypeID, @FromAnaID, @ToAnaID, @FieldID, @AnaID, @BudgetID,
					  @AmountLastPeriod OUTPUT, @AmountALastPeriod OUTPUT, @StrDivisionID   

					IF(@Amount IS NULL) SET @Amount = 0
					IF(@AmountA IS NULL) SET @AmountA = 0
					IF(@AmountLastPeriod IS NULL) SET @AmountLastPeriod = 0
					IF(@AmountALastPeriod IS NULL) SET @AmountALastPeriod = 0

					--IF(@LineID = N'C402')
					--BEGIN
					--	SELECT @Amount AS A, @AmountLastPeriod AS Last
					--END
					  				
					IF(@i < 10)
					BEGIN 
						SET @strUpdateAT7622Row = N'-- Cập nhật biến #AT7622
						UPDATE #AT7622Row
						SET 
						Amount0' + CAST(@i AS NVARCHAR(5)) + ' = ISNULL(' + CAST(@Amount AS NVARCHAR(100)) + ', 0),
						Amount0' + CAST(@i AS NVARCHAR(5)) + 'LastPeriod = ISNULL(' + CAST(@AmountLastPeriod AS NVARCHAR(100)) + ', 0),
						Amount0' + CAST(@i AS NVARCHAR(5)) + 'A = ISNULL(' + CAST(@AmountA AS NVARCHAR(100)) + ', 0),
						Amount0' + CAST(@i AS NVARCHAR(5)) + 'ALastPeriod = ISNULL(' + CAST(@AmountALastPeriod AS NVARCHAR(100)) + ', 0)'

						EXEC (@strUpdateAT7622Row)
						--PRINT (@strUpdateAT7622Row)
					END
					ELSE
					BEGIN
						SET @strUpdateAT7622Row = N'-- Cập nhật biến #AT7622
						UPDATE #AT7622Row
						SET 
						Amount' + CAST(@i AS NVARCHAR(5)) + ' = ISNULL(' + CAST(@Amount AS NVARCHAR(100)) + ', 0),
						Amount' + CAST(@i AS NVARCHAR(5)) + 'LastPeriod = ISNULL(' + CAST(@AmountLastPeriod AS NVARCHAR(100)) + ', 0),
						Amount' + CAST(@i AS NVARCHAR(5)) + 'A = ISNULL(' + CAST(@AmountA AS NVARCHAR(100)) + ', 0),
						Amount' + CAST(@i AS NVARCHAR(5)) + 'ALastPeriod = ISNULL(' + CAST(@AmountLastPeriod AS NVARCHAR(100)) + ', 0)'

						EXEC (@strUpdateAT7622Row)
						--PRINT (@strUpdateAT7622Row)
					END
					    -- DEBUG
						--IF(@LineID = N'C402')
						--BEGIN
						--	SELECT CAST(@i AS NVARCHAR(5)) AS I
						--	, CAST(@Amount AS NVARCHAR(100)) AS A
						--	, CAST(@AmountLastPeriod AS NVARCHAR(100)) AS B
						--	, CAST(@AmountA AS NVARCHAR(100)) AS C
						--	, CAST(@AmountLastPeriod AS NVARCHAR(100)) AS D
						--	, @strUpdateAT7622Row AS TEXT, * FROM #AT7622Row
						--END

					SET  @i = @i+1   
					FETCH NEXT FROM @Cur_Ana INTO  @AnaID  
				END  
				CLOSE  @Cur_Ana

				-- DEBUG
				--IF(@LineID = N'C402')
				--BEGIN
				--	SELECT * FROM #AT7622Row
				--END
											
				SET @colIndex = 1
				SET @strUpdateRowAmount = ''
				SET @strUpdateRowAmountLastPeriod = ''
				SET @strUpdateRowAmountA = ''
				SET @strUpdateRowAmountALastPeriod = ''
				SET @strUpdateAT7622Temp = N'-- Cập nhật bảng dữ liệu
				UPDATE #AT7622 SET 
				'
				WHILE (@colIndex <= @ColumnCount)
				BEGIN	
					SET @strUpdateRowAmount = @strUpdateRowAmount 
						  + CASE WHEN @colIndex < 10 
							THEN N' Amount0' + CAST(@colIndex AS VARCHAR(5)) 
									+ ' = ISNULL(Amount0' + CAST(@colIndex AS VARCHAR(5)) + ', 0) + ISNULL((SELECT TOP 1 Amount0' + CAST(@colIndex AS VARCHAR(5)) + ' FROM #AT7622Row), 0), 
							'
							ELSE N' Amount' + CAST(@colIndex AS VARCHAR(5)) 
									+ ' = ISNULL(Amount' + CAST(@colIndex AS VARCHAR(5)) + ', 0) ISNULL((SELECT TOP 1 Amount' + CAST(@colIndex AS VARCHAR(5)) + ' FROM #AT7622Row), 0), 
							'
							END
					SET @strUpdateRowAmountLastPeriod = @strUpdateRowAmountLastPeriod 
						  + CASE WHEN @colIndex < 10
							THEN N' Amount0' + CAST(@colIndex AS VARCHAR(5)) 
									+ 'LastPeriod = ISNULL(Amount0' + CAST(@colIndex AS VARCHAR(5)) + 'LastPeriod, 0) + ISNULL((SELECT TOP 1 Amount0' + CAST(@colIndex AS VARCHAR(5)) + 'LastPeriod FROM #AT7622Row), 0), 
							'
							ELSE N' Amount' + CAST(@colIndex AS VARCHAR(5)) 
									+ 'LastPeriod = ISNULL(Amount' + CAST(@colIndex AS VARCHAR(5)) + 'LastPeriod, 0) + ISNULL((SELECT TOP 1 Amount' + CAST(@colIndex AS VARCHAR(5)) + 'LastPeriod FROM #AT7622Row), 0),
							'
							END
					SET @strUpdateRowAmountA = @strUpdateRowAmountA 
						  + CASE WHEN @colIndex < 10 
							THEN N' Amount0' + CAST(@colIndex AS VARCHAR(5)) 
									+ 'A = ISNULL(Amount0' + CAST(@colIndex AS VARCHAR(5)) + 'A, 0) + ISNULL((SELECT TOP 1 Amount0' + CAST(@colIndex AS VARCHAR(5)) + 'A FROM #AT7622Row), 0), 
							'
							ELSE N' Amount' + CAST(@colIndex AS VARCHAR(5)) 
									+ 'A = ISNULL(Amount' + CAST(@colIndex AS VARCHAR(5)) + 'A, 0) + ISNULL((SELECT TOP 1 Amount' + CAST(@colIndex AS VARCHAR(5)) + 'A FROM #AT7622Row), 0), 
							'
							END
					SET @strUpdateRowAmountALastPeriod = @strUpdateRowAmountALastPeriod 
						  + CASE WHEN @colIndex < 10 
							THEN N' Amount0' + CAST(@colIndex AS VARCHAR(5)) 
									+ 'ALastPeriod = ISNULL(Amount0' + CAST(@colIndex AS VARCHAR(5)) + 'ALastPeriod, 0) + ISNULL((SELECT TOP 1 Amount0' + CAST(@colIndex AS VARCHAR(5)) + 'ALastPeriod FROM #AT7622Row), 0), 
							'
							ELSE N' Amount' + CAST(@colIndex AS VARCHAR(5)) 
									+ 'ALastPeriod = ISNULL(Amount0' + CAST(@colIndex AS VARCHAR(5)) + 'ALastPeriod, 0) + ISNULL((SELECT TOP 1 Amount' + CAST(@colIndex AS VARCHAR(5)) + 'ALastPeriod FROM #AT7622Row), 0), 
							'
							END

					SET @colIndex = @colIndex + 1
				END
				
				SET @strUpdateAT7622Temp = @strUpdateAT7622Temp 
						+ @strUpdateRowAmount
						+ @strUpdateRowAmountLastPeriod
						+ @strUpdateRowAmountA
						+ @strUpdateRowAmountALastPeriod
						+ N' DivisionID = DivisionID
						WHERE DivisionID = ''' + @DivisionID + ''' AND ReportCode = ''' + @ReportCode + ''' AND LineID = ''' + @LineID + ''' '
						
				-- Thực thi cập nhật cho bảng #AT7622
				--PRINT (@strUpdateAT7622Temp)
				EXEC (@strUpdateAT7622Temp)
				
				-- Nếu có chỉ tiêu con được tính vào chi tiêu này.  
				-- #AT7623: Bảng lưu các row sử dụng công thức.
				SELECT ROW_NUMBER() OVER(ORDER BY #AT7622.LineCode) AS RowNum
					, AT7621.Sign
					, AT7621.AccuLineID
					, #AT7622.*
				INTO #AT7623
				FROM AT7621
				INNER JOIN #AT7622 ON #AT7622.DivisionID = AT7621.DivisionID 
										AND #AT7622.LineID = AT7621.LineID 
										AND #AT7622.ReportCode = AT7621.ReportCode
				WHERE AT7621.DivisionID = @DivisionID 
						AND AT7621.ReportCode = @ReportCode
						AND AT7621.AccuLineID IN (
													SELECT LineID FROM AT7621 WHERE ReportCode = @ReportCode 
																						AND LineID = @LineID 
																						AND DivisionID = @DivisionID
													)  
				ORDER BY #AT7622.LineCode

				-- DEBUG
				--SELECT * FROM #AT7623

				-- Xử lý từng dòng sử dụng công thức
				DECLARE @RowNum INT = 0

				WHILE (EXISTS(SELECT 1 FROM #AT7623))
				BEGIN
					SET @RowNum = 0
					SET @ChildSign = ''
					SET @AccuLineID = ''
					SET @strUpdateRowAmount = ''
					SET @strUpdateRowAmountLastPeriod = ''
					SET @strUpdateRowAmountA = ''
					SET @strUpdateRowAmountALastPeriod = ''

					SET @ChildSign = ''
					SET @strUpdateAT7622Temp = 'UPDATE #AT7622 SET 
					'

					SELECT TOP 1 
							@RowNum = RowNum
							, @ChildSign = Sign 
							, @AccuLineID = AccuLineID
							FROM #AT7623 ORDER BY RowNum

					SELECT TOP 1 * 
					INTO #AT7623Row 
					FROM #AT7623 
					ORDER BY RowNum

					IF (@ChildSign = '+' 
							OR @ChildSign = '-' )
					BEGIN
						
						SET @colIndex = 1
						WHILE (@colIndex <= @ColumnCount)
						BEGIN	
							SET @strUpdateRowAmount = @strUpdateRowAmount 
								  + CASE WHEN @colIndex < 10 
									THEN N' Amount0' + CAST(@colIndex AS VARCHAR(5)) 
											+ ' = ISNULL(Amount0' + CAST(@colIndex AS VARCHAR(5)) + ', 0) ' + @ChildSign + ' ISNULL((SELECT TOP 1 Amount0' + CAST(@colIndex AS VARCHAR(5)) + ' FROM #AT7623Row), 0), 
									'
									ELSE N' Amount' + CAST(@colIndex AS VARCHAR(5)) 
											+ ' = ISNULL(Amount' + CAST(@colIndex AS VARCHAR(5)) + ', 0) ' + @ChildSign + ' ISNULL((SELECT TOP 1 Amount' + CAST(@colIndex AS VARCHAR(5)) + ' FROM #AT7623Row), 0), 
									'
									END
							SET @strUpdateRowAmountLastPeriod = @strUpdateRowAmountLastPeriod 
								  + CASE WHEN @colIndex < 10
									THEN N' Amount0' + CAST(@colIndex AS VARCHAR(5)) 
											+ 'LastPeriod = ISNULL(Amount0' + CAST(@colIndex AS VARCHAR(5)) + 'LastPeriod, 0) ' + @ChildSign + ' ISNULL((SELECT TOP 1 Amount0' + CAST(@colIndex AS VARCHAR(5)) + 'LastPeriod FROM #AT7623Row), 0), 
									'
									ELSE N' Amount' + CAST(@colIndex AS VARCHAR(5)) 
											+ 'LastPeriod = ISNULL(Amount' + CAST(@colIndex AS VARCHAR(5)) + 'LastPeriod, 0) ' + @ChildSign + ' ISNULL((SELECT TOP 1 Amount' + CAST(@colIndex AS VARCHAR(5)) + 'LastPeriod FROM #AT7623Row), 0),
									'
									END
							SET @strUpdateRowAmountA = @strUpdateRowAmountA 
								  + CASE WHEN @colIndex < 10 
									THEN N' Amount0' + CAST(@colIndex AS VARCHAR(5)) 
											+ 'A = ISNULL(Amount0' + CAST(@colIndex AS VARCHAR(5)) + 'A, 0) ' + @ChildSign + ' ISNULL((SELECT TOP 1 Amount0' + CAST(@colIndex AS VARCHAR(5)) + 'A FROM #AT7623Row), 0), 
									'
									ELSE N' Amount' + CAST(@colIndex AS VARCHAR(5)) 
											+ 'A = ISNULL(Amount' + CAST(@colIndex AS VARCHAR(5)) + 'A, 0) ' + @ChildSign + ' ISNULL((SELECT TOP 1 Amount' + CAST(@colIndex AS VARCHAR(5)) + 'A FROM #AT7623Row), 0), 
									'
									END
							SET @strUpdateRowAmountALastPeriod = @strUpdateRowAmountALastPeriod 
								  + CASE WHEN @colIndex < 10 
									THEN N' Amount0' + CAST(@colIndex AS VARCHAR(5)) 
											+ 'ALastPeriod = ISNULL(Amount0' + CAST(@colIndex AS VARCHAR(5)) + 'ALastPeriod, 0) ' + @ChildSign + ' ISNULL((SELECT TOP 1 Amount0' + CAST(@colIndex AS VARCHAR(5)) + 'ALastPeriod FROM #AT7623Row), 0), 
									'
									ELSE N' Amount' + CAST(@colIndex AS VARCHAR(5)) 
											+ 'ALastPeriod = ISNULL(Amount0' + CAST(@colIndex AS VARCHAR(5)) + 'ALastPeriod, 0) ' + @ChildSign + ' ISNULL((SELECT TOP 1 Amount' + CAST(@colIndex AS VARCHAR(5)) + 'ALastPeriod FROM #AT7623Row), 0), 
									'
									END

							SET @colIndex = @colIndex + 1
						END
						
						-- Thực hiện cập nhật giá trị
						SET @strUpdateAT7622Temp = @strUpdateAT7622Temp 
						+ @strUpdateRowAmount
						+ @strUpdateRowAmountLastPeriod
						+ @strUpdateRowAmountA
						+ @strUpdateRowAmountALastPeriod
						+ N' DivisionID = DivisionID
						WHERE DivisionID = ''' + @DivisionID + ''' AND ReportCode = ''' + @ReportCode + ''' AND LineID = ''' + @AccuLineID + ''' '

						--PRINT (@strUpdateAT7622Temp)

						-- Thực thi cập nhật cho bảng #AT7622
						EXEC (@strUpdateAT7622Temp)

					END		
					ELSE IF(@ChildSign = '*')
					BEGIN

						SET @colIndex = 1
						WHILE (@colIndex <= @ColumnCount)
						BEGIN
							SET @strUpdateRowAmount = @strUpdateRowAmount 
								  + CASE WHEN @colIndex < 10 
									THEN N' Amount0' + CAST(@colIndex AS VARCHAR(5)) 
											+ ' = (CASE WHEN ISNULL(Amount0' + CAST(@colIndex AS VARCHAR(5)) + ', 0) = 0 THEN 1 ELSE Amount0' + CAST(@colIndex AS VARCHAR(5)) + ' END) '  + @ChildSign + ' ISNULL((SELECT TOP 1 Amount0' + CAST(@colIndex AS VARCHAR(5)) + ' FROM #AT7623Row), 0), 
									'
									ELSE N' Amount' + CAST(@colIndex AS VARCHAR(5)) 
											+ ' = (CASE WHEN ISNULL(Amount' + CAST(@colIndex AS VARCHAR(5)) + ', 0) = 0 THEN 1 ELSE Amount' + CAST(@colIndex AS VARCHAR(5)) + ' END) '  + @ChildSign + ' ISNULL((SELECT TOP 1 Amount' + CAST(@colIndex AS VARCHAR(5)) + ' FROM #AT7623Row), 0), 
									'
									END
							SET @strUpdateRowAmountLastPeriod = @strUpdateRowAmountLastPeriod 
								  + CASE WHEN @colIndex < 10
									THEN N' Amount0' + CAST(@colIndex AS VARCHAR(5)) 
											+ 'LastPeriod = (CASE WHEN ISNULL(Amount0' + CAST(@colIndex AS VARCHAR(5)) + 'LastPeriod, 0) = 0 THEN 1 ELSE Amount0' + CAST(@colIndex AS VARCHAR(5)) + 'LastPeriod END) ' + @ChildSign + ' ISNULL((SELECT TOP 1 Amount0' + CAST(@colIndex AS VARCHAR(5)) + 'LastPeriod FROM #AT7623Row), 0), 
									'
									ELSE N' Amount' + CAST(@colIndex AS VARCHAR(5)) 
											+ 'LastPeriod = (CASE WHEN ISNULL(Amount' + CAST(@colIndex AS VARCHAR(5)) + 'LastPeriod, 0) = 0 THEN 1 ELSE Amount' + CAST(@colIndex AS VARCHAR(5)) + 'LastPeriod END) ' + @ChildSign + ' ISNULL((SELECT TOP 1 Amount' + CAST(@colIndex AS VARCHAR(5)) + 'LastPeriod FROM #AT7623Row), 0), 
									'
									END
							SET @strUpdateRowAmountA = @strUpdateRowAmountA 
								  + CASE WHEN @colIndex < 10 
									THEN N' Amount0' + CAST(@colIndex AS VARCHAR(5)) 
											+ 'A = (CASE WHEN ISNULL(Amount0' + CAST(@colIndex AS VARCHAR(5)) + 'A, 0) = 0 THEN 1 ELSE Amount0' + CAST(@colIndex AS VARCHAR(5)) + 'A END) ' + @ChildSign + ' ISNULL((SELECT TOP 1 Amount0' + CAST(@colIndex AS VARCHAR(5)) + 'A FROM #AT7623Row), 0), 
									'
									ELSE N' Amount' + CAST(@colIndex AS VARCHAR(5)) 
											+ 'A = (CASE WHEN ISNULL(Amount' + CAST(@colIndex AS VARCHAR(5)) + 'A, 0) = 0 THEN 1 ELSE Amount' + CAST(@colIndex AS VARCHAR(5)) + 'A END) ' + @ChildSign + ' ISNULL((SELECT TOP 1 Amount' + CAST(@colIndex AS VARCHAR(5)) + 'A FROM #AT7623Row), 0), 
									'
									END
							SET @strUpdateRowAmountALastPeriod = @strUpdateRowAmountALastPeriod 
								  + CASE WHEN @colIndex < 10 
									THEN N' Amount0' + CAST(@colIndex AS VARCHAR(5)) 
											+ 'ALastPeriod = (CASE WHEN ISNULL(Amount0' + CAST(@colIndex AS VARCHAR(5)) + 'ALastPeriod, 0) = 0 THEN 1 ELSE Amount0' + CAST(@colIndex AS VARCHAR(5)) + 'ALastPeriod END) ' + @ChildSign + ' ISNULL((SELECT TOP 1 Amount0' + CAST(@colIndex AS VARCHAR(5)) + 'ALastPeriod FROM #AT7623Row), 0), 
									'
									ELSE N' Amount' + CAST(@colIndex AS VARCHAR(5)) 
											+ 'ALastPeriod = (CASE WHEN ISNULL(Amount' + CAST(@colIndex AS VARCHAR(5)) + 'ALastPeriod, 0) = 0 THEN 1 ELSE Amount' + CAST(@colIndex AS VARCHAR(5)) + 'ALastPeriod END) ' + @ChildSign + ' ISNULL((SELECT TOP 1 Amount' + CAST(@colIndex AS VARCHAR(5)) + 'ALastPeriod FROM #AT7623Row), 0), 
									'
									END

							SET @colIndex = @colIndex + 1						
						END

						-- Thực hiện cập nhật giá trị
						SET @strUpdateAT7622Temp = @strUpdateAT7622Temp 
						+ @strUpdateRowAmount
						+ @strUpdateRowAmountLastPeriod
						+ @strUpdateRowAmountA
						+ @strUpdateRowAmountALastPeriod
						+ N' DivisionID = DivisionID
						WHERE DivisionID = ''' + @DivisionID + ''' AND ReportCode = ''' + @ReportCode + ''' AND LineID = ''' + @AccuLineID + ''' '

						-- PRINT (@strUpdateAT7622Temp)

						-- Thực thi cập nhật cho bảng #AT7622
						EXEC (@strUpdateAT7622Temp)

						-- DEBUG
						-- SELECT @strUpdateAT7622Temp AS TEXT1

					END 
					ELSE IF(@ChildSign =  '/')
					BEGIN

						SET @colIndex = 1
						WHILE (@colIndex <= @ColumnCount)
						BEGIN	
							SET @strUpdateRowAmount = @strUpdateRowAmount 
								  + CASE WHEN @colIndex < 10 
									THEN N' Amount0' + CAST(@colIndex AS VARCHAR(5)) 
											+ ' = CASE WHEN ISNULL((SELECT TOP 1 Amount0' + CAST(@colIndex AS VARCHAR(5)) + ' FROM #AT7623Row), 0) = 0 THEN 0 ELSE ISNULL(Amount0' + CAST(@colIndex AS VARCHAR(5)) + ', 0) ' + @ChildSign + ' ISNULL((SELECT TOP 1 Amount0' + CAST(@colIndex AS VARCHAR(5)) + ' FROM #AT7623Row), 0) END, 
									'
									ELSE N' Amount' + CAST(@colIndex AS VARCHAR(5)) 
											+ ' = CASE WHEN ISNULL((SELECT TOP 1 Amount' + CAST(@colIndex AS VARCHAR(5)) + ' FROM #AT7623Row), 0) = 0 THEN 0 ELSE ISNULL(Amount' + CAST(@colIndex AS VARCHAR(5)) + ', 0) ' + @ChildSign + ' ISNULL((SELECT TOP 1 Amount' + CAST(@colIndex AS VARCHAR(5)) + ' FROM #AT7623Row), 0) END, 
									'
									END
							SET @strUpdateRowAmountLastPeriod = @strUpdateRowAmountLastPeriod 
								  + CASE WHEN @colIndex < 10
									THEN N' Amount0' + CAST(@colIndex AS VARCHAR(5)) 
											+ 'LastPeriod = CASE WHEN ISNULL((SELECT TOP 1 Amount0' + CAST(@colIndex AS VARCHAR(5)) + 'LastPeriod FROM #AT7623Row), 0) = 0 THEN 0 ELSE ISNULL(Amount0' + CAST(@colIndex AS VARCHAR(5)) + 'LastPeriod, 0) ' + @ChildSign + ' ISNULL((SELECT TOP 1 Amount0' + CAST(@colIndex AS VARCHAR(5)) + 'LastPeriod FROM #AT7623Row), 0) END, 
									'
									ELSE N' Amount' + CAST(@colIndex AS VARCHAR(5)) 
											+ 'LastPeriod = CASE WHEN ISNULL((SELECT TOP 1 Amount' + CAST(@colIndex AS VARCHAR(5)) + 'LastPeriod FROM #AT7623Row), 0) = 0 THEN 0 ELSE ISNULL(Amount' + CAST(@colIndex AS VARCHAR(5)) + 'LastPeriod, 0) ' + @ChildSign + ' ISNULL((SELECT TOP 1 Amount' + CAST(@colIndex AS VARCHAR(5)) + 'LastPeriod FROM #AT7623Row), 0) END, 
									'
									END
							SET @strUpdateRowAmountA = @strUpdateRowAmountA 
								  + CASE WHEN @colIndex < 10 
									THEN N' Amount0' + CAST(@colIndex AS VARCHAR(5)) 
											+ 'A = CASE WHEN ISNULL((SELECT TOP 1 Amount0' + CAST(@colIndex AS VARCHAR(5)) + 'A FROM #AT7623Row), 0) = 0 THEN 0 ELSE ISNULL(Amount0' + CAST(@colIndex AS VARCHAR(5)) + 'A, 0) ' + @ChildSign + ' ISNULL((SELECT TOP 1 Amount0' + CAST(@colIndex AS VARCHAR(5)) + 'A FROM #AT7623Row), 0) END, 
									'
									ELSE N' Amount' + CAST(@colIndex AS VARCHAR(5)) 
											+ 'A = CASE WHEN ISNULL((SELECT TOP 1 Amount' + CAST(@colIndex AS VARCHAR(5)) + 'A FROM #AT7623Row), 0) = 0 THEN 0 ELSE ISNULL(Amount' + CAST(@colIndex AS VARCHAR(5)) + 'A, 0) ' + @ChildSign + ' ISNULL((SELECT TOP 1 Amount' + CAST(@colIndex AS VARCHAR(5)) + 'A FROM #AT7623Row), 0) END, 
									'
									END
							SET @strUpdateRowAmountALastPeriod = @strUpdateRowAmountALastPeriod 
								  + CASE WHEN @colIndex < 10 
									THEN N' Amount0' + CAST(@colIndex AS VARCHAR(5)) 
											+ 'ALastPeriod = CASE WHEN ISNULL((SELECT TOP 1 Amount0' + CAST(@colIndex AS VARCHAR(5)) + 'ALastPeriod FROM #AT7623Row), 0) = 0 THEN 0 ELSE ISNULL(Amount0' + CAST(@colIndex AS VARCHAR(5)) + 'ALastPeriod, 0) ' + @ChildSign + ' ISNULL((SELECT TOP 1 Amount0' + CAST(@colIndex AS VARCHAR(5)) + 'ALastPeriod FROM #AT7623Row), 0) END, 
									'
									ELSE N' Amount' + CAST(@colIndex AS VARCHAR(5)) 
											+ 'ALastPeriod = CASE WHEN ISNULL((SELECT TOP 1 Amount' + CAST(@colIndex AS VARCHAR(5)) + 'ALastPeriod FROM #AT7623Row), 0) = 0 THEN 0 ELSE ISNULL(Amount' + CAST(@colIndex AS VARCHAR(5)) + 'ALastPeriod, 0) ' + @ChildSign + ' ISNULL((SELECT TOP 1 Amount' + CAST(@colIndex AS VARCHAR(5)) + 'ALastPeriod FROM #AT7623Row), 0) END, 
									'
									END

							SET @colIndex = @colIndex + 1
						END

						-- Thực hiện cập nhật giá trị
						SET @strUpdateAT7622Temp = @strUpdateAT7622Temp 
						+ @strUpdateRowAmount
						+ @strUpdateRowAmountLastPeriod
						+ @strUpdateRowAmountA
						+ @strUpdateRowAmountALastPeriod
						+ N' DivisionID = DivisionID
						WHERE DivisionID = ''' + @DivisionID + ''' AND ReportCode = ''' + @ReportCode + ''' AND LineID = ''' + @AccuLineID + ''' '

						-- PRINT (@strUpdateAT7622Temp)

						-- Thực thi cập nhật cho bảng #AT7622
						EXEC (@strUpdateAT7622Temp)

						-- DEBUG
						-- SELECT @strUpdateAT7622Temp AS TEXT2
	
					END

					DELETE #AT7623 WHERE RowNum = @RowNum
					DROP TABLE #AT7623Row
				END

				-- Xóa Bảng lưu các row sử dụng công thức.
				DROP TABLE #AT7623				
     
				FETCH NEXT FROM @Cur INTO  @LineID, @Sign, @AccuLineID, @CaculatorID ,@FromAccountID, @ToAccountID, @FromCorAccountID,@ToCorAccountID,  
					@AnaTypeID, @FromAnaID , @ToAnaID, @BudgetID  
			END  

			CLOSE @Cur  

			FETCH NEXT FROM @Cur_LevelID INTO  @LevelID  
			End  
		Close @Cur_LevelID  

		SET NOCOUNT OFF  

		--- Lấy ra khối dữ liệu in
		SELECT * FROM #AT7622
	END 
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
