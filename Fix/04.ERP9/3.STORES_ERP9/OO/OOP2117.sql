IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2117]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2117]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






















-- <Summary>
---- Kiểm tra Công việc có liên quan đến Phiếu nghiệp vụ cần xét duyệt nào hay không
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
-- Create on 28/03/2020 by Vĩnh Tâm
-- <Example> EXEC OOP2117 @DivisionID='DTI', @TaskID = 'CV/03/2020/0020'

CREATE PROCEDURE [dbo].[OOP2117]
(
	@DivisionID VARCHAR(50),
	@TaskID VARCHAR(50) = NULL
)
AS
BEGIN 
	DECLARE @sSQL NVARCHAR(MAX),
			@TableID VARCHAR(50),
			@KeyID VARCHAR(50)

	CREATE TABLE #BusinessData (BusinessID VARCHAR(50))

	-- Tạo bảng tạm lưu dữ liệu các module hiện tại của hệ thống
	CREATE TABLE #BusinessApprove (TableID VARCHAR(50), KeyID VARCHAR(50))
	INSERT INTO #BusinessApprove (TableID, KeyID)
	VALUES
	-- Cơ hội
	('CRMT20501', 'OpportunityID'),
	-- Yêu cầu mua hàng
	('OT3101', 'VoucherNo'),
	-- Đơn hàng bán
	('OT2001', 'VoucherNo'),
	-- Phiếu báo giá KHCU, NC, SALE
	('OT2101', 'QuotationNo')

	WHILE NOT EXISTS(SELECT TOP 1 1 FROM #BusinessData)
		AND EXISTS(SELECT TOP 1 1 FROM #BusinessApprove ORDER BY TableID)
	BEGIN
		SELECT @TableID = TableID, @KeyID = KeyID
		FROM #BusinessApprove

		SET @sSQL = 'SELECT ' + @KeyID + ' FROM ' + @TableID + ' WITH (NOLOCK) WHERE TaskID = ''' + @TaskID + ''''

		INSERT INTO #BusinessData(BusinessID)
		EXEC SP_EXECUTESQL @sSQL

		DELETE #BusinessApprove WHERE TableID = @TableID
	END

	SELECT * FROM #BusinessData
END






















GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
