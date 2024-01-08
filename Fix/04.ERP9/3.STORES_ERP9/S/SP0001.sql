IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SP0001]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SP0001]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO









-- <Summary>
---- Danh sách module
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Nguyễn Đức Quý, Date: 04/11/2014
----Modified by: Thị PHượng, Date: 01/03/2018 Kiểm tra load module trùng đơn vị
----Modified by: Tấn Lộc, Date: 19/04/2022 Bổ sung thêm biến @DBAdmin để join qua lấy những module đang sử dụng cho màn hình Phân quyền chức năng
----Modified by: Tấn Lộc, Date: 24/05/2022 Bổ sung thêm điều kiện: CustomerIndex -99 là sử dụng cho mục đích những menu đó có sử dụng nhưng không muốn hiển thị ở cấp 0 nhưng lại có sử dụng Thiết lập ở màn hình hệ thống
----Modified by: Văn Tài, Date: 15/08/2022 Trường hợp CCM chưa có module trên ERP 9.9
----Modified by: Văn Tài, Date: 25/08/2022 Fix lỗi ngôn ngữ tên module CCM.
----Modify by: Phương Thảo, Date  13/03/2023 : [2023/03/IS/0097] OrderBy theo  OrderNo để sắp xếp phân hệ 
----Modify by: Nhật Thanh, Date  31/07/2023 : Bổ sung phân hệ POS
-- <Example>
---- 
/*
	exec SP0001
*/

CREATE PROCEDURE SP0001(
	@DBAdmin NVARCHAR(250) = null
)
AS 
DECLARE @sSQL NVARCHAR (MAX) = '',
		@sWhere NVARCHAR (MAX) = '',
		@customerIndex INT = 0

CREATE TABLE #Module(CustomerIndex INT, ImportExcel INT)
INSERT #Module EXEC AP4444
SELECT @customerIndex = CustomerIndex FROM #Module
DROP TABLE #Module
DECLARE @mModuleID NVARCHAR(250) = ''

IF NOT EXISTS (SELECT * FROM [AT1409] WHERE [ModuleID] = 'ASOFTDRM')
BEGIN
	DECLARE	@mDRM NVARCHAR(250) = N'Quản lý thu hồi nợ'   
	SET @sSQL = 'INSERT INTO [AT1409]
				SELECT NEWID() as APK, DivisionID, ''ASOFTDRM'' AS ModuleID, 
						N'''+@mDRM+''' AS [Description],
						'''' AS [DescriptionE]
				FROM AT1101 '
END
IF NOT EXISTS (SELECT * FROM [AT1409] WHERE [ModuleID] = 'ASOFTS')
BEGIN
	SET @mModuleID = N'Thiết lập và quản trị hệ thống'   
	SET @sSQL = 'INSERT INTO [AT1409]
				SELECT NEWID() as APK, DivisionID, ''ASOFTS'' AS ModuleID, 
						N''' + @mModuleID + ''' AS [Description],
						'''' AS [DescriptionE]
				FROM AT1101 '
END
ELSE
BEGIN
	SET @mModuleID = N'Thiết lập và quản trị hệ thống'   
	SET @sSQL = 'UPDATE [AT1409]
				SET Description = N''' + @mModuleID + '''
				WHERE [ModuleID] = ''ASOFTS'' '
END

IF @customerIndex = 34
BEGIN
	SET @sWhere = 'AND (ModuleID = ''ASOFTCI'' OR ModuleID = ''ASOFTS'' OR ModuleID = ''ASOFTDRM'')'
END

SET @sSQL = @sSQL + N'
SELECT A.ModuleID, A.ModuleName, A.OrderNo  FROM 
(

SELECT Distinct A1.ModuleID, A1.[Description] as ModuleName , A1.OrderNo 
FROM AT1409 A1
LEFT JOIN ['+@DBAdmin+'].dbo.sysMenu menu ON A1.ModuleID = menu.ModuleID AND menu.MenuLevel = 0
WHERE 1 = 1 AND (menu.CustomerIndex IN (''-1'',''-99'') OR A1.ModuleID IN (''ASOFTS'', ''ASOFTKPI'', ''ASOFTPOS'')) '+@sWhere+N' 

UNION ALL

SELECT ''ASOFTCCM'' as ModuleID, N''Quản lý tương tác/liên hệ khách hàng'' as ModuleName, 17 as OrderNo
) A
ORDER BY A.OrderNo ASC ,A.ModuleID
'

--DECLARE @mS NVARCHAR (MAX),
--		@mCI NVARCHAR (MAX),
--		@mOP NVARCHAR (MAX),
--		@mT NVARCHAR (MAX),
--		@mWM NVARCHAR (MAX),
--		@mFA NVARCHAR (MAX),
--		@mM NVARCHAR (MAX),
--		@mHRM NVARCHAR (MAX),
--		@mCS NVARCHAR (MAX),
--		@mPS NVARCHAR (MAX),
--		@mCRM NVARCHAR (MAX),
--		@mCM NVARCHAR (MAX),
--		@mMT NVARCHAR (MAX),
--		@mPOS NVARCHAR (MAX),
--		@mDRM NVARCHAR (MAX)  
--SET @mS = N'Phân hệ chính'
--SET	@mCI = N'Phân hệ thông tin dùng chung'    
--SET	@mOP = N'Phân hệ quản lý đơn hàng'  
--SET	@mT = N'Phân hệ kế toán'
--SET	@mWM = N'Phân hệ kho'
--SET	@mFA = N'Phân hệ quản lý tài sản' 
--SET	@mM = N'Phân hệ quản lý giá thành'
--SET	@mHRM = N'Phân hệ quản lý nhân sự và tiền lương'   
--SET	@mCS = N'Phân hệ quản lý dịch vụ khách hàng'  
--SET	@mPS = N'Phân hệ quản lý cảng biển'   
--SET	@mCRM = N'Phân hệ quản lý quan hệ khách hàng' 
--SET	@mCM = N'Phân hệ quản lý hoa hồng'
--SET	@mMT = N'Phân hệ quản lý học viên'
--SET	@mPOS = N'Phân hệ quản lý hệ thống bán lẻ'  
--SET	@mDRM = N'Phân hệ quản lý thu hồi nợ'                               

--SET @sSQL = '
--SELECT ''ASoftS'' as ModuleID, N'''+@mS+''' as ModuleName 
--UNION ALL
--SELECT ''ASoftCI'' as ModuleID, N'''+@mCI+''' as ModuleName
--UNION ALL
--SELECT	''ASoftOP'' as ModuleID, N'''+@mOP+''' as ModuleName
--UNION ALL
--SELECT	''ASoftT'' as ModuleID, N'''+@mT+''' as ModuleName
--UNION ALL
--SELECT	''ASoftWM'' as ModuleID, N'''+@mWM+''' as ModuleName
--UNION ALL
--SELECT	''ASoftFA'' as ModuleID, N'''+@mFA+''' as ModuleName
--UNION ALL
--SELECT	''ASoftM'' as ModuleID, N'''+@mM+''' as ModuleName
--UNION ALL
--SELECT	''ASoftHRM'' as ModuleID, N'''+@mHRM+''' as ModuleName
--UNION ALL
--SELECT	''ASoftCS'' as ModuleID, N'''+@mCS+''' as ModuleName
--UNION ALL
--SELECT	''ASoftPS'' as ModuleID, N'''+@mPS+''' as ModuleName
--UNION ALL
--SELECT	''ASoftCRM'' as ModuleID, N'''+@mCRM+''' as ModuleName
--UNION ALL
--SELECT	''ASoftCM'' as ModuleID, N'''+@mCM+''' as ModuleName
--UNION ALL
--SELECT	''ASoftMT'' as ModuleID, N'''+@mMT+''' as ModuleName
--UNION ALL
--SELECT	''ASoftPOS'' as ModuleID, N'''+@mPOS+''' as ModuleName
--UNION ALL
--SELECT	''ASoftDRM'' as ModuleID, N'''+@mDRM+''' as ModuleName
--'

EXEC (@sSQL)
PRINT(@sSQL)










GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
