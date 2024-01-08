IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2116]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[OOP2116]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




















-- <Summary>
---- Insert đính kèm, ghi chú và checklist cho công việc khi kế thừa mẫu công việc
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
-- Create on 12/11/2019 by Đình Ly
-- <Example> Exec OOP2116 @DivisionID='DTI', @APK_2110 = '0A44E172-A058-444A-85A5-B8F20C845FEB', @TaskSampleID = 'MCVDA.DTI.00003'

CREATE PROCEDURE [dbo].[OOP2116]
(
	@DivisionID VARCHAR(50),
	@APK_2110 VARCHAR(50),
	@TaskSampleID VARCHAR(50)
)
AS
BEGIN 
	DECLARE @Key_AttachID VARCHAR(50),
			@Key_APK_Notes VARCHAR(50),
			@Key_Notes INT,
			@Key_CheckList VARCHAR(50),
			@Key_RelatedID INT,
			@APKNotes UNIQUEIDENTIFIER

	-- Update đính kèm của Mẫu công việc cho công việc mới
	-- Lấy ra danh sách AttachID của Mẫu công việc
	SELECT C1.AttachID, O1.APK, C1.RelatedToTypeID_REL
	INTO #tbl_Loop_Attach
	FROM OOT1060 O1 WITH (NOLOCK)
		INNER JOIN CRMT00002_REL C1 WITH (NOLOCK) ON CAST(O1.APK AS VARCHAR(50)) = C1.RelatedToID
	WHERE O1.TaskSampleID = @TaskSampleID

	-- Insert đính kèm tương ứng AttachID vừa lấy ra
	INSERT CRMT00002_REL(DivisionID, AttachID, RelatedToID, RelatedToTypeID_REL)
	SELECT @DivisionID, AttachID, @APK_2110, RelatedToTypeID_REL
	FROM #tbl_Loop_Attach

	-- Update ghi chú của Mẫu công việc cho công việc mới
	-- Lấy ra danh sách NotesID của Mẫu công việc
	SELECT C2.*, C1.RelatedToTypeID_REL
	INTO #tbl_Loop_Notes
	FROM OOT1060 O1 WITH (NOLOCK)
		INNER JOIN CRMT90031_REL C1 WITH (NOLOCK) ON CAST(O1.APK AS VARCHAR(50)) = C1.RelatedToID
		INNER JOIN CRMT90031 C2 WITH (NOLOCK) ON C2.NotesID = C1.NotesID
	WHERE O1.TaskSampleID = @TaskSampleID

	-- Chạy vòng lặp cho đến hết #tbl_Loop
	WHILE EXISTS(SELECT TOP 1 1 FROM #tbl_Loop_Notes)
	BEGIN
		-- Lấy NotesID trong #tbl_Loop_Notes làm điều kiện xóa dần bảng tạm
		SELECT TOP 1 @Key_APK_Notes = APK, @Key_RelatedID = RelatedToTypeID_REL
		FROM #tbl_Loop_Notes
		SET @APKNotes = NEWID()

		-- Insert data lấy từ bảng tạm vào bảng CRMT90031
		-- Không insert NotesID vì là cột tự tăng
		INSERT CRMT90031(APK, DivisionID, NotesSubject, Description, CreateUserID, CreateDate, LastModifyDate, LastModifyUserID, DeleteFlg)
		SELECT TOP 1 @APKNotes, DivisionID, NotesSubject, Description, CreateUserID, CreateDate, LastModifyDate, LastModifyUserID, DeleteFlg
		FROM #tbl_Loop_Notes

		-- Lấy giá trị cột NotesID vừa mới insert vào bảng CRMT90031
		-- Để làm giá trị insert vào cột NotesID bảng CRMT90031_REL
		SELECT TOP 1 @Key_Notes = NotesID FROM CRMT90031 WITH (NOLOCK) WHERE APK = @APKNotes

		-- Insert ghi chú tương ứng NotesID vừa lấy ra
		INSERT CRMT90031_REL(DivisionID, NotesID, RelatedToTypeID_REL, RelatedToID)
		VALUES(@DivisionID, @Key_Notes, @Key_RelatedID, @APK_2110)

		-- Xóa dần NotesID của bảng chạy trong vòng lặp
		DELETE FROM #tbl_Loop_Notes WHERE APK = @Key_APK_Notes
	END

	-- Update checklist của Mẫu công việc cho công việc mới
	-- Lấy ra danh sách NotesID của Mẫu công việc
	SELECT O2.*
	INTO #tbl_Loop_CheckList
	FROM OOT1060 O1 WITH (NOLOCK)
		INNER JOIN OOT2111 O2 WITH (NOLOCK) ON CAST(O1.APK AS VARCHAR(50)) = O2.APKMaster
	WHERE O1.TaskSampleID = @TaskSampleID

	-- Insert dữ liệu checklist của mẫu công việc vào công việc mới
	INSERT OOT2111 (APKMaster, ChecklistName, Description, IsComplete, IsConfirm, DeleteFlag, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, DeleteFlg)
	SELECT @APK_2110, ChecklistName, Description, IsComplete, IsConfirm, DeleteFlag, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, DeleteFlg
	FROM #tbl_Loop_CheckList
END




















GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
