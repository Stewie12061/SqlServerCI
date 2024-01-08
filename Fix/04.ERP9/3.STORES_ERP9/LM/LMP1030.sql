IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[LMP1030]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[LMP1030]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load Grid Form LMF1030: Danh mục nguồn thanh toán
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Như Hàn, Date: 11/10/2018
-- <Example>
---- 
/*-- <Example>
LMP1030 @DivisionID, @DivisionList, @Paymentsource, @Descriptions, @Notes, @IsCommon, @Disable, @PageNumber, @PageSize
----*/

CREATE PROCEDURE LMP1030
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @Paymentsource NVARCHAR(500),
	 @Descriptions NVARCHAR(500),
	 @Notes NVARCHAR(500),
	 @IsCommon	VARCHAR(5),
	 @Disable VARCHAR(5),
	 @PageNumber INT,
	 @PageSize INT
)
AS 
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX)=N'',
        @OrderBy NVARCHAR(500)=N'',
        @TotalRow NVARCHAR(50)=N''

SET @OrderBy = 'T1.Paymentsource'
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

	IF Isnull(@DivisionList, '') <> ''
		BEGIN
			IF @DivisionList <> '%'
			SET @sWhere = @sWhere + ' T1.DivisionID IN ('''+@DivisionList+''', ''@@@'')'
		END
	ELSE SET @sWhere = @sWhere + ' T1.DivisionID IN ('''+@DivisionID+''', ''@@@'') '
	
	
	IF ISNULL(@Paymentsource,'') <> '' SET @sWhere = @sWhere + '
	AND T1.Paymentsource LIKE ''%'+@Paymentsource+'%'' '
	IF ISNULL(@Descriptions,'') <> '' SET @sWhere = @sWhere + '
	AND T1.Descriptions LIKE N''%'+@Descriptions+'%'' '
	IF ISNULL(@Notes,'') <> '' SET @sWhere = @sWhere + '
	AND T1.Notes LIKE N''%'+@Notes+'%'' '

	IF Isnull(@Disable, '') <> ''
		SET @sWhere = @sWhere + '
		AND T1.Disabled = '+STR(@Disable)+''

	IF Isnull(@IsCommon, '') <> ''
		SET @sWhere = @sWhere + '
		AND T1.IsCommon = '+STR(@IsCommon)+''
	
	SET @sSQL = '
		SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow,
		T1.APK
		,T1.DivisionID
		,T1.Paymentsource
		,T1.Descriptions
		,T1.Notes
		,T1.Disabled
		,T1.IsCommon
		,T1.CreateDate
		,T1.CreateUserID
		,T1.LastModifyDate
		,T1.LastModifyUserID
		FROM LMT1030 T1 WITH (NOLOCK) 
		WHERE 1=1 AND '+@sWhere +'
		ORDER BY '+@OrderBy+'

		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'


EXEC (@sSQL)
--PRINT(@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
