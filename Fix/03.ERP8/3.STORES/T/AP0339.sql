IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0339]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0339]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






---- Created by Tieu Mai on 05/05/2016
---- Purpose: In báo cáo doanh số bán hàng theo MPT nghiệp vụ (CustomizeIndex = 52 - KOYO)
---- Modified by Hải Long on 18/05/2017: Chỉnh sửa danh mục dùng chung
---- Modified by Tiểu Mai on 14/06/2017: Lấy bổ sung Số lượng, doanh thu hàng bán trả lại
---- Modified by Tiểu Mai on 23/06/2017: Lấy bổ sung ngày in báo cáo
---- Modified by Kim Thư on 14/1/2019: Bổ sung O03ID, O04ID, O05ID
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
/*
	exec AP0339 'KVC', '05/05/2016', 'AR0331', 'ANHPHU', 'VANTAM', 'KVC001', 'NNN06', '1311', '171', 'VND'
 */


CREATE PROCEDURE [dbo].[AP0339] 	
					@DivisionID as nvarchar(50),
					@ReportDate as Datetime,
					@ReportID AS NVARCHAR(10),
					@FromObjectID AS NVARCHAR(50) = '',
					@ToObjectID AS NVARCHAR(50)= '',
					@FromEmployeeID AS NVARCHAR(50),
					@ToEmployeeID AS NVARCHAR(50),
					@FromAccountID as nvarchar(50),
					@ToAccountID as nvarchar(50),
					@CurrencyID as nvarchar(50)
					
 AS
Declare @sSQL AS nvarchar(MAX) = '',
		@Month AS int,
		@Year AS int

SET @Month = month(@ReportDate)
SET @Year = year(@ReportDate)

IF @ReportID = 'AR0326'
BEGIN
--------------------------------------- Lấy thông tin công nợ khách hàng-----------------------------------------
	Exec AP03391	@DivisionID, @ReportDate, @FromAccountID, @ToAccountID,@FromObjectID, @ToObjectID, @CurrencyID

--------------------------------------- Lấy số lượng hàng bán theo nhóm hàng-------------------------------
	Exec AP03392	@DivisionID, @ReportDate, @FromAccountID, @ToAccountID,@FromObjectID, @ToObjectID, @CurrencyID

	SET @sSQL = '
		SELECT '''+CONVERT(NVARCHAR(50),@ReportDate,103)+''' as ReportDate, AV03391.*, AV03392.Period, AV03392.Ana02ID, AV03392.AnaName, TranMonth, TranYear, AV03392.Quantity, AV03392.QuantityTL, AV03392.ConvertedAmountTL,
		AT1202.ObjectName, TradeName, A01.AnaName as AnaName05, AT1202.O03ID, AT1202.O04ID, AT1202.O05ID
		FROM AV03391
		LEFT JOIN AV03392 ON AV03391.DivisionID = AV03392.DivisionID AND AV03391.ObjectID = AV03392.ObjectID AND Isnull(AV03391.Ana05ID,'''') = Isnull(AV03392.Ana05ID,'''')
		LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = AV03391.ObjectID
		LEFT JOIN AT1011 A01 WITH (NOLOCK) ON AV03391.Ana05ID = A01.AnaID AND A01.AnaTypeID = ''A05''
	'

	--PRINT @sSQL
	EXEC (@sSQL)

	DROP VIEW AV033911
	DROP VIEW AV033912
	DROP VIEW AV033913
	DROP VIEW AV033914
	DROP VIEW AV033915
	DROP VIEW AV033916
	DROP VIEW AV033917
	DROP VIEW AV033918
	DROP VIEW AV033919
	DROP VIEW AV03391
	DROP VIEW AV03392

END





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
