IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[BEMP2022]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[BEMP2022]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO










-- <Summary>
--- Load Master cho màn hình Detail - BEMF2022
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Trọng Kiên	Create on: 12/06/2020
---- Modify by: Trọng Kiên on 18/06/2020: Get thêm Levels và Status để đổ dữ liệu lên màn hình xem chi tiết phiếu thanh toán đi lại BEMF2022


CREATE PROCEDURE [dbo].[BEMP2022]
(
    @DivisionID VARCHAR(50),
    @APK VARCHAR(50) = '',
    @APKMaster VARCHAR(50) = '',
    @Type VARCHAR(50) = ''
)
AS

DECLARE @sSQL NVARCHAR(max), 
        @sWhere  NVARCHAR(max) = '',
        @Level INT,
        @sSQLSL NVARCHAR (MAX) = '',
        @i INT = 1, @s VARCHAR(2),
        @sSQLJon NVARCHAR (MAX) = ''

IF ISNULL(@Type, '') = 'TTDL' 
BEGIN
SET @sWhere = @sWhere + 'AND CONVERT(VARCHAR(50),B1.APKMaster_9000)= '''+@APKMaster+''''
SELECT  @Level = MAX(Levels) FROM BEMT2020 WITH (NOLOCK) WHERE APKMaster_9000 = @APKMaster AND DivisionID = @DivisionID
END
ELSE
BEGIN
SET @sWhere = @sWhere + 'AND (CONVERT(VARCHAR(50),B1.APK)= '''+@APK+'''OR CONVERT(VARCHAR(50),B1.APKMaster_9000) = ''' + @APK + ''')'
SELECT  @Level = MAX(Levels) FROM BEMT2020 WITH (NOLOCK) WHERE @APK = @APK AND DivisionID = @DivisionID
END

    WHILE @i <= @Level
    BEGIN
        IF @i < 10 SET @s = '0' + CONVERT(VARCHAR, @i)
        ELSE SET @s = CONVERT(VARCHAR, @i)

        SET @sSQLSL=@sSQLSL+' ,ApprovePerson'+@s+'ID, ApprovePerson'+@s+'Name, O1.[Description] AS ApprovePerson'+@s+'Status ' 

        SET @sSQLJon =@sSQLJon+ '
                        LEFT JOIN (
                                  SELECT ApprovePersonID ApprovePerson'+@s+'ID, OOT1.APKMaster, OOT1.DivisionID,
                                         A1.FullName As ApprovePerson'+@s+'Name
                                  FROM OOT9001 OOT1 WITH (NOLOCK)
                                  INNER JOIN AT1103 A1 WITH (NOLOCK) ON A1.DivisionID=OOT1.DivisionID AND A1.EmployeeID=OOT1.ApprovePersonID
                                  WHERE OOT1.Level='+STR(@i)+'
                                  ) APP'+@s+' ON APP'+@s+'.DivisionID= OOT90.DivisionID  AND APP'+@s+'.APKMaster=OOT90.APK'

        SET @i = @i + 1	
    END

SET @sSQL = '
        SELECT B1.APK, B1.DivisionID, B1.APKMaster, B1.VoucherNo, B1.VoucherDate, B1.StartDate, B1.EndDate
              , B1.Purpose, B1.TheOthers, B1.AdvanceTotalFee, B1.NoteFee, B1.TotalFee1, B1.APKMaster_9000
              , B1.TotalFee2, B1.TotalFee3, B1.TotalFee4, B1.TotalFee5, B1.Levels, B1.Applicant
              , B2.VoucherNo AS BSTripProposalVoucher, B1.CreateDate, CONCAT(B1.CreateUserID, ''_'', A12.FullName) AS CreateUserID, B1.LastModifyDate
              , CONCAT(B1.LastModifyUserID, ''_'', A13.FullName) AS LastModifyUserID
              , H2.DutyName AS RankName, B1.Rank, B1.TitleID, B1.DepartmentID, B1.SectionID, B1.SubsectionID
              , A3.CurrencyName AS CurrencyName1
              , A4.CurrencyName AS CurrencyName2
              , A5.CurrencyName AS CurrencyName3
              , A6.CurrencyName AS CurrencyName4
              , A7.CurrencyName AS CurrencyName5
              , A8.CurrencyName AS AdvanceCurrencyName
              , H1.TeamName AS SectionName
              , A9.FullName AS ApplicantName
              , A11.CityName, A1.CountryName, H3.TitleName
              , A2.DepartmentName, A10.AnaName AS SubsectionName
              , H1.TeamName
              , B2.CountryID
              , B2.CityID
              , B4.Description AS TypeBSTripName
              , B1.TypeBSTripID
              , ISNULL(B1.Status, 0) AS StatusID
              , O2.Note

    '+@sSQLSL+'
        FROM BEMT2020 B1 WITH (NOLOCK)
            LEFT JOIN OOT9000 OOT90 WITH (NOLOCK) ON B1.APKMaster_9000 = OOT90.APK
            LEFT JOIN BEMT2010 B2 WITH (NOLOCK) ON B2.APK = B1.APKMaster
            LEFT JOIN BEMT0000 AS B3 WITH (NOLOCK) ON B1.DivisionID = B3.DivisionID
            LEFT JOIN HT1101 AS H1 WITH (NOLOCK) ON H1.TeamID = B1.TeamID
            LEFT JOIN HT1102 AS H2 WITH (NOLOCK) ON H2.DutyID = B1.Rank
            LEFT JOIN HT1106 AS H3 WITH (NOLOCK) ON H3.TitleID = B1.TitleID
            LEFT JOIN AT1001 AS A1 WITH (NOLOCK) ON A1.CountryID = B1.CountryID
            LEFT JOIN AT1102 AS A2 WITH (NOLOCK) ON A2.DepartmentID = B1.DepartmentID
            LEFT JOIN AT1004 AS A3 WITH (NOLOCK) ON A3.CurrencyID = B1.CurrencyID1
            LEFT JOIN AT1004 AS A4 WITH (NOLOCK) ON A4.CurrencyID = B1.CurrencyID2
            LEFT JOIN AT1004 AS A5 WITH (NOLOCK) ON A5.CurrencyID = B1.CurrencyID3
            LEFT JOIN AT1004 AS A6 WITH (NOLOCK) ON A6.CurrencyID = B1.CurrencyID4
            LEFT JOIN AT1004 AS A7 WITH (NOLOCK) ON A7.CurrencyID = B1.CurrencyID5
            LEFT JOIN AT1004 AS A8 WITH (NOLOCK) ON A8.CurrencyID = B1.AdvanceCurrencyID
            LEFT JOIN AT1103 AS A9 WITH (NOLOCK) ON A9.EmployeeID = B1.Applicant
            LEFT JOIN AT1011 AS A10 WITH (NOLOCK) ON B3.SubsectionAnaID = A10.AnaTypeID AND A10.AnaID  = B1.SubsectionID
            LEFT JOIN AT1002 AS A11 WITH (NOLOCK) ON A11.CityID = B1.CityID
            LEFT JOIN OOT0099 AS O1 WITH (NOLOCK) ON O1.ID = ISNULL(B1.Status, 0) AND O1.CodeMaster = ''Status''
            LEFT JOIN AT1103 AS A12 WITH (NOLOCK) ON A12.EmployeeID = B1.CreateUserID
            LEFT JOIN AT1103 AS A13 WITH (NOLOCK) ON A13.EmployeeID = B1.LastModifyUserID
            LEFT JOIN BEMT0099 AS B4 WITH (NOLOCK) ON B4.ID  = B1.TypeBSTripID AND B4.CodeMaster = ''TypeBSTrip''
            LEFT JOIN OOT9001 O2 WITH (NOLOCK) ON O2.APKMaster = B1.APKMaster_9000

    '+@sSQLJon+'
    WHERE B1.DivisionID = '''+@DivisionID+''' '+@sWhere+''

EXEC (@sSQL)
PRINT (@sSQL)











GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
