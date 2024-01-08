IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0005]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0005]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Cập nhật dữ liệu phòng ban, chức vụ dựa trên nghiệp vụ thuyên chuyển (customize Meiko)
-- <Param>
---- TH đã lập quyết định thuyên chuyển nhưng chưa đến ngày hiệu lực
-- <Return>
---- 
-- <Reference> HRM\Nghiệp vụ QĐ thuyên chuyển
---- 
-- <History>
---- Create on 07/12/2017 by Trương Ngọc Phương Thảo
---- Modified on 04/09/2019 by Mỹ Tuyền: sửa lỗi không cập nhật được thông tin chức danh/chức vụ từ quyết định bổ nhiệm về hồ sơ nhân viên
---- Modified on 
-- <Example>
----  exec HP0005 @DivisionID,@UserID, @DecideNo
CREATE PROCEDURE HP0005 
(
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@DecideNo Varchar(50) = ''
)    
AS 
DECLARE @CurDecide CURSOR,
		@CurMonth CURSOR,
		@CurYear CURSOR,
		@MonthTableID VARCHAR(50),
		@YearTableID VARCHAR(50),
		@sSQL001 NVarchar(4000),
		@iMonthTotal INT,
		@iMonth INT,		
		@MaxEndDate Datetime,
		@sTranMonth VARCHAR(2)

--set @Employeeid = '000293'
--HT1302_MK
DECLARE @cDecideNo Varchar(50), @EmployeeID Varchar(50), @FromMonth Int, 
		@ToMonth Int, @FromYear Int, @ToYear Int, @DepartmentID Varchar(50), 
		@TeamID Varchar(50)

-- Lấy thông tin quyết định thuyên chuyển bộ phận mới nhất
SELECT T1.*
INTO	#HP0005_HT1302_Max
From HT1302_MK T1
INNER JOIN
(
Select  EmployeeID, Max(CreateDate) AS CreateDate
From	HT1302_MK
Where	DivisionID = @DivisionID AND DecideNo LIKE @DecideNo
Group by EmployeeID
) T2 ON T1.EmployeeID = T2.EmployeeID AND T1.CreateDate = T2.CreateDate
Where	DivisionID = @DivisionID
AND DecideNo LIKE @DecideNo

-- Lấy thông tin quyết định bổ nhiệm chức vụ mới nhất
SELECT T1.*
INTO	#HP0005_HT0362_Max
From HT0362 T1
INNER JOIN
(
Select  EmployeeID, Max(CreateDate) AS CreateDate
From	HT0362
Where	DivisionID = @DivisionID AND DecideNo LIKE @DecideNo
Group by EmployeeID
) T2 ON T1.EmployeeID = T2.EmployeeID AND T1.CreateDate = T2.CreateDate
Where	DivisionID = @DivisionID
AND DecideNo LIKE @DecideNo

Update T1 
Set T1.DepartmentID = T2.DepartmentID,
    T1.TeamID = T2.TeamID,
    T1.Ana02ID = T2.DepartmentID,
    T1.Ana03ID = T2.TeamID,
    T1.Ana04ID = T2.SectionID,
    T1.Ana05ID = T2.ProcessID
FROM HT1400 T1
INNER JOIN #HP0005_HT1302_Max T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID
WHERE Convert(Date,T2.FromDate) <= Convert(Date,GetDate()) AND Convert(Date,ISNULL(T2.ToDate,GetDate())) >= Convert(Date,GetDate())
AND T2.DivisionID = @DivisionID
AND T2.DecideNo LIKE @DecideNo
AND (ISNULL(T1.DepartmentID,'') <> ISNULL(T2.DepartmentID,'')
    OR ISNULL(T1.TeamID ,'')<>  ISNULL(T2.TeamID,'')
    OR ISNULL(T1.Ana02ID,'') <> ISNULL(T2.DepartmentID,'')
    OR ISNULL(T1.Ana03ID,'') <> ISNULL(T2.TeamID,'')
    OR ISNULL(T1.Ana04ID,'') <> ISNULL(T2.SectionID,'')
    OR ISNULL(T1.Ana05ID,'') <> ISNULL(T2.ProcessID,''))

UPDATE T1
SET	
	T1.DutyID = T2.NewDutyID,
    T1.TitleID = T2.NewDutyID
FROM HT1403 T1
INNER JOIN #HP0005_HT0362_Max T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID
WHERE Convert(Date,T2.EffectiveDate) <= Convert(Date,GetDate()) --AND Convert(Date,ISNULL(T2.EffectiveDate,GetDate())) >= Convert(Date,GetDate())
AND T2.DivisionID = @DivisionID
AND T2.DecideNo LIKE @DecideNo
AND (ISNULL(T1.DutyID ,'')<>  ISNULL(T2.NewDutyID,'')
	OR ISNULL(T1.TitleID ,'')<>  ISNULL(T2.NewDutyID,'')
	)

SELECT  top 1 @MaxEndDate = EndDate
FROM HT9999
ORDER BY TranYear desc, TranMonth desc

IF(@DecideNo = '%') -- Chạy khi mở module HRM
BEGIN
	IF EXISTS (SELECT TOP 1 1 FROM AT0001 WITH (NOLOCK) WHERE IsSplitTable = 1)	
	BEGIN
		SET @CurDecide = CURSOR SCROLL KEYSET FOR
		SELECT  T1.DecideNo, T1.EmployeeID, Month(FromDate), Year(FromDate), Month(CASE WHEN ToDate >= @MaxEndDate OR ToDate is null THEN @MaxEndDate ELSE ToDate END),
		Year(CASE WHEN ToDate >= @MaxEndDate OR ToDate is null THEN @MaxEndDate ELSE ToDate END), T1.DepartmentID, T1.TeamID
		FROM #HP0005_HT1302_Max	T1
		INNER JOIN HT1400 T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID
		WHERE Convert(Date,FromDate) <= Convert(Date,GetDate()) AND Convert(Date,ISNULL(T1.ToDate,GetDate())) >= Convert(Date,GetDate()) AND DecideNo LIKE @DecideNo
		AND (ISNULL(T1.DepartmentID,'') <> ISNULL(T2.DepartmentID,'')
			OR ISNULL(T1.TeamID ,'')<>  ISNULL(T2.TeamID,'')
			)
		OPEN @CurDecide
		FETCH NEXT FROM @CurDecide INTO  @cDecideNo, @EmployeeID, @FromMonth, @FromYear, @ToMonth, @ToYear, @DepartmentID, @TeamID
		WHILE @@FETCH_STATUS = 0
		BEGIN
	
			SELECT  @iMonthTotal = @ToMonth + 12 * (@ToYear - @FromYear),
					@iMonth = @FromMonth
								
			WHILE (@iMonth<=@iMonthTotal)
			BEGIN
				SELECT @sTranMonth = CASE WHEN @FromMonth >9 THEN Convert(Varchar(2),@FromMonth) ELSE '0'+Convert(Varchar(1),@FromMonth) END

				SET @sSQL001 = N'
				IF EXISTS (SELECT TOP 1 1 FROM SYSOBJECTS TAB WHERE TAB.Name =''HT2402M'+@sTranMonth+RTRIM(LTRIM(STR(@FromYear))) +''')
				BEGIN
					UPDATE T1
					SET	T1.DepartmentID= '''+@DepartmentID+''',
						T1.TeamID= '''+@TeamID+'''
					FROM HT2402M'+@sTranMonth+RTRIM(LTRIM(STR(@FromYear)))+' T1
					WHERE EmployeeID = '''+@EmployeeID+'''

				END
				'
				print @sSQL001
				EXEC(@sSQL001)
				IF(@FromMonth = 12)
				BEGIN
					SET @FromMonth = 1
					SET @FromYear = @FromYear +1
				END
				ELSE
					SET @FromMonth = @FromMonth+ 1

				SET @iMonth = @iMonth + 1
			END
			
		FETCH NEXT FROM @CurDecide INTO  @cDecideNo, @EmployeeID, @FromMonth, @FromYear, @ToMonth, @ToYear, @DepartmentID, @TeamID
		END
		Close @CurDecide
	END
END



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
