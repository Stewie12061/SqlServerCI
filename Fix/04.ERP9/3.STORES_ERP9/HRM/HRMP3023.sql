IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP3023]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP3023]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Báo cáo tình hình thay đổi lao động 6 tháng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
----Created by Kiều Nga on 04/12/2020
----Modify by Kiều Nga on 14/12/2020 : Fix lỗi đếm tổng số lao động đầu kỳ, bổ sung điều kiện lọc khi in báo cáo năm

-- <Example>
---- 
/*-- <Example>
	
----*/

CREATE PROCEDURE HRMP3023
( 
	 @DivisionID        NVARCHAR(50),
	 @DivisionIDList	NVARCHAR(MAX), -- Đơn vị
	 @UserID            NVARCHAR(50),
	 @Year			    INT,
	 @Period			INT, -- 1: 6 tháng đầu năm ,2 : 6 tháng cuối năm
	 @EmployeeID            NVARCHAR(50)
)
AS 
DECLARE @sSQL NVARCHAR(MAX) = N'',	
		@sWhere NVARCHAR(MAX) = N'',
		@TotalRow NVARCHAR(50) = N'',
        @OrderBy NVARCHAR(500) = N'',
		@BeginDate NVARCHAR(MAX) = N'',
		@EndDate NVARCHAR(MAX) = N''

IF @Period = 1
BEGIN
	SET @BeginDate = (SELECT CAST(RIGHT(FiscalBeginDate,2)+'/'+LEFT(FiscalBeginDate,2)+'/'+ LTRIM(@Year) AS  DATETIME) as BeginDate
							 FROM AT1101 WITH (NOLOCK) WHERE DivisionID = @DivisionIDList)

	SET @EndDate = (SELECT CASE WHEN CONVERT(INT,RIGHT(FiscalBeginDate,2)) + 6 > 12 
										THEN CAST(LTRIM(STR(CONVERT(INT,RIGHT(FiscalBeginDate,2)) + 6 - 12 ))+'/'+LEFT(FiscalBeginDate,2)+'/'+ LTRIM(@Year +1) AS  DATETIME)
										ELSE CAST(LTRIM(STR(CONVERT(INT,RIGHT(FiscalBeginDate,2)) + 6))  +'/'+LEFT(FiscalBeginDate,2)+'/'+ LTRIM(@Year) AS  DATETIME) END as EndDate
							 FROM AT1101 WITH (NOLOCK) WHERE DivisionID = @DivisionIDList)
END
ELSE
BEGIN
	SET @BeginDate = (SELECT CASE WHEN CONVERT(INT,RIGHT(FiscalBeginDate,2)) + 6 > 12 
										THEN CAST(LTRIM(STR(CONVERT(INT,RIGHT(FiscalBeginDate,2)) + 6 - 12 ))+'/'+LEFT(FiscalBeginDate,2)+'/'+ LTRIM(@Year +1) AS  DATETIME)
										ELSE CAST(LTRIM(STR(CONVERT(INT,RIGHT(FiscalBeginDate,2)) + 6))  +'/'+LEFT(FiscalBeginDate,2)+'/'+ LTRIM(@Year) AS  DATETIME) END as EndDate
							 FROM AT1101 WITH (NOLOCK) WHERE DivisionID = @DivisionIDList)

	SET @EndDate = (SELECT CAST(RIGHT(FiscalBeginDate,2)+'/'+LEFT(FiscalBeginDate,2)+'/'+ LTRIM(@Year + 1) AS  DATETIME) as BeginDate
							 FROM AT1101 WITH (NOLOCK) WHERE DivisionID = @DivisionIDList)
END

-- Số lao động đầu kỳ
SELECT Count(T1.EmployeeID) as TotalEmployee -- Tổng số 
,SUM(Case When T1.IsMale = 1 then 0 else 1 end) as TotalFemale -- Lao động nữ
,SUM(Case When T4.SpecialID = 'DH' then 1 else 0 end) as TotalDH -- Đại học trở lên
,SUM(Case When T4.SpecialID = 'CD' then 1 else 0 end) as TotalCD -- Cao đẳng / Cao đẳng nghề
,SUM(Case When T4.SpecialID = 'TC' then 1 else 0 end) as TotalTC -- Trung cấp / Trung cấp nghề
,SUM(Case When T4.SpecialID = 'SC' then 1 else 0 end) as TotalSC  -- Sơ cấp nghề
,SUM(Case When T4.SpecialID = 'DN' then 1 else 0 end) as TotalDN -- Dạy nghề thường xuyên
,SUM(Case When T4.SpecialID = 'CDT' then 1 else 0 end) as TotalCDT -- Chưa qua đào tạo
,SUM(Case When T5.ContractTypeID = 'KTH' then 1 else 0 end) as TotalKTH -- Không xác định thời hạn
,SUM(Case When T5.ContractTypeID = 'TH' then 1 else 0 end) as TotalTH -- Xác định thời hạn
,SUM(Case When T5.ContractTypeID = 'MV' then 1 else 0 end) as TotalMV -- Theo mùa vụ hoặc theo công việc nhất định dưới 12 tháng
FROM HT1400 T1 WITH (NOLOCK)
INNER JOIN HT1403 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID
INNER JOIN AT1101 T3 WITH (NOLOCK) ON T1.DivisionID = T3.DivisionID AND T2.FromApprenticeTime < @BeginDate
INNER JOIN HT1401 T4 WITH (NOLOCK) ON T1.DivisionID = T4.DivisionID AND T1.EmployeeID = T4.EmployeeID
LEFT JOIN HT1360 T5 WITH (NOLOCK) ON T1.DivisionID = T5.DivisionID AND T1.EmployeeID = T5.EmployeeID
LEFT JOIN HT1380 T6 WITH (NOLOCK) ON T1.DivisionID = T6.DivisionID AND T1.EmployeeID = T6.EmployeeID
WHERE T1.DivisionID = @DivisionIDList AND (T6.LeaveDate is null OR T6.LeaveDate >= @BeginDate )

---- Số lao động tăng trong kỳ
SELECT ROW_NUMBER() OVER (ORDER BY T1.EmployeeID) AS RowNum,T1.EmployeeID, T1.LastName +' '+ T1.MiddleName +' '+ T1.FirstName as EmployeeName
,Case When T1.IsMale = 1 then 'X' else '' end as Male -- Nam
,Case When T1.IsMale = 0 then 'X' else '' end as Female -- Nữ
,Case When T4.SpecialID = 'DH' then 'X' else '' end as DH -- Đại học trở lên
,Case When T4.SpecialID = 'CD' then 'X' else '' end as CD -- Cao đẳng / Cao đẳng nghề
,Case When T4.SpecialID = 'TC' then 'X' else '' end as TC -- Trung cấp / Trung cấp nghề
,Case When T4.SpecialID = 'SC' then 'X' else '' end as SC  -- Sơ cấp nghề
,Case When T4.SpecialID = 'DN' then 'X' else '' end as DN -- Dạy nghề thường xuyên
,Case When T4.SpecialID = 'CDT' then 'X' else ''end as CDT -- Chưa qua đào tạo
,Case When T5.ContractTypeID = 'KTH' then 'X' else '' end as KTH -- Không xác định thời hạn
,Case When T5.ContractTypeID = 'TH' then 'X' else '' end as TH -- Xác định thời hạn
,Case When T5.ContractTypeID = 'MV' then 'X' else '' end as MV -- Theo mùa vụ hoặc theo công việc nhất định dưới 12 tháng
,T2.TitleID,T7.TitleName  -- Vị trí việc làm
FROM HT1400 T1 WITH (NOLOCK)
INNER JOIN HT1403 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID
INNER JOIN AT1101 T3 WITH (NOLOCK) ON T1.DivisionID = T3.DivisionID AND @BeginDate <= T2.FromApprenticeTime AND T2.FromApprenticeTime < @EndDate
INNER JOIN HT1401 T4 WITH (NOLOCK) ON T1.DivisionID = T4.DivisionID AND T1.EmployeeID = T4.EmployeeID
LEFT JOIN HT1360 T5 WITH (NOLOCK) ON T1.DivisionID = T5.DivisionID AND T1.EmployeeID = T5.EmployeeID
LEFT JOIN HT1106 T7 WITH (NOLOCK) ON T2.DivisionID = T7.DivisionID AND T2.TitleID = T7.TitleID

-- Số lao động giảm trong kỳ
SELECT ROW_NUMBER() OVER (ORDER BY T1.EmployeeID) AS RowNum,T1.EmployeeID, T1.LastName +' '+ T1.MiddleName +' '+ T1.FirstName as EmployeeName
,Case When T1.IsMale = 1 then 'X' else '' end as Male -- Nam
,Case When T1.IsMale = 0 then 'X' else '' end as Female -- Nữ
,Case When T4.SpecialID = 'DH' then 'X' else '' end as DH -- Đại học trở lên
,Case When T4.SpecialID = 'CD' then 'X' else '' end as CD -- Cao đẳng / Cao đẳng nghề
,Case When T4.SpecialID = 'TC' then 'X' else '' end as TC -- Trung cấp / Trung cấp nghề
,Case When T4.SpecialID = 'DN' then 'X' else '' end as DN -- Sơ cấp nghề
,Case When T4.SpecialID = 'SC' then 'X' else '' end as SC  -- Dạy nghề thường xuyên
,Case When T4.SpecialID = 'CDT' then 'X' else ''end as CDT -- Chưa qua đào tạo
,Case When T5.ContractTypeID = 'KTH' then 'X' else '' end as KTH -- Không xác định thời hạn
,Case When T5.ContractTypeID = 'TH' then 'X' else '' end as TH -- Xác định thời hạn
,Case When T5.ContractTypeID = 'MV' then 'X' else '' end as MV -- Theo mùa vụ hoặc theo công việc nhất định dưới 12 tháng
,Case When T6.QuitJobID = 'NH' then 'X' else '' end as NH -- Nghỉ hưu
,Case When T6.QuitJobID = 'DP' then 'X' else '' end as DP -- Đơn phương chấm dứt Hợp đồng lao động / Hợp đồng làm việc
,Case When T6.QuitJobID = 'ST' then 'X' else '' end as ST -- Kỷ luật sa thải
,Case When T6.QuitJobID = 'TT' then 'X' else '' end as TT -- Thỏa thuận chấm dứt
,T6.Notes -- Lý do khác
FROM HT1400 T1 WITH (NOLOCK)
INNER JOIN HT1403 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID
INNER JOIN AT1101 T3 WITH (NOLOCK) ON T1.DivisionID = T3.DivisionID 
INNER JOIN HT1401 T4 WITH (NOLOCK) ON T1.DivisionID = T4.DivisionID AND T1.EmployeeID = T4.EmployeeID
INNER JOIN HT1380 T6 WITH (NOLOCK) ON T1.DivisionID = T6.DivisionID AND T1.EmployeeID = T6.EmployeeID AND @BeginDate <= T6.LeaveDate AND T6.LeaveDate < @EndDate
LEFT JOIN HT1360 T5 WITH (NOLOCK) ON T1.DivisionID = T5.DivisionID AND T1.EmployeeID = T5.EmployeeID
LEFT JOIN HT1106 T7 WITH (NOLOCK) ON T2.DivisionID = T7.DivisionID AND T2.TitleID = T7.TitleID
WHERE T1.DivisionID = @DivisionIDList

-- Số lao động cuối kỳ
SELECT Count(T1.EmployeeID) as TotalEmployee -- Tổng số 
,SUM(Case When T1.IsMale = 1 then 0 else 1 end) as TotalFemale -- Lao động nữ
,SUM(Case When T4.SpecialID = 'DH' then 1 else 0 end) as TotalDH -- Đại học trở lên
,SUM(Case When T4.SpecialID = 'CD' then 1 else 0 end) as TotalCD -- Cao đẳng / Cao đẳng nghề
,SUM(Case When T4.SpecialID = 'TC' then 1 else 0 end) as TotalTC -- Trung cấp / Trung cấp nghề
,SUM(Case When T4.SpecialID = 'SC' then 1 else 0 end) as TotalSC  -- Sơ cấp nghề
,SUM(Case When T4.SpecialID = 'DN' then 1 else 0 end) as TotalDN -- Dạy nghề thường xuyên
,SUM(Case When T4.SpecialID = 'CDT' then 1 else 0 end) as TotalCDT -- Chưa qua đào tạo
,SUM(Case When T5.ContractTypeID = 'KTH' then 1 else 0 end) as TotalKTH -- Không xác định thời hạn
,SUM(Case When T5.ContractTypeID = 'TH' then 1 else 0 end) as TotalTH -- Xác định thời hạn
,SUM(Case When T5.ContractTypeID = 'MV' then 1 else 0 end) as TotalMV -- Theo mùa vụ hoặc theo công việc nhất định dưới 12 tháng
FROM HT1400 T1 WITH (NOLOCK)
INNER JOIN HT1403 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID
INNER JOIN AT1101 T3 WITH (NOLOCK) ON T1.DivisionID = T3.DivisionID AND T2.FromApprenticeTime < @EndDate
INNER JOIN HT1401 T4 WITH (NOLOCK) ON T1.DivisionID = T4.DivisionID AND T1.EmployeeID = T4.EmployeeID
LEFT JOIN HT1360 T5 WITH (NOLOCK) ON T1.DivisionID = T5.DivisionID AND T1.EmployeeID = T5.EmployeeID
LEFT JOIN HT1380 T6 WITH (NOLOCK) ON T1.DivisionID = T6.DivisionID AND T1.EmployeeID = T6.EmployeeID
WHERE T1.DivisionID = @DivisionIDList AND (T6.LeaveDate is null OR T6.LeaveDate >= @EndDate )

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
