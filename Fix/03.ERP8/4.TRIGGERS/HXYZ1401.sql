IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HXYZ1401]') AND OBJECTPROPERTY(ID, N'IsTrigger') = 1)
DROP TRIGGER [DBO].[HXYZ1401]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Cap nhat vào bảng HT1401_CT trường hợp update, delete và insert hồ sơ nhân viên
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 16/03/2016 by Bảo Thy
---- 
-- <Example>
----

CREATE TRIGGER HXYZ1401 ON [dbo].[HT1401]  FOR UPDATE,DELETE,INSERT
AS

--SELECT @TableName = 'HT1401_CT'
 ----2: insert;1 delete;4 update

IF EXISTS (SELECT * FROM inserted)
       IF EXISTS (SELECT top 1 1 FROM deleted)
               --SELECT @Type = 'U'
               insert into [HT1401_CT]
               ([Operation],
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
		 SELECT 4 as [Operation],
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
				[ReAPK]  FROM deleted
       ELSE
               --SELECT @Type = 'I'
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
		 SELECT 2 AS [Operation],
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
				[ReAPK]  FROM inserted
ELSE
       --SELECT @Type = 'D'
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
		SELECT 1 AS [Operation],
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
				[ReAPK] FROM deleted

-- get list of columns
--SELECT *INTO #ins FROM inserted
--SELECT * INTO #del FROM deleted




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
