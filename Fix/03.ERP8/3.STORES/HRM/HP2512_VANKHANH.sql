IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP2512_VANKHANH]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP2512_VANKHANH]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-----Created by Vo Thanh Huong, date: 25/08/2004
-----purpose: Xu lý so lieu IN luong cong thang 
-----Edited by: Pham Thi Phuong Loan : Thue thu nhap
-----Edit by: Dang Le Bao Quynh, Date 18/08/2006
-----Purpose: Xu ly tinh trang tran chuoi.
-----Edit by: Dang Le Bao Quynh; Date: 19/06/2009
-----Purpose: Bo sung truong DivisionID vao view HV2409
---Edit by Hoang Trong Khanh, date 14/12/2011 -- Add @GrossPay,@Deduction,@IncomeTax : Sử dụng đa ngôn ngữ
---Edit by Trần Quốc Tuấn, date 06/02/2015 -- Add ISNULL cho các trường IGAbsentAmount01-30

/********************************************
'* Edited by: [GS] [Việt Khánh] [02/08/2010]
'********************************************/
---- Modified on 20/12/2012 by Lê Thị Thu Hiền : Bổ sung kiểm tra @Condition 
---- Modified on 16/08/2013 by Lê Thị Thu Hiền : Chỉnh sửa thiếu dấu nháy 0020735
---- Modified on 11/11/2013 by Bảo Anh : Bổ sung lương tháng 13 (customize Unicare) và 10 khoản thu nhập cho chấm công theo công trình
---- Modified on 19/11/2013 by Bảo Anh : Bổ sung số ngày công lớn nhất và số công trình của từng nhân viên (customize Unicare)
---- Modified on 01/12/2013 by Bảo Anh : Bổ sung số TK ngân hàng
---- Modified on 03/12/2013 by Thanh Sơn: Cập nhật in lỗi font
---- Modified on 23/12/2013 by Bảo Anh : Bổ sung ngày bắt đầu tham gia công trình và ngày của công trình được chuyển sau cùng (Unicare)
---- Modified on 25/12/2013 by Thanh Sơn: Bổ sung lấy thêm một số trường (Customize CSG = 19) (EXEC HP5410CSG)
---- Modified on 30/12/2013 by Bảo Anh : Sửa tên field BeginDate thành BeginJoinDate, Where thêm tháng năm khi lấy BeginJoinDate (Unicare)
---- Modified on 02/01/2014 by Bảo Anh : Where thêm tháng, năm khi lấy CountOfProjects, MaxAbsentAmounts (Unicare)
---- Modified on 07/01/2014 by Bảo Anh : Sửa cách tính lương tháng 13 (Unicare)
---- Modified on 08/01/2014 by Bảo Anh : Bổ sung WorkDate
---- Modified on 09/01/2014 by Bảo Anh : Cải thiện tốc độ (dùng HT5411 thay HV2408, bỏ join một số bảng khi tạo view HV240901)
---- Modified on 13/01/2014 by Bảo Anh : Bổ sung CountOfPayrollMethodID
---- Modified on 15/01/2014 by Bảo Anh : Where thêm PayrollMethodID khi tính CountOfProjects
---- Modified on 06/03/2014 by Bảo Anh : Bổ sung DutyID vào HV240901
---- Modified on 11/03/2014 by Bảo Anh : Bổ sung các trường STT cong trình của 1 nhân viên, STT từng công trình
---- Modified on 10/04/2014 by Bảo Anh : Bổ sung mã cong trình tính trừ các khoản BHXH - InsuranceProjectID (Unicare)
---- Modified on 12/05/2015 by Mai Duyen : Fix loi field BeginDate tra ra nhieu dong   (Van khanh)
---- Modifyed by Kim Vu on 23/02/2016: Bổ sung in theo danh sách nhân viên được chọn
---- Modified by Bảo Thy on 16/09/2016: Thay đổi cách lấy danh sách nhân viên bằng XML để không bị tràn chuỗi
---- Modified by Phương Thảo on 18/05/2017: Sửa danh mục dùng chung
---- Modified by Hải Long on 04/08/2017: Bổ sung trường ghi chú chấm công theo công trình (Notes)
---- Modified on 11/01/2018 by Bảo Anh: Bổ sung in nhiều đơn vị
---- Modified by Bảo Thy on 17/01/2017: Bổ sung I151 -> I200 (MEIKO)
---- Modified by Kim Thư on 30/05/2019: Bổ sung thêm trường lương BHXH (InsuranceSalary) lên view HV240901
---- Modified by Hoài Phong on 03/12/2020: Lấy thêm cột để hiển thị lên báo cáo, Tính tổng lại cho các khoản bảo hiểm của cty cho VĂN KHÁNH


CREATE PROCEDURE [dbo].[HP2512_VANKHANH] 
	@DivisionID nvarchar(20),      
    @FromDepartmentID nvarchar(50),  
    @ToDepartmentID nvarchar(50),  
    @TeamID nvarchar(50),  
    @FromEmployeeID nvarchar(50),   
    @ToEmployeeID nvarchar(50),   
    @FromYear int,  
    @FromMonth int,      
    @ToYear int,  
    @ToMonth int,      
    @lstPayrollMethodID nvarchar(4000),  
    @GrossPay nvarchar(50),
	@Deduction nvarchar(50), 
	@IncomeTax nvarchar(50),
    @gnLang int,  
    @Condition nvarchar(1000),
	@lstEmployeeID as XML,--- Danh sach nhân viên được chọn
	@StrDivisionID AS NVARCHAR(4000) = ''
AS
DECLARE 
    @sSQL NVARCHAR(MAX), 
    @sSQL2 NVARCHAR(max), 
    @sSQL3 NVARCHAR(MAX), 
    @cur CURSOR, 
    @FieldID NVARCHAR(50), 
    @Caption NVARCHAR(100), 
    @Signs DECIMAL, 
    @Notes NVARCHAR(50), 
    @Orders TINYINT, 
    @IncomeID NVARCHAR(50), 
    @PayrollMethodID NVARCHAR(50),
    @CustomerName INT,
    @sSQL1 NVARCHAR(2000),
	@sSQL4 NVARCHAR(MAX)='',
	@sSQL5 NVARCHAR(MAX)='',
	@sSQL6 NVARCHAR(MAX)='',
	@sSQL7 NVARCHAR(MAX)='',
	@sSQL8 NVARCHAR(MAX)='',
    @sFrom NVARCHAR(2000),
    @sGroup NVARCHAR(2000),
	@sSQL_Where nvarchar(4000),
	@StrDivisionID_New AS NVARCHAR(4000),
	@DivisionID1 NVARCHAR(50),
	@sTable VARCHAR(4000)

SET @StrDivisionID_New = ''
SET @DivisionID1 = ''
SET @sTable = ''		

IF ISNULL(@StrDivisionID,'') <> ''
	SELECT @StrDivisionID_New = CASE WHEN @StrDivisionID = '%' THEN ' LIKE ''' + 
	@StrDivisionID + '''' ELSE ' IN (''' + replace(@StrDivisionID, ',',''',''') + ''')' END
ELSE
	SELECT @StrDivisionID_New = ' = ''' + @DivisionID + ''''	
    
--Tao bang tam de kiem tra day co phai la khach hang Unicare khong (CustomerName = 21)
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

SET @sSQL1 = ''
SET @sFrom = ''
SET @sGroup = ''

IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[TBL_HP2512]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE TBL_HP2512 (EmployeeID VARCHAR(50))
END

INSERT INTO TBL_HP2512
SELECT X.Data.query('EmployeeID').value('.', 'NVARCHAR(50)') AS EmployeeID
FROM @lstEmployeeID.nodes('//Data') AS X (Data)

IF NOT EXISTS (SELECT TOP 1 1 FROM TBL_HP2512)
BEGIN 
	SET @sSQL_Where =''
END
ELSE
BEGIN
	SET @sSQL_Where = ' AND T00.EmployeeID  in (SELECT EmployeeID FROM TBL_HP2512) '
END


IF EXISTS (SELECT * FROM sysobjects WHERE name = 'HT5401' AND xtype = 'U') ---Table tam 
    DROP TABLE HT5401
    
CREATE TABLE HT5401(
	DivisionID NVARCHAR(50), 
    EmployeeID NVARCHAR(50), 
    DepartmentID NVARCHAR(50), 
    DepartmentName NVARCHAR(100), 
    InsuranceSalary DECIMAL, 
    Orders NVARCHAR(50), 
    TeamID NVARCHAR(50), 
    Notes NVARCHAR(100), 
    IncomeID NVARCHAR(50), 
    Signs numeric, 
    Amount DECIMAL, 
    Caption NVARCHAR(100), 
    FOrders INT
)

--- tạo bảng HT5411 thay cho view HV2408 để cải thiện tốc độ
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'HT5411' AND xtype = 'U') ---Table tam 
    DROP TABLE HT5411
    
CREATE TABLE HT5411(
		DivisionID nvarchar(50),
		EmployeeID nvarchar(50),
		FullName nvarchar(250),
		DepartmentID nvarchar(50),
		DepartmentName nvarchar(250),
		Birthday datetime,
		PayrollMethodID nvarchar(50),
		Orders int,
		DutyName nvarchar(250),
		TeamID nvarchar(50),
		InsuranceSalary decimal(28,8),
		Income01 decimal(28,8),
		Income02 decimal(28,8),
		Income03 decimal(28,8),
		Income04 decimal(28,8),
		Income05 decimal(28,8),
		Income06 decimal(28,8),
		Income07 decimal(28,8),
		Income08 decimal(28,8),
		Income09 decimal(28,8),
		Income10 decimal(28,8),
		Income11 decimal(28,8),
		Income12 decimal(28,8),
		Income13 decimal(28,8),
		Income14 decimal(28,8),
		Income15 decimal(28,8),
		Income16 decimal(28,8),
		Income17 decimal(28,8),
		Income18 decimal(28,8),
		Income19 decimal(28,8),
		Income20 decimal(28,8),
		Income21 decimal(28,8),
		Income22 decimal(28,8),
		Income23 decimal(28,8),
		Income24 decimal(28,8),
		Income25 decimal(28,8),
		Income26 decimal(28,8),
		Income27 decimal(28,8),
		Income28 decimal(28,8),
		Income29 decimal(28,8),
		Income30 decimal(28,8),
		Income31 decimal(28,8),
		Income32 decimal(28,8),
		Income33 decimal(28,8),
		Income34 decimal(28,8),
		Income35 decimal(28,8),
		Income36 decimal(28,8),
		Income37 decimal(28,8),
		Income38 decimal(28,8),
		Income39 decimal(28,8),
		Income40 decimal(28,8),
		Income41 decimal(28,8),
		Income42 decimal(28,8),
		Income43 decimal(28,8),
		Income44 decimal(28,8),
		Income45 decimal(28,8),
		Income46 decimal(28,8),
		Income47 decimal(28,8),
		Income48 decimal(28,8),
		Income49 decimal(28,8),
		Income50 decimal(28,8),
		Income51 decimal(28,8),
		Income52 decimal(28,8),
		Income53 decimal(28,8),
		Income54 decimal(28,8),
		Income55 decimal(28,8),
		Income56 decimal(28,8),
		Income57 decimal(28,8),
		Income58 decimal(28,8),
		Income59 decimal(28,8),
		Income60 decimal(28,8),
		Income61 decimal(28,8),
		Income62 decimal(28,8),
		Income63 decimal(28,8),
		Income64 decimal(28,8),
		Income65 decimal(28,8),
		Income66 decimal(28,8),
		Income67 decimal(28,8),
		Income68 decimal(28,8),
		Income69 decimal(28,8),
		Income70 decimal(28,8),
		Income71 decimal(28,8),
		Income72 decimal(28,8),
		Income73 decimal(28,8),
		Income74 decimal(28,8),
		Income75 decimal(28,8),
		Income76 decimal(28,8),
		Income77 decimal(28,8),
		Income78 decimal(28,8),
		Income79 decimal(28,8),
		Income80 decimal(28,8),
		Income81 decimal(28,8),
		Income82 decimal(28,8),
		Income83 decimal(28,8),
		Income84 decimal(28,8),
		Income85 decimal(28,8),
		Income86 decimal(28,8),
		Income87 decimal(28,8),
		Income88 decimal(28,8),
		Income89 decimal(28,8),
		Income90 decimal(28,8),
		Income91 decimal(28,8),
		Income92 decimal(28,8),
		Income93 decimal(28,8),
		Income94 decimal(28,8),
		Income95 decimal(28,8),
		Income96 decimal(28,8),
		Income97 decimal(28,8),
		Income98 decimal(28,8),
		Income99 decimal(28,8),
		Income100 decimal(28,8),
		Income101 decimal(28,8),
		Income102 decimal(28,8),
		Income103 decimal(28,8),
		Income104 decimal(28,8),
		Income105 decimal(28,8),
		Income106 decimal(28,8),
		Income107 decimal(28,8),
		Income108 decimal(28,8),
		Income109 decimal(28,8),
		Income110 decimal(28,8),
		Income111 decimal(28,8),
		Income112 decimal(28,8),
		Income113 decimal(28,8),
		Income114 decimal(28,8),
		Income115 decimal(28,8),
		Income116 decimal(28,8),
		Income117 decimal(28,8),
		Income118 decimal(28,8),
		Income119 decimal(28,8),
		Income120 decimal(28,8),
		Income121 decimal(28,8),
		Income122 decimal(28,8),
		Income123 decimal(28,8),
		Income124 decimal(28,8),
		Income125 decimal(28,8),
		Income126 decimal(28,8),
		Income127 decimal(28,8),
		Income128 decimal(28,8),
		Income129 decimal(28,8),
		Income130 decimal(28,8),
		Income131 decimal(28,8),
		Income132 decimal(28,8),
		Income133 decimal(28,8),
		Income134 decimal(28,8),
		Income135 decimal(28,8),
		Income136 decimal(28,8),
		Income137 decimal(28,8),
		Income138 decimal(28,8),
		Income139 decimal(28,8),
		Income140 decimal(28,8),
		Income141 decimal(28,8),
		Income142 decimal(28,8),
		Income143 decimal(28,8),
		Income144 decimal(28,8),
		Income145 decimal(28,8),
		Income146 decimal(28,8),
		Income147 decimal(28,8),
		Income148 decimal(28,8),
		Income149 decimal(28,8),
		Income150 decimal(28,8),
		Income151 decimal(28,8),
		Income152 decimal(28,8),
		Income153 decimal(28,8),
		Income154 decimal(28,8),
		Income155 decimal(28,8),
		Income156 decimal(28,8),
		Income157 decimal(28,8),
		Income158 decimal(28,8),
		Income159 decimal(28,8),
		Income160 decimal(28,8),
		Income161 decimal(28,8),
		Income162 decimal(28,8),
		Income163 decimal(28,8),
		Income164 decimal(28,8),
		Income165 decimal(28,8),
		Income166 decimal(28,8),
		Income167 decimal(28,8),
		Income168 decimal(28,8),
		Income169 decimal(28,8),
		Income170 decimal(28,8),
		Income171 decimal(28,8),
		Income172 decimal(28,8),
		Income173 decimal(28,8),
		Income174 decimal(28,8),
		Income175 decimal(28,8),
		Income176 decimal(28,8),
		Income177 decimal(28,8),
		Income178 decimal(28,8),
		Income179 decimal(28,8),
		Income180 decimal(28,8),
		Income181 decimal(28,8),
		Income182 decimal(28,8),
		Income183 decimal(28,8),
		Income184 decimal(28,8),
		Income185 decimal(28,8),
		Income186 decimal(28,8),
		Income187 decimal(28,8),
		Income188 decimal(28,8),
		Income189 decimal(28,8),
		Income190 decimal(28,8),
		Income191 decimal(28,8),
		Income192 decimal(28,8),
		Income193 decimal(28,8),
		Income194 decimal(28,8),
		Income195 decimal(28,8),
		Income196 decimal(28,8),
		Income197 decimal(28,8),
		Income198 decimal(28,8),
		Income199 decimal(28,8),
		Income200 decimal(28,8),
		SubAmount01 decimal(28,8),
		SubAmount02 decimal(28,8),
		SubAmount03 decimal(28,8),
		SubAmount04 decimal(28,8),
		SubAmount05 decimal(28,8),
		SubAmount06 decimal(28,8),
		SubAmount07 decimal(28,8),
		SubAmount08 decimal(28,8),
		SubAmount09 decimal(28,8),
		SubAmount10 decimal(28,8),
		SubAmount11 decimal(28,8),
		SubAmount12 decimal(28,8),
		SubAmount13 decimal(28,8),
		SubAmount14 decimal(28,8),
		SubAmount15 decimal(28,8),
		SubAmount16 decimal(28,8),
		SubAmount17 decimal(28,8),
		SubAmount18 decimal(28,8),
		SubAmount19 decimal(28,8),
		SubAmount20 decimal(28,8),
		SubAmount21	DECIMAL(28,8),
		SubAmount22	DECIMAL(28,8),
		SubAmount23	DECIMAL(28,8),
		SubAmount24	DECIMAL(28,8),
		SubAmount25	DECIMAL(28,8),
		SubAmount26	DECIMAL(28,8),
		SubAmount27	DECIMAL(28,8),
		SubAmount28	DECIMAL(28,8),
		SubAmount29	DECIMAL(28,8),
		SubAmount30	DECIMAL(28,8),
		SubAmount31	DECIMAL(28,8),
		SubAmount32	DECIMAL(28,8),
		SubAmount33	DECIMAL(28,8),
		SubAmount34	DECIMAL(28,8),
		SubAmount35	DECIMAL(28,8),
		SubAmount36	DECIMAL(28,8),
		SubAmount37	DECIMAL(28,8),
		SubAmount38	DECIMAL(28,8),
		SubAmount39	DECIMAL(28,8),
		SubAmount40	DECIMAL(28,8),
		SubAmount41	DECIMAL(28,8),
		SubAmount42	DECIMAL(28,8),
		SubAmount43	DECIMAL(28,8),
		SubAmount44	DECIMAL(28,8),
		SubAmount45	DECIMAL(28,8),
		SubAmount46	DECIMAL(28,8),
		SubAmount47	DECIMAL(28,8),
		SubAmount48	DECIMAL(28,8),
		SubAmount49	DECIMAL(28,8),
		SubAmount50	DECIMAL(28,8),
		SubAmount51	DECIMAL(28,8),
		SubAmount52	DECIMAL(28,8),
		SubAmount53	DECIMAL(28,8),
		SubAmount54	DECIMAL(28,8),
		SubAmount55	DECIMAL(28,8),
		SubAmount56	DECIMAL(28,8),
		SubAmount57	DECIMAL(28,8),
		SubAmount58	DECIMAL(28,8),
		SubAmount59	DECIMAL(28,8),
		SubAmount60	DECIMAL(28,8),
		SubAmount61	DECIMAL(28,8),
		SubAmount62	DECIMAL(28,8),
		SubAmount63	DECIMAL(28,8),
		SubAmount64	DECIMAL(28,8),
		SubAmount65	DECIMAL(28,8),
		SubAmount66	DECIMAL(28,8),
		SubAmount67	DECIMAL(28,8),
		SubAmount68	DECIMAL(28,8),
		SubAmount69	DECIMAL(28,8),
		SubAmount70	DECIMAL(28,8),
		SubAmount71	DECIMAL(28,8),
		SubAmount72	DECIMAL(28,8),
		SubAmount73	DECIMAL(28,8),
		SubAmount74	DECIMAL(28,8),
		SubAmount75	DECIMAL(28,8),
		SubAmount76	DECIMAL(28,8),
		SubAmount77	DECIMAL(28,8),
		SubAmount78	DECIMAL(28,8),
		SubAmount79	DECIMAL(28,8),
		SubAmount80	DECIMAL(28,8),
		SubAmount81	DECIMAL(28,8),
		SubAmount82	DECIMAL(28,8),
		SubAmount83	DECIMAL(28,8),
		SubAmount84	DECIMAL(28,8),
		SubAmount85	DECIMAL(28,8),
		SubAmount86	DECIMAL(28,8),
		SubAmount87	DECIMAL(28,8),
		SubAmount88	DECIMAL(28,8),
		SubAmount89	DECIMAL(28,8),
		SubAmount90	DECIMAL(28,8),
		SubAmount91	DECIMAL(28,8),
		SubAmount92	DECIMAL(28,8),
		SubAmount93	DECIMAL(28,8),
		SubAmount94	DECIMAL(28,8),
		SubAmount95	DECIMAL(28,8),
		SubAmount96	DECIMAL(28,8),
		SubAmount97	DECIMAL(28,8),
		SubAmount98	DECIMAL(28,8),
		SubAmount99	DECIMAL(28,8),
		SubAmount100 DECIMAL(28,8),
		SubAmount00 decimal(28,8),		
	)

SET @lstPayrollMethodID = 
CASE 
    WHEN @lstPayrollMethodID = '%' THEN ' LIKE ''' + 
        @lstPayrollMethodID + '''' 
    ELSE ' IN (''' + replace(@lstPayrollMethodID, ', ', ''', ''') + ''')' 
END 
    
SELECT @sSQL = '', @sSQL2 = '', @Orders = 1

---Neu don vi co tinh thue thu nhap

IF EXISTS (SELECT TOP 1 1 FROM HT2400 WHERE DivisionID = @DivisionID And TranMonth + 100* TranYear BETWEEN CAST(@FromMonth + @FromYear*100 AS NVARCHAR(10)) AND CAST(@ToMonth + @ToYear*100 AS NVARCHAR(10)) AND ISNULL(TaxObjectID, '') <> '')
    BEGIN 
        SET @sSQL = 'INSERT INTO HT5411
					SELECT T00.DivisionID, T00.EmployeeID, FullName, T00.DepartmentID, V00.DepartmentName, V00.Birthday, PayrollMethodID, V00.Orders AS Orders, 
					ISNULL(DutyName, '''') AS DutyName, ISNULL(T00.TeamID, '''') AS TeamID, ISNULL(T02.InsuranceSalary, 0) AS InsuranceSalary, 
			        ISNULL(Income01, 0) AS Income01, ISNULL(Income02, 0) AS Income02, ISNULL(Income03, 0) AS Income03, ISNULL(Income04, 0) AS Income04, ISNULL(Income05, 0) AS Income05, 
					ISNULL(Income06, 0) AS Income06, ISNULL(Income07, 0) AS Income07, ISNULL(Income08, 0) AS Income08, ISNULL(Income09, 0) AS Income09, ISNULL(Income10, 0) AS Income10, 
			        ISNULL(Income11, 0) AS Income11, ISNULL(Income12, 0) AS Income12, ISNULL(Income13, 0) AS Income13, ISNULL(Income14, 0) AS Income14, ISNULL(Income15, 0) AS Income15,
					ISNULL(Income16, 0) AS Income16, ISNULL(Income17, 0) AS Income17, ISNULL(Income18, 0) AS Income18, ISNULL(Income19, 0) AS Income19, ISNULL(Income20, 0) AS Income20,
			        ISNULL(Income21, 0) AS Income21, ISNULL(Income22, 0) AS Income22, ISNULL(Income23, 0) AS Income23, ISNULL(Income24, 0) AS Income24, ISNULL(Income25, 0) AS Income25, 
					ISNULL(Income26, 0) AS Income26, ISNULL(Income27, 0) AS Income27, ISNULL(Income28, 0) AS Income28, ISNULL(Income29, 0) AS Income29, ISNULL(Income30, 0) AS Income30,
					ISNULL(Income31,0) AS Income31, ISNULL(Income32,0) AS Income32, ISNULL(Income33,0) AS Income33, ISNULL(Income34,0) AS Income34, ISNULL(Income35,0) AS Income35, 
					ISNULL(Income36,0) AS Income36, ISNULL(Income37,0) AS Income37, ISNULL(Income38,0) AS Income38, ISNULL(Income39,0) AS Income39, ISNULL(Income40,0) AS Income40, 
					ISNULL(Income41,0) AS Income41, ISNULL(Income42,0) AS Income42, ISNULL(Income43,0) AS Income43, ISNULL(Income44,0) AS Income44, ISNULL(Income45,0) AS Income45, 
					ISNULL(Income46,0) AS Income46, ISNULL(Income47,0) AS Income47, ISNULL(Income48,0) AS Income48, ISNULL(Income49,0) AS Income49, ISNULL(Income50,0) AS Income50, 
					ISNULL(Income51,0) AS Income51, ISNULL(Income52,0) AS Income52, ISNULL(Income53,0) AS Income53, ISNULL(Income54,0) AS Income54, ISNULL(Income55,0) AS Income55, 
					ISNULL(Income56,0) AS Income56, ISNULL(Income57,0) AS Income57, ISNULL(Income58,0) AS Income58, ISNULL(Income59,0) AS Income59, ISNULL(Income60,0) AS Income60, 
					ISNULL(Income61,0) AS Income61, ISNULL(Income62,0) AS Income62, ISNULL(Income63,0) AS Income63, ISNULL(Income64,0) AS Income64, ISNULL(Income65,0) AS Income65, 
					ISNULL(Income66,0) AS Income66, ISNULL(Income67,0) AS Income67, ISNULL(Income68,0) AS Income68, ISNULL(Income69,0) AS Income69, ISNULL(Income70,0) AS Income70, 
					ISNULL(Income71,0) AS Income71, ISNULL(Income72,0) AS Income72, ISNULL(Income73,0) AS Income73, ISNULL(Income74,0) AS Income74, ISNULL(Income75,0) AS Income75, 
					ISNULL(Income76,0) AS Income76, ISNULL(Income77,0) AS Income77, ISNULL(Income78,0) AS Income78, ISNULL(Income79,0) AS Income79, ISNULL(Income80,0) AS Income80, 
					ISNULL(Income81,0) AS Income81, ISNULL(Income82,0) AS Income82, ISNULL(Income83,0) AS Income83, ISNULL(Income84,0) AS Income84, ISNULL(Income85,0) AS Income85, 
					ISNULL(Income86,0) AS Income86, ISNULL(Income87,0) AS Income87, ISNULL(Income88,0) AS Income88, ISNULL(Income89,0) AS Income89, ISNULL(Income90,0) AS Income90, 
					ISNULL(Income91,0) AS Income91, ISNULL(Income92,0) AS Income92, ISNULL(Income93,0) AS Income93, ISNULL(Income94,0) AS Income94, ISNULL(Income95,0) AS Income95, 
					ISNULL(Income96,0) AS Income96, ISNULL(Income97,0) AS Income97, ISNULL(Income98,0) AS Income98, ISNULL(Income99,0) AS Income99, ISNULL(Income100,0) AS Income100, 
					ISNULL(Income101,0) AS Income101, ISNULL(Income102,0) AS Income102, ISNULL(Income103,0) AS Income103, ISNULL(Income104,0) AS Income104, ISNULL(Income105,0) AS Income105, '
					SET @sSQL4 = '
					ISNULL(Income106,0) AS Income106, ISNULL(Income107,0) AS Income107, ISNULL(Income108,0) AS Income108, ISNULL(Income109,0) AS Income109, ISNULL(Income110,0) AS Income110, 
					ISNULL(Income111,0) AS Income111, ISNULL(Income112,0) AS Income112, ISNULL(Income113,0) AS Income113, ISNULL(Income114,0) AS Income114, ISNULL(Income115,0) AS Income115, 
					ISNULL(Income116,0) AS Income116, ISNULL(Income117,0) AS Income117, ISNULL(Income118,0) AS Income118, ISNULL(Income119,0) AS Income119, ISNULL(Income120,0) AS Income120, 
					ISNULL(Income121,0) AS Income121, ISNULL(Income122,0) AS Income122, ISNULL(Income123,0) AS Income123, ISNULL(Income124,0) AS Income124, ISNULL(Income125,0) AS Income125, 
					ISNULL(Income126,0) AS Income126, ISNULL(Income127,0) AS Income127, ISNULL(Income128,0) AS Income128, ISNULL(Income129,0) AS Income129, ISNULL(Income130,0) AS Income130, 
					ISNULL(Income131,0) AS Income131, ISNULL(Income132,0) AS Income132, ISNULL(Income133,0) AS Income133, ISNULL(Income134,0) AS Income134, ISNULL(Income135,0) AS Income135, 
					ISNULL(Income136,0) AS Income136, ISNULL(Income137,0) AS Income137, ISNULL(Income138,0) AS Income138, ISNULL(Income139,0) AS Income139, ISNULL(Income140,0) AS Income140, 
					ISNULL(Income141,0) AS Income141, ISNULL(Income142,0) AS Income142, ISNULL(Income143,0) AS Income143, ISNULL(Income144,0) AS Income144, ISNULL(Income145,0) AS Income145, 
					ISNULL(Income146,0) AS Income146, ISNULL(Income147,0) AS Income147, ISNULL(Income148,0) AS Income148, ISNULL(Income149,0) AS Income149, ISNULL(Income150,0) AS Income150,
					ISNULL(Income151,0) AS Income151, ISNULL(Income152,0) AS Income152, ISNULL(Income153,0) AS Income153, ISNULL(Income154,0) AS Income154, ISNULL(Income155,0) AS Income155, 
					ISNULL(Income156,0) AS Income156, ISNULL(Income157,0) AS Income157, ISNULL(Income158,0) AS Income158, ISNULL(Income159,0) AS Income159, ISNULL(Income160,0) AS Income160,
					ISNULL(Income161,0) AS Income161, ISNULL(Income162,0) AS Income162, ISNULL(Income163,0) AS Income163, ISNULL(Income164,0) AS Income164, ISNULL(Income165,0) AS Income165, 
					ISNULL(Income166,0) AS Income166, ISNULL(Income167,0) AS Income167, ISNULL(Income168,0) AS Income168, ISNULL(Income169,0) AS Income169, ISNULL(Income170,0) AS Income170, 
					ISNULL(Income171,0) AS Income171, ISNULL(Income172,0) AS Income172, ISNULL(Income173,0) AS Income173, ISNULL(Income174,0) AS Income174, ISNULL(Income175,0) AS Income175, 
					ISNULL(Income176,0) AS Income176, ISNULL(Income177,0) AS Income177, ISNULL(Income178,0) AS Income178, ISNULL(Income179,0) AS Income179, ISNULL(Income180,0) AS Income180, 
					ISNULL(Income181,0) AS Income181, ISNULL(Income182,0) AS Income182, ISNULL(Income183,0) AS Income183, ISNULL(Income184,0) AS Income184, ISNULL(Income185,0) AS Income185, 
					ISNULL(Income186,0) AS Income186, ISNULL(Income187,0) AS Income187, ISNULL(Income188,0) AS Income188, ISNULL(Income189,0) AS Income189, ISNULL(Income190,0) AS Income190, 
					ISNULL(Income191,0) AS Income191, ISNULL(Income192,0) AS Income192, ISNULL(Income193,0) AS Income193, ISNULL(Income194,0) AS Income194, ISNULL(Income195,0) AS Income195, 
					ISNULL(Income196,0) AS Income196, ISNULL(Income197,0) AS Income197, ISNULL(Income198,0) AS Income198, ISNULL(Income199,0) AS Income199, ISNULL(Income200,0) AS Income200,'
					SET @sSQL8 = '
			        ISNULL(SubAmount01,0) AS SubAmount01, ISNULL(SubAmount02,0) AS SubAmount02, ISNULL(SubAmount03,0) AS SubAmount03, ISNULL(SubAmount04,0) AS SubAmount04, 
			        ISNULL(SubAmount05,0) AS SubAmount05, ISNULL(SubAmount06,0) AS SubAmount06, ISNULL(SubAmount07,0) AS SubAmount07, ISNULL(SubAmount08,0) AS SubAmount08, 
			        ISNULL(SubAmount09,0) AS SubAmount09, ISNULL(SubAmount10,0) AS SubAmount10, ISNULL(SubAmount11,0) AS SubAmount11, ISNULL(SubAmount12,0) AS SubAmount12, 
			        ISNULL(SubAmount13,0) AS SubAmount13, ISNULL(SubAmount14,0) AS SubAmount14, ISNULL(SubAmount15,0) AS SubAmount15, ISNULL(SubAmount16,0) AS SubAmount16, 
			        ISNULL(SubAmount17,0) AS SubAmount17, ISNULL(SubAmount18,0) AS SubAmount18, ISNULL(SubAmount19,0) AS SubAmount19, ISNULL(SubAmount20,0) AS SubAmount20, 
					ISNULL(SubAmount21,0) AS SubAmount21, ISNULL(SubAmount22,0) AS SubAmount22, ISNULL(SubAmount23,0) AS SubAmount23, ISNULL(SubAmount24,0) AS SubAmount24, 
					ISNULL(SubAmount25,0) AS SubAmount25, ISNULL(SubAmount26,0) AS SubAmount26, ISNULL(SubAmount27,0) AS SubAmount27, ISNULL(SubAmount28,0) AS SubAmount28, 
					ISNULL(SubAmount29,0) AS SubAmount29, ISNULL(SubAmount30,0) AS SubAmount30, ISNULL(SubAmount31,0) AS SubAmount31, ISNULL(SubAmount32,0) AS SubAmount32, 
					ISNULL(SubAmount33,0) AS SubAmount33, ISNULL(SubAmount34,0) AS SubAmount34, ISNULL(SubAmount35,0) AS SubAmount35, ISNULL(SubAmount36,0) AS SubAmount36, 
					ISNULL(SubAmount37,0) AS SubAmount37, ISNULL(SubAmount38,0) AS SubAmount38, ISNULL(SubAmount39,0) AS SubAmount39, ISNULL(SubAmount40,0) AS SubAmount40, 
					ISNULL(SubAmount41,0) AS SubAmount41, ISNULL(SubAmount42,0) AS SubAmount42, ISNULL(SubAmount43,0) AS SubAmount43, ISNULL(SubAmount44,0) AS SubAmount44, 
					ISNULL(SubAmount45,0) AS SubAmount45, ISNULL(SubAmount46,0) AS SubAmount46, ISNULL(SubAmount47,0) AS SubAmount47, ISNULL(SubAmount48,0) AS SubAmount48, 
					ISNULL(SubAmount49,0) AS SubAmount49, ISNULL(SubAmount50,0) AS SubAmount50, ISNULL(SubAmount51,0) AS SubAmount51, ISNULL(SubAmount52,0) AS SubAmount52, 
					ISNULL(SubAmount53,0) AS SubAmount53, ISNULL(SubAmount54,0) AS SubAmount54, ISNULL(SubAmount55,0) AS SubAmount55, ISNULL(SubAmount56,0) AS SubAmount56, 
					ISNULL(SubAmount57,0) AS SubAmount57, ISNULL(SubAmount58,0) AS SubAmount58, ISNULL(SubAmount59,0) AS SubAmount59,'
					SET @sSQL5 = ' 
					ISNULL(SubAmount60,0) AS SubAmount60, ISNULL(SubAmount61,0) AS SubAmount61, ISNULL(SubAmount62,0) AS SubAmount62, ISNULL(SubAmount63,0) AS SubAmount63, ISNULL(SubAmount64,0) AS SubAmount64, 
					ISNULL(SubAmount65,0) AS SubAmount65, ISNULL(SubAmount66,0) AS SubAmount66, ISNULL(SubAmount67,0) AS SubAmount67, ISNULL(SubAmount68,0) AS SubAmount68, 
					ISNULL(SubAmount69,0) AS SubAmount69, ISNULL(SubAmount70,0) AS SubAmount70, ISNULL(SubAmount71,0) AS SubAmount71, ISNULL(SubAmount72,0) AS SubAmount72, 
					ISNULL(SubAmount73,0) AS SubAmount73, ISNULL(SubAmount74,0) AS SubAmount74, ISNULL(SubAmount75,0) AS SubAmount75, ISNULL(SubAmount76,0) AS SubAmount76, 
					ISNULL(SubAmount77,0) AS SubAmount77, ISNULL(SubAmount78,0) AS SubAmount78, ISNULL(SubAmount79,0) AS SubAmount79, ISNULL(SubAmount80,0) AS SubAmount80, 
					ISNULL(SubAmount81,0) AS SubAmount81, ISNULL(SubAmount82,0) AS SubAmount82, ISNULL(SubAmount83,0) AS SubAmount83, ISNULL(SubAmount84,0) AS SubAmount84, 
					ISNULL(SubAmount85,0) AS SubAmount85, ISNULL(SubAmount86,0) AS SubAmount86, ISNULL(SubAmount87,0) AS SubAmount87, ISNULL(SubAmount88,0) AS SubAmount88, 
					ISNULL(SubAmount89,0) AS SubAmount89, ISNULL(SubAmount90,0) AS SubAmount90, ISNULL(SubAmount91,0) AS SubAmount91, ISNULL(SubAmount92,0) AS SubAmount92, 
					ISNULL(SubAmount93,0) AS SubAmount93, ISNULL(SubAmount94,0) AS SubAmount94, ISNULL(SubAmount95,0) AS SubAmount95, ISNULL(SubAmount96,0) AS SubAmount96, 
					ISNULL(SubAmount97,0) AS SubAmount97, ISNULL(SubAmount98,0) AS SubAmount98, ISNULL(SubAmount99,0) AS SubAmount99, ISNULL(SubAmount100,0) AS SubAmount100, 
			        ISNULL(TaxAmount, 0) AS SubAmount00
			    FROM HT3400 T00 					
				INNER JOIN AT1102 T01 ON T01.DepartmentID = T00.DepartmentID 
				INNER JOIN HT2400 T02 ON T02.DivisionID = T00.DivisionID And T02.EmployeeID = T00.EmployeeID 
									AND T02.TranMonth = T00.TranMonth AND T02.TranYear = T00.TranYear AND T02.DepartmentID = T00.DepartmentID 
									AND ISNULL(T02.TeamID, '''') = ISNULL(T00.TeamID, '''')
				LEFT JOIN HT3499 T03 ON T03.DivisionID = T00.DivisionID AND T03.TransactionID = T00.TransactionID
				  WHERE T00.DivisionID = ''' + @DivisionID + ''' 
					AND T00.DepartmentID BETWEEN ''' + ISNULL(@FromDepartmentID,'') + ''' AND ''' + ISNULL(@ToDepartmentID,'') + ''' 
			        '+CASE WHEN ISNULL(@Condition,'') <> '' THEN 'AND isnull(T00.DepartmentID,''#'') in ('+ISNULL(@Condition,'')+')' ELSE '' END +' 
			        AND ISNULL(T00.TeamID, '''') LIKE ''' + ISNULL(@TeamID,'') + ''' 
					AND T00.EmployeeID BETWEEN ''' + ISNULL(@FromEmployeeID,'') + ''' AND ''' + ISNULL(@ToEmployeeID,'') + ''' 
					AND T00.TranMonth + T00.TranYear*100 BETWEEN ' + CAST(@FromMonth + @FromYear*100 AS NVARCHAR(10)) + ' AND ' + CAST(@ToMonth + @ToYear*100 AS NVARCHAR(10)) + ' 
					AND PayrollMethodID ' + ISNULL(@lstPayrollMethodID,'') + @sSQL_Where

		EXEC(@sSQL+@sSQL4+@sSQL8+@sSQL5)   
		/*
        IF EXISTS (SELECT 1 FROM sysObjects WHERE XType = 'V' AND Name = 'HV2408')
            DROP VIEW HV2408
            
        EXEC ('---- tao boi HP2512
            CREATE VIEW HV2408 AS ' + @sSQL)
		*/
        SET @sSQL = ''
        
		IF ISNULL(@StrDivisionID,'') = ''
		BEGIN
			SET @cur = CURSOR SCROLL KEYSET FOR
				SELECT T00.DivisionID, T00.PayrollMethodID, T00.IncomeID, RIGHT(T00.IncomeID, 2) AS Orders, 1 AS Signs, 
				   -- CASE @gnLang WHEN 0 THEN 'Tieàn löông' ELSE 'Gross Pay' END AS Notes, 
				   @GrossPay AS Notes, 
					CASE @gnLang WHEN 0 THEN T01.Caption ELSE T01.CaptionE END AS Caption
				FROM HT5005 T00 INNER JOIN HT0002 T01 ON T00.IncomeID = T01.IncomeID and T00.DivisionID = T01.DivisionID
				WHERE T00.DivisionID = @DivisionID And T00.PayrollMethodID IN (SELECT DISTINCT PayrollMethodID FROM HT5411 Where DivisionID = @DivisionID )
				UNION 
				SELECT T00.DivisionID, T00.PayrollMethodID, T00.SubID AS IncomeID, RIGHT(T00.SubID, 2) AS Orders, -1 AS Signs, 
					--CASE @gnLang WHEN 0 THEN 'Caùc khoaûn giaûm tröø' ELSE 'Deduction' END AS Notes, 
					@Deduction AS Notes,
					CASE @gnLang WHEN 0 THEN T01.Caption ELSE T01.CaptionE END AS Caption
				FROM HT5006 T00 INNER JOIN HT0005 T01 ON T00.SubID = T01.SubID and T00.DivisionID = T01.DivisionID
				WHERE T00.DivisionID = @DivisionID And T00.PayrollMethodID IN (SELECT DISTINCT PayrollMethodID FROM HT5411  Where DivisionID = @DivisionID) 
				UNION 
				SELECT DISTINCT T00.DivisionID, T00.PayrollMethodID, 'S00' AS IncomeID, 0 AS Orders, -1 AS Signs, 
					--CASE @gnLang WHEN 0 THEN 'Caùc khoaûn giaûm tröø' ELSE 'Deduction' END AS Notes, 
					--CASE @gnLang WHEN 0 THEN 'Thueá TN' ELSE 'Income Tax' END AS Caption
					@Deduction AS Notes,@IncomeTax AS Caption
				FROM HT5006 T00 
				WHERE T00.DivisionID = @DivisionID And T00.PayrollMethodID IN (SELECT DISTINCT PayrollMethodID FROM HT5411 Where DivisionID = @DivisionID) 
		END

		ELSE
		BEGIN
			IF EXISTS (SELECT * FROM sysobjects WHERE name = 'T1' AND xtype = 'U')
				DROP TABLE T1
					
			CREATE TABLE T1 (DivisionID NVARCHAR(50))
			SET @sTable = 'INSERT INTO T1 SELECT ''' + REPLACE(@StrDivisionID,',',''' UNION ALL Select ''') + ''''
			EXEC (@sTable)

			SET @cur = CURSOR SCROLL KEYSET FOR
				SELECT T00.DivisionID, T00.PayrollMethodID, T00.IncomeID, RIGHT(T00.IncomeID, 2) AS Orders, 1 AS Signs, 
				   -- CASE @gnLang WHEN 0 THEN 'Tieàn löông' ELSE 'Gross Pay' END AS Notes, 
				   @GrossPay AS Notes, 
					CASE @gnLang WHEN 0 THEN T01.Caption ELSE T01.CaptionE END AS Caption
				FROM HT5005 T00 INNER JOIN HT0002 T01 ON T00.IncomeID = T01.IncomeID and T00.DivisionID = T01.DivisionID
				WHERE T00.DivisionID IN (Select DivisionID From T1) And T00.PayrollMethodID IN (SELECT DISTINCT PayrollMethodID FROM HT5411 Where DivisionID IN (Select DivisionID From T1))
				UNION 
				SELECT T00.DivisionID, T00.PayrollMethodID, T00.SubID AS IncomeID, RIGHT(T00.SubID, 2) AS Orders, -1 AS Signs, 
					--CASE @gnLang WHEN 0 THEN 'Caùc khoaûn giaûm tröø' ELSE 'Deduction' END AS Notes, 
					@Deduction AS Notes,
					CASE @gnLang WHEN 0 THEN T01.Caption ELSE T01.CaptionE END AS Caption
				FROM HT5006 T00 INNER JOIN HT0005 T01 ON T00.SubID = T01.SubID and T00.DivisionID = T01.DivisionID
				WHERE T00.DivisionID IN (Select DivisionID From T1) And T00.PayrollMethodID IN (SELECT DISTINCT PayrollMethodID FROM HT5411  Where DivisionID IN (Select DivisionID From T1)) 
				UNION 
				SELECT DISTINCT T00.DivisionID, T00.PayrollMethodID, 'S00' AS IncomeID, 0 AS Orders, -1 AS Signs, 
					--CASE @gnLang WHEN 0 THEN 'Caùc khoaûn giaûm tröø' ELSE 'Deduction' END AS Notes, 
					--CASE @gnLang WHEN 0 THEN 'Thueá TN' ELSE 'Income Tax' END AS Caption
					@Deduction AS Notes,@IncomeTax AS Caption
				FROM HT5006 T00 
				WHERE T00.DivisionID IN (Select DivisionID From T1) And T00.PayrollMethodID IN (SELECT DISTINCT PayrollMethodID FROM HT5411 Where DivisionID IN (Select DivisionID From T1))
		END

        OPEN @cur
        FETCH NEXT FROM @cur INTO @DivisionID1, @PayrollMethodID, @IncomeID, @Orders, @Signs, @Notes, @Caption

        WHILE @@FETCH_STATUS = 0 
            BEGIN
                SET @sSQL = '
                    INSERT INTO HT5401 
                    SELECT DivisionID, EmployeeID, DepartmentID, HV2408.DepartmentName, InsuranceSalary, 
                        Orders, TeamID, N''' + @Notes + ''' AS Notes, ''' + @IncomeID + ''' AS IncomeID, ' + 
                        CAST(@Signs AS NVARCHAR(50)) + ' AS Signs, ' + CASE WHEN @Signs = 1 THEN 'Income' ELSE '-SubAmount' END + 
                        CASE WHEN @Orders < 10 THEN '0' ELSE '' END + CAST(@Orders AS NVARCHAR(50)) + ' AS Amount, N''' + @Caption + ''' AS Caption, '
                        + CAST(@Orders AS NVARCHAR(50)) + ' AS FOrders
                    FROM HT5411 HV2408 WHERE HV2408.DivisionID = '''+@DivisionID1+''' And PayrollMethodID = ''' + @PayrollMethodID + '''
                '
--PRINT(@sSQL)

				-- PRINT (N'B')
                EXEC (@sSQL)

                FETCH NEXT FROM @cur INTO @DivisionID1, @PayrollMethodID, @IncomeID, @Orders, @Signs, @Notes, @Caption
            END

        SET @sSQL = '
            SELECT HV1400.DivisionID, HV2410.EmployeeID, HV1400.FullName, HV2410.DepartmentID, HV2410.DepartmentName, 
                HV1400.Birthday, avg( HV2410.InsuranceSalary) AS InsuranceSalary, 
                HV2410.Orders, HV1400.DutyName, HV2410.TeamID, HV2410.Notes, HV2410.IncomeID, 
                HV2410.Signs, HV2410.Caption, HV2410.FOrders, SUM(HV2410.Amount) AS Amount, 
                HV1400.Notes AS Note2, BankAccountNo '+@sSQL1+'
            FROM HT5401 HV2410 
            INNER JOIN HV1400 ON HV1400.EmployeeID = HV2410.EmployeeID and HV1400.DivisionID = HV2410.DivisionID
            '+@sFrom+'
            Where HV2410.DivisionID '+@StrDivisionID_New+'
            GROUP BY HV1400.DivisionID, HV2410.EmployeeID, HV1400.FullName, HV2410.DepartmentID, HV2410.DepartmentName, HV1400.Birthday, 
                HV2410.Orders, HV1400.DutyName, HV2410.TeamID, HV2410.Notes, HV2410.IncomeID, HV2410.Signs, 
                HV2410.Caption, HV2410.FOrders, HV1400.Notes, BankAccountNo '+@sGroup+' '

--PRINT(@sSQL)
        IF NOT EXISTS (SELECT 1 FROM sysObjects WHERE XType = 'V' AND Name = 'HV2409')
            EXEC('---- tao boi HP2512
                CREATE VIEW HV2409 AS ' + @sSQL)
        ELSE 
            EXEC('---- tao boi HP2512
                ALTER VIEW HV2409 AS ' + @sSQL)
    END
ELSE -----Neu don vi khong tinh thue thu nhap
    BEGIN 
       SET @sSQL = 'INSERT INTO HT5411
			    SELECT T00.DivisionID, T00.EmployeeID, FullName, T00.DepartmentID, V00.DepartmentName, V00.Birthday, PayrollMethodID, V00.Orders AS Orders, 
					ISNULL(DutyName, '''') AS DutyName, ISNULL(T00.TeamID, '''') AS TeamID, ISNULL(T02.InsuranceSalary, 0) AS InsuranceSalary, 
			        ISNULL(Income01, 0) AS Income01, ISNULL(Income02, 0) AS Income02, ISNULL(Income03, 0) AS Income03, ISNULL(Income04, 0) AS Income04, ISNULL(Income05, 0) AS Income05, 
					ISNULL(Income06, 0) AS Income06, ISNULL(Income07, 0) AS Income07, ISNULL(Income08, 0) AS Income08, ISNULL(Income09, 0) AS Income09, ISNULL(Income10, 0) AS Income10, 
			        ISNULL(Income11, 0) AS Income11, ISNULL(Income12, 0) AS Income12, ISNULL(Income13, 0) AS Income13, ISNULL(Income14, 0) AS Income14, ISNULL(Income15, 0) AS Income15, 
					ISNULL(Income16, 0) AS Income16, ISNULL(Income17, 0) AS Income17, ISNULL(Income18, 0) AS Income18, ISNULL(Income19, 0) AS Income19, ISNULL(Income20, 0) AS Income20,
			        ISNULL(Income21, 0) AS Income21, ISNULL(Income22, 0) AS Income22, ISNULL(Income23, 0) AS Income23, ISNULL(Income24, 0) AS Income24, ISNULL(Income25, 0) AS Income25, 
					ISNULL(Income26, 0) AS Income26, ISNULL(Income27, 0) AS Income27, ISNULL(Income28, 0) AS Income28, ISNULL(Income29, 0) AS Income29, ISNULL(Income30, 0) AS Income30,
					ISNULL(Income31,0) AS Income31, ISNULL(Income32,0) AS Income32, ISNULL(Income33,0) AS Income33, ISNULL(Income34,0) AS Income34, ISNULL(Income35,0) AS Income35, 
					ISNULL(Income36,0) AS Income36, ISNULL(Income37,0) AS Income37, ISNULL(Income38,0) AS Income38, ISNULL(Income39,0) AS Income39, ISNULL(Income40,0) AS Income40, 
					ISNULL(Income41,0) AS Income41, ISNULL(Income42,0) AS Income42, ISNULL(Income43,0) AS Income43, ISNULL(Income44,0) AS Income44, ISNULL(Income45,0) AS Income45, 
					ISNULL(Income46,0) AS Income46, ISNULL(Income47,0) AS Income47, ISNULL(Income48,0) AS Income48, ISNULL(Income49,0) AS Income49, ISNULL(Income50,0) AS Income50, 
					ISNULL(Income51,0) AS Income51, ISNULL(Income52,0) AS Income52, ISNULL(Income53,0) AS Income53, ISNULL(Income54,0) AS Income54, ISNULL(Income55,0) AS Income55, 
					ISNULL(Income56,0) AS Income56, ISNULL(Income57,0) AS Income57, ISNULL(Income58,0) AS Income58, ISNULL(Income59,0) AS Income59, ISNULL(Income60,0) AS Income60, 
					ISNULL(Income61,0) AS Income61, ISNULL(Income62,0) AS Income62, ISNULL(Income63,0) AS Income63, ISNULL(Income64,0) AS Income64, ISNULL(Income65,0) AS Income65, 
					ISNULL(Income66,0) AS Income66, ISNULL(Income67,0) AS Income67, ISNULL(Income68,0) AS Income68, ISNULL(Income69,0) AS Income69, ISNULL(Income70,0) AS Income70, 
					ISNULL(Income71,0) AS Income71, ISNULL(Income72,0) AS Income72, ISNULL(Income73,0) AS Income73, ISNULL(Income74,0) AS Income74, ISNULL(Income75,0) AS Income75, 
					ISNULL(Income76,0) AS Income76, ISNULL(Income77,0) AS Income77, ISNULL(Income78,0) AS Income78, ISNULL(Income79,0) AS Income79, ISNULL(Income80,0) AS Income80, 
					ISNULL(Income81,0) AS Income81, ISNULL(Income82,0) AS Income82, ISNULL(Income83,0) AS Income83, ISNULL(Income84,0) AS Income84, ISNULL(Income85,0) AS Income85, 
					ISNULL(Income86,0) AS Income86, ISNULL(Income87,0) AS Income87, ISNULL(Income88,0) AS Income88, ISNULL(Income89,0) AS Income89, ISNULL(Income90,0) AS Income90, 
					ISNULL(Income91,0) AS Income91, ISNULL(Income92,0) AS Income92, ISNULL(Income93,0) AS Income93, ISNULL(Income94,0) AS Income94, ISNULL(Income95,0) AS Income95, 
					ISNULL(Income96,0) AS Income96, ISNULL(Income97,0) AS Income97, ISNULL(Income98,0) AS Income98, ISNULL(Income99,0) AS Income99, ISNULL(Income100,0) AS Income100, 
					ISNULL(Income101,0) AS Income101, ISNULL(Income102,0) AS Income102, ISNULL(Income103,0) AS Income103, ISNULL(Income104,0) AS Income104, ISNULL(Income105,0) AS Income105,'
					SET @sSQL4 = '
					ISNULL(Income106,0) AS Income106, ISNULL(Income107,0) AS Income107, ISNULL(Income108,0) AS Income108, ISNULL(Income109,0) AS Income109, ISNULL(Income110,0) AS Income110, 
					ISNULL(Income111,0) AS Income111, ISNULL(Income112,0) AS Income112, ISNULL(Income113,0) AS Income113, ISNULL(Income114,0) AS Income114, ISNULL(Income115,0) AS Income115, 
					ISNULL(Income116,0) AS Income116, ISNULL(Income117,0) AS Income117, ISNULL(Income118,0) AS Income118, ISNULL(Income119,0) AS Income119, ISNULL(Income120,0) AS Income120, 
					ISNULL(Income121,0) AS Income121, ISNULL(Income122,0) AS Income122, ISNULL(Income123,0) AS Income123, ISNULL(Income124,0) AS Income124, ISNULL(Income125,0) AS Income125, 
					ISNULL(Income126,0) AS Income126, ISNULL(Income127,0) AS Income127, ISNULL(Income128,0) AS Income128, ISNULL(Income129,0) AS Income129, ISNULL(Income130,0) AS Income130, 
					ISNULL(Income131,0) AS Income131, ISNULL(Income132,0) AS Income132, ISNULL(Income133,0) AS Income133, ISNULL(Income134,0) AS Income134, ISNULL(Income135,0) AS Income135, 
					ISNULL(Income136,0) AS Income136, ISNULL(Income137,0) AS Income137, ISNULL(Income138,0) AS Income138, ISNULL(Income139,0) AS Income139, ISNULL(Income140,0) AS Income140, 
					ISNULL(Income141,0) AS Income141, ISNULL(Income142,0) AS Income142, ISNULL(Income143,0) AS Income143, ISNULL(Income144,0) AS Income144, ISNULL(Income145,0) AS Income145, 
					ISNULL(Income146,0) AS Income146, ISNULL(Income147,0) AS Income147, ISNULL(Income148,0) AS Income148, ISNULL(Income149,0) AS Income149, ISNULL(Income150,0) AS Income150,
					ISNULL(Income151,0) AS Income151, ISNULL(Income152,0) AS Income152, ISNULL(Income153,0) AS Income153, ISNULL(Income154,0) AS Income154, ISNULL(Income155,0) AS Income155, 
					ISNULL(Income156,0) AS Income156, ISNULL(Income157,0) AS Income157, ISNULL(Income158,0) AS Income158, ISNULL(Income159,0) AS Income159, ISNULL(Income160,0) AS Income160,
					ISNULL(Income161,0) AS Income161, ISNULL(Income162,0) AS Income162, ISNULL(Income163,0) AS Income163, ISNULL(Income164,0) AS Income164, ISNULL(Income165,0) AS Income165, 
					ISNULL(Income166,0) AS Income166, ISNULL(Income167,0) AS Income167, ISNULL(Income168,0) AS Income168, ISNULL(Income169,0) AS Income169, ISNULL(Income170,0) AS Income170, 
					ISNULL(Income171,0) AS Income171, ISNULL(Income172,0) AS Income172, ISNULL(Income173,0) AS Income173, ISNULL(Income174,0) AS Income174, ISNULL(Income175,0) AS Income175, 
					ISNULL(Income176,0) AS Income176, ISNULL(Income177,0) AS Income177, ISNULL(Income178,0) AS Income178, ISNULL(Income179,0) AS Income179, ISNULL(Income180,0) AS Income180, 
					ISNULL(Income181,0) AS Income181, ISNULL(Income182,0) AS Income182, ISNULL(Income183,0) AS Income183, ISNULL(Income184,0) AS Income184, ISNULL(Income185,0) AS Income185, 
					ISNULL(Income186,0) AS Income186, ISNULL(Income187,0) AS Income187, ISNULL(Income188,0) AS Income188, ISNULL(Income189,0) AS Income189, ISNULL(Income190,0) AS Income190, 
					ISNULL(Income191,0) AS Income191, ISNULL(Income192,0) AS Income192, ISNULL(Income193,0) AS Income193, ISNULL(Income194,0) AS Income194, ISNULL(Income195,0) AS Income195, 
					ISNULL(Income196,0) AS Income196, ISNULL(Income197,0) AS Income197, ISNULL(Income198,0) AS Income198, ISNULL(Income199,0) AS Income199, ISNULL(Income200,0) AS Income200,'
					SET @sSQL8 = '
			        ISNULL(SubAmount01,0) AS SubAmount01, ISNULL(SubAmount02,0) AS SubAmount02, ISNULL(SubAmount03,0) AS SubAmount03, ISNULL(SubAmount04,0) AS SubAmount04, 
			        ISNULL(SubAmount05,0) AS SubAmount05, ISNULL(SubAmount06,0) AS SubAmount06, ISNULL(SubAmount07,0) AS SubAmount07, ISNULL(SubAmount08,0) AS SubAmount08, 
			        ISNULL(SubAmount09,0) AS SubAmount09, ISNULL(SubAmount10,0) AS SubAmount10, ISNULL(SubAmount11,0) AS SubAmount11, ISNULL(SubAmount12,0) AS SubAmount12, 
			        ISNULL(SubAmount13,0) AS SubAmount13, ISNULL(SubAmount14,0) AS SubAmount14, ISNULL(SubAmount15,0) AS SubAmount15, ISNULL(SubAmount16,0) AS SubAmount16, 
			        ISNULL(SubAmount17,0) AS SubAmount17, ISNULL(SubAmount18,0) AS SubAmount18, ISNULL(SubAmount19,0) AS SubAmount19, ISNULL(SubAmount20,0) AS SubAmount20, 
					ISNULL(SubAmount21,0) AS SubAmount21, ISNULL(SubAmount22,0) AS SubAmount22, ISNULL(SubAmount23,0) AS SubAmount23, ISNULL(SubAmount24,0) AS SubAmount24, 
					ISNULL(SubAmount25,0) AS SubAmount25, ISNULL(SubAmount26,0) AS SubAmount26, ISNULL(SubAmount27,0) AS SubAmount27, ISNULL(SubAmount28,0) AS SubAmount28, 
					ISNULL(SubAmount29,0) AS SubAmount29, ISNULL(SubAmount30,0) AS SubAmount30, ISNULL(SubAmount31,0) AS SubAmount31, ISNULL(SubAmount32,0) AS SubAmount32, 
					ISNULL(SubAmount33,0) AS SubAmount33, ISNULL(SubAmount34,0) AS SubAmount34, ISNULL(SubAmount35,0) AS SubAmount35, ISNULL(SubAmount36,0) AS SubAmount36, 
					ISNULL(SubAmount37,0) AS SubAmount37, ISNULL(SubAmount38,0) AS SubAmount38, ISNULL(SubAmount39,0) AS SubAmount39, ISNULL(SubAmount40,0) AS SubAmount40, 
					ISNULL(SubAmount41,0) AS SubAmount41, ISNULL(SubAmount42,0) AS SubAmount42, ISNULL(SubAmount43,0) AS SubAmount43, ISNULL(SubAmount44,0) AS SubAmount44, 
					ISNULL(SubAmount45,0) AS SubAmount45, ISNULL(SubAmount46,0) AS SubAmount46, ISNULL(SubAmount47,0) AS SubAmount47, ISNULL(SubAmount48,0) AS SubAmount48, 
					ISNULL(SubAmount49,0) AS SubAmount49, ISNULL(SubAmount50,0) AS SubAmount50, ISNULL(SubAmount51,0) AS SubAmount51, ISNULL(SubAmount52,0) AS SubAmount52, 
					ISNULL(SubAmount53,0) AS SubAmount53, ISNULL(SubAmount54,0) AS SubAmount54, ISNULL(SubAmount55,0) AS SubAmount55, ISNULL(SubAmount56,0) AS SubAmount56, 
					ISNULL(SubAmount57,0) AS SubAmount57, ISNULL(SubAmount58,0) AS SubAmount58, ISNULL(SubAmount59,0) AS SubAmount59,'
					SET @sSQL5 = '
			        ISNULL(SubAmount60,0) AS SubAmount60, ISNULL(SubAmount61,0) AS SubAmount61, ISNULL(SubAmount62,0) AS SubAmount62, ISNULL(SubAmount63,0) AS SubAmount63, ISNULL(SubAmount64,0) AS SubAmount64, 
					ISNULL(SubAmount65,0) AS SubAmount65, ISNULL(SubAmount66,0) AS SubAmount66, ISNULL(SubAmount67,0) AS SubAmount67, ISNULL(SubAmount68,0) AS SubAmount68, 
					ISNULL(SubAmount69,0) AS SubAmount69, ISNULL(SubAmount70,0) AS SubAmount70, ISNULL(SubAmount71,0) AS SubAmount71, ISNULL(SubAmount72,0) AS SubAmount72, 
					ISNULL(SubAmount73,0) AS SubAmount73, ISNULL(SubAmount74,0) AS SubAmount74, ISNULL(SubAmount75,0) AS SubAmount75, ISNULL(SubAmount76,0) AS SubAmount76, 
					ISNULL(SubAmount77,0) AS SubAmount77, ISNULL(SubAmount78,0) AS SubAmount78, ISNULL(SubAmount79,0) AS SubAmount79, ISNULL(SubAmount80,0) AS SubAmount80, 
					ISNULL(SubAmount81,0) AS SubAmount81, ISNULL(SubAmount82,0) AS SubAmount82, ISNULL(SubAmount83,0) AS SubAmount83, ISNULL(SubAmount84,0) AS SubAmount84, 
					ISNULL(SubAmount85,0) AS SubAmount85, ISNULL(SubAmount86,0) AS SubAmount86, ISNULL(SubAmount87,0) AS SubAmount87, ISNULL(SubAmount88,0) AS SubAmount88, 
					ISNULL(SubAmount89,0) AS SubAmount89, ISNULL(SubAmount90,0) AS SubAmount90, ISNULL(SubAmount91,0) AS SubAmount91, ISNULL(SubAmount92,0) AS SubAmount92, 
					ISNULL(SubAmount93,0) AS SubAmount93, ISNULL(SubAmount94,0) AS SubAmount94, ISNULL(SubAmount95,0) AS SubAmount95, ISNULL(SubAmount96,0) AS SubAmount96, 
					ISNULL(SubAmount97,0) AS SubAmount97, ISNULL(SubAmount98,0) AS SubAmount98, ISNULL(SubAmount99,0) AS SubAmount99, ISNULL(SubAmount100,0) AS SubAmount100,
					ISNULL(TaxAmount, 0) AS SubAmount00
			   	FROM HT3400 T00 				
				INNER JOIN HV1400 V00 ON V00.EmployeeID = T00.EmployeeID and V00.DivisionID = T00.DivisionID 
				INNER JOIN AT1102 T01 ON T01.DepartmentID = T00.DepartmentID 
				INNER JOIN HT2400 T02 ON T02.DivisionID = T00.DivisionID  and T02.EmployeeID = T00.EmployeeID AND T02.TranMonth = T00.TranMonth 
									AND T02.TranYear = T00.TranYear AND T02.DepartmentID = T00.DepartmentID AND ISNULL(T02.TeamID, '''') = ISNULL(T00.TeamID, '''')
				LEFT JOIN HT3499 T03 ON T03.DivisionID = T00.DivisionID AND T03.TransactionID = T00.TransactionID
			    WHERE T00.DivisionID '+@StrDivisionID_New+' 
					AND T00.DepartmentID BETWEEN ''' + ISNULL(@FromDepartmentID,'') + ''' AND ''' + ISNULL(@ToDepartmentID,'') + ''' 
			        '+CASE WHEN ISNULL(@Condition,'') <> '' THEN ' AND isnull(T00.DepartmentID,''#'') in ('+ISNULL(@Condition,'')+')' ELSE '' END +' 
			        AND ISNULL(T00.TeamID, '''') LIKE ''' + ISNULL(@TeamID,'') + ''' 
					AND T00.EmployeeID BETWEEN ''' + @FromEmployeeID + ''' AND ''' + @ToEmployeeID + ''' 
					AND T00.TranMonth + T00.TranYear*100 BETWEEN ' + CAST(@FromMonth + @FromYear*100 AS NVARCHAR(10)) + ' AND ' + CAST(@ToMonth + @ToYear*100 AS NVARCHAR(10)) + ' 
					AND PayrollMethodID ' + ISNULL(@lstPayrollMethodID,'') + @sSQL_Where	

		EXEC(@sSQL+@sSQL4+@sSQL8+@sSQL5) 
		/*
        IF EXISTS (SELECT 1 FROM sysObjects WHERE XType = 'V' AND Name = 'HV2408') 
        DROP VIEW HV2408
        EXEC('---- tao boi HP2512
            CREATE VIEW HV2408 AS ' + @sSQL)
        */  

        SET @sSQL = ''

		IF ISNULL(@StrDivisionID,'') = ''
		BEGIN			
			SET @cur = CURSOR SCROLL KEYSET FOR
				SELECT T00.DivisionID, T00.PayrollMethodID, T00.IncomeID, RIGHT(T00.IncomeID, 2) AS Orders, 1 AS Signs, 
					--CASE @gnLang WHEN 0 THEN 'Tieàn löông' ELSE 'Gross Pay' END AS Notes, 
					 @GrossPay AS Notes,
				   CASE @gnLang WHEN 0 THEN T01.Caption ELSE T01.CaptionE END AS Caption               
				FROM HT5005 T00 INNER JOIN HT0002 T01 ON T00.IncomeID = T01.IncomeID and T00.DivisionID = T01.DivisionID
				WHERE T00.DivisionID = @DivisionID And T00.PayrollMethodID IN (SELECT DISTINCT PayrollMethodID FROM HT5411 Where DivisionID = @DivisionID) 
				UNION 
				SELECT T00.DivisionID, T00.PayrollMethodID, T00.SubID AS IncomeID, RIGHT(T00.SubID, 2) AS Orders, -1 AS Signs, 
					--CASE @gnLang WHEN 0 THEN 'Caùc khoaûn giaûm tröø' ELSE 'Deduction' END AS Notes, 
					@Deduction AS Notes,
					CASE @gnLang WHEN 0 THEN T01.Caption ELSE T01.CaptionE END AS Caption
				FROM HT5006 T00 INNER JOIN HT0005 T01 ON T00.SubID = T01.SubID and T00.DivisionID = T01.DivisionID
				WHERE T00.DivisionID = @DivisionID And T00.PayrollMethodID IN (SELECT DISTINCT PayrollMethodID FROM HT5411 Where DivisionID = @DivisionID) 
		END
		ELSE
		BEGIN
			IF EXISTS (SELECT * FROM sysobjects WHERE name = 'T1' AND xtype = 'U')
				DROP TABLE T1			
			
			CREATE TABLE T1 (DivisionID NVARCHAR(50))
			SET @sTable = 'INSERT INTO T1 SELECT ''' + REPLACE(@StrDivisionID,',',''' UNION ALL Select ''') + ''''
			EXEC (@sTable)

			SET @cur = CURSOR SCROLL KEYSET FOR	
				SELECT T00.DivisionID, T00.PayrollMethodID, T00.IncomeID, RIGHT(T00.IncomeID, 2) AS Orders, 1 AS Signs, 
					--CASE @gnLang WHEN 0 THEN 'Tieàn löông' ELSE 'Gross Pay' END AS Notes, 
					 @GrossPay AS Notes,
				   CASE @gnLang WHEN 0 THEN T01.Caption ELSE T01.CaptionE END AS Caption               
				FROM HT5005 T00 INNER JOIN HT0002 T01 ON T00.IncomeID = T01.IncomeID and T00.DivisionID = T01.DivisionID
				WHERE T00.DivisionID IN (Select DivisionID From T1) And T00.PayrollMethodID IN (SELECT DISTINCT PayrollMethodID FROM HT5411 Where DivisionID IN (Select DivisionID From T1)) 
				UNION 
				SELECT T00.DivisionID, T00.PayrollMethodID, T00.SubID AS IncomeID, RIGHT(T00.SubID, 2) AS Orders, -1 AS Signs, 
					--CASE @gnLang WHEN 0 THEN 'Caùc khoaûn giaûm tröø' ELSE 'Deduction' END AS Notes, 
					@Deduction AS Notes,
					CASE @gnLang WHEN 0 THEN T01.Caption ELSE T01.CaptionE END AS Caption
				FROM HT5006 T00 INNER JOIN HT0005 T01 ON T00.SubID = T01.SubID and T00.DivisionID = T01.DivisionID
				WHERE T00.DivisionID IN (Select DivisionID From T1) And T00.PayrollMethodID IN (SELECT DISTINCT PayrollMethodID FROM HT5411 Where DivisionID IN (Select DivisionID From T1))
		END

        OPEN @cur FETCH NEXT FROM @cur INTO @DivisionID1, @PayrollMethodID, @IncomeID, @Orders, @Signs, @Notes, @Caption

        WHILE @@FETCH_STATUS = 0 
            BEGIN
                SET @sSQL = N'
                    INSERT INTO HT5401 SELECT DivisionID,EmployeeID, DepartmentID, HV2408.DepartmentName, InsuranceSalary, 
                        Orders, TeamID, N''' + @Notes + ''' AS Notes, ''' + @IncomeID + ''' AS IncomeID, ' + 
                        CAST(@Signs AS NVARCHAR(50)) + ' AS Signs, ' + CASE WHEN @Signs = 1 THEN 'Income' ELSE '-SubAmount' END + 
                        CASE WHEN @Orders < 10 THEN '0' ELSE '' END + CAST(@Orders AS NVARCHAR(50)) + ' AS Amount, N''' + @Caption + ''' AS Caption, '
                        + CAST(@Orders AS NVARCHAR(50)) + ' AS FOrders
                    FROM HT5411 HV2408 WHERE HV2408.DivisionID = '''+@DivisionID1+''' And PayrollMethodID = ''' + @PayrollMethodID + ''''

					
		-- PRINT (N'E')
              EXEC (@sSQL)

                FETCH NEXT FROM @cur INTO @DivisionID1, @PayrollMethodID, @IncomeID, @Orders, @Signs, @Notes, @Caption
            END

        SET @sSQL = '
            SELECT HV1400.DivisionID, HV2410.EmployeeID, HV1400.FullName, HV2410.DepartmentID, HV2410.DepartmentName, 
                HV1400.Birthday, avg( HV2410.InsuranceSalary) AS InsuranceSalary, 
                HV2410.Orders, HV1400.DutyName, HV2410.TeamID, HV2410.Notes, HV2410.IncomeID, 
                HV2410.Signs, HV2410.Caption, HV2410.FOrders, SUM(HV2410.Amount) AS Amount, 
                HV1400.Notes AS Note2, BankAccountNo '+@sSQL1+'
            FROM HT5401 HV2410 INNER JOIN HV1400 ON HV1400.EmployeeID = HV2410.EmployeeID and HV1400.DivisionID = HV2410.DivisionID
            '+@sFrom+'
            Where HV2410.DivisionID '+@StrDivisionID_New+'
            GROUP BY HV1400.DivisionID, HV2410.EmployeeID, HV1400.FullName, HV2410.DepartmentID, HV2410.DepartmentName, HV1400.Birthday, 
                HV2410.Orders, HV1400.DutyName, HV2410.TeamID, HV2410.Notes, HV2410.IncomeID, HV2410.Signs, 
                HV2410.Caption, HV2410.FOrders, HV1400.Notes, BankAccountNo '+@sGroup+ ''

        -------------------------------------------------------------------------------------------------------------------------------
        --PRINT(@sSQL)
        IF NOT EXISTS (SELECT 1 FROM sysObjects WHERE XType = 'V' AND Name = 'HV2409')
            EXEC('---- tao boi HP2512
                CREATE VIEW HV2409 AS ' + @sSQL)
        ELSE 
            EXEC('---- tao boi HP2512
                ALTER VIEW HV2409 AS ' + @sSQL)
    END
    
-------------------------------------
-- Tao view in lương theo công trình.
-------------------------------------
SET @sSQL = '
            SELECT T00.DivisionID, T00.EmployeeID, FullName, T00.DepartmentID, V00.DepartmentName, V00.Birthday, PayrollMethodID, 
                V00.Orders AS Orders, V00.DutyID, ISNULL(DutyName, '''') AS DutyName, ISNULL(T00.TeamID, '''') AS TeamID, ---T02.BaseSalary,
                (select BaseSalary From HT2400 Where DivisionID = T00.DivisionID And EmployeeID = T00.EmployeeID AND TranMonth = T00.TranMonth
                AND TranYear = T00.TranYear AND DepartmentID = T00.DepartmentID AND ISNULL(TeamID, '''') = ISNULL(T00.TeamID, '''')) as BaseSalary,
                ISNULL(T00.Income01, 0) AS Income01, ISNULL(T00.Income02, 0) AS Income02, ISNULL(T00.Income03, 0) AS Income03, ISNULL(T00.Income04, 0) AS Income04, ISNULL(T00.Income05, 0) AS Income05, 
				ISNULL(T00.Income06, 0) AS Income06, ISNULL(T00.Income07, 0) AS Income07, ISNULL(T00.Income08, 0) AS Income08, ISNULL(T00.Income09, 0) AS Income09, ISNULL(T00.Income10, 0) AS Income10, 
                ISNULL(T00.Income11, 0) AS Income11, ISNULL(T00.Income12, 0) AS Income12, ISNULL(T00.Income13, 0) AS Income13, ISNULL(T00.Income14, 0) AS Income14, ISNULL(T00.Income15, 0) AS Income15, 
				ISNULL(T00.Income16, 0) AS Income16, ISNULL(T00.Income17, 0) AS Income17, ISNULL(T00.Income18, 0) AS Income18, ISNULL(T00.Income19, 0) AS Income19, ISNULL(T00.Income20, 0) AS Income20,
                ISNULL(T00.Income21, 0) AS Income21, ISNULL(T00.Income22, 0) AS Income22, ISNULL(T00.Income23, 0) AS Income23, ISNULL(T00.Income24, 0) AS Income24, ISNULL(T00.Income25, 0) AS Income25, 
				ISNULL(T00.Income26, 0) AS Income26, ISNULL(T00.Income27, 0) AS Income27, ISNULL(T00.Income28, 0) AS Income28, ISNULL(T00.Income29, 0) AS Income29, ISNULL(T00.Income30, 0) AS Income30,
				ISNULL(T03.Income31,0) AS Income31, ISNULL(T03.Income32,0) AS Income32, ISNULL(T03.Income33,0) AS Income33, ISNULL(T03.Income34,0) AS Income34, ISNULL(T03.Income35,0) AS Income35, 
				ISNULL(T03.Income36,0) AS Income36, ISNULL(T03.Income37,0) AS Income37, ISNULL(T03.Income38,0) AS Income38, ISNULL(T03.Income39,0) AS Income39, ISNULL(T03.Income40,0) AS Income40, 
				ISNULL(T03.Income41,0) AS Income41, ISNULL(T03.Income42,0) AS Income42, ISNULL(T03.Income43,0) AS Income43, ISNULL(T03.Income44,0) AS Income44, ISNULL(T03.Income45,0) AS Income45, 
				ISNULL(T03.Income46,0) AS Income46, ISNULL(T03.Income47,0) AS Income47, ISNULL(T03.Income48,0) AS Income48, ISNULL(T03.Income49,0) AS Income49, ISNULL(T03.Income50,0) AS Income50, 
				ISNULL(T03.Income51,0) AS Income51, ISNULL(T03.Income52,0) AS Income52, ISNULL(T03.Income53,0) AS Income53, ISNULL(T03.Income54,0) AS Income54, ISNULL(T03.Income55,0) AS Income55, 
				ISNULL(T03.Income56,0) AS Income56, ISNULL(T03.Income57,0) AS Income57, ISNULL(T03.Income58,0) AS Income58, ISNULL(T03.Income59,0) AS Income59, ISNULL(T03.Income60,0) AS Income60, 
				ISNULL(T03.Income61,0) AS Income61, ISNULL(T03.Income62,0) AS Income62, ISNULL(T03.Income63,0) AS Income63, ISNULL(T03.Income64,0) AS Income64, ISNULL(T03.Income65,0) AS Income65, 
				ISNULL(T03.Income66,0) AS Income66, ISNULL(T03.Income67,0) AS Income67, ISNULL(T03.Income68,0) AS Income68, ISNULL(T03.Income69,0) AS Income69, ISNULL(T03.Income70,0) AS Income70, 
				ISNULL(T03.Income71,0) AS Income71, ISNULL(T03.Income72,0) AS Income72, ISNULL(T03.Income73,0) AS Income73, ISNULL(T03.Income74,0) AS Income74, ISNULL(T03.Income75,0) AS Income75, 
				ISNULL(T03.Income76,0) AS Income76, ISNULL(T03.Income77,0) AS Income77, ISNULL(T03.Income78,0) AS Income78, ISNULL(T03.Income79,0) AS Income79, ISNULL(T03.Income80,0) AS Income80, 
				ISNULL(T03.Income81,0) AS Income81, ISNULL(T03.Income82,0) AS Income82, ISNULL(T03.Income83,0) AS Income83, ISNULL(T03.Income84,0) AS Income84, ISNULL(T03.Income85,0) AS Income85, 
				ISNULL(T03.Income86,0) AS Income86, ISNULL(T03.Income87,0) AS Income87, ISNULL(T03.Income88,0) AS Income88, ISNULL(T03.Income89,0) AS Income89, ISNULL(T03.Income90,0) AS Income90, '
		SET @sSQL4 = '
				ISNULL(T03.Income91,0) AS Income91, ISNULL(T03.Income92,0) AS Income92, ISNULL(T03.Income93,0) AS Income93, ISNULL(T03.Income94,0) AS Income94, ISNULL(T03.Income95,0) AS Income95, 
				ISNULL(T03.Income96,0) AS Income96, ISNULL(T03.Income97,0) AS Income97, ISNULL(T03.Income98,0) AS Income98, ISNULL(T03.Income99,0) AS Income99, ISNULL(T03.Income100,0) AS Income100, 
				ISNULL(T03.Income101,0) AS Income101, ISNULL(T03.Income102,0) AS Income102, ISNULL(T03.Income103,0) AS Income103, ISNULL(T03.Income104,0) AS Income104, ISNULL(T03.Income105,0) AS Income105,
				ISNULL(T03.Income106,0) AS Income106, ISNULL(T03.Income107,0) AS Income107, ISNULL(T03.Income108,0) AS Income108, ISNULL(T03.Income109,0) AS Income109, ISNULL(T03.Income110,0) AS Income110, 
				ISNULL(T03.Income111,0) AS Income111, ISNULL(T03.Income112,0) AS Income112, ISNULL(T03.Income113,0) AS Income113, ISNULL(T03.Income114,0) AS Income114, ISNULL(T03.Income115,0) AS Income115, 
				ISNULL(T03.Income116,0) AS Income116, ISNULL(T03.Income117,0) AS Income117, ISNULL(T03.Income118,0) AS Income118, ISNULL(T03.Income119,0) AS Income119, ISNULL(T03.Income120,0) AS Income120, 
				ISNULL(T03.Income121,0) AS Income121, ISNULL(T03.Income122,0) AS Income122, ISNULL(T03.Income123,0) AS Income123, ISNULL(T03.Income124,0) AS Income124, ISNULL(T03.Income125,0) AS Income125, 
				ISNULL(T03.Income126,0) AS Income126, ISNULL(T03.Income127,0) AS Income127, ISNULL(T03.Income128,0) AS Income128, ISNULL(T03.Income129,0) AS Income129, ISNULL(T03.Income130,0) AS Income130, 
				ISNULL(T03.Income131,0) AS Income131, ISNULL(T03.Income132,0) AS Income132, ISNULL(T03.Income133,0) AS Income133, ISNULL(T03.Income134,0) AS Income134, ISNULL(T03.Income135,0) AS Income135, 
				ISNULL(T03.Income136,0) AS Income136, ISNULL(T03.Income137,0) AS Income137, ISNULL(T03.Income138,0) AS Income138, ISNULL(T03.Income139,0) AS Income139, ISNULL(T03.Income140,0) AS Income140, 
				ISNULL(T03.Income141,0) AS Income141, ISNULL(T03.Income142,0) AS Income142, ISNULL(T03.Income143,0) AS Income143, ISNULL(T03.Income144,0) AS Income144, ISNULL(T03.Income145,0) AS Income145, 
				ISNULL(T03.Income146,0) AS Income146, ISNULL(T03.Income147,0) AS Income147, ISNULL(T03.Income148,0) AS Income148, ISNULL(T03.Income149,0) AS Income149, ISNULL(T03.Income150,0) AS Income150,
				ISNULL(T03.Income151,0) AS Income151, ISNULL(T03.Income152,0) AS Income152, ISNULL(T03.Income153,0) AS Income153, ISNULL(T03.Income154,0) AS Income154, ISNULL(T03.Income155,0) AS Income155, 
				ISNULL(T03.Income156,0) AS Income156, ISNULL(T03.Income157,0) AS Income157, ISNULL(T03.Income158,0) AS Income158, ISNULL(T03.Income159,0) AS Income159, ISNULL(T03.Income160,0) AS Income160,
				ISNULL(T03.Income161,0) AS Income161, ISNULL(T03.Income162,0) AS Income162, ISNULL(T03.Income163,0) AS Income163, ISNULL(T03.Income164,0) AS Income164, ISNULL(T03.Income165,0) AS Income165, 
				ISNULL(T03.Income166,0) AS Income166, ISNULL(T03.Income167,0) AS Income167, ISNULL(T03.Income168,0) AS Income168, ISNULL(T03.Income169,0) AS Income169, ISNULL(T03.Income170,0) AS Income170, 
				ISNULL(T03.Income171,0) AS Income171, ISNULL(T03.Income172,0) AS Income172, ISNULL(T03.Income173,0) AS Income173, ISNULL(T03.Income174,0) AS Income174, ISNULL(T03.Income175,0) AS Income175, 
				ISNULL(T03.Income176,0) AS Income176, ISNULL(T03.Income177,0) AS Income177, ISNULL(T03.Income178,0) AS Income178, ISNULL(T03.Income179,0) AS Income179, ISNULL(T03.Income180,0) AS Income180, 
				ISNULL(T03.Income181,0) AS Income181, ISNULL(T03.Income182,0) AS Income182, ISNULL(T03.Income183,0) AS Income183, ISNULL(T03.Income184,0) AS Income184, ISNULL(T03.Income185,0) AS Income185, 
				ISNULL(T03.Income186,0) AS Income186, ISNULL(T03.Income187,0) AS Income187, ISNULL(T03.Income188,0) AS Income188, ISNULL(T03.Income189,0) AS Income189, ISNULL(T03.Income190,0) AS Income190, 
				ISNULL(T03.Income191,0) AS Income191, ISNULL(T03.Income192,0) AS Income192, ISNULL(T03.Income193,0) AS Income193, ISNULL(T03.Income194,0) AS Income194, ISNULL(T03.Income195,0) AS Income195, 
				ISNULL(T03.Income196,0) AS Income196, ISNULL(T03.Income197,0) AS Income197, ISNULL(T03.Income198,0) AS Income198, ISNULL(T03.Income199,0) AS Income199, ISNULL(T03.Income200,0) AS Income200,'
		SET @sSQL8 = '
                ISNULL(T00.SubAmount01, 0) AS SubAmount01, ISNULL(T00.SubAmount02, 0) AS SubAmount02, ISNULL(T00.SubAmount03, 0) AS SubAmount03, ISNULL(T00.SubAmount04, 0) AS SubAmount04, 
                ISNULL(T00.SubAmount05, 0) AS SubAmount05, ISNULL(T00.SubAmount06, 0) AS SubAmount06, ISNULL(T00.SubAmount07, 0) AS SubAmount07, ISNULL(T00.SubAmount08, 0) AS SubAmount08, 
                ISNULL(T00.SubAmount09, 0) AS SubAmount09, ISNULL(T00.SubAmount10, 0) AS SubAmount10, ISNULL(T00.SubAmount11, 0) AS SubAmount11, ISNULL(T00.SubAmount12, 0) AS SubAmount12, 
                ISNULL(T00.SubAmount13, 0) AS SubAmount13, ISNULL(T00.SubAmount14, 0) AS SubAmount14, ISNULL(T00.SubAmount15, 0) AS SubAmount15, ISNULL(T00.SubAmount16, 0) AS SubAmount16, 
                ISNULL(T00.SubAmount17, 0) AS SubAmount17, ISNULL(T00.SubAmount18, 0) AS SubAmount18, ISNULL(T00.SubAmount19, 0) AS SubAmount19, ISNULL(T00.SubAmount20, 0) AS SubAmount20, 
                ISNULL(H34.Income01, 0) AS CT_Income01, ISNULL(H34.Income02, 0) AS CT_Income02, ISNULL(H34.Income03, 0) AS CT_Income03, ISNULL(H34.Income04, 0) AS CT_Income04, 
                ISNULL(H34.Income05, 0) AS CT_Income05, ISNULL(H34.Income06, 0) AS CT_Income06, ISNULL(H34.Income07, 0) AS CT_Income07, ISNULL(H34.Income08, 0) AS CT_Income08, 
                ISNULL(H34.Income09, 0) AS CT_Income09, ISNULL(H34.Income10, 0) AS CT_Income10, ISNULL(H34.Income11, 0) AS CT_Income11, ISNULL(H34.Income12, 0) AS CT_Income12,'
		SET @sSQL5 = '
				ISNULL(H34.Income13, 0) AS CT_Income13, ISNULL(H34.Income14, 0) AS CT_Income14, ISNULL(H34.Income15, 0) AS CT_Income15, ISNULL(H34.Income16, 0) AS CT_Income16, 
				ISNULL(H34.Income17, 0) AS CT_Income17, ISNULL(H34.Income18, 0) AS CT_Income18, ISNULL(H34.Income19, 0) AS CT_Income19, ISNULL(H34.Income20, 0) AS CT_Income20, 
				ISNULL(H34.Income21, 0) AS CT_Income21, ISNULL(H34.Income22, 0) AS CT_Income22, ISNULL(H34.Income23, 0) AS CT_Income23, ISNULL(H34.Income24, 0) AS CT_Income24,
				ISNULL(H34.Income25, 0) AS CT_Income25, ISNULL(H34.Income26, 0) AS CT_Income26, ISNULL(H34.Income27, 0) AS CT_Income27, ISNULL(H34.Income28, 0) AS CT_Income28, 
				ISNULL(H34.Income29, 0) AS CT_Income29, ISNULL(H34.Income30, 0) AS CT_Income30, ISNULL(T03.Income31,0) AS CT_Income31, ISNULL(T03.Income32,0) AS CT_Income32, ISNULL(T03.Income33,0) AS CT_Income33,
				ISNULL(T03.Income34,0) AS CT_Income34, ISNULL(T03.Income35,0) AS CT_Income35, ISNULL(T03.Income36,0) AS CT_Income36, ISNULL(T03.Income37,0) AS CT_Income37, ISNULL(T03.Income38,0) AS CT_Income38, 
				ISNULL(T03.Income39,0) AS CT_Income39, ISNULL(T03.Income40,0) AS CT_Income40, ISNULL(T03.Income41,0) AS CT_Income41, ISNULL(T03.Income42,0) AS CT_Income42, ISNULL(T03.Income43,0) AS CT_Income43, 
				ISNULL(T03.Income44,0) AS CT_Income44, ISNULL(T03.Income45,0) AS CT_Income45, ISNULL(T03.Income46,0) AS CT_Income46, ISNULL(T03.Income47,0) AS CT_Income47, ISNULL(T03.Income48,0) AS CT_Income48, 
				ISNULL(T03.Income49,0) AS CT_Income49, ISNULL(T03.Income50,0) AS CT_Income50, ISNULL(T03.Income51,0) AS CT_Income51, ISNULL(T03.Income52,0) AS CT_Income52, ISNULL(T03.Income53,0) AS CT_Income53, 
				ISNULL(T03.Income54,0) AS CT_Income54, ISNULL(T03.Income55,0) AS CT_Income55, ISNULL(T03.Income56,0) AS CT_Income56, ISNULL(T03.Income57,0) AS CT_Income57, ISNULL(T03.Income58,0) AS CT_Income58, 
				ISNULL(T03.Income59,0) AS CT_Income59, ISNULL(T03.Income60,0) AS CT_Income60, ISNULL(T03.Income61,0) AS CT_Income61, ISNULL(T03.Income62,0) AS CT_Income62, ISNULL(T03.Income63,0) AS CT_Income63, 
				ISNULL(T03.Income64,0) AS CT_Income64, ISNULL(T03.Income65,0) AS CT_Income65, ISNULL(T03.Income66,0) AS CT_Income66, ISNULL(T03.Income67,0) AS CT_Income67, ISNULL(T03.Income68,0) AS CT_Income68, 
				ISNULL(T03.Income69,0) AS CT_Income69, ISNULL(T03.Income70,0) AS CT_Income70, ISNULL(T03.Income71,0) AS CT_Income71, ISNULL(T03.Income72,0) AS CT_Income72, ISNULL(T03.Income73,0) AS CT_Income73, 
				ISNULL(T03.Income74,0) AS CT_Income74, ISNULL(T03.Income75,0) AS CT_Income75, ISNULL(T03.Income76,0) AS CT_Income76, ISNULL(T03.Income77,0) AS CT_Income77, ISNULL(T03.Income78,0) AS CT_Income78,
				ISNULL(T03.Income79,0) AS CT_Income79, ISNULL(T03.Income80,0) AS CT_Income80, ISNULL(T03.Income81,0) AS CT_Income81, ISNULL(T03.Income82,0) AS CT_Income82, ISNULL(T03.Income83,0) AS CT_Income83, 
				ISNULL(T03.Income84,0) AS CT_Income84, ISNULL(T03.Income85,0) AS CT_Income85, ISNULL(T03.Income86,0) AS CT_Income86, ISNULL(T03.Income87,0) AS CT_Income87, ISNULL(T03.Income88,0) AS CT_Income88, 
				ISNULL(T03.Income89,0) AS CT_Income89, ISNULL(T03.Income90,0) AS CT_Income90, ISNULL(T03.Income91,0) AS CT_Income91, ISNULL(T03.Income92,0) AS CT_Income92, ISNULL(T03.Income93,0) AS CT_Income93, 
				ISNULL(T03.Income94,0) AS CT_Income94, ISNULL(T03.Income95,0) AS CT_Income95, ISNULL(T03.Income96,0) AS CT_Income96, ISNULL(T03.Income97,0) AS CT_Income97, ISNULL(T03.Income98,0) AS CT_Income98, 
				ISNULL(T03.Income99,0) AS CT_Income99, ISNULL(T03.Income100,0) AS CT_Income100, ISNULL(T03.Income101,0) AS CT_Income101, ISNULL(T03.Income102,0) AS CT_Income102, ISNULL(T03.Income103,0) AS CT_Income103,
				ISNULL(T03.Income104,0) AS CT_Income104, ISNULL(T03.Income105,0) AS CT_Income105, ISNULL(T03.Income106,0) AS CT_Income106, ISNULL(T03.Income107,0) AS CT_Income107, ISNULL(T03.Income108,0) AS CT_Income108,'
           SET @sSQL6 = '     
				ISNULL(T03.Income109,0) AS CT_Income109, ISNULL(T03.Income110,0) AS CT_Income110, ISNULL(T03.Income111,0) AS CT_Income111, ISNULL(T03.Income112,0) AS CT_Income112, ISNULL(T03.Income113,0) AS CT_Income113, 
				ISNULL(T03.Income114,0) AS CT_Income114, ISNULL(T03.Income115,0) AS CT_Income115, ISNULL(T03.Income116,0) AS CT_Income116, ISNULL(T03.Income117,0) AS CT_Income117, ISNULL(T03.Income118,0) AS CT_Income118, 
				ISNULL(T03.Income119,0) AS CT_Income119, ISNULL(T03.Income120,0) AS CT_Income120, ISNULL(T03.Income121,0) AS CT_Income121, ISNULL(T03.Income122,0) AS CT_Income122, ISNULL(T03.Income123,0) AS CT_Income123, 
				ISNULL(T03.Income124,0) AS CT_Income124, ISNULL(T03.Income125,0) AS CT_Income125, ISNULL(T03.Income126,0) AS CT_Income126, ISNULL(T03.Income127,0) AS CT_Income127, ISNULL(T03.Income128,0) AS CT_Income128, 
				ISNULL(T03.Income129,0) AS CT_Income129, ISNULL(T03.Income130,0) AS CT_Income130, ISNULL(T03.Income131,0) AS CT_Income131, ISNULL(T03.Income132,0) AS CT_Income132, ISNULL(T03.Income133,0) AS CT_Income133, 
				ISNULL(T03.Income134,0) AS CT_Income134, ISNULL(T03.Income135,0) AS CT_Income135, ISNULL(T03.Income136,0) AS CT_Income136, ISNULL(T03.Income137,0) AS CT_Income137, ISNULL(T03.Income138,0) AS CT_Income138, 
				ISNULL(T03.Income139,0) AS CT_Income139, ISNULL(T03.Income140,0) AS CT_Income140, ISNULL(T03.Income141,0) AS CT_Income141, ISNULL(T03.Income142,0) AS CT_Income142, ISNULL(T03.Income143,0) AS CT_Income143, 
				ISNULL(T03.Income144,0) AS CT_Income144, ISNULL(T03.Income145,0) AS CT_Income145, ISNULL(T03.Income146,0) AS CT_Income146, ISNULL(T03.Income147,0) AS CT_Income147, ISNULL(T03.Income148,0) AS CT_Income148, 
				ISNULL(T03.Income149,0) AS CT_Income149, ISNULL(T03.Income150,0) AS CT_Income150, 
				ISNULL(T03.Income151,0) AS CT_Income151, ISNULL(T03.Income152,0) AS CT_Income152, ISNULL(T03.Income153,0) AS CT_Income153, ISNULL(T03.Income154,0) AS CT_Income154, ISNULL(T03.Income155,0) AS CT_Income155, 
				ISNULL(T03.Income156,0) AS CT_Income156, ISNULL(T03.Income157,0) AS CT_Income157, ISNULL(T03.Income158,0) AS CT_Income158, ISNULL(T03.Income159,0) AS CT_Income159, ISNULL(T03.Income160,0) AS CT_Income160,
				ISNULL(T03.Income161,0) AS CT_Income161, ISNULL(T03.Income162,0) AS CT_Income162, ISNULL(T03.Income163,0) AS CT_Income163, ISNULL(T03.Income164,0) AS CT_Income164, ISNULL(T03.Income165,0) AS CT_Income165, 
				ISNULL(T03.Income166,0) AS CT_Income166, ISNULL(T03.Income167,0) AS CT_Income167, ISNULL(T03.Income168,0) AS CT_Income168, ISNULL(T03.Income169,0) AS CT_Income169, ISNULL(T03.Income170,0) AS CT_Income170, 
				ISNULL(T03.Income171,0) AS CT_Income171, ISNULL(T03.Income172,0) AS CT_Income172, ISNULL(T03.Income173,0) AS CT_Income173, ISNULL(T03.Income174,0) AS CT_Income174, ISNULL(T03.Income175,0) AS CT_Income175, 
				ISNULL(T03.Income176,0) AS CT_Income176, ISNULL(T03.Income177,0) AS CT_Income177, ISNULL(T03.Income178,0) AS CT_Income178, ISNULL(T03.Income179,0) AS CT_Income179, ISNULL(T03.Income180,0) AS CT_Income180, 
				ISNULL(T03.Income181,0) AS CT_Income181, ISNULL(T03.Income182,0) AS CT_Income182, ISNULL(T03.Income183,0) AS CT_Income183, ISNULL(T03.Income184,0) AS CT_Income184, ISNULL(T03.Income185,0) AS CT_Income185, 
				ISNULL(T03.Income186,0) AS CT_Income186, ISNULL(T03.Income187,0) AS CT_Income187, ISNULL(T03.Income188,0) AS CT_Income188, ISNULL(T03.Income189,0) AS CT_Income189, ISNULL(T03.Income190,0) AS CT_Income190, 
				ISNULL(T03.Income191,0) AS CT_Income191, ISNULL(T03.Income192,0) AS CT_Income192, ISNULL(T03.Income193,0) AS CT_Income193, ISNULL(T03.Income194,0) AS CT_Income194, ISNULL(T03.Income195,0) AS CT_Income195, 
				ISNULL(T03.Income196,0) AS CT_Income196, ISNULL(T03.Income197,0) AS CT_Income197, ISNULL(T03.Income198,0) AS CT_Income198, ISNULL(T03.Income199,0) AS CT_Income199, ISNULL(T03.Income200,0) AS CT_Income200,
				H34.ProjectID, HT1120.ProjectName, HT1120.BeginDate, HT1120.EndDate, T00.TranMonth, T00.TranYear, V00.IdentifyCardNo, 
				V00.FullAddress, V00.BankAccountNo, V00.WorkDate, ISNULL(H34.IGAbsentAmount01, 0) IGAbsentAmount01, ISNULL(H34.IGAbsentAmount02, 0) IGAbsentAmount02, ISNULL(H34.IGAbsentAmount03, 0) IGAbsentAmount03, ISNULL(H34.IGAbsentAmount04, 0) IGAbsentAmount04, ISNULL(H34.IGAbsentAmount05, 0) IGAbsentAmount05, 
				ISNULL(H34.IGAbsentAmount06, 0) IGAbsentAmount06, ISNULL(H34.IGAbsentAmount07, 0) IGAbsentAmount07, ISNULL(H34.IGAbsentAmount08, 0) IGAbsentAmount08, ISNULL(H34.IGAbsentAmount09, 0) IGAbsentAmount09, ISNULL(H34.IGAbsentAmount10, 0) IGAbsentAmount10, 
				ISNULL(H34.IGAbsentAmount11, 0) IGAbsentAmount11, ISNULL(H34.IGAbsentAmount12, 0) IGAbsentAmount12, ISNULL(H34.IGAbsentAmount13, 0) IGAbsentAmount13, ISNULL(H34.IGAbsentAmount14, 0) IGAbsentAmount14, ISNULL(H34.IGAbsentAmount15, 0) IGAbsentAmount15, 
				ISNULL(H34.IGAbsentAmount16, 0) IGAbsentAmount16, ISNULL(H34.IGAbsentAmount17, 0) IGAbsentAmount17, ISNULL(H34.IGAbsentAmount18, 0) IGAbsentAmount18, ISNULL(H34.IGAbsentAmount19, 0) IGAbsentAmount19, ISNULL(H34.IGAbsentAmount20, 0) IGAbsentAmount20,
				ISNULL(H34.IGAbsentAmount21, 0) IGAbsentAmount21, ISNULL(H34.IGAbsentAmount22, 0) IGAbsentAmount22, ISNULL(H34.IGAbsentAmount23, 0) IGAbsentAmount23, ISNULL(H34.IGAbsentAmount24, 0) IGAbsentAmount24, ISNULL(H34.IGAbsentAmount25, 0) IGAbsentAmount25,
				ISNULL(H34.IGAbsentAmount26, 0) IGAbsentAmount26, ISNULL(H34.IGAbsentAmount27, 0) IGAbsentAmount27, ISNULL(H34.IGAbsentAmount28, 0) IGAbsentAmount28, ISNULL(H34.IGAbsentAmount29, 0) IGAbsentAmount29, ISNULL(H34.IGAbsentAmount30, 0) IGAbsentAmount30,
				ISNULL(H34.SubAmount01, 0) AS CT_SubAmount01, ISNULL(H34.SubAmount02, 0) AS CT_SubAmount02, ISNULL(H34.SubAmount03, 0) AS CT_SubAmount03, ISNULL(H34.SubAmount04, 0) AS CT_SubAmount04, 
                ISNULL(H34.SubAmount05, 0) AS CT_SubAmount05, ISNULL(H34.SubAmount06, 0) AS CT_SubAmount06, ISNULL(H34.SubAmount07, 0) AS CT_SubAmount07, ISNULL(H34.SubAmount08, 0) AS CT_SubAmount08,'
			SET @sSQL7 = ' 
                ISNULL(H34.SubAmount09, 0) AS CT_SubAmount09, ISNULL(H34.SubAmount10, 0) AS CT_SubAmount10, ISNULL(H34.SubAmount11, 0) AS CT_SubAmount11, ISNULL(H34.SubAmount12, 0) AS CT_SubAmount12, 
                ISNULL(H34.SubAmount13, 0) AS CT_SubAmount13, ISNULL(H34.SubAmount14, 0) AS CT_SubAmount14, ISNULL(H34.SubAmount15, 0) AS CT_SubAmount15, ISNULL(H34.SubAmount16, 0) AS CT_SubAmount16, 
                ISNULL(H34.SubAmount17, 0) AS CT_SubAmount17, ISNULL(H34.SubAmount18, 0) AS CT_SubAmount18, ISNULL(H34.SubAmount19, 0) AS CT_SubAmount19, ISNULL(H34.SubAmount20, 0) AS CT_SubAmount20,
				ISNULL(T03.SubAmount21,0) AS CT_SubAmount21, ISNULL(T03.SubAmount22,0) AS CT_SubAmount22, ISNULL(T03.SubAmount23,0) AS CT_SubAmount23, ISNULL(T03.SubAmount24,0) AS CT_SubAmount24, 
				ISNULL(T03.SubAmount25,0) AS CT_SubAmount25, ISNULL(T03.SubAmount26,0) AS CT_SubAmount26, ISNULL(T03.SubAmount27,0) AS CT_SubAmount27, ISNULL(T03.SubAmount28,0) AS CT_SubAmount28, 
				ISNULL(T03.SubAmount29,0) AS CT_SubAmount29, ISNULL(T03.SubAmount30,0) AS CT_SubAmount30, ISNULL(T03.SubAmount31,0) AS CT_SubAmount31, ISNULL(T03.SubAmount32,0) AS CT_SubAmount32, 
				ISNULL(T03.SubAmount33,0) AS CT_SubAmount33, ISNULL(T03.SubAmount34,0) AS CT_SubAmount34, ISNULL(T03.SubAmount35,0) AS CT_SubAmount35, ISNULL(T03.SubAmount36,0) AS CT_SubAmount36, 
				ISNULL(T03.SubAmount37,0) AS CT_SubAmount37, ISNULL(T03.SubAmount38,0) AS CT_SubAmount38, ISNULL(T03.SubAmount39,0) AS CT_SubAmount39, ISNULL(T03.SubAmount40,0) AS CT_SubAmount40, 
				ISNULL(T03.SubAmount41,0) AS CT_SubAmount41, ISNULL(T03.SubAmount42,0) AS CT_SubAmount42, ISNULL(T03.SubAmount43,0) AS CT_SubAmount43, ISNULL(T03.SubAmount44,0) AS CT_SubAmount44, 
				ISNULL(T03.SubAmount45,0) AS CT_SubAmount45, ISNULL(T03.SubAmount46,0) AS CT_SubAmount46, ISNULL(T03.SubAmount47,0) AS CT_SubAmount47, ISNULL(T03.SubAmount48,0) AS CT_SubAmount48, 
				ISNULL(T03.SubAmount49,0) AS CT_SubAmount49, ISNULL(T03.SubAmount50,0) AS CT_SubAmount50, ISNULL(T03.SubAmount51,0) AS CT_SubAmount51, ISNULL(T03.SubAmount52,0) AS CT_SubAmount52, 
				ISNULL(T03.SubAmount53,0) AS CT_SubAmount53, ISNULL(T03.SubAmount54,0) AS CT_SubAmount54, ISNULL(T03.SubAmount55,0) AS CT_SubAmount55, ISNULL(T03.SubAmount56,0) AS CT_SubAmount56, 
				ISNULL(T03.SubAmount57,0) AS CT_SubAmount57, ISNULL(T03.SubAmount58,0) AS CT_SubAmount58, ISNULL(T03.SubAmount59,0) AS CT_SubAmount59, ISNULL(T03.SubAmount60,0) AS CT_SubAmount60,
				ISNULL(T03.SubAmount61,0) AS CT_SubAmount61, ISNULL(T03.SubAmount62,0) AS CT_SubAmount62, ISNULL(T03.SubAmount63,0) AS CT_SubAmount63, ISNULL(T03.SubAmount64,0) AS CT_SubAmount64, 
				ISNULL(T03.SubAmount65,0) AS CT_SubAmount65, ISNULL(T03.SubAmount66,0) AS CT_SubAmount66, ISNULL(T03.SubAmount67,0) AS CT_SubAmount67, ISNULL(T03.SubAmount68,0) AS CT_SubAmount68, 
				ISNULL(T03.SubAmount69,0) AS CT_SubAmount69, ISNULL(T03.SubAmount70,0) AS CT_SubAmount70, ISNULL(T03.SubAmount71,0) AS CT_SubAmount71, ISNULL(T03.SubAmount72,0) AS CT_SubAmount72, 
				ISNULL(T03.SubAmount73,0) AS CT_SubAmount73, ISNULL(T03.SubAmount74,0) AS CT_SubAmount74, ISNULL(T03.SubAmount75,0) AS CT_SubAmount75, ISNULL(T03.SubAmount76,0) AS CT_SubAmount76, 
				ISNULL(T03.SubAmount77,0) AS CT_SubAmount77, ISNULL(T03.SubAmount78,0) AS CT_SubAmount78, ISNULL(T03.SubAmount79,0) AS CT_SubAmount79, ISNULL(T03.SubAmount80,0) AS CT_SubAmount80,'
			SET @sSQL2 = ' 
				ISNULL(T03.SubAmount81,0) AS CT_SubAmount81, ISNULL(T03.SubAmount82,0) AS CT_SubAmount82, ISNULL(T03.SubAmount83,0) AS CT_SubAmount83, ISNULL(T03.SubAmount84,0) AS CT_SubAmount84, 
				ISNULL(T03.SubAmount85,0) AS CT_SubAmount85, ISNULL(T03.SubAmount86,0) AS CT_SubAmount86, ISNULL(T03.SubAmount87,0) AS CT_SubAmount87, ISNULL(T03.SubAmount88,0) AS CT_SubAmount88, 
				ISNULL(T03.SubAmount89,0) AS CT_SubAmount89, ISNULL(T03.SubAmount90,0) AS CT_SubAmount90, ISNULL(T03.SubAmount91,0) AS CT_SubAmount91, ISNULL(T03.SubAmount92,0) AS CT_SubAmount92, 
				ISNULL(T03.SubAmount93,0) AS CT_SubAmount93, ISNULL(T03.SubAmount94,0) AS CT_SubAmount94, ISNULL(T03.SubAmount95,0) AS CT_SubAmount95, ISNULL(T03.SubAmount96,0) AS CT_SubAmount96, 
				ISNULL(T03.SubAmount97,0) AS CT_SubAmount97, ISNULL(T03.SubAmount98,0) AS CT_SubAmount98, ISNULL(T03.SubAmount99,0) AS CT_SubAmount99, ISNULL(T03.SubAmount100,0) AS CT_SubAmount100,
				ISNULL(A1.SAmount2, 0) AS CT_SubSAmount2,ISNULL(A1.HAmount2, 0) AS CT_SubHAmount2,ISNULL(A1.TAmount2, 0) AS CT_SubTAmount2, ISNULL(H35.TongCong,0) as CT_TongCong'
				--PRINT ('aaa'+@sSQL4)
                
			IF @CustomerName in (21,39)--- Bổ sung lương tháng 13 và số ngày công lớn nhất của từng nhân viên (Unicare)
			BEGIN
				IF @ToMonth = 12
				BEGIN
					Declare @SQL_TAM varchar(max)
					--- Tạo bảng tạm lưu phụ cấp cũ, phụ cấp mới, ngày quy định, hệ số thâm niên của các nhân viên theo từng tháng
					IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HT34001]') AND type in (N'U'))
					BEGIN
						CREATE TABLE HT34001 (
											DivisionID nvarchar(50),
											EmployeeID nvarchar(50),
											TranMonth int,
											TranYear int,
											OldExAmount decimal(28,8),
											NewExAmount decimal(28,8),										
											TimeAmount decimal(28,8))
											
						IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[HT3400]') AND name = N'HT3400_Index1')
							DROP INDEX [HT3400_Index1] ON [dbo].[HT3400] WITH ( ONLINE = OFF )			
						
						CREATE NONCLUSTERED INDEX [HT34001_Index1] ON [dbo].[HT34001] 
						(
							[EmployeeID] ASC,
							[TranYear] ASC							
						)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
					END
					ELSE
					BEGIN
						-- Created by Văn Tài on 13/01/2020
						IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT34001' AND xtype = 'U')
							BEGIN
								IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
								ON col.id = tab.id WHERE tab.name = 'HT34001' AND col.name = 'DivisionID')
								ALTER TABLE HT34001 ADD DivisionID NVARCHAR(50)
							END
					END
					
					DELETE HT34001
					SET @SQL_TAM = 'INSERT INTO HT34001 (DivisionID, EmployeeID,TranMonth,TranYear,OldExAmount,NewExAmount,TimeAmount)
					SELECT  T00.DivisionID, T00.EmployeeID,T00.TranMonth,T00.TranYear,
							case when Isnull(T00.Income22,0) = 0 then 0 else (Isnull(T00.Income03,0) * Isnull(T00.IGAbsentAmount17,0) * (Select Count(ProjectID) From HT340001 Where DivisionID '+@StrDivisionID_New+'
																						And TransactionID in (Select TransactionID From HT3400 Where DivisionID '+@StrDivisionID_New+'
																						and TranMonth = T00.TranMonth and TranYear = T00.TranYear And EmployeeID = T00.EmployeeID))
																			/ Isnull(T00.Income22,0)) end,
							case when Isnull(T00.Income22,0) = 0 then 0 else (Isnull(T00.Income20,0) * Isnull(T00.IGAbsentAmount18,0) * (Select Count(ProjectID) From HT340001 Where DivisionID '+@StrDivisionID_New+'
																						And TransactionID in (Select TransactionID From HT3400 Where DivisionID '+@StrDivisionID_New+'
																						and TranMonth = T00.TranMonth and TranYear = T00.TranYear And EmployeeID = T00.EmployeeID))
																			/ Isnull(T00.Income22,0)) end,
							(case when (Select Count(ProjectID) From HT340001 Where DivisionID '+@StrDivisionID_New+'
																						And TransactionID in (Select TransactionID From HT3400 Where DivisionID '+@StrDivisionID_New+'
																						and TranMonth = T00.TranMonth and TranYear = T00.TranYear And EmployeeID = T00.EmployeeID)) > 1
							then T00.Income17/(Select Count(ProjectID) From HT340001 Where DivisionID '+@StrDivisionID_New+'
																						And TransactionID in (Select TransactionID From HT3400 Where DivisionID '+@StrDivisionID_New+'
																						and TranMonth = T00.TranMonth and TranYear = T00.TranYear And EmployeeID = T00.EmployeeID))
							else 0 end)
							
					FROM HT3400 T00
					WHERE T00.DivisionID '+@StrDivisionID_New+' AND T00.DepartmentID BETWEEN ''' + @FromDepartmentID + ''' AND ''' + @ToDepartmentID + ''' 
					'+CASE WHEN ISNULL(@Condition,'') <> '' THEN ' AND isnull(T00.DepartmentID,''#'') in ('+@Condition+')' ELSE '' END +' 
					AND ISNULL(T00.TeamID, '''') LIKE ISNULL(''' + @TeamID + ''', '''') AND
					T00.EmployeeID BETWEEN ''' + @FromEmployeeID + ''' AND ''' + @ToEmployeeID + ''' AND
					T00.TranYear = ' + str(@ToYear) + ' AND PayrollMethodID ' + @lstPayrollMethodID   + @sSQL_Where
	               
				   
				
					EXEC(@SQL_TAM)
					
					--PRINT (N'F2')
				
					SET @sSQL2 = @sSQL2 + ',
						(((Select Sum(OldExAmount) From HT34001 Where EmployeeID = T00.EmployeeID And TranYear = ' + str(@ToYear) + ')
						+ (Select Sum(NewExAmount) From HT34001 Where EmployeeID = T00.EmployeeID And TranYear = ' + str(@ToYear) + ')
						- (Select Sum(TimeAmount) From HT34001 Where EmployeeID = T00.EmployeeID And TranYear = ' + str(@ToYear) + ')
						+
						(Select sum(BaseSalary) From HT2400 Where DivisionID '+@StrDivisionID_New+' And EmployeeID = T00.EmployeeID
							And TranYear = ' + str(@ToYear) + '))/12) as ThirteenSalary'
				END
				ELSE
				BEGIN
					SET @sSQL2 = @sSQL2 + ',0 as ThirteenSalary'
				END
				
				SET @sSQL2 = @sSQL2 + ',
				(Select Max(BeginDate) From HT2421 Where DivisionID '+@StrDivisionID_New+' And TranMonth = T00.TranMonth And TranYear = T00.TranYear And ProjectID = H34.ProjectID And EmployeeID = T00.EmployeeID
				) as BeginJoinDate,
				
				(Select max(Isnull(IGAbsentAmount02,0) + Isnull(IGAbsentAmount04,0) + Isnull(IGAbsentAmount19,0) + Isnull(IGAbsentAmount14,0) + Isnull(IGAbsentAmount15,0))
					From HT340001 Where DivisionID '+@StrDivisionID_New+'
					And TransactionID in (Select TransactionID From HT3400 Where DivisionID '+@StrDivisionID_New+'
											and TranMonth = T00.TranMonth and TranYear = T00.TranYear and PayrollMethodID = T00.PayrollMethodID And EmployeeID = T00.EmployeeID)
				) as MaxAbsentAmounts,
				
				(Select max(BeginDate) From HT2421 Where DivisionID '+@StrDivisionID_New+' And TranMonth = T00.TranMonth
					And TranYear = T00.TranYear And EmployeeID = T00.EmployeeID
				) as MaxBeginDate,
				
				(Select Count(ProjectID) From HT340001 Where DivisionID '+@StrDivisionID_New+'
					And TransactionID in (Select TransactionID From HT3400 Where DivisionID '+@StrDivisionID_New+'
											and TranMonth = T00.TranMonth and TranYear = T00.TranYear and PayrollMethodID = T00.PayrollMethodID And EmployeeID = T00.EmployeeID)
				) as CountOfProjects,
				
				(Select count(*) From (Select distinct PayrollMethodID From HT3400 T00 Where DivisionID '+@StrDivisionID_New+'
										And DepartmentID BETWEEN ''' + @FromDepartmentID + ''' AND ''' + @ToDepartmentID + '''
										And ISNULL(T00.TeamID, '''') LIKE ISNULL(''' + @TeamID + ''', '''') AND
										EmployeeID BETWEEN ''' + @FromEmployeeID + ''' AND ''' + @ToEmployeeID + ''' AND
										(TranMonth + T00.TranYear*100 BETWEEN ' + CAST(@FromMonth + @FromYear*100 AS NVARCHAR(10)) + ' AND ' + 
										CAST(@ToMonth + @ToYear*100 AS NVARCHAR(10)) + @sSQL_Where + ')) A) as CountOfPayrollMethodID,
				
				ROW_NUMBER() over (partition by T00.EmployeeID order by (select 1)) as ProjectOrders,
				DENSE_RANK() over (order by H34.ProjectID) as ProjectNumber,
				
				(Select top 1 ProjectID From HT340001
				Where TransactionID in (Select TransactionID From HT3400 Where DivisionID '+@StrDivisionID_New+'
										and TranMonth = T00.TranMonth and TranYear = T00.TranYear and PayrollMethodID = T00.PayrollMethodID And EmployeeID = T00.EmployeeID)
				Order by Isnull(IGAbsentAmount02,0) + Isnull(IGAbsentAmount04,0) + Isnull(IGAbsentAmount19,0) + Isnull(IGAbsentAmount14,0) + Isnull(IGAbsentAmount15,0) DESC, ProjectID)
				as InsuranceProjectID, HT1120.Notes,V00.InsuranceSalary'
            END
            
			SET @sSQL3 = '    	
            FROM HT3400 T00 INNER JOIN HV1400 V00 ON V00.EmployeeID = T00.EmployeeID and V00.DivisionID = T00.DivisionID 
			INNER JOIN HT2461 A1 ON A1.DivisionID = T00.DivisionID 
				                                              AND A1.EmployeeID=T00.EmployeeID 				                                            
															  AND A1.TranMonth=T00.TranMonth 
															  AND A1.TranYear=T00.TranYear
			LEFT JOIN HT340001 H34 ON T00.DivisionID = H34.DivisionID AND T00.TransactionID = H34.TransactionID
			LEFT JOIN (SELECT DivisionID, TransactionID, SUM(ISNULL(IGAbsentAmount02,0)) AS TongCong FROM HT340001 GROUP BY DivisionID, TransactionID) H35 ON H34.DivisionID = H35.DivisionID AND H34.TransactionID = H35.TransactionID
			LEFT JOIN HT1120 ON H34.DivisionID = HT1120.DivisionID AND H34.ProjectID = HT1120.ProjectID
			LEFT JOIN HT3499 T03 ON T03.DivisionID = T00.DivisionID AND T03.TransactionID = T00.TransactionID
            --- INNER JOIN AT1102 T01 ON T01.DepartmentID = T00.DepartmentID 
            --- INNER JOIN HT2400 T02 ON T02.DivisionID = T00.DivisionID And T02.EmployeeID = T00.EmployeeID AND T02.TranMonth = T00.TranMonth AND
            --- T02.TranYear = T00.TranYear AND T02.DepartmentID = T00.DepartmentID AND ISNULL(T02.TeamID, '''') = ISNULL(T00.TeamID, '''')
            
            WHERE T00.DivisionID '+@StrDivisionID_New+' AND
                T00.DepartmentID BETWEEN ''' + @FromDepartmentID + ''' AND ''' + @ToDepartmentID + ''' 
                '+CASE WHEN ISNULL(@Condition,'') <> '' THEN ' AND isnull(T00.DepartmentID,''#'') in ('+@Condition+')' ELSE '' END +' 
			AND ISNULL(T00.TeamID, '''') LIKE ISNULL(''' + @TeamID + ''', '''') AND
                T00.EmployeeID BETWEEN ''' + @FromEmployeeID + ''' AND ''' + @ToEmployeeID + ''' AND
                T00.TranMonth + T00.TranYear*100 BETWEEN ' + CAST(@FromMonth + @FromYear*100 AS NVARCHAR(10)) + ' AND ' + 
                CAST(@ToMonth + @ToYear*100 AS NVARCHAR(10)) + ' AND H34.ProjectID Is Not Null AND
                PayrollMethodID ' + @lstPayrollMethodID     + @sSQL_Where           
		
		
        IF EXISTS (SELECT 1 FROM sysObjects WHERE XType = 'V' AND Name = 'HV240901')
            EXEC ('---- tao boi HP2512
            ALTER VIEW HV240901 AS ' + @sSQL + @sSQL4 + @sSQL8 + @sSQL5 + @sSQL6 + @sSQL7 + @sSQL2 + @sSQL3)
        ELSE    
			EXEC ('---- tao boi HP2512
            CREATE VIEW HV240901 AS ' + @sSQL + @sSQL4 + @sSQL8 + @sSQL5 + @sSQL6 + @sSQL7 + @sSQL2 + @sSQL3)


DELETE TBL_HP2512






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
