IF EXISTS
(
    SELECT TOP 1
           1
    FROM dbo.sysobjects
    WHERE id = OBJECT_ID(N'[DBO].[OOP2005_NQH]')
          AND OBJECTPROPERTY(id, N'IsProcedure') = 1
)
    DROP PROCEDURE [dbo].[OOP2005_NQH];
GO
SET QUOTED_IDENTIFIER ON;
GO
SET ANSI_NULLS ON;
GO





-- <Summary>
---- Sử dụng để trả dữ liệu gửi mail cho người duyệt
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hoài Phong [11/01/2021] Tách SP cho NQH
----Updated by: Thành Sang - set lại điều kiện khi duyệt 1 cấp
---- 
/*
   OOP2005_NQH 'HT','ASOFTADMIN',3,2016,'142C344D-11C8-4ED3-AA53-0020261A0C18','0294D54C-0EC4-499D-A16C-DC1A0732A3CC'
*/
CREATE PROCEDURE OOP2005_NQH
(
    @DivisionID VARCHAR(50),
    @UserID VARCHAR(50),
    @TranMonth INT,
    @TranYear INT,
    @APKMaster VARCHAR(50),
    @APK VARCHAR(50) -- APK của bảng OOT9001
)
AS
DECLARE @Level INT,
        @ApprovePersonID VARCHAR(50),
        @sSQl NVARCHAR(MAX) = '',
        @sSelect NVARCHAR(MAX) = '',
        @sJoin NVARCHAR(MAX) = '',
        @TypeName NVARCHAR(MAX) = '',
        @Type VARCHAR(50) = '',
        @APKOOT9000 VARCHAR(250) = '';


IF ISNULL(@APK, '') = ''
BEGIN
    SELECT @Type = [Type]
    FROM OOT9000
    WHERE APK = @APKMaster;
    SET @APKOOT9000 = @APKMaster;

END;

ELSE
BEGIN
    SELECT @Type = [Type]
    FROM OOT9000
    WHERE APK =
    (
        SELECT APKMaster FROM dbo.OOT9001 WHERE APK = @APK
    );
    SET @APKOOT9000 =
    (
        SELECT APKMaster FROM dbo.OOT9001 WHERE APK = @APK
    );
END;


IF @Type = 'DXP'
BEGIN
    SET @sSelect
        = N', MAX(OOT.Reason) AS Reason, CONVERT(VARCHAR(150),MAX(OOT.LeaveFromDate),120) +N'' đến ''+ CONVERT(VARCHAR(150),MAX(OOT.LeaveToDate),120) AS ApproveTime';
    SET @TypeName = 'MAX(OOT99.Description + '' '' + LOWER(OOT10.[Description]))';
    SET @sJoin
        = 'LEFT JOIN OOT2010 OOT ON OOT.DivisionID = OOT90.DivisionID AND OOT.APKMaster = OOT90.APK
				  LEFT JOIN OOT1000 OOT10 ON OOT10.DivisionID = OOT90.DivisionID AND OOT10.AbsentTypeID = OOT.AbsentTypeID';

END;
ELSE IF @Type = 'DXDC'
BEGIN
    SET @sSelect
        = N', CONVERT(VARCHAR(150),MAX(OOT.ChangeFromDate),120) +N'' đến ''+ CONVERT(VARCHAR(150),MAX(OOT.ChangeToDate),120) AS ApproveTime';
    SET @TypeName = 'MAX(OOT99.Description)';
    SET @sJoin = 'LEFT JOIN OOT2070 OOT ON OOT.DivisionID = OOT90.DivisionID AND OOT.APKMaster = OOT90.APK';
END;
ELSE IF @Type = 'DXLTG'
BEGIN
    SET @sSelect
        = N', MAX(OOT.Reason) AS Reason, CONVERT(VARCHAR(150),MAX(OOT.WorkFromDate),120) +N'' đến ''+ CONVERT(VARCHAR(150),MAX(OOT.WorkToDate),120) AS ApproveTime';
    SET @TypeName = 'MAX(OOT99.Description)';
    SET @sJoin = 'LEFT JOIN OOT2030 OOT ON OOT.DivisionID = OOT90.DivisionID AND OOT.APKMaster = OOT90.APK';
END;
ELSE IF @Type = 'DXBSQT'
BEGIN
    SET @sSelect = N', MAX(OOT.Reason) AS Reason, CONVERT(VARCHAR(150),MAX(OOT.Date),120) AS ApproveTime';
    SET @TypeName = 'MAX(OOT99.Description)';
    SET @sJoin = 'LEFT JOIN OOT2040 OOT ON OOT.DivisionID = OOT90.DivisionID AND OOT.APKMaster = OOT90.APK';
END;
ELSE IF @Type = 'DXRN'
BEGIN
    SET @sSelect
        = N', MAX(OOT.Reason) AS Reason, CONVERT(VARCHAR(150),MAX(OOT.GoFromDate),120) +N'' đến ''+ CONVERT(VARCHAR(150),MAX(OOT.GoToDate),120) AS ApproveTime';
    SET @TypeName = 'MAX(OOT99.Description)';
    SET @sJoin = 'LEFT JOIN OOT2020 OOT ON OOT.DivisionID = OOT90.DivisionID AND OOT.APKMaster = OOT90.APK';
END;
ELSE
    SET @TypeName = 'MAX(OOT99.Description)';

SELECT @Level = MAX(Level),
       @ApprovePersonID = ApprovePersonID
FROM OOT9001
WHERE APKMaster = @APKMaster
      AND ApprovePersonID =
      (
          SELECT TOP 1
                 ApprovePersonID
          FROM OOT9001
          WHERE  APKMaster = @APKMaster
      )
GROUP BY ApprovePersonID;

SET @Level = ISNULL(@Level, 0);

IF @Level > 1
    SET @APK =
(
    SELECT TOP 1
           APK
    FROM OOT9001
    WHERE APKMaster = @APKMaster
          AND ApprovePersonID = @ApprovePersonID
          AND Level = @Level
)   ;

SET @sSQl
    = '
SELECT OOT911.APK NextAPK,OOT90.ID,OOT90.Description,OOT90.Type,OOT90.APK APKMaster
	, AT13.EmployeeID CreateUserID, AT13.FullName CreateUserName ,OOT91.Level
	, CASE WHEN ''' + @Type + ''' = ''DXP'' THEN ' + @TypeName
      + ' ELSE OOT99.Description END AS TypeName
	, AT13.Email CreateEmail,AT131.EmployeeID ApprovePersonID, AT131.FullName ApprovePersonName,AT131.Email ApproveEmail
	, ISNULL(HT00.EmailSuggest, OOT02.EmailSuggest) EmailSuggest
	, ISNULL(HT00.EmailApprove, OOT02.EmailApprove) EmailApprove
	, AT1311.Email NextApproveEmail,AT1311.EmployeeID NextApprovePersonID, AT1311.FullName NextApprovePersonName
	, OOT91.Note,OOT991.Description Status
	, AT29.EmailTitle SubjectSuggest,AT29.EmailBody ContentSuggest,AT291.EmailTitle SubjectApprove,AT291.EmailBody ContentApprove
	, OOT911.APK ' + @sSelect
      + '
FROM OOT9000 OOT90
	LEFT JOIN AT1103 AT13 ON AT13.EmployeeID = OOT90.CreateUserID
	LEFT JOIN OOT9001 OOT91 ON OOT91.DivisionID = OOT90.DivisionID AND OOT91.APKMaster = OOT90.APK AND CONVERT(VARCHAR(50),OOT91.APK) = '''
      + ISNULL(CONVERT(VARCHAR(50), @APK), '')
      + '''
	LEFT JOIN AT1103 AT131 ON AT131.EmployeeID = OOT91.ApprovePersonID
	LEFT JOIN OOT0099 OOT99 ON OOT99.ID=OOT90.[Type] AND OOT99.CodeMaster=''Applying''
	LEFT JOIN OOT0099 OOT991 ON OOT991.ID1=OOT91.Status AND OOT991.CodeMaster=''Status''
	LEFT JOIN OOT0020 OOT02 ON OOT02.DivisionID = OOT90.DivisionID AND OOT02.TranMonth=' + STR(@TranMonth)
      + ' AND OOT02.TranYear = ' + STR(@TranYear)
      + '
	LEFT JOIN OOT9001 OOT911 ON OOT911.DivisionID = OOT90.DivisionID AND OOT911.APKMaster = OOT90.APK AND OOT911.Level = '+CASE WHEN @Level > 1 THEN STR(@Level + 1) ELSE STR(@Level) END +'
	LEFT JOIN AT1103 AT1311 ON AT1311.EmployeeID = OOT911.ApprovePersonID
	LEFT JOIN HT0000 HT00 ON HT00.DivisionID = OOT90.DivisionID
	LEFT JOIN AT0129 AT29 ON AT29.TemplateID = ISNULL(HT00.EmailSuggest, OOT02.EmailSuggest)
	LEFT JOIN AT0129 AT291 ON AT291.TemplateID = iSNULL(HT00.EmailApprove, OOT02.EmailApprove)
	' + @sJoin + '
WHERE OOT90.DivisionID=''' + @DivisionID + '''
	AND OOT90.APK=''' + @APKOOT9000
      + '''
GROUP BY OOT911.APK,OOT90.ID,OOT90.Description,OOT90.Type,OOT90.APK,AT13.EmployeeID,AT13.FullName,OOT91.Level, OOT99.Description,
	AT13.Email,AT131.EmployeeID, AT131.FullName ,AT131.Email ,OOT02.EmailApprove,OOT02.EmailSuggest,HT00.EmailApprove,HT00.EmailSuggest,AT1311.Email ,AT1311.EmployeeID , AT1311.FullName ,OOT91.Note,
	OOT991.Description,AT29.EmailTitle,AT29.EmailBody ,AT291.EmailTitle ,AT291.EmailBody,OOT911.APK
';
PRINT (@sSQl);
EXEC (@sSQl);







GO
SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS ON;
GO
