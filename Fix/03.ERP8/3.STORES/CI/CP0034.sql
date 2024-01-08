IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CP0034]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CP0034]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- In báo cáo danh mục máy - khuôn (ANGEL)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 21/11/2016 by Hải Long
---- Modified by Tiểu Mai on 26/05/2017: Chỉnh sửa danh mục dùng chung và bổ sung WITH (NOLOCK)
---- Modified by Huỳnh Thử on 28/09/2020 : Bổ sung danh mục dùng chung

-- <Example>
---- EXEC CP0034 @DivisionID = 'ANG', @StrCombineID = 'B1 - MDB32001,B2 - MDB12001,B2 - MDB12002'

CREATE PROCEDURE [dbo].[CP0034]
( 
		@DivisionID AS VARCHAR(50),
		@StrCombineID AS VARCHAR(4000)
) 
AS 

DECLARE @sSQL1 NVARCHAR(4000)
		
SET @StrCombineID = REPLACE(@StrCombineID, ',', ''',''')		

SET @sSQL1 = '
SELECT AT0156.CombineID, AT0156.CombineName, AT0156.MachineID, AT0150.MachineName, AT0152.BlockID, AT0152.BlockName, AT0156.ProductID, AT1302.InventoryName AS ProductName,
AT0156.CavityNo, AT0156.Pressure, AT0156.MachineNo, AT0156.BlockTypeID, AT0156.Weight, AT0156.ProductQty,
AT0157.CombineID, AT0157.Orders, AT0157.GroupID, AT0163.GroupName, AT0157.TypeID, TypeName, AT0157.DetailTypeID, DetailTypeName, AT0157.UnitOrMaterial, AT0157.Value
FROM AT0156 WITH (NOLOCK)
LEFT JOIN AT0157 WITH (NOLOCK) ON AT0157.DivisionID = AT0156.DivisionID AND AT0157.CombineID = AT0156.CombineID
LEFT JOIN AT0154 WITH (NOLOCK) ON AT0154.DivisionID = AT0157.DivisionID AND AT0154.TypeID = AT0157.TypeID
LEFT JOIN AT0155 WITH (NOLOCK) ON AT0155.DivisionID = AT0157.DivisionID AND AT0155.TypeID = AT0157.TypeID AND AT0155.DetailTypeID = AT0157.DetailTypeID
LEFT JOIN AT0163 WITH (NOLOCK) ON AT0163.DivisionID = AT0157.DivisionID AND AT0163.GroupID = AT0157.GroupID
LEFT JOIN AT0150 WITH (NOLOCK) ON AT0156.DivisionID = AT0150.DivisionID AND AT0156.MachineID = AT0150.MachineID
LEFT JOIN AT0152 WITH (NOLOCK) ON AT0156.DivisionID = AT0152.DivisionID AND AT0156.BlockID = AT0152.BlockID
LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (''@@@'', AT0156.DivisionID) AND AT0156.ProductID = AT1302.InventoryID
WHERE AT0156.DivisionID = ''' + @DivisionID + '''
AND AT0156.CombineID IN (N''' + @StrCombineID + ''') 
ORDER BY AT0157.CombineID, AT0157.GroupID, Orders
'

EXEC (@sSQL1)
PRINT @sSQL1


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
