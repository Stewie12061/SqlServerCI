﻿---- Create by Đặng Thị Tiểu Mai on 19/08/2016
---- Chi tiết đề nghị định mức

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[MT0177]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[MT0177]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NULL,
      [DivisionID] VARCHAR(50) NOT NULL,
      [TransactionID] VARCHAR(50) NOT NULL,
      [VoucherID] VARCHAR(50) NULL,
      [ReTransactionID] VARCHAR(50) NULL,
      [InheritTransactionID] VARCHAR(50) NULL,
      [MaterialID] VARCHAR(50) NULL,
      [MaterialUnitID] VARCHAR(50) NULL,
      [MaterialTypeID] VARCHAR(50) NULL,
      [Rate] DECIMAL(28,8) NULL,
      [ExpenseID] VARCHAR(50) NULL,
      [MaterialQuantity] DECIMAL(28,8) NULL,
      [MaterialPrice] DECIMAL(28,8) NULL,
      [RateDecimalApp] DECIMAL(28,8) NULL,
      [MaterialAmount] DECIMAL(28,8) NULL,
      [QuantityUnit] DECIMAL(28,8) NULL,
      [ConvertedUnit] DECIMAL(28,8) NULL,
      [IsExtraMaterial] TINYINT DEFAULT (0) NULL,
      [MaterialGroupID] VARCHAR(50) NULL,
      [WasteID] VARCHAR(50) NULL,
      [RateWastage] DECIMAL(28,8) NULL,
      [Notes] NVARCHAR(250) NULL,
      [DParameter01] NVARCHAR(250) NULL,
      [DParameter02] NVARCHAR(250) NULL,
      [DParameter03] NVARCHAR(250) NULL,
      [DS01ID] VARCHAR(50) NULL,
      [DS02ID] VARCHAR(50) NULL,
      [DS03ID] VARCHAR(50) NULL,
      [DS04ID] VARCHAR(50) NULL,
      [DS05ID] VARCHAR(50) NULL,
      [DS06ID] VARCHAR(50) NULL,
      [DS07ID] VARCHAR(50) NULL,
      [DS08ID] VARCHAR(50) NULL,
      [DS09ID] VARCHAR(50) NULL,
      [DS10ID] VARCHAR(50) NULL,
      [DS11ID] VARCHAR(50) NULL,
      [DS12ID] VARCHAR(50) NULL,
      [DS13ID] VARCHAR(50) NULL,
      [DS14ID] VARCHAR(50) NULL,
      [DS15ID] VARCHAR(50) NULL,
      [DS16ID] VARCHAR(50) NULL,
      [DS17ID] VARCHAR(50) NULL,
      [DS18ID] VARCHAR(50) NULL,
      [DS19ID] VARCHAR(50) NULL,
      [DS20ID] VARCHAR(50) NULL,
      [Orders] INT NULL,
      [Begin_MaterialQuantity] DECIMAL(28,8) NULL,
      [Begin_MaterialPrice] DECIMAL(28,8) NULL,
      [Begin_RateDecimalApp] DECIMAL(28,8) NULL,
      [Begin_MaterialAmount] DECIMAL(28,8) NULL,
      [Begin_QuantityUnit] DECIMAL(28,8) NULL,
      [Begin_ConvertedUnit] DECIMAL(28,8) NULL
    CONSTRAINT [PK_MT0177] PRIMARY KEY CLUSTERED
      (
      [DivisionID],
      [TransactionID]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END

