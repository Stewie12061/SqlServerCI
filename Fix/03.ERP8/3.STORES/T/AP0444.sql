IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0444]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0444]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Báo cáo tổng hợp doanh thu theo từng công ty
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
--- Created on 18/12/2023 by Trọng Phúc
-- </History>



CREATE PROCEDURE AP0444
( 
	@DivisionID VARCHAR(MAX),
	@TranYearFrom INT,
	@TranYearTo INT,
	@Ana07ID VARCHAR(MAX),
	@Ana09ID VARCHAR(MAX)
)
AS

BEGIN

	SELECT s.Value as Ana07ID, ISNULL(AT1011.AnaName,'') as Ana07Name  --- nhân viên
	into #temp
	FROM STRINGSPLIT(@Ana07ID, ''',''') s LEFT JOIN AT1011 ON AT1011.AnaID = s.Value  and AT1011.AnaTypeID = 'A07'
	order by [Value] asc
	delete from #temp where Ana07ID = ','

	SELECT s.Value as Ana09ID, ISNULL(AT1011.AnaName,'') as Ana09Name  --- đối tượng
	into #temp2
	FROM STRINGSPLIT(@Ana09ID, ',') s LEFT JOIN AT1011 ON AT1011.AnaID = s.Value  and AT1011.AnaTypeID = 'A09'
	order by [Value] asc
	SELECT * FROM #temp2
	
	SELECT ISNULL(tmp.Ana07ID,'') as Ana07ID, ISNULL(tmp.Ana07Name,'') as Ana07Name
		, SUM(ISNULL(A092.ConvertedAmount,0)) as CurrentConvertedAmount
		, SUM(ISNULL(A091.ConvertedAmount,0)) as LastYearConvertedAmount
		, ISNULL(A09.Ana09ID,'') as Ana09ID
		FROM #temp tmp
			LEFT JOIN AT9000 A09 ON A09.Ana07ID = tmp.Ana07ID AND A09.Ana09ID <> ''

			LEFT JOIN AT9000 A091 ON A091.Ana07ID = tmp.Ana07ID AND A091.TranYear = @TranYearFrom
			AND A091.Ana09ID <> ''

			LEFT JOIN AT9000 A092 ON A092.Ana07ID = tmp.Ana07ID AND A092.TranYear = @TranYearTo
			AND A092.Ana09ID <> ''

		WHERE tmp.Ana07ID <> '' 
		GROUP BY tmp.Ana07ID, tmp.Ana07Name, A09.Ana09ID
		ORDER BY tmp.Ana07ID, tmp.Ana07Name, A09.Ana09ID desc

		DROP TABLE #temp
		DROP TABLE #temp2
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

