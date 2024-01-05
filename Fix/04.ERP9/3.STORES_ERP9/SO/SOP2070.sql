IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP2070]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP2070]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Grid Form SOF2070 Nghiệp vụ kế hoạch bán hàng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Dũng DV, Date 16/11/2019
----Modify by: Kiều Nga, Date 28/04/2020 Điều chỉnh phân loại 'Nội bộ' -> 'Nội địa'

-- <Example>
/* 
exec SOP2070 @DivisionID=N'NN'',''TD',@DivisionIDList=N'',@ObjectName=N'',@YearPlan=N'',@Type=N'',@IsDate=1,@FromDate='2018-11-16 00:00:00',@ToDate='2019-11-16 00:00:00',@Period=N'',@UserID=N'SUPPORT2',@strWhere=N'',@PageNumber=1,@PageSize=25
*/
----
CREATE PROCEDURE SOP2070 ( 
        @DivisionID VARCHAR(50),  --Biến môi trường
		@DivisionIDList NVARCHAR(2000),  --Chọn trong DropdownChecklist DivisionID	      
		@ObjectName  NVARCHAR(250),
		@YearPlan  NVARCHAR(50),		
		@Type  NVARCHAR(250),		
		@IsDate TINYINT,--0: theo ngày, 1: Theo kỳ
		@FromDate Datetime,
		@ToDate Datetime,
		@Period NVARCHAR(4000), --Chọn trong DropdownChecklist Chọn kỳ
		@UserID  VARCHAR(50),
		@strWhere NVARCHAR(MAX) = NULL,
		@PageNumber INT,
		@PageSize INT		
) 
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50),
		@XK NVARCHAR(50) =N'Xuất khẩu',
		@NB NVARCHAR(50) =N'Nội địa';
        
SET @sWhere='WHERE P70.VoucherNo IS NOT NULL AND ISNULL(P70.DeleteFlg,0) = 0 AND '
SET @OrderBy = ' P70.CreateDate'
		IF @IsDate = 1 
		begin
		SET @sWhere = @sWhere + ' CONVERT(VARCHAR(10),P70.VoucherDate,112) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,112)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,112)+''' '
		end
	Else 
	BEGIN
		SET @sWhere = @sWhere + ' (Case When  MONTH(P70.VoucherDate) <10 then ''0''+rtrim(ltrim(str(MONTH(P70.VoucherDate))))+''/''+ltrim(Rtrim(str(YEAR(P70.VoucherDate)))) 
									Else rtrim(ltrim(str(MONTH(P70.VoucherDate))))+''/''+ltrim(Rtrim(str(YEAR(P70.VoucherDate)))) End) IN ('''+@Period+''')'
	end

	--Check Para DivisionIDList null then get DivisionID 
	IF Isnull(@DivisionIDList, '')!=''
		SET @sWhere = @sWhere + ' AND P70.DivisionID IN ('''+@DivisionIDList+''')'
	Else 
		SET @sWhere = @sWhere + ' AND P70.DivisionID IN ('''+@DivisionID+''')'
	
	IF Isnull(@YearPlan, '') != '' 
		SET @sWhere = @sWhere + ' AND ISNULL(P70.YearPlan, '''') LIKE N''%'+@YearPlan+'%'' '

	IF Isnull(@Type, '') != '' 
		SET @sWhere = @sWhere + ' AND ISNULL(P70.Type, '''') LIKE N''%'+@Type+'%''' 

	IF Isnull(@ObjectName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(AT02.ObjectName, '''') LIKE N''%'+@ObjectName+'%'' '
	

IF ISNULL(@strWhere,'')!=''
BEGIN
	IF @strWhere LIKE '%IsNull%'
	SET @strWhere = REPLACE(@strWhere,''',''',',''''')
	IF @strWhere LIKE '%DivisionID%'
	SET @strWhere = REPLACE(@strWhere,'DivisionID','P70.DivisionID')
	SET @sWhere=@strWhere;
END

SET @sSQL = '	
Declare @Count int
	Select @Count = Count(VoucherNo) From  SOT2070 as P70 
	JOIN AT1202(NOLOCK) AS AT02 ON AT02.ObjectID = P70.ObjectID 
	' +@sWhere + ';
SELECT  ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum,@Count AS TotalRow, P70.APK ,
       P70.DivisionID,P70.VoucherNo,P70.VoucherDate,AT02.ObjectName,CASE when P70.Type = 0 THEN N'''+@NB+''' ELSE N'''+@XK+''' END AS [Type],p70.YearPlan   
FROM SOT2070 (NOLOCK) AS P70
JOIN AT1202(NOLOCK) AS AT02 ON AT02.ObjectID = P70.ObjectID
 '+@sWhere+'
	ORDER BY '+@OrderBy+'
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '

EXEC (@sSQL)

print (@sSQL)
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
