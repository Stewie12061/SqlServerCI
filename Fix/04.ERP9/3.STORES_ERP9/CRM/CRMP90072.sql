IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP90072]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP90072]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
-- Kiểm tra trước khi xóa nhiệm vụ hay sự kiện trên calendar
-- Nếu nhiệm vụ hay sự kiện chưa được sử dụng thì cho phép xóa (Xóa ngầm) ngược lại thì báo message ID đã sử dụng không được phép xóa
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Phan thanh hoàng vũ, Date: 05/04/2017
-- Edited by: Truong Lam, Date: 11/07/2019
-- Edited by Thu Hà, Date 12/10/2023: Bổ sung kiểm tra xóa Lịch phỏng vấn 
-- <Example> EXEC CRMP90072 'AS', '3', 9, 'CRMT90051', NULL

CREATE PROCEDURE CRMP90072 ( 
	@DivisionID varchar(50), --Biến môi trường
	@IDList NVARCHAR(MAX),	 --Trường hợp xóa
	@RelatedToTypeID int ,	 --1: sự kiện; 2: nhiệm vụ; 5: Lịch phỏng vấn 
	@TableID nvarchar(50),	 --CRMT90041: Nhiệm vụ; CRMT90051: Sự kiện; HRMT2030: Lịch phỏng vấn
	@UserID Varchar(50)	,	 --Biến môi trường
	@APKList NVARCHAR(MAX)	 --Biến Apk
	) 
AS 
BEGIN
	DECLARE @sSQL NVARCHAR(MAX)
IF @RelatedToTypeID = 1 --Kiểm tra xóa sự kiện
		SET @sSQL = 'DECLARE @Status TINYINT,
							@Message NVARCHAR(1000),
							@Cur CURSOR,
							@DelDivisionID VARCHAR(50),
							@DelAPKEventID VARCHAR(50),
							@DelEventID INT,
							@DelEventSubject NVARCHAR(250),
							@DelEventStatus INT
					Declare @CRMT90051temp table (
							Status tinyint,
							MessageID varchar(100),
							Params nvarchar(4000))
					SET @Status = 0
					SET @Message = ''''
						
					Insert into @CRMT90051temp (Status, MessageID, Params) 
					Select 2 as Status, ''00ML000050'' as MessageID, Null as Params
					union all 
					Select 2 as Status, ''CRMFML000014'' as MessageID, Null as Params

													
					SET @Cur = CURSOR SCROLL KEYSET FOR
					SELECT APK , DivisionID, EventID, EventSubject, EventStatus FROM CRMT90051 WITH (NOLOCK) WHERE EventID IN ('''+@IDList+''')
					OPEN @Cur
					FETCH NEXT FROM @Cur INTO @DelAPKEventID, @DelDivisionID, @DelEventID, @DelEventSubject, @DelEventStatus
					WHILE @@FETCH_STATUS = 0
					BEGIN
						IF @DelDivisionID != '''+@DivisionID+'''
								update @CRMT90051temp set Params = ISNULL(Params,'''') + @DelEventSubject+'','' where MessageID = ''00ML000050''
						IF @DelEventStatus  = 2
								update @CRMT90051temp set Params = ISNULL(Params,'''') + @DelEventSubject+'','' where MessageID = ''CRMFML000014''
						ELSE 
							Begin
								DELETE FROM CRMT90051 WHERE APK = @DelAPKEventID								
							End
						FETCH NEXT FROM @Cur INTO @DelAPKEventID, @DelDivisionID, @DelEventID, @DelEventSubject, @DelEventStatus
					END
					CLOSE @Cur
					SELECT Status, MessageID, LEFT(Params,LEN(Params) - 1) AS Params From  @CRMT90051temp where Params is not null'
	
	IF @RelatedToTypeID = 3 --Kiểm tra xóa công việc
		SET @sSQL = 'DECLARE @Status TINYINT,
							@Message NVARCHAR(1000),
							@Cur CURSOR,
							@DelDivisionID VARCHAR(50),
							@DelAPKWorkID VARCHAR(50),
							@DelWorkID INT,
							@DelWorkSubject NVARCHAR(250),
							@DelWorkStatus INT
					Declare @OOT2110temp table (
							Status tinyint,
							MessageID varchar(100),
							Params nvarchar(4000))
					SET @Status = 0
					SET @Message = ''''
						
					Insert into @OOT2110temp (Status, MessageID, Params) 
					Select 2 as Status, ''00ML000050'' as MessageID, Null as Params
					union all 
					Select 2 as Status, ''CRMFML000015'' as MessageID, Null as Params
													
					SET @Cur = CURSOR SCROLL KEYSET FOR
					SELECT APK , DivisionID, NULL as WorkID, TaskName as WorkSubject, NULL as WorkStatus FROM OOT2110 WITH (NOLOCK) WHERE APK IN ('''+@APKList+''')
					OPEN @Cur
					FETCH NEXT FROM @Cur INTO @DelAPKWorkID, @DelDivisionID, @DelWorkID, @DelWorkSubject, @DelWorkStatus
					WHILE @@FETCH_STATUS = 0
					BEGIN
						IF @DelDivisionID != '''+@DivisionID+'''
								update @OOT2110temp set Params = ISNULL(Params,'''') + @DelWorkSubject+'','' where MessageID = ''00ML000050''
						IF @DelWorkStatus  = 3
								update @OOT2110temp set Params = ISNULL(Params,'''') + @DelWorkSubject+'','' where MessageID = ''CRMFML000015''
						ELSE 
							Begin
								DELETE FROM OOT2110 WHERE APK = @DelAPKWorkID								
							End
						FETCH NEXT FROM @Cur INTO @DelAPKWorkID, @DelDivisionID, @DelWorkID, @DelWorkSubject, @DelWorkStatus
					END
					CLOSE @Cur
					SELECT Status, MessageID, LEFT(Params,LEN(Params) - 1) AS Params From  @OOT2110temp where Params is not null'

	IF @RelatedToTypeID = 4 --Kiểm tra xóa Đặt lịch
		SET @sSQL = 'DECLARE @Status TINYINT,
							@Message NVARCHAR(1000),
							@Cur CURSOR,
							@DelDivisionID VARCHAR(50),
							@DelAPKWorkID VARCHAR(50),
							@DelWorkID INT,
							@DelWorkSubject NVARCHAR(250),
							@DelWorkStatus INT
					Declare @OOT2240temp table (
							Status tinyint,
							MessageID varchar(100),
							Params nvarchar(4000))
					SET @Status = 0
					SET @Message = ''''
						
					Insert into @OOT2240temp (Status, MessageID, Params) 
					Select 2 as Status, ''00ML000050'' as MessageID, Null as Params
					union all 
					Select 2 as Status, ''CRMFML000015'' as MessageID, Null as Params
													
					SET @Cur = CURSOR SCROLL KEYSET FOR
					SELECT APK , DivisionID, NULL as WorkID, BookingName as WorkSubject, NULL as WorkStatus FROM OOT2240 WITH (NOLOCK) WHERE APK IN ('''+@APKList+''')
					OPEN @Cur
					FETCH NEXT FROM @Cur INTO @DelAPKWorkID, @DelDivisionID, @DelWorkID, @DelWorkSubject, @DelWorkStatus
					WHILE @@FETCH_STATUS = 0
					BEGIN
						IF @DelDivisionID != '''+@DivisionID+'''
								update @OOT2240temp set Params = ISNULL(Params,'''') + @DelWorkSubject+'','' where MessageID = ''00ML000050''
						IF @DelWorkStatus  = 3
								update @OOT2240temp set Params = ISNULL(Params,'''') + @DelWorkSubject+'','' where MessageID = ''CRMFML000015''
						ELSE 
							Begin
								DELETE FROM OOT2240 WHERE APK = @DelAPKWorkID								
							End
						FETCH NEXT FROM @Cur INTO @DelAPKWorkID, @DelDivisionID, @DelWorkID, @DelWorkSubject, @DelWorkStatus
					END
					CLOSE @Cur
					SELECT Status, MessageID, LEFT(Params,LEN(Params) - 1) AS Params From  @OOT2240temp where Params is not null'
	
	IF @RelatedToTypeID = 5 --Kiểm tra xóa Lịch phỏng vấn 
		SET @sSQL = 'DECLARE @Status TINYINT,
							@Message NVARCHAR(1000),
							@Cur CURSOR,
							@DelDivisionID VARCHAR(50),
							@DelAPKWorkID VARCHAR(50),
							@DelWorkID INT,
							@DelWorkSubject NVARCHAR(250),
							@DelWorkStatus INT
					Declare @HRMT2030temp table (
							Status tinyint,
							MessageID varchar(100),
							Params nvarchar(4000))
					SET @Status = 0
					SET @Message = ''''
						
					Insert into @HRMT2030temp (Status, MessageID, Params) 
					Select 2 as Status, ''00ML000050'' as MessageID, Null as Params
					union all 
					Select 2 as Status, ''CRMFML000015'' as MessageID, Null as Params
													
					SET @Cur = CURSOR SCROLL KEYSET FOR
					SELECT APK , DivisionID, NULL as WorkID, Description as WorkSubject, NULL as WorkStatus FROM HRMT2030 WITH (NOLOCK) WHERE APK IN ('''+@APKList+''')
					OPEN @Cur
					FETCH NEXT FROM @Cur INTO @DelAPKWorkID, @DelDivisionID, @DelWorkID, @DelWorkSubject, @DelWorkStatus
					WHILE @@FETCH_STATUS = 0
					BEGIN
						IF @DelDivisionID != '''+@DivisionID+'''
								update @HRMT2030temp set Params = ISNULL(Params,'''') + @DelWorkSubject+'','' where MessageID = ''00ML000050''
						IF @DelWorkStatus  = 3
								update @HRMT2030temp set Params = ISNULL(Params,'''') + @DelWorkSubject+'','' where MessageID = ''CRMFML000015''
						ELSE 
							Begin
								DELETE FROM HRMT2030 WHERE APK = @DelAPKWorkID								
							End
						FETCH NEXT FROM @Cur INTO @DelAPKWorkID, @DelDivisionID, @DelWorkID, @DelWorkSubject, @DelWorkStatus
					END
					CLOSE @Cur
					SELECT Status, MessageID, LEFT(Params,LEN(Params) - 1) AS Params From  @HRMT2030temp where Params is not null'

	EXEC (@sSQL)
	PRINT (@sSQL)
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
