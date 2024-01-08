IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0549]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0549]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Load dữ liệu lưới Master màn hình kế thừa thống kê kết quả sản xuất (MAITHU)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Lê Hoàng, Date: 22/04/2021
----Update by: Nhật Thanh, Date: 04/04/2023: không hiển thị phiếu đã kế thừa hết + chỉ hiển thị phiếu đã tick xuất kho trên 9
/*-- <Example>
	HP0549 @DivisionID = 'VF', @StrDivisionID = '', @UserID = 'ASOFTADMIN', @TranMonth = 12, @TranYear = 2017, @DepartmentID = '', @TeamID = '', @EmployeeID = '', 
	@FromProductID = '', @ToProductID = ''

	HP0549 @DivisionID, @UserID, @StrDivisionID, @TranMonth, @TranYear, @DepartmentID, @TeamID, @EmployeeID, @FromProductID, @ToProductID
----*/

CREATE PROCEDURE HP0549
( 
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@StrDivisionID VARCHAR(4000), 
	@IsDate INT,
	@FromPeriod VARCHAR(50), 
	@ToPeriod VARCHAR(50), 
	@FromDate DATETIME,
	@ToDate DATETIME,
	@PhaseID VARCHAR(50)
)

AS 
DECLARE @sSQL NVARCHAR(MAX) = N'', 
		@sWhere NVARCHAR(MAX) = N''

IF ISNULL(@StrDivisionID, '') <> '' SET @sWhere = @sWhere + N' M1.DivisionID IN ('''+@StrDivisionID+''') '
ELSE SET @sWhere = @sWhere + N' M1.DivisionID = '''+@DivisionID+''' '

SET @sWhere = @sWhere + ' AND M1.DeleteFlg = 0 '

IF @IsDate = 0
BEGIN
	SET @sWhere = @sWhere + ' AND M1.TranMonth + M1.TranYear * 100 BETWEEN ' 
	+ STR(CONVERT(INT,LEFT(@FromPeriod,2)) + CONVERT(INT,RIGHT(@FromPeriod,4)) * 100)
	+ ' AND ' 
	+ STR(CONVERT(INT,LEFT(@ToPeriod,2)) + CONVERT(INT,RIGHT(@ToPeriod,4)) * 100)
END
ELSE
BEGIN
	SET @sWhere = @sWhere + ' AND CONVERT(NVARCHAR(50),M1.VoucherDate,101) BETWEEN ''' +CONVERT(NVARCHAR(50),@FromDate,101)+ ''' AND ''' +CONVERT(NVARCHAR(50),@ToDate,101)+ ''' '
END

IF ISNULL(@PhaseID, '') <> ''  SET @sWhere = @sWhere + N' AND M2.PhaseID LIKE N''%'+@PhaseID+'%'' '

SET @sWhere = @sWhere + N' AND H94.RefAPKDetail IS NULL'

SET @sSQL = N'
			SELECT DISTINCT M1.DivisionID, M1.APK, 0 Choose, M1.VoucherNo, M1.VoucherDate,  
				STUFF(( SELECT '','' + PhaseName
				        FROM AT0126 A26 WITH(NOLOCK) 
						LEFT JOIN MT2211 M02 WITH(NOLOCK) ON M02.PhaseID = A26.PhaseID
						WHERE M02.APKMaster = M1.APK
				        FOR XML PATH('''')
				        ), 1, 1, '''') PhaseName, 
				A1.FullName EmployeeName, M1.Description
			FROM MT2210 M1 WITH(NOLOCK)
			LEFT JOIN MT2211 M2 WITH(NOLOCK) ON M1.DivisionID = M2.DivisionID AND M1.APK = M2.APKMaster
			LEFT JOIN AT1103 A1 WITH(NOLOCK) ON M1.DivisionID IN (''@@@'',A1.DivisionID) AND M1.EmployeeID = A1.EmployeeID
			LEFT JOIN HT1904_MT H94 WITH(NOLOCK) ON M2.DivisionID = H94.DivisionID AND M2.APK = H94.RefAPKDetail AND M2.APKMaster = H94.RefAPKMaster
			WHERE ' + @sWhere + '
			AND ISNULL(M2.IsWarehouse,0)!=0 AND M2.Quantity-ISNULL((Select SUM(Quantity) from MT1001 where InheritTransactionID = M2.APK),0)>0'

PRINT @sSQL
EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
