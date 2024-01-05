IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[BEMP2012]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[BEMP2012]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







-- <Summary>
--- Load Dữ liệu màn hình xem chi tiết BEMF2012 
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Tấn Thành	on: 22/06/2020
---- Modified by: Vĩnh Tâm	on: 14/12/2020: Bổ sung load dữ liệu Công đoạn
---- Modified by: Vĩnh Tâm	on: 25/01/2021: Update câu query load dữ liệu khi có nhiều cấp duyệt


CREATE PROCEDURE [dbo].[BEMP2012]
(
	@DivisionID VARCHAR(50),
	@APK VARCHAR(50) = '',
	@APKMaster VARCHAR(50) = '',
	@Type VARCHAR(50) = ''
)
AS

DECLARE @sSQL NVARCHAR(MAX), 
		@sWhere NVARCHAR(MAX) = '',
		@Level INT,
		@sSQLSL NVARCHAR (MAX) = '',
		@i INT = 1, @s VARCHAR(2),
		@sSQLJoin NVARCHAR(MAX) = ''

IF ISNULL(@Type, '') = 'DNCT'
BEGIN
	SET @sWhere = @sWhere + 'AND CONVERT(VARCHAR(50),B1.APKMaster_9000) = ''' + @APKMaster + ''''
	SELECT @Level = MAX(Levels) FROM BEMT2010 WITH (NOLOCK) WHERE APKMaster_9000 = @APKMaster AND DivisionID = @DivisionID
END
ELSE
BEGIN
	SET @sWhere = @sWhere + 'AND (CONVERT(VARCHAR(50),B1.APK) = ''' + @APK + '''OR CONVERT(VARCHAR(50),B1.APKMaster_9000) = ''' + @APK + ''')'
	SELECT @Level = MAX(Levels) FROM BEMT2010 WITH (NOLOCK) WHERE @APK = @APK AND DivisionID = @DivisionID
END

	WHILE @i < = @Level
	BEGIN
		IF @i < 10 SET @s = '0' + CONVERT(VARCHAR, @i)
		ELSE SET @s = CONVERT(VARCHAR, @i)

		SET @sSQLSL = @sSQLSL + ' , ApprovePerson' + @s + 'ID, ApprovePerson' + @s + 'Name, ApprovePerson' + @s + 'Status, ApprovePerson' + @s + 'Note '
		
		SET @sSQLJoin = @sSQLJoin + '
		LEFT JOIN (
			SELECT ApprovePersonID ApprovePerson' + @s + 'ID, OOT1.APKMaster, OOT1.DivisionID, O99.Description AS ApprovePerson' + @s + 'Status,
				A1.FullName AS ApprovePerson' + @s + 'Name, OOT1.Note AS ApprovePerson' + @s + 'Note
			FROM OOT9001 OOT1 WITH (NOLOCK)
				LEFT JOIN OOT0099 O99 WITH (NOLOCK) ON O99.ID1 = ISNULL(OOT1.Status, 0) AND O99.CodeMaster = ''Status''
				INNER JOIN AT1103 A1 WITH (NOLOCK) ON A1.DivisionID = OOT1.DivisionID AND A1.EmployeeID = OOT1.ApprovePersonID
			WHERE OOT1.Level = ' + STR(@i) + '
		) APP' + @s + ' ON APP' + @s + '.DivisionID = OOT90.DivisionID AND APP' + @s + '.APKMaster = OOT90.APK'

		SET @i = @i + 1
	END

SET @sSQL = '
	SELECT B1.APK, B1.DivisionID, B1.VoucherNo, B1.VoucherDate, B1.TypeID,
		B1.TypeBSTripID, B1.DepartmentCharged, B1.StatusID, B1.Applicant,
		B1.AdvancePaymentUserID, B1.AdvanceEstimate, B1.AdvanceCurrencyID,
		B1.DutyID, B1.TitleID, B1.DepartmentID, B1.SectionID, B1.SubsectionID,
		B1.TotalDate, B1.CountryID, B1.CityID, B1.CompanyName, B1.Purpose,
		B1.EmergencyReason, B1.TheOthers, B1.TicketFee, B1.Journeys, B1.MeetingFee,
		B1.OtherFee,B1.ReasonOtherFee, B1.LivingFee, B1.TravellingFee, B1.Accommodation,
		B1.NumberOfDateStay, B1.BusinessFeePerDay, B1.CurrencyID, B1.TotalFee, B1.StartDate,
		B1.EndDate, B1.CreateDate, B1.CreateUserID, B1.LastModifyDate, B1.LastModifyUserID, B1.Levels,
		B2.[Description] AS TypeBSTripName, B3.[Description] AS TypeName, A1.AnaName AS DepartmentChargedName,
		A3.FullName AS ApplicantName, A2.AnaName AS SubsectionName, A5.CurrencyName AS AdvanceCurrencyName,
		A4.ObjectName AS AdvancePaymentUserName, A6.CurrencyName AS CurrencyName,
		A5.ExchangeRate, A7.AnaName DepartmentName, A8.CountryName, A9.CityName, H1.TeamName AS TeamID,
		A10.AnaName AS SectionName, A11.AnaName AS ProcessID, H3.DutyName, H4.TitleName
		' + @sSQLSL + '
	FROM BEMT2010 AS B1 WITH (NOLOCK)
		LEFT JOIN OOT9000 OOT90 WITH (NOLOCK) ON B1.APKMaster_9000 = OOT90.APK
		LEFT JOIN BEMT0099 AS B2 WITH (NOLOCK) ON B2.ID = B1.TypeBSTripID AND B2.CodeMaster = ''TypeBSTrip''
		LEFT JOIN BEMT0099 AS B3 WITH (NOLOCK) ON B3.ID = B1.TypeID AND B3.CodeMaster = ''TypePriority''
		LEFT JOIN BEMT0000 AS B4 WITH (NOLOCK) ON B1.DivisionID = B4.DivisionID
		LEFT JOIN AT1011 AS A1 WITH (NOLOCK) ON B4.DepartmentAnaID = A1.AnaTypeID AND A1.AnaID = B1.DepartmentCharged AND A1.DivisionID IN (B1.DivisionID, ''@@@'')
		LEFT JOIN AT1011 AS A2 WITH (NOLOCK) ON A2.AnaID = B1.SubsectionID AND A2.AnaTypeID = ''A03'' AND A2.DivisionID IN (B1.DivisionID, ''@@@'')
		LEFT JOIN AT1103 AS A3 WITH (NOLOCK) ON A3.EmployeeID = B1.Applicant AND A3.DivisionID IN (B1.DivisionID, ''@@@'')
		LEFT JOIN AT1202 AS A4 WITH (NOLOCK) ON A4.ObjectID = B1.AdvancePaymentUserID AND A4.DivisionID IN (B1.DivisionID, ''@@@'')
		LEFT JOIN AT1004 AS A5 WITH (NOLOCK) ON A5.CurrencyID = B1.AdvanceCurrencyID AND A5.DivisionID IN (B1.DivisionID, ''@@@'')
		LEFT JOIN AT1004 AS A6 WITH (NOLOCK) ON A6.CurrencyID = B1.CurrencyID AND A6.DivisionID IN (B1.DivisionID, ''@@@'')
		LEFT JOIN AT1011 AS A7 WITH (NOLOCK) ON A7.AnaID = B1.DepartmentID AND A7.AnaTypeID = ''A02'' AND A7.DivisionID IN (B1.DivisionID, ''@@@'')
		LEFT JOIN AT1001 AS A8 WITH (NOLOCK) ON A8.CountryID = B1.CountryID AND A8.DivisionID IN (B1.DivisionID, ''@@@'')
		LEFT JOIN AT1002 AS A9 WITH (NOLOCK) ON A9.CityID = B1.CityID AND A9.DivisionID IN (B1.DivisionID, ''@@@'')
		LEFT JOIN HT1101 AS H1 WITH (NOLOCK) ON H1.TeamID = B1.TeamID AND H1.DivisionID IN (B1.DivisionID, ''@@@'')
		LEFT JOIN AT1011 AS A10 WITH (NOLOCK) ON A10.AnaID = B1.SectionID AND A10.AnaTypeID = ''A04'' AND A10.DivisionID IN (B1.DivisionID, ''@@@'')
		LEFT JOIN AT1011 AS A11 WITH (NOLOCK) ON A11.AnaID = B1.ProcessID AND A11.AnaTypeID = ''A05'' AND A11.DivisionID IN (B1.DivisionID, ''@@@'')
		LEFT JOIN HT1102 AS H3 WITH (NOLOCK) ON H3.DutyID = B1.DutyID AND H3.DivisionID IN (B1.DivisionID, ''@@@'')
		LEFT JOIN HT1106 AS H4 WITH (NOLOCK) ON H4.TitleID = B1.TitleID AND H4.DivisionID IN (B1.DivisionID, ''@@@'')
		' + @sSQLJoin + '
	WHERE B1.DivisionID = ''' + @DivisionID + ''' ' + @sWhere + ''

EXEC (@sSQL)
--PRINT (@sSQL)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
