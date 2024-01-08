IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP1001]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP1001]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Kiểm tra Sửa/Xóa Danh mục Loại phép
---- Xóa danh mục Loại phép
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Bảo Thy, Date: 26/11/2015
---- 
/*-- <Example>
	Exec OOP1001 @DivisionID='CTY',@UserID='ASOFTADMIN',@APK=NULL,@Mode=0
	Exec OOP1001 @DivisionID='CTY',@UserID='ASOFTADMIN',@APKList='2A5687D8-563C-47E0-B870-0D6853EDC681',@Mode=1
----*/

CREATE PROCEDURE OOP1001
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
		@DelAbsentTypeID VARCHAR(50)
SET @Params1 = ''''
SET @Params2 = ''''
SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT DivisionID, AbsentTypeID FROM OOT1000 WHERE APK IN ('''+@APKList+''')
OPEN @Cur
FETCH NEXT FROM @Cur INTO @DelDivisionID, @DelAbsentTypeID
WHILE @@FETCH_STATUS = 0
BEGIN
	IF (@DelDivisionID <> '''+@DivisionID+''')   --kiểm tra khác DivisionID
		SET @Params1 = @Params1 + @DelAbsentTypeID + '', ''
	ELSE
		BEGIN		
			IF (EXISTS (SELECT TOP 1 1 FROM OOT2010 WHERE DivisionID=@DelDivisionID AND  AbsentTypeID = @DelAbsentTypeID)) -- kiểm tra loại phép đã được sử dụng	
			   OR (EXISTS (SELECT TOP 1 1 FROM OOT1000 WHERE DivisionID=@DelDivisionID AND ISNULL(IsDefault,0)=1 AND AbsentTypeID=@DelAbsentTypeID))
				SET @Params2 = @Params2 + @DelAbsentTypeID + '', ''			
			ELSE
				BEGIN
					DELETE OOT1000 WHERE AbsentTypeID = @DelAbsentTypeID
				END
		END	
	FETCH NEXT FROM @Cur INTO @DelDivisionID, @DelAbsentTypeID
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

IF ('''+@DivisionID+''' <> (SELECT TOP 1 DivisionID FROM OOT1000 WHERE APK= '''+@APK+''')) -- kiểm tra khác Division
	BEGIN
		SET @Params = SELECT TOP 1 AbsentTypeID FROM OOT1000 WHERE APK='''+@APK+'''
		SET @MessageID = ''00ML000050''
	END
IF @Params <> '''' SET @Params = LEFT(@Params, LEN(@Params)- 1)
SELECT 2 AS Status, @MessageID AS MessageID, @Params AS Params
WHERE @Params <> ''''   '

EXEC (@sSQL)
--PRINT @sSQL
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
