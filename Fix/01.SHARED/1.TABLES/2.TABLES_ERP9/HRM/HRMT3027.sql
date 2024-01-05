---- Create by Phan Hải Long on 9/22/2017 1:45:02 PM
---- Ghi nhận chi phí (detail)

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[HRMT3027]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[HRMT3027]
(
  [APK] NVARCHAR(50) NOT NULL,
  [DivisionID] NVARCHAR(50) NOT NULL,
  [ReportTypeID] NVARCHAR(50) NOT NULL,
  [ReportTypeName] NVARCHAR(50) NULL,
  [Date] NVARCHAR(50) NULL,
  [EmployeeID] NVARCHAR(50) NULL,
  [DepartmentID] NVARCHAR(50) NULL,  
  [MachineID] NVARCHAR(50) NULL,  
  [ShiftID] NVARCHAR(50) NULL,  
  [FromDate] NVARCHAR(50) NULL,  
  [ToDate] NVARCHAR(50) NULL, 
  [Notes] NVARCHAR(50) NULL,
  [CreatedDate] NVARCHAR(50) NULL 
)
ON [PRIMARY]
END