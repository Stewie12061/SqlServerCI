IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2021]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2021]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Kiểm tra Sửa/Xóa Đơn xin Phép ra ngoài
---- Xóa Đơn xin phép ra ngoài
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Bảo Thy, Date: 03/12/2015
/*-- <Example>
	OOP2021 @DivisionID='CTY',@UserID='ASOFTADMIN',@APK=NULL,@APKList='835EF49C-D440-43F1-ABB7-31977B61478E',@Mode=1
	OOP2021 @DivisionID='CTY',@UserID='ASOFTADMIN',@APK=NULL,@APKList=NULL,@Mode=0
----*/


CREATE PROCEDURE OOP2021
( 
  @DivisionID VARCHAR(50),
  @UserID VARCHAR(50),
  @APK VARCHAR(50),
  @APKList VARCHAR(MAX),
  @Mode TINYINT --0: Edit, 1: Delete
) 
AS 
DECLARE @sSQL NVARCHAR(MAX)	

IF @Mode = 1 SET @sSQL = '
DECLARE @Cur CURSOR,
		@Params1 NVARCHAR(MAX) = '''',
		@DelAPK VARCHAR(50),
		@ID VARCHAR(50)
		
SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT ID,APK FROM OOT9000 WHERE APK IN ('''+@APKList+''')
OPEN @Cur
FETCH NEXT FROM @Cur INTO @ID, @DelAPK
WHILE @@FETCH_STATUS = 0
BEGIN	
	IF (EXISTS (SELECT TOP 1 1 FROM OOT9000 WHERE APK = @DelAPK AND ISNULL(Status,0) <> 2 AND ISNULL(ApprovingLevel,0) > 0))-- Kiểm tra Đơn ra ngoài đã được duyệt
		SET @Params1 = @Params1 + @ID + '', ''
	ELSE
		BEGIN
			IF EXISTS (SELECT TOP 1 1 FROM OOT2060 WITH (NOLOCK) WHERE APK = @DelAPK)
			BEGIN
				UPDATE OOT2060
				SET [Status] = 0
				WHERE APK = @DelAPK
			END
			DELETE OOT9000 WHERE APK = @DelAPK
			DELETE OOT9001 WHERE APKMaster = @DelAPK
			DELETE OOT2020 WHERE APKMaster = @DelAPK
			DELETE OOT2001 WHERE APKMaster =@DelAPK
		END
	FETCH NEXT FROM @Cur INTO @ID, @DelAPK
END 
Close @Cur
IF @Params1 <> '''' SET @Params1 = LEFT(@Params1, LEN(@Params1)- 1)
SELECT * FROM
(
SELECT 2 AS Status,''OOFML000015'' AS MessageID, @Params1 AS Params
)A WHERE A.Params <> '''' '

IF @Mode = 0 SET @sSQL = '
DECLARE @Params NVARCHAR(MAX),
		@MessageID VARCHAR(50)		
SET @Params = ''''		
IF (EXISTS (SELECT TOP 1 1 FROM OOT9000 WHERE APK = '''+@APK+''' AND ISNULL(Status,0) <> 2 AND ApprovingLevel>0))-- Kiểm tra Đơn xin phép ra ngoài đã được duyệt
	BEGIN	
		SET @Params = '''+@APK+'''
		SET @MessageID = ''OOFML000015''
	END
SELECT 2 AS Status, @MessageID AS MessageID, @Params AS Params
WHERE @Params <> ''''   '

EXEC (@sSQL)
--PRINT(@sSQL)
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO



