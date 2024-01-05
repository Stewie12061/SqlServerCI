IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[FNP2000]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[FNP2000]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





----- Created by Như Hàn
---- Created Date 05/11/2018
---- Purpose: Đổ nguồn lưới danh mục kế hoạch thu chi
---- Modified on ... by ...

/*
exec FNP2000 @DivisionID=N'AS',@VoucherNo=NULL,@PriorityID=N'UT001',@EmployeeID=N'',@Status=NULL,@FromDate='2018-11-08 00:00:00',@ToDate='2018-11-10 00:00:00',@ObjectProposalID=N'',@Ana01ID=NULL,@Ana02ID=NULL,@Ana03ID=NULL,@Ana04ID=NULL,@Ana05ID=NULL,@Ana06ID=NULL,@Ana07ID=NULL,@Ana08ID=NULL,@Ana09ID=NULL,@Ana10ID=NULL,@LanguageID = 'vi-VN', @PageNumber=1,@PageSize=10,@IsExcel=NULL,@APKList=NULL
EXEC FNP2000
@DivisionID = ''
,@VoucherNo = '123'
,@PriorityID = '123'
,@EmployeeID = '123'
,@FromDate = '2018/11/20'
,@ToDate = '2018/11/20'
,@Status = 1
,@ObjectProposalID = '123'
,@Ana01ID = '123'
,@Ana02ID = '123'
,@Ana03ID = '123'
,@Ana04ID = '123'
,@Ana05ID = '123'
,@Ana06ID = '123'
,@Ana07ID = '123'
,@Ana08ID = '123'
,@Ana09ID = '123'
,@Ana10ID = '123'
,@LanguageID = ''
,@PageNumber = ''
,@PageSize = ''
,@IsExcel = ''
,@APKList = ''
*/

CREATE PROCEDURE [dbo].[FNP2000] 	
				@DivisionID varchar(50),
				@DivisionList NVARCHAR(max) = '',  --Chọn
				@VoucherNo varchar(50),
				@PriorityID  varchar(50),
				@EmployeeID varchar(50),
				@FromDate Datetime,
				@ToDate Datetime,
				@Status int,
				@ObjectProposalID varchar(50),
				@Ana01ID varchar(50),
				@Ana02ID varchar(50),
				@Ana03ID varchar(50),
				@Ana04ID varchar(50),
				@Ana05ID varchar(50),
				@Ana06ID varchar(50),
				@Ana07ID varchar(50),
				@Ana08ID varchar(50),
				@Ana09ID varchar(50),
				@Ana10ID varchar(50),
				@LanguageID VARCHAR(50),
				@PageNumber INT,
				@PageSize INT,
				@IsExcel BIT, --1: thực hiện xuất file Excel; 0: Thực hiện load danh sách
				@APKList XML,
				@TypeID varchar(50) = '',
				@IsDate INT = 1,
				@Period NVARCHAR(4000) = ''
				
AS

DECLARE @WHERE varchar(max) = '', 
		@SQL varchar(max) = '',
		@TotalRow VARCHAR(50),
		@sJoin VARCHAR(MAX) = ''

SET @TotalRow = ''
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

IF @APKList IS NOT NULL
BEGIN
	CREATE TABLE #TAM (APK VARCHAR(50))
	INSERT INTO #TAM (APK)
	SELECT X.Data.query('APK').value('.', 'VARCHAR(50)') AS APK
	FROM @APKList.nodes('//Data') AS X (Data)
END	


IF ISNULL(@DivisionList, '') <> '' 
	SET @WHERE = @WHERE + ' AND T20.DivisionID IN ('''+@DivisionList+''')'
ELSE 
	SET @WHERE = @WHERE + ' AND T20.DivisionID = '''+@DivisionID+''''

IF @IsDate = 1 
BEGIN
IF ISNULL(@FromDate,'') <> '' AND ISNULL(@ToDate,'') <> ''
SET @WHERE = @WHERE + ' AND CONVERT(VARCHAR(10),T20.VoucherDate,21) BETWEEN '''+ CONVERT(VARCHAR(10),@FromDate,21)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,21)+''''
END
IF @IsDate = 0 
BEGIN
IF ISNULL(@Period,'')<>''
SET @WHERE = @WHERE + ' AND (CASE WHEN T20.TranMonth <10 THEN ''0''+rtrim(ltrim(str(T20.TranMonth)))+''/''+ltrim(Rtrim(str(T20.TranYear))) 
				ELSE rtrim(ltrim(str(T20.TranMonth)))+''/''+ltrim(Rtrim(str(T20.TranYear))) END) in ('''+@Period +''')'
END

IF ISNULL(@TypeID,'') <> ''
SET @WHERE = @WHERE + ' AND T20.TypeID = '''+@TypeID+''''

IF ISNULL(@VoucherNo,'') <>''
SET @WHERE = @WHERE + '
	 AND T20.VoucherNo LIKE ''%'+@VoucherNo+'%'''

IF ISNULL(@PriorityID,'') <> ''
SET @WHERE = @WHERE + '
	AND T20.PriorityID = '''+@PriorityID+''''

IF ISNULL(@Status,0) <> 0
SET @WHERE = @WHERE + '
	AND T20.Status = '+LTrim(@Status)+''

IF ISNULL(@ObjectProposalID,'')<>''
SET @WHERE = @WHERE + '
	AND T21.ObjectProposalID = '''+@ObjectProposalID+''''


IF ISNULL(@Ana01ID,'') <> ''
BEGIN
	SET @WHERE = @WHERE + ' AND (T20.Ana01ID like ''%' + @Ana01ID + '%'' OR A11.AnaName like N''%' + @Ana01ID + '%'')'
	SET @sJoin = @sJoin + '
	LEFT JOIN AT1011 A11 WITH (NOLOCK) ON T20.Ana01ID = A11.AnaID AND A11.AnaTypeID = ''A01'''
END

IF ISNULL(@Ana02ID,'') <> ''
BEGIN
	SET @WHERE = @WHERE + ' AND (T20.Ana02ID like ''%' + @Ana02ID + '%'' OR A12.AnaName like N''%' + @Ana02ID + '%'')'
	SET @sJoin = @sJoin + '
	LEFT JOIN AT1011 A12 WITH (NOLOCK) ON T20.Ana02ID = A12.AnaID AND A12.AnaTypeID = ''A02'''
END

IF ISNULL(@Ana03ID,'') <> ''
BEGIN
	SET @WHERE = @WHERE + ' AND (T20.Ana03ID like ''%' + @Ana03ID + '%'' OR A13.AnaName like N''%' + @Ana03ID + '%'')'
	SET @sJoin = @sJoin + '
	LEFT JOIN AT1011 A13 WITH (NOLOCK) ON T20.Ana03ID = A13.AnaID AND A13.AnaTypeID = ''A03'''
END

IF ISNULL(@Ana04ID,'') <> ''
BEGIN
	SET @WHERE = @WHERE + ' AND (T20.Ana04ID like ''%' + @Ana04ID + '%'' OR A14.AnaName like N''%' + @Ana04ID + '%'')'
	SET @sJoin = @sJoin + '
	LEFT JOIN AT1011 A14 WITH (NOLOCK) ON T20.Ana04ID = A14.AnaID AND A14.AnaTypeID = ''A04'''
END

IF ISNULL(@Ana05ID,'') <> ''
BEGIN
	SET @WHERE = @WHERE + ' AND (T20.Ana05ID like ''%' + @Ana05ID + '%'' OR A15.AnaName like N''%' + @Ana05ID + '%'')'
	SET @sJoin = @sJoin + '
	LEFT JOIN AT1011 A15 WITH (NOLOCK) ON T20.Ana05ID = A15.AnaID AND A15.AnaTypeID = ''A05'''
END

IF ISNULL(@Ana06ID,'') <> ''
BEGIN
	SET @WHERE = @WHERE + ' AND (T20.Ana06ID like ''%' + @Ana06ID + '%'' OR A16.AnaName like N''%' + @Ana06ID + '%'')'
	SET @sJoin = @sJoin + '
	LEFT JOIN AT1011 A16 WITH (NOLOCK) ON T20.Ana06ID = A16.AnaID AND A16.AnaTypeID = ''A06'''
END

IF ISNULL(@Ana07ID,'') <> ''
BEGIN
	SET @WHERE = @WHERE + ' AND (T20.Ana07ID like ''%' + @Ana07ID + '%'' OR A17.AnaName like N''%' + @Ana07ID + '%'')'
	SET @sJoin = @sJoin + '
	LEFT JOIN AT1011 A17 WITH (NOLOCK) ON T20.Ana07ID = A17.AnaID AND A17.AnaTypeID = ''A07'''
END

IF ISNULL(@Ana08ID,'') <> ''
BEGIN
	SET @WHERE = @WHERE + ' AND (T20.Ana08ID like ''%' + @Ana08ID + '%'' OR A18.AnaName like N''%' + @Ana08ID + '%'')'
	SET @sJoin = @sJoin + '
	LEFT JOIN AT1011 A18 WITH (NOLOCK) ON T20.Ana08ID = A18.AnaID AND A18.AnaTypeID = ''A08'''
END

IF ISNULL(@Ana09ID,'') <> ''
BEGIN
	SET @WHERE = @WHERE + ' AND (T20.Ana09ID like ''%' + @Ana09ID + '%'' OR A19.AnaName like N''%' + @Ana09ID + '%'')'
	SET @sJoin = @sJoin + '
	LEFT JOIN AT1011 A19 WITH (NOLOCK) ON T20.Ana09ID = A19.AnaID AND A19.AnaTypeID = ''A09'''
END

IF ISNULL(@Ana10ID,'') <> ''
BEGIN
	SET @WHERE = @WHERE + ' AND (T20.Ana10ID like ''%' + @Ana10ID + '%'' OR A20.AnaName like N''%' + @Ana10ID + '%'')'
	SET @sJoin = @sJoin + '
	LEFT JOIN AT1011 A20 WITH (NOLOCK) ON T20.Ana10ID = A20.AnaID AND A20.AnaTypeID = ''A10'''
END

IF ISNULL(@EmployeeID,'') <>''
BEGIN
SET @WHERE = @WHERE + '
	AND (T20.EmployeeID like ''%'+@EmployeeID+'%'' OR T03.FullName Like N''%'+@EmployeeID+'%'')'
END

--Print (@WHERE)

SET @SQL = @SQL + '

SELECT	DISTINCT
		T20.APK
		,T20.DivisionID
		,VoucherNo
		,VoucherDate
		,T20.EmployeeID
		,T03.FullName
		,PayMentPlanDate
		,Descriptions
		,T20.PriorityID
		,T10.PriorityName
		,T20.Status
		,CASE WHEN ISNULL(''' + @LanguageID + ''','''') = ''vi-VN'' THEN T09.[Description] ELSE T09.DescriptionE END AS StatusName
		,ApprovalDate
		,TypeID
		,CASE WHEN ISNULL(''' + @LanguageID + ''','''') = ''vi-VN'' THEN T19.[Description] ELSE T19.DescriptionE END AS TypeName
INTO	#FNT2000
FROM	FNT2000 T20 WITH (NOLOCK)
INNER JOIN FNT2001 T21 WITH (NOLOCK) ON T20.APK = T21.APKMaster AND T20.DivisionID = T21.DivisionID
LEFT JOIN AT1103 T03 WITH (NOLOCK) ON T03.EmployeeID = T20.EmployeeID
LEFT JOIN FNT1020 T10 WITH (NOLOCK) ON T10.PriorityID = T20.PriorityID
LEFT JOIN FNT0099 T09 WITH (NOLOCK) ON T09.ID = T20.Status AND T09.CodeMaster = ''Status''
LEFT JOIN FNT0099 T19 WITH (NOLOCK) ON T19.ID = T20.TypeID AND T19.CodeMaster = ''TypeID''
'+@sJoin+'
WHERE	T20.DeleteFlag = 0 '+@WHERE+'


SELECT ROW_NUMBER() OVER (ORDER BY T20.VoucherDate, T20.VoucherNo) AS RowNum, '+@TotalRow+' AS TotalRow, T20.*
FROM #FNT2000 T20'

IF @IsExcel = 1
	SET @SQL = @SQL + N'
INNER JOIN #TAM ON T20.APK = #TAM.APK'

IF @IsExcel = 0
	SET @SQL = @SQL+'
	ORDER BY T20.VoucherDate, T20.VoucherNo
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '

EXEC (@SQL)
--PRINT @SQL


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

