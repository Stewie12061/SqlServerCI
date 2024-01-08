IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP30171]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP30171]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- IN báo cáo tình hình giao hàng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create ON 28/08/2020 by Kiều Nga
-- <Example> EXEC SOP30171 'MT','OR6001'

CREATE PROCEDURE [dbo].[SOP30171] (
				@DivisionID			NVARCHAR(50),	--Biến môi trường
                @ReportID			NVARCHAR(50))
AS
BEGIN
	DECLARE @sSQL NVARCHAR(max)='',
			@query AS NVARCHAR(MAX)='',
			@cols  AS NVARCHAR(MAX)='',
			@cols1  AS NVARCHAR(MAX)=''

	IF @ReportID = 'OR6001' -- Tình hình giao hàng (mẫu 1)
	BEGIN
		SELECT @cols = @cols + QUOTENAME(Dates) + ',' FROM (SELECT DISTINCT  CONVERT(CHAR(10), OV2107.Dates, 103) +'_KH' as Dates
																		From OV2107, OV2106
																		Where OV2107.Dates = OV2106.Dates
																		AND OV2107.DivisionID in (@DivisionID,'@@@')
																) as tmp
		SELECT @cols = substring(@cols, 0, len(@cols))

		SELECT @cols1 = @cols1 + QUOTENAME(Dates) + ',' FROM (SELECT DISTINCT  CONVERT(CHAR(10), OV2107.Dates, 103) +'_TT' as Dates
																		From OV2107, OV2106
																		Where OV2107.Dates = OV2106.Dates
																		AND OV2107.DivisionID in (@DivisionID,'@@@')
																) as tmp
		SELECT @cols1 = substring(@cols1, 0, len(@cols1))

		IF @cols = '' OR @cols1 = ''
			RETURN

		SET @sSQL = 
				' SELECT * from 
					(
						SELECT DISTINCT
							OV2107.VoucherNo,OV2107.VoucherDate,OV2107.InventoryID,OV2107.InventoryName,OV2107.UnitName,OV2107.OrderQuantity,OV2107.ActualQuantity
							,Case when OV2107.Types = 1 then CONVERT(CHAR(10), OV2107.Dates, 103) + ''_KH'' 
							                     else CONVERT(CHAR(10), OV2107.Dates, 103) + ''_TT'' end as Dates1
							,Case when OV2107.Types = 1 or Types = 2 then ISNULL(OV2107.Quantity,0) else 0 end as Quantity1
							From OV2107, OV2106
							Where OV2107.Dates = OV2106.Dates 
							AND OV2107.DivisionID in ('''+@DivisionID+''',''@@@'')
					) src
				pivot 
				(
					Sum(Quantity1)
					for Dates1 in ('+@cols+','+@cols1+')
				) piv1'

	    --- Load caption
		select * from (SELECT DISTINCT  CONVERT(CHAR(10), OV2107.Dates, 103) +'_KH' as ID, CONVERT(CHAR(10), OV2107.Dates, 103) as Dates,N'Kế hoạch' as [Name]
								From OV2107, OV2106
								Where OV2107.Dates = OV2106.Dates
								AND OV2107.DivisionID in (@DivisionID,'@@@')
						UNION ALL
						SELECT DISTINCT  CONVERT(CHAR(10), OV2107.Dates, 103) +'_TT' as ID , CONVERT(CHAR(10), OV2107.Dates, 103) as Dates,N'Thực tế' as [Name]
										From OV2107, OV2106
										Where OV2107.Dates = OV2106.Dates
										AND OV2107.DivisionID in (@DivisionID,'@@@')
						) as p
						order by Dates

		print @sSQL
		EXEC (@sSQL)
	END
	IF @ReportID = 'OR6003' -- Tình hình giao hàng (mẫu 2)
	BEGIN
		SELECT @cols = @cols + QUOTENAME(Dates) + ',' FROM (SELECT DISTINCT  CONVERT(CHAR(10), OV2107.Dates, 103) as Dates
																		From OV2107, OV2106
																		Where OV2107.Dates = OV2106.Dates
																		AND OV2107.DivisionID in (@DivisionID,'@@@')
																) as tmp
		SELECT @cols = substring(@cols, 0, len(@cols))

		IF @cols = '' RETURN

		SET @sSQL = 
				' SELECT * from 
					(
						SELECT
							OV2107.VoucherNo,OV2107.VoucherDate,OV2107.InventoryID,OV2107.InventoryName,OV2107.UnitName,OV2107.OrderQuantity
							,CONVERT(CHAR(10), OV2107.Dates, 103) as Dates1
							,Case when OV2107.Types = 2 and OV2107.Quantity > 0 then ISNULL(OV2107.Quantity,0) else ISNULL(OV2107.ActualQuantity,0) end as TQuantity
							From OV2107, OV2106
							Where OV2107.Dates = OV2106.Dates and OV2107.Types = 2
							AND OV2107.DivisionID in ('''+@DivisionID+''',''@@@'')
					) src
				pivot 
				(
					SUM(TQuantity)
					for Dates1 in ('+@cols+')
				) piv1
				'

		--- Load caption
		select * from (SELECT DISTINCT CONVERT(CHAR(10), OV2107.Dates, 103) as Dates
								From OV2107, OV2106
								Where OV2107.Dates = OV2106.Dates
								AND OV2107.DivisionID in (@DivisionID,'@@@')
						) as p
						order by Dates

		print @sSQL
		Exec (@sSQL)
	END
	IF @ReportID = 'OR6005' -- Chi tiết tình hình giao hàng (mẫu 3)
	BEGIN
		SELECT @cols = @cols + QUOTENAME(Dates) + ',' FROM (SELECT DISTINCT  CONVERT(CHAR(10), OV2107.Dates, 103) as Dates
																		From OV2107, OV2106
																		Where OV2107.Dates = OV2106.Dates
																		AND OV2107.DivisionID in (@DivisionID,'@@@')
																) as tmp
		SELECT @cols = substring(@cols, 0, len(@cols))

		IF @cols = '' RETURN

		SET @sSQL = 
				' SELECT * from 
					(
						SELECT
							OV2107.VoucherNo,OV2107.VoucherDate,OV2107.DueDate,OV2107.ObjectName,OV2107.T01OriginalAmount,OV2107.InventoryID,OV2107.InventoryName
							,OV2107.UnitName,OV2107.OrderQuantity,OV2107.OrderConvertedAmount,OV2107.ActualQuantity,OV2107.ActualConvertedAmount
							,Case when OV2107.ActualQuantity is null then OV2107.OrderQuantity else OV2107.OrderQuantity - OV2107.ActualQuantity end as RemainQty
							,Case when OV2107.ActualConvertedAmount is null then OV2107.OrderConvertedAmount else OV2107.OrderConvertedAmount - OV2107.ActualConvertedAmount end as RemainAmount
							,CONVERT(CHAR(10), OV2107.Dates, 103) as Dates1
							,Case when OV2107.Types = 2 and OV2107.Quantity > 0 then ISNULL(OV2107.Quantity,0) else ISNULL(OV2107.ActualQuantity,0) end as TQuantity
							From OV2107, OV2106
							Where OV2107.Dates = OV2106.Dates and OV2107.Types = 2
							AND OV2107.DivisionID in ('''+@DivisionID+''',''@@@'')
					) src
				pivot 
				(
					SUM(TQuantity)
					for Dates1 in ('+@cols+')
				) piv1
				'

		--- Load caption
		select * from (SELECT DISTINCT CONVERT(CHAR(10), OV2107.Dates, 103) as Dates
								From OV2107, OV2106
								Where OV2107.Dates = OV2106.Dates
								AND OV2107.DivisionID in (@DivisionID,'@@@')
						) as p
						order by Dates

		print @sSQL
		Exec (@sSQL)
	END

END
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO


