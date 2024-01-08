IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SP0111]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SP0111]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
-- Load dữ liệu  menu
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Đình Hòa, Date: 04/12/2020
-- Updated by: Phương Thảo, Date: 21/07/2023 Bổ sung thêm điều kiện lọc theo loại 

CREATE PROCEDURE SP0111 (
	@ScreenID NVARCHAR(50),
	@MenuName NVARCHAR(MAX),
	@ModuleID NVARCHAR(50),
	@TypeMenu NVARCHAR(50),
	@DB_ADMIN NVARCHAR(50),
	@LanguageID NVARCHAR(50))
AS
BEGIN
	DECLARE @sSQL NVARCHAR(MAX),
			@sWhere NVARCHAR(MAX)
	
	SET @sWhere = ''
	IF Isnull(@ModuleID, '') != ''
		SET @sWhere = @sWhere + ' AND M.ModuleID LIKE ''%' +@ModuleID+'%'''
---- TH: chọn Phân hệ hoặc Nghiệp vụ/Danh mục
	IF(( Isnull(@MenuName, '') != '') AND (@TypeMenu in (1,2) ))
		SET @sWhere = @sWhere + ' AND L.Name LIKE ''%' +@MenuName+'%'''
	IF ((ISNULL(@ScreenID, '') != '')AND (@TypeMenu in (1,2) ))
		SET @sWhere = @sWhere + ' AND M.sysScreenID = ''' +@ScreenID+''''
---- TH: chọn Nhóm báo cáo
	IF(( Isnull(@MenuName, '') != '') AND (@TypeMenu in (3) ))
		SET @sWhere = @sWhere + ' AND L.Name LIKE ''%' +@MenuName+'%'''
	IF ((ISNULL(@ScreenID, '') != '')AND (@TypeMenu in (3) ))
		SET @sWhere = @sWhere + ' AND G.GroupID = ''' +@ScreenID+''''
---- TH: chọn Báo cáo
	IF(( Isnull(@MenuName, '') != '') AND (@TypeMenu in (4) ))
		SET @sWhere = @sWhere + ' AND R.ReportName LIKE ''%' +@MenuName+'%'''
	IF ((ISNULL(@ScreenID, '') != '')AND (@TypeMenu in (4) ))
		SET @sWhere = @sWhere + ' AND R.ReportID = ''' +@ScreenID+''''
   
    IF (@TypeMenu = 1)
    BEGIN
		SET @sSQL = 'SELECT M.sysMenuID, M.ModuleID, M.MenuLevel ,M.MenuID, L.Name AS MenuName, M.sysScreenID,
					        CASE WHEN M.CustomerIndex = -1 THEN 0 ELSE 1 END AS CustomerIndex
					 FROM ['+@DB_ADMIN+'].dbo.sysMenu M WITH(NOLOCK)
					     LEFT JOIN A00001 L WITH(NOLOCK) ON M.MenuText = L.ID
					 WHERE L.LanguageID = '''+@LanguageID+''' '+@sWhere+' AND M.MenuLevel in (0,1)
					 ORDER BY M.MenuLevel, M.MenuOrder, M.sysScreenID;'
      
    END
    IF (@TypeMenu = 2)
	BEGIN
		SET @sSQL = 'SELECT M.sysMenuID, M.ModuleID, M.MenuLevel ,M.MenuID, L.Name AS MenuName, M.sysScreenID,
					 CASE WHEN M.CustomerIndex = -1 THEN 0 ELSE 1 END AS CustomerIndex
					 FROM ['+@DB_ADMIN+'].dbo.sysMenu M WITH(NOLOCK)
						LEFT JOIN A00001 L WITH(NOLOCK) ON M.MenuText = L.ID
					 WHERE L.LanguageID = '''+@LanguageID+''' '+@sWhere+' AND M.MenuLevel in (2,3,4)
					 ORDER BY M.MenuLevel, M.MenuOrder, M.sysScreenID;' 
	END
	IF (@TypeMenu = 3)
	BEGIN
	  SET @sSQL = 'SELECT *
				   FROM (SELECT DISTINCT M.ModuleID, G.ReportGroupOrder AS ReportGroupOrder, G.sysReportGroupID AS sysMenuID,
				                         G.GroupID AS MenuID, L.Name AS MenuName, G.GroupID AS sysScreenID,
				   						 CASE WHEN G.Disabled = 0 THEN 0 ELSE 1 END AS CustomerIndex
				         FROM ['+@DB_ADMIN+'].dbo.sysReportGroup G WITH(NOLOCK) 
				              LEFT JOIN ['+@DB_ADMIN+'].dbo.sysMenu M WITH(NOLOCK) ON M.ModuleID = G.Module
				   			 LEFT JOIN A00001 L WITH(NOLOCK) ON G.GroupName = L.ID
				   		WHERE L.LanguageID = '''+@LanguageID+''' '+@sWhere+'
				   ) AS SubQuery
				   ORDER BY ReportGroupOrder'
  END
  IF (@TypeMenu = 4)
  BEGIN
  SET @sSQL ='SELECT *
			  FROM (SELECT DISTINCT M.ModuleID,G.ReportGroupOrder, R.ReportOrder AS ReportOrder, R.sysReportID AS sysMenuID,
			                        R.ReportName AS MenuName,R.ReportID AS sysScreenID,
									CASE WHEN R.Disabled = 0 THEN 0 ELSE 1 END AS CustomerIndex
			        FROM ['+@DB_ADMIN+'].dbo.sysReportGroup G WITH(NOLOCK) 
			  			LEFT JOIN ['+@DB_ADMIN+'].dbo.sysReport R WITH(NOLOCK) ON R.GroupID = G.GroupID
						LEFT JOIN ['+@DB_ADMIN+'].dbo.sysMenu M WITH(NOLOCK) ON M.ModuleID = G.Module
						LEFT JOIN A00001 L WITH(NOLOCK) ON G.GroupName = L.ID
			        WHERE L.LanguageID = '''+@LanguageID+''' '+@sWhere+'
			  ) AS SubQuery
			  ORDER BY ReportGroupOrder, ReportOrder'
  END
	 
  EXEC(@sSQL)
  PRINT(@sSQL)
END	
  


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
