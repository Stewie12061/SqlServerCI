IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP0120]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[WP0120]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
--- Load danh sách phiếu yêu cầu nhập - xuất - VCNB lên màn hình Duyệt cấp 2
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Tiểu Mai on 09/08/2016
---- Modified by Bảo Thy on 26/05/2017: Sửa danh mục dùng chung
---- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

-- <Example>
/*
    EXEC WP0120 'HT','2016-08-01 00:00:00.000','2016-08-15 00:00:00.000',8,2016,8,2016,1, 1, 2, N'('''')', N' (0=0) ', N'('''')', N' (0=0) '
*/

 CREATE PROCEDURE WP0120
(
		@DivisionID NVARCHAR(50),
		@FromDate DATETIME,
		@ToDate DATETIME,
		@FromMonth INT,
		@FromYear INT,
		@ToMonth INT,
		@ToYear INT,
		@IsDate TINYINT, -- = 1: Theo ngày, = 0: Theo kỳ
		@Status TINYINT, -- Tình trạng phiếu
		@KindVoucherID INT, -- 1: nhập, 2: xuất, 3: vcnb
		@ConditionVT NVARCHAR(MAX), -- phân quyền chứng từ
		@IsUsedConditionVT NVARCHAR(50),
		@ConditionOB NVARCHAR(MAX), -- phân quyền đối tượng
		@IsUsedConditionOB NVARCHAR(50)    
)
AS

DECLARE @sSQL NVARCHAR(MAX),
		@sWhere NVARCHAR(MAX)

SET @sWhere = ''
	if @KindVoucherID is not null 
		set @sWhere = @sWhere + '
				AND ISNULL(W95.KindVoucherID,'''') = '+Convert(nvarchar(5),@KindVoucherID)+' '			

	IF LTRIM((@IsDate)) = 1	SET @sWHERE = @sWHERE + '
	AND CONVERT(VARCHAR(10),W95.VoucherDate,112) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,112)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,112)+''' '
	IF LTRIM((@IsDate)) = 0	SET @sWHERE = @sWHERE + '
	AND (W95.TranYear*12 + W95.TranMonth) BETWEEN '+LTRIM((@FromYear*12 + @FromMonth))+' AND '+LTRIM((@ToYear*12 + @ToMonth))+' '
SET @sWhere = @sWhere +	'
	AND (ISNULL(W95.ObjectID, ''#'') IN ('+@ConditionOB+') OR '+@IsUsedConditionOB+') 
	AND (ISNULL(W95.VoucherTypeID, ''#'') IN ('+@ConditionVT+') OR '+@IsUsedConditionVT+')'	

set @sSQL = N'
SELECT CASE WHEN W95.KindVoucherID IN (1,3,5,7,9) AND W95.WareHouseID2 IS NULL THEN 1 
WHEN W95.KindVoucherID  = 3 AND W95.WareHouseID2 IS NOT NULL THEN 3 ELSE 2 END KindVoucherID, ISNULL(W95.IsCheck,0) IsCheck,
 W95.VoucherTypeID, W95.VoucherID, W95.VoucherNo, W95.VoucherDate, W95.ObjectID, A02.ObjectName, W95.WareHouseID, W95.WareHouseID2,
CASE WHEN W95.KindVoucherID IN (1,3,5,7,9) THEN A03.WareHouseName ELSE '''' END ImWareHouseName,
CASE WHEN W95.KindVoucherID IN (2,4,6,8,10) THEN A03.WareHouseName ELSE 
	CASE WHEN W95.KindVoucherID = 3 THEN A04.WareHouseName ELSE '''' END END ExWareHouseName,
SUM (W96.ConvertedAmount) ConvertedAmount, W95.RefNo01, W95.RefNo02, W95.[Description],
Isnull(IsConfirm01,0) as IsConfirm01, 
Case when Isnull(IsConfirm01,0) = 0 then N''Chưa chấp nhận'' else 
	(case when Isnull(IsConfirm01,0) = 1 then N''Xác nhận'' else N''Từ chối'' end) end as IsConfirmName01, 
ConfDescription01, 
Isnull(IsConfirm02,0) as IsConfirm02, 
Case when Isnull(IsConfirm02,0) = 0 then N''Chưa chấp nhận'' else 
	(case when Isnull(IsConfirm02,0) = 1 then N''Xác nhận'' else N''Từ chối'' end) end as IsConfirmName02,
ConfDescription02
FROM WT0095 W95 WITH (NOLOCK)
LEFT JOIN WT0096 W96 WITH (NOLOCK) ON W96.DivisionID = W95.DivisionID AND W96.VoucherID = W95.VoucherID
LEFT JOIN AT1303 A03 WITH (NOLOCK) ON A03.DivisionID IN ('''+@DivisionID+''',''@@@'') AND A03.WareHouseID = W95.WareHouseID
LEFT JOIN AT1303 A04 WITH (NOLOCK) ON A04.DivisionID IN ('''+@DivisionID+''',''@@@'') AND A04.WareHouseID = W95.WareHouseID2
LEFT JOIN AT1202 A02 WITH (NOLOCK) ON A02.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A02.ObjectID = W95.ObjectID
WHERE W95.DivisionID = '''+@DivisionID+'''
	AND ISNULL(IsConfirm01,0) = 1
'+ CASE WHEN (ISNULL(@Status,0) = 0 OR ISNULL(@Status,0) = 2) THEN 'AND ISNULL(IsConfirm02,0) IN (0, 2) ' ELSE ' AND ISNULL(IsConfirm02,0) = 1 ' END +'
'+ @sWhere +'
GROUP BY W95.VoucherID, W95.VoucherTypeID, W95.VoucherNo, W95.VoucherDate, W95.ObjectID, A02.ObjectName, W95.WareHouseID, W95.WareHouseID2,
KindVoucherID, A03.WareHouseName, A04.WareHouseName, W95.RefNo01, W95.RefNo02, W95.[Description],W95.WareHouseID2, IsCheck,
IsConfirm01, ConfDescription01, IsConfirm02, ConfDescription02		
'
EXEC (@sSQL)
--PRINT @sSQL

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
