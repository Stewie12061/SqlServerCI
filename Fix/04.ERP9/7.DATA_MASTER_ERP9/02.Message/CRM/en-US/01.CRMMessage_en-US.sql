DECLARE @ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10),
@MessageValue NVARCHAR(400),
------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
@Finished BIT
------------------------------------------------------------------------------------------------------
-- Set value và Execute query
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN 
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP
- Tieng Trung: zh-CN
*/
SET @Language = 'en-US'
SET @ModuleID = 'CRM'

SET @MessageValue=N'[Start time] cannot be greater than [End time]!' 
EXEC ERP9AddMessage @ModuleID,'CRMFML000019', @MessageValue, @Language; 

-- [Ngày thêm: 04/11/2020] [Người tạo: Đình Hòa]
SET @MessageValue=N'Place Date date must not be less than Start Date and cannot be greater than End Date!'
EXEC ERP9AddMessage @ModuleID,'CRMFML000029', @MessageValue, @Language;

-- [Ngày thêm: 26/01/2021] [Người tạo: Đình Hòa]
SET @MessageValue=N'Leads {0} has phone number {1} or email {2} already in the system. Do you want to continue?'
EXEC ERP9AddMessage @ModuleID,'CRMFML000032', @MessageValue, @Language;

SET @MessageValue=N'You have just been assigned a high priority support request: {0}'
EXEC ERP9AddMessage @ModuleID,'CRMFML000061', @MessageValue, @Language;

SET @MessageValue=N'You have just been assigned a low priority support request: {0}'
EXEC ERP9AddMessage @ModuleID,'CRMFML000062', @MessageValue, @Language;

SET @MessageValue=N'Your {0} support request has just been transferred to {1}'
EXEC ERP9AddMessage @ModuleID,'CRMFML000063', @MessageValue, @Language;

SET @MessageValue=N'Your support request {0} has been changed to High priority support request'
EXEC ERP9AddMessage @ModuleID,'CRMFML000064', @MessageValue, @Language;

SET @MessageValue=N'Your support request {0} has been moved to status {1}'
EXEC ERP9AddMessage @ModuleID,'CRMFML000065', @MessageValue, @Language;

