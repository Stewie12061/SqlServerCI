IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP00221]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[POSP00221]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- <Summary>
----  Load detail cho form ke thua nhieu phieu nhập
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---
---Created by: Cap Thị Phượng Date 08/09/2017
----Modified by Thị Phượng Date 22/03/2018: Bổ sung order by them Orders (STT)
---Edited by:
---purpose: Filter dữ liệu vào lưới Detail
---	Exec POSP00221 'KC', '06d8088b-2179-46e9-95f4-c042616d7d70', 'PHUONG', 1, 25

Create PROCEDURE POSP00221
(
    @DivisionID VARCHAR(50),
    @APKList VARCHAR(MAX),
	@UserID  VARCHAR(50),	 --Biến môi trường
	@PageNumber INT,		
	@PageSize INT			 --Biến môi trường
)
AS
Begin
			DECLARE @sSQL NVARCHAR(MAX),
			@sWhere AS NVARCHAR(4000),
			@OrderBy NVARCHAR(500),
			@TotalRow NVARCHAR(50)
	SET @sWhere = ' '
	SET @TotalRow = ''
	SET @OrderBy = ' D.OrderNo '

	IF @PageNumber = 1 
		SET @TotalRow = 'COUNT(*) OVER ()' 
	ELSE 
		SET @TotalRow = 'NULL'


	IF Isnull(@DivisionID, '') != ''
		SET @sWhere = @sWhere + ' M.DivisionID ='''+@DivisionID+''''
		
	IF Isnull(@APKList, '') != ''
		SET @sWhere = @sWhere + ' And M.VoucherID IN ('''+@APKList+''')'
		
		SET @sSQL = 'Select ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow
						, 0 AS RowNo, D.APK ,Cast(D.APK as Varchar(50)) TransactionID, Cast(D.APKMaster as Varchar(50)) VoucherID, M.DivisionID, M.VoucherNo
								,B.InventoryTypeID, D.InventoryID, B.InventoryName, D.UnitID, E.UnitName ,Isnull(D.ActualQuantity,0) as ActualQuantity
							, D.EVoucherNo as Notes, 
								Case When B.MethodID = 3 then D.UnitPrice 
								When B.MethodID not in (3, 1) then (Select  isnull(A.UnitPrice, 0) as UnitPrice From
												(Select M.TranYear, M.TranMonth, A.DivisionID,  A.InventoryID , M.UnitPrice , P10.ShopID
												From AT2008 M With (NOLOCK) Inner join AT1302 A  With (NOLOCK) on M.InventoryID = A.InventoryID and A.MethodID not in (1,3)
												Inner join POST0010 P10 With (NOLOCK) on M.DivisionID = P10.DivisionID  and M.WareHouseID = P10.WareHouseID 
												INNER JOIN (Select  Max(M.TranYear) as TranYear, Max(M.TranMonth) as TranMonth, M.DivisionID, M.InventoryID 
												From AT2008 M With (NOLOCK) 
												Group by M.DivisionID, M.InventoryID  )B 
												ON B.DivisionID = M.DivisionID  and B.InventoryID = M.InventoryID and B.TranYear = M.TranYear and M.TranMonth = B.TranMonth)A
												WHERE  A.ShopID = D.ShopID AND A.InventoryID = D.InventoryID) End as UnitPrice
						, D.OrderNo 
					     From POST0015 M With (NOLOCK) inner join POST00151 D With (NOLOCK) On M.DivisionID = D.DivisionID and M.APK = D.APKMaster AND D.DeleteFlg = M.DeleteFlg
										inner join AT1302 B With (NOLOCK) on D.InventoryID = B.InventoryID
										Left join AT1304 E With (NOLOCK) on D.UnitID = E.UnitID
						WHERE '+@sWhere+' 
						ORDER BY '+@OrderBy+'
						OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
						FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
					  
		Exec (@sSQL) 
		Print (@sSQL)
End

