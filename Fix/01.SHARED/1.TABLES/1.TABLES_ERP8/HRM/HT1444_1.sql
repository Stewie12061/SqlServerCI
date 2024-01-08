﻿---- Create by Bảo Thy on 22/11/2016
---- Purpose: Bổ sung hệ số C26->C150

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[HT1444_1]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[HT1444_1]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
      [DivisionID] NVARCHAR(50) NOT NULL,
      [EmployeeID] NVARCHAR(50) NOT NULL,
      [C26] DECIMAL(28,8) NULL,
      [C27] DECIMAL(28,8) NULL,
      [C28] DECIMAL(28,8) NULL,
      [C29] DECIMAL(28,8) NULL,
      [C30] DECIMAL(28,8) NULL,
      [C31] DECIMAL(28,8) NULL,
      [C32] DECIMAL(28,8) NULL,
      [C33] DECIMAL(28,8) NULL,
      [C34] DECIMAL(28,8) NULL,
      [C35] DECIMAL(28,8) NULL,
      [C36] DECIMAL(28,8) NULL,
      [C37] DECIMAL(28,8) NULL,
      [C38] DECIMAL(28,8) NULL,
      [C39] DECIMAL(28,8) NULL,
      [C40] DECIMAL(28,8) NULL,
      [C41] DECIMAL(28,8) NULL,
      [C42] DECIMAL(28,8) NULL,
      [C43] DECIMAL(28,8) NULL,
      [C44] DECIMAL(28,8) NULL,
      [C45] DECIMAL(28,8) NULL,
      [C46] DECIMAL(28,8) NULL,
      [C47] DECIMAL(28,8) NULL,
      [C48] DECIMAL(28,8) NULL,
      [C49] DECIMAL(28,8) NULL,
      [C50] DECIMAL(28,8) NULL,
	  [C51] DECIMAL(28,8) NULL,
	  [C52] DECIMAL(28,8) NULL,
	  [C53] DECIMAL(28,8) NULL,
	  [C54] DECIMAL(28,8) NULL,
	  [C55] DECIMAL(28,8) NULL,
	  [C56] DECIMAL(28,8) NULL,
	  [C57] DECIMAL(28,8) NULL,
	  [C58] DECIMAL(28,8) NULL,
	  [C59] DECIMAL(28,8) NULL,
	  [C60] DECIMAL(28,8) NULL,
	  [C61] DECIMAL(28,8) NULL,
	  [C62] DECIMAL(28,8) NULL,
	  [C63] DECIMAL(28,8) NULL,
	  [C64] DECIMAL(28,8) NULL,
	  [C65] DECIMAL(28,8) NULL,
	  [C66] DECIMAL(28,8) NULL,
	  [C67] DECIMAL(28,8) NULL,
	  [C68] DECIMAL(28,8) NULL,
	  [C69] DECIMAL(28,8) NULL,
	  [C70] DECIMAL(28,8) NULL,
	  [C71] DECIMAL(28,8) NULL,
	  [C72] DECIMAL(28,8) NULL,
	  [C73] DECIMAL(28,8) NULL,
	  [C74] DECIMAL(28,8) NULL,
	  [C75] DECIMAL(28,8) NULL,
	  [C76] DECIMAL(28,8) NULL,
	  [C77] DECIMAL(28,8) NULL,
	  [C78] DECIMAL(28,8) NULL,
	  [C79] DECIMAL(28,8) NULL,
	  [C80] DECIMAL(28,8) NULL,
	  [C81] DECIMAL(28,8) NULL,
	  [C82] DECIMAL(28,8) NULL,
	  [C83] DECIMAL(28,8) NULL,
	  [C84] DECIMAL(28,8) NULL,
	  [C85] DECIMAL(28,8) NULL,
	  [C86] DECIMAL(28,8) NULL,
	  [C87] DECIMAL(28,8) NULL,
	  [C88] DECIMAL(28,8) NULL,
	  [C89] DECIMAL(28,8) NULL,
	  [C90] DECIMAL(28,8) NULL,
	  [C91] DECIMAL(28,8) NULL,
	  [C92] DECIMAL(28,8) NULL,
	  [C93] DECIMAL(28,8) NULL,
	  [C94] DECIMAL(28,8) NULL,
	  [C95] DECIMAL(28,8) NULL,
	  [C96] DECIMAL(28,8) NULL,
	  [C97] DECIMAL(28,8) NULL,
	  [C98] DECIMAL(28,8) NULL,
	  [C99] DECIMAL(28,8) NULL,
	  [C100] DECIMAL(28,8) NULL,
	  [C101] DECIMAL(28,8) NULL,
	  [C102] DECIMAL(28,8) NULL,
	  [C103] DECIMAL(28,8) NULL,
	  [C104] DECIMAL(28,8) NULL,
	  [C105] DECIMAL(28,8) NULL,
	  [C106] DECIMAL(28,8) NULL,
	  [C107] DECIMAL(28,8) NULL,
	  [C108] DECIMAL(28,8) NULL,
	  [C109] DECIMAL(28,8) NULL,
	  [C110] DECIMAL(28,8) NULL,
	  [C111] DECIMAL(28,8) NULL,
	  [C112] DECIMAL(28,8) NULL,
	  [C113] DECIMAL(28,8) NULL,
	  [C114] DECIMAL(28,8) NULL,
	  [C115] DECIMAL(28,8) NULL,
	  [C116] DECIMAL(28,8) NULL,
	  [C117] DECIMAL(28,8) NULL,
	  [C118] DECIMAL(28,8) NULL,
	  [C119] DECIMAL(28,8) NULL,
	  [C120] DECIMAL(28,8) NULL,
	  [C121] DECIMAL(28,8) NULL,
	  [C122] DECIMAL(28,8) NULL,
	  [C123] DECIMAL(28,8) NULL,
	  [C124] DECIMAL(28,8) NULL,
	  [C125] DECIMAL(28,8) NULL,
	  [C126] DECIMAL(28,8) NULL,
	  [C127] DECIMAL(28,8) NULL,
	  [C128] DECIMAL(28,8) NULL,
	  [C129] DECIMAL(28,8) NULL,
	  [C130] DECIMAL(28,8) NULL,
	  [C131] DECIMAL(28,8) NULL,
	  [C132] DECIMAL(28,8) NULL,
	  [C133] DECIMAL(28,8) NULL,
	  [C134] DECIMAL(28,8) NULL,
	  [C135] DECIMAL(28,8) NULL,
	  [C136] DECIMAL(28,8) NULL,
	  [C137] DECIMAL(28,8) NULL,
	  [C138] DECIMAL(28,8) NULL,
	  [C139] DECIMAL(28,8) NULL,
	  [C140] DECIMAL(28,8) NULL,
	  [C141] DECIMAL(28,8) NULL,
	  [C142] DECIMAL(28,8) NULL,
	  [C143] DECIMAL(28,8) NULL,
	  [C144] DECIMAL(28,8) NULL,
	  [C145] DECIMAL(28,8) NULL,
	  [C146] DECIMAL(28,8) NULL,
	  [C147] DECIMAL(28,8) NULL,
	  [C148] DECIMAL(28,8) NULL,
	  [C149] DECIMAL(28,8) NULL,
	  [C150] DECIMAL(28,8) NULL,
      [CreateDate] DATETIME NULL,
      [CreateUserID] NVARCHAR(250) NULL,
      [LastModifyDate] DATETIME NULL,
      [LastModifyUserID] NVARCHAR(250) DEFAULT (0) NULL
    CONSTRAINT [PK_HT1444_1] PRIMARY KEY CLUSTERED
      (
      [APK],
	  [DivisionID]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END