IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP1176]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CIP1176]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Load Grid Form CIF1176: Mapping mặt hàng từ đề nghị mua hàng 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----Asoft ERP\ Asoft-Thông tin dùng chung (CI)\ Danh mục\ Thông tin mặt hàng\ Mặt hàng\ Kế thừa.
-- <History>
----Created by Hồng Thảo on 10/08/2018 
---- Modify by Như Hàn on 05/12/2018: Chỉnh sửa lại store đổi tên các trường, thêm thông tin các trường khác
-- <Example>
---- 
/*-- <Example>
	CIP1176 @DivisionID = 'AIC', @UserID = 'ASOFTADMIN', @ProjectID = NULL
	
	EXEC CIP1176 @DivisionID,@UserID, @ASCProjectID, @StatusID
----*/

CREATE PROCEDURE CIP1176
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @ProjectID VARCHAR(max)
	
)
AS 
DECLARE @sSQL NVARCHAR (MAX) = N'',
        @sWhere NVARCHAR(MAX) = N'',
        @OrderBy NVARCHAR(500) = N'', 
		@LanguageID VARCHAR(50)

SELECT TOP 1 @LanguageID = ISNULL(LanguageID,'') FROM AT14051 WITH (NOLOCK) WHERE UserID = @UserID

SET @OrderBy = 'T1.ASCProjectID' 
SET @sWhere = @sWhere + ' T1.DivisionID IN ('''+@DivisionID+''', ''@@@'') ' 
SET @sWhere = @sWhere + '
				AND T1.ASCProjectID IN ('''+ISNULL(@ProjectID,'')+''')  '	

BEGIN
	SET @sSQL = N'
	SELECT 
     T1.APK,T1.DivisionID, T1.ASCProjectID, T1.ASCProjectID + '' - '' + T3.AnaName AS ProjectName,
	T1.ASCInventoryID, T1.ASCInvenName, T1.ASCSpecIn, T1.ASCModel, T1.ASCMadeby, T1.ASCInvenType, T1.ASCMadeIn, T1.ASCEquipment,
	T1.InventoryID, T2.InventoryName,
	T1.ASCSpecIn,
	ISNULL(T2.Specification, T1.SpecIn) As SpecIn,
	T2.I01ID, T15.AnaName As I01Name, 
	T2.I02ID, T25.AnaName As I02Name,
	T2.I03ID, T35.AnaName As I03Name,
	T2.I04ID, T45.AnaName As I04Name,
	T2.I05ID, T55.AnaName As I05Name,
	'+CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'T4.Description' ELSE 'T4.DescriptionE' END+' AS StatusName, 0 As IsLock
    FROM CIT1176 T1 WITH (NOLOCK)
	LEFT JOIN AT1302 T2 WITH (NOLOCK) ON T2.DivisionID = T1.DivisionID AND T1.InventoryID = T2.InventoryID
	LEFT JOIN AT1015 T15 WITH (NOLOCK) ON T2.I01ID = T15.AnaID AND T15.AnaTypeID = ''I01''
	LEFT JOIN AT1015 T25 WITH (NOLOCK) ON T2.I02ID = T25.AnaID AND T25.AnaTypeID = ''I02''
	LEFT JOIN AT1015 T35 WITH (NOLOCK) ON T2.I03ID = T35.AnaID AND T35.AnaTypeID = ''I03''
	LEFT JOIN AT1015 T45 WITH (NOLOCK) ON T2.I04ID = T45.AnaID AND T45.AnaTypeID = ''I04''
	LEFT JOIN AT1015 T55 WITH (NOLOCK) ON T2.I05ID = T55.AnaID AND T55.AnaTypeID = ''I05''
	LEFT JOIN AT1011 T3 WITH (NOLOCK) ON T1.ASCProjectID=T3.AnaID AND T3.AnaTypeID = ''A05''
	LEFT JOIN CIT0099 T4 WITH (NOLOCK) ON T1.StatusID=T4.ID AND T4.CodeMaster = ''CI000003''
	WHERE '+@sWhere +'
	ORDER BY '+@OrderBy+''
END

--PRINT(@sSQL)
EXEC (@sSQL)
   




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
