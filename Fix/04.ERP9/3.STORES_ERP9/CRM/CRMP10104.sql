IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP10104]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP10104]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load dữ liệu Khách hàng cho màn hình Xem chi tiết - CRMF1012
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created by Vĩnh Tâm ON Date 31/12/2020: Chuyển câu SQL SQL001_KIMYEN từ file CRMF1012DAL.cs sang Store
---- Modified by Minh Hiếu  on 14/02/2022: Bổ sung thuộc tính Tel1,Tel2
-- <Example> 
/*
	EXEC CRMP10104 @APK = N'16b20c97-a12a-4624-8f7a-cec5498f2ad8', @DivisionID = 'DTI', @CodeMaster = 'AT00000004', @UserID = 'ASOFTADMIN'
*/

CREATE PROCEDURE CRMP10104 ( 
		@APK VARCHAR(50), 
		@DivisionID VARCHAR(50), 
		@CodeMaster VARCHAR(50), 
		@UserID VARCHAR(50)
) 
AS 

SELECT M.APK
	, M.DivisionID
	, M.MemberID AccountID
	, M.MemberName AccountName
	, M.Address
	, M.Tel
	, M.Tel1
	, M.Tel2
	, M.Fax
	, M.Email
	, M.Website
	, M.BankName
	, M.BankAccountNo
	, M.EmployeeID
	, M.PaCreditLimit
	, M.ReDueDays
	, M.PaDueDays
	, M.PaDiscountDays
	, M.PaDiscountPercent
	, M.RePaymentTermID
	, M.PaPaymentTermID
	, M.ReDays
	, M.O01ID
	, M.O02ID
	, M.O03ID
	, M.O04ID
	, M.O05ID
	, M.DeliveryAddress
	, M.DeliveryWard
	, M.DeliveryDistrictID
	, M.DeliveryCityID
	, M.DeliveryPostalCode
	, M.DeliveryCountryID
	, M.BillAddress
	, M.BillWard
	, M.BillDistrictID
	, M.BillCityID
	, M.BillPostalCode
	, M.BillCountryID
	, M.Description
	, M.Note
	, M.Note1
	, M.VATNo
	, M.ReCreditLimit
	, M.VATAccountID, M.MemberName AS VATAccountName
	, M.IsCustomer, A997.Description AS IsCustomerName
	, M.IsOrganize, A992.Description AS IsOrganizeName
	, M.IsInvoice, A994.Description AS IsInvoiceName
	, A993.Description AS IsUsing
	, A991.Description AS IsCommon
	, A995.Description AS Disabled
	, M.CreateDate
	, M.CreateUserID + ' _ ' + A13.FullName AS CreateUserID
	, M.LastModifyDate
	, M.LastModifyUserID + ' _ ' + A14.FullName AS LastModifyUserID
	, M.ConvertType
	, CRM99.Description AS ConvertTypeName
	, M.InheritConvertID, M.CauseConverted, M.DescriptionConvert, M.ConvertUserID
	, M.RelatedToTypeID
	, A103.FullName AS AssignedToUserName
	, C1.BusinessLinesName AS BusinessLinesID
FROM POST0011 M WITH (NOLOCK)
	LEFT JOIN AT0099 A991 WITH (NOLOCK) ON CONVERT(VARCHAR, M.IsCommon) = A991.ID AND A991.CodeMaster = @CodeMaster
	LEFT JOIN AT0099 A992 WITH (NOLOCK) ON CONVERT(VARCHAR, M.IsOrganize) = A992.ID AND A992.CodeMaster = @CodeMaster
	LEFT JOIN AT0099 A993 WITH (NOLOCK) ON CONVERT(VARCHAR, M.IsUsing) = A993.ID AND A993.CodeMaster = @CodeMaster
	LEFT JOIN AT0099 A994 WITH (NOLOCK) ON CONVERT(VARCHAR, M.IsInvoice) = A994.ID AND A994.CodeMaster = @CodeMaster
	LEFT JOIN AT0099 A995 WITH (NOLOCK) ON CONVERT(VARCHAR, M.Disabled) = A995.ID AND A995.CodeMaster = @CodeMaster
	LEFT JOIN AT0099 A997 WITH (NOLOCK) ON CONVERT(VARCHAR, M.IsCustomer) = A997.ID AND A997.CodeMaster = @CodeMaster
	LEFT JOIN AT1103 A103 WITH (NOLOCK) ON A103.EmployeeID = M.AssignedToUserID
	LEFT JOIN AT1103 A13 WITH (NOLOCK) ON A13.EmployeeID = M.CreateUserID
	LEFT JOIN AT1103 A14 WITH (NOLOCK) ON A14.EmployeeID = M.LastModifyUserID
	LEFT JOIN CRMT10701 C1 WITH (NOLOCK) ON C1.BusinessLinesID = M.BusinessLinesID
	LEFT JOIN CRMT0099 CRM99 WITH (NOLOCK) ON M.ConvertType = CRM99.ID AND CRM99.CodeMaster = 'CRMT00000004'
WHERE M.APK = @APK


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
