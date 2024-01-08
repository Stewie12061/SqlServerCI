
IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP30601]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[CRMP30601]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>

----In báo cáo số lượng thống kê đơn hàng đặt hàng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Thị Phượng on 12/09/2016
---- Modified by Thị Phượng on 05/01/2017 sửa fix dữ liệu
-- <Example>
----    exec sp_executesql N'CRMP30601 @DivisionID=N''HT'',@DivisionIDList=''HT'',@FromDate='''',@ToDate='''',@IsPeriod=0,@Period=''12/2016'',@FromAccountID=N''1008-B.PN*7'',@ToAccountID=N''1008-B.PN*7'',@UserID=N''ASOFTADMIN''',N'@CreateUserID nvarchar(10),@LastModifyUserID nvarchar(10),@DivisionID nvarchar(2)',@CreateUserID=N'ASOFTADMIN',@LastModifyUserID=N'ASOFTADMIN',@DivisionID=N'HT'

CREATE PROCEDURE [dbo].[CRMP30601] ( 
        @DivisionID       VARCHAR(50),  --Biến môi trường
		@DivisionIDList    NVARCHAR(2000),  --Chọn trong DropdownChecklist DivisionID
		@IsPeriod AS TINYINT,
		@FromDate         DATETIME,
		@ToDate           DATETIME,
		@Period nvarchar(max),
		@FromAccountID  NVarchar(200),
		@ToAccountID  NVarchar(200),
		@UserID  VARCHAR(50)
		
)
AS
BEGIN 
DECLARE
		@sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@sWhere1 NVARCHAR(MAX)
		
SET @sWhere=''
SET @sWhere1=''
--Check Para DivisionIDList null then get DivisionID 
	IF @DivisionIDList IS NULL or @DivisionIDList = ''
		SET @sWhere =@sWhere+ ' AND O01.DivisionID = '''+ @DivisionID+''''
	Else 
		SET @sWhere = @sWhere+ ' AND O01.DivisionID IN ('''+@DivisionIDList+''')'

	IF ((Isnull(@FromAccountID, '') !='')and (Isnull(@ToAccountID, '') !=''))
		SET @sWhere1 = @sWhere1 +' AND (O01.ObjectID between N'''+@FromAccountID+''' and N'''+@ToAccountID+''')'
	IF ((Isnull(@FromAccountID, '') !='')and (Isnull(@ToAccountID, '') =''))
		SET @sWhere1 = @sWhere1 +'AND cast(O01.ObjectID as Nvarchar(50)) >= N'''+cast(@FromAccountID as Nvarchar(50))+''''
	IF ((Isnull(@FromAccountID, '') ='')and (Isnull(@ToAccountID, '') !=''))
		SET @sWhere1 = @sWhere1 +'AND cast(O01.ObjectID as Nvarchar(50)) <= N'''+cast(@ToAccountID as Nvarchar(50))+'''' 		
	IF @IsPeriod = 1
		SET @sWhere = @sWhere + N' AND CONVERT(NVARCHAR(10),O01.OrderDate,21) BETWEEN '''+CONVERT(NVARCHAR(10),@FromDate,21)+''' AND '''+CONVERT(NVARCHAR(10),@ToDate,21)+''' '
	IF @IsPeriod = 0
		SET @sWhere = @sWhere + ' AND (CASE WHEN O01.TranMonth <10 THEN ''0''+rtrim(ltrim(str(O01.TranMonth)))+''/''+ltrim(Rtrim(str(O01.TranYear))) 
  ELSE rtrim(ltrim(str(O01.TranMonth)))+''/''+ltrim(Rtrim(str(O01.TranYear))) END) in ('''+@Period+''')'


---Load danh sách Đơn hàng theo nhân viên
SET @sSQL =
	N' SELECT a.DivisionID, a.O01ID,a.ObjectID, a.AccountName, a.Tel
		, a.[Address], a.ContactID, a.ContactName,a.NotesQuantity
		, CONVERT(NVARCHAR(50), a.OrderDate, 103) AS OrderDate, a.PeriodWater, b.DayTime
		, isnull(case when b.DayTime != 0 then  Convert(Nvarchar(50),DATEADD(day,b.DayTime,a.OrderDate),103) else null end,0) as PeriodeTime
		, case when b.DayTime = 0 then 0 else DateDiff(Day, DATEADD(day,b.DayTime,a.OrderDate), GETDate()) end as OverPeriodTime
	FROM 
	(
		SELECT O01.DivisionID, Max(O01.OrderDate) AS OrderDate, C01.O01ID, O01.ObjectID, C01.AccountName
		, C01.Tel, C01.[Address], Max(ISNULL(C02.ContactID, O01.Contact)) AS ContactID
		, max(Isnull(C03.ContactName,'''')) as ContactName, Max(O01.NotesQuantity) as NotesQuantity, Isnull(C01.PeriodWater,0) PeriodWater
		FROM OT2001 O01 
		LEFT Join CRMT10101 C01 ON C01.DivisionID = O01.DivisionID AND C01.AccountID = O01.ObjectID
		LEFT JOIN CRMT10102 C02 ON C02.DivisionID =O01.DivisionID AND C02.AccountID = O01.ObjectID
		LEFT JOIN CRMT10001 C03 ON C03.DivisionID =O01.DivisionID AND C02.ContactID = C03.ContactID
		WHERE 1=1 '+@sWhere+@sWhere1+'
		GROUP BY  O01.DivisionID,  C01.O01ID, O01.ObjectID, C01.AccountName, C01.Tel, C01.[Address],  C01.PeriodWater--,ISNULL(C02.ContactID, O01.Contact), C03.ContactName
	)a 
	Inner JOIN 
	(
		SELECT D.DivisionID, d.ObjectID , isnull(DateDiff(Day, c.OrderDates, d.OrderDate),0) as DayTime
		  FROM 
		(SELECT DivisionID, Max(OrderDate) AS OrderDate, ObjectID 
		FROM OT2001 O01 
		WHERE 1=1 '+@sWhere+@sWhere1+'
		GROUP BY  ObjectID , DivisionID)D
		Left join 
		(SELECT O01.DivisionID, Max(O01.OrderDate)AS OrderDates, O01.ObjectID 
		FROM OT2001 O01 Inner JOIN (
							SELECT Max(OrderDate) AS OrderDate, ObjectID, O01.DivisionID 
							FROM OT2001 O01 
							WHERE 1=1 '+@sWhere+@sWhere1+'
							GROUP BY  ObjectID, DivisionID
							 ) a ON O01.DivisionID= a.DivisionID and O01.ObjectID = a.ObjectID AND O01.OrderDate != a.OrderDate
		WHERE 1=1 '+@sWhere+@sWhere1+'
		GROUP BY O01.ObjectID, O01.DivisionID)C on C.DivisionID = D.DivisionID and C.ObjectID =D.ObjectID
		GROUP BY d.DivisionID, d.ObjectID, c.OrderDates, D.OrderDate
	)b ON a.DivisionID =b.DivisionID AND a.ObjectID= b.ObjectID	
	ORDER BY a.DivisionID, a.ObjectID, a.OrderDate
	'
EXEC (@sSQL)
--PRINT @sSQL	
END
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

