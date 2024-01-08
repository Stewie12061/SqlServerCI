IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[QCP2051]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[QCP2051]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load Grid danh sách phiếu nguyên vật liệu
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: TanTai , Date: 11/11/2020
-- <Example>

/*
--Lọc nâng cao
EXEC	@return_value = [dbo].[QCP2051]	@DivisionID = N'VNP', @UserID = N'ASOFTADMIN',@DivisionList = N' ',	@VoucherTypeID = N' ',@VoucherNo = N' ',@VoucherDate = N' ',@TranMonth = N'11',@TranYear = N'2020',	@ShiftID = N' ',@ShiftName = N' ',@MachineID = N' ',@MachineName = N' ',@Notes = N' ',@PageNumber = 0,@PageSize = 25,@SearchWhere = N' '

*/

CREATE PROCEDURE [dbo].[QCP2051] ( 
        @DivisionID VARCHAR(50),
		@UserID VARCHAR(50),
		@StrVoucherNo VARCHAR(MAX)
) 
AS 
BEGIN
	DECLARE @sSQL NVARCHAR(MAX),
			@sWhere VARCHAR(MAX) = N'',
			@OrderBy NVARCHAR(500) = N'', 
			@TotalRow NVARCHAR(50) = N''

		Set @sWhere = @sWhere + ' and QCT2000.VoucherNo IN (''' + replace(@StrVoucherNo, ',',''',''') + ''')'

		SET @sSQL = N'
				SELECT QCT2000.APK as APKShift, QCT2000.VoucherNo as ShiftVoucherNo, QCT2000.VoucherDate as ShiftVoucherDate, CIT1150.MachineID, CIT1150.MachineName, CIT1150.MachineNameE, HT1020.ShiftID, HT1020.ShiftName, QCT2001.APK AS APKInventory, QCT2001.APKMaster, QCT2001.BatchNo, QCT2001.InventoryID, QCT2001.SourceNo, AT1302.InventoryName  
				FROM QCT2001 QCT2001 WITH(NOLOCK)
				LEFT JOIN AT1302 AT1302 WITH(NOLOCK) ON QCT2001.InventoryID = AT1302.InventoryID  
				LEFT JOIN QCT2000 QCT2000 WITH(NOLOCK) ON QCT2000.APK = QCT2001.APKMaster  
				LEFT JOIN CIT1150 CIT1150 WITH(NOLOCK) ON CIT1150.MachineID = QCT2000.MachineID  
				LEFT JOIN HT1020 HT1020 WITH(NOLOCK) ON HT1020.ShiftID = QCT2000.ShiftID 
				WHERE QCT2001.DivisionID IN ('''+@DivisionID+''',''@@@'') AND ISNULL(QCT2001.DeleteFlg,0) = 0 AND ISNULL(QCT2000.DeleteFlg,0) = 0 '
				+ @sWhere
		
		EXEC (@sSQL)
		PRINT (@sSQL)
END
