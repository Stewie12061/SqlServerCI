IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP2087]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP2087]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO












-- <Summary>
---- Sinh tự động phiếu yêu cầu xuất kho khi duyệt thông tin sản xuất
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
----Created by Kiều Nga on 06/03/2021
----Modify by Kiều Nga on 25/11/2022 : Bổ sung sinh động phiếu YCXK cho công đoạn cắt cuộn, sóng
----Modified by Viết Toàn on 09/08/2023: Bổ sung lưu người duyệt YCXK là người duyệt phiểu thông tin sản xuất
-- <Example>
---- 
/*-- <Example>
    SOP2087 @DivisionID = 'MT', @UserID='ASOFTADMIN',@TranMonth='6',@TranYear='2021',@InsVoucherTypeID='PXK',@APKMaster_9000='94008DF8-FB91-41ED-901D-DE6E4D65CC1D'

----*/

CREATE PROCEDURE [dbo].[SOP2087]
( 
     @DivisionID VARCHAR(50),
     @UserID VARCHAR(50),
	 @TranMonth	AS INT,
	 @TranYear	AS INT,
	 @InsVoucherTypeID	AS VARCHAR(50),
	 @APKMaster_9000 AS VARCHAR(50)
)
AS 
DECLARE @sSQL NVARCHAR(MAX) = N'', 
		@sSQL1 NVARCHAR(MAX) = N'',
		@sSQL2 NVARCHAR(MAX) = N''

SET @sSQL1 = @sSQL1 + N'
					-- Thêm thông tin người duyệt
						SET @APK9000 = NEWID()
						INSERT INTO OOT9000 (APK, status, DeleteFlag, AppoveLevel, ApprovingLevel, AskForVehicle, UseVehicle, HaveLunch, WorkType, TranMonth, TranYear, CreateDate, LastModifyDate, DivisionID, ID, DepartmentID, Type, CreateUserID, LastModifyUserID)
						VALUES (@APK9000, 0, 0, 1, 1, 0, 0, 0, 0, '+CONVERT(VARCHAR(10), @TranMonth)+', '+CONVERT(VARCHAR(10), @TranYear)+', GETDATE(), GETDATE(), ''' + @DivisionID + ''', @VoucherNo, '''', ''YCXK'', '''+@UserID+''', '''+@UserID+''')

						INSERT INTO OOT9001 (APK, DivisionID, APKMaster, ApprovePersonID, Level, Note, DeleteFlag, Status, IsWatched)
						VALUES (NEWID(), '''+@DivisionID+''', @APK9000, @ApprovePersonID, 1, '''', 0, 0, 0)

						---- Sinh phiếu YCXK cho công đoạn cắt cuộn ----
						-- Yêu cầu xuất kho (Master)
						INSERT INTO WT0095 (DivisionID,TranMonth,TranYear,VoucherTypeID,VoucherID,VoucherNo,VoucherDate,RefNo01,ObjectID,WareHouseID,InventoryTypeID
						,EmployeeID,ContactPerson,RDAddress,Description,TableID,KindVoucherID,CreateUserID,CreateDate,LastModifyUserID,LastModifyDate,DeliveryDate,APKMaster_9000,ApprovingLevel, ApproveLevel)
						SELECT M1.DivisionID,M1.TranMonth,M1.TranYear,'''+@InsVoucherTypeID+''',@InsVoucherID,@VoucherNo,M1.VoucherDate,M1.VoucherNo,M1.ObjectID,'''',''%''
							,M1.CreateUserID as EmployeeID,M2.ObjectName as ContactPerson,M1.DeliveryAddressName as RDAddress,N''Phieu YCXK sinh tu dong tu TTSX cat cuon'',''WT0095'',2,M1.CreateUserID,
							GETDATE(),M1.CreateUserID,GETDATE(),M1.DeliveryTime,@APK9000, 1, 1
						FROM SOT2080 M1 WITH (NOLOCK)
						LEFT JOIN AT1202 M2 WITH (NOLOCK) ON M1.ObjectID = M2.ObjectID AND M2.DivisionID IN (M1.DivisionID,''@@@'')
						WHERE M1.DivisionID = '''+@DivisionID+''' AND M1.APKMaster_9000 ='''+@APKMaster_9000+'''

						-- Insert bảng tmp1
						SELECT M1.DivisionID,M2.MaterialID AS InventoryID,M2.UnitID
						--,CASE WHEN ISNULL(M2.Gsm, 0) > 0 THEN M2.Gsm 
						-- WHEN ISNULL(M2.Sheets, 0) > 0 THEN M2.Sheets
						-- WHEN ISNULL(M2.Ram, 0) > 0 THEN M2.Ram
						-- WHEN ISNULL(M2.Kg, 0) > 0 THEN M2.Kg
						-- WHEN ISNULL(M2.M2, 0) > 0 THEN M2.M2 END AS ActualQuantity
						 , M2.Quantity AS ActualQuantity
						 ,M2.UnitPrice AS UnitPrice,0 AS OriginalAmount
						 ----
						 ,0 AS ConvertedAmount,'''' AS Notes,M1.TranMonth,M1.Tranyear,''VND'' AS CurrencyID,1 AS ExchangeRate,M3.PrimeCostAccountID AS DebitAccountID,M3.AccountID AS CreditAccountID
						 ----
						 ,1 AS Orders,1 AS ConversionFactor
						,CASE WHEN ISNULL(M2.Gsm, 0) > 0 THEN M2.Gsm 
						 WHEN ISNULL(M2.Sheets, 0) > 0 THEN M2.Sheets
						 WHEN ISNULL(M2.Ram, 0) > 0 THEN M2.Ram
						 WHEN ISNULL(M2.Kg, 0) > 0 THEN M2.Kg
						 WHEN ISNULL(M2.M2, 0) > 0 THEN M2.M2 END AS ConvertedQuantity
						 ,0 AS ConvertedPrice
						 ----
						 ,M2.UnitID AS ConvertedUnitID
						,CASE WHEN ISNULL(M2.Gsm, 0) > 0 THEN M2.Gsm 
						 WHEN ISNULL(M2.Sheets, 0) > 0 THEN M2.Sheets
						 WHEN ISNULL(M2.Ram, 0) > 0 THEN M2.Ram
						 WHEN ISNULL(M2.Kg, 0) > 0 THEN M2.Kg
						 WHEN ISNULL(M2.M2, 0) > 0 THEN M2.M2 END AS MarkQuantity
						 ,''SOT2080'' AS InheritTableID,M1.APK AS InheritVoucherID,M2.APK AS InheritTransactionID
						 INTO #SOT2080_tmp1
						FROM SOT2080 M1 WITH (NOLOCK)
						LEFT JOIN SOT2082 M2 WITH (NOLOCK) ON M1.APK = M2.APKMaster
						LEFT JOIN AT1302 M3 WITH (NOLOCK) ON M1.InventoryID = M2.MaterialID AND M3.DivisionID IN (M2.DivisionID,''@@@'')
						WHERE M1.DivisionID = '''+@DivisionID+''' AND M1.APKMaster_9000 ='''+@APKMaster_9000+''' AND PhaseID = N''01''

						-- Yêu cầu xuất kho (Detail)
						INSERT INTO WT0096(DivisionID,TransactionID,VoucherID,InventoryID,UnitID,ActualQuantity,UnitPrice,OriginalAmount
							,ConvertedAmount,Notes,TranMonth,TranYear,CurrencyID,ExchangeRate,DebitAccountID,CreditAccountID
							,Orders,ConversionFactor,ConvertedQuantity,ConvertedPrice
							,ConvertedUnitID,MarkQuantity,InheritTableID,InheritVoucherID,InheritTransactionID)
						SELECT T1.DivisionID, NEWID(), @InsVoucherID, T1.InventoryID, T1.UnitID, T1.ActualQuantity, T1.UnitPrice, (T1.ActualQuantity * T1.UnitPrice) AS OriginalAmount
							, T1.ConvertedAmount, T1.Notes, T1.TranMonth, T1.TranYear, T1.CurrencyID, T1.ExchangeRate, T1.DebitAccountID, T1.CreditAccountID
							, T1.Orders, T1.ConversionFactor, T1.ConvertedQuantity, T1.ConvertedPrice
							, ConvertedUnitID, T1.MarkQuantity, T1.InheritTableID, T1.InheritVoucherID, T1.InheritTransactionID
						FROM (
							SELECT DivisionID, InventoryID, UnitID, SUM(ActualQuantity) AS ActualQuantity, UnitPrice, OriginalAmount
								, ConvertedAmount, Notes, TranMonth, TranYear, CurrencyID, ExchangeRate, DebitAccountID, CreditAccountID
								, Orders, ConversionFactor, SUM(ConvertedQuantity) AS ConvertedQuantity, ConvertedPrice
								, ConvertedUnitID, SUM(MarkQuantity) AS MarkQuantity, InheritTableID, InheritVoucherID, MIN(InheritTransactionID) AS InheritTransactionID
							FROM #SOT2080_tmp1
							GROUP BY DivisionID, InventoryID, UnitID, UnitPrice, OriginalAmount, ConvertedAmount, Notes, TranMonth, TranYear
								, CurrencyID, ExchangeRate, DebitAccountID, CreditAccountID, Orders, ConversionFactor, ConvertedPrice
								, ConvertedUnitID,  InheritTableID, InheritVoucherID
						) T1
'

SET @sSQL2 = @sSQL2 + N'
					-- Thêm thông tin người duyệt
						SET @APK9000 = NEWID()
						INSERT INTO OOT9000 (APK, status, DeleteFlag, AppoveLevel, ApprovingLevel, AskForVehicle, UseVehicle, HaveLunch, WorkType, TranMonth, TranYear, CreateDate, LastModifyDate, DivisionID, ID, DepartmentID, Type, CreateUserID, LastModifyUserID)
						VALUES (@APK9000, 0, 0, 1, 1, 0, 0, 0, 0, '+CONVERT(VARCHAR(10), @TranMonth)+', '+CONVERT(VARCHAR(10), @TranYear)+', GETDATE(), GETDATE(), ''' + @DivisionID + ''', @VoucherNo2, '''', ''YCXK'', '''+@UserID+''', '''+@UserID+''')

						INSERT INTO OOT9001 (APK, DivisionID, APKMaster, ApprovePersonID, Level, Note, DeleteFlag, Status, IsWatched)
						VALUES (NEWID(), '''+@DivisionID+''', @APK9000, @ApprovePersonID, 1, '''', 0, 0, 0)

						---- Sinh phiếu YCXK cho công đoạn sóng ----
						-- Yêu cầu xuất kho (Master)
						INSERT INTO WT0095 (DivisionID,TranMonth,TranYear,VoucherTypeID,VoucherID,VoucherNo,VoucherDate,RefNo01,ObjectID,WareHouseID,InventoryTypeID
						,EmployeeID,ContactPerson,RDAddress,Description,TableID,KindVoucherID,CreateUserID,CreateDate,LastModifyUserID,LastModifyDate,DeliveryDate,APKMaster_9000,ApprovingLevel, ApproveLevel)
						SELECT M1.DivisionID,M1.TranMonth,M1.TranYear,'''+@InsVoucherTypeID+''',@InsVoucherID2,@VoucherNo2,M1.VoucherDate,M1.VoucherNo,M1.ObjectID,'''',''%''
							,M1.CreateUserID as EmployeeID,M2.ObjectName as ContactPerson,M1.DeliveryAddressName as RDAddress,N''Phieu YCXK sinh tu dong tu TTSX song'',''WT0095'',2,M1.CreateUserID,
							GETDATE(),M1.CreateUserID,GETDATE(),M1.DeliveryTime,@APK9000, 1, 1
						FROM SOT2080 M1 WITH (NOLOCK)
						LEFT JOIN AT1202 M2 WITH (NOLOCK) ON M1.ObjectID = M2.ObjectID AND M2.DivisionID IN (M1.DivisionID,''@@@'')
						WHERE M1.DivisionID = '''+@DivisionID+''' AND M1.APKMaster_9000 ='''+@APKMaster_9000+'''

						-- Insert bảng tmp2
						SELECT M1.DivisionID,M2.MaterialID AS InventoryID,M2.UnitID
						--,CASE WHEN ISNULL(M2.Gsm, 0) > 0 THEN M2.Gsm 
						-- WHEN ISNULL(M2.Sheets, 0) > 0 THEN M2.Sheets
						-- WHEN ISNULL(M2.Ram, 0) > 0 THEN M2.Ram
						-- WHEN ISNULL(M2.Kg, 0) > 0 THEN M2.Kg
						-- WHEN ISNULL(M2.M2, 0) > 0 THEN M2.M2 END AS ActualQuantity
						 , M2.Quantity AS ActualQuantity
						 ,M2.UnitPrice AS UnitPrice,0 AS OriginalAmount
						 ----
						 ,0 AS ConvertedAmount,'''' AS Notes,M1.TranMonth,M1.Tranyear,''VND'' AS CurrencyID,1 AS ExchangeRate,M3.PrimeCostAccountID AS DebitAccountID,M3.AccountID AS CreditAccountID
						 ----
						 ,1 AS Orders,1 AS ConversionFactor
						,CASE WHEN ISNULL(M2.Gsm, 0) > 0 THEN M2.Gsm 
						 WHEN ISNULL(M2.Sheets, 0) > 0 THEN M2.Sheets
						 WHEN ISNULL(M2.Ram, 0) > 0 THEN M2.Ram
						 WHEN ISNULL(M2.Kg, 0) > 0 THEN M2.Kg
						 WHEN ISNULL(M2.M2, 0) > 0 THEN M2.M2 END AS ConvertedQuantity
						 ,0 AS ConvertedPrice
						 ----
						 ,M2.UnitID AS ConvertedUnitID
						,CASE WHEN ISNULL(M2.Gsm, 0) > 0 THEN M2.Gsm 
						 WHEN ISNULL(M2.Sheets, 0) > 0 THEN M2.Sheets
						 WHEN ISNULL(M2.Ram, 0) > 0 THEN M2.Ram
						 WHEN ISNULL(M2.Kg, 0) > 0 THEN M2.Kg
						 WHEN ISNULL(M2.M2, 0) > 0 THEN M2.M2 END AS MarkQuantity
						 ,''SOT2080'' AS InheritTableID,M1.APK AS InheritVoucherID,M2.APK AS InheritTransactionID
						 INTO #SOT2080_tmp2
						FROM SOT2080 M1 WITH (NOLOCK)
						LEFT JOIN SOT2082 M2 WITH (NOLOCK) ON M1.APK = M2.APKMaster
						LEFT JOIN AT1302 M3 WITH (NOLOCK) ON M1.InventoryID = M2.MaterialID AND M3.DivisionID IN (M2.DivisionID,''@@@'')
						WHERE M1.DivisionID = '''+@DivisionID+''' AND M1.APKMaster_9000 ='''+@APKMaster_9000+''' AND PhaseID = N''05''

						-- Yêu cầu xuất kho (Detail)
						INSERT INTO WT0096(DivisionID,TransactionID,VoucherID,InventoryID,UnitID,ActualQuantity,UnitPrice,OriginalAmount
							,ConvertedAmount,Notes,TranMonth,TranYear,CurrencyID,ExchangeRate,DebitAccountID,CreditAccountID
							,Orders,ConversionFactor,ConvertedQuantity,ConvertedPrice
							,ConvertedUnitID,MarkQuantity,InheritTableID,InheritVoucherID,InheritTransactionID)
						SELECT T1.DivisionID, NEWID(), @InsVoucherID2, T1.InventoryID, T1.UnitID, T1.ActualQuantity, T1.UnitPrice, (T1.ActualQuantity * T1.UnitPrice) AS OriginalAmount
							, T1.ConvertedAmount, T1.Notes, T1.TranMonth, T1.TranYear, T1.CurrencyID, T1.ExchangeRate, T1.DebitAccountID, T1.CreditAccountID
							, T1.Orders, T1.ConversionFactor, T1.ConvertedQuantity, T1.ConvertedPrice
							, ConvertedUnitID, T1.MarkQuantity, T1.InheritTableID, T1.InheritVoucherID, T1.InheritTransactionID
						FROM (
							SELECT DivisionID, InventoryID, UnitID, SUM(ActualQuantity) AS ActualQuantity, UnitPrice, OriginalAmount
								, ConvertedAmount, Notes, TranMonth,TranYear, CurrencyID, ExchangeRate, DebitAccountID, CreditAccountID
								, Orders, ConversionFactor, SUM(ConvertedQuantity) AS ConvertedQuantity, ConvertedPrice
								, ConvertedUnitID, SUM(MarkQuantity) AS MarkQuantity, InheritTableID, InheritVoucherID, MIN(InheritTransactionID) AS InheritTransactionID
							FROM #SOT2080_tmp2
							GROUP BY DivisionID, InventoryID, UnitID, UnitPrice, OriginalAmount, ConvertedAmount, Notes, TranMonth, TranYear
								, CurrencyID, ExchangeRate, DebitAccountID, CreditAccountID, Orders, ConversionFactor, ConvertedPrice
								, ConvertedUnitID,  InheritTableID, InheritVoucherID
						) T1
'

SET @sSQL = @sSQL + N'
					DECLARE	@StringKey1 nvarchar(50), @StringKey2 nvarchar(50),@StringKey3 nvarchar(50), 
							@OutputLen int, @OutputOrder int,
							@Separated int, @Separator char(1),
							@Enabled1 tinyint, @Enabled2 tinyint, @Enabled3 tinyint,
							@S1 nvarchar(50), @S2 nvarchar(50),@S3 nvarchar(50),
							@S1Type tinyint, @S2Type tinyint,@S3Type tinyint,
							@VoucherNo AS NVARCHAR(50),
							@VoucherNo2 AS NVARCHAR(50),
							@InsVoucherID AS NVARCHAR(50),
							@InsVoucherID2 AS NVARCHAR(50),
							@APK9000 AS NVARCHAR(50),
							@ApprovePersonID VARCHAR(50) = (SELECT TOP 1 ApprovePersonID FROM OOT9001 WHERE APKMaster = '''+@APKMaster_9000+''')
					Select	@Enabled1=Enabled1, @Enabled2=Enabled2, @Enabled3=Enabled3, @S1=S1, @S2=S2, @S3=S3, @S1Type=S1Type, @S2Type=S2Type, @S3Type=S3Type
							, @OutputLen = OutputLength, @OutputOrder= OutputOrder,@Separated= Separated,@Separator= Separator
					FROM	AT1007 WITH (NOLOCK)
					WHERE	DivisionID = '''+@DivisionID+''' AND VoucherTypeID = '''+@InsVoucherTypeID+''' 
						If @Enabled1 = 1
							Set @StringKey1 = Case @S1Type When 1 Then Case When '+STR(@TranMonth)+' <10 Then ''0'' + ltrim('+STR(@TranMonth)+') Else ltrim('+STR(@TranMonth)+') End
															When 2 Then ltrim('+STR(@TranYear)+')
															When 3 Then '''+@InsVoucherTypeID+'''
															When 4 Then '''+@DivisionID+'''
															When 5 Then @S1 Else '''' End
						Else Set @StringKey1 = ''''
						If @Enabled2 = 1
							Set @StringKey2 = Case @S2Type When 1 Then Case When '+STR(@TranMonth)+' <10 Then ''0'' + ltrim('+STR(@TranMonth)+') Else ltrim('+STR(@TranMonth)+') End
															When 2 Then ltrim('+STR(@TranYear)+')
															When 3 Then '''+@InsVoucherTypeID+'''
															When 4 Then '''+@DivisionID+'''
															When 5 Then @S2 Else '''' End
						Else Set @StringKey2 = ''''
						If @Enabled3 = 1
							Set @StringKey3 = Case @S3Type When 1 Then Case When '+STR(@TranMonth)+' <10 Then ''0'' + ltrim('+STR(@TranMonth)+') Else ltrim('+STR(@TranMonth)+') End
															When 2 Then ltrim('+STR(@TranYear)+')
															When 3 Then '''+@InsVoucherTypeID+'''
															When 4 Then '''+@DivisionID+'''
															When 5 Then @S3
															Else '''' End 

						Else Set @StringKey3 = ''''
						EXEC AP0000 '''+@DivisionID+''' ,@VoucherNo Output, ''WT0095'', @StringKey1, @StringKey2, @StringKey3, @OutputLen, @OutputOrder, @Separated, @Separator

						EXEC AP0000 '''+@DivisionID+''' ,@VoucherNo2 Output, ''WT0095'', @StringKey1, @StringKey2, @StringKey3, @OutputLen, @OutputOrder, @Separated, @Separator

						SET @InsVoucherID = NEWID()
						SET @InsVoucherID2 = NEWID()
						
 '

    EXEC (@sSQL + @sSQL1 + @sSQL2)
    PRINT(@sSQL + @sSQL1 + @sSQL2)










GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO