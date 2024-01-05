IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP1001]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP1001]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Kiểm tra Sửa/Xóa Danh mục Nguồn tuyển dụng
---- Xóa danh mục Nguồn tuyển dụng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by Bảo Thy on 17/07/2017
---Modified by Khả Vi on 30/10/1017: Bổ sung trường hợp kiểm tra sửa xóa khi nguồn tuyển dụng là dùng chung
-- <Example>
-- Exec HRMP1001 @DivisionID = 'AS', @UserID = 'ASOFTADMIN', @ResourceList = 'NTD0001', @Mode = 0
-- Exec HRMP1001 @DivisionID, @UserID, @ResourceList, @Mode

---- 

CREATE PROCEDURE HRMP1001
( 
  @DivisionID VARCHAR(50),
  @UserID VARCHAR(50),
  @ResourceList NVARCHAR(MAX) = NULL,
  @Mode TINYINT --0: Edit, 1: Delete
) 
AS 
DECLARE @sSQL NVARCHAR(MAX)

IF @Mode = 1 
BEGIN
	SET @sSQL = '
	DECLARE @Cur CURSOR,
			@Params1 NVARCHAR(MAX),
			@Params2 NVARCHAR(MAX),
			@DelDivisionID VARCHAR(50),
			@DelResourceID VARCHAR(50),
			@DelAPK VARCHAR(50),
			@DelIsCommon VARCHAR(1)
	SET @Params1 = ''''
	SET @Params2 = ''''

	SET @Cur = CURSOR SCROLL KEYSET FOR
	SELECT APK, DivisionID, ResourceID, IsCommon 
	FROM HRMT1000 WITH (NOLOCK) WHERE ResourceID IN ('''+@ResourceList+''')
	OPEN @Cur
	FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelResourceID, @DelIsCommon
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF (@DelDivisionID <> '''+@DivisionID+''' AND  ISNULL(@DelIsCommon, 0) <> 1)   --kiểm tra khác DivisionID và không dùng chung
			SET @Params1 = @Params1 + @DelResourceID + '', ''
		ELSE IF EXISTS (SELECT TOP 1 1 FROM HRMT1031 WITH (NOLOCK) WHERE ResourceID = @DelResourceID)  -- kiểm tra đã được sử dụng	
			SET @Params2 = @Params2 + @DelResourceID + '', ''			
		ELSE
		BEGIN
			DELETE CRMT00003 WHERE DivisionID = @DelDivisionID AND RelatedToID = @DelAPK AND RelatedToTypeID = 1 ---Xoa thong tin tab lich su
			DELETE HRMT1000 WHERE DivisionID = @DelDivisionID AND ResourceID = @DelResourceID
		END
		FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelResourceID, @DelIsCommon
	END 
	IF @Params1 <> '''' SET @Params1 = LEFT(@Params1, LEN(@Params1)- 1)
	IF @Params2 <> '''' SET @Params2 = LEFT(@Params2, LEN(@Params2)- 1)
	SELECT * FROM
	(
	SELECT 2 AS Status,''00ML000050'' AS MessageID, @Params1 AS Params             
	UNION ALL 
	SELECT 2 AS Status,''HRMFML000001'' AS MessageID, @Params2 AS Params
	)A WHERE A.Params <> '''' '
END

IF @Mode = 0 
BEGIN
	SET @sSQL = '
	DECLARE @Params NVARCHAR(MAX),
			@MessageID VARCHAR(50)
	SET @Params = ''''

	IF ('''+@DivisionID+''' <> (SELECT TOP 1 DivisionID FROM HRMT1000 WITH (NOLOCK) WHERE ResourceID = '''+@ResourceList+''')
		AND (SELECT ISNULL(IsCommon,0) FROM HRMT1000 WITH (NOLOCK) WHERE ResourceID = '''+@ResourceList+''') <> 1
	   ) -- kiểm tra khác Division va không dùng chung
		BEGIN
			SET @Params = (SELECT TOP 1 ResourceID FROM HRMT1000 WITH (NOLOCK) WHERE ResourceID = '''+@ResourceList+''')
			SET @MessageID = ''00ML000050''
		END
	IF EXISTS (SELECT TOP 1 1 FROM HRMT1031 WITH (NOLOCK) WHERE ResourceID = '''+@ResourceList+''')  -- kiểm tra đã được sử dụng	
		BEGIN
			SET @Params = (SELECT TOP 1 ResourceID FROM HRMT1000 WITH (NOLOCK) WHERE ResourceID = '''+@ResourceList+''')
			SET @MessageID = ''HRMFML000001''
		END	 
	IF @Params <> '''' SET @Params = LEFT(@Params, LEN(@Params)- 1)
	SELECT 2 AS Status, @MessageID AS MessageID, @Params AS Params
	WHERE @Params <> '''' '
	
      
END


--PRINT(@sSQL)
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
