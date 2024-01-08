﻿-- <Summary>
---- 
-- <History>
---- Create on 13/12/2010 by Thanh Sơn
---- Modified on ... by 
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[AT1014]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[AT1014]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
      [DivisionID] VARCHAR(50) NULL,
      [CityID] VARCHAR(50) NULL,
      [DistrictID] VARCHAR(50) NULL,
      [WardID] VARCHAR(50) NOT NULL,
      [WardName] NVARCHAR(250) NULL,
      [Disabled] TINYINT DEFAULT (0) NOT NULL,
      [IsCommon] TINYINT DEFAULT (0) NOT NULL,
      [CreateUserID] VARCHAR(50) NULL,
      [CreateDate] DATETIME NULL,
      [LastModifyUserID] VARCHAR(50) NULL,
      [LastModifyDate] DATETIME NULL
    CONSTRAINT [PK_AT1014] PRIMARY KEY CLUSTERED
      (
      [WardID]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END