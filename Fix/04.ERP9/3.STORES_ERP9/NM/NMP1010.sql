IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[NMP1010]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[NMP1010]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Load danh mục thực phẩm (màn hình truy vấn)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
-- <History>
----Created by: Trà Giang, Date: 25/08/2018
-- <Example>
---- 
/*-- <Example>
--Lọc thường
	NMP1010 @DivisionID = 'BE', @DivisionList = 'BE', @UserID = 'ASOFTADMIN', @PageNumber = 1, @PageSize = 25, @MaterialsID = '', 
	@MaterialsName = '',@MaterialsTypeID='',  @Disabled = 0,@SearchWhere=NULL
	
	NMP1010 @DivisionID, @DivisionList, @UserID, @PageNumber, @PageSize, @ServiceTypeID, @ServiceTypeName, @IsCommon, @Disabled
--Lọc nâng cao
    NMP1010 @DivisionID = 'VF', @DivisionList = 'VF', @UserID = 'ASOFTADMIN', @PageNumber = 1, @PageSize = 25, @MaterialsID = '', 
	@MaterialsName = '',@MaterialsTypeID='',  @Disabled = 0 ,@SearchWhere=N' where IsNull(MaterialsID,'''') = N''asdas'''
	
----*/

CREATE PROCEDURE NMP1010
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @MaterialsID VARCHAR(50),
	 @MaterialsName NVARCHAR(250),
	 @MaterialsTypeID  VARCHAR(50),
	 @Disabled VARCHAR(1),
	  @SearchWhere NVARCHAR(MAX) = NULL --#NULL: Lọc nâng cao; =NULL: Lọc thường

)
AS 
DECLARE @sSQL NVARCHAR (MAX) = N'',
        @sWhere NVARCHAR(MAX) = N'',
        @OrderBy NVARCHAR(500) = N'',
        @TotalRow NVARCHAR(50) = N''
        
SET @OrderBy = 'N10.MaterialsID'
SET @sWhere = ' 1 = 1 '
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
If Isnull(@SearchWhere, '') = '' --Lọc thường
		Begin
IF ISNULL(@DivisionList, '') <> ''
	SET @sWhere = @sWhere + 'AND N10.DivisionID IN ('''+@DivisionList+''', ''@@@'') ' 
ELSE 
	SET @sWhere = @sWhere + 'AND  N10.DivisionID IN ('''+@DivisionID+''', ''@@@'') ' 

IF ISNULL(@MaterialsID,'') <> '' SET @sWhere = @sWhere + '
AND N10.MaterialsID LIKE N''%'+@MaterialsID+'%'' '	
IF ISNULL(@MaterialsName,'') <> '' SET @sWhere = @sWhere + '
AND A02.InventoryName LIKE N''%'+@MaterialsName+'%'' '
IF ISNULL(@MaterialsTypeID,'') <> '' SET @sWhere = @sWhere + '
AND N10.MaterialsTypeID LIKE N''%'+@MaterialsTypeID+'%'' '
IF @Disabled IS NOT NULL SET @sWhere = @sWhere + N'
AND N10.Disabled = '+@Disabled+''
	--nếu giá trị NULL thì set về rổng 
		SET @SearchWhere = Isnull(@SearchWhere, '')
End	


SET @sSQL = @sSQL + N'
		SELECT distinct CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' AS TotalRow
		,N10.APK,N10.DivisionID,N10.MaterialsID, A02.InventoryName as MaterialsName ,A04.UnitName, N10.MaterialsTypeID,NMT1000.MaterialsTypeName, N10.Description, N10.Disabled 
		INTO #NMP1010
		FROM NMT1010 N10 WITH (NOLOCK) 
		left join AT1302 A02 WITH (NOLOCK) on  N10.MaterialsID=A02.InventoryID  
		left join AT1304 A04 With (nolock) on A04.UnitID=A02.UnitID
		left join NMT1000  WITH (NOLOCK) on N10.MaterialsTypeID= NMT1000.MaterialsTypeID
		WHERE '+@sWhere +'
		
		Select  ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow	
				,APK,DivisionID,MaterialsID, MaterialsName,UnitName, MaterialsTypeID,MaterialsTypeName, Description, Disabled 
			FROM #NMP1010 AS N10
			'+@SearchWhere +'
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
