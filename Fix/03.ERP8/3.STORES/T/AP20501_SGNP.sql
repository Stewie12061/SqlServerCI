IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP20501_SGNP]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP20501_SGNP]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- Lấy chi phí khả dụng còn lại so với định mức dự án (Cảnh báo chi vực định mức dự án)
-- <Param>
----DivisionID : Đơn vị
----ProjectID : Mã dự án
-- <Return>
----
-- <Reference>
----	
-- <History>
----Created by:Bảo Toàn Date 15/08/2019
----Modified by Lê Hoàng on 19/08/2021 : bổ sung điều kiện mã phân tích số 2 - custom SaiGonNamPhat
-- <Example>
--- AP20501_SGNP 'DTI', 'CH002','QH','CPHQ','TNK',''
CREATE PROC AP20501_SGNP
	@Division varchar(50),
	@ProjectID varchar(50),
	@AnaDepartmentID varchar(50),
	@Ana03ID varchar(50),
	@Ana04ID varchar(50),
	@VoucherNo varchar(50)
AS
BEGIN
	DECLARE @sSQL NVARCHAR(MAX) = '',
			@sWHERE NVARCHAR(MAX) = '',
			@sWHERE01 NVARCHAR(MAX) = ' 1 = 1 ',
			@pCostAnaTypeID NVARCHAR(10) = '',
			@pCostDetailAnaTypeID NVARCHAR(10) = '',
			@pDepartmentAnaTypeID NVARCHAR(10) = ''

	SET @sWHERE = ' R01.DivisionID = '''+@Division+''''
	IF ISNULL(@ProjectID,'') <> ''
	BEGIN
		SET @sWHERE = @sWHERE + ' AND R01.ProjectID = '''+@ProjectID+''''
	END
	IF ISNULL(@AnaDepartmentID,'') <> ''
	BEGIN
		SET @sWHERE = @sWHERE + ' AND M.AnaDepartmentID = '''+@AnaDepartmentID+''''
	END
	IF ISNULL(@Ana03ID,'') <> ''
	BEGIN
		SET @sWHERE = @sWHERE + ' AND M.CostGroup = '''+@Ana03ID+''''
	END
	IF ISNULL(@Ana04ID,'') <> ''
	BEGIN
		SET @sWHERE = @sWHERE + ' AND M.CostGroupDetail = '''+@Ana04ID+''''
	END

	SELECT 
		@pCostAnaTypeID = CASE WHEN ISNULL(CostAnaTypeID,'') = '' THEN '' ELSE REPLACE(CostAnaTypeID,'A','Ana') + 'ID,' END, 
		@pCostDetailAnaTypeID = CASE WHEN ISNULL(CostDetailAnaTypeID,'') = '' THEN '' ELSE REPLACE(CostDetailAnaTypeID,'A','Ana') + 'ID,' END, 
		@pDepartmentAnaTypeID = CASE WHEN ISNULL(DepartmentAnaTypeID,'') = '' THEN '' ELSE REPLACE(DepartmentAnaTypeID,'A','Ana') + 'ID,' END 
	FROM AT0000 WITH(NOLOCK) WHERE DefDivisionID = @Division

	IF @pCostAnaTypeID <> ''
	BEGIN
		SET @sWHERE01 = @sWHERE01 + ' AND M.CostGroup = R02.'+REPLACE(@pCostAnaTypeID,',','')
	END
	IF @pCostDetailAnaTypeID <> ''
	BEGIN
		SET @sWHERE01 = @sWHERE01 + ' AND M.CostGroupDetail = R02.'+REPLACE(@pCostDetailAnaTypeID,',','')
	END
	IF @pDepartmentAnaTypeID <> ''
	BEGIN
		SET @sWHERE01 = @sWHERE01 + ' AND M.AnaDepartmentID = R02.'+REPLACE(@pDepartmentAnaTypeID,',','')
	END

	SET @sSQL = '
	SELECT R01.DivisionID ,R01.ProjectID, ISNULL(M.[ActualMoney],0) - ISNULL(R02.OriginalAmount,0) AS RemainingCost
		FROM OOT2141 M WITH(NOLOCK) 
			INNER JOIN OOT2140 R01 WITH(NOLOCK) ON M.APKMaster = R01.APK
			LEFT JOIN (
				SELECT '+@pCostAnaTypeID+'
					   '+@pCostDetailAnaTypeID+'
					   '+@pDepartmentAnaTypeID+' SUM(OriginalAmount) AS OriginalAmount
				FROM AT9000 WITH(NOLOCK) 
				WHERE Ana01ID = '''+@ProjectID+''' AND DivisionID = '''+@Division+'''
					AND VoucherNo <> '''+@VoucherNo+''' OR '''+@VoucherNo+''' = ''''
				GROUP BY '+REVERSE(STUFF(REVERSE(@pCostAnaTypeID+@pCostDetailAnaTypeID+@pDepartmentAnaTypeID), 1, 1, ''))+'
				) R02 ON '+@sWHERE01+'
		WHERE ' + @sWHERE

EXEC (@sSQL)
PRINT (@sSQL)

END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
