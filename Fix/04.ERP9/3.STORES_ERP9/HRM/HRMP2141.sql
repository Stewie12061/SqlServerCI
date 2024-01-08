IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2141]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2141]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Cập nhật trạng thái duyệt kế hoạch tuyển dụng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Kim Thư, Date: 16/08/2018
----Modified by Như Hàn on 19/09/2018:Sửa store duyệt kế hoạch tuyển dụng

-- <Example>
---- 
/*-- <Example>
	EXEC HRMP2141 @DivisionID='VF',@UserID='ASOFTADMIN',@APK='63CF0AA3-8C77-4C42-8D71-6255E9790374',@APKList='', @StatusID=2, @Notes=NULL

	EXEC HRMP2141 @DivisionID,@UserID,@APK,@APKList, @StatusID, @Notes
----*/

CREATE PROCEDURE HRMP2141
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @APK VARCHAR(50),
	 @APKList VARCHAR(MAX),
	 @StatusID TINYINT,
	 @Notes VARCHAR (200)
)
AS 

DECLARE @Approver VARCHAR(50),
		@MessageID VARCHAR(50),
		@Param VARCHAR(50),
		@StatusError TINYINT,
		@StatusColumn VARCHAR(10),
		@SQL NVARCHAR(MAX) = N'',
		@TranMonth INT,
		@TranYear INT

CREATE TABLE #HRMP2141 (
	DivisionID VARCHAR(50),
	APK VARCHAR(50),
	Status TINYINT,
	AfEmployeeID VARCHAR(50),
	BeEmployeeID VARCHAR(50),
	StatusColumn VARCHAR(10)
)

-- TRƯỜNG HỢP DUYỆT 1 PHIẾU
IF ISNULL(@APK,'')<>''
BEGIN
	INSERT INTO #HRMP2141
	SELECT DivisionID, APK, Status, 
	CASE WHEN ISNULL(Status1,'')='' THEN ISNULL(Approver1,'') ELSE
		CASE WHEN ISNULL(Status1,'')<>'' AND ISNULL(Status2,'')='' THEN ISNULL(Approver2,'') ELSE
		CASE WHEN ISNULL(Status2,'')<>'' AND ISNULL(Status3,'')='' THEN ISNULL(Approver3,'') ELSE
		CASE WHEN ISNULL(Status3,'')<>'' AND ISNULL(Status4,'')='' THEN ISNULL(Approver4,'') ELSE
		CASE WHEN ISNULL(Status4,'')<>'' AND ISNULL(Status5,'')='' THEN ISNULL(Approver5,'') ELSE
		CASE WHEN ISNULL(Status5,'')<>'' THEN ''
	END END END END END END AS AfEmployeeID,

	CASE WHEN ISNULL(Status1,'')='' THEN '' ELSE
		CASE WHEN ISNULL(Status1,'')<>'' AND ISNULL(Status2,'')='' THEN ISNULL(Approver1,'') ELSE
		CASE WHEN ISNULL(Status2,'')<>'' AND ISNULL(Status3,'')='' THEN ISNULL(Approver2,'') ELSE
		CASE WHEN ISNULL(Status3,'')<>'' AND ISNULL(Status4,'')='' THEN ISNULL(Approver3,'') ELSE
		CASE WHEN ISNULL(Status4,'')<>'' AND ISNULL(Status5,'')='' THEN ISNULL(Approver4,'') ELSE
		CASE WHEN ISNULL(Status5,'')<>'' THEN ISNULL(Approver5,'')
	END END END END END END AS BeEmployeeID,

	CASE WHEN ISNULL(Status1,'')='' THEN 'Status1' ELSE
		CASE WHEN ISNULL(Status1,'')<>'' AND ISNULL(Status2,'')='' THEN 'Status2' ELSE
		CASE WHEN ISNULL(Status2,'')<>'' AND ISNULL(Status3,'')='' THEN 'Status3' ELSE
		CASE WHEN ISNULL(Status3,'')<>'' AND ISNULL(Status4,'')='' THEN 'Status4' ELSE
		CASE WHEN ISNULL(Status4,'')<>'' AND ISNULL(Status5,'')='' THEN 'Status5' ELSE
		CASE WHEN ISNULL(Status5,'')<>'' THEN ''
	END END END END END END AS StatusColumn

	FROM HRMT2000
	WHERE APK = @APK

	SET @Approver=(SELECT TOP 1 AfEmployeeID FROM #HRMP2141)
	SET @StatusColumn=(SELECT TOP 1 StatusColumn FROM #HRMP2141)
	SET @TranMonth = (SELECT TranMonth From HRMT2000 WHERE APK = ISNULL(@APK,0))
	SET @TranYear = (SELECT TranYear From HRMT2000 WHERE APK = ISNULL(@APK,0))

	-- NẾU NGƯỜI DUYỆT KHÔNG ĐÚNG
	IF @UserID<>@Approver
	BEGIN
		SET @MessageID='OOFML000069'
		SET @Param=NULL
		SET @StatusError=1
		GOTO EndMess
	END
	ELSE
	BEGIN
	--CẬP NHẬT TRẠNG THÁI CÁC STATUS1->STATUS5
		DECLARE @Level TINYINT, @StatusCol VARCHAR(10), @SQL1 NVARCHAR(MAX)
		SET @Level=(SELECT Level FROM OOT0010 WHERE DivisionID=@DivisionID AND AbsentType='KHTD' AND TranMonth = @TranMonth AND TranYear = @TranYear)
		SET @StatusCol='Status'+ltrim(@Level)

		--UPDATE HRMT2000
		--SET @StatusColumn=@StatusID, Notes=@Notes
		--WHERE APK=@APK

		Set @SQL1 = N'
		UPDATE HRMT2000
		SET '+@StatusColumn+'='+LTRim(@StatusID)+', Notes= '''+@Notes+'''
		WHERE APK='''+@APK+''''

		SET @SQL1= @SQL1 + N' 
		Declare @STT TINYINT
		SELECT @STT = '+@StatusColumn+' FROM HRMT2000 WHERE APK='''+@APK+'''

		IF @STT = 2
			BEGIN
				UPDATE T1
				SET T1.Status= 2
				FROM HRMT2000 T1
				WHERE APK='''+@APK+'''

			END
		ELSE 
			BEGIN
				UPDATE T1
				SET T1.Status= ISNULL(T1.'+@StatusCol+',0)
				FROM HRMT2000 T1
				WHERE APK='''+@APK+'''
			END
		'
		
		--Print @SQL1
		EXEC (@SQL1)
	
	-- CẬP NHẬT Message
		SET @MessageID='00ML000015'
		SET @Param=NULL
		SET @StatusError=0
		GOTO EndMess
	END

END
ELSE -- TRƯỜNG HỢP DUYỆT NHIỀU PHIẾU
BEGIN
	SET @SQL=@SQL+'
	INSERT INTO #HRMP2141 (DivisionID, APK, Status, AfEmployeeID, BeEmployeeID, StatusColumn)
	SELECT DivisionID, APK, Status, 
	CASE WHEN ISNULL(Status1,'''')='''' THEN ISNULL(Approver1,'''') ELSE
		CASE WHEN ISNULL(Status1,'''')<>'''' AND ISNULL(Status2,'''')='''' THEN ISNULL(Approver2,'''') ELSE
		CASE WHEN ISNULL(Status2,'''')<>'''' AND ISNULL(Status3,'''')='''' THEN ISNULL(Approver3,'''') ELSE
		CASE WHEN ISNULL(Status3,'''')<>'''' AND ISNULL(Status4,'''')='''' THEN ISNULL(Approver4,'''') ELSE
		CASE WHEN ISNULL(Status4,'''')<>'''' AND ISNULL(Status5,'''')='''' THEN ISNULL(Approver5,'''') ELSE
		CASE WHEN ISNULL(Status5,'''')<>'''' THEN ''''
	END END END END END END AS AfEmployeeID,
	
	CASE WHEN ISNULL(Status1,'''')='''' THEN '''' ELSE
		CASE WHEN ISNULL(Status1,'''')<>'''' AND ISNULL(Status2,'''')='''' THEN ISNULL(Approver1,'''') ELSE
		CASE WHEN ISNULL(Status2,'''')<>'''' AND ISNULL(Status3,'''')='''' THEN ISNULL(Approver2,'''') ELSE
		CASE WHEN ISNULL(Status3,'''')<>'''' AND ISNULL(Status4,'''')='''' THEN ISNULL(Approver3,'''') ELSE
		CASE WHEN ISNULL(Status4,'''')<>'''' AND ISNULL(Status5,'''')='''' THEN ISNULL(Approver4,'''') ELSE
		CASE WHEN ISNULL(Status5,'''')<>'''' THEN ISNULL(Approver5,'''')
	END END END END END END AS BeEmployeeID,

	CASE WHEN ISNULL(Status1,'''')='''' THEN ''Status1'' ELSE
		CASE WHEN ISNULL(Status1,'''')<>'''' AND ISNULL(Status2,'''')='''' THEN ''Status2'' ELSE
		CASE WHEN ISNULL(Status2,'''')<>'''' AND ISNULL(Status3,'''')='''' THEN ''Status3'' ELSE
		CASE WHEN ISNULL(Status3,'''')<>'''' AND ISNULL(Status4,'''')='''' THEN ''Status4'' ELSE
		CASE WHEN ISNULL(Status4,'''')<>'''' AND ISNULL(Status5,'''')='''' THEN ''Status5'' ELSE
		CASE WHEN ISNULL(Status5,'''')<>'''' THEN ''''
	END END END END END END AS StatusColumn
	FROM HRMT2000
	WHERE APK in ('''+@APKList+''')
	'
	EXEC (@SQL)

	DECLARE @Leveln TINYINT, @StatusColn VARCHAR(10), @SQL2 NVARCHAR(MAX) = N'',  @STT TINYINT

	SET @SQL2 = @SQL2 +N'DECLARE @STT TINYINT'

	IF EXISTS (	SELECT TOP 1 1 FROM #HRMP2141 WHERE AfEmployeeID<>@UserID )
	BEGIN
		SET @MessageID='OOFML000069'
		SET @Param=NULL
		SET @StatusError=1
		GOTO EndMess
	END
	ELSE
	BEGIN
		DECLARE @cur cursor, @curStatusColumn VARCHAR(10), @curAPK VARCHAR(50)
		SET @cur = CURSOR SCROLL KEYSET FOR SELECT StatusColumn, APK FROM #HRMP2141
		OPEN @cur
		FETCH NEXT FROM @cur INTO @curStatusColumn, @curAPK

		WHILE @@FETCH_STATUS = 0
			BEGIN
				SET @TranMonth = (SELECT TranMonth From HRMT2000 WHERE APK = ISNULL(@curAPK,0))
				SET @TranYear = (SELECT TranYear From HRMT2000 WHERE APK = ISNULL(@curAPK,0))

				DECLARE @SQL1n NVARCHAR(MAX) = N''
				SET @SQL1n = N'
				UPDATE HRMT2000
				SET '+LTRIM(@curStatusColumn)+'= '+LTRIM(@StatusID)+', Notes= '''+@Notes+'''
				WHERE APK='''+@curAPK+''''
				EXEC (@SQL1n)
				--PRINT @SQL1n 
				
				SET @Leveln=(SELECT Level FROM OOT0010 WHERE DivisionID=@DivisionID AND AbsentType='KHTD' AND TranMonth = @TranMonth AND TranYear = @TranYear)
				SET @StatusColn='Status'+LTRIM(@Leveln)
				
				SET @SQL2= @SQL2+ N'
				SET @STT = 0
				SELECT @STT = '+@curStatusColumn+' FROM HRMT2000 WHERE APK='''+@curAPK+'''
				
				IF @STT = 2
					BEGIN
						UPDATE T1
						SET T1.Status= 2
						FROM HRMT2000 T1
						WHERE APK='''+@curAPK+'''

					END
				ELSE 
					BEGIN
						UPDATE T1
						SET T1.Status= ISNULL(T1.'+LTRIM(@StatusColn)+',0)
						FROM HRMT2000 T1
						WHERE APK='''+@curAPK+'''
					END
					'

		
					prINT @SQL2
				--UPDATE T1
				--SET T1.Status= ISNULL(T1.'+@StatusColn+',0)
				--FROM HRMT2000 T1
				--WHERE APK='''+@curAPK+''''
				EXEC (@SQL2)
				--prINT @SQL2

			FETCH NEXT FROM @cur INTO @curStatusColumn, @curAPK
  			END
		CLOSE @cur
		DEALLOCATE @cur


		
		SET @MessageID='00ML000015'
		SET @Param=NULL
		SET @StatusError=0
		GOTO EndMess
	END
END
EndMess:
SELECT @MessageID AS MessageID, @Param AS Param, @StatusError AS StatusError


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
