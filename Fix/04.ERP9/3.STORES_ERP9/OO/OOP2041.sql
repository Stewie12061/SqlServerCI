IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2041]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2041]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Kiểm tra Sửa/Xóa Đơn xin bổ sung/hủy quẹt thẻ
---- Xóa Đơn xin bổ sung/hủy quẹt thẻ
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Bảo Thy, Date: 11/12/2015
--- Modified on 04/01/2019 by Bảo Anh: Sửa câu kiểm tra đơn đã duyệt
--- Modified on 04/11/2022 by Đức Tuyên: Fix lỗi xóa hoàn loạt không được
/*-- <Example>
	OOP2041 @DivisionID='CTY',@UserID='ASOFTADMIN',@APK='',@APKList=NULL,@Mode=1
	OOP2041 @DivisionID='CTY',@UserID='ASOFTADMIN',@APK='',@APKList=NULL,@Mode=0
----*/


CREATE PROCEDURE OOP2041
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
SELECT APK, ID FROM OOT9000 WHERE APK IN ('''+@APKList+''')
OPEN @Cur
FETCH NEXT FROM @Cur INTO @DelAPK, @ID
WHILE @@FETCH_STATUS = 0
BEGIN	
	IF (EXISTS (SELECT TOP 1 1 FROM OOT2040 WITH (NOLOCK) WHERE Convert(Varchar(50),APKMaster) = @DelAPK AND ISNULL(Status,0) = 1)) -- Kiểm tra Đơn xin bổ sung/hủy quẹt thẻ đã được duyệt  
		SET @Params1 = @Params1 + @ID + '', ''			
	ELSE
		BEGIN
			IF EXISTS (SELECT TOP 1 1 FROM OOT2060 WITH (NOLOCK) WHERE Convert(Varchar(50),APK) = @DelAPK)
			BEGIN
				UPDATE OOT2060
				SET [Status] = 0
				WHERE APK = @DelAPK
			END
			DELETE OOT9000 WHERE Convert(Varchar(50),APK) = @DelAPK
			DELETE OOT9001 WHERE Convert(Varchar(50),APKMaster) = @DelAPK
			DELETE OOT2040 WHERE Convert(Varchar(50),APKMaster) = @DelAPK
			DELETE OOT2041 WHERE Convert(Varchar(50),ID) =@ID
			--DELETE OOT2001 WHERE Convert(Varchar(50),APKMaster) =@DelAPK
		END
	FETCH NEXT FROM @Cur INTO @DelAPK, @ID
END 
Close @Cur
IF @Params1 <> '''' SET @Params1 = LEFT(@Params1, LEN(@Params1)- 1)
SELECT * FROM
(
SELECT 2 AS Status,''00ML000117'' AS MessageID, @Params1 AS Params
)A WHERE A.Params <> '''' '

IF @Mode = 0 SET @sSQL = '
DECLARE @Params NVARCHAR(MAX),
		@MessageID VARCHAR(50)	
IF (EXISTS (SELECT TOP 1 1 FROM OOT2040 WITH (NOLOCK) WHERE APK = '''+@APK+''' AND ISNULL(Status,0) <> 2 AND ApprovingLevel>0))-- Kiểm tra Đơn xin bổ sung/hủy quẹt thẻ đã được duyệt
	BEGIN	
		SET @Params = '''+@APK+'''
		SET @MessageID = ''OOFML000015''
	END		
SET @Params = ''''		
SELECT 2 AS Status, @MessageID AS MessageID, @Params AS Params
WHERE @Params <> ''''   '

--PRINT (@sSQL)
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
