IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'CIP10000') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE CIP10000
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Truy vấn dữ liệu khi truyền APK và Bảng vào để kiểm tra điều kiện
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Cao Thị Phượng, Date: 25/04/2016
-- <Example>
----    EXEC CIP10000 'D101578B-CEFC-45E1-A172-4D76CD5B6EF2'',''13245FBB-729E-4D93-95D0-9891C378DF9C','AT0005', 'ASOFTADMIN'

CREATE PROCEDURE CIP10000 ( 
		@APKList NVARCHAR(2000),  
        @TableID nvarchar(50),
		@UserID  VARCHAR(50)
) 
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX)
        
SET @sWhere ='APK IN ('''+@APKList+''')'
SET @sSQL='
	SELECT *
    FROM '+@TableID+'
	WHERE '+@sWhere+'
	'

EXEC (@sSQL)

