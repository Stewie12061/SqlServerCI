--- Modify by: Lê Thị Hạnh on 27/8/14 - Bổ sung BrandID
IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[MTT2000]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[MTT2000]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
      [DivisionID] VARCHAR(50) NOT NULL,
      [BrandID] VARCHAR(50) NOT NULL, -- Bổ sung phân quyền
      [TranMonth] INT NOT NULL,
      [TranYear] INT NOT NULL,
      [S] VARCHAR(50) NULL,
      [StudentID] VARCHAR(50) NOT NULL,
      [StudentName] NVARCHAR(250) NULL,
      [StudentNameE] NVARCHAR(250) NULL,
      [IsMale] TINYINT DEFAULT (0) NULL,
      [Birthday] DATETIME NULL,
      [Tel1] VARCHAR(100) NULL,
      [Tel2] VARCHAR(100) NULL,
      [Email] NVARCHAR(250) NULL,
      [Address] NVARCHAR(500) NULL,
      [AddWard] NVARCHAR(250) NULL,
      [AddDistrict] NVARCHAR(250) NULL,
      [Notes] NVARCHAR(1000) NULL,
      [StartDate] DATETIME NULL,
      [School] NVARCHAR(250) NULL,
      [Grade] NVARCHAR(250) NULL,
      [IsTATC] TINYINT DEFAULT (0) NULL,
      [Ward] NVARCHAR(250) NULL,
      [District] NVARCHAR(250) NULL,
      [FatherJob] NVARCHAR(250) NULL,
      [MotherJob] NVARCHAR(250) NULL,
      [SpecNotes] NVARCHAR(1000) NULL,
      [Source1] VARCHAR(50) NULL,
      [Source2] VARCHAR(50) NULL,
      [Source3] VARCHAR(50) NULL,
      [ContactPerson1] NVARCHAR(250) NULL,
      [ContactTel1] VARCHAR(100) NULL,
      [ContactEmail1] NVARCHAR(250) NULL,
      [ContactPerson2] NVARCHAR(250) NULL,
      [ContactTel2] VARCHAR(100) NULL,
      [ContactEmail2] NVARCHAR(250) NULL,
      [Interviewer] NVARCHAR(250) NULL,
      [Reception] NVARCHAR(250) NULL,
      [PlacementLevel] NVARCHAR(250) NULL,
      [TeacherCommentEK] NVARCHAR(1000) NULL,
      [ClassDate] DATETIME NULL,
      [Improvement] NVARCHAR(250) NULL,
      [Strength] NVARCHAR(1000) NULL,
      [Listening] DECIMAL(28,8) DEFAULT (0) NULL,
      [Speaking] DECIMAL(28,8) DEFAULT (0) NULL,
      [Reading] DECIMAL(28,8) DEFAULT (0) NULL,
      [Writing] DECIMAL(28,8) DEFAULT (0) NULL,
      [Total] DECIMAL(28,8) DEFAULT (0) NULL,
      [DeleteFlag] TINYINT DEFAULT (0) NOT NULL,
      [Part1] DECIMAL(28,8) DEFAULT (0) NULL,
      [Part2] DECIMAL(28,8) DEFAULT (0) NULL,
      [Part3] DECIMAL(28,8) DEFAULT (0) NULL,
      [Part4] DECIMAL(28,8) DEFAULT (0) NULL,
      [PartTotal] DECIMAL(28,8) DEFAULT (0) NULL,
      [IsSkill] TINYINT DEFAULT (0) NOT NULL,
      [CreateUserID] VARCHAR(50) NULL,
      [CreateDate] DATETIME NULL,
      [LastModifyUserID] VARCHAR(50) NULL,
      [LastModifyDate] DATETIME NULL,
      [OtherNotes] NVARCHAR(500) NULL
    CONSTRAINT [PK_MTT2000] PRIMARY KEY CLUSTERED
      (
      [DivisionID],
      [StudentID]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END