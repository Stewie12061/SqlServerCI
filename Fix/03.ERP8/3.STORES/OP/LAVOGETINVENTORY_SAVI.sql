IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[LAVOGETINVENTORY_SAVI]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[LAVOGETINVENTORY_SAVI]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--- Modified by Bảo Anh on 27/05/2017: Sửa danh mục dùng chung
--- Modified by Đức Thông on 03/09/2020: Bổ sung filter theo tranmonth, tranyear
--- Modified by Văn Tài	  on 28/09/2020: Tách store customize
--- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.

--	LAVOGETINVENTORY 'LG', 'ASOFTADMIN', 'NLDAU', '%', '%'

CREATE PROCEDURE LAVOGETINVENTORY_SAVI
(
	@DivisionID VARCHAR(50),
	@user_id VARCHAR(50),
	@product_id VARCHAR(50),
	@product_name NVARCHAR(250),
	@warehouse_id VARCHAR(50)
)
AS
DECLARE @TranMonth INT = MONTH(GETDATE()),
		@TranYear INT = YEAR(GETDATE()),
		@sSQL NVARCHAR(MAX)

--kiểm tra nếu product rỗng thì gán %
IF ISNULL(@product_id,'') =''  SET @product_id='%'
IF ISNULL(@product_name,'') =''  SET @product_name='%'
IF Isnull(@warehouse_id,'') ='' SET @warehouse_id ='%'

-- thực thi store trả số liệu
EXEC OP2504_SAVI @DivisionID, @TranMonth, @TranYear, @product_id
	
SET @sSQL = '
SELECT V54.WareHouseID warehouse_id
		, A03.WareHouseName warehouse_name
		, V54.InventoryID product_id
		, A02.InventoryName product_name
		, CONVERT(INT,V54.ENDQuantity) remain_count
FROM OV2504 V54
LEFT JOIN AT1302 A02 ON A02.InventoryID = V54.InventoryID
LEFT JOIN AT1303 A03 ON A03.DivisionID IN (''' + @DivisionID + ''',''@@@'') AND A03.WareHouseID = V54.WareHouseID
WHERE V54.DivisionID = '''+@DivisionID+'''
AND ISNULL(V54.WareHouseID, '''') LIKE '''+ISNULL(@warehouse_id,'%')+'''
AND ISNULL(A02.InventoryName,'''') LIKE N''%'+ISNULL(@product_name,'%')+'%''
AND V54.WareHouseID IS NOT NULL
AND V54.TranMonth = ' + STR(@TranMonth) +
' AND V54.TranYear = ' + STR(@TranYear) + ''


EXEC (@sSQL)
PRINT(@sSQL)
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO