IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP2193]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP2193]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO










-- <Summary>
---- Load detail thông tin phụ liệu
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: [Minh Phúc ] - 08/06/2021
-- <Example> EXEC MP2193 @DivisionID = 'BE', @UserID = '', @APK = '9B8430BF-53C2-4EAB-A524-50BC4F2FCA82'

CREATE PROCEDURE MP2193
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

	SET @OrderBy = N'ComponentQuantity'

	SET @sSQL = N'
				SELECT  M1.APK, M1.DivisionID, M1.InheritVoucher, M1.ComponentQuantity, M1.ComponentID, M1.BoxID,A3.InventoryName AS ComponentName
				INTO #TempMP2193
				FROM MT2192 M1 WITH (NOLOCK)
					LEFT JOIN MT2190 M2 WITH (NOLOCK) ON M1.APKMaster = M2.APK
					LEFT JOIN AT1302 A3 WITH(NOLOCK) ON A3.InventoryID = M1.ComponentID
				WHERE  CONVERT(VARCHAR(50),M2.APK) = '''+@APK+''' AND M2.DivisionID = ''' + @DivisionID + '''

				DECLARE @Count INT
				SELECT @Count = COUNT(*) FROM #TempMP2193
				
				SELECT  CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, @Count AS TotalRow
						, APK, DivisionID, InheritVoucher, ComponentQuantity, ComponentID, BoxID,ComponentName
				FROM #TempMP2193 WITH (NOLOCK) 
				ORDER BY '+@OrderBy+''

 	 EXEC (@sSQL)
	 PRINT (@sSQL)








GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
