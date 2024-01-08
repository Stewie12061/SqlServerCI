IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HZ1411]') AND OBJECTPROPERTY(ID, N'IsTrigger') = 1)
DROP TRIGGER [DBO].[HZ1411]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


--Created by Tiểu Mai.
--Purpose: UPDATE lại trạng thái duyệt của đợt tuyển dụng đv chức vụ thiết lập duyệt 1 lần (ANGEL).



CREATE TRIGGER [dbo].[HZ1411] ON [dbo].[HT1411]
FOR UPDATE 
AS

DECLARE 
@H11_Cursor CURSOR,
@DivisionID NVARCHAR(50),
@RecruitTimeID NVARCHAR(50),
@RecruitDetail NVARCHAR(50),
@DutyID NVARCHAR(50),
@IsApproveRecruit TINYINT,
@IsConfirm01 TINYINT,
@IsConfirm02 TINYINT,
@ConfDescription01 NVARCHAR(250),
@ConfDescription02 NVARCHAR(250),
@StatusRecruit TINYINT,
@ConfirmUserID NVARCHAR(50),
@ConfirmDate DATETIME

DECLARE @CustomerName INT
--Tao bang tam de kiem tra day co phai la khach hang ANGEL khong (CustomerName = 57)
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

IF @CustomerName = 57 ------ ANGEL
BEGIN
	SET @H11_Cursor = CURSOR SCROLL KEYSET FOR
		SELECT Inserted.DivisionID, Deleted.RecruitTimeID, Deleted.RecruitDetail, DELETED.DutyID, HT1102.IsApproveRecruit,
		INSERTED.IsConfirm01, INSERTED.IsConfirm02, INSERTED.ConfDescription01, INSERTED.ConfDescription02,
		DELETED.ConfirmUserID, DELETED.ConfirmDate
		FROM Deleted  
		INNER JOIN Inserted ON Inserted.RecruitDetail = Deleted.ReCruitDetail AND Inserted.RecruitTimeID = Deleted.ReCruitTimeID and Inserted.DivisionID = Deleted.DivisionID 
		LEFT JOIN HT1102 ON HT1102.DivisionID = Deleted.DivisionID AND HT1102.DutyID = Deleted.DutyID
	OPEN @H11_Cursor
	FETCH NEXT FROM @H11_Cursor INTO @DivisionID, @RecruitTimeID, @RecruitDetail, @DutyID, @IsApproveRecruit,
									@IsConfirm01, @IsConfirm02, @ConfDescription01, @ConfDescription02, @ConfirmUserID, @ConfirmDate


	WHILE @@FETCH_STATUS = 0
	BEGIN

			IF @IsApproveRecruit = 1 AND @IsConfirm01 = 1
				UPDATE HT1411
				SET
					StatusRecruit = 1
				FROM HT1411	
				WHERE DivisionID = @DivisionID AND RecruitTimeID = @RecruitTimeID AND RecruitDetail = @RecruitDetail	
			IF @IsApproveRecruit = 1 AND @IsConfirm01 = 0
				UPDATE HT1411
				SET
					StatusRecruit = 0
				FROM HT1411	
				WHERE DivisionID = @DivisionID AND RecruitTimeID = @RecruitTimeID AND RecruitDetail = @RecruitDetail	


		FETCH NEXT FROM @H11_Cursor INTO @DivisionID, @RecruitTimeID, @RecruitDetail, @DutyID, @IsApproveRecruit,
									@IsConfirm01, @IsConfirm02, @ConfDescription01, @ConfDescription02, @ConfirmUserID, @ConfirmDate

	END
	Close @H11_Cursor

END
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
