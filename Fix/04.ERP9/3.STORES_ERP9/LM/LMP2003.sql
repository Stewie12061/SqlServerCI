IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[LMP2003]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[LMP2003]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Đổ nguồn màn hình chọn hợp đồng bảo lãnh / LC (LMF2003)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created on 20/10/2017 by Hải Long
----Modify on 28/01/2019 by Như Hàn: Chỉnh sửa chọn HĐBL gọi từ màn hình vay để sử dụng kế thừa
-- <Example>
/*  
 EXEC LMP2003 @DivisionID = 'AS', @UserID = 'ASOFTADMIN',@PageNumber = 1,@PageSize = 10, @TxtSearch = 'ABC'
*/
----
CREATE PROCEDURE [LMP2003] 
( 
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@PageNumber INT,
	@PageSize INT,	
	@TxtSearch NVARCHAR(250)	
) 
AS

DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50)


SET @sWhere = ''
SET @TotalRow = ''
SET @OrderBy = 'CreateDate'

IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = '0'

IF @TxtSearch IS NOT NULL 
BEGIN
	SET @sWhere = @sWhere +'
	AND (LMT2051.VoucherNo LIKE N''%'+@TxtSearch+'%'' 
	OR LMT2051.Description LIKE N''%'+@TxtSearch+'%'')'	
END

--	SET @sSQL = '
--SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+N' AS TotalRow, *
--FROM
--(	
--	SELECT LMT2051.VoucherID AS ContractOfGuaranteeID, LMT2051.VoucherNo AS ContractOfGuaranteeNo, LMT2051.Description, 
--	LMT2051.ConvertedAmount - TB.ConvertedAmount AS ConvertedAmount, LMT2051.CreateDate
--	FROM LMT2051 WITH (NOLOCK)
--	LEFT JOIN 
--	(
--		SELECT DivisionID, VoucherID, SUM(ConvertedAmount) AS ConvertedAmount 
--		FROM LMT2052 WITH (NOLOCK)
--		GROUP BY DivisionID, VoucherID
--	) TB ON TB.DivisionID = LMT2051.DivisionID AND TB.VoucherID = LMT2051.VoucherID
--	WHERE LMT2051.ConvertedAmount - TB.ConvertedAmount > 0
--	AND LMT2051.DivisionID = ''' + @DivisionID + '''' + @sWhere + '
--) A 
--ORDER BY ' + @OrderBy + '
--OFFSET ' + CONVERT(NVARCHAR(10), (@PageNumber - 1) * @PageSize) + ' ROWS
--FETCH NEXT ' + CONVERT(NVARCHAR(10), @PageSize) + ' ROWS ONLY'	


SET @sSQL = '
SELECT	ROW_NUMBER() OVER (ORDER BY T21.VoucherDate, T21.VoucherNo) AS RowNum, '+@TotalRow+' AS TotalRow,
		T21.VoucherID AS ContractOfGuaranteeID, T21.VoucherNo AS ContractOfGuaranteeNo, T21.Description, 
		--T21.VoucherID, T21.VoucherNo, T21.Description,
		T10.VoucherNo as LimitVoucherNo,  
		T21.FromDate, T21.ToDate, T21.CurrencyID, T21.ExchangeRate,
		T21.OriginalAmount -  ISNULL(T51.OriginalAmount,0) as LimitAmount, T21.ConvertedAmount - ISNULL(T51.ConvertedAmount,0) as LimitCAmount, 
		T21.OriginalAmount, T21.ConvertedAmount
FROM LMT2051 T21 WITH (NOLOCK)
LEFT JOIN 
	(SELECT T1.ContractID, SUM(ISNULL(T1.OriginalAmount,0)) AS OriginalAmount, SUM(ISNULL(T1.ConvertedAmount,0)) AS ConvertedAmount 
	FROM LMT2053 T1	WITH (NOLOCK)
	GROUP BY T1.ContractID) T51 ON T21.VoucherID = T51.ContractID
LEFT JOIN LMT1010 T10 WITH (NOLOCK) ON T21.LimitVoucherID = T10.VoucherID
WHERE T21.DivisionID = ''' + @DivisionID + '''
AND (ISNULL(T21.VoucherNo,'''') LIKE ''%'+@TxtSearch+'%'' OR ISNULL(T21.Description,'''') LIKE ''%'+@TxtSearch+'%'') 
AND T21.OriginalAmount - ISNULL(T51.OriginalAmount,0) > 0
ORDER BY T21.VoucherDate, T21.VoucherNo'

SET @sSQL = @sSQL+'
OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '

--PRINT @sSQL
EXEC (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
