IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP7620_INT]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP7620_INT]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---- Created Date 27/10/2006 by Đức Tuyên.
---- Modified on 27/10/2023 by Đức Tuyên   Update: Thiết lập báo cáo dòng tiền (Customize INNOTEK).
---- Modified on 31/10/2023 by Đức Tuyên   Update: Báo cáo P&L chi tiết (Customize INNOTEK).
-- <Example>
---- 
-- <Summary>
CREATE PROCEDURE [dbo].[AP7620_INT]   
	@DivisionID AS nvarchar(50),   
	@ReportCode AS nvarchar(50),   
	@FromMonth int,   
	@FromYear  int,   
	@ToMonth int,   
	@ToYear  int,  
	@FromValueID AS nvarchar(50),   
	@ToValueID AS nvarchar(50),  
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
	@ToSelection05 AS VARCHAR(50) = ''
AS
DECLARE @ReportID NVARCHAR(50)
SET @ReportID = (SELECT ReportID FROM AT7620 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND ReportCode = @ReportCode)


--SET NOCOUNT ON  
DECLARE @FieldID AS nvarchar(50),  
		@ChildLineID  AS nvarchar(50),  
		@ParLineID  AS nvarchar(50),  
		@ChildSign  AS nvarchar(5),  
		@sSQL AS nvarchar(4000),  
		@FilterMaster AS nvarchar(50),  
		@FilterDetail AS nvarchar(50),  
		@LineID AS nvarchar(50),  
		@LineDescription NVARCHAR(MAX),
		@LineCode AS nvarchar(50),             
		@LevelID AS int,   
		@LevelID_Pre AS int,   
		@Sign AS nvarchar(5),   
		@AccuLineID AS nvarchar(50),   
		@CaculatorID AS nvarchar(50),   
		@FromAccountID AS nvarchar(50),   
		@ToAccountID AS nvarchar(50),   
		@FromCorAccountID AS nvarchar(50),   
		@ToCorAccountID AS nvarchar(50),    
		@AnaTypeID AS nvarchar(50),    
		@FromAnaID AS nvarchar(50),     
		@ToAnaID AS nvarchar(50),  
		@IsPrint AS TINYINT,
		@BudgetID AS nvarchar(50),   
		@FromWareHouseID AS NVARCHAR(50),
		@ToWareHouseID AS NVARCHAR(50),
		@IsFormulaCode AS TINYINT,
		@FormulaCode AS NVARCHAR(50),
		@Cur_LevelID AS cursor,  
		@Cur_ChildLevelID AS cursor,  
		@Cur AS cursor,  
		@Cur_Ana AS cursor,
		@Cur_Ana00 AS cursor,
		@Cur_ChildLevelID2 AS cursor,  
		@Cur2 AS cursor,  
		@Amount00 AS decimal(28,8), 
		@Amount01 AS decimal(28,8),  
		@Amount02 AS decimal(28,8),  
		@Amount03 AS decimal(28,8),  
		@Amount04 AS decimal(28,8),  
		@Amount05 AS decimal(28,8),  
		@Amount06 AS decimal(28,8),  
		@Amount07 AS decimal(28,8),  
		@Amount08 AS decimal(28,8),  
		@Amount09 AS decimal(28,8),  
		@Amount10 AS decimal(28,8),  
		@Amount11 AS decimal(28,8),  
		@Amount12 AS decimal(28,8),  
		@Amount13 AS decimal(28,8),  
		@Amount14 AS decimal(28,8),  
		@Amount15 AS decimal(28,8),  
		@Amount16 AS decimal(28,8),  
		@Amount17 AS decimal(28,8),  
		@Amount18 AS decimal(28,8),  
		@Amount19 AS decimal(28,8),  
		@Amount20 AS decimal(28,8),  
		@Amount21 AS decimal(28,8),  
		@Amount22 AS decimal(28,8),  
		@Amount23 AS decimal(28,8),  
		@Amount24 AS decimal(28,8),  
		@Amount01A AS decimal(28,8),
		@Amount02A AS decimal(28,8),
		@Amount03A AS decimal(28,8),
		@Amount04A AS decimal(28,8),
		@Amount05A AS decimal(28,8),
		@Amount06A AS decimal(28,8),
		@Amount07A AS decimal(28,8),
		@Amount08A AS decimal(28,8),
		@Amount09A AS decimal(28,8),
		@Amount10A AS decimal(28,8),
		@Amount11A AS decimal(28,8),
		@Amount12A AS decimal(28,8),
		@Amount13A AS decimal(28,8),
		@Amount14A AS decimal(28,8),
		@Amount15A AS decimal(28,8),
		@Amount16A AS decimal(28,8),
		@Amount17A AS decimal(28,8),
		@Amount18A AS decimal(28,8),
		@Amount19A AS decimal(28,8),
		@Amount20A AS decimal(28,8),
		@Amount21A AS decimal(28,8),
		@Amount22A AS decimal(28,8),
		@Amount23A AS decimal(28,8),
		@Amount24A AS decimal(28,8),				
		@Amount01LastPeriod AS decimal(28,8),  
		@Amount02LastPeriod AS decimal(28,8),  
		@Amount03LastPeriod AS decimal(28,8),  
		@Amount04LastPeriod AS decimal(28,8),  
		@Amount05LastPeriod AS decimal(28,8),  
		@Amount06LastPeriod AS decimal(28,8),  
		@Amount07LastPeriod AS decimal(28,8),  
		@Amount08LastPeriod AS decimal(28,8),  
		@Amount09LastPeriod AS decimal(28,8),  
		@Amount10LastPeriod AS decimal(28,8),  
		@Amount11LastPeriod AS decimal(28,8),  
		@Amount12LastPeriod AS decimal(28,8),  
		@Amount13LastPeriod AS decimal(28,8),  
		@Amount14LastPeriod AS decimal(28,8),  
		@Amount15LastPeriod AS decimal(28,8),  
		@Amount16LastPeriod AS decimal(28,8),  
		@Amount17LastPeriod AS decimal(28,8),  
		@Amount18LastPeriod AS decimal(28,8),  
		@Amount19LastPeriod AS decimal(28,8),  
		@Amount20LastPeriod AS decimal(28,8),  
		@Amount21LastPeriod AS decimal(28,8),  
		@Amount22LastPeriod AS decimal(28,8),  
		@Amount23LastPeriod AS decimal(28,8),  
		@Amount24LastPeriod AS decimal(28,8),  
		@Amount01ALastPeriod AS decimal(28,8), 
		@Amount02ALastPeriod AS decimal(28,8), 
		@Amount03ALastPeriod AS decimal(28,8), 
		@Amount04ALastPeriod AS decimal(28,8), 
		@Amount05ALastPeriod AS decimal(28,8), 
		@Amount06ALastPeriod AS decimal(28,8), 
		@Amount07ALastPeriod AS decimal(28,8), 
		@Amount08ALastPeriod AS decimal(28,8), 
		@Amount09ALastPeriod AS decimal(28,8), 
		@Amount10ALastPeriod AS decimal(28,8), 
		@Amount11ALastPeriod AS decimal(28,8), 
		@Amount12ALastPeriod AS decimal(28,8), 
		@Amount13ALastPeriod AS decimal(28,8), 
		@Amount14ALastPeriod AS decimal(28,8), 
		@Amount15ALastPeriod AS decimal(28,8), 
		@Amount16ALastPeriod AS decimal(28,8), 
		@Amount17ALastPeriod AS decimal(28,8), 
		@Amount18ALastPeriod AS decimal(28,8), 
		@Amount19ALastPeriod AS decimal(28,8), 
		@Amount20ALastPeriod AS decimal(28,8), 
		@Amount21ALastPeriod AS decimal(28,8), 
		@Amount22ALastPeriod AS decimal(28,8), 
		@Amount23ALastPeriod AS decimal(28,8), 
		@Amount24ALastPeriod AS decimal(28,8), 		
		@Amount AS decimal(28,8),  
		@AmountLastPeriod AS decimal(28,8),  
		@AmountA AS decimal(28,8),  
		@AmountALastPeriod AS decimal(28,8), 		
		@AnaID AS nvarchar(50), 
		@AnaID00 AS nvarchar(50),  
		@I  AS INT,  
		@StrDivisionID_New AS NVARCHAR(4000),  
		@FromMonthLastPeriod int,   
		@FromYearLastPeriod  int,   
		@ToMonthLastPeriod int,   
		@ToYearLastPeriod  int  ,
		@FromID AS nvarchar(50),   
		@ToID AS nvarchar(50),
		@FromID00 AS nvarchar(50),   
		@ToID00 AS nvarchar(50),
		@SQL as varchar(max),
		@CustomerName INT,
		@Index INT = 0

--Xử lý--
BEGIN
	-----------------Phân quyền xem chứng từ của người dùng khác-----------------
	BEGIN
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
				@strTable AS NVARCHAR(MAX) = '',
				@strTableName AS NVARCHAR(MAX) = ''

		SET @sSQLPer = ''
		SET @sWHEREPer = ''

	-- Nếu check Phân quyền xem dữ liệu tại Thiết lập hệ thống thì mới thực hiện
		IF EXISTS (SELECT TOP 1 1 FROM AT0000 WHERE DefDivisionID = @DivisionID AND IsPermissionView = 1 ) 
		BEGIN
			SET @sSQLPer = ' LEFT JOIN AT0010 ON AT0010.DivisionID = AV9090.DivisionID 
												AND AT0010.AdminUserID = '''+@UserID+'''
												AND AT0010.UserID = AV9090.CreateUserID '
			SET @sWHEREPer = 'AND (AV9090.CreateUserID = AT0010.UserID
									OR  AV9090.CreateUserID = '''+@UserID+''') '
		END

	-----------------Phân quyền xem chứng từ của người dùng khác-----------------
		BEGIN
			CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
			INSERT #CustomerName EXEC AP4444
			SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)
		END
	END

	--Xac dinh thang, nam cuoi ky truoc
	BEGIN
		SELECT @FromMonthLastPeriod = FromMonth,  
			@FromYearLastPeriod = FromYear,  
			@ToMonthLastPeriod = ToMonth,  
			@ToYearLastPeriod = ToYear  
		FROM dbo.GetLastPeriod(@FromMonth,@FromYear,@ToMonth,@ToYear)

		SELECT @StrDivisionID_New = CASE WHEN @StrDivisionID = '%' THEN ' LIKE ''' +   
		@StrDivisionID + '''' ELSE ' IN (''' + replace(@StrDivisionID, ',',''',''') + ''')' END

		SELECT	@FieldID = FieldID ,
				@Selection01 = Selection01,
				@Selection02 = Selection02,
				@Selection03 = Selection03,
				@Selection04 = Selection04,
				@Selection05 = Selection05
		FROM AT7620 WITH (NOLOCK)
		WHERE ReportCode = @ReportCode
			AND DivisionID = @DivisionID
	END

	IF(Isnull(@Selection01,'') <> '' OR Isnull(@Selection02,'') <> '' OR Isnull(@Selection03,'') <> '' OR
		Isnull(@Selection04,'') <> '' OR Isnull(@Selection05,'') <> '' ) AND @CustomerName = 50
	BEGIN
		EXEC AP7623 @DivisionID,   @ReportCode,  @FromMonth ,     @FromYear  ,     @ToMonth ,     @ToYear  ,  
		@FromValueID ,     @ToValueID ,    @StrDivisionID, @UserID ,
		@FromSelection01 ,  @ToSelection01 ,  @FromSelection02 ,  @ToSelection02 ,  @FromSelection03 ,  @ToSelection03 ,
		@FromSelection04 ,  @ToSelection04 ,  @FromSelection05 ,  @ToSelection05 
	END
	ELSE 
	BEGIN
		EXEC AP4700  @FieldID, @FilterMaster OUTPUT

		---Tim Period Credit, Period Debit theo đối tượng
		BEGIN
			DELETE AT7621 WHERE ISNULL(IsObject, 0) = 1 AND ReportCode = @ReportCode

			SET @Index = 0
			SET @Cur = Cursor Scroll KeySet FOR
			SELECT DivisionID,ReportCode,LineID,LineCode,LineDescription,LevelID,Sign,AccuLineID,CaculatorID,FromAccountID,ToAccountID,FromCorAccountID,ToCorAccountID,AnaTypeID,FromAnaID,ToAnaID,IsPrint,BudgetID,FromWareHouseID,ToWareHouseID,IsFormulaCode,FormulaCode
			FROM	AT7621 WITH (NOLOCK)
			WHERE	DivisionID = @DivisionID
				AND ReportCode = @ReportCode
				AND CaculatorID IN ('YI','YK', 'YL')
				AND ISNULL(IsObject, 0) <> 1 

			OPEN @Cur
			FETCH NEXT FROM @Cur INTO  @DivisionID,@ReportCode,@LineID,@LineCode,@LineDescription,@LevelID,@Sign,@AccuLineID,@CaculatorID,@FromAccountID,@ToAccountID,@FromCorAccountID,@ToCorAccountID,@AnaTypeID,@FromAnaID,@ToAnaID,@IsPrint,@BudgetID,@FromWareHouseID,@ToWareHouseID,@IsFormulaCode,@FormulaCode
			WHILE @@Fetch_Status = 0
			BEGIN
				SET @Index = @Index + 1
				PRINT(@LineDescription)

				INSERT INTO dbo.AT7621
				(
					APK
					,DivisionID
					,ReportCode
					,LineID
					,LineCode
					,LineDescription
					,LevelID
					,Sign
					,AccuLineID
					,CaculatorID
					,FromAccountID
					,ToAccountID
					,FromCorAccountID
					,ToCorAccountID
					,AnaTypeID
					,FromAnaID
					,ToAnaID
					,IsPrint
					,BudgetID
					,FromWareHouseID
					,ToWareHouseID
					,IsFormulaCode
					,FormulaCode
					,IsObject
					,ObjectID
					,IsCredit
					,IsDebit
				)
				SELECT
					NEWID() AS APK
					,@DivisionID AS DivisionID
					,@ReportCode AS ReportCode
					,CASE WHEN @CaculatorID = 'YI' THEN  CONCAT(@LineID, 1, ROW_NUMBER() OVER (ORDER BY AT02.ObjectID))
						WHEN @CaculatorID = 'YK' THEN  CONCAT(@LineID, 2, ROW_NUMBER() OVER (ORDER BY AT02.ObjectID))
						WHEN @CaculatorID = 'YL' THEN  CONCAT(@LineID, 3, ROW_NUMBER() OVER (ORDER BY AT02.ObjectID))
					END AS LineID
					,CASE WHEN @CaculatorID = 'YI' THEN  CONCAT(@LineCode, 1, ROW_NUMBER() OVER (ORDER BY AT02.ObjectID))
						WHEN @CaculatorID = 'YK' THEN  CONCAT(@LineCode, 2, ROW_NUMBER() OVER (ORDER BY AT02.ObjectID))
						WHEN @CaculatorID = 'YL' THEN  CONCAT(@LineCode, 3, ROW_NUMBER() OVER (ORDER BY AT02.ObjectID))
					END AS LineCode
					,CONCAT(@LineDescription,': ', ISNULL(AT02.ObjectName, '')) AS LineDescription
					,@LevelID AS LevelID
					,@Sign AS Sign
					,CASE WHEN @CaculatorID = 'YI' THEN  CONCAT(@AccuLineID, 3, ROW_NUMBER() OVER (ORDER BY AT02.ObjectID))
						WHEN @CaculatorID = 'YK' THEN  CONCAT(@AccuLineID, 3, ROW_NUMBER() OVER (ORDER BY AT02.ObjectID))
						WHEN @CaculatorID = 'YL' THEN  @AccuLineID
					END AS AccuLineID
					,@CaculatorID AS CaculatorID
					,@FromAccountID AS FromAccountID
					,@ToAccountID AS ToAccountID
					,@FromCorAccountID AS FromCorAccountID
					,@ToCorAccountID AS ToCorAccountID
					,@AnaTypeID AS AnaTypeID
					,AT02.ObjectID AS FromAnaID
					,AT02.ObjectID AS ToAnaID
					,@IsPrint AS IsPrint
					,@BudgetID AS BudgetID
					,@FromWareHouseID AS FromWareHouseID
					,@ToWareHouseID AS ToWareHouseID
					,@IsFormulaCode AS IsFormulaCode
					,@FormulaCode AS FormulaCode
					,1 AS IsObject
					,AT02.ObjectID
					,CASE WHEN @CaculatorID = 'YI' THEN 1
						ELSE 0
					END AS IsCredit
					,CASE WHEN @CaculatorID = 'YK' THEN 1
						ELSE 0
					END AS IsDebit

				FROM AT1202 AT02 WITH (NOLOCK)
				WHERE (AT02.ObjectID BETWEEN @FromAnaID AND  @ToAnaID)

				FETCH NEXT FROM @Cur INTO @DivisionID,@ReportCode,@LineID,@LineCode,@LineDescription,@LevelID,@Sign,@AccuLineID,@CaculatorID,@FromAccountID,@ToAccountID,@FromCorAccountID,@ToCorAccountID,@AnaTypeID,@FromAnaID,@ToAnaID,@IsPrint,@BudgetID,@FromWareHouseID,@ToWareHouseID,@IsFormulaCode,@FormulaCode
			END
			CLOSE @Cur
		END

		--- Print @FilterMaster---
		---Buoc 1 Xoa du lieu bang tam:
		BEGIN
			DELETE AT7622   
			WHERE ReportCode =@ReportCode
		END

		---Buoc 2 Insert du lieu vao bang tam:
		BEGIN
			INSERT AT7622 (DivisionID, ReportCode, LineID)
			SELECT DivisionID, @ReportCode, LineID
			FROM AT7621   WITH (NOLOCK)
			WHERE ReportCode =@ReportCode AND DivisionID =@DivisionID
		END
 
		---Buoc 3 Duyet tung cap tu lon den nho:
		BEGIN
			SET @strSelect = ' 0 AS SignAmount2,'
			SET @strTable = 'AV9090 WITH (NOLOCK) '	
			SET @strTableName = 'AV9090'
		END
	
		---Bổ sung điều kiện lọc
		IF(Isnull(@Selection01,'') <> '' OR Isnull(@Selection02,'') <> '' OR Isnull(@Selection03,'') <> '' OR
		Isnull(@Selection04,'') <> '' OR Isnull(@Selection05,'') <> '' ) AND @CustomerName = 75
		BEGIN
			IF @Selection01 IS NOT NULL AND @Selection01 <> '' ---- Tim kiem theo chi tieu 1
				BEGIN
					EXEC AP4700 @Selection01, @LevelColumn = @Temp OUTPUT
					IF @FromSelection01  IS NOT NULL AND @FromSelection01  <> '' AND PatIndex('%[%]%',@FromSelection01 ) = 0
						BEGIN
							SET @strSQLFilter = @strSQLFilter +
							 ' AND ISNULL(' + @Temp + ','''') >= ''' + Replace(@FromSelection01,'[]','') + ''' AND ISNULL(' + @Temp + ','''') <= ''' + Replace(@ToSelection01,'[]','') + '''' 
						END
					ELSE
						BEGIN
							SET @strSQLFilter = @strSQLFilter + ' AND ISNULL(' + @Temp + ','''') LIKE ''' + @FromSelection01 + ''''
						END 
				END
			IF @Selection02 IS NOT NULL AND @Selection02 <> '' ---- Tim kiem theo chi tieu 2
				BEGIN
					EXEC AP4700 @Selection02, @LevelColumn = @Temp OUTPUT
					IF @FromSelection02  IS NOT NULL AND @FromSelection02  <> '' AND PatIndex('%[%]%',@FromSelection02 ) = 0
						BEGIN
							SET @strSQLFilter = @strSQLFilter + 
							' AND ISNULL(' + @Temp + ','''') >= ''' + Replace(@FromSelection02,'[]','') + ''' AND ISNULL(' + @Temp + ','''') <= ''' + Replace(@ToSelection02,'[]','') + '''' 
						END
					ELSE
						BEGIN
							SET @strSQLFilter = @strSQLFilter + ' AND ISNULL(' + @Temp + ','''') LIKE ''' + @FromSelection02 + ''''
						END 
				END
			IF @Selection03 IS NOT NULL AND @Selection03 <> '' ---- Tim kiem theo chi tieu 3
				BEGIN
					EXEC AP4700 @Selection03, @LevelColumn = @Temp OUTPUT
					IF @FromSelection03  IS NOT NULL AND @FromSelection03  <> '' AND PatIndex('%[%]%',@FromSelection03 ) = 0
						BEGIN
							SET @strSQLFilter = @strSQLFilter + 
							' AND ISNULL(' + @Temp + ','''') >= ''' + Replace(@FromSelection03,'[]','') + ''' AND ISNULL(' + @Temp + ','''') <= ''' + Replace(@ToSelection03,'[]','') + '''' 
						END
					ELSE
						BEGIN
							SET @strSQLFilter = @strSQLFilter + ' AND ISNULL(' + @Temp + ','''') LIKE ''' + @FromSelection03 + ''' '
						END 
				END
			IF @Selection04 IS NOT NULL AND @Selection04 <> '' ---- Tim kiem theo chi tieu 4
				BEGIN
					EXEC AP4700 @Selection04, @LevelColumn = @Temp OUTPUT
					IF @FromSelection04  IS NOT NULL AND @FromSelection04  <> '' AND PatIndex('%[%]%',@FromSelection04 ) = 0
						BEGIN
							SET @strSQLFilter = @strSQLFilter + ' 
							AND  ISNULL(' + @Temp + ','''') >= ''' + Replace(@FromSelection04,'[]','') + ''' AND ISNULL(' + @Temp + ','''') <= ''' + Replace(@ToSelection04,'[]','') + '''					
							' 
						END
					ELSE
						BEGIN
							SET @strSQLFilter = @strSQLFilter + ' AND ISNULL(' + @Temp + ','''') LIKE ''' + @FromSelection04 + '''' 
						END 
				END
			IF @Selection05 IS NOT NULL AND @Selection05 <> '' ---- Tim kiem theo chi tieu 5
				BEGIN
					EXEC AP4700 @Selection05, @LevelColumn = @Temp OUTPUT
					IF @FromSelection05  IS NOT NULL AND @FromSelection05  <> '' AND PatIndex('%[%]%',@FromSelection05 ) = 0
						BEGIN
							SET @strSQLFilter = @strSQLFilter + 
							' AND  ISNULL(' + @Temp + ','''') >= ''' + Replace(@FromSelection05,'[]','') + ''' AND ISNULL(' + @Temp + ','''') <= ''' + Replace(@ToSelection05,'[]','') + '''						
							' 
						END
					ELSE
						BEGIN
							SET @strSQLFilter = @strSQLFilter + ' AND ISNULL(' + @Temp + ','''') LIKE ''' + @FromSelection05 + '''' 
						END 
				END

			SET @strWhere = '
				' +@strSQLFilter + '
				AND (Isnull(Ana01ID,'''') <> '''' or Isnull(Ana02ID,'''') <> '''' or Isnull(Ana03ID,'''') <> '''' 
					or Isnull(Ana04ID,'''') <> '''' or Isnull(Ana05ID,'''') <> '''' )'
		END

		SET @LevelID_Pre = (Select Top 1 LevelID From AT7621 Where ReportCode =@ReportCode and DivisionID =@DivisionID Order by LevelID Desc)

		---Buoc 4  Tinh toan va update du lieu bang bang tam:
		BEGIN
			--Vòng lặp AT7621 theo thiết lập báo cáo
			SET @Cur_LevelID= Cursor Scroll KeySet FOR   
			SELECT   DISTINCT LevelID   
			FROM AT7621   WITH (NOLOCK)  
			WHERE ReportCode = @ReportCode and DivisionID = @DivisionID  
			ORDER BY LevelID Desc  

			OPEN @Cur_LevelID  
			FETCH NEXT FROM @Cur_LevelID INTO  @LevelID
			WHILE @@Fetch_Status = 0  
			BEGIN

				SET @Cur = Cursor Scroll KeySet FOR   
				Select  LineID, LineDescription, Sign, AccuLineID, CaculatorID , FromAccountID, ToAccountID, FromCorAccountID,ToCorAccountID,   
						isnull(AnaTypeID,''), isnull(FromAnaID,'') , isnull(ToAnaID,''),  BudgetID  
				From	AT7621 WITH (NOLOCK)  
				Where	ReportCode = @ReportCode and  LevelID = @LevelID and DivisionID = @DivisionID
				---Order by LineID 
  
				OPEN @Cur  
				FETCH NEXT FROM @Cur INTO  @LineID, @LineDescription, @Sign, @AccuLineID, @CaculatorID ,@FromAccountID, @ToAccountID, @FromCorAccountID,@ToCorAccountID, @AnaTypeID,@FromAnaID , @ToAnaID, @BudgetID  
				WHILE @@Fetch_Status = 0  
				BEGIN
					---- Phát sinh có/nợ trong năm  theo đối tượng
					IF (@CaculatorID IN ('YI','YK'))
					BEGIN
						SET @FilterDetail = N'ObjectID'
						SET @sSQL =N' SELECT	Ana01ID, Ana02ID, Ana03ID, ObjectID, PeriodID, TranMonth, TranYear,
									' + @strTableName + '.DivisionID, AccountID, CorAccountID, D_C, SignAmount,' + @strSelect + '
									SignQuantity, BudgetID, TransactionTypeID,  
									'+@FilterMaster+' AS FilterMaster,  
									'+@FilterDetail+' AS FilterDetail
							FROM	' + @strTable + @sSQLPer + '
							WHERE 1= 1 ' + @sWHEREPer + @strWhere + '
						'
						--Update LineDescription theo tên đối tượng
						--SET @LineDescription = CONCAT(' ', ISNULL((SELECT TOP 1 ObjectName FROM AT1202 WHERE ObjectID = @FromAnaID), 
					END
					ELSE
					BEGIN
						IF @CaculatorID = 'YL'
							BEGIN
								SET @AnaTypeID = ''
							END
						IF ISNULL(@AnaTypeID,'')<>''  
						BEGIN  
							 Exec AP4700  @AnaTypeID, @FilterDetail output   
							SET @sSQL =' SELECT	Ana01ID, Ana02ID, Ana03ID, ObjectID, PeriodID, TranMonth, TranYear,   
												' + @strTableName + '.DivisionID, AccountID, CorAccountID, D_C, SignAmount,' + @strSelect + '   
												SignQuantity, BudgetID, TransactionTypeID,  
												'+@FilterMaster+' AS FilterMaster,  
												'+@FilterDetail+' AS FilterDetail
										FROM	' + @strTable + @sSQLPer + '
										WHERE 1= 1 ' + @sWHEREPer + @strWhere + ' 
										'  
						END  
						ELSE  
						BEGIN
							SET @sSQL =' SELECT	Ana01ID, Ana02ID, Ana03ID, ObjectID, PeriodID, TranMonth, TranYear,   
												' + @strTableName + '.DivisionID, AccountID, CorAccountID, D_C, SignAmount,' + @strSelect + '   
												SignQuantity, BudgetID, TransactionTypeID,  
												'+@FilterMaster+' AS FilterMaster,  
												'''' AS FilterDetail  
										FROM	' + @strTable + @sSQLPer + '
										WHERE 1= 1 ' + @sWHEREPer + @strWhere + '
										'  
						END
					END

					IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WHERE NAME = 'AV9091' AND XTYPE ='V')  
						EXEC ('  CREATE VIEW AV9091 AS ' + @sSQL)  
					ELSE  
						EXEC ('  ALTER VIEW AV9091  AS ' + @sSQL)  

					 Set @i =1 
					 --Gia tri ban dau:
					 BEGIN
						 SET @Amount00 = 0
						 SET @Amount = 0  
						 SET @AmountLastPeriod = 0  
						 SET @AmountA = 0  
						 SET @AmountALastPeriod = 0  	 

						 Set @Amount01 =0  set @Amount02 =0  set @Amount03 =0  set  @Amount04 =0  set  @Amount05 =0  set  @Amount06 =0  set  @Amount07 =0  set  @Amount08 =0  set  @Amount09 =0  set  @Amount10 =0   
						 Set @Amount11 =0  set @Amount12 =0  set @Amount13 =0  set  @Amount14 =0  set  @Amount15 =0  set  @Amount16 =0  set   @Amount17 =0  set  @Amount18 =0  set  @Amount19 =0  set  @Amount20 =0   
						 set @Amount21 =0  set @Amount22 =0  set @Amount23 =0  set  @Amount24 =0   
	 
						 Set @Amount01A =0  set @Amount02A =0  set @Amount03A =0  set  @Amount04A =0  set  @Amount05A =0  set  @Amount06A =0  set  @Amount07A =0  set  @Amount08A =0  set  @Amount09A =0  set  @Amount10A =0   
						 Set @Amount11A =0  set @Amount12A =0  set @Amount13A =0  set  @Amount14A =0  set  @Amount15A =0  set  @Amount16A =0  set  @Amount17A =0  set  @Amount18A =0  set  @Amount19A =0  set  @Amount20A =0   
						 set @Amount21A =0  set @Amount22A =0  set @Amount23A =0  set  @Amount24A =0 	 
   
						 Set @Amount01LastPeriod =0  set @Amount02LastPeriod =0 set @Amount03LastPeriod =0  set @Amount04LastPeriod =0    
						 set @Amount05LastPeriod =0  set @Amount06LastPeriod =0 set @Amount07LastPeriod =0  set @Amount08LastPeriod =0    
						 set @Amount09LastPeriod =0  set @Amount10LastPeriod =0 set @Amount11LastPeriod =0  set @Amount12LastPeriod =0    
						 set @Amount13LastPeriod =0  set @Amount14LastPeriod =0 set @Amount15LastPeriod =0  set @Amount16LastPeriod =0    
						 set @Amount17LastPeriod =0  set @Amount18LastPeriod =0 set @Amount19LastPeriod =0  set @Amount20LastPeriod =0   
						 set @Amount21LastPeriod =0  set @Amount22LastPeriod =0 set @Amount23LastPeriod =0  set @Amount24LastPeriod =0   
	 
						 Set @Amount01ALastPeriod =0  set @Amount02ALastPeriod =0 set @Amount03ALastPeriod =0  set @Amount04ALastPeriod =0    
						 set @Amount05ALastPeriod =0  set @Amount06ALastPeriod =0 set @Amount07ALastPeriod =0  set @Amount08ALastPeriod =0    
						 set @Amount09ALastPeriod =0  set @Amount10ALastPeriod =0 set @Amount11ALastPeriod =0  set @Amount12ALastPeriod =0    
						 set @Amount13ALastPeriod =0  set @Amount14ALastPeriod =0 set @Amount15ALastPeriod =0  set @Amount16ALastPeriod =0    
						 set @Amount17ALastPeriod =0  set @Amount18ALastPeriod =0 set @Amount19ALastPeriod =0  set @Amount20ALastPeriod =0   
						 set @Amount21ALastPeriod =0  set @Amount22ALastPeriod =0 set @Amount23ALastPeriod =0  set @Amount24ALastPeriod =0  	 
 
						 select @FromID =orderby from AV6666 where SelectionType = @FieldID and DivisionID in (@DivisionID,'@@@') and SelectionID = @FromValueID 
						 select @ToID =orderby from AV6666 where SelectionType = @FieldID and DivisionID in (@DivisionID,'@@@') and SelectionID = @ToValueID   

						 IF @FieldID IN ('MO','QU','YE')
							select @FromID00 =orderby from AV6666 where SelectionType = @FieldID and DivisionID in (@DivisionID,'@@@') and SelectionID = '01/'+ltrim(@ToYear)
						 ELSE
							select @FromID00 =orderby from AV6666 where SelectionType = @FieldID and DivisionID in (@DivisionID,'@@@') and SelectionID = @FromValueID

						 select @ToID00 =orderby from AV6666 where SelectionType = @FieldID and DivisionID in (@DivisionID,'@@@') and SelectionID = @ToValueID
					END

					----------------------------<<Begin - Lũy kế từ đầu năm>>----------------------------------------------------------------------
					BEGIN
						 SET @Cur_Ana00 = Cursor Scroll KeySet FOR    
						 Select SelectionID From AV6666  
						 Where SelectionType= @FieldID   
						 and Orderby between @FromID00 and @ToID00 
						 and DivisionID in (@DivisionID,'@@@') 
						 order by Orderby 

						 OPEN @Cur_Ana00  
						 FETCH NEXT FROM @Cur_Ana00 INTO  @AnaID00  
						 ---Khoi tao gia tri dau  
						 WHILE @@Fetch_Status = 0
						 BEGIN
							If @ReportCode in ('LLONB','LLONB01','LLONBYTD') And @LineID = '05.01'   
							Begin  
								Select @AnaTypeID='A01',@FromAnaID=@AnaID00,@ToAnaID = @AnaID00  
								Select @AnaID00 = @DivisionID  
							End

							--IF @LineID = '003.001.01'
							--BEGIN
							--	PRINT '------------------------------------' + @LineID
							--	PRINT '@i:'+                        CONVERT(NVARCHAR(100), @i)
							--	PRINT '@FromMonth:'+                        CONVERT(NVARCHAR(100), @FromMonth)
							--	PRINT '@FromYear:'+                        CONVERT(NVARCHAR(100), @FromYear)
							--	PRINT '@ToMonth:'+                        CONVERT(NVARCHAR(100), @ToMonth)
							--	PRINT '@ToYear:'+                        CONVERT(NVARCHAR(100), @ToYear)
							--	PRINT '@CaculatorID:'+                        CONVERT(NVARCHAR(100), @CaculatorID)
							--	PRINT '@FromAccountID:'+                        CONVERT(NVARCHAR(100), @FromAccountID)
							--	PRINT '@ToAccountID:'+                        CONVERT(NVARCHAR(100), @ToAccountID)
							--	PRINT '@FromCorAccountID:'+                        CONVERT(NVARCHAR(100), @FromCorAccountID)
							--	PRINT '@ToCorAccountID:'+	                        CONVERT(NVARCHAR(100), @ToCorAccountID)	
							--	PRINT '@AnaTypeID:'+                        CONVERT(NVARCHAR(100), @AnaTypeID)
							--	PRINT '@FromAnaID:'+                        CONVERT(NVARCHAR(100), @FromAnaID)
							--	PRINT '@ToAnaID:'+                        CONVERT(NVARCHAR(100), @ToAnaID)
							--	PRINT '@FieldID:'+	                        CONVERT(NVARCHAR(100), @FieldID)	
							--	PRINT '@AnaID00:'+			                        CONVERT(NVARCHAR(100), @AnaID00)			
							--	PRINT '@BudgetID:'+			                        CONVERT(NVARCHAR(100), @BudgetID)		
							--END	
				
							EXEC AP7619 @DivisionID,1,@ToYear,@ToMonth,@ToYear,  
							@CaculatorID,@FromAccountID,@ToAccountID,  
							@FromCorAccountID,@ToCorAccountID,  
							@AnaTypeID,@FromAnaID,@ToAnaID,@FieldID,@AnaID00,  
							@BudgetID,@Amount OUTPUT, @AmountA OUTPUT, @StrDivisionID 

							SET @Amount00 = @Amount00 + isnull(@Amount,0) 
							SET @Amount = 0
							SET @AmountA = 0

						FETCH NEXT FROM @Cur_Ana00 INTO  @AnaID00  
						End  
						Close  @Cur_Ana00
					END

					------------------------------<<End - Lũy kế từ đầu năm>>----------------------------------------------------------------------
					BEGIN
						SET @Cur_Ana = Cursor Scroll KeySet FOR    
						Select SelectionID From AV6666  
						Where SelectionType= @FieldID   
							 and Orderby between @FromID and @ToID 
							 and DivisionID in (@DivisionID,'@@@') 
						order by Orderby

						Open @Cur_Ana  
						FETCH NEXT FROM @Cur_Ana INTO  @AnaID  
						---Khoi tao gia tri dau  
						WHILE @@Fetch_Status = 0 and @i<=24  
						BEGIN  
							If @ReportCode in ('LLONB','LLONB01','LLONBYTD') And @LineID = '05.01'   
							Begin  
								Select @AnaTypeID='A01',@FromAnaID=@AnaID,@ToAnaID = @AnaID  
								Select @AnaID = @DivisionID  
							End  
				
							--IF @LineID = '003.001.01'
							--BEGIN
							--	PRINT '------------------------------------' + @LineID
							--	PRINT '@i:'+                        CONVERT(NVARCHAR(100), @i)
							--	PRINT '@FromMonth:'+                        CONVERT(NVARCHAR(100), @FromMonth)
							--	PRINT '@FromYear:'+                        CONVERT(NVARCHAR(100), @FromYear)
							--	PRINT '@ToMonth:'+                        CONVERT(NVARCHAR(100), @ToMonth)
							--	PRINT '@ToYear:'+                        CONVERT(NVARCHAR(100), @ToYear)
							--	PRINT '@CaculatorID:'+                        CONVERT(NVARCHAR(100), @CaculatorID)
							--	PRINT '@FromAccountID:'+                        CONVERT(NVARCHAR(100), @FromAccountID)
							--	PRINT '@ToAccountID:'+                        CONVERT(NVARCHAR(100), @ToAccountID)
							--	PRINT '@FromCorAccountID:'+                        CONVERT(NVARCHAR(100), @FromCorAccountID)
							--	PRINT '@ToCorAccountID:'+	                        CONVERT(NVARCHAR(100), @ToCorAccountID)	
							--	PRINT '@AnaTypeID:'+                        CONVERT(NVARCHAR(100), @AnaTypeID)
							--	PRINT '@FromAnaID:'+                        CONVERT(NVARCHAR(100), @FromAnaID)
							--	PRINT '@ToAnaID:'+                        CONVERT(NVARCHAR(100), @ToAnaID)
							--	PRINT '@FieldID:'+	                        CONVERT(NVARCHAR(100), @FieldID)	
							--	PRINT '@AnaID:'+			                        CONVERT(NVARCHAR(100), @AnaID)			
							--	PRINT '@BudgetID:'+			                        CONVERT(NVARCHAR(100), @BudgetID)		
							--END	
					
						 --  EXEC AP7619 @DivisionID,1,@ToYear,@ToMonth,@ToYear,  
							--@CaculatorID,@FromAccountID,@ToAccountID,  
							--@FromCorAccountID,@ToCorAccountID,  
							--@AnaTypeID,@FromAnaID,@ToAnaID,@FieldID,@AnaID,  
							--@BudgetID,@Amount OUTPUT, @AmountA OUTPUT, @StrDivisionID 
				
							--SET @Amount00 = isnull(@Amount,0) 
							--SET @Amount = 0
							--SET @AmountA = 0
						
						   EXEC AP7619 @DivisionID,@FromMonth,@FromYear,@ToMonth,@ToYear,  
							@CaculatorID,@FromAccountID,@ToAccountID,  
							@FromCorAccountID,@ToCorAccountID,  
							@AnaTypeID,@FromAnaID,@ToAnaID,@FieldID,@AnaID,  
							@BudgetID,@Amount OUTPUT, @AmountA OUTPUT, @StrDivisionID  
      
						   EXEC AP7619 @DivisionID,@FromMonthLastPeriod,@FromYearLastPeriod,@ToMonthLastPeriod,@ToYearLastPeriod,  
							@CaculatorID,@FromAccountID,@ToAccountID,  
							@FromCorAccountID,@ToCorAccountID,  
							@AnaTypeID,@FromAnaID,@ToAnaID,@FieldID,@AnaID,  
							@BudgetID,@AmountLastPeriod OUTPUT, @AmountALastPeriod OUTPUT, @StrDivisionID   

							IF @CustomerName IN (N'161')
							BEGIN
								EXEC AP7619_INT @DivisionID,@FromMonth,@FromYear,@ToMonth,@ToYear,  
								@CaculatorID,@FromAccountID,@ToAccountID,  
								@FromCorAccountID,@ToCorAccountID,  
								@AnaTypeID,@FromAnaID,@ToAnaID,@FieldID,@AnaID,  
								@BudgetID,@Amount OUTPUT, @AmountA OUTPUT, @StrDivisionID  
							END
  
			
						   IF @i = 1   
						   BEGIN   
							SET @Amount01 = isnull(@Amount,0)  
							SET @Amount01LastPeriod = isnull(@AmountLastPeriod,0)
							SET @Amount01A = isnull(@AmountA,0)  
							SET @Amount01ALastPeriod = isnull(@AmountALastPeriod,0)	
						   END   
  
						   IF @i = 2   
						   BEGIN   
							SET @Amount02 = isnull(@Amount,0)
							SET @Amount02LastPeriod = isnull(@AmountLastPeriod,0) 
							SET @Amount02A = isnull(@AmountA,0) 
							SET @Amount02ALastPeriod = isnull(@AmountALastPeriod,0)
						   END   
  
						   IF @i = 3   
						   BEGIN   
							SET @Amount03 = isnull(@Amount,0)  
							SET @Amount03LastPeriod = isnull(@AmountLastPeriod,0)  
							SET @Amount03A = isnull(@AmountA,0)  
							SET @Amount03ALastPeriod = isnull(@AmountALastPeriod,0)		
						   END   
  
						   IF @i = 4   
						   BEGIN   
							SET @Amount04 = isnull(@Amount,0)  
							SET @Amount04LastPeriod = isnull(@AmountLastPeriod,0) 
							SET @Amount04A = isnull(@AmountA,0)  
							SET @Amount04ALastPeriod = isnull(@AmountALastPeriod,0)  		 
						   END   
  
						   IF @i = 5   
						   BEGIN   
							SET @Amount05 = isnull(@Amount,0)  
							SET @Amount05LastPeriod = isnull(@AmountLastPeriod,0)  
							SET @Amount05A = isnull(@AmountA,0)  
							SET @Amount05ALastPeriod = isnull(@AmountALastPeriod,0)
						   END   
  
						   IF @i = 6   
						   BEGIN   
							SET @Amount06 = isnull(@Amount,0)  
							SET @Amount06LastPeriod = isnull(@AmountLastPeriod,0)
							SET @Amount06A = isnull(@AmountA,0)  
							SET @Amount06ALastPeriod = isnull(@AmountALastPeriod,0) 		  
						   END   
  
						   IF @i = 7   
						   BEGIN   
							SET @Amount07 = isnull(@Amount,0)  
							SET @Amount07LastPeriod = isnull(@AmountLastPeriod,0)  
							SET @Amount07A = isnull(@AmountA,0)  
							SET @Amount07ALastPeriod = isnull(@AmountALastPeriod,0) 		
						   END   
  
						   IF @i = 8   
						   BEGIN   
							SET @Amount08 = isnull(@Amount,0)  
							SET @Amount08LastPeriod = isnull(@AmountLastPeriod,0)
							SET @Amount08A = isnull(@AmountA,0)  
							SET @Amount08ALastPeriod = isnull(@AmountALastPeriod,0)   
						   END   
  
						   IF @i = 9   
						   BEGIN   
							SET @Amount09 = isnull(@Amount,0)  
							SET @Amount09LastPeriod = isnull(@AmountLastPeriod,0)  
							SET @Amount09A = isnull(@AmountA,0)  
							SET @Amount09ALastPeriod = isnull(@AmountALastPeriod,0)  
						   END   
  
						   IF @i = 10   
						   BEGIN   
							SET @Amount10 = isnull(@Amount,0)  
							SET @Amount10LastPeriod = isnull(@AmountLastPeriod,0)
							SET @Amount10A = isnull(@AmountA,0)  
							SET @Amount10ALastPeriod = isnull(@AmountALastPeriod,0)	  
						   END   
  
						   IF @i = 11   
						   BEGIN   
							SET @Amount11 = isnull(@Amount,0)  
							SET @Amount11LastPeriod = isnull(@AmountLastPeriod,0)  
							SET @Amount11A = isnull(@AmountA,0)  
							SET @Amount11ALastPeriod = isnull(@AmountALastPeriod,0)				
						   END   
  
						   IF @i = 12   
						   BEGIN   
							SET @Amount12 = isnull(@Amount,0)  
							SET @Amount12LastPeriod = isnull(@AmountLastPeriod,0)  
							SET @Amount12A = isnull(@AmountA,0)  
							SET @Amount12ALastPeriod = isnull(@AmountALastPeriod,0) 		
						   END   
  
						   IF @i = 13   
						   BEGIN   
							SET @Amount13 = isnull(@Amount,0)  
							SET @Amount13LastPeriod = isnull(@AmountLastPeriod,0)  
							SET @Amount13A = isnull(@AmountA,0)  
							SET @Amount13ALastPeriod = isnull(@AmountALastPeriod,0) 	
						   END   
  
						   IF @i = 14   
						   BEGIN   
							SET @Amount14 = isnull(@Amount,0)  
							SET @Amount14LastPeriod = isnull(@AmountLastPeriod,0)  
							SET @Amount14A = isnull(@AmountA,0)  
							SET @Amount14ALastPeriod = isnull(@AmountALastPeriod,0)	
						   END   
  
						   IF @i = 15   
						   BEGIN   
							SET @Amount15 = isnull(@Amount,0)  
							SET @Amount15LastPeriod = isnull(@AmountLastPeriod,0)  
							SET @Amount15A = isnull(@AmountA,0)  
							SET @Amount15ALastPeriod = isnull(@AmountALastPeriod,0)  		
							END   
  
						   IF @i = 16   
						   BEGIN   
							SET @Amount16 = isnull(@Amount,0)  
							SET @Amount16LastPeriod = isnull(@AmountLastPeriod,0)  
							SET @Amount16A = isnull(@AmountA,0)  
							SET @Amount16ALastPeriod = isnull(@AmountALastPeriod,0)	
						   END   
  
						   IF @i = 17   
						   BEGIN   
							SET @Amount17 = isnull(@Amount,0)  
							SET @Amount17LastPeriod = isnull(@AmountLastPeriod,0)  
							SET @Amount17A = isnull(@AmountA,0)  
							SET @Amount17ALastPeriod = isnull(@AmountALastPeriod,0)	
						   END   
  
						   IF @i = 18   
						   BEGIN   
							SET @Amount18 = isnull(@Amount,0)  
							SET @Amount18LastPeriod = isnull(@AmountLastPeriod,0) 
							SET @Amount18A = isnull(@AmountA,0)  
							SET @Amount18ALastPeriod = isnull(@AmountALastPeriod,0)	 
						   END   
  
						   IF @i = 19   
						   BEGIN   
							SET @Amount19 = isnull(@Amount,0)  
							SET @Amount19LastPeriod = isnull(@AmountLastPeriod,0)  
							SET @Amount19A = isnull(@AmountA,0)  
							SET @Amount19ALastPeriod = isnull(@AmountALastPeriod,0) 		
						   END   
  
						   IF @i = 20   
						   BEGIN   
							SET @Amount20 = isnull(@Amount,0)  
							SET @Amount20LastPeriod = isnull(@AmountLastPeriod,0)  
							SET @Amount20A = isnull(@AmountA,0)  
							SET @Amount20ALastPeriod = isnull(@AmountALastPeriod,0) 	
						   END   
  
						   IF @i = 21   
						   BEGIN   
							SET @Amount21 = isnull(@Amount,0)  
							SET @Amount21LastPeriod = isnull(@AmountLastPeriod,0)  
							SET @Amount21A = isnull(@AmountA,0)  
							SET @Amount21ALastPeriod = isnull(@AmountALastPeriod,0)  		
						   END   
  
						   IF @i = 22   
						   BEGIN   
							SET @Amount22 = isnull(@Amount,0)  
							SET @Amount22LastPeriod = isnull(@AmountLastPeriod,0)  
							SET @Amount22A = isnull(@AmountA,0)  
							SET @Amount22ALastPeriod = isnull(@AmountALastPeriod,0)	
						   END   
  
						   IF @i = 23   
						   BEGIN   
							SET @Amount23 = isnull(@Amount,0)  
							SET @Amount23LastPeriod = isnull(@AmountLastPeriod,0)
							SET @Amount23A = isnull(@AmountA,0)  
							SET @Amount23ALastPeriod = isnull(@AmountALastPeriod,0)  
						   END   
  
						   IF @i = 24   
						   BEGIN   
							SET @Amount24 = isnull(@Amount,0)  
							SET @Amount24LastPeriod = isnull(@AmountLastPeriod,0)  
							SET @Amount24A = isnull(@AmountA,0)  
							SET @Amount24ALastPeriod = isnull(@AmountALastPeriod,0)	
						   END   
						   PRINT 'End '+@LineID
							Set  @i = @i+1   
						FETCH NEXT FROM @Cur_Ana INTO  @AnaID  
						End  
						Close  @Cur_Ana
					END

					--Update dữ liệu báo cáo 
					BEGIN
					--UPDATE AT7621 SET LineDescription = @LineDescription
					--WHERE ReportCode=@ReportCode and LineID =@LineID and DivisionID =@DivisionID

						Update AT7622   set 
							Amount00 = isnull(Amount00,0)+ @Amount00,    
							Amount01 = isnull(Amount01,0)+ @Amount01,   
							Amount02 = isnull(Amount02,0)+ @Amount02,  
							Amount03 = isnull(Amount03,0)+ @Amount03,  
							Amount04 = isnull(Amount04,0)+ @Amount04,  
							Amount05 = isnull(Amount05,0)+ @Amount05,  
							Amount06 = isnull(Amount06,0)+ @Amount06,  
							Amount07 = isnull(Amount07,0)+ @Amount07,  
							Amount08 = isnull(Amount08,0)+ @Amount08,  
							Amount09 = isnull(Amount09,0)+ @Amount09,  
							Amount10 = isnull(Amount10,0)+ @Amount10,  
							Amount11 = isnull(Amount11,0)+ @Amount11,  
							Amount12 = isnull(Amount12,0)+ @Amount12,  
							Amount13 = isnull(Amount13,0)+ @Amount13,  
							Amount14 = isnull(Amount14,0)+ @Amount14,  
							Amount15 = isnull(Amount15,0)+ @Amount15,  
							Amount16 = isnull(Amount16,0)+ @Amount16,  
							Amount17 = isnull(Amount17,0)+ @Amount17,  
							Amount18 = isnull(Amount18,0)+ @Amount18,  
							Amount19 = isnull(Amount19,0)+ @Amount19,  
							Amount20 = isnull(Amount20,0)+ @Amount20,  
							Amount21 = isnull(Amount21,0)+ @Amount21,  
							Amount22 = isnull(Amount22,0)+ @Amount22,  
							Amount23 = isnull(Amount23,0)+ @Amount23,  
							Amount24 = isnull(Amount24,0)+ @Amount24,  
							Amount01A = isnull(Amount01A,0)+ @Amount01A,
							Amount02A = isnull(Amount02A,0)+ @Amount02A,
							Amount03A = isnull(Amount03A,0)+ @Amount03A,
							Amount04A = isnull(Amount04A,0)+ @Amount04A,
							Amount05A = isnull(Amount05A,0)+ @Amount05A,
							Amount06A = isnull(Amount06A,0)+ @Amount06A,
							Amount07A = isnull(Amount07A,0)+ @Amount07A,
							Amount08A = isnull(Amount08A,0)+ @Amount08A,
							Amount09A = isnull(Amount09A,0)+ @Amount09A,
							Amount10A = isnull(Amount10A,0)+ @Amount10A,
							Amount11A = isnull(Amount11A,0)+ @Amount11A,
							Amount12A = isnull(Amount12A,0)+ @Amount12A,
							Amount13A = isnull(Amount13A,0)+ @Amount13A,
							Amount14A = isnull(Amount14A,0)+ @Amount14A,
							Amount15A = isnull(Amount15A,0)+ @Amount15A,
							Amount16A = isnull(Amount16A,0)+ @Amount16A,
							Amount17A = isnull(Amount17A,0)+ @Amount17A,
							Amount18A = isnull(Amount18A,0)+ @Amount18A,
							Amount19A = isnull(Amount19A,0)+ @Amount19A,
							Amount20A = isnull(Amount20A,0)+ @Amount20A,
							Amount21A = isnull(Amount21A,0)+ @Amount21A,
							Amount22A = isnull(Amount22A,0)+ @Amount22A,
							Amount23A = isnull(Amount23A,0)+ @Amount23A,
							Amount24A = isnull(Amount24A,0)+ @Amount24A,		
							Amount01LastPeriod = isnull(Amount01LastPeriod,0)+ @Amount01LastPeriod,   
							Amount02LastPeriod = isnull(Amount02LastPeriod,0)+ @Amount02LastPeriod,  
							Amount03LastPeriod = isnull(Amount03LastPeriod,0)+ @Amount03LastPeriod,  
							Amount04LastPeriod = isnull(Amount04LastPeriod,0)+ @Amount04LastPeriod,  
							Amount05LastPeriod = isnull(Amount05LastPeriod,0)+ @Amount05LastPeriod,  
							Amount06LastPeriod = isnull(Amount06LastPeriod,0)+ @Amount06LastPeriod,  
							Amount07LastPeriod = isnull(Amount07LastPeriod,0)+ @Amount07LastPeriod,  
							Amount08LastPeriod = isnull(Amount08LastPeriod,0)+ @Amount08LastPeriod,  
							Amount09LastPeriod = isnull(Amount09LastPeriod,0)+ @Amount09LastPeriod,  
							Amount10LastPeriod = isnull(Amount10LastPeriod,0)+ @Amount10LastPeriod,  
							Amount11LastPeriod = isnull(Amount11LastPeriod,0)+ @Amount11LastPeriod,  
							Amount12LastPeriod = isnull(Amount12LastPeriod,0)+ @Amount12LastPeriod,  
							Amount13LastPeriod = isnull(Amount13LastPeriod,0)+ @Amount13LastPeriod,  
							Amount14LastPeriod = isnull(Amount14LastPeriod,0)+ @Amount14LastPeriod,  
							Amount15LastPeriod = isnull(Amount15LastPeriod,0)+ @Amount15LastPeriod,  
							Amount16LastPeriod = isnull(Amount16LastPeriod,0)+ @Amount16LastPeriod,  
							Amount17LastPeriod = isnull(Amount17LastPeriod,0)+ @Amount17LastPeriod,  
							Amount18LastPeriod = isnull(Amount18LastPeriod,0)+ @Amount18LastPeriod,  
							Amount19LastPeriod = isnull(Amount19LastPeriod,0)+ @Amount19LastPeriod,  
							Amount20LastPeriod = isnull(Amount20LastPeriod,0)+ @Amount20LastPeriod,  
							Amount21LastPeriod = isnull(Amount21LastPeriod,0)+ @Amount21LastPeriod,  
							Amount22LastPeriod = isnull(Amount22LastPeriod,0)+ @Amount22LastPeriod,  
							Amount23LastPeriod = isnull(Amount23LastPeriod,0)+ @Amount23LastPeriod,  
							Amount24LastPeriod = isnull(Amount24LastPeriod,0)+ @Amount24LastPeriod,
							Amount01ALastPeriod = isnull(Amount01ALastPeriod,0)+ @Amount01ALastPeriod,   
							Amount02ALastPeriod = isnull(Amount02ALastPeriod,0)+ @Amount02ALastPeriod,  
							Amount03ALastPeriod = isnull(Amount03ALastPeriod,0)+ @Amount03ALastPeriod,  
							Amount04ALastPeriod = isnull(Amount04ALastPeriod,0)+ @Amount04ALastPeriod,  
							Amount05ALastPeriod = isnull(Amount05ALastPeriod,0)+ @Amount05ALastPeriod,  
							Amount06ALastPeriod = isnull(Amount06ALastPeriod,0)+ @Amount06ALastPeriod,  
							Amount07ALastPeriod = isnull(Amount07ALastPeriod,0)+ @Amount07ALastPeriod,  
							Amount08ALastPeriod = isnull(Amount08ALastPeriod,0)+ @Amount08ALastPeriod,  
							Amount09ALastPeriod = isnull(Amount09ALastPeriod,0)+ @Amount09ALastPeriod,  
							Amount10ALastPeriod = isnull(Amount10ALastPeriod,0)+ @Amount10ALastPeriod,  
							Amount11ALastPeriod = isnull(Amount11ALastPeriod,0)+ @Amount11ALastPeriod,  
							Amount12ALastPeriod = isnull(Amount12ALastPeriod,0)+ @Amount12ALastPeriod,  
							Amount13ALastPeriod = isnull(Amount13ALastPeriod,0)+ @Amount13ALastPeriod,  
							Amount14ALastPeriod = isnull(Amount14ALastPeriod,0)+ @Amount14ALastPeriod,  
							Amount15ALastPeriod = isnull(Amount15ALastPeriod,0)+ @Amount15ALastPeriod,  
							Amount16ALastPeriod = isnull(Amount16ALastPeriod,0)+ @Amount16ALastPeriod,  
							Amount17ALastPeriod = isnull(Amount17ALastPeriod,0)+ @Amount17ALastPeriod,  
							Amount18ALastPeriod = isnull(Amount18ALastPeriod,0)+ @Amount18ALastPeriod,  
							Amount19ALastPeriod = isnull(Amount19ALastPeriod,0)+ @Amount19ALastPeriod,  
							Amount20ALastPeriod = isnull(Amount20ALastPeriod,0)+ @Amount20ALastPeriod,  
							Amount21ALastPeriod = isnull(Amount21ALastPeriod,0)+ @Amount21ALastPeriod,  
							Amount22ALastPeriod = isnull(Amount22ALastPeriod,0)+ @Amount22ALastPeriod,  
							Amount23ALastPeriod = isnull(Amount23ALastPeriod,0)+ @Amount23ALastPeriod,  
							Amount24ALastPeriod = isnull(Amount24ALastPeriod,0)+ @Amount24ALastPeriod  
						Where ReportCode=@ReportCode and LineID =@LineID and DivisionID =@DivisionID  

						--Neu co chi tieu con duoc tinh vao chi tieu nay.  
						SET @Cur_ChildLevelID= Cursor Scroll KeySet FOR   
						SELECT   AT7621.LineID, AT7621.Sign, AT7621.AccuLineID, isnull(Amount00,0),  
						  isnull(Amount01,0), isnull(Amount02,0), isnull(Amount03,0), isnull(Amount04,0), isnull(Amount05,0),   
						  isnull(Amount06,0), isnull(Amount07,0), isnull(Amount08,0), isnull(Amount09,0), isnull(Amount10,0),   
						  isnull(Amount11,0), isnull(Amount12,0), isnull(Amount13,0), isnull(Amount14,0), isnull(Amount15,0),   
						  isnull(Amount16,0), isnull(Amount17,0), isnull(Amount18,0), isnull(Amount19,0), isnull(Amount20,0),   
						  isnull(Amount21,0), isnull(Amount22,0), isnull(Amount23,0), isnull(Amount24,0),   
						  isnull(Amount01A,0), isnull(Amount02A,0), isnull(Amount03A,0), isnull(Amount04A,0), isnull(Amount05A,0),   
						  isnull(Amount06A,0), isnull(Amount07A,0), isnull(Amount08A,0), isnull(Amount09A,0), isnull(Amount10A,0),   
						  isnull(Amount11A,0), isnull(Amount12A,0), isnull(Amount13A,0), isnull(Amount14A,0), isnull(Amount15A,0),   
						  isnull(Amount16A,0), isnull(Amount17A,0), isnull(Amount18A,0), isnull(Amount19A,0), isnull(Amount20A,0),   
						  isnull(Amount21A,0), isnull(Amount22A,0), isnull(Amount23A,0), isnull(Amount24A,0),   		  
						  isnull(Amount01LastPeriod,0), isnull(Amount02LastPeriod,0), isnull(Amount03LastPeriod,0), isnull(Amount04LastPeriod,0),   
						  isnull(Amount05LastPeriod,0), isnull(Amount06LastPeriod,0), isnull(Amount07LastPeriod,0), isnull(Amount08LastPeriod,0),   
						  isnull(Amount09LastPeriod,0), isnull(Amount10LastPeriod,0), isnull(Amount11LastPeriod,0), isnull(Amount12LastPeriod,0),   
						  isnull(Amount13LastPeriod,0), isnull(Amount14LastPeriod,0), isnull(Amount15LastPeriod,0), isnull(Amount16LastPeriod,0),   
						  isnull(Amount17LastPeriod,0), isnull(Amount18LastPeriod,0), isnull(Amount19LastPeriod,0), isnull(Amount20LastPeriod,0),   
						  isnull(Amount21LastPeriod,0), isnull(Amount22LastPeriod,0), isnull(Amount23LastPeriod,0), isnull(Amount24LastPeriod,0),
						  isnull(Amount01ALastPeriod,0), isnull(Amount02ALastPeriod,0), isnull(Amount03ALastPeriod,0), isnull(Amount04ALastPeriod,0),   
						  isnull(Amount05ALastPeriod,0), isnull(Amount06ALastPeriod,0), isnull(Amount07ALastPeriod,0), isnull(Amount08ALastPeriod,0),   
						  isnull(Amount09ALastPeriod,0), isnull(Amount10ALastPeriod,0), isnull(Amount11ALastPeriod,0), isnull(Amount12ALastPeriod,0),   
						  isnull(Amount13ALastPeriod,0), isnull(Amount14ALastPeriod,0), isnull(Amount15ALastPeriod,0), isnull(Amount16ALastPeriod,0),   
						  isnull(Amount17ALastPeriod,0), isnull(Amount18ALastPeriod,0), isnull(Amount19ALastPeriod,0), isnull(Amount20ALastPeriod,0),   
						  isnull(Amount21ALastPeriod,0), isnull(Amount22ALastPeriod,0), isnull(Amount23ALastPeriod,0), isnull(Amount24ALastPeriod,0)   		     
						FROM AT7621   
						INNER JOIN AT7622 on AT7622.LineID = AT7621.LineID and AT7622.ReportCode = AT7621.ReportCode and AT7622.DivisionID = AT7621.DivisionID  
						WHERE AT7621.DivisionID = @DivisionID and AT7621.ReportCode =@ReportCode ---and AT7621.LevelID >= @LevelID_Pre  
						  and AT7621.AccuLineID in (Select LineID From AT7621 Where ReportCode =@ReportCode and  LineID= @LineID AND DivisionID = @DivisionID)  
						Order by AT7622.LineID

						OPEN @Cur_ChildLevelID  
						FETCH NEXT FROM @Cur_ChildLevelID INTO  @ChildLineID, @ChildSign, @ParLineID,@Amount00,  
							  @Amount01, @Amount02, @Amount03, @Amount04, @Amount05, @Amount06, @Amount07, @Amount08, @Amount09, @Amount10,  
							  @Amount11, @Amount12, @Amount13, @Amount14, @Amount15, @Amount16, @Amount17, @Amount18, @Amount19, @Amount20,  
							  @Amount21, @Amount22, @Amount23, @Amount24,
							  @Amount01A, @Amount02A, @Amount03A, @Amount04A, @Amount05A, @Amount06A, @Amount07A, @Amount08A, @Amount09A, @Amount10A,  
							  @Amount11A, @Amount12A, @Amount13A, @Amount14A, @Amount15A, @Amount16A, @Amount17A, @Amount18A, @Amount19A, @Amount20A,  
							  @Amount21A, @Amount22A, @Amount23A, @Amount24A, 			    
							  @Amount01LastPeriod, @Amount02LastPeriod, @Amount03LastPeriod, @Amount04LastPeriod,   
							  @Amount05LastPeriod, @Amount06LastPeriod, @Amount07LastPeriod, @Amount08LastPeriod,   
							  @Amount09LastPeriod, @Amount10LastPeriod, @Amount11LastPeriod, @Amount12LastPeriod,   
							  @Amount13LastPeriod, @Amount14LastPeriod, @Amount15LastPeriod, @Amount16LastPeriod,   
							  @Amount17LastPeriod, @Amount18LastPeriod, @Amount19LastPeriod, @Amount20LastPeriod,   
							  @Amount21LastPeriod, @Amount22LastPeriod, @Amount23LastPeriod, @Amount24LastPeriod,
							  @Amount01ALastPeriod, @Amount02ALastPeriod, @Amount03ALastPeriod, @Amount04ALastPeriod, 
							  @Amount05ALastPeriod, @Amount06ALastPeriod, @Amount07ALastPeriod, @Amount08ALastPeriod, 
							  @Amount09ALastPeriod, @Amount10ALastPeriod, @Amount11ALastPeriod, @Amount12ALastPeriod, 
							  @Amount13ALastPeriod, @Amount14ALastPeriod, @Amount15ALastPeriod, @Amount16ALastPeriod, 
							  @Amount17ALastPeriod, @Amount18ALastPeriod, @Amount19ALastPeriod, @Amount20ALastPeriod, 
							  @Amount21ALastPeriod, @Amount22ALastPeriod, @Amount23ALastPeriod, @Amount24ALastPeriod				    
						WHILE @@Fetch_Status = 0  
						BEGIN
							If @ChildSign =  '+'   
								Update AT7622  Set   
								Amount00 = isnull(Amount00,0)+ @Amount00, 
								Amount01 = isnull(Amount01,0)+ @Amount01,   
								Amount02 = isnull(Amount02,0)+ @Amount02,  
								Amount03 = isnull(Amount03,0)+ @Amount03,  
								Amount04 = isnull(Amount04,0)+ @Amount04,  
								Amount05 = isnull(Amount05,0)+ @Amount05,  
								Amount06 = isnull(Amount06,0)+ @Amount06,  
								Amount07 = isnull(Amount07,0)+ @Amount07,  
								Amount08 = isnull(Amount08,0)+ @Amount08,  
								Amount09 = isnull(Amount09,0)+ @Amount09,  
								Amount10 = isnull(Amount10,0)+ @Amount10,  
								Amount11 = isnull(Amount11,0)+ @Amount11,  
								Amount12 = isnull(Amount12,0)+ @Amount12,  
								Amount13 = isnull(Amount13,0)+ @Amount13,  
								Amount14 = isnull(Amount14,0)+ @Amount14,  
								Amount15 = isnull(Amount15,0)+ @Amount15,  
								Amount16 = isnull(Amount16,0)+ @Amount16,  
								Amount17 = isnull(Amount17,0)+ @Amount17,  
								Amount18 = isnull(Amount18,0)+ @Amount18,  
								Amount19 = isnull(Amount19,0)+ @Amount19,  
								Amount20 = isnull(Amount20,0)+ @Amount20,  
								Amount21 = isnull(Amount21,0)+ @Amount21,  
								Amount22 = isnull(Amount22,0)+ @Amount22,  
								Amount23 = isnull(Amount23,0)+ @Amount23,  
								Amount24 = isnull(Amount24,0)+ @Amount24,  
								Amount01A = isnull(Amount01A,0)+ @Amount01A, 
								Amount02A = isnull(Amount02A,0)+ @Amount02A, 
								Amount03A = isnull(Amount03A,0)+ @Amount03A, 
								Amount04A = isnull(Amount04A,0)+ @Amount04A, 
								Amount05A = isnull(Amount05A,0)+ @Amount05A, 
								Amount06A = isnull(Amount06A,0)+ @Amount06A, 
								Amount07A = isnull(Amount07A,0)+ @Amount07A, 
								Amount08A = isnull(Amount08A,0)+ @Amount08A, 
								Amount09A = isnull(Amount09A,0)+ @Amount09A, 
								Amount10A = isnull(Amount10A,0)+ @Amount10A, 
								Amount11A = isnull(Amount11A,0)+ @Amount11A, 
								Amount12A = isnull(Amount12A,0)+ @Amount12A, 
								Amount13A = isnull(Amount13A,0)+ @Amount13A, 
								Amount14A = isnull(Amount14A,0)+ @Amount14A, 
								Amount15A = isnull(Amount15A,0)+ @Amount15A, 
								Amount16A = isnull(Amount16A,0)+ @Amount16A, 
								Amount17A = isnull(Amount17A,0)+ @Amount17A, 
								Amount18A = isnull(Amount18A,0)+ @Amount18A, 
								Amount19A = isnull(Amount19A,0)+ @Amount19A, 
								Amount20A = isnull(Amount20A,0)+ @Amount20A, 
								Amount21A = isnull(Amount21A,0)+ @Amount21A, 
								Amount22A = isnull(Amount22A,0)+ @Amount22A, 
								Amount23A = isnull(Amount23A,0)+ @Amount23A, 
								Amount24A = isnull(Amount24A,0)+ @Amount24A, 			
								Amount01LastPeriod = isnull(Amount01LastPeriod,0)+ @Amount01LastPeriod,   
								Amount02LastPeriod = isnull(Amount02LastPeriod,0)+ @Amount02LastPeriod,  
								Amount03LastPeriod = isnull(Amount03LastPeriod,0)+ @Amount03LastPeriod,  
								Amount04LastPeriod = isnull(Amount04LastPeriod,0)+ @Amount04LastPeriod,  
								Amount05LastPeriod = isnull(Amount05LastPeriod,0)+ @Amount05LastPeriod,  
								Amount06LastPeriod = isnull(Amount06LastPeriod,0)+ @Amount06LastPeriod,  
								Amount07LastPeriod = isnull(Amount07LastPeriod,0)+ @Amount07LastPeriod,  
								Amount08LastPeriod = isnull(Amount08LastPeriod,0)+ @Amount08LastPeriod,  
								Amount09LastPeriod = isnull(Amount09LastPeriod,0)+ @Amount09LastPeriod,  
								Amount10LastPeriod = isnull(Amount10LastPeriod,0)+ @Amount10LastPeriod,  
								Amount11LastPeriod = isnull(Amount11LastPeriod,0)+ @Amount11LastPeriod,  
								Amount12LastPeriod = isnull(Amount12LastPeriod,0)+ @Amount12LastPeriod,  
								Amount13LastPeriod = isnull(Amount13LastPeriod,0)+ @Amount13LastPeriod,  
								Amount14LastPeriod = isnull(Amount14LastPeriod,0)+ @Amount14LastPeriod,  
								Amount15LastPeriod = isnull(Amount15LastPeriod,0)+ @Amount15LastPeriod,  
								Amount16LastPeriod = isnull(Amount16LastPeriod,0)+ @Amount16LastPeriod,  
								Amount17LastPeriod = isnull(Amount17LastPeriod,0)+ @Amount17LastPeriod,  
								Amount18LastPeriod = isnull(Amount18LastPeriod,0)+ @Amount18LastPeriod,  
								Amount19LastPeriod = isnull(Amount19LastPeriod,0)+ @Amount19LastPeriod,  
								Amount20LastPeriod = isnull(Amount20LastPeriod,0)+ @Amount20LastPeriod,  
								Amount21LastPeriod = isnull(Amount21LastPeriod,0)+ @Amount21LastPeriod,  
								Amount22LastPeriod = isnull(Amount22LastPeriod,0)+ @Amount22LastPeriod,  
								Amount23LastPeriod = isnull(Amount23LastPeriod,0)+ @Amount23LastPeriod,  
								Amount24LastPeriod = isnull(Amount24LastPeriod,0)+ @Amount24LastPeriod,
								Amount01ALastPeriod = isnull(Amount01ALastPeriod,0)+ @Amount01ALastPeriod,   
								Amount02ALastPeriod = isnull(Amount02ALastPeriod,0)+ @Amount02ALastPeriod,  
								Amount03ALastPeriod = isnull(Amount03ALastPeriod,0)+ @Amount03ALastPeriod,  
								Amount04ALastPeriod = isnull(Amount04ALastPeriod,0)+ @Amount04ALastPeriod,  
								Amount05ALastPeriod = isnull(Amount05ALastPeriod,0)+ @Amount05ALastPeriod,  
								Amount06ALastPeriod = isnull(Amount06ALastPeriod,0)+ @Amount06ALastPeriod,  
								Amount07ALastPeriod = isnull(Amount07ALastPeriod,0)+ @Amount07ALastPeriod,  
								Amount08ALastPeriod = isnull(Amount08ALastPeriod,0)+ @Amount08ALastPeriod,  
								Amount09ALastPeriod = isnull(Amount09ALastPeriod,0)+ @Amount09ALastPeriod,  
								Amount10ALastPeriod = isnull(Amount10ALastPeriod,0)+ @Amount10ALastPeriod,  
								Amount11ALastPeriod = isnull(Amount11ALastPeriod,0)+ @Amount11ALastPeriod,  
								Amount12ALastPeriod = isnull(Amount12ALastPeriod,0)+ @Amount12ALastPeriod,  
								Amount13ALastPeriod = isnull(Amount13ALastPeriod,0)+ @Amount13ALastPeriod,  
								Amount14ALastPeriod = isnull(Amount14ALastPeriod,0)+ @Amount14ALastPeriod,  
								Amount15ALastPeriod = isnull(Amount15ALastPeriod,0)+ @Amount15ALastPeriod,  
								Amount16ALastPeriod = isnull(Amount16ALastPeriod,0)+ @Amount16ALastPeriod,  
								Amount17ALastPeriod = isnull(Amount17ALastPeriod,0)+ @Amount17ALastPeriod,  
								Amount18ALastPeriod = isnull(Amount18ALastPeriod,0)+ @Amount18ALastPeriod,  
								Amount19ALastPeriod = isnull(Amount19ALastPeriod,0)+ @Amount19ALastPeriod,  
								Amount20ALastPeriod = isnull(Amount20ALastPeriod,0)+ @Amount20ALastPeriod,  
								Amount21ALastPeriod = isnull(Amount21ALastPeriod,0)+ @Amount21ALastPeriod,  
								Amount22ALastPeriod = isnull(Amount22ALastPeriod,0)+ @Amount22ALastPeriod,  
								Amount23ALastPeriod = isnull(Amount23ALastPeriod,0)+ @Amount23ALastPeriod,  
								Amount24ALastPeriod = isnull(Amount24ALastPeriod,0)+ @Amount24ALastPeriod  			  
								Where LineID = @ParLineID and ReportCode = @ReportCode and DivisionID = @DivisionID  
							If @ChildSign =  '-'   
								Update AT7622   set    
								Amount00 = isnull(Amount00,0)- @Amount00, 
								Amount01 = isnull(Amount01,0) - @Amount01,   
								Amount02 = isnull(Amount02,0)- @Amount02,  
								Amount03 = isnull(Amount03,0)- @Amount03,  
								Amount04 = isnull(Amount04,0)- @Amount04,  
								Amount05 = isnull(Amount05,0)- @Amount05,  
								Amount06 = isnull(Amount06,0)- @Amount06,  
								Amount07 = isnull(Amount07,0)- @Amount07,  
								Amount08 = isnull(Amount08,0)- @Amount08,  
								Amount09 = isnull(Amount09,0) - @Amount09,  
								Amount10 = isnull(Amount10,0) - @Amount10,  
								Amount11 = isnull(Amount11,0)- @Amount11,  
								Amount12 = isnull(Amount12,0)- @Amount12,  
								Amount13 = isnull(Amount13,0)- @Amount13,  
								Amount14 = isnull(Amount14,0)- @Amount14,  
								Amount15 = isnull(Amount15,0)- @Amount15,  
								Amount16 = isnull(Amount16,0)- @Amount16,  
								Amount17 = isnull(Amount17,0)- @Amount17,  
								Amount18 = isnull(Amount18,0)- @Amount18,  
								Amount19 = isnull(Amount19,0)- @Amount19,  
								Amount20 = isnull(Amount20,0)- @Amount20,  
								Amount21 = isnull(Amount21,0)- @Amount21,  
								Amount22 = isnull(Amount22,0)- @Amount22,  
								Amount23 = isnull(Amount23,0)- @Amount23,  
								Amount24 = isnull(Amount24,0)- @Amount24,  
								Amount01A = isnull(Amount01A,0)- @Amount01A,  
								Amount02A = isnull(Amount02A,0)- @Amount02A,  
								Amount03A = isnull(Amount03A,0)- @Amount03A,  
								Amount04A = isnull(Amount04A,0)- @Amount04A,  
								Amount05A = isnull(Amount05A,0)- @Amount05A,  
								Amount06A = isnull(Amount06A,0)- @Amount06A,  
								Amount07A = isnull(Amount07A,0)- @Amount07A,  
								Amount08A = isnull(Amount08A,0)- @Amount08A,  
								Amount09A = isnull(Amount09A,0)- @Amount09A,  
								Amount10A = isnull(Amount10A,0)- @Amount10A,  
								Amount11A = isnull(Amount11A,0)- @Amount11A,  
								Amount12A = isnull(Amount12A,0)- @Amount12A,  
								Amount13A = isnull(Amount13A,0)- @Amount13A,  
								Amount14A = isnull(Amount14A,0)- @Amount14A,  
								Amount15A = isnull(Amount15A,0)- @Amount15A,  
								Amount16A = isnull(Amount16A,0)- @Amount16A,  
								Amount17A = isnull(Amount17A,0)- @Amount17A,  
								Amount18A = isnull(Amount18A,0)- @Amount18A,  
								Amount19A = isnull(Amount19A,0)- @Amount19A,  
								Amount20A = isnull(Amount20A,0)- @Amount20A,  
								Amount21A = isnull(Amount21A,0)- @Amount21A,  
								Amount22A = isnull(Amount22A,0)- @Amount22A,  
								Amount23A = isnull(Amount23A,0)- @Amount23A,  
								Amount24A = isnull(Amount24A,0)- @Amount24A,  		
								Amount01LastPeriod = isnull(Amount01LastPeriod,0)- @Amount01LastPeriod,   
								Amount02LastPeriod = isnull(Amount02LastPeriod,0)- @Amount02LastPeriod,  
								Amount03LastPeriod = isnull(Amount03LastPeriod,0)- @Amount03LastPeriod,  
								Amount04LastPeriod = isnull(Amount04LastPeriod,0)- @Amount04LastPeriod,  
								Amount05LastPeriod = isnull(Amount05LastPeriod,0)- @Amount05LastPeriod,  
								Amount06LastPeriod = isnull(Amount06LastPeriod,0)- @Amount06LastPeriod,  
								Amount07LastPeriod = isnull(Amount07LastPeriod,0)- @Amount07LastPeriod,  
								Amount08LastPeriod = isnull(Amount08LastPeriod,0)- @Amount08LastPeriod,  
								Amount09LastPeriod = isnull(Amount09LastPeriod,0)- @Amount09LastPeriod,  
								Amount10LastPeriod = isnull(Amount10LastPeriod,0)- @Amount10LastPeriod,  
								Amount11LastPeriod = isnull(Amount11LastPeriod,0)- @Amount11LastPeriod,  
								Amount12LastPeriod = isnull(Amount12LastPeriod,0)- @Amount12LastPeriod,  
								Amount13LastPeriod = isnull(Amount13LastPeriod,0)- @Amount13LastPeriod,  
								Amount14LastPeriod = isnull(Amount14LastPeriod,0)- @Amount14LastPeriod,  
								Amount15LastPeriod = isnull(Amount15LastPeriod,0)- @Amount15LastPeriod,  
								Amount16LastPeriod = isnull(Amount16LastPeriod,0)- @Amount16LastPeriod,  
								Amount17LastPeriod = isnull(Amount17LastPeriod,0)- @Amount17LastPeriod,  
								Amount18LastPeriod = isnull(Amount18LastPeriod,0)- @Amount18LastPeriod,  
								Amount19LastPeriod = isnull(Amount19LastPeriod,0)- @Amount19LastPeriod,  
								Amount20LastPeriod = isnull(Amount20LastPeriod,0)- @Amount20LastPeriod,  
								Amount21LastPeriod = isnull(Amount21LastPeriod,0)- @Amount21LastPeriod,  
								Amount22LastPeriod = isnull(Amount22LastPeriod,0)- @Amount22LastPeriod,  
								Amount23LastPeriod = isnull(Amount23LastPeriod,0)- @Amount23LastPeriod,  
								Amount24LastPeriod = isnull(Amount24LastPeriod,0)- @Amount24LastPeriod,
								Amount01ALastPeriod = isnull(Amount01ALastPeriod,0)- @Amount01ALastPeriod,
								Amount02ALastPeriod = isnull(Amount02ALastPeriod,0)- @Amount02ALastPeriod,
								Amount03ALastPeriod = isnull(Amount03ALastPeriod,0)- @Amount03ALastPeriod,
								Amount04ALastPeriod = isnull(Amount04ALastPeriod,0)- @Amount04ALastPeriod,
								Amount05ALastPeriod = isnull(Amount05ALastPeriod,0)- @Amount05ALastPeriod,
								Amount06ALastPeriod = isnull(Amount06ALastPeriod,0)- @Amount06ALastPeriod,
								Amount07ALastPeriod = isnull(Amount07ALastPeriod,0)- @Amount07ALastPeriod,
								Amount08ALastPeriod = isnull(Amount08ALastPeriod,0)- @Amount08ALastPeriod,
								Amount09ALastPeriod = isnull(Amount09ALastPeriod,0)- @Amount09ALastPeriod,
								Amount10ALastPeriod = isnull(Amount10ALastPeriod,0)- @Amount10ALastPeriod,
								Amount11ALastPeriod = isnull(Amount11ALastPeriod,0)- @Amount11ALastPeriod,
								Amount12ALastPeriod = isnull(Amount12ALastPeriod,0)- @Amount12ALastPeriod,
								Amount13ALastPeriod = isnull(Amount13ALastPeriod,0)- @Amount13ALastPeriod,
								Amount14ALastPeriod = isnull(Amount14ALastPeriod,0)- @Amount14ALastPeriod,
								Amount15ALastPeriod = isnull(Amount15ALastPeriod,0)- @Amount15ALastPeriod,
								Amount16ALastPeriod = isnull(Amount16ALastPeriod,0)- @Amount16ALastPeriod,
								Amount17ALastPeriod = isnull(Amount17ALastPeriod,0)- @Amount17ALastPeriod,
								Amount18ALastPeriod = isnull(Amount18ALastPeriod,0)- @Amount18ALastPeriod,
								Amount19ALastPeriod = isnull(Amount19ALastPeriod,0)- @Amount19ALastPeriod,
								Amount20ALastPeriod = isnull(Amount20ALastPeriod,0)- @Amount20ALastPeriod,
								Amount21ALastPeriod = isnull(Amount21ALastPeriod,0)- @Amount21ALastPeriod,
								Amount22ALastPeriod = isnull(Amount22ALastPeriod,0)- @Amount22ALastPeriod,
								Amount23ALastPeriod = isnull(Amount23ALastPeriod,0)- @Amount23ALastPeriod,
								Amount24ALastPeriod = isnull(Amount24ALastPeriod,0)- @Amount24ALastPeriod 			  
								Where LineID = @ParLineID and ReportCode = @ReportCode and DivisionID = @DivisionID  
							If @ChildSign =  '*'   
								Update AT7622   set    
								Amount00 = (Case when  isnull(Amount00,0) =0 then 1 else  Amount00 End) * @Amount00, 
								Amount01 = (Case when  isnull(Amount01,0) =0 then 1 else  Amount01 End) * @Amount01,   
								Amount02 = (Case when  isnull(Amount02,0) =0 then 1 else  Amount02 End) * @Amount02,  
								Amount03 = (Case when  isnull(Amount03,0) =0 then 1 else  Amount03 End) * @Amount03,  
								Amount04 = (Case when  isnull(Amount04,0) =0 then 1 else  Amount04 End) * @Amount04,  
								Amount05 = (Case when  isnull(Amount05,0) =0 then 1 else  Amount05 End) * @Amount05,  
								Amount06 = (Case when  isnull(Amount06,0) =0 then 1 else  Amount06 End) * @Amount06,  
								Amount07 = (Case when  isnull(Amount07,0) =0 then 1 else  Amount07 End) * @Amount07,  
								Amount08 = (Case when  isnull(Amount08,0) =0 then 1 else  Amount08 End) * @Amount08,  
								Amount09 = (Case when  isnull(Amount09,0) =0 then 1 else  Amount09 End) * @Amount09,  
								Amount10 = (Case when  isnull(Amount10,0) =0 then 1 else  Amount10 End) * @Amount10,  
								Amount11 = (Case when  isnull(Amount11,0) =0 then 1 else  Amount11 End) * @Amount11,  
								Amount12 = (Case when  isnull(Amount12,0) =0 then 1 else  Amount12 End) * @Amount12,  
								Amount13 = (Case when  isnull(Amount13,0) =0 then 1 else  Amount13 End) * @Amount13,  
								Amount14 = (Case when  isnull(Amount14,0) =0 then 1 else  Amount14 End) * @Amount14,  
								Amount15 = (Case when  isnull(Amount15,0) =0 then 1 else  Amount15 End) * @Amount15,  
								Amount16 = (Case when  isnull(Amount16,0) =0 then 1 else  Amount16 End) * @Amount16,  
								Amount17 = (Case when  isnull(Amount17,0) =0 then 1 else  Amount17 End) * @Amount17,  
								Amount18 = (Case when  isnull(Amount18,0) =0 then 1 else  Amount18 End) * @Amount18,  
								Amount19 = (Case when  isnull(Amount19,0) =0 then 1 else  Amount19 End) * @Amount19,  
								Amount20 = (Case when  isnull(Amount20,0) =0 then 1 else  Amount20 End) * @Amount20,  
								Amount21 = (Case when  isnull(Amount21,0) =0 then 1 else  Amount21 End) * @Amount21,  
								Amount22 = (Case when  isnull(Amount22,0) =0 then 1 else  Amount22 End) * @Amount22,  
								Amount23 = (Case when  isnull(Amount23,0) =0 then 1 else  Amount23 End) * @Amount23,  
								Amount24 = (Case when  isnull(Amount24,0) =0 then 1 else  Amount24 End) * @Amount24, 
								Amount01A = (Case when  isnull(Amount01A,0) =0 then 1 else  Amount01A End) * @Amount01A, 
								Amount02A = (Case when  isnull(Amount02A,0) =0 then 1 else  Amount02A End) * @Amount02A, 
								Amount03A = (Case when  isnull(Amount03A,0) =0 then 1 else  Amount03A End) * @Amount03A, 
								Amount04A = (Case when  isnull(Amount04A,0) =0 then 1 else  Amount04A End) * @Amount04A, 
								Amount05A = (Case when  isnull(Amount05A,0) =0 then 1 else  Amount05A End) * @Amount05A, 
								Amount06A = (Case when  isnull(Amount06A,0) =0 then 1 else  Amount06A End) * @Amount06A, 
								Amount07A = (Case when  isnull(Amount07A,0) =0 then 1 else  Amount07A End) * @Amount07A, 
								Amount08A = (Case when  isnull(Amount08A,0) =0 then 1 else  Amount08A End) * @Amount08A, 
								Amount09A = (Case when  isnull(Amount09A,0) =0 then 1 else  Amount09A End) * @Amount09A, 
								Amount10A = (Case when  isnull(Amount10A,0) =0 then 1 else  Amount10A End) * @Amount10A, 
								Amount11A = (Case when  isnull(Amount11A,0) =0 then 1 else  Amount11A End) * @Amount11A, 
								Amount12A = (Case when  isnull(Amount12A,0) =0 then 1 else  Amount12A End) * @Amount12A, 
								Amount13A = (Case when  isnull(Amount13A,0) =0 then 1 else  Amount13A End) * @Amount13A, 
								Amount14A = (Case when  isnull(Amount14A,0) =0 then 1 else  Amount14A End) * @Amount14A, 
								Amount15A = (Case when  isnull(Amount15A,0) =0 then 1 else  Amount15A End) * @Amount15A, 
								Amount16A = (Case when  isnull(Amount16A,0) =0 then 1 else  Amount16A End) * @Amount16A, 
								Amount17A = (Case when  isnull(Amount17A,0) =0 then 1 else  Amount17A End) * @Amount17A, 
								Amount18A = (Case when  isnull(Amount18A,0) =0 then 1 else  Amount18A End) * @Amount18A, 
								Amount19A = (Case when  isnull(Amount19A,0) =0 then 1 else  Amount19A End) * @Amount19A, 
								Amount20A = (Case when  isnull(Amount20A,0) =0 then 1 else  Amount20A End) * @Amount20A, 
								Amount21A = (Case when  isnull(Amount21A,0) =0 then 1 else  Amount21A End) * @Amount21A, 
								Amount22A = (Case when  isnull(Amount22A,0) =0 then 1 else  Amount22A End) * @Amount22A, 
								Amount23A = (Case when  isnull(Amount23A,0) =0 then 1 else  Amount23A End) * @Amount23A, 
								Amount24A = (Case when  isnull(Amount24A,0) =0 then 1 else  Amount24A End) * @Amount24A, 			 
								Amount01LastPeriod = (Case when  isnull(Amount01LastPeriod,0) =0 then 1 else  Amount01LastPeriod End) * @Amount01LastPeriod,   
								Amount02LastPeriod = (Case when  isnull(Amount02LastPeriod,0) =0 then 1 else  Amount02LastPeriod End) * @Amount02LastPeriod,  
								Amount03LastPeriod = (Case when  isnull(Amount03LastPeriod,0) =0 then 1 else  Amount03LastPeriod End) * @Amount03LastPeriod,  
								Amount04LastPeriod = (Case when  isnull(Amount04LastPeriod,0) =0 then 1 else  Amount04LastPeriod End) * @Amount04LastPeriod,  
								Amount05LastPeriod = (Case when  isnull(Amount05LastPeriod,0) =0 then 1 else  Amount05LastPeriod End) * @Amount05LastPeriod,  
								Amount06LastPeriod = (Case when  isnull(Amount06LastPeriod,0) =0 then 1 else  Amount06LastPeriod End) * @Amount06LastPeriod,  
								Amount07LastPeriod = (Case when  isnull(Amount07LastPeriod,0) =0 then 1 else  Amount07LastPeriod End) * @Amount07LastPeriod,  
								Amount08LastPeriod = (Case when  isnull(Amount08LastPeriod,0) =0 then 1 else  Amount08LastPeriod End) * @Amount08LastPeriod,  
								Amount09LastPeriod = (Case when  isnull(Amount09LastPeriod,0) =0 then 1 else  Amount09LastPeriod End) * @Amount09LastPeriod,  
								Amount10LastPeriod = (Case when  isnull(Amount10LastPeriod,0) =0 then 1 else  Amount10LastPeriod End) * @Amount10LastPeriod,  
								Amount11LastPeriod = (Case when  isnull(Amount11LastPeriod,0) =0 then 1 else  Amount11LastPeriod End) * @Amount11LastPeriod,  
								Amount12LastPeriod = (Case when  isnull(Amount12LastPeriod,0) =0 then 1 else  Amount12LastPeriod End) * @Amount12LastPeriod,  
								Amount13LastPeriod = (Case when  isnull(Amount13LastPeriod,0) =0 then 1 else  Amount13LastPeriod End) * @Amount13LastPeriod,  
								Amount14LastPeriod = (Case when  isnull(Amount14LastPeriod,0) =0 then 1 else  Amount14LastPeriod End) * @Amount14LastPeriod,  
								Amount15LastPeriod = (Case when  isnull(Amount15LastPeriod,0) =0 then 1 else  Amount15LastPeriod End) * @Amount15LastPeriod,  
								Amount16LastPeriod = (Case when  isnull(Amount16LastPeriod,0) =0 then 1 else  Amount16LastPeriod End) * @Amount16LastPeriod,  
								Amount17LastPeriod = (Case when  isnull(Amount17LastPeriod,0) =0 then 1 else  Amount17LastPeriod End) * @Amount17LastPeriod,  
								Amount18LastPeriod = (Case when  isnull(Amount18LastPeriod,0) =0 then 1 else  Amount18LastPeriod End) * @Amount18LastPeriod,  
								Amount19LastPeriod = (Case when  isnull(Amount19LastPeriod,0) =0 then 1 else  Amount19LastPeriod End) * @Amount19LastPeriod,  
								Amount20LastPeriod = (Case when  isnull(Amount20LastPeriod,0) =0 then 1 else  Amount20LastPeriod End) * @Amount20LastPeriod,  
								Amount21LastPeriod = (Case when  isnull(Amount21LastPeriod,0) =0 then 1 else  Amount21LastPeriod End) * @Amount21LastPeriod,  
								Amount22LastPeriod = (Case when  isnull(Amount22LastPeriod,0) =0 then 1 else  Amount22LastPeriod End) * @Amount22LastPeriod,  
								Amount23LastPeriod = (Case when  isnull(Amount23LastPeriod,0) =0 then 1 else  Amount23LastPeriod End) * @Amount23LastPeriod,  
								Amount24LastPeriod = (Case when  isnull(Amount24LastPeriod,0) =0 then 1 else  Amount24LastPeriod End) * @Amount24LastPeriod,
								Amount01ALastPeriod = (Case when  isnull(Amount01ALastPeriod,0) =0 then 1 else  Amount01ALastPeriod End) * @Amount01ALastPeriod,  
								Amount02ALastPeriod = (Case when  isnull(Amount02ALastPeriod,0) =0 then 1 else  Amount02ALastPeriod End) * @Amount02ALastPeriod,  
								Amount03ALastPeriod = (Case when  isnull(Amount03ALastPeriod,0) =0 then 1 else  Amount03ALastPeriod End) * @Amount03ALastPeriod,  
								Amount04ALastPeriod = (Case when  isnull(Amount04ALastPeriod,0) =0 then 1 else  Amount04ALastPeriod End) * @Amount04ALastPeriod,  
								Amount05ALastPeriod = (Case when  isnull(Amount05ALastPeriod,0) =0 then 1 else  Amount05ALastPeriod End) * @Amount05ALastPeriod,  
								Amount06ALastPeriod = (Case when  isnull(Amount06ALastPeriod,0) =0 then 1 else  Amount06ALastPeriod End) * @Amount06ALastPeriod,  
								Amount07ALastPeriod = (Case when  isnull(Amount07ALastPeriod,0) =0 then 1 else  Amount07ALastPeriod End) * @Amount07ALastPeriod,  
								Amount08ALastPeriod = (Case when  isnull(Amount08ALastPeriod,0) =0 then 1 else  Amount08ALastPeriod End) * @Amount08ALastPeriod,  
								Amount09ALastPeriod = (Case when  isnull(Amount09ALastPeriod,0) =0 then 1 else  Amount09ALastPeriod End) * @Amount09ALastPeriod,  
								Amount10ALastPeriod = (Case when  isnull(Amount10ALastPeriod,0) =0 then 1 else  Amount10ALastPeriod End) * @Amount10ALastPeriod,  
								Amount11ALastPeriod = (Case when  isnull(Amount11ALastPeriod,0) =0 then 1 else  Amount11ALastPeriod End) * @Amount11ALastPeriod,  
								Amount12ALastPeriod = (Case when  isnull(Amount12ALastPeriod,0) =0 then 1 else  Amount12ALastPeriod End) * @Amount12ALastPeriod,  
								Amount13ALastPeriod = (Case when  isnull(Amount13ALastPeriod,0) =0 then 1 else  Amount13ALastPeriod End) * @Amount13ALastPeriod,  
								Amount14ALastPeriod = (Case when  isnull(Amount14ALastPeriod,0) =0 then 1 else  Amount14ALastPeriod End) * @Amount14ALastPeriod,  
								Amount15ALastPeriod = (Case when  isnull(Amount15ALastPeriod,0) =0 then 1 else  Amount15ALastPeriod End) * @Amount15ALastPeriod,  
								Amount16ALastPeriod = (Case when  isnull(Amount16ALastPeriod,0) =0 then 1 else  Amount16ALastPeriod End) * @Amount16ALastPeriod,  
								Amount17ALastPeriod = (Case when  isnull(Amount17ALastPeriod,0) =0 then 1 else  Amount17ALastPeriod End) * @Amount17ALastPeriod,  
								Amount18ALastPeriod = (Case when  isnull(Amount18ALastPeriod,0) =0 then 1 else  Amount18ALastPeriod End) * @Amount18ALastPeriod,  
								Amount19ALastPeriod = (Case when  isnull(Amount19ALastPeriod,0) =0 then 1 else  Amount19ALastPeriod End) * @Amount19ALastPeriod,  
								Amount20ALastPeriod = (Case when  isnull(Amount20ALastPeriod,0) =0 then 1 else  Amount20ALastPeriod End) * @Amount20ALastPeriod,  
								Amount21ALastPeriod = (Case when  isnull(Amount21ALastPeriod,0) =0 then 1 else  Amount21ALastPeriod End) * @Amount21ALastPeriod,  
								Amount22ALastPeriod = (Case when  isnull(Amount22ALastPeriod,0) =0 then 1 else  Amount22ALastPeriod End) * @Amount22ALastPeriod,  
								Amount23ALastPeriod = (Case when  isnull(Amount23ALastPeriod,0) =0 then 1 else  Amount23ALastPeriod End) * @Amount23ALastPeriod,  
								Amount24ALastPeriod = (Case when  isnull(Amount24ALastPeriod,0) =0 then 1 else  Amount24ALastPeriod End) * @Amount24ALastPeriod  			  
								Where LineID = @ParLineID and ReportCode = @ReportCode and DivisionID = @DivisionID  
							If @ChildSign =  '/'   
								Update AT7622  set  
								Amount00 = Case When isnull(@Amount00,0) <> 0 Then isnull(Amount00,0) / @Amount00 Else 0 End,   
								Amount01 = Case When isnull(@Amount01,0) <> 0 Then isnull(Amount01,0) / @Amount01 Else 0 End,         
								Amount02 = Case When isnull(@Amount02,0) <> 0 Then isnull(Amount02,0) / @Amount02 Else 0 End,         
								Amount03 = Case When isnull(@Amount03,0) <> 0 Then isnull(Amount03,0) / @Amount03 Else 0 End,  
								Amount04 = Case When isnull(@Amount04,0) <> 0 Then isnull(Amount04,0) / @Amount04 Else 0 End,  
								Amount05 = Case When isnull(@Amount05,0) <> 0 Then isnull(Amount05,0) / @Amount05 Else 0 End,  
								Amount06 = Case When isnull(@Amount06,0) <> 0 Then isnull(Amount06,0) / @Amount06 Else 0 End,  
								Amount07 = Case When isnull(@Amount07,0) <> 0 Then isnull(Amount07,0) / @Amount07 Else 0 End,  
								Amount08 = Case When isnull(@Amount08,0) <> 0 Then isnull(Amount08,0) / @Amount08 Else 0 End,  
								Amount09 = Case When isnull(@Amount09,0) <> 0 Then isnull(Amount09,0) / @Amount09 Else 0 End,  
								Amount10 = Case When isnull(@Amount10,0) <> 0 Then isnull(Amount10,0) / @Amount10 Else 0 End,  
								Amount11 = Case When isnull(@Amount11,0) <> 0 Then isnull(Amount11,0) / @Amount11 Else 0 End,  
								Amount12 = Case When isnull(@Amount12,0) <> 0 Then isnull(Amount12,0) / @Amount12 Else 0 End,  
								Amount13 = Case When isnull(@Amount13,0) <> 0 Then isnull(Amount13,0) / @Amount13 Else 0 End,  
								Amount14 = Case When isnull(@Amount14,0) <> 0 Then isnull(Amount14,0) / @Amount14 Else 0 End,  
								Amount15 = Case When isnull(@Amount15,0) <> 0 Then isnull(Amount15,0) / @Amount15 Else 0 End,  
								Amount16 = Case When isnull(@Amount16,0) <> 0 Then isnull(Amount16,0) / @Amount16 Else 0 End,  
								Amount17 = Case When isnull(@Amount17,0) <> 0 Then isnull(Amount17,0) / @Amount17 Else 0 End,  
								Amount18 = Case When isnull(@Amount18,0) <> 0 Then isnull(Amount18,0) / @Amount18 Else 0 End,  
								Amount19 = Case When isnull(@Amount19,0) <> 0 Then isnull(Amount19,0) / @Amount19 Else 0 End,  
								Amount20 = Case When isnull(@Amount20,0) <> 0 Then isnull(Amount20,0) / @Amount20 Else 0 END,  
								Amount21 = Case When isnull(@Amount21,0) <> 0 Then isnull(Amount21,0) / @Amount21 Else 0 END,  
								Amount22 = Case When isnull(@Amount22,0) <> 0 Then isnull(Amount22,0) / @Amount22 Else 0 END,  
								Amount23 = Case When isnull(@Amount23,0) <> 0 Then isnull(Amount23,0) / @Amount23 Else 0 END,  
								Amount24 = Case When isnull(@Amount24,0) <> 0 Then isnull(Amount24,0) / @Amount24 Else 0 End, 
								Amount01A = Case When isnull(@Amount01A,0) <> 0 Then isnull(Amount01A,0) / @Amount01A Else 0 End, 
								Amount02A = Case When isnull(@Amount02A,0) <> 0 Then isnull(Amount02A,0) / @Amount02A Else 0 End, 
								Amount03A = Case When isnull(@Amount03A,0) <> 0 Then isnull(Amount03A,0) / @Amount03A Else 0 End, 
								Amount04A = Case When isnull(@Amount04A,0) <> 0 Then isnull(Amount04A,0) / @Amount04A Else 0 End, 
								Amount05A = Case When isnull(@Amount05A,0) <> 0 Then isnull(Amount05A,0) / @Amount05A Else 0 End, 
								Amount06A = Case When isnull(@Amount06A,0) <> 0 Then isnull(Amount06A,0) / @Amount06A Else 0 End, 
								Amount07A = Case When isnull(@Amount07A,0) <> 0 Then isnull(Amount07A,0) / @Amount07A Else 0 End, 
								Amount08A = Case When isnull(@Amount08A,0) <> 0 Then isnull(Amount08A,0) / @Amount08A Else 0 End, 
								Amount09A = Case When isnull(@Amount09A,0) <> 0 Then isnull(Amount09A,0) / @Amount09A Else 0 End, 
								Amount10A = Case When isnull(@Amount10A,0) <> 0 Then isnull(Amount10A,0) / @Amount10A Else 0 End, 
								Amount11A = Case When isnull(@Amount11A,0) <> 0 Then isnull(Amount11A,0) / @Amount11A Else 0 End, 
								Amount12A = Case When isnull(@Amount12A,0) <> 0 Then isnull(Amount12A,0) / @Amount12A Else 0 End, 
								Amount13A = Case When isnull(@Amount13A,0) <> 0 Then isnull(Amount13A,0) / @Amount13A Else 0 End, 
								Amount14A = Case When isnull(@Amount14A,0) <> 0 Then isnull(Amount14A,0) / @Amount14A Else 0 End, 
								Amount15A = Case When isnull(@Amount15A,0) <> 0 Then isnull(Amount15A,0) / @Amount15A Else 0 End, 
								Amount16A = Case When isnull(@Amount16A,0) <> 0 Then isnull(Amount16A,0) / @Amount16A Else 0 End, 
								Amount17A = Case When isnull(@Amount17A,0) <> 0 Then isnull(Amount17A,0) / @Amount17A Else 0 End, 
								Amount18A = Case When isnull(@Amount18A,0) <> 0 Then isnull(Amount18A,0) / @Amount18A Else 0 End, 
								Amount19A = Case When isnull(@Amount19A,0) <> 0 Then isnull(Amount19A,0) / @Amount19A Else 0 End, 
								Amount20A = Case When isnull(@Amount20A,0) <> 0 Then isnull(Amount20A,0) / @Amount20A Else 0 END, 
								Amount21A = Case When isnull(@Amount21A,0) <> 0 Then isnull(Amount21A,0) / @Amount21A Else 0 END, 
								Amount22A = Case When isnull(@Amount22A,0) <> 0 Then isnull(Amount22A,0) / @Amount22A Else 0 END, 
								Amount23A = Case When isnull(@Amount23A,0) <> 0 Then isnull(Amount23A,0) / @Amount23A Else 0 END, 
								Amount24A = Case When isnull(@Amount24A,0) <> 0 Then isnull(Amount24A,0) / @Amount24A Else 0 End,			 
								Amount01LastPeriod = Case When isnull(@Amount01LastPeriod,0) <> 0 Then isnull(Amount01LastPeriod,0) / @Amount01LastPeriod Else 0 End,         
								Amount02LastPeriod = Case When isnull(@Amount02LastPeriod,0) <> 0 Then isnull(Amount02LastPeriod,0) / @Amount02LastPeriod Else 0 End,         
								Amount03LastPeriod = Case When isnull(@Amount03LastPeriod,0) <> 0 Then isnull(Amount03LastPeriod,0) / @Amount03LastPeriod Else 0 End,  
								Amount04LastPeriod = Case When isnull(@Amount04LastPeriod,0) <> 0 Then isnull(Amount04LastPeriod,0) / @Amount04LastPeriod Else 0 End,  
								Amount05LastPeriod = Case When isnull(@Amount05LastPeriod,0) <> 0 Then isnull(Amount05LastPeriod,0) / @Amount05LastPeriod Else 0 End,  
								Amount06LastPeriod = Case When isnull(@Amount06LastPeriod,0) <> 0 Then isnull(Amount06LastPeriod,0) / @Amount06LastPeriod Else 0 End,  
								Amount07LastPeriod = Case When isnull(@Amount07LastPeriod,0) <> 0 Then isnull(Amount07LastPeriod,0) / @Amount07LastPeriod Else 0 End,  
								Amount08LastPeriod = Case When isnull(@Amount08LastPeriod,0) <> 0 Then isnull(Amount08LastPeriod,0) / @Amount08LastPeriod Else 0 End,  
								Amount09LastPeriod = Case When isnull(@Amount09LastPeriod,0) <> 0 Then isnull(Amount09LastPeriod,0) / @Amount09LastPeriod Else 0 End,  
								Amount10LastPeriod = Case When isnull(@Amount10LastPeriod,0) <> 0 Then isnull(Amount10LastPeriod,0) / @Amount10LastPeriod Else 0 End,  
								Amount11LastPeriod = Case When isnull(@Amount11LastPeriod,0) <> 0 Then isnull(Amount11LastPeriod,0) / @Amount11LastPeriod Else 0 End,  
								Amount12LastPeriod = Case When isnull(@Amount12LastPeriod,0) <> 0 Then isnull(Amount12LastPeriod,0) / @Amount12LastPeriod Else 0 End,  
								Amount13LastPeriod = Case When isnull(@Amount13LastPeriod,0) <> 0 Then isnull(Amount13LastPeriod,0) / @Amount13LastPeriod Else 0 End,  
								Amount14LastPeriod = Case When isnull(@Amount14LastPeriod,0) <> 0 Then isnull(Amount14LastPeriod,0) / @Amount14LastPeriod Else 0 End,  
								Amount15LastPeriod = Case When isnull(@Amount15LastPeriod,0) <> 0 Then isnull(Amount15LastPeriod,0) / @Amount15LastPeriod Else 0 End,  
								Amount16LastPeriod = Case When isnull(@Amount16LastPeriod,0) <> 0 Then isnull(Amount16LastPeriod,0) / @Amount16LastPeriod Else 0 End,  
								Amount17LastPeriod = Case When isnull(@Amount17LastPeriod,0) <> 0 Then isnull(Amount17LastPeriod,0) / @Amount17LastPeriod Else 0 End,  
								Amount18LastPeriod = Case When isnull(@Amount18LastPeriod,0) <> 0 Then isnull(Amount18LastPeriod,0) / @Amount18LastPeriod Else 0 End,  
								Amount19LastPeriod = Case When isnull(@Amount19LastPeriod,0) <> 0 Then isnull(Amount19LastPeriod,0) / @Amount19LastPeriod Else 0 End,  
								Amount20LastPeriod = Case When isnull(@Amount20LastPeriod,0) <> 0 Then isnull(Amount20LastPeriod,0) / @Amount20LastPeriod Else 0 END,  
								Amount21LastPeriod = Case When isnull(@Amount21LastPeriod,0) <> 0 Then isnull(Amount21LastPeriod,0) / @Amount21LastPeriod Else 0 END,  
								Amount22LastPeriod = Case When isnull(@Amount22LastPeriod,0) <> 0 Then isnull(Amount22LastPeriod,0) / @Amount22LastPeriod Else 0 END,  
								Amount23LastPeriod = Case When isnull(@Amount23LastPeriod,0) <> 0 Then isnull(Amount23LastPeriod,0) / @Amount23LastPeriod Else 0 END,  
								Amount24LastPeriod = Case When isnull(@Amount24LastPeriod,0) <> 0 Then isnull(Amount24LastPeriod,0) / @Amount24LastPeriod Else 0 END,
								Amount01ALastPeriod = Case When isnull(@Amount01ALastPeriod,0) <> 0 Then isnull(Amount01ALastPeriod,0) / @Amount01ALastPeriod Else 0 End,
								Amount02ALastPeriod = Case When isnull(@Amount02ALastPeriod,0) <> 0 Then isnull(Amount02ALastPeriod,0) / @Amount02ALastPeriod Else 0 End,
								Amount03ALastPeriod = Case When isnull(@Amount03ALastPeriod,0) <> 0 Then isnull(Amount03ALastPeriod,0) / @Amount03ALastPeriod Else 0 End,
								Amount04ALastPeriod = Case When isnull(@Amount04ALastPeriod,0) <> 0 Then isnull(Amount04ALastPeriod,0) / @Amount04ALastPeriod Else 0 End,
								Amount05ALastPeriod = Case When isnull(@Amount05ALastPeriod,0) <> 0 Then isnull(Amount05ALastPeriod,0) / @Amount05ALastPeriod Else 0 End,
								Amount06ALastPeriod = Case When isnull(@Amount06ALastPeriod,0) <> 0 Then isnull(Amount06ALastPeriod,0) / @Amount06ALastPeriod Else 0 End,
								Amount07ALastPeriod = Case When isnull(@Amount07ALastPeriod,0) <> 0 Then isnull(Amount07ALastPeriod,0) / @Amount07ALastPeriod Else 0 End,
								Amount08ALastPeriod = Case When isnull(@Amount08ALastPeriod,0) <> 0 Then isnull(Amount08ALastPeriod,0) / @Amount08ALastPeriod Else 0 End,
								Amount09ALastPeriod = Case When isnull(@Amount09ALastPeriod,0) <> 0 Then isnull(Amount09ALastPeriod,0) / @Amount09ALastPeriod Else 0 End,
								Amount10ALastPeriod = Case When isnull(@Amount10ALastPeriod,0) <> 0 Then isnull(Amount10ALastPeriod,0) / @Amount10ALastPeriod Else 0 End,
								Amount11ALastPeriod = Case When isnull(@Amount11ALastPeriod,0) <> 0 Then isnull(Amount11ALastPeriod,0) / @Amount11ALastPeriod Else 0 End,
								Amount12ALastPeriod = Case When isnull(@Amount12ALastPeriod,0) <> 0 Then isnull(Amount12ALastPeriod,0) / @Amount12ALastPeriod Else 0 End,
								Amount13ALastPeriod = Case When isnull(@Amount13ALastPeriod,0) <> 0 Then isnull(Amount13ALastPeriod,0) / @Amount13ALastPeriod Else 0 End,
								Amount14ALastPeriod = Case When isnull(@Amount14ALastPeriod,0) <> 0 Then isnull(Amount14ALastPeriod,0) / @Amount14ALastPeriod Else 0 End,
								Amount15ALastPeriod = Case When isnull(@Amount15ALastPeriod,0) <> 0 Then isnull(Amount15ALastPeriod,0) / @Amount15ALastPeriod Else 0 End,
								Amount16ALastPeriod = Case When isnull(@Amount16ALastPeriod,0) <> 0 Then isnull(Amount16ALastPeriod,0) / @Amount16ALastPeriod Else 0 End,
								Amount17ALastPeriod = Case When isnull(@Amount17ALastPeriod,0) <> 0 Then isnull(Amount17ALastPeriod,0) / @Amount17ALastPeriod Else 0 End,
								Amount18ALastPeriod = Case When isnull(@Amount18ALastPeriod,0) <> 0 Then isnull(Amount18ALastPeriod,0) / @Amount18ALastPeriod Else 0 End,
								Amount19ALastPeriod = Case When isnull(@Amount19ALastPeriod,0) <> 0 Then isnull(Amount19ALastPeriod,0) / @Amount19ALastPeriod Else 0 End,
								Amount20ALastPeriod = Case When isnull(@Amount20ALastPeriod,0) <> 0 Then isnull(Amount20ALastPeriod,0) / @Amount20ALastPeriod Else 0 END,
								Amount21ALastPeriod = Case When isnull(@Amount21ALastPeriod,0) <> 0 Then isnull(Amount21ALastPeriod,0) / @Amount21ALastPeriod Else 0 END,
								Amount22ALastPeriod = Case When isnull(@Amount22ALastPeriod,0) <> 0 Then isnull(Amount22ALastPeriod,0) / @Amount22ALastPeriod Else 0 END,
								Amount23ALastPeriod = Case When isnull(@Amount23ALastPeriod,0) <> 0 Then isnull(Amount23ALastPeriod,0) / @Amount23ALastPeriod Else 0 END,
								Amount24ALastPeriod = Case When isnull(@Amount24ALastPeriod,0) <> 0 Then isnull(Amount24ALastPeriod,0) / @Amount24ALastPeriod Else 0 END			  
								Where LineID = @ParLineID and ReportCode = @ReportCode and DivisionID = @DivisionID  

							FETCH NEXT FROM @Cur_ChildLevelID INTO  @ChildLineID, @ChildSign, @ParLineID, @Amount00,  
							@Amount01, @Amount02, @Amount03, @Amount04, @Amount05, @Amount06, @Amount07, @Amount08, @Amount09, @Amount10,  
							@Amount11, @Amount12, @Amount13, @Amount14, @Amount15, @Amount16, @Amount17, @Amount18, @Amount19, @Amount20,  
							@Amount21, @Amount22, @Amount23, @Amount24,  
							@Amount01A, @Amount02A, @Amount03A, @Amount04A, @Amount05A, @Amount06A, @Amount07A, @Amount08A, @Amount09A, @Amount10A,  
							@Amount11A, @Amount12A, @Amount13A, @Amount14A, @Amount15A, @Amount16A, @Amount17A, @Amount18A, @Amount19A, @Amount20A,  
							@Amount21A, @Amount22A, @Amount23A, @Amount24A,  				
							@Amount01LastPeriod, @Amount02LastPeriod, @Amount03LastPeriod, @Amount04LastPeriod,   
							@Amount05LastPeriod, @Amount06LastPeriod, @Amount07LastPeriod, @Amount08LastPeriod,   
							@Amount09LastPeriod, @Amount10LastPeriod, @Amount11LastPeriod, @Amount12LastPeriod,   
							@Amount13LastPeriod, @Amount14LastPeriod, @Amount15LastPeriod, @Amount16LastPeriod,   
							@Amount17LastPeriod, @Amount18LastPeriod, @Amount19LastPeriod, @Amount20LastPeriod,   
							@Amount21LastPeriod, @Amount22LastPeriod, @Amount23LastPeriod, @Amount24LastPeriod,
							@Amount01ALastPeriod, @Amount02ALastPeriod, @Amount03ALastPeriod, @Amount04ALastPeriod,   
							@Amount05ALastPeriod, @Amount06ALastPeriod, @Amount07ALastPeriod, @Amount08ALastPeriod,   
							@Amount09ALastPeriod, @Amount10ALastPeriod, @Amount11ALastPeriod, @Amount12ALastPeriod,   
							@Amount13ALastPeriod, @Amount14ALastPeriod, @Amount15ALastPeriod, @Amount16ALastPeriod,   
							@Amount17ALastPeriod, @Amount18ALastPeriod, @Amount19ALastPeriod, @Amount20ALastPeriod,   
							@Amount21ALastPeriod, @Amount22ALastPeriod, @Amount23ALastPeriod, @Amount24ALastPeriod			  
						END
						CLOSE @Cur_ChildLevelID
					END

				FETCH NEXT FROM @Cur INTO  @LineID, @LineDescription, @Sign, @AccuLineID, @CaculatorID ,@FromAccountID, @ToAccountID, @FromCorAccountID,@ToCorAccountID,  
				  @AnaTypeID, @FromAnaID , @ToAnaID, @BudgetID  
				End  
				CLOSE @Cur 

				SET @LevelID_Pre = @LevelID
				FETCH NEXT FROM @Cur_LevelID INTO  @LevelID
			END
			CLOSE @Cur_LevelID
		END

		---Buoc 5  Tinh toan va update du lieu bang bang tam loai "YL" dong (Danh thu, Gia von, Loi nhuan):
		BEGIN
			SET @Cur2 = Cursor Scroll KeySet FOR   
			SELECT LineID, LineDescription, Sign, AccuLineID, CaculatorID , FromAccountID, ToAccountID, FromCorAccountID,ToCorAccountID,ISNULL(AnaTypeID,''),ISNULL(FromAnaID,''),ISNULL  (ToAnaID,''),BudgetID
			FROM	AT7621 WITH (NOLOCK)  
			WHERE	ReportCode = @ReportCode AND DivisionID = @DivisionID AND CaculatorID = N'YL'
			---Order by LineID 

			OPEN @Cur2  
			FETCH NEXT FROM @Cur2 INTO  @LineID, @LineDescription, @Sign, @AccuLineID, @CaculatorID ,@FromAccountID, @ToAccountID, @FromCorAccountID,@ToCorAccountID, @AnaTypeID,@FromAnaID , @ToAnaID, @BudgetID
			WHILE @@Fetch_Status = 0  
			BEGIN
				SET @Cur_ChildLevelID2 = Cursor Scroll KeySet FOR
				SELECT   AT7621.LineID, AT7621.Sign, AT7621.AccuLineID, ISNULL(Amount00,0),  
				  ISNULL(Amount01,0), ISNULL(Amount02,0), ISNULL(Amount03,0), ISNULL(Amount04,0), ISNULL(Amount05,0),   
				  ISNULL(Amount06,0), ISNULL(Amount07,0), ISNULL(Amount08,0), ISNULL(Amount09,0), ISNULL(Amount10,0),   
				  ISNULL(Amount11,0), ISNULL(Amount12,0), ISNULL(Amount13,0), ISNULL(Amount14,0), ISNULL(Amount15,0),   
				  ISNULL(Amount16,0), ISNULL(Amount17,0), ISNULL(Amount18,0), ISNULL(Amount19,0), ISNULL(Amount20,0),   
				  ISNULL(Amount21,0), ISNULL(Amount22,0), ISNULL(Amount23,0), ISNULL(Amount24,0),   
				  ISNULL(Amount01A,0), ISNULL(Amount02A,0), ISNULL(Amount03A,0), ISNULL(Amount04A,0), ISNULL(Amount05A,0),   
				  ISNULL(Amount06A,0), ISNULL(Amount07A,0), ISNULL(Amount08A,0), ISNULL(Amount09A,0), ISNULL(Amount10A,0),   
				  ISNULL(Amount11A,0), ISNULL(Amount12A,0), ISNULL(Amount13A,0), ISNULL(Amount14A,0), ISNULL(Amount15A,0),   
				  ISNULL(Amount16A,0), ISNULL(Amount17A,0), ISNULL(Amount18A,0), ISNULL(Amount19A,0), ISNULL(Amount20A,0),   
				  ISNULL(Amount21A,0), ISNULL(Amount22A,0), ISNULL(Amount23A,0), ISNULL(Amount24A,0),   		  
				  ISNULL(Amount01LastPeriod,0), ISNULL(Amount02LastPeriod,0), ISNULL(Amount03LastPeriod,0), ISNULL(Amount04LastPeriod,0),   
				  ISNULL(Amount05LastPeriod,0), ISNULL(Amount06LastPeriod,0), ISNULL(Amount07LastPeriod,0), ISNULL(Amount08LastPeriod,0),   
				  ISNULL(Amount09LastPeriod,0), ISNULL(Amount10LastPeriod,0), ISNULL(Amount11LastPeriod,0), ISNULL(Amount12LastPeriod,0),   
				  ISNULL(Amount13LastPeriod,0), ISNULL(Amount14LastPeriod,0), ISNULL(Amount15LastPeriod,0), ISNULL(Amount16LastPeriod,0),   
				  ISNULL(Amount17LastPeriod,0), ISNULL(Amount18LastPeriod,0), ISNULL(Amount19LastPeriod,0), ISNULL(Amount20LastPeriod,0),   
				  ISNULL(Amount21LastPeriod,0), ISNULL(Amount22LastPeriod,0), ISNULL(Amount23LastPeriod,0), ISNULL(Amount24LastPeriod,0),
				  ISNULL(Amount01ALastPeriod,0), ISNULL(Amount02ALastPeriod,0), ISNULL(Amount03ALastPeriod,0), ISNULL(Amount04ALastPeriod,0),   
				  ISNULL(Amount05ALastPeriod,0), ISNULL(Amount06ALastPeriod,0), ISNULL(Amount07ALastPeriod,0), ISNULL(Amount08ALastPeriod,0),   
				  ISNULL(Amount09ALastPeriod,0), ISNULL(Amount10ALastPeriod,0), ISNULL(Amount11ALastPeriod,0), ISNULL(Amount12ALastPeriod,0),   
				  ISNULL(Amount13ALastPeriod,0), ISNULL(Amount14ALastPeriod,0), ISNULL(Amount15ALastPeriod,0), ISNULL(Amount16ALastPeriod,0),   
				  ISNULL(Amount17ALastPeriod,0), ISNULL(Amount18ALastPeriod,0), ISNULL(Amount19ALastPeriod,0), ISNULL(Amount20ALastPeriod,0),   
				  ISNULL(Amount21ALastPeriod,0), ISNULL(Amount22ALastPeriod,0), ISNULL(Amount23ALastPeriod,0), ISNULL(Amount24ALastPeriod,0)   
				FROM AT7621   
				INNER JOIN AT7622 on AT7622.LineID = AT7621.LineID AND AT7622.ReportCode = AT7621.ReportCode AND AT7622.DivisionID = AT7621.DivisionID  
				WHERE AT7621.DivisionID = @DivisionID AND AT7621.ReportCode =@ReportCode ---AND AT7621.LevelID >= @LevelID_Pre  
				  AND AT7621.AccuLineID in (SELECT LineID FROM AT7621 WHERE ReportCode =@ReportCode AND  LineID= @LineID AND DivisionID = @DivisionID)  
				Order by AT7622.LineID

				OPEN @Cur_ChildLevelID2  
				FETCH NEXT FROM @Cur_ChildLevelID2 INTO  @ChildLineID, @ChildSign, @ParLineID,@Amount00,  
						  @Amount01, @Amount02, @Amount03, @Amount04, @Amount05, @Amount06, @Amount07, @Amount08, @Amount09, @Amount10,  
						  @Amount11, @Amount12, @Amount13, @Amount14, @Amount15, @Amount16, @Amount17, @Amount18, @Amount19, @Amount20,  
						  @Amount21, @Amount22, @Amount23, @Amount24,
						  @Amount01A, @Amount02A, @Amount03A, @Amount04A, @Amount05A, @Amount06A, @Amount07A, @Amount08A, @Amount09A, @Amount10A,  
						  @Amount11A, @Amount12A, @Amount13A, @Amount14A, @Amount15A, @Amount16A, @Amount17A, @Amount18A, @Amount19A, @Amount20A,  
						  @Amount21A, @Amount22A, @Amount23A, @Amount24A, 			    
						  @Amount01LastPeriod, @Amount02LastPeriod, @Amount03LastPeriod, @Amount04LastPeriod,   
						  @Amount05LastPeriod, @Amount06LastPeriod, @Amount07LastPeriod, @Amount08LastPeriod,   
						  @Amount09LastPeriod, @Amount10LastPeriod, @Amount11LastPeriod, @Amount12LastPeriod,   
						  @Amount13LastPeriod, @Amount14LastPeriod, @Amount15LastPeriod, @Amount16LastPeriod,   
						  @Amount17LastPeriod, @Amount18LastPeriod, @Amount19LastPeriod, @Amount20LastPeriod,   
						  @Amount21LastPeriod, @Amount22LastPeriod, @Amount23LastPeriod, @Amount24LastPeriod,
						  @Amount01ALastPeriod, @Amount02ALastPeriod, @Amount03ALastPeriod, @Amount04ALastPeriod, 
						  @Amount05ALastPeriod, @Amount06ALastPeriod, @Amount07ALastPeriod, @Amount08ALastPeriod, 
						  @Amount09ALastPeriod, @Amount10ALastPeriod, @Amount11ALastPeriod, @Amount12ALastPeriod, 
						  @Amount13ALastPeriod, @Amount14ALastPeriod, @Amount15ALastPeriod, @Amount16ALastPeriod, 
						  @Amount17ALastPeriod, @Amount18ALastPeriod, @Amount19ALastPeriod, @Amount20ALastPeriod, 
						  @Amount21ALastPeriod, @Amount22ALastPeriod, @Amount23ALastPeriod, @Amount24ALastPeriod				    
				WHILE @@Fetch_Status = 0  
				BEGIN
					--PRINT '@LineCode:' + @LineCode
					--PRINT '@ParLineID:' + @ParLineID
					--PRINT '@ChildSign:' + @ChildSign
					IF @ChildSign =  '+'   
						Update AT7622  SET   
						Amount00 = ISNULL(Amount00,0)+ @Amount00, 
						Amount01 = ISNULL(Amount01,0)+ @Amount01,   
						Amount02 = ISNULL(Amount02,0)+ @Amount02,  
						Amount03 = ISNULL(Amount03,0)+ @Amount03,  
						Amount04 = ISNULL(Amount04,0)+ @Amount04,  
						Amount05 = ISNULL(Amount05,0)+ @Amount05,  
						Amount06 = ISNULL(Amount06,0)+ @Amount06,  
						Amount07 = ISNULL(Amount07,0)+ @Amount07,  
						Amount08 = ISNULL(Amount08,0)+ @Amount08,  
						Amount09 = ISNULL(Amount09,0)+ @Amount09,  
						Amount10 = ISNULL(Amount10,0)+ @Amount10,  
						Amount11 = ISNULL(Amount11,0)+ @Amount11,  
						Amount12 = ISNULL(Amount12,0)+ @Amount12,  
						Amount13 = ISNULL(Amount13,0)+ @Amount13,  
						Amount14 = ISNULL(Amount14,0)+ @Amount14,  
						Amount15 = ISNULL(Amount15,0)+ @Amount15,  
						Amount16 = ISNULL(Amount16,0)+ @Amount16,  
						Amount17 = ISNULL(Amount17,0)+ @Amount17,  
						Amount18 = ISNULL(Amount18,0)+ @Amount18,  
						Amount19 = ISNULL(Amount19,0)+ @Amount19,  
						Amount20 = ISNULL(Amount20,0)+ @Amount20,  
						Amount21 = ISNULL(Amount21,0)+ @Amount21,  
						Amount22 = ISNULL(Amount22,0)+ @Amount22,  
						Amount23 = ISNULL(Amount23,0)+ @Amount23,  
						Amount24 = ISNULL(Amount24,0)+ @Amount24,  
						Amount01A = ISNULL(Amount01A,0)+ @Amount01A, 
						Amount02A = ISNULL(Amount02A,0)+ @Amount02A, 
						Amount03A = ISNULL(Amount03A,0)+ @Amount03A, 
						Amount04A = ISNULL(Amount04A,0)+ @Amount04A, 
						Amount05A = ISNULL(Amount05A,0)+ @Amount05A, 
						Amount06A = ISNULL(Amount06A,0)+ @Amount06A, 
						Amount07A = ISNULL(Amount07A,0)+ @Amount07A, 
						Amount08A = ISNULL(Amount08A,0)+ @Amount08A, 
						Amount09A = ISNULL(Amount09A,0)+ @Amount09A, 
						Amount10A = ISNULL(Amount10A,0)+ @Amount10A, 
						Amount11A = ISNULL(Amount11A,0)+ @Amount11A, 
						Amount12A = ISNULL(Amount12A,0)+ @Amount12A, 
						Amount13A = ISNULL(Amount13A,0)+ @Amount13A, 
						Amount14A = ISNULL(Amount14A,0)+ @Amount14A, 
						Amount15A = ISNULL(Amount15A,0)+ @Amount15A, 
						Amount16A = ISNULL(Amount16A,0)+ @Amount16A, 
						Amount17A = ISNULL(Amount17A,0)+ @Amount17A, 
						Amount18A = ISNULL(Amount18A,0)+ @Amount18A, 
						Amount19A = ISNULL(Amount19A,0)+ @Amount19A, 
						Amount20A = ISNULL(Amount20A,0)+ @Amount20A, 
						Amount21A = ISNULL(Amount21A,0)+ @Amount21A, 
						Amount22A = ISNULL(Amount22A,0)+ @Amount22A, 
						Amount23A = ISNULL(Amount23A,0)+ @Amount23A, 
						Amount24A = ISNULL(Amount24A,0)+ @Amount24A, 			
						Amount01LastPeriod = ISNULL(Amount01LastPeriod,0)+ @Amount01LastPeriod,   
						Amount02LastPeriod = ISNULL(Amount02LastPeriod,0)+ @Amount02LastPeriod,  
						Amount03LastPeriod = ISNULL(Amount03LastPeriod,0)+ @Amount03LastPeriod,  
						Amount04LastPeriod = ISNULL(Amount04LastPeriod,0)+ @Amount04LastPeriod,  
						Amount05LastPeriod = ISNULL(Amount05LastPeriod,0)+ @Amount05LastPeriod,  
						Amount06LastPeriod = ISNULL(Amount06LastPeriod,0)+ @Amount06LastPeriod,  
						Amount07LastPeriod = ISNULL(Amount07LastPeriod,0)+ @Amount07LastPeriod,  
						Amount08LastPeriod = ISNULL(Amount08LastPeriod,0)+ @Amount08LastPeriod,  
						Amount09LastPeriod = ISNULL(Amount09LastPeriod,0)+ @Amount09LastPeriod,  
						Amount10LastPeriod = ISNULL(Amount10LastPeriod,0)+ @Amount10LastPeriod,  
						Amount11LastPeriod = ISNULL(Amount11LastPeriod,0)+ @Amount11LastPeriod,  
						Amount12LastPeriod = ISNULL(Amount12LastPeriod,0)+ @Amount12LastPeriod,  
						Amount13LastPeriod = ISNULL(Amount13LastPeriod,0)+ @Amount13LastPeriod,  
						Amount14LastPeriod = ISNULL(Amount14LastPeriod,0)+ @Amount14LastPeriod,  
						Amount15LastPeriod = ISNULL(Amount15LastPeriod,0)+ @Amount15LastPeriod,  
						Amount16LastPeriod = ISNULL(Amount16LastPeriod,0)+ @Amount16LastPeriod,  
						Amount17LastPeriod = ISNULL(Amount17LastPeriod,0)+ @Amount17LastPeriod,  
						Amount18LastPeriod = ISNULL(Amount18LastPeriod,0)+ @Amount18LastPeriod,  
						Amount19LastPeriod = ISNULL(Amount19LastPeriod,0)+ @Amount19LastPeriod,  
						Amount20LastPeriod = ISNULL(Amount20LastPeriod,0)+ @Amount20LastPeriod,  
						Amount21LastPeriod = ISNULL(Amount21LastPeriod,0)+ @Amount21LastPeriod,  
						Amount22LastPeriod = ISNULL(Amount22LastPeriod,0)+ @Amount22LastPeriod,  
						Amount23LastPeriod = ISNULL(Amount23LastPeriod,0)+ @Amount23LastPeriod,  
						Amount24LastPeriod = ISNULL(Amount24LastPeriod,0)+ @Amount24LastPeriod,
						Amount01ALastPeriod = ISNULL(Amount01ALastPeriod,0)+ @Amount01ALastPeriod,   
						Amount02ALastPeriod = ISNULL(Amount02ALastPeriod,0)+ @Amount02ALastPeriod,  
						Amount03ALastPeriod = ISNULL(Amount03ALastPeriod,0)+ @Amount03ALastPeriod,  
						Amount04ALastPeriod = ISNULL(Amount04ALastPeriod,0)+ @Amount04ALastPeriod,  
						Amount05ALastPeriod = ISNULL(Amount05ALastPeriod,0)+ @Amount05ALastPeriod,  
						Amount06ALastPeriod = ISNULL(Amount06ALastPeriod,0)+ @Amount06ALastPeriod,  
						Amount07ALastPeriod = ISNULL(Amount07ALastPeriod,0)+ @Amount07ALastPeriod,  
						Amount08ALastPeriod = ISNULL(Amount08ALastPeriod,0)+ @Amount08ALastPeriod,  
						Amount09ALastPeriod = ISNULL(Amount09ALastPeriod,0)+ @Amount09ALastPeriod,  
						Amount10ALastPeriod = ISNULL(Amount10ALastPeriod,0)+ @Amount10ALastPeriod,  
						Amount11ALastPeriod = ISNULL(Amount11ALastPeriod,0)+ @Amount11ALastPeriod,  
						Amount12ALastPeriod = ISNULL(Amount12ALastPeriod,0)+ @Amount12ALastPeriod,  
						Amount13ALastPeriod = ISNULL(Amount13ALastPeriod,0)+ @Amount13ALastPeriod,  
						Amount14ALastPeriod = ISNULL(Amount14ALastPeriod,0)+ @Amount14ALastPeriod,  
						Amount15ALastPeriod = ISNULL(Amount15ALastPeriod,0)+ @Amount15ALastPeriod,  
						Amount16ALastPeriod = ISNULL(Amount16ALastPeriod,0)+ @Amount16ALastPeriod,  
						Amount17ALastPeriod = ISNULL(Amount17ALastPeriod,0)+ @Amount17ALastPeriod,  
						Amount18ALastPeriod = ISNULL(Amount18ALastPeriod,0)+ @Amount18ALastPeriod,  
						Amount19ALastPeriod = ISNULL(Amount19ALastPeriod,0)+ @Amount19ALastPeriod,  
						Amount20ALastPeriod = ISNULL(Amount20ALastPeriod,0)+ @Amount20ALastPeriod,  
						Amount21ALastPeriod = ISNULL(Amount21ALastPeriod,0)+ @Amount21ALastPeriod,  
						Amount22ALastPeriod = ISNULL(Amount22ALastPeriod,0)+ @Amount22ALastPeriod,  
						Amount23ALastPeriod = ISNULL(Amount23ALastPeriod,0)+ @Amount23ALastPeriod,  
						Amount24ALastPeriod = ISNULL(Amount24ALastPeriod,0)+ @Amount24ALastPeriod  			  
						WHERE LineID = @ParLineID AND ReportCode = @ReportCode AND DivisionID = @DivisionID  
					IF @ChildSign =  '-'   
						Update AT7622   set    
						Amount00 = ISNULL(Amount00,0)- @Amount00, 
						Amount01 = ISNULL(Amount01,0) - @Amount01,   
						Amount02 = ISNULL(Amount02,0)- @Amount02,  
						Amount03 = ISNULL(Amount03,0)- @Amount03,  
						Amount04 = ISNULL(Amount04,0)- @Amount04,  
						Amount05 = ISNULL(Amount05,0)- @Amount05,  
						Amount06 = ISNULL(Amount06,0)- @Amount06,  
						Amount07 = ISNULL(Amount07,0)- @Amount07,  
						Amount08 = ISNULL(Amount08,0)- @Amount08,  
						Amount09 = ISNULL(Amount09,0) - @Amount09,  
						Amount10 = ISNULL(Amount10,0) - @Amount10,  
						Amount11 = ISNULL(Amount11,0)- @Amount11,  
						Amount12 = ISNULL(Amount12,0)- @Amount12,  
						Amount13 = ISNULL(Amount13,0)- @Amount13,  
						Amount14 = ISNULL(Amount14,0)- @Amount14,  
						Amount15 = ISNULL(Amount15,0)- @Amount15,  
						Amount16 = ISNULL(Amount16,0)- @Amount16,  
						Amount17 = ISNULL(Amount17,0)- @Amount17,  
						Amount18 = ISNULL(Amount18,0)- @Amount18,  
						Amount19 = ISNULL(Amount19,0)- @Amount19,  
						Amount20 = ISNULL(Amount20,0)- @Amount20,  
						Amount21 = ISNULL(Amount21,0)- @Amount21,  
						Amount22 = ISNULL(Amount22,0)- @Amount22,  
						Amount23 = ISNULL(Amount23,0)- @Amount23,  
						Amount24 = ISNULL(Amount24,0)- @Amount24,  
						Amount01A = ISNULL(Amount01A,0)- @Amount01A,  
						Amount02A = ISNULL(Amount02A,0)- @Amount02A,  
						Amount03A = ISNULL(Amount03A,0)- @Amount03A,  
						Amount04A = ISNULL(Amount04A,0)- @Amount04A,  
						Amount05A = ISNULL(Amount05A,0)- @Amount05A,  
						Amount06A = ISNULL(Amount06A,0)- @Amount06A,  
						Amount07A = ISNULL(Amount07A,0)- @Amount07A,  
						Amount08A = ISNULL(Amount08A,0)- @Amount08A,  
						Amount09A = ISNULL(Amount09A,0)- @Amount09A,  
						Amount10A = ISNULL(Amount10A,0)- @Amount10A,  
						Amount11A = ISNULL(Amount11A,0)- @Amount11A,  
						Amount12A = ISNULL(Amount12A,0)- @Amount12A,  
						Amount13A = ISNULL(Amount13A,0)- @Amount13A,  
						Amount14A = ISNULL(Amount14A,0)- @Amount14A,  
						Amount15A = ISNULL(Amount15A,0)- @Amount15A,  
						Amount16A = ISNULL(Amount16A,0)- @Amount16A,  
						Amount17A = ISNULL(Amount17A,0)- @Amount17A,  
						Amount18A = ISNULL(Amount18A,0)- @Amount18A,  
						Amount19A = ISNULL(Amount19A,0)- @Amount19A,  
						Amount20A = ISNULL(Amount20A,0)- @Amount20A,  
						Amount21A = ISNULL(Amount21A,0)- @Amount21A,  
						Amount22A = ISNULL(Amount22A,0)- @Amount22A,  
						Amount23A = ISNULL(Amount23A,0)- @Amount23A,  
						Amount24A = ISNULL(Amount24A,0)- @Amount24A,  		
						Amount01LastPeriod = ISNULL(Amount01LastPeriod,0)- @Amount01LastPeriod,   
						Amount02LastPeriod = ISNULL(Amount02LastPeriod,0)- @Amount02LastPeriod,  
						Amount03LastPeriod = ISNULL(Amount03LastPeriod,0)- @Amount03LastPeriod,  
						Amount04LastPeriod = ISNULL(Amount04LastPeriod,0)- @Amount04LastPeriod,  
						Amount05LastPeriod = ISNULL(Amount05LastPeriod,0)- @Amount05LastPeriod,  
						Amount06LastPeriod = ISNULL(Amount06LastPeriod,0)- @Amount06LastPeriod,  
						Amount07LastPeriod = ISNULL(Amount07LastPeriod,0)- @Amount07LastPeriod,  
						Amount08LastPeriod = ISNULL(Amount08LastPeriod,0)- @Amount08LastPeriod,  
						Amount09LastPeriod = ISNULL(Amount09LastPeriod,0)- @Amount09LastPeriod,  
						Amount10LastPeriod = ISNULL(Amount10LastPeriod,0)- @Amount10LastPeriod,  
						Amount11LastPeriod = ISNULL(Amount11LastPeriod,0)- @Amount11LastPeriod,  
						Amount12LastPeriod = ISNULL(Amount12LastPeriod,0)- @Amount12LastPeriod,  
						Amount13LastPeriod = ISNULL(Amount13LastPeriod,0)- @Amount13LastPeriod,  
						Amount14LastPeriod = ISNULL(Amount14LastPeriod,0)- @Amount14LastPeriod,  
						Amount15LastPeriod = ISNULL(Amount15LastPeriod,0)- @Amount15LastPeriod,  
						Amount16LastPeriod = ISNULL(Amount16LastPeriod,0)- @Amount16LastPeriod,  
						Amount17LastPeriod = ISNULL(Amount17LastPeriod,0)- @Amount17LastPeriod,  
						Amount18LastPeriod = ISNULL(Amount18LastPeriod,0)- @Amount18LastPeriod,  
						Amount19LastPeriod = ISNULL(Amount19LastPeriod,0)- @Amount19LastPeriod,  
						Amount20LastPeriod = ISNULL(Amount20LastPeriod,0)- @Amount20LastPeriod,  
						Amount21LastPeriod = ISNULL(Amount21LastPeriod,0)- @Amount21LastPeriod,  
						Amount22LastPeriod = ISNULL(Amount22LastPeriod,0)- @Amount22LastPeriod,  
						Amount23LastPeriod = ISNULL(Amount23LastPeriod,0)- @Amount23LastPeriod,  
						Amount24LastPeriod = ISNULL(Amount24LastPeriod,0)- @Amount24LastPeriod,
						Amount01ALastPeriod = ISNULL(Amount01ALastPeriod,0)- @Amount01ALastPeriod,
						Amount02ALastPeriod = ISNULL(Amount02ALastPeriod,0)- @Amount02ALastPeriod,
						Amount03ALastPeriod = ISNULL(Amount03ALastPeriod,0)- @Amount03ALastPeriod,
						Amount04ALastPeriod = ISNULL(Amount04ALastPeriod,0)- @Amount04ALastPeriod,
						Amount05ALastPeriod = ISNULL(Amount05ALastPeriod,0)- @Amount05ALastPeriod,
						Amount06ALastPeriod = ISNULL(Amount06ALastPeriod,0)- @Amount06ALastPeriod,
						Amount07ALastPeriod = ISNULL(Amount07ALastPeriod,0)- @Amount07ALastPeriod,
						Amount08ALastPeriod = ISNULL(Amount08ALastPeriod,0)- @Amount08ALastPeriod,
						Amount09ALastPeriod = ISNULL(Amount09ALastPeriod,0)- @Amount09ALastPeriod,
						Amount10ALastPeriod = ISNULL(Amount10ALastPeriod,0)- @Amount10ALastPeriod,
						Amount11ALastPeriod = ISNULL(Amount11ALastPeriod,0)- @Amount11ALastPeriod,
						Amount12ALastPeriod = ISNULL(Amount12ALastPeriod,0)- @Amount12ALastPeriod,
						Amount13ALastPeriod = ISNULL(Amount13ALastPeriod,0)- @Amount13ALastPeriod,
						Amount14ALastPeriod = ISNULL(Amount14ALastPeriod,0)- @Amount14ALastPeriod,
						Amount15ALastPeriod = ISNULL(Amount15ALastPeriod,0)- @Amount15ALastPeriod,
						Amount16ALastPeriod = ISNULL(Amount16ALastPeriod,0)- @Amount16ALastPeriod,
						Amount17ALastPeriod = ISNULL(Amount17ALastPeriod,0)- @Amount17ALastPeriod,
						Amount18ALastPeriod = ISNULL(Amount18ALastPeriod,0)- @Amount18ALastPeriod,
						Amount19ALastPeriod = ISNULL(Amount19ALastPeriod,0)- @Amount19ALastPeriod,
						Amount20ALastPeriod = ISNULL(Amount20ALastPeriod,0)- @Amount20ALastPeriod,
						Amount21ALastPeriod = ISNULL(Amount21ALastPeriod,0)- @Amount21ALastPeriod,
						Amount22ALastPeriod = ISNULL(Amount22ALastPeriod,0)- @Amount22ALastPeriod,
						Amount23ALastPeriod = ISNULL(Amount23ALastPeriod,0)- @Amount23ALastPeriod,
						Amount24ALastPeriod = ISNULL(Amount24ALastPeriod,0)- @Amount24ALastPeriod 			  
						WHERE LineID = @ParLineID AND ReportCode = @ReportCode AND DivisionID = @DivisionID  
					IF @ChildSign =  '*'   
						Update AT7622   set    
						Amount00 = (Case when  ISNULL(Amount00,0) =0 then 1 else  Amount00 END) * @Amount00, 
						Amount01 = (Case when  ISNULL(Amount01,0) =0 then 1 else  Amount01 END) * @Amount01,   
						Amount02 = (Case when  ISNULL(Amount02,0) =0 then 1 else  Amount02 END) * @Amount02,  
						Amount03 = (Case when  ISNULL(Amount03,0) =0 then 1 else  Amount03 END) * @Amount03,  
						Amount04 = (Case when  ISNULL(Amount04,0) =0 then 1 else  Amount04 END) * @Amount04,  
						Amount05 = (Case when  ISNULL(Amount05,0) =0 then 1 else  Amount05 END) * @Amount05,  
						Amount06 = (Case when  ISNULL(Amount06,0) =0 then 1 else  Amount06 END) * @Amount06,  
						Amount07 = (Case when  ISNULL(Amount07,0) =0 then 1 else  Amount07 END) * @Amount07,  
						Amount08 = (Case when  ISNULL(Amount08,0) =0 then 1 else  Amount08 END) * @Amount08,  
						Amount09 = (Case when  ISNULL(Amount09,0) =0 then 1 else  Amount09 END) * @Amount09,  
						Amount10 = (Case when  ISNULL(Amount10,0) =0 then 1 else  Amount10 END) * @Amount10,  
						Amount11 = (Case when  ISNULL(Amount11,0) =0 then 1 else  Amount11 END) * @Amount11,  
						Amount12 = (Case when  ISNULL(Amount12,0) =0 then 1 else  Amount12 END) * @Amount12,  
						Amount13 = (Case when  ISNULL(Amount13,0) =0 then 1 else  Amount13 END) * @Amount13,  
						Amount14 = (Case when  ISNULL(Amount14,0) =0 then 1 else  Amount14 END) * @Amount14,  
						Amount15 = (Case when  ISNULL(Amount15,0) =0 then 1 else  Amount15 END) * @Amount15,  
						Amount16 = (Case when  ISNULL(Amount16,0) =0 then 1 else  Amount16 END) * @Amount16,  
						Amount17 = (Case when  ISNULL(Amount17,0) =0 then 1 else  Amount17 END) * @Amount17,  
						Amount18 = (Case when  ISNULL(Amount18,0) =0 then 1 else  Amount18 END) * @Amount18,  
						Amount19 = (Case when  ISNULL(Amount19,0) =0 then 1 else  Amount19 END) * @Amount19,  
						Amount20 = (Case when  ISNULL(Amount20,0) =0 then 1 else  Amount20 END) * @Amount20,  
						Amount21 = (Case when  ISNULL(Amount21,0) =0 then 1 else  Amount21 END) * @Amount21,  
						Amount22 = (Case when  ISNULL(Amount22,0) =0 then 1 else  Amount22 END) * @Amount22,  
						Amount23 = (Case when  ISNULL(Amount23,0) =0 then 1 else  Amount23 END) * @Amount23,  
						Amount24 = (Case when  ISNULL(Amount24,0) =0 then 1 else  Amount24 END) * @Amount24, 
						Amount01A = (Case when  ISNULL(Amount01A,0) =0 then 1 else  Amount01A END) * @Amount01A, 
						Amount02A = (Case when  ISNULL(Amount02A,0) =0 then 1 else  Amount02A END) * @Amount02A, 
						Amount03A = (Case when  ISNULL(Amount03A,0) =0 then 1 else  Amount03A END) * @Amount03A, 
						Amount04A = (Case when  ISNULL(Amount04A,0) =0 then 1 else  Amount04A END) * @Amount04A, 
						Amount05A = (Case when  ISNULL(Amount05A,0) =0 then 1 else  Amount05A END) * @Amount05A, 
						Amount06A = (Case when  ISNULL(Amount06A,0) =0 then 1 else  Amount06A END) * @Amount06A, 
						Amount07A = (Case when  ISNULL(Amount07A,0) =0 then 1 else  Amount07A END) * @Amount07A, 
						Amount08A = (Case when  ISNULL(Amount08A,0) =0 then 1 else  Amount08A END) * @Amount08A, 
						Amount09A = (Case when  ISNULL(Amount09A,0) =0 then 1 else  Amount09A END) * @Amount09A, 
						Amount10A = (Case when  ISNULL(Amount10A,0) =0 then 1 else  Amount10A END) * @Amount10A, 
						Amount11A = (Case when  ISNULL(Amount11A,0) =0 then 1 else  Amount11A END) * @Amount11A, 
						Amount12A = (Case when  ISNULL(Amount12A,0) =0 then 1 else  Amount12A END) * @Amount12A, 
						Amount13A = (Case when  ISNULL(Amount13A,0) =0 then 1 else  Amount13A END) * @Amount13A, 
						Amount14A = (Case when  ISNULL(Amount14A,0) =0 then 1 else  Amount14A END) * @Amount14A, 
						Amount15A = (Case when  ISNULL(Amount15A,0) =0 then 1 else  Amount15A END) * @Amount15A, 
						Amount16A = (Case when  ISNULL(Amount16A,0) =0 then 1 else  Amount16A END) * @Amount16A, 
						Amount17A = (Case when  ISNULL(Amount17A,0) =0 then 1 else  Amount17A END) * @Amount17A, 
						Amount18A = (Case when  ISNULL(Amount18A,0) =0 then 1 else  Amount18A END) * @Amount18A, 
						Amount19A = (Case when  ISNULL(Amount19A,0) =0 then 1 else  Amount19A END) * @Amount19A, 
						Amount20A = (Case when  ISNULL(Amount20A,0) =0 then 1 else  Amount20A END) * @Amount20A, 
						Amount21A = (Case when  ISNULL(Amount21A,0) =0 then 1 else  Amount21A END) * @Amount21A, 
						Amount22A = (Case when  ISNULL(Amount22A,0) =0 then 1 else  Amount22A END) * @Amount22A, 
						Amount23A = (Case when  ISNULL(Amount23A,0) =0 then 1 else  Amount23A END) * @Amount23A, 
						Amount24A = (Case when  ISNULL(Amount24A,0) =0 then 1 else  Amount24A END) * @Amount24A, 			 
						Amount01LastPeriod = (Case when  ISNULL(Amount01LastPeriod,0) =0 then 1 else  Amount01LastPeriod END) * @Amount01LastPeriod,   
						Amount02LastPeriod = (Case when  ISNULL(Amount02LastPeriod,0) =0 then 1 else  Amount02LastPeriod END) * @Amount02LastPeriod,  
						Amount03LastPeriod = (Case when  ISNULL(Amount03LastPeriod,0) =0 then 1 else  Amount03LastPeriod END) * @Amount03LastPeriod,  
						Amount04LastPeriod = (Case when  ISNULL(Amount04LastPeriod,0) =0 then 1 else  Amount04LastPeriod END) * @Amount04LastPeriod,  
						Amount05LastPeriod = (Case when  ISNULL(Amount05LastPeriod,0) =0 then 1 else  Amount05LastPeriod END) * @Amount05LastPeriod,  
						Amount06LastPeriod = (Case when  ISNULL(Amount06LastPeriod,0) =0 then 1 else  Amount06LastPeriod END) * @Amount06LastPeriod,  
						Amount07LastPeriod = (Case when  ISNULL(Amount07LastPeriod,0) =0 then 1 else  Amount07LastPeriod END) * @Amount07LastPeriod,  
						Amount08LastPeriod = (Case when  ISNULL(Amount08LastPeriod,0) =0 then 1 else  Amount08LastPeriod END) * @Amount08LastPeriod,  
						Amount09LastPeriod = (Case when  ISNULL(Amount09LastPeriod,0) =0 then 1 else  Amount09LastPeriod END) * @Amount09LastPeriod,  
						Amount10LastPeriod = (Case when  ISNULL(Amount10LastPeriod,0) =0 then 1 else  Amount10LastPeriod END) * @Amount10LastPeriod,  
						Amount11LastPeriod = (Case when  ISNULL(Amount11LastPeriod,0) =0 then 1 else  Amount11LastPeriod END) * @Amount11LastPeriod,  
						Amount12LastPeriod = (Case when  ISNULL(Amount12LastPeriod,0) =0 then 1 else  Amount12LastPeriod END) * @Amount12LastPeriod,  
						Amount13LastPeriod = (Case when  ISNULL(Amount13LastPeriod,0) =0 then 1 else  Amount13LastPeriod END) * @Amount13LastPeriod,  
						Amount14LastPeriod = (Case when  ISNULL(Amount14LastPeriod,0) =0 then 1 else  Amount14LastPeriod END) * @Amount14LastPeriod,  
						Amount15LastPeriod = (Case when  ISNULL(Amount15LastPeriod,0) =0 then 1 else  Amount15LastPeriod END) * @Amount15LastPeriod,  
						Amount16LastPeriod = (Case when  ISNULL(Amount16LastPeriod,0) =0 then 1 else  Amount16LastPeriod END) * @Amount16LastPeriod,  
						Amount17LastPeriod = (Case when  ISNULL(Amount17LastPeriod,0) =0 then 1 else  Amount17LastPeriod END) * @Amount17LastPeriod,  
						Amount18LastPeriod = (Case when  ISNULL(Amount18LastPeriod,0) =0 then 1 else  Amount18LastPeriod END) * @Amount18LastPeriod,  
						Amount19LastPeriod = (Case when  ISNULL(Amount19LastPeriod,0) =0 then 1 else  Amount19LastPeriod END) * @Amount19LastPeriod,  
						Amount20LastPeriod = (Case when  ISNULL(Amount20LastPeriod,0) =0 then 1 else  Amount20LastPeriod END) * @Amount20LastPeriod,  
						Amount21LastPeriod = (Case when  ISNULL(Amount21LastPeriod,0) =0 then 1 else  Amount21LastPeriod END) * @Amount21LastPeriod,  
						Amount22LastPeriod = (Case when  ISNULL(Amount22LastPeriod,0) =0 then 1 else  Amount22LastPeriod END) * @Amount22LastPeriod,  
						Amount23LastPeriod = (Case when  ISNULL(Amount23LastPeriod,0) =0 then 1 else  Amount23LastPeriod END) * @Amount23LastPeriod,  
						Amount24LastPeriod = (Case when  ISNULL(Amount24LastPeriod,0) =0 then 1 else  Amount24LastPeriod END) * @Amount24LastPeriod,
						Amount01ALastPeriod = (Case when  ISNULL(Amount01ALastPeriod,0) =0 then 1 else  Amount01ALastPeriod END) * @Amount01ALastPeriod,  
						Amount02ALastPeriod = (Case when  ISNULL(Amount02ALastPeriod,0) =0 then 1 else  Amount02ALastPeriod END) * @Amount02ALastPeriod,  
						Amount03ALastPeriod = (Case when  ISNULL(Amount03ALastPeriod,0) =0 then 1 else  Amount03ALastPeriod END) * @Amount03ALastPeriod,  
						Amount04ALastPeriod = (Case when  ISNULL(Amount04ALastPeriod,0) =0 then 1 else  Amount04ALastPeriod END) * @Amount04ALastPeriod,  
						Amount05ALastPeriod = (Case when  ISNULL(Amount05ALastPeriod,0) =0 then 1 else  Amount05ALastPeriod END) * @Amount05ALastPeriod,  
						Amount06ALastPeriod = (Case when  ISNULL(Amount06ALastPeriod,0) =0 then 1 else  Amount06ALastPeriod END) * @Amount06ALastPeriod,  
						Amount07ALastPeriod = (Case when  ISNULL(Amount07ALastPeriod,0) =0 then 1 else  Amount07ALastPeriod END) * @Amount07ALastPeriod,  
						Amount08ALastPeriod = (Case when  ISNULL(Amount08ALastPeriod,0) =0 then 1 else  Amount08ALastPeriod END) * @Amount08ALastPeriod,  
						Amount09ALastPeriod = (Case when  ISNULL(Amount09ALastPeriod,0) =0 then 1 else  Amount09ALastPeriod END) * @Amount09ALastPeriod,  
						Amount10ALastPeriod = (Case when  ISNULL(Amount10ALastPeriod,0) =0 then 1 else  Amount10ALastPeriod END) * @Amount10ALastPeriod,  
						Amount11ALastPeriod = (Case when  ISNULL(Amount11ALastPeriod,0) =0 then 1 else  Amount11ALastPeriod END) * @Amount11ALastPeriod,  
						Amount12ALastPeriod = (Case when  ISNULL(Amount12ALastPeriod,0) =0 then 1 else  Amount12ALastPeriod END) * @Amount12ALastPeriod,  
						Amount13ALastPeriod = (Case when  ISNULL(Amount13ALastPeriod,0) =0 then 1 else  Amount13ALastPeriod END) * @Amount13ALastPeriod,  
						Amount14ALastPeriod = (Case when  ISNULL(Amount14ALastPeriod,0) =0 then 1 else  Amount14ALastPeriod END) * @Amount14ALastPeriod,  
						Amount15ALastPeriod = (Case when  ISNULL(Amount15ALastPeriod,0) =0 then 1 else  Amount15ALastPeriod END) * @Amount15ALastPeriod,  
						Amount16ALastPeriod = (Case when  ISNULL(Amount16ALastPeriod,0) =0 then 1 else  Amount16ALastPeriod END) * @Amount16ALastPeriod,  
						Amount17ALastPeriod = (Case when  ISNULL(Amount17ALastPeriod,0) =0 then 1 else  Amount17ALastPeriod END) * @Amount17ALastPeriod,  
						Amount18ALastPeriod = (Case when  ISNULL(Amount18ALastPeriod,0) =0 then 1 else  Amount18ALastPeriod END) * @Amount18ALastPeriod,  
						Amount19ALastPeriod = (Case when  ISNULL(Amount19ALastPeriod,0) =0 then 1 else  Amount19ALastPeriod END) * @Amount19ALastPeriod,  
						Amount20ALastPeriod = (Case when  ISNULL(Amount20ALastPeriod,0) =0 then 1 else  Amount20ALastPeriod END) * @Amount20ALastPeriod,  
						Amount21ALastPeriod = (Case when  ISNULL(Amount21ALastPeriod,0) =0 then 1 else  Amount21ALastPeriod END) * @Amount21ALastPeriod,  
						Amount22ALastPeriod = (Case when  ISNULL(Amount22ALastPeriod,0) =0 then 1 else  Amount22ALastPeriod END) * @Amount22ALastPeriod,  
						Amount23ALastPeriod = (Case when  ISNULL(Amount23ALastPeriod,0) =0 then 1 else  Amount23ALastPeriod END) * @Amount23ALastPeriod,  
						Amount24ALastPeriod = (Case when  ISNULL(Amount24ALastPeriod,0) =0 then 1 else  Amount24ALastPeriod END) * @Amount24ALastPeriod  			  
						WHERE LineID = @ParLineID AND ReportCode = @ReportCode AND DivisionID = @DivisionID  
					IF @ChildSign =  '/'   
						Update AT7622  set  
						Amount00 = Case When ISNULL(@Amount00,0) <> 0 Then ISNULL(Amount00,0) / @Amount00 Else 0 END,   
						Amount01 = Case When ISNULL(@Amount01,0) <> 0 Then ISNULL(Amount01,0) / @Amount01 Else 0 END,         
						Amount02 = Case When ISNULL(@Amount02,0) <> 0 Then ISNULL(Amount02,0) / @Amount02 Else 0 END,         
						Amount03 = Case When ISNULL(@Amount03,0) <> 0 Then ISNULL(Amount03,0) / @Amount03 Else 0 END,  
						Amount04 = Case When ISNULL(@Amount04,0) <> 0 Then ISNULL(Amount04,0) / @Amount04 Else 0 END,  
						Amount05 = Case When ISNULL(@Amount05,0) <> 0 Then ISNULL(Amount05,0) / @Amount05 Else 0 END,  
						Amount06 = Case When ISNULL(@Amount06,0) <> 0 Then ISNULL(Amount06,0) / @Amount06 Else 0 END,  
						Amount07 = Case When ISNULL(@Amount07,0) <> 0 Then ISNULL(Amount07,0) / @Amount07 Else 0 END,  
						Amount08 = Case When ISNULL(@Amount08,0) <> 0 Then ISNULL(Amount08,0) / @Amount08 Else 0 END,  
						Amount09 = Case When ISNULL(@Amount09,0) <> 0 Then ISNULL(Amount09,0) / @Amount09 Else 0 END,  
						Amount10 = Case When ISNULL(@Amount10,0) <> 0 Then ISNULL(Amount10,0) / @Amount10 Else 0 END,  
						Amount11 = Case When ISNULL(@Amount11,0) <> 0 Then ISNULL(Amount11,0) / @Amount11 Else 0 END,  
						Amount12 = Case When ISNULL(@Amount12,0) <> 0 Then ISNULL(Amount12,0) / @Amount12 Else 0 END,  
						Amount13 = Case When ISNULL(@Amount13,0) <> 0 Then ISNULL(Amount13,0) / @Amount13 Else 0 END,  
						Amount14 = Case When ISNULL(@Amount14,0) <> 0 Then ISNULL(Amount14,0) / @Amount14 Else 0 END,  
						Amount15 = Case When ISNULL(@Amount15,0) <> 0 Then ISNULL(Amount15,0) / @Amount15 Else 0 END,  
						Amount16 = Case When ISNULL(@Amount16,0) <> 0 Then ISNULL(Amount16,0) / @Amount16 Else 0 END,  
						Amount17 = Case When ISNULL(@Amount17,0) <> 0 Then ISNULL(Amount17,0) / @Amount17 Else 0 END,  
						Amount18 = Case When ISNULL(@Amount18,0) <> 0 Then ISNULL(Amount18,0) / @Amount18 Else 0 END,  
						Amount19 = Case When ISNULL(@Amount19,0) <> 0 Then ISNULL(Amount19,0) / @Amount19 Else 0 END,  
						Amount20 = Case When ISNULL(@Amount20,0) <> 0 Then ISNULL(Amount20,0) / @Amount20 Else 0 END,  
						Amount21 = Case When ISNULL(@Amount21,0) <> 0 Then ISNULL(Amount21,0) / @Amount21 Else 0 END,  
						Amount22 = Case When ISNULL(@Amount22,0) <> 0 Then ISNULL(Amount22,0) / @Amount22 Else 0 END,  
						Amount23 = Case When ISNULL(@Amount23,0) <> 0 Then ISNULL(Amount23,0) / @Amount23 Else 0 END,  
						Amount24 = Case When ISNULL(@Amount24,0) <> 0 Then ISNULL(Amount24,0) / @Amount24 Else 0 END, 
						Amount01A = Case When ISNULL(@Amount01A,0) <> 0 Then ISNULL(Amount01A,0) / @Amount01A Else 0 END, 
						Amount02A = Case When ISNULL(@Amount02A,0) <> 0 Then ISNULL(Amount02A,0) / @Amount02A Else 0 END, 
						Amount03A = Case When ISNULL(@Amount03A,0) <> 0 Then ISNULL(Amount03A,0) / @Amount03A Else 0 END, 
						Amount04A = Case When ISNULL(@Amount04A,0) <> 0 Then ISNULL(Amount04A,0) / @Amount04A Else 0 END, 
						Amount05A = Case When ISNULL(@Amount05A,0) <> 0 Then ISNULL(Amount05A,0) / @Amount05A Else 0 END, 
						Amount06A = Case When ISNULL(@Amount06A,0) <> 0 Then ISNULL(Amount06A,0) / @Amount06A Else 0 END, 
						Amount07A = Case When ISNULL(@Amount07A,0) <> 0 Then ISNULL(Amount07A,0) / @Amount07A Else 0 END, 
						Amount08A = Case When ISNULL(@Amount08A,0) <> 0 Then ISNULL(Amount08A,0) / @Amount08A Else 0 END, 
						Amount09A = Case When ISNULL(@Amount09A,0) <> 0 Then ISNULL(Amount09A,0) / @Amount09A Else 0 END, 
						Amount10A = Case When ISNULL(@Amount10A,0) <> 0 Then ISNULL(Amount10A,0) / @Amount10A Else 0 END, 
						Amount11A = Case When ISNULL(@Amount11A,0) <> 0 Then ISNULL(Amount11A,0) / @Amount11A Else 0 END, 
						Amount12A = Case When ISNULL(@Amount12A,0) <> 0 Then ISNULL(Amount12A,0) / @Amount12A Else 0 END, 
						Amount13A = Case When ISNULL(@Amount13A,0) <> 0 Then ISNULL(Amount13A,0) / @Amount13A Else 0 END, 
						Amount14A = Case When ISNULL(@Amount14A,0) <> 0 Then ISNULL(Amount14A,0) / @Amount14A Else 0 END, 
						Amount15A = Case When ISNULL(@Amount15A,0) <> 0 Then ISNULL(Amount15A,0) / @Amount15A Else 0 END, 
						Amount16A = Case When ISNULL(@Amount16A,0) <> 0 Then ISNULL(Amount16A,0) / @Amount16A Else 0 END, 
						Amount17A = Case When ISNULL(@Amount17A,0) <> 0 Then ISNULL(Amount17A,0) / @Amount17A Else 0 END, 
						Amount18A = Case When ISNULL(@Amount18A,0) <> 0 Then ISNULL(Amount18A,0) / @Amount18A Else 0 END, 
						Amount19A = Case When ISNULL(@Amount19A,0) <> 0 Then ISNULL(Amount19A,0) / @Amount19A Else 0 END, 
						Amount20A = Case When ISNULL(@Amount20A,0) <> 0 Then ISNULL(Amount20A,0) / @Amount20A Else 0 END, 
						Amount21A = Case When ISNULL(@Amount21A,0) <> 0 Then ISNULL(Amount21A,0) / @Amount21A Else 0 END, 
						Amount22A = Case When ISNULL(@Amount22A,0) <> 0 Then ISNULL(Amount22A,0) / @Amount22A Else 0 END, 
						Amount23A = Case When ISNULL(@Amount23A,0) <> 0 Then ISNULL(Amount23A,0) / @Amount23A Else 0 END, 
						Amount24A = Case When ISNULL(@Amount24A,0) <> 0 Then ISNULL(Amount24A,0) / @Amount24A Else 0 END,			 
						Amount01LastPeriod = Case When ISNULL(@Amount01LastPeriod,0) <> 0 Then ISNULL(Amount01LastPeriod,0) / @Amount01LastPeriod Else 0 END,         
						Amount02LastPeriod = Case When ISNULL(@Amount02LastPeriod,0) <> 0 Then ISNULL(Amount02LastPeriod,0) / @Amount02LastPeriod Else 0 END,         
						Amount03LastPeriod = Case When ISNULL(@Amount03LastPeriod,0) <> 0 Then ISNULL(Amount03LastPeriod,0) / @Amount03LastPeriod Else 0 END,  
						Amount04LastPeriod = Case When ISNULL(@Amount04LastPeriod,0) <> 0 Then ISNULL(Amount04LastPeriod,0) / @Amount04LastPeriod Else 0 END,  
						Amount05LastPeriod = Case When ISNULL(@Amount05LastPeriod,0) <> 0 Then ISNULL(Amount05LastPeriod,0) / @Amount05LastPeriod Else 0 END,  
						Amount06LastPeriod = Case When ISNULL(@Amount06LastPeriod,0) <> 0 Then ISNULL(Amount06LastPeriod,0) / @Amount06LastPeriod Else 0 END,  
						Amount07LastPeriod = Case When ISNULL(@Amount07LastPeriod,0) <> 0 Then ISNULL(Amount07LastPeriod,0) / @Amount07LastPeriod Else 0 END,  
						Amount08LastPeriod = Case When ISNULL(@Amount08LastPeriod,0) <> 0 Then ISNULL(Amount08LastPeriod,0) / @Amount08LastPeriod Else 0 END,  
						Amount09LastPeriod = Case When ISNULL(@Amount09LastPeriod,0) <> 0 Then ISNULL(Amount09LastPeriod,0) / @Amount09LastPeriod Else 0 END,  
						Amount10LastPeriod = Case When ISNULL(@Amount10LastPeriod,0) <> 0 Then ISNULL(Amount10LastPeriod,0) / @Amount10LastPeriod Else 0 END,  
						Amount11LastPeriod = Case When ISNULL(@Amount11LastPeriod,0) <> 0 Then ISNULL(Amount11LastPeriod,0) / @Amount11LastPeriod Else 0 END,  
						Amount12LastPeriod = Case When ISNULL(@Amount12LastPeriod,0) <> 0 Then ISNULL(Amount12LastPeriod,0) / @Amount12LastPeriod Else 0 END,  
						Amount13LastPeriod = Case When ISNULL(@Amount13LastPeriod,0) <> 0 Then ISNULL(Amount13LastPeriod,0) / @Amount13LastPeriod Else 0 END,  
						Amount14LastPeriod = Case When ISNULL(@Amount14LastPeriod,0) <> 0 Then ISNULL(Amount14LastPeriod,0) / @Amount14LastPeriod Else 0 END,  
						Amount15LastPeriod = Case When ISNULL(@Amount15LastPeriod,0) <> 0 Then ISNULL(Amount15LastPeriod,0) / @Amount15LastPeriod Else 0 END,  
						Amount16LastPeriod = Case When ISNULL(@Amount16LastPeriod,0) <> 0 Then ISNULL(Amount16LastPeriod,0) / @Amount16LastPeriod Else 0 END,  
						Amount17LastPeriod = Case When ISNULL(@Amount17LastPeriod,0) <> 0 Then ISNULL(Amount17LastPeriod,0) / @Amount17LastPeriod Else 0 END,  
						Amount18LastPeriod = Case When ISNULL(@Amount18LastPeriod,0) <> 0 Then ISNULL(Amount18LastPeriod,0) / @Amount18LastPeriod Else 0 END,  
						Amount19LastPeriod = Case When ISNULL(@Amount19LastPeriod,0) <> 0 Then ISNULL(Amount19LastPeriod,0) / @Amount19LastPeriod Else 0 END,  
						Amount20LastPeriod = Case When ISNULL(@Amount20LastPeriod,0) <> 0 Then ISNULL(Amount20LastPeriod,0) / @Amount20LastPeriod Else 0 END,  
						Amount21LastPeriod = Case When ISNULL(@Amount21LastPeriod,0) <> 0 Then ISNULL(Amount21LastPeriod,0) / @Amount21LastPeriod Else 0 END,  
						Amount22LastPeriod = Case When ISNULL(@Amount22LastPeriod,0) <> 0 Then ISNULL(Amount22LastPeriod,0) / @Amount22LastPeriod Else 0 END,  
						Amount23LastPeriod = Case When ISNULL(@Amount23LastPeriod,0) <> 0 Then ISNULL(Amount23LastPeriod,0) / @Amount23LastPeriod Else 0 END,  
						Amount24LastPeriod = Case When ISNULL(@Amount24LastPeriod,0) <> 0 Then ISNULL(Amount24LastPeriod,0) / @Amount24LastPeriod Else 0 END,
						Amount01ALastPeriod = Case When ISNULL(@Amount01ALastPeriod,0) <> 0 Then ISNULL(Amount01ALastPeriod,0) / @Amount01ALastPeriod Else 0 END,
						Amount02ALastPeriod = Case When ISNULL(@Amount02ALastPeriod,0) <> 0 Then ISNULL(Amount02ALastPeriod,0) / @Amount02ALastPeriod Else 0 END,
						Amount03ALastPeriod = Case When ISNULL(@Amount03ALastPeriod,0) <> 0 Then ISNULL(Amount03ALastPeriod,0) / @Amount03ALastPeriod Else 0 END,
						Amount04ALastPeriod = Case When ISNULL(@Amount04ALastPeriod,0) <> 0 Then ISNULL(Amount04ALastPeriod,0) / @Amount04ALastPeriod Else 0 END,
						Amount05ALastPeriod = Case When ISNULL(@Amount05ALastPeriod,0) <> 0 Then ISNULL(Amount05ALastPeriod,0) / @Amount05ALastPeriod Else 0 END,
						Amount06ALastPeriod = Case When ISNULL(@Amount06ALastPeriod,0) <> 0 Then ISNULL(Amount06ALastPeriod,0) / @Amount06ALastPeriod Else 0 END,
						Amount07ALastPeriod = Case When ISNULL(@Amount07ALastPeriod,0) <> 0 Then ISNULL(Amount07ALastPeriod,0) / @Amount07ALastPeriod Else 0 END,
						Amount08ALastPeriod = Case When ISNULL(@Amount08ALastPeriod,0) <> 0 Then ISNULL(Amount08ALastPeriod,0) / @Amount08ALastPeriod Else 0 END,
						Amount09ALastPeriod = Case When ISNULL(@Amount09ALastPeriod,0) <> 0 Then ISNULL(Amount09ALastPeriod,0) / @Amount09ALastPeriod Else 0 END,
						Amount10ALastPeriod = Case When ISNULL(@Amount10ALastPeriod,0) <> 0 Then ISNULL(Amount10ALastPeriod,0) / @Amount10ALastPeriod Else 0 END,
						Amount11ALastPeriod = Case When ISNULL(@Amount11ALastPeriod,0) <> 0 Then ISNULL(Amount11ALastPeriod,0) / @Amount11ALastPeriod Else 0 END,
						Amount12ALastPeriod = Case When ISNULL(@Amount12ALastPeriod,0) <> 0 Then ISNULL(Amount12ALastPeriod,0) / @Amount12ALastPeriod Else 0 END,
						Amount13ALastPeriod = Case When ISNULL(@Amount13ALastPeriod,0) <> 0 Then ISNULL(Amount13ALastPeriod,0) / @Amount13ALastPeriod Else 0 END,
						Amount14ALastPeriod = Case When ISNULL(@Amount14ALastPeriod,0) <> 0 Then ISNULL(Amount14ALastPeriod,0) / @Amount14ALastPeriod Else 0 END,
						Amount15ALastPeriod = Case When ISNULL(@Amount15ALastPeriod,0) <> 0 Then ISNULL(Amount15ALastPeriod,0) / @Amount15ALastPeriod Else 0 END,
						Amount16ALastPeriod = Case When ISNULL(@Amount16ALastPeriod,0) <> 0 Then ISNULL(Amount16ALastPeriod,0) / @Amount16ALastPeriod Else 0 END,
						Amount17ALastPeriod = Case When ISNULL(@Amount17ALastPeriod,0) <> 0 Then ISNULL(Amount17ALastPeriod,0) / @Amount17ALastPeriod Else 0 END,
						Amount18ALastPeriod = Case When ISNULL(@Amount18ALastPeriod,0) <> 0 Then ISNULL(Amount18ALastPeriod,0) / @Amount18ALastPeriod Else 0 END,
						Amount19ALastPeriod = Case When ISNULL(@Amount19ALastPeriod,0) <> 0 Then ISNULL(Amount19ALastPeriod,0) / @Amount19ALastPeriod Else 0 END,
						Amount20ALastPeriod = Case When ISNULL(@Amount20ALastPeriod,0) <> 0 Then ISNULL(Amount20ALastPeriod,0) / @Amount20ALastPeriod Else 0 END,
						Amount21ALastPeriod = Case When ISNULL(@Amount21ALastPeriod,0) <> 0 Then ISNULL(Amount21ALastPeriod,0) / @Amount21ALastPeriod Else 0 END,
						Amount22ALastPeriod = Case When ISNULL(@Amount22ALastPeriod,0) <> 0 Then ISNULL(Amount22ALastPeriod,0) / @Amount22ALastPeriod Else 0 END,
						Amount23ALastPeriod = Case When ISNULL(@Amount23ALastPeriod,0) <> 0 Then ISNULL(Amount23ALastPeriod,0) / @Amount23ALastPeriod Else 0 END,
						Amount24ALastPeriod = Case When ISNULL(@Amount24ALastPeriod,0) <> 0 Then ISNULL(Amount24ALastPeriod,0) / @Amount24ALastPeriod Else 0 END			  
						WHERE LineID = @ParLineID AND ReportCode = @ReportCode AND DivisionID = @DivisionID  

					FETCH NEXT FROM @Cur_ChildLevelID2 INTO  @ChildLineID, @ChildSign, @ParLineID, @Amount00,  
					@Amount01, @Amount02, @Amount03, @Amount04, @Amount05, @Amount06, @Amount07, @Amount08, @Amount09, @Amount10,  
					@Amount11, @Amount12, @Amount13, @Amount14, @Amount15, @Amount16, @Amount17, @Amount18, @Amount19, @Amount20,  
					@Amount21, @Amount22, @Amount23, @Amount24,  
					@Amount01A, @Amount02A, @Amount03A, @Amount04A, @Amount05A, @Amount06A, @Amount07A, @Amount08A, @Amount09A, @Amount10A,  
					@Amount11A, @Amount12A, @Amount13A, @Amount14A, @Amount15A, @Amount16A, @Amount17A, @Amount18A, @Amount19A, @Amount20A,  
					@Amount21A, @Amount22A, @Amount23A, @Amount24A,  				
					@Amount01LastPeriod, @Amount02LastPeriod, @Amount03LastPeriod, @Amount04LastPeriod,   
					@Amount05LastPeriod, @Amount06LastPeriod, @Amount07LastPeriod, @Amount08LastPeriod,   
					@Amount09LastPeriod, @Amount10LastPeriod, @Amount11LastPeriod, @Amount12LastPeriod,   
					@Amount13LastPeriod, @Amount14LastPeriod, @Amount15LastPeriod, @Amount16LastPeriod,   
					@Amount17LastPeriod, @Amount18LastPeriod, @Amount19LastPeriod, @Amount20LastPeriod,   
					@Amount21LastPeriod, @Amount22LastPeriod, @Amount23LastPeriod, @Amount24LastPeriod,
					@Amount01ALastPeriod, @Amount02ALastPeriod, @Amount03ALastPeriod, @Amount04ALastPeriod,   
					@Amount05ALastPeriod, @Amount06ALastPeriod, @Amount07ALastPeriod, @Amount08ALastPeriod,   
					@Amount09ALastPeriod, @Amount10ALastPeriod, @Amount11ALastPeriod, @Amount12ALastPeriod,   
					@Amount13ALastPeriod, @Amount14ALastPeriod, @Amount15ALastPeriod, @Amount16ALastPeriod,   
					@Amount17ALastPeriod, @Amount18ALastPeriod, @Amount19ALastPeriod, @Amount20ALastPeriod,   
					@Amount21ALastPeriod, @Amount22ALastPeriod, @Amount23ALastPeriod, @Amount24ALastPeriod			  
				END
				CLOSE @Cur_ChildLevelID2

				FETCH NEXT FROM @Cur2 INTO  @LineID, @LineDescription, @Sign, @AccuLineID, @CaculatorID ,@FromAccountID, @ToAccountID, @FromCorAccountID,@ToCorAccountID, @AnaTypeID, @FromAnaID , @ToAnaID, @BudgetID  
			END
			CLOSE @Cur2
		END
	END
END
Set nocount off  

--Customize bao cao PL006--
BEGIN
	UPDATE AT1
	SET AT1.Amount00 = ISNULL((ISNULL(AT2.Amount00, 0)/NULLIF(AT3.Amount00, 0)/3600), 0)
	, AT1.Amount01 = ISNULL((ISNULL(AT2.Amount01, 0)/NULLIF(AT3.Amount01, 0)/3600), 0)
	, AT1.Amount02 = ISNULL((ISNULL(AT2.Amount02, 0)/NULLIF(AT3.Amount02, 0)/3600), 0)
	, AT1.Amount03 = ISNULL((ISNULL(AT2.Amount03, 0)/NULLIF(AT3.Amount03, 0)/3600), 0)
	, AT1.Amount04 = ISNULL((ISNULL(AT2.Amount04, 0)/NULLIF(AT3.Amount04, 0)/3600), 0)
	, AT1.Amount05 = ISNULL((ISNULL(AT2.Amount05, 0)/NULLIF(AT3.Amount05, 0)/3600), 0)
	, AT1.Amount06 = ISNULL((ISNULL(AT2.Amount06, 0)/NULLIF(AT3.Amount06, 0)/3600), 0)
	, AT1.Amount07 = ISNULL((ISNULL(AT2.Amount07, 0)/NULLIF(AT3.Amount07, 0)/3600), 0)
	, AT1.Amount08 = ISNULL((ISNULL(AT2.Amount08, 0)/NULLIF(AT3.Amount08, 0)/3600), 0)
	, AT1.Amount09 = ISNULL((ISNULL(AT2.Amount09, 0)/NULLIF(AT3.Amount09, 0)/3600), 0)
	, AT1.Amount10 = ISNULL((ISNULL(AT2.Amount10, 0)/NULLIF(AT3.Amount10, 0)/3600), 0)
	, AT1.Amount11 = ISNULL((ISNULL(AT2.Amount11, 0)/NULLIF(AT3.Amount11, 0)/3600), 0)
	, AT1.Amount12 = ISNULL((ISNULL(AT2.Amount12, 0)/NULLIF(AT3.Amount12, 0)/3600), 0)
	, AT1.Amount13 = ISNULL((ISNULL(AT2.Amount13, 0)/NULLIF(AT3.Amount13, 0)/3600), 0)
	, AT1.Amount14 = ISNULL((ISNULL(AT2.Amount14, 0)/NULLIF(AT3.Amount14, 0)/3600), 0)
	, AT1.Amount15 = ISNULL((ISNULL(AT2.Amount15, 0)/NULLIF(AT3.Amount15, 0)/3600), 0)
	, AT1.Amount16 = ISNULL((ISNULL(AT2.Amount16, 0)/NULLIF(AT3.Amount16, 0)/3600), 0)
	, AT1.Amount17 = ISNULL((ISNULL(AT2.Amount17, 0)/NULLIF(AT3.Amount17, 0)/3600), 0)
	, AT1.Amount18 = ISNULL((ISNULL(AT2.Amount18, 0)/NULLIF(AT3.Amount18, 0)/3600), 0)
	, AT1.Amount19 = ISNULL((ISNULL(AT2.Amount19, 0)/NULLIF(AT3.Amount19, 0)/3600), 0)
	, AT1.Amount20 = ISNULL((ISNULL(AT2.Amount20, 0)/NULLIF(AT3.Amount20, 0)/3600), 0)
	, AT1.Amount21 = ISNULL((ISNULL(AT2.Amount21, 0)/NULLIF(AT3.Amount21, 0)/3600), 0)
	, AT1.Amount22 = ISNULL((ISNULL(AT2.Amount22, 0)/NULLIF(AT3.Amount22, 0)/3600), 0)
	, AT1.Amount23 = ISNULL((ISNULL(AT2.Amount23, 0)/NULLIF(AT3.Amount23, 0)/3600), 0)
	, AT1.Amount24 = ISNULL((ISNULL(AT2.Amount24, 0)/NULLIF(AT3.Amount24, 0)/3600), 0)
	FROM AT7622 AT1
		LEFT JOIN AT7622 AT2 ON AT2.ReportCode = AT1.ReportCode AND AT2.LineID = N'A.02'
		LEFT JOIN AT7622 AT3 ON AT3.ReportCode = AT1.ReportCode AND AT3.LineID = N'A.11'
	Where AT1.DivisionID = @DivisionID AND AT1.ReportCode = N'PL006' AND AT1.LineID = N'A.12'
END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

