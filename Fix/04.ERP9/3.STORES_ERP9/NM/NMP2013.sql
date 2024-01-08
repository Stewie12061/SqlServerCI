IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[NMP2013]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[NMP2013]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Load detail n/vu thực đơn ngày (thực phẩm )
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
	NMP2013 @DivisionID = 'VF', @DivisionList = 'VF', @UserID = 'ASOFTADMIN', @PageNumber = 1, @PageSize = 25, @APK='EBF42A64-9756-4EC0-B512-27A2BF1E1D09',@Mode=2
	
	NMP2013 @DivisionID, @DivisionList, @UserID, @PageNumber, @PageSize, @APK,@Mode
----*/

CREATE PROCEDURE NMP2013
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @APK VARCHAR(50),
	 @Mode INT 

)
AS 
DECLARE @sSQL NVARCHAR (MAX) = N'',
        @sWhere NVARCHAR(MAX) = N'',
		@sWhere1 NVARCHAR(MAX) = N'',
        @OrderBy NVARCHAR(500) = N'',
		@OrderBy1 NVARCHAR(500) = N'',
        @TotalRow NVARCHAR(50) = N''
        
SET @OrderBy = 'N23.MaterialsID'
SET @OrderBy1 = 'N24.ServiceID'
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

IF ISNULL(@DivisionList, '') <> ''
	SET @sWhere = @sWhere + 'AND N23.DivisionID IN ('''+@DivisionList+''', ''@@@'') ' 
ELSE 
	SET @sWhere = @sWhere + 'AND N23.DivisionID IN ('''+@DivisionID+''', ''@@@'') ' 
IF ISNULL(@DivisionList, '') <> ''
	SET @sWhere1 = @sWhere1 + 'AND N24.DivisionID IN ('''+@DivisionList+''', ''@@@'') ' 
ELSE 
	SET @sWhere1 = @sWhere1 + 'AND N24.DivisionID IN ('''+@DivisionID+''', ''@@@'') ' 

	IF @Mode = 1 
	BEGIN
			SET @sSQL = @sSQL + N'
					SELECT distinct CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' AS TotalRow,
					N23.APK, N23.APKMaster,N23.DivisionID,N23.MaterialsID,A02.InventoryName as MaterialsName,N23.UnitID,A04.UnitName,N23.ActualQuantity,N23.ConvetedQuantity
					,N23.UnitPrice,N23.Amount,N23.DeleteFlg,N23.TranMonth,N23.TranYear,N23.CreateUserID,N23.CreateDate,N23.LastModifyUserID,N23.LastModifyDate
					  FROM NMT2013 N23 WITH (NOLOCK) 
					LEFT JOIN AT1302 A02 WITH (NOLOCK) ON  N23.MaterialsID=A02.InventoryID 
					LEFT JOIN  AT1304 A04 WITH  (NOLOCK) ON A04.UnitID=N23.UnitID  
					WHERE N23.APKMaster='''+@APK+''' '+@sWhere +'
					ORDER BY '+@OrderBy+' 
	
			OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
	END
	ELSE
	BEGIN
			SET @sSQL = @sSQL + N'
					SELECT distinct CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy1+')) AS RowNum, '+@TotalRow+' AS TotalRow,
					N24.APK,N24.APKMaster,N24.DivisionID,N24.ServiceID,A02.InventoryName as ServiceName,N24.PeopleUnitPrice,N24.DeleteFlg,N24.TranMonth,
					N24.TranYear,N24.CreateUserID,N24.CreateDate,N24.LastModifyUserID,N24.LastModifyDate
					  FROM NMT2014 N24 WITH (NOLOCK) 
					LEFT JOIN AT1302 A02 WITH (NOLOCK) ON  N24.ServiceID=A02.InventoryID 
					WHERE N24.APKMaster='''+@APK+''' '+@sWhere1 +'
					ORDER BY '+@OrderBy1+' 
	
			OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
	
	END

EXEC (@sSQL)
--PRINT(@sSQL)

   




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
