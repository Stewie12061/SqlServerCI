IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HZ1402]') AND OBJECTPROPERTY(ID, N'IsTrigger') = 1)
DROP TRIGGER [DBO].[HZ1402]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
----- Thêm vào HT1402_CT khi update thông tin hồ sơ nhân viên
----- Created by Bảo Thy, Date 16/03/2016


CREATE TRIGGER HZ1402 ON HT1402 
FOR UPDATE
AS

IF EXISTS (SELECT TOP 1 1 FROM INSERTED)
BEGIN
	IF EXISTS (SELECT TOP 1 1 FROM DELETED)
	insert into [HT1402_CT]([Operation],	
	[APK],
	[DivisionID],
	[EmployeeID],
	[BankID],
	[BankAccountNo],
	[SoInsuranceNo],
	[SoInsurBeginDate],
	[HeInsuranceNo],
	[ArmyJoinDate],
	[ArmyEndDate],
	[ArmyLevel],
	[Hobby],
	[HospitalID],
	[Height],
	[Weight],
	[BloodGroup],
	[PersonalTaxID],
	[HFromDate],
	[HToDate],
	[CreateDate],
	[CreateUserID],
	[LastModifyDate],
	[LastModifyUserID],
	[ReAPK]) SELECT 4 as [Operation],	
	[APK],
	[DivisionID],
	[EmployeeID],
	[BankID],
	[BankAccountNo],
	[SoInsuranceNo],
	[SoInsurBeginDate],
	[HeInsuranceNo],
	[ArmyJoinDate],
	[ArmyEndDate],
	[ArmyLevel],
	[Hobby],
	[HospitalID],
	[Height],
	[Weight],
	[BloodGroup],
	[PersonalTaxID],
	[HFromDate],
	[HToDate],
	[CreateDate],
	[CreateUserID],
	GETDATE(),
	[LastModifyUserID],
	[ReAPK]  FROM INSERTED
	
insert into [HT1402_CT]([Operation],	
	[APK],
	[DivisionID],
	[EmployeeID],
	[BankID],
	[BankAccountNo],
	[SoInsuranceNo],
	[SoInsurBeginDate],
	[HeInsuranceNo],
	[ArmyJoinDate],
	[ArmyEndDate],
	[ArmyLevel],
	[Hobby],
	[HospitalID],
	[Height],
	[Weight],
	[BloodGroup],
	[PersonalTaxID],
	[HFromDate],
	[HToDate],
	[CreateDate],
	[CreateUserID],
	[LastModifyDate],
	[LastModifyUserID],
	[ReAPK]) SELECT 3 as [Operation],	
	[APK],
	[DivisionID],
	[EmployeeID],
	[BankID],
	[BankAccountNo],
	[SoInsuranceNo],
	[SoInsurBeginDate],
	[HeInsuranceNo],
	[ArmyJoinDate],
	[ArmyEndDate],
	[ArmyLevel],
	[Hobby],
	[HospitalID],
	[Height],
	[Weight],
	[BloodGroup],
	[PersonalTaxID],
	[HFromDate],
	[HToDate],
	[CreateDate],
	[CreateUserID],
	GETDATE(),
	[LastModifyUserID],
	[ReAPK]  FROM DELETED
 END    
 
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
