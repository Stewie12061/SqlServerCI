IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP00202]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP00202]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


---- Created by Tieu Mai on 24/04/2016
---- Purpose: Lay no chua toi han, qua han (CustomizeIndex = 52 - KOYO)
---- Modified on 16/05/2017 by Hải Long: Chỉnh sửa danh mục dùng chung
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

CREATE PROCEDURE [dbo].[AP00202]  --- Duoc goi tu Store AP0020	
					@DivisionID as nvarchar(50),
					@ReportDate as Datetime,
					@FromAccountID as nvarchar(50),
					@ToAccountID as nvarchar(50),
					@FromObjectID as nvarchar(50),
					@ToObjectID as nvarchar(50),
					@CurrencyID as nvarchar(50),
					@IsGroup as tinyint,
					@GroupID as nvarchar(50)
					
 AS
Declare @sSQL AS nvarchar(MAX),
		@sSQL1 AS nvarchar(MAX),
		@Month AS int,
		@Year AS int,
		@GroupIDField AS nvarchar(50),
		@SQLGroup AS nvarchar(50)
	
SET nocount off
SET @Month = month(@ReportDate)
SET @Year = year(@ReportDate)


If @IsGroup = 1
Begin
	SET @GroupIDField =  (SELECT Case @GroupID when  'A01'  then 'Ana01ID'
					   when 'O01' then 'O01ID'   when 'O02' then 'O02ID'   when 'O03' then 'O03ID'   when 'O04' then 'O04ID' 
					   when 'O05' then 'O05ID'   End)

	SET @SQLGroup = ',' + @GroupIDField
End

Else 

Begin
   SET     @GroupIDField   =  ''''''''''
   SET   @SQLGroup = ''
End
--------- So no chua thanh toan-----------------------------------------------------------------
SET @sSQL = '
SELECT 	AV002011.ObjectID, '+@GroupIDField+'  AS  GroupID, AV002011.VoucherID, AV002011.TableID, AV002011.VoucherDate, AT1202.ReDays,
		AV002011.batchID, AV002011.CurrencyIDCN, AV002011.AccountID, AV002011.DivisionID, 
		SUM(ISNULL(AV002011.BeginDebitAmount,0)) AS BeginDebitAmount  , SUM(ISNULL(AV002011.BeginDebitConAmount,0)) AS BeginDebitConAmount , 
		SUM(ISNULL(AV002011.BeginCreditAmount,0)) AS BeginCreditAmount  , SUM(ISNULL(AV002011.BeginCreditConAmount,0)) AS BeginCreditConAmount
FROM	AV002011  
INNER JOIN AT1202 on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AV002011.ObjectID 
GROUP BY   AV002011.ObjectID ,  AV002011.VoucherID, AV002011.TableID, 
			AV002011.batchID, AV002011.CurrencyIDCN, AV002011.AccountID, AV002011.DivisionID, AV002011.VoucherDate, AT1202.ReDays

UNION ALL
SELECT 	AV002013.ObjectID, '+@GroupIDField+'  AS  GroupID  ,  AV002013.VoucherID, AV002013.TableID, AV002013.VoucherDate, AT1202.ReDays,
	AV002013.batchID, AV002013.CurrencyIDCN, AV002013.AccountID, AV002013.DivisionID, 
	SUM(ISNULL(AV002013.BeginDebitAmount,0)) AS BeginDebitAmount  , SUM(ISNULL(AV002013.BeginDebitConAmount,0)) AS BeginDebitConAmount , 
	SUM(ISNULL(AV002013.BeginCreditAmount,0)) AS BeginCreditAmount  , SUM(ISNULL(AV002013.BeginCreditConAmount,0)) AS BeginCreditConAmount
FROM	AV002013
INNER JOIN AT1202 on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AV002013.ObjectID
GROUP BY   AV002013.ObjectID ,  AV002013.VoucherID, AV002013.TableID, 
			AV002013.batchID, AV002013.CurrencyIDCN, AV002013.AccountID, AV002013.DivisionID, AV002013.VoucherDate, AT1202.ReDays
'
	
IF NOT EXISTS (SELECT NAME FROM sysobjects WHERE ID = OBJECT_ID(N'[DBO].[AV002021]') AND OBJECTPROPERTY(ID,N'ISVIEW') = 1)
	EXEC ('  CREATE VIEW AV002021 	--CREATED BY AP00202
		AS ' + @sSQL )
ELSE
	EXEC ('  ALTER VIEW  AV002021	--CREATED BY AP00202
		AS ' + @sSQL )

------- Lấy tổng nợ quá hạn-------------------------------------
SET @sSQL = '
SELECT A01.DivisionID, A01.ObjectID,  A01.OutDateDebitAmount, A01.OutDateDebitConAmount, A01.OutDateCreditAmount, A01.OutDateCreditConAmount,
A02.UnexpiredDebitAmount, UnexpiredDebitConAmount, UnexpiredCreditAmount, UnexpiredCreditConAmount,
OneUnexpiredDebitAmount, OneUnexpiredDebitConAmount, OneUnexpiredCreditAmount, OneUnexpiredCreditConAmount,
ThreeUnexpiredDebitAmount, ThreeUnexpiredDebitConAmount, ThreeUnexpiredCreditAmount, ThreeUnexpiredCreditConAmount,
SixUnexpiredDebitAmount, SixUnexpiredDebitConAmount, SixUnexpiredCreditAmount, SixUnexpiredCreditConAmount
FROM (
SELECT DivisionID, ObjectID,
	SUM(ISNULL(AV002021.BeginDebitAmount,0)) AS OutDateDebitAmount  , SUM(ISNULL(AV002021.BeginDebitConAmount,0)) AS OutDateDebitConAmount , 
	SUM(ISNULL(AV002021.BeginCreditAmount,0)) AS OutDateCreditAmount  , SUM(ISNULL(AV002021.BeginCreditConAmount,0)) AS OutDateCreditConAmount
FROM AV002021
WHERE (DATEDIFF(dd,AV002021.VoucherDate, Getdate()) > Isnull(AV002021.ReDays,0))
	AND AV002021.VoucherDate < GETDATE()
GROUP BY DivisionID, ObjectID) A01
LEFT JOIN (
------- Lấy tổng nợ chưa đến hạn -------------------------------
SELECT DivisionID, ObjectID,
	SUM(ISNULL(AV002021.BeginDebitAmount,0)) AS UnexpiredDebitAmount  , SUM(ISNULL(AV002021.BeginDebitConAmount,0)) AS UnexpiredDebitConAmount , 
	SUM(ISNULL(AV002021.BeginCreditAmount,0)) AS UnexpiredCreditAmount  , SUM(ISNULL(AV002021.BeginCreditConAmount,0)) AS UnexpiredCreditConAmount	
FROM AV002021
WHERE (DATEDIFF(dd,AV002021.VoucherDate, Getdate()) <= Isnull(AV002021.ReDays,0))
	AND AV002021.VoucherDate <= GETDATE()
GROUP BY DivisionID, ObjectID) A02 ON A01.DivisionID = A02.DivisionID AND A01.ObjectID = A02.ObjectID
'
SET @sSQL1 = '
LEFT JOIN (
------- Lấy tổng nợ quá hạn trên 1 tháng ------------------------
SELECT DivisionID, ObjectID, 
	SUM(ISNULL(AV002021.BeginDebitAmount,0)) AS OneUnexpiredDebitAmount  , SUM(ISNULL(AV002021.BeginDebitConAmount,0)) AS OneUnexpiredDebitConAmount , 
	SUM(ISNULL(AV002021.BeginCreditAmount,0)) AS OneUnexpiredCreditAmount  , SUM(ISNULL(AV002021.BeginCreditConAmount,0)) AS OneUnexpiredCreditConAmount
FROM AV002021
WHERE (DATEDIFF(dd,AV002021.VoucherDate, Getdate()) > Isnull(AV002021.ReDays,0))
	AND (DATEDIFF(dd,AV002021.VoucherDate, Getdate()) - Isnull(AV002021.ReDays,0)) > 30
	AND AV002021.VoucherDate < GETDATE()
GROUP BY DivisionID, ObjectID) A03 ON A01.DivisionID = A03.DivisionID AND A01.ObjectID = A03.ObjectID
LEFT JOIN (
------- Lấy tổng nợ quá hạn trên 3 tháng ------------------------
SELECT DivisionID, ObjectID, 
	SUM(ISNULL(AV002021.BeginDebitAmount,0)) AS ThreeUnexpiredDebitAmount  , SUM(ISNULL(AV002021.BeginDebitConAmount,0)) AS ThreeUnexpiredDebitConAmount , 
	SUM(ISNULL(AV002021.BeginCreditAmount,0)) AS ThreeUnexpiredCreditAmount  , SUM(ISNULL(AV002021.BeginCreditConAmount,0)) AS ThreeUnexpiredCreditConAmount
FROM AV002021
WHERE (DATEDIFF(dd,AV002021.VoucherDate, Getdate()) > Isnull(AV002021.ReDays,0))
	AND (DATEDIFF(dd,AV002021.VoucherDate, Getdate()) - Isnull(AV002021.ReDays,0)) > 90
	AND AV002021.VoucherDate < GETDATE()
GROUP BY DivisionID, ObjectID) A04 ON A01.DivisionID = A04.DivisionID AND A01.ObjectID = A04.ObjectID
LEFT JOIN (
------- Lấy tổng nợ quá hạn trên 6 tháng ------------------------
SELECT DivisionID, ObjectID, 
	SUM(ISNULL(AV002021.BeginDebitAmount,0)) AS SixUnexpiredDebitAmount  , SUM(ISNULL(AV002021.BeginDebitConAmount,0)) AS SixUnexpiredDebitConAmount , 
	SUM(ISNULL(AV002021.BeginCreditAmount,0)) AS SixUnexpiredCreditAmount  , SUM(ISNULL(AV002021.BeginCreditConAmount,0)) AS SixUnexpiredCreditConAmount
FROM AV002021
WHERE (DATEDIFF(dd,AV002021.VoucherDate, Getdate()) > Isnull(AV002021.ReDays,0))
	AND (DATEDIFF(dd,AV002021.VoucherDate, Getdate()) - Isnull(AV002021.ReDays,0)) > 120
	AND AV002021.VoucherDate < GETDATE()
GROUP BY DivisionID, ObjectID) A05 ON A01.DivisionID = A05.DivisionID AND A01.ObjectID = A05.ObjectID
'

IF NOT EXISTS (SELECT NAME FROM sysobjects WHERE ID = OBJECT_ID(N'[DBO].[AV00202]') AND OBJECTPROPERTY(ID,N'ISVIEW') = 1)
	EXEC ('  CREATE VIEW AV00202 	--CREATED BY AP00202
		AS ' + @sSQL + @sSQL1)
ELSE
	EXEC ('  ALTER VIEW  AV00202	--CREATED BY AP00202
		AS ' + @sSQL + @sSQL1)

Set nocount on

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
