IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP1412]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP1412]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
--- Tạo dữ liệu từ các bảng standar khi tạo đơn vị
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Created by Thanh Tram on 13/12/2010
----Edit by Khanh Van on 18/12/2013: Them vao module quan ly hoa hong
----Modified by Thanh Sơn on 10/07/2014: Chuyển thành store bắn dữ liệu tự động từ các bảng standard
----Modified by Thanh Sơn on 20/11/2014: Không Insert thêm bảng OOOOSTD và bảng AT0001STD thì đã insert trigger
----Modified by Phương Thảo on 29/05/2017: Bảng AT1301 là bảng danh mục dùng chung nên ko bắn dữ liệu qua tất cả các Division
----Modified by Phương Thảo on 08/03/2018: Chỉnh sửa không thêm dữ liệu ngầm của bảng dùng chung ở những đơn vị tạo sau
----Modified by Lê Hoàng on 19/08/2020: Bổ sung tạo dữ liệu người dùng ASOFTADMIN, nhóm người dùng ADMIN và người sử dụng chương trình từ AT1401STD,AT1402STD,AT1405STD để khi tạo đơn vị mới sẽ có các dữ liệu ngầm 
----Modified by Lê Hoàng on 24/08/2020: Xóa bảng những dữ liệu mẫu của bảng dùng chung trước rồi insert vào nếu có dữ liệu, bỏ điều kiện where tồn tại
----Modified by Huỳnh Thử on 24/08/2020: Tách Store SaVi
-- <Example>

/*
    AP1412 'KKK',1,2014
*/

CREATE PROCEDURE AP1412
	@DivisionID NVARCHAR(50),
	@TranMonth INT,
	@TranYear INT
AS
DECLARE @Cur CURSOR, @Cur1 CURSOR, @TableSTD VARCHAR(50), @Table VARCHAR(50), @sSQL NVARCHAR(MAX),
		@Id NVARCHAR(50), @Insert NVARCHAR(MAX), @Insert1 NVARCHAR(MAX), @ColumnID NVARCHAR(100)
CREATE TABLE #Tam(TableID VARCHAR(50))
CREATE TABLE #Division(Division VARCHAR(50))
CREATE TABLE #TableSTD(TableID VARCHAR(50), ColumnID VARCHAR(50))

DECLARE @ColumnSTD VARCHAR(50)
DECLARE @CustomerName VARCHAR(50)
SELECT @CustomerName = CustomerName FROM dbo.CustomerIndex
IF @CustomerName = 44 -- Sa Vi
BEGIN
    EXEC dbo.AP1412_SV @DivisionID = @DivisionID, -- nvarchar(50)
                    @TranMonth = @TranMonth,    -- int
                    @TranYear = @TranYear      -- int
    
END
ELSE
BEGIN
	INSERT INTO #TableSTD
	SELECT 'AT1001', 'CountryID' UNION ALL
	SELECT 'AT1002', 'CityID' UNION ALL
	SELECT 'AT1004', 'CurrencyID' UNION ALL
	SELECT 'AT1005', 'AccountID' UNION ALL
	SELECT 'AT1006', 'GroupID' UNION ALL
	SELECT 'AT1009', 'VATTypeID' UNION ALL
	SELECT 'AT1010', 'VATGroupID' UNION ALL
	SELECT 'AT1206', 'DebtAgeStepID' UNION ALL
	SELECT 'AT1301', 'InventoryTypeID' UNION ALL
	SELECT 'AT1304', 'UnitID' UNION ALL
	SELECT 'AT1201', 'ObjectTypeID'


	SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT [name], REPLACE([name],'STD',''), id FROM sysobjects 
				WHERE xtype='U' AND [name] LIKE '%STD' 
				AND [name] <> 'MT0700STD '-- đã được bắn từ AT1005 (trigger)
				AND [name] <> 'AT1403STD' 
				AND [name] <> 'AT0001STD' 
				AND [name] not like '%0000STD' 
				AND REPLACE([name],'STD','')  not in (	SELECT distinct TAB.Name
									FROM SYSCOLUMNS COL  WITH(NOLOCK)
									INNER JOIN 
									(
										SELECT id, Name 
										FROM sysobjects where name in (
										SELECT REPLACE([name],'STD','') as [name] FROM sysobjects 
													WHERE xtype='U' AND [name] LIKE '%STD' 
													AND REPLACE([name],'STD','')  Not in ('AT0005','AT1007','AT0009','AT1401','AT1402','AT1405') )
									) TAB ON COL.ID = TAB.ID  
									WHERE COL.Name = 'IsCommon')
	OPEN @Cur
	FETCH NEXT FROM @Cur INTO @TableSTD, @Table, @Id
	WHILE @@FETCH_STATUS =0
	BEGIN
		INSERT INTO #Tam (TableID)	 
		EXEC ('SELECT TOP 1 1 FROM '+@TableSTD+'')
		IF EXISTS (SELECT TOP 1 1 FROM #Tam)
		BEGIN
			INSERT INTO #Division (Division)	 
			EXEC ('SELECT TOP 1 [name] FROM syscolumns WHERE id = (SELECT id FROM sysobjects WHERE NAME = '''+@Table+''' ) AND [name] LIKE ''%DivisionID%''')
			IF EXISTS (SELECT TOP 1 1 FROM #Division) SET @Insert = (SELECT TOP 1 Division FROM #Division)
			SET @Insert1 = ''
			SET @Cur1 = CURSOR SCROLL KEYSET FOR
						SELECT [name] FROM syscolumns WHERE id = @Id
			OPEN @Cur1
			FETCH NEXT FROM @Cur1 INTO @ColumnID
			WHILE @@FETCH_STATUS = 0
			BEGIN
				SET @Insert = @Insert + ', ' + @ColumnID
				IF @ColumnID LIKE '%TranMonth%' SET @Insert1 = @Insert1 + STR(@TranMonth) + ', '
				ELSE 
					BEGIN
						IF @ColumnID LIKE '%TranYear%' SET @Insert1 = @Insert1 + STR(@TranYear) + ', '
						ELSE SET @Insert1 = @Insert1 + @ColumnID + ', '
					END
			
				FETCH NEXT FROM @Cur1 INTO @ColumnID
			END
			SET @sSQL = '
			INSERT INTO '+@Table+' ('+@Insert+')
			SELECT '''+@DivisionID+''', '+left(@Insert1, LEN(@Insert1) - 1)+' FROM '+@TableSTD+' '
			EXEC (@sSQL)
			DELETE #Tam
			DELETE FROM #Division
		END	
		FETCH NEXT FROM @Cur INTO @TableSTD, @Table, @Id
	END
	CLOSE @Cur

	SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT [name], REPLACE([name],'STD',''), id FROM sysobjects 
				WHERE xtype='U' AND [name] LIKE '%STD' 
				AND [name] <> 'MT0700STD '-- đã được bắn từ AT1005 (trigger)
				AND [name] <> 'AT1403STD' 
				AND [name] <> 'AT0001STD' 
				AND [name] not like '%0000STD' 
				AND REPLACE([name],'STD','')  in (	SELECT distinct TAB.Name
									FROM SYSCOLUMNS COL  WITH(NOLOCK)
									INNER JOIN 
									(
										SELECT id, Name 
										FROM sysobjects where name in (
										SELECT REPLACE([name],'STD','') as [name] FROM sysobjects 
													WHERE xtype='U' AND [name] LIKE '%STD' 
													AND REPLACE([name],'STD','')  Not in ('AT0005','AT1007','AT0009','AT1401','AT1402','AT1405') )
									) TAB ON COL.ID = TAB.ID  
									WHERE COL.Name = 'IsCommon')
	OPEN @Cur
	FETCH NEXT FROM @Cur INTO @TableSTD, @Table, @Id
	WHILE @@FETCH_STATUS =0
	BEGIN
		INSERT INTO #Tam (TableID)	 
		EXEC ('SELECT TOP 1 1 FROM '+@TableSTD+'')
		IF EXISTS (SELECT TOP 1 1 FROM #Tam)
		BEGIN
			INSERT INTO #Division (Division)	 
			EXEC ('SELECT TOP 1 [name] FROM syscolumns WHERE id = (SELECT id FROM sysobjects WHERE NAME = '''+@Table+''' ) AND [name] LIKE ''%DivisionID%''')
			IF EXISTS (SELECT TOP 1 1 FROM #Division) 
				SET @Insert = (SELECT TOP 1 Division FROM #Division)
			SET @Insert = 'IsCommon, '+@Insert
			SET @Insert1 = ''
			SET @Cur1 = CURSOR SCROLL KEYSET FOR
						SELECT [name] FROM syscolumns WHERE id = @Id
			OPEN @Cur1
			FETCH NEXT FROM @Cur1 INTO @ColumnID
			WHILE @@FETCH_STATUS = 0
			BEGIN
				SET @Insert = @Insert + ', ' + @ColumnID
				IF @ColumnID LIKE '%TranMonth%' SET @Insert1 = @Insert1 + STR(@TranMonth) + ', '
				ELSE 
					BEGIN
						IF @ColumnID LIKE '%TranYear%' SET @Insert1 = @Insert1 + STR(@TranYear) + ', '
						ELSE SET @Insert1 = @Insert1 + @ColumnID + ', '
					END
			
				FETCH NEXT FROM @Cur1 INTO @ColumnID
			END

			SET @ColumnSTD = (SELECT TOP 1 ColumnID FROM #TableSTD WHERE TableID = @Table)

			SET @sSQL = '
			SET XACT_ABORT ON
			BEGIN TRAN
			BEGIN TRY
				DELETE FROM '+@Table+' WHERE '+@ColumnSTD+' IN (SELECT '+@ColumnSTD+' FROM '+@TableSTD+')
				INSERT INTO '+@Table+' ('+@Insert+')
				SELECT 1, ''@@@'', '+left(@Insert1, LEN(@Insert1) - 1)+' FROM '+@TableSTD+' 
			COMMIT
			END TRY
			BEGIN CATCH
			   IF(@@TRANCOUNT > 0)
					ROLLBACK;
			   THROW; -- raise error to the client
			END CATCH	
			'
			EXEC (@sSQL)
			DELETE #Tam
			DELETE FROM #Division
			--print @sSQL
		END	
		FETCH NEXT FROM @Cur INTO @TableSTD, @Table, @Id
	END
	CLOSE @Cur


	--BEGIN

	--	--Insert dữ liệu từ các bản standar vào table 
	--	IF (EXISTS(SELECT * FROM A00004STD))	
	--		BEGIN
	--			INSERT INTO A00004(DivisionID, ModuleID, ScreenID, CommandMenu)
	--			SELECT @DivisionID, ModuleID, ScreenID, CommandMenu FROM A00004STD;
	--		END
	
	--	IF (EXISTS(SELECT * FROM AT0002STD))	
	--		BEGIN
	--			INSERT INTO AT0002 (DivisionID, TableID, IsAutomatic, IsS1, IsS2, IsS3, S1, S2, S3, Length, OutputOrder, IsSeparator, Separator)
	--			SELECT @DivisionID, TableID, IsAutomatic, IsS1, IsS2, IsS3, S1, S2, S3, Length, OutputOrder, IsSeparator, Separator FROM AT0002STD;
	--		END

	--	IF (EXISTS(SELECT * FROM AT0005STD))	
	--		BEGIN
	--			INSERT INTO AT0005 (DivisionID, TypeID, SystemName, UserName, IsUsed, UserNameE, Status)	
	--			SELECT @DivisionID, TypeID, SystemName, UserName, IsUsed, UserNameE, Status FROM AT0005STD
	--		END
	--		IF (EXISTS(SELECT * FROM AT0005STD))	
	--		BEGIN
	--			INSERT INTO WT0005 (DivisionID, TypeID, SystemName, UserName, IsUsed, UserNameE)	
	--			SELECT @DivisionID, TypeID, SystemName, UserName, IsUsed, UserNameE FROM AT0005STD
	--		END
		
		
	--	IF (EXISTS(SELECT * FROM AT0006STD))	
	--		BEGIN	
	--			INSERT INTO AT0006 (DivisionID, AccountID, D_C)
	--			SELECT @DivisionID, AccountID, D_C FROM AT0006STD
	--		END
	
	--	IF (EXISTS(SELECT * FROM AT1001STD))	
	--		BEGIN	
	--			INSERT INTO AT1001 (DivisionID, CountryID, CountryName, Disabled, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID)
	--			SELECT @DivisionID, CountryID, CountryName, Disabled, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID FROM AT1001STD
	--		END

	--	IF (EXISTS(SELECT * FROM AT1002STD))	
	--		BEGIN
	--			INSERT INTO AT1002 (DivisionID, CityID, CityName, Disabled, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID)
	--			SELECT @DivisionID, CityID, CityName, Disabled, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID FROM AT1002STD 
	--		END
		
	--	IF (EXISTS(SELECT * FROM AT1004STD))	
	--		BEGIN
	--			INSERT INTO AT1004 (DivisionID, CurrencyID, CurrencyName, ExchangeRate, Operator, Disabled, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID, ExchangeRateDecimal, DecimalName, UnitName)
	--			SELECT @DivisionID, CurrencyID, CurrencyName, ExchangeRate, Operator, Disabled, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID, ExchangeRateDecimal, DecimalName, UnitName FROM AT1004STD
	--		END
		
	--	IF (EXISTS(SELECT * FROM AT1005STD))	
	--		BEGIN	
	--			INSERT INTO AT1005 (DivisionID, AccountID, AccountName, Notes1, Notes2, GroupID, SubGroupID, IsBalance, IsDebitBalance, IsObject, IsNotShow, Disabled, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID, AccountNameE)
	--			SELECT @DivisionID, AccountID, AccountName, Notes1, Notes2, GroupID, SubGroupID, IsBalance, IsDebitBalance, IsObject, IsNotShow, Disabled, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID, AccountNameE FROM AT1005STD
	--		END

	--	IF (EXISTS(SELECT * FROM AT1006STD))	
	--		BEGIN	
	--			INSERT INTO AT1006 (DivisionID, GroupID, GroupName, Disabled)
	--			SELECT @DivisionID, GroupID, GroupName, Disabled FROM AT1006STD
	--		END	

	--	IF (EXISTS(SELECT * FROM AT1007STD))	
	--		BEGIN
	--			INSERT INTO AT1007 (DivisionID, VoucherTypeID, VoucherTypeName, Disabled, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, IsDefault, DebitAccountID, CreditAccountID, ObjectID, WareHouseID, VDescription, TDescription, BDescription, Auto, S1, S2, S3, OutputOrder, OutputLength, Separated, separator, S1Type, S2Type, S3Type, Enabled1, Enabled2, Enabled3, Enabled, VoucherGroupID, BankAccountID, BankName, IsVAT, VATTypeID, IsBDescription, IsTDescription)
	--			SELECT @DivisionID, VoucherTypeID, VoucherTypeName, Disabled, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, IsDefault, DebitAccountID, CreditAccountID, ObjectID, WareHouseID, VDescription, TDescription, BDescription, Auto, S1, S2, S3, OutputOrder, OutputLength, Separated, separator, S1Type, S2Type, S3Type, Enabled1, Enabled2, Enabled3, Enabled, VoucherGroupID, BankAccountID, BankName, IsVAT, VATTypeID, IsBDescription, IsTDescription FROM AT1007STD
	--		END	

	--	IF (EXISTS(SELECT * FROM AT1008STD))	
	--		BEGIN	
	--			INSERT INTO AT1008 (DivisionID, TransactionTypeID, Description, DescriptionE)
	--			SELECT @DivisionID, TransactionTypeID, Description, DescriptionE FROM AT1008STD
	--		END

	--	IF (EXISTS(SELECT * FROM AT1009STD))	
	--		BEGIN	
	--			INSERT INTO AT1009 (DivisionID, VATTypeID, VATTypeName, IsVATIn, Disabled, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID)
	--			SELECT @DivisionID, VATTypeID, VATTypeName, IsVATIn, Disabled, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID FROM AT1009STD
	--		END

	--	IF (EXISTS(SELECT * FROM AT1010STD))	
	--		BEGIN	
	--			INSERT INTO AT1010 (DivisionID, VATGroupID, VATRate, VATGroupName, Disabled, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID)
	--			SELECT @DivisionID, VATGroupID, VATRate, VATGroupName, Disabled, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID FROM AT1010STD
	--		END			

	--	IF (EXISTS(SELECT * FROM AT1017STD))	
	--		BEGIN		
	--			INSERT INTO AT1017 (DivisionID, VoucherGroupID, Description, Disabled, IsUsed)
	--			SELECT @DivisionID, VoucherGroupID, Description, Disabled, IsUsed FROM AT1017STD
	--		END

	--	IF (EXISTS(SELECT * FROM AT1201STD))	
	--		BEGIN	
	--			INSERT INTO AT1201 (DivisionID, ObjectTypeID, ObjectTypeName, Disabled, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID)
	--			SELECT @DivisionID, ObjectTypeID, ObjectTypeName, Disabled, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID FROM AT1201STD
	--		END
	
	--	IF (EXISTS(SELECT * FROM AT1206STD))	
	--		BEGIN		
	--			INSERT INTO AT1206 (DivisionID, DebtAgeStepID, AgeID, Description, Orders, FromDay, ToDay, Title, DefinedUserID, Disabled, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID)
	--			SELECT @DivisionID, DebtAgeStepID, AgeID, Description, Orders, FromDay, ToDay, Title, DefinedUserID, Disabled, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID FROM AT1206STD
	--		END

	--	IF (EXISTS(SELECT * FROM AT1301STD))	
	--		BEGIN
	--			INSERT INTO AT1301 (DivisionID, InventoryTypeID, InventoryTypeName, Disabled, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID)
	--			SELECT @DivisionID, InventoryTypeID, InventoryTypeName, Disabled, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID FROM AT1301STD
	--		END

	--	IF (EXISTS(SELECT * FROM AT1304STD))	
	--		BEGIN	
	--			INSERT INTO AT1304 (DivisionID, UnitID, UnitName, Disabled, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID)
	--			SELECT @DivisionID, UnitID, UnitName, Disabled, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID FROM AT1304STD
	--		END
		
	--	IF (EXISTS(SELECT * FROM AT1305STD))	
	--		BEGIN		
	--			INSERT INTO AT1305 (DivisionID, ReDeTypeID, ReDeTypeName, Disabled, IsReceived, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID)
	--			SELECT @DivisionID, ReDeTypeID, ReDeTypeName, Disabled, IsReceived, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID FROM AT1305STD
	--		END

	--	IF (EXISTS(SELECT * FROM AT1306STD))	
	--		BEGIN		
	--			INSERT INTO AT1306 (DivisionID, ClassifyTypeID, Caption, Disabled)
	--			SELECT @DivisionID, ClassifyTypeID, Caption, Disabled FROM AT1306STD 
	--		END

	--	/*	
	--	IF (EXISTS(SELECT * FROM AT1403STD))	
	--		BEGIN	
	--			INSERT INTO AT1403 (DivisionID, ScreenID, GroupID, ModuleID, IsAddNew, IsUpdate, IsDelete, IsView, IsPrint, CreateDate, CreateUserID, LastModifyUserID, LastModifyDate)
	--			SELECT @DivisionID, ScreenID, GroupID, ModuleID, IsAddNew, IsUpdate, IsDelete, IsView, IsPrint, CreateDate, CreateUserID, LastModifyUserID, LastModifyDate FROM AT1403STD
	--		END
	--	*/
	
	--	IF (EXISTS(SELECT * FROM AT1404STD))	
	--		BEGIN	
	--			INSERT INTO AT1404 (DivisionID, ModuleID, ScreenID, ScreenName, ScreenType, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	--			SELECT @DivisionID, ModuleID, ScreenID, ScreenName, ScreenType, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate FROM AT1404STD
	--		END

	--	IF (EXISTS(SELECT * FROM AT1401STD))	
	--		BEGIN
	--			INSERT INTO AT1401 (DivisionID, GroupID, GroupName, Disabled, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID) 
	--			SELECT @DivisionID, GroupID, GroupName, Disabled, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID FROM AT1401STD
	--		END

	--	IF (EXISTS(SELECT * FROM AT1402STD))	
	--		BEGIN	
	--			INSERT INTO AT1402 (DivisionID, GroupID, UserID)
	--			SELECT @DivisionID, GroupID, UserID FROM AT1402STD
	--		END

	--	IF (EXISTS(SELECT * FROM AT1405STD))	
	--		BEGIN	
	--			INSERT INTO AT1405 (DivisionID, UserID, UserName, Password, Disabled, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate) 
	--			SELECT @DivisionID, UserID, UserName, Password, Disabled, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate FROM AT1405STD
	--		END
	
	--	IF (EXISTS(SELECT * FROM AT1408STD))	
	--		BEGIN	
	--			INSERT INTO AT1408 (DivisionID, DataTypeID, DataTypeName, DataTypeNameE)
	--			SELECT @DivisionID, DataTypeID, DataTypeName, DataTypeNameE FROM AT1408STD
	--		END

	--	IF (EXISTS(SELECT * FROM AT1409STD))	
	--		BEGIN	
	--			INSERT INTO AT1409 (DivisionID, ModuleID, Description, DescriptionE)
	--			SELECT @DivisionID, ModuleID, Description, DescriptionE FROM AT1409STD 
	--		END	

	--	IF (EXISTS(SELECT * FROM AT1410STD))	
	--		BEGIN	
	--			INSERT INTO AT1410 (DivisionID, ModuleID, ModuleName, ModuleNameE, GroupID, Status)
	--			SELECT @DivisionID, ModuleID, ModuleName, ModuleNameE, GroupID, Status FROM AT1410STD
	--		END
	
	--	IF (EXISTS(SELECT * FROM AT1502STD))	
	--		BEGIN	
	--			INSERT INTO AT1502 (DivisionID, SourceID, SourceName, Disabled, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID)
	--			SELECT @DivisionID, SourceID, SourceName, Disabled, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID FROM AT1502STD
	--		END
			
	--	IF (EXISTS(SELECT * FROM AT1598STD))	
	--		BEGIN	
	--			INSERT INTO AT1598 (DivisionID, ReportCode, ReportName, ReportTitle, AmountFormat, BracketNegative, ReportID, IsCustomized, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID)
	--			SELECT @DivisionID, ReportCode, ReportName, ReportTitle, AmountFormat, BracketNegative, ReportID, IsCustomized, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID FROM AT1598STD
	--		END	
			
	--	IF (EXISTS(SELECT * FROM AT1599STD))	
	--		BEGIN	
	--			INSERT INTO AT1599 (DivisionID, LineID, ReportCode, LineDescription, AccountIDFrom, AccountIDTo, D_C, Detail, Method, TypeValues, Cause, Level1, PrintStatus, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID, LineDescriptionE, Notes, Sign, NowstatusID)
	--			SELECT @DivisionID, LineID, ReportCode, LineDescription, AccountIDFrom, AccountIDTo, D_C, Detail, Method, TypeValues, Cause, Level1, PrintStatus, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID, LineDescriptionE, Notes, Sign, NowstatusID FROM AT1599STD
	--		END	
			
	--	IF (EXISTS(SELECT * FROM AT4700STD))	
	--		BEGIN	
	--			INSERT INTO AT4700 (DivisionID, ReportCode, ReportName1, ReportName2, Selection01, Selection02, Selection03, Selection04, Selection05, Level01, Level02, Level03, BracketNegative, DecimalPlaces, AmountFormat, Customized, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, Disabled, ReportID, LineZeroSuppress, Level00)
	--			SELECT @DivisionID, ReportCode, ReportName1, ReportName2, Selection01, Selection02, Selection03, Selection04, Selection05, Level01, Level02, Level03, BracketNegative, DecimalPlaces, AmountFormat, Customized, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, Disabled, ReportID, LineZeroSuppress, Level00 FROM AT4700STD
	--		END
	
	--	IF (EXISTS(SELECT * FROM AT4701STD))	
	--		BEGIN	
	--			INSERT INTO AT4701 (DivisionID, ReportCode, ColumnID, ColumnType, IsOriginal, ColumnBudget, FromAccountID, ToAccountID, FromCoAccountID, ToCorAccountID, IsUsed, ColumnCaption, ColumnID1, ColumnID2, ColumnID3, ColumnID4, Sign1, Sign2, Sign3, Sign4)
	--			SELECT @DivisionID, ReportCode, ColumnID, ColumnType, IsOriginal, ColumnBudget, FromAccountID, ToAccountID, FromCoAccountID, ToCorAccountID, IsUsed, ColumnCaption, ColumnID1, ColumnID2, ColumnID3, ColumnID4, Sign1, Sign2, Sign3, Sign4 FROM AT4701STD
	--		END
	
	--	IF (EXISTS(SELECT * FROM AT4710STD))	
	--		BEGIN	
	--			INSERT INTO AT4710 (DivisionID, ReportCode, ReportName1, ReportName2, Title, ReportID, Disabled, IsReceivable, IsDetail, DateType, GetColumnTitle, DebtAgeStepID, Group1ID, Group2ID, Group3ID, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, Selection01ID, Selection02ID, Selection03ID)
	--			SELECT @DivisionID, ReportCode, ReportName1, ReportName2, Title, ReportID, Disabled, IsReceivable, IsDetail, DateType, GetColumnTitle, DebtAgeStepID, Group1ID, Group2ID, Group3ID, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, Selection01ID, Selection02ID, Selection03ID FROM AT4710STD
	--		END
					
	--	IF (EXISTS(SELECT * FROM AT6000STD))	
	--		BEGIN	
	--			INSERT INTO AT6000 (DivisionID, Code, Description, Type, Orders, Disabled, IsASOFTFA)
	--			SELECT @DivisionID, Code, Description, Type, Orders, Disabled, IsASOFTFA FROM AT6000STD
	--		END
		
	--	IF (EXISTS(SELECT * FROM AT6100STD))	
	--		BEGIN	
	--			INSERT INTO AT6100 (DivisionID, ReportCode, ReportName1, ReportName2, IsUsedColA, IsUsedColB, IsUsedColC, IsUsedColD, IsUsedColE, ColumnACaption, ColumnBCaption, ColumnCCaption, ColumnDCaption, ColumnECaption, ColumnABudget, ColumnBBudget, ColumnCBudget, ColumnDBudget, ColumnEBudget, Selection01, Selection02, Selection03, Selection04, Selection05, Level01, Level02, BracketNegative, DecimalPlaces, AmountFormat, Customized, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, Disabled, ReportID, LineZeroSuppress)
	--			SELECT @DivisionID, ReportCode, ReportName1, ReportName2, IsUsedColA, IsUsedColB, IsUsedColC, IsUsedColD, IsUsedColE, ColumnACaption, ColumnBCaption, ColumnCCaption, ColumnDCaption, ColumnECaption, ColumnABudget, ColumnBBudget, ColumnCBudget, ColumnDBudget, ColumnEBudget, Selection01, Selection02, Selection03, Selection04, Selection05, Level01, Level02, BracketNegative, DecimalPlaces, AmountFormat, Customized, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, Disabled, ReportID, LineZeroSuppress FROM AT6100STD
	--		END
	
	--	IF (EXISTS(SELECT * FROM AT6101STD))	
	--		BEGIN	
	--			INSERT INTO AT6101 (DivisionID, ReportCode, LineID, LineCode, LineDescription, AccountIDFrom, AccountIDTo, CorAccountIDFrom, CorAccountIDTo, LineType, BreakDetail, AmountSign, AccuSign, Accumulator, Accumulator1, Accumulator2, PrintStatus, Type, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, IsAccount, LevelID, Sign)
	--			SELECT @DivisionID, ReportCode, LineID, LineCode, LineDescription, AccountIDFrom, AccountIDTo, CorAccountIDFrom, CorAccountIDTo, LineType, BreakDetail, AmountSign, AccuSign, Accumulator, Accumulator1, Accumulator2, PrintStatus, Type, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, IsAccount, LevelID, Sign FROM AT6101STD
	--		END	
			
	--	IF (EXISTS(SELECT * FROM AT6501STD))	
	--		BEGIN	
	--			INSERT INTO AT6501 (DivisionID, ReportCode, ReportName1, ReportName2, ReportID, BracketNegative, AmountFormat, Customized, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	--			SELECT @DivisionID, ReportCode, ReportName1, ReportName2, ReportID, BracketNegative, AmountFormat, Customized, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate FROM AT6501STD
	--		END
	
	--	IF (EXISTS(SELECT * FROM AT6502STD))	
	--		BEGIN	
	--			INSERT INTO AT6502 (DivisionID, ReportCode, LineCode, LineDescription, PrintCode, AccountIDFrom, AccountIDTo, CorAccountIDFrom, CorAccountIDTo, D_C, AmountSign, PeriodAmount, AccuSign, Accumulator, Level1, Suppress, PrintStatus, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, LineDescriptionE)
	--			SELECT @DivisionID, ReportCode, LineCode, LineDescription, PrintCode, AccountIDFrom, AccountIDTo, CorAccountIDFrom, CorAccountIDTo, D_C, AmountSign, PeriodAmount, AccuSign, Accumulator, Level1, Suppress, PrintStatus, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, LineDescriptionE FROM AT6502STD 
	--		END	
			
	--	IF (EXISTS(SELECT * FROM AT7410STD))	
	--		BEGIN	
	--			INSERT INTO AT7410 (DivisionID, ReportCode, ReportName1, ReportName2, IsTax, TaxAccountID1From, TaxAccountID1To, TaxAccountID2From, TaxAccountID2To, TaxAccountID3From, TaxAccountID3To, NetAccountID1From, NetAccountID1To, NetAccountID2From, NetAccountID2To, NetAccountID3From, NetAccountID3To, NetAccountID4From, NetAccountID4To, NetAccountID5From, NetAccountID5To, VoucherTypeIDFrom, VoucherTypeIDTo, IsVATType, VATTypeID1, VATTypeID2, VATTypeID3, VATTypeID, IsVATGroup, VATGroupID1, VATGroupID2, VATGroupID3, VATGroupIDFrom, VATGroupIDTo, VATObjectTypeID, VATObjectIDFrom, VATObjectIDTo, VoucherTypeID, ReportID, CreateUserID, LastModifyUserID, CreateDate, LastModifyDate, Disabled, IsVATIn, ObjectIDFrom, ObjectIDTo, Order1, Order2, Order3, Order4, VATTypeID4, VATGroupID4)
	--			SELECT @DivisionID, ReportCode, ReportName1, ReportName2, IsTax, TaxAccountID1From, TaxAccountID1To, TaxAccountID2From, TaxAccountID2To, TaxAccountID3From, TaxAccountID3To, NetAccountID1From, NetAccountID1To, NetAccountID2From, NetAccountID2To, NetAccountID3From, NetAccountID3To, NetAccountID4From, NetAccountID4To, NetAccountID5From, NetAccountID5To, VoucherTypeIDFrom, VoucherTypeIDTo, IsVATType, VATTypeID1, VATTypeID2, VATTypeID3, VATTypeID, IsVATGroup, VATGroupID1, VATGroupID2, VATGroupID3, VATGroupIDFrom, VATGroupIDTo, VATObjectTypeID, VATObjectIDFrom, VATObjectIDTo, VoucherTypeID, ReportID, CreateUserID, LastModifyUserID, CreateDate, LastModifyDate, Disabled, IsVATIn, ObjectIDFrom, ObjectIDTo, Order1, Order2, Order3, Order4, VATTypeID4, VATGroupID4 FROM AT7410STD
	--		END
					
	--	IF (EXISTS(SELECT * FROM AT7420STD))	
	--		BEGIN	
	--			INSERT INTO AT7420 (DivisionID, LineID,IsIn,IsShow,IsTurnOver,IsTax,IsAccumulated,Sign,AccumulateLineID1,
	--						AccumulateLineID2,TurnOverCode,TaxCode,IsBold,[Description],Note,TOAccountID1From,
	--						TOAccountID1To,TOAccountID2From,TOAccountID2To,TOAccountID3From,TOAccountID3To,
	--						TOAccountID4From,TOAccountID4To,TOAccountID5From,TOAccountID5To,TOInvoiceTypeFrom,
	--						TOInvoiceTypeTo,TOVATGroupFrom,TOVATGroupTo,TOVoucherTypeFrom,TOVoucherTypeTo,
	--						VATAccountID1From,VATAccountID1To,VATAccountID2From,VATAccountID2To,
	--						VATAccountID3From,VATAccountID3To,VATInvoiceTypeFrom,VATInvoiceTypeTo,
	--						VATGroupFrom,VATGroupTo,VATVoucherTypeFrom,VATVoucherTypeTo,CreateDate,
	--						CreateUserID,LastModifyDate,LastModifyUserID)
	--			SELECT @DivisionID, LineID,IsIn,IsShow,IsTurnOver,IsTax,IsAccumulated,Sign,AccumulateLineID1,
	--						AccumulateLineID2,TurnOverCode,TaxCode,IsBold,Description,Note,TOAccountID1From,
	--						TOAccountID1To,TOAccountID2From,TOAccountID2To,TOAccountID3From,TOAccountID3To,
	--						TOAccountID4From,TOAccountID4To,TOAccountID5From,TOAccountID5To,TOInvoiceTypeFrom,
	--						TOInvoiceTypeTo,TOVATGroupFrom,TOVATGroupTo,TOVoucherTypeFrom,TOVoucherTypeTo,
	--						VATAccountID1From,VATAccountID1To,VATAccountID2From,VATAccountID2To,
	--						VATAccountID3From,VATAccountID3To,VATInvoiceTypeFrom,VATInvoiceTypeTo,
	--						VATGroupFrom,VATGroupTo,VATVoucherTypeFrom,VATVoucherTypeTo,CreateDate,
	--						CreateUserID,LastModifyDate,LastModifyUserID
	--			FROM AT7420STD			
	--		END
					
	--	IF (EXISTS(SELECT * FROM AT7433STD))	
	--		BEGIN	
	--			INSERT INTO AT7433 (DivisionID, ReportCode, ReportName, ReportID, Disabled, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID)
	--			SELECT @DivisionID, ReportCode, ReportName, ReportID, Disabled, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID FROM AT7433STD 
	--		END
	
	--	IF (EXISTS(SELECT * FROM AT7434STD))	
	--		BEGIN				
	--			INSERT INTO AT7434 (DivisionID, LineID, Type, ReportCodeID, OrderNo, Orders, IsNotPrint, LineDescription, IsBold, IsGray, IsAmount, Method, AmountCode, CalculatorID, VATGroup, VATTypeID1, VATTypeID2, VATTypeID3, AccumulatorID, FromAccountID1, ToAccountID1, FromCorAccountID1, ToCorAccountID1, FromAccountID2, ToAccountID2, FromCorAccountID2, ToCorAccountID2, FromAccountID3, ToAccountID3, FromCorAccountID3, ToCorAccountID3, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID, Sign)
	--			SELECT @DivisionID, LineID, Type, ReportCodeID, OrderNo, Orders, IsNotPrint, LineDescription, IsBold, IsGray, IsAmount, Method, AmountCode, CalculatorID, VATGroup, VATTypeID1, VATTypeID2, VATTypeID3, AccumulatorID, FromAccountID1, ToAccountID1, FromCorAccountID1, ToCorAccountID1, FromAccountID2, ToAccountID2, FromCorAccountID2, ToCorAccountID2, FromAccountID3, ToAccountID3, FromCorAccountID3, ToCorAccountID3, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID, Sign FROM AT7434STD
	--		END	
			
	--	IF (EXISTS(SELECT * FROM AT7601STD))	
	--		BEGIN
	--			INSERT INTO AT7601 (DivisionID, ReportCode, ReportName1, ReportName2, ReportID, ReportID2, ReportID3, BracketNegative, AmountFormat, Customized, Column01_1, Column01_2, Column01_3, Column01_4, Column01_5, Column02_1, Column02_2, Column02_3, Column02_4, Column02_5, Column02_6, Column02_7, Column02_8, Column02_9, Column03_1, Column03_2, Column03_4, Column03_5, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, Disabled)
	--			SELECT @DivisionID, ReportCode, ReportName1, ReportName2, ReportID, ReportID2, ReportID3, BracketNegative, AmountFormat, Customized, Column01_1, Column01_2, Column01_3, Column01_4, Column01_5, Column02_1, Column02_2, Column02_3, Column02_4, Column02_5, Column02_6, Column02_7, Column02_8, Column02_9, Column03_1, Column03_2, Column03_4, Column03_5, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, Disabled FROM AT7601STD
	--		END
	
	--	IF (EXISTS(SELECT * FROM AT7602STD))	
	--		BEGIN
	--			INSERT INTO AT7602 (DivisionID, ReportCode, Type, LineCode, LineDescription, PrintCode, AccountIDFrom, AccountIDTo, CorAccountIDFrom, CorAccountIDTo, D_C, AmountSign, PeriodAmount, AccuSign, Accumulator, Level1, Suppress, PrintStatus, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, ColStatus01, ColStatus02, ColStatus03, ColStatus04, ColStatus05, ColStatus06, IsLastPeriod, LineDescriptionE)
	--			SELECT @DivisionID, ReportCode, Type, LineCode, LineDescription, PrintCode, AccountIDFrom, AccountIDTo, CorAccountIDFrom, CorAccountIDTo, D_C, AmountSign, PeriodAmount, AccuSign, Accumulator, Level1, Suppress, PrintStatus, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, ColStatus01, ColStatus02, ColStatus03, ColStatus04, ColStatus05, ColStatus06, IsLastPeriod, LineDescriptionE FROM AT7602STD
	--		END
							
	--	IF (EXISTS(SELECT * FROM AT7801STD))	
	--		BEGIN
	--			INSERT INTO AT7801 (DivisionID, AllocationID, AllocationDesc, EmployeeID, Disabled, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	--			SELECT @DivisionID, AllocationID, AllocationDesc, EmployeeID, Disabled, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate FROM AT7801STD
	--		END
		
	--	IF (EXISTS(SELECT * FROM AT7802STD))	
	--		BEGIN
	--			INSERT INTO AT7802 (DivisionID, AllocationID, SequenceID, SequenceDesc, SourceAccountIDFrom, SourceAccountIDTo, TargetAccountID, SourceAmountID, AllocationMode, VoucherTypeID, Percentage)
	--			SELECT @DivisionID, AllocationID, SequenceID, SequenceDesc, SourceAccountIDFrom, SourceAccountIDTo, TargetAccountID, SourceAmountID, AllocationMode, VoucherTypeID, Percentage FROM AT7802STD 
	--		END
		
	--	IF (EXISTS(SELECT * FROM AT7901STD))	
	--		BEGIN
	--			INSERT INTO AT7901 (DivisionID, ReportCode, ReportName, ReportTitle, AmountFormat, BracketNegative, ReportID, IsCustomized, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID)
	--			SELECT @DivisionID, ReportCode, ReportName, ReportTitle, AmountFormat, BracketNegative, ReportID, IsCustomized, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID FROM AT7901STD
	--		END
		
	--	IF (EXISTS(SELECT * FROM AT7902STD))	
	--		BEGIN
	--			INSERT INTO AT7902 (DivisionID, LineID, ReportCode, Type, LineCode, LineDescription, AccountIDFrom, AccountIDTo, D_C, Detail, ParrentLineID, Accumulator, Level1, PrintStatus, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID, LineDescriptionE, Notes)
	--			SELECT @DivisionID, LineID, ReportCode, Type, LineCode, LineDescription, AccountIDFrom, AccountIDTo, D_C, Detail, ParrentLineID, Accumulator, Level1, PrintStatus, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID, LineDescriptionE, Notes FROM AT7902STD
	--		END
		
	--	IF (EXISTS(SELECT * FROM AT8000STD))	
	--		BEGIN
	--			INSERT INTO AT8000 (DivisionID, SectionID, IsShow, Section, FontDetail, FontName, FontSize, FontType, Content, Alignment, IsLock, IsHide, PrintGridLine, TopMargin, BottomMargin, LeftMargin, RightMargin, Path)
	--			SELECT @DivisionID, SectionID, IsShow, Section, FontDetail, FontName, FontSize, FontType, Content, Alignment, IsLock, IsHide, PrintGridLine, TopMargin, BottomMargin, LeftMargin, RightMargin, Path FROM AT8000STD 
	--		END
		
	--	IF (EXISTS(SELECT * FROM AT8001STD))	
	--		BEGIN
	--			INSERT INTO AT8001 (DivisionID, Code, Type, Language, Description, Disabled)
	--			SELECT @DivisionID, Code, Type, Language, Description, Disabled FROM AT8001STD
	--		END
	
	--	IF (EXISTS(SELECT * FROM AT8888STD))	
	--		BEGIN
	--			INSERT INTO AT8888 (DivisionID, ReportID, ReportName, Title, GroupID, Type, Disabled, SQLstring, Orderby, Description, DescriptionE, TitleE, ReportNameE)
	--			SELECT @DivisionID, ReportID, ReportName, Title, GroupID, Type, Disabled, SQLstring, Orderby, Description, DescriptionE, TitleE, ReportNameE FROM AT8888STD 
	--		END
	
	--	IF (EXISTS(SELECT * FROM AT9011STD))	
	--		BEGIN
	--			INSERT INTO AT9011 (DivisionID, ColumnID, ColumnName, SysColumnName, Orders, IsChosen)
	--			SELECT @DivisionID, ColumnID, ColumnName, SysColumnName, Orders, IsChosen FROM AT9011STD
	--		END	
			
	--	IF (EXISTS(SELECT * FROM CT0005STD))	
	--		BEGIN
	--			INSERT INTO CT0005 (DivisionID, TypeID, SystemName, UserName, IsUsed, UserNameE)
	--			SELECT @DivisionID, TypeID, SystemName, UserName, IsUsed, UserNameE FROM CT0005STD
	--		END	
			
	--	IF (EXISTS(SELECT * FROM CT2222STD))	
	--		BEGIN
	--			INSERT INTO CT2222 (DivisionID, TablesName, Description, FieldID, Type, Orders, Disabled)
	--			SELECT @DivisionID, TablesName, Description, FieldID, Type, Orders, Disabled FROM CT2222STD
	--		END	
				
	--	IF (EXISTS(SELECT * FROM CT8888STD))	
	--		BEGIN
	--			INSERT INTO CT8888 (DivisionID, ReportID, ReportName, Title, GroupID, Type, Disabled, SQLstring, Orderby, Description, DescriptionE, TitleE, ReportNameE)
	--			SELECT @DivisionID, ReportID, ReportName, Title, GroupID, Type, Disabled, SQLstring, Orderby, Description, DescriptionE, TitleE, ReportNameE FROM CT8888STD
	--		END
					
	--	IF (EXISTS(SELECT * FROM HT0001STD))	
	--		BEGIN
	--			INSERT INTO HT0001 (DivisionID, TargetTypeID, TargetName, Caption, IsUsed, IsAmount)
	--			SELECT @DivisionID, TargetTypeID, TargetName, Caption, IsUsed, IsAmount FROM HT0001STD
	--		END
					
	--	IF (EXISTS(SELECT * FROM HT0002STD))	
	--		BEGIN	
	--			INSERT INTO HT0002 (DivisionID, IncomeID, FieldName, IncomeName, Caption, IsUsed, IsTax)
	--			SELECT @DivisionID, IncomeID, FieldName, IncomeName, Caption, IsUsed, IsTax FROM HT0002STD
	--		END
	
	--	IF (EXISTS(SELECT * FROM HT0003STD))	
	--		BEGIN	
	--			INSERT INTO HT0003 (DivisionID, CoefficientID, FieldName, CoefficientName, Caption, IsUsed)
	--			SELECT @DivisionID, CoefficientID, FieldName, CoefficientName, Caption, IsUsed FROM HT0003STD
	--		END
	
	--	IF (EXISTS(SELECT * FROM HT0005STD))	
	--		BEGIN	
	--			INSERT INTO HT0005 (DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName)
	--			SELECT @DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName FROM HT0005STD 
	--		END
		
	--	IF (EXISTS(SELECT * FROM HT0006STD))	
	--		BEGIN	
	--			INSERT INTO HT0006 (DivisionID, DefineID, DefineCaption, DefineCaptionE, ParentID, IsUsed)
	--			SELECT @DivisionID, DefineID, DefineCaption, DefineCaptionE, ParentID, IsUsed FROM HT0006STD
	--		END
	--	IF (EXISTS(SELECT * FROM HT0017STD))	
	--		BEGIN	
	--			INSERT INTO HT0017 (DivisionID, [ParaID], [Parameter], [ParameterE], [Position], [Width], [IsUsed], [ViewIndex])
	--			SELECT @DivisionID, [ParaID], [Parameter], [ParameterE], [Position], [Width], [IsUsed], [ViewIndex] FROM HT0017STD
	--		END
	--	IF (EXISTS(SELECT * FROM HT0018STD))	
	--		BEGIN	
	--			INSERT INTO HT0018 (DivisionID, [ImportMethod], [Tab_char], [Space_char], [Semilicon_char], [Comma_char], [Others_char], [Others_Define], [S_InCode], [S_OutCode])
	--			SELECT @DivisionID, [ImportMethod], [Tab_char], [Space_char], [Semilicon_char], [Comma_char], [Others_char], [Others_Define], [S_InCode], [S_OutCode] FROM HT0018STD
	--		END
	
	--	IF (EXISTS(SELECT * FROM HT1000STD))	
	--		BEGIN	
	--			INSERT INTO HT1000 (DivisionID, MethodID, SystemName, UserName, Description, IsDivision, IsUsed)
	--			SELECT @DivisionID, MethodID, SystemName, UserName, Description, IsDivision, IsUsed FROM HT1000STD
	--		END	
			
	--	IF (EXISTS(SELECT * FROM HT1000STD))	
	--		BEGIN	
	--			INSERT INTO HT1001 (DivisionID, EthnicID, EthnicName, Disabled, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	--			SELECT @DivisionID, EthnicID, EthnicName, Disabled, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate FROM HT1001STD
	--		END
			
	--	IF (EXISTS(SELECT * FROM HT1002STD))	
	--		BEGIN	
	--			INSERT INTO HT1002 (DivisionID, ReligionID, ReligionName, Disabled, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	--			SELECT @DivisionID, ReligionID, ReligionName, Disabled, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate FROM HT1002STD
	--		END	
			
	--	IF (EXISTS(SELECT * FROM HT1005STD))	
	--		BEGIN
	--			INSERT INTO HT1005 (DivisionID, EducationLevelID, EducationLevelName, Disabled, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, RaceEducation)
	--			SELECT @DivisionID, EducationLevelID, EducationLevelName, Disabled, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, RaceEducation FROM HT1005STD
	--		END
			
	--	IF (EXISTS(SELECT * FROM HT1006STD))	
	--		BEGIN	
	--			INSERT INTO HT1006 (DivisionID, LanguageID, LanguageName, Disabled, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	--			SELECT @DivisionID, LanguageID, LanguageName, Disabled, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate FROM HT1006STD
	--		END
					
	--	IF (EXISTS(SELECT * FROM HT1007STD))	
	--		BEGIN	
	--			INSERT INTO HT1007 (DivisionID, LanguageLevelID, LanguageLevelName, Disabled, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	--			SELECT @DivisionID, LanguageLevelID, LanguageLevelName, Disabled, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate FROM HT1007STD
	--		END	
			
	--	IF (EXISTS(SELECT * FROM HT1010STD))	
	--		BEGIN	
	--			INSERT INTO HT1010 (DivisionID, PoliticsID, PoliticsName, Disabled, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	--			SELECT @DivisionID, PoliticsID, PoliticsName, Disabled, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate FROM HT1010STD
	--		END		
			
	--	IF (EXISTS(SELECT * FROM HT1103STD))	
	--		BEGIN	
	--			INSERT INTO HT1103 (DivisionID, AssociationID, AssociationName, Disabled, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	--			SELECT @DivisionID, AssociationID, AssociationName, Disabled, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate FROM HT1103STD
	--		END	
			
	--	IF (EXISTS(SELECT * FROM HT2222STD))	
	--		BEGIN	
	--			INSERT INTO HT2222 (DivisionID, TablesName, Description, FieldID, Type, Orders, Disabled)
	--			SELECT @DivisionID, TablesName, Description, FieldID, Type, Orders, Disabled FROM HT2222STD
	--		END	
			
	--	IF (EXISTS(SELECT * FROM HT2223STD))	
	--		BEGIN	
	--			INSERT INTO HT2223 (DivisionID, Orders, Bold, Frame, Step, Code, Code0, Sign, Caption1, Caption2, Amount1, Amount2, FCaption1, FCaption2, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	--			SELECT @DivisionID, Orders, Bold, Frame, Step, Code, Code0, Sign, Caption1, Caption2, Amount1, Amount2, FCaption1, FCaption2, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate FROM HT2223STD
	--		END
					
	--	IF (EXISTS(SELECT * FROM HT2225STD))	
	--		BEGIN	
	--			INSERT INTO HT2225 (DivisionID, Orders, Bold, Description, Step, Code, Code0, Sign, Amount1, Amount2, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	--			SELECT @DivisionID, Orders, Bold, Description, Step, Code, Code0, Sign, Amount1, Amount2, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate FROM HT2225STD 
	--		END	
	--	IF (EXISTS(SELECT * FROM HT6666STD))	
	--		BEGIN	
	--			INSERT INTO HT6666 (DivisionID, PeriodID, PeriodName, IsDefault)
	--			SELECT @DivisionID, PeriodID, PeriodName, IsDefault FROM HT6666STD 
	--		END			
	--	IF (EXISTS(SELECT * FROM HT8888STD))	
	--		BEGIN	
	--			INSERT INTO HT8888 (DivisionID, ReportID, ReportName, Title, GroupID, Type, Disabled, SQLstring, Orderby, TitleE, ReportNameE, Description, DescriptionE) 
	--			SELECT @DivisionID, ReportID, ReportName, Title, GroupID, Type, Disabled, SQLstring, Orderby, TitleE, ReportNameE, Description, DescriptionE FROM HT8888STD
	--		END

	--	IF (EXISTS(SELECT * FROM MT0699STD))	
	--		BEGIN	
	--			INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName, UserName) 
	--			SELECT @DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName, UserName FROM MT0699STD
	--		END			
	
	--	/*
	--	Đã insert từ AT1005		
	--	IF (EXISTS(SELECT * FROM MT0700STD))	
	--		BEGIN	
	--			INSERT INTO MT0700 (DivisionID, AccountID, ExpenseID, MaterialTypeID, IsCheck)
	--			SELECT @DivisionID, AccountID, ExpenseID, MaterialTypeID, IsCheck FROM MT0700STD
	--		END	
	--	*/
			
	--	IF (EXISTS(SELECT * FROM MT0811STD))	
	--		BEGIN	
	--			INSERT INTO MT0811 (DivisionID, ResultTypeID, ResultTypeName, InventoryTypeCaption, InventoryCaption, DefaultTypeID, ResultOrder, Type, ResultTypeNameOther, InventoryTypeOther, InventoryOther) 
	--			SELECT @DivisionID, ResultTypeID, ResultTypeName, InventoryTypeCaption, InventoryCaption, DefaultTypeID, ResultOrder, Type, ResultTypeNameOther, InventoryTypeOther, InventoryOther FROM MT0811STD
	--		END	
			
	--	IF (EXISTS(SELECT * FROM MT1619STD))	
	--		BEGIN	
	--			INSERT INTO MT1619 (DivisionID, EndMethodID, Description, IsApportion)
	--			SELECT @DivisionID, EndMethodID, Description, IsApportion FROM MT1619STD
	--		END	
			
	--	IF (EXISTS(SELECT * FROM MT1620STD))	
	--		BEGIN	
	--			INSERT INTO MT1620 (DivisionID, ExpenseID, ExpenseName, Disabled, Language)
	--			SELECT @DivisionID, ExpenseID, ExpenseName, Disabled, Language FROM MT1620STD
	--		END
		
	--	IF (EXISTS(SELECT * FROM MT5002STD))	
	--		BEGIN	
	--			INSERT INTO MT5002 (DivisionID, DistributedMethod, Description, IsCoefficient, IsApportion, Types, Other, Is621, Is622, Is627) 
	--			SELECT @DivisionID, DistributedMethod, Description, IsCoefficient, IsApportion, Types, Other, Is621, Is622, Is627 FROM MT5002STD
	--		END	
	
	--	IF (EXISTS(SELECT * FROM MT8888STD))	
	--		BEGIN
	--			INSERT INTO MT8888 (DivisionID, ReportID, ReportName, Title, GroupID, Type, Disabled, SQLstring, Description, Orderby, DescriptionE, TitleE, ReportNameE)
	--			SELECT @DivisionID, ReportID, ReportName, Title, GroupID, Type, Disabled, SQLstring, Description, Orderby, DescriptionE, TitleE, ReportNameE FROM MT8888STD
	--		END	
			
	--	IF (EXISTS(SELECT * FROM OT0001STD))	
	--		BEGIN	
	--			INSERT INTO OT0001 (DivisionID, TypeID, VoucherTypeID, OrderType, ClassifyID, OrderStatus, Notes, InventoryTypeID, CurrencyID, EmployeeID, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, PaymentID, DepartmentID, DeReAddress, WareHouseID, ApportionType, Is621, Is622, Is627, DeReAddess)
	--			SELECT @DivisionID, TypeID, VoucherTypeID, OrderType, ClassifyID, OrderStatus, Notes, InventoryTypeID, CurrencyID, EmployeeID, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, PaymentID, DepartmentID, DeReAddress, WareHouseID, ApportionType, Is621, Is622, Is627, DeReAddess FROM OT0001STD
	--		END
	
	--	IF (EXISTS(SELECT * FROM OT1005STD))	
	--		BEGIN	
	--			INSERT INTO OT1005 (DivisionID, AnaTypeID, SystemName, UserName, IsUsed, SystemNameE, UserNameE) 
	--			SELECT @DivisionID, AnaTypeID, SystemName, UserName, IsUsed, SystemNameE, UserNameE FROM OT1005STD
	--		END
	
	--	IF (EXISTS(SELECT * FROM OT1006STD))	
	--		BEGIN	
	--			INSERT INTO OT1006 (DivisionID, UnitID, UnitName, UnitNameE, Type, Disabled)
	--			SELECT @DivisionID, UnitID, UnitName, UnitNameE, Type, Disabled FROM OT1006STD
	--		END	
			
	--	IF (EXISTS(SELECT * FROM OT1101STD))	
	--		BEGIN	
	--			INSERT INTO OT1101 (DivisionID, OrderStatus, Description, EDescription, TypeID, LanguageID)
	--			SELECT @DivisionID, OrderStatus, Description, EDescription, TypeID, LanguageID FROM OT1101STD
	--		END	
			
	--	IF (EXISTS(SELECT * FROM OT4011STD))	
	--		BEGIN	
	--			INSERT INTO OT4011 (DivisionID, ReportCode, ReportName, Filter01ID, Filter02ID, Filter03ID, Filter04ID, Disabled, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	--			SELECT @DivisionID, ReportCode, ReportName, Filter01ID, Filter02ID, Filter03ID, Filter04ID, Disabled, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate FROM OT4011STD
	--		END
	
	--	IF (EXISTS(SELECT * FROM OT4012STD))	
	--		BEGIN	
	--			INSERT INTO OT4012 (DivisionID, LineID, Code, ReportCode, Orders, Disabled, LineDescription, Method, MonthAmount, DataType, AmountType, IsPast, FromAccountID, ToAccountID, FromCorAccountID, ToCorAccountID, Sign10, Sign20, Col10, Col11, Col12, Col13, Col14, Col15, Col20, Col21, Col22, Col23, Col24, Col25)
	--			SELECT @DivisionID, LineID, Code, ReportCode, Orders, Disabled, LineDescription, Method, MonthAmount, DataType, AmountType, IsPast, FromAccountID, ToAccountID, FromCorAccountID, ToCorAccountID, Sign10, Sign20, Col10, Col11, Col12, Col13, Col14, Col15, Col20, Col21, Col22, Col23, Col24, Col25 FROM OT4012STD
	--		END
	
	--	IF (EXISTS(SELECT * FROM OT8888STD))	
	--		BEGIN	
	--			INSERT INTO OT8888 (DivisionID, ReportID, ReportName, Title, GroupID, Type, Disabled, SQLstring, Orderby, Description, DescriptionE, TitleE, ReportNameE) 
	--			SELECT @DivisionID, ReportID, ReportName, Title, GroupID, Type, Disabled, SQLstring, Orderby, Description, DescriptionE, TitleE, ReportNameE FROM OT8888STD
	--		END	

	--	IF (EXISTS(SELECT * FROM WT8888STD))	
	--		BEGIN	
	--			INSERT INTO WT8888 (DivisionID, ReportID,ReportName,Title,GroupID,Type,Disabled,SQLstring,Orderby,Description,DescriptionE,TitleE,ReportNameE) 
	--			SELECT @DivisionID, ReportID,ReportName,Title,GroupID,Type,Disabled,SQLstring,Orderby,Description,DescriptionE,TitleE,ReportNameE FROM WT8888STD
	--		END	

	--	IF (EXISTS(SELECT * FROM OT1102STD))	
	--		BEGIN	
	--			INSERT INTO OT1102 (DivisionID, Code, Description, EDescription, TypeID) 
	--			SELECT @DivisionID, Code, Description, EDescription, TypeID FROM OT1102STD
	--		END	
		
	--	-- Tấn Phú add dữ liệu phần hóa đơn tự in
	--	IF (EXISTS(SELECT * FROM AT0008STD))	
	--		BEGIN	
	--			INSERT INTO AT0008 (DivisionID, TypeID, SystemName, UserName, IsUsed, UserNameE) 
	--			SELECT @DivisionID, TypeID, SystemName, UserName, IsUsed, UserNameE FROM AT0008STD
	--		END
	--	IF (EXISTS(SELECT * FROM AT3000STD))	
	--		BEGIN	
	--			INSERT INTO AT3000 (DivisionID, ReportID, ReportName, Pages, Page1, Page2, Page3, Page4, Page5, Page6, Page7, Page8, Page9) 
	--			SELECT @DivisionID, ReportID, ReportName, Pages, Page1, Page2, Page3, Page4, Page5, Page6, Page7, Page8, Page9 FROM AT3000STD
	--		END
			
	--	IF (EXISTS(SELECT * FROM AT7903STD))	
	--		BEGIN	
	--			INSERT INTO AT7903 (DivisionID, ReportCode,Description,ReportID,CreateDate,CreateUserID,LastModifyDate,LastModifyUserID) 
	--			SELECT @DivisionID, ReportCode,Description,ReportID,CreateDate,CreateUserID,LastModifyDate,LastModifyUserID FROM AT7903STD
	--		END	
		
	--	IF (EXISTS(SELECT * FROM AT7904STD))	
	--		BEGIN	
	--			INSERT INTO AT7904 (DivisionID, ReportCode,TitleName,TitleID,Description,SubTitleName,GroupID,CreateUserID,CreateDate,LastModifyUserID,LastModifyDate) 
	--			SELECT @DivisionID, ReportCode,TitleName,TitleID,Description,SubTitleName,GroupID,CreateUserID,CreateDate,LastModifyUserID,LastModifyDate FROM AT7904STD
	--		END	

	--	IF (EXISTS(SELECT * FROM OT0005STD))	
	--		BEGIN	
	--			INSERT INTO OT0005(DivisionID,TypeID,SystemName,UserName,IsUsed,UserNameE) 
	--			SELECT @DivisionID,TypeID,SystemName,UserName,IsUsed,UserNameE FROM OT0005STD
	--		END

	--	IF (EXISTS(SELECT * FROM PT0000STD))	
	--		BEGIN	
	--			INSERT INTO PT0000(DivisionID,TranMonth,TranYear,OriginalDecimal,ConvertDecimal,UnitPriceDecimal,QuantityDecimal) 
	--			SELECT @DivisionID,@TranMonth,@TranYear,OriginalDecimal,ConvertDecimal,UnitPriceDecimal,QuantityDecimal FROM PT0000STD
	--		END			
		
	--	IF (EXISTS(SELECT * FROM CMT0000STD))	
	--		BEGIN	
	--			INSERT INTO CMT0000(DefDivisionID,DefTranMonth,DefTranYear,OriginalDecimal,ConvertDecimal,UnitPriceDecimal,QuantityDecimal) 
	--			SELECT @DivisionID,@TranMonth,@TranYear,OriginalDecimal,ConvertDecimal,UnitPriceDecimal,QuantityDecimal FROM CMT0000STD
	--		END			
		
	--	IF (EXISTS(SELECT * FROM AT0009STD))	
	--		BEGIN	
	--			INSERT INTO AT0009(DivisionID,TypeID,SystemName,UserName,IsUsed,UserNameE) 
	--			SELECT @DivisionID,TypeID,SystemName,UserName,IsUsed,UserNameE FROM AT0009STD
	--		END	
		
	--	IF (EXISTS(SELECT * FROM AT7905STD))	
	--		BEGIN	
	--			INSERT INTO AT7905(DivisionID,ReportCode,TitleID,TitleName,LineDes,FromAccountID,ToAccountID,OperatorID,GroupID,FromCorAccountID,ToCorAccountID,CreateUserID,CreateDate,LastModifyUserID,LastModifyDate) 
	--			SELECT @DivisionID,ReportCode,TitleID,TitleName,LineDes,FromAccountID,ToAccountID,OperatorID,GroupID,FromCorAccountID,ToCorAccountID,CreateUserID,CreateDate,LastModifyUserID,LastModifyDate FROM AT7905STD
	--		END	
		
	--	IF (EXISTS(SELECT * FROM AT7907STD))	
	--		BEGIN	
	--			INSERT INTO AT7907(DivisionID,ReportCode,GroupID,TitleID,LineDes,LineLevel,OperatorID) 
	--			SELECT @DivisionID,ReportCode,GroupID,TitleID,LineDes,LineLevel,OperatorID FROM AT7907STD
	--		END
		
	--	IF (EXISTS(SELECT * FROM AT7908STD))	
	--		BEGIN	
	--			INSERT INTO AT7908(DivisionID,ReportCode,TitleID,ColID,FromAccountID,ToAccountID,FromCorAccountID,ToCorAccountID,GroupID) 
	--			SELECT @DivisionID,ReportCode,TitleID,ColID,FromAccountID,ToAccountID,FromCorAccountID,ToCorAccountID,GroupID FROM AT7908STD
	--		END
	
	--	IF (EXISTS(SELECT * FROM OT1007STD))	
	--		BEGIN	
	--			INSERT INTO OT1007(DivisionID,Code,Description,Type,Orders,Disabled) 
	--			SELECT @DivisionID,Code,Description,Type,Orders,Disabled FROM OT1007STD
	--		END
		
	--	IF (EXISTS(SELECT * FROM AT8889STD))	
	--		BEGIN	
	--			INSERT INTO AT8889(DivisionID,ModuleID,FormID,FormName,SystemOrderBy,UserOrderBy,CreateDate,CreateUserID,LastModifyDate,LastModifyUserID) 
	--			SELECT @DivisionID,ModuleID,FormID,FormName,SystemOrderBy,UserOrderBy,CreateDate,CreateUserID,LastModifyDate,LastModifyUserID FROM AT8889STD
	--		END
	--END
END 






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
