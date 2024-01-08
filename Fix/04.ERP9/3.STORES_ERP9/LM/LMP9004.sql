IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[LMP9004]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[LMP9004]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load danh sách hợp đồng tín dụng  
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created on 10/09/2020 by Đình Hoà
-- <Example>

----
CREATE PROCEDURE LMP9004 ( 
        @DivisionID VARCHAR(50),
		@TxtSearch VARCHAR(250) = '',
		@BankIDList VARCHAR(MAX) = '',
		@CurrencyIDList VARCHAR(MAX) = '',
		@PageNumber INT,
        @PageSize INT
) 
AS

DECLARE @TotalRow VARCHAR(50),
        @sWhere VARCHAR (MAX),
		@sSQL VARCHAR (MAX)

SET @sWhere = ''		
SET @TotalRow = ''
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

SET @BankIDList = REPLACE(@BankIDList,',',''',''')
SET @CurrencyIDList = REPLACE(@CurrencyIDList,',',''',''')

IF ISNULL(@BankIDList,'') <> ''
	SET @sWhere = @sWhere + ' AND L01.BankID in (''' + @BankIDList + ''')'

IF ISNULL(@CurrencyIDList,'') <> ''
	SET @sWhere = @sWhere + ' AND T04.CurrencyID in (''' + @CurrencyIDList + ''')'

SET @sSQL = 'SELECT ROW_NUMBER() OVER (ORDER BY L01.VoucherDate, L01.VoucherNo) AS RowNum, '+@TotalRow+' AS TotalRow,
				L01.VoucherID, L01.VoucherNo, L01.VoucherDate, COALESCE(A02.ObjectName,'''') AS ObjectName, L01.FromDate, L01.ToDate,COALESCE(T04.CurrencyName,'''') AS CurrencyName,L10.OriginalLimitTotal,COALESCE(L01.Description,'''') AS Description
				FROM LMT2001 L01
					 LEFT JOIN LMT1010 L10 ON L10.VoucherID = L01.LimitVoucherID
					 LEFT JOIN AT1202 A02 ON L01.BankID = A02.ObjectID
					 LEFT JOIN AT1004 T04 ON L01.CurrencyID = T04.CurrencyID
				WHERE L01.DivisionID = ''' + @DivisionID + '''
					'+ @sWhere +'
					AND (ISNULL(L01.VoucherNo,'''') LIKE ''%'+@TxtSearch+'%'' OR ISNULL(A02.ObjectName,'''') LIKE ''%'+@TxtSearch+'%''
					OR ISNULL(T04.CurrencyID,'''') LIKE ''%'+@TxtSearch+'%'') 
				ORDER BY L01.VoucherDate, L01.VoucherNo'

SET @sSQL = @sSQL+'
OFFSET '+STR(@PageNumber * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '

PRINT @sSQL
EXEC(@sSQL)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
