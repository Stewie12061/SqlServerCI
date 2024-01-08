IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SP0082]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SP0082]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Load danh sách cột dữ liệu - cbb phu thuộc trên màn hình thiết lập dữ liệu mặc định SF0080
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Trọng Kiên, Date 05/11/2020
-- <Example>

CREATE PROCEDURE SP0082 
( 
	@DatabaseAdmin VARCHAR(50),
	@ScreenID VARCHAR(50)
) 
AS 

DECLARE @sSQL NVARCHAR (MAX), 
		@sWhere NVARCHAR(MAX)

SET @sSQL = 'SELECT S1.ColumnName AS ColumnID, A1.Name AS ColumnName
             FROM ['+@DatabaseAdmin+'].[dbo].sysFields S1 WITH (NOLOCK)
	             LEFT JOIN ['+@DatabaseAdmin+'].dbo.sysScreen S2 ON S2.sysTable = S1.sysTable 
	             LEFT JOIN  A00001 A1 ON A1.ID = S2.ScreenID+''.''+S1.ColumnName
             WHERE S2.ScreenID = '''+@ScreenID+''' AND A1.FormID = '''+@ScreenID+''' AND A1.LanguageID = ''vi-VN'' and A1.ID = S2.ScreenID+''.''+S1.ColumnName'


EXEC (@sSQL)
PRINT (@sSQL)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
