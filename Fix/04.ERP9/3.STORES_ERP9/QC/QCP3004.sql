IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[QCP3004]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[QCP3004]
GO
/****** Object:  StoredProcedure [dbo].[QCP3004]    Script Date: 11/13/2020 8:49:25 AM ******/
-- <Summary>
---- Lấy dữ liệu báo cáo vận hành
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Create on 16/11/2020 by TAN TAI
----Modified by Le Hoang on 24/02/2021 : Sắp xếp theo ngày
----Modified on 13/05/2021 by Le Hoang: Bổ sung điều kiện lọc DepartmentID
----Modified on ... by ...
-- <Example>
---- 
/*-- <Example>
	EXEC [dbo].[QCP3004]
		@DivisionID = N'VNP',
		@UserID = N'HOANG',
		@Date = N'2020-11-16 20:00:00.000',
		@ShiftID = N'CA1',
		@DepartmentID = N'PX01',
		@MachineID = N'MAY01'
----*/

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[QCP3004]
( 
	 @DivisionID NVARCHAR(50),
	 @UserID NVARCHAR(50),
	 @Date NVARCHAR(50), 
	 @ToDate NVARCHAR(50) = null, 
	 @ShiftID VARCHAR(MAX),
	 @DepartmentID VARCHAR(MAX),
	 @MachineID VARCHAR(MAX)
)
AS 
DECLARE @sSQL NVARCHAR(MAX),
		@sWhere NVARCHAR(MAX) = N''
		SET @sWhere = ''
		IF ISNULL(@DivisionID, '') != '' 
			SET @sWhere = @sWhere + N' AND QCT2010.DivisionID IN ('''+@DivisionID+''') '
		--IF ISNULL(@Date, '') != '' 
		--	SET @sWhere = @sWhere + N' AND DATEDIFF(day,'''+@Date+''', QCT2010.VoucherDate )  =0   '	
		IF ISNULL(@Date, '') != '' AND ISNULL(@ToDate, '') = '' 
			SET @sWhere = @sWhere + N' AND QCT2010.VoucherDate >= '''+@Date+''' AND QCT2010.VoucherDate <= '''+SUBSTRING(@Date,0,11)+' 23:59:59'+''''
		IF ISNULL(@Date, '') != '' AND ISNULL(@ToDate, '') != '' 
			SET @sWhere = @sWhere + N' AND QCT2010.VoucherDate >= '''+@Date+''' AND QCT2010.VoucherDate <= '''+SUBSTRING(@ToDate,0,11)+' 23:59:59'+''''	
		IF ISNULL(@ShiftID, '') != '' 
			SET @sWhere = @sWhere + N' AND (QCT2000.ShiftID IN ('''+@ShiftID+''') OR QCT2010.InheritShift IN ('''+@ShiftID+'''))'
		IF ISNULL(@DepartmentID, '') != '' 
			SET @sWhere = @sWhere + N' AND CIT1150.DepartmentID IN ('''+REPLACE(@DepartmentID,',',''',''')+''')'
		IF ISNULL(@MachineID, '') != '' 
		BEGIN
			SET @sWhere = @sWhere + N' AND (QCT2000.MachineID IN ('''+@MachineID+''') OR QCT2010.InheritMachine IN ('''+@MachineID+'''))'
		END

		DECLARE   @SQLQuery AS NVARCHAR(MAX)
		DECLARE  @PivotColumnsSQL  AS NVARCHAR(MAX)
		DECLARE  @PivotColumns AS  NVARCHAR(MAX)
		DECLARE @ParmDefinition NVARCHAR(MAX)
		--+'',''+ QUOTENAME(StandardID+''_UnitID'') 
		SET   @PivotColumnsSQL= 'SELECT @retvalOUT= COALESCE(@retvalOUT + '','','''') + QUOTENAME(APKMasterVoucherDate)
		FROM ( SELECT MasterVoucherDate.VoucherDate, MasterVoucherDate.APKMasterVoucherDate FROM (
		select  DISTINCT  QCT2010.VoucherDate, convert(nvarchar(50), QCT2010.VoucherDate) +''/''+ convert(nvarchar(50), QCT2010.APK) as APKMasterVoucherDate
			-- Phiếu nhập đầu ca
			from QCT2010 QCT2010
			left join QCT2000 QCT2000 on QCT2010.APKMaster = QCT2000.APK
			left join QCT2002 QCT2002 on QCT2002.APKMaster = QCT2010.APK
			left join QCT1000 QCT1000 on QCT1000.StandardID = QCT2002.StandardID
			left join CIT1150 CIT1150 on CIT1150.MachineID = QCT2000.MachineID
			where QCT2010.VoucherType=''0'' and ISNULL(QCT2000.DeleteFlg,0) = 0 and QCT2002.DeleteFlg = 0 and QCT2010.DeleteFlg = 0
			'+@sWhere+ '
			) AS MasterVoucherDate) AS PivotExample
			ORDER BY PivotExample.VoucherDate ASC'
		SET @ParmDefinition = N'@retvalOUT NVARCHAR(max) OUTPUT'
		PRINT (@PivotColumnsSQL)
		EXEC sp_executesql @PivotColumnsSQL,@ParmDefinition, @retvalOUT=@PivotColumns OUTPUT
		IF @PivotColumns IS NULL 
			PRINT '1'

SET   @SQLQuery =  N'
		select *
		from(
		select convert(nvarchar(50), QCT2010.VoucherDate) +''/''+ convert(nvarchar(50), QCT2010.APK) as APKMasterVoucherDate, 
		 QCT2000.APK as QCT2000APK, 
		 CASE WHEN ISNULL(QCT2000.ShiftID,'''') = '''' THEN QCT2010.InheritShift ELSE QCT2000.ShiftID END ShiftID,
		 QCT2000.Status,QCT2000.VoucherNo as QCT2000VoucherNo, 
		 CASE WHEN ISNULL(QCT2000.VoucherDate,'''') = '''' THEN QCT2010.InheritDate ELSE QCT2000.VoucherDate END QCT2000VoucherDate,
		 CASE WHEN ISNULL(QCT2000.MachineID,'''') = '''' THEN QCT2010.InheritMachine ELSE CIT1150.MachineID END MachineID,
		 CASE WHEN ISNULL(QCT2000.MachineID,'''') = '''' THEN CIT11501.MachineName ELSE CIT1150.MachineName END MachineName,
		 CIT1150.DepartmentID,
		QCT2010.APK as QCT2010APK,QCT2010.VoucherType as QCT2010VoucherType,QCT2010.VoucherTypeID as QCT2010VoucherTypeID, QCT2010.VoucherNo as  QCT2010VoucherNo, QCT2010.VoucherDate as QCT2010VoucherDate, CONVERT(DATE, QCT2010.VoucherDate) as ReportDate,
		QCT2002.StandardID,QCT1000.StandardName , QCT2002.StandardValue
		-- Phiếu nhập đầu ca
		from QCT2010 QCT2010
		left join QCT2000  QCT2000 on QCT2010.APKMaster  = QCT2000.APK
		left join QCT2002  QCT2002 on QCT2002.APKMaster  = QCT2010.APK
		left join QCT1000  QCT1000 on QCT1000.StandardID  = QCT2002.StandardID
		left join CIT1150  CIT1150 on CIT1150.MachineID  = QCT2000.MachineID
		left join CIT1150  CIT11501 on CIT11501.MachineID  = QCT2010.InheritMachine
		where QCT2010.VoucherType=''0''  
		and ISNULL(QCT2000.DeleteFlg,0) = 0 and QCT2002.DeleteFlg = 0 and QCT2010.DeleteFlg = 0 '+ @sWhere +'
		) APKMasterVoucherDate
		PIVOT(
			Max(StandardValue)
			FOR APKMasterVoucherDate IN (
				 ' + @PivotColumns + ' )
		) AS pivot_table
		ORDER BY ReportDate'
		print (@SQLQuery)
		EXEC sp_executesql @SQLQuery






		