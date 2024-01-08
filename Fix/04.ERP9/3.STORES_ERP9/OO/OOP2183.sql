IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2183]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2183]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
--- Load dữ liệu màn hình  chọn lịch sử cuộc gọi
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Tấn Lộc Date 06/12/2019
-- <Example>
/*
	EXEC OOP2183 @DivisionID=N'DTI',@TxtSearch=N'',@UserID=N'DANH',@PageNumber=N'1',@PageSize=N'10'
*/

 CREATE PROCEDURE [dbo].[OOP2183] (
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
SET @OrderBy = 'M.CallDate'

IF ISNULL(@TxtSearch,'') != ''

	SET @sWhere = @sWhere + '
				 AND (M.CallDate LIKE N''%' + @TxtSearch + '%'' 
				OR M.SupportRequiredName LIKE N''%' + @TxtSearch + '%'' 
				OR M.DID LIKE N''%' + @TxtSearch + '%''  
				OR M.Source LIKE N''%' + @TxtSearch + '%''
				OR M.Destination LIKE N''%' + @TxtSearch + '%''
				OR O2.Description LIKE N''%' + @TxtSearch + '%'' 
				OR O3.Description LIKE N''%' + @TxtSearch + '%''
				OR M.RequestStatus LIKE N''%' + @TxtSearch + '%''
				OR M.AccountName LIKE N''%' + @TxtSearch + '%''
				OR M.ContactName LIKE N''%' + @TxtSearch + '%'')'
				

IF @IsOpportunity = 1
	SET @sWhere = @sWhere + ' AND ISNULL(M.OpportunityID, '''') != '''''

SET @sSQL = '
		SELECT M.APK
			 , M.DivisionID
			 , M.CallDate
			 , M.DID
			 , M.Source
			 , M.Destination
		     , M.StatusID
			 , O2.Description AS StatusName
			 , M.Note
			 , CONVERT(char(8), DATEADD(SECOND, ISNULL(M.Duration, 0), ''''), 114) AS Duration
			 , M.TypeOfCall
			 , O3.Description AS TypeOfCallName
			 , M.RequestStatus
			 , M.Extend
			 , IIF(ISNULL(M.CreateUserID, '''') != ''ASOFTADMIN'', A1.FullName, A2.UserName) AS ExtendName
			 , M.AccountID
			 , M.ContactID
			 , M.AccountName
			 , M.ContactName
			 , M.RequestSupportID
			 , M.Download
			 , M.CreateDate
		INTO #TemOOT2180
		FROM OOT2180 M WITH (NOLOCK)
		    LEFT JOIN OOT2170 O1 WITH (NOLOCK) ON O1.SupportRequiredID = M.RequestSupportID
			LEFT JOIN OOT0099 O2 WITH (NOLOCK) ON O2.ID = M.StatusID AND O2.CodeMaster = ''OOF2180.StatusCall''
			LEFT JOIN OOT0099 O3 WITH (NOLOCK) ON O3.ID = M.TypeOfCall AND O3.CodeMaster = ''OOF2180.TypeOfCall'' 
			LEFT JOIN AT1103  A1 WITH (NOLOCK) ON A1.EmployeeID = M.CreateUserID
			LEFT JOIN AT1405  A2 WITH (NOLOCK) ON A2.UserID = M.CreateUserID 
		WHERE ' + @sWhere + ' AND M.DivisionID = ''' + @DivisionID + ''' AND M.DeleteFlg = 0 AND M.RequestSupportID IS NULL
			
		DECLARE @count INT
		SELECT @count = COUNT(*) FROM #TemOOT2180 
		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @count AS TotalRow
			, M.APK
			, M.DivisionID
			, M.CallDate
			, M.DID
			, M.Source
			, M.Destination
			, M.StatusID
			, M.StatusName
			, M.Note
			, M.Duration
			, M.TypeOfCall
			, M.TypeOfCallName
			, M.RequestStatus
			, M.Extend
			, M.ExtendName
			, M.AccountID
			, M.ContactID
			, M.AccountName
			, M.ContactName
			, M.RequestSupportID
			, M.Download
			, M.CreateDate
		FROM #TemOOT2180 M
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
