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
SET @ModuleID = 'OO'

SET @MessageValue=N'' 
EXEC ERP9AddMessage @ModuleID,'OOFML000001', @MessageValue, @Language; 
SET @MessageValue=N'' 
EXEC ERP9AddMessage @ModuleID,'OOFML000002', @MessageValue, @Language; 
SET @MessageValue=N'' 
EXEC ERP9AddMessage @ModuleID,'OOFML000003', @MessageValue, @Language; 
SET @MessageValue=N'' 
EXEC ERP9AddMessage @ModuleID,'OOFML000004', @MessageValue, @Language; 
SET @MessageValue=N'' 
EXEC ERP9AddMessage @ModuleID,'OOFML000005', @MessageValue, @Language; 
SET @MessageValue=N'' 
EXEC ERP9AddMessage @ModuleID,'OOFML000006', @MessageValue, @Language; 
SET @MessageValue=N'' 
EXEC ERP9AddMessage @ModuleID,'OOFML000007', @MessageValue, @Language; 
SET @MessageValue=N'' 
EXEC ERP9AddMessage @ModuleID,'OOFML000008', @MessageValue, @Language; 
SET @MessageValue=N'' 
EXEC ERP9AddMessage @ModuleID,'OOFML000009', @MessageValue, @Language; 
SET @MessageValue=N'' 
EXEC ERP9AddMessage @ModuleID,'OOFML000010', @MessageValue, @Language; 
SET @MessageValue=N'' 
EXEC ERP9AddMessage @ModuleID,'OOFML000011', @MessageValue, @Language; 
SET @MessageValue=N'' 
EXEC ERP9AddMessage @ModuleID,'OOFML000012', @MessageValue, @Language; 
SET @MessageValue=N'' 
EXEC ERP9AddMessage @ModuleID,'OOFML000013', @MessageValue, @Language; 
SET @MessageValue=N'' 
EXEC ERP9AddMessage @ModuleID,'OOFML000014', @MessageValue, @Language; 
SET @MessageValue=N'' 
EXEC ERP9AddMessage @ModuleID,'OOFML000015', @MessageValue, @Language; 
SET @MessageValue=N'' 
EXEC ERP9AddMessage @ModuleID,'OOFML000016', @MessageValue, @Language; 
SET @MessageValue=N'' 
EXEC ERP9AddMessage @ModuleID,'OOFML000017', @MessageValue, @Language; 
SET @MessageValue=N'' 
EXEC ERP9AddMessage @ModuleID,'OOFML000018', @MessageValue, @Language; 
SET @MessageValue=N'' 
EXEC ERP9AddMessage @ModuleID,'OOFML000019', @MessageValue, @Language; 
SET @MessageValue=N'' 
EXEC ERP9AddMessage @ModuleID,'OOFML000020', @MessageValue, @Language; 
SET @MessageValue=N'' 
EXEC ERP9AddMessage @ModuleID,'OOFML000021', @MessageValue, @Language; 
SET @MessageValue=N'' 
EXEC ERP9AddMessage @ModuleID,'OOFML000022', @MessageValue, @Language; 
SET @MessageValue=N'' 
EXEC ERP9AddMessage @ModuleID,'OOFML000023', @MessageValue, @Language; 
SET @MessageValue=N'' 
EXEC ERP9AddMessage @ModuleID,'OOFML000024', @MessageValue, @Language; 
SET @MessageValue=N'' 
EXEC ERP9AddMessage @ModuleID,'OOFML000025', @MessageValue, @Language; 
SET @MessageValue=N'' 
EXEC ERP9AddMessage @ModuleID,'OOFML000026', @MessageValue, @Language; 
SET @MessageValue=N'' 
EXEC ERP9AddMessage @ModuleID,'OOFML000027', @MessageValue, @Language; 
SET @MessageValue=N'' 
EXEC ERP9AddMessage @ModuleID,'OOFML000028', @MessageValue, @Language; 
SET @MessageValue=N'' 
EXEC ERP9AddMessage @ModuleID,'OOFML000029', @MessageValue, @Language; 
SET @MessageValue=N'' 
EXEC ERP9AddMessage @ModuleID,'OOFML000030', @MessageValue, @Language; 
SET @MessageValue=N'' 
EXEC ERP9AddMessage @ModuleID,'OOFML000031', @MessageValue, @Language; 
SET @MessageValue=N'' 
EXEC ERP9AddMessage @ModuleID,'OOFML000032', @MessageValue, @Language; 
SET @MessageValue=N'' 
EXEC ERP9AddMessage @ModuleID,'OOFML000033', @MessageValue, @Language; 
SET @MessageValue=N'' 
EXEC ERP9AddMessage @ModuleID,'OOFML000034', @MessageValue, @Language; 
SET @MessageValue=N'' 
EXEC ERP9AddMessage @ModuleID,'OOFML000035', @MessageValue, @Language; 
SET @MessageValue=N'' 
EXEC ERP9AddMessage @ModuleID,'OOFML000036', @MessageValue, @Language; 
SET @MessageValue=N'' 
EXEC ERP9AddMessage @ModuleID,'OOFML000038', @MessageValue, @Language; 
SET @MessageValue=N'' 
EXEC ERP9AddMessage @ModuleID,'OOFML000039', @MessageValue, @Language; 
SET @MessageValue=N'You haven''t chosen changed shift. Would you like to save?' 
EXEC ERP9AddMessage @ModuleID,'OOFML000048', @MessageValue, @Language; 
SET @MessageValue=N'Do not assign shift before {0} for employee {1}!' 
EXEC ERP9AddMessage @ModuleID,'OOFML000049', @MessageValue, @Language; 
SET @MessageValue=N'B?n ph?i ch?n quy d?nh di tr? v? s?m!' 
EXEC ERP9AddMessage @ModuleID,'OOFML000050', @MessageValue, @Language; 
SET @MessageValue=N'Create date has been out of {0} since absence date' 
EXEC ERP9AddMessage @ModuleID,'OOFML000051', @MessageValue, @Language; 
SET @MessageValue=N'This application has been {0}. You can not {0} again!' 
EXEC ERP9AddMessage @ModuleID,'OOFML000052', @MessageValue, @Language; 
SET @MessageValue=N'Do not assign shift after {0} for employee {1}!' 
EXEC ERP9AddMessage @ModuleID,'OOFML000053', @MessageValue, @Language; 
SET @MessageValue=N'Do not assign OT shift for employee being in prenant policy' 
EXEC ERP9AddMessage @ModuleID,'OOFML000054', @MessageValue, @Language; 
SET @MessageValue=N'You have been assigned work {0}' 
EXEC ERP9AddMessage @ModuleID,'OOFML000055', @MessageValue, @Language; 
SET @MessageValue=N'You have been following the work {0}' 
EXEC ERP9AddMessage @ModuleID,'OOFML000056', @MessageValue, @Language; 
SET @MessageValue=N'You just got support for the work {0}' 
EXEC ERP9AddMessage @ModuleID,'OOFML000057', @MessageValue, @Language; 
SET @MessageValue=N'You have been supervised the work {0}' 
EXEC ERP9AddMessage @ModuleID,'OOFML000058', @MessageValue, @Language; 
SET @MessageValue=N'You have been just join to the project {0}' 
EXEC ERP9AddMessage @ModuleID,'OOFML000059', @MessageValue, @Language; 
SET @MessageValue=N'You just have been followed the project {0}' 
EXEC ERP9AddMessage @ModuleID,'OOFML000060', @MessageValue, @Language; 
SET @MessageValue=N'The work {0} that you assigned to delete' 
EXEC ERP9AddMessage @ModuleID,'OOFML000061', @MessageValue, @Language; 
SET @MessageValue=N'The work {0} that you support to delete' 
EXEC ERP9AddMessage @ModuleID,'OOFML000062', @MessageValue, @Language; 
SET @MessageValue=N'The work {0} that you follow to delete' 
EXEC ERP9AddMessage @ModuleID,'OOFML000063', @MessageValue, @Language; 
SET @MessageValue=N'You must assign shift for employee {0} from {1} to {2}!' 
EXEC ERP9AddMessage @ModuleID,'OOFML000064', @MessageValue, @Language; 
SET @MessageValue=N'You must assign apprentice shift on {0} for {1}!' 
EXEC ERP9AddMessage @ModuleID,'OOFML000065', @MessageValue, @Language; 
SET @MessageValue=N'Do not make application form before {0} for employee {1}!' 
EXEC ERP9AddMessage @ModuleID,'OOFML000066', @MessageValue, @Language; 
SET @MessageValue=N'Do not make application form after {0} for {1}!' 
EXEC ERP9AddMessage @ModuleID,'OOFML000067', @MessageValue, @Language; 
SET @MessageValue=N'Employee {0} had not been assigned shift in this period.' 
EXEC ERP9AddMessage @ModuleID,'OOFML000068', @MessageValue, @Language; 
SET @MessageValue=N'Person approving is not correct!' 
EXEC ERP9AddMessage @ModuleID,'OOFML000069', @MessageValue, @Language; 
SET @MessageValue=N'There are data in period. You can not change level approve' 
EXEC ERP9AddMessage @ModuleID,'OOFML000070', @MessageValue, @Language; 
SET @MessageValue=N'Task sample must be part of a Step of Process!' 
EXEC ERP9AddMessage @ModuleID,'OOFML000092', @MessageValue, @Language; 
SET @MessageValue=N'This object has been used in the Process!' 
EXEC ERP9AddMessage @ModuleID,'OOFML000093', @MessageValue, @Language; 
SET @MessageValue=N'Child objects will also be deleted. Agree to delete?' 
EXEC ERP9AddMessage @ModuleID,'OOFML000094', @MessageValue, @Language; 
SET @MessageValue=N'Step of Process must be part of a Process!' 
EXEC ERP9AddMessage @ModuleID,'OOFML000095', @MessageValue, @Language; 
SET @MessageValue=N'Process must be part of a Project/Group Task or another Process!' 
EXEC ERP9AddMessage @ModuleID,'OOFML000096', @MessageValue, @Language; 
SET @MessageValue=N'To date is invalid!' 
EXEC ERP9AddMessage @ModuleID,'OOFML000097', @MessageValue, @Language; 
SET @MessageValue=N'End date is invalid!' 
EXEC ERP9AddMessage @ModuleID,'OOFML000098', @MessageValue, @Language; 
SET @MessageValue=N'Plan end date is invalid!' 
EXEC ERP9AddMessage @ModuleID,'OOFML000099', @MessageValue, @Language; 
SET @MessageValue=N'Actual end date is invalid!' 
EXEC ERP9AddMessage @ModuleID,'OOFML000100', @MessageValue, @Language; 
SET @MessageValue=N'ToDate is invalid!' 
EXEC ERP9AddMessage @ModuleID,'OOFML000101', @MessageValue, @Language; 
SET @MessageValue=N'Every...Days is invalid!' 
EXEC ERP9AddMessage @ModuleID,'OOFML000102', @MessageValue, @Language; 
SET @MessageValue=N'Day of week is invalid!' 
EXEC ERP9AddMessage @ModuleID,'OOFML000103', @MessageValue, @Language; 
SET @MessageValue=N'Data of Month is invalid!' 
EXEC ERP9AddMessage @ModuleID,'OOFML000104', @MessageValue, @Language; 
SET @MessageValue=N'Data of Year is invalid!' 
EXEC ERP9AddMessage @ModuleID,'OOFML000105', @MessageValue, @Language; 
SET @MessageValue=N'Start Time is invalid!' 
EXEC ERP9AddMessage @ModuleID,'OOFML000106', @MessageValue, @Language; 
SET @MessageValue=N'End Time is invalid!' 
EXEC ERP9AddMessage @ModuleID,'OOFML000107', @MessageValue, @Language; 
SET @MessageValue=N'Time is invalid!' 
EXEC ERP9AddMessage @ModuleID,'OOFML000108', @MessageValue, @Language; 
SET @MessageValue=N'Day is invalid!' 
EXEC ERP9AddMessage @ModuleID,'OOFML000109', @MessageValue, @Language; 
SET @MessageValue=N'Start Day is invalid!' 
EXEC ERP9AddMessage @ModuleID,'OOFML000110', @MessageValue, @Language; 
SET @MessageValue=N'Start day off is invalid!' 
EXEC ERP9AddMessage @ModuleID,'OOFML000111', @MessageValue, @Language; 
SET @MessageValue=N'End time is invalid!' 
EXEC ERP9AddMessage @ModuleID,'OOFML000112', @MessageValue, @Language; 
SET @MessageValue=N'Time work is invalid!' 
EXEC ERP9AddMessage @ModuleID,'OOFML000113', @MessageValue, @Language; 
SET @MessageValue=N'You must check at least 1 day!' 
EXEC ERP9AddMessage @ModuleID,'OOFML000114', @MessageValue, @Language; 
SET @MessageValue=N'Hours work is higher than 24!' 
EXEC ERP9AddMessage @ModuleID,'OOFML000115', @MessageValue, @Language; 
SET @MessageValue=N'You must input process!' 
EXEC ERP9AddMessage @ModuleID,'OOFML000116', @MessageValue, @Language; 
SET @MessageValue=N'You must input step!' 
EXEC ERP9AddMessage @ModuleID,'OOFML000117', @MessageValue, @Language; 
SET @MessageValue=N'You must input project job!' 
EXEC ERP9AddMessage @ModuleID,'OOFML000118', @MessageValue, @Language; 
SET @MessageValue=N'You must input recurrent job!' 
EXEC ERP9AddMessage @ModuleID,'OOFML000119', @MessageValue, @Language; 
SET @MessageValue=N'You must input arising job!' 
EXEC ERP9AddMessage @ModuleID,'OOFML000120', @MessageValue, @Language; 
SET @MessageValue=N'Time can''t negative value!' 
EXEC ERP9AddMessage @ModuleID,'OOFML000121', @MessageValue, @Language; 
SET @MessageValue=N'Remind day is invalid!' 
EXEC ERP9AddMessage @ModuleID,'OOFML000122', @MessageValue, @Language; 
SET @MessageValue=N'Email template is invalid!' 
EXEC ERP9AddMessage @ModuleID,'OOFML000123', @MessageValue, @Language; 
SET @MessageValue=N'SMS template is invalid!' 
EXEC ERP9AddMessage @ModuleID,'OOFML000124', @MessageValue, @Language; 
SET @MessageValue=N'Percent can''t negative value!' 
EXEC ERP9AddMessage @ModuleID,'OOFML000125', @MessageValue, @Language; 
SET @MessageValue=N'Can''t receive negative value at here!' 
EXEC ERP9AddMessage @ModuleID,'OOFML000126', @MessageValue, @Language; 
SET @MessageValue=N'User is not null value!' 
EXEC ERP9AddMessage @ModuleID,'OOFML000127', @MessageValue, @Language; 
SET @MessageValue=N'Start Date isn''t correct with working time!' 
EXEC ERP9AddMessage @ModuleID,'OOFML000128', @MessageValue, @Language; 
SET @MessageValue=N'End Date isn''t correct with working time!' 
EXEC ERP9AddMessage @ModuleID,'OOFML000129', @MessageValue, @Language; 
SET @MessageValue=N'Data can not duplicate.' 
EXEC ERP9AddMessage @ModuleID,'OOFML000130', @MessageValue, @Language; 
SET @MessageValue=N'Data successfully updated.' 
EXEC ERP9AddMessage @ModuleID,'OOFML000131', @MessageValue, @Language; 
SET @MessageValue=N'The start date of Task work isn''t less than start date of Project!' 
EXEC ERP9AddMessage @ModuleID,'OOFML000132', @MessageValue, @Language; 
SET @MessageValue=N'The checking date isn''t less than the start date!' 
EXEC ERP9AddMessage @ModuleID,'OOFML000133', @MessageValue, @Language; 
SET @MessageValue=N'The checking date isn''t correct with working time!' 
EXEC ERP9AddMessage @ModuleID,'OOFML000134', @MessageValue, @Language; 
SET @MessageValue=N'The start date of Task isn''t larger than the end date of Project!' 
EXEC ERP9AddMessage @ModuleID,'OOFML000135', @MessageValue, @Language; 
SET @MessageValue=N'The end date of Task isn''t larger than the end date of Project.' 
EXEC ERP9AddMessage @ModuleID,'OOFML000136', @MessageValue, @Language; 
SET @MessageValue=N'You do not setting Recurrence yet!' 
EXEC ERP9AddMessage @ModuleID,'OOFML000137', @MessageValue, @Language;
SET @MessageValue=N'Please select a day of the week!'
EXEC ERP9AddMessage @ModuleID,'SFML000282', @MessageValue, @Language;
SET @MessageValue=N'Actions required to declare the condition, please check again!'
EXEC ERP9AddMessage @ModuleID,'SFML000283', @MessageValue, @Language;
SET @MessageValue=N'Delete all conditions deletes the actions entered. Do you want to continue?'
EXEC ERP9AddMessage @ModuleID,'SFML000284', @MessageValue, @Language;
SET @MessageValue=N'Please select activation action!'
EXEC ERP9AddMessage @ModuleID,'SFML000285', @MessageValue, @Language;
SET @MessageValue=N'Variable names cannot contain special characters, spaces, and begin with numbers or numbers. Please check again!'
EXEC ERP9AddMessage @ModuleID,'SFML000286', @MessageValue, @Language;
SET @MessageValue=N'Invalid variable value. Please check again!'
EXEC ERP9AddMessage @ModuleID,'SFML000287', @MessageValue, @Language;
SET @MessageValue=N'Refresh will be data restored. do you want continue?'
EXEC ERP9AddMessage @ModuleID,'SFML000288', @MessageValue, @Language;
SET @MessageValue=N'Changing your settings will reset your entire system and possibly damage your system. Do you want to continue?'
EXEC ERP9AddMessage @ModuleID,'SFML000289', @MessageValue, @Language;
SET @MessageValue=N'Applying all platforms will synchronize decentralization for all platforms!'
EXEC ERP9AddMessage @ModuleID,'SFML000290', @MessageValue, @Language;