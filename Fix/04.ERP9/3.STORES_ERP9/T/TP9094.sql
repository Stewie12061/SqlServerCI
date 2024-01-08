IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[TP9094]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[TP9094]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----<Summary>
---- Load Form khi xem/ sửa - Master
---- 
----<Param>
---- 
----<Return>
---- 
----<Reference>
----
----<History>
----<Created by>: Như Hàn, Date: 30/10/2018
---- Modified by Học Huy on 09/12/2019: Sửa Số cấp duyệt và lỗi không hiển thị Người duyệt có DivisionID = '@@@'
---- Modify by ĐÌnh Hoà on 25/06/2020 : Convert APK
---- Modified by Lê Hoàng on 24/08/2021: Bổ sung trả thêm trường Loại ngân sách chi phí / doanh thu (BudgetKindID,BudgetKindName)
---- Modified by ... on ... :
----<Example>
/*
	EXEC TP9094 'BS', '359B3973-3E52-4C92-85CB-2B603A6D3F93'
	EXEC TP9094 @DivisionID, @APK
*/
CREATE PROCEDURE [dbo].[TP9094] 	
(
	@DivisionID VARCHAR(50),
	@APK VARCHAR(50),
	@APKMaster VARCHAR(50) = '',
	@Type VARCHAR(50) = ''
)
AS

DECLARE @sSQL NVARCHAR(MAX) = '',
		@sSQL1 NVARCHAR(MAX) = '',
		@Level INT,
		@sSQLSL NVARCHAR (MAX) = '',
		@sSQLJon NVARCHAR (MAX) = '',
		@Swhere  Nvarchar(max) = '',
		@OrderBy NVARCHAR(500),
		@i INT = 1, @s VARCHAR(2),
		@TotalRow VARCHAR(50)

-- Sửa Số cấp duyệt load theo Phiếu đã tạo
--SET @Level = ISNULL((SELECT MAX(LEVELS) FROM ST0010 WITH (NOLOCK) WHERE DivisionID=@DivisionID AND TypeID ='NS'), 0)
SET @Level = ISNULL(
	(
		SELECT MAX(ApproveLevel)
		FROM TT2101 T1 WITH (NOLOCK) INNER JOIN TT2100 T2 WITH (NOLOCK) ON T1.APKMaster = CONVERT(VARCHAR(50), T2.APK) AND CONVERT(VARCHAR(50), T2.APK) = @APK
	), 0)
	WHILE @i <= @Level
	BEGIN
		IF @i < 10 
			SET @s = '0' + CONVERT(VARCHAR, @i)
		ELSE 
			SET @s = CONVERT(VARCHAR, @i)
		SET @sSQLSL = @sSQLSL+' , ApprovePerson'+@s+'ID, ApprovePerson'+@s+'Name, ApprovePerson'+@s+'Status, ApprovePerson'+@s+'StatusName'
		SET @sSQLJon = @sSQLJon+ '
	LEFT JOIN 
		(
			SELECT ApprovePersonID ApprovePerson'+@s+'ID, OOT1.APKMaster, OOT1.DivisionID, OOT1.Status, 
				HT14.FullName AS ApprovePerson'+@s+'Name, OOT1.Status ApprovePerson'+@s+'Status, 
				O99.Description ApprovePerson'+@s+'StatusName, OOT1.Note ApprovePerson'+@s+'Note
			FROM OOT9001 OOT1 WITH (NOLOCK)
				INNER JOIN AT1103 HT14 WITH (NOLOCK) ON HT14.DivisionID IN (OOT1.DivisionID, ''@@@'') AND HT14.EmployeeID = OOT1.ApprovePersonID
				LEFT JOIN OOT0099 O99 WITH (NOLOCK) ON O99.ID1 = ISNULL(OOT1.Status, 0) AND O99.CodeMaster = ''Status''
			WHERE OOT1.Level = '+STR(@i)+'
		) APP'+@s+' ON APP'+@s+'.DivisionID = OOT90.DivisionID AND APP'+@s+'.APKMaster = CONVERT(VARCHAR(50), OOT90.APK)'
		SET @i = @i + 1		
	END	

IF ISNULL(@Type, '') = 'NS' 
	SET @Swhere = @Swhere + 'AND CONVERT(VARCHAR(50), T21.APKMaster_9000)= '''+@APKMaster+''''
ELSE 
	SET @Swhere = @Swhere + 'AND CONVERT(VARCHAR(50), T21.APK) = '''+@APK+''''

SET @sSQL = @sSQL+'
SELECT TOP 1 T21.APK, T21.APKMaster_9000, T21.DivisionID, T21.TranMonth, T21.TranYear, T21.VoucherTypeID, T21.VoucherNo, 
	FORMAT(T21.VoucherDate, ''dd/MM/yyyy'') VoucherDate, 
	T21.BudgetType, T99.Description As BudgetTypeName,
	T21.MonthBP AS Month, T21.YearBP AS Year, T21.MonthBP+''/''+T21.YearBP As MonthYear,
	T21.Description, T21.CurrencyID, T04.CurrencyName,
	T21.ExchangeRate, 
	T21.DepartmentID, T11.AnaName As DepartmentName,
	T21.Status, T09.Description As StatusName,
	T21.BudgetKindID, T10.Description As BudgetKindName,
	T21.ApprovalDate, T21.CreateDate, T21.CreateUserID, T21.LastModifyDate, T21.LastModifyUserID, T21.DeleteFlag, T211.ApproveLevel
	'+@sSQLSL+''
SET @sSQL = @sSQL+'
FROM TT2100 T21 WITH (NOLOCK)
	LEFT JOIN (SELECT DISTINCT APKMaster, ApproveLevel FROM TT2101 T21 WITH (NOLOCK)) T211 ON T211.APKMaster = T21.APK
	LEFT JOIN OOT9000 OOT90 WITH (NOLOCK) ON T21.APKMaster_9000 = OOT90.APK
	LEFT JOIN AT0099 T99 WITH (NOLOCK) ON T21.BudgetType = T99.ID AND T99.CodeMaster = ''BudgetType''
	LEFT JOIN AT0099 T09 WITH (NOLOCK) ON T21.Status = T09.ID AND T09.CodeMaster = ''Status''
	LEFT JOIN AT1011 T11 WITH (NOLOCK) ON T21.DepartmentID = T11.AnaID AND T11.AnaTypeID = ''A03''
	LEFT JOIN AT1004 T04 WITH (NOLOCK) ON T21.CurrencyID = T04.CurrencyID
	LEFT JOIN AT0099 T10 WITH (NOLOCK) ON T21.BudgetKindID = T10.ID AND T10.CodeMaster = ''BudgetKind'' AND T10.Disabled = 0
	'+@sSQLJon
SET @sSQL = @sSQL+' 
WHERE T21.DeleteFlag = 0 AND T21.DivisionID = '''+@DivisionID+''' '+@Swhere+''

EXEC (@sSQL)
--PRINT @sSQL

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
