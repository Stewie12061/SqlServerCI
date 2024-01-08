IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP2192]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP2192]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO










-- <Summary>
---- Load details tab thông tin thùng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: [Minh Phúc] - 08/06/2021
-- <Example> EXEC MP2192 @DivisionID = 'BE', @UserID = '', @APK = '9B8430BF-53C2-4EAB-A524-50BC4F2FCA82'

CREATE PROCEDURE MP2192
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @APK VARCHAR(50)
)

AS 

	DECLARE @sSQL NVARCHAR(MAX) = N'',
			@OrderBy NVARCHAR(MAX) = N'', 
			@TotalRow NVARCHAR(50) = N'',
			@sWhere NVARCHAR(MAX) = N''

	SET @OrderBy = N'InheritVoucher'

	SET @sSQL = N'
				SELECT  M1.APK, M1.DivisionID, M1.InheritVoucher, M1.InventoryID, M1.BoxID, M1.Quantity, M1.Length
				, M1.Height, M1.Width, M1.SizeM, M1.CutM, M1.SizeWave, M1.CutWave, M1.Sheets, M1.WayInside
				, M1.BoxSize, M1.TransplantSize, M1.Description, A1.InventoryName AS BoxName, A2.InventoryName AS InventoryName
				INTO #TempMP2192
				FROM MT2191 M1 WITH (NOLOCK)
					LEFT JOIN MT2190 M2 WITH (NOLOCK) ON M1.APKMaster = M2.APK
					LEFT JOIN AT1302 A1 WITH(NOLOCK) ON A1.InventoryID = M1.BoxID
					LEFT JOIN AT1302 A2 WITH(NOLOCK) ON A2.InventoryID = M1.InventoryID 
				WHERE CONVERT(VARCHAR(50),M2.APK) = '''+@APK+''' AND M2.DivisionID = ''' + @DivisionID + '''

				DECLARE @Count INT
				SELECT @Count = COUNT(*) FROM #TempMP2192
				
				SELECT  CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, @Count AS TotalRow
						, APK, DivisionID, InheritVoucher, InventoryID, BoxID, Quantity, Length
						, Height, Width, SizeM, CutM, SizeWave, CutWave, Sheets, WayInside
						, BoxSize, TransplantSize, Description, BoxName, InventoryName
				FROM #TempMP2192 WITH (NOLOCK) 
				ORDER BY '+@OrderBy+''

 	 EXEC (@sSQL)
	 PRINT (@sSQL)









GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
