IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[QCP3008]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[QCP3008]
GO
/****** Object:  StoredProcedure [dbo].[QCP3008]    Script Date: 11/13/2020 3:01:26 PM ******/
-- <Summary>
---- Lấy dữ liệu in tem
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Create on 17/11/2020 by TAN TAI
----Modified by Le Hoang on 24/02/2021 : In tem lỗi replace trên code vì biến giống nhau
-- <Example>
---- 
/*-- <Example>
	EXEC [dbo].[QCP3008]
		@DivisionID = N'VNP',
		@UserID = N'',
		@APK =N'1E56892F-0FCF-49B4-8D99-6EB502A86E0D'',''D3E71422-B544-4877-81AA-84BE29A923AA'
----*/


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[QCP3008]
( 
	 @DivisionID  NVARCHAR(50),
	 @UserID  NVARCHAR(50),
	 @APK NVARCHAR(MAX)
)
AS 
DECLARE @sSQL NVARCHAR(MAX),
		@sWhere NVARCHAR(MAX) = N''
		SET @sWhere = ''
		IF ISNULL(@DivisionID, '') != '' 
			SET @sWhere = @sWhere + N' AND QCT2000.DivisionID IN ('''+@DivisionID+''') '
		IF ISNULL(@APK, '') != '' 
			SET @sWhere = @sWhere + N' AND QCT2001.APK IN ('''+@APK+''')'
		-- IF ISNULL(@BatchNo, '') != '' 
		-- 	SET @sWhere = @sWhere + N' AND QCT2001.BatchNo IN ('''+@BatchNo+''')'
		--DROP TABLE #Total_Standard
		DECLARE   @SQLQuery AS NVARCHAR(MAX)
		DECLARE   @SQLQuery1 AS NVARCHAR(MAX)
		DECLARE   @SQLQuery2 AS NVARCHAR(MAX)
		DECLARE  @PivotColumnsSQL  AS NVARCHAR(MAX)
		DECLARE  @PivotColumns AS  NVARCHAR(MAX)
		DECLARE @ParmDefinition NVARCHAR(MAX)
		--+'',''+ QUOTENAME(StandardID+''_UnitID'') 
		SET   @PivotColumnsSQL= 'SELECT @retvalOUT  = 
		COALESCE(@retvalOUT + '','','''') + QUOTENAME(StandardID) 
				FROM (
				select DISTINCT 
				QCT2002.StandardID,QCT1000.UnitID
				-- Phiếu nhập đầu ca
				from QCT2000 QCT2000
				join QCT2001  QCT2001 on QCT2001.APKMaster  = QCT2000.APK
				join QCT2002  QCT2002 on QCT2002.APKMaster  = QCT2001.APK
				join QCT1000  QCT1000 on QCT1000.StandardID  = QCT2002.StandardID
				where   QCT2000.DeleteFlg = 0 and QCT2001.DeleteFlg = 0 and QCT2002.DeleteFlg = 0 
				 '+@sWhere+ '
			) AS PivotExample'
		SET @ParmDefinition = N'@retvalOUT VARCHAR(max) OUTPUT'
		EXEC sp_executesql @PivotColumnsSQL,@ParmDefinition, @retvalOUT=@PivotColumns OUTPUT
		--SELECT @PivotColumnsSQL

		DECLARE  @PivotValue AS  VARCHAR(MAX)
		SET @PivotValue  = REPLACE(@PivotColumns,']','_Value]')
		--select @PivotUnits

		DECLARE  @PivotUnits AS  VARCHAR(MAX)
		SET @PivotUnits  = REPLACE(@PivotColumns,']','_UnitID]')
		--select @PivotUnits

		DECLARE  @Pivot_Target AS  VARCHAR(MAX)
		SET @Pivot_Target  = REPLACE(@PivotColumns,']','_Target]')
		--select @Pivot_Target

SET   @SQLQuery =  N'
			select * from(
			select 
			QCT2000.APK as QCT2000APK, QCT2000.ShiftID,HT1020.ShiftName,QCT2000.Status,QCT2000.VoucherNo as QCT2000VoucherNo, QCT2000.VoucherDate as QCT2000VoucherDate ,CONVERT(NVARCHAR(50), QCT2000.VoucherDate, 103) as Date,DATEPART(day, QCT2000.VoucherDate) as VoucherDay,DATEPART(month, QCT2000.VoucherDate) as VoucherMonth,DATEPART(YEAR, QCT2000.VoucherDate) as VoucherYear,
			QCT2000.MachineID, CIT1150.MachineName, QCT2001.InventoryID,AT1302.InventoryName,AT1302.UnitID,AT1302.Notes02 AS RawMaterial,QCT2001.BatchNo, QCT2001.GrossWeight, QCT2001.NetWeight,QCT2001.OtherQuantity , QCT2001.OtherUnitID,
			QCT2001.DParameter01, QCT2001.DParameter02,QCT2001.DParameter03,QCT2001.DParameter04,QCT2001.DParameter05,
			QCT2001.Notes02 AS STTKe, QCT2001.Notes03 AS STTrenKe,
			QCT2001.Description, QCT1020.Notes Notes00, QCT1020.Notes01, QCT1020.Notes02, QCT1020.Notes03,
			CONCAT(QCT2002.StandardID,''_Value'') StandardID, 
			(CASE WHEN T14.StandardName IS NULL THEN QCT2002.StandardValue ELSE T14.StandardName END) AS StandardValue
			-- Phiếu nhập đầu ca
			from QCT2000 QCT2000
			join QCT2001  QCT2001 on QCT2001.APKMaster  = QCT2000.APK
			join QCT2002  QCT2002 on QCT2002.APKMaster  = QCT2001.APK
			join QCT1000  QCT1000 on QCT1000.StandardID  = QCT2002.StandardID
			join AT1302  AT1302 on AT1302.InventoryID  = QCT2001.InventoryID
			Left join QCT1020  QCT1020 on QCT1020.InventoryID  = QCT2001.InventoryID
			Left join CIT1150  CIT1150 on CIT1150.MachineID  = QCT2000.MachineID
			Left join HT1020  HT1020 on HT1020.ShiftID  = QCT2000.ShiftID
			LEFT JOIN QCT1000 T14 ON QCT2002.StandardValue = T14.StandardID AND T14.TypeID = ''APPE''
			where   QCT2000.DeleteFlg = 0 and QCT2001.DeleteFlg = 0 and QCT2002.DeleteFlg = 0 
			 '+@sWhere+ '
			) APKVoucherDateInventory
			PIVOT(
				Max(StandardValue)
				FOR StandardID IN (
					 '+@PivotValue+' )
			) AS pivot_table_StandardID 
			join (select * from(
			select 
			QCT2000.APK as QCT2000APK_Unit, QCT2001.InventoryID as InventoryID_Unit, QCT2001.BatchNo as BatchNo_Unit,
			QCT2002.StandardID+''_UnitID'' as StandardIDUnitID, QCT1000.UnitID
			-- Phiếu nhập đầu ca
			from QCT2000 QCT2000
			join QCT2001  QCT2001 on QCT2001.APKMaster  = QCT2000.APK
			join QCT2002  QCT2002 on QCT2002.APKMaster  = QCT2001.APK
			join QCT1000  QCT1000 on QCT1000.StandardID  = QCT2002.StandardID
			where   QCT2000.DeleteFlg = 0 and QCT2001.DeleteFlg = 0 and QCT2002.DeleteFlg = 0 '
SET   @SQLQuery1 =  N' 
			'+@sWhere+ '
			) APKVoucherDateInventory
					PIVOT(
				Max(UnitID)
				FOR StandardIDUnitID IN (
					 '+@PivotUnits+' )
			) AS pivot_table_UnitID) pivot_table_UnitID on pivot_table_UnitID.QCT2000APK_Unit  = pivot_table_StandardID.QCT2000APK and pivot_table_UnitID.InventoryID_Unit =pivot_table_StandardID.InventoryID and pivot_table_UnitID.BatchNo_Unit =pivot_table_StandardID.BatchNo 
			join (select * from 
			(
			select QCT1020.InventoryID, StandardID+''_Target'' as StandardTarget , SRange03 from QCT1020  QCT1020
			join QCT1021 QCT1021 on QCT1021.APKMaster = QCT1020.APK
			join QCT2001 QCT2001 on QCT2001.InventoryID = QCT1020.InventoryID
			where CONVERT(NVARCHAR(50), QCT2001.APK) IN ('''+ISNULL(@APK,'')+''') )
			pivot_Standard_Target
			PIVOT(
			Max(SRange03) '
SET   @SQLQuery2 =  N'
			FOR StandardTarget IN (
				'+@Pivot_Target+')
			) AS pivot_Standard_Target) pivot_Standard_Target on pivot_Standard_Target.InventoryID = pivot_table_StandardID.InventoryID'
		print (@SQLQuery)
		print (@SQLQuery1)
		print (@SQLQuery2)
		EXEC (@SQLQuery + @SQLQuery1 + @SQLQuery2)





		