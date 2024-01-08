IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP0073]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POSP0073]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- Load Grid danh sách khu vực - POSF0073
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: DũngDV 23/09/2019
----exec POSP0073 @DivisionID=N'NN'',''TD',@DivisionIDList=N'',@AreaID=N'',@AreaName=N'',@FromDistance=N'',@ToDistance=N'',@ScoreFactor=N'',@PageNumber=1,@PageSize=25,@strWhere=N''

 CREATE PROCEDURE POSP0073 (
	 @DivisionID	NVARCHAR(Max),			--Biến môi trường
	 @DivisionIDList NVARCHAR(Max),
	 @AreaID		VARCHAR(50),	 
	 @AreaName	   NVARCHAR(250),
	 @FromDistance		VARCHAR(10),
	 @ToDistance VARCHAR(10),
	 @ScoreFactor VARCHAR(10),				
	 @PageNumber	INT,
     @PageSize		INT,						
	 @strWhere NVARCHAR(Max)
)
AS
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500)

	SET @sWhere = 'WHERE 1=1 '
	SET @OrderBy = ' CreateDate DESC'
	
	IF Isnull(@AreaID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(AreaID,'''') LIKE N''%'+@AreaID+'%'''
	IF Isnull(@AreaName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(AreaName,'''') LIKE N''%'+@AreaName+'%'''
	--Check Para DivisionIDList null then get DivisionID 
	IF Isnull(@DivisionIDList,'') = ''
		SET @sWhere = @sWhere + ' AND DivisionID IN ('''+ @DivisionID+''')'
	Else 
		SET @sWhere = @sWhere + ' AND DivisionID IN ('''+@DivisionIDList+''')'

	IF Isnull(@FromDistance, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(FromDistance,'''') ='+@FromDistance
	IF Isnull(@ToDistance, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(ToDistance,'''') = '+@ToDistance
	IF Isnull(@ScoreFactor, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(ScoreFactor,'''') = '+@ScoreFactor
	
	IF ISNULL(@strWhere,'')!=''
	
	
	SET @sWhere=@strWhere;
   	SET @sSQL ='
	Declare @Count int
	Select @Count = Count(AreaID) From  POST0073 ' +@sWhere + ';
	Select ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum,@Count AS TotalRow, * FROM POST0073 ' +@sWhere + '
				ORDER BY '+@OrderBy+'
				OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
				FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
	EXEC (@sSQL)
	PRINT @sSQL


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
