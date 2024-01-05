IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP90141]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[CRMP90141]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
--- Load màn hình chọn đầu mối
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by:Thị Phượng Date 30/03/2017
--- Modify by Thị Phượng, Date 08/05/2017: Bổ sung phân quyền
--- Modify by Hồng Thảo , Date 15/8/2019: Bổ sung cột Prefix
--- Modify by Đình Hòa, Date 26/05/2021: Bổ sung load thêm đơn vị dùng chung 
-- <Example>
/*

	exec CRMP90141 @DivisionID=N'AS',@TxtSearch=N'',@UserID=N'CALL002',@PageNumber=N'1',@PageSize=N'10'
	, @ConditionLeadID= N'ASOFTADMIN'', ''DANH'', ''HOANG'', ''HUYEN'', ''LIEN'', ''LUAN'', ''PHUONG'', ''QUI'', ''QUYNH'', ''VU' 
*/

 CREATE PROCEDURE CRMP90141 (
     @DivisionID NVARCHAR(2000),
     @TxtSearch NVARCHAR(250),
	 @UserID VARCHAR(50),
     @PageNumber INT,
     @PageSize INT,
	 @ConditionLeadID nvarchar(max)
)
AS
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50)
DECLARE @CustomerName INT
IF EXISTS (SELECT *	FROM tempdb.dbo.sysobjects WHERE ID = OBJECT_ID(N'tempdb.dbo.#CustomerName')) 
DROP TABLE #CustomerName
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName) 

	SET @sWhere = ''
	SET @TotalRow = ''
	SET @OrderBy = ' A.LeadID, A.LeadName'

	IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
	
	
	IF Isnull(@TxtSearch,'') != ''  SET @sWhere = @sWhere +'
							AND (A.LeadID LIKE N''%'+@TxtSearch+'%'' 
							OR A.LeadName LIKE N''%'+@TxtSearch+'%'' 
							OR A.Address LIKE N''%'+@TxtSearch+'%'' 
							OR isnull(A.LeadMobile, A.LeadTel) LIKE N''%'+@TxtSearch+'%'' 
							OR A.Email LIKE N''%'+@TxtSearch + '%'' 
							OR A.AssignedToUserID LIKE N''%'+@TxtSearch+'%'')'
	IF Isnull(@ConditionLeadID,'')!=''
		SET @sWhere = @sWhere + ' AND ISNULL(A.AssignedToUserID,A.CreateUserID) in ('''+@ConditionLeadID+''' )'
	SET @sSQL = '
				SELECT  A.LeadID, A.LeadName, A.DivisionID
							, A.Address, isnull(A.LeadMobile, A.LeadTel) as LeadMobile
							, A.Email,A.Prefix, A.LeadTypeID
							, A.BirthDate, A.LeadStatusID
							, C.Description as LeadStatusName
							, A.LeadSourceID, B.Description as LeadSourceName
							, A.AssignedToUserID
							, A.RelatedToTypeID, A.APK, A.CreateUserID, A.CreateDate
				Into #TemCRMT20301
				FROM CRMT20301 A WITH (NOLOCK)
				Left join CRMT0099 B  WITH (NOLOCK) On A.LeadSourceID = B.ID and B.CodeMaster =''CRMT00000008''
				Left join CRMT0099 C  WITH (NOLOCK) On A.LeadStatusID = C.ID and C.CodeMaster =''CRMT00000007''
				WHERE A.DivisionID IN ('''+@DivisionID+''', ''@@@'')  '+@sWhere+'
		DECLARE @count int
		Select @count = Count(LeadID) From #TemCRMT20301
		SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow
							, A.LeadID, A.LeadName, A.DivisionID
							, A.Address,  A.LeadMobile
							, A.Email,A.Prefix, A.LeadTypeID
							, A.BirthDate, A.LeadStatusID
							, A.LeadStatusName
							, A.LeadSourceID, A.LeadSourceName
							, A.AssignedToUserID
							, A.RelatedToTypeID, A.APK, A.CreateUserID, A.CreateDate
				From  #TemCRMT20301 A
				ORDER BY '+@OrderBy+'
				OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
				FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
	EXEC (@sSQL)
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
