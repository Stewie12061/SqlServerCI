IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[BP3009]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[BP3009]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO








-- <Summary>
---- Laod detail của mã phân tích
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Tấn Lộc, Date 15/06/2021
-- <Example>

CREATE PROCEDURE BP3009 
( 
	@DivisionID VARCHAR(50),
	@GroupID1 VARCHAR(50)
	
) 
AS 

DECLARE @sSQL NVARCHAR (MAX), 
		@sWhere NVARCHAR(MAX)

SET @sSQL = 'SELECT A1.SelectionID AS ValueID, A1.SelectionName AS ValueName			FROM AV6666 A1 WITH (NOLOCK) 			WHERE A1.SelectionType=''' +@GroupID1+''' AND  A1.DivisionID = '''+@DivisionID+''' '


EXEC (@sSQL)
PRINT (@sSQL)







GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
