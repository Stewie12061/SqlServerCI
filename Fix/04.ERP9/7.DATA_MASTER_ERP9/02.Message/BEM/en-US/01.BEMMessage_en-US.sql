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
SET @ModuleID = 'BEM'

SET @MessageValue=N'Duplicate CostAnalysisID and DepartmentAnalysisID. Please check again.'
EXEC ERP9AddMessage @ModuleID,'BEMFML000000', @MessageValue, @Language;
SET @MessageValue=N'You must choose Object before data filter!'
EXEC ERP9AddMessage @ModuleID,'BEMFML000001', @MessageValue, @Language;
SET @MessageValue=N'Request amount cannot exceed the remaining amount!'
EXEC ERP9AddMessage @ModuleID,'BEMFML000002', @MessageValue, @Language;
SET @MessageValue=N'Invalid business duration, please check again!'
EXEC ERP9AddMessage @ModuleID,'BEMFML000003', @MessageValue, @Language;
SET @MessageValue=N'You must select a list with only PDN or no PDN in the list'
EXEC ERP9AddMessage @ModuleID,'BEMFML000004', @MessageValue, @Language;
SET @MessageValue=N'You have not entered Reason, please check again!'
EXEC ERP9AddMessage @ModuleID,'BEMFML000005', @MessageValue, @Language;
SET @MessageValue=N'The number of business days is invalid, please check again!'
EXEC ERP9AddMessage @ModuleID,'BEMFML000006', @MessageValue, @Language;
SET @MessageValue=N'You have not entered Business fee per day, please check again!'
EXEC ERP9AddMessage @ModuleID,'BEMFML000007', @MessageValue, @Language;
SET @MessageValue=N'Please chosse type Proposal!'
EXEC ERP9AddMessage @ModuleID,'BEMFML000008', @MessageValue, @Language;
SET @MessageValue=N'Changing the Advance object will delete all data on the grid. Do you want to continue?'
EXEC ERP9AddMessage @ModuleID,'BEMFML000009', @MessageValue, @Language;
SET @MessageValue=N'The Inherited only VoucherNos same object'
EXEC ERP9AddMessage @ModuleID,'BEMFML000010', @MessageValue, @Language;
SET @MessageValue=N'Please import full fromdate and todate'
EXEC ERP9AddMessage @ModuleID,'BEMFML000011', @MessageValue, @Language;
SET @MessageValue=N'Please choose the records to have the same currency!'
EXEC ERP9AddMessage @ModuleID,'BEMFML000012', @MessageValue, @Language;
SET @MessageValue=N'Save failed, proposal business work is in use!'
EXEC ERP9AddMessage @ModuleID,'BEMFML000013', @MessageValue, @Language;
SET @MessageValue=N'The inherited datas of {0} have approved, you cannot change the status!'
EXEC ERP9AddMessage @ModuleID,'BEMFML000014', @MessageValue, @Language;
SET @MessageValue=N'{0} is refused to approve. Please check the detail!'
EXEC ERP9AddMessage @ModuleID,'BEMFML000015', @MessageValue, @Language;
SET @MessageValue=N'The request amount is greater than the remaining amount of the voucher!'
EXEC ERP9AddMessage @ModuleID,'BEMFML000016', @MessageValue, @Language;
SET @MessageValue=N'{0} is automatically generated, you are not allowed to delete / edit!'
EXEC ERP9AddMessage @ModuleID,'BEMFML000017', @MessageValue, @Language;
SET @MessageValue=N'Please choose the Proposal type!'
EXEC ERP9AddMessage @ModuleID,'BEMFML000018', @MessageValue, @Language;
SET @MessageValue=N'The detail data is not valid, please check again!'
EXEC ERP9AddMessage @ModuleID,'BEMFML000019', @MessageValue, @Language;