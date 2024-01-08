IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP20504]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP20504]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-- <Summary>
--- Load Master cơ hội
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Kiều Nga on: 04/03/2020
---- Modified by Trọng Kiên on 06/08/2020: Fix lỗi load dữ liệu master khi đơn vị dùng chung
---- Modified by Trọng Kiên on 21/10/2020: Fix lỗi load người tạo và người cập nhật
---- Modified by Vĩnh Tâm   on 15/01/2021: Format nội dung SQL, bổ sung load LastAssignedToUserID
---- Modified by Văn Tài    on 31/08/2021: Bổ sung ráp tên bảng để không bị lỗi Ambigous các cột duyệt.
-- <Example>
/*
	EXEC CRMP20504 'DTI', '2977ed14-c8b7-478f-abf8-ede2ff241a94', 'b964c015-c496-494b-8cb8-33818d32a7ca', 'CH'
*/

CREATE PROCEDURE CRMP20504
(
	@DivisionID VARCHAR(50),
	@APK VARCHAR(50),
	@APKMaster VARCHAR(50) = '',
	@Type VARCHAR(50) = ''
)
AS

DECLARE @Ssql NVARCHAR(MAX),
		@Ssql2 NVARCHAR(MAX),
		@SWHERE NVARCHAR(MAX) = '',
		@Level INT,
		@sSQLSL NVARCHAR(MAX) = '',
		@i INT = 1, @s VARCHAR(2),
		@sSQLJon NVARCHAR (MAX) = ''

IF ISNULL(@Type, '') = 'CH'
BEGIN
	SET @SWHERE = @SWHERE + 'AND CONVERT(VARCHAR(50), M.APKMaster_9000) = ''' + @APKMaster + ''''
	SELECT @Level = MAX(Level) FROM OOT9001 WITH (NOLOCK) WHERE APKMaster = @APKMaster
END
ELSE
BEGIN
	SET @SWHERE = @SWHERE + 'AND M.APK = ''' + @APK + ''''
	SELECT @Level = MAX(Level) FROM OOT9001 WITH (NOLOCK) LEFT JOIN CRMT20501 ON OOT9001.APKMaster = CRMT20501.APKMaster_9000 WHERE CRMT20501.APK = @APK
END
	WHILE @i < = @Level
	BEGIN
		IF @i < 10 SET @s = '0' + CONVERT(VARCHAR, @i)
		ELSE SET @s = CONVERT(VARCHAR, @i)
		SET @sSQLSL = @sSQLSL + ' , APP' + @s + '.ApprovePerson' + @s + 'ID, APP' + @s + '.ApprovePerson' + @s + 'Name, APP' + @s + '.ApprovePerson' + @s + 'Status, APP' + @s + '.ApprovePerson' + @s + 'StatusName, APP' + @s + '.ApprovePerson' + @s + 'Note'
		SET @sSQLJon = @sSQLJon + '
							LEFT JOIN (SELECT ApprovePersonID ApprovePerson' + @s + 'ID, OOT1.APKMaster, OOT1.DivisionID, OOT1.Status, 
							 HT14.FullName AS ApprovePerson' + @s + 'Name, 
							OOT1.Status ApprovePerson' + @s + 'Status, O99.Description ApprovePerson' + @s + 'StatusName, 
							OOT1.Note ApprovePerson' + @s + 'Note
						FROM OOT9001 OOT1 WITH (NOLOCK)
						INNER JOIN AT1103 HT14 WITH (NOLOCK) ON (HT14.DivisionID = OOT1.DivisionID OR ISNULL(HT14.DivisionID, '''') = ''@@@'') AND HT14.EmployeeID = OOT1.ApprovePersonID
						LEFT JOIN OOT0099 O99 WITH (NOLOCK) ON O99.ID1 = ISNULL(OOT1.Status, 0) AND O99.CodeMaster = ''Status''
						WHERE OOT1.Level = ' + STR(@i) + '
						) APP' + @s + ' ON APP' + @s + '.DivisionID = OOT90.DivisionID AND APP' + @s + '.APKMaster = OOT90.APK'
		SET @i = @i + 1
	END	

SET @Ssql = '
	SELECT M.APK, M.DivisionID , M.OpportunityID, M.OpportunityName
		, M.StageID, D1.StageName, M.CampaignID, D2.CampaignName, M.AccountID, D9.ObjectName AS AccountName
		, M.ExpectAmount, M.PriorityID, D17.Description AS PriorityName, M.CauseID, D3.CauseName, M.Notes
		, M.AssignedToUserID, M.AssignedToUserID AS LastAssignedToUserID, D4.FullName AS AssignedToUserName
		, M.SourceID, D5.LeadTypeName AS SourceName, M.StartDate
		, M.ExpectedCloseDate, ISNULL(M.Rate, 0) AS Rate, M.NextActionID, D7.NextActionName, M.NextActionDate
		, STUFF(ISNULL((SELECT '', '' + D6.SalesTagID
				FROM CRMT20501_CRMT10601_REL D6 WITH (NOLOCK) LEFT JOIN CRMT10601 D8 WITH (NOLOCK) ON D8.APK = D6.SalesTagID
				WHERE D6.OpportunityID = M.APK
				GROUP BY D6.SalesTagID
				ORDER BY D6.SalesTagID
				FOR XML PATH (''''), TYPE).value(''.'', ''NVARCHAR(MAX)''), ''''), 1, 2, '''') AS SalesTagID
		, STUFF(ISNULL((SELECT '', '' + D8.SalesTagName
				FROM CRMT20501_CRMT10601_REL D6 WITH (NOLOCK) LEFT JOIN CRMT10601 D8 WITH (NOLOCK) ON D8.APK = D6.SalesTagID
				WHERE D6.OpportunityID = M.APK
				GROUP BY D6.SalesTagID, D8.SalesTagName
				ORDER BY D6.SalesTagID
				FOR XML PATH (''''), TYPE).value(''.'', ''NVARCHAR(MAX)''), ''''), 1, 2, '''') AS SalesTagName
		, M.Disabled, D18.Description AS DisabledName, M.IsCommon, D19.Description AS IsCommonName
		, M.IsAddCalendar, D20.Description AS IsAddCalendarName, M.EventSubject
		, M.CreateUserID + ''_'' + D21.FullName AS CreateUserID
		, M.CreateDate, M.LastModifyUserID + ''_'' + D22.FullName AS LastModifyUserID, M.LastModifyDate
		, M.AreaID, D10.AreaName, M.BusinessLinesID, D11.BusinessLinesName
		, M.O01ID, D12.AnaName AS [O01Name], M.O02ID, D13.AnaName AS [O02Name]
		, M.O03ID, D14.AnaName AS [O03Name], M.O04ID, D15.AnaName AS [O04Name]
		, M.O05ID, D16.AnaName AS [O05Name] , M.RelatedToTypeID, M.S1, M.S2, M.S3, M.OrderStatus, D23.Description AS OrderStatusName, M.APKMaster_9000, M.TaskID, D24.TaskName
		, M.Status
		' + @sSQLSL + ''

SET @Ssql2 = ' FROM CRMT20501 M With (NOLOCK) 
		LEFT JOIN OOT9000 OOT90 WITH (NOLOCK) ON M.APKMaster_9000 = OOT90.APK
		LEFT JOIN CRMT10401 D1 WITH (NOLOCK) ON M.StageID = D1.StageID
		LEFT JOIN CRMT20401 D2 WITH (NOLOCK) ON M.CampaignID = D2.CampaignID
		LEFT JOIN CRMT10501 D3 WITH (NOLOCK) ON M.CauseID = D3.CauseID
		LEFT JOIN AT1103 D4 WITH (NOLOCK) ON M.AssignedToUserID = D4.EmployeeID
		LEFT JOIN CRMT10201 D5 WITH (NOLOCK) ON M.SourceID = D5.LeadTypeID
		LEFT JOIN CRMT10801 D7 WITH (NOLOCK) ON M.NextActionID = D7.NextActionID
		LEFT JOIN AT1202 D9 WITH (NOLOCK) ON M.AccountID = D9.ObjectID
		LEFT JOIN AT1003 D10 WITH (NOLOCK) ON M.AreaID = D10.AreaID
		LEFT JOIN CRMT10701 D11 WITH (NOLOCK) ON M.BusinessLinesID = D11.BusinessLinesID
		LEFT JOIN AT1015 D12 WITH (NOLOCK) ON M.O01ID = D12.AnaID
		LEFT JOIN AT1015 D13 WITH (NOLOCK) ON M.O02ID = D13.AnaID
		LEFT JOIN AT1015 D14 WITH (NOLOCK) ON M.O03ID = D14.AnaID
		LEFT JOIN AT1015 D15 WITH (NOLOCK) ON M.O04ID = D15.AnaID
		LEFT JOIN AT1015 D16 WITH (NOLOCK) ON M.O05ID = D16.AnaID
		LEFT JOIN CRMT0099 D17 WITH (NOLOCK) ON M.PriorityID = D17.ID AND D17.CodeMaster = ''CRMT00000006''
		LEFT JOIN AT0099 D18 WITH (NOLOCK) ON M.Disabled = D18.ID AND D18.CodeMaster = ''AT00000004''
		LEFT JOIN AT0099 D19 WITH (NOLOCK) ON M.IsCommon = D19.ID AND D19.CodeMaster = ''AT00000004''
		LEFT JOIN AT0099 D20 WITH (NOLOCK) ON M.IsAddCalendar = D20.ID AND D20.CodeMaster = ''AT00000004''
		LEFT JOIN AT1103 D21 WITH (NOLOCK) ON M.CreateUserID = D21.EmployeeID
		LEFT JOIN AT1103 D22 WITH (NOLOCK) ON M.LastModifyUserID = D22.EmployeeID
		LEFT JOIN AT0099 D23 WITH (NOLOCK) ON Convert(varchar, M.OrderStatus) = D23.ID AND D23.CodeMaster = ''AT00000003''
		LEFT JOIN OOT2110 D24 WITH (NOLOCK) ON M.TaskID = D24.TaskID AND M.DivisionID = D24.DivisionID
		' + @sSQLJon + '
	WHERE M.DivisionID IN (''' + @DivisionID + ''', ''@@@'') ' + @SWHERE + ''

EXEC (@Ssql + @Ssql2)
--PRINT (@Ssql)
--PRINT (@Ssql2)






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
