IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[QCP3005]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[QCP3005]
GO
/****** Object:  StoredProcedure [dbo].[QCP3005]    Script Date: 11/13/2020 3:01:26 PM ******/
-- <Summary>
---- Lấy dữ liệu báo cáo sản xuất
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Create on 13/11/2020 by TAN TAI
----Modified on 13/05/2021 by Le Hoang: Bổ sung điều kiện lọc DepartmentID
----Modified on 22/06/2021 by Le Hoang: (2021/06/IS/0120) Yêu cầu xử lý lại chỉ lấy lên những mã hàng có ghi nhận số lượng. 
----------------------------------------Nếu có nhập đầu ca mà không ghi nhận nghiệp vụ ghi nhận số lượng sẽ không lây mã hàng này lên báo cáo.
----Modified on ... by ...
-- <Example>
---- 
/*-- <Example>
	EXEC [dbo].[QCP3005]
		@DivisionID = N'VNP',
		@UserID = N'ASOFTADMIN',
		@FromDate = N'2019-11-12 00:00:00.000',
		@ToDate = N'2020-11-15 00:00:00.000',
		@ShiftID = N'',
		@DepartmentID = N'PX01',
		@MachineID = N'MAY01',
		@InventoryID = N''

		NOTE: AT1302 --isvip:0 Thành phẩm, 1: thứ phẩm
----*/

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[QCP3005]
( 
	 @DivisionID NVARCHAR(50),
	 @UserID NVARCHAR(50),	 
	 @FromDate NVARCHAR(50), 	 
	 @ToDate NVARCHAR(50),
	 @ShiftID VARCHAR(MAX),
	 @DepartmentID VARCHAR(MAX),
	 @MachineID VARCHAR(MAX),
	 @InventoryID VARCHAR(MAX)
)
AS 
DECLARE @sSQL NVARCHAR(MAX),
		@sWhere NVARCHAR(MAX) = N''
		SET @sWhere = ''
		IF ISNULL(@DivisionID, '') != '' 
			SET @sWhere = @sWhere + N' AND QCT2000.DivisionID IN ('''+@DivisionID+''')'
		IF ISNULL(@FromDate, '') != '' 
			SET @sWhere = @sWhere + N' AND QCT2000.VoucherDate >= '''+@FromDate+''''
		IF ISNULL(@ToDate, '') != '' 
			SET @sWhere = @sWhere + N' AND QCT2000.VoucherDate <= '''+SUBSTRING(@ToDate, 0, 11) + ' 23:59:59' +''''
		IF ISNULL(@ShiftID, '') != '' 
			SET @sWhere = @sWhere + N' AND QCT2000.ShiftID IN ('''+@ShiftID+''')'
		IF ISNULL(@DepartmentID, '') != '' 
			SET @sWhere = @sWhere + N' AND CIT1150.DepartmentID IN ('''+REPLACE(@DepartmentID,',',''',''')+''')'
		IF ISNULL(@MachineID, '') != '' 
			SET @sWhere = @sWhere + N' AND QCT2000.MachineID IN ('''+@MachineID+''')'
		IF ISNULL(@InventoryID, '') != '' 
			SET @sWhere = @sWhere + N' AND QCT2001.InventoryID IN ('''+@InventoryID+''')'
		--DROP TABLE #Total_Standard
		DECLARE   @SQLQuery AS NVARCHAR(MAX)
		--select * from  #Total_Standard
		DECLARE   @PivotColumns AS NVARCHAR(MAX)
		SELECT   @PivotColumns= COALESCE(@PivotColumns + ',','') + QUOTENAME(StandardID) 
		FROM (SELECT DISTINCT StandardID FROM QCT1000 where TypeID='BOM') AS PivotExample
		--SELECT  @PivotColumns

		DECLARE   @PivotColumnsSUM AS NVARCHAR(MAX)
		SELECT   @PivotColumnsSUM= COALESCE(@PivotColumnsSUM + ',','') +'SUM(convert (int,'+ QUOTENAME(StandardID)+' )) as ' + QUOTENAME(StandardName)
		FROM (SELECT DISTINCT StandardID,StandardName FROM QCT1000 where TypeID='BOM') AS PivotExample
		--SELECT  @PivotColumnsSUM

SET   @SQLQuery =  N'
		SELECT CIT1150.MachineID,CIT1150.MachineName,CIT1150.MachineNameE,
		HT1020.ShiftID,HT1020.ShiftName,
		QCT2000.VoucherNo ,
		CONVERT(VARCHAR, QCT2000.VoucherDate, 103) As VoucherDate,
		QCT2001.InventoryID,
		AT1302.InventoryName,
		AT1302.isvip,
		AT1302.UnitID,
		QCT2001.BatchNo ,	
		QCT2001.Status AS QCT2001Status,
		T10.StatusName AS Status,
		QCT2001.Description,
		QCT2001.GrossWeight,
		QCT2001.NetWeight,
		QCT2001.OtherUnitID,
		CASE WHEN ISNULL(QCT2001.OtherQuantity,0) = 0 
			 THEN ISNULL(TRY_PARSE(AT1302.Varchar03 AS DECIMAL(28,8)),0) * ISNULL(QCT2001.GrossWeight,0)
			 ELSE QCT2001.OtherQuantity END AS OtherQuantity
		FROM QCT2000 WITH(NOLOCK) 
		INNER JOIN QCT2001 WITH(NOLOCK) ON QCT2001.DivisionID = QCT2000.DivisionID AND QCT2001.APKMaster = QCT2000.APK
		INNER JOIN AT1302 WITH(NOLOCK) ON AT1302.DivisionID IN (QCT2001.DivisionID,''@@@'') AND AT1302.InventoryID = QCT2001.InventoryID
		INNER JOIN CIT1150 WITH(NOLOCK) ON CIT1150.DivisionID IN (QCT2000.DivisionID,''@@@'') AND CIT1150.MachineID = QCT2000.MachineID
		INNER JOIN HT1020 WITH(NOLOCK) ON HT1020.DivisionID IN (QCT2000.DivisionID,''@@@'') AND HT1020.ShiftID = QCT2000.ShiftID
		INNER JOIN QCT2010 WITH(NOLOCK) ON QCT2010.DivisionID = QCT2000.DivisionID AND QCT2010.APKMaster = QCT2000.APK
		LEFT JOIN (SELECT ID AS StatusID, Description AS StatusName FROM QCT0099 WITH(NOLOCK) WHERE CodeMaster = ''Status'') T10 ON QCT2001.Status = T10.StatusID
		WHERE QCT2000.DeleteFlg = 0 AND QCT2001.DeleteFlg = 0 '+@sWhere+''
		print (@SQLQuery)
		EXEC sp_executesql @SQLQuery





		