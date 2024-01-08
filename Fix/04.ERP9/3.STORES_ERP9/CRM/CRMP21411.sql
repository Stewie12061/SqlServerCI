﻿IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP21411]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].CRMP21411
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load danh sách giai đoạn bán hàng theo StageType
-- <History>
----Created 19/12/2022 by Anh Đô

CREATE PROC CRMP21411
			@DivisionID	VARCHAR(50),
			@StageType	VARCHAR(10)
AS
BEGIN
	DECLARE @sSql NVARCHAR(MAX)

	SET @sSql = N'
	SELECT
		 CRMT10401.StageID AS ID
		,CRMT10401.StageName AS Description
		,CRMT10401.Color
	FROM CRMT10401 WHERE CRMT10401.StageType = '''+ @StageType +'''
	AND CRMT10401.DivisionID IN ('''+ @DivisionID +''', ''@@@'') 
	AND ISNULL(CRMT10401.Disabled, 0) = 0
	'
	EXEC(@sSql)
	--PRINT(@sSql)
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
