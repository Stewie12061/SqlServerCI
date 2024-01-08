IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP0185]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP0185]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

  
-- <Summary>  
---- Load Combo kế hoạch sản xuất tháng theo tham số (ANPHAT).
-- <Param>  
----   
-- <Return>  
----   
-- <Reference>  
----   
-- <History>  
------ Created By Hải Long.  
------ Date 14.09.2016.  
------ Purpose: Truy vấn mã kế hoạch sản xuất tháng với tham số (ANPHAT) 
------ Modified by Tiểu Mai on 21/11/2016: Bổ sung ObjectID1, ObjectName, Description
------ Modified by Hải Long on 25/05/2017: Sửa danh mục dùng chung
------ Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
-- <Example>  
  
CREATE PROCEDURE [dbo].[MP0185]  
(   
       @DivisionID nvarchar(50),  
       @FromMonth AS int,
       @ToMonth AS int,
       @FromYear AS int,
       @ToYear AS int,
       @FromDate AS datetime,
       @ToDate AS DATETIME,
       @IsDate AS tinyint
)         
AS  
SET NOCOUNT ON  

IF @IsDate = 0
BEGIN
	SELECT MT0181.VoucherNo, MT0181.VoucherID, A.ObjectID1 AS ObjectID, ObjectName, MT0181.[Description]
	FROM MT0181 WITH (NOLOCK)
	LEFT JOIN (SELECT DivisionID, VoucherID, ObjectID1
	             FROM MT0182 WITH (NOLOCK)) A ON A.VoucherID = MT0181.VoucherID AND A.DivisionID = MT0181.DivisionID
	LEFT JOIN AT1202 ON AT1202.DivisionID IN (@DivisionID, '@@@') AND AT1202.ObjectID = A.ObjectID1
	WHERE MT0181.DivisionID = @DivisionID
	AND TranYear*12 + TranMonth BETWEEN @FromYear*12+@FromMonth AND @ToYear*12+@ToMonth
	ORDER BY VoucherNo
END 
ELSE
	BEGIN
		SELECT MT0181.VoucherNo, MT0181.VoucherID, A.ObjectID1 AS ObjectID, ObjectName, MT0181.[Description]
		FROM MT0181 WITH (NOLOCK)
		LEFT JOIN (SELECT DivisionID, VoucherID, ObjectID1
					 FROM MT0182 WITH (NOLOCK)) A ON A.VoucherID = MT0181.VoucherID AND A.DivisionID = MT0181.DivisionID
		LEFT JOIN AT1202 ON AT1202.DivisionID IN (@DivisionID, '@@@') AND AT1202.ObjectID = A.ObjectID1
		WHERE MT0181.DivisionID = @DivisionID
				AND VoucherDate BETWEEN CONVERT(NVARCHAR(20), @FromDate, 101) AND CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'	
		ORDER BY VoucherNo
	END

		
SET NOCOUNT OFF  

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
