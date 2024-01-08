IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2052]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2052]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO









-- <Summary>
---- Load Form OOP2052: Duyệt hàng loạt
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Trần Quốc Tuấn, Date: 07/12/2015
--- Modified on 25/12/2018 by Bảo Anh: Bổ sung kiểm tra phép âm khi duyệt đơn xin phép (NEWTOYO)
--- Modified on 19/02/2019 by Bảo Anh: Bổ sung duyệt quyết định tuyển dụng
--- Modified on 28/06/2019 by Như Hàn: Sửa lại cách viết store khi truyền các biến vào trong chuỗi
--- Modified on 19/06/2020 by Trọng Kiên: [BEM] Bổ sung điều kiện chạy Store OOP2052: 'TTDL', 'BCCT', 'TGCT', 'DCT', 'DNCT', 'PDN'
--- Modified on 24/08/2020 by Trọng Kiên: Bổ sung duyệt đơn hàng mua: 'DHM'
--- Modified on 24/09/2020 by Kiều Nga: Bổ sung order theo APKMaster,Level
--- Modified on 24/09/2020 by Kiều Nga: Bổ sung order theo APKMaster,Level
--- Modified on 30/11/2020 by Huỳnh Thử: Bổ sung duyệt kế hoạch tuyển dụng
--- Modified on 30/11/2020 by Hoài Phong: Bổ sung duyệt Điều chỉnh tạm thời
--- Modified on 21/12/2020 by Đình Ly: Bổ sung duyệt phiếu Thông tin sản xuất.
--- Modified on 30/11/2020 by Hoài Phong:Fix lỗi duyệt duyệt Điều chỉnh tạm thời
--- Modified on 23/07/2021 by Đình Hoà:Bổ sung duyệt bảng tính giá(BTG)
--- Modified on 03/08/2021 by Đình Hoà:Bổ sung duyệt Phiếu báo giá Sale(PBGKD) - (SGNP)
--- Modified on 26/11/2021 by Kiều Nga:Bổ sung lưu thông tin duyệt chi tiết (DHM,PBG,DHB)
--- Modified on 12/01/2022 by Nhật Thanh:Bổ sung điều kiện xét duyệt theo type = 'YCMH'
--- Modified on 17/03/2022 by Hoài Bảo:Bổ sung duyệt Phiếu yêu cầu nhập kho - xuất kho - yêu cầu vận chuyển nội bộ (YCNK - YCXK - YCVCNB)
--- Modified on 07/04/2022 by Hoài Bảo:Fix lỗi syntax YCNK - YCXK - YCVCNB.
--- Modified on 14/05/2022 by Kiều Nga:Bổ sung duyệt Văn bản đi, Văn bản đến (CSG).
--- Modified on 20/05/2022 by Kiều Nga:Bổ sung kiểm tra cần ký số Văn bản đi, Văn bản đến (CSG).
--- Modified on 06/09/2022 by Đức Tuyên: Bổ sung duyệt Đề nghị thu/chi ('DNT','DNC').
--- Modified on 31/03/2023 by Anh Đô: Bổ sung check lưu thông tin duyệt chi tiết Yêu cầu báo giá ('BGNCC')
--- Modified on 05/04/2023 by Thanh Lượng: Bổ sung duyệt Quản lý chất lượng ca (QLCLC).
--- Modified on 13/04/2023 by Hoài Thanh: Bổ sung duyệt Đơn hàng Sell out.
--- Modified on 12/05/2023 by Thanh Lượng: Bổ sung duyệt chương trình khuyến mãi theo điều kiện(KMTDK).
--- Modified on 19/06/2023 by Xuân Nguyên:[Liễn Quán][2023/06/IS/0145] Bổ sung điều kiện APK khi join OOT9001.
--- Modified on 28/06/2023 by Thanh Lượng: Bổ sung duyệt Bản giá báng SELL-IN(BGSI).
--- Modified on 12/07/2023 by Thanh Lượng: Bổ sung duyệt Kế hoạch doanh số (SELL IN)(KHDSSI).
--- Modified on 25/07/2023 by Thanh Lượng: Bổ sung duyệt Kế hoạch doanh số (SELL OUT)(KHDSSO).
--- Modified on 12/09/2023 by Nhật Thanh: Xóa ví chiết khấu khi từ chối duyệt đơn hàng bán
--- Modified on 20/09/2023 by Hoàng Lâm: Fix lỗi khi duyệt hàng loạt đơn hàng + tách chuỗi câu query
--- Modified on 30/10/2023 by Thúy Trâm: Cập nhật trạng thái duyệt cho phiếu QLCL



/*
   exec OOP2052 @DivisionID=N'MK',@UserID=N'ADMIN',
   @APKList=N'3d3282f8-1d86-4cb6-bccd-25343be2a2e0',@NextApprovePersonID=N''
   ,@IsSearch=0,@IsCheckALL=0,@ID=N'',@DepartmentID=N'',@CreateUserID=N'',@SectionID=N'',
   @SubsectionID=N'',@ProcessID=N'',@Type=N'',@Status=Null,@ApprovePersonNote=N'',
   @ApprovePersonStatus=1,@TranMonth=2,@TranYear=2016,@PageNumber=0,@PageSize=0
*/
CREATE PROCEDURE OOP2052
( 
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@TranMonth INT,
	@TranYear INT,
	@PageNumber INT,
	@PageSize INT,
	@IsSearch TINYINT,
	@ID VARCHAR(50),
	@CreateUserID VARCHAR(50),
	@DepartmentID VARCHAR(50),
	@SectionID VARCHAR(50),
	@SubsectionID VARCHAR(50),
	@ProcessID VARCHAR(50),
	@Status NVARCHAR(50),
	@Type VARCHAR(50),
	@NextApprovePersonID VARCHAR(50),
	@IsCheckALL TINYINT=0, --- 1: CheckAll
	@APKList VARCHAR(MAX),
	@ApprovePersonStatus TINYINT, -- Biến duyệt ở trong
	@ApprovePersonNote NVARCHAR(500), -- Ghi chú duyệt ở trong
	@LoginDate DATETIME	= ''--- Ngày làm việc khi đăng nhập hệ thống
)
AS 
DECLARE @sSQL VARCHAR (MAX) = '',
		@sSQL1 VARCHAR (MAX) = '',
		@sSQL11 VARCHAR (MAX) = '',
		@sSQL12 VARCHAR (MAX) = '',
		@sSQL2 NVARCHAR (MAX) = '',
		@sSQL3 NVARCHAR (MAX) = '',
		@sSQL21 NVARCHAR(MAX) = '',
        @sWhere VARCHAR(MAX) = '',
        @sWhere1 VARCHAR(MAX) = '',
		@APKcondition VARCHAR(MAX)=''

IF OBJECT_ID('tempdb..#Approve') IS NOT NULL DROP TABLE #Approve
CREATE TABLE #Approve (ApprovingLevel INT,ApproveLevel INT) 

--IF @IsSearch = 1
--BEGIN
	IF @ID IS NOT NULL SET @sWhere = @sWhere + '
	AND ISNULL(OOT90.ID,'''') LIKE ''%'+@ID+'%'' '
	IF @CreateUserID IS NOT NULL SET @sWhere = @sWhere + '
	AND OOT90.CreateUserID LIKE ''%'+@CreateUserID+'%'' '
	IF @DepartmentID IS NOT NULL SET @sWhere = @sWhere + '
	AND ISNULL(OOT90.DepartmentID,'''') LIKE ''%'+@DepartmentID+'%'' '
	IF @SectionID IS NOT NULL SET @sWhere = @sWhere + '
	AND ISNULL(OOT90.SectionID,'''') LIKE ''%'+@SectionID+'%'' '
	IF @SubsectionID IS NOT NULL SET @sWhere = @sWhere + '
	AND ISNULL(OOT90.SubsectionID,'''') LIKE ''%'+@SubsectionID+'%'' '
	IF @ProcessID IS NOT NULL SET @sWhere = @sWhere + '
	AND ISNULL(OOT90.ProcessID,'''') LIKE ''%'+@ProcessID+'%'' '
	IF @Status IS NOT NULL SET @sWhere = @sWhere + '
	AND ISNULL(LTRIM(OOT91.Status),'''') LIKE ''%'+@Status+'%'' '
	--IF @NextApprovePersonID IS NOT NULL SET @sWhere = @sWhere + '
	--AND ISNULL(OOT911.ApprovePersonID,'''') LIKE ''%'+@NextApprovePersonID+'%'' '
	IF @Type IS NOT NULL SET @sWhere = @sWhere + '
	AND ISNULL(OOT90.Type,'''') LIKE ''%'+@Type+'%'' '
--END
IF @IsCheckALL=0 SET @sWhere1='AND CONVERT(VARCHAR(50),OOT90.APK) IN ('''+@APKList+''')'

IF(select CustomerName from CustomerIndex) = 105 ---Liễn Quán
BEGIN
	SET @APKcondition='AND OOT912.APK = OOT91.APK'
END

SET @sSQL ='
--Tạo bảng tạm chứa dữ liệu message cảnh báo
SELECT CONVERT(VARCHAR(50),'''') MessageID,CONVERT(TINYINT,0) [Status],CONVERT(VARCHAR(50),'''') Params,CONVERT(VARCHAR(50),'''') APKMaster
INTO #Message
--xóa dòng rỗng
DELETE #Message
	DECLARE @Cur CURSOR,
			@APKMaster VARCHAR(50),
			@Type VARCHAR(50),
			@APK VARCHAR(50),
			@APKDetail VARCHAR(50),
			@Level INT,
			@ApprovingLevel INT,
			@AppoveLevel  INT,
			@Table VARCHAR(50),
			@TableMaster VARCHAR(50) ='''',
			@sSQL NVARCHAR(MAX)='''',
			@DivisionID VARCHAR(50),
			@Month INT,
			@Year INT

	IF EXISTS (SELECT TOP 1 1 FROM OOT2052)
	BEGIN
		DELETE OOT2052
	END
	
	INSERT INTO OOT2052 (DivisionID,APKMaster,[Type],APK,APKDetail,[Level],UserID)
	SELECT OOT90.DivisionID,OOT91.APKMaster,OOT90.Type,OOT91.APK,OOT91.APKDetail,OOT91.Level,'''+@UserID+''' AS UserID
	FROM OOT9000 OOT90 WITH (NOLOCK)
	INNER JOIN OOT9001 OOT91 WITH (NOLOCK) ON OOT91.DivisionID = OOT90.DivisionID AND OOT91.APKMaster = OOT90.APK
	--LEFT JOIN OOT9001 OOT911 WITH (NOLOCK) ON OOT911.DivisionID = OOT91.DivisionID AND OOT911.APKMaster = OOT91.APKMaster AND OOT911.APKDetail = OOT91.APKDetail AND OOT911.[Level] = OOT91.[Level]+1
	LEFT JOIN OOT9001 OOT912 WITH (NOLOCK) ON OOT912.DivisionID = OOT91.DivisionID AND OOT912.APKMaster = OOT91.APKMaster AND OOT912.APKDetail = OOT91.APKDetail AND OOT912.[Level] = OOT91.[Level]-1 '+@APKcondition+'
	WHERE OOT91.DivisionID ='''+@DivisionID+'''
	AND ISNULL(OOT90.DeleteFlag,0)=0
	AND ISNULL(OOT912.[Status],0) <> 2
	AND OOT91.ApprovePersonID = '''+@UserID+'''
	'+@sWhere+'
	'+@sWhere1+' 
	'


SET @sSQL1 = 'SET @Cur = CURSOR SCROLL KEYSET FOR
			SELECT	OOT2052.DivisionID,OOT2052.APKMaster,OOT2052.APKDetail,OOT2052.Type,OOT2052.APK,OOT2052.Level,
					OOT9000.TranMonth, OOT9000.TranYear
			FROM OOT2052 WITH (NOLOCK)
			LEFT JOIN OOT9000 WITH (NOLOCK) ON OOT2052.APKMaster = OOT9000.APK
			ORDER BY OOT2052.APKMaster,OOT2052.Level
OPEN @Cur
FETCH NEXT FROM @Cur INTO @DivisionID,@APKMaster,@APKDetail,@Type,@APK,@Level,@Month, @Year
WHILE @@FETCH_STATUS = 0
BEGIN
	--kiem tra bang thuoc nghiep vu nao
	IF @Type=''BPC''
		SET @Table=''OOT2000''
	ELSE IF @Type=''DXP''
		SET @Table=''OOT2010''
	ELSE IF @Type=''DXRN''
		SET @Table=''OOT2020''
	ELSE IF @Type=''DXLTG''
		SET @Table=''OOT2030''
	ELSE IF @Type=''DXBSQT''
		SET @Table=''OOT2040''
	ELSE IF @Type=''DXDC''
		SET @Table=''OOT2070''
	ELSE IF @Type=''QDTD''
		SET @Table=''HRMT2051''
	ELSE IF @Type=''BGNCC''
	   BEGIN
		SET @Table=''POT2022''
		SET @TableMaster=''POT2021''
	   END
	ELSE IF @Type=''PBG'' OR @Type=''PBGNC'' OR @Type=''PBGKHCU'' OR @Type=''PBGSALE''
		BEGIN
		SET @Table=''OT2102''
		SET @TableMaster=''OT2101''
		END
	ELSE IF @Type=''YCMH''
		BEGIN
		SET @Table=''OT3102''
		SET @TableMaster=''OT3101''
		END
	ELSE IF @Type=''DMDA''
		BEGIN
		SET @Table=''OOT2141''
		SET @TableMaster=''OOt2140''
		END
	ELSE IF @Type=''DHB'' OR @Type=''DHB-SELLOUT''
		BEGIN
		SET @Table=''OT2002''
		SET @TableMaster=''OT2001''
		END
	ELSE IF @Type=''DHDC''
		BEGIN
		SET @Table=''OT2007''
		SET @TableMaster=''OT2006''
		END
	ELSE IF @Type=''DT''
		BEGIN
		SET @Table=''CRMT2114''
		SET @TableMaster=''CRMT2110''
		END
	ELSE IF @Type=''CH''
		BEGIN
		SET @Table=''CRMT20501''
		SET @TableMaster=''CRMT20501''
		END
	ELSE IF @Type=''TTDL''
		BEGIN
		SET @Table=''BEMT2020''
		SET @TableMaster=''BEMT2020''
		END
	ELSE IF @Type=''TGCT''
		BEGIN
		SET @Table=''BEMT2030''
		SET @TableMaster=''BEMT2030''
		END
	ELSE IF @Type=''BCCT''
		BEGIN
		SET @Table=''BEMT2040''
		SET @TableMaster=''BEMT2040''
		END
	ELSE IF @Type=''DCT''
		BEGIN
		SET @Table=''BEMT2050''
		SET @TableMaster=''BEMT2050''
		END
	ELSE IF @Type=''DNCT''
		BEGIN
		SET @Table=''BEMT2010''
		SET @TableMaster=''BEMT2010''
		END
	ELSE IF @Type=''PDN''
		BEGIN
		SET @Table=''BEMT2001''
		SET @TableMaster=''BEMT2000''
		END
	ELSE IF @Type=''DHM''
		BEGIN
		SET @Table=''OT3002''
		SET @TableMaster=''OT3001''
		END
	ELSE IF @Type=''KHTD''
		BEGIN
		SET @Table=''HRMT2000''
		SET @TableMaster=''HRMT2000''
		END
	ELSE IF @Type=''TTSX''
		BEGIN
		SET @Table=''SOT2082''
		SET @TableMaster=''SOT2080''
		END
	ELSE IF @Type=''DCTT''
		BEGIN
		SET @Table=''HRMT2170''
		SET @TableMaster=''HRMT2170''
		END
	ELSE IF @Type=''DTCP''
		BEGIN
		SET @Table=''OT2201''
		SET @TableMaster=''OT2201''
		END	
	ELSE IF @Type=''BTG''
		BEGIN
		SET @Table=''SOT2110''
		SET @TableMaster=''SOT2110''
		END
	ELSE IF @Type=''PBGKD''
		BEGIN
		SET @Table=''SOT2120''
		SET @TableMaster=''SOT2120''
		END	
	ELSE IF @Type IN (''YCNK'',''YCXK'',''YCVCNB'')
		BEGIN
		SET @Table=''WT0095''
		SET @TableMaster=''WT0095''
		END	
	ELSE IF @Type IN (''VBDEN'',''VBDI'')
		BEGIN
		SET @Table=''OOT2341''
		SET @TableMaster=''OOT2340''
		END
	ELSE IF @Type IN (''DNT'',''DNC'')
		BEGIN
		SET @Table=''AT9010''
		SET @TableMaster=''AT9010''
		END
	ELSE IF @Type IN (''QLCLC'')
        BEGIN
        SET @Table=''QCT2000''
        SET @TableMaster=''QCT2000''
        END
	ELSE IF @Type IN (''KMTDK'')
        BEGIN
        SET @Table=''CIT1220''
        SET @TableMaster=''CIT1220''
        END
	ELSE IF @Type IN (''BGSI'')
        BEGIN
        SET @Table=''OT1301''
        SET @TableMaster=''OT1301''
        END
	ELSE IF @Type IN (''KHDSSI'')
        BEGIN
        SET @Table=''AT0161''
        SET @TableMaster=''AT0161''
        END
	ELSE IF @Type IN (''KHDSSO'')
        BEGIN
        SET @Table=''AT0161''
        SET @TableMaster=''AT0161''
        END

	IF(ISNULL(@APKDetail,''00000000-0000-0000-0000-000000000000'') = ''00000000-0000-0000-0000-000000000000'') 
		SET @APKDetail = ''00000000-0000-0000-0000-000000000000''
	INSERT INTO #Message(MessageID,Status,Params,APKMaster) 
	EXEC OOP2058 @DivisionID,'''+@UserID+''',@APKMaster,@APK,@Type,'+STR(@ApprovePersonStatus)+',@APKDetail,@Table
	
	--- Kiem tra phep am
	IF @Type = ''DXP'' and (SELECT CustomerName FROM CustomerIndex) = 81
	BEGIN
		DECLARE @EmployeeID VARCHAR(50),
				@AbsentTypeID VARCHAR(50),
				@LeaveFromDate DATETIME,
				@LeaveToDate DATETIME,
				@DaysRemained DECIMAL(8,2),
				@OTLeaveDaysRemained DECIMAL(8,2)

		SELECT @EmployeeID = EmployeeID, @AbsentTypeID = AbsentTypeID, @LeaveFromDate = LeaveFromDate, @LeaveToDate = LeaveToDate
		FROM OOT2010 WITH (NOLOCK)
		WHERE DivisionID = @DivisionID AND APKMaster = @APKMaster

		IF OBJECT_ID(''tempdb..#HRMP2111'') IS NOT NULL DROP TABLE #HRMP2111
		IF OBJECT_ID(''tempdb..#HRMP2112'') IS NOT NULL DROP TABLE #HRMP2112

		CREATE TABLE #HRMP2111 (DaysRemained DECIMAL(8,2), OTLeaveDaysRemained DECIMAL(8,2))
		CREATE TABLE #HRMP2112 (Status TINYINT, Params VARCHAR(50), Message VARCHAR(50))

		INSERT INTO #HRMP2111 (DaysRemained, OTLeaveDaysRemained)
		EXEC HRMP2111 @DivisionID, ' + LTRIM(@TranMonth) + ', ' + LTRIM(@TranYear) + ', @EmployeeID, ''' + CONVERT(VARCHAR(10),@LoginDate,101) + '''
		SELECT @DaysRemained = DaysRemained, @OTLeaveDaysRemained = OTLeaveDaysRemained FROM #HRMP2111
		
		DECLARE @sXML XML
		SET @sXML = ''<Data> 
						<EmployeeID>''+@EmployeeID+''</EmployeeID>
						<AbsentTypeID>''+@AbsentTypeID+''</AbsentTypeID>
						<LeaveFromDate>''+CONVERT(VARCHAR(50),@LeaveFromDate)+''</LeaveFromDate>
						<LeaveToDate>''+CONVERT(VARCHAR(50),@LeaveToDate)+''</LeaveToDate>
						<DaysRemained>''+CONVERT(VARCHAR(50),@DaysRemained)+''</DaysRemained>
						<OTLeaveDaysRemained>''+CONVERT(VARCHAR(50),@OTLeaveDaysRemained)+''</OTLeaveDaysRemained>
					</Data>''
		INSERT INTO #HRMP2112 (Status, Params, Message)
		EXEC HRMP2112 @DivisionID, @sXML
		--EXEC HRMP2112 @DivisionID, @EmployeeID, @AbsentTypeID, @LeaveFromDate, @LeaveToDate, @DaysRemained, @OTLeaveDaysRemained

		INSERT INTO #Message(MessageID,Status,Params,APKMaster)
		SELECT Message,Status,@EmployeeID, @APKMaster FROM #HRMP2112
	END
	'
 SET @sSQL11='
 	--- Kiem tra co check duyet ky so thi khong cho duyet
	IF @Type = ''VBDEN'' OR @Type = ''VBDI''
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM OOT2341 T1 WITH (NOLOCK) 
					INNER JOIN OOT2340 T2 WITH (NOLOCK) ON T1.APKMaster = T2.APK
					WHERE T2.APKMaster_9000 = @APKMaster AND T1.FollowerID = '''+@UserID+''' AND T1.UseESign = 1)
		BEGIN
			SELECT ''OOFML000269'' as MessageID,1 as Status,T2.DocumentID
			INTO #OOT2341
			FROM OOT2341 T1 WITH (NOLOCK)
			INNER JOIN OOT2340 T2 WITH (NOLOCK) ON T1.APKMaster = T2.APK
			WHERE T2.APKMaster_9000 = @APKMaster AND T1.FollowerID = '''+@UserID+''' AND T1.UseESign = 1

			INSERT INTO #Message(MessageID,Status,Params,APKMaster)
			SELECT MessageID,Status,DocumentID, @APKMaster FROM #OOT2341
		END
	END
	'

 SET @sSQL12='	
 	IF EXISTS (SELECT TOP 1 1 FROM #Message WHERE APKMaster=@APKMaster)
	BEGIN
		FETCH NEXT FROM @Cur INTO @DivisionID,@APKMaster,@APKDetail,@Type,@APK,@Level,@Month, @Year
		CONTINUE
	END
 
	DELETE #Approve
	--- lay so cap phai duyet va so cap dang duyet
	IF @Type = ''BPC''
	SET @sSQL=''
        INSERT INTO #Approve (ApprovingLevel, ApproveLevel)
		SELECT TOP 1 ApprovingLevel, ApproveLevel
		FROM ''+@Table+'' WITH (NOLOCK)
		WHERE DivisionID=''''''+@DivisionID+'''''' AND APKMaster=''''''+@APKMaster+''''''''
	ELSE IF @Type =''BGNCC'' OR @Type=''PBG'' OR @Type=''YCMH'' OR @Type=''DMDA'' OR @Type=''PBGNC'' OR @Type=''PBGKHCU'' 
			OR @Type=''PBGSALE'' OR @Type=''DHB'' OR @Type=''DHB-SELLOUT'' OR @Type=''DHDC'' OR @Type=''DT'' OR @Type=''CH'' OR @Type=''TTDL'' OR @Type=''TGCT''
			OR @Type=''BCCT'' OR @Type=''DCT'' OR @Type=''DNCT'' OR @Type=''PDN'' OR @Type=''DHM'' OR @Type=''TTSX'' OR @Type=''DTCP''  OR @Type=''BTG''  OR @Type=''PBGKD'' 
	   SET @sSQL='' INSERT INTO #Approve (ApprovingLevel, ApproveLevel)
		SELECT DISTINCT T2.Level as ApprovingLevel , T1.ApproveLevel
		FROM ''+@Table+'' T1 WITH (NOLOCK)
		LEFT JOIN OOT9001 T2 WITH (NOLOCK) ON T1.APKMaster_9000 = T2.APKMaster
		WHERE T1.DivisionID=''''''+@DivisionID+'''''' AND T1.APKMaster_9000=''''''+@APKMaster+''''''AND T2.APK =''''''+@APK+''''''''
	ELSE IF @Type =''DNT'' OR @Type=''DNC'' 
	   SET @sSQL='' INSERT INTO #Approve (ApprovingLevel, ApproveLevel)
		SELECT DISTINCT T2.Level as ApprovingLevel , T1.ApproveLevel
		FROM ''+@Table+'' T1 WITH (NOLOCK)
		LEFT JOIN OOT9001 T2 WITH (NOLOCK) ON T1.APKMaster_9000 = T2.APKMaster
		WHERE T1.Orders = 0 AND T1.DivisionID=''''''+@DivisionID+'''''' AND T1.APKMaster_9000=''''''+@APKMaster+''''''AND T2.APK =''''''+@APK+''''''''
	ELSE IF @Type = ''KHTD'' 
		SET @sSQL=''
		INSERT INTO #Approve (ApprovingLevel, ApproveLevel)
		SELECT ApprovingLevel, ApproveLevel
		FROM ''+@Table+'' WITH (NOLOCK)
		WHERE DivisionID=''''''+@DivisionID+'''''' AND APK=''''''+@APKMaster+''''''''
	ELSE IF @Type = ''DCTT'' 
		SET @sSQL=''
		INSERT INTO #Approve (ApprovingLevel, ApproveLevel)
		SELECT ApproveLevel, ApproveLevel
		FROM ''+@TableMaster+'' WITH (NOLOCK)
		WHERE DivisionID=''''''+@DivisionID+'''''' AND APK=''''''+@APKMaster+''''''''
	ELSE IF @Type = ''YCNK''
		SET @sSQL=''
		INSERT INTO #Approve (ApprovingLevel, ApproveLevel)
		SELECT ApprovingLevel, ApproveLevel
		FROM ''+@TableMaster+'' WITH (NOLOCK)
		WHERE DivisionID=''''''+@DivisionID+'''''' AND APKMaster_9000=''''''+@APKMaster+''''''''
	ELSE IF @Type = ''YCXK''
		SET @sSQL=''
		INSERT INTO #Approve (ApprovingLevel, ApproveLevel)
		SELECT ApprovingLevel, ApproveLevel
		FROM ''+@TableMaster+'' WITH (NOLOCK)
		WHERE DivisionID=''''''+@DivisionID+'''''' AND APKMaster_9000=''''''+@APKMaster+''''''''
	ELSE IF @Type = ''YCVCNB''
		SET @sSQL=''
		INSERT INTO #Approve (ApprovingLevel, ApproveLevel)
		SELECT ApprovingLevel, ApproveLevel
		FROM ''+@TableMaster+'' WITH (NOLOCK)
		WHERE DivisionID=''''''+@DivisionID+'''''' AND APKMaster_9000=''''''+@APKMaster+''''''''
	ELSE IF @Type = ''VBDEN'' OR  @Type = ''VBDI''
		SET @sSQL=''
		INSERT INTO #Approve (ApprovingLevel, ApproveLevel)
		SELECT T2.Level, T1.AppoveLevel
		FROM OOT9000 T1 WITH (NOLOCK)
		LEFT JOIN OOT9001 T2 WITH (NOLOCK) ON T1.APK = T2.APKMaster
		WHERE T1.DivisionID=''''''+@DivisionID+'''''' AND T2.APK=''''''+@APK+''''''''
	ELSE IF @Type =''QLCLC''
           SET @sSQL='' INSERT INTO #Approve (ApprovingLevel, ApproveLevel)
                SELECT DISTINCT T2.Level as ApprovingLevel , T1.ApproveLevel
                FROM ''+@Table+'' T1 WITH (NOLOCK)
                LEFT JOIN OOT9001 T2 WITH (NOLOCK) ON T1.APKMaster_9000 = T2.APKMaster
                WHERE T1.DivisionID=''''''+@DivisionID+'''''' AND T1.APKMaster_9000=''''''+@APKMaster+''''''AND T2.APK =''''''+@APK+''''''''
	ELSE IF @Type =''KMTDK''
           SET @sSQL='' INSERT INTO #Approve (ApprovingLevel, ApproveLevel)
                SELECT DISTINCT T2.Level as ApprovingLevel , T1.ApproveLevel
                FROM ''+@Table+'' T1 WITH (NOLOCK)
                LEFT JOIN OOT9001 T2 WITH (NOLOCK) ON T1.APKMaster_9000 = T2.APKMaster
                WHERE T1.DivisionID=''''''+@DivisionID+'''''' AND T1.APKMaster_9000=''''''+@APKMaster+''''''AND T2.APK =''''''+@APK+''''''''
	ELSE IF @Type =''BGSI''
           SET @sSQL='' INSERT INTO #Approve (ApprovingLevel, ApproveLevel)
                SELECT DISTINCT T2.Level as ApprovingLevel , T1.ApproveLevel
                FROM ''+@Table+'' T1 WITH (NOLOCK)
                LEFT JOIN OOT9001 T2 WITH (NOLOCK) ON T1.APKMaster_9000 = T2.APKMaster
                WHERE T1.DivisionID=''''''+@DivisionID+'''''' AND T1.APKMaster_9000=''''''+@APKMaster+''''''AND T2.APK =''''''+@APK+''''''''
	ELSE IF @Type =''KHDSSI''
           SET @sSQL='' INSERT INTO #Approve (ApprovingLevel, ApproveLevel)
                SELECT DISTINCT T2.Level as ApprovingLevel , T1.ApproveLevel
                FROM ''+@Table+'' T1 WITH (NOLOCK)
                LEFT JOIN OOT9001 T2 WITH (NOLOCK) ON T1.APKMaster_9000 = T2.APKMaster
                WHERE T1.DivisionID=''''''+@DivisionID+'''''' AND T1.APKMaster_9000=''''''+@APKMaster+''''''AND T2.APK =''''''+@APK+''''''''
	ELSE IF @Type =''KHDSSO''
           SET @sSQL='' INSERT INTO #Approve (ApprovingLevel, ApproveLevel)
                SELECT DISTINCT T2.Level as ApprovingLevel , T1.ApproveLevel
                FROM ''+@Table+'' T1 WITH (NOLOCK)
                LEFT JOIN OOT9001 T2 WITH (NOLOCK) ON T1.APKMaster_9000 = T2.APKMaster
                WHERE T1.DivisionID=''''''+@DivisionID+'''''' AND T1.APKMaster_9000=''''''+@APKMaster+''''''AND T2.APK =''''''+@APK+''''''''
        ELSE
		SET @sSQL=''
        INSERT INTO #Approve (ApprovingLevel, ApproveLevel)
		SELECT ApprovingLevel, ApproveLevel
		FROM ''+@Table+'' WITH (NOLOCK)
		WHERE DivisionID=''''''+@DivisionID+'''''' AND APKMaster=''''''+@APKMaster+'''''' AND APK = ''''''+@APKDetail+''''''''

		EXEC (@sSQL)
		--PRINT (@sSQL)'

SET @sSQL2=N'
	IF @Level=(SELECT ApprovingLevel FROM #Approve)+1 OR  @Level=(SELECT ApprovingLevel FROM #Approve)
	BEGIN	

		--- Cập nhật bảng OOT9001
		UPDATE OOT9001
		SET [Status] = '+STR(@ApprovePersonStatus)+',
		Note=N'''+@ApprovePersonNote+'''
		WHERE DivisionID=@DivisionID
		AND APK=@APK
		AND APKMaster=@APKMaster

		--- Cập nhật bảng OOT9000
		UPDATE OOT9000 SET LastModifyUserID = '''+@UserID+''',LastModifyDate=GETDATE()
		FROM OOT9000 OOT90 WITH (NOLOCK)
		WHERE OOT90.DivisionID=@DivisionID 
		AND OOT90.APK=@APKMaster
		
		IF @Type = ''BPC''
		BEGIN
			SET @sSQL='' UPDATE ''+@Table+'' SET
			Status='+STR(CASE WHEN ISNULL(@ApprovePersonStatus,0)=1 THEN 1 ELSE 0 END) +'
			WHERE DivisionID='''''+@DivisionID+'''''
			AND APKMaster=''''''+@APKMaster+''''''

			UPDATE ''+@Table+'' SET
			ApprovingLevel= ''+CONVERT(VARCHAR(5),@Level)+''
			WHERE DivisionID='''''+@DivisionID+'''''
			AND APKMaster=''''''+@APKMaster+''''''''

		END
		ELSE IF @Type = ''DTCP''
		BEGIN
			SET @sSQL='' UPDATE ''+@Table+'' SET
			StatusID='+STR(CASE WHEN ISNULL(@ApprovePersonStatus,0)=1 THEN 1 ELSE 0 END) +'
			WHERE DivisionID='''''+@DivisionID+'''''
			AND APKMaster_9000=''''''+@APKMaster+''''''

			UPDATE ''+@Table+'' SET
			ApprovingLevel= ''+CONVERT(VARCHAR(5),@Level)+''
			WHERE DivisionID='''''+@DivisionID+'''''
			AND APKMaster_9000=''''''+@APKMaster+''''''''

		END
		ELSE IF @Type=''YCMH''
		BEGIN
			SET @sSQL='' UPDATE ''+@Table+'' SET
			Status='+STR(CASE WHEN ISNULL(@ApprovePersonStatus,0)=1 THEN 1 ELSE 0 END) +',
			ApprovingLevel= ''+CONVERT(VARCHAR(5),@Level)+''
			WHERE DivisionID='''''+@DivisionID+'''''
			AND APKMaster_9000=''''''+@APKMaster+''''''

			 UPDATE ''+@TableMaster+'' SET
			Status='+STR(CASE WHEN ISNULL(@ApprovePersonStatus,0)=1 THEN 1 ELSE 0 END) +'
			WHERE DivisionID='''''+@DivisionID+'''''
			AND APKMaster_9000=''''''+@APKMaster+''''''''

		END'

		SET @sSQL21 = '
		ELSE IF @Type = ''BGNCC'' OR @Type=''PBG'' OR @Type=''DMDA'' OR @Type=''PBGNC'' OR @Type=''PBGKHCU'' 
				OR @Type=''PBGSALE'' OR @Type=''DHB'' OR @Type=''DHB-SELLOUT'' OR @Type=''DHDC'' OR @Type=''DT'' OR @Type=''TTDL'' OR @Type=''TGCT''
				OR @Type=''BCCT'' OR @Type=''DCT'' OR @Type=''DNCT'' OR @Type=''DCT'' OR @Type=''PDN'' OR @Type=''DHM'' OR @Type=''TTSX'' OR @Type=''DNT'' OR @Type=''DNC'' 
			   OR @Type=''KMTDK''OR @Type=''BGSI'' OR @Type=''KHDSSI'' OR @Type=''KHDSSO''
		BEGIN
			SET @sSQL='' UPDATE ''+@Table+'' SET
			Status='+STR(CASE WHEN ISNULL(@ApprovePersonStatus,0)=1 THEN 1 ELSE 0 END) +'
			WHERE DivisionID='''''+@DivisionID+'''''
			AND APKMaster_9000=''''''+@APKMaster+''''''

			UPDATE ''+@Table+'' SET
			ApprovingLevel= ''+CONVERT(VARCHAR(5),@Level)+''
			WHERE DivisionID='''''+@DivisionID+'''''
			AND APKMaster_9000=''''''+@APKMaster+''''''
			IF ''''''+ISNULL(@Type,'''''''')+'''''' IN (''''DHB'''',''''DHB-SELLOUT'''') AND '+STR(@ApprovePersonStatus)+' = 2
			BEGIN
				DELETE CIT1530 
				FROM CIT1530
				LEFT JOIN OT2001 ON CIT1530.SOrderID = OT2001.VoucherNo
				WHERE OT2001.DivisionID='''''+@DivisionID+'''''
				AND OT2001.APKMaster_9000 = ''''''+@APKMaster+''''''
			END''
		END
		ELSE IF @Type = ''QLCLC''
		 BEGIN
				SET @sSQL='' UPDATE ''+@Table+'' SET
				StatusSS='+STR(CASE WHEN ISNULL(@ApprovePersonStatus,0)=1 THEN 1 ELSE 0 END) +'
				WHERE DivisionID='''''+@DivisionID+'''''
				AND APKMaster_9000=''''''+@APKMaster+''''''

				UPDATE ''+@Table+'' SET
				ApprovingLevel= ''+CONVERT(VARCHAR(5),@Level)+''
				WHERE DivisionID='''''+@DivisionID+'''''
				AND APKMaster_9000=''''''+@APKMaster+''''''
				IF ''''''+ISNULL(@Type,'''''''')+'''''' IN (''''DHB'''',''''DHB-SELLOUT'''') AND '+STR(@ApprovePersonStatus)+' = 2
				BEGIN
					DELETE CIT1530 
					FROM CIT1530
					LEFT JOIN OT2001 ON CIT1530.SOrderID = OT2001.VoucherNo
					WHERE OT2001.DivisionID='''''+@DivisionID+'''''
					AND OT2001.APKMaster_9000 = ''''''+@APKMaster+''''''
				END''
		END
	   ELSE IF @Type = ''DCTT''
		BEGIN
		SET @sSQL='' UPDATE ''+@TableMaster+'' SET
			Status='+STR(CASE WHEN ISNULL(@ApprovePersonStatus,0)=1 THEN 1 ELSE 0 END) +'
			WHERE DivisionID='''''+@DivisionID+'''''
			AND APK=''''''+@APKMaster+''''''

			UPDATE ''+@TableMaster+'' SET
			ApprovingLevel= ''+CONVERT(VARCHAR(5),@Level)+''
			WHERE DivisionID='''''+@DivisionID+'''''
			AND APK=''''''+@APKMaster+''''''''
		END
		ELSE IF @Type = ''KHTD''
		BEGIN
		-- Master
			UPDATE OOT9001 SET Status ='+STR(CASE WHEN ISNULL(@ApprovePersonStatus,0)=1 THEN 1 ELSE 0 END) +' WHERE APKMaster = @APKMaster --AND ApprovePersonID = @UserID
            UPDATE HRMT2000
            SET Status = '+STR(CASE WHEN ISNULL(@ApprovePersonStatus,0)=1 THEN 1 ELSE 0 END) +',  ApprovingLevel = O1.Level
            FROM HRMT2000 B1 WITH (NOLOCK)
                INNER JOIN OOT9001 O1 WITH (NOLOCK) ON O1.APKMaster = B1.APK
            WHERE B1.APK = @APKMaster --AND O1.ApprovePersonID = @UserID
		    IF NOT EXISTS (SELECT Top 1 1 FROM OOT9001 where Status = 0 AND APKMaster = @APKMaster )
		    UPDATE OOT9000 SET Status = 1, ApprovingLevel = AppoveLevel WHERE APK = @APKMaster 

			SET @sSQL='' UPDATE ''+@Table+'' SET
			Status= '+STR(CASE WHEN ISNULL(@ApprovePersonStatus,0)=1 THEN 1 ELSE 0 END) +'
			WHERE DivisionID='''''+@DivisionID+'''''
			AND APK=''''''+@APKMaster+'''''' 

			UPDATE ''+@Table+'' SET
			ApprovingLevel= ''+CONVERT(VARCHAR(5),@Level)+''
			WHERE DivisionID='''''+@DivisionID+'''''
			AND APK =''''''+@APKMaster+''''''''
		END
		ELSE IF @Type = ''BTG''
		BEGIN
			SET @sSQL=''
			UPDATE ''+@Table+'' SET
			ApprovingLevel= ''+CONVERT(VARCHAR(5),@Level)+''
			WHERE DivisionID='''''+@DivisionID+'''''
			AND APKMaster_9000=''''''+@APKMaster+''''''''
		END
		ELSE IF @Type = ''PBGKD''
		BEGIN
			SET @sSQL=''
			UPDATE ''+@Table+'' SET
			ApprovingLevel= ''+CONVERT(VARCHAR(5),@Level)+''
			WHERE DivisionID='''''+@DivisionID+'''''
			AND APKMaster_9000=''''''+@APKMaster+''''''''
		END'
		
SET @sSQL3 = N'
		ELSE IF @Type = ''YCNK''
		BEGIN
			SET @sSQL='' UPDATE ''+@Table+'' SET
			IsCheck='+STR(CASE WHEN ISNULL(@ApprovePersonStatus,0)=1 THEN 1 ELSE 0 END) +'
			, ApprovingLevel= ''+CONVERT(VARCHAR(5),@Level)+''
			WHERE DivisionID='''''+@DivisionID+'''''
			AND APKMaster_9000=''''''+@APKMaster+''''''''
		END
		ELSE IF @Type = ''YCXK''
		BEGIN
			SET @sSQL='' UPDATE ''+@Table+'' SET
			IsCheck='+STR(CASE WHEN ISNULL(@ApprovePersonStatus,0)=1 THEN 1 ELSE 0 END) +'
			, ApprovingLevel= ''+CONVERT(VARCHAR(5),@Level)+''
			WHERE DivisionID='''''+@DivisionID+'''''
			AND APKMaster_9000=''''''+@APKMaster+''''''''
		END
		ELSE IF @Type = ''YCVCNB''
		BEGIN
			SET @sSQL='' UPDATE ''+@Table+'' SET
			IsCheck='+STR(CASE WHEN ISNULL(@ApprovePersonStatus,0)=1 THEN 1 ELSE 0 END) +'
			, ApprovingLevel= ''+CONVERT(VARCHAR(5),@Level)+''
			WHERE DivisionID='''''+@DivisionID+'''''
			AND APKMaster_9000=''''''+@APKMaster+''''''''
		END
		ELSE IF @Type = ''VBDEN'' OR @Type = ''VBDI''
		BEGIN
			SET @sSQL=''''
		END
		ELSE IF @Type <> ''CH''
		BEGIN
			SET @sSQL='' UPDATE ''+@Table+'' SET
			Status= '+STR(CASE WHEN ISNULL(@ApprovePersonStatus,0)=1 THEN 1 ELSE 0 END) +'
			WHERE DivisionID='''''+@DivisionID+'''''
			AND APKMaster=''''''+@APKMaster+''''''
			AND APK = ''''''+@APKDetail+'''''' 

			UPDATE ''+@Table+'' SET
			ApprovingLevel= ''+CONVERT(VARCHAR(5),@Level)+''
			WHERE DivisionID='''''+@DivisionID+'''''
			AND APKMaster=''''''+@APKMaster+''''''
			AND APK = ''''''+@APKDetail+''''''''

		END

		--- Lưu thông tin duyệt thông tin chi tiết 
		IF @Type IN (''DHM'',''PBG'',''DHB'',''BGNCC'',''DHB-SELLOUT'')	
		BEGIN
		    SET @sSQL= @sSQL + N'' DELETE FROM OOT9004 WHERE APK9001 = ''''''+@APK+''''''
			INSERT INTO OOT9004 (APKDetail, APK9001, DivisionID, ApprovePersonID, Level, Note, ApprovalDate, DeleteFlag,Status)
			SELECT APK as APKDetail,''''''+@APK+'''''','''''+@DivisionID+''''','''''+@UserID+''''',''+STR(@Level)+'','''''''',GETDATE(),0,'+LTRIM(STR(CASE WHEN ISNULL(@ApprovePersonStatus,0)=1 THEN 1 ELSE 0 END))+'
			FROM ''+@Table+'' WITH (NOLOCK) WHERE APKMaster_9000 = ''''''+@APKMaster+''''''''
		END
		
		EXEC (@sSQL)
		--PRINT @sSQL

		IF(ISNULL(@APKDetail,'''') = '''') 
			SET @APKDetail = NULL
		IF @Type <> ''KHTD''
		EXEC OOP2053 '''+@DivisionID+''','''+@UserID+''',@Month,@Year,@APKMaster,@APK,@Type,@APKDetail,@Table,@TableMaster,1
	END
	FETCH NEXT FROM @Cur INTO @DivisionID,@APKMaster,@APKDetail,@Type,@APK,@Level,@Month, @Year
END
CLOSE @Cur

SELECT TOP 1 [MessageID],[Status],
	(SUBSTRING((SELECT '',''+Params FROM #Message   FOR XML PATH ('''')), 2, 1000)) Params,
	(SUBSTRING((SELECT '',''+APKMaster FROM #Message   FOR XML PATH ('''')),2, 1000)) APKMasterList
FROM #Message
'

PRINT (@sSQL)
print('---------------------')
PRINT (@sSQL1)
print('---------------------')
PRINT (@sSQL11)
print('---------------------')
PRINT (@sSQL12)
print('---------------------')
PRINT (@sSQL2)
print('---------------------')
PRINT (@sSQL21)
print('---------------------')
PRINT (@sSQL3)
EXEC (@sSQL+@sSQL1+@sSQL11+@sSQL12+@sSQL2 +@sSQL21+@sSQL3)














GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
