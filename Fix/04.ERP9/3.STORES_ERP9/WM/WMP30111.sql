IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WMP30111]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WMP30111]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Báo cáo tồn kho theo mặt hàng (Clone From AP2009)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create ON 13/03/2023 by Tấn Lộc
---- 
---- Modified ON ... by ...
---- <Example>
---- EXEC WMP30101 @DivisionID=N''1B'',@DivisionIDList=''1B'',@WareHouseID=''CCDC'''',''''HH'',@InventoryID=N''ABC001'',@FromDate=N''2023-03-14 00:00:00'',@ToDate=N''2023-03-14 00:00:00'',@PeriodList=NULL,@IsPeriod=0,@IsGroupID=1,@GroupID1=NULL,@GroupID2=N''I03'',@UserID=N''ASOFTADMIN''



CREATE PROCEDURE [dbo].[WMP30111]
       @DivisionID AS nvarchar(50) = '' ,
	   @DivisionIDList	  AS NVARCHAR(MAX) = '',
	   @WareHouseID      AS NVARCHAR(MAX) = '',
	   @InventoryID	  AS NVARCHAR(MAX) = '',
       @FromDate AS DATETIME = NULL,
       @ToDate AS DATETIME ,
	   @PeriodList	AS NVARCHAR(MAX) = '',
       @IsPeriod	AS TINYINT = 0, -- 0: Theo ngày, 1: Theo kỳ
	   @UserID	AS VARCHAR(50)

AS

IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
BEGIN
	EXEC WMP30111_QC @DivisionID,@DivisionIDList,@WareHouseID, @InventoryID, @FromDate, @ToDate, @PeriodList, @IsPeriod, @UserID
END
ELSE
	BEGIN
		DECLARE	@sWhere AS NVARCHAR(MAX),
				@sWhere1 AS NVARCHAR(MAX),
				@sWhere2 AS NVARCHAR(MAX),
				@sWhere3 AS NVARCHAR(MAX),
				@sSQLSelect AS VARCHAR(MAX) ,
				@sSQLSelect1 AS VARCHAR(MAX) = '' ,
				@sSQLFrom AS VARCHAR(MAX) ='',
				@sSQLFrom1 AS VARCHAR(MAX) ='' ,
				@sSQLWhere AS VARCHAR(MAX)= '',
				@sSQLWhere1 AS VARCHAR(MAX) ='' ,
				@sSQLUnion AS VARCHAR(MAX) = '', 
				@FromMonthYearText VARCHAR(250), 
				@ToMonthYearText VARCHAR(250), 
				@FromDateText VARCHAR(250), 
				@ToDateText VARCHAR(250)
						    

		SET @sWhere = ''
		SET @sWhere1 = ''
		SET @sWhere2 = ''
		SET @sWhere3 = ''
		SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
		SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'

	-- Check Para FromDate và ToDate
	-- Trường hợp search theo từ ngày đến ngày
	IF @IsPeriod = 0
	BEGIN
		IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
			BEGIN
				SET @sWhere = @sWhere + ' AND (AV7018.VoucherDate >= ''' + @FromDateText + ''')'
				-- Dùng cho những chỗ đang select từ View AV7000
				SET @sWhere1 = @sWhere1 + ' AND (AV7000.VoucherDate >= ''' + @FromDateText + ''')'
				-- Dùng cho những chỗ đang select từ View AV7001
				SET @sWhere2 = @sWhere2 + ' AND (AV7001.VoucherDate >= ''' + @FromDateText + ''')'
				-- Dùng cho những chỗ đang select từ View AV7004
				SET @sWhere3 = @sWhere3 + ' AND (AV7004.VoucherDate >= ''' + @FromDateText + ''')'
			END
		ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
			BEGIN
				SET @sWhere = @sWhere + ' AND (AV7018.VoucherDate <= ''' + @ToDateText + ''')'
				-- Đùng cho những chỗ đang select từ View AV7000
				SET @sWhere1 = @sWhere1 + ' AND (AV7000.VoucherDate <= ''' + @ToDateText + ''')'
				-- Đùng cho những chỗ đang select từ View AV7001
				SET @sWhere2 = @sWhere2 + ' AND (AV7001.VoucherDate <= ''' + @ToDateText + ''')'
				-- Dùng cho những chỗ đang select từ View AV7004
				SET @sWhere3 = @sWhere3 + ' AND (AV7004.VoucherDate <= ''' + @ToDateText + ''')'

			END
		ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
			BEGIN
				SET @sWhere = @sWhere + ' AND (AV7018.VoucherDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
				-- Đùng cho những chỗ đang select từ View AV7000
				SET @sWhere1 = @sWhere1 + ' AND (AV7000.VoucherDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
				-- Đùng cho những chỗ đang select từ View AV7001
				SET @sWhere2 = @sWhere2 + ' AND (AV7001.VoucherDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
				-- Dùng cho những chỗ đang select từ View AV7004
				SET @sWhere3 = @sWhere3 + ' AND (AV7004.VoucherDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
			END
	END
	ELSE IF @IsPeriod = 1 AND ISNULL(@PeriodList, '') != ''
		BEGIN
			SET @sWhere = @sWhere + ' AND ((SELECT FORMAT(AV7018.VoucherDate, ''MM/yyyy'')) IN (''' + @PeriodList + ''')'
		END

		IF @IsPeriod = 1  -- theo kỳ
		   BEGIN
				 SET @sSQLSelect = '
			Select 	AT2008.DivisionID, AT2008.InventoryID, AT1302.InventoryName,
			AT2008.WareHouseID,	AT1303.WareHouseName,
			AT1302.UnitID, 	AT1304.UnitName,
			AT1302.Specification,AT1302.Notes01, AT1302.Notes02, AT1302.Notes03, 
			SUM(CASE WHEN (Case When  AT2008.TranMonth <10 then ''0''+rtrim(ltrim(str(AT2008.TranMonth)))+''/''+ltrim(Rtrim(str(AT2008.TranYear))) 
										Else rtrim(ltrim(str(AT2008.TranMonth)))+''/''+ltrim(Rtrim(str(AT2008.TranYear))) End) IN (''' + @PeriodList + ''')
				THEN ISNULL(BeginQuantity, 0) ELSE 0 END) AS BeginQuantity,


			SUM(CASE WHEN (CASE WHEN  AT2008.TranMonth <10 THEN ''0''+rtrim(ltrim(str(AT2008.TranMonth)))+''/''+ltrim(Rtrim(str(AT2008.TranYear))) 
										ELSE rtrim(ltrim(str(AT2008.TranMonth)))+''/''+ltrim(Rtrim(str(AT2008.TranYear))) End) IN (''' + @PeriodList + ''')
				THEN ISNULL(EndQuantity, 0) ELSE 0 END) AS EndQuantity,

			SUM(ISNULL(DebitQuantity, 0)) AS DebitQuantity,
			SUM(ISNULL(CreditQuantity, 0)) AS CreditQuantity,

			SUM(CASE WHEN (CASE WHEN  AT2008.TranMonth <10 THEN ''0''+rtrim(ltrim(str(AT2008.TranMonth)))+''/''+ltrim(Rtrim(str(AT2008.TranYear))) 
										ELSE rtrim(ltrim(str(AT2008.TranMonth)))+''/''+ltrim(Rtrim(str(AT2008.TranYear))) End) IN (''' + @PeriodList + ''')
					THEN ISNULL(BeginAmount, 0) ELSE 0 END) AS BeginAmount,

			SUM(CASE WHEN (CASE WHEN  AT2008.TranMonth <10 THEN ''0''+rtrim(ltrim(str(AT2008.TranMonth)))+''/''+ltrim(Rtrim(str(AT2008.TranYear))) 
										ELSE rtrim(ltrim(str(AT2008.TranMonth)))+''/''+ltrim(Rtrim(str(AT2008.TranYear))) End) IN (''' + @PeriodList + ''')
					THEN ISNULL(EndAmount, 0) ELSE 0 END) AS EndAmount,

			sum(isnull(DebitAmount, 0)) as DebitAmount,
			sum(isnull(CreditAmount, 0)) as CreditAmount,
			sum(isnull(InDebitAmount, 0)) as InDebitAmount,
			sum(isnull(InCreditAmount, 0)) as InCreditAmount,
			sum(isnull(InDebitQuantity, 0)) as InDebitQuantity,
			sum(isnull(InCreditQuantity, 0)) as InCreditQuantity,
			CASE WHEN A.ConvertedQuantity <> 0 THEN Sum(BeginQuantity + DebitQuantity - CreditQuantity) / (A.ConvertedQuantity/3) ELSE 0 END TimeOfUse	'
				 SET @sSQLFrom = '
			From AT2008 WITH (NOLOCK)
			LEFT JOIN (SELECT WareHouseID, InventoryID, InventoryName, WareHouseName, --UnitID, UnitName,
							--Specification, Notes01, Notes02, Notes03, 
						SUM(ISNULL(ConvertedQuantity,0)) ConvertedQuantity FROM AV7001
						WHERE DivisionID IN (''' + IIF(ISNULL(@DivisionIDList, '') != '', @DivisionIDList, @DivisionID) + ''') 
						AND (CASE WHEN  AV7001.TranMonth <10 THEN ''0''+rtrim(ltrim(str(AV7001.TranMonth)))+''/''+ltrim(Rtrim(str(AV7001.TranYear))) 
										ELSE rtrim(ltrim(str(AV7001.TranMonth)))+''/''+ltrim(Rtrim(str(AV7001.TranYear))) End) IN (''' + @PeriodList + ''')
						AND D_C = ''C''
						GROUP BY WareHouseID, InventoryID, InventoryName, WareHouseName--,
						 --UnitID, UnitName,Specification, Notes01, Notes02, Notes03
						 )A ON A.WareHouseID = AT2008.WareHouseID AND A.InventoryID = AT2008.InventoryID
			inner join AT1303 WITH (NOLOCK) on AT1303.DivisionID IN ('''+@DivisionID+''',''@@@'') AND AT1303.WareHouseID = AT2008.WareHouseID
			inner join AT1302 WITH (NOLOCK) on AT1302.DivisionID IN (AT2008.DivisionID,''@@@'') AND AT1302.InventoryID = AT2008.InventoryID
			inner join AT1304 WITH (NOLOCK) on AT1304.DivisionID IN (AT1302.DivisionID, ''' + @DivisionID + ''' , ''@@@'') AND AT1302.UnitID = AT1304.UnitID'

				 SET @sSQLWhere = '
			Where AT2008.DivisionID IN (''' + IIF(ISNULL(@DivisionIDList, '') != '', @DivisionIDList, @DivisionID) + ''') 
			AND AT2008.InventoryID IN (SELECT Value FROM dbo.StringSplit(''' +@InventoryID+ ''', '','')) 
			AND AT2008.WareHouseID IN (N''' + @WareHouseID + ''')
			AND (CASE WHEN  AT2008.TranMonth <10 THEN ''0''+rtrim(ltrim(str(AT2008.TranMonth)))+''/''+ltrim(Rtrim(str(AT2008.TranYear))) 
										ELSE rtrim(ltrim(str(AT2008.TranMonth)))+''/''+ltrim(Rtrim(str(AT2008.TranYear))) End) IN (''' + @PeriodList + ''')

		    Group By AT2008.DivisionID, AT2008.InventoryID, AT1302.InventoryName, 
			AT2008.WareHouseID, AT1303.WareHouseName, AT1302.UnitID, AT1304.UnitName,
			AT1302.Specification,AT1302.Notes01, AT1302.Notes02, AT1302.Notes03, 
			A.ConvertedQuantity '
		   END
		ELSE            -- theo ngày
		   BEGIN
				SET @sSQLSelect1='
				'
				SET @sSQLSelect = ' Select 	DivisionID, WareHouseID,InventoryID, --InventoryName, UnitID, UnitName,
				--Specification, Notes01, Notes02, Notes03, 	
				--InventoryID+WareHouseID as Key1, 
				(ltrim(rtrim(InventoryID)) + ltrim(rtrim(WareHouseID))) as Key1, 
				-- S1, S2, S3 ,
				--S1Name,  S2Name, S3Name,				
				Sum(SignQuantity) as BeginQuantity,
				Sum(SignAmount) as BeginAmount'

				SET @sSQLFrom = ' 
				From AV7004'
				SET @sSQLWhere = ' 
				Where DivisionID IN (''' + IIF(ISNULL(@DivisionIDList, '') != '', @DivisionIDList, @DivisionID) + ''')
				AND WareHouseID IN (N''' + @WareHouseID + ''') 
				AND InventoryID IN (SELECT Value FROM dbo.StringSplit(''' +@InventoryID+ ''', '',''))
				 ' + @sWhere3+'
				
				Group by  DivisionID, WareHouseID,InventoryID--,InventoryName, UnitID, UnitName, Specification, Notes01, Notes02, Notes03, 
				--S1, S2, S3 ,S1Name,  S2Name, S3Name 
				'
			IF NOT EXISTS ( SELECT TOP 1 1 FROM sysObjects WHERE Xtype = 'V' AND Name = 'AV7018' )
			   BEGIN
					 EXEC ( ' Create view AV7018 --AP2009
					 as '+@sSQLSelect+@sSQLFrom+@sSQLWhere )
			   END
			ELSE
			   BEGIN
					 EXEC ( ' Alter view AV7018 as  --AP2009
					 '+@sSQLSelect+@sSQLFrom+@sSQLWhere )
			   END

			SET @sSQLSelect = 'Select 	AV7018.DivisionID, AV7018.InventoryID,
				--AT1302.InventoryName,
				AV7018.WareHouseID,
				--AT1303.WareHouseName,
				--AV7018.UnitID,
				--AV7018.UnitName,
				--AV7018.Specification, AV7018.Notes01, AV7018.Notes02, AV7018.Notes03, 	
				isnull(AV7018.BeginQuantity,0) as BeginQuantity,
				isnull(AV7018.BeginAmount,0) as BeginAmount,
				0 as DebitQuantity,
				0 as CreditQuantity,
				0 as DebitAmount,
				0 as CreditAmount,
				0 as EndQuantity,
				0 as EndAmount'

			SET @sSQLFrom = ' 
			into #AV2089
			From AV7018 --inner join AT1302 WITH (NOLOCK) on AT1302.DivisionID IN (AV7018.DivisionID,''@@@'') AND AT1302.InventoryID =AV7018.InventoryID
					--inner join AT1303 WITH (NOLOCK) on AT1303.DivisionID IN (''' + @DivisionID + ''',''@@@'') AND AT1303.WareHouseID = AV7018.WareHouseID'

			SET @sSQLWhere = ' 
			WHERE 	AV7018.WareHouseID IN (N''' + @WareHouseID + ''')
					AND AV7018.Key1 NOT IN (Select  (ltrim(rtrim(InventoryID)) + ltrim(rtrim(WareHouseID)))  as Key1 From AV7004 AV7000
							Where 	AV7000.DivisionID IN (''' + IIF(ISNULL(@DivisionIDList, '') != '', @DivisionIDList, @DivisionID) + ''')
							AND AV7000.WareHouseID IN (N''' + @WareHouseID + ''')
							AND AV7000.InventoryID IN (SELECT Value FROM dbo.StringSplit(''' +@InventoryID+ ''', '',''))
							AND AV7000.D_C in (''D'', ''C'')' +@sWhere1+')
			Group by  AV7018.DivisionID, AV7018.InventoryID, --AT1302.InventoryName, 
					AV7018.WareHouseID, --AT1303.WareHouseName, 
					--AV7018.UnitID, AV7018.UnitName, 
					--AV7018.Specification, AV7018.Notes01, AV7018.Notes02, AV7018.Notes03, 	
					AV7018.BeginQuantity,AV7018.BeginAmount'

			SET @sSQLUnion = ' Union all
			Select 	AV7000.DivisionID, AV7000.InventoryID,
				--AT1302.InventoryName,
				AV7000.WareHouseID,
				--AT1303.WareHouseName,
				--AV7000.UnitID, 
				--AV7000.UnitName,
				--AV7000.Specification, AV7000.Notes01, AV7000.Notes02, AV7000.Notes03, 	
				isnull(AV7018.BeginQuantity,0) as BeginQuantity,
				isnull(AV7018.BeginAmount,0) as BeginAmount,
				Sum(Case when D_C = ''D'' then isnull(AV7000.SignQuantity,0) else 0 end) as DebitQuantity,
				Sum(Case when D_C = ''C'' then isnull(-AV7000.SignQuantity,0) else 0 end) as CreditQuantity,
				Sum(Case when D_C = ''D'' then isnull(AV7000.SignAmount,0) else 0 end) as DebitAmount,
				Sum(Case when D_C = ''C'' then isnull(-AV7000.SignAmount,0) else 0 end) as CreditAmount,
				0 as EndQuantity,
				0 as EndAmount
			From AV7004 AV7000 
			left join AV7018 on (AV7000.WareHouseID = AV7018.WareHouseID and AV7000.InventoryID = AV7018.InventoryID and AV7000.DivisionID = AV7018.DivisionID)
					--inner join AT1302 WITH (NOLOCK) on AT1302.DivisionID IN (AV7000.DivisionID,''@@@'') AND AT1302.InventoryID = AV7000.InventoryID
					--inner join AT1303 WITH (NOLOCK) on AT1303.DivisionID IN ('''+@DivisionID+''',''@@@'') AND AT1303.WareHouseID = AV7000.WareHouseID
					
			Where 	AV7000.DivisionID IN (''' + IIF(ISNULL(@DivisionIDList, '') != '', @DivisionIDList, @DivisionID) + ''')
				AND AV7000.InventoryID IN (SELECT Value FROM dbo.StringSplit(''' +@InventoryID+ ''', '',''))
				AND AV7000.WareHouseID IN (N''' + @WareHouseID + ''')
				AND AV7000.D_C in (''D'', ''C'')
				'+@sWhere1+'
			Group by  AV7000.DivisionID, AV7000.InventoryID, --AT1302.InventoryName, 
					AV7000.WareHouseID, --AT1303.WareHouseName,AV7000.UnitName,
					--AV7000.Specification, AV7000.Notes01, AV7000.Notes02, AV7000.Notes03, 	
					--AV7000.UnitID, 	
					AV7018.BeginQuantity,AV7018.BeginAmount  '



		--IF NOT EXISTS ( SELECT TOP 1 1 FROM sysObjects WHERE Xtype = 'V' AND Name = 'AV2089' )
		--   BEGIN
		--		 EXEC ( ' Create view AV2089 as --AP2009
		--		 '+@sSQLSelect+@sSQLFrom+@sSQLWhere+@sSQLUnion )
		--   END
		--ELSE
		--   BEGIN
		--		 EXEC ( ' Alter view AV2089 as  --AP2009
		--		 '+@sSQLSelect+@sSQLFrom+@sSQLWhere+@sSQLUnion )
		--   END

		SET @sSQLSelect1 = '
		Select 	AV2089.DivisionID, AV2089.InventoryID, AT1302.InventoryName,
			AV2089.WareHouseID, AT1303.WareHouseName,
			AT1302.UnitID, 
			AT1304.UnitName,
			AT1302.Specification, AT1302.Notes01, AT1302.Notes02, AT1302.Notes03, 	
			Sum(AV2089.BeginQuantity) as BeginQuantity,
			Sum(AV2089.BeginAmount) as BeginAmount, 
			Sum(AV2089.DebitQuantity) as DebitQuantity,
			Sum(AV2089.CreditQuantity) as CreditQuantity,
			Sum(AV2089.DebitAmount) as DebitAmount,
			Sum(AV2089.CreditAmount) as CreditAmount,
			Sum(AV2089.BeginQuantity + AV2089.DebitQuantity - AV2089.CreditQuantity) as EndQuantity,
			Sum(AV2089.BeginAmount + AV2089.DebitAmount - AV2089.CreditAmount) as EndAmount,
			CASE WHEN A.ConvertedQuantity <> 0 THEN Sum(AV2089.BeginQuantity + AV2089.DebitQuantity - AV2089.CreditQuantity) / (A.ConvertedQuantity/3) ELSE 0 END TimeOfUse	'		

		SET @sSQLFrom1= '
		FROM #AV2089 AV2089
						LEFT JOIN (SELECT WareHouseID, InventoryID, SUM(ISNULL(ConvertedQuantity,0)) ConvertedQuantity FROM AV7001
									WHERE DivisionID = '''+@DivisionID+'''
									'+@sWhere2+'
									AND D_C = ''C''
									GROUP BY WareHouseID, InventoryID)A
						ON A.WareHouseID = AV2089.WareHouseID AND A.InventoryID = AV2089.InventoryID
						inner join AT1302 WITH (NOLOCK) on AT1302.DivisionID IN (AV2089.DivisionID,''@@@'') AND AT1302.InventoryID = AV2089.InventoryID
						inner join AT1303 WITH (NOLOCK) on AT1303.DivisionID IN (''' + @DivisionID + ''',''@@@'') AND AT1303.WareHouseID = AV2089.WareHouseID
						inner join AT1304 WITH (NOLOCK) on AT1302.DivisionID IN (AT1304.DivisionID,''@@@'') AND AT1302.UnitID = AT1304.UnitID'
									
									
		set @sSQLWhere1= ' 
		Where (BeginQuantity <> 0 or BeginAmount <> 0 or DebitQuantity <> 0 or DebitAmount <> 0 or
			CreditQuantity <> 0 or CreditAmount <> 0 or EndQuantity <> 0 or EndAmount <> 0) and AV2089.DivisionID = ''' + @DivisionID + '''
		Group by  AV2089.DivisionID, AV2089.InventoryID, AT1302.InventoryName, 
			AV2089.WareHouseID, AT1303.WareHouseName, AT1302.UnitID, AT1304.UnitName,
			AT1302.Specification, AT1302.Notes01, AT1302.Notes02, AT1302.Notes03, 
			A.ConvertedQuantity '

		END
		--print @sSQL
		--SELECT @sSQLSelect
		--SELECT @sSQLFrom
		--SELECT @sSQLWhere
		--SELECT @sSQLUnion
		--SELECT @sSQLSelect1
		--SELECT @sSQLFrom1
		--SELECT @sSQLWhere1
		EXEC (@sSQLSelect + @sSQLFrom + @sSQLWhere+@sSQLUnion+@sSQLSelect1 + @sSQLFrom1 + @sSQLWhere1)
		print (@sSQLSelect + @sSQLFrom + @sSQLWhere+@sSQLUnion+@sSQLSelect1 + @sSQLFrom1 + @sSQLWhere1)
		
		--IF NOT EXISTS ( SELECT
		--					1
		--				FROM
		--					sysObjects
		--				WHERE
		--					Xtype = 'V' AND Name = 'AV2009' )
		--   BEGIN
		--		 EXEC ( ' Create view AV2009 as  --AP2009
		--		 '+@sSQLSelect+@sSQLFrom+@sSQLWhere  )
		--   END
		--ELSE
		--   BEGIN
		--		 EXEC ( ' Alter view AV2009 as  --AP2009
		--		 '+@sSQLSelect+@sSQLFrom+@sSQLWhere  )
		--/*
		--Set @sSQL = 
		--'SELECT AV2099.*,  AT1304.UnitName  F
		--	ROM AV2099  inner join AT1304 on AT1304.UnitID = AV2099.UnitID
		--Where BeginQuantity <> 0 or BeginAmount <> 0 or DebitQuantity <> 0 or DebitAmount <> 0 or
		--	CreditQuantity <> 0 or CreditAmount <> 0 or EndQuantity <> 0 or EndAmount <>0 
		-- '

		--If not Exists (Select 1 From  sysObjects Where Xtype ='V' and Name ='AV2009')
		--	Exec(' Create view AV2009 as '+@sSQL)
		--Else
		--	Exec(' Alter view AV2009 as '+@sSQL)
		--*/
		--   END
	END



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
