IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HX1401]') AND OBJECTPROPERTY(ID, N'IsTrigger') = 1)
DROP TRIGGER [DBO].[HX1401]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
----- Thêm vào HT1401_CT khi Xóa thông tin hồ sơ nhân viên
----- Created by Bảo Thy, Date 16/03/2016


CREATE TRIGGER HX1401 ON HT1401 
FOR DELETE
AS

       IF EXISTS (SELECT top 1 1 FROM deleted)
              insert into [HT1401_CT]([Operation],
				[APK],
				[DivisionID],
				[EmployeeID] ,
				[FatherName],
				[FatherYear],
				[FatherJob],
				[FatherAddress],
				[FatherNote],
				[IsFatherDeath],
				[MotherName],
				[MotherYear],
				[MotherJob],
				[MotherAddress],
				[MotherNote],
				[IsMotherDeath],
				[SpouseName],
				[SpouseYear],
				[SpouseAddress],
				[SpouseNote],
				[SpouseJob],
				[IsSpouseDeath],
				[EducationLevelID],
				[PoliticsID],
				[Language1ID],
				[Language2ID],
				[Language3ID],
				[LanguageLevel1ID],
				[LanguageLevel2ID],
				[LanguageLevel3ID],
				[CreateDate],
				[CreateUserID],
				[LastModifyDate],
				[LastModifyUserID],
				[ReAPK])
		SELECT 1 AS [Operation], --1: Delete
				[APK],
				[DivisionID],
				[EmployeeID] ,
				[FatherName],
				[FatherYear],
				[FatherJob],
				[FatherAddress],
				[FatherNote],
				[IsFatherDeath],
				[MotherName],
				[MotherYear],
				[MotherJob],
				[MotherAddress],
				[MotherNote],
				[IsMotherDeath],
				[SpouseName],
				[SpouseYear],
				[SpouseAddress],
				[SpouseNote],
				[SpouseJob],
				[IsSpouseDeath],
				[EducationLevelID],
				[PoliticsID],
				[Language1ID],
				[Language2ID],
				[Language3ID],
				[LanguageLevel1ID],
				[LanguageLevel2ID],
				[LanguageLevel3ID],
				[CreateDate],
				[CreateUserID],
				GETDATE(),
				[LastModifyUserID],
				[ReAPK] FROM deleted
     
      
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
