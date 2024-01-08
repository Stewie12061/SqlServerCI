IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2282]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2282]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-- <Summary>
---- Load danh sách màn hình nghiệp theo module - cbb phu thuộc
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Tấn Lộc, Date 28/01/2021
-- <Example>

CREATE PROCEDURE OOP2282 
( 
	@DatabaseAdmin VARCHAR(50),
	@ModuleID VARCHAR(50)
) 
AS 

DECLARE @sSQL NVARCHAR (MAX), 
		@sWhere NVARCHAR(MAX)

SET @sSQL = 'SELECT S1.DivisionID, S1.ModuleID, S1.ScreenID, S1.ScreenName, S1.sysTable, S1.sysTable AS TableID, S2.Description, S1.ScreenType, S1.Parent, S1.TypeInput, S1.sysCategoryBusinessID, S1.Version
			FROM ['+@DatabaseAdmin+'].[dbo].sysScreen S1 WITH (NOLOCK)
				LEFT JOIN ['+@DatabaseAdmin+'].[dbo].sysTable S2 WITH (NOLOCK) ON S1.sysTable = S2.TableName
			WHERE S1.ModuleID = '''+@ModuleID+''' AND S1.ScreenType = ''2'' '


EXEC (@sSQL)
PRINT (@sSQL)





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
