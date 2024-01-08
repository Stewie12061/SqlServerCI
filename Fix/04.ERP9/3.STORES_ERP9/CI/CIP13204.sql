IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP13204]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CIP13204]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load danh sách màn hình cập nhật nghiệp vụ theo module - cbb phu thuộc
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hoài Bảo, Date 06/12/2021
----Modified by: Nhật Quang, Date 03/04/2023  EXD - Cập nhật: Bổ sung thêm mã màn hình từ mã Phân tích mặt hàng I03
-- <Example>

CREATE PROCEDURE CIP13204
( 
	@DatabaseAdmin VARCHAR(50),
	@ModuleID VARCHAR(50)
) 
AS 

DECLARE @sSQL NVARCHAR (MAX), 
		@sWhere NVARCHAR(MAX),
		@sSQL_EXV NVARCHAR(MAX) = '';

DECLARE @CustomizeName INT = ( SELECT TOP 1 CustomerIndex.CustomerName FROM CustomerIndex)

-- Customer EXEDY
IF(@CustomizeName = 151)
BEGIN
	SET @sSQL_EXV =N'UNION ALL
	SELECT ''EXV'' AS DivisionID
	  , ''AsoftM'' AS ModuleID
	  , ''MF2161_''+ A5.AnaName AS ScreenID
	  , N''Mã tăng Số Lô '' + A5.AnaName +''_M'' AS ScreenName
	  , ''0'' AS sysTable
	  , ''0'' AS TableID
	  , N''Mã tăng Số Lô '' + A5.AnaName +''_M'' AS Description
	  , ''3'' AS ScreenType
	  , ''0'' AS Parent 
	  , ''1'' AS TypeInput
	  , ''2'' AS sysCategoryBusinessID
	  , NULL AS Version
	  FROM AT1015 A5 WITH (NOLOCK)
	  WHERE '''+@ModuleID+''' = ''AsoftM'' AND A5.AnaTypeID= ''I03'' '
END

SET @sSQL = 'SELECT S1.DivisionID, S1.ModuleID, S1.ScreenID, S1.ScreenName, S1.sysTable, S1.sysTable AS TableID, S2.Description, S1.ScreenType, S1.Parent, S1.TypeInput, S1.sysCategoryBusinessID, S1.Version
			FROM ['+@DatabaseAdmin+'].[dbo].sysScreen S1 WITH (NOLOCK)
				LEFT JOIN ['+@DatabaseAdmin+'].[dbo].sysTable S2 WITH (NOLOCK) ON S1.sysTable = S2.TableName
			WHERE S1.ModuleID = '''+@ModuleID+''' AND S1.ScreenType = ''3'' 
	'+@sSQL_EXV+' '



EXEC (@sSQL)
PRINT (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO