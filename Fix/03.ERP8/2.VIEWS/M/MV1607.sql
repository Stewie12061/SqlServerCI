
/****** Object:  View [dbo].[MV1607]    Script Date: 12/16/2010 15:37:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

--Created by :Hoang Thi Lan
--Date 25/11/2003
--Purpose:Hien thi chi tiet cho report Bo dinh muc(MR1602)

ALTER VIEW [dbo].[MV1607]
as
Select DivisionID, ApportionID,Description,Disabled, InventoryTypeID,
Case when IsBOM =1 then '��nh m��c nguye�n va�t lie�u'
 else '��nh m��c ha�ng xua�t kho'
 End  as Type
From MT1602

GO


