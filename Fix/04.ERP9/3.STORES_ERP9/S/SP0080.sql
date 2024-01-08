IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SP0080]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SP0080]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Load danh sách mã màn hình - cbb phu thuộc trên màn hình thiết lập dữ liệu mặc định SF0080
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Trọng Kiên, Date 05/11/2020
-- <Example>

CREATE PROCEDURE SP0080 
( 
	@DatabaseAdmin VARCHAR(50),
	@ModuleID VARCHAR(50)
) 
AS 

DECLARE @sSQL NVARCHAR (MAX), 
		@sWhere NVARCHAR(MAX)

SET @sSQL = 'SELECT A1.ScreenID, A1.ScreenName
             FROM ['+@DatabaseAdmin+'].[dbo].sysScreen A1 WITH (NOLOCK)
			 WHERE A1.sysCategoryBusinessID = 2 AND A1.ModuleID = '''+@ModuleID+''''


EXEC (@sSQL)
PRINT (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
