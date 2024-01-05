IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[NMP1053]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[NMP1053]
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
	NMP1053 @DivisionID = 'BS',  @UserID = 'ASOFTADMIN', @PageNumber = 1, @PageSize = 25,@APK= '51B1F11D-2C9B-432D-ACDC-42E9F6C33D2E'

----*/

CREATE PROCEDURE NMP1053
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @APK VARCHAR(50)
	

)
AS 
DECLARE @sSQL NVARCHAR (MAX) = N'',
        @sWhere NVARCHAR(MAX) = N'',
        @OrderBy NVARCHAR(500) = N'',
        @TotalRow NVARCHAR(50) = N''
        
SET @OrderBy = 'N51.MaterialsID'

IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'



SET @sSQL = @sSQL + N'
			SELECT DISTINCT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' AS TotalRow,
				 N51.APK,N51.DivisionID,N51.MaterialsID,N51.UnitID,N51.Mass,N51.ConvertedMass   ,
										 A02.InventoryName,A04.UnitName,N51.CreateUserID,N51.CreateDate,N51.LastModifyUserID,N51.LastModifyDate
			 FROM NMT1051 N51 WITH (NOLOCK) 
				left  join AT1302 A02 WITH (NOLOCK) on  N51.MaterialsID=A02.InventoryID and N51.DivisionID=A02.DivisionID 
				 left join AT1304 A04 With (nolock) on N51.UnitID=A04.UnitID and N51.DivisionID= A04.DivisionID
			WHERE N51.APKMaster='''+@APK+'''
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
