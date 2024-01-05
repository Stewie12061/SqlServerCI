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
SET @ModuleID = 'KPI'

SET @MessageValue=N'To period must not be less than from period!'
EXEC ERP9AddMessage @ModuleID,'KPIFML000001', @MessageValue, @Language;
SET @MessageValue=N'Invalid data'
EXEC ERP9AddMessage @ModuleID,'KPIFML0000010', @MessageValue, @Language;
SET @MessageValue=N'Period is invalid'
EXEC ERP9AddMessage @ModuleID,'KPIFML0000011', @MessageValue, @Language;
SET @MessageValue=N'The operation cannot be performed when the period has been closed'
EXEC ERP9AddMessage @ModuleID,'KPIFML0000012', @MessageValue, @Language;
SET @MessageValue=N'The current period has not been paid'
EXEC ERP9AddMessage @ModuleID,'KPIFML0000013', @MessageValue, @Language;
SET @MessageValue=N' There was an error in the salary calculation process'
EXEC ERP9AddMessage @ModuleID,'KPIFML0000014', @MessageValue, @Language;
SET @MessageValue=N'The current period has been closed'
EXEC ERP9AddMessage @ModuleID,'KPIFML0000015', @MessageValue, @Language;
SET @MessageValue=N'The current period has been edited'
EXEC ERP9AddMessage @ModuleID,'KPIFML0000016', @MessageValue, @Language;
SET @MessageValue=N'The period from period to period has been created. Please set another time.'
EXEC ERP9AddMessage @ModuleID,'KPIFML000002', @MessageValue, @Language;
SET @MessageValue=N'Data cannot duplicate'
EXEC ERP9AddMessage @ModuleID,'KPIFML000003', @MessageValue, @Language;
SET @MessageValue=N'Do not enter negative values!'
EXEC ERP9AddMessage @ModuleID,'KPIFML000004', @MessageValue, @Language;
SET @MessageValue=N'The input value is in the range of 0 to 200'
EXEC ERP9AddMessage @ModuleID,'KPIFML000005', @MessageValue, @Language;
SET @MessageValue=N'Do you want to receive soft salary?'
EXEC ERP9AddMessage @ModuleID,'KPIFML000006', @MessageValue, @Language;
SET @MessageValue=N' You do not want to receive a soft salary?'
EXEC ERP9AddMessage @ModuleID,'KPIFML000007', @MessageValue, @Language;
SET @MessageValue=N'To period must not coincide From period!'
EXEC ERP9AddMessage @ModuleID,'KPIFML000008', @MessageValue, @Language;
SET @MessageValue=N' Do you want to edit?'
EXEC ERP9AddMessage @ModuleID,'KPIFML000009', @MessageValue, @Language;
SET @MessageValue=N'Detail datas are duplicate!'
EXEC ERP9AddMessage @ModuleID,'KPIFML000017', @MessageValue, @Language;
SET @MessageValue=N'Unlock successful period'
EXEC ERP9AddMessage @ModuleID,'KPIFML000018', @MessageValue, @Language;
SET @MessageValue=N'The department has been paid soft salary: '
EXEC ERP9AddMessage @ModuleID,'KPIFML000019', @MessageValue, @Language;
SET @MessageValue=N'You have just been assigned a KPI review by {0}'
EXEC ERP9AddMessage @ModuleID,'KPIFML000020', @MessageValue, @Language;
SET @MessageValue=N'You must perform the Kpis prior to the evaluation.'
EXEC ERP9AddMessage @ModuleID,'KPIFML000021', @MessageValue, @Language;