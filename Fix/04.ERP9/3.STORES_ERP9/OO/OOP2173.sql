IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2173]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2173]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

















-- <Summary>
--- Load màn hình chọn hỗ trợ yêu cầu
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Tấn Lộc Date 08/11/2019
-- <Example>
/*
	EXEC OOP2173 @DivisionID=N'KY',@TxtSearch=N'',@UserID=N'DANH',@PageNumber=N'1',@PageSize=N'10'
*/

 CREATE PROCEDURE [dbo].[OOP2173] (
	 @DivisionID NVARCHAR(2000),
	 @TxtSearch NVARCHAR(250),
	 @IsOpportunity TINYINT = 0,
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT
)
AS
DECLARE @sSQL NVARCHAR (MAX),
	 @sWhere NVARCHAR(MAX),
	 @OrderBy NVARCHAR(500),
	 @TotalRow NVARCHAR(50)

SET @sWhere = '1 = 1'
SET @OrderBy = 'M.CreateDate, M.SupportRequiredID'

IF ISNULL(@TxtSearch,'') != ''

	SET @sWhere = @sWhere + '
				 AND (M.SupportRequiredID LIKE N''%' + @TxtSearch + '%'' 
				OR M.SupportRequiredName LIKE N''%' + @TxtSearch + '%'' 
				OR O1.Description LIKE N''%' + @TxtSearch + '%''  
				OR C1.ObjectName LIKE N''%' + @TxtSearch + '%''
				OR C2.ContactName LIKE N''%' + @TxtSearch + '%''
				OR M.TimeRequest LIKE N''%' + @TxtSearch + '%'' 
				OR M.DeadlineRequest LIKE N''%' + @TxtSearch + '%'')'

IF @IsOpportunity = 1
	SET @sWhere = @sWhere + ' AND ISNULL(M.OpportunityID, '''') != '''''

SET @sSQL = '
		SELECT M.APK, M.DivisionID
			, M.SupportRequiredID
			, M.SupportRequiredName
			, O1.Description AS TypeOfRequest
			, M.AccountID
			, M.ContactID
			, C1.ObjectName AS AccountName
			, C2.ContactName AS ContactName 
			, M.TimeRequest
			, M.DeadlineRequest
			, C2.HomeMobile AS HomeMobile
			, C2.HomeTel AS HomeTel
			, C2.BusinessTel AS BusinessTel
			, C2.BusinessFax AS BusinessFax
			, C2.CreateDate
		INTO #TemOOT2170
		FROM OOT2170 M WITH (NOLOCK)
			LEFT JOIN CRMT0099 O1 WITH (NOLOCK) ON O1.ID = M.TypeOfRequest AND O1.CodeMaster = ''CRMF2160.TypeOfRequest''
			LEFT JOIN AT1202 C1 WITH (NOLOCK) ON C1.ObjectID = M.AccountID
			LEFT JOIN CRMT10001 C2 WITH (NOLOCK) ON C2.ContactID = M.ContactID
		WHERE M.DivisionID = ''' + @DivisionID + ''' AND ISNULL(M.DeleteFlg, 0) = 0 AND ' + @sWhere + '
			
		DECLARE @count INT
		SELECT @count = COUNT(*) FROM #TemOOT2170 
		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @count AS TotalRow
			, M.APK, M.DivisionID
			, M.SupportRequiredID
			, M.SupportRequiredName
			, M.TypeOfRequest
			, M.AccountID
			, M.ContactID
			, M.AccountName
			, M.ContactName
			, M.TimeRequest
			, M.DeadlineRequest
			, M.HomeMobile
			, M.HomeTel
			, M.BusinessTel
			, M.BusinessFax
		FROM #TemOOT2170 M
		ORDER BY ' + @OrderBy + '
		OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
		FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
EXEC (@sSQL)
--PRINT(@sSQL)


















GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
