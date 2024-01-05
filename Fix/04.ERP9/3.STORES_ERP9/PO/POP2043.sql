IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP2043]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP2043]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Load Grid Form so sánh báo giá POF2043
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created 	on 15/03/2019 by Như Hàn
----Modified 	on 12/06/2023 by Văn Tài - [2023/06/IS/0111] Xử lý join dữ liệu sai tại màn hình báo giá.
----Modify on ... by ...
-- <Example>
/*  
 EXEC POP2043 @DivisionID= 'AIC', @APK = '4B48353A-6197-4B81-9143-5A96F7E5230E', @Mode = 2
*/
----
CREATE PROCEDURE POP2043 ( 
        @DivisionID VARCHAR(50),
		@APK VARCHAR(50),
		@Mode INT = 0 ----: 0; Đổ ra danh sách nhà cung cấp, 1 Đổ dữ liệu lưới
) 
AS 

IF ISNULL(@Mode,0) = 0
	BEGIN 
	
		SELECT DISTINCT T21.ObjectID, T12.ObjectName
		FROM POT2022 T22 WITH (NOLOCK)
		INNER JOIN POT2021 T21 WITH (NOLOCK) ON T22.APKMaster = T21.APK
		LEFT JOIN AT1202 T12 WITH (NOLOCK) ON T21.ObjectID = T12.ObjectID
		WHERE T22.InheritTableID = 'OT3101' AND T22.InheritAPK = @APK

	END
ELSE IF ISNULL(@Mode,0) = 1
	BEGIN

		DECLARE @cols  AS NVARCHAR(MAX)='';
		DECLARE @query AS NVARCHAR(MAX)='';

		SELECT @cols = @cols + QUOTENAME(ObjectID) + ',' FROM (SELECT DISTINCT 'DT'+ T21.ObjectID As ObjectID FROM POT2022 T22 WITH (NOLOCK) 
																INNER JOIN POT2021 T21 WITH (NOLOCK) ON T22.APKMaster = T21.APK 
																LEFT JOIN AT1202 T12 WITH (NOLOCK) ON T21.ObjectID = T12.ObjectID
																WHERE T22.InheritTableID = 'OT3101' AND T22.InheritAPK = @APK
																) as tmp
		SELECT @cols = substring(@cols, 0, len(@cols))

		SET @query = 
		'SELECT * FROM
		(
			SELECT T22.InventoryID
					, T02.InventoryName
					, T32.RequestPrice
					, T22.Notes
					, ''DT'' + T21.ObjectID AS ObjectID
					, CONVERT(Varchar(50), T22.UnitPrice) + ''@'' + CONVERT(VARCHAR(50), T22.APK) + ''@'' + CONVERT(Varchar(50), ISNULL(T22.IsSelectPrice,0)) SQL
			FROM POT2022 T22 WITH (NOLOCK)
			INNER JOIN POT2021 T21 WITH (NOLOCK) ON T22.APKMaster = T21.APK
			LEFT JOIN OT3102 T32 WITH (NOLOCK) ON T22.InheritAPKDetail = T32.APK
			LEFT JOIN AT1302 T02 WITH (NOLOCK) ON T22.DivisionID IN (''@@@'', T22.DivisionID) AND T22.InventoryID = T02.InventoryID
			LEFT JOIN AT1202 T12 WITH (NOLOCK) ON T12.DivisionID IN (''@@@'', T22.DivisionID) AND T21.ObjectID = T12.ObjectID
			WHERE T22.InheritTableID = ''OT3101'' AND ISNULL(T21.DeleteFlag,0) = 0 AND T22.InheritAPK = '''+@APK+'''
		) src
		pivot 
		(
			max(SQL) for ObjectID in (' + @cols + ')
		) piv
	

		'

END
ELSE IF ISNULL(@Mode,0) = 2
BEGIN

		UPDATE T22
		SET IsSelectPrice = 0
		FROM POT2022 T22 WITH (NOLOCK) 
		INNER JOIN POT2021 T21 WITH (NOLOCK) ON T22.APKMaster = T21.APK 
		LEFT JOIN AT1202 T12 WITH (NOLOCK) ON T12.DivisionID IN ('@@@', T22.DivisionID) AND T21.ObjectID = T12.ObjectID
		WHERE T22.InheritTableID = 'OT3101' AND T22.InheritAPK = @APK
END


	PRINT @query
	IF ISNULL(@cols,'') <> ''
	EXEC(@query)
	--DROP TABLE #TEMP



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
