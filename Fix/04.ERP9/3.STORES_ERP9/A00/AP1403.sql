IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP1403]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP1403]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO











-- <Summary>
---- Lấy danh sách Permission theo USER - AS0001
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created by: Tấn Thành, Date 20/08/2020: Chuyển từ Query SQL_GETBYPERMISSION trong ASOFT.ERP.A00.DataAccess.Extensions.Database -> AT1403DAL.extension.cs
---- Modified by: Vĩnh Tâm, Date 20/08/2020: Bổ sung param IsApp để lọc phân quyền màn hình theo app Mobile
---- Modified by: Tấn Thành, Date 04/02/2021: Check thêm quyền Module vào quyền màn hình
---- Modified by: Hoài Bảo, Date 22/10/2021: Bổ sung điều kiện chỉ lấy những màn hình user phải có ít nhất 1 quyền (View)
---- Modified by: Hoài Bảo, Date 10/11/2021: Bổ sung điều kiện lấy thêm những màn hình phân quyền theo quyền addNew (màn hình Chọn)
---- Modified by: Văn Tài, 	Date 19/01/2022: Trường hợp không truyền CustomerIndex ở mobile.
---- Modified by: Văn Tài, 	Date 26/07/2022: Cải tiến tốc độ load phân quyền, lỗi inner join AT1404 không có điều kiện ScreenID.
-- <Example>
/*
 EXEC AP1403 @UserID = N'ASOFTADMIN', @DivisionID = N'DTI', @IsApp = 0
 */

CREATE PROCEDURE AP1403
( 
	@UserID VARCHAR(50),
	@DivisionID VARCHAR(50),
	@CustomerIndex INT = -1,
	@IsApp TINYINT = 0
	--@SourceID VARCHAR(50) = 'APP'
) 
AS 

BEGIN

	-- Lấy danh sách nhóm của người dùng thuộc Division
	SELECT DISTINCT GroupID 
	INTO #AP1403Group
	FROM AT1402 WITH (NOLOCK)
	WHERE DivisionID = @DivisionID 
			AND UserID = @UserID 

	--- Lấy danh sách màn hình liên quan nhóm thuộc Division
	SELECT AT1403.*
	INTO #AP1403AT1403
	FROM AT1403 WITH (NOLOCK)
	INNER JOIN #AP1403Group AT1402 WITH (NOLOCK) 
				ON AT1403.DivisionID = @DivisionID
					AND ISNULL(AT1402.GroupID, '') = ISNULL(AT1403.GroupID, '')

	-- Lấy thông tin quyền của Module và màn hình theo danh sách nhóm.
	-- Lấy MAX để group by theo nhóm user có quyền 1 cao nhất.
	SELECT @UserID AS UserID, AT1403.ModuleID, AT1403.ScreenID, AT1403.DivisionID,
			  MAX(IsAddNew) AS IsAddNew,
			  MAX(IsUpdate) AS IsUpdate,
			  MAX(IsDelete) AS IsDelete,
			  MAX(IsView) AS IsView,
			  MAX(IsPrint) AS IsPrint,
			  MAX(IsExportExcel) AS IsExportExcel,
			  MIN(ISNULL(IsHidden,1)) AS IsHidden
		INTO #ScreenRaw
		FROM #AP1403AT1403 AT1403 WITH (NOLOCK)
			INNER JOIN #AP1403Group AT1402 WITH (NOLOCK) ON ISNULL(AT1402.GroupID, '') = ISNULL(AT1403.GroupID, '')
			INNER JOIN AT1404 WITH (NOLOCK) ON AT1404.DivisionID = @DivisionID
						AND ISNULL(AT1404.CustomerIndex, -1) IN (-1, @CustomerIndex)
						AND AT1404.ScreenID = AT1403.ScreenID
		WHERE AT1403.DivisionID = @DivisionID 
				AND (@IsApp = 0 OR (@IsApp = 1 AND AT1403.SourceID = 'APP'))
		GROUP BY AT1403.DivisionID, AT1403.ScreenID, AT1403.ModuleID
	UNION
	SELECT @UserID AS UserID, AT1403.ModuleID, AT1403.ScreenID, AT1403.DivisionID,
			  MAX(AT1403.IsAddNew) AS IsAddNew,
			  MAX(AT1403.IsUpdate) AS IsUpdate,
			  MAX(AT1403.IsDelete) AS IsDelete,
			  MAX(AT1403.IsView) AS IsView,
			  MAX(AT1403.IsPrint) AS IsPrint,
			  MAX(AT1403.IsExportExcel) AS IsExportExcel,
			  MIN(ISNULL(AT1403.IsHidden,1)) AS IsHidden
	FROM AT1403 WITH (NOLOCK)
	INNER JOIN #AP1403Group AT1402 WITH (NOLOCK) ON ISNULL(AT1402.GroupID, '') = ISNULL(AT1403.GroupID, '')
	WHERE AT1403.DivisionID = @DivisionID
			AND (@IsApp = 0 OR (@IsApp = 1 AND AT1403.SourceID = 'APP'))
			AND AT1403.ScreenID = AT1403.ModuleID
	GROUP BY AT1403.DivisionID, AT1403.ScreenID, AT1403.ModuleID

	SELECT AT1402.UserID, AT1403.ModuleID, AT1403.ScreenID, AT1403.DivisionID,
			MAX(IsAddNew) AS IsAddNew,
			MAX(IsUpdate) AS IsUpdate,
			MAX(IsDelete) AS IsDelete,
			MAX(IsView) AS IsView,
			MAX(IsPrint) AS IsPrint,
			MAX(IsExportExcel) AS IsExportExcel,
			MIN(ISNULL(IsHidden,1)) AS IsHidden
	INTO #ModuleRaw
	FROM AT1403 WITH (NOLOCK)
		LEFT JOIN AT1402 WITH (NOLOCK) ON AT1402.DivisionID = AT1403.DivisionID AND AT1402.GroupID = AT1403.GroupID
	WHERE AT1403.DivisionID = @DivisionID AND AT1402.UserID = @UserID
		AND AT1403.ModuleID = AT1403.ScreenID AND AT1403.SourceID = 'Hidden'
	GROUP BY AT1403.DivisionID, AT1403.ScreenID, AT1402.UserID, AT1403.ModuleID
	ORDER BY AT1402.UserID, AT1403.ModuleID, AT1403.ScreenID
	
	SELECT Temp.UserID, Temp.ModuleID, Temp.ScreenID, Temp.DivisionID,
			CONVERT(TINYINT, MAX(Temp.IsAddNew)) AS IsAddNew,
			CONVERT(TINYINT, MAX(Temp.IsUpdate)) AS IsUpdate,
			CONVERT(TINYINT, MAX(Temp.IsDelete)) AS IsDelete,
			CONVERT(TINYINT, MAX(Temp.IsView)) AS IsView,
			CONVERT(TINYINT, MAX(Temp.IsPrint)) AS IsPrint,
			CONVERT(TINYINT, MAX(Temp.IsExportExcel)) AS IsExportExcel,
			CONVERT(TINYINT, MAX(Temp.IsHidden)) AS IsHidden
	FROM 
	(
		SELECT T1.UserID, T1.ModuleID, T1.ScreenID, T1.DivisionID,
			CASE
				WHEN T2.IsView = 0 OR T2.IsHidden = 1 THEN 0
				ELSE T1.IsAddNew
			END AS IsAddNew,

			CASE
				WHEN T2.IsView = 0 OR T2.IsHidden = 1 THEN 0
				ELSE T1.IsUpdate
			END AS IsUpdate,

			CASE
				WHEN T2.IsView = 0 OR T2.IsHidden = 1 THEN 0
				ELSE T1.IsDelete
			END AS IsDelete,

			CASE
				WHEN T2.IsView = 0 OR T2.IsHidden = 1 THEN 0
				ELSE T1.IsView
			END AS IsView,

			CASE
				WHEN T2.IsView = 0 OR T2.IsHidden = 1 THEN 0
				ELSE T1.IsPrint
			END AS IsPrint,

			CASE
				WHEN T2.IsView = 0 OR T2.IsHidden = 1 THEN 0
				ELSE T1.IsExportExcel
			END AS IsExportExcel,

			CASE
				WHEN T2.IsView = 0 OR T2.IsHidden = 1 THEN 0
				ELSE T1.IsHidden
			END AS IsHidden
		FROM #ScreenRaw T1 WITH(NOLOCK)
		LEFT JOIN #ModuleRaw T2 WITH(NOLOCK) ON T2.ScreenID = T1.ModuleID
		WHERE ISNULL(T2.IsView, 0) > 0 AND (ISNULL(T1.IsView, 0) > 0 OR ISNULL(T1.IsAddNew, 0) > 0)

		UNION ALL

		SELECT UserID, ModuleID, ScreenID, DivisionID,
				IsAddNew AS IsAddNew,
				IsUpdate AS IsUpdate,
				IsDelete AS IsDelete,
				IsView AS IsView,
				IsPrint AS IsPrint,
				IsExportExcel AS IsExportExcel,
				ISNULL(IsHidden, 0) AS IsHidden
		FROM #ModuleRaw WITH (NOLOCK)
	) AS Temp
	GROUP BY Temp.DivisionID, Temp.ScreenID, Temp.UserID, Temp.ModuleID
	ORDER BY Temp.UserID, Temp.ModuleID, Temp.ScreenID

END




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
