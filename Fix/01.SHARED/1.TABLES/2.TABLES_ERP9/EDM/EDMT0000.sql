---- Create by Hồng Thảo on 20/08/2018
---- Thiết lập hệ thống EDM

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[EDMT0000]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[EDMT0000]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [MaxStudentQuantity] INT NULL,
  [MinstudentQuantity] INT NULL,
  [MaxTeacherQuantity] INT NULL,
  [MinTeacherQuantity] INT NULL,
  [TransportTypeAnalyst] VARCHAR(50) NULL, 
  [WorkOvertimeTypeAnalyst] VARCHAR(50) NULL, 
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_EDMT0000] PRIMARY KEY CLUSTERED
(
  [APK],
  [DivisionID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END   



---Modified by Hồng Thảo on 17/10/2018: Bổ sung cột mã phân tích tự động module EDM 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT0000' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT0000' AND col.name = 'VoucherConsultancy') 
   ALTER TABLE EDMT0000 ADD VoucherConsultancy VARCHAR(50) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT0000' AND col.name = 'VoucherObject') 
   ALTER TABLE EDMT0000 ADD VoucherObject VARCHAR(50) NULL 
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT0000' AND col.name = 'VoucherInterstratify') 
   ALTER TABLE EDMT0000 ADD VoucherInterstratify VARCHAR(50) NULL
   
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT0000' AND col.name = 'VoucherAssignedTeacher') 
   ALTER TABLE EDMT0000 ADD VoucherAssignedTeacher VARCHAR(50) NULL
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT0000' AND col.name = 'VoucherRollcall') 
   ALTER TABLE EDMT0000 ADD VoucherRollcall VARCHAR(50) NULL


   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT0000' AND col.name = 'VoucherLearnningResult') 
   ALTER TABLE EDMT0000 ADD VoucherLearnningResult VARCHAR(50) NULL
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT0000' AND col.name = 'VoucherClassObservation') 
   ALTER TABLE EDMT0000 ADD VoucherClassObservation VARCHAR(50) NULL
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT0000' AND col.name = 'VoucherTranferTeacher') 
   ALTER TABLE EDMT0000 ADD VoucherTranferTeacher VARCHAR(50) NULL
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT0000' AND col.name = 'VoucherScheduleYear') 
   ALTER TABLE EDMT0000 ADD VoucherScheduleYear VARCHAR(50) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT0000' AND col.name = 'VoucherSchedule') 
   ALTER TABLE EDMT0000 ADD VoucherSchedule VARCHAR(50) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT0000' AND col.name = 'VoucherCurriculum') 
   ALTER TABLE EDMT0000 ADD VoucherCurriculum VARCHAR(50) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT0000' AND col.name = 'VoucherCurriculumMonth') 
   ALTER TABLE EDMT0000 ADD VoucherCurriculumMonth VARCHAR(50) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT0000' AND col.name = 'VoucherRegisterService') 
   ALTER TABLE EDMT0000 ADD VoucherRegisterService VARCHAR(50) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT0000' AND col.name = 'VoucherAssignedStudent') 
   ALTER TABLE EDMT0000 ADD VoucherAssignedStudent VARCHAR(50) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT0000' AND col.name = 'VoucherReserve') 
   ALTER TABLE EDMT0000 ADD VoucherReserve VARCHAR(50) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT0000' AND col.name = 'VoucherTuition') 
   ALTER TABLE EDMT0000 ADD VoucherTuition VARCHAR(50) NULL

    
END 


---Modified by Hồng Thảo on 20/03/2019: Bổ sung cột số chứng từ quản lý tin tức 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT0000' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT0000' AND col.name = 'VoucherNews') 
   ALTER TABLE EDMT0000 ADD VoucherNews VARCHAR(50) NULL 


   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT0000' AND col.name = 'SType01ID') 
   ALTER TABLE EDMT0000 ADD SType01ID VARCHAR(50) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT0000' AND col.name = 'SType02ID') 
   ALTER TABLE EDMT0000 ADD SType02ID VARCHAR(50) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT0000' AND col.name = 'SType03ID') 
   ALTER TABLE EDMT0000 ADD SType03ID VARCHAR(50) NULL



   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT0000' AND col.name = 'SType01IDS') 
   ALTER TABLE EDMT0000 ADD SType01IDS VARCHAR(50) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT0000' AND col.name = 'SType02IDS') 
   ALTER TABLE EDMT0000 ADD SType02IDS VARCHAR(50) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT0000' AND col.name = 'SType03IDS') 
   ALTER TABLE EDMT0000 ADD SType03IDS VARCHAR(50) NULL



END 



  
  ---Modified by Hồng Thảo on 27/9/2019: Bổ sung cột số ngày xin phép nghỉ cho hoàn trả tiền ăn ngày, hoàn trả tiền ăn trưa/xế 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT0000' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT0000' AND col.name = 'DayEatLunch') 
   ALTER TABLE EDMT0000 ADD DayEatLunch TINYINT DEFAULT(0) NULL


   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT0000' AND col.name = 'DayEat') 
   ALTER TABLE EDMT0000 ADD DayEat TINYINT DEFAULT(0) NULL


END 

 
-----Modified by Hồng Thảo on 16/10/2019: Bố sung cột số chứng từ nghỉ học cho những DB không có cột này 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT0000' AND xtype = 'U')
BEGIN 

 IF  EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
			 ON col.id = tab.id WHERE tab.name = 'EDMT0000' AND col.name = 'VoucheLeaveSchool')
			 AND 
			 NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
			 ON col.id = tab.id WHERE tab.name = 'EDMT0000' AND col.name = 'VoucheLeaveSchool') 
  EXEC sp_rename 'EDMT0000.VoucheLeaveSchool', 'VoucherLeaveSchool', 'COLUMN';

 ELSE IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT0000' AND col.name = 'VoucherLeaveSchool') 
   ALTER TABLE EDMT0000 ADD VoucherLeaveSchool VARCHAR(50) NULL
   

END 

  
 
 

 ---Modified by Hồng Thảo on 31/12/2019: Bổ sung cột số chứng từ thay đổi mức đóng phí, voucher giảm giá đưa đón, cảnh báo sáp đến ngyaf đóng phí 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT0000' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT0000' AND col.name = 'VoucherFeeChange') 
   ALTER TABLE EDMT0000 ADD VoucherFeeChange VARCHAR(50) NULL


   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT0000' AND col.name = 'PromotionShuttle') 
   ALTER TABLE EDMT0000 ADD PromotionShuttle VARCHAR(50) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT0000' AND col.name = 'IsFeePay') 
   ALTER TABLE EDMT0000 ADD IsFeePay TINYINT DEFAULT(0) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT0000' AND col.name = 'DatePay') 
   ALTER TABLE EDMT0000 ADD DatePay TINYINT DEFAULT(0) NULL



END 


 ---Modified by Hồng Thảo on 31/12/2019: Bổ sung cột số chứng từ thiết lập mức phí đóng đầu năm
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT0000' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT0000' AND col.name = 'VoucherSetNewYear') 
   ALTER TABLE EDMT0000 ADD VoucherSetNewYear VARCHAR(50) NULL

END 
