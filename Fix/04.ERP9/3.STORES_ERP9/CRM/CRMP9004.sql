IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP9004]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP9004]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


























-- <Summary>
--- Load danh sách khách hàng
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Ðình Ly Date 17/12/2019
-- <Example>
/*
	EXEC CRMF9004 @DivisionID=N'DTI',@TxtSearch=N'',@UserID=N'DANH',@PageNumber=N'1',@PageSize=N'10'
*/

 CREATE PROCEDURE [dbo].[CRMP9004] (
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

SET @sWhere = '1 = 1'
SET @OrderBy = 'P1.CreateDate'

IF ISNULL(@TxtSearch,'') != ''
	SET @sWhere = @sWhere + ' AND (P.MemberName LIKE N''%' + @TxtSearch + '%'')'
	SET @sWhere = @sWhere + ' AND (P.MemberID LIKE N''%' + @TxtSearch + '%'')'
SET @sSQL = '
		SELECT P.MemberID
			 , P.MemberName 
			 , P.CreateDate INTO #POST0011
		FROM POST0011 P WITH (NOLOCK)
		WHERE ' + @sWhere + ' AND P.DivisionID = ''' + @DivisionID + '''
			
		DECLARE @count INT
		SELECT @count = COUNT(MemberID) FROM #POST0011 
		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum
			 , @count AS TotalRow
			 , P1.MemberID
			 , P1.MemberName
			 , P1.CreateDate
		FROM #POST0011 P1
		ORDER BY ' + @OrderBy + '
		OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
		FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
PRINT(@sSQL)
EXEC (@sSQL)


























GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
