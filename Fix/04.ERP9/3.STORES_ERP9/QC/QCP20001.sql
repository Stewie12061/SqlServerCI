IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[QCP20001]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[QCP20001]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/****** Object:  StoredProcedure [dbo].[QCP1000]    Script Date: 06/10/2020 14:51:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- <Summary>
	--Load danh mục nhóm cổ đông
-- <History>
---- Create on 06/10/2020 by Thanh Thi
---- Modified on 19/04/2023 by Nhat Thanh
---- Modified on 13/05/2021 by Le Manh Cuong: Fix lỗi các tiêu chuẩn của mã hàng hiển thị không sắp xếp theo số thứ tự bảng vẽ đã khai báo tại màn hình QCF1021 với mã hàng tương ứng.
---- Modified on 03/08/2023 by Trong Phuc
---- Modified on 11/09/2023 by Viết Toàn: Bổ sung lấy cột SRange09 (Tần suất đo)
/*<Example>
	--Lọc nâng cao
    EXEC QCP1000 @DivisionID = 'BS', @DivisionList = '', @UserID = 'ASOFTADMIN',@Notes='', @PageNumber = 1, @PageSize = 25, @ShareHolderCategoryID = 'a', 
	@ShareHolderCategaoryName = 'd', @IsCommon = '0', @Disabled = '0', @SearchWhere=N' where IsNull(ShareHolderCategoryID,'''') = N''asdas'''

	--Lọc thường
    EXEC QCP1000 @DivisionID = 'BS', @DivisionList = '', @UserID = 'ASOFTADMIN',@Notes='', @PageNumber = 1, @PageSize = 25, @ShareHolderCategoryID = 'a', 
	@ShareHolderCategaoryName = 'd', @IsCommon = '0', @Disabled = '0', @SearchWhere = NULL
*/
CREATE PROCEDURE [dbo].[QCP20001]
( 
	 @DivisionID VARCHAR(50),
	 @InventoryID VARCHAR(50)
) 
AS
DECLARE @sSQL NVARCHAR (MAX) = N''
	
	SET @sSQL = N'
				SELECT T3.InventoryID
					, T3.InventoryName
					, T4.StandardID
					, T4.StandardName
					, T4.StandardNameE
					, T5.UnitID
					, T5.UnitName
					, T4.TypeID
					, T2.SRange01
					, T2.SRange02
					, T2.SRange03
					, T2.SRange04
					, T2.SRange05
					, T2.SRange06
					, T2.SRange07
					, T2.SRange08
					, T2.SRange09
					, T2.LastModifyDate
					, T2.Orders
					, CASE WHEN ISNULL(R01.StandardName,'''') <> '''' THEN R01.StandardName ELSE T2.SRange01 END AS APPESNRange01
					, CASE WHEN ISNULL(R02.StandardName,'''') <> '''' THEN R02.StandardName ELSE T2.SRange02 END AS APPESNRange02
					, CASE WHEN ISNULL(R03.StandardName,'''') <> '''' THEN R03.StandardName ELSE T2.SRange03 END AS APPESNRange03
					, CASE WHEN ISNULL(R04.StandardName,'''') <> '''' THEN R04.StandardName ELSE T2.SRange04 END AS APPESNRange04
					, CASE WHEN ISNULL(R05.StandardName,'''') <> '''' THEN R05.StandardName ELSE T2.SRange05 END AS APPESNRange05
					, T4.IsVisible
					, T4.IsDefault
					--INTO #QCP20001
				FROM QCT1020 T1 WITH(NOLOCK)
				JOIN QCT1021 T2 WITH(NOLOCK) ON T1.APK = T2.APKMaster
				JOIN AT1302 T3 WITH(NOLOCK) ON T1.InventoryID = T3.InventoryID
				JOIN QCT1000 T4 WITH(NOLOCK) ON T2.StandardID = T4.StandardID
				LEFT JOIN QCT1000 R01 WITH(NOLOCK) ON R01.DivisionID = T2.DivisionID AND R01.StandardID = T2.SRange01 AND R01.TypeID = ''APPE''
				LEFT JOIN QCT1000 R02 WITH(NOLOCK) ON R02.DivisionID = T2.DivisionID AND R02.StandardID = T2.SRange02 AND R02.TypeID = ''APPE''
				LEFT JOIN QCT1000 R03 WITH(NOLOCK) ON R03.DivisionID = T2.DivisionID AND R03.StandardID = T2.SRange03 AND R03.TypeID = ''APPE''
				LEFT JOIN QCT1000 R04 WITH(NOLOCK) ON R04.DivisionID = T2.DivisionID AND R04.StandardID = T2.SRange04 AND R04.TypeID = ''APPE''
				LEFT JOIN QCT1000 R05 WITH(NOLOCK) ON R05.DivisionID = T2.DivisionID AND R05.StandardID = T2.SRange05 AND R05.TypeID = ''APPE''
				LEFT JOIN AT1304 T5 WITH(NOLOCK) ON T4.UnitID = T5.UnitID
				WHERE T1.InventoryID = '''+ @InventoryID + '''
				AND T1.DivisionID = ''' + @DivisionID + '''
				AND T4.TypeID IN (''CHE'',''PHY'',''APPE'',''OTH'')
				ORDER BY T2.Orders

				--SELECT * FROM #QCP20001 ORDER BY Orders, LastModifyDate DESC
				'
	EXEC (@sSQL)
	
GO