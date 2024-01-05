IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[SOT2083]') AND TYPE IN (N'U'))
BEGIN

CREATE TABLE [dbo].[SOT2083](
	[APK] [uniqueidentifier] NULL,
	[DivisionID] [varchar](25) NULL,
	[AttachID] [int] NULL,
	[RelatedToID] [varchar](125) NULL,
	[StatusID] [varchar](50) NULL
) ON [PRIMARY]
ALTER TABLE [dbo].[SOT2083] ADD  CONSTRAINT [DF_SOT2083_APK]  DEFAULT (newid()) FOR [APK]

END
--[Kiều Nga][01/03/2022] Bổ sung cột GluingTypeID
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2083' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2083' AND col.name = 'GluingTypeID')
    ALTER TABLE SOT2083 ADD GluingTypeID [varchar](50) NULL
END