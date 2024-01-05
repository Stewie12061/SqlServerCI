---- Create by truong ngoc phuong thao on 07/04/2016 11:13:31 AM
---- Thiết lập báo cáo công (Detail - Meiko)

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[HT0383]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[HT0383]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NULL,
      [DivisionID] VARCHAR(50) NOT NULL,
      [LineID] VARCHAR(50) NOT NULL,
      [ReportID] VARCHAR(50) NOT NULL,
      [DataTypeID] VARCHAR(50) NULL,
      [DataTypeName] NVARCHAR(250) NULL,
      [FromAbsentTypeID] VARCHAR(50) NULL,
      [ToAbsentTypeID] VARCHAR(50) NULL,
      [Orders] INT DEFAULT 0 NULL
    CONSTRAINT [PK_HT0383] PRIMARY KEY CLUSTERED
      (
      [DivisionID],
      [LineID],
      [ReportID]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END