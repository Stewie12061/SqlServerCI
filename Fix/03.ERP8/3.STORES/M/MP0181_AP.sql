IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP0181_AP]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP0181_AP]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---- Created by Tiểu Mai on 06/09/2016: Load màn hình truy vấn Kế hoạch sản xuất tháng MF0181 (AN PHÁT)
---- Modified by Hải Long on 25/05/2017: Sửa danh mục dùng chung
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

CREATE PROCEDURE [dbo].[MP0181_AP]
		@DivisionID NVARCHAR(50) ,
		@FromMonth INT,
		@FromYear INT,
		@ToMonth INT,
		@ToYear INT,
		@ObjectID NVARCHAR(50),
		@EmployeeID NVARCHAR(50),
		@ObjectID1 NVARCHAR(50),
		@ObjectID2 NVARCHAR(50)
AS

	DECLARE @sSQL AS nvarchar(4000)

IF Isnull(@ObjectID1,'') = ''
	SET @ObjectID1 = N'%'
	
IF Isnull(@ObjectID2,'') = ''
	SET @ObjectID2 = N'%'
			
SET @sSQL = '
SELECT MT0181.DivisionID, MT0181.VoucherID, MT0181.VoucherNo, MT0181.VoucherDate, MT0181.VoucherTypeID,
MT0181.ObjectID, AT1202.ObjectName, MT0181.EmployeeID, AT1103.FullName as EmployeeName, MT0181.[Description], MT0181.TranMonth, MT0181.TranYear,
MT0181.[Disabled]
FROM MT0181 WITH (NOLOCK)
LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = MT0181.ObjectID
LEFT JOIN AT1103 WITH (NOLOCK) ON AT1103.EmployeeID = MT0181.EmployeeID
LEFT JOIN (SELECT DISTINCT DivisionID, VoucherID FROM MT0182 WITH (NOLOCK) WHERE MT0182.ObjectID1 LIKE N'''+@ObjectID1+''' AND MT0182.ObjectID2 LIKE N'''+@ObjectID2+''') MT0182
			ON MT0182.DivisionID = MT0181.DivisionID AND MT0181.VoucherID = MT0182.VoucherID
WHERE MT0181.DivisionID = '''+@DivisionID+'''
	AND Isnull(MT0181.ObjectID,'''') LIKE '''+@ObjectID+'''
	AND Isnull(MT0181.EmployeeID,'''') LIKE '''+@EmployeeID+'''
	AND MT0181.TranMonth + MT0181.TranYear*100 BETWEEN '+Convert(nvarchar(10),@FromMonth + @FromYear*100) + ' AND '+ Convert(nvarchar(10),@ToMonth + @ToYear*100)

PRINT @sSQL
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
