﻿
/****** Object:  View [dbo].[WQ7000]    Script Date: 12/16/2010 15:43:21 ******/
IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WQ7000]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[WQ7000]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--Create By: Dang Le Bao Quynh; Date 05/03/2009
--Purpose: Phuc vu in bao cao NXT chi tiet theo nguon goc kho
--Modified by Bảo Thy on 03/05/2017: Bổ sung 20 quy cách

CREATE VIEW [dbo].[WQ7000] AS

Select T6.DivisionID, T6.TranMonth, T6.TranYear, T6. VoucherDate, T6.WareHouseID, T6.WareHouseID2, 0 As KindVoucherID, 
T7.InventoryID, isnull(T7.ActualQuantity,0) As ActualQuantity, Isnull(T7.ConvertedAmount,0) As ConvertedAmount, 
Isnull(T7.ActualQuantity,0) As SignQuantity, isnull(T7.ConvertedAmount,0) As SignAmount, T7.TransactionID, T7.VoucherID
From AT2016 T6 inner join AT2017 T7 on T6.VoucherID = T7.VoucherID

Union All

Select T6.DivisionID, T6.TranMonth, T6.TranYear, T6. VoucherDate, T6.WareHouseID, T6.WareHouseID2, 1 As KindVoucherID, 
T7.InventoryID, isnull(T7.ActualQuantity,0) As ActualQuantity, Isnull(T7.ConvertedAmount,0) As ConvertedAmount, 
Isnull(T7.ActualQuantity,0) As SignQuantity, isnull(T7.ConvertedAmount,0) As SignAmount, T7.TransactionID, T7.VoucherID
From AT2006 T6 inner join AT2007 T7 on T6.VoucherID = T7.VoucherID
Where T6.KindVoucherID in (1,5,7,9)

Union All

Select T6.DivisionID, T6.TranMonth, T6.TranYear, T6. VoucherDate, T6.WareHouseID, T6.WareHouseID2, 3 As KindVoucherID, 
T7.InventoryID, isnull(T7.ActualQuantity,0) As ActualQuantity, Isnull(T7.ConvertedAmount,0) As ConvertedAmount, 
Isnull(T7.ActualQuantity,0) As SignQuantity, isnull(T7.ConvertedAmount,0) As SignAmount, T7.TransactionID, T7.VoucherID
From AT2006 T6 inner join AT2007 T7 on T6.VoucherID = T7.VoucherID
Where T6.KindVoucherID in (3)

Union All

Select T6.DivisionID, T6.TranMonth, T6.TranYear, T6. VoucherDate, T6.WareHouseID, T6.WareHouseID2, 2 As KindVoucherID, 
T7.InventoryID, isnull(T7.ActualQuantity,0) As ActualQuantity, Isnull(T7.ConvertedAmount,0) As ConvertedAmount, 
-Isnull(T7.ActualQuantity,0) As SignQuantity, -isnull(T7.ConvertedAmount,0) As SignAmount, T7.TransactionID, T7.VoucherID
From AT2006 T6 inner join AT2007 T7 on T6.VoucherID = T7.VoucherID
Where T6.KindVoucherID in (2,4,6,8,10)

Union All

Select T6.DivisionID, T6.TranMonth, T6.TranYear, T6. VoucherDate, T6.WareHouseID2 As WareHouseID, T6.WareHouseID As WareHouseID2, 3 As KindVoucherID, 
T7.InventoryID, isnull(T7.ActualQuantity,0) As ActualQuantity, Isnull(T7.ConvertedAmount,0) As ConvertedAmount, 
-Isnull(T7.ActualQuantity,0) As SignQuantity, -isnull(T7.ConvertedAmount,0) As SignAmount, T7.TransactionID, T7.VoucherID
From AT2006 T6 inner join AT2007 T7 on T6.VoucherID = T7.VoucherID
Where T6.KindVoucherID in (3)

GO


