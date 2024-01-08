IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP1011]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP1011]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Kiểm tra Sửa/Xóa Danh mục Loại bất thường
---- Xóa danh mục Loại bất thường
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Bảo Thy, Date: 27/11/2015
--- Modified on 30/08/2018 by Bảo Anh: Bổ sung xóa bảng chi tiết OOT1011
-- <Example>
-- Exec OOP1011 @DivisionID='CTY',@UserID='ASOFTADMIN',@APKList='2A5687D8-563C-47E0-B870-0D6853EDC681',@Mode=1
---- 


CREATE PROCEDURE OOP1011
( 
  @DivisionID VARCHAR(50),
  @UserID VARCHAR(50),
  @APK VARCHAR(50) = NULL,
  @APKList NVARCHAR(MAX) = NULL,
  @Mode TINYINT --0: Edit, 1: Delete
) 
AS 
DECLARE @sSQL NVARCHAR(MAX),
		@sSQL1 NVARCHAR(MAX)

IF @Mode = 1 SET @sSQL = '
DECLARE @Cur CURSOR,
		@Params1 NVARCHAR(MAX),
		@Params2 NVARCHAR(MAX),
		@DelDivisionID VARCHAR(50),
		@DelUnusualTypeID VARCHAR(50),
		@APK1 VARCHAR(50)

SET @Params1 = ''''
SET @Params2 = ''''
SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT DivisionID, UnusualTypeID, APK FROM OOT1010 WHERE APK IN ('''+@APKList+''')
OPEN @Cur
FETCH NEXT FROM @Cur INTO @DelDivisionID, @DelUnusualTypeID, @APK1
WHILE @@FETCH_STATUS = 0
BEGIN
	IF (@DelDivisionID <> '''+@DivisionID+''')   --kiểm tra khác DivisionID
		SET @Params1 = @Params1 + @DelUnusualTypeID + '', ''
	ELSE
		BEGIN		
			IF (EXISTS (SELECT TOP 1 1 FROM OOT2060 WHERE DivisionID=@DelDivisionID AND JugdeUnusualType = @DelUnusualTypeID)) -- kiểm tra đã được sử dụng	
			   OR (EXISTS (SELECT TOP 1 1 FROM OOT1010 WHERE DivisionID=@DelDivisionID AND UnusualTypeID = @DelUnusualTypeID AND ISNULL(ISDefault,0)=1))
				SET @Params2 = @Params2 + @DelUnusualTypeID + '', ''			
			ELSE
				BEGIN
					DELETE OOT1010 WHERE UnusualTypeID = @DelUnusualTypeID
					DELETE OOT1011 WHERE DivisionID = @DelDivisionID AND APKMaster = @APK1
				END
		END	
	FETCH NEXT FROM @Cur INTO @DelDivisionID, @DelUnusualTypeID, @APK1
END 
IF @Params1 <> '''' SET @Params1 = LEFT(@Params1, LEN(@Params1)- 1)
IF @Params2 <> '''' SET @Params2 = LEFT(@Params2, LEN(@Params2)- 1)

SELECT * FROM
(
SELECT 2 AS Status,''00ML000050'' AS MessageID, @Params1 AS Params             
UNION ALL 
SELECT 2 AS Status,''00ML000052'' AS MessageID, @Params2 AS Params
)A WHERE A.Params <> '''' '

IF @Mode = 0 SET @sSQL = '
DECLARE @Params NVARCHAR(MAX),
		@MessageID VARCHAR(50)
SET @Params = ''''

IF ('''+@DivisionID+''' <> (SELECT TOP 1 DivisionID FROM OOT1010 WHERE UnusualTypeID = '''+@APK+''')) -- kiểm tra khác Division
	BEGIN
		SET @Params = ELECT TOP 1 UnusualTypeID FROM OOT1010 WHERE UnusualTypeID = '''+@APK+'''
		SET @MessageID = ''00ML000050''
	END
IF @Params <> '''' SET @Params = LEFT(@Params, LEN(@Params)- 1)
SELECT 2 AS Status, @MessageID AS MessageID, @Params AS Params
WHERE @Params <> ''''   '

EXEC (@sSQL)
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
