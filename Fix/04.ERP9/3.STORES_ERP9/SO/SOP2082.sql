IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP2082]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP2082]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO









-- <Summary>
---- Load data cho lưới màn hình xem chi tiết thông tin sản xuất
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>

-- <History>
----Create on 11/9/2018 by Đình Ly
----Modify on 30/06/2020 by Kiều Nga : Load các trường quy cách
----Modify on 30/06/2020 by Kiều Nga : Load Tên thông tin NVL
-- <Example> 

CREATE PROCEDURE [dbo].[SOP2082] 
( 
	 @DivisionID VARCHAR(50), 
	 @UserID VARCHAR(50), 
	 @APK VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT
)
AS 
	DECLARE @sSQL NVARCHAR (MAX) = N'',
     		@OrderBy NVARCHAR(MAX) = N'', 
			@TotalRow NVARCHAR(50) = N''

	SET @OrderBy = N'S1.CreateDate'
	IF  @PageNumber = 1 SET @TotalRow = 'COUNT OVER ()' ELSE SET @TotalRow = 'NULL'
	SET @sSQL = @sSQL + N'
		SELECT S1.KindOfSuppliers, S1.MaterialID 
			  , S1.CartonQuantitation, S1.UnitID 
			  , S1.CartonQuantity, S1.CartonUnitPrice, S1.CartonAmount,S1.CreateDate,A2.InventoryName
			  ,S1.S01ID,S1.S02ID,S1.S03ID,S1.S04ID,S1.S05ID,S1.S06ID,S1.S07ID,S1.S08ID,S1.S09ID,S1.S10ID,S1.S11ID,S1.S12ID,S1.S13ID,S1.S14ID,S1.S15ID,S1.S16ID,S1.S17ID,S1.S18ID,S1.S19ID,S1.S20ID
		INTO #TempOOT2140
		FROM SOT2082 S1 WITH (NOLOCK)
		LEFT JOIN AT1302 A2 WITH (NOLOCK) ON A2.InventoryID = S1.InventoryID
		WHERE S1.APKMaster = ''' + @APK + ''' 

		DECLARE @Count INT
		SELECT @Count = COUNT(KindOfSuppliers) FROM #TempOOT2140

		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @count AS TotalRow
			  , S1.KindOfSuppliers
			  , S1.MaterialID 
			  , S1.CartonQuantitation
			  , S1.UnitID 
			  , S1.CartonQuantity
			  , S1.CartonUnitPrice
			  , S1.CartonAmount,S1.CreateDate,S1.InventoryName
			  ,S1.S01ID,S1.S02ID,S1.S03ID,S1.S04ID,S1.S05ID,S1.S06ID,S1.S07ID,S1.S08ID,S1.S09ID,S1.S10ID,S1.S11ID,S1.S12ID,S1.S13ID,S1.S14ID,S1.S15ID,S1.S16ID,S1.S17ID,S1.S18ID,S1.S19ID,S1.S20ID
		FROM #TempOOT2140 S1
		ORDER BY ' + @OrderBy + '
		OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
		FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
	EXEC (@sSQL)









GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
