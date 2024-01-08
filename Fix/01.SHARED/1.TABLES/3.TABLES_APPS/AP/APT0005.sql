-- <Summary>
---- Bảng chứa dữ liệu ảnh check - in (APP - MOBILE)
-- <History>
---- Create on 09/06/2017 by Hải Long
---- Modified on
---- <Example>

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[APT0005]') AND type in (N'U'))
CREATE TABLE [dbo].[APT0005](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[TransactionID] [nvarchar](50) NOT NULL,	
	[VisitID] [nvarchar](50) NOT NULL,		
	[Image] [XML] NOT NULL,
	[Orders] [tinyint] NULL,
	[CreateUserID] [nvarchar](50) NULL, 
	[CreateDate] [datetime] NULL
 CONSTRAINT [PK_APT0005] PRIMARY KEY NONCLUSTERED 
(
	[DivisionID] ASC,	
	[TransactionID] ASC,
	[VisitID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
