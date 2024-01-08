
IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP0159]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP0159]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


---- Customize Angel: Load dữ liệu khi edit kế hoạch mua hàng tổng hợp
---- Created by Bảo Anh, Date: 02/03/2016
---- Modified by Tiểu Mai on 26/07/2016: Sửa cách load của SourceID
---- Modified by Tiểu Mai on 23/05/2017: Bổ sung WITH (NOLOCK) và chỉnh sửa danh mục dùng chung
---- Modified by Huỳnh Thử on 28/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
---- OP0159 'ANG','ZZZ'

CREATE PROCEDURE [dbo].[OP0159] 
    @DivisionID NVARCHAR(50),
    @VoucherID AS NVARCHAR(50)
AS

SELECT	OT55.VoucherTypeID, OT55.VoucherNo, OT55.VoucherDate, OT55.Description, OT55.EmployeeID,
		OT56.*,
		AT1202.ObjectName, AT1302.InventoryName,
		CASE WHEN OT56.SourceID = 0 then N'Nội địa' else CASE when Isnull(OT56.SourceID,'') = '' THEN '' ELSE N'Nhập khẩu'  END 
		END as SourceName
FROM OT0155 OT55 WITH (NOLOCK)
INNER JOIN OT0156 OT56 WITH (NOLOCK) ON OT55.DivisionID = OT56.DivisionID And OT55.VoucherID = OT56.VoucherID
LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (@DivisionID, '@@@') AND OT56.ObjectID = AT1202.ObjectID
LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN ('@@@', OT56.DivisionID) AND OT56.InventoryID = AT1302.InventoryID
WHERE OT55.DivisionID = @DivisionID AND OT55.VoucherID = @VoucherID


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
