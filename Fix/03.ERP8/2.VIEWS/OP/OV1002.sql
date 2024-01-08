IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OV1002]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[OV1002]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


---Created by: Vo Thanh huong
---Created date: 11/08/2004
---purpose: Tao du lieu ngam: Hình th?c giao hàng
--- Modified by Kim Thư on 26/6/2019: Bổ sung dấu hiển thị tiếng Việt
 
CREATE VIEW [dbo].[OV1002] as

---Don hang mua
Select 0 as OrderType, N'Thương mại' as Description, 'SO' as TypeID,DivisionID from AT1101
Union
Select 1 as OrderType, N'Sản xuất' as Description, 'SO' as TypeID,DivisionID from AT1101
Union
Select 2 as OrderType, N'Dịch vụ' as Description, 'SO' as TypeID,DivisionID from AT1101
Union
Select 9 as OrderType, N'Khác' as Description, 'SO' as TypeID,DivisionID from AT1101
Union

---Don hang mua
Select 0 as OrderType, N'Chưa xác định' as Description, 'PO' as TypeID,DivisionID from AT1101

GO

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO


