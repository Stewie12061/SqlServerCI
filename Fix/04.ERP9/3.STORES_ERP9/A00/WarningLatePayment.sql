IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WARNINGLATEPAYMENT]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WARNINGLATEPAYMENT]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO














-- <Summary>
---- danh sách trễ quá 30 ngày thanh toán
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>

-- <History>
----Create on 20/05/2021 by Tấn Lộc

CREATE PROCEDURE [dbo].[WarningLatePayment]
( 
	 @DivisionID VARCHAR(50),
	 @CurDay DATETIME,
	 @LastDay DATETIME,
	 @ListObject VARCHAR(MAX)
	 
)
AS
	DECLARE @sSQL NVARCHAR (MAX) = N'',
     		@OrderBy NVARCHAR(MAX) = N'', 
			@TotalRow NVARCHAR(50) = N'',
			@sWhere NVARCHAR(MAX),
			@ConvertCurDay NVARCHAR(30),
			@ConvertLastDay NVARCHAR(30)


	SET @OrderBy = 'M.SendMailDate DESC'
	SET @sWhere = ''
	SET @ConvertCurDay =  CONVERT(NVARCHAR(20), @CurDay, 101)
	SET @ConvertLastDay =  CONVERT(NVARCHAR(20), @LastDay, 101)

	SET @sSQL = @sSQL + N' SELECT	AV4301.DivisionID, AV4301.VoucherDate, AV4301.VoucherNo, 
					DATEDIFF (day, AV4301.DueDate,''' +@ConvertCurDay+ ''' ) AS Days,
					 AV4301.InvoiceNo, AV4301.InvoiceDate, AV4301.DueDate, 
					 AV4301.VoucherID, AV4301.ObjectID, 
					 AT1202.ObjectName, AT1202.ReDueDays,
					SUM(ISNULL(AV4301.ConvertedAmount,0)  -- Tổng thành tiền
					- (ISNULL(GivedConvertedAmount,0))  -- Tiền giải trừ
					- ISNULL(A1.ConvertedAmount,0)) -- Chiếc khấu
					 AS GivedConvertedAmount
		FROM	AV4301
		LEFT JOIN (	SELECT	DivisionID, SUM(ISNULL(AB.GivedOriginalAmount,0)) AS GivedOriginalAmount,
							SUM(ISNULL(AB.GivedConvertedAmount,0)) AS GivedConvertedAmount,
							VoucherID,  BatchID, ObjectID, AccountID, CurrencyID
					FROM	
					(
								SELECT DISTINCT AT0404.ObjectID, AT0404.AccountID, AT0404.CurrencyID, 
								AT0404.CreditVoucherID AS VoucherID, 
								AT0404.CreditBatchID AS BatchID,
								SUM(ISNULL(AT0404.OriginalAmount,0)) AS GivedOriginalAmount,
								SUM(ISNULL(AT0404.ConvertedAmount,0)) AS GivedConvertedAmount,
								AT0404.DivisionID
						FROM AT0404
						LEFT JOIN  (SELECT DISTINCT DivisionID, VoucherID, BatchID, TableID,ObjectID,VoucherDate 
									FROM	AV0402
									) AS  AV0402 
							ON		AV0402.DivisionID = AT0404.DivisionID AND  AV0402.VoucherID = AT0404.DebitVoucherID 
									AND AV0402.TableID = AT0404.DebitTableID AND AV0402.ObjectID = AT0404.ObjectID AND AV0402.BatchID = AT0404.CreditBatchID
						LEFT JOIN AT1005 WITH (NOLOCK) ON AT1005.AccountID = AT0404.AccountID
						WHERE	AT0404.DivisionID = '''+@DivisionID+''' AND
								AT0404.AccountID between ''131'' AND ''171'' AND
								CONVERT(DATETIME,CONVERT(VARCHAR(10),ISNULL(AT0404.DebitVoucherDate,''01/01/1900''),101), 101)  <=''' +@ConvertCurDay+'''
								AND AT1005.GroupID = ''G03'' 
						GROUP BY	AT0404.ObjectID, AT0404.AccountID, AT0404.CurrencyID, AT0404.CreditVoucherID, 
									AT0404.CreditBatchID, AT0404.DivisionID
					) AB
           			GROUP BY DivisionID, VoucherID,  BatchID, ObjectID, AccountID, CurrencyID) AS A
			  ON 	AV4301.DivisionID = A.DivisionID AND AV4301.VoucherID = A.VoucherID AND
					AV4301.BatchID = A.BatchID AND
					AV4301.ObjectID = A.ObjectID AND
					AV4301.AccountID = A.AccountID AND
					AV4301.CurrencyIDCN =A.CurrencyID	
		LEFT JOIN AT1202 on AT1202.ObjectID = AV4301.ObjectID
		LEFT JOIN AT1005 WITH (NOLOCK) ON AT1005.AccountID = AV4301.AccountID
		LEFT JOIN AV4301 A1 ON A1.VoucherID = AV4301.VoucherID AND A1.TransactionTypeID=''T64'' AND A1.D_C = AV4301.D_C
		
		WHERE 	(AV4301.ObjectID IN('+@ListObject+')) 
				AND AV4301.DivisionID = '''+@DivisionID+'''  	
				AND AV4301.CurrencyIDCN like ''%'' 
				AND AV4301.TransactionTypeID not in (''T09'',''T10'') 
				AND (AV4301.AccountID between ''131'' AND ''171'' or AV4301.CorAccountID between ''131'' AND ''171'')  
				AND AT1005.GroupID = ''G03'' 
				AND CONVERT(DATETIME,CONVERT(VARCHAR(10),AV4301.DueDate,101),101) <= '''+@ConvertCurDay+'''
				AND CONVERT(DATETIME,CONVERT(VARCHAR(10),AV4301.DueDate,101),101) >= '''+@ConvertLastDay+'''

		GROUP BY	AV4301.ObjectID, AT1202.ObjectName,  AT1202.ReDueDays, AV4301.CurrencyID,
					AT1202.Tel, AT1202.Note1, 
					AV4301.DivisionID , AV4301.O01ID,
					AV4301.VoucherID, AV4301.VoucherDate, AV4301.VoucherNo, AV4301.InvoiceDate, AV4301.Serial, 
					AV4301.DueDate, AV4301.InvoiceNo, AV4301.VDescription, 
					AV4301.VoucherID, AV4301.BatchID, AT1202.ReCreditLimit, DeAddress, ReDays'
		 

	EXEC (@sSQL)
	PRINT(@sSQL)




















GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
