IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[LMP2072]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[LMP2072]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load danh sách hợp đồng bảo lãnh LMF2071 tại LMF4444
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by Tiểu Mai on 24/10/2017
----Modify on 15/2/2019 by Như Hàn: Bổ sung diễn giải
-- <Example>
/*  
 EXEC LMP2072 'AS','01/04/2017','',1,8
*/
----
CREATE PROCEDURE LMP2072 ( 
        @DivisionID VARCHAR(50),
		@VoucherDate DATETIME,
		@TxtSearch VARCHAR(250) = '',
		@PageNumber INT,
        @PageSize INT
) 
AS

DECLARE @TotalRow VARCHAR(50),
		@sSQL VARCHAR (MAX)
		
SET @TotalRow = ''
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

SET @sSQL = '
SELECT	ROW_NUMBER() OVER (ORDER BY T21.VoucherDate, T21.VoucherNo) AS RowNum, '+@TotalRow+' AS TotalRow,
		T21.VoucherID as GuaranteeVoucherID, T21.LimitVoucherID, T21.VoucherNo as GuaranteeVoucherNo, T21.CurrencyID,T21.ExchangeRate, 
		T21.OriginalAmount, T21.ConvertedAmount,
		T21.Parameter01,T21.Parameter02,T21.Parameter03,T21.Parameter04,T21.Parameter05,T21.Parameter06,T21.Parameter07,T21.Parameter08,
		T21.Parameter09,T21.Parameter10,T21.Parameter11,T21.Parameter12,T21.Parameter13,
		T21.Parameter14,T21.Parameter15,T21.Parameter16,T21.Parameter17,T21.Parameter18,T21.Parameter19,T21.Parameter20, 
		T21.Description as GuaranteeDescription, T11.OriginalAmount As BlockadeAmount
FROM LMT2051 T21 WITH (NOLOCK)
LEFT JOIN LMT2011 T11 WITH (NOLOCK) ON T21.VoucherID = T11.CreditVoucherID
WHERE T21.DivisionID = ''' + @DivisionID + '''
AND (''' + Convert(varchar(10),@VoucherDate,101) + ''' between Convert(varchar(10),T21.FromDate,101) and Convert(varchar(10),T21.ToDate,101))
AND (ISNULL(T21.VoucherNo,'''') LIKE ''%'+@TxtSearch+'%'' OR ISNULL(T21.Description,'''') LIKE ''%'+@TxtSearch+'%'') 
ORDER BY T21.VoucherDate, T21.VoucherNo'

SET @sSQL = @sSQL+'
OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '

--PRINT @sSQL
EXEC(@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
