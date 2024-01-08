IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP1364]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP1364]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-----Created by: Vo Thanh Huong
-----Created date: 02/07/2004
-----purpose: In hop dong lao dong
-----Edit by: Le Hoai Minh
-----Edit by: Dang Le Bao Quynh; Date: 03/01/2007
-----Purpose: Bo sung them truong quoc tich vao view de in bao cao
---- Modify on 27/05/2014 by Bảo Anh: Bổ sung DepartmentName
---- Modified on 14/04/2015 by Lê Thị Hạnh: Bổ sung load CContractNo hợp đồng lao động
---- Modified on 23/11/2016 by Bảo Thy: Bổ sung lưu C26->C100 (MEIKO)
---- Modified on 25/09/2017 by Hải Long: Bổ sung trường lương BHXH (InsuranceSalary)
---- Modified by Tiểu Mai	on 05/06/2018: Fix không lấy đúng CContractNo, CSignDate
---- Modified by Văn Tài	on 17/08/2022: Xử lý lấy sai thông tin phòng ban.
/***************************************************************
'* Edited by : [GS] [Quoc Cuong] [30/07/2010]
'**************************************************************/
CREATE PROCEDURE [dbo].[HP1364] 	@DivisionID nvarchar(50),
						@ContractID nvarchar(50),
						@Man nvarchar(20),
						@Woman nvarchar(20)		 				

 AS 

DECLARE @sSQL as nvarchar(4000),
		@CustomerIndex INT

SELECT @CustomerIndex = CustomerName From CustomerIndex

SET @sSQL = 'SELECT HT13.*, HV01.FullName, HV01.PermanentAddress, HV01.TemporaryAddress, AT01.CountryName as CountryName,
				HV01.FullAddress, HV01.EducationLevelName, HV01.NativeCountry as ANativeCountry, HV01.PassportDate as APassportDate, HV01.PassportNo as APassportNo,
				HV01.IdentifyCardNo as AIdentityCardNo, HV01.IdentifyDate as AIdentifyDate, HV01.IdentifyPlace as AIdentityPlace, HV01.Birthday As ABirthday, HV01.BornPlace As ABornPlace,
				CASE HV01.IsMale when 1 THEN N'''+@Man+''' ELSE N'''+@Woman+''' END AS IsMale,  
				CASE HV02.IsMale when 1 THEN N'''+@Man+''' ELSE N'''+@Woman+''' END AS SPIsMale,  
				HV01.DistrictID, HT03.DutyName, HV02.FullName as SPName, AT02.CountryName as SPCountryName, HT04.DutyName as SPDutyName, HT05.ContractTypeName ,
				HT06.TitleName,HT06.TitleNameE, HV02.BornPlace, HV02.PassportDate, HV02.PassportNo, HV02.IdentifyCardNo, HV02.IdentifyDate, HV02.IdentifyPlace, 
				HV02.NativeCountry,HV02.Birthday, AT1102.DepartmentName,
				HV01.C01, HV01.C02, HV01.C03, HV01.C04, HV01.C05, HV01.C06, HV01.C07,
				HV01.C08, HV01.C09, HV01.C10, HV01.C11, HV01.C12, HV01.C13, HV01.C15,
				HV01.C16, HV01.C17, HV01.C14, HV01.C18, HV01.C19, HV01.C20, HV01.C21,
				HV01.C22, HV01.C23, HV01.C24, HV01.C25, HT43.C26, HT43.C27, HT43.C28, 
				HT43.C29, HT43.C30, HT43.C31, HT43.C32, HT43.C33, HT43.C34, HT43.C35, 
				HT43.C36, HT43.C37, HT43.C38, HT43.C39, HT43.C40, HT43.C41, HT43.C42, 
				HT43.C43, HT43.C44, HT43.C45, HT43.C46, HT43.C47, HT43.C48, HT43.C49, 
				HT43.C50, HT43.C51, HT43.C52, HT43.C53, HT43.C54, HT43.C55, HT43.C56,
				HT43.C57, HT43.C58, HT43.C59, HT43.C60, HT43.C61, HT43.C62, HT43.C63, 
				HT43.C64, HT43.C65, HT43.C66, HT43.C67, HT43.C68, HT43.C69, HT43.C70, 
				HT43.C71, HT43.C72, HT43.C73, HT43.C74, HT43.C75, HT43.C76, HT43.C77, 
				HT43.C78, HT43.C79, HT43.C80, HT43.C81, HT43.C82, HT43.C83, HT43.C84, 
				HT43.C85, HT43.C86, HT43.C87, HT43.C88, HT43.C89, HT43.C90, HT43.C91, 
				HT43.C92, HT43.C93, HT43.C94, HT43.C95, HT43.C96, HT43.C97, HT43.C98, HT43.C99, HT43.C100,
				HT43.C101, HT43.C102, HT43.C103, HT43.C104, HT43.C105, HT43.C106, HT43.C107, HT43.C108, 
				HT43.C109, HT43.C110, HT43.C111, HT43.C112, HT43.C113, HT43.C114, HT43.C115, HT43.C116, HT43.C117, HT43.C118, HT43.C119, HT43.C120, 
				HT43.C121, HT43.C122, HT43.C123, HT43.C124, HT43.C125, HT43.C126, HT43.C127, HT43.C128, HT43.C129, HT43.C130, HT43.C131, HT43.C132, 
				HT43.C133, HT43.C134, HT43.C135, HT43.C136, HT43.C137, HT43.C138, HT43.C139, HT43.C140, HT43.C141, HT43.C142, HT43.C143, HT43.C144, 
				HT43.C145, HT43.C146, HT43.C147, HT43.C148, HT43.C149, HT43.C150, HV01.ImageID, 
				HT36.ContractNo AS CContractNo, HT36.SignDate AS CSignDate, HV01.InsuranceSalary
			FROM HT1360	HT13		
				inner join HV1400 HV01 on HT13.EmployeeID = HV01.EmployeeID and HT13.DivisionID = HV01.DivisionID
				left join HT1403_1 HT43 on HT13.EmployeeID = HT43.EmployeeID and HT13.DivisionID = HT43.DivisionID
				left join AT1001 AT01 on HV01.CountryID = AT01.CountryID
				left join HT1102 HT03 on HT13.DutyID = HT03.DutyID and HT13.DivisionID = HT03.DivisionID 
	  			left join HV1400 HV02 on HV02.EmployeeID = HT13.SignPersonID and HV02.DivisionID = HT13.DivisionID
				left join AT1001 AT02 on HV02.CountryID = AT02.CountryID
				left join HT1102 HT04 on HV02.DutyID = HT04.DutyID and	HV02.DivisionID = HT04.DivisionID	
				left join HT1105 HT05 on HT05.ContractTypeID = HT13.ContractTypeID and HT05.DivisionID = HT13.DivisionID
				left join HT1106 HT06 on HT06.TitleID = HT13.TitleID  and HT06.DivisionID = HT13.DivisionID
				left join AT1102 on AT1102.DivisionID = HT13.DivisionID AND AT1102.DepartmentID = HT13.DepartmentID
				LEFT JOIN HT1360 HT36 ON HT36.DivisionID = HT13.DivisionID AND HT13.CContractID = HT36.ContractID AND HT36.EmployeeID = HT13.EmployeeID
			WHERE HT13.DivisionID =''' +  @DivisionID +''' and HT13.ContractID =''' +  @ContractID +''''
--print @sSQL
IF not exists (SELECT name FROM sysObjects WHERE id = Object_ID(N'[dbo].[HV1360]') and OBJECTPROPERTY(id, N'IsView') = 1)
	EXEC ('Create View HV1360 -- tao boi HP1364
			  as '  +  @sSQL)
ELSE
	EXEC('Alter View HV1360 -- tao boi HP1364
		as ' + @sSQL )
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
