IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HY1400]') AND OBJECTPROPERTY(ID, N'IsTrigger') = 1)
DROP TRIGGER [DBO].[HY1400]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Trigger insert HT1400
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
------- Created by Bảo Thy, Date 16/03/2016 : Thêm vào HT1400_CT khi thêm thông tin hồ sơ nhân viên
------- Modified by Bảo Thy,  Date 21/09/2016: Thêm vào HT1407 khi import thông tin hồ sơ nhân viên
------- Modified by Kiều Nga,  Date 18/08/2023: Bổ sung check tồn tại khi insert HT1407


CREATE TRIGGER HY1400 ON HT1400 
FOR INSERT
AS

IF (SELECT CustomerName FROM CustomerIndex) = 50  ---Customize MEIKO
BEGIN
	IF EXISTS (SELECT TOP 1 1 FROM INSERTED)
		INSERT INTO [HT1400_CT](Operation, [APK]
	      ,[DivisionID]
	      ,[EmployeeID]
	      ,[Orders]
	      ,[DepartmentID]
	      ,[TeamID]
	      ,[LastName]
	      ,[MiddleName]
	      ,[FirstName]
	      ,[ShortName]
	      ,[Alias]
	      ,[Birthday]
	      ,[BornPlace]
	      ,[IsMale]
	      ,[NativeCountry]
	      ,[PermanentAddress]
	      ,[TemporaryAddress]
	      ,[PassportNo]
	      ,[PassportDate]
	      ,[PassportEnd]
	      ,[IdentifyCardNo]
	      ,[IdentifyDate]
	      ,[IdentifyPlace]
	      ,[IsSingle]
	      --,[ImageID]
	      ,[CountryID]
	      ,[CityID]
	      ,[DistrictID]
	      ,[EthnicID]
	      ,[ReligionID]
	      ,[Notes]
	      ,[HealthStatus]
	      ,[HomePhone]
	      ,[HomeFax]
	      ,[MobiPhone]
	      ,[Email]
	      ,[CreateDate]
	      ,[CreateUserID]
	      ,[LastModifyDate]
	      ,[LastModifyUserID]
	      ,[S1]
	      ,[S2]
	      ,[S3]
	      ,[EmployeeStatus]
	      ,[IsForeigner]
	      ,[RecruitTimeID]
	      ,[IdentifyCityID]
	      ,[NoResident]
	      ,[DrivingLicenceNo]
	      ,[DrivingLicenceDate]
	      ,[DrivingLicenceEnd]
	      ,[DrivingLicencePlace]
	      ,[IdentifyEnd]
	      ,[Ana01ID]
	      ,[Ana02ID]
	      ,[Ana03ID]
	      ,[Ana04ID]
	      ,[Ana05ID]
	      ,[Ana06ID]
	      ,[Ana07ID]
	      ,[Ana08ID]
	      ,[Ana09ID]
	      ,[Ana10ID]
	      ,[IsAutoCreateUser],ReAPK) SELECT 2, [APK]
	      ,[DivisionID]
	      ,[EmployeeID]
	      ,[Orders]
	      ,[DepartmentID]
	      ,[TeamID]
	      ,[LastName]
	      ,[MiddleName]
	      ,[FirstName]
	      ,[ShortName]
	      ,[Alias]
	      ,[Birthday]
	      ,[BornPlace]
	      ,[IsMale]
	      ,[NativeCountry]
	      ,[PermanentAddress]
	      ,[TemporaryAddress]
	      ,[PassportNo]
	      ,[PassportDate]
	      ,[PassportEnd]
	      ,[IdentifyCardNo]
	      ,[IdentifyDate]
	      ,[IdentifyPlace]
	      ,[IsSingle]
	      --,[ImageID]
	      ,[CountryID]
	      ,[CityID]
	      ,[DistrictID]
	      ,[EthnicID]
	      ,[ReligionID]
	      ,[Notes]
	      ,[HealthStatus]
	      ,[HomePhone]
	      ,[HomeFax]
	      ,[MobiPhone]
	      ,[Email]
	      ,[CreateDate]
	      ,[CreateUserID]
	      ,[LastModifyDate]
	      ,[LastModifyUserID]
	      ,[S1]
	      ,[S2]
	      ,[S3]
	      ,[EmployeeStatus]
	      ,[IsForeigner]
	      ,[RecruitTimeID]
	      ,[IdentifyCityID]
	      ,[NoResident]
	      ,[DrivingLicenceNo]
	      ,[DrivingLicenceDate]
	      ,[DrivingLicenceEnd]
	      ,[DrivingLicencePlace]
	      ,[IdentifyEnd]
	      ,[Ana01ID]
	      ,[Ana02ID]
	      ,[Ana03ID]
	      ,[Ana04ID]
	      ,[Ana05ID]
	      ,[Ana06ID]
	      ,[Ana07ID]
	      ,[Ana08ID]
	      ,[Ana09ID]
	      ,[Ana10ID]
	      ,[IsAutoCreateUser], ReAPK  FROM INSERTED
	   
	 IF EXISTS (SELECT TOP 1 1 FROM INSERTED)
	 INSERT INTO [HT1407]
	 (	  
	 	   [APK]
	      ,[DivisionID]
	      ,[AbsentCardID]
	      ,[AbsentCardNo]
	      ,[EmployeeID]
	      ,[BeginDate]
	      ,[EndDate]
	      ,[CreateDate]
	      ,[CreateUserID]
	      ,[LastModifyDate]
	      ,[LastModifyUserID]
	      ,[IsCurrent]
	 )
	 SELECT NEWID()
	      ,[DivisionID]
	      ,NEWID()
	      ,[EmployeeID]
	      ,[EmployeeID]
	      ,Convert(DATE,GETDATE())
	      ,DATEADD(YYYY,100,Convert(DATE,GETDATE()))
	      ,[CreateDate]
	      ,[CreateUserID]
	      ,[LastModifyDate]
	      ,[LastModifyUserID]
	      ,0
	  FROM INSERTED 
	  WHERE NOT EXISTS (SELECT TOP 1 1 FROM HT1407 WITH (NOLOCK) WHERE AbsentCardNo = INSERTED.EmployeeID)
END
    
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
