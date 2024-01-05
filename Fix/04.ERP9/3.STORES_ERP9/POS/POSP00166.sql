IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP00166]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POSP00166]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO









-- <Summary>
--- Load grid màn hình Xem nhanh tồn kho
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Cao thị Phượng vu on 31/10/2017
----Edited by:  Tra Giang on 29/11/2018 : Bổ sung truyền biến VoucherDate (Ngày lập phiếu bán hàng) load xem nhanh hàng tồn kho.
----Edited by:  Tra Giang on 07/12/2018 : fix lỗi số liệu hàng trên đường đi bị sai số liệu.
----Edited by:  Tra Giang on 21/02/2019 : Lấy thông tin số lượng hàng từ bảng thay cho loại chứng từ, lọc kho theo UserID đăng nhập 
----Edited by:  Tra Giang on 09/04/2019 : Bổ sung check toàn hệ thống hiển thị search thông tin % mặt hàng có ở các kho(ATTOM)
----Edited by:  Tan Phu on 01/11/2019 : Bổ sung search theo mã, màu, size cho khách hàng ATTOM
----Edited by:  Thanh Luan on 02/11/2019 : Fix search theo mã ATTOM.
----Example: EXEC POSP00166 'MSA', 'ALIADTPA3800TD', '', 'NN', 'DD', 'XB', 'PHUONG', 1, 20
/*
exec POSP00166 @InventoryID=N'AB101.1.34',@DivisionID=N'AT',@WareHouseID=N'HGB.CNYB',@VoucherType01=N'BC0',
@VoucherType13=N'CL0',@VoucherType09=N'BH2',@UserID=N'AS',@PageNumber=1,@PageSize=25, @VoucherDate='2018-12-29 11:53:42.933'*/

 CREATE PROCEDURE POSP00166 (
		 @DivisionID	VARCHAR(50),
		 @InventoryID	NVARCHAR(50),
		 @WareHouseID	NVARCHAR(50),
		 @VoucherType01 NVARCHAR(50),
		 @VoucherType13 NVARCHAR(50),
		 @VoucherType09 NVARCHAR(50),
		 @UserID		NVARCHAR(50),	
		 @VoucherDate   DATETIME ,	
		 @PageNumber	INT,
		 @PageSize		INT,
		 @IsAllWarehouse TINYINT = 0, -- 0:không check, 1: check 
		 @Color NVARCHAR(50) = NULL, -- Customize ATTOM
		 @Size  NVARCHAR(50) = NULL -- Customize ATTOM
		)
AS
	DECLARE
		 @sSQL NVARCHAR(4000),
		@sSQL1 NVARCHAR(4000),
		@sSQL2 NVARCHAR(4000),
		@sSQL33 NVARCHAR(4000),
		@sSQL3 NVARCHAR(4000),
		@sSQL4 NVARCHAR(4000),
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500),
		@CustomerName NVARCHAR(4000)
SET @CustomerName = ( SELECT CustomerName FROM CustomerIndex )

SET @sWhere = ' = N'''+@InventoryID+''''

-- Trường hơp customize cho ATTOM
IF @CustomerName = 98
BEGIN 
	--IF @InventoryID = '' SET @InventoryID = '%';
	--IF @Color = '' SET @Color = '%';
	--IF @Size = '' SET @Size = '%';

	--SET @sWhere = ' LIKE N'''+CONCAT(ISNULL(@InventoryID, '%'),'%.',ISNULL(@Color, '%'),'.',ISNULL(@Size, '%'))+''''
	if ISNULL(@Size, '')=''
	SET @sWhere = ' LIKE N'''+CONCAT('%', ISNULL(@InventoryID, ''), '%.', '%', ISNULL(@Color, ''), '%')+''''
	else
	SET @sWhere = ' LIKE N'''+CONCAT('%', ISNULL(@InventoryID, ''), '%.', '%', ISNULL(@Color, ''), '%.', '%', ISNULL(@Size, ''), '%')+''''
	--SELECT @sWhere
END

	SET @OrderBy = ' B.WareHouseID'


	--Check Para DivisionIDList null then get DivisionID 
	
	SET @sSQL = '
		Select B.DivisionID, B.InventoryID, B.WareHouseID, Isnull(Sum(B.ExportQuantity - B.ImportQuantity),0) as EndQuantity 
		, P.PQuantity as PQuantity,P.SQuantity as SQuantity
		Into #POST00165Temp
		FROM (Select Sum(Quantity) ExportQuantity, 0.0 as  ImportQuantity, WareHouseID, InventoryID, DivisionID
			From POST9000  WITH (NOLOCK)
			Where DivisionID = '''+@DivisionID+''' and InventoryID '+ @sWhere +'
				and TableID in (''POST0038'', ''POST0015'') 
			and VoucherDate <= GETDATE() and DeleteFlg = 0
			Group by ShopID, DivisionID, WareHouseID, InventoryID
			Union all
			Select  0.0 as ExportQuantity, Sum(Quantity) ImportQuantity, WareHouseID, InventoryID, DivisionID
			From POST9000 WITH (NOLOCK)
			Where DivisionID = '''+ @DivisionID+''' and InventoryID '+ @sWhere +'
				and TableID in (''POST0027'') 
			and VoucherDate <= GETDATE() and DeleteFlg = 0
			Group by ShopID, DivisionID, WareHouseID, InventoryID) B
		LEFT JOIN
		( Select x.DivisionID,  x.InventoryID, x.UnitID, x.WareHouseID, sum(x.FromMovingQuantity) as PQuantity, sum(x.ToMovingQuantity) as SQuantity
		  From
			(Select M.DivisionID,  D.InventoryID, D.UnitID, M.WareHouseID
			, Sum(Isnull(D.ActualQuantity,0) - isnull(D.ReceiveQuantity,0)) as FromMovingQuantity
			, 0 as ToMovingQuantity
			from WT0095 M inner join WT0096 D on M.DivisionID = D.DivisionID and M.VoucherID = D.VoucherID
			Where M.DivisionID = '''+@DivisionID+'''  and M.IsCheck = 1 and (D.Status = 0 OR D.Status is null) and D.InventoryID '+ @sWhere +'
			Group by M.DivisionID, D.InventoryID, D.UnitID, M.WareHouseID
			union all
			Select  M.DivisionID, D.InventoryID, D.UnitID, M.WareHouseID2 as WareHouseID
			, 0 as FromMovingQuantity
			, Sum(Isnull(D.ActualQuantity,0) - isnull(D.ReceiveQuantity,0)) as ToMovingQuantity
			from WT0095 M inner join WT0096 D on M.DivisionID = D.DivisionID and M.VoucherID = D.VoucherID and D.InventoryID '+ @sWhere +'
			Where M.DivisionID = '''+@DivisionID+''' and M.IsCheck = 1 and (D.Status = 0 OR D.Status is null)
			Group by M.DivisionID, D.InventoryID, D.UnitID, M.WareHouseID2 
			) x
			Group by x.DivisionID, x.InventoryID, x.UnitID, x.WareHouseID
		) P on P.DivisionID = B.DivisionID and P.InventoryID = B.InventoryID and P.WareHouseID = B.WareHouseID
		WHERE B.DivisionID = '''+ @DivisionID+''' and B.InventoryID '+ @sWhere +'
		Group by  B.DivisionID, B.InventoryID, B.WareHouseID, P.PQuantity,P.SQuantity'
SET @sSQL1=N' 
	Union ALL 
		SELECT A.DivisionID, A.InventoryID, A.WareHouseID, isnull(Sum(DebitQuantity - CreditQuantity), 0) as EndQuantity, Sum(P.PQuantity) as PQuantity, sum(P.SQuantity) SQuantity FROM 
		(Select 	AV7000.DivisionID, AV7000.InventoryID, AV7000.WareHouseID,	
			Sum(Case when D_C = ''D'' then isnull(AV7000.ActualQuantity,0) else 0 end) as DebitQuantity,
			Sum(Case when D_C = ''C'' then isnull(AV7000.ActualQuantity,0) else 0 end) as CreditQuantity From AV7000 
			Where AV7000.DivisionID = ''' + @DivisionID + ''' and
			(AV7000.WareHouseID in (Select Distinct  ComWareHouseID From POST0010 With (NOLOCK) Where DivisionID = ''' + @DivisionID + '''))  And
			AV7000.InventoryID '+ @sWhere +' and VoucherDate <= '''+CONVERT(VARCHAR,@VoucherDate,120)+'''
			Group by  AV7000.DivisionID, AV7000.InventoryID, AV7000.WareHouseID) A
		LEFT JOIN
		( Select x.DivisionID,  x.InventoryID, x.UnitID, x.WareHouseID, sum(x.FromMovingQuantity) as PQuantity, sum(x.ToMovingQuantity) as SQuantity
		  From	(Select M.DivisionID,  D.InventoryID, D.UnitID, M.WareHouseID2 as WareHouseID
			, Sum(Isnull(D.ActualQuantity,0) - isnull(D.ReceiveQuantity,0)) as FromMovingQuantity
			, 0 as ToMovingQuantity
			from WT0095 M inner join WT0096 D on M.DivisionID = D.DivisionID and M.VoucherID = D.VoucherID
			Where M.DivisionID = '''+@DivisionID+'''  and M.IsCheck = 1 and (D.Status = 0 OR D.Status is null) and D.InventoryID '+ @sWhere +'
			and M.WareHouseID2 in (Select Distinct  ComWareHouseID From POST0010 With (NOLOCK) Where DivisionID = ''' + @DivisionID + ''')
			Group by M.DivisionID, D.InventoryID, D.UnitID, M.WareHouseID2
			union all
			Select  M.DivisionID, D.InventoryID, D.UnitID, M.WareHouseID, 0 as FromMovingQuantity
			, Sum(Isnull(D.ActualQuantity,0) - isnull(D.ReceiveQuantity,0)) as ToMovingQuantity
			from WT0095 M inner join WT0096 D on M.DivisionID = D.DivisionID and M.VoucherID = D.VoucherID
			Where M.DivisionID = '''+@DivisionID+''' and M.IsCheck = 1 and (D.Status = 0 OR D.Status is null) and D.InventoryID '+ @sWhere +'
			and M.WareHouseID in (Select Distinct  ComWareHouseID From POST0010 With (NOLOCK) Where DivisionID = ''' + @DivisionID + ''')
			Group by M.DivisionID, D.InventoryID, D.UnitID, M.WareHouseID) x
			Group by x.DivisionID, x.InventoryID, x.UnitID, x.WareHouseID
		) P on P.DivisionID = A.DivisionID and P.InventoryID = A.InventoryID and P.WareHouseID = A.WareHouseID
		WHERE A.DivisionID = '''+ @DivisionID+''' and A.InventoryID '+ @sWhere +'
		Group by A.DivisionID, A.InventoryID, A.WareHouseID
		'
	SET @sSQL3='	
		SELECT distinct WareHouseID,ComWarehouseID,DisplayWareHouseID,BrokenWareHouseID 
		INTO #TAMP1
			FROM POST0010 P10 WITH (NOLOCK)
			INNER JOIN POST0026 P26 WITH (NOLOCK) ON P10.DivisionID =P26.DivisionID AND P10.ShopID=P26.ShopID 
			WHERE P26.EmployeeID='''+@UserID+''''
SET @sSQL33='	
		SELECT distinct WareHouseID,'''' as ComWarehouseID,DisplayWareHouseID,BrokenWareHouseID 
		INTO #TAMP1
			FROM POST0010 P10 WITH (NOLOCK)
			INNER JOIN POST0026 P26 WITH (NOLOCK) ON P10.DivisionID =P26.DivisionID AND P10.ShopID=P26.ShopID 
			WHERE P26.EmployeeID='''+@UserID+''' and P10.WareHouseID = '''+@WareHouseID+''''
	
	SET @sSQL2='	
	DECLARE @count int
		Select @count = Count(WareHouseID) From #POST00165Temp
	SELECT 	ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, @count AS TotalRow
				, B.DivisionID, B.InventoryID, A.InventoryName, B.WareHouseID, C.WareHouseName
				, B.EndQuantity, isnull(B.PQuantity,0) PQuantity , isnull(B.SQuantity,0) as SQuantity
				FROM #POST00165Temp B
		LEFT JOIN AT1302 A WITH (NOLOCK) ON A.InventoryID = B.InventoryID
		LEFT JOIN AT1303 C WITH (NOLOCK) ON B.WareHouseID = C.WareHouseID
		where B.WareHouseID in (	SELECT WareHouseID AS WareHouseID FROM #TAMP1 WHERE ISNULL(WareHouseID,'''') <> ''''
									UNION ALL
									SELECT ComWarehouseID AS WareHouseID FROM #TAMP1 WHERE ISNULL(ComWarehouseID,'''') <> ''''
									UNION ALL
									SELECT DisplayWareHouseID AS WareHouseID FROM #TAMP1 WHERE ISNULL(DisplayWareHouseID,'''') <> ''''
									UNION ALL
									SELECT BrokenWareHouseID AS WareHouseID FROM #TAMP1 WHERE ISNULL(BrokenWareHouseID,'''') <> ''''	)
		ORDER BY '+@OrderBy+ '
		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
	
		SET @sSQL4='	
	DECLARE @count int
		Select @count = Count(WareHouseID) From #POST00165Temp
	SELECT 	ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, @count AS TotalRow
				, B.DivisionID, B.InventoryID, A.InventoryName, B.WareHouseID, C.WareHouseName
				, B.EndQuantity, isnull(B.PQuantity,0) PQuantity , isnull(B.SQuantity,0) as SQuantity
				FROM #POST00165Temp B
		LEFT JOIN AT1302 A WITH (NOLOCK) ON A.InventoryID = B.InventoryID
		LEFT JOIN AT1303 C WITH (NOLOCK) ON B.WareHouseID = C.WareHouseID
		ORDER BY '+@OrderBy+ '
		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '

-- Trường hơp customize cho ATTOM
IF @CustomerName = 98
BEGIN 
	-- Trường hợp search all kho
	IF 	@IsAllWarehouse = 0
		EXEC (@sSQL + @sSQL1 +@sSQL33 +@sSQL2)
	ELSE
		 EXEC (@sSQL + @sSQL1 +@sSQL4)  
END
ELSE
	EXEC (@sSQL + @sSQL1 +@sSQL3 +@sSQL2)
	--Print (@sSQL)
	--Print (@sSQL1)
	--Print (@sSQL3)
	--Print (@sSQL2)


 










GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

