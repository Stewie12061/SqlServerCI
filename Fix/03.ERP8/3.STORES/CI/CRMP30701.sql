IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP30701]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP30701]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Viết báo cáo riêng cho HOANGTRAN (Báo cáo tổng công nợ của khách hàng: vỏ, tiền cọc, máy nóng lạnh, chân kệ, vật dụng (báo cáo công nợ của khách hàng))
---- Store tra ra Crosstab (co dinh cot O01ID, ObjectID, ObjectName, Address, O05ID, 1, 2, 3, 4) và Cross tab cột InventoryID
---- Group dữ liệu sum theo (STT, DivisionID, O01ID, ObjectID, ObjectName, Address, O05ID)
---- Công thức tính (Group sum STT = 1, STT = 2, STT = 3 [=1+sum(2)], STT = 4 [=1+3])
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 07/12/2016 by Phan thanh hoàng Vũ
---- Edited by 06/02/2016 hoàng vũ: Fixbug lỗi internal server do điều kiện vật tư sai
---- Edited by 19/06/2017 Cao Thị Phượng: Fixbug Lấy vật tư cho mượn theo yêu cầu mới của KH
---- Modify by: Phan thanh hoàng vũ, Date: 28/11/2017, Bổ sung with Nolock để tránh bị deadlock
---- Edited by 16/10/2019 Văn Minh: Chỉnh sửa điều kiện search theo Deposit và ToTalDeposit
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
----- 
-- <Example> EXEC CRMP30701  'HT'',''TB'',''Q7', 'HT','2017-06-19', '2017-06-19', N'131', N'344', N'3441', N'16062-A.1*CG', N'16062-A.1*CG', '3C-700A', 'WAMI'
CREATE PROCEDURE [dbo].[CRMP30701]
					@DivisionIDList AS nvarchar(Max) ,
				 	@DivisionID AS nvarchar(50) ,
					@FromDate  AS Datetime,
					@ToDate  AS Datetime,
					@DebitAccountID AS nvarchar(Max),	
					@TotalDepositAccountID AS nvarchar(Max),
					@DepositAccountID AS nvarchar(Max),
					@FromObjectID  AS nvarchar(50),
					@ToObjectID  AS nvarchar(50),
					@FromInventoryID  AS nvarchar(50),
					@ToInventoryID  AS nvarchar(50)
AS
DECLARE 		@FromDateText NVARCHAR(20), 
				@ToDateText NVARCHAR(20), 
				@sSQL01 nvarchar(Max),
				@sSQL02 nvarchar(Max),
				@sSQL03 nvarchar(Max),
				@sSQL04 nvarchar(Max),
				@sSQL05 nvarchar(Max),
				@sSQL06 nvarchar(Max),
				@sSQL07 nvarchar(Max),
				@sSQL08 nvarchar(Max),
				@sSQL09 nvarchar(Max),
				@sSQL10 nvarchar(Max),
				@sSQL11 nvarchar(Max),
				@sWhere00 nvarchar(Max) = '',
				@sWhere01 nvarchar(Max) = '',
				@sWhere02 nvarchar(Max) = '',
				@sWhere03 nvarchar(Max) = '',
				@sWhere04 nvarchar(Max) = '',
				@sWhere05 nvarchar(Max) = '',
				@sWhere06 nvarchar(Max) = '',
				@sWhere07 nvarchar(Max) = ''


			SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
			SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'
			
			--Điều kiện search DivisionID		
			IF Isnull(@DivisionIDList, '') != '' 
					Set @sWhere00 = @sWhere00 + ' D17.DivisionID in ( '''+ @DivisionIDList + ''')'
				Else	
					Set @sWhere00 = @sWhere00 + ' D17.DivisionID = N'''+ @DivisionID + ''''
			
			--Điều kiện search thời gian
					--Set @sWhere01 = @sWhere00 + ' and (CONVERT(DATETIME, CONVERT(VARCHAR(10), D17.VoucherDate, 101), 101) < '''+ @FromDateText + ''')'
					--Set @sWhere02 = @sWhere00 + ' and (CONVERT(DATETIME, CONVERT(VARCHAR(10), D17.VoucherDate, 101), 101) Between '''+ @FromDateText + ''' AND ''' + @ToDateText + ''')'
			
					Set @sWhere01 = @sWhere00 + ' and (D17.VoucherDate < '''+ @FromDateText + ''')'
					Set @sWhere02 = @sWhere00 + ' and (D17.VoucherDate Between '''+ @FromDateText + ''' AND ''' + @ToDateText + ''')'
			
			--Search theo khách hàng
			IF Isnull(@FromObjectID, '') = '' and Isnull(@ToObjectID, '') ! = ''
					Set @sWhere03 = @sWhere03 + ' and D17.ObjectID <=''' + @ToObjectID + ''''
				Else IF Isnull(@FromObjectID, '') != '' and Isnull(@ToObjectID, '')  = ''
					Set @sWhere03 = @sWhere03 + ' and D17.ObjectID >=''' + @FromObjectID +''''
				Else IF Isnull(@FromObjectID, '') != '' and Isnull(@ToObjectID, '')  != ''
					Set @sWhere03 = @sWhere03 + ' and D17.ObjectID Between '''+ @FromObjectID + ''' AND ''' + @ToObjectID + ''''
				Else IF Isnull(@FromObjectID, '') = '' and Isnull(@ToObjectID, '') = ''
					Set @sWhere03 = @sWhere03

			--Search theo tài khoản công nợ
			IF Isnull(@DebitAccountID, '') != '' 
					Set @sWhere04 = @sWhere04 + ' and D17.AccountID  in (''' + @DebitAccountID + ''')'
			Else 
					Set @sWhere04 = @sWhere04 + ' and D17.AccountID  in (Select AccountID from AT1005 D17 Where D17.GroupID in (''G03'') and '+@sWhere00+')'
					
				
			--Search theo tài khoản tiền cọc vỏ
			IF Isnull(@DepositAccountID, '') != '' 
					Set @sWhere05 = @sWhere05 + ' and D17.AccountID  in (''' + @DepositAccountID + ''')'
			Else
					Set @sWhere05 = @sWhere05 + ' and D17.AccountID  in (Select AccountID from AT1005 D17 Where D17.AccountID  like N''3441%'' and '+@sWhere00+')'
				

			--Search theo tài khoản tiền cọc
			IF Isnull(@TotalDepositAccountID, '') != '' 
					Set @sWhere06 = @sWhere06 + ' and D17.AccountID  in (''' + @TotalDepositAccountID + ''')'
			Else
					Set @sWhere06 = @sWhere06 + ' and D17.AccountID  in (Select AccountID from AT1005 D17 Where D17.AccountID  like N''344%'' and '+@sWhere00+')'

			--Search theo mặt hàng
			IF Isnull(@FromInventoryID, '') = '' and Isnull(@ToInventoryID, '') ! = ''
					Set @sWhere07 = @sWhere07 + ' and D17.InventoryID  <=''' + @ToInventoryID + ''''
				Else IF Isnull(@FromInventoryID, '') != '' and Isnull(@ToInventoryID, '')  = ''
					Set @sWhere07 = @sWhere07 + ' and D17.InventoryID  >=''' + @FromInventoryID  + ''''
				Else IF Isnull(@FromInventoryID, '') != '' and Isnull(@ToInventoryID, '')  != ''
					Set @sWhere07 = @sWhere07 + ' and D17.InventoryID  Between '''+ @FromInventoryID + ''' AND ''' + @ToInventoryID + ''''
				Else IF Isnull(@FromInventoryID, '') = '' and Isnull(@ToInventoryID, '') = ''
					Set @sWhere07 = @sWhere07 
				
				
Set @sSQL01 = '--Biến bảng lưu kết trả ra trước khi Crosstab
				Declare @RESULT table (  Stt int,
										 GroupID int, --1: Tổng tiền cọc, 2: Tiền cọc vỏ, 3: Vỏ tồn; 4: Công nợ phải thu; 5: Vật tư cho mượn
										 DivisionID varchar(50),
										 InventoryID varchar(50),
										 ObjectID varchar(50),
										 Amount decimal(28,8))
				--Biến bảng lưu kết trả số dư (công nợ + kho)
				Declare @DUDAU table (   Stt int,
										 DivisionID varchar(50),
										 WareHouseID varchar(50),
										 InventoryID varchar(50),
										 ObjectID varchar(50),
										 Amount decimal(28,8),
										 IsBottle tinyint,
										 IsBorrow tinyint)  '

Set @sSQL02 = ' 
				Insert into @DUDAU (Stt, DivisionID, WareHouseID, InventoryID, ObjectID, Amount, IsBottle, IsBorrow)
				SELECT  1 as Stt, D17.DivisionID, D17.WareHouseID, D17.InventoryID, D17.ObjectID, Sum(Isnull(DebitQuantity, 0)) - Sum(Isnull(CreditQuantity, 0)) as BeginQuantity, 
				Isnull(D17.IsBottle, 0) as IsBottle, Isnull(D17.IsBorrow,0) as IsBorrow
				FROM AV7000_HT D17
				WHERE	' + @sWhere01+ @sWhere03+@sWhere07+'
				Group by D17.DivisionID, D17.WareHouseID, D17.InventoryID, D17.ObjectID, Isnull(D17.IsBottle, 0), Isnull(D17.IsBorrow,0) '
Set @sSQL03 = ' Insert into @RESULT (Stt, GroupID, DivisionID, InventoryID, ObjectID, Amount)
				--Số dư công nợ tổng tiền cọc (1: Tổng tiền cọc)
				SELECT 	1 as Stt, 1 as GroupID, D17.DivisionID, NULL as InventoryID, NULL as ObjectID, Sum(D17.ConvertedAmount)
				FROM AV4202 D17 
				WHERE ' + @sWhere01+ @sWhere03+ @sWhere06+'
		 		Group by D17.DivisionID 
				union all
				--Số dư công nợ tiền vỏ cọc (2: Tiền cọc vỏ)
				SELECT 1 as Stt, 2 as GroupID,	D17.DivisionID, NULL as InventoryID, NULL as ObjectID, Sum(D17.ConvertedAmount)
				FROM AV4202 D17 '
Set @sSQL04 = ' WHERE ' + @sWhere01+ @sWhere03+@sWhere05+ '
				Group by D17.DivisionID 
				union all 
				 --Số dư kho Vỏ (3: Vỏ tồn)
				Select D17.Stt, 3 as GroupID, D17.DivisionID, NULL as InventoryID, NULL as ObjectID, 
				Case when Isnull(D17.IsBottle, 0) = 1 then Sum(D17.Amount) * (-1) else Sum(D17.Amount) end 
				from @DUDAU D17
				Where Isnull(D17.IsBottle, 0) = 1 and D17.WareHouseID in (Select WareHouseTempID From CRMT00000 D17 With (Nolock) Where '+@sWhere00+' 
												Union all
												Select WareHouseID From CRMT00000 D17 With (Nolock) Where '+@sWhere00+' )
				Group by D17.Stt, D17.DivisionID, Isnull(D17.IsBottle, 0)
				Union all 
				--Số dư công nợ tổng (4: Công nợ phải thu)
				SELECT x.Stt, x.GroupID, x.DivisionID, NULL as InventoryID, NULL as ObjectID, Sum(x.ConvertedAmount)
				From (
				SELECT 1 as Stt, 4 as GroupID, 	D17.DivisionID, D17.ConvertedAmount
				FROM AV4202 D17 '
Set @sSQL05 = ' WHERE ' + @sWhere01+@sWhere03+@sWhere04+'  and	D17.TransactionTypeID <> N''T00''
				Union all
				SELECT 1 as Stt, 4 as GroupID, 	D17.DivisionID, D17.ConvertedAmount
				FROM AV4202 D17
				WHERE ' + @sWhere00+@sWhere03+@sWhere04+'  and	D17.TransactionTypeID = N''T00''
				) x 
				Group by x.Stt, x.GroupID, x.DivisionID 
				Union all 
				 --Số dư kho khác (5: Vật tư cho mượn)
				Select D17.Stt, 5 as GroupID, D17.DivisionID, D17.InventoryID, NULL as ObjectID, 
				Case when (D17.WareHouseID = M.WareHouseID or D17.WareHouseID = M.WareHouseBorrowID) then Sum(D17.Amount) * (-1) else Sum(D17.Amount) end 
				from @DUDAU D17 left join CRMT00000 M on D17.DivisionID = M.DivisionID '
Set @sSQL06 = ' Where D17.WareHouseID in (Select WareHouseBorrowID From CRMT00000  D17 With (Nolock) Where '+@sWhere00+' 
										  Union all
										  Select WareHouseID From CRMT00000 D17 With (Nolock) Where '+@sWhere00+' )
						And D17.InventoryID not in (Select Distinct ItemID from AT1326 With (Nolock) Where '+@sWhere00+' )
						And D17.IsBorrow = 1
				Group by D17.Stt, D17.DivisionID, D17.InventoryID , D17.WareHouseID, M.WareHouseID, M.WareHouseBorrowID
				--Biến bảng lưu kết trả phát sinh (công nợ + kho) 
			    Declare @PHATSINH table ( Stt int,
									DivisionID varchar(50),
									WareHouseID varchar(50),
									InventoryID varchar(50),
									ObjectID varchar(50),
									Amount decimal(28,8),
									IsBottle tinyint ,
									IsBorrow tinyint)
				Insert into @PHATSINH (Stt, DivisionID, WareHouseID, InventoryID, ObjectID, Amount, IsBottle, IsBorrow)
				-- phát sinh
				SELECT 2 as STT, D17.DivisionID, D17.WareHouseID, D17.InventoryID, D17.ObjectID, Sum(D17.DebitQuantity) - Sum(D17.CreditQuantity) as Amount, 
						Isnull(D17.IsBottle, 0)l, Isnull(D17.IsBorrow,0) as IsBorrow
				FROM AV7001_HT  D17 '
Set @sSQL07 = '
				WHERE ' + @sWhere02+@sWhere03+@sWhere07+ ' 
				GROUP BY D17.DivisionID, D17.WareHouseID, D17.InventoryID, D17.ObjectID, Isnull(D17.IsBottle, 0), Isnull(D17.IsBorrow,0)
				Having Sum(D17.DebitQuantity) - Sum(D17.CreditQuantity) <> 0 
				Insert into @RESULT (Stt, GroupID, DivisionID, InventoryID, ObjectID, Amount) 
				 --Phát sinh công nợ tổng tiền cọc (1: Tổng tiền cọc)
				SELECT 	2 as Stt, 1 as GroupID, D17.DivisionID, NULL as InventoryID,  D17.ObjectID, Sum(D17.ConvertedAmount)
				FROM AV4202 D17 
				WHERE ' + @sWhere02+ @sWhere03+ @sWhere06+' 
				 Group by D17.DivisionID, D17.ObjectID
				union all 
				--phát sinh công nợ tiền vỏ cọc (2: Tiền cọc vỏ)
				SELECT 2 as Stt, 2 as GroupID,	D17.DivisionID, NULL as InventoryID, D17.ObjectID, Sum(D17.ConvertedAmount)
				FROM AV4202 D17 '
Set @sSQL08 = ' WHERE ' + @sWhere02+ @sWhere03+@sWhere05+ ' 
				Group by D17.DivisionID, D17.ObjectID
				Union all  --Phát sinh kho Vỏ (3: Vỏ tồn)
				Select D17.Stt, 3 as GroupID, D17.DivisionID, D17.InventoryID, D17.ObjectID, 
				Case when Isnull(D17.IsBottle, 0) = 1 then Sum(D17.Amount) * (-1) else Sum(D17.Amount) end 
				from @PHATSINH D17
				Where Isnull(D17.IsBottle, 0) = 1
						and D17.WareHouseID in (Select WareHouseTempID From CRMT00000  D17 With (Nolock) Where '+@sWhere00+' 
												Union all
												Select WareHouseID From CRMT00000 D17 With (Nolock) Where '+@sWhere00+'
												)
				Group by D17.Stt, D17.DivisionID, D17.InventoryID, D17.ObjectID, Isnull(D17.IsBottle, 0)
				Union all 
				 --phát sinh công nợ tổng (4: Công nợ phải thu)
				SELECT 2 as Stt, 4 as GroupID, 	D17.DivisionID, NULL as InventoryID, D17.ObjectID, Sum(D17.ConvertedAmount)
				FROM AV4202 D17 '

Set @sSQL09= '  WHERE ' + @sWhere02+@sWhere03+@sWhere04+' and	D17.TransactionTypeID <> ''T00'' 
				Group by D17.DivisionID, D17.ObjectID
				Union all 
				--phát sinh kho khác (5: Vật tư cho mượn)
				Select D17.Stt, 5 as GroupID, D17.DivisionID,D17.InventoryID, D17.ObjectID, 
				Case when (D17.WareHouseID = M.WareHouseID or D17.WareHouseID = M.WareHouseBorrowID) then Sum(D17.Amount) * (-1) else Sum(D17.Amount) end 
				from @PHATSINH D17  left join CRMT00000 M With (Nolock) on D17.DivisionID = M.DivisionID 
				Where D17.WareHouseID in (Select WareHouseBorrowID From CRMT00000  D17 With (Nolock) Where '+@sWhere00+' 
										  Union all
										  Select WareHouseID From CRMT00000 D17 With (Nolock) Where '+@sWhere00+'
										 )
					  And D17.InventoryID not in (Select Distinct ItemID from AT1326 With (Nolock) Where '+@sWhere00+' ) 
					  AND D17.IsBorrow =1
				Group by D17.Stt, D17.DivisionID, D17.InventoryID, D17.ObjectID, D17.WareHouseID, M.WareHouseID, M.WareHouseBorrowID 
				
				Select D17.Stt, Case when D17.GroupID = 5 then 5 + DENSE_RANK() over (order by D17.InventoryID) else D17.GroupID end as GroupID , D17.DivisionID
						, Case when D17.GroupID = 1 then N''1'' 
							   when D17.GroupID = 2 then N''2''
							   when D17.GroupID = 3 then N''3''
							   when D17.GroupID = 4 then N''4'' '

Set @sSQL10= ' 			   else D17.InventoryID end InventoryID, D.O01ID, C.AnaName as O01Name, D17.ObjectID, D.ObjectName, D.O05ID, E.Ananame as O05Name, D.Address, Isnull(D17.Amount, 0) as Amount
				into #RESULT
				from @RESULT D17 left join AT1202 D With (Nolock) on D.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND D17.ObjectID = D.ObjectID
							   left join AT1015 C With (Nolock) on C.DivisionID = D.DivisionID and C.AnaID = D.O01ID and C.AnaTypeID = N''O01''
							   left join AT1015 E With (Nolock) on E.DivisionID = D.DivisionID and E.AnaID = D.O05ID and E.AnaTypeID = N''O05''
				Order by  D17.Stt, D17.GroupID 
				Select D17.Stt, D17.GroupID, D17.DivisionID, D17.InventoryID
						, D17.O01ID, D17.O01Name, D17.ObjectID, D17.ObjectName, D17.O05ID, D17.O05Name, D17.Address, D17.Amount
				into #RESULTX
				from #RESULT D17 
				Union all
				Select 1 as Stt, 1 as GroupID, D17.DivisionID, ''1'' as InventoryID, NULL as O01ID, NULL as O01Name, NULL as ObjectID, NULL as ObjectName, NULL as O05ID, NULL as O05Name, NULL as Address, 0 as Amount
				from #RESULT D17 
				Where Isnull(InventoryID, 0) != ''1''
				Union all
				Select 1 as Stt, 2 as GroupID, D17.DivisionID, ''2'' as InventoryID
						, NULL as O01ID, NULL as O01Name, NULL as ObjectID, NULL as ObjectName, NULL as O05ID, NULL as O05Name, NULL as Address, 0 as Amount
				from #RESULT D17 
				Where Isnull(InventoryID, 0) != ''2'' 
				Union all
				Select 1 as Stt, 3 as GroupID, D17.DivisionID, ''3'' as InventoryID
						, NULL as O01ID, NULL as O01Name, NULL as ObjectID, NULL as ObjectName, NULL as O05ID, NULL as O05Name, NULL as Address, 0 as Amount
				from #RESULT D17 
				Where Isnull(InventoryID, 0) != ''3''
				Union all '

Set @sSQL11= '
				Select 1 as Stt, 4 as GroupID, D17.DivisionID, ''4'' as InventoryID
						, NULL as O01ID, NULL as O01Name, NULL as ObjectID, NULL as ObjectName, NULL as O05ID, NULL as O05Name, NULL as Address, 0 as Amount
				from #RESULT D17 
				Where Isnull(InventoryID, 0) != ''4''
				 DECLARE @columns NVARCHAR(MAX), @sql NVARCHAR(MAX);
		SET @columns = N'''';
		SELECT @columns += N'', '' + quotename(InventoryID)
		  FROM (SELECT InventoryID 
				FROM #RESULTX group by InventoryID ) AS x;
		SET @sql = N''
		SELECT Stt, DivisionID, O01ID, O01Name, ObjectID, ObjectName, Address,  O05ID, O05Name,  '' + STUFF(@columns, 1, 2, '''') + ''
		FROM
		(
		  SELECT Stt, GroupID, DivisionID, O01ID, O01Name, ObjectID, ObjectName, O05ID, O05Name, Address, InventoryID, Amount
		  FROM #RESULTX
		  ) AS j
		PIVOT
		(
		  SUM(Amount) FOR InventoryID IN (''
		  + STUFF(REPLACE(@columns, '', ['', '',[''), 1, 1, '''')
		  + '')
		) AS p;'';
		PRINT @sql;
		EXEC sp_executesql @sql;
		'
		
EXEC (@sSQL01 + @sSQL02 + @sSQL03 + @sSQL04 + @sSQL05 +@sSQL06  +@sSQL07 +@sSQL08 +@sSQL09 +@sSQL10 +@sSQL11)
Print @sSQL01 
Print @sSQL02 
Print @sSQL03 
Print @sSQL04 
Print @sSQL05
Print @sSQL06
Print @sSQL07
Print @sSQL08
Print @sSQL09
Print @sSQL10
Print @sSQL11

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
