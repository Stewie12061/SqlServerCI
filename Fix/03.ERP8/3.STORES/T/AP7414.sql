IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP7414]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP7414]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-----Created by Nguyen Van Nhan, Date 10/10/2003
-----Tra ra View xac dinh so du cong no phai thu
-----Edited by Nguyen Thi Ngoc Minh, Date 27/04/2004
-----Purpose: Cho phep chon loai ngay len bao cao theo ngay  va theo ky
-----Edited by Dang Le Bao Quynh, Date 04/07/2008
-----Purpose: Bo sung view phuc in chi tiet phai thu theo ma phan tich
---- Modified by on 15/10/2014 by Huỳnh Tấn Phú : Bổ sung điều kiện lọc theo 10 mã phân tích. 0022751: [VG] In số dư đầu kỳ lên sai dẫn đến số dư cuối kỳ sai. 
---- Modified on 07/04/2016 by Hoàng Vũ: Bổ sung Điều kiện lọc nhiều DivisionIDvới biến truyền vào @StrDivisionID (CuatomizeIndex = 51 hoàng trần)
---- Modified on 07/10/2016 by Phương Thảo: Sửa lỗi bị double dòng nếu lọc theo mã phân tích
---- Modified by Hải Long on 19/05/2017: Chỉnh sửa danh mục dùng chung
---- Modified by Kim Thư on 03/05/2019: Chỉnh sửa tính OpeningOriginalAmount theo OriginalAmountCN trên view AV7414
---- Modified by Đức Thông on 19/03/2021: [Tiên Tiến] 2021/03/IS/0157: Lấy dữ liệu division được chọn trên báo cáo
---- Modified by Nhựt Trường on 21/01/2022: Bổ sung Division IN khi join bảng AT1202, AT1005.
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

/********************************************
'* Edited by: [GS] [Ngọc Nhựt] [29/07/2010]
'********************************************/
/*
exec AP7414 
	@DivisionID=N'HT',
	@FromObjectID=N' 22247-B.TD*HBC',
	@ToObjectID=N'Z-TV70',
	@FromAccountID=N'1311',
	@ToAccountID=N'171',
	@CurrencyID=N'VND',
	@FromPeriod = 4,
	@FromDate='2016-04-06 14:29:16.457',
	@IsDate = 1,
	@TypeDate = '',
	@SqlFind=N'1=1',
	@StrDivisionID=N'HT,Q7,TB'

*/

CREATE PROCEDURE  [dbo].[AP7414] 
			@DivisionID AS NVARCHAR(50), 
			@FromObjectID AS NVARCHAR(50),  
			@ToObjectID AS NVARCHAR(50),  
			@FromAccountID AS NVARCHAR(50),  
			@ToAccountID AS NVARCHAR(50),  
			@CurrencyID NVARCHAR(50),  
			@FromPeriod AS int, 
			@FromDate AS Datetime, 		
			@IsDate AS TINYINT,
			@TypeDate AS NVARCHAR(20),
			@SqlFind AS NVARCHAR(500),
			@StrDivisionID AS NVARCHAR(4000)


AS
		Declare @CustomerName INT
		CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
		INSERT #CustomerName EXEC AP4444
		SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

		--------------->>>> Chuỗi DivisionID
		DECLARE @StrDivisionID_NewAV4202 AS NVARCHAR(4000)
		DECLARE @StrDivisionID_NewAV4203 AS NVARCHAR(4000)
		If @CustomerName=51 OR @CustomerName = 13 --Customer hoàng trần
		Begin
			IF Isnull(@StrDivisionID, '') = Isnull(@DivisionID, '') 
			Begin
				Set @StrDivisionID_NewAV4202 = ' AV4202.DivisionID LIKE ''' + @DivisionID + '''' 
				Set @StrDivisionID_NewAV4203 = ' AV4203.DivisionID LIKE ''' + @DivisionID + '''' 
			End
			ELSE
			Begin 
				Set @StrDivisionID_NewAV4202 = ' AV4202.DivisionID IN (''' + replace(@StrDivisionID, ',',''',''') + ''')'
				Set @StrDivisionID_NewAV4203 = ' AV4203.DivisionID IN (''' + replace(@StrDivisionID, ',',''',''') + ''')'
			End
		End
		Else
		Begin
				Set @StrDivisionID_NewAV4202 = ' AV4202.DivisionID LIKE ''' + @DivisionID + '''' 
				Set @StrDivisionID_NewAV4203 = ' AV4203.DivisionID LIKE ''' + @DivisionID + '''' 
		End
		---------------<<<< Chuỗi DivisionID	




DECLARE @sSQL AS NVARCHAR(max),
	@TempCurrID AS NVARCHAR(50),
	@TempCurrIDAna AS NVARCHAR(50),
	@AnaSQL_COLUMN AS NVARCHAR(max),
	@AnaSQL_GROUPBY AS NVARCHAR(max)

IF @CurrencyID ='%'
	BEGIN
		SET @TempCurrID ='%'
		SET @TempCurrIDAna ='%'
	END
ELSE
	BEGIN
		SET @TempCurrID =@CurrencyID--' AV4202.CurrencyIDCN '
		SET @TempCurrIDAna =@CurrencyID--' AV4203.CurrencyIDCN '
	END
SET @AnaSQL_COLUMN = ''
SET @AnaSQL_GROUPBY = ''
--if @SqlFind <> '1=1'
--	BEGIN
--		SET @AnaSQL_COLUMN = ' ,Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID, Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID '
--		SET @AnaSQL_GROUPBY = ''
--	END
--ELSE
--	SET @AnaSQL_COLUMN = ' , NULL Ana01ID, NULL Ana02ID, NULL Ana03ID, NULL Ana04ID, NULL Ana05ID, NULL Ana06ID, NULL Ana07ID, NULL Ana08ID, NULL Ana09ID, NULL Ana10ID '

	
IF @IsDate not in ( 1,2,3)   ---- Tinh theo Ky
	BEGIN
		SET @sSQL =' 
		SELECT 	AV4202.ObjectID, 
			AV4202.AccountID , 
			''' + @TempCurrID + ''' AS CurrencyID,
			AV4202.DivisionID,
			AT1202.ObjectName,
			AT1005.AccountName, AT1005.AccountNameE,
			Sum(ConvertedAmount) AS OpeningConvertedAmount,
			Sum(OriginalAmountCN) AS OpeningOriginalAmount'+@AnaSQL_COLUMN+'
			--Sum(OriginalAmount) AS OpeningOriginalAmount'+@AnaSQL_COLUMN+'
		FROM AV4202 INNER JOIN AT1202 ON AT1202.ObjectID = AV4202.ObjectID and AT1202.DivisionID  IN ('''+@DivisionID+''',''@@@'')
				INNER JOIN AT1005 ON AT1005.AccountID = AV4202.AccountID and AT1005.DivisionID IN ('''+@DivisionID+''',''@@@'')
		WHERE ' + @StrDivisionID_NewAV4202 + ' AND
			(AV4202.TranMonth + 100 * AV4202.TranYear < ' + STR(@FromPeriod) + ' OR (AV4202.TranMonth + 100 * AV4202.TranYear = ' + STR(@FromPeriod)+'  AND AV4202.TransactionTypeID =''T00'' )) AND
			(AV4202.ObjectID BETWEEN ''' + @FromObjectID + ''' AND ''' + @ToObjectID + ''') AND
			(AV4202.AccountID BETWEEN ''' + @FromAccountID + ''' AND ''' + @ToAccountID + ''' ) AND
			AV4202.CurrencyIDCN like ''' + @CurrencyID +''''+'	AND '+@SqlFind+'
		GROUP BY AV4202.ObjectID,  AV4202.AccountID ,AV4202.DivisionID,AT1202.ObjectName,AT1005.AccountName, AT1005.AccountNameE '+@AnaSQL_GROUPBY
		
		IF @CurrencyID <> '%'
			SET @sSQL = @sSQL + ',  AV4202.CurrencyIDCN '
	END
	ELSE
	 BEGIN
		SET @sSQL =' 
		SELECT AV4202.ObjectID,
			AV4202.AccountID , 
			--AV4202.CurrencyID,
			''' + @TempCurrID + ''' as CurrencyID,
			AV4202.DivisionID,
			AT1202.ObjectName,
			AT1005.AccountName, AT1005.AccountNameE,
			SUM(ConvertedAmount) as OpeningConvertedAmount,
			Sum(OriginalAmountCN) AS OpeningOriginalAmount'+@AnaSQL_COLUMN+'
			--Sum(OriginalAmount) AS OpeningOriginalAmount'+@AnaSQL_COLUMN+'			
		FROM AV4202	INNER JOIN AT1202 ON AT1202.ObjectID = AV4202.ObjectID and AT1202.DivisionID  IN ('''+@DivisionID+''',''@@@'')
				INNER JOIN AT1005 ON AT1005.AccountID = AV4202.AccountID and AT1005.DivisionID IN ('''+@DivisionID+''',''@@@'')
		WHERE ' + @StrDivisionID_NewAV4202 + ' AND
			((' + LTRIM(RTRIM(@TypeDate)) + ' < ''' + CONVERT(NVARCHAR(10), @FromDate, 101) + ''') OR 
			 (' + LTRIM(RTRIM(@TypeDate)) + ' <= ''' + CONVERT(NVARCHAR(10), @FromDate, 101) + ''' AND TransactionTypeID = ''T00'')) AND
			(AV4202.ObjectID BETWEEN ''' + @FromObjectID + ''' AND ''' + @ToObjectID + ''') AND
			(AV4202.AccountID BETWEEN ''' + @FromAccountID + ''' AND ''' + @ToAccountID + ''') AND
			AV4202.CurrencyIDCN LIKE ''' + @CurrencyID +''' AND '+@SqlFind+ '	
		GROUP BY AV4202.DivisionID,AV4202.ObjectID, AV4202.AccountID, AT1202.ObjectName, AT1005.AccountName, AT1005.AccountNameE '+ @AnaSQL_GROUPBY
		IF @CurrencyID <> '%'
			SET @sSQL = @sSQL + ', AV4202.CurrencyIDCN '
	END
	

	IF NOT EXISTS (SELECT name FROM sysobjects WHERE id = Object_id(N'[dbo].[AV7414]') AND OBJECTPROPERTY(id, N'IsView') = 1)
     		EXEC ('  CREATE VIEW AV7414 AS ' + @sSQL)
	ELSE
		EXEC ('  ALTER VIEW AV7414 AS ' + @sSQL)
		
IF @IsDate NOT IN ( 1,2,3)   ---- Tinh theo Ky
	BEGIN
		SET @sSQL =' 
		SELECT AV4203.ObjectID, 
			AV4203.Ana01ID,
			AV4203.AccountID , 
			''' + @TempCurrIDAna + ''' as CurrencyID,
			AT1202.DivisionID,
			AT1202.ObjectName,
			AT1005.AccountName,
			(SELECT SUM(ConvertedAmount) 
				FROM AV4203 V03
				WHERE V03.DivisionID = ''' + @DivisionID + ''' AND
					(V03.TranMonth + 100 * V03.TranYear < ' + STR(@FromPeriod) + ' OR (V03.TranMonth + 100 * V03.TranYear = ' + STR(@FromPeriod) + ' AND V03.TransactionTypeID =''T00'')) AND
					(V03.ObjectID = AV4203.ObjectID) AND
					(V03.AccountID between ''' + @FromAccountID + ''' AND ''' + @ToAccountID + ''') AND
					V03.CurrencyIDCN like ''' + @CurrencyID + '''
			) AS OpeningConvertedAmount,
			(SELECT SUM(OriginalAmount) 
				FROM AV4203 V03 
				WHERE V03.DivisionID = ''' + @DivisionID + ''' AND
				(V03.TranMonth + 100 * V03.TranYear < ' + str(@FromPeriod) + ' OR (V03.TranMonth + 100 * V03.TranYear = ' + STR(@FromPeriod) + '  AND V03.TransactionTypeID =''T00'')) AND
				(V03.ObjectID = AV4203.ObjectID) and (V03.DivisionID = AV4203.ObjectID) AND
				(V03.AccountID BETWEEN  ''' + @FromAccountID + ''' AND  '''+@ToAccountID+''') AND
				V03.CurrencyIDCN LIKE ''' + @CurrencyID + '''
			) AS OpeningOriginalAmount,
			SUM(ConvertedAmount) as OpeningConvertedAmountAna01ID,
			SUM(OriginalAmount) AS OpeningOriginalAmountAna01ID
		FROM AV4203 INNER JOIN AT1202 on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AV4203.ObjectID
				INNER JOIN AT1005 on AT1005.AccountID = AV4203.AccountID and AT1005.DivisionID = AV4203.DivisionID
		WHERE ' + @StrDivisionID_NewAV4203 + ' AND
			(AV4203.TranMonth + 100 * AV4203.TranYear < ' + STR(@FromPeriod) + ' OR (AV4203.TranMonth + 100 * AV4203.TranYear = ' + STR(@FromPeriod) + ' AND AV4203.TransactionTypeID =''T00'')) AND
			(AV4203.ObjectID BETWEEN ''' + @FromObjectID + ''' and ''' + @ToObjectID + ''') AND
			(AV4203.AccountID BETWEEN ''' + @FromAccountID + ''' and ''' + @ToAccountID + ''') AND
			AV4203.CurrencyIDCN LIKE ''' + @CurrencyID + '''	
		GROUP BY AT1202.DivisionID,AV4203.ObjectID, AV4203.Ana01ID, AV4203.AccountID, AT1202.ObjectName, AT1005.AccountName '
		IF @CurrencyID <> '%'
			SET @sSQL = @sSQL + ',  AV4203.CurrencyIDCN '
	END

	ELSE
	 BEGIN
		SET @sSQL =' 
		SELECT AV4203.ObjectID,
			AV4203.Ana01ID,
			AV4203.AccountID, 
			--AV4203.CurrencyID,
			''' + @TempCurrIDAna + ''' as CurrencyID,
			AT1202.DivisionID,
			AT1202.ObjectName,
			AT1005.AccountName,
			(SELECT Sum(ConvertedAmount) 
				FROM AV4203 V03
				WHERE V03.DivisionID = ''' + @DivisionID + ''' and
				((' + LTRIM(RTRIM(@TypeDate)) + ' < ''' + CONVERT(NVARCHAR(10), @FromDate, 101) + ''') OR 
				 (' + LTRIM(RTRIM(@TypeDate)) + ' <= ''' + CONVERT(NVARCHAR(10), @FromDate, 101) + ''' AND TransactionTypeID = ''T00'')) AND
				(V03.ObjectID = AV4203.ObjectID) and (V03.DivisionID = AV4203.ObjectID) AND
				(V03.AccountID BETWEEN ''' + @FromAccountID + ''' AND ''' + @ToAccountID + ''') AND
				V03.CurrencyIDCN LIKE ''' + @CurrencyID + ''' 
			) AS OpeningConvertedAmount,
			(SELECT SUM(OriginalAmount) 
				FROM AV4203 V03 
				WHERE V03.DivisionID = ''' + @DivisionID+''' AND
				((' + LTRIM(RTRIM(@TypeDate)) + ' < ''' + CONVERT(VARCHAR(10), @FromDate, 101) + ''')  
				or ( ' + ltrim(Rtrim(@TypeDate)) + ' <=''' + CONVERT(VARCHAR(10), @FromDate, 101) + ''' AND TransactionTypeID = ''T00'')) AND
				(V03.ObjectID = AV4203.ObjectID) AND
				(V03.AccountID BETWEEN ''' + @FromAccountID + ''' AND  ''' + @ToAccountID + ''') AND
				V03.CurrencyIDCN LIKE ''' + @CurrencyID + ''' 
			) AS OpeningOriginalAmount,
			SUM(ConvertedAmount) AS OpeningConvertedAmountAna01ID,
			SUM(OriginalAmount) AS OpeningOriginalAmountAna01ID
		FROM AV4203	INNER JOIN AT1202 on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AV4203.ObjectID
				INNER JOIN AT1005 on AT1005.AccountID = AV4203.AccountID and AT1005.DivisionID = AV4203.DivisionID
		WHERE ' + @StrDivisionID_NewAV4203 + ' AND
			((' + LTRIM(RTRIM(@TypeDate)) + ' < ''' + CONVERT(NVARCHAR(10), @FromDate, 101) + ''') OR 
			 (' + LTRIM(RTRIM(@TypeDate)) + ' <= ''' + CONVERT(NVARCHAR(10), @FromDate, 101) + ''' AND TransactionTypeID = ''T00'')) AND
			(AV4203.ObjectID BETWEEN ''' + @FromObjectID + ''' AND ''' + @ToObjectID + ''') AND
			(AV4203.AccountID BETWEEN  ''' + @FromAccountID + ''' AND '''+@ToAccountID+''' ) AND
			AV4203.CurrencyIDCN LIKE ''' + @CurrencyID + '''	
		GROUP BY AT1202.DivisionID,AV4203.ObjectID,  AV4203.Ana01ID, AV4203.AccountID, AT1202.ObjectName, AT1005.AccountName '
	IF @CurrencyID <> '%'
			Set @sSQL = @sSQL + ',  AV4203.CurrencyIDCN '
	END
	

	IF NOT EXISTS (SELECT name FROM sysobjects WHERE id = Object_id(N'[dbo].[AV7424]') AND OBJECTPROPERTY(id, N'IsView') = 1)
     		EXEC ('  CREATE VIEW AV7424 AS ' + @sSQL)
	ELSE
		EXEC ('  ALTER VIEW AV7424  AS ' + @sSQL)

	

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
