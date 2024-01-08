IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[QCP20002]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[QCP20002]
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
	--Load danh mục tiêu chuẩn của mặt hang theo danh sách mặt hàng
-- <History>
---- Create on 15/01/2021 by Le Hoang
/*<Example>
	--Lọc nâng cao
    EXEC QCP1000 @DivisionID = 'BS', @DivisionList = '', @UserID = 'ASOFTADMIN',@Notes='', @PageNumber = 1, @PageSize = 25, @ShareHolderCategoryID = 'a', 
	@ShareHolderCategaoryName = 'd', @IsCommon = '0', @Disabled = '0', @SearchWhere=N' where IsNull(ShareHolderCategoryID,'''') = N''asdas'''

	--Lọc thường
    EXEC QCP1000 @DivisionID = 'BS', @DivisionList = '', @UserID = 'ASOFTADMIN',@Notes='', @PageNumber = 1, @PageSize = 25, @ShareHolderCategoryID = 'a', 
	@ShareHolderCategaoryName = 'd', @IsCommon = '0', @Disabled = '0', @SearchWhere = NULL
*/
CREATE PROCEDURE [dbo].[QCP20002]
( 
	 @DivisionID VARCHAR(50),
	 @ListInventoryID XML
) 
AS
DECLARE @sSQL NVARCHAR (MAX) = N''
	
	---bảng mặt hàng từ XML
	Create TABLE #InventoryTable (InventoryID nvarchar(50) primary key) 
	INSERT INTO	#InventoryTable		
	SELECT	DISTINCT X.D.value('.', 'VARCHAR(50)') AS InventoryID
	FROM	@ListInventoryID.nodes('//D') AS X (D)

	SET @sSQL = N'
				SELECT DISTINCT T4.StandardID
				FROM QCT1020 T1
				JOIN QCT1021 T2 ON T1.APK = T2.APKMaster
				JOIN #InventoryTable T3 ON T1.InventoryID = T3.InventoryID
				JOIN QCT1000 T4 ON T2.StandardID = T4.StandardID
				LEFT JOIN AT1302 T6 ON T3.InventoryID = T6.InventoryID
				LEFT JOIN AT1304 T5 ON T4.UnitID = T5.UnitID
				WHERE T1.DivisionID = ''' + @DivisionID + '''
				ORDER BY T4.StandardID
				'
	EXEC (@sSQL)
	
GO