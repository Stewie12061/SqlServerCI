IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP2150]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP2150]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---- <Summary>
------ Load Dropdown/Combo Bộ định mức
---- <Param>
------ 
---- <Return>
------ 
---- <Reference>
------ 
---- <History>
------Created by: Trọng Kiên, Date: 25/09/2020
---- <Example> EXEC MP2150  'AS' ,'','CRMT10101' ,'CRMF1011', 'vi-VN', 'AS_ADMIN_OKIA'

--CREATE PROCEDURE MP2150 ( 
--        @DivisionID VARCHAR(50),  --Biến môi trường
--		@InventoryID VARCHAR(50),
--		@ObjectID VARCHAR(50)
--) 
--AS 

--DECLARE @sSQL NVARCHAR(MAX) = N'',
--		@sWhere NVARCHAR(MAX) = N'',
--		@sGroupBy NVARCHAR(MAX) = N''

--SET @sWhere = N' WHERE M1.DivisionID IN (''' + @DivisionID + ''', ''@@@'') AND CONVERT(VARCHAR,GETDATE(),112) BETWEEN CONVERT(VARCHAR,M1.StartDate,112) AND CONVERT(VARCHAR,M1.EndDate,112)'
--SET @sGroupBy = N' GROUP BY M1.NodeID, M1.Version, M1.ObjectID, M1.Description, M1.APK'

--IF ISNULL(@InventoryID, '') != ''
--	SET @sWhere = @sWhere +' AND M1.NodeID = N'''+@InventoryID+''''

--IF ISNULL(@ObjectID, '') != ''
--	SET @sWhere = @sWhere +' AND M1.ObjectID = N'''+@ObjectID+''' '+ @sGroupBy + ''
--ELSE
--	SET @sWhere = @sWhere + ' AND M1.ObjectID = N'''+@ObjectID+''' '+ @sGroupBy + '
--	              UNION ALL
--				  SELECT M2.APK AS APK_BomVersion, M2.NodeID, M2.Version, M2.ObjectID, M2.Description
--				  FROM MT2122 M2 WITH (NOLOCK)
--				  WHERE M2.NodeID = N'''+@InventoryID+''' AND CONVERT(VARCHAR,GETDATE(),112) BETWEEN CONVERT(VARCHAR,M2.StartDate,112) AND CONVERT(VARCHAR,M2.EndDate,112)' 

--SET @sSQL = N'SELECT M1.APK AS APK_BomVersion, M1.NodeID, M1.Version, M1.ObjectID, M1.Description
--			  FROM MT2122 M1 WITH (NOLOCK)' + @sWhere
--PRINT @sSQL
--EXEC (@sSQL)


-- <Summary>
---- Load Bom Version
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Đức Tuyên, Date: 25/09/2020
-- <Example> EXEC MP2150  'AS' ,'','CRMT10101' ,'CRMF1011', 'vi-VN', 'AS_ADMIN_OKIA'

CREATE PROCEDURE MP2150 ( 
		@DivisionID VARCHAR(50),  --Biến môi trường
		@InventoryID VARCHAR(50) = '',
		@TxtSearch NVARCHAR(250),
		@UserID VARCHAR(50),
		@PageNumber INT,
		@PageSize INT
) 
AS 

DECLARE @sSQL NVARCHAR(MAX) = N'',
		@sWhere NVARCHAR(MAX) = N'',
		@OrderBy NVARCHAR(MAX) = N'',
		@TotalRow NVARCHAR(50)

SET @TotalRow = ''
SET @sWhere = N'--AND CONVERT(VARCHAR,GETDATE(),112) BETWEEN CONVERT(VARCHAR,M1.StartDate,112) AND CONVERT(VARCHAR,M1.EndDate,112)
					'

SET @OrderBy = N'M1.NodeID, M1.Version DESC'

IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = '0'

IF ISNULL(@TxtSearch,'') != ''  
SET @sWhere = @sWhere +' AND (M1.NodeID LIKE N''%'+@TxtSearch+'%'' 
						OR M1.NodeName LIKE N''%'+@TxtSearch+'%'' 
						OR M1.Version LIKE N''%'+@TxtSearch+'%'' 
						OR M1.ObjectID LIKE N''%'+@TxtSearch+'%'' 
						OR T1.ObjectName LIKE N''%'+@TxtSearch+'%''
						OR M1.Description LIKE N''0'+@TxtSearch+'%'')'

IF ISNULL(@InventoryID, '') != ''
	SET @sWhere = @sWhere +' AND M1.NodeID = N'''+@InventoryID+''''


SET @sSQL = N'SELECT DISTINCT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow
					, M1.APK
					, M1.DivisionID
					, M1.NodeID
					, M1.NodeName
					, M1.Version
					, M1.ObjectID
					, T1.ObjectName
					, M1.Description
				FROM MT2122 M1 WITH (NOLOCK)
					LEFT JOIN AT1202 T1 WITH (NOLOCK) ON M1.ObjectID = T1.ObjectID AND T1.DivisionID IN (''' + @DivisionID + ''', ''@@@'')
				WHERE M1.DivisionID IN (''' + @DivisionID + ''', ''@@@'') '+ @sWhere +'
				ORDER BY '+@OrderBy+'
				OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
				FETCH NEXT '+STR(@PageSize)+' ROWS ONLY ' 
PRINT @sSQL
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
