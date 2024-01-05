IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP20405]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP20405]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Load dữ liệu ngầm cho Grid trên màn hình Cập nhật chiến dịch Marketing - CRMF2141
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Tấn Lộc, Date 27/07/2021
-- <Example>

CREATE PROCEDURE CRMP20405 
( 
	@CustomizeIndex VARCHAR(50)
) 
AS 

DECLARE @sSQL NVARCHAR (MAX), 
		@sWhere NVARCHAR(MAX),
		@CodeMaster NVARCHAR(250)

SET @CustomizeIndex = (SELECT CustomerName FROM CustomerIndex)

-- CBD thì xài Code master = CRMT00000031
IF (@CustomizeIndex = 130)
	BEGIN
		SET @CodeMaster = 'CRMT00000031'
	END
ELSE
	BEGIN
		SET @CodeMaster = 'CRMT00000033'
	END



SET @sSQL = 'SELECT ID AS ConversionTargetID, Description AS ConversionTargetName 
			 FROM CRMT0099 WITH (NOLOCK)
			 WHERE [Disabled] = ''0'' AND CodeMaster ='''+@CodeMaster+''' 
			 ORDER BY OrderNo '


EXEC (@sSQL)
PRINT (@sSQL)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
