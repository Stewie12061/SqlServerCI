IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP3087]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POSP3087]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Báo cáo doanh số dịch vụ cửa hàng và nhân viên
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Kiều Nga, Date: 22/11/2019
----Modify by Kiều Nga , Date: 24/06/2020: Bổ sung cột Còn phải thu, dòng SUm tổng theo cửa hàng.
-- <Example> 

CREATE PROCEDURE POSP3087 
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
			SET @sWhere = @sWhere + ' PT50.DivisionID IN ('''+ @DivisionID+''')'
		Else 
			SET @sWhere = @sWhere + ' PT50.DivisionID IN ('''+@DivisionIDList+''')'

		IF @IsDate = 1	
			SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR,PT50.VoucherDate,112) BETWEEN '''+CONVERT(VARCHAR,@FromDate,112)+''' AND '''+CONVERT(VARCHAR,@ToDate,112)+''''
		ELSE
			SET @sWhere = @sWhere + ' AND (Case When  Month(PT50.VoucherDate) <10 then ''0''+rtrim(ltrim(str(Month(PT50.VoucherDate))))+''/''+ltrim(Rtrim(str(Year(PT50.VoucherDate)))) Else rtrim(ltrim(str(Month(PT50.VoucherDate))))+''/''+ltrim(Rtrim(str(Year(PT50.VoucherDate)))) End) IN ('''+@PeriodIDList+''')'

		IF Isnull(@ShopIDList,'') = ''
			SET @sWhere = @sWhere + ' And PT50.ShopID IN ('''+@ShopID+''')'
		Else 
			SET @sWhere = @sWhere + ' And PT50.ShopID IN ('''+@ShopIDList+''')'
				
		IF Isnull(@ListInventoryID, '')<> ''
			SET @sWhere = @sWhere + ' AND PT51.ServiceID IN ('''+@ListInventoryID +''')'

		IF Isnull(@ListEmployeeID, '')<> ''
		   	SET @sWhere = @sWhere + ' AND PT50.CreateUserID IN ('''+@ListEmployeeID +''')'

		SET @sSQL1 = 'SELECT PT50.CreateUserID AS EmployeeID ,A03.FullName AS EmployeeName,PT50.ShopID,PT10.ShopName,PT50.VoucherDate, PT50.VoucherNo,PT50.MemberID,P0011.MemberName,PT51.ServiceID,PT51.ServiceName,PT51.UnitID,
		ISNULL(PT51.ActualQuantity,0) AS ActualQuantity,ISNULL(PT51.UnitPrice,0) AS UnitPrice,ISNULL(PT51.Amount,0) AS Amount,A.InventoryAmount,A.TotalAmount,ISNULL(A.InventoryAmount,0) - ISNULL(A.TotalAmount,0) as DebitAmount
FROM POST2050 PT50 WITH (NOLOCK)
LEFT JOIN POST2051 PT51 WITH (NOLOCK) ON PT50.APK = PT51.APKMaster
LEFT JOIN POST0011 P0011 WITH (NOLOCK) ON PT50.MemberID = P0011.MemberID
LEFT JOIN AT1103 A03 WITH (NOLOCK)  ON PT50.CreateUserID = A03.EmployeeID
LEFT JOIN POST0010 PT10 WITH (NOLOCK) ON PT50.ShopID = PT10.ShopID
LEFT JOIN(
			SELECT PT50.VoucherNo,ISNULL(PT82.Amount,0) as TotalAmount, ISNULL(SUM(PT51.Amount),0) as InventoryAmount
			FROM POST2050 PT50 WITH (NOLOCK)
			LEFT JOIN POST2051 PT51 WITH (NOLOCK) ON PT50.APK = PT51.APKMaster
			LEFT JOIN POST00802 PT82 WITH (NOLOCK) ON PT50.APK = PT82.APKMInherited
			Group by PT50.VoucherNo,ISNULL(PT82.Amount,0)) 
A ON A.VoucherNo = PT50.VoucherNo
Where '+@sWhere+
'Order by PT50.ShopID,PT50.CreateUserID,PT50.VoucherNo'

EXEC(@sSQL1)

print @sSQL1
END		

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
