IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[LMP2070]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[LMP2070]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load Grid Form LMF2050 Danh mục gia hạn hợp đồng bảo lãnh
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by Tiểu Mai on 24/10/2017
----Modify on
-- <Example>
/*  
 EXEC LMP2070 'AS','01/01/2017','01/01/2017','01/2017,02/2017',1,'VND','ABCDE',1,8,0
*/
----
CREATE PROCEDURE LMP2070 ( 
        @DivisionID VARCHAR(50),
		@FromDate DATETIME,
		@ToDate DATETIME,
		@PeriodList NVARCHAR(MAX),
		@IsDate BIT,
		@CurrencyID NVARCHAR(50),
		@GuaranteeVoucherNo NVARCHAR(50),
		@PageNumber INT,
        @PageSize INT,
		@IsExcel BIT --1: thực hiện xuất file Excel; 0: Thực hiện Filter
		
) 
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@ProjectAnaTypeID varchar(50),
		@TotalRow VARCHAR(50)
    
SET @TotalRow = ''
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
    
SELECT @ProjectAnaTypeID = ISNULL(ProjectAnaTypeID,'') FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID
SET @sWhere = ''
SET @PeriodList = REPLACE(@PeriodList,',',''',''')

IF @IsDate = 0
	SET @sWhere = ' AND ((CASE WHEN T01.TranMonth <10 THEN ''0'' ELSE '''' END) + rtrim(ltrim(str(T01.TranMonth)))+''/''+ltrim(Rtrim(str(T01.TranYear))) in ('''+@PeriodList +'''))'
ELSE
	SET @sWhere = ' AND (Convert(varchar(20),T01.VoucherDate,103) Between ''' + Convert(varchar(20),@FromDate,103) + ''' AND ''' + Convert(varchar(20),Isnull(@ToDate,'12/31/9999'),103) + ''')'
	
IF ISNULL(@CurrencyID,'') <> ''
	SET @sWhere = @sWhere + ' AND T01.CurrencyID = ''' + @CurrencyID + ''''

IF ISNULL(@GuaranteeVoucherNo,'') <> ''
	SET @sWhere = @sWhere + ' AND T10.VoucherNo like ''%' + @GuaranteeVoucherNo + '%'''

SET @sSQL = N'
	SELECT ROW_NUMBER() OVER (ORDER BY T01.VoucherNo) AS RowNum, '+@TotalRow+' AS TotalRow,
			T01.*, T10.VoucherNo as GuaranteeVoucherNo, T04.ExchangeRateDecimal 
	FROM LMT2051 T01 WITH (NOLOCK)
	LEFT JOIN LMT2051 T10 WITH (NOLOCK) ON T01.DivisionID = T10.DivisionID And T01.GuaranteeVoucherID = T10.VoucherID
	LEFT JOIN AT1004  T04 WITH (NOLOCK) ON T04.CurrencyID = T01.CurrencyID	
	WHERE T01.DivisionID = ''' + @DivisionID + '''' + @sWhere+'
	ORDER BY T01.VoucherNo'

IF @IsExcel = 0
	SET @sSQL = @sSQL+'
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '

EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

