IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP7620]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP7620]
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
---- Modified on 18/07/2022 by Văn Tài: Điều chỉnh quy tắc đặt tên bảng.
-- <Example>
---- 
-- <Summary>
CREATE PROCEDURE [dbo].[AP7620]
  @DivisionID AS nvarchar(50),   
  @ReportCode AS nvarchar(50),   
  @FromMonth int,   
  @FromYear  int,   
  @ToMonth int,   
  @ToYear  int,  
  @ValueID AS xml = '<D></D>',
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
		Declare @FieldID AS nvarchar(50),  
				@ChildLineID  AS nvarchar(50),  
				@ParLineID  AS nvarchar(50),  
				@ChildSign  AS nvarchar(5),  
				@sSQL AS nvarchar(4000),  
				@FilterMaster AS nvarchar(50),  
				@FilterDetail AS nvarchar(50),  
				@LineID AS nvarchar(50),  
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
				@BudgetID AS nvarchar(50),   
				@Cur_LevelID AS cursor,  
				@Cur_ChildLevelID AS cursor,  
				@Cur AS cursor,  
				@Cur_Ana AS cursor,  
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
				@I  AS INT,  
				@StrDivisionID_New AS NVARCHAR(4000),  
				@FromMonthLastPeriod int,   
				@FromYearLastPeriod  int,   
				@ToMonthLastPeriod int,   
				@ToYearLastPeriod  int  ,
				@FromID AS nvarchar(50),   
				@ToID AS nvarchar(50),
				@SQL as varchar(max),
				@CustomerName INT
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
				@strTable AS NVARCHAR(MAX) = ''	

		SET @sSQLPer = ''
		SET @sWHEREPer = ''		

--Begin: Load dữ liệu từ xml params:
	CREATE TABLE #AP7620Value
	(
		 ValueID varchar(50)
	)
	INSERT INTO	#AP7620Value		
	SELECT	X.D.value('.', 'VARCHAR(50)') AS ValueID
	FROM	@ValueID.nodes('//D') AS X (D)
--------------------------------------------
		IF EXISTS (SELECT TOP 1 1 FROM AT0000 WHERE DefDivisionID = @DivisionID AND IsPermissionView = 1 ) -- Nếu check Phân quyền xem dữ liệu tại Thiết lập hệ thống thì mới thực hiện
			BEGIN
				SET @sSQLPer = ' LEFT JOIN AT0010 ON AT0010.DivisionID = AV9090.DivisionID 
													AND AT0010.AdminUserID = '''+@UserID+''' 
													AND AT0010.UserID = AV9090.CreateUserID '
				SET @sWHEREPer = 'AND (AV9090.CreateUserID = AT0010.UserID
										OR  AV9090.CreateUserID = '''+@UserID+''') '		
			END

		-----------------<<<<<< Phân quyền xem chứng từ của người dùng khác	
		CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
		INSERT #CustomerName EXEC AP4444
		SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

	IF Isnull(@IsExcelorPrint, 1) = 1	--Khi in xử lý chết 24 cột theo cách bản chuẩn cũ
	Begin
		IF @CustomerName = 16 --- Customize Sieu Thanh
			EXEC AP7620_ST @DivisionID,   @ReportCode, @FromMonth ,     @FromYear  ,     @ToMonth ,     @ToYear  ,       @ValueID ,    @StrDivisionID   
		ELSE 
		Begin   
		--Xac dinh thang, nam cuoi ky truoc  
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
		FROM AT7620   
		WHERE ReportCode = @ReportCode   
		  AND DivisionID = @DivisionID  

		 IF(Isnull(@Selection01,'') <> '' OR Isnull(@Selection02,'') <> '' OR Isnull(@Selection03,'') <> '' OR
			Isnull(@Selection04,'') <> '' OR Isnull(@Selection05,'') <> '' ) AND @CustomerName = 50
		 BEGIN
 			EXEC AP7623 @DivisionID,   @ReportCode,  @FromMonth ,     @FromYear  ,     @ToMonth ,     @ToYear  ,  
 			@ValueID ,      @StrDivisionID, @UserID ,
 			@FromSelection01 ,  @ToSelection01 ,  @FromSelection02 ,  @ToSelection02 ,  @FromSelection03 ,  @ToSelection03 ,
 			@FromSelection04 ,  @ToSelection04 ,  @FromSelection05 ,  @ToSelection05 
		 END
		 ELSE 
		 BEGIN
			EXEC AP4700  @FieldID, @FilterMaster output   

			---Print @FilterMaster  
			--- Buoc 1------------------------  
			DELETE AT7622   
			WHERE ReportCode =@ReportCode
			--WHERE DivisionID = @DivisionID  --- Xoa du lieu bang tam  
  
			--- Buoc 2   Insert du lieu vao bang tam------------------------  
			INSERT AT7622 (DivisionID, ReportCode, LineID)  
			SELECT DivisionID, @ReportCode, LineID   
			FROM AT7621   
			WHERE ReportCode =@ReportCode ---and IsPrint =1  
			  and DivisionID =@DivisionID  
 
			----Buoc 3 duyet tung cap tu lon den nho  
  
			IF @CustomerName = 75
			BEGIN
				SET @strSelect = ' SignAmount2,'
				SET @strTable = 'AV9090_PCF AV9090'
			END
			ELSE IF @CustomerName = 98
				BEGIN
					SET @strSelect = ' SignAmount2,'
					SET @strTable = 'AV9090_AT AV9090'
				END
			ELSE
			BEGIN
				SET @strSelect = ' 0 AS SignAmount2,'
				SET @strTable = 'AV9090'	
			END	
	
			-------------- Bổ sung điều kiện lọc --------------------
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
     
			Set @LevelID_Pre = (Select Top 1 LevelID From AT7621 Where ReportCode =@ReportCode and DivisionID =@DivisionID Order by LevelID Desc)  
  
			SET @Cur_LevelID= Cursor Scroll KeySet FOR   
			 SELECT   DISTINCT LevelID   
			 FROM AT7621  
			 WHERE ReportCode = @ReportCode and DivisionID = @DivisionID  
			 ORDER BY LevelID Desc  
  
			OPEN @Cur_LevelID  
			FETCH NEXT FROM @Cur_LevelID INTO  @LevelID  
			WHILE @@Fetch_Status = 0  
			  Begin   
   
			---- Buoc 4  Tinh toan va update du lieu bang bang tam ------------------------  
			SET @Cur = Cursor Scroll KeySet FOR   
			 Select  LineID, Sign, AccuLineID, CaculatorID , FromAccountID, ToAccountID, FromCorAccountID,ToCorAccountID,   
					isnull(AnaTypeID,''), isnull(FromAnaID,'') , isnull(ToAnaID,''),  BudgetID  
			 From	AT7621  
			 Where	ReportCode = @ReportCode and  LevelID = @LevelID and DivisionID = @DivisionID
			 ---Order by LineID 
  
			OPEN @Cur  
			FETCH NEXT FROM @Cur INTO  @LineID, @Sign, @AccuLineID, @CaculatorID ,@FromAccountID, @ToAccountID, @FromCorAccountID,@ToCorAccountID,  
			   @AnaTypeID,@FromAnaID , @ToAnaID, @BudgetID  
			WHILE @@Fetch_Status = 0  
			  Begin   
  
			 If isnull(@AnaTypeID,'')<>''  
			 Begin  
				 Exec AP4700  @AnaTypeID, @FilterDetail output   
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
	 
			--PRINT @sSQL  
			--PRINT(@sSQLPer)
			--PRINT(@sWHEREPer)
			 IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WHERE NAME = 'AV9091' AND XTYPE ='V')  
				   EXEC ('  CREATE VIEW AV9091 AS ' + @sSQL)  
			 ELSE  
				   EXEC ('  ALTER VIEW AV9091  AS ' + @sSQL)  
				   
			 Set @i =1  
   
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
 		
			--select @FromID =orderby from AV6666 where SelectionType = @FieldID and DivisionID in (@DivisionID,'@@@') and SelectionID = @FromValueID 
			-- select @ToID =orderby from AV6666 where SelectionType = @FieldID and DivisionID in (@DivisionID,'@@@') and SelectionID = @ToValueID   

			 SET @Cur_Ana = Cursor Scroll KeySet FOR    
			 Select SelectionID From AV6666  
			 Where SelectionType= @FieldID   
			 --and Orderby between @FromID and @ToID 
			 and Orderby IN (select orderby from AV6666 where SelectionType = @FieldID 
								and DivisionID in (@DivisionID,'@@@') 
								and SelectionID in (select ValueID from #AP7620Value ))
			and DivisionID in (@DivisionID,'@@@') 
			 order by Orderby 
 
			 Open @Cur_Ana  
			 FETCH NEXT FROM @Cur_Ana INTO  @AnaID  
			 ---Khoi tao gia tri dau  
			 WHILE @@Fetch_Status = 0 and @i<=24  
				 Begin  
			   If @ReportCode in ('LLONB','LLONB01','LLONBYTD') And @LineID = '05.01'   
    
				 Begin  
				Select @AnaTypeID='A01',@FromAnaID=@AnaID,@ToAnaID = @AnaID  
				Select @AnaID = @DivisionID  
				 End  
		
				--PRINT '------------------------------------'
				--PRINT '@i:'+                        CONVERT(NVARCHAR(100), @i)
				--PRINT '@FromMonth:'+                        CONVERT(NVARCHAR(100), @FromMonth)
				--PRINT '@FromYear:'+                        CONVERT(NVARCHAR(100), @FromYear)
				--PRINT '@ToMonth:'+                        CONVERT(NVARCHAR(100), @ToMonth)
				--PRINT '@ToYear:'+                        CONVERT(NVARCHAR(100), @ToYear)
				--PRINT '@CaculatorID:'+                        CONVERT(NVARCHAR(100), @CaculatorID)
				--PRINT '@FromAccountID:'+                        CONVERT(NVARCHAR(100), @FromAccountID)
				--PRINT '@ToAccountID:'+                        CONVERT(NVARCHAR(100), @ToAccountID)
				--PRINT '@FromCorAccountID:'+                        CONVERT(NVARCHAR(100), @FromCorAccountID)
				--PRINT '@ToCorAccountID:'+	                        CONVERT(NVARCHAR(100), @ToCorAccountID)	
				--PRINT '@AnaTypeID:'+                        CONVERT(NVARCHAR(100), @AnaTypeID)
				--PRINT '@FromAnaID:'+                        CONVERT(NVARCHAR(100), @FromAnaID)
				--PRINT '@ToAnaID:'+                        CONVERT(NVARCHAR(100), @ToAnaID)
				--PRINT '@FieldID:'+	                        CONVERT(NVARCHAR(100), @FieldID)	
				--PRINT '@AnaID:'+			                        CONVERT(NVARCHAR(100), @AnaID)			
				--PRINT '@BudgetID:'+			                        CONVERT(NVARCHAR(100), @BudgetID)			
							
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
			  Set  @i = @i+1   
			  FETCH NEXT FROM @Cur_Ana INTO  @AnaID  
			  End  
			  Close  @Cur_Ana
			
		
			  Update AT7622   set    
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
  
  
			  --Set @ChildLineID = @AccuLineID  
			  --Set @ChildSign = @Sign  
  

    
			  ---While @LevelID_Pre <> @LevelID and isnull(@LevelID,0)<>0  
			  --- Begin
				--Neu co chi tieu con duoc tinh vao chi tieu nay.  
				SET @Cur_ChildLevelID= Cursor Scroll KeySet FOR   
				SELECT   AT7621.LineID, AT7621.Sign, AT7621.AccuLineID,   
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
				FETCH NEXT FROM @Cur_ChildLevelID INTO  @ChildLineID, @ChildSign, @ParLineID,  
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
				 Begin   
				 If @ChildSign =  '+'   
					Update AT7622  Set    
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
      
  
				 FETCH NEXT FROM @Cur_ChildLevelID INTO  @ChildLineID, @ChildSign, @ParLineID,   
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
  
				End  
      
     
				---Set @LevelID_Pre = @LevelID  
			   ---End  
     
			 FETCH NEXT FROM @Cur INTO  @LineID, @Sign, @AccuLineID, @CaculatorID ,@FromAccountID, @ToAccountID, @FromCorAccountID,@ToCorAccountID,  
				  @AnaTypeID, @FromAnaID , @ToAnaID, @BudgetID  
			  End  
			Close @Cur  
			  Set @LevelID_Pre = @LevelID
			FETCH NEXT FROM @Cur_LevelID INTO  @LevelID  
			End  
			Close @Cur_LevelID  
			  End
			Set nocount off  
	
			END 
	End
	IF Isnull(@IsExcelorPrint, 1) =2 --Khi xuất Excel xử lý cột động theo CrossTab (xử lý trước cho ATTOM)
	Begin
		IF @CustomerName = 98 --- Customize ATTOM
			EXEC AP7620_AT @DivisionID, @ReportCode, @FromMonth, @FromYear, @ToMonth, @ToYear, @ValueID, @StrDivisionID, @UserID, @FromSelection01, @ToSelection01, @FromSelection02,
							@ToSelection02, @FromSelection03, @ToSelection03, @FromSelection04, @ToSelection04, @FromSelection05, @ToSelection05, @IsExcelorPrint, @IsPeriod
		IF @CustomerName = 87 --- Customize OKIA
			EXEC AP7620_OK @DivisionID, @ReportCode, @FromMonth, @FromYear, @ToMonth, @ToYear,  @ValueID, @StrDivisionID, @UserID, @FromSelection01, @ToSelection01, @FromSelection02,
							@ToSelection02, @FromSelection03, @ToSelection03, @FromSelection04, @ToSelection04, @FromSelection05, @ToSelection05, @IsExcelorPrint, @IsPeriod
	End
 
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
