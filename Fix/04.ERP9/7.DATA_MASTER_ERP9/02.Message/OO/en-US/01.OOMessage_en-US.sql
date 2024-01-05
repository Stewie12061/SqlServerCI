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
SET @MessageValue=N'End date can not smaller than Start date!'
EXEC ERP9AddMessage @ModuleID,'OOFML000099', @MessageValue, @Language;
SET @MessageValue=N'Start date can not smaller End date!'
EXEC ERP9AddMessage @ModuleID,'OOFML000100', @MessageValue, @Language;
SET @MessageValue=N'ToDate is invalid!'
EXEC ERP9AddMessage @ModuleID,'OOFML000101', @MessageValue, @Language;
SET @MessageValue=N'Every...Days is invalid!'
EXEC ERP9AddMessage @ModuleID,'OOFML000102', @MessageValue, @Language;
SET @MessageValue=N'You must choose Day of week!'
EXEC ERP9AddMessage @ModuleID,'OOFML000103', @MessageValue, @Language;
SET @MessageValue=N'The day is invalid!'
EXEC ERP9AddMessage @ModuleID,'OOFML000104', @MessageValue, @Language;
SET @MessageValue=N'The month is invalid!'
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
SET @MessageValue=N'You must setup info for Target group!'
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
SET @MessageValue=N'{0} has been setup in another line!'
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
SET @MessageValue=N'The start date of Task work is less than start date of Project!'
EXEC ERP9AddMessage @ModuleID,'OOFML000132', @MessageValue, @Language;
SET @MessageValue=N'The checking date isn''t less than the start date!'
EXEC ERP9AddMessage @ModuleID,'OOFML000133', @MessageValue, @Language;
SET @MessageValue=N'The checking date isn''t correct with working time!'
EXEC ERP9AddMessage @ModuleID,'OOFML000134', @MessageValue, @Language;
SET @MessageValue=N'The start date of Task is larger than the end date of Project!'
EXEC ERP9AddMessage @ModuleID,'OOFML000135', @MessageValue, @Language;
SET @MessageValue=N'The end date of Task is larger than the end date of Project!'
EXEC ERP9AddMessage @ModuleID,'OOFML000136', @MessageValue, @Language;
SET @MessageValue=N'You do not setting Recurrence yet!'
EXEC ERP9AddMessage @ModuleID,'OOFML000137', @MessageValue, @Language;
SET @MessageValue=N'{0} is {1}. You can not use {2} function!'
EXEC ERP9AddMessage @ModuleID,'OOFML000138', @MessageValue, @Language;
SET @MessageValue=N'Task evaluating: {0}'
EXEC ERP9AddMessage @ModuleID,'OOFML000139', @MessageValue, @Language;
SET @MessageValue=N'Task {0} is completed, you need to review it.'
EXEC ERP9AddMessage @ModuleID,'OOFML000140', @MessageValue, @Language;
SET @MessageValue=N'{0} is violating this task. You cannot assign to {0}'
EXEC ERP9AddMessage @ModuleID,'OOFML000141', @MessageValue, @Language;
SET @MessageValue=N'0} is Completed/Closed. You cannot Delete!'
EXEC ERP9AddMessage @ModuleID,'OOFML000142', @MessageValue, @Language;
SET @MessageValue=N'Can not change Status of Task violated!'
EXEC ERP9AddMessage @ModuleID,'OOFML000143', @MessageValue, @Language;
SET @MessageValue=N'This event Id is Invalid'
EXEC ERP9AddMessage @ModuleID,'OOFML000144', @MessageValue, @Language;
SET @MessageValue=N'This event name is Invalid'
EXEC ERP9AddMessage @ModuleID,'OOFML000145', @MessageValue, @Language;
SET @MessageValue=N'The checking date is invalid'
EXEC ERP9AddMessage @ModuleID,'OOFML000146', @MessageValue, @Language;
SET @MessageValue=N'You are currently notified: {0}'
EXEC ERP9AddMessage @ModuleID,'OOFML000147', @MessageValue, @Language;
SET @MessageValue=N'Notification: {0}'
EXEC ERP9AddMessage @ModuleID,'OOFML000148', @MessageValue, @Language;
SET @MessageValue=N' Department is invalid'
EXEC ERP9AddMessage @ModuleID,'OOFML000149', @MessageValue, @Language;
SET @MessageValue=N'You must input assigned to username!'
EXEC ERP9AddMessage @ModuleID,'OOFML000150', @MessageValue, @Language;
SET @MessageValue=N'You must input QTCM!'
EXEC ERP9AddMessage @ModuleID,'OOFML000151', @MessageValue, @Language;
SET @MessageValue=N'Having an unfinished job needs you to consider'
EXEC ERP9AddMessage @ModuleID,'OOFML000152', @MessageValue, @Language;
SET @MessageValue=N'You must input VHPT!'
EXEC ERP9AddMessage @ModuleID,'OOFML000153', @MessageValue, @Language;
SET @MessageValue=N'Work to late: {0}'
EXEC ERP9AddMessage @ModuleID,'OOFML000154', @MessageValue, @Language;
SET @MessageValue=N'Having an unfinished job needs you to consider: {0}'
EXEC ERP9AddMessage @ModuleID,'OOFML000155', @MessageValue, @Language;
SET @MessageValue=N'{0} is late for work {1}'
EXEC ERP9AddMessage @ModuleID,'OOFML000156', @MessageValue, @Language;
SET @MessageValue=N'{0} has been initialized'
EXEC ERP9AddMessage @ModuleID,'OOFML000157', @MessageValue, @Language;
SET @MessageValue=N'You must input project!'
EXEC ERP9AddMessage @ModuleID,'OOFML000158', @MessageValue, @Language;
SET @MessageValue=N'You are assigned a task: {0}'
EXEC ERP9AddMessage @ModuleID,'OOFML000159', @MessageValue, @Language;
SET @MessageValue=N'You are assigned to support a task: {0}'
EXEC ERP9AddMessage @ModuleID,'OOFML000160', @MessageValue, @Language;
SET @MessageValue=N'You are assigned to review a task: {0}'
EXEC ERP9AddMessage @ModuleID,'OOFML000161', @MessageValue, @Language;
SET @MessageValue=N'The start date or end date belongs to the company holiday. Do you want to continue?'
EXEC ERP9AddMessage @ModuleID,'OOFML000162', @MessageValue, @Language;
SET @MessageValue=N' Changing the template will lose the entered data. Do you want to change the template?'
EXEC ERP9AddMessage @ModuleID,'OOFML000163', @MessageValue, @Language;
SET @MessageValue=N'Start date/End date/Checking date belongs to the company holiday. Do you want to continue?'
EXEC ERP9AddMessage @ModuleID,'OOFML000164', @MessageValue, @Language;
SET @MessageValue=N'The work start date or work end date belongs to the company holiday. Do you want to continue?'
EXEC ERP9AddMessage @ModuleID,'OOFML000165', @MessageValue, @Language;
SET @MessageValue=N'You have just been assigned a high priority job: {0}'
EXEC ERP9AddMessage @ModuleID,'OOFML000166', @MessageValue, @Language;
SET @MessageValue=N'Your {0} job has been converted into a high priority task'
EXEC ERP9AddMessage @ModuleID,'OOFML000167', @MessageValue, @Language;
SET @MessageValue=N'Your {0} job has just been transferred to {1}'
EXEC ERP9AddMessage @ModuleID,'OOFML000170', @MessageValue, @Language;
SET @MessageValue=N'{0} is child task of another task, you can not delete!'
EXEC ERP9AddMessage @ModuleID,'OOFML000171', @MessageValue, @Language;
SET @MessageValue=N' The work {0} you supported has been transformed into a high priority job'
EXEC ERP9AddMessage @ModuleID,'OOFML000172', @MessageValue, @Language;
SET @MessageValue=N'The work {0} you supervised has been converted into a high priority job'
EXEC ERP9AddMessage @ModuleID,'OOFML000173', @MessageValue, @Language;
SET @MessageValue=N'Not edit when job is done or closed'
EXEC ERP9AddMessage @ModuleID,'OOFML000174', @MessageValue, @Language;
SET @MessageValue=N' Unable to create a new job when the period ends'
EXEC ERP9AddMessage @ModuleID,'OOFML000177', @MessageValue, @Language;
SET @MessageValue=N'Unable to create a new project when the period ends'
EXEC ERP9AddMessage @ModuleID,'OOFML000178', @MessageValue, @Language;
SET @MessageValue=N'{0} has been reviewed, you cannot {1}!'
EXEC ERP9AddMessage @ModuleID,'OOFML000179', @MessageValue, @Language;
SET @MessageValue=N'change status'
EXEC ERP9AddMessage @ModuleID,'OOFML000180', @MessageValue, @Language;
SET @MessageValue=N'edit checklist'
EXEC ERP9AddMessage @ModuleID,'OOFML000181', @MessageValue, @Language;
SET @MessageValue=N'edit attach'
EXEC ERP9AddMessage @ModuleID,'OOFML000182', @MessageValue, @Language;
SET @MessageValue=N'The Task does not has the sub task!'
EXEC ERP9AddMessage @ModuleID,'OOFML000183', @MessageValue, @Language;
SET @MessageValue=N'You do not have the right to refuse to complete {0} here'
EXEC ERP9AddMessage @ModuleID,'OOFML000184', @MessageValue, @Language;
SET @MessageValue=N'Job already exists around this time. Do you want to continue?'
EXEC ERP9AddMessage @ModuleID,'OOFML000185', @MessageValue, @Language;
SET @MessageValue=N'Steps cannot be converted to Jobs'
EXEC ERP9AddMessage @ModuleID,'OOFML000186', @MessageValue, @Language;
SET @MessageValue=N'Project objects cannot be converted into jobs or steps'
EXEC ERP9AddMessage @ModuleID,'OOFML000187', @MessageValue, @Language;
SET @MessageValue=N' Work objects cannot be converted into steps or processes'
EXEC ERP9AddMessage @ModuleID,'OOFML000188', @MessageValue, @Language;
SET @MessageValue=N'A step created from a process cannot be changed to a job'
EXEC ERP9AddMessage @ModuleID,'OOFML000189', @MessageValue, @Language;
SET @MessageValue=N'Data cannot be deleted'
EXEC ERP9AddMessage @ModuleID,'OOFML000190', @MessageValue, @Language;
SET @MessageValue=N' The analysis code must not be duplicated'
EXEC ERP9AddMessage @ModuleID,'OOFML000191', @MessageValue, @Language;
SET @MessageValue=N'You have not entered employee name'
EXEC ERP9AddMessage @ModuleID,'OOFML000192', @MessageValue, @Language;
SET @MessageValue=N'Can not add Task to Step is using!'
EXEC ERP9AddMessage @ModuleID,'OOFML000193', @MessageValue, @Language;
SET @MessageValue=N'Cannot delete object is used!'
EXEC ERP9AddMessage @ModuleID,'OOFML000194', @MessageValue, @Language;
SET @MessageValue=N'The job has been locked up!'
EXEC ERP9AddMessage @ModuleID,'OOFML000195', @MessageValue, @Language;
SET @MessageValue=N'You must change to Processing status before change to other status!'
EXEC ERP9AddMessage @ModuleID,'OOFML000196', @MessageValue, @Language;
SET @MessageValue=N'The task was beginned can not change to Unexecute status!'
EXEC ERP9AddMessage @ModuleID,'OOFML000197', @MessageValue, @Language;
SET @MessageValue=N'Do you want change status to {0}?'
EXEC ERP9AddMessage @ModuleID,'OOFML000198', @MessageValue, @Language;
SET @MessageValue=N'The problem must be a Project, Work, or Request'
EXEC ERP9AddMessage @ModuleID,'OOFML000199', @MessageValue, @Language;
SET @MessageValue=N'The expiry time cannot be less than the time that the problem arises'
EXEC ERP9AddMessage @ModuleID,'OOFML000200', @MessageValue, @Language;
SET @MessageValue=N'Mark must not be empty!'
EXEC ERP9AddMessage @ModuleID,'OOFML000201', @MessageValue, @Language;
SET @MessageValue=N'Mark cannot be less than 0 and exceed 100!'
EXEC ERP9AddMessage @ModuleID,'OOFML000202', @MessageValue, @Language;
SET @MessageValue=N'You have not choose Project'
EXEC ERP9AddMessage @ModuleID,'OOFML000203', @MessageValue, @Language;
SET @MessageValue=N'{0} was locked, you cannot {1}!'
EXEC ERP9AddMessage @ModuleID,'OOFML000204', @MessageValue, @Language;
SET @MessageValue=N'The time limit for ending must not be less than the time for arising a request'
EXEC ERP9AddMessage @ModuleID,'OOFML000205', @MessageValue, @Language;
SET @MessageValue=N'The list of approved norms exists.'
EXEC ERP9AddMessage @ModuleID,'OOFML000206', @MessageValue, @Language;
SET @MessageValue=N'Periodic work: {0}'
EXEC ERP9AddMessage @ModuleID,'OOFML000207', @MessageValue, @Language;
SET @MessageValue=N'{0} is System status, you cannot Edit/Delete!'
EXEC ERP9AddMessage @ModuleID,'OOFML000208', @MessageValue, @Language;
SET @MessageValue=N'{0} has a job period {1}'
EXEC ERP9AddMessage @ModuleID,'OOFML000209', @MessageValue, @Language;
SET @MessageValue=N'You have just been assigned a high priority issue: {0}'
EXEC ERP9AddMessage @ModuleID,'OOFML000210', @MessageValue, @Language;
SET @MessageValue=N'You have just been assigned a low priority issue: {0}'
EXEC ERP9AddMessage @ModuleID,'OOFML000211', @MessageValue, @Language;
SET @MessageValue=N'Your {0} issue has just been transferred to {1}'
EXEC ERP9AddMessage @ModuleID,'OOFML000212', @MessageValue, @Language;
SET @MessageValue=N'Your {0} issue has been converted into a high priority issue'
EXEC ERP9AddMessage @ModuleID,'OOFML000213', @MessageValue, @Language;
SET @MessageValue=N'You have just been assigned a high priority support request: {0}'
EXEC ERP9AddMessage @ModuleID,'OOFML000214', @MessageValue, @Language;
SET @MessageValue=N'You have just been assigned a low priority support request: {0}'
EXEC ERP9AddMessage @ModuleID,'OOFML000215', @MessageValue, @Language;
SET @MessageValue=N'Your {0} support request has just been transferred to {1}'
EXEC ERP9AddMessage @ModuleID,'OOFML000216', @MessageValue, @Language;
SET @MessageValue=N'Your support request {0} has been changed to High priority support request'
EXEC ERP9AddMessage @ModuleID,'OOFML000217', @MessageValue, @Language;
SET @MessageValue=N'Do you want to continue?'
EXEC ERP9AddMessage @ModuleID,'OOFML000218', @MessageValue, @Language;
SET @MessageValue=N'Your issue {0} has been moved to state {1}'
EXEC ERP9AddMessage @ModuleID,'OOFML000219', @MessageValue, @Language;
SET @MessageValue=N'Your support request {0} has been moved to status {1}'
EXEC ERP9AddMessage @ModuleID,'OOFML000220', @MessageValue, @Language;
SET @MessageValue=N'Can not update progress 100% while in progress!'
EXEC ERP9AddMessage @ModuleID,'OOFML000221', @MessageValue, @Language;
SET @MessageValue=N'The end date of Task work has less than start date of Project!'
EXEC ERP9AddMessage @ModuleID,'OOFML000222', @MessageValue, @Language;
SET @MessageValue=N'You can only create a Support Request for successful incoming calls'
EXEC ERP9AddMessage @ModuleID,'OOFML000223', @MessageValue, @Language;
SET @MessageValue=N'The system is processing. Please wait and do not reload the browser!'
EXEC ERP9AddMessage @ModuleID,'OOFML000224', @MessageValue, @Language;
SET @MessageValue=N'Customer and Contact data when inherited must match Customer and Contact Data of the call'
EXEC ERP9AddMessage @ModuleID,'OOFML000225', @MessageValue, @Language;
SET @MessageValue=N'The job creation date must not be greater than the effective date'
EXEC ERP9AddMessage @ModuleID,'OOFML000227', @MessageValue, @Language;
SET @MessageValue=N'Unable to delete data from the quotation'
EXEC ERP9AddMessage @ModuleID,'OOFML000228', @MessageValue, @Language;
SET @MessageValue=N'Not set working time yet'
EXEC ERP9AddMessage @ModuleID,'OOFML000229', @MessageValue, @Language;
SET @MessageValue=N'End date of {0} is less than start date!'
EXEC ERP9AddMessage @ModuleID,'OOFML000233', @MessageValue, @Language;
SET @MessageValue=N'The start / end time Task is outside the project start / end date'
EXEC ERP9AddMessage @ModuleID,'OOFML000234', @MessageValue, @Language;
SET @MessageValue=N'- Delete the problem ticket:'
EXEC ERP9AddMessage @ModuleID,'OOFML000235', @MessageValue, @Language;
SET @MessageValue=N'- Delete the request form:'
EXEC ERP9AddMessage @ModuleID,'OOFML000236', @MessageValue, @Language;
SET @MessageValue=N'{0} task cannot change to {1}!'
EXEC ERP9AddMessage @ModuleID,'OOFML000237', @MessageValue, @Language;
SET @MessageValue=N'The task will {0} when you approve {1}!'
EXEC ERP9AddMessage @ModuleID,'OOFML000238', @MessageValue, @Language;
SET @MessageValue=N'Task {0} depends on the Accept/Reject status of {1}!'
EXEC ERP9AddMessage @ModuleID,'OOFML000239', @MessageValue, @Language;
SET @MessageValue=N'You have just been assigned an issue of urgent priority: {0}'
EXEC ERP9AddMessage @ModuleID,'OOFML000240', @MessageValue, @Language;
SET @MessageValue=N'You have just been assigned an emergency priority support request: {0}'
EXEC ERP9AddMessage @ModuleID,'OOFML000241', @MessageValue, @Language;
SET @MessageValue=N'You have not selected print data'
EXEC ERP9AddMessage @ModuleID,'OOFML000242', @MessageValue, @Language;
SET @MessageValue=N'You have not selected unit'
EXEC ERP9AddMessage @ModuleID,'OOFML000243', @MessageValue, @Language;
SET @MessageValue=N'You have not selected the project'
EXEC ERP9AddMessage @ModuleID,'OOFML000244', @MessageValue, @Language;
SET @MessageValue=N'The Issues was beginned can not change to Unexecute status!'
EXEC ERP9AddMessage @ModuleID,'OOFML000245', @MessageValue, @Language;
SET @MessageValue=N'{0} Issues cannot change to {1}!'
EXEC ERP9AddMessage @ModuleID,'OOFML000246', @MessageValue, @Language;
SET @MessageValue=N'The support request that started has not been able to switch to Unable Status!'
EXEC ERP9AddMessage @ModuleID,'OOFML000247', @MessageValue, @Language;
SET @MessageValue=N'Support for {0} cannot be transferred to {1}!'
EXEC ERP9AddMessage @ModuleID,'OOFML000248', @MessageValue, @Language;
SET @MessageValue=N'Milestone has begun to be unable to switch to the Unmatched Status!'
EXEC ERP9AddMessage @ModuleID,'OOFML000249', @MessageValue, @Language;
SET @MessageValue=N'Milestone {0} cannot transfer to {1}!'
EXEC ERP9AddMessage @ModuleID,'OOFML000250', @MessageValue, @Language;
SET @MessageValue=N'Receive mail successfully'
EXEC ERP9AddMessage @ModuleID,'OOFML000252', @MessageValue, @Language;
SET @MessageValue=N'Email data failed to save!'
EXEC ERP9AddMessage @ModuleID,'OOFML000253', @MessageValue, @Language;
SET @MessageValue=N'You do not have a new email'
EXEC ERP9AddMessage @ModuleID,'OOFML000254', @MessageValue, @Language;
SET @MessageValue=N'Please set up mail receipt information'
EXEC ERP9AddMessage @ModuleID,'OOFML000255', @MessageValue, @Language;
SET @MessageValue=N'Email data already exists'
EXEC ERP9AddMessage @ModuleID,'OOFML000256', @MessageValue, @Language;
SET @MessageValue=N'Change the Support Dictionary will lose the entered data.'
EXEC ERP9AddMessage @ModuleID,'OOFML000257', @MessageValue, @Language;
SET @MessageValue=N'The starting or ending time is not part of business hours. Do you want to continue?'
EXEC ERP9AddMessage @ModuleID,'OOFML000258', @MessageValue, @Language;
SET @MessageValue=N'Start time and end time have been duplicated, please choose another time!'
EXEC ERP9AddMessage @ModuleID,'OOFML000259', @MessageValue, @Language;
SET @MessageValue=N'The repeat time has been set. Please choose another time!!!'
EXEC ERP9AddMessage @ModuleID,'OOFML000261', @MessageValue, @Language;
SET @MessageValue=N'The allowable period is 365 days. Please select the time again!!!'
EXEC ERP9AddMessage @ModuleID,'OOFML000262', @MessageValue, @Language;
SET @MessageValue=N'{0} is not inheriting data, you cannot remove it.'
EXEC ERP9AddMessage @ModuleID,'OOFML000263', @MessageValue, @Language;
SET @MessageValue=N'Time {0} from {1} to {2}  has confirmed booking. You must reselect a different time for the booking code {3} !!!'
EXEC ERP9AddMessage @ModuleID,'OOFML000264', @MessageValue, @Language;
SET @MessageValue=N'You have just been assigned a low priority target: {0}'
EXEC ERP9AddMessage @ModuleID,'OOFML000280', @MessageValue, @Language;
SET @MessageValue=N'You have just been assigned a high priority target: {0}'
EXEC ERP9AddMessage @ModuleID,'OOFML000281', @MessageValue, @Language;
SET @MessageValue=N'You have just been assigned a target with urgent priority: {0}'
EXEC ERP9AddMessage @ModuleID,'OOFML000282', @MessageValue, @Language;
SET @MessageValue=N'A canceled target cannot be transferred to the Done status!'
EXEC ERP9AddMessage @ModuleID,'OOFML000283', @MessageValue, @Language;
SET @MessageValue=N'Targets that have been started cannot be moved to the Unfulfilled state!'
EXEC ERP9AddMessage @ModuleID,'OOFML000284', @MessageValue, @Language;
SET @MessageValue=N'You must move to the Processing state before moving on to other states!'
EXEC ERP9AddMessage @ModuleID,'OOFML000285', @MessageValue, @Language;
SET @MessageValue=N'{0} has completed the target {1}'
EXEC ERP9AddMessage @ModuleID,'OOFML000286', @MessageValue, @Language;