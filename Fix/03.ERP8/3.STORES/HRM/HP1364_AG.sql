IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP1364_AG]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP1364_AG]
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
---- Modified by Tiểu Mai on 30/12/2016: Bổ sung các trường HV01.BankID, HT08.BankName, HV01.BankAccountNo
---- Modified by Tiểu Mai on 05/06/2018: Fix không lấy đúng CContractNo, CSignDate
/***************************************************************
'* Edited by : [GS] [Quoc Cuong] [30/07/2010]
'**************************************************************/
CREATE PROCEDURE [dbo].[HP1364_AG] 	@DivisionID nvarchar(50),
						@ContractID nvarchar(50),
						@Man nvarchar(20),
						@Woman nvarchar(20)		 				

 AS 

DECLARE @sSQL as nvarchar(4000)

SET @sSQL = 'SELECT HT13.*, HV01.FullName, HV01.PermanentAddress, HV01.TemporaryAddress, AT01.CountryName as CountryName,
			HV01.FullAddress, HV01.EducationLevelName, HV01.NativeCountry as ANativeCountry, HV01.PassportDate as APassportDate, HV01.PassportNo as APassportNo,
			HV01.IdentifyCardNo as AIdentityCardNo, HV01.IdentifyDate as AIdentifyDate, HV01.IdentifyPlace as AIdentityPlace, HV01.Birthday As ABirthday, HV01.BornPlace As ABornPlace,
			CASE HV01.IsMale when 1 THEN N'''+@Man+''' ELSE N'''+@Woman+''' END AS IsMale,  
			CASE HV02.IsMale when 1 THEN N'''+@Man+''' ELSE N'''+@Woman+''' END AS SPIsMale,  
			HV01.DistrictID, HT03.DutyName, 
			HV02.FullName as SPName, AT02.CountryName as SPCountryName, HT04.DutyName as SPDutyName, HT05.ContractTypeName ,HT06.TitleName,HT06.TitleNameE,
			HV02.BornPlace, HV02.PassportDate, HV02.PassportNo, HV02.IdentifyCardNo, HV02.IdentifyDate, HV02.IdentifyPlace, HV02.NativeCountry,HV02.Birthday,
			AT1102.DepartmentName,
			HV01.C01, HV01.C02, HV01.C03, HV01.C04, HV01.C05, HV01.C06, HV01.C07,
			HV01.C08, HV01.C09, HV01.C10, HV01.C11, HV01.C12, HV01.C13, HV01.C15,
			HV01.C16, HV01.C17, HV01.C14, HV01.C18, HV01.C19, HV01.C20, HV01.C21,
			HV01.C22, HV01.C23, HV01.C24, HV01.C25, HV01.ImageID, 
			HT36.ContractNo AS CContractNo, HT36.SignDate AS CSignDate,
			HV01.BankID, HT08.BankName, HV01.BankAccountNo, HV01.Notes as HV01Notes
		FROM HT1360	HT13		
			inner join HV1400 HV01 on HT13.EmployeeID = HV01.EmployeeID and HT13.DivisionID = HV01.DivisionID
			inner join AT1001 AT01 on HV01.CountryID = AT01.CountryID and AT01.DivisionID in (''@@@'',HV01.DivisionID)
			left join HT1102 HT03 on HT13.DutyID = HT03.DutyID and HT13.DivisionID = HT03.DivisionID 
  			left join HV1400 HV02 on HV02.EmployeeID = HT13.SignPersonID and HV02.DivisionID = HT13.DivisionID
			inner join AT1001 AT02 on HV02.CountryID = AT02.CountryID and AT02.DivisionID in (''@@@'',HV02.DivisionID)
			left join HT1102 HT04 on HV02.DutyID = HT04.DutyID and	HV02.DivisionID = HT04.DivisionID	
			left join HT1105 HT05 on HT05.ContractTypeID = HT13.ContractTypeID and HT05.DivisionID = HT13.DivisionID
			left join HT1106 HT06 on HT06.TitleID = HT13.TitleID  and HT06.DivisionID = HT13.DivisionID
			left join AT1102 on AT1102.DivisionID = HT13.DivisionID and AT1102.DepartmentID = HT13.DepartmentID
			LEFT JOIN HT1360 HT36 ON HT36.DivisionID = HT13.DivisionID AND HT13.CContractID = HT36.ContractID AND HT36.EmployeeID = HT13.EmployeeID
			LEFT JOIN HT1008 HT08 ON HT08.DivisionID = HV01.DivisionID AND HT08.BankID = HV01.BankID
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
