IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[LMP2052]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[LMP2052]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Load danh sách hợp đồng vay LMF2051 gọi LMF4444
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by Tiểu Mai on 12/10/2017
----Modify on
-- <Example>
/*  
 EXEC LMP2052 'AS','01/04/2017','',1,8
*/
----
CREATE PROCEDURE LMP2052 ( 
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
		T21.VoucherID as ContractID, T21.VoucherNo as ContractNo, T21.Description, 
		T21.OriginalAmount -  ISNULL(T51.OriginalAmount,0) as LimitAmount, T21.ConvertedAmount - ISNULL(T51.ConvertedAmount,0) as LimitCAmount, 
		T21.OriginalAmount -  ISNULL(T51.OriginalAmount,0)  as  OriginalAmount, T21.OriginalAmount - ISNULL(T51.ConvertedAmount,0) as  ConvertedAmount
FROM LMT2001 T21 WITH (NOLOCK)
LEFT JOIN 
	(SELECT T1.ContractID, SUM(ISNULL(T1.OriginalAmount,0)) AS OriginalAmount, SUM(ISNULL(T1.ConvertedAmount,0)) AS ConvertedAmount 
	FROM LMT2053 T1	WITH (NOLOCK)
	GROUP BY T1.ContractID ) T51 ON T21.VoucherID = T51.ContractID
WHERE T21.DivisionID = ''' + @DivisionID + '''
AND (''' + Convert(varchar(10),@VoucherDate,101) + ''' between T21.FromDate and T21.ToDate )
AND (ISNULL(T21.VoucherNo,'''') LIKE ''%'+@TxtSearch+'%'' OR ISNULL(T21.Description,'''') LIKE ''%'+@TxtSearch+'%'') 
AND T21.OriginalAmount - ISNULL(T51.OriginalAmount,0) > 0
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

