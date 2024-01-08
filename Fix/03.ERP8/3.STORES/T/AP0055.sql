IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0055]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0055]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- AP0055
-- <Summary>
---- Stored Xử lý phân bổ nhiều cấp (PACIFIC)
---- Created on 12/04/2017 Hải Long
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Modified on 11/08/2014 by 
-- <Example>
---- EXEC AP0055 @DivisionID = 'PCF', @UserID = 'ASOFTADMIN', @Orders = 1   

CREATE PROCEDURE [DBO].[AP0055]
( 
	@DivisionID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50),	
	@Orders AS INT
) 
AS
DECLARE	@sSQL NVARCHAR(MAX)

SET @sSQL = '
SELECT VATGroupID, VATGroupName, VATRate, ISNULL(VATWithhodingRate, 0) AS VATWithhodingRate
FROM AT1010 WITH (NOLOCK)
WHERE Disabled = 0
AND DivisionID  = ''' + @DivisionID + '''
AND IsWithhodingTax = 1
ORDER BY VATGroupID'


--PRINT @sSQL
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
