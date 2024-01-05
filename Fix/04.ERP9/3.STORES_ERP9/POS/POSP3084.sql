IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP3084]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POSP3084]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Báo cáo huê hồng nhân viên dịch vụ
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Kiều Nga, Date: 22/11/2019
----Updated by: Nhật Thanh, Date: 18/07/2023: Cải tiến trường hợp không có dữ liệu in lỗi
-- <Example> 

CREATE PROCEDURE POSP3084 
(
	@DivisionID			VARCHAR(50),
	@DivisionIDList		NVARCHAR(MAX),
	@ShopID				VARCHAR(50),
	@ShopIDList			NVARCHAR(MAX),
	@IsDate				TINYINT,  --1: Theo ngày; 0: Theo kỳ
	@FromDate			DATETIME, 
	@ToDate				DATETIME, 
	@PeriodIDList		NVARCHAR(2000),
	@ListInventoryID	VARCHAR(MAX) ='',
	@ListEmployeeID		VARCHAR(MAX) =''
)
AS
BEGIN
		DECLARE @sSQL1   NVARCHAR(MAX) ='',  
				@sSQL2   NVARCHAR(MAX) ='',  
				@sWhere NVARCHAR(MAX) =''
				
		IF Isnull(@DivisionIDList,'') = ''
			SET @sWhere = @sWhere + ' A.DivisionID IN ('''+ @DivisionID+''')'
		Else 
			SET @sWhere = @sWhere + ' A.DivisionID IN ('''+@DivisionIDList+''')'

		IF @IsDate = 1	
			SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR,A.VoucherDate,112) BETWEEN '''+CONVERT(VARCHAR,@FromDate,112)+''' AND '''+CONVERT(VARCHAR,@ToDate,112)+''''
		ELSE
			SET @sWhere = @sWhere + 'AND concat(Convert(nvarchar(2),format(Month(ISNULL(A.VoucherDate,0)),''00'')),''/'',CONVERT(nvarchar(4),Year(ISNULL(A.VoucherDate,0)))) IN ('''+@PeriodIDList+''')'

		IF Isnull(@ShopIDList,'') = ''
			SET @sWhere = @sWhere + ' And A.ShopID IN ('''+@ShopID+''')'
		Else 
			SET @sWhere = @sWhere + ' And A.ShopID IN ('''+@ShopIDList+''')'
				
		IF Isnull(@ListInventoryID, '')<> ''
			SET @sWhere = @sWhere + ' AND A.InventoryID IN ('''+@ListInventoryID +''')'

		IF Isnull(@ListEmployeeID, '')<> ''
		   	SET @sWhere = @sWhere + ' AND A.EmployeeID IN ('''+@ListEmployeeID +''')'

		SET @sSQL1 = 'SELECT Distinct  A.EmployeeID,A.EmployeeName ,A.VoucherNo,A.InventoryID ,A.InventoryName,A.ActualQuantity,A.UnitPrice
		,A.Amount,Sum(A.GuaranteeEmployeeScores) as GuaranteeEmployeeScores,Sum(A.RepairStaffScores) as RepairStaffScores,
		Sum(A.DeliveryEmployeeScores) as DeliveryEmployeeScores,Sum(A.Notes05) as Notes05
from 
(SELECT Distinct  PT53.GuaranteeEmployeeID as EmployeeID ,A03.FullName AS EmployeeName,PT50.VoucherNo,PT51.ServiceID as InventoryID ,A01.InventoryName,PT51.ActualQuantity,PT51.UnitPrice
		,ISNULL(PT51.ActualQuantity,0) * ISNULL(PT51.UnitPrice,0) AS Amount,ISNULL(PT51.Notes01,0)* ISNULL(P.ScoreFactor,0) as GuaranteeEmployeeScores,0 as RepairStaffScores ,0 as DeliveryEmployeeScores,
		ISNULL(PT51.Notes01,0)* ISNULL(P.ScoreFactor,0) as Notes05,PT50.ShopID,PT50.DivisionID,PT50.VoucherDate,PT50.DeleteFlg
FROM POST2050 PT50 WITH (NOLOCK)
INNER JOIN POST2051 PT51 WITH (NOLOCK) ON PT50.APK = PT51.APKMaster
INNER JOIN POST2053 PT53 WITH (NOLOCK) ON PT50.VoucherNo = PT53.VoucherNo AND PT50.DivisionID = PT53.DivisionID and ISNULL(PT53.GuaranteeEmployeeID,'''') <>'''' 
LEFT JOIN AT1302 A01 WITH (NOLOCK)  ON PT51.ServiceID = A01.InventoryID
LEFT JOIN AT1202 A02 WITH (NOLOCK)  ON PT50.MemberID = A02.ObjectID
LEFT JOIN AT1103 A03 WITH (NOLOCK)  ON PT53.GuaranteeEmployeeID = A03.EmployeeID
LEFT JOIN (select POST2050.APK, POST0073.ScoreFactor,ROW_NUMBER() OVER (PARTITION BY POST2050.APK ORDER BY APT0007.CheckinTime DESC) as t from APT0007 
			inner join POST2050 ON APT0007.APKMInherited = POST2050.APK
			left join POST0073 ON POST0073.DivisionID = POST2050.DivisionID
			where  POST0073.FromDistance <=  ISNULL(APT0007.Distance,0)/1000  and  ISNULL(APT0007.Distance,0)/1000 <=  POST0073.ToDistance) P ON P.t =1 and P.APK = PT50.APK
Union all
SELECT Distinct PT53.RepairEmployeeID as EmployeeID  ,A03.FullName AS EmployeeName,PT50.VoucherNo,PT51.ServiceID as InventoryID ,A01.InventoryName,PT51.ActualQuantity,PT51.UnitPrice
		,ISNULL(PT51.ActualQuantity,0) * ISNULL(PT51.UnitPrice,0) AS Amount,0 as GuaranteeEmployeeScores,ISNULL(PT51.Notes02,0)* ISNULL(P.ScoreFactor,0) as RepairStaffScores ,0 as DeliveryEmployeeScores,
		ISNULL(PT51.Notes02,0)* ISNULL(P.ScoreFactor,0) as Notes05,PT50.ShopID,PT50.DivisionID,PT50.VoucherDate,PT50.DeleteFlg
FROM POST2050 PT50 WITH (NOLOCK)
INNER JOIN POST2051 PT51 WITH (NOLOCK) ON PT50.APK = PT51.APKMaster
INNER JOIN POST2053 PT53 WITH (NOLOCK) ON PT50.VoucherNo = PT53.VoucherNo AND PT50.DivisionID = PT53.DivisionID and ISNULL(PT53.RepairEmployeeID,'''') <>''''
LEFT JOIN AT1302 A01 WITH (NOLOCK)  ON PT51.ServiceID = A01.InventoryID
LEFT JOIN AT1202 A02 WITH (NOLOCK)  ON PT50.MemberID = A02.ObjectID
LEFT JOIN AT1103 A03 WITH (NOLOCK)  ON PT53.RepairEmployeeID = A03.EmployeeID
LEFT JOIN (select POST2050.APK, POST0073.ScoreFactor,ROW_NUMBER() OVER (PARTITION BY POST2050.APK ORDER BY APT0007.CheckinTime DESC) as t from APT0007 
			inner join POST2050 ON APT0007.APKMInherited = POST2050.APK
			left join POST0073 ON POST0073.DivisionID = POST2050.DivisionID
			where  POST0073.FromDistance <=  ISNULL(APT0007.Distance,0)/1000  and  ISNULL(APT0007.Distance,0)/1000  <=  POST0073.ToDistance) P ON P.t =1 and P.APK = PT50.APK'

SET @sSQL2 ='
Union all
SELECT Distinct PT53.DeliveryEmployeeID as EmployeeID ,A03.FullName AS EmployeeName,PT50.VoucherNo,PT51.ServiceID as InventoryID ,A01.InventoryName,PT51.ActualQuantity,PT51.UnitPrice
		,ISNULL(PT51.ActualQuantity,0) * ISNULL(PT51.UnitPrice,0) AS Amount,0 as GuaranteeEmployeeScores,0 as RepairStaffScores ,ISNULL(Convert(decimal,PT51.Notes),0)* ISNULL(P.ScoreFactor,0) as DeliveryEmployeeScores,
		ISNULL(Convert(decimal,PT51.Notes),0)* ISNULL(P.ScoreFactor,0) as Notes05,PT50.ShopID,PT50.DivisionID,PT50.VoucherDate,PT50.DeleteFlg
FROM POST2050 PT50 WITH (NOLOCK)
INNER JOIN POST2051 PT51 WITH (NOLOCK) ON PT50.APK = PT51.APKMaster
INNER JOIN POST2053 PT53 WITH (NOLOCK) ON PT50.VoucherNo = PT53.VoucherNo AND PT50.DivisionID = PT53.DivisionID and ISNULL(PT53.DeliveryEmployeeID,'''') <>''''
LEFT JOIN AT1302 A01 WITH (NOLOCK)  ON PT51.ServiceID = A01.InventoryID
LEFT JOIN AT1202 A02 WITH (NOLOCK)  ON PT50.MemberID = A02.ObjectID
LEFT JOIN AT1103 A03 WITH (NOLOCK)  ON PT53.DeliveryEmployeeID = A03.EmployeeID
LEFT JOIN (select POST2050.APK, POST0073.ScoreFactor,ROW_NUMBER() OVER (PARTITION BY POST2050.APK ORDER BY APT0007.CheckinTime DESC) as t from APT0007 
			inner join POST2050 ON APT0007.APKMInherited = POST2050.APK
			left join POST0073 ON POST0073.DivisionID = POST2050.DivisionID
			where  POST0073.FromDistance <=  ISNULL(APT0007.Distance,0)/1000  and  ISNULL(APT0007.Distance,0)/1000 <=  POST0073.ToDistance) P ON P.t =1 and P.APK = PT50.APK
) as A
Where  A.DeleteFlg = 0 AND '+@sWhere+
'
group by A.EmployeeID,A.EmployeeName ,A.VoucherNo,A.InventoryID ,A.InventoryName,A.ActualQuantity,A.UnitPrice
		,A.Amount,A.VoucherDate
order by A.EmployeeID'
PRINT @sSQL1
PRINT @sSQL2
EXEC(@sSQL1 + @sSQL2)

END		


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
