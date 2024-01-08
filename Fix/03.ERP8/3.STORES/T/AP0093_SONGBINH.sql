IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0093_SONGBINH]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0093_SONGBINH]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Truy vấn hóa đơn bán hàng customize riêng cho Song Bình
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 10/03/2020 by Văn Minh
---- Create on 09/11/2020 by Hoài Phong Convert lại ngày VoucherDate
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
-- <Example>
---- 
-- <Summary>

CREATE PROCEDURE AP0093_SONGBINH
			@DivisionID NVARCHAR(50),
			@TranMonth INT,
			@TranYear INT,
			@FromDate DATETIME,
			@ToDate DATETIME,
			@ConditionVT NVARCHAR(1000),
			@IsUsedConditionVT NVARCHAR(1000),
			@ConditionAC NVARCHAR(1000),
			@IsUsedConditionAC NVARCHAR(1000),
			@ConditionOB NVARCHAR(1000),
			@IsUsedConditionOB NVARCHAR(1000),
			@ObjectID NVARCHAR(50),
			@UserID VARCHAR(50) = ''
AS	
DECLARE @sSQLSelect NVARCHAR(MAX),
        @sSQLFrom NVARCHAR(MAX),
        @sWhere NVARCHAR(MAX),
        @sGroup NVARCHAR(MAX),
        @sWhereAdd NVARCHAR(MAX) = '',
		@sOrderBy NVARCHAR(MAX) = ''


SET @sSQLSelect = '
SELECT AT9000.DivisionID, TranMonth, TranYear,
	VoucherID, BatchID,	  
	VoucherDate,VoucherNo, Serial, InvoiceNo,
	VoucherTypeID,
	VATTypeID, InvoiceDate,
	VDescription,
	BDescription,
	AT9000.CurrencyID,
	ExchangeRate,
	Sum ( Case when TransactionTypeID in (''T04'') then OriginalAmount else 
												Case When TransactionTypeID in (''64'') then -OriginalAmount else 0 end end) as OriginalAmount,
	Sum ( Case when TransactionTypeID in (''T04'') then ConvertedAmount else 
												Case When TransactionTypeID in (''T64'') then -ConvertedAmount else 0 end end) as ConvertedAmount,
	AT9000.ObjectID,
	AT1202.ObjectName, AT1202.VATNo,
	AT1202.Address,AT1202.CityID,At1002.CityName,
	AT9000.VATObjectID,
	(Case when A.IsUpdateName = 0 then A.ObjectName else VATObjectName End) as  VATObjectName,
	DueDate,
	OrderID,
	isnull(IsStock,0) as IsStock, 
	isnull((Select sum(ConvertedAmount) From AT9000 C WITH (NOLOCK) Where AT9000.VoucherID = C.VoucherID and C.TransactionTypeID =''T54''),0)  as CommissionAmount,
	Sum(isnull(DiscountAmount,0)) as DiscountAmount,
	Sum ( Case when TransactionTypeID =''T14'' then ConvertedAmount else 0 end ) as TaxAmount,
	Sum ( Case when TransactionTypeID =''T14'' then OriginalAmount  else 0 end ) as TaxOriginalAmount --Tien Thue qui doi
	'

SET @sSQLFrom = '
				FROM AT9000 WITH (NOLOCK)
				INNER JOIN AT1202 on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AT9000.ObjectID
				LEFT JOIN AT1202 A on A.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A.ObjectID = AT9000.VATObjectID
				LEFT JOIN AT1002 on AT1002.CityID = AT1202.CityID' 
SET @sWhere = '
		Where AT9000.DivisionID = '''+@DivisionID+'''
				AND AT9000.VoucherDate BETWEEN '''+CONVERT(NVARCHAR(50),@FromDate,101)+''' AND '''+CONVERT(NVARCHAR(10),@ToDate,101)+' 23:59:59''
				AND TransactionTypeID IN (''T04'', ''T14'',''T64'') AND AT9000.TableID IN (''AT9000'')
				AND AT9000.ObjectID LIKE ('''+@ObjectID+''')
				AND	(ISNULL(VoucherTypeID,''#'') IN ' + @ConditionVT + ' OR ' + @IsUsedConditionVT
				  + ')
				AND	(ISNULL(DebitAccountID,''#'') IN ' + @ConditionAC + ' OR ' + @IsUsedConditionAC
				  + ')
				AND	(ISNULL(CreditAccountID,''#'') IN ' + @ConditionAC + ' OR ' + @IsUsedConditionAC
				  + ')
				AND	(ISNULL(AT9000.ObjectID,''#'')  IN ' + @ConditionOB + ' OR ' + @IsUsedConditionOB
				  + ')'


SET @sGroup = '
Group by  AT9000.DivisionID, TranMonth, TranYear,
	VoucherID, BatchID,	  
	VoucherDate,VoucherNo, Serial, InvoiceNo,
	VoucherTypeID, VATTypeID, InvoiceDate,
	VDescription,
	BDescription,
	AT9000.CurrencyID,
	ExchangeRate,	
	AT9000.ObjectID,
	AT1202.ObjectName, AT1202.VATNo, AT1202.Address,AT1202.CityID,AT1002.CityNAme,
	DueDate,
	AT1202.IsUpdateName, VATObjectName,
	IsStock, AT9000.VATObjectID,A.ObjectName,A.IsUpdateName,
	AT9000.OrderID'

SET @sOrderBy = '
ORDER BY VoucherDate DESC,VoucherNo'

--PRINT @sSQLSelect + @sSQLFrom + @sWhere + @sGroup + @sOrderBy
EXEC (@sSQLSelect + @sSQLFrom + @sWhere + @sGroup + @sOrderBy)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
