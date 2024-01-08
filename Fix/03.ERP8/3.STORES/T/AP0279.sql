IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0279]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0279]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Form AF0280 Danh muc phieu chênh lệch
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 06/06/2014 by Lê Thi Thu Hiền
---- 
---- Modified on 06/06/2014 by 
---- Modified on 12/05/2017 by Tiểu Mai: Bổ sung with (nolock) và chỉnh sửa danh mục dùng chung
-- <Example>
---- 
CREATE PROCEDURE AP0279
( 
	@DivisionID AS NVARCHAR(50),
	@TranMonth AS INT,
	@TranYear AS INT,
	@FromDate AS DATETIME,
	@ToDate AS DATETIME,
	@AnaID AS NVARCHAR(50)

) 
AS 

DECLARE @CustomerName INT
--Tao bang tam de kiem tra day co phai la khach hang 2T khong (CustomerName = 15)
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

IF @CustomerName = 32 --- Customize PHUC LONG
BEGIN
	SELECT A.* , A1.AnaName
	FROM AT0280 A WITH (NOLOCK)
	LEFT JOIN AT1015 A1 WITH (NOLOCK) ON A1.AnaID = A.AnaID 
	WHERE A.DivisionID = @DivisionID
	AND TranMonth = @TranMonth
	AND TranYear = @TranYear
	AND A.VoucherDate BETWEEN Convert(nvarchar(10),@FromDate,21) AND convert(nvarchar(10), @ToDate,21)
	AND A.AnaID LIKE @AnaID
END
ELSE
BEGIN
	SELECT A.* , A1.AnaName
	FROM AT0280 A WITH (NOLOCK)
	LEFT JOIN AT1015 A1 WITH (NOLOCK) ON A1.AnaID = A.AnaID 
	AND A1.AnaTypeID = (SELECT TOP 1 ShopTypeID 
					 FROM POST0001  WITH (NOLOCK)
					 WHERE POST0001.DivisionID = @DivisionID)
	WHERE A.DivisionID = @DivisionID
	AND TranMonth = @TranMonth
	AND TranYear = @TranYear
	AND A.VoucherDate BETWEEN Convert(nvarchar(10),@FromDate,21) AND convert(nvarchar(10), @ToDate,21)
	AND A.AnaID LIKE @AnaID
END
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
