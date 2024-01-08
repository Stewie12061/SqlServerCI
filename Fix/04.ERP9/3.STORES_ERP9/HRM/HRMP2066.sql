IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2066]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2066]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Đổ nguồn combo ngân sách năm/quý 
---- 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- Màn hình cập nhật ngân sách năm quý - HRMF2061
-- <History>
----Created by Hải Long on 08/09/2017
---- <Example>
---- Exec HRMP2066 @DivisionID='AS',@UserID='ASOFTADMIN',@TranMonth=7,@TranYear=2017,@IsBugetYear=0
---- 

CREATE PROCEDURE [dbo].[HRMP2066]
( 
  @DivisionID AS NVARCHAR(50),
  @UserID AS NVARCHAR(50),
  @TranMonth AS INT,
  @TranYear AS INT,
  @IsBugetYear AS TINYINT 
) 
AS 

IF @IsBugetYear = 1
BEGIN
	SELECT N'Năm ' + CONVERT(NVARCHAR(10), @TranYear) AS NAME, NULL AS TranQuarter, @TranYear AS TranYear
	UNION ALL
	SELECT N'Năm ' + CONVERT(NVARCHAR(10), @TranYear + 1) AS NAME, NULL AS TranQuarter, (@TranYear + 1) AS TranYear	
END
ELSE
BEGIN
	SELECT NAME, TranQuarter, TranYear
	FROM
	(
		SELECT N'Qúy 1/Năm ' + CONVERT(NVARCHAR(5), @TranYear) AS Name, 1 AS TranQuarter, @TranYear AS TranYear, @TranYear*100 + 1 AS FromPeriod, @TranYear*100 + 3 AS ToPeriod
		UNION ALL	
		SELECT N'Qúy 2/Năm ' + CONVERT(NVARCHAR(5), @TranYear) AS Name, 2 AS TranQuarter, @TranYear AS TranYear, @TranYear*100 + 4 AS FromPeriod, @TranYear*100 + 6 AS ToPeriod
		UNION ALL	
		SELECT N'Qúy 3/Năm ' + CONVERT(NVARCHAR(5), @TranYear) AS Name, 3 AS TranQuarter, @TranYear AS TranYear, @TranYear*100 + 7 AS FromPeriod, @TranYear*100 + 9 AS ToPeriod
		UNION ALL	
		SELECT N'Qúy 4/Năm ' + CONVERT(NVARCHAR(5), @TranYear) AS Name, 4 AS TranQuarter, @TranYear AS TranYear, @TranYear*100 + 10 AS FromPeriod, @TranYear*100 + 12 AS ToPeriod
		UNION
		SELECT N'Qúy 1/Năm ' + CONVERT(NVARCHAR(5), @TranYear + 1) AS Name, 1 AS TranQuarter, (@TranYear + 1) AS TranYear, (@TranYear + 1)*100 + 1 AS FromPeriod, (@TranYear + 1)*100 + 3 AS ToPeriod
		UNION ALL																			 							  
		SELECT N'Qúy 2/Năm ' + CONVERT(NVARCHAR(5), @TranYear + 1) AS Name, 2 AS TranQuarter, (@TranYear + 1) AS TranYear, (@TranYear + 1)*100 + 4 AS FromPeriod, (@TranYear + 1)*100 + 6 AS ToPeriod
		UNION ALL																			 							  
		SELECT N'Qúy 3/Năm ' + CONVERT(NVARCHAR(5), @TranYear + 1) AS Name, 3 AS TranQuarter, (@TranYear + 1) AS TranYear, (@TranYear + 1)*100 + 7 AS FromPeriod, (@TranYear + 1)*100 + 9 AS ToPeriod
		UNION ALL																			 							  
		SELECT N'Qúy 4/Năm ' + CONVERT(NVARCHAR(5), @TranYear + 1) AS Name, 4 AS TranQuarter, (@TranYear + 1) AS TranYear, (@TranYear + 1)*100 + 10 AS FromPeriod, (@TranYear + 1)*100 + 12 AS ToPeriod				
	) TB
	WHERE (@TranYear*100 + @TranMonth BETWEEN FromPeriod AND ToPeriod) OR (@TranYear*100 + @TranMonth < FromPeriod)
	ORDER BY FromPeriod
END	


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
