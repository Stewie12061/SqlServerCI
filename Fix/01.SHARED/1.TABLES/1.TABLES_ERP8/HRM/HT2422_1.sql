﻿-- <Summary>
---- 
-- <History>
---- Create on 28/11/2016 by Bảo Thy
---- Purpose: Lưu I21 -> I150 cho MEIKO
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HT2422_1]') AND type in (N'U'))
CREATE TABLE [dbo].[HT2422_1](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] nvarchar(50) NOT NULL,
	[EmpFileID] [nvarchar](50) NOT NULL,
	[EmployeeID] [nvarchar](50) NOT NULL,
	[TranMonth] [int] NULL,
	[TranYear] [int] NULL,
	[I21] [decimal](28, 8) NULL,
	[I22] [decimal](28, 8) NULL,
	[I23] [decimal](28, 8) NULL,
	[I24] [decimal](28, 8) NULL,
	[I25] [decimal](28, 8) NULL,
	[I26] [decimal](28, 8) NULL,
	[I27] [decimal](28, 8) NULL,
	[I28] [decimal](28, 8) NULL,
	[I29] [decimal](28, 8) NULL,
	[I30] [decimal](28, 8) NULL,
	[I31] [decimal](28, 8) NULL,
	[I32] [decimal](28, 8) NULL,
	[I33] [decimal](28, 8) NULL,
	[I34] [decimal](28, 8) NULL,
	[I35] [decimal](28, 8) NULL,
	[I36] [decimal](28, 8) NULL,
	[I37] [decimal](28, 8) NULL,
	[I38] [decimal](28, 8) NULL,
	[I39] [decimal](28, 8) NULL,
	[I40] [decimal](28, 8) NULL,
	[I41] [decimal](28, 8) NULL,
	[I42] [decimal](28, 8) NULL,
	[I43] [decimal](28, 8) NULL,
	[I44] [decimal](28, 8) NULL,
	[I45] [decimal](28, 8) NULL,
	[I46] [decimal](28, 8) NULL,
	[I47] [decimal](28, 8) NULL,
	[I48] [decimal](28, 8) NULL,
	[I49] [decimal](28, 8) NULL,
	[I50] [decimal](28, 8) NULL,
	[I51] [decimal](28, 8) NULL,
	[I52] [decimal](28, 8) NULL,
	[I53] [decimal](28, 8) NULL,
	[I54] [decimal](28, 8) NULL,
	[I55] [decimal](28, 8) NULL,
	[I56] [decimal](28, 8) NULL,
	[I57] [decimal](28, 8) NULL,
	[I58] [decimal](28, 8) NULL,
	[I59] [decimal](28, 8) NULL,
	[I60] [decimal](28, 8) NULL,
	[I61] [decimal](28, 8) NULL,
	[I62] [decimal](28, 8) NULL,
	[I63] [decimal](28, 8) NULL,
	[I64] [decimal](28, 8) NULL,
	[I65] [decimal](28, 8) NULL,
	[I66] [decimal](28, 8) NULL,
	[I67] [decimal](28, 8) NULL,
	[I68] [decimal](28, 8) NULL,
	[I69] [decimal](28, 8) NULL,
	[I70] [decimal](28, 8) NULL,
	[I71] [decimal](28, 8) NULL,
	[I72] [decimal](28, 8) NULL,
	[I73] [decimal](28, 8) NULL,
	[I74] [decimal](28, 8) NULL,
	[I75] [decimal](28, 8) NULL,
	[I76] [decimal](28, 8) NULL,
	[I77] [decimal](28, 8) NULL,
	[I78] [decimal](28, 8) NULL,
	[I79] [decimal](28, 8) NULL,
	[I80] [decimal](28, 8) NULL,
	[I81] [decimal](28, 8) NULL,
	[I82] [decimal](28, 8) NULL,
	[I83] [decimal](28, 8) NULL,
	[I84] [decimal](28, 8) NULL,
	[I85] [decimal](28, 8) NULL,
	[I86] [decimal](28, 8) NULL,
	[I87] [decimal](28, 8) NULL,
	[I88] [decimal](28, 8) NULL,
	[I89] [decimal](28, 8) NULL,
	[I90] [decimal](28, 8) NULL,
	[I91] [decimal](28, 8) NULL,
	[I92] [decimal](28, 8) NULL,
	[I93] [decimal](28, 8) NULL,
	[I94] [decimal](28, 8) NULL,
	[I95] [decimal](28, 8) NULL,
	[I96] [decimal](28, 8) NULL,
	[I97] [decimal](28, 8) NULL,
	[I98] [decimal](28, 8) NULL,
	[I99] [decimal](28, 8) NULL,
	[I100] [decimal](28, 8) NULL,
	[I101] [decimal](28, 8) NULL,
	[I102] [decimal](28, 8) NULL,
	[I103] [decimal](28, 8) NULL,
	[I104] [decimal](28, 8) NULL,
	[I105] [decimal](28, 8) NULL,
	[I106] [decimal](28, 8) NULL,
	[I107] [decimal](28, 8) NULL,
	[I108] [decimal](28, 8) NULL,
	[I109] [decimal](28, 8) NULL,
	[I110] [decimal](28, 8) NULL,
	[I111] [decimal](28, 8) NULL,
	[I112] [decimal](28, 8) NULL,
	[I113] [decimal](28, 8) NULL,
	[I114] [decimal](28, 8) NULL,
	[I115] [decimal](28, 8) NULL,
	[I116] [decimal](28, 8) NULL,
	[I117] [decimal](28, 8) NULL,
	[I118] [decimal](28, 8) NULL,
	[I119] [decimal](28, 8) NULL,
	[I120] [decimal](28, 8) NULL,
	[I121] [decimal](28, 8) NULL,
	[I122] [decimal](28, 8) NULL,
	[I123] [decimal](28, 8) NULL,
	[I124] [decimal](28, 8) NULL,
	[I125] [decimal](28, 8) NULL,
	[I126] [decimal](28, 8) NULL,
	[I127] [decimal](28, 8) NULL,
	[I128] [decimal](28, 8) NULL,
	[I129] [decimal](28, 8) NULL,
	[I130] [decimal](28, 8) NULL,
	[I131] [decimal](28, 8) NULL,
	[I132] [decimal](28, 8) NULL,
	[I133] [decimal](28, 8) NULL,
	[I134] [decimal](28, 8) NULL,
	[I135] [decimal](28, 8) NULL,
	[I136] [decimal](28, 8) NULL,
	[I137] [decimal](28, 8) NULL,
	[I138] [decimal](28, 8) NULL,
	[I139] [decimal](28, 8) NULL,
	[I140] [decimal](28, 8) NULL,
	[I141] [decimal](28, 8) NULL,
	[I142] [decimal](28, 8) NULL,
	[I143] [decimal](28, 8) NULL,
	[I144] [decimal](28, 8) NULL,
	[I145] [decimal](28, 8) NULL,
	[I146] [decimal](28, 8) NULL,
	[I147] [decimal](28, 8) NULL,
	[I148] [decimal](28, 8) NULL,
	[I149] [decimal](28, 8) NULL,
	[I150] [decimal](28, 8) NULL,
	[CreateDate] [datetime] NULL,
	[LastModifyDate] [datetime] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
 CONSTRAINT [PK_HT2422_1] PRIMARY KEY CLUSTERED 
(
	[APK],
	[DivisionID]
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
