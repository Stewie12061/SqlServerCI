IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[OOP2053_OLD]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[OOP2053_OLD]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Xét duyệt đơn 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Quốc Tuấn, Date: 09/12/2015
/*-- <Example>
exec OOP2053_OLD @APKMaster='5A3CE2DD-D286-4F5E-BF5F-058EDB714DB6',
@TranMonth=2,@TranYear=2016,@Type=N'DXRN',@APK='2E728BDC-E154-4CF5-ADF3-44A890E07910',@DivisionID=N'MK',@UserID=N'000004'
----*/


CREATE PROCEDURE OOP2053_OLD
( 
  @DivisionID VARCHAR(50),
  @UserID VARCHAR(50),
  @TranMonth INT,
  @TranYear INT,
  @APKMaster VARCHAR(50),
  @APK VARCHAR(50), ---- APK cua bang OOT9001
  @Type VARCHAR(50)
) 
AS 
DECLARE @ApprovingLevel TINYINT,
		@Status TINYINT,
		@Cur CURSOR,
		@APKAT9001 VARCHAR(50),
		@ApprovePresonID VARCHAR(50),
		@Level TINYINT
--tăng tốc độ
SET NOCOUNT ON;

SELECT @ApprovingLevel=LEVEL, @Status=STATUS,
	   @ApprovePresonID=ApprovePersonID
FROM OOT9001
WHERE DivisionID=@DivisionID
AND APK=@APK

--cập nhật đệ quy
SET @Cur = CURSOR SCROLL KEYSET FOR
		   SELECT APK,[Level]
		   FROM OOT9001
		   WHERE DivisionID=@DivisionID
		   AND APKMaster=@APKMaster
		   AND ApprovePersonID=@ApprovePresonID
		   AND ( ([Level]> @ApprovingLevel AND @Status = 1) 
				OR ([Level]< @ApprovingLevel AND @Status = 2)  )
		   ORDER BY Level
OPEN @Cur
FETCH NEXT FROM @Cur INTO @APKAT9001,@Level
WHILE @@FETCH_STATUS = 0
BEGIN
	IF (@Level <> @ApprovingLevel+1 AND @Status = 1) OR (@Level <> @ApprovingLevel-1 AND @Status = 2)
	BEGIN
		BREAK
	END
	UPDATE OOT9001 SET @ApprovingLevel=CASE WHEN @Status = 1 THEN [Level] ELSE @ApprovingLevel END,
	[Status]=@Status
	WHERE APK=@APKAT9001
	AND DivisionID=@DivisionID

	UPDATE OOT9000 SET ApprovingLevel = @ApprovingLevel
	WHERE APK=@APKMaster
	AND DivisionID =@DivisionID
	AND @Status = 1

	FETCH NEXT FROM @Cur INTO @APKAT9001,@Level
END
CLOSE @Cur

--- Cập nhật tình trạng nếu là người duyệt cuối cùng 
IF EXISTS (SELECT TOP 1 1 FROM OOT9000 WHERE AppoveLevel=@ApprovingLevel AND APK =@APKMaster)
BEGIN	

	UPDATE OOT9000 SET [Status] = @Status
	WHERE APK=@APKMaster
	AND DivisionID =@DivisionID

	IF EXISTS (SELECT TOP 1 1 FROM OOT9000 WITH (NOLOCK) WHERE APK=@APKMaster AND DivisionID =@DivisionID AND Status = @Status)
	UPDATE OOT2010 
	SET Status = @Status
	WHERE APKMaster = @APKMaster AND DivisionID =@DivisionID

	-- cập nhật xuống HRM nếu duyệt thnash coong
	IF @Status=1 
		EXEC OOP2054_OLD @DivisionID,@UserID,@TranMonth,@TranYear,@APKMaster,@Type,1
	ELSE IF @Status=2 -- xóa những dòng đã import xuống HRM nếu người duyệt cuối cùng bỏ duyệt
		EXEC OOP2054_OLD @DivisionID,@UserID,@TranMonth,@TranYear,@APKMaster,@Type,0
END
ELSE IF @Status =2
BEGIN
	--Cập nhật bảng Master OOT9000
	UPDATE OOT9000 SET [Status] = @Status 
	WHERE APK=@APKMaster
	AND DivisionID =@DivisionID
	--Kiem tra la phieu ra ngoai thi tru chuyen can
	IF @Type ='DXRN'
	BEGIN
		EXEC OOP2059 @DivisionID,@UserID,@TranMonth,@TranYear,@APKMaster,@Status
	END
END
ELSE IF @Status =1
	UPDATE OOT9000 SET [Status] = 0 WHERE APK=@APKMaster
		
--tăng tốc độ
SET NOCOUNT OFF


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

