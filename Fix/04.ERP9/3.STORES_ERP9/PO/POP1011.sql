﻿IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP1011]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP1011]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load Grid Form POF1010: Danh mục Mẫu kế hoạch nhận hàng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Như Hàn, Date: 12/12/2018
-- <Example>
---- 
/*-- <Example>
POP1011 @DivisionID, @DivisionList, @UserID, @PageNumber, @PageSize, @FormPlanID, @Description, @IsCommon, @Disable
----*/

CREATE PROCEDURE POP1011
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @FormPlanID VARCHAR(50),
	 @Description NVARCHAR(250),
	 @IsCommon	VARCHAR(5),
	 @Disable VARCHAR(5)
)
AS 
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX)=N'',
        @OrderBy NVARCHAR(500)=N'',
        @TotalRow NVARCHAR(50)=N''

SET @OrderBy = 'T1.FormPlanID'
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

	IF Isnull(@DivisionList, '') <> ''
		BEGIN
			IF @DivisionList <> '%'
			SET @sWhere = @sWhere + ' T1.DivisionID IN ('''+@DivisionList+''', ''@@@'')'
		END
	ELSE SET @sWhere = @sWhere + ' T1.DivisionID IN ('''+@DivisionID+''', ''@@@'') '
	
	
	IF ISNULL(@FormPlanID,'') <> '' SET @sWhere = @sWhere + '
	AND T1.FormPlanID LIKE ''%'+@FormPlanID+'%'' '
	IF ISNULL(@Description,'') <> '' SET @sWhere = @sWhere + '
	AND T1.Description LIKE N''%'+@Description+'%'' '

	IF ISNULL(@Disable,'') <> '' 
		SET @sWhere = @sWhere + '
		AND T1.Disabled = '+STR(@Disable)+''

	IF ISNULL(@IsCommon,'') <> ''
		SET @sWhere = @sWhere + '
		AND T1.IsCommon = '+STR(@IsCommon)+''

	
	SET @sSQL = '
		SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow,
		T1.APK
		, T1.DivisionID
		, T1.FormPlanID
		, T1.Description
		, T1.Disabled
		, T1.IsCommon
		, T1.CreateDate
		, T1.CreateUserID
		, T1.LastModifyDate
		, T1.LastModifyUserID
		FROM POT1010 T1 WITH (NOLOCK)
		WHERE '+@sWhere +'
		ORDER BY '+@OrderBy+'

		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'


	EXEC (@sSQL)
PRINT(@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
