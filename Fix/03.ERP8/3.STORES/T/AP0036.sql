IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0036]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0036]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- AP0036
-- <Summary>
---- Stored load combo mã phân tích ở màn hình cập nhật phương pháp phân bổ (PACIFIC)
---- Created on 10/04/2017 Hải Long
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Modified by Bảo Anh on 27/05/2017: Sửa danh mục dùng chung
-- <Example>
---- EXEC AP0036 @DivisionID = 'ANG', @AllocationLevelID = 1, @UserID = 'ASOFTADMIN'

CREATE PROCEDURE [DBO].[AP0036]
( 
	@DivisionID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50),
	@AllocationLevelID AS TINYINT
) 
AS

DECLARE @sSQL NVARCHAR(MAX)

SET @sSQL = '
SELECT AnaID, AnaTypeID, AnaName 
FROM AT1011 WITH (NOLOCK)
WHERE DivisionID in (''@@@'',''' + @DivisionID + ''')
AND AnaTypeID = (SELECT TypeID FROM AT0005 WITH (NOLOCK) WHERE DivisionID = ''' + @DivisionID + ''' AND AllocationLevelID = ' + CONVERT(NVARCHAR(2), @AllocationLevelID) + ')
ORDER BY AnaID
'
--PRINT @sSQL
EXEC (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
