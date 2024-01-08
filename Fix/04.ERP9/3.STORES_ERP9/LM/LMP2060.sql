IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[LMP2060]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[LMP2060]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load Grid Form HRF2060: Danh sách giải chấp tài sản
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hải Long, Date: 21/09/2017
-- <Example>
---- 
/*-- <Example>
	LMP2060 @DivisionID='AS',@UserID='ASOFTADMIN',@FromDate='2017-01-01',@ToDate='2017-12-01',@PeriodList='01/2017,02/2017',@IsDate=0,@PageNumber=1,@PageSize=25,@IsSearch=1,@LoanVoucherNo='ABC',@Description='DEF',@IsExcel=1
----*/

CREATE PROCEDURE [dbo].[LMP2060]
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @FromDate DATETIME,
	 @ToDate DATETIME,
	 @PeriodList VARCHAR(MAX),
	 @IsDate BIT,		 
	 @IsSearch TINYINT, 
	 @LoanVoucherNo NVARCHAR(50),
	 @Description NVARCHAR(250),
	 @IsExcel BIT --1: thực hiện xuất file Excel; 0: Thực hiện Filter	 
)
AS 
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500) = 'LoanVoucherNo, UnwindDate',
        @TotalRow NVARCHAR(50) = ''
        
IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL' 	

SET @sWhere = ''
SET @PeriodList = REPLACE(@PeriodList,',',''',''')
       
IF @IsDate = 0
	SET @sWhere = @sWhere + ' AND ((CASE WHEN LMT2060.TranMonth <10 THEN ''0'' ELSE '''' END) + rtrim(ltrim(str(LMT2060.TranMonth)))+''/''+ltrim(Rtrim(str(LMT2060.TranYear))) in ('''+@PeriodList +'''))'

	       

IF  @IsSearch = 1
BEGIN
	IF ISNULL(@LoanVoucherNo,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + '
		AND LMT2001.VoucherNo LIKE N''%' + @LoanVoucherNo + '%'''	
	END
	 
	IF ISNULL(@Description,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + '
		AND LMT2060.Description = N''' + @Description + ''''		
	END
END	

IF @IsExcel = 0
BEGIN
	SET @sSQL = N'
		SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+N' AS TotalRow, *
		FROM
		(
			SELECT  LMT2060.APK, LMT2060.DivisionID, LMT2060.VoucherID, LMT2060.TranMonth, LMT2060.TranYear, LMT2060.LoanVoucherID,
					LMT2060.UnwindDate, LMT2060.Description, LMT2001.VoucherNo	AS LoanVoucherNo, LMT2001.FromDate, LMT2001.ToDate, LMT2001.ConvertedAmount AS LoanConvertedAmount,
					SUM(LMT2061.UnwindAmount) AS UnwindAmount
			FROM LMT2060 WITH (NOLOCK)
			LEFT JOIN LMT2001 WITH (NOLOCK) ON LMT2060.DivisionID = LMT2001.DivisionID And LMT2060.LoanVoucherID = LMT2001.VoucherID
			INNER JOIN LMT2061 WITH(NOLOCK) ON  LMT2060.DivisionID = LMT2061.DivisionID And LMT2060.VoucherID = LMT2061.VoucherID
			WHERE LMT2060.DivisionID = ''' + @DivisionID + ''''+@sWhere +'	
			GROUP BY LMT2060.APK, LMT2060.DivisionID, LMT2060.VoucherID, LMT2060.TranMonth, LMT2060.TranYear, LMT2060.LoanVoucherID,
					LMT2060.UnwindDate, LMT2060.Description,  LMT2001.VoucherNo, LMT2001.FromDate, LMT2001.ToDate, LMT2001.ConvertedAmount
		) A 
		ORDER BY ' + @OrderBy + '
		OFFSET ' + CONVERT(NVARCHAR(10), (@PageNumber - 1) * @PageSize) + ' ROWS
		FETCH NEXT ' + CONVERT(NVARCHAR(10), @PageSize) + ' ROWS ONLY'	
END
ELSE
BEGIN
	SET @sSQL = N'	
		SELECT	LMT2060.APK, LMT2060.DivisionID, LMT2060.VoucherID, LMT2060.TranMonth, LMT2060.TranYear, LMT2060.LoanVoucherID,
				LMT2060.UnwindDate, LMT2060.Description,LMT2001.VoucherNo	AS LoanVoucherNo, LMT2001.FromDate, LMT2001.ToDate, LMT2001.ConvertedAmount AS LoanConvertedAmount, SUM(LMT2061.UnwindAmount) AS UnwindAmount
		FROM LMT2060 WITH (NOLOCK)
		LEFT JOIN LMT2001 WITH (NOLOCK) ON LMT2060.DivisionID = LMT2001.DivisionID And LMT2060.LoanVoucherID = LMT2001.VoucherID
		INNER JOIN LMT2061 WITH(NOLOCK) ON  LMT2060.DivisionID = LMT2061.DivisionID And LMT2060.VoucherID = LMT2061.VoucherID
		WHERE LMT2060.DivisionID = ''' + @DivisionID + ''''+@sWhere		+'
		GROUP BY LMT2060.APK, LMT2060.DivisionID, LMT2060.VoucherID, LMT2060.TranMonth, LMT2060.TranYear, LMT2060.LoanVoucherID,
				LMT2060.UnwindDate, LMT2060.Description,  LMT2001.VoucherNo, LMT2001.FromDate, LMT2001.ToDate, LMT2001.ConvertedAmount
		'
END



--PRINT(@sSQL)
EXEC (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

