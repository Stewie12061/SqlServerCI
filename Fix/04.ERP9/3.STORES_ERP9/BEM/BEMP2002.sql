IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[BEMP2002]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[BEMP2002]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-- <Summary>
---- Load dữ liệu cho màn hình Xem chi tiết Phiếu DNTT/DNTTTU/DNTU - BEMF2002
-- <Param>
-- <Return>
-- <Reference>
-- <History>
---- Create by Vĩnh Tâm on 15/06/2020
---- Updated by Đình Ly on 29/03/2021 - Load dữ liệu cột Phân loại nguồn hình thành (FormationID).
-- <Example> EXEC BEMP2002 @DivisionID = 'DTI', @APK = 'b69c8d96-2fdc-4c0a-d977-4887126e2641'

CREATE PROCEDURE [dbo].[BEMP2002]
(
	@DivisionID VARCHAR(50),
	@APK VARCHAR(50)
)
AS
BEGIN
	DECLARE @sSQL NVARCHAR (MAX) = N'',
			@sWhere NVARCHAR(MAX),
			@Level INT = 0,
			@sSQLSelect NVARCHAR (MAX) = '',
			@sSQLJoin NVARCHAR (MAX) = '',
			@i INT = 1, @s VARCHAR(2)
	
	-- Lấy cấp độ duyệt của phiếu hiện tại
	SELECT @Level = MAX(Levels) FROM BEMT2000 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND @APK IN (CONVERT(VARCHAR(50), APK), CONVERT(VARCHAR(50), APKMaster_9000))

	WHILE @i <= @Level
	BEGIN
		IF @i < 10 SET @s = '0' + CONVERT(VARCHAR, @i)
		ELSE SET @s = CONVERT(VARCHAR, @i)
		SET @sSQLSelect = @sSQLSelect + ' , APK9001' + @s + ', ApprovePerson' + @s + 'Name, ApprovePerson' + @s + 'Status, ApprovePerson' + @s + 'Note'
		SET @sSQLJoin = @sSQLJoin + '
						LEFT JOIN (SELECT OOT1.APK APK9001' + @s + ', OOT1.APKMaster, OOT1.DivisionID,
								A1.FullName AS ApprovePerson' + @s + 'Name,
								OOT1.Status AS Status' + @s + ',
								O99.Description AS ApprovePerson' + @s + 'Status,
								OOT1.Note AS ApprovePerson' + @s + 'Note
							FROM OOT9001 OOT1 WITH (NOLOCK)
								LEFT JOIN OOT0099 O99 WITH (NOLOCK) ON O99.ID1 = ISNULL(OOT1.Status,0) AND O99.CodeMaster = ''Status''
								INNER JOIN AT1103 A1 WITH (NOLOCK) ON A1.DivisionID = OOT1.DivisionID AND A1.EmployeeID = OOT1.ApprovePersonID
							WHERE OOT1.Level = ' + STR(@i) + '
						) APP' + @s + ' ON APP' + @s + '.DivisionID = B1.DivisionID AND APP' + @s + '.APKMaster = B1.APKMaster_9000'
		SET @i = @i + 1	
	END

	SET @sSQL = @sSQL + N'
			SELECT B1.APK, B1.DivisionID, B1.APKMaster_9000, B1.Levels, B1.TranMonth, B1.TranYear, B1.VoucherNo, B1.VoucherDate, B1.TypeID
				--, ISNULL(B2.Description, B1.TypeID) AS TypeName
				, CASE
					WHEN B1.InheritType IS NULL THEN ISNULL(B2.Description, B1.TypeID)
					ELSE CONCAT(ISNULL(B2.Description, B1.TypeID), '' - '', B1.InheritType)
				END AS TypeName
				, ISNULL(A0.AnaName, B1.DepartmentID) AS DepartmentID, B1.PhoneNumber, B1.ApplicantID, A3.FullName AS ApplicantName, ISNULL(A5.PaymentName, B1.MethodPay) AS MethodPay
				, ISNULL(A6.PaymentTermName, B1.PaymentTermID) AS PaymentTermID, ISNULL(A9.Description, B1.FCT) AS FCT
				, B1.AdvancePayment, B1.AdvanceUserID, A4.ObjectName AS AdvanceUserName, B1.DueDate
				, B1.Deadline, B1.Status, B1.DeleteFlg, B1.APKInherited, B1.InheritVoucherNo, B1.DescriptionMaster
				, B1.ApprovingLevel, B1.ApproveLevel, ISNULL(A7.CurrencyName, B1.CurrencyID) AS CurrencyID, B1.ExchangeRate
				, CONCAT(B1.CreateUserID, ''_'', A1.FullName) AS CreateUserID, B1.CreateDate
				, CONCAT(B1.LastModifyUserID, ''_'', A2.FullName) AS LastModifyUserID, B1.LastModifyDate
				' + @sSQLSelect + '
			FROM BEMT2000 B1 WITH (NOLOCK)
				INNER JOIN BEMT0000 B0 WITH (NOLOCK) ON B1.DivisionID = B0.DivisionID
				LEFT JOIN AT1011 A0 WITH (NOLOCK) ON A0.DivisionID = B0.DivisionID AND A0.AnaTypeID = B0.SubsectionAnaID AND A0.AnaID = B1.DepartmentID
				LEFT JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = B1.CreateUserID AND A1.DivisionID = B1.DivisionID
				LEFT JOIN AT1103 A2 WITH (NOLOCK) ON A2.EmployeeID = B1.LastModifyUserID AND A1.DivisionID = B1.DivisionID
				LEFT JOIN AT1103 A3 WITH (NOLOCK) ON A3.EmployeeID = B1.ApplicantID AND A3.DivisionID = B1.DivisionID
				LEFT JOIN AT1202 A4 WITH (NOLOCK) ON A4.ObjectID = B1.AdvanceUserID AND A4.DivisionID = B1.DivisionID
				LEFT JOIN AT1205 A5 WITH (NOLOCK) ON A5.DivisionID IN (B1.DivisionID, ''@@@'') AND A5.PaymentID = B1.MethodPay
				LEFT JOIN AT1208 A6 WITH (NOLOCK) ON A6.DivisionID IN (B1.DivisionID, ''@@@'') AND A6.PaymentTermID = B1.PaymentTermID
				LEFT JOIN AT1004 A7 WITH (NOLOCK) ON A7.DivisionID IN (B1.DivisionID, ''@@@'') AND A7.CurrencyID = B1.CurrencyID
                --LEFT JOIN OOT9001 O1 WITH (NOLOCK) ON O1.APKMaster = B1.APKMaster_9000
                --LEFT JOIN AT0099 A8 WITH (NOLOCK) ON A8.ID = O1.Status AND A8.CodeMaster = ''Status''
				LEFT JOIN AT0099 A9 WITH (NOLOCK) ON A9.CodeMaster = ''AT00000004'' AND A9.ID = B1.FCT
				LEFT JOIN BEMT0099 B2 WITH (NOLOCK) ON B2.CodeMaster = ''ProposalTypeID'' AND ISNULL(B2.Disabled, 0) = 0 AND B2.ID = B1.TypeID
				' + @sSQLJoin + '
            WHERE B1.APK = ''' + @APK + ''' OR B1.APKMaster_9000 = ''' + @APK + ''' '

	EXEC (@sSQL)
	PRINT(@sSQL)

END






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
