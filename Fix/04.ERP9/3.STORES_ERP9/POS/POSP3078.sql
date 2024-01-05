IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP3078]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POSP3078]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Báo cáo hoa hong nhan vien => VUONSACH => báo cáo hoa hồng nhân viên theo điểm => NHANNGOC
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by:Trà Giang, Date: 29/06/2018
----Editted by:Hoàng Vũ, Date: 16/04/2019: Load thêm trường để phân biết điểm các loại nhân viên liên quan đến phiếu bán hàng
----Editted by:Hoàng Vũ, Date: 10/06/2019: Tách customize vườn sạch và nhân ngọc, sửa lại lấy số liệu theo mẫu mới  
----Editted by:Hoàng Vũ, Date: 03/07/2019: Fixbug update dữ liệu Dev lưu sai kiểu dữ liệu cho 4 trường Notes01, Notes02, Notes03, Notes04 là chữ null, vì đối với nhân ngọc 4 trường này lưu kiểu số không phải kiểu chuỗi
----Editted by:Kiều Nga, Date: 18/05/2020: Fixbug không hiển thị tên nhân viên
-- <Example> exec  POSP3078 @DivisionID=N'NN',@DivisionIDList='NN',@ShopID=N'SHOPNN_HCM',@ShopIDList='SHOPNN_HCM'',''SHOPNN_HCM'',''SHOPNN_HCM',@IsDate=0,@FromDate='',@ToDate='',@PeriodIDList='01/2019',@ToEmployeeID=null,@FromEmployeeID=null,@FromInventoryID=null,@ToInventoryID=null

CREATE PROCEDURE POSP3078 
(
	--@APK			VARCHAR(50),
	@DivisionID			VARCHAR(50),
	@DivisionIDList		NVARCHAR(MAX),
	@ShopID				VARCHAR(50),
	@ShopIDList			NVARCHAR(MAX),
	@IsDate				TINYINT,  --1: Theo ngày; 0: Theo kỳ
	@FromDate			DATETIME, 
	@ToDate				DATETIME, 
	@PeriodIDList		NVARCHAR(2000),
	@ToEmployeeID			VARCHAR(MAX)='',
	@FromEmployeeID		VARCHAR(MAX)='',
	@FromInventoryID	NVARCHAR(MAX) ='',
	@ToInventoryID		VARCHAR(MAX) ='',
	@ListInventoryID		VARCHAR(MAX) ='',
	@ListEmployeeID		VARCHAR(MAX) =''
)
AS
BEGIN
		DECLARE @sSQL1   NVARCHAR(MAX),  
				@sSQL2   NVARCHAR(MAX),  
				@sSQL22   NVARCHAR(MAX),  
			    @sSQL3   NVARCHAR(MAX),  
				@sSQL4   NVARCHAR(MAX),  
				@sSQL5   NVARCHAR(MAX),  
				@sWhere NVARCHAR(MAX),
				@sWhereEmployeeID NVARCHAR(MAX)
				
		DECLARE @CustomerName INT
	
		CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
		INSERT #CustomerName EXEC AP4444
		SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)
		
		SET @sSQL1 = ''
		SET @sSQL2 = ''
		SET @sSQL22 = ''
		SET @sSQL3 = ''
		SET @sSQL4 = ''
		SET @sSQL5 = ''
				
		SET @sWhere = ''
		SET @sWhereEmployeeID = ''

		IF @IsDate = 1	
			SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR,M.VoucherDate,112) BETWEEN '''+CONVERT(VARCHAR,@FromDate,112)+''' AND '''+CONVERT(VARCHAR,@ToDate,112)+''''
		ELSE
			SET @sWhere = @sWhere + ' AND (Case When  M.TranMonth <10 then ''0''+rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) Else rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) End) IN ('''+@PeriodIDList+''')'

		IF Isnull(@DivisionIDList,'') = ''
			SET @sWhere = @sWhere + ' AND M.DivisionID IN ('''+ @DivisionID+''')'
		Else 
			SET @sWhere = @sWhere + ' AND M.DivisionID IN ('''+@DivisionIDList+''')'

		IF Isnull(@ShopIDList,'') = ''
			SET @sWhere = @sWhere + ' And M.ShopID IN ('''+@ShopID+''')'
		Else 
			SET @sWhere = @sWhere + ' And M.ShopID IN ('''+@ShopIDList+''')'
				
		 --Search theo vật tư 
		IF Isnull(@FromInventoryID, '')!= '' and Isnull(@ToInventoryID, '') = ''
			SET @sWhere = @sWhere + ' AND D.InventoryID > = N'''+@FromInventoryID +''''
		ELSE IF Isnull(@FromInventoryID, '') = '' and Isnull(@ToInventoryID, '') != ''
			SET @sWhere = @sWhere + ' AND D.InventoryID < = N'''+@ToInventoryID +''''
		ELSE IF Isnull(@FromInventoryID, '') != '' and Isnull(@ToInventoryID, '') != ''
			SET @sWhere = @sWhere + ' AND D.InventoryID Between N'''+@FromInventoryID+''' AND N'''+@ToInventoryID+''''       
        
		--Search theo nhan vien
		IF Isnull(@FromEmployeeID, '')!= '' and Isnull(@ToEmployeeID, '') = ''
			SET @sWhereEmployeeID = @sWhereEmployeeID + ' AND M.EmployeeID = N'''+@FromEmployeeID +''''
		ELSE IF Isnull(@FromEmployeeID, '') = '' and Isnull(@ToEmployeeID, '') != ''
			SET @sWhereEmployeeID = @sWhereEmployeeID + ' AND M.EmployeeID  = N'''+@ToEmployeeID +''''
		ELSE IF Isnull(@FromEmployeeID, '') != '' and Isnull(@ToEmployeeID, '') != ''
			SET @sWhereEmployeeID = @sWhereEmployeeID + ' AND M.EmployeeID Between N'''+@FromEmployeeID+''' AND N'''+@ToEmployeeID+''''

		IF Isnull(@ListInventoryID, '')<> ''
			SET @sWhere = @sWhere + ' AND D.InventoryID IN ('''+@ListInventoryID +''')'

		IF Isnull(@ListEmployeeID, '')<> ''
			SET @sWhereEmployeeID = @sWhereEmployeeID + ' AND M.EmployeeID IN ('''+@ListEmployeeID +''')'
		       
		IF @CustomerName = 97
 	    Begin
				SET @sSQL1 = N'
					SELECT distinct  M.APK,M.DivisionID, M.VoucherNo  as VoucherNo, ''''  as CVoucherNo, '''' as PVoucherNo
							, A02.InventoryID, A02.InventoryName, M.SaleManID as EmployeeID ,Isnull(A03.FullName, M.EmployeeName) as EmployeeName, Isnull(D.MinPrice, O02.MinPrice) as MinPrice
							, D.ActualQuantity as ActualQuantity, D.UnitPrice, ISNULL(B.ActualQuantity,0)  as ReturnQuantity, M.VoucherDate
							, D.Notes01, D.Notes02, D.Notes03
					From POST0016 M  WITH (NOLOCK) inner join POST00161 D  WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
											Left join POST0010 P10 WITH (NOLOCK) on M.DivisionID = P10.DivisionID and M.ShopID = P10.ShopID		
											Left Join AT1103 A03  WITH (NOLOCK) on A03.EmployeeID = M.SaleManID
											Left Join POST00802 P802  WITH (NOLOCK) on M.APK=P802.APKMInherited
											Left Join AT1302 A02  WITH (NOLOCK) on D.InventoryID = A02.InventoryID
											Left Join AT1304 A04  WITH (NOLOCK) on A02.UnitID = A04.UnitID
											left Join OT1302 O02  WITH (NOLOCK) on O02.InventoryID = A02.InventoryID
											LEFT JOIN (
														-- truong hop doi hang
														SELECT APKminherited, Evoucherno, InventoryID, SUM(actualquantity) AS actualquantity
														FROM(
														Select APKminherited, Evoucherno, InventoryID, actualquantity from POST00161 
														inner join POST0016 on POST0016.APK = POST00161.APKMaster
														where IsKindVoucherID = 1 and POST0016.DeleteFlg =0
														and POST0016.PVoucherNo is null and POST0016.CVoucherNo is not null
														union all
														Select APKminherited, Evoucherno, InventoryID, actualquantity from POST00161 
														inner join POST0016 on POST0016.APK = POST00161.APKMaster
														where POST0016.DeleteFlg =0
														and POST0016.PVoucherNo is not null and POST0016.CVoucherNo is null
														) A
														GROUP BY APKminherited, Evoucherno, InventoryID
														) B ON M.APK = B.APKminherited  and D.InventoryID=B.InventoryID

					WHERE M.DeleteFlg = 0  '+@sWhere+ @sWhereEmployeeID+ ' and M.PVoucherNo is null and M.CVoucherNo is null 
					Group by  M.APK,M.DivisionID, M.VoucherNo ,  A02.InventoryID, A02.InventoryName, A04.UnitID, A04.UnitName,M.SaleManID
							, Isnull(D.MinPrice, O02.MinPrice) ,Isnull(A03.FullName, M.EmployeeName), D.UnitPrice, M.VoucherDate,B.ActualQuantity,D.ActualQuantity, D.Notes01, D.Notes02, D.Notes03
					union all '
				SET @sSQL2=N'
					--doi hang
					SELECT distinct  M.APK,M.DivisionID, M.VoucherNo  as VoucherNo,  M.CVoucherNo  as CVoucherNo, '''' as PVoucherNo
							, A02.InventoryID, A02.InventoryName, M.SaleManID as EmployeeID ,Isnull(A03.FullName, M.EmployeeName) as EmployeeName,Isnull(D.MinPrice, O02.MinPrice) as MinPrice
							, case when D.IsKindVoucherID=2 then sum(D.ActualQuantity) else 0 end  as ActualQuantity, D.UnitPrice
							, case when D.IsKindVoucherID=1 then  ISNULL(SUM( D.ActualQuantity),0) else 0 end  as ReturnQuantity, M.VoucherDate
							, D.Notes01, D.Notes02, D.Notes03
					from POST0016 M  WITH (NOLOCK) inner join POST00161 D  WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
									Left join POST0010 P10 WITH (NOLOCK) on M.DivisionID = P10.DivisionID and M.ShopID = P10.ShopID		
									Left Join AT1103 A03  WITH (NOLOCK) on A03.EmployeeID = M.SaleManID
									Left Join POST00802 P802  WITH (NOLOCK) on M.APK=P802.APKMInherited
									Left Join AT1302 A02  WITH (NOLOCK) on D.InventoryID = A02.InventoryID
									Left Join AT1304 A04  WITH (NOLOCK) on A02.UnitID = A04.UnitID
									left Join OT1302 O02  WITH (NOLOCK) on O02.InventoryID = A02.InventoryID
					WHERE M.DeleteFlg = 0  '+@sWhere+ @sWhereEmployeeID+' and M.PVoucherNo is null and M.CVoucherNo is not null 
					group by  M.APK,M.DivisionID, M.VoucherNo ,  A02.InventoryID, A02.InventoryName, A04.UnitID, A04.UnitName,M.SaleManID , Isnull(D.MinPrice, O02.MinPrice)
							, Isnull(A03.FullName, M.EmployeeName), D.UnitPrice, M.CVoucherNo, M.VoucherDate,D.IsKindVoucherID, D.Notes01, D.Notes02, D.Notes03
					union all '
				SET @sSQL3=N'
					--tra hang
					SELECT distinct  M.APK,M.DivisionID, M.VoucherNo  as VoucherNo,  ''''  as CVoucherNo, M.PVoucherNo as PVoucherNo, A02.InventoryID
							, A02.InventoryName, M.SaleManID as EmployeeID ,Isnull(A03.FullName, M.EmployeeName) as EmployeeName, Isnull(D.MinPrice, O02.MinPrice) as MinPrice
							, sum(D.ActualQuantity) as ActualQuantity, D.UnitPrice,ISNULL(SUM( a.SLHBTL),0) as ReturnQuantity, M.VoucherDate
							, D.Notes01, D.Notes02, D.Notes03
					from POST0016 M  WITH (NOLOCK) inner join POST00161 D  WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
									Left join POST0010 P10 WITH (NOLOCK) on M.DivisionID = P10.DivisionID and M.ShopID = P10.ShopID		
									Left Join AT1103 A03  WITH (NOLOCK) on A03.EmployeeID = M.SaleManID
									Left Join POST00802 P802  WITH (NOLOCK) on M.APK=P802.APKMInherited
									Left Join AT1302 A02  WITH (NOLOCK) on D.InventoryID = A02.InventoryID
									Left Join AT1304 A04  WITH (NOLOCK) on A02.UnitID = A04.UnitID
									left Join OT1302 O02  WITH (NOLOCK) on O02.InventoryID = A02.InventoryID
									left join ( 
												SELECT m.voucherno , m.Pvoucherno, sum(D.ActualQuantity) as SLHBTL
												from POST0016 M  WITH (NOLOCK) inner join POST00161 D  WITH (NOLOCK) on M.APK = D.APKMaster
												WHERE  M.DeleteFlg = 0  and m.Pvoucherno is not null
												group by m.voucherno , m.Pvoucherno
  											  )	a 	on a.voucherno = M.voucherno	
					WHERE M.DeleteFlg = 0   '+@sWhere+ @sWhereEmployeeID+ ' and M.PVoucherNo is not null and M.CVoucherNo is null 
					Group by  M.APK,M.DivisionID, M.VoucherNo ,  A02.InventoryID, A02.InventoryName, A04.UnitID, A04.UnitName,M.SaleManID , Isnull(D.MinPrice, O02.MinPrice)
							, Isnull(A03.FullName, M.EmployeeName),D.UnitPrice, M.PVoucherNo,M.VoucherDate, D.Notes01, D.Notes02, D.Notes03 '
		
				exec ('select * from ('+ @sSQL1+ @sSQl2 + @sSQL3 + ' ) A order by VoucherNo,VoucherDate,CVoucherNo,PVoucherNo')
		End

		IF @CustomerName = 108
		Begin
			SET @sSQL1 = N' --Fix những nghiệp vụ bên dev lưu sai trường số nhưng lưu chữ [null] -> vì bên nhân ngọc 4 trường này dùng để lưu điểm của các nhân viên theo báo cáo hoa hồng
							Update POST00161 
							SET   notes01 = (Case when notes01 = ''null'' then 0.0 end)
								, notes02 = (Case when notes02 = ''null'' then 0.0 end)
								, notes03 = (Case when notes03 = ''null'' then 0.0 end)
								, notes04 = (Case when notes04 = ''null'' then 0.0 end)
							Where notes01 = ''null'' or notes02 = ''null'' or notes03 = ''null'' or notes04 = ''null''
							
							Select M.APK, M.DivisionID, M.ShopID, M.VoucherDate
								, Case when M.PVoucherNo is null and M.CVoucherNo is null then M.VoucherNo
										when M.PVoucherNo is not null then M.PVoucherNo
										When M.CVoucherNo is not null then M.CVoucherNo 
										Else M.VoucherNo end as VoucherNo
								, M.PVoucherNo, M.CVoucherNo
								, M.EmployeeID, A13.FullName as EmployeeName
								, M.EmployeeTypeID
								, M.InventoryID, A32.InventoryName
								, M.Quantity as ActualQuantity
								, M.UnitPrice
								, M.InventoryAmount
								, Sum(M.MinPrice) as MinPrice	 						--Điểm nhân viên bán hàng/1 sản phẩm
								, Sum(M.MinPrice * M.Quantity) as Point_MinPrice		--Điểm nhân viên bán hàng
								, Sum(M.Notes01) as	Notes01								--Điểm nhân viên giao hàng/1 sản phẩm
								, Sum(M.Notes01 * M.Quantity) as Point_Notes01 		--Điểm nhân viên giao hàng
								, Sum(M.Notes02) as	Notes02									--Điểm nhân viên kho/1 sản phẩm
								, Sum(M.Notes02 * M.Quantity) as Point_Notes02		--Điểm nhân viên kho
								, Sum(M.Notes03) as	Notes03									--Điểm nhân viên thu ngân/1 sản phẩm
								, Sum(M.Notes03 * M.Quantity) as Point_Notes03		--Điểm nhân viên thu ngân
								, Sum(M.Notes04) as	Notes04									--Điểm nhân viên phụ kho/1 sản phẩm
								, Sum(M.Notes04 * M.Quantity) as Point_Notes04		--Điểm nhân viên phụ kho
								, Sum(M.MinPrice * M.Quantity + M.Notes01 * M.Quantity + M.Notes02 * M.Quantity + M.Notes03 * M.Quantity + M.Notes04 * M.Quantity) as Notes05				--Điểm thực lãnh
								, Sum((M.MinPrice * M.Quantity + M.Notes01 * M.Quantity + M.Notes02 * M.Quantity + M.Notes03 * M.Quantity + M.Notes04 * M.Quantity) * 2000) as Notes06		--Tiền hoa hồng
								, 0.0 as ReturnQuantity
							From (  '
						SET @sSQL2=N'	
									--Lấy điểm {Nhân viên bán hàng} -->Phiếu bán hàng
									Select M.APK, M.DivisionID, M.ShopID, M.VoucherDate, M.VoucherNo, M.PVoucherNo, M.CVoucherNo, Isnull(M.SaleManID, M.EmployeeID) as EmployeeID, 1 as EmployeeTypeID, D.InventoryID, D.ActualQuantity as Quantity, D.UnitPrice, D.ActualQuantity * D.UnitPrice as InventoryAmount
										 , Cast(Isnull(D.MinPrice, 0.0) as Decimal(28, 8)) as MinPrice	
										 , Cast(0.0 as Decimal(28, 8)) as Notes01						
										 , Cast(0.0 as Decimal(28, 8)) as Notes02						
										 , Cast(0.0 as Decimal(28, 8)) as Notes03						
										 , Cast(0.0 as Decimal(28, 8)) as Notes04, D.OrderNo						
									From POST0016 M With (nolock) inner join POST00161 D With (nolock) on M.APK = D.APKmaster and M.DeleteFlg = D.DeleteFlg
									Where M.DeleteFlg = 0 and M.PVoucherNo is null and M.CVoucherNo is null ' + @sWhere + '
									Union all
									--Lấy điểm {Nhân viên bán hàng} -->Phiếu đổi hàng (Xuất)
									Select M.APK, M.DivisionID, M.ShopID, M.VoucherDate, M.VoucherNo, M.PVoucherNo, M.CVoucherNo, Isnull(B.SaleManID, B.EmployeeID), 4, D.InventoryID, D.ActualQuantity, D.UnitPrice, D.ActualQuantity * D.UnitPrice
										 , Cast(Isnull(D.MinPrice, 0.0) as Decimal(28, 8)) as MinPrice	
										 , Cast(0.0 as Decimal(28, 8)) as Notes01						
										 , Cast(0.0 as Decimal(28, 8)) as Notes02						
										 , Cast(0.0 as Decimal(28, 8)) as Notes03						
										 , Cast(0.0 as Decimal(28, 8)) as Notes04, D.OrderNo						
									From POST0016 M With (nolock) inner join POST00161 D With (nolock) on M.APK = D.APKmaster and M.DeleteFlg = D.DeleteFlg
													Left join POST0016 B With (nolock) on D.DivisionID = B.DivisionID and D.APKMInherited = B.APK and B.DeleteFlg = 0
									Where M.DeleteFlg = 0 and M.CVoucherNo is not null and D.IsKindVoucherID = 2 ' + @sWhere + '
									Union all
									--Lấy điểm {Nhân viên bán hàng} -->Phiếu trả hàng
									Select M.APK, M.DivisionID, M.ShopID, M.VoucherDate, M.VoucherNo, M.PVoucherNo, M.CVoucherNo, Isnull(B.SaleManID, B.EmployeeID), 2, D.InventoryID, -1*D.ActualQuantity, D.UnitPrice, -1*D.ActualQuantity * D.UnitPrice
										 , Cast(Isnull(D.MinPrice, 0.0) as Decimal(28, 8)) as MinPrice	
										 , Cast(0.0 as Decimal(28, 8)) as Notes01	
										 , Cast(0.0 as Decimal(28, 8)) as Notes02	
										 , Cast(0.0 as Decimal(28, 8)) as Notes03	
										 , Cast(0.0 as Decimal(28, 8)) as Notes04, D.OrderNo	
									From POST0016 M With (nolock) inner join POST00161 D With (nolock) on M.APK = D.APKmaster and M.DeleteFlg = D.DeleteFlg
													Left join POST0016 B With (nolock) on D.DivisionID = B.DivisionID and D.APKMInherited = B.APK and B.DeleteFlg = 0
									Where M.DeleteFlg = 0 and M.PVoucherNo is not null ' + @sWhere + ''
			SET @sSQL22=N'
								Union all
									--Lấy điểm {Nhân viên bán hàng} -->Phiếu đổi hàng (Nhập)
									Select M.APK, M.DivisionID, M.ShopID, M.VoucherDate, M.VoucherNo, M.PVoucherNo, M.CVoucherNo, Isnull(B.SaleManID, B.EmployeeID), 3, D.InventoryID, -1*D.ActualQuantity, D.UnitPrice, -1*D.ActualQuantity * D.UnitPrice
										 , Cast(Isnull(D.MinPrice, 0.0) as Decimal(28, 8)) as MinPrice	
										 , Cast(0.0 as Decimal(28, 8)) as Notes01	
										 , Cast(0.0 as Decimal(28, 8)) as Notes02	
										 , Cast(0.0 as Decimal(28, 8)) as Notes03	
										 , Cast(0.0 as Decimal(28, 8)) as Notes04, D.OrderNo	
									From POST0016 M With (nolock) inner join POST00161 D With (nolock) on M.APK = D.APKmaster and M.DeleteFlg = D.DeleteFlg
													Left join POST0016 B With (nolock) on D.DivisionID = B.DivisionID and D.APKMInherited = B.APK and B.DeleteFlg = 0
									Where M.DeleteFlg = 0 and M.CVoucherNo is not null and D.IsKindVoucherID = 1 ' + @sWhere + ''
									
			SET @sSQL3=N'			
									Union all
									--Lấy điểm {Nhân viên thu ngân} -->Phiếu bán hàng
									Select M.APK, M.DivisionID, M.ShopID, M.VoucherDate, M.VoucherNo, M.PVoucherNo, M.CVoucherNo, M.EmployeeID, 1, D.InventoryID, D.ActualQuantity, D.UnitPrice, D.ActualQuantity * D.UnitPrice
										 , Cast(0.0 as Decimal(28, 8)) as MinPrice			
										 , Cast(0.0 as Decimal(28, 8)) as Notes01			
										 , Cast(0.0 as Decimal(28, 8)) as Notes02			
										 , Cast(Isnull(D.Notes03, 0.0) as Decimal(28, 8)) as Notes03	
										 , Cast(0.0 as Decimal(28, 8)) as Notes04, D.OrderNo			
									From POST0016 M With (nolock) inner join POST00161 D With (nolock) on M.APK = D.APKmaster and M.DeleteFlg = D.DeleteFlg
									Where M.DeleteFlg = 0 and M.PVoucherNo is null and M.CVoucherNo is null ' + @sWhere + '
									Union all
									--Lấy điểm {Nhân viên thu ngân} -->Phiếu đổi hàng (Xuất)
									Select M.APK, M.DivisionID, M.ShopID, M.VoucherDate, M.VoucherNo, M.PVoucherNo, M.CVoucherNo, B.EmployeeID, 4, D.InventoryID, D.ActualQuantity, D.UnitPrice, D.ActualQuantity * D.UnitPrice
										 , Cast(0.0 as Decimal(28, 8)) as MinPrice			
										 , Cast(0.0 as Decimal(28, 8)) as Notes01			
										 , Cast(0.0 as Decimal(28, 8)) as Notes02			
										 , Cast(Isnull(D.Notes03, 0.0) as Decimal(28, 8)) as Notes03	
										 , Cast(0.0 as Decimal(28, 8)) as Notes04, D.OrderNo			
									From POST0016 M With (nolock) inner join POST00161 D With (nolock) on M.APK = D.APKmaster and M.DeleteFlg = D.DeleteFlg
													Left join POST0016 B With (nolock) on D.DivisionID = B.DivisionID and D.APKMInherited = B.APK and B.DeleteFlg = 0
									Where M.DeleteFlg = 0 and M.CVoucherNo is not null and D.IsKindVoucherID = 2 ' + @sWhere + '
									Union all
									--Lấy điểm {Nhân viên thu ngân} -->Phiếu trả hàng
									Select M.APK, M.DivisionID, M.ShopID, M.VoucherDate, M.VoucherNo, M.PVoucherNo, M.CVoucherNo, B.EmployeeID, 2, D.InventoryID, -1*D.ActualQuantity, D.UnitPrice, -1*D.ActualQuantity * D.UnitPrice
										 , Cast(0.0 as Decimal(28, 8)) as MinPrice			
										 , Cast(0.0 as Decimal(28, 8)) as Notes01			
										 , Cast(0.0 as Decimal(28, 8)) as Notes02			
										 , Cast(Isnull(D.Notes03, 0.0) as Decimal(28, 8)) as Notes03			
										 , Cast(0.0 as Decimal(28, 8)) as Notes04, D.OrderNo			
									From POST0016 M With (nolock) inner join POST00161 D With (nolock) on M.APK = D.APKmaster and M.DeleteFlg = D.DeleteFlg
													Left join POST0016 B With (nolock) on D.DivisionID = B.DivisionID and D.APKMInherited = B.APK and B.DeleteFlg = 0
									Where M.DeleteFlg = 0 and M.PVoucherNo is not null ' + @sWhere + '
									Union all'
			SET @sSQL4=N'			--Lấy điểm {Nhân viên thu ngân} -->Phiếu đổi hàng (Nhập)
									Select M.APK, M.DivisionID, M.ShopID, M.VoucherDate, M.VoucherNo, M.PVoucherNo, M.CVoucherNo, B.EmployeeID, 3, D.InventoryID, -1*D.ActualQuantity, D.UnitPrice, -1*D.ActualQuantity * D.UnitPrice
										 , Cast(0.0 as Decimal(28, 8)) as MinPrice			
										 , Cast(0.0 as Decimal(28, 8)) as Notes01			
										 , Cast(0.0 as Decimal(28, 8)) as Notes02			
										 , Cast(Isnull(D.Notes03, 0.0) as Decimal(28, 8)) as Notes03			
										 , Cast(0.0 as Decimal(28, 8)) as Notes04, D.OrderNo			
									From POST0016 M With (nolock) inner join POST00161 D With (nolock) on M.APK = D.APKmaster and M.DeleteFlg = D.DeleteFlg
													Left join POST0016 B With (nolock) on D.DivisionID = B.DivisionID and D.APKMInherited = B.APK and B.DeleteFlg = 0
									Where M.DeleteFlg = 0 and M.CVoucherNo is not null and D.IsKindVoucherID = 1 ' + @sWhere + '
									Union all
									--Lấy điểm {Nhân viên kho} -->Phiếu xuất kho
									Select M.APK, M.DivisionID, M.ShopID, M.VoucherDate, M.VoucherNo, NULL, NULL, M.EmployeeID, 5, D.InventoryID, D.ShipQuantity as Quantity, P16.UnitPrice, D.ShipQuantity * P16.UnitPrice
										 , Cast(0.0 as Decimal(28, 8)) as MinPrice		--Điểm nhân viên bán hàng
										 , Cast(0.0 as Decimal(28, 8)) as Notes01		--Điểm nhân viên giao hàng
										 , Cast(Isnull(P16.Notes02, 0.0) as Decimal(28, 8))	as Notes02		--Điểm nhân viên kho
										 , Cast(0.0 as Decimal(28, 8)) as Notes03		--Điểm nhân viên thu ngân
										 , Cast(0.0 as Decimal(28, 8)) as Notes04		--Điểm nhân viên phụ kho
										 , Cast(0.0 as Decimal(28, 8)) as Notes05		--Điểm trả/đổi
									From POST0027 M With (nolock) inner join POST0028 D With (nolock) on M.APK = D.APKmaster and M.DeleteFlg = D.DeleteFlg
													Left join POST00161 P16 With (nolock) on D.DivisionID = P16.DivisionID and D.APKMInherited = P16.APKMaster and D.APKDInherited = P16.APK and P16.DeleteFlg = 0
									Where M.DeleteFlg = 0 ' + @sWhere + '
																		Union all
									--Lấy điểm {Nhân viên phụ kho} -->Phiếu xuất kho
									Select M.APK, M.DivisionID, M.ShopID, M.VoucherDate, M.VoucherNo, NULL, NULL, M.UserStaffWarehouse, 5, D.InventoryID, D.ShipQuantity as Quantity, P16.UnitPrice, D.ShipQuantity * P16.UnitPrice
										 , Cast(0.0 as Decimal(28, 8)) as MinPrice		--Điểm nhân viên bán hàng
										 , Cast(0.0 as Decimal(28, 8)) as Notes01		--Điểm nhân viên giao hàng
										 , Cast(0.0 as Decimal(28, 8)) as Notes02		--Điểm nhân viên kho
										 , Cast(0.0 as Decimal(28, 8)) as Notes03		--Điểm nhân viên thu ngân
										 , Cast(Isnull(P16.Notes04, 0.0) as Decimal(28, 8)) as Notes04		--Điểm nhân viên phụ kho
										 , Cast(0.0 as Decimal(28, 8)) as Notes05		--Điểm trả/đổi
									From POST0027 M With (nolock) inner join POST0028 D With (nolock) on M.APK = D.APKmaster and M.DeleteFlg = D.DeleteFlg
													Left join POST00161 P16 With (nolock) on D.DivisionID = P16.DivisionID and D.APKMInherited = P16.APKMaster and D.APKDInherited = P16.APK and P16.DeleteFlg = 0
									Where M.DeleteFlg = 0 and Isnull(M.UserStaffWarehouse, '''') !='''' ' + @sWhere + '

									Union all'
			SET @sSQL5=N'			--Lấy điểm {Nhân viên giao hàng/lắp ráp} -->Phiếu xuất kho
									Select M.APK, M.DivisionID, M.ShopID, M.VoucherDate, M.VoucherNo, NULL, NULL, M.DeliveryEmployeeID, 6, D.InventoryID, D.ShipQuantity as Quantity, P16.UnitPrice, D.ShipQuantity * P16.UnitPrice
										 , Cast(0.0 as Decimal(28, 8)) as MinPrice		--Điểm nhân viên bán hàng
										 , Cast(Isnull(P16.Notes01, 0.0) as Decimal(28, 8))	as Notes01		--Điểm nhân viên giao hàng
										 , Cast(0.0 as Decimal(28, 8)) as Notes02		--Điểm nhân viên kho
										 , Cast(0.0 as Decimal(28, 8)) as Notes03		--Điểm nhân viên thu ngân
										 , Cast(0.0 as Decimal(28, 8)) as Notes04		--Điểm nhân viên phụ kho
										 , Cast(0.0 as Decimal(28, 8)) as Notes05		--Điểm trả/đổi
									From POST0027 M With (nolock) inner join POST0028 D With (nolock) on M.APK = D.APKmaster and M.DeleteFlg = D.DeleteFlg
												  Left join POST00161 P16 With (nolock) on D.DivisionID = P16.DivisionID and D.APKMInherited = P16.APKMaster and D.APKDInherited = P16.APK and P16.DeleteFlg = 0
									Where M.DeleteFlg = 0 and Isnull(M.DeliveryEmployeeID, '''') !='''' ' + @sWhere + '
							) M LEFT JOIN AT1302 A32 With (nolock) on M.InventoryID = A32.InventoryID
								LEFT JOIN AT1103 A13 With (nolock) on M.EmployeeID = A13.EmployeeID
						Where 1 = 1 ' + @sWhereEmployeeID + ' 
						group by M.APK, M.DivisionID, M.ShopID, M.VoucherDate, M.VoucherNo , M.PVoucherNo, M.CVoucherNo
								, M.EmployeeID, A13.FullName, M.EmployeeTypeID, M.InventoryID, A32.InventoryName, M.Quantity, M.UnitPrice, M.InventoryAmount,M.OrderNo
						Order by M.EmployeeID, VoucherDate, EmployeeTypeID, VoucherNo, M.OrderNo'
			exec (@sSQL1+ @sSQl2 + @sSQl22 + @sSQL3 + @sSQL4 + @sSQL5)
			Print @sSQL1
			Print @sSQl2 
			Print @sSQl22
			Print @sSQL3 
			Print @sSQL4 
			Print @sSQL5
		End
		
END		

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
