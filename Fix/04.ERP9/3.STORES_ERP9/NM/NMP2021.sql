IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[NMP2021]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[NMP2021]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Load detail n/vu phiếu kê chợ (tab thực đơn/thực phẩm/ chi phí )
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
	NMP2021 @DivisionID = 'BS', @DivisionList = 'BS', @UserID = 'ASOFTADMIN', @PageNumber = 1, @PageSize = 25, @APK='EBF42A64-9756-4EC0-B512-27A2BF1E1D09',@Mode=3
	
	NMP2021 @DivisionID, @DivisionList, @UserID, @PageNumber, @PageSize, @APK,@Mode
----*/

CREATE PROCEDURE NMP2021
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @APK VARCHAR(50),
	 @Mode INT --1: thực đơn, 2: thực phẩm , 3: chi phí 

)
AS 
DECLARE @sSQL NVARCHAR (MAX) = N'',
        @sWhere NVARCHAR(MAX) = N'',
		@sWhere1 NVARCHAR(MAX) = N'',
		@sWhere2 NVARCHAR(MAX) = N'',
        @OrderBy NVARCHAR(500) = N'',
		@OrderBy1 NVARCHAR(500) = N'',
        @TotalRow NVARCHAR(50) = N''
        
SET @OrderBy = 'N22.MaterialsID'
SET @OrderBy1 = 'N23.MaterialsID'
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

IF ISNULL(@DivisionList, '') <> ''
	SET @sWhere = @sWhere + 'AND N22.DivisionID IN ('''+@DivisionList+''', ''@@@'') ' 
ELSE 
	SET @sWhere = @sWhere + 'AND N22.DivisionID IN ('''+@DivisionID+''', ''@@@'') ' 
IF ISNULL(@DivisionList, '') <> ''
	SET @sWhere1 = @sWhere1 + 'AND N23.DivisionID IN ('''+@DivisionList+''', ''@@@'') ' 
ELSE 
	SET @sWhere1 = @sWhere1 + 'AND N23.DivisionID IN ('''+@DivisionID+''', ''@@@'') ' 
IF ISNULL(@DivisionList, '') <> ''
	SET @sWhere1 = @sWhere2 + 'AND N23.DivisionID IN ('''+@DivisionList+''', ''@@@'') ' 
ELSE 
	SET @sWhere1 = @sWhere2 + 'AND N23.DivisionID IN ('''+@DivisionID+''', ''@@@'') '
	IF @Mode = 1 
	BEGIN
		SET @sSQL = @sSQL + N'
					SELECT distinct CONVERT(INT, ROW_NUMBER() OVER (ORDER BY N21.MenuVoucherNo)) AS RowNum, '+@TotalRow+' AS TotalRow,
					N21.APK,N21.APKMaster,N21.DivisionID,N21.MenuVoucherNo,N21.ChildActualQuantity,N21.MealID,N16.MealName,N21.DishID,N15.DishName,
					N21.TranMonth,N21.TranYear,N21.CreateUserID,N21.CreateDate,N21.LastModifyUserID,N21.LastModifyDate
						FROM NMT2021 N21 WITH (NOLOCK) 
					LEFT JOIN NMT1050 N15 WITH (NOLOCK) ON N15.DishID=N21.DishID
					LEFT JOIN NMT1060 N16 WITH (NOLOCK) ON N16.MealID=N21.MealID
					WHERE N21.APKMaster='''+@APK+''' '+@sWhere2 +'
					ORDER BY N21.MenuVoucherNo
	
			OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
			
	END
	ELSE
	IF @Mode=2
	BEGIN
	SET @sSQL = @sSQL + N'
					SELECT distinct CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' AS TotalRow,
					N22.APK,N22.APKMaster,N22.DivisionID,N22.MenuName,N22.MaterialsID,A02.InventoryName,N22.ActualQuantity
					,N22.UnitID,A04.UnitName,N22.TranMonth,N22.TranYear,N22.CreateUserID,N22.CreateDate,N22.LastModifyUserID,N22.LastModifyDate
						FROM NMT2022 N22
						LEFT JOIN AT1302 A02 WITH (NOLOCK) ON  N22.MaterialsID=A02.InventoryID 
					LEFT JOIN AT1304 A04 WITH (NOLOCK) ON A04.UnitID=N22.UnitID
					WHERE N22.APKMaster='''+@APK+''' '+@sWhere +'
					ORDER BY '+@OrderBy+' 
	
			OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
	END 
	ELSE
	BEGIN
			SET @sSQL = @sSQL + N'
					SELECT distinct CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy1+')) AS RowNum, '+@TotalRow+' AS TotalRow,
					N23.APK,N23.APKMaster,N23.DivisionID,N23.MaterialsID,A02.InventoryName,N23.UnitID,A04.UnitName,N23.WareHouseID,A03.WareHouseName,
					N23.ActualQuantity,N23.UnitPrice,N23.Amount,N23.TranMonth,
					N23.TranYear,N23.CreateUserID,N23.CreateDate,N23.LastModifyUserID,N23.LastModifyDate
					 FROM NMT2023 N23 WITH (NOLOCK) 
					LEFT JOIN AT1302 A02 WITH (NOLOCK) ON  N23.MaterialsID=A02.InventoryID 
					LEFT JOIN AT1304 A04 WITH (NOLOCK) ON A04.UnitID=N23.UnitID
					LEFT JOIN AT1303 A03 WITH (NOLOCK) ON A03.WareHouseID=N23.WareHouseID
					WHERE N23.APKMaster='''+@APK+''' '+@sWhere1 +'
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

