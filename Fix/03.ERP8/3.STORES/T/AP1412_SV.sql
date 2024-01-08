IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP1412_SV]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP1412_SV]
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
----Created by: Created by Huỳnh Thử on 27/05/2021: Tách Store SaVi -- Không cần Update lại    AT1001
																							-- AT1002
																							-- AT1004
																							-- AT1005
																							-- AT1006
																							-- AT1009
																							-- AT1010
																							-- AT1206
																							-- AT1301
																							-- AT1304
																							-- AT1201
----Modified by 
-- <Example>

/*
    AP1412 'KKK',1,2014
*/

CREATE PROCEDURE AP1412_SV
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

		--SET @sSQL = '
		--SET XACT_ABORT ON
		--BEGIN TRAN
		--BEGIN TRY
		--	DELETE FROM '+@Table+' WHERE '+@ColumnSTD+' IN (SELECT '+@ColumnSTD+' FROM '+@TableSTD+')
		--	INSERT INTO '+@Table+' ('+@Insert+')
		--	SELECT 1, ''@@@'', '+left(@Insert1, LEN(@Insert1) - 1)+' FROM '+@TableSTD+' 
		--COMMIT
		--END TRY
		--BEGIN CATCH
		--   IF(@@TRANCOUNT > 0)
		--        ROLLBACK;
		--   THROW; -- raise error to the client
		--END CATCH	
		--'
		--EXEC (@sSQL)
		DELETE #Tam
		DELETE FROM #Division
		--print @sSQL
	END	
	FETCH NEXT FROM @Cur INTO @TableSTD, @Table, @Id
END
CLOSE @Cur




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
