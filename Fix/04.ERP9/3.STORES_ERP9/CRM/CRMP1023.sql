IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP1023]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP1023]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- Load màn hình chọn nguồn đầu mối
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by:Hoài Bảo Date 04/07/2022
-- <Example>
/*	EXEC CRMP1023 @DivisionID=N'DTI',@TxtSearch=N'',@UserID=N'ASOFTADMIN',@PageNumber=N'1',@PageSize=N'25'
*/

 CREATE PROCEDURE CRMP1023 (
    @DivisionID NVARCHAR(2000),
    @TxtSearch NVARCHAR(250),
	@UserID VARCHAR(50),
    @PageNumber INT,
    @PageSize INT
)
AS
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50)

	SET @sWhere = ''
	SET @TotalRow = ''
	SET @OrderBy = ' M.LeadTypeID'

	IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = '0'
	
	IF ISNULL(@TxtSearch,'') != ''  SET @sWhere = @sWhere +'
							AND (M.LeadTypeID LIKE N''%'+@TxtSearch+'%'' 
							OR M.LeadTypeName LIKE N''%'+@TxtSearch+'%'' 
							OR M.[Description] LIKE N''%'+@TxtSearch+'%'')'

	SET @sSQL = '
				SELECT  ROW_NUMBER() OVER (ORDER BY M.LeadTypeID) AS RowNum, COUNT(*) OVER () AS TotalRow
				 , M.APK, M.DivisionID, M.LeadTypeID, M.LeadTypeName, M.[Description], M.IsCommon, M.[Disabled]
				 , M.CreateDate, M.CreateUserID, M.LastModifyDate, M.LastModifyUserID, M.RelatedToTypeID
				From (
					SELECT * 
					FROM CRMT10201 WITH (NOLOCK) 
					WHERE (DivisionID = ''' +@DivisionID+ ''' OR IsCommon = 1) AND ISNULL([Disabled],0) = 0
				 ) M
				WHERE 1=1  '+@sWhere+'
				ORDER BY M.LeadTypeID
				OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
				FETCH NEXT  '+STR(@PageSize)+' ROWS ONLY'
	PRINT (@sSQL)
	EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
