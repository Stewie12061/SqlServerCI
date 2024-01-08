IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV6026]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[AV6026]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



--Creater: Thuy Tuyen
-- Purpore: Load edit man hinh ban hang theo bo
--Date: 03/07/2009
---- Modified by Phương Thảo on 10/05/2016 : Sửa danh mục dùng chung
---- Modify on 02/10/2020 by Nhựt Trường: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.


CREATE VIEW [dbo].[AV6026]
as

Select AT1302.InventoryName, AT1302.IsSource,AT1302.IsLimitDate,AT1302.IsLocation,AT1302.MethodID,AT1302.DeliveryPrice,
 AT1302.IsStocked, AT1302.AccountID as IsDebitAccountID , 2 as IsApportionID, AT9000.*
From AT9000 WITH(NOLOCK)
Left Join AT1302  WITH(NOLOCK) On AT1302.DivisionID IN (AT9000.DivisionID,'@@@') AND AT9000.InventoryID = AT1302.InventoryID
Where 
( exists (select top 1 1 From AT1326  WITH(NOLOCK) Where InventoryID = AT9000.InventoryID)
or exists (Select top 1 1 From MT1603  WITH(NOLOCK) Where ProductID = AT9000.InventoryID And DivisionID = AT9000.DivisionID)
 )

union all
Select AT1302.InventoryName, AT1302.IsSource,AT1302.IsLimitDate,AT1302.IsLocation,AT1302.MethodID,AT1302.DeliveryPrice,
 AT1302.IsStocked, AT1302.AccountID as IsDebitAccountID ,  case when IsStocked =0 then 0 else 1 end  as IsApportionID,AT9000.*
From AT9000  WITH(NOLOCK)
Left Join AT1302  WITH(NOLOCK) On AT1302.DivisionID IN (AT9000.DivisionID,'@@@') AND AT9000.InventoryID = AT1302.InventoryID 
Where 
not exists (select top 1 1  from AT1326  WITH(NOLOCK) Where InventoryID = AT9000.InventoryID)
and not exists(select top 1 1 from MT1603  WITH(NOLOCK) Where ProductID = AT9000.InventoryID and DivisionID = AT9000.DivisionID)

GO


