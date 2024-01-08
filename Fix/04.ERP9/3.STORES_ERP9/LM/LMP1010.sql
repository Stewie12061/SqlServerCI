IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[LMP1010]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[LMP1010]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load Grid Form LMF1010 Danh mục hợp đồng hạn mức
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created on 25/06/2017 by Bảo Anh
----Modify on 09/01/2019 by Như Hàn bổ sung hiển thị phụ lục hợp đồng 
----Modify on 09/09/2020 by Kiều Nga Fix lỗi load tên ngân hàng 

-- <Example>
/*  
 EXEC LMP1010 'AS','01/01/2017','01/01/2017','01/2017,02/2017',1,'VND','ACB','',N'',1,8,0
*/
----
CREATE PROCEDURE LMP1010 ( 
        @DivisionID VARCHAR(50),
		@FromDate DATETIME,
		@ToDate DATETIME,
		@PeriodList VARCHAR(MAX),
		@IsDate BIT,
		@CurrencyID VARCHAR(50),
		@BankID VARCHAR(50),
		@VoucherNo VARCHAR(MAX),
		@Description NVARCHAR(250),
		@PageNumber INT,
        @PageSize INT,
		@IsExcel BIT --1: thực hiện xuất file Excel; 0: Thực hiện Filter
		
) 
AS 
DECLARE @sSQL NVARCHAR (MAX) = N'',
		@sWhere NVARCHAR(MAX),
		@TotalRow VARCHAR(50),
		@IsAppenConCaption NVARCHAR (250) = N''

		SET @IsAppenConCaption = @IsAppenConCaption + N'Là phụ lục hợp đồng'
SET @TotalRow = ''
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
       
SET @sWhere = ''
SET @PeriodList = REPLACE(@PeriodList,',',''',''')

IF @IsDate = 0
	SET @sWhere = @sWhere + ' AND ((CASE WHEN T01.TranMonth <10 THEN ''0'' ELSE '''' END) + rtrim(ltrim(str(T01.TranMonth)))+''/''+ltrim(Rtrim(str(T01.TranYear))) in ('''+@PeriodList +'''))'
ELSE
	SET @sWhere = @sWhere + ' AND (Convert(varchar(20),T01.VoucherDate,112) Between ''' + Convert(varchar(20),@FromDate,112) + ''' AND ''' + Convert(varchar(20),Isnull(@ToDate,'12/31/9999'),112) + ''')'
	

IF ISNULL(@CurrencyID,'') <> ''
	SET @sWhere = @sWhere + ' AND T01.CurrencyID = ''' + @CurrencyID + ''''
	
IF ISNULL(@BankID,'') <> ''
	SET @sWhere = @sWhere + ' AND T16.BankID = ''' + @BankID + ''''

IF ISNULL(@VoucherNo,'') <> ''
BEGIN
	IF ISNULL(@IsExcel,0) = 0
		SET @sWhere = @sWhere + N' AND T01.VoucherNo Like ''%' + @VoucherNo + '%'''
	ELSE 
		SET @sWhere = @sWhere + N' AND T01.VoucherNo IN (''' + @VoucherNo + ''')'
END

IF ISNULL(@Description,'') <> ''
	SET @sWhere = @sWhere + ' AND T01.Description Like ''%' + @Description + '%'''

SET @sSQL = @sSQL+ N'
	SELECT ROW_NUMBER() OVER (ORDER BY T01.VoucherNo) AS RowNum, '+@TotalRow+' AS TotalRow,
			T01.*, T16.BankName, T04.ExchangeRateDecimal, 
			CASE WHEN ISNULL(T01.IsAppendixofcontract,0) = 1 THEN N'''+@IsAppenConCaption+''' ELSE '''' END AS IsAppenConCaption, 
			T01.ContractNo
	FROM LMT1010 T01 WITH (NOLOCK)
	LEFT JOIN 
	(Select Distinct AT1202.ObjectID as BankID, AT1202.ObjectName as BankName
	From AT1202 WITH (NOLOCK)
	Where AT1202.DivisionID in (''@@@'',''' + @DivisionID + ''') And AT1202.Disabled = 0) T16 ON T01.BankID = T16.BankID
	LEFT JOIN AT1004  T04 WITH (NOLOCK) ON T04.CurrencyID = T01.CurrencyID	
	WHERE T01.DivisionID = ''' + @DivisionID + '''' + @sWhere+'
	ORDER BY T01.VoucherNo'

IF @IsExcel = 0
	SET @sSQL = @sSQL+'
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '

EXEC (@sSQL)
----print (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
