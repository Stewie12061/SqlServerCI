IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0368]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP0368]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Tinh toan so du theo mat hang cho bao cao doi chieu cong no phai thu & phai tra cho cung 1 doi tuong
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- 	Created on 15/09/2004 by Nguyen Thi Ngoc Minh
-----
---- Modified on 28/09/2011 by Le Thi Thu Hien : Chinh sua Division
---- Modified on 17/01/2012 by Le Thi Thu Hien : Chinh sua CONVERT(DATETIME,CONVERT(VARCHAR(10),VoucherDate,101),101)
---- Modify on 20/06/2012 by Bao Anh : Cai thien toc do (khong dung cursor)
---- Modify on 16/08/2012 by Thien Huynh : Chinh sua Convert DateTime, Sữa lỗi nối chuỗi
---- Modified by Hải Long on 18/05/2017: Chỉnh sửa danh mục dùng chung
---- Modified by Kim Thư on 09/01/2018 : Sửa lỗi in báo cáo @sSQL2 , @IsDate = 1
---- Modified by Nhựt Trường on 04/03/2021: Fix lỗi điều kiện Where theo InventoryID - Chưa bắt được trường hợp rỗng.
---- Modified by Nhựt Trường on 10/03/2021: Fix lỗi điều kiện where theo DivisionID khi in theo ngày.
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
-- <Example>
---- 


CREATE PROCEDURE [dbo].[AP0368] 
				@DivisionID AS nvarchar(50), 
				@FromObjectID  AS nvarchar(50),  
				@ToObjectID  AS nvarchar(50),  
				@FromRecAccountID  AS nvarchar(50),  
				@ToRecAccountID  AS nvarchar(50), 
				@FromPayAccountID  AS nvarchar(50),  
				@ToPayAccountID  AS nvarchar(50), 
				@CurrencyID  AS nvarchar(50),  
				@FromInventoryID AS nvarchar(50),
				@ToInventoryID AS nvarchar(50),
				@IsDate AS tinyint, 
				@FromMonth AS int ,
				@FromYear  AS int,  
				@FromDate AS Datetime,
				@IsPayable tinyint  	--- 0: Chi lay so phat thu
										---	1: Chi lay so phai tra
										---	2: Lay ca so phai thu va phai tra
	

AS

SET NOCOUNT ON

Declare @sSQL AS nvarchar(4000),
	@sSQL1 AS nvarchar(4000),
	@sSQL2 AS nvarchar(4000),
	@FromPeriod AS int

Set @FromPeriod = @FromMonth + @FromYear*100
SET @sSQL1 = ''
SET @sSQL2 = ''

Delete AT0368 where DivisionID = @DivisionID
	
if @IsDate =0  --- Theo ky
Begin 
	
	If @IsPayable =0  Or  @IsPayable =2  --- Chi co phai thu:
		SET @sSQL1 = '(SELECT AV4202.DivisionID, AV4202.ObjectID, AT1202.ObjectName, 
			Sum(isnull(OriginalAmount,0)) AS ReBeOriginalAmount, Sum(isnull(ConvertedAmount,0)) AS ReBeConvertedAmount, 0, 0,
			AT1202.Address, AT1202.Tel, AT1202.Fax,	AT1202.Email, AT1202.VATNo, AT1202.Contactor,
			AT1202.S1, AT1202.S2, AT1202.S3, AT1202.O01ID, AT1202.O02ID, AT1202.O03ID, AT1202.O04ID, AT1202.O05ID			
			From AV4202
			inner join AT1005 on AT1005.AccountID = AV4202.AccountID and AT1005.GroupID =''G03'' 
			inner join AT1202 on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AV4202.ObjectID
			Where 	(AV4202.ObjectID between ''' + @FromObjectID + ''' and ''' + @ToObjectID + ''')		
			and (AV4202.AccountID between ''' + @FromRecAccountID + ''' and ''' + @ToRecAccountID + ''') 	
			and ((TranMonth + TranYear*100 = ' + str(@FromPeriod) + ' and TransactionTypeID = ''T00'')
			or (TranMonth + TranYear*100 < ' + str(@FromPeriod) + '))	
			and	CurrencyIDCN like ''' + @CurrencyID + '''
			and Case ISNULL(InventoryID,'''')
				When '''' Then ''' + @FromInventoryID + '''
				Else InventoryID
				End Between ''' + @FromInventoryID + ''' and ''' + @ToInventoryID + '''
			and AV4202.DivisionID = ''' + @DivisionID + ''' GROUP BY AV4202.DivisionID, AV4202.ObjectID, AT1202.ObjectName, AT1202.Address, 
			AT1202.Tel, AT1202.Fax, AT1202.Email, AT1202.VATNo, AT1202.Contactor, AT1202.S1, AT1202.S2, AT1202.S3, AT1202.O01ID, AT1202.O02ID, AT1202.O03ID, AT1202.O04ID, AT1202.O05ID
			HAVING Sum(isnull(OriginalAmount,0)) + Sum(isnull(ConvertedAmount,0)) <>0
			)'
			

	If @IsPayable = 1    Or  @IsPayable =2  --- Chi co phai tra
		SET @sSQL2 = '(SELECT AV4202.DivisionID, AV4202.ObjectID, AT1202.ObjectName, 
			0, 0, Sum(isnull(OriginalAmount,0)) AS PaBeOriginalAmount, Sum(isnull(ConvertedAmount,0)) AS PaBeConvertedAmount,
			AT1202.Address, AT1202.Tel, AT1202.Fax, AT1202.Email, AT1202.VATNo, AT1202.Contactor,
			AT1202.S1, AT1202.S2, AT1202.S3, AT1202.O01ID, AT1202.O02ID, AT1202.O03ID, AT1202.O04ID, AT1202.O05ID			
			From AV4202
			inner join AT1005 on AT1005.AccountID = AV4202.AccountID and AT1005.GroupID =''G04'' 
			inner join AT1202 on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AV4202.ObjectID 
		        Where 	(AV4202.ObjectID between ''' + @FromObjectID + ''' and ''' + @ToObjectID + ''')			
			and (AV4202.AccountID between ''' + @FromPayAccountID + ''' and ''' + @ToPayAccountID + ''') 	
			and ((TranMonth + TranYear*100 = ' + str(@FromPeriod) + ' and TransactionTypeID = ''T00'')
			or (TranMonth + TranYear*100 < ' + str(@FromPeriod) + '))	
			and	CurrencyIDCN like  ''' + @CurrencyID + '''
			and Case ISNULL(InventoryID,'''')
				When '''' Then ''' + @FromInventoryID + '''
				Else InventoryID
				End Between ''' + @FromInventoryID + ''' and ''' + @ToInventoryID + '''
			and AV4202.DivisionID = ''' + @DivisionID + ''' GROUP BY AV4202.DivisionID, AV4202.ObjectID, AT1202.ObjectName, AT1202.Address, 
			AT1202.Tel, AT1202.Fax, AT1202.Email, AT1202.VATNo, AT1202.Contactor, AT1202.S1, AT1202.S2, AT1202.S3, AT1202.O01ID, AT1202.O02ID, AT1202.O03ID, AT1202.O04ID, AT1202.O05ID 
			HAVING Sum(isnull(OriginalAmount,0)) + Sum(isnull(ConvertedAmount,0)) <>0
			)' 
End
Else
Begin  --- Theo ngay

If @IsPayable = 0  or @IsPayable = 2  --- Chi co phai thu
		SET @sSQL1 = '(SELECT AV4202.DivisionID, AV4202.ObjectID, AT1202.ObjectName, 
			Sum(isnull(OriginalAmount,0)) AS ReBeOriginalAmount, Sum(isnull(ConvertedAmount,0)) AS ReBeConvertedAmount, 0, 0,
			AT1202.Address, AT1202.Tel, AT1202.Fax,	AT1202.Email, AT1202.VATNo, AT1202.Contactor, 
			AT1202.S1, AT1202.S2, AT1202.S3, AT1202.O01ID, AT1202.O02ID, AT1202.O03ID, AT1202.O04ID, AT1202.O05ID			
			From	AV4202 
			inner join AT1005 on AT1005.AccountID = AV4202.AccountID and AT1005.GroupID =''G03'' 
			inner join AT1202 on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AV4202.ObjectID
		        Where 	(AV4202.ObjectID between ''' + @FromObjectID + ''' and ''' + @ToObjectID + ''')
			and (AV4202.AccountID between ''' + @FromRecAccountID + ''' and ''' + @ToRecAccountID + ''') and 	
			((CONVERT(DATETIME,CONVERT(VARCHAR(10),VoucherDate,101),101) = ''' + CONVERT(NVARCHAR(10), @FromDate ,101) + ''' and TransactionTypeID = ''T00'') or
			(CONVERT(DATETIME,CONVERT(VARCHAR(10),VoucherDate,101),101) <  ''' + CONVERT(NVARCHAR(10), @FromDate ,101) + ''' )) and
			CurrencyIDCN like ''' + @CurrencyID + ''' and
			Case ISNULL(InventoryID,'''')
				When '''' Then ''' + @FromInventoryID + '''
				Else InventoryID
				End Between ''' + @FromInventoryID + ''' and ''' + @ToInventoryID + '''
			and AV4202.DivisionID = ''' + @DivisionID + ''' GROUP BY AV4202.DivisionID, AV4202.ObjectID, AT1202.ObjectName, AT1202.Address, 
			AT1202.Tel, AT1202.Fax, AT1202.Email, AT1202.VATNo, AT1202.Contactor, AT1202.S1, AT1202.S2, AT1202.S3, AT1202.O01ID, AT1202.O02ID, AT1202.O03ID, AT1202.O04ID, AT1202.O05ID
			HAVING Sum(isnull(OriginalAmount,0)) + Sum(isnull(ConvertedAmount,0)) <>0
			)'

If @IsPayable = 1 or  @IsPayable = 2 --- Chi co phai tra
		SET @sSQL2 = '(SELECT AV4202.DivisionID, AV4202.ObjectID, AT1202.ObjectName, 
			0, 0, Sum(isnull(OriginalAmount,0)) AS PaBeOriginalAmount, Sum(isnull(ConvertedAmount,0)) AS PaBeConvertedAmount,
			AT1202.Address, AT1202.Tel, AT1202.Fax, AT1202.Email, AT1202.VATNo, AT1202.Contactor, 
			AT1202.S1, AT1202.S2, AT1202.S3, AT1202.O01ID, AT1202.O02ID, AT1202.O03ID, AT1202.O04ID, AT1202.O05ID
			From	AV4202 
			inner join AT1005 on AT1005.DivisionID = AV4202.DivisionID and AT1005.GroupID =''G04'' 
			inner join AT1202 on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AV4202.ObjectID
		        Where 	(AV4202.ObjectID between ''' + @FromObjectID + ''' and ''' + @ToObjectID + ''')		
			And 	(AV4202.AccountID between ''' + @FromPayAccountID + ''' and ''' + @FromPayAccountID + ''') 	
			and    ((CONVERT(DATETIME,CONVERT(VARCHAR(10),VoucherDate,101),101) = ''' + CONVERT(NVARCHAR(10), @FromDate ,101) + '''  and TransactionTypeID = ''T00'') or
				CONVERT(DATETIME,CONVERT(VARCHAR(10),VoucherDate,101),101) < ''' + CONVERT(NVARCHAR(10), @FromDate ,101) + ''') and
				CurrencyIDCN like ''' + @CurrencyID + ''' and
				Case ISNULL(InventoryID,'''')
					When '''' Then ''' + @FromInventoryID + '''
					Else InventoryID
					End Between ''' + @FromInventoryID + ''' and ''' + @ToInventoryID + '''
				and AV4202.DivisionID = ''' + @DivisionID + ''' GROUP BY AV4202.DivisionID, AV4202.ObjectID, AT1202.ObjectName, AT1202.Address, 
			AT1202.Tel, AT1202.Fax, AT1202.Email, AT1202.VATNo, AT1202.Contactor, AT1202.S1, AT1202.S2, AT1202.S3, AT1202.O01ID, AT1202.O02ID, AT1202.O03ID, AT1202.O04ID, AT1202.O05ID
			HAVING Sum(isnull(OriginalAmount,0)) + Sum(isnull(ConvertedAmount,0)) <>0
			)'

End	

SET @sSQL = CASE WHEN RTRIM(LTRIM(@sSQL1)) = '' THEN @sSQL2
		WHEN RTRIM(LTRIM(@sSQL2)) = '' THEN @sSQL1
		ELSE @sSQL1 + ' UNION ' + @sSQL2 END
	
	
	EXEC('INSERT INTO AT0368 (DivisionID, ObjectID, ObjectName, ReBeOriginalAmount, ReBeConvertedAmount, 
						PaBeOriginalAmount, PaBeConvertedAmount,
						ObjectAddress, Tel, Fax, Email, VATNo, Contactor ,
						S1, S2 ,S3, O01ID, O02ID, O03ID, O04ID, O05ID) ('
		+ @sSQL + ')')
		


SET NOCOUNT OFF


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

