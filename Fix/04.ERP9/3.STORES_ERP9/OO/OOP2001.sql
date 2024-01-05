IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2001]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2001]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Kiểm tra Sửa/Xóa bản phân ca
---- xóa đơn xin phép
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Quốc Tuấn, Date: 07/12/2015
--- Modified on 04/01/2018 by Bảo Anh: Lấy thông tin duyệt từ OOT9001
--- Modified on 06/08/2020 by Trọng Kiên: Fix điều kiện không xóa được bảng phân ca
--- Modified on 28/09/2022 by Xuân Nguyên: Cho phép xóa bảng phân ca đã bị từ chối
--- Modified on 19/10/2022 by Nhựt Trường: Fix lỗi sai cú pháp và thiếu khai báo biến @AppoveLevel.
--- Modified on 12/01/2022 by Đức Tuyên: Fix lỗi sai điều kiện check bảng phân ca đã duyệt.
/*-- <Example>
	OOP2001 @DivisionID='CTY',@UserID='',@APK=NULL,@APKList='3230ED89-8898-4223-B0F1-037829372F7C', @Mode=1
----*/


CREATE PROCEDURE OOP2001
( 
  @DivisionID VARCHAR(50),
  @UserID VARCHAR(50),
  @APK VARCHAR(50) = NULL,
  @APKList NVARCHAR(MAX) = NULL,
  @Mode TINYINT --0: Edit, 1: Delete
) 
AS 
DECLARE @sSQL NVARCHAR(MAX)	

IF @Mode = 1 SET @sSQL = '
DECLARE @Cur CURSOR,
		@Params1 NVARCHAR(MAX) = '''',
		@DelAPK VARCHAR(50),
		@ID VARCHAR(50),
		@AppoveLevel VARCHAR(50)
		
SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT ID,APK, AppoveLevel FROM OOT9000 WITH (NOLOCK) WHERE APK IN ('''+@APKList+''')
OPEN @Cur
FETCH NEXT FROM @Cur INTO @ID, @DelAPK, @AppoveLevel
WHILE @@FETCH_STATUS = 0
BEGIN	
	IF (EXISTS (SELECT TOP 1 1 FROM OOT9000 WITH (NOLOCK) WHERE APK = @DelAPK AND (ISNULL(Status,0) = 1) ))-- Kiểm tra Đơn nghỉ phép đã được duyệt
		BEGIN
			SET @Params1 = @Params1 + @ID + '', ''
		END
	ELSE
		BEGIN
			DELETE OOT9000 WHERE APK = @DelAPK
			DELETE OOT9001 WHERE APKMaster = @DelAPK
			DELETE OOT2000 WHERE APKMaster = @DelAPK
			DELETE OOT2001 WHERE APKMaster =@DelAPK
		END
	FETCH NEXT FROM @Cur INTO @ID, @DelAPK, @AppoveLevel
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
SET @Params = ''''		
IF (EXISTS (SELECT TOP 1 1 FROM OOT9001 WITH (NOLOCK) WHERE APKMaster = '''+@APK+''' AND ISNULL(Status,0) <> 2 ))-- Kiểm tra Đơn xin phép ra ngoài đã được duyệt
	BEGIN	
		SET @Params = '''+@APK+'''
		SET @MessageID = ''OOFML000015''
	END
SELECT 2 AS Status, @MessageID AS MessageID, @Params AS Params
WHERE @Params <> ''''   '

EXEC (@sSQL)
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
