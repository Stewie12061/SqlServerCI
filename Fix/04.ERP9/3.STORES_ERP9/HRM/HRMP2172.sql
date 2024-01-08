IF EXISTS
(
    SELECT TOP 1
           1
    FROM dbo.sysobjects
    WHERE id = OBJECT_ID(N'[DBO].[HRMP2172]')
          AND OBJECTPROPERTY(id, N'IsProcedure') = 1
)
    DROP PROCEDURE [dbo].[HRMP2172];
GO
SET QUOTED_IDENTIFIER ON;
GO
SET ANSI_NULLS ON;
GO


-- <Summary>
---- Kiểm tra Sửa/Xóa điều chuyển tạm thời
---- Xóa  điều chuyển tạm thời
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hoài Phong, Date: 08/01/2021

CREATE PROCEDURE HRMP2172
(
    @DivisionID VARCHAR(50),
    @UserID VARCHAR(50),
    @APK VARCHAR(50),
    @APKList VARCHAR(MAX),
    @Mode TINYINT --0: Edit, 1: Delete
)
AS
DECLARE @sSQL NVARCHAR(MAX);

IF @Mode = 1
    SET @sSQL
        = '
DECLARE @Cur CURSOR,
		@Params1 NVARCHAR(MAX) = '''',
		@DelAPK VARCHAR(50),
		@ID VARCHAR(50)
		
SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT ID,APK FROM OOT9000 WHERE APK IN (''' + @APKList
          + ''')
OPEN @Cur
FETCH NEXT FROM @Cur INTO @ID, @DelAPK
WHILE @@FETCH_STATUS = 0
BEGIN	
	IF (EXISTS (SELECT TOP 1 1 FROM HRMT2170 WITH (NOLOCK) WHERE APK = @DelAPK AND ISNULL(Status,0) = 1 AND ISNULL(ApproveLevel,0) > 0))-- Kiểm tra Đơn nghỉ phép đã được duyệt
		SET @Params1 = @Params1 + @ID + '', ''
	ELSE
		BEGIN			
			DELETE OOT9000 WHERE APK = @DelAPK
			DELETE OOT9001 WHERE APKMaster = @DelAPK
			DELETE HRMT2170 WHERE APK = @DelAPK
			DELETE HRMT2171 WHERE APKMaster =@DelAPK
		END
	FETCH NEXT FROM @Cur INTO @ID, @DelAPK
END 
Close @Cur
IF @Params1 <> '''' SET @Params1 = LEFT(@Params1, LEN(@Params1)- 1)
SELECT * FROM
(
SELECT 2 AS Status,''CRMFML000015'' AS MessageID, @Params1 AS Params
)A WHERE A.Params <> '''' ';

IF @Mode = 0
    SET @sSQL
        = '
DECLARE @Params NVARCHAR(MAX),
		@MessageID VARCHAR(50)		
SET @Params = ''''		
IF (EXISTS (SELECT TOP 1 1 FROM HRMT2170 WITH (NOLOCK) WHERE APK = ''' + @APK
          + ''' AND ISNULL(Status,0) = 1 AND ApproveLevel>0))-- Kiểm tra Đơn xin phép ra ngoài đã được duyệt
	BEGIN	
		SET @Params = ''' + @APK
          + '''
		SET @MessageID = ''CRMFML000015''
	END
SELECT 2 AS Status, @MessageID AS MessageID, @Params AS Params
WHERE @Params <> ''''   ';

EXEC (@sSQL);
PRINT (@sSQL);


GO
SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS ON;
GO
