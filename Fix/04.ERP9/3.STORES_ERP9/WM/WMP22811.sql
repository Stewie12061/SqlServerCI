IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WMP22811]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WMP22811]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
----Load dữ liệu dưới lưới khi nhập số seri - Master nhập kho seri
-- <Param>
---- 
-- <Return>
---- 
-- <History>
----Created by: Hồng Thắm, Date: 01/11/2023
-- <Example>

create   PROCEDURE [dbo].[WMP22811]
( 
	 @SeriNo VARCHAR(50)
)
AS 
declare @count int = 0;
set @count = (Select COUNT (*) from BT1002 where SeriNo = @SeriNo)
if @count = 0
Begin 
SELECT BT1302.*, AT1302.InventoryName, AT1302.UnitID
            FROM BT1302 WITH(NOLOCK)
            INNER JOIN AT1302 WITH(NOLOCK)
            ON AT1302.DivisionID IN ('@@@', BT1302.DivisionID) AND BT1302.InventoryID = AT1302.InventoryID
            WHERE BT1302.DivisionID in ('@@@', BT1302.DivisionID) AND BT1302.SeriNo = @SeriNo
end

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

