IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0037]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0037]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- AP0037
-- <Summary>
---- Stored load edit màn hình cập nhật phương pháp phân bổ (PACIFIC)
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
---- EXEC AP0037 @DivisionID = 'ANG', @AllocationID = 'ABC', @UserID = 'ASOFTADMIN'

CREATE PROCEDURE [DBO].[AP0037]
( 
	@DivisionID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50),
	@AllocationID AS NVARCHAR(50)
) 
AS

DECLARE @sSQL NVARCHAR(MAX)

SET @sSQL = '
SELECT AT1610.DivisionID, AT1610.AllocationID, AT1610.AllocationType, AT1610.AllocationLevelID, AT1610.DESCRIPTION, AT1610.TranMonth, AT1610.TranYear, 
AT1611.TransactionID, AT1611.AnaID, AT1011.AnaName, AT1611.PercentRate, AT1611.EmployeeNumber, AT1611.Notes
FROM AT1610 WITH (NOLOCK)
INNER JOIN AT1611 WITH (NOLOCK) ON AT1610.DivisionID = AT1611.DivisionID AND AT1610.AllocationID = AT1611.AllocationID
LEFT JOIN AT1011 WITH (NOLOCK) ON AT1011.AnaID = AT1611.AnaID AND AT1011.AnaTypeID = AT1611.AnaTypeID 
WHERE AT1610.DivisionID = ''' + @DivisionID + '''
AND AT1610.AllocationID = ''' + @AllocationID + '''
'
--PRINT @sSQL
EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
