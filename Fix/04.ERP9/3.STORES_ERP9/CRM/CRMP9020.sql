IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP9020]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[CRMP9020]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
--- Load màn hình chọn hội thảo - chuyển đề
-- <Param>
----
-- <Return>
-- <Reference>
-- <History>
----Created by:Đình Hòa Date 08/12/2020
-- <Example>
/*
	exec CRMP9020 @DivisionID=N'AS',@TxtSearch=N'',@UserID=N'CALL002',@PageNumber=N'1',@PageSize=N'10',@Mode=1
*/

 CREATE PROCEDURE CRMP9020 (
     @DivisionID NVARCHAR(2000),
     @TxtSearch NVARCHAR(250),
	 @UserID VARCHAR(50),
     @PageNumber INT,
     @PageSize INT,
	 @Mode INT
)
AS
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50)

	SET @sWhere = ''
	SET @TotalRow = ''
	SET @OrderBy = 'A.OrderNo'
	
	IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
	
	IF @Mode = 1
	BEGIN
		SET @sWhere = 'A.CodeMaster = ''CRMT00000030''' 
	END

	IF @Mode = 2
	BEGIN
		SET @sWhere = 'A.CodeMaster = ''CRMT00000031'''
	END

	IF Isnull(@TxtSearch,'') != '' 
	 SET @sWhere = @sWhere +'
							AND (A.ID LIKE N''%'+@TxtSearch+'%'' 
							OR A.Description LIKE N''%'+@TxtSearch+'%'' 
							OR A.DescriptionE LIKE N''%'+@TxtSearch+'%'')'

	
	SET @sSQL = 'SELECT  A.OrderNo, A.ID, A.Description, A.DescriptionE
				INTO #TemCRMT0099
				FROM CRMT0099 A WITH (NOLOCK)
				WHERE '+@sWhere+'
		DECLARE @count int
		Select @count = Count(ID) From #TemCRMT0099
		SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow,
							A.OrderNo, A.ID, A.Description, A.DescriptionE
				From  #TemCRMT0099 A
				ORDER BY '+@OrderBy+'
				OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
				FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
	print @sSQL
	EXEC (@sSQL)
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
