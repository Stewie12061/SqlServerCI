IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0038]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0038]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- AP0038
-- <Summary>
---- Stored load lưới màn hình thiết lập phương pháp phân bổ theo nhiều cấp (PACIFIC) 
---- Created on 10/04/2017 Hải Long
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- [ASOFT-T] - Danh mục - Thiết lập phương pháp phân bổ nhiều cấp (AF0352)
-- <History>
---- Modified on 11/08/2014 by 
-- <Example>
---- EXEC AP0038 @DivisionID = 'ANG', @UserID = 'ASOFTADMIN'

CREATE PROCEDURE [DBO].[AP0038]
( 
	@DivisionID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50)
) 
AS

DECLARE @sSQL NVARCHAR(MAX)

SET @sSQL = N'
SELECT AT1610.DivisionID, AT1610.AllocationID, AT1610.AllocationType,
(CASE WHEN AT1610.AllocationType = 1 THEN N''Tỉ lệ'' 
      WHEN AT1610.AllocationType = 2 THEN N''Số lượng nhân viên''
      ELSE N''Giá trị ấn định'' END) as AllocationTypeName,
AT1610.AllocationLevelID, AV0020.AllocationLevelName, AT1610.DESCRIPTION, AT1610.TranMonth, AT1610.TranYear
FROM AT1610 WITH (NOLOCK)
LEFT JOIN AV0020 ON AT1610.AllocationLevelID = AV0020.AllocationLevelID
WHERE AT1610.DivisionID = ''' + @DivisionID + '''
ORDER BY AT1610.CreateDate DESC
'
--PRINT @sSQL
EXEC (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
