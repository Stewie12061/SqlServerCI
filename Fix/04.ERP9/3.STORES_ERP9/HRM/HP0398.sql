IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0398]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0398]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Kiểm tra Sửa/Xóa danh mục phương pháp tính phép
---- Xóa phương pháp tính phép
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Tiểu Mai on 16/12/2016
/*-- <Example>
	HP0398 @DivisionID='ANG',@APKList=NULL,@Mode=1,N'HF0396'
	
----*/


CREATE PROCEDURE HP0398
( 
  @DivisionID VARCHAR(50),
  @APKList VARCHAR(MAX),
  @Mode TINYINT, --0: Edit, 1: Delete
  @Form NVARCHAR(50)
) 
AS 
DECLARE @sSQL NVARCHAR(MAX)	

SET @sSQL = '
	DECLARE @Cur CURSOR,
			@Params1 NVARCHAR(MAX) = '''',
			@DelAPK VARCHAR(50),
			@ID VARCHAR(50)
		'
IF @Form = 'HF0396'
BEGIN
	IF @Mode = 1 
	BEGIN 
		SET @sSQL = @sSQL + '
		SET @Cur = CURSOR SCROLL KEYSET FOR
		SELECT MethodVacationID,APK FROM HT1029 WITH (NOLOCK) WHERE APK IN ('''+@APKList+''') 
		OPEN @Cur
		FETCH NEXT FROM @Cur INTO @ID, @DelAPK
		WHILE @@FETCH_STATUS = 0
		BEGIN	
			IF (EXISTS (SELECT TOP 1 1 FROM HT2803 WITH (NOLOCK) WHERE MethodVacationID = @ID AND DivisionID = '''+@DivisionID+'''))-- Kiểm tra phương pháp tính phep đã được sử dụng
				SET @Params1 = @Params1 + @ID + '', ''
			ELSE
				BEGIN
					DELETE HT1029 WHERE APK = @DelAPK AND DivisionID = '''+@DivisionID+'''
				END
			FETCH NEXT FROM @Cur INTO @ID, @DelAPK
		END 
		Close @Cur
		IF @Params1 <> '''' SET @Params1 = LEFT(@Params1, LEN(@Params1)- 1)
		SELECT * FROM
		(
		SELECT 1 AS Status,''HFML000545'' AS MessageID, @Params1 AS Params
		)A WHERE A.Params <> '''' '
	END 
	IF @Mode = 0
	BEGIN
		SET @sSQL = @sSQL + '	
			IF (EXISTS (SELECT TOP 1 1 FROM HT2803 WITH (NOLOCK) 
						LEFT JOIN HT1029 WITH (NOLOCK) ON HT2803.DivisionID = HT1029.DivisionID AND HT2803.MethodVacationID = HT1029.MethodVacationID
						WHERE HT1029.APK = '''+@APKList+''' AND HT2803.DivisionID = '''+@DivisionID+'''))-- Kiểm tra phương pháp tính phep đã được sử dụng
				SET @Params1 = @Params1 + @ID + '', ''
	
		IF @Params1 <> '''' SET @Params1 = LEFT(@Params1, LEN(@Params1)- 1)
		SELECT * FROM
		(
		SELECT 1 AS Status,''HFML000546'' AS MessageID, @Params1 AS Params
		)A WHERE A.Params <> '''' '
	END	
END
IF @Form = 'HF0392'
BEGIN
IF @Mode = 1 
	BEGIN 
		SET @sSQL = @sSQL + '
		SET @Cur = CURSOR SCROLL KEYSET FOR
		SELECT SeniorityID, APK FROM HT1027 WITH (NOLOCK) WHERE APK IN ('''+@APKList+''') 
		OPEN @Cur
		FETCH NEXT FROM @Cur INTO @ID, @DelAPK
		WHILE @@FETCH_STATUS = 0
		BEGIN	
			IF (EXISTS (SELECT TOP 1 1 FROM HT1029 WITH (NOLOCK) WHERE SeniorityID = @ID AND DivisionID = '''+@DivisionID+'''))-- Kiểm tra phép thâm niên đã được sử dụng
				SET @Params1 = @Params1 + @ID + '', ''
			ELSE
			BEGIN
					DELETE HT1028 
					FROM HT1028
					LEFT JOIN HT1027 ON HT1028.DivisionID = HT1027.DivisionID AND HT1027.SeniorityID = HT1028.SeniorityID
					WHERE HT1027.APK = @DelAPK AND HT1028.DivisionID = '''+@DivisionID+'''
					
					DELETE HT1027 WHERE APK = @DelAPK AND DivisionID = '''+@DivisionID+'''
				END
			FETCH NEXT FROM @Cur INTO @ID, @DelAPK
		END 
		Close @Cur
		IF @Params1 <> '''' SET @Params1 = LEFT(@Params1, LEN(@Params1)- 1)
		SELECT * FROM
		(
		SELECT 1 AS Status,''HFML000009'' AS MessageID, @Params1 AS Params
		)A WHERE A.Params <> '''' '
	END 
	IF @Mode = 0
	BEGIN
		SET @sSQL = @sSQL + '	
			IF (EXISTS (SELECT TOP 1 1 FROM HT1029 WITH (NOLOCK) WHERE SeniorityID = @ID AND DivisionID = '''+@DivisionID+'''))-- Kiểm tra phép thâm niên đã được sử dụng
				SET @Params1 = @Params1 + @ID + '', ''
	
		IF @Params1 <> '''' SET @Params1 = LEFT(@Params1, LEN(@Params1)- 1)
		SELECT * FROM
		(
		SELECT 1 AS Status,''HFML000009'' AS MessageID, @Params1 AS Params
		)A WHERE A.Params <> '''' '
	END		
END
EXEC (@sSQL)
PRINT @sSQL

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
