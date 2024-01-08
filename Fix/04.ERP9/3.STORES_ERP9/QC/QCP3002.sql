IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[QCP3002]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[QCP3002]
GO
/****** Object:  StoredProcedure [dbo].[QCP3002]    Script Date: 11/13/2020 8:49:25 AM ******/
-- <Summary>
---- Lấy dữ liệu báo cáo VNL
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Create on 13/11/2020 by TAN TAI
----Modified on 03/03/2021 by Le Hoang : them dieu kien hoac ca, may khi phiếu không kế thừa phiếu đầu ca
----Modified on 13/05/2021 by Le Hoang: Bổ sung điều kiện lọc DepartmentID
----Modified on 21/05/2021 by Le Hoang: Bổ sung trường ghi chú 01 của NVL từ phiếu nhập đầu ca của NVL đó
----Modified on ... by ...
-- <Example>
---- 
/*-- <Example>
	EXEC [dbo].[QCP3002]
		@DivisionID = N'VNP',
		@UserID = N'ASOFTADMIN',
		@FromDate = N'2019-11-12 00:00:00.000',
		@ToDate = N'2020-11-15 00:00:00.000',
		@ShiftID = N'',
		@DepartmentID = N'PX01',
		@MachineID = N'MAY01',
		@InventoryID = N'',
		@MaterialID = N''
----*/

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[QCP3002]
( 
	 @DivisionID NVARCHAR(50),
	 @UserID NVARCHAR(50),	 
	 @FromDate NVARCHAR(50), 	 
	 @ToDate NVARCHAR(50),
	 @ShiftID NVARCHAR(255),
	 @DepartmentID NVARCHAR(255),
	 @MachineID NVARCHAR(255),
	 @InventoryID VARCHAR(MAX),
	 @MaterialID VARCHAR(MAX)
)
AS 
DECLARE @sSQL NVARCHAR(MAX),
		@sWhere NVARCHAR(MAX) = N''
		SET @sWhere = ''
		IF ISNULL(@DivisionID, '') != '' 
			SET @sWhere = @sWhere + N' AND QCT2010.DivisionID IN ('''+@DivisionID+''') '
		IF ISNULL(@FromDate, '') != '' 
			SET @sWhere = @sWhere + N' AND QCT2010.VoucherDate >= '''+@FromDate+''''
		IF ISNULL(@ToDate, '') != '' 
			SET @sWhere = @sWhere + N' AND QCT2010.VoucherDate <= '''+SUBSTRING(@ToDate, 0, 11) + ' 23:59:59' +''''
		IF ISNULL(@ShiftID, '') != '' 
			SET @sWhere = @sWhere + N' AND (QCT2000.ShiftID IN ('''+@ShiftID+''') OR QCT2010.InheritShift IN ('''+@ShiftID+''')) '
		IF ISNULL(@DepartmentID, '') != '' 
			SET @sWhere = @sWhere + N' AND CIT1150.DepartmentID IN ('''+REPLACE(@DepartmentID,',',''',''')+''')'
		IF ISNULL(@MachineID, '') != '' 
			SET @sWhere = @sWhere + N' AND (QCT2000.MachineID IN ('''+@MachineID+''') OR QCT2010.InheritMachine IN ('''+@MachineID+''')) '
		IF ISNULL(@InventoryID, '') != '' 
			SET @sWhere = @sWhere + N' AND QCT2001.InventoryID IN ('''+@InventoryID+''')'
		IF ISNULL(@MaterialID, '') != '' 
			SET @sWhere = @sWhere + N' AND QCT2011.MaterialID IN ('''+@MaterialID+''')'
		--DROP TABLE #Total_Standard
		DECLARE   @SQLQuery AS NVARCHAR(MAX)
		--select * from  #Total_Standard
		DECLARE   @PivotColumns AS NVARCHAR(MAX)
		SELECT   @PivotColumns= COALESCE(@PivotColumns + ',','') + QUOTENAME(Standard)
		FROM (SELECT DISTINCT (StandardID +' |-| '+StandardName) as Standard FROM QCT1000 where TypeID='BOM') AS PivotExample
		--SELECT  @PivotColumns

		DECLARE   @PivotColumnsSUM AS NVARCHAR(MAX)
		IF EXISTS (SELECT TOP 1 1 FROM CustomerIndex WHERE CustomerName = 128)
		BEGIN
			SELECT   @PivotColumnsSUM= COALESCE(@PivotColumnsSUM + ',','') +'AVG(convert (int,'+ QUOTENAME(Standard)+' )) as'+ QUOTENAME(Standard)
			FROM (SELECT DISTINCT (StandardID +' |-| '+StandardName) as Standard FROM QCT1000 where TypeID='BOM') AS PivotExample
		END
		ELSE
		BEGIN
			SELECT   @PivotColumnsSUM= COALESCE(@PivotColumnsSUM + ',','') +'SUM(convert (int,'+ QUOTENAME(Standard)+' )) as'+ QUOTENAME(Standard)
			FROM (SELECT DISTINCT (StandardID +' |-| '+StandardName) as Standard FROM QCT1000 where TypeID='BOM') AS PivotExample
		END
		--SELECT  @PivotColumnsSUM

SET   @SQLQuery =  N'
		select QCT2011APKMaster,MaterialID,InventoryName,BatchID AS BatchNo,UnitID, ShiftID, Q99.Notes01, '+@PivotColumnsSUM+'  from (
		select QCT2011.DivisionID, QCT2011.APK as QCT2011APK,QCT2011.APKMaster as QCT2011APKMaster, QCT2011.MaterialID,AT1302.InventoryName,QCT2011.BatchID,AT1302.UnitID,QCT2000.ShiftID  
		,PIVOTStandard.*
		from QCT2010 QCT2010
		left join QCT2011 QCT2011 on QCT2011.APKMaster  = QCT2010.APK
		left join AT1302 AT1302 on AT1302.InventoryID  = QCT2011.MaterialID
		left join QCT2001 QCT2001 on QCT2001.APK  = QCT2011.RefAPKDetail
		left join QCT2000 QCT2000 on QCT2000.APK  = QCT2001.APKMaster
		left join CIT1150 CIT1150 on CIT1150.MachineID  = QCT2000.MachineID
		left join (
		SELECT APKMaster ,DeleteFlg ,'+ @PivotColumns +' FROM (
		SELECT QCT2002.APKMaster,QCT2002.DeleteFlg, QCT1000.StandardName AS StandardID,QCT2002.StandardValue,(QCT1000.StandardID +'' |-| ''+ QCT1000.StandardName) as Standard   
		from QCT1000 QCT1000 
		LEFT JOIN QCT2002 QCT2002 on QCT2002.StandardID = QCT1000.StandardID 
		where QCT1000.TypeID=N''BOM'' and  QCT2002.DeleteFlg =0 and StandardValue !=''''
		) as Standard_Temp
		PIVOT
		( 
			max(StandardValue)
			FOR Standard IN (' + @PivotColumns + ')
		)as  pvt ) as PIVOTStandard on
		PIVOTStandard.APKMaster = QCT2011.APK

		where  QCT2010.DeleteFlg = 0 AND QCT2010.VoucherType = 2 AND QCT2011.APK IS NOT NULL '+@sWhere+'

		)  as total
		LEFT JOIN QCT2001 Q99 WITH(NOLOCK) ON Q99.DivisionID = total.DivisionID AND Q99.InventoryID = total.MaterialID AND Q99.BatchNo = total.BatchID
		GROUP BY  QCT2011APKMaster,MaterialID,InventoryName,BatchID,UnitID,ShiftID,Q99.Notes01
		'
		print (@SQLQuery)
		EXEC sp_executesql @SQLQuery





