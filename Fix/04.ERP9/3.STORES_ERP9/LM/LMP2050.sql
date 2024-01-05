IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[LMP2050]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[LMP2050]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load Grid Form LMF2050 Danh mục hợp đồng bảo lãnh
-- <Param>
---- 
-- <Return>
---- a
-- <Reference>
---- 
-- <History>
----Created by Tiểu Mai on 12/10/2017
----Modify on 09/09/2020 by Kiều Nga Fix lỗi load tên ngân hàng 
-- <Example>
/*  
 EXEC LMP2050 'AS','01/01/2017','01/01/2017','01/2017,02/2017',1,'VND','ACB','123','VTD','ABCD',0,N'diễn',1,8,0
*/
----
CREATE PROCEDURE LMP2050 ( 
        @DivisionID VARCHAR(50),
		@FromDate DATETIME,
		@ToDate DATETIME,
		@PeriodList VARCHAR(MAX),
		@IsDate BIT,
		@CurrencyID VARCHAR(50),
		@BankID VARCHAR(50),
		@LimitVoucherNo VARCHAR(50),
		@CreditFormID VARCHAR(50),
		@ProjectID NVARCHAR(250),
		@Status TINYINT,
		@Description NVARCHAR(250),
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
	SET @sWhere = ' AND (T01.VoucherDate Between ''' + Convert(varchar(20),@FromDate,120) + ''' AND ''' + Convert(varchar(20),Isnull(@ToDate,'12/31/9999'),120) + ''')'
	
IF ISNULL(@CurrencyID,'') <> ''
	SET @sWhere = @sWhere + ' AND T01.CurrencyID = ''' + @CurrencyID + ''''

IF ISNULL(@BankID,'') <> ''
	SET @sWhere = @sWhere + ' AND T10.BankID = ''' + @BankID + ''''

IF ISNULL(@LimitVoucherNo,'') <> ''
	SET @sWhere = @sWhere + ' AND T10.VoucherNo like ''%' + @LimitVoucherNo + '%'''

IF ISNULL(@CreditFormID,'') <> ''
	SET @sWhere = @sWhere + ' AND T01.CreditFormID = ''' + @CreditFormID + ''''

IF ISNULL(@ProjectID,'') <> ''
	SET @sWhere = @sWhere + ' AND (T01.ProjectID like ''%' + @ProjectID + '%'' OR A11.AnaName like N''%' + @ProjectID + '%'')'

IF @Status IS NOT NULL
	SET @sWhere = @sWhere + ' AND T01.Status = ' + LTRIM(@Status)

IF ISNULL(@Description,'') <> ''
	SET @sWhere = @sWhere + ' AND T01.Description Like N''%' + @Description + '%'''

SET @sSQL = N'
	SELECT ROW_NUMBER() OVER (ORDER BY T01.VoucherNo) AS RowNum, '+@TotalRow+' AS TotalRow,
			T01.*, T10.BankID, T16.BankName, T00.CreditFormName, T10.VoucherNo as LimitVoucherNo, A11.AnaName as ProjectName, T04.ExchangeRateDecimal 
	FROM LMT2051 T01 WITH (NOLOCK)
	LEFT JOIN LMT1010 T10 WITH (NOLOCK) ON T01.DivisionID = T10.DivisionID And T01.LimitVoucherID = T10.VoucherID
	LEFT JOIN (Select Distinct AT1202.ObjectID as BankID, AT1202.ObjectName as BankName
	From AT1202 WITH (NOLOCK)
	Where AT1202.DivisionID in (''@@@'',''' + @DivisionID + ''') And AT1202.Disabled = 0) T16 ON T10.BankID = T16.BankID
	LEFT JOIN LMT1001 T00 WITH (NOLOCK) ON T01.CreditFormID = T00.CreditFormID
	LEFT JOIN AT1011 A11 WITH (NOLOCK) ON T01.ProjectID = A11.AnaID And A11.AnaTypeID = ''' + @ProjectAnaTypeID + '''
	LEFT JOIN AT1004  T04 WITH (NOLOCK) ON T04.CurrencyID = T01.CurrencyID	
	WHERE T01.DivisionID = ''' + @DivisionID + '''' + @sWhere+'
	ORDER BY T01.VoucherNo'

IF @IsExcel = 0
	SET @sSQL = @sSQL+'
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '

EXEC (@sSQL)
--print @sSQL



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

