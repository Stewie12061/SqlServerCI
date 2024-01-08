IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP0124_1]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP0124_1]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- Tính chỉ tiêu sản lượng cho DNP
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Thanh Sơn on:13/07/2015
---- Modified on 03/12/2019 by Văn Minh: Bổ sung thêm 2 chuẩn mới
-- <Example>
/*
	MP0124_1 'DNP', '', '', 'CNC', 23.70
*/
CREATE PROCEDURE MP0124_1
(
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@TeamID VARCHAR(50),
	@HourAvg DECIMAL(28,8)
)
AS
---- lấy dữ liệu từ thiết lập
DECLARE @Coe1 DECIMAL(28,8) = 0,
		@Coe2 DECIMAL(28,8) = 0,
		@Coe3 DECIMAL(28,8) = 0,
		@Coe4 DECIMAL(28,8) = 0,
		@Coe5 DECIMAL(28,8) = 0,

		@Qty1 DECIMAL(28,8) = 0,
		@Qty2 DECIMAL(28,8) = 0,
		@Qty3 DECIMAL(28,8) = 0,
		@Qty4 DECIMAL(28,8) = 0,
		@Qty5 DECIMAL(28,8) = 0,

		@TCGCCoefficient DECIMAL(28,8) = 0,
		@HourCriteria DECIMAL(28,8) = 0,
		@QtyCriteria1h DECIMAL(28,8) = 0,
		@QtyCriteria8h DECIMAL(28,8) = 0,
		@QtyCriteria12h DECIMAL(28,8) = 0,
		@Notes NVARCHAR(250)
		
IF EXISTS (SELECT TOP 1 1 FROM HT1101 WHERE DivisionID = @DivisionID AND TeamID = @TeamID AND Notes IS NOT NULL AND Notes01 IS NOT NULL)
SELECT TOP 1	@Coe1 = CONVERT(DECIMAL(28,8), LEFT(REPLACE(Notes01,' ',''), 4)),
				@Coe2 = CONVERT(DECIMAL(28,8), SUBSTRING(REPLACE(Notes01,' ',''), 5,4)),
				@Coe3 = CONVERT(DECIMAL(28,8), SUBSTRING(REPLACE(Notes01,' ',''), 9,4)),
				@Coe4 = CONVERT(DECIMAL(28,8), SUBSTRING(REPLACE(Notes01,' ',''), 13,4)),
				@Coe5 = CONVERT(DECIMAL(28,8), SUBSTRING(REPLACE(Notes01,' ',''),17, 4)),
				
				@Qty1 = CONVERT(DECIMAL(28,8), CASE WHEN CHARINDEX(' ',LEFT(Notes,3)) > 0   THEN LEFT(REPLACE(Notes,' ',''), 2) ELSE LEFT(REPLACE(Notes,' ',''), 3) END),
				@Qty2 = CONVERT(DECIMAL(28,8), CASE WHEN CHARINDEX(' ',SUBSTRING(Notes, 3,3)) > 0  THEN SUBSTRING(REPLACE(Notes,' ',''), 3,2) ELSE SUBSTRING(REPLACE(Notes,' ',''), 3,3) END),
				@Qty3 = CONVERT(DECIMAL(28,8), CASE WHEN CHARINDEX(' ',SUBSTRING(Notes, 5,3)) > 0  THEN SUBSTRING(REPLACE(Notes,' ',''), 5,2) ELSE SUBSTRING(REPLACE(Notes,' ',''), 6,3) END),
				@Qty4 = CONVERT(DECIMAL(28,8), CASE WHEN CHARINDEX(' ',SUBSTRING(Notes, 7,3)) > 0  THEN SUBSTRING(REPLACE(Notes,' ',''), 7,2) ELSE SUBSTRING(REPLACE(Notes,' ',''), 9,3) END),
				@Qty5 = CONVERT(DECIMAL(28,8), CASE WHEN CHARINDEX(' ',RIGHT(Notes,3)) > 0  THEN RIGHT(REPLACE(Notes,' ',''),2) ELSE RIGHT(REPLACE(Notes,' ',''),3) END)
FROM HT1101
WHERE DivisionID = @DivisionID
AND TeamID = @TeamID

SET @TCGCCoefficient = CASE WHEN @HourAvg > @Qty1 AND @HourAvg <= @Qty2 THEN @Coe1 
							WHEN @HourAvg > @Qty2 AND @HourAvg <= @Qty3 THEN @Coe2
							WHEN @HourAvg > @Qty3 AND @HourAvg <= @Qty4 THEN @Coe3
							WHEN @HourAvg > @Qty4 AND @HourAvg <= @Qty5 THEN @Coe4
							WHEN @HourAvg > @Qty5 THEN @Coe5 ELSE 0 END
SET @HourCriteria = ISNULL(@TCGCCoefficient, 0) * ISNULL(@HourAvg,0)
SET @QtyCriteria1h = CASE WHEN @HourCriteria = 0 THEN 0 ELSE 3600 / @HourCriteria END
SET @QtyCriteria8h = CASE WHEN @HourCriteria = 0 THEN 0 ELSE 26700 / @HourCriteria END
SET @QtyCriteria12h = CASE WHEN @HourCriteria = 0 THEN 0 ELSE 38400 / @HourCriteria END
			
SELECT @TCGCCoefficient TCGCCoefficient, @HourCriteria HourCriteria, @QtyCriteria1h QtyCriteria1h,
	@QtyCriteria8h QtyCriteria8h, @QtyCriteria12h QtyCriteria12h


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
