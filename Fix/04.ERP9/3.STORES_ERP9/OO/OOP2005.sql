IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2005]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2005]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
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
----Created by: Trần Quốc Tuấn, Date: 08/12/2015
---- Modified by Bảo Thy on 23/05/2017: Sửa danh mục dùng chung
---- Modified by Hoài Phong on 11/01/2020: Tách sp Cho NQH
---- Modified by Kiều Nga on 17/08/2023: [2023/08/IS/0170] Fix lỗi cùng 1 mã đơn xin ra ngoài nhưng nhưng thông báo gửi mail bị lặp lại nhiều lần
-- <Example>
---- 
/*
   OOP2005 'HT','ASOFTADMIN',3,2016,'142C344D-11C8-4ED3-AA53-0020261A0C18','0294D54C-0EC4-499D-A16C-DC1A0732A3CC'
*/
CREATE PROCEDURE OOP2005
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
        @CustomerName INT;

SET @CustomerName =
(
    SELECT TOP 1 CustomerName FROM dbo.CustomerIndex
);
IF @CustomerName = 131 --NQH
BEGIN
    EXEC OOP2005_NQH @DivisionID, @UserID, @TranMonth,@TranYear, @APKMaster, @APK;
END;
ELSE
BEGIN
    SELECT @Type = [Type]
    FROM OOT9000
    WHERE APK = @APKMaster;

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
              WHERE CONVERT(VARCHAR(50), APK) = @APK
                    AND APKMaster = @APKMaster
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

	IF @Type IN ('DXP','DXDC','DXLTG','DXBSQT','DXRN') AND ISNULL(@APK,'') = ''
	BEGIN
		SET @sSQl
			= '
	SELECT OOT91.APK NextAPK,OOT90.ID,OOT90.Description,OOT90.Type,OOT90.APK APKMaster
		, AT13.EmployeeID CreateUserID, AT13.FullName CreateUserName ,OOT91.Level
		, CASE WHEN ''' + @Type + ''' = ''DXP'' THEN ' + @TypeName
			  + ' ELSE OOT99.Description END AS TypeName
		, AT13.Email CreateEmail,AT131.EmployeeID ApprovePersonID, AT131.FullName ApprovePersonName,AT131.Email ApproveEmail
		, ISNULL(HT00.EmailSuggest, OOT02.EmailSuggest) EmailSuggest
		, ISNULL(HT00.EmailApprove, OOT02.EmailApprove) EmailApprove
		, AT1311.Email NextApproveEmail,AT1311.EmployeeID NextApprovePersonID, AT1311.FullName NextApprovePersonName
		, OOT91.Note,OOT991.Description Status
		, AT29.EmailTitle SubjectSuggest,AT29.EmailBody ContentSuggest,AT291.EmailTitle SubjectApprove,AT291.EmailBody ContentApprove
		, OOT91.APK ' + @sSelect
			  + '
	FROM OOT9000 OOT90
		LEFT JOIN AT1103 AT13 ON AT13.EmployeeID = OOT90.CreateUserID
		LEFT JOIN (SELECT * FROM (
					SELECT ROW_NUMBER() OVER (PARTITION BY OOT91.APKMaster,OOT91.ApprovePersonID ORDER BY [Level] DESC) AS rn,OOT91.APK,OOT91.DivisionID,OOT91.APKMaster,OOT91.ApprovePersonID, OOT91.Note,OOT91.[Status],OOT91.[Level] 
					FROM OOT9001 OOT91 WITH (NOLOCK)
					LEFT JOIN OOT9000 OOT90 WITH (NOLOCK) ON OOT91.DivisionID = OOT90.DivisionID AND OOT91.APKMaster = OOT90.APK
					WHERE OOT90.APK=''' + @APKMaster+ ''') A WHERE rn = 1) OOT91 ON OOT91.DivisionID = OOT90.DivisionID AND OOT91.APKMaster = OOT90.APK
		LEFT JOIN AT1103 AT131 ON AT131.EmployeeID = OOT91.ApprovePersonID
		LEFT JOIN OOT0099 OOT99 ON OOT99.ID=OOT90.[Type] AND OOT99.CodeMaster=''Applying''
		LEFT JOIN OOT0099 OOT991 ON OOT991.ID1=OOT91.Status AND OOT991.CodeMaster=''Status''
		LEFT JOIN OOT0020 OOT02 ON OOT02.DivisionID = OOT90.DivisionID AND OOT02.TranMonth=' + STR(@TranMonth)
			  + ' AND OOT02.TranYear = ' + STR(@TranYear)
			  + '
		LEFT JOIN AT1103 AT1311 ON AT1311.EmployeeID = OOT91.ApprovePersonID
		LEFT JOIN HT0000 HT00 ON HT00.DivisionID = OOT90.DivisionID
		LEFT JOIN AT0129 AT29 ON AT29.TemplateID = ISNULL(HT00.EmailSuggest, OOT02.EmailSuggest)
		LEFT JOIN AT0129 AT291 ON AT291.TemplateID = iSNULL(HT00.EmailApprove, OOT02.EmailApprove)
		' + @sJoin + '
	WHERE OOT90.DivisionID=''' + @DivisionID + '''
		AND OOT90.APK=''' + @APKMaster
			  + '''
	GROUP BY OOT91.APK,OOT90.ID,OOT90.Description,OOT90.Type,OOT90.APK,AT13.EmployeeID,AT13.FullName,OOT91.Level, OOT99.Description,
		AT13.Email,AT131.EmployeeID, AT131.FullName ,AT131.Email ,OOT02.EmailApprove,OOT02.EmailSuggest,HT00.EmailApprove,HT00.EmailSuggest,AT1311.Email ,AT1311.EmployeeID , AT1311.FullName ,OOT91.Note,
		OOT991.Description,AT29.EmailTitle,AT29.EmailBody ,AT291.EmailTitle ,AT291.EmailBody,OOT91.APK
	ORDER BY OOT91.Level
	'   ;

	END
	ELSE
	BEGIN
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
	LEFT JOIN OOT9001 OOT911 ON OOT911.DivisionID = OOT90.DivisionID AND OOT911.APKMaster = OOT90.APK AND OOT911.Level = '
          + STR(@Level + 1)
          + '
	LEFT JOIN AT1103 AT1311 ON AT1311.EmployeeID = OOT911.ApprovePersonID
	LEFT JOIN HT0000 HT00 ON HT00.DivisionID = OOT90.DivisionID
	LEFT JOIN AT0129 AT29 ON AT29.TemplateID = ISNULL(HT00.EmailSuggest, OOT02.EmailSuggest)
	LEFT JOIN AT0129 AT291 ON AT291.TemplateID = iSNULL(HT00.EmailApprove, OOT02.EmailApprove)
	' + @sJoin + '
WHERE OOT90.DivisionID=''' + @DivisionID + '''
	AND OOT90.APK=''' + @APKMaster
          + '''
GROUP BY OOT911.APK,OOT90.ID,OOT90.Description,OOT90.Type,OOT90.APK,AT13.EmployeeID,AT13.FullName,OOT91.Level, OOT99.Description,
	AT13.Email,AT131.EmployeeID, AT131.FullName ,AT131.Email ,OOT02.EmailApprove,OOT02.EmailSuggest,HT00.EmailApprove,HT00.EmailSuggest,AT1311.Email ,AT1311.EmployeeID , AT1311.FullName ,OOT91.Note,
	OOT991.Description,AT29.EmailTitle,AT29.EmailBody ,AT291.EmailTitle ,AT291.EmailBody,OOT911.APK
'   ;
	END

    PRINT (@sSQl);
    EXEC (@sSQl);



END;

GO
SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS ON;
GO
