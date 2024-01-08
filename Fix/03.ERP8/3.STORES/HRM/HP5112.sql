IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP5112]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP5112]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




---- Created by Nhật Quang, Date 20/12/2022  
---- Purpose: HIPC - In báo cáo lương sản phẩm theo phương pháp chỉ định 
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
---- Modified by Đức Tuyên on 21/06/2023: Điều chỉnh báo cáo lương theo sản phẩm HIPC.
---- Modified by Viết Toàn on [08/08/2023]: tính ProductTime và SBProduction theo phiếu dự toán

---- <Example>
---- EXEC HP5112 @DivisionID=N'HIP',@TranMonth=12,@TranYear=2022,@DepartmentID=N'%',@TeamID=N'%',@EmployeeID=N'%',@StrDivisionID=N'HIP', @FromDate=N'12/9/2022 3:57:52 PM',@ToDate=N'12/21/2022 3:57:52 PM'
 
 
CREATE PROCEDURE [dbo].[HP5112] 
	@DivisionID NVARCHAR(50),
	@FromDate NVARCHAR(50),
	@ToDate NVARCHAR(50),
	@TranMonth INT,  
	@TranYear INT,
	@DepartmentID NVARCHAR(50),  
	@TeamID NVARCHAR(50),
	@EmployeeID NVARCHAR(50),
	@StrDivisionID AS NVARCHAR(4000) = ''
AS  
  
DECLARE @sSQL VARCHAR(MAX),
		@StrDivisionID_New AS NVARCHAR(4000)

SET @StrDivisionID_New = ''

IF ISNULL(@StrDivisionID,'') <> ''
	SELECT @StrDivisionID_New = CASE WHEN @StrDivisionID = '%' THEN ' LIKE ''' + 
	@StrDivisionID + '''' ELSE ' IN (''' + REPLACE(@StrDivisionID, ',',''',''') + ''')' END
ELSE
	SELECT @StrDivisionID_New = ' = ''' + @DivisionID + ''''

SET @sSQL = 'SELECT HT87.*
					, ''W'' + CONVERT(VARCHAR,DATEPART(WEEK, CONVERT(DATE,HT87.TrackingDate)) - DATEPART(WEEK, DATEADD(MM, DATEDIFF(MM,0,CONVERT(DATE,HT87.TrackingDate)), 0)) + 1) AS Week
					, LTRIM(RTRIM(ISNULL(HT00.LastName,'''')))+ '' '' + LTRIM(RTRIM(ISNULL(HT00.MiddleName,''''))) + '' '' + LTRIM(RTRIM(ISNULL(HT00.FirstName,''''))) AS FullName
					, DATENAME(dw,HT87.TrackingDate) AS TrackingDateName, AT1102.DepartmentName, HT1101.TeamName, HT1020.ShiftName, HT1015.ProductID AS ProductName, OA02.OrderQuantity, HT1015.UnitPrice, AT02.ObjectName
					, HT87.Quantity
					, ISNULL((ISNULL(OA02.OriginalQuantityProduct, 0)/NULLIF(C14.Quantity, 0)) * 1.25, 0) AS SetUpTime
					, ISNULL(OA01.AbsentHour,0) AS AbsentHour
					, ISNULL(( ISNULL(HT87.Quantity, 0) / NULLIF((ISNULL(OA02.OriginalQuantityProduct, 0)/NULLIF(C14.Quantity, 0)) * 1.25, 0)) , 0)  AS ProductionTime
					, CONVERT(DECIMAL(28,8), ROUND((HT24.BaseSalary*12/52/44.5),0)) AS Rate
					, ISNULL(ISNULL(( ISNULL(HT87.Quantity, 0) / NULLIF((ISNULL(OA02.OriginalQuantityProduct, 0)/NULLIF(C14.Quantity, 0)) * 1.25, 0)) , 0) * CONVERT(DECIMAL(28,8), ROUND((HT24.BaseSalary*12/52/44.5),0)), 0) AS SBProduction
					, OA02.VoucherNo AS VoucherNo_DT, OA02.APK_BomVersion
			FROM HT0287 HT87  WITH (NOLOCK) 
			INNER JOIN HT1400 HT00 WITH (NOLOCK) ON HT87.DivisionID = HT00.DivisionID And HT87.EmployeeID = HT00.EmployeeID
			INNER JOIN AT1102  WITH (NOLOCK) ON HT87.DepartmentID = AT1102.DepartmentID
			LEFT JOIN HT1101  WITH (NOLOCK) ON HT87.DivisionID = HT1101.DivisionID And HT87.TeamID = HT1101.TeamID
			LEFT JOIN HT1020  WITH (NOLOCK) ON HT87.DivisionID = HT1020.DivisionID And HT87.ShiftID = HT1020.ShiftID
			LEFT JOIN HT1015  WITH (NOLOCK) ON HT87.DivisionID = HT1015.DivisionID And HT87.ProductID = HT1015.ProductID	
			LEFT JOIN OT2001 OT21 WITH (NOLOCK) ON OT21.DivisionID = HT87.DivisionID AND OT21.VoucherNo = HT87.VoucherNo  
			LEFT JOIN AT1202 AT02 WITH (NOLOCK) ON AT02.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT02.ObjectID = OT21.ObjectID  

			OUTER APPLY (SELECT SUM(AbsentAmount) AS AbsentHour
						 FROM HT2401 HT07 WITH (NOLOCK)
						 WHERE  HT07.DivisionID = HT87.DivisionID AND HT07.EmployeeID = HT87.EmployeeID
												 AND CONVERT(DATE,HT07.AbsentDate) = CONVERT(DATE,HT87.TrackingDate) AND HT07.AbsentTypeID NOT IN (''N.ANDEM'',''N.NKP'')
						) OA01

			OUTER APPLY (SELECT TOP 1 CRMT10.*, OT22.OrderQuantity FROM OT2002 OT22 WITH (NOLOCK)
							INNER JOIN OT2102 OT102 WITH (NOLOCK) ON OT102.DivisionID = OT22.DivisionID AND OT22.InheritTransactionID = OT102.APK  
							INNER JOIN CRMT2110  CRMT10 WITH (NOLOCK) ON CRMT10.DivisionID = OT22.DivisionID AND OT102.InheritTransactionID = CRMT10.APK
							WHERE OT22.DivisionID = OT21.DivisionID AND OT22.SOrderID = OT21.SOrderID AND OT22.InventoryID = HT1015.ProductID
			) OA02
			LEFT JOIN CRMT2114 C14 WITH (NOLOCK) ON C14.DivisionID = HT87.DivisionID AND C14.APKMaster = OA02.APK AND HT87.PhaseID = C14.MaterialID
			LEFT JOIN HT2400 HT24 WITH (NOLOCK) ON HT24.DivisionID = HT87.DivisionID AND HT24.EmployeeID = HT87.EmployeeID
												 AND HT24.TranMonth = HT87.TranMonth AND HT24.TranYear = HT87.TranYear
			WHERE HT87.DivisionID ' +@StrDivisionID_New+ '
			
			AND CONVERT(DATE, HT87.TrackingDate, 103) BETWEEN '''+ CONVERT(VARCHAR(10), CONVERT(DATE,@FromDate,103))+''' AND '''+ CONVERT(VARCHAR(10), CONVERT(DATE,@ToDate,103))+'''
			AND HT87.DepartmentID LIKE ''' + @DepartmentID + ''' AND HT87.TeamID LIKE ''' + @TeamID + '''
			AND HT87.EmployeeID LIKE ''' + @EmployeeID + '''
			ORDER BY HT87.DivisionID, HT87.DepartmentID, HT87.TeamID, HT87.TrackingDate, HT87.ShiftID, HT87.EmployeeID, HT87.ProductID

'
PRINT(@sSQL)
EXEC(@sSQL)		



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO