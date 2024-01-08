IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP2006]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP2006]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Bao cao ton kho theo tai khoan cho tat ca cac kho
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create ON 12/05/2004 by Nguyen Thi Ngoc Minh
---- 
---- Edited by: Vo Thanh Huong, date: 07/03/2006
---- Edited by: Nguyen Quoc Huy, date: 19/10/2006
---- Edited by: Dang Le Bao Quynh Date 04/07/2008 : Them truong WareHouseName
---- Modified ON 17/11/2011 by Le Thi Thu Hien : Bo sung 5 ma va ten phan tich I01ID --> I05ID
---- Modified on 09/10/2012 by Bao Anh : Customize cho 2T (ton kho theo TK, quy cach), goi AP2086
---- Modified on 30/01/2013 by Bao Quynh : Khong in kho tam
---- Modified by Thanh Son on 16/07/2014: l?y d? li?u tr?c ti?p t? store, không sinh ra view AV2007
---- Modified by Mai Duyen on 09/02/2015: Bo sung AT1302.Barcode
---- Modified on 11/09/2015 by Thanh Th?nh: Ch? hi?n nh?ng ngu?i có tru?ng Th? Kho ? AT1303 là khác 1 (Figla)
---- Modified on 21/12/2015 by B?o Anh: B? sung Isnull cho AT1303.FullName (Figla)
---- Modified by Ti?u Mai on 15/06/2016: B? sung in theo quy cách và  WITH (NOLOCK)
------ Modify on 24/04/2017 by B?o Anh: S?a danh m?c dùng chung (b? k?t theo DivisionID)
---- Modified by Kim Thu on 18/10/2018: B? sung l?c báo cáo theo ngày
---- Modified by Kim Thu on 15/11/2018: L?y BeginAmount và EndAMount ? in 1 k? gi?ng in nhi?u k?
------ Modify on 18/12/2018 by B?o Anh: S?a l?i sai s? du d?u, cu?i khi in nhi?u tháng
---- Modified by Kim Thu on 22/04/2019: B? sung thêm tru?ng nhóm ngu?i dùng (GroupID), TRUY?N @UserID 
---- Modified by Kim Thu on 10/05/2019: S?a l?i load thi?u d? li?u in theo ngày
---- Modified by Kim Thu on 05/06/2019: B? sung @SQL2A
---- Modified by Kim Thu on 15/07/2019: S?a l?i @sGroupWareHouse
---- Modified by Kim Thu on 17/07/2019: X? lý l?y WarehouseID tru?ng h?p VCNB (in theo ngày)
---- Modified by Văn Minh on 05/03/2020: Tách chuỗi tránh quá tải chuỗi
---- Modified by Huỳnh Thử on 20/05/2020: Đưa BeginQuantity, EndQuantity, BeginAmount, EndAmount vào bảng tạm, bỏ View, cải thiện tốc độ.
---- Modified by Văn Tài on 06/07/2020: Fix lỗi comment điều kiện sai vị trí.
---- Modified by Văn Tài on 07/07/2020: Fix lỗi bổ sung điều kiện AND thay vì ,
---- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
---- Modified by Lê Hoàng on 21/10/2020: Nên dùng @DivisionID nếu INNER các danh mục
---- Modified on 13/04/2021 by Huỳnh Thử : Tách Store [TienTien] -- Bổ sung xuất execl nhiều Division
---- Modified on 25/05/2021 by Nhựt Trường: Bổ sung thêm điều kiện DivisionID khi join bảng AT1303.
---- Modified on 28/01/2022 by Văn Tài	  : Bổ sung điều kiện khi truyền vào store QC.
-- <Example>
----exec AP2006 @DivisionID=N'MP',@FromMonth=4,@FromYear=2019,@ToMonth=4,@ToYear=2019,@FromAccountID=N'152',@ToAccountID=N'158',@IsWareHouse=0,
----@FromDate='2019-04-22 10:22:45.317',@ToDate='2019-04-22 10:22:45.303',@IsDate=0, @UserID='ASOFTADMIN'

CREATE PROCEDURE [dbo].[AP2006]
       @DivisionID AS nvarchar(50) ,
       @FromMonth AS int ,
       @FromYear AS int ,
       @ToMonth AS int ,
       @ToYear AS int ,
	   @IsDate AS TINYINT,
	   @FromDate AS DATETIME,
	   @ToDate AS DATETIME,
       @FromAccountID AS nvarchar(50) ,
       @ToAccountID AS nvarchar(50) ,
       @IsWareHouse AS TINYINT,   ---co nhom theo tung kho khong?
	   @UserID nvarchar(50),
	   @Strdivisionid NVARCHAR(500)

AS
DECLARE @GroupID VARCHAR(50)
SET @GroupID = (SELECT TOP 1 AT1402.GroupID FROM AT1402 WHERE AT1402.UserID = @UserID)
PRINT @GroupID 
PRINT 1
IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
	EXEC AP2006_QC @DivisionID, @FromMonth, @FromYear, @ToMonth, @ToYear, @IsDate, @FromDate, @ToDate,  @FromAccountID, @ToAccountID, @IsWareHouse, @UserID
ELSE
BEGIN
	DECLARE @CustomerName INT
	--Tao bang tam de kiem tra day co phai la khach hang 2T khong (CustomerName = 15)
	CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
	INSERT #CustomerName EXEC AP4444
	SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

	IF @CustomerName = 15 --- Customize 2T
		EXEC AP2086 @DivisionID, @FromMonth, @FromYear, @ToMonth, @ToYear, @FromAccountID, @ToAccountID, @IsWareHouse
	ELSE
	IF @CustomerName = 13 --- Customize TienTien
		EXEC AP2006_TIENTIEN @DivisionID = @DivisionID,                 -- nvarchar(50)
                @FromMonth = @FromMonth,                    -- int
                @FromYear = @FromYear,                     -- int
                @ToMonth = @ToMonth,                      -- int
                @ToYear = @ToYear,                       -- int
                @IsDate = @IsDate,                       -- tinyint
                @FromDate = @FromDate, -- datetime
                @ToDate = @ToDate,   -- datetime
                @FromAccountID = @FromAccountID,              -- nvarchar(50)
                @ToAccountID = @ToAccountID,                -- nvarchar(50)
                @IsWareHouse = @IsWareHouse,                  -- tinyint
                @UserID = @UserID    ,
				@Strdivisionid= @Strdivisionid                  
	ELSE
	BEGIN
		IF @IsDate=0 -- THEO K?
		BEGIN
			DECLARE
				@sSQL0 AS nvarchar(MAX) ,
				@sSQL1 AS nvarchar(MAX) ,
				@sSQL2 AS nvarchar(max) ,
				@sSQL2_2 AS nvarchar(MAX) = '',
				@sSQL3 AS nvarchar(MAX) ,
				@sSQL4 AS nvarchar(MAX) ,
				@sGroupWareHouse AS nvarchar(250), 
				@FromMonthYearText NVARCHAR(20), 
				@ToMonthYearText NVARCHAR(20)
		    
			SET @FromMonthYearText = STR(@FromMonth + @FromYear * 100)
			SET @ToMonthYearText = STR(@ToMonth + @ToYear * 100)

			IF @IsWareHouse = 1
				SET @sGroupWareHouse = ', AT2008.WareHouseID, AT1303.WareHouseName '
			ELSE
				SET @sGroupWareHouse = ''	

				SET @sSQL0 = N'		
								SELECT	   SUM(ISNULL(BeginQuantity,0)) AS BeginQuantity, 
										SUM(ISNULL(EndQuantity,0)) AS EndQuantity,
										SUM(ISNULL(BeginAmount,0)) AS BeginAmount,
										SUM(ISNULL(EndAmount,0)) AS EndAmount,
										T08.InventoryID,T08.InventoryAccountID
										' + CASE  WHEN @IsWareHouse = 1 THEN ',T08.WareHouseID' ELSE ' ' END + '
										INTO #BEGIN FROM	AT2008 T08  WITH (NOLOCK)
										LEFT JOIN AT1303 T03 WITH (NOLOCK) ON T03.DivisionID IN ('''+@DivisionID+''',''@@@'') AND T03.WarehouseID = T08.WarehouseID
		                        		WHERE 	
											T03.IsTemp = 0 AND
											T08.DivisionID = ''' + @DivisionID + ''' AND
											T08.TranMonth + T08.TranYear*100 = ' + @FromMonthYearText + ' 
											GROUP BY InventoryID,InventoryAccountID
										' + CASE  WHEN @IsWareHouse = 1 THEN ',T08.WareHouseID' ELSE ' ' END + '
														
									SELECT SUM(ISNULL(BeginQuantity,0)) AS BeginQuantity, 
											SUM(ISNULL(EndQuantity,0)) AS EndQuantity,
											SUM(ISNULL(BeginAmount,0)) AS BeginAmount,
											SUM(ISNULL(EndAmount,0)) AS EndAmount,
											T08.InventoryID,T08.InventoryAccountID
											' + CASE  WHEN @IsWareHouse = 1 THEN ',T08.WareHouseID' ELSE ' ' END + '
										INTO #END FROM	AT2008 T08  WITH (NOLOCK)
										LEFT JOIN AT1303 T03 WITH (NOLOCK) ON T03.DivisionID IN ('''+@DivisionID+''',''@@@'') AND T03.WarehouseID = T08.WarehouseID
										WHERE 
											T03.IsTemp = 0 AND 
											T08.DivisionID = ''' + @DivisionID + ''' AND
											T08.TranMonth + T08.TranYear*100 = ' + @ToMonthYearText + '
											GROUP BY InventoryID,InventoryAccountID
									' + CASE  WHEN @IsWareHouse = 1 THEN ',T08.WareHouseID' ELSE ' ' END + '
														'
			--B/c cho 1 ky
			IF @FromMonth + @FromYear * 100 = @ToMonth + 100 * @ToYear
			BEGIN
				SET @sSQL1 = ' 
					SELECT	AT2008.DivisionID, AT2008.InventoryID, InventoryName,
							AT1302.UnitID, AT1302.InventoryTypeID, AT1302.Specification,
							AT1302.Notes01, AT1302.Notes02, AT1302.Notes03,
							AT1304.UnitName, AT2008.InventoryAccountID, AT1005.AccountName'
						
				SET @sSQL2 = @sGroupWareHouse + '
							, ISNULL(BEGIN1.BeginQuantity,0) AS BeginQuantity ,
							ISNULL(END1.EndQuantity,0) AS EndQuantity,
							ISNULL(BEGIN1.BeginAmount,0) AS BeginAmount,
							ISNULL(END1.EndAmount,0) AS EndAmount,
							SUM(ISNULL(DebitQuantity,0)  ) AS DebitQuantity,
							SUM(ISNULL(CreditQuantity,0)  ) AS CreditQuantity,	
							SUM(ISNULL(DebitAmount,0)  ) AS DebitAmount,
							SUM(ISNULL(CreditAmount,0)  ) AS CreditAmount,
							SUM(ISNULL(InDebitAmount,0)) AS InDebitAmount,
							SUM(ISNULL(InCreditAmount,0)) AS InCreditAmount,
							SUM(ISNULL(InDebitQuantity,0)) AS InDebitQuantity,
							SUM(ISNULL(InCreditQuantity,0)) AS InCreditQuantity,
							'
			SET  @sSQL2_2 = 'AT1302.I01ID,AT1302.I02ID,AT1302.I03ID,AT1302.I04ID,AT1302.I05ID,
							I01.AnaName AS I01Name,I02.AnaName AS I02Name,
							I03.AnaName AS I03Name,I04.AnaName AS I04Name,
							I05.AnaName AS I05Name, AT1302.Barcode, '''+@GroupID+''' as GroupID, 
							(SELECT AT1401.GroupName FROM AT1401 WITH(NOLOCK) WHERE AT1401.DivisionID = AT2008.DivisionID AND AT1401.GroupID = '''+@GroupID+''' ) AS GroupName
					
					FROM	AT2008 WITH (NOLOCK) 	
					INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (''' + @DivisionID + ''',''@@@'') AND AT1302.InventoryID = AT2008.InventoryID
					INNER JOIN AT1304 WITH (NOLOCK) ON AT1302.DivisionID IN (''' + @DivisionID + ''',''@@@'') AND AT1304.UnitID = AT1302.UnitID
					LEFT JOIN AT1005 WITH (NOLOCK) ON AT1005.AccountID = AT2008.InventoryAccountID
					LEFT JOIN AT1303 WITH (NOLOCK) ON AT1303.DivisionID IN ('''+@DivisionID+''',''@@@'') AND AT2008.WareHouseID = AT1303.WareHouseID
					LEFT JOIN AT1015 I01 WITH (NOLOCK) ON AT1302.DivisionID IN (I01.DivisionID,''@@@'') AND I01.AnaTypeID = ''I01'' AND I01.AnaID = AT1302.I01ID
					LEFT JOIN AT1015 I02 WITH (NOLOCK) ON AT1302.DivisionID IN (I02.DivisionID,''@@@'') AND I02.AnaTypeID = ''I02'' AND I02.AnaID = AT1302.I02ID
					LEFT JOIN AT1015 I03 WITH (NOLOCK) ON AT1302.DivisionID IN (I03.DivisionID,''@@@'') AND I03.AnaTypeID = ''I03'' AND I03.AnaID = AT1302.I03ID
					LEFT JOIN AT1015 I04 WITH (NOLOCK) ON AT1302.DivisionID IN (I04.DivisionID,''@@@'') AND I04.AnaTypeID = ''I04'' AND I04.AnaID = AT1302.I04ID
					LEFT JOIN AT1015 I05 WITH (NOLOCK) ON AT1302.DivisionID IN (I05.DivisionID,''@@@'') AND I05.AnaTypeID = ''I05'' AND I05.AnaID = AT1302.I05ID
				LEFT JOIN #BEGIN BEGIN1 WITH (NOLOCK) ON BEGIN1.InventoryID = AT2008.InventoryID AND BEGIN1.InventoryAccountID = AT2008.InventoryAccountID
					' + CASE  WHEN @IsWareHouse = 1 THEN ' AND BEGIN1.WareHouseID = AT2008.WareHouseID ' ELSE ' ' END + '
					LEFT JOIN #END END1 WITH (NOLOCK) ON END1.InventoryID = AT2008.InventoryID AND END1.InventoryAccountID = AT2008.InventoryAccountID
					' + CASE  WHEN @IsWareHouse = 1 THEN 'AND END1.WareHouseID = AT2008.WareHouseID ' ELSE ' ' END + '
					WHERE 	--AT1302.Disabled = 0 AND
							AT1303.IsTemp = 0 AND 
							'+CASE WHEN @CustomerName = 49 THEN ' Isnull(AT1303.FullName,'''') <> ''1'' AND 'ELSE '' END  +'
							AT2008.DivisionID = ''' + @DivisionID + ''' AND
							(AT2008.InventoryAccountID between ''' + @FromAccountID + ''' AND ''' + @ToAccountID + ''') AND
							( TranMonth  +100*TranYear  = ' + @FromMonthYearText + ') 
							AND (
							BEGIN1.BeginQuantity<>0 or END1.EndQuantity<>0 or 
							DebitQuantity<>0 or CreditQuantity<>0 or 
							BEGIN1.BeginAmount<>0 or END1.EndAmount <>0 or 
							DebitAmount<>0 or CreditAmount<>0)
					GROUP BY	AT2008.DivisionID, 
								AT2008.InventoryID,	InventoryName,	
								AT1302.UnitID,	AT1304.UnitName'
		         
				SET @sSQL3 = @sGroupWareHouse + '	
					, AT1302.InventoryTypeID, AT1302.Specification,  
					AT1302.Notes01, AT1302.Notes02, AT1302.Notes03, 
					AT2008.InventoryAccountID, AT1005.AccountName,
					AT1302.I01ID,AT1302.I02ID,AT1302.I03ID,AT1302.I04ID,AT1302.I05ID,
					I01.AnaName,I02.AnaName,I03.AnaName,I04.AnaName,I05.AnaName,AT1302.Barcode,
							BEGIN1.BeginQuantity ,
							END1.EndQuantity,
							BEGIN1.BeginAmount,
							END1.EndAmount  '

			END
			ELSE --B/c cho nhieu ky
			BEGIN

				SET @sSQL1 = '
					SELECT	AT2008.DivisionID, AT2008.InventoryID, AT1302.InventoryName,
							AT1302.UnitID,	AT1304.UnitName,
							AT1302.InventoryTypeID, AT1302.Specification,	
							AT1302.Notes01, AT1302.Notes02, AT1302.Notes03,
							AT2008.InventoryAccountID, AT1005.AccountName '
				SET @sSQL2 = @sGroupWareHouse + ' 
					, ISNULL(BEGIN1.BeginQuantity,0) AS BeginQuantity ,
					ISNULL(END1.EndQuantity,0) AS EndQuantity,
					ISNULL(BEGIN1.BeginAmount,0) AS BeginAmount,
					ISNULL(END1.EndAmount,0) AS EndAmount,
					Sum( isnull(DebitQuantity,0)  ) AS DebitQuantity,
					SUM(ISNULL(CreditQuantity,0) ) AS CreditQuantity,	
					SUM(ISNULL(DebitAmount,0)) AS DebitAmount,
					SUM(ISNULL(CreditAmount,0)) AS CreditAmount,
					SUM(ISNULL(InDebitAmount,0)) AS InDebitAmount,
					SUM(ISNULL(InCreditAmount,0)) AS InCreditAmount,
					SUM(ISNULL(InDebitQuantity,0)) AS InDebitQuantity,
					SUM(ISNULL(InCreditQuantity,0)) AS InCreditQuantity,
					AT1302.I01ID,AT1302.I02ID,AT1302.I03ID,AT1302.I04ID,AT1302.I05ID,
					I01.AnaName AS I01Name,I02.AnaName AS I02Name,
					I03.AnaName AS I03Name,I04.AnaName AS I04Name,
					I05.AnaName AS I05Name,AT1302.Barcode, '''+@GroupID+''' as GroupID,
					(SELECT AT1401.GroupName FROM AT1401 WITH(NOLOCK) WHERE AT1401.DivisionID = AT2008.DivisionID AND AT1401.GroupID = '''+@GroupID+''' ) AS GroupName
					'
			
				SET @sSQL3 = '				
					FROM	AT2008 WITH (NOLOCK) 	
					INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (''' + @DivisionID + ''',''@@@'') AND AT1302.InventoryID = AT2008.InventoryID
					INNER JOIN AT1304 WITH (NOLOCK) ON AT1302.DivisionID IN (''' + @DivisionID + ''',''@@@'') AND AT1304.UnitID = AT1302.UnitID
					LEFT JOIN AT1005 WITH (NOLOCK) ON AT1005.AccountID = AT2008.InventoryAccountID
					LEFT JOIN AT1303 WITH (NOLOCK) ON AT1303.DivisionID IN ('''+@DivisionID+''',''@@@'') AND AT2008.WareHouseID = AT1303.WareHouseID
					LEFT JOIN AT1015 I01 WITH (NOLOCK) ON AT1302.DivisionID IN (I01.DivisionID,''@@@'') AND I01.AnaTypeID = ''I01'' AND I01.AnaID = AT1302.I01ID
					LEFT JOIN AT1015 I02 WITH (NOLOCK) ON AT1302.DivisionID IN (I02.DivisionID,''@@@'') AND I02.AnaTypeID = ''I02'' AND I02.AnaID = AT1302.I02ID
					LEFT JOIN AT1015 I03 WITH (NOLOCK) ON AT1302.DivisionID IN (I03.DivisionID,''@@@'') AND I03.AnaTypeID = ''I03'' AND I03.AnaID = AT1302.I03ID
					LEFT JOIN AT1015 I04 WITH (NOLOCK) ON AT1302.DivisionID IN (I04.DivisionID,''@@@'') AND I04.AnaTypeID = ''I04'' AND I04.AnaID = AT1302.I04ID
					LEFT JOIN AT1015 I05 WITH (NOLOCK) ON AT1302.DivisionID IN (I05.DivisionID,''@@@'') AND I05.AnaTypeID = ''I05'' AND I05.AnaID = AT1302.I05ID
					LEFT JOIN #BEGIN BEGIN1 WITH (NOLOCK) ON BEGIN1.InventoryID = AT2008.InventoryID AND BEGIN1.InventoryAccountID = AT2008.InventoryAccountID
					' + CASE  WHEN @IsWareHouse = 1 THEN ' AND BEGIN1.WareHouseID = AT2008.WareHouseID' ELSE ' ' END + '
					LEFT JOIN #END END1 WITH (NOLOCK) ON END1.InventoryID = AT2008.InventoryID AND END1.InventoryAccountID = AT2008.InventoryAccountID
					' + CASE  WHEN @IsWareHouse = 1 THEN ' AND END1.WareHouseID = AT2008.WareHouseID' ELSE ' ' END + '
					WHERE  -- AT1302.Disabled = 0 AND
							AT1303.IsTemp = 0 AND 
							'+CASE WHEN @CustomerName = 49 THEN ' Isnull(AT1303.FullName,'''') <> ''1'' AND 'ELSE'' END +'
							AT2008.DivisionID = ''' + @DivisionID + ''' AND
							(AT2008.InventoryAccountID BETWEEN ''' + @FromAccountID + ''' AND ''' + @ToAccountID + ''') AND
							( TranMonth  +100*TranYear  BETWEEN ' + @FromMonthYearText + ' AND ' + str(@ToMonth) + ' +  100*' + str(@ToYear) + ') 
							AND (
							BEGIN1.BeginQuantity<>0 or END1.EndQuantity<>0 or 
							DebitQuantity<>0 or CreditQuantity<>0 or 
							BEGIN1.BeginAmount<>0 or END1.EndAmount <>0 or 
							DebitAmount<>0 or CreditAmount<>0)
					GROUP BY	AT2008.DivisionID, AT2008.InventoryID,	AT1302.InventoryName,  AT1302.UnitID,	AT1304.UnitName, 
								AT2008.InventoryAccountID ,  AT1005.AccountName, AT1302.I01ID,AT1302.I02ID,AT1302.I03ID,AT1302.I04ID,AT1302.I05ID,
								I01.AnaName,I02.AnaName,I03.AnaName,I04.AnaName,I05.AnaName,AT1302.Barcode,BEGIN1.BeginQuantity ,
								END1.EndQuantity,
								BEGIN1.BeginAmount,
								END1.EndAmount'
		         
				SET @sSQL4 = @sGroupWareHouse + ', AT1302.InventoryTypeID, AT1302.Specification, AT1302.Notes01, AT1302.Notes02, AT1302.Notes03 '

			END

			

			--IF NOT EXISTS ( SELECT 1 FROM sysObjects WHERE Xtype = 'V' AND Name = 'AV2016' )
			--	EXEC ( ' CREATE VIEW AV2016 AS '+@sSQL1+@sSQL2+@sSQL2_2+@sSQL3+@sSQL4 )
			--ELSE
			--	EXEC ( ' ALTER VIEW AV2016 AS '+@sSQL1+@sSQL2+@sSQL2_2+@sSQL3+@sSQL4 )


			--SET @sSQL1 = ' 
			--	SELECT * FROM AV2016		
			--	WHERE 	(	BeginQuantity<>0 or EndQuantity<>0 or 
			--				DebitQuantity<>0 or CreditQuantity<>0 or 
			--				BeginAmount<>0 or EndAmount <>0 or 
			--				DebitAmount<>0 or CreditAmount<>0) '
			--EXEC (@sSQL1)
			
			--PRINT @sSQL0
			--PRINT @sSQL1
			--PRINT @sSQL2
			--PRINT @sSQL2_2
			--PRINT @sSQL3
			--PRINT @sSQL4

			EXEC (@sSQL0 + @sSQL1 + @sSQL2 + @sSQL2_2 + @sSQL3 + @sSQL4)
				--IF NOT EXISTS ( SELECT 1 FROM sysObjects WHERE Xtype = 'V' AND Name = 'AV2007' )
				--   EXEC ( ' CREATE VIEW AV2007 AS '+@sSQL1 )
				--ELSE
				--   EXEC ( ' ALTER VIEW AV2007 AS '+@sSQL1 )
		END
		ELSE -- THEO NGÀY
		BEGIN
			DECLARE @SQL NVARCHAR(MAX),
					@SQL1 NVARCHAR(MAX),
					@SQL2 NVARCHAR(MAX),
					@SQL2A NVARCHAR(MAX),
					@SQL3 NVARCHAR(MAX),
					@SQL4 NVARCHAR(MAX),
					@SQL5 NVARCHAR(MAX),
					@FromDateText VARCHAR(50),
					@ToDateText VARCHAR(50)
			
			SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)  
			SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'  

			CREATE TABLE #TEMP (DivisionID VARCHAR(50),InventoryID VARCHAR(50), InventoryName NVARCHAR(MAX),UnitID VARCHAR(50), UnitName NVARCHAR(250),InventoryTypeID VARCHAR(50),
					Specification NVARCHAR(250),Notes01 NVARCHAR(250),Notes02 NVARCHAR(250),Notes03 NVARCHAR(250),AccountID VARCHAR(50),AccountName NVARCHAR(MAX),
					BeginQuantity DECIMAL(28,8) DEFAULT(0),BeginAmount DECIMAL(28,8) DEFAULT(0),DebitQuantity DECIMAL(28,8) DEFAULT(0), DebitAmount DECIMAL(28,8) DEFAULT(0),
					CreditQuantity DECIMAL(28,8) DEFAULT(0), CreditAmount DECIMAL(28,8) DEFAULT(0), EndQuantity DECIMAL(28,8) DEFAULT(0),EndAmount DECIMAL(28,8) DEFAULT(0),
					InDebitQuantity DECIMAL(28,8) DEFAULT(0), InDebitAmount DECIMAL(28,8) DEFAULT(0),InCreditQuantity DECIMAL(28,8) DEFAULT(0),InCreditAmount DECIMAL(28,8) DEFAULT(0),
					I01ID NVARCHAR(50), I02ID NVARCHAR(50),I03ID NVARCHAR(50),I04ID NVARCHAR(50),I05ID NVARCHAR(50),I01Name NVARCHAR(250), I02Name NVARCHAR(250),I03Name NVARCHAR(250),
					I04Name NVARCHAR(250),I05Name NVARCHAR(250),Barcode NVARCHAR(50),WareHouseID NVARCHAR(50), WareHouseName NVARCHAR(250), GroupID NVARCHAR(50) )


			-- Tính t?n d?u
			-- S? du d?u k?
			SET @SQL='
			SELECT TEMP1.DivisionID, TEMP1.InventoryID, TEMP1.InventoryName, TEMP1.UnitID, TEMP1.UnitName, TEMP1.InventoryTypeID, TEMP1.Specification, TEMP1.Notes01, TEMP1.Notes02, TEMP1.Notes03,
									TEMP1.AccountID, TEMP1.AccountName, SUM(TEMP1.ActualQuantity) AS BeginQuantity, SUM(TEMP1.ConvertedAmount) AS BeginAmount,
									TEMP1.I01ID, TEMP1.I02ID, TEMP1.I03ID, TEMP1.I04ID, TEMP1.I05ID, TEMP1.I01Name, TEMP1.I02Name, TEMP1.I03Name, TEMP1.I04Name, TEMP1.I05Name, TEMP1.Barcode
									' + CASE WHEN @IsWarehouse = 1 THEN + ', TEMP1.WareHouseID, TEMP1.WareHouseName ' ELSE '' END + '
			INTO #TEMP1
			FROM (
			SELECT A1.DivisionID, A1.InventoryID, A3.InventoryName, A3.UnitID, A4.UnitName, A3.InventoryTypeID, A3.Specification, A3.Notes01, A3.Notes02, A3.Notes03,
									A3.AccountID, A5.AccountName, A1.ActualQuantity, A1.ConvertedAmount,
									A3.I01ID,A3.I02ID,A3.I03ID,A3.I04ID,A3.I05ID, I01.AnaName AS I01Name,I02.AnaName AS I02Name,
									I03.AnaName AS I03Name,I04.AnaName AS I04Name,I05.AnaName AS I05Name,A3.Barcode
									' + CASE WHEN @IsWarehouse = 1 THEN + ', A2.WareHouseID, A6.WareHouseName ' ELSE '' END + '
			FROM AT2017 A1 WITH (NOLOCK) INNER JOIN AT2016 A2 WITH (NOLOCK) ON A1.VoucherID = A2.VoucherID
			LEFT JOIN AT1302 A3 WITH (NOLOCK) ON A3.DivisionID IN (A1.DivisionID,''@@@'') AND A1.InventoryID = A3.InventoryID
			LEFT JOIN AT1304 A4 WITH (NOLOCK) ON A3.UnitID = A4.UnitID
			LEFT JOIN AT1005 A5 WITH (NOLOCK) ON A3.AccountID = A5.AccountID
			LEFT JOIN AT1015 I01 WITH (NOLOCK) ON I01.AnaTypeID = ''I01'' AND I01.AnaID = A3.I01ID
			LEFT JOIN AT1015 I02 WITH (NOLOCK) ON I02.AnaTypeID = ''I02'' AND I02.AnaID = A3.I02ID
			LEFT JOIN AT1015 I03 WITH (NOLOCK) ON I03.AnaTypeID = ''I03'' AND I03.AnaID = A3.I03ID
			LEFT JOIN AT1015 I04 WITH (NOLOCK) ON I04.AnaTypeID = ''I04'' AND I04.AnaID = A3.I04ID
			LEFT JOIN AT1015 I05 WITH (NOLOCK) ON I05.AnaTypeID = ''I05'' AND I05.AnaID = A3.I05ID
			LEFT JOIN AT1303 A6 WITH (NOLOCK) ON A6.DivisionID IN ('''+@DivisionID+''',''@@@'') AND A2.WarehouseID = A6.WarehouseID
			WHERE A1.DivisionID = '''+@DivisionID+''' AND A1.DebitAccountID BETWEEN '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND A6.IsTemp = 0
			'
			SET @SQL1='
			UNION ALL
			-- Nh?p tru?c @FromDateText
			SELECT A1.DivisionID, A1.InventoryID, A3.InventoryName, A3.UnitID, A4.UnitName, A3.InventoryTypeID, A3.Specification, A3.Notes01, A3.Notes02, A3.Notes03,
									A1.DebitAccountID, A5.AccountName, A1.ActualQuantity, A1.ConvertedAmount,
									A3.I01ID,A3.I02ID,A3.I03ID,A3.I04ID,A3.I05ID, I01.AnaName AS I01Name,I02.AnaName AS I02Name,
									I03.AnaName AS I03Name,I04.AnaName AS I04Name,I05.AnaName AS I05Name,A3.Barcode
									' + CASE WHEN @IsWarehouse = 1 THEN + ', A2.WareHouseID, A6.WareHouseName ' ELSE '' END + '
			FROM AT2007 A1 WITH (NOLOCK) INNER JOIN AT2006 A2 WITH (NOLOCK) ON A1.VoucherID = A2.VoucherID
			LEFT JOIN AT1302 A3 WITH (NOLOCK) ON A3.DivisionID IN (A1.DivisionID,''@@@'') AND A1.InventoryID = A3.InventoryID
			LEFT JOIN AT1304 A4 WITH (NOLOCK) ON A3.UnitID = A4.UnitID
			LEFT JOIN AT1005 A5 WITH (NOLOCK) ON A3.AccountID = A5.AccountID
			LEFT JOIN AT1015 I01 WITH (NOLOCK) ON I01.AnaTypeID = ''I01'' AND I01.AnaID = A3.I01ID
			LEFT JOIN AT1015 I02 WITH (NOLOCK) ON I02.AnaTypeID = ''I02'' AND I02.AnaID = A3.I02ID
			LEFT JOIN AT1015 I03 WITH (NOLOCK) ON I03.AnaTypeID = ''I03'' AND I03.AnaID = A3.I03ID
			LEFT JOIN AT1015 I04 WITH (NOLOCK) ON I04.AnaTypeID = ''I04'' AND I04.AnaID = A3.I04ID
			LEFT JOIN AT1015 I05 WITH (NOLOCK) ON I05.AnaTypeID = ''I05'' AND I05.AnaID = A3.I05ID
			LEFT JOIN AT1303 A6 WITH (NOLOCK) ON A6.DivisionID IN ('''+@DivisionID+''',''@@@'') AND A2.WarehouseID = A6.WarehouseID
			WHERE A1.DivisionID = '''+@DivisionID+''' AND A1.DebitAccountID BETWEEN '''+@FromAccountID+''' AND '''+@ToAccountID+'''
					AND A2.KindVoucherID in (1,3,5,7,9,15,17)
					AND A2.VoucherDate < '''+@FromDateText+'''
					AND A6.IsTemp = 0
			UNION ALL
			--Xu?t tru?c @FromDateText
			SELECT A1.DivisionID, A1.InventoryID, A3.InventoryName, A3.UnitID, A4.UnitName, A3.InventoryTypeID, A3.Specification, A3.Notes01, A3.Notes02, A3.Notes03,
									A1.CreditAccountID, A5.AccountName, -A1.ActualQuantity AS ActualQuantity, -A1.ConvertedAmount AS OriginalAmount,
									A3.I01ID,A3.I02ID,A3.I03ID,A3.I04ID,A3.I05ID, I01.AnaName AS I01Name,I02.AnaName AS I02Name,
									I03.AnaName AS I03Name,I04.AnaName AS I04Name,I05.AnaName AS I05Name,A3.Barcode
									' + CASE WHEN @IsWarehouse = 1 THEN + ', CASE WHEN A2.KindVoucherID = 3 THEN A2.WarehouseID2 ELSE A2.WareHouseID END AS WareHouseID, A6.WareHouseName ' ELSE '' END + '
			FROM AT2007 A1 WITH (NOLOCK) INNER JOIN AT2006 A2 WITH (NOLOCK) ON A1.VoucherID = A2.VoucherID
			LEFT JOIN AT1302 A3 WITH (NOLOCK) ON A3.DivisionID IN (A1.DivisionID,''@@@'') AND A1.InventoryID = A3.InventoryID
			LEFT JOIN AT1304 A4 WITH (NOLOCK) ON A3.UnitID = A4.UnitID
			LEFT JOIN AT1005 A5 WITH (NOLOCK) ON A3.AccountID = A5.AccountID
			LEFT JOIN AT1015 I01 WITH (NOLOCK) ON I01.AnaTypeID = ''I01'' AND I01.AnaID = A3.I01ID
			LEFT JOIN AT1015 I02 WITH (NOLOCK) ON I02.AnaTypeID = ''I02'' AND I02.AnaID = A3.I02ID
			LEFT JOIN AT1015 I03 WITH (NOLOCK) ON I03.AnaTypeID = ''I03'' AND I03.AnaID = A3.I03ID
			LEFT JOIN AT1015 I04 WITH (NOLOCK) ON I04.AnaTypeID = ''I04'' AND I04.AnaID = A3.I04ID
			LEFT JOIN AT1015 I05 WITH (NOLOCK) ON I05.AnaTypeID = ''I05'' AND I05.AnaID = A3.I05ID
			LEFT JOIN AT1303 A6 WITH (NOLOCK) ON A6.DivisionID IN ('''+@DivisionID+''',''@@@'') AND CASE WHEN A2.KindVoucherID = 3 THEN A2.WarehouseID2 ELSE A2.WareHouseID END = A6.WarehouseID
			WHERE A1.DivisionID = '''+@DivisionID+''' AND A1.CreditAccountID BETWEEN '''+@FromAccountID+''' AND '''+@ToAccountID+'''
			AND A2.KindVoucherID in (2,3,4,6,8,10,14,20)
			AND A2.VoucherDate < '''+@FromDateText+'''
			AND A6.IsTemp = 0
			) TEMP1
			GROUP BY TEMP1.DivisionID, TEMP1.InventoryID, TEMP1.InventoryName, TEMP1.UnitID, TEMP1.UnitName, TEMP1.InventoryTypeID, TEMP1.Specification, TEMP1.Notes01, TEMP1.Notes02, TEMP1.Notes03,
									TEMP1.AccountID, TEMP1.AccountName, TEMP1.I01ID, TEMP1.I02ID, TEMP1.I03ID, TEMP1.I04ID, TEMP1.I05ID, TEMP1.I01Name, TEMP1.I02Name, TEMP1.I03Name, TEMP1.I04Name, TEMP1.I05Name, TEMP1.Barcode
									' + CASE WHEN @IsWarehouse = 1 THEN + ', TEMP1.WareHouseID, TEMP1.WareHouseName ' ELSE '' END + '

			'
			SET @SQL2='
			--Tính nh?p t? @FromDateText -> @ToDateText
			SELECT A1.DivisionID, A1.InventoryID, A3.InventoryName, A3.UnitID, A4.UnitName, A3.InventoryTypeID, A3.Specification, A3.Notes01, A3.Notes02, A3.Notes03,
									A1.DebitAccountID, A5.AccountName, SUM(A1.ActualQuantity) AS DebitQuantity, SUM(A1.ConvertedAmount) AS DebitAmount,
									A3.I01ID,A3.I02ID,A3.I03ID,A3.I04ID,A3.I05ID, I01.AnaName AS I01Name,I02.AnaName AS I02Name,
									I03.AnaName AS I03Name,I04.AnaName AS I04Name,I05.AnaName AS I05Name,A3.Barcode
									' + CASE WHEN @IsWarehouse = 1 THEN + ', A2.WareHouseID, A6.WareHouseName ' ELSE '' END + '
			INTO #TEMP2_IM
			FROM AT2007 A1 WITH (NOLOCK) INNER JOIN AT2006 A2 WITH (NOLOCK) ON A1.VoucherID = A2.VoucherID
			LEFT JOIN AT1302 A3 WITH (NOLOCK) ON A3.DivisionID IN (A1.DivisionID,''@@@'') AND A1.InventoryID = A3.InventoryID
			LEFT JOIN AT1304 A4 WITH (NOLOCK) ON A3.UnitID = A4.UnitID
			LEFT JOIN AT1005 A5 WITH (NOLOCK) ON A3.AccountID = A5.AccountID
			LEFT JOIN AT1015 I01 WITH (NOLOCK) ON I01.AnaTypeID = ''I01'' AND I01.AnaID = A3.I01ID
			LEFT JOIN AT1015 I02 WITH (NOLOCK) ON I02.AnaTypeID = ''I02'' AND I02.AnaID = A3.I02ID
			LEFT JOIN AT1015 I03 WITH (NOLOCK) ON I03.AnaTypeID = ''I03'' AND I03.AnaID = A3.I03ID
			LEFT JOIN AT1015 I04 WITH (NOLOCK) ON I04.AnaTypeID = ''I04'' AND I04.AnaID = A3.I04ID
			LEFT JOIN AT1015 I05 WITH (NOLOCK) ON I05.AnaTypeID = ''I05'' AND I05.AnaID = A3.I05ID
			LEFT JOIN AT1303 A6 WITH (NOLOCK) ON A6.DivisionID IN ('''+@DivisionID+''',''@@@'') AND A2.WarehouseID = A6.WarehouseID
			WHERE A1.DivisionID = '''+@DivisionID+''' AND A1.DebitAccountID BETWEEN '''+@FromAccountID+''' AND '''+@ToAccountID+'''
					AND A2.KindVoucherID in (1,3,5,7,9,15,17)
					AND A2.VoucherDate BETWEEN '''+@FromDateText+''' AND '''+@ToDateText+'''
					AND A6.IsTemp = 0
			GROUP BY  A1.DivisionID, A1.InventoryID, A3.InventoryName, A3.UnitID, A4.UnitName, A3.InventoryTypeID, A3.Specification, A3.Notes01, A3.Notes02, A3.Notes03,
									A1.DebitAccountID, A5.AccountName,A3.I01ID,A3.I02ID,A3.I03ID,A3.I04ID,A3.I05ID, I01.AnaName,I02.AnaName,
									I03.AnaName,I04.AnaName,I05.AnaName,A3.Barcode
									' + CASE WHEN @IsWarehouse = 1 THEN + ', A2.WareHouseID, A6.WareHouseName ' ELSE '' END + '	'
			
			SET @SQL2A='
			--Tính xu?t t? @FromDateText -> @ToDateText
			SELECT A1.DivisionID, A1.InventoryID, A3.InventoryName, A3.UnitID, A4.UnitName, A3.InventoryTypeID, A3.Specification, A3.Notes01, A3.Notes02, A3.Notes03,
									A1.CreditAccountID, A5.AccountName, SUM(A1.ActualQuantity) AS CreditQuantity, SUM(A1.ConvertedAmount) AS CreditAmount,
									A3.I01ID,A3.I02ID,A3.I03ID,A3.I04ID,A3.I05ID, I01.AnaName AS I01Name,I02.AnaName AS I02Name,
									I03.AnaName AS I03Name,I04.AnaName AS I04Name,I05.AnaName AS I05Name,A3.Barcode
									' + CASE WHEN @IsWarehouse = 1 THEN + ', CASE WHEN A2.KindVoucherID = 3 THEN A2.WarehouseID2 ELSE A2.WareHouseID END AS WareHouseID, A6.WareHouseName ' ELSE '' END + '
			INTO #TEMP2_EX
			FROM AT2007 A1 WITH (NOLOCK) INNER JOIN AT2006 A2 WITH (NOLOCK) ON A1.VoucherID = A2.VoucherID
			LEFT JOIN AT1302 A3 WITH (NOLOCK) ON A3.DivisionID IN (A1.DivisionID,''@@@'') AND A1.InventoryID = A3.InventoryID
			LEFT JOIN AT1304 A4 WITH (NOLOCK) ON A3.UnitID = A4.UnitID
			LEFT JOIN AT1005 A5 WITH (NOLOCK) ON A3.AccountID = A5.AccountID
			LEFT JOIN AT1015 I01 WITH (NOLOCK) ON I01.AnaTypeID = ''I01'' AND I01.AnaID = A3.I01ID
			LEFT JOIN AT1015 I02 WITH (NOLOCK) ON I02.AnaTypeID = ''I02'' AND I02.AnaID = A3.I02ID
			LEFT JOIN AT1015 I03 WITH (NOLOCK) ON I03.AnaTypeID = ''I03'' AND I03.AnaID = A3.I03ID
			LEFT JOIN AT1015 I04 WITH (NOLOCK) ON I04.AnaTypeID = ''I04'' AND I04.AnaID = A3.I04ID
			LEFT JOIN AT1015 I05 WITH (NOLOCK) ON I05.AnaTypeID = ''I05'' AND I05.AnaID = A3.I05ID
			LEFT JOIN AT1303 A6 WITH (NOLOCK) ON A6.DivisionID IN ('''+@DivisionID+''',''@@@'') AND CASE WHEN A2.KindVoucherID = 3 THEN A2.WarehouseID2 ELSE A2.WareHouseID END = A6.WarehouseID
			WHERE A1.DivisionID = '''+@DivisionID+''' AND A1.CreditAccountID BETWEEN '''+@FromAccountID+''' AND '''+@ToAccountID+'''
					AND A2.KindVoucherID in (2,3,4,6,8,10,14,20)
					AND A2.VoucherDate BETWEEN '''+@FromDateText+''' AND '''+@ToDateText+'''
					AND A6.IsTemp = 0
			GROUP BY A1.DivisionID, A1.InventoryID, A3.InventoryName, A3.UnitID, A4.UnitName, A3.InventoryTypeID, A3.Specification, A3.Notes01, A3.Notes02, A3.Notes03,
									A1.CreditAccountID, A5.AccountName,A3.I01ID,A3.I02ID,A3.I03ID,A3.I04ID,A3.I05ID, I01.AnaName,I02.AnaName,
									I03.AnaName,I04.AnaName,I05.AnaName,A3.Barcode
									' + CASE WHEN @IsWarehouse = 1 THEN + ', CASE WHEN A2.KindVoucherID = 3 THEN A2.WarehouseID2 ELSE A2.WareHouseID END, A6.WareHouseName ' ELSE '' END + '
			'
			SET @SQL3='
			-- Tính s? lu?ng nh?p VCNB
			SELECT A1.DivisionID, A1.InventoryID, A3.InventoryName, A3.UnitID, A4.UnitName, A3.InventoryTypeID, A3.Specification, A3.Notes01, A3.Notes02, A3.Notes03,
						A1.DebitAccountID, A5.AccountName, SUM(A1.ActualQuantity) AS InDebitQuantity, SUM(A1.ConvertedAmount) AS InDebitAmount,A3.I01ID,A3.I02ID,A3.I03ID,
						A3.I04ID,A3.I05ID,  I01.AnaName AS I01Name,I02.AnaName AS I02Name,
						I03.AnaName AS I03Name,I04.AnaName AS I04Name,I05.AnaName AS I05Name,A3.Barcode
						' + CASE WHEN @IsWarehouse = 1 THEN + ', A2.WareHouseID, A6.WareHouseName ' ELSE '' END + '
			INTO #TEMP3_IM
			FROM AT2007 A1 WITH (NOLOCK) INNER JOIN AT2006 A2 WITH (NOLOCK) ON A1.VoucherID = A2.VoucherID
			LEFT JOIN AT1302 A3 WITH (NOLOCK) ON A3.DivisionID IN (A1.DivisionID,''@@@'') AND A1.InventoryID = A3.InventoryID
			LEFT JOIN AT1304 A4 WITH (NOLOCK) ON A3.UnitID = A4.UnitID
			LEFT JOIN AT1005 A5 WITH (NOLOCK) ON A3.AccountID = A5.AccountID
			LEFT JOIN AT1303 A6 WITH (NOLOCK) ON A6.DivisionID IN ('''+@DivisionID+''',''@@@'') AND A2.WarehouseID = A6.WarehouseID
			LEFT JOIN AT1015 I01 WITH (NOLOCK) ON I01.AnaTypeID = ''I01'' AND I01.AnaID = A3.I01ID
			LEFT JOIN AT1015 I02 WITH (NOLOCK) ON I02.AnaTypeID = ''I02'' AND I02.AnaID = A3.I02ID
			LEFT JOIN AT1015 I03 WITH (NOLOCK) ON I03.AnaTypeID = ''I03'' AND I03.AnaID = A3.I03ID
			LEFT JOIN AT1015 I04 WITH (NOLOCK) ON I04.AnaTypeID = ''I04'' AND I04.AnaID = A3.I04ID
			LEFT JOIN AT1015 I05 WITH (NOLOCK) ON I05.AnaTypeID = ''I05'' AND I05.AnaID = A3.I05ID
			WHERE A1.DivisionID = '''+@DivisionID+''' AND A1.DebitAccountID BETWEEN '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND A2.KindVoucherID = 3
					AND A6.IsTemp = 0
			GROUP BY A1.DivisionID, A1.InventoryID, A3.InventoryName, A3.UnitID, A4.UnitName, A3.InventoryTypeID, A3.Specification, A3.Notes01, A3.Notes02, A3.Notes03,
						A1.DebitAccountID, A5.AccountName,A3.I01ID,A3.I02ID,A3.I03ID,
						A3.I04ID,A3.I05ID,  I01.AnaName,I02.AnaName,
						I03.AnaName,I04.AnaName,I05.AnaName,A3.Barcode
						' + CASE WHEN @IsWarehouse = 1 THEN + ', A2.WareHouseID, A6.WareHouseName ' ELSE '' END + '

			-- Tính s? lu?ng xu?t VCNB
			SELECT A1.DivisionID, A1.InventoryID, A3.InventoryName, A3.UnitID, A4.UnitName, A3.InventoryTypeID, A3.Specification, A3.Notes01, A3.Notes02, A3.Notes03,
						A1.CreditAccountID, A5.AccountName, SUM(A1.ActualQuantity) AS InCreditQuantity, SUM(A1.ConvertedAmount) AS InCreditAmount,
						A3.I01ID,A3.I02ID,A3.I03ID,A3.I04ID,A3.I05ID,  I01.AnaName AS I01Name,I02.AnaName AS I02Name,
						I03.AnaName AS I03Name,I04.AnaName AS I04Name,I05.AnaName AS I05Name,A3.Barcode
						' + CASE WHEN @IsWarehouse = 1 THEN + ', A2.WareHouseID2 AS WareHouseID, A6.WareHouseName ' ELSE '' END + '
			INTO #TEMP3_EX
			FROM AT2007 A1 WITH (NOLOCK) INNER JOIN AT2006 A2 WITH (NOLOCK) ON A1.VoucherID = A2.VoucherID
			LEFT JOIN AT1302 A3 WITH (NOLOCK) ON A3.DivisionID IN (A1.DivisionID,''@@@'') AND A1.InventoryID = A3.InventoryID
			LEFT JOIN AT1304 A4 WITH (NOLOCK) ON A3.UnitID = A4.UnitID
			LEFT JOIN AT1005 A5 WITH (NOLOCK) ON A3.AccountID = A5.AccountID
			LEFT JOIN AT1303 A6 WITH (NOLOCK) ON A6.DivisionID IN ('''+@DivisionID+''',''@@@'') AND A2.WarehouseID2 = A6.WarehouseID
			LEFT JOIN AT1015 I01 WITH (NOLOCK) ON I01.AnaTypeID = ''I01'' AND I01.AnaID = A3.I01ID
			LEFT JOIN AT1015 I02 WITH (NOLOCK) ON I02.AnaTypeID = ''I02'' AND I02.AnaID = A3.I02ID
			LEFT JOIN AT1015 I03 WITH (NOLOCK) ON I03.AnaTypeID = ''I03'' AND I03.AnaID = A3.I03ID
			LEFT JOIN AT1015 I04 WITH (NOLOCK) ON I04.AnaTypeID = ''I04'' AND I04.AnaID = A3.I04ID
			LEFT JOIN AT1015 I05 WITH (NOLOCK) ON I05.AnaTypeID = ''I05'' AND I05.AnaID = A3.I05ID
			WHERE A1.DivisionID = '''+@DivisionID+''' AND A1.CreditAccountID BETWEEN '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND A2.KindVoucherID = 3
					AND A6.IsTemp = 0
			GROUP BY A1.DivisionID, A1.InventoryID, A3.InventoryName, A3.UnitID, A4.UnitName, A3.InventoryTypeID, A3.Specification, A3.Notes01, A3.Notes02, A3.Notes03,
						A1.CreditAccountID, A5.AccountName,A3.I01ID,A3.I02ID,A3.I03ID,A3.I04ID,A3.I05ID,  I01.AnaName,I02.AnaName,
						I03.AnaName,I04.AnaName,I05.AnaName,A3.Barcode
						' + CASE WHEN @IsWarehouse = 1 THEN + ', A2.WareHouseID2, A6.WareHouseName ' ELSE '' END + '
			'

			SET @SQL4='
			INSERT INTO #TEMP (DivisionID, InventoryID, InventoryName, UnitID, UnitName, InventoryTypeID, Specification, Notes01, Notes02, Notes03,
								AccountID, AccountName, BeginQuantity, BeginAmount, I01ID, I02ID, I03ID, I04ID, I05ID, I01Name, I02Name, I03Name, I04Name, I05Name, Barcode
								' + CASE WHEN @IsWarehouse = 1 THEN + ', WareHouseID, WareHouseName ' ELSE '' END + ')
			SELECT #TEMP1.DivisionID, #TEMP1.InventoryID, #TEMP1.InventoryName, #TEMP1.UnitID, #TEMP1.UnitName, #TEMP1.InventoryTypeID, #TEMP1.Specification, #TEMP1.Notes01, #TEMP1.Notes02, #TEMP1.Notes03,
					#TEMP1.AccountID, #TEMP1.AccountName, #TEMP1.BeginQuantity, #TEMP1.BeginAmount, #TEMP1.I01ID, #TEMP1.I02ID, #TEMP1.I03ID, #TEMP1.I04ID, #TEMP1.I05ID, #TEMP1.I01Name, #TEMP1.I02Name, #TEMP1.I03Name, 
					#TEMP1.I04Name, #TEMP1.I05Name, #TEMP1.Barcode ' + CASE WHEN @IsWarehouse = 1 THEN + ',  #TEMP1.WareHouseID, #TEMP1.WareHouseName  ' ELSE '' END + '
			FROM #TEMP1
			
			INSERT INTO #TEMP (DivisionID, InventoryID, InventoryName, UnitID, UnitName, InventoryTypeID, Specification, Notes01, Notes02, Notes03,
								AccountID, AccountName, DebitQuantity, DebitAmount, I01ID, I02ID, I03ID, I04ID, I05ID, I01Name, I02Name,
								I03Name, I04Name, I05Name, Barcode ' + CASE WHEN @IsWarehouse = 1 THEN + ', WareHouseID, WareHouseName ' ELSE '' END + ')
			SELECT #TEMP2_IM.DivisionID, #TEMP2_IM.InventoryID, #TEMP2_IM.InventoryName, #TEMP2_IM.UnitID, #TEMP2_IM.UnitName, #TEMP2_IM.InventoryTypeID, #TEMP2_IM.Specification, #TEMP2_IM.Notes01, #TEMP2_IM.Notes02, #TEMP2_IM.Notes03,
					#TEMP2_IM.DebitAccountID, #TEMP2_IM.AccountName, #TEMP2_IM.DebitQuantity, #TEMP2_IM.DebitAmount, #TEMP2_IM.I01ID, #TEMP2_IM.I02ID, #TEMP2_IM.I03ID, #TEMP2_IM.I04ID, #TEMP2_IM.I05ID, #TEMP2_IM.I01Name, #TEMP2_IM.I02Name,
					#TEMP2_IM.I03Name, #TEMP2_IM.I04Name, #TEMP2_IM.I05Name, #TEMP2_IM.Barcode ' + CASE WHEN @IsWarehouse = 1 THEN + ', #TEMP2_IM.WareHouseID, #TEMP2_IM.WareHouseName' ELSE '' END + '
			FROM #TEMP2_IM


			INSERT INTO #TEMP (DivisionID, InventoryID, InventoryName, UnitID, UnitName, InventoryTypeID, Specification, Notes01, Notes02, Notes03,
							AccountID, AccountName, CreditQuantity, CreditAmount,
							I01ID,I02ID,I03ID,I04ID,I05ID,I01Name,I02Name,
							I03Name,I04Name,I05Name,Barcode
									' + CASE WHEN @IsWarehouse = 1 THEN + ', WareHouseID, WareHouseName ' ELSE '' END + ')
			SELECT #TEMP2_EX.DivisionID, #TEMP2_EX.InventoryID, #TEMP2_EX.InventoryName, #TEMP2_EX.UnitID, #TEMP2_EX.UnitName, #TEMP2_EX.InventoryTypeID, #TEMP2_EX.Specification, #TEMP2_EX.Notes01, #TEMP2_EX.Notes02, #TEMP2_EX.Notes03,
					#TEMP2_EX.CreditAccountID, #TEMP2_EX.AccountName, #TEMP2_EX.CreditQuantity, #TEMP2_EX.CreditAmount,
					#TEMP2_EX.I01ID,#TEMP2_EX.I02ID,#TEMP2_EX.I03ID,#TEMP2_EX.I04ID,#TEMP2_EX.I05ID,#TEMP2_EX.I01Name,#TEMP2_EX.I02Name,
					#TEMP2_EX.I03Name,#TEMP2_EX.I04Name,#TEMP2_EX.I05Name,#TEMP2_EX.Barcode' + CASE WHEN @IsWarehouse = 1 THEN + ', #TEMP2_EX.WareHouseID, #TEMP2_EX.WareHouseName' ELSE '' END + '
			FROM #TEMP2_EX

			INSERT INTO #TEMP (DivisionID, InventoryID, InventoryName, UnitID, UnitName, InventoryTypeID, Specification, Notes01, Notes02, Notes03,
								AccountID, AccountName, InDebitQuantity, InDebitAmount,I01ID,I02ID,I03ID,
								I04ID,I05ID, I01Name, I02Name, I03Name, I04Name, I05Name, Barcode
								' + CASE WHEN @IsWarehouse = 1 THEN + ', WareHouseID, WareHouseName ' ELSE '' END + ')
			SELECT #TEMP3_IM.DivisionID, #TEMP3_IM.InventoryID, #TEMP3_IM.InventoryName, #TEMP3_IM.UnitID, #TEMP3_IM.UnitName, #TEMP3_IM.InventoryTypeID, #TEMP3_IM.Specification, #TEMP3_IM.Notes01, #TEMP3_IM.Notes02, #TEMP3_IM.Notes03,
					#TEMP3_IM.DebitAccountID, #TEMP3_IM.AccountName, #TEMP3_IM.InDebitQuantity, #TEMP3_IM.InDebitAmount,#TEMP3_IM.I01ID,#TEMP3_IM.I02ID,#TEMP3_IM.I03ID,
					#TEMP3_IM.I04ID,#TEMP3_IM.I05ID, #TEMP3_IM.I01Name, #TEMP3_IM.I02Name, #TEMP3_IM.I03Name, #TEMP3_IM.I04Name, #TEMP3_IM.I05Name, #TEMP3_IM.Barcode ' + CASE WHEN @IsWarehouse = 1 THEN + ',#TEMP3_IM.WareHouseID, #TEMP3_IM.WareHouseName' ELSE '' END + '
			FROM #TEMP3_IM

			INSERT INTO #TEMP (DivisionID, InventoryID, InventoryName, UnitID, UnitName, InventoryTypeID, Specification, Notes01, Notes02, Notes03,
								AccountID, AccountName, InCreditQuantity, InCreditAmount,
								I01ID, I02ID, I03ID, I04ID, I05ID, I01Name, I02Name, I03Name, I04Name, I05Name,Barcode
								' + CASE WHEN @IsWarehouse = 1 THEN + ', WareHouseID, WareHouseName ' ELSE '' END + ')
			SELECT #TEMP3_EX.DivisionID, #TEMP3_EX.InventoryID, #TEMP3_EX.InventoryName, #TEMP3_EX.UnitID, #TEMP3_EX.UnitName, #TEMP3_EX.InventoryTypeID, #TEMP3_EX.Specification, #TEMP3_EX.Notes01, #TEMP3_EX.Notes02, #TEMP3_EX.Notes03,
					#TEMP3_EX.CreditAccountID, #TEMP3_EX.AccountName, #TEMP3_EX.InCreditQuantity, #TEMP3_EX.InCreditAmount,
					#TEMP3_EX.I01ID, #TEMP3_EX.I02ID, #TEMP3_EX.I03ID, #TEMP3_EX.I04ID, #TEMP3_EX.I05ID, #TEMP3_EX.I01Name, #TEMP3_EX.I02Name, #TEMP3_EX.I03Name, #TEMP3_EX.I04Name, #TEMP3_EX.I05Name,#TEMP3_EX.Barcode
					' + CASE WHEN @IsWarehouse = 1 THEN + ', #TEMP3_EX.WareHouseID, #TEMP3_EX.WareHouseName ' ELSE '' END + '
			FROM #TEMP3_EX
			'

			SET @SQL5='
			SELECT #TEMP.DivisionID, #TEMP.InventoryID, #TEMP.InventoryName, #TEMP.UnitID, #TEMP.UnitName, #TEMP.InventoryTypeID,
					#TEMP.Specification, #TEMP.Notes01, #TEMP.Notes02, #TEMP.Notes03, #TEMP.AccountID, #TEMP.AccountName,
					sum(#TEMP.BeginQuantity) as BeginQuantity, sum(#TEMP.BeginAmount) as BeginAmount,
					sum(#TEMP.DebitQuantity) as DebitQuantity, sum(#TEMP.DebitAmount) as DebitAmount,
					sum(#TEMP.CreditQuantity) as CreditQuantity , sum(#TEMP.CreditAmount) as CreditAmount, 
					sum(#TEMP.BeginQuantity)+SUM(#TEMP.DebitQuantity)-sum(#TEMP.CreditQuantity) AS EndQuantity,
					sum(#TEMP.BeginAmount)+sum(#TEMP.DebitAmount)-sum(#TEMP.CreditAmount) as EndAmount,
					sum(#TEMP.InDebitQuantity) as InDebitQuantity, sum(#TEMP.InDebitAmount) as InDebitAmount, 
					sum(#TEMP.InCreditQuantity) as InCreditQuantity, sum(#TEMP.InCreditAmount) as InCreditAmount,
					#TEMP.I01ID, #TEMP.I02ID, #TEMP.I03ID, #TEMP.I04ID, #TEMP.I05ID, #TEMP.I01Name, #TEMP.I02Name, #TEMP.I03Name,
					#TEMP.I04Name, #TEMP.I05Name, #TEMP.Barcode, #TEMP.WareHouseID, #TEMP.WareHouseName, '''+@GroupID+''' as GroupID, 
					(SELECT TOP 1 AT1401.GroupName FROM AT1401 WITH(NOLOCK) WHERE AT1401.GroupID = '''+@GroupID+''' ) AS GroupName

			FROM #TEMP
			WHERE  #TEMP.BeginQuantity<>0 OR #TEMP.BeginAmount<>0 
					OR #TEMP.DebitQuantity<>0 OR #TEMP.DebitAmount<>0
					OR #TEMP.CreditQuantity<>0 OR #TEMP.CreditAmount<>0
			GROUP BY #TEMP.DivisionID, #TEMP.InventoryID, #TEMP.InventoryName, #TEMP.UnitID, #TEMP.UnitName, #TEMP.InventoryTypeID,
					#TEMP.Specification,#TEMP.Notes01, #TEMP.Notes02, #TEMP.Notes03, #TEMP.AccountID, #TEMP.AccountName,
					#TEMP.I01ID, #TEMP.I02ID, #TEMP.I03ID, #TEMP.I04ID, #TEMP.I05ID, #TEMP.I01Name, #TEMP.I02Name, #TEMP.I03Name,
					#TEMP.I04Name, #TEMP.I05Name, #TEMP.Barcode, #TEMP.WareHouseID, #TEMP.WareHouseName

			'
			--PRINT @sql
			--PRINT @sql1
			--PRINT @sql2
			--PRINT @sql2A
			--PRINT @sql3
			--PRINT @sql4
			--PRINT @sql5
			EXEC (@SQL+@SQL1+@SQL2+@SQL2A+@SQL3+@SQL4+@SQL5)

		END
	END
END




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
