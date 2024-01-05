IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP2438]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP2438]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Xóa số ngày phép ban đầu 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hải Long, Date: 06/12/2016


CREATE PROCEDURE HP2438
( 
  @DivisionID VARCHAR(50),
  @UserID VARCHAR(50),
  @APKList VARCHAR(MAX)
) 
AS 
DECLARE @sSQL NVARCHAR(MAX)	

SET @sSQL = '
DELETE FROM HT1420
WHERE DivisionID = '''+@DivisionID+'''
AND APK IN ('''+@APKList+''')
'

EXEC (@sSQL)
--PRINT @sSQL
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

