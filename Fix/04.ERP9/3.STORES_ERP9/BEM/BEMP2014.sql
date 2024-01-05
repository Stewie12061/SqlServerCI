IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[BEMP2014]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[BEMP2014]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-- <Summary>
--- Load Master cho màn hình Update - BEMF2011 (Cập nhật đơn xin duyệt CT-NP)
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Tấn Thành	Create on: 09/06/2020
---- Modified by: Vĩnh Tâm	on: 14/12/2020: Bổ sung load dữ liệu Công đoạn
---- Modified by: Vĩnh Tâm	on: 25/01/2021: Update câu query load dữ liệu khi có nhiều cấp duyệt

CREATE PROCEDURE [dbo].[BEMP2014]
(
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@APK VARCHAR(50) = '',
	@APKMaster VARCHAR(50) = '',
	@Type VARCHAR(50) = ''
)
AS

DECLARE @sSQL NVARCHAR(MAX), 
		@sWhere NVARCHAR(MAX) = '',
		@Level INT,
		@sSQLSL NVARCHAR(MAX) = '',
		@i INT = 1, @s VARCHAR(2),
		@sSQLJoin NVARCHAR(MAX) = '',
		@sSQLGetExchangeRate VARCHAR(MAX) = '',
		@sLevelApprove VARCHAR(50) = '',
		@sSQLOrderBy NVARCHAR (MAX) = ''

SET @APK = IIF(ISNULL(@APK, '') != '', @APK, @APKMaster)
-- Lấy cấp độ duyệt của phiếu hiện tại
SELECT @Level = MAX(Levels) FROM BEMT2010 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND @APK IN (CONVERT(VARCHAR(50), APK), CONVERT(VARCHAR(50), APKMaster_9000))

SET @sWhere = ' B1.DivisionID = ''' + @DivisionID + ''''
SET @sWhere = @sWhere + ' AND ''' + @APK + ''' IN (CONVERT(VARCHAR(50), B1.APK), CONVERT(VARCHAR(50), B1.APKMaster_9000))'

IF ISNULL(@Type, '') = 'DNCT' 
BEGIN
	SET @sLevelApprove = ', O2.Level AS CurrentLevel'
	SET @sSQLSL = ' , O2.Status AS Status, O2.Note '
	SET @sSQLJoin = 'LEFT JOIN OOT9001 O2 WITH (NOLOCK) ON O2.APKMaster = B1.APKMaster_9000 AND O2.ApprovePersonID = ''' + @UserID + ''''
	-- Trường hợp mở từ màn hình Duyệt thì thực hiện sắp xếp theo Cấp duyệt giảm dần và lấy TOP 1 => Xử lý lỗi mở form khi có cùng người duyệt cho nhiều cấp
	SET @sSQLOrderBy = ' ORDER BY O2.Level DESC'
END

WHILE @i <= @Level
BEGIN
	IF @i < 10 SET @s = '0' + CONVERT(VARCHAR, @i)
	ELSE SET @s = CONVERT(VARCHAR, @i)

	SET @sSQLGetExchangeRate = '
	DECLARE @CurrencyID_Temp VARCHAR(50),
			@ExchangeRate DECIMAL(28,8)
	SELECT @CurrencyID_Temp = B1.AdvanceCurrencyID 
	FROM BEMT2010 B1 WITH (NOLOCK)
	WHERE ' + @sWhere + '

	IF (EXISTS (
		SELECT TOP 1 1 
		FROM AT1012 A WITH (NOLOCK)
		WHERE A.DivisionID = ''' + @DivisionID + ''' AND A.CurrencyID = @CurrencyID_Temp AND FORMAT(ExchangeDate, ''yyyy-MM-dd 00:00:00:000'') = FORMAT(GETDATE(), ''yyyy-MM-dd 00:00:00:000''))) 
		BEGIN
			SELECT TOP 1 @ExchangeRate = ExchangeRate 
			FROM AT1012 A WITH (NOLOCK)
			WHERE A.DivisionID = ''' + @DivisionID + ''' AND A.CurrencyID = @CurrencyID_Temp AND FORMAT(ExchangeDate, ''yyyy-MM-dd 00:00:00:000'') = FORMAT(GETDATE(), ''yyyy-MM-dd 00:00:00:000'')
		END
	ELSE IF (EXISTS (
		SELECT TOP 1 1 
		FROM AT1012 A WITH (NOLOCK)
		WHERE A.DivisionID = ''' + @DivisionID + ''' AND A.CurrencyID = @CurrencyID_Temp AND A.TranMonth = MONTH(GETDATE()) AND A.TranYear = YEAR(GETDATE()))) 
			BEGIN
				SELECT TOP 1 @ExchangeRate = ExchangeRate 
				FROM AT1012 A WITH (NOLOCK)
				WHERE A.DivisionID = ''' + @DivisionID + ''' AND A.CurrencyID = @CurrencyID_Temp AND A.TranMonth = MONTH(GETDATE()) AND A.TranYear = YEAR(GETDATE())
				ORDER BY ExchangeDate DESC
			END
	ELSE 
		BEGIN
			SELECT @ExchangeRate = ExchangeRate 
			FROM AT1004 A WITH (NOLOCK)
			WHERE A.DivisionID = ''' + @DivisionID + ''' AND A.CurrencyID = @CurrencyID_Temp 
		END'

	SET @sSQLSL= @sSQLSL + ', ApprovePerson' + @s + 'ID, ApprovePerson' + @s + 'Name, ApprovePerson' + @s + 'Status, ApprovePerson' + @s + 'Note'
		
	SET @sSQLJoin = @sSQLJoin + '
		LEFT JOIN (
			SELECT ApprovePersonID ApprovePerson' + @s + 'ID, OOT1.APKMaster, OOT1.DivisionID, OOT1.Status AS ApprovePerson' + @s + 'Status,
				A1.FullName AS ApprovePerson' + @s + 'Name, OOT1.Note AS ApprovePerson' + @s + 'Note
			FROM OOT9001 OOT1 WITH (NOLOCK)
				INNER JOIN AT1103 A1 WITH (NOLOCK) ON A1.DivisionID = OOT1.DivisionID AND A1.EmployeeID = OOT1.ApprovePersonID
			WHERE OOT1.Level = ' + STR(@i) + '
		) APP' + @s + ' ON APP' + @s + '.DivisionID = O1.DivisionID AND APP' + @s + '.APKMaster = O1.APK'

	SET @i = @i + 1
END

SET @sSQL = @sSQLGetExchangeRate + '
	SELECT TOP 1 B1.APK, B1.APKMaster_9000, B1.DivisionID, B1.VoucherNo, B1.VoucherDate, ''' + ISNULL(@Type, '') + ''' AS Type, B1.TypeID,
		B1.DepartmentCharged, B1.DutyID, B1.TitleID, B1.DepartmentID, B1.TypeBSTripID, B1.Applicant,
		B1.SubsectionID, B1.TeamID, B1.ProcessID, B1.AdvanceEstimate, B1.AdvanceCurrencyID, B1.CountryID,
		B1.CityID, B1.CompanyName, B1.StartDate, B1.EndDate, B1.Purpose, B1.EmergencyReason,
		B1.TheOthers ,B1.SectionID, B1.TicketFee, B1.Journeys, B1.TravellingFee, B1.MeetingFee,
		B1.OtherFee, B1.ReasonOtherFee, B1.LivingFee, B1.Accommodation, B1.NumberOfDateStay, 
		B1.BusinessFeePerDay, B1.CurrencyID, B1.TotalFee,B1.TotalDate, B1.AdvancePaymentUserID,
		B1.TranMonth, B1.TranYear, B1.DeleteFlg, B1.CreateDate, B1.CreateUserID, B1.LastModifyDate,
		B1.LastModifyUserID, B1.Levels' + @sLevelApprove + ', B1.ApproveLevel, B1.ApprovingLevel,
		A1.FullName AS ApplicantName, A2.ObjectName AS AdvancePaymentUserName, @ExchangeRate AS ExchangeRate,
		A3.CurrencyName AS AdvanceCurrencyName
		' + @sSQLSL + '
	FROM BEMT2010 AS B1 WITH (NOLOCK)
		LEFT JOIN OOT9000 O1 WITH (NOLOCK) ON B1.APKMaster_9000 = O1.APK
		LEFT JOIN AT1103 AS A1 WITH (NOLOCK) ON A1.EmployeeID = B1.Applicant
		LEFT JOIN AT1202 AS A2 WITH (NOLOCK) ON A2.ObjectID = B1.AdvancePaymentUserID
		LEFT JOIN AT1004 AS A3 WITH (NOLOCK) ON A3.CurrencyID = B1.AdvanceCurrencyID
		' + @sSQLJoin + '
	WHERE ' + @sWhere + ''

EXEC (@sSQL)
--PRINT (@sSQL)







GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
