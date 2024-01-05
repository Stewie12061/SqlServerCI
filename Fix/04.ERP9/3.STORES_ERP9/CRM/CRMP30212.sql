IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP30212]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP30212]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Load danh sách Loại chiến dịch
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Tấn Lộc, Date 08/09/2022
-- <Example>

CREATE PROCEDURE CRMP30212 
(
	@CustomerIndex INT
)
AS 

DECLARE @sSQL NVARCHAR (MAX), 
		@sWhere NVARCHAR(MAX)
		
-- Lấy CustomerIndex
SELECT TOP 1 @CustomerIndex = CustomerName FROM dbo.CustomerIndex

-- Loại chiến dịch của CBD
IF @CustomerIndex = 130
BEGIN
	SET @sSQL = '
	SELECT CodeMaster, ID, Description
	FROM CRMT0099 WITH (NOLOCK)
	WHERE Codemaster = ''CRMT00000032'' AND Disabled = 0
	ORDER BY OrderNo'
END
ELSE 
BEGIN
	SET @sSQL = '
	SELECT CodeMaster, ID, Description
	FROM CRMT0099 WITH (NOLOCK)
	WHERE Codemaster = ''CRMT00000011'' AND Disabled = 0
	ORDER BY OrderNo'
END 


EXEC (@sSQL)
PRINT (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
