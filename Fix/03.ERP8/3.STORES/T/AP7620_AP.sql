IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP7620_AP]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP7620_AP]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

------------------- Created by Tiểu Mai.  
------------------ Created Date 06/07/2016  
----------------- Purpose: In bao cao bang ket qua kinh doanh. theo ma phan tich đặc thù cho AN PHÁT (mẫu AR7620_AP)
-- <Example>
---- 
-- <Summary>
CREATE PROCEDURE [dbo].[AP7620_AP]   
  @DivisionID AS nvarchar(50),   
  @ReportCode AS nvarchar(50),   
  @FromMonth int,   
  @FromYear  int,   
  @ToMonth int,   
  @ToYear  int,  
  @FromValueID AS nvarchar(50),   
  @ToValueID AS nvarchar(50),  
  @StrDivisionID AS NVARCHAR(4000) = '' ,
  @UserID AS VARCHAR(50) = '' 
  
AS  
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
		@FromWareHouseID AS nvarchar(50),     
		@ToWareHouseID AS nvarchar(50),
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
		@Amount AS decimal(28,8),  
		@AmountLastPeriod AS decimal(28,8),  
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
		@sWHEREPer AS NVARCHAR(MAX)
SET @sSQLPer = ''
SET @sWHEREPer = ''		

IF EXISTS (SELECT TOP 1 1 FROM AT0000 WHERE DefDivisionID = @DivisionID AND IsPermissionView = 1 ) -- Nếu check Phân quyền xem dữ liệu tại Thiết lập hệ thống thì mới thực hiện
	BEGIN
		SET @sSQLPer = ' LEFT JOIN AT0010 WITH (NOLOCK) ON AT0010.DivisionID = AV9090.DivisionID 
											AND AT0010.AdminUserID = '''+@UserID+''' 
											AND AT0010.UserID = AV9090.CreateUserID '
		SET @sWHEREPer = ' WHERE (AV9090.CreateUserID = AT0010.UserID
								OR  AV9090.CreateUserID = '''+@UserID+''') '		
	END



--Xac dinh thang, nam cuoi ky truoc  
SELECT @FromMonthLastPeriod = FromMonth,  
  @FromYearLastPeriod = FromYear,  
  @ToMonthLastPeriod = ToMonth,  
  @ToYearLastPeriod = ToYear  
FROM dbo.GetLastPeriod(@FromMonth,@FromYear,@ToMonth,@ToYear)  

    
SELECT @StrDivisionID_New = CASE WHEN @StrDivisionID = '%' THEN ' LIKE ''' +   
@StrDivisionID + '''' ELSE ' IN (''' + replace(@StrDivisionID, ',',''',''') + ''')' END  
  
  
SELECT @FieldID = FieldID   
FROM AT7620 WITH (NOLOCK)   
WHERE ReportCode = @ReportCode   
  AND DivisionID = @DivisionID  
  

EXEC AP4700  @FieldID, @FilterMaster output   
  
---Print @FilterMaster  
--- Buoc 1------------------------  
DELETE AT7622   
--WHERE DivisionID = @DivisionID  --- Xoa du lieu bang tam  
  
--- Buoc 2   Insert du lieu vao bang tam------------------------  
INSERT AT7622 (DivisionID, ReportCode, LineID)  
SELECT DivisionID, @ReportCode, LineID   
FROM AT7621 WITH (NOLOCK)   
WHERE ReportCode =@ReportCode ---and IsPrint =1  
  and DivisionID =@DivisionID  
 
----Buoc 3 duyet tung cap tu lon den nho  
  
Set @LevelID_Pre = (Select Top 1 LevelID From AT7621 Where ReportCode =@ReportCode and DivisionID =@DivisionID Order by LevelID Desc)  
  
SET @Cur_LevelID= Cursor Scroll KeySet FOR   
 SELECT   DISTINCT LevelID   
 FROM AT7621 WITH (NOLOCK)  
 WHERE ReportCode = @ReportCode and DivisionID = @DivisionID  
 ORDER BY LevelID Desc  
  
OPEN @Cur_LevelID  
FETCH NEXT FROM @Cur_LevelID INTO  @LevelID  
WHILE @@Fetch_Status = 0  
  Begin   
   
---- Buoc 4  Tinh toan va update du lieu bang bang tam ------------------------  
SET @Cur = Cursor Scroll KeySet FOR   
 Select  LineID, Sign, AccuLineID, CaculatorID , FromAccountID, ToAccountID, FromCorAccountID,ToCorAccountID,   
		isnull(AnaTypeID,''), isnull(FromAnaID,'') , isnull(ToAnaID,''),  BudgetID, FromWareHouseID, ToWareHouseID  
 From	AT7621 WITH (NOLOCK)  
 Where	ReportCode = @ReportCode and  LevelID = @LevelID and DivisionID = @DivisionID
 ---Order by LineID 
  
OPEN @Cur  
FETCH NEXT FROM @Cur INTO  @LineID, @Sign, @AccuLineID, @CaculatorID ,@FromAccountID, @ToAccountID, @FromCorAccountID,@ToCorAccountID,  
   @AnaTypeID,@FromAnaID , @ToAnaID, @BudgetID, @FromWareHouseID, @ToWareHouseID  
WHILE @@Fetch_Status = 0  
  Begin   
  
 If isnull(@AnaTypeID,'')<>''  
 Begin  
	 Exec AP4700  @AnaTypeID, @FilterDetail output   
	 SET @sSQL =' 
		SELECT	Ana01ID, Ana02ID, Ana03ID, ObjectID, PeriodID, TranMonth, TranYear,   
				AV9090.DivisionID, AccountID, CorAccountID, D_C, SignAmount,   
				SignQuantity, BudgetID, TransactionTypeID,  
				'+@FilterMaster+' AS FilterMaster,  
				'+@FilterDetail+' AS FilterDetail  
		FROM	AV9090  
		'  
 END  
 
 ELSE  
 SET @sSQL =' 
SELECT	Ana01ID, Ana02ID, Ana03ID, ObjectID, PeriodID, TranMonth, TranYear,   
			AV9090.DivisionID, AccountID, CorAccountID, D_C, SignAmount,   
			SignQuantity, BudgetID, TransactionTypeID,  
			'+@FilterMaster+' AS FilterMaster,  
			'''' AS FilterDetail  
	FROM	AV9090  
		'  
--PRINT @sSQL  
--PRINT(@sSQLPer)
--PRINT(@sWHEREPer)
 IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WHERE NAME = 'AV9091' AND XTYPE ='V')  
       EXEC ('  CREATE VIEW AV9091 AS ' + @sSQL +@sSQLPer+@sWHEREPer)  
 ELSE  
       EXEC ('  ALTER VIEW AV9091  AS ' + @sSQL+@sSQLPer+@sWHEREPer)  

  
 Set @i =1  
   
 SET @Amount = 0  
 SET @AmountLastPeriod = 0  
   
 Set @Amount01 =0  set @Amount02 =0  set @Amount03 =0  set  @Amount04 =0  set  @Amount05 =0  set  @Amount06 =0  set  @Amount07 =0  set  @Amount08 =0  set  @Amount09 =0  set  @Amount10 =0   
 Set @Amount11 =0  set @Amount12 =0  set @Amount13 =0  set  @Amount14 =0  set  @Amount15 =0  set  @Amount16 =0  set   @Amount17 =0  set  @Amount18 =0  set  @Amount19 =0  set  @Amount20 =0   
 set @Amount21 =0  set @Amount22 =0  set @Amount23 =0  set  @Amount24 =0   
   
 Set @Amount01LastPeriod =0  set @Amount02LastPeriod =0 set @Amount03LastPeriod =0  set @Amount04LastPeriod =0    
 set @Amount05LastPeriod =0  set @Amount06LastPeriod =0 set @Amount07LastPeriod =0  set @Amount08LastPeriod =0    
 set @Amount09LastPeriod =0  set @Amount10LastPeriod =0 set @Amount11LastPeriod =0  set @Amount12LastPeriod =0    
 set @Amount13LastPeriod =0  set @Amount14LastPeriod =0 set @Amount15LastPeriod =0  set @Amount16LastPeriod =0    
 set @Amount17LastPeriod =0  set @Amount18LastPeriod =0 set @Amount19LastPeriod =0  set @Amount20LastPeriod =0   
 set @Amount21LastPeriod =0  set @Amount22LastPeriod =0 set @Amount23LastPeriod =0  set @Amount24LastPeriod =0   

 SET @Cur_Ana = Cursor Scroll KeySet FOR    
	SELECT '01/'+ CONVERT(NVARCHAR(4),@FromYear) AS SelectionID
	UNION ALL
	SELECT '02/'+ CONVERT(NVARCHAR(4),@FromYear) AS SelectionID
	UNION ALL
	SELECT '03/'+ CONVERT(NVARCHAR(4),@FromYear) AS SelectionID
	UNION ALL
	SELECT '04/'+ CONVERT(NVARCHAR(4),@FromYear) AS SelectionID
	UNION ALL
	SELECT '05/'+ CONVERT(NVARCHAR(4),@FromYear) AS SelectionID
	UNION ALL
	SELECT '06/'+ CONVERT(NVARCHAR(4),@FromYear) AS SelectionID
	UNION ALL
	SELECT '07/'+ CONVERT(NVARCHAR(4),@FromYear) AS SelectionID
	UNION ALL
	SELECT '08/'+ CONVERT(NVARCHAR(4),@FromYear) AS SelectionID
	UNION ALL
	SELECT '09/'+ CONVERT(NVARCHAR(4),@FromYear) AS SelectionID
	UNION ALL
	SELECT '10/'+ CONVERT(NVARCHAR(4),@FromYear) AS SelectionID
	UNION ALL
	SELECT '11/'+ CONVERT(NVARCHAR(4),@FromYear) AS SelectionID
	UNION ALL
	SELECT '12/'+ CONVERT(NVARCHAR(4),@FromYear) AS SelectionID
 
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
     
      
   EXEC AP7619_AP @DivisionID,@FromMonth,@FromYear,@ToMonth,@ToYear,  
    @CaculatorID,@FromAccountID,@ToAccountID,  
    @FromCorAccountID,@ToCorAccountID,  
    @AnaTypeID,@FromAnaID,@ToAnaID, @FromWareHouseID, @ToWareHouseID, @FieldID,@AnaID,  
    @BudgetID,@Amount OUTPUT,@StrDivisionID  
      
   EXEC AP7619_AP @DivisionID,@FromMonthLastPeriod,@FromYearLastPeriod,@ToMonthLastPeriod,@ToYearLastPeriod,  
    @CaculatorID,@FromAccountID,@ToAccountID,  
    @FromCorAccountID,@ToCorAccountID,  
    @AnaTypeID,@FromAnaID,@ToAnaID, @FromWareHouseID, @ToWareHouseID,@FieldID,@AnaID,  
    @BudgetID,@AmountLastPeriod OUTPUT,@StrDivisionID   
  
     
   IF @i = 1   
   BEGIN   
    SET @Amount01 = isnull(@Amount,0)  
    SET @Amount01LastPeriod = isnull(@AmountLastPeriod,0)
    
   END   
  
   IF @i = 2   
   BEGIN   
    SET @Amount02 = isnull(@Amount,0) 
    SET @Amount02LastPeriod = isnull(@AmountLastPeriod,0) 
   END   
  
   IF @i = 3   
   BEGIN   
    SET @Amount03 = isnull(@Amount,0)  
    SET @Amount03LastPeriod = isnull(@AmountLastPeriod,0)  
   END   
  
   IF @i = 4   
   BEGIN   
    SET @Amount04 = isnull(@Amount,0)  
    SET @Amount04LastPeriod = isnull(@AmountLastPeriod,0)  
   END   
  
   IF @i = 5   
   BEGIN   
    SET @Amount05 = isnull(@Amount,0)  
    SET @Amount05LastPeriod = isnull(@AmountLastPeriod,0)  
   END   

   IF @i = 6   
   BEGIN   
    SET @Amount06 = isnull(@Amount,0)  
    SET @Amount06LastPeriod = isnull(@AmountLastPeriod,0)  
   END   
  
   IF @i = 7   
   BEGIN   
    SET @Amount07 = isnull(@Amount,0)  
    SET @Amount07LastPeriod = isnull(@AmountLastPeriod,0)  
   END   
  
   IF @i = 8   
   BEGIN   
    SET @Amount08 = isnull(@Amount,0)  
    SET @Amount08LastPeriod = isnull(@AmountLastPeriod,0)  
   END   
  
   IF @i = 9   
   BEGIN   
    SET @Amount09 = isnull(@Amount,0)  
    SET @Amount09LastPeriod = isnull(@AmountLastPeriod,0)  
   END   
  
   IF @i = 10   
   BEGIN   
    SET @Amount10 = isnull(@Amount,0)  
    SET @Amount10LastPeriod = isnull(@AmountLastPeriod,0)  
   END   
  
   IF @i = 11   
   BEGIN   
    SET @Amount11 = isnull(@Amount,0)  
    SET @Amount11LastPeriod = isnull(@AmountLastPeriod,0)  
   END   
  
   IF @i = 12   
   BEGIN   
    SET @Amount12 = isnull(@Amount,0)  
    SET @Amount12LastPeriod = isnull(@AmountLastPeriod,0)  
   END   
  
   IF @i = 13   
   BEGIN   
    SET @Amount13 = isnull(@Amount,0)  
    SET @Amount13LastPeriod = isnull(@AmountLastPeriod,0)  
   END   
  
   IF @i = 14   
   BEGIN   
    SET @Amount14 = isnull(@Amount,0)  
    SET @Amount14LastPeriod = isnull(@AmountLastPeriod,0)  
   END   
  
   IF @i = 15   
   BEGIN   
    SET @Amount15 = isnull(@Amount,0)  
    SET @Amount15LastPeriod = isnull(@AmountLastPeriod,0)  
   END   
  
   IF @i = 16   
   BEGIN   
    SET @Amount16 = isnull(@Amount,0)  
    SET @Amount16LastPeriod = isnull(@AmountLastPeriod,0)  
   END   
  
   IF @i = 17   
   BEGIN   
    SET @Amount17 = isnull(@Amount,0)  
    SET @Amount17LastPeriod = isnull(@AmountLastPeriod,0)  
   END   
  
   IF @i = 18   
   BEGIN   
    SET @Amount18 = isnull(@Amount,0)  
    SET @Amount18LastPeriod = isnull(@AmountLastPeriod,0)  
   END   
  
   IF @i = 19   
   BEGIN   
    SET @Amount19 = isnull(@Amount,0)  
    SET @Amount19LastPeriod = isnull(@AmountLastPeriod,0)  
   END   
  
   IF @i = 20   
   BEGIN   
    SET @Amount20 = isnull(@Amount,0)  
    SET @Amount20LastPeriod = isnull(@AmountLastPeriod,0)  
   END   
  
   IF @i = 21   
   BEGIN   
    SET @Amount21 = isnull(@Amount,0)  
    SET @Amount21LastPeriod = isnull(@AmountLastPeriod,0)  
   END   
  
   IF @i = 22   
   BEGIN   
    SET @Amount22 = isnull(@Amount,0)  
    SET @Amount22LastPeriod = isnull(@AmountLastPeriod,0)  
   END   
  
   IF @i = 23   
   BEGIN   
    SET @Amount23 = isnull(@Amount,0)  
    SET @Amount23LastPeriod = isnull(@AmountLastPeriod,0)  
   END   
  
   IF @i = 24   
   BEGIN   
    SET @Amount24 = isnull(@Amount,0)  
    SET @Amount24LastPeriod = isnull(@AmountLastPeriod,0)  
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
    Amount24LastPeriod = isnull(Amount24LastPeriod,0)+ @Amount24LastPeriod  
  Where ReportCode=@ReportCode and LineID =@LineID and DivisionID =@DivisionID  

    --Neu co chi tieu con duoc tinh vao chi tieu nay.  
    SET @Cur_ChildLevelID= Cursor Scroll KeySet FOR   
    SELECT   AT7621.LineID, AT7621.Sign, AT7621.AccuLineID,   
      isnull(Amount01,0), isnull(Amount02,0), isnull(Amount03,0), isnull(Amount04,0), isnull(Amount05,0),   
      isnull(Amount06,0), isnull(Amount07,0), isnull(Amount08,0), isnull(Amount09,0), isnull(Amount10,0),   
      isnull(Amount11,0), isnull(Amount12,0), isnull(Amount13,0), isnull(Amount14,0), isnull(Amount15,0),   
      isnull(Amount16,0), isnull(Amount17,0), isnull(Amount18,0), isnull(Amount19,0), isnull(Amount20,0),   
      isnull(Amount21,0), isnull(Amount22,0), isnull(Amount23,0), isnull(Amount24,0),   
      isnull(Amount01LastPeriod,0), isnull(Amount02LastPeriod,0), isnull(Amount03LastPeriod,0), isnull(Amount04LastPeriod,0),   
      isnull(Amount05LastPeriod,0), isnull(Amount06LastPeriod,0), isnull(Amount07LastPeriod,0), isnull(Amount08LastPeriod,0),   
      isnull(Amount09LastPeriod,0), isnull(Amount10LastPeriod,0), isnull(Amount11LastPeriod,0), isnull(Amount12LastPeriod,0),   
      isnull(Amount13LastPeriod,0), isnull(Amount14LastPeriod,0), isnull(Amount15LastPeriod,0), isnull(Amount16LastPeriod,0),   
      isnull(Amount17LastPeriod,0), isnull(Amount18LastPeriod,0), isnull(Amount19LastPeriod,0), isnull(Amount20LastPeriod,0),   
      isnull(Amount21LastPeriod,0), isnull(Amount22LastPeriod,0), isnull(Amount23LastPeriod,0), isnull(Amount24LastPeriod,0)   
    FROM AT7621   
    INNER JOIN AT7622 on AT7622.LineID = AT7621.LineID and AT7622.ReportCode = AT7621.ReportCode and AT7622.DivisionID = AT7621.DivisionID  
  WHERE AT7621.DivisionID = @DivisionID and AT7621.ReportCode =@ReportCode 
      and AT7621.AccuLineID in (Select LineID From AT7621 Where ReportCode =@ReportCode and  LineID= @LineID AND DivisionID = @DivisionID)  
    Order by AT7622.LineID
    
    OPEN @Cur_ChildLevelID  
    FETCH NEXT FROM @Cur_ChildLevelID INTO  @ChildLineID, @ChildSign, @ParLineID,  
          @Amount01, @Amount02, @Amount03, @Amount04, @Amount05, @Amount06, @Amount07, @Amount08, @Amount09, @Amount10,  
          @Amount11, @Amount12, @Amount13, @Amount14, @Amount15, @Amount16, @Amount17, @Amount18, @Amount19, @Amount20,  
          @Amount21, @Amount22, @Amount23, @Amount24,  
          @Amount01LastPeriod, @Amount02LastPeriod, @Amount03LastPeriod, @Amount04LastPeriod,   
          @Amount05LastPeriod, @Amount06LastPeriod, @Amount07LastPeriod, @Amount08LastPeriod,   
          @Amount09LastPeriod, @Amount10LastPeriod, @Amount11LastPeriod, @Amount12LastPeriod,   
          @Amount13LastPeriod, @Amount14LastPeriod, @Amount15LastPeriod, @Amount16LastPeriod,   
          @Amount17LastPeriod, @Amount18LastPeriod, @Amount19LastPeriod, @Amount20LastPeriod,   
          @Amount21LastPeriod, @Amount22LastPeriod, @Amount23LastPeriod, @Amount24LastPeriod  
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
        Amount24LastPeriod = isnull(Amount24LastPeriod,0)+ @Amount24LastPeriod  
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
        Amount09 = isnull(Amount09,0)- @Amount09,  
        Amount10 = isnull(Amount10,0)- @Amount10,  
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
        Amount24LastPeriod = isnull(Amount24LastPeriod,0)- @Amount24LastPeriod  
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
        Amount24LastPeriod = (Case when  isnull(Amount24LastPeriod,0) =0 then 1 else  Amount24LastPeriod End) * @Amount24LastPeriod  
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
        Amount24LastPeriod = Case When isnull(@Amount24LastPeriod,0) <> 0 Then isnull(Amount24LastPeriod,0) / @Amount24LastPeriod Else 0 End  
        Where LineID = @ParLineID and ReportCode = @ReportCode and DivisionID = @DivisionID  
      
  
     FETCH NEXT FROM @Cur_ChildLevelID INTO  @ChildLineID, @ChildSign, @ParLineID,   
        @Amount01, @Amount02, @Amount03, @Amount04, @Amount05, @Amount06, @Amount07, @Amount08, @Amount09, @Amount10,  
        @Amount11, @Amount12, @Amount13, @Amount14, @Amount15, @Amount16, @Amount17, @Amount18, @Amount19, @Amount20,  
        @Amount21, @Amount22, @Amount23, @Amount24,  
        @Amount01LastPeriod, @Amount02LastPeriod, @Amount03LastPeriod, @Amount04LastPeriod,   
        @Amount05LastPeriod, @Amount06LastPeriod, @Amount07LastPeriod, @Amount08LastPeriod,   
        @Amount09LastPeriod, @Amount10LastPeriod, @Amount11LastPeriod, @Amount12LastPeriod,   
        @Amount13LastPeriod, @Amount14LastPeriod, @Amount15LastPeriod, @Amount16LastPeriod,   
        @Amount17LastPeriod, @Amount18LastPeriod, @Amount19LastPeriod, @Amount20LastPeriod,   
        @Amount21LastPeriod, @Amount22LastPeriod, @Amount23LastPeriod, @Amount24LastPeriod  
  
    End     
     
 FETCH NEXT FROM @Cur INTO  @LineID, @Sign, @AccuLineID, @CaculatorID ,@FromAccountID, @ToAccountID, @FromCorAccountID,@ToCorAccountID,  
      @AnaTypeID, @FromAnaID , @ToAnaID, @BudgetID, @FromWareHouseID, @ToWareHouseID   
  End  
Close @Cur  
  Set @LevelID_Pre = @LevelID
FETCH NEXT FROM @Cur_LevelID INTO  @LevelID  
End  
Close @Cur_LevelID  

Set nocount off  

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
