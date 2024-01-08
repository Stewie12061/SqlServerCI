IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SP0110]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SP0110]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
-- Update dữ liệu ẩn hiện menu
-- 
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Đình Hòa, Date: 04/12/2020
-- Updated by: Phương Thảo, Date: 21/07/2023 Bổ sung thêm điều kiện lưu theo loại 

CREATE PROCEDURE SP0110 (
	@DB_ADMIN NVARCHAR(50),	
	@Data XML,
	@DataMater NVARCHAR(50))
AS

BEGIN
	DECLARE @sSQL NVARCHAR(MAX)
	----Tạo bảng tạm TH:chọn Phân hệ hoặc Nghiệp vụ/Danh mục
	IF(@DataMater in (1,2) )
	BEGIN
	SELECT X.Data.query('SysMenuID').value('.', 'VARCHAR(50)') AS sysMenuID,
		   X.Data.query('ModuleID').value('.', 'VARCHAR(50)') AS ModuleID,
		   (CASE WHEN X.Data.query('CustomerIndex').value('.', 'VARCHAR(50)') = '0' THEN CONVERT(int, -1)
			     ELSE CONVERT(int, -2) END) AS CustomerIndex
	INTO #TEMP1
	FROM @Data.nodes('//Data') AS X (Data)
	END
	----Tạo bảng tạm TH:chọn Nhóm báo cáo hoặc Báo cáo
	IF(@DataMater in (3,4) )
	BEGIN 
	SELECT X.Data.query('SysMenuID').value('.', 'VARCHAR(50)') AS sysMenuID,
		   X.Data.query('ModuleID').value('.', 'VARCHAR(50)') AS ModuleID,
		   (CASE WHEN X.Data.query('CustomerIndex').value('.', 'VARCHAR(50)') = '0' THEN CONVERT(TINYINT, 0)
			     ELSE CONVERT(TINYINT, 1) END) AS CustomerIndex
	INTO #TEMP2
	FROM @Data.nodes('//Data') AS X (Data)
	END
	----Lưu TH:chọn Phân hệ hoặc Nghiệp vụ/Danh mục
	IF(@DataMater in (1,2) )
	BEGIN
	SET @sSQL = 'UPDATE ['+@DB_ADMIN+'].dbo.sysMenu
				 SET ['+@DB_ADMIN+'].dbo.sysMenu.CustomerIndex = M2.CustomerIndex
				 FROM ['+@DB_ADMIN+'].dbo.sysMenu M1 
				     INNER JOIN #TEMP1 M2 ON M1.sysMenuID = M2.sysMenuID AND M1.ModuleID = M2.ModuleID'
	END
	----Lưu TH:chọn Nhóm báo cáo
	IF(@DataMater in (3) )
	BEGIN
	SET @sSQL = 'UPDATE ['+@DB_ADMIN+'].dbo.sysReportGroup
				 SET ['+@DB_ADMIN+'].dbo.sysReportGroup.Disabled= CONVERT(tinyint, M2.CustomerIndex)
				 FROM ['+@DB_ADMIN+'].dbo.sysReportGroup G
				     INNER JOIN #TEMP2 M2 ON G.sysReportGroupID = M2.sysMenuID 
				     LEFT JOIN ['+@DB_ADMIN+'].dbo.sysMenu M3 WITH(NOLOCK) ON M3.ModuleID = G.Module
				 WHERE M3.ModuleID = M2.ModuleID'	
	END
	----Lưu TH:chọn Báo cáo
	IF(@DataMater in (4) )
	BEGIN
	SET @sSQL = 'UPDATE ['+@DB_ADMIN+'].dbo.sysReport
				 SET ['+@DB_ADMIN+'].dbo.sysReport.Disabled = M2.CustomerIndex
				 FROM ['+@DB_ADMIN+'].dbo.sysReport R
				 	LEFT JOIN ['+@DB_ADMIN+'].dbo.sysReportGroup G WITH(NOLOCK) ON R.GroupID = G.GroupID
				 	INNER JOIN #TEMP2 M2 ON R.sysReportID = M2.sysMenuID 
				 	LEFT JOIN ['+@DB_ADMIN+'].dbo.sysMenu M3 WITH(NOLOCK) ON M3.ModuleID = G.Module
				 WHERE M3.ModuleID = M2.ModuleID'
	END

	EXEC(@sSQL)
	PRINT(@sSQL)
	
END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
