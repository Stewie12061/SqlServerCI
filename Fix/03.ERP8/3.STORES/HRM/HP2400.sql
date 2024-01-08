IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP2400]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP2400]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--------- 	Created by Nguyen Thi Ngoc Minh, Date 01/04/2004
---------	Purpose: Tao du lieu ke thua so luong nhân viên
---------	Edit by: Dang Le Bao Quynh; Date: 09/10/2006
---------	Purpose: Them dieu kien ke thua tung to nhom va tung nhan vien
---------    Edit by: Dang Le Bao Quynh; Date 20/10/2007
---------    Purpose: Ke thua ho so luong tu ho so nhan su lay them nhan vien thu viec
---------    Edit by: Dang Le Bao Quynh,  Date 12/03/2008
---------    Purpose: Them tinh trang nhan vien dang lam viec khi ke thua tu ho so luong
---------	Modify on 31/07/2013 by Bao Anh: Bo sung cac he so tu C14 -> C25 (Hung Vuong)
---------	Modify on 27/08/2013 by Bao Anh: Khi kế thừa hồ sơ lương, bổ sung lấy cả nhân viên nghỉ việc nhưng tháng trước còn làm (Unicare)
---------   Modied on 04/11/2013 by Thanh Sơn: Lấy thêm 2 trường IsJobWage và IsPiecework
---------	Modify on 06/01/2014 by Bao Anh: Khi kế thừa hồ sơ lương, không lấy nhân viên nghỉ việc nữa (Unicare)
---------	Modify on 04/11/2016 by Phương Thảo: Bỏ điều kiện kiểm tra theo phòng ban, tổ nhóm
---------	Modified on 23/11/2016 by Bảo Thy: Bổ sung C26 -> C150 (MEIKO)
---------	Modified on 03/07/2018 by Bảo Anh: Không kế thừa các hệ số C15, C16, C17, C18, C20, C25 (customize GODREJ)
---------	Modified on 22/05/2019 by Kim Thư: Bổ sung tên bảng cho các cột C29->C95 sửa lỗi ambigous
---------	Modified on 26/02/2021 by Huỳnh Thử: Xóa bảng Ht2499 Lưu C26 -> C150 (MEIKO)
/********************************************
'* Edited by: [GS] [Mỹ Tuyền] [30/07/2010]
'********************************************/

CREATE PROCEDURE [dbo].[HP2400]  @Mode as tinyint,
				@DivisionID as nvarchar(50),
				@DepartmentID as nvarchar(50),
				@TeamIDIn as nvarchar(50),
				@EmployeeIDIn as nvarchar(50),
				@TranMonth as int,
				@TranYear as int,
				@FromTranMonth as int,
				@FromTranYear as int,
				@CreateDate as datetime,
				@CreateUserID as nvarchar(50)
				
AS

	DECLARE	@TempYear as nvarchar(20),
			@TempMonth as nvarchar(20),
			@HT2400Cursor as CURSOR,
			--@EmpFileID as nvarchar(50),
			@DivisionID1 as nvarchar(50),
			@EmployeeID as nvarchar(50),
			@DepartmentID1 as nvarchar(50),
			@TeamID as nvarchar(50),
			@SalaryCoefficient as decimal(28,8),
			@TimeCoefficient as decimal(28,8),
			@DutyCoefficient as decimal(28,8),
			@BaseSalary as decimal(28,8),
			@TaxObjectID as nvarchar(50),
			@InsuranceSalary as decimal(28,8),
			@Salary01 as decimal(28,8),
			@Salary02 as decimal(28,8),
			@Salary03 as decimal(28,8),
			@C01 as decimal(28,8),
			@C02 as decimal(28,8),
			@C03 as decimal(28,8),
			@C04 as decimal(28,8),
			@C05 as decimal(28,8),
			@C06 as decimal(28,8),
			@C07 as decimal(28,8),
			@C08 as decimal(28,8),
			@C09 as decimal(28,8),
			@C10 as decimal(28,8),
			@C11 as decimal(28,8),
			@C12 as decimal(28,8),
			@C13 as decimal(28,8),
			@C14 as decimal(28,8),
			@C15 as decimal(28,8),
			@C16 as decimal(28,8),
			@C17 as decimal(28,8),
			@C18 as decimal(28,8),
			@C19 as decimal(28,8),
			@C20 as decimal(28,8),
			@C21 as decimal(28,8),
			@C22 as decimal(28,8),
			@C23 as decimal(28,8),
			@C24 as decimal(28,8),
			@C25 as decimal(28,8),
			@C26 as DECIMAL(28,8),
			@C27 as DECIMAL(28,8),
			@C28 as DECIMAL(28,8),
			@C29 as DECIMAL(28,8),
			@C30 as DECIMAL(28,8),
			@C31 as DECIMAL(28,8),
			@C32 as DECIMAL(28,8),
			@C33 as DECIMAL(28,8),
			@C34 as DECIMAL(28,8),
			@C35 as DECIMAL(28,8),
			@C36 as DECIMAL(28,8),
			@C37 as DECIMAL(28,8),
			@C38 as DECIMAL(28,8),
			@C39 as DECIMAL(28,8),
			@C40 as DECIMAL(28,8),
			@C41 as DECIMAL(28,8),
			@C42 as DECIMAL(28,8),
			@C43 as DECIMAL(28,8),
			@C44 as DECIMAL(28,8),
			@C45 as DECIMAL(28,8),
			@C46 as DECIMAL(28,8),
			@C47 as DECIMAL(28,8),
			@C48 as DECIMAL(28,8),
			@C49 as DECIMAL(28,8),
			@C50 as DECIMAL(28,8),
			@C51 as DECIMAL(28,8),
			@C52 as DECIMAL(28,8),
			@C53 as DECIMAL(28,8),
			@C54 as DECIMAL(28,8),
			@C55 as DECIMAL(28,8),
			@C56 as DECIMAL(28,8),
			@C57 as DECIMAL(28,8),
			@C58 as DECIMAL(28,8),
			@C59 as DECIMAL(28,8),
			@C60 as DECIMAL(28,8),
			@C61 as DECIMAL(28,8),
			@C62 as DECIMAL(28,8),
			@C63 as DECIMAL(28,8),
			@C64 as DECIMAL(28,8),
			@C65 as DECIMAL(28,8),
			@C66 as DECIMAL(28,8),
			@C67 as DECIMAL(28,8),
			@C68 as DECIMAL(28,8),
			@C69 as DECIMAL(28,8),
			@C70 as DECIMAL(28,8),
			@C71 as DECIMAL(28,8),
			@C72 as DECIMAL(28,8),
			@C73 as DECIMAL(28,8),
			@C74 as DECIMAL(28,8),
			@C75 as DECIMAL(28,8),
			@C76 as DECIMAL(28,8),
			@C77 as DECIMAL(28,8),
			@C78 as DECIMAL(28,8),
			@C79 as DECIMAL(28,8),
			@C80 as DECIMAL(28,8),
			@C81 as DECIMAL(28,8),
			@C82 as DECIMAL(28,8),
			@C83 as DECIMAL(28,8),
			@C84 as DECIMAL(28,8),
			@C85 as DECIMAL(28,8),
			@C86 as DECIMAL(28,8),
			@C87 as DECIMAL(28,8),
			@C88 as DECIMAL(28,8),
			@C89 as DECIMAL(28,8),
			@C90 as DECIMAL(28,8),
			@C91 as DECIMAL(28,8),
			@C92 as DECIMAL(28,8),
			@C93 as DECIMAL(28,8),
			@C94 as DECIMAL(28,8),
			@C95 as DECIMAL(28,8),
			@C96 as DECIMAL(28,8),
			@C97 as DECIMAL(28,8),
			@C98 as DECIMAL(28,8),
			@C99 as DECIMAL(28,8),
			@C100 as DECIMAL(28,8),
			@C101 as DECIMAL(28,8),
			@C102 as DECIMAL(28,8),
			@C103 as DECIMAL(28,8),
			@C104 as DECIMAL(28,8),
			@C105 as DECIMAL(28,8),
			@C106 as DECIMAL(28,8),
			@C107 as DECIMAL(28,8),
			@C108 as DECIMAL(28,8),
			@C109 as DECIMAL(28,8),
			@C110 as DECIMAL(28,8),
			@C111 as DECIMAL(28,8),
			@C112 as DECIMAL(28,8),
			@C113 as DECIMAL(28,8),
			@C114 as DECIMAL(28,8),
			@C115 as DECIMAL(28,8),
			@C116 as DECIMAL(28,8),
			@C117 as DECIMAL(28,8),
			@C118 as DECIMAL(28,8),
			@C119 as DECIMAL(28,8),
			@C120 as DECIMAL(28,8),
			@C121 as DECIMAL(28,8),
			@C122 as DECIMAL(28,8),
			@C123 as DECIMAL(28,8),
			@C124 as DECIMAL(28,8),
			@C125 as DECIMAL(28,8),
			@C126 as DECIMAL(28,8),
			@C127 as DECIMAL(28,8),
			@C128 as DECIMAL(28,8),
			@C129 as DECIMAL(28,8),
			@C130 as DECIMAL(28,8),
			@C131 as DECIMAL(28,8),
			@C132 as DECIMAL(28,8),
			@C133 as DECIMAL(28,8),
			@C134 as DECIMAL(28,8),
			@C135 as DECIMAL(28,8),
			@C136 as DECIMAL(28,8),
			@C137 as DECIMAL(28,8),
			@C138 as DECIMAL(28,8),
			@C139 as DECIMAL(28,8),
			@C140 as DECIMAL(28,8),
			@C141 as DECIMAL(28,8),
			@C142 as DECIMAL(28,8),
			@C143 as DECIMAL(28,8),
			@C144 as DECIMAL(28,8),
			@C145 as DECIMAL(28,8),
			@C146 as DECIMAL(28,8),
			@C147 as DECIMAL(28,8),
			@C148 as DECIMAL(28,8),
			@C149 as DECIMAL(28,8),
			@C150 as DECIMAL(28,8),
			@WorkDate as datetime,
			@RecruitDate as datetime,
			@EmployeeStatus as  int,
			@IsOtherDayPerMonth as tinyint,
			@WorkTerm as decimal(28,8),
			@IsJobWage AS tinyint,
			@IsPiecework AS TINYINT,
			@HV1400Cursor as CURSOR,
			@sSQL001 Nvarchar(4000) ='',
			@sSQL002 Nvarchar(4000) ='',
			@sSQL003 Nvarchar(4000) ='',
			@TableHT2400 Varchar(50),
			@FromTableHT2400 Varchar(50),
			@sTranMonth Varchar(2),
			@sFromTranMonth Varchar(2),
			@CustomerIndex INT

SELECT @CustomerIndex = CustomerName From CustomerIndex

SELECT @sTranMonth = CASE WHEN @TranMonth >9 THEN Convert(Varchar(2),@TranMonth) ELSE '0'+Convert(Varchar(1),@TranMonth) END
SELECT @sFromTranMonth = CASE WHEN @FromTranMonth >9 THEN Convert(Varchar(2),@FromTranMonth) ELSE '0'+Convert(Varchar(1),@FromTranMonth) END

IF EXISTS (SELECT TOP 1 1 FROM AT0001 WITH (NOLOCK) WHERE IsSplitTable = 1)	
BEGIN
	SELECT  @TableHT2400 = 'HT2400M'+@sTranMonth+Convert(Varchar(4),@TranYear)
	SELECT  @FromTableHT2400 = 'HT2400M'+@sFromTranMonth+Convert(Varchar(4),@FromTranYear)
END
ELSE
BEGIN
	SELECT  @TableHT2400 = 'HT2400'
	SELECT  @FromTableHT2400 = 'HT2400'
END
Set nocount on
SET @TempYear = cast(@TranYear as nvarchar(20))
SET @TempMonth = Case when len(Ltrim(Rtrim(str(@TranMonth))))= 1 then  '0' + Ltrim(Rtrim(str(@TranMonth)))
		else Ltrim(Rtrim(str(@TranMonth))) END
-- Delete HT2499 lưu C26->C150 (MEIKO)
DELETE HT2499 WHERE EmployeeID IN (
SELECT HT2499.EmployeeID FROM HT2499
				LEFT JOIN  HV1400 HT ON HT.EmployeeID = HT2499.EmployeeID
				 Inner join AT1102 T13 WITH (NOLOCK) on T13.DepartmentID=HT.DepartmentID
      And T13.DivisionID IN (HT.DivisionID, '@@@')
      Left Join HT1101 T11 WITH (NOLOCK) on IsNull(T11.TeamID,'')=IsNull(HT.TeamID,'')
      And T11.DepartmentID=HT.DepartmentID
      And HT.DivisionID IN (T11.DivisionID, '@@@')
				 WHERE  HT.DivisionID IN (@DivisionID, '@@@')
      And HT.DepartmentID between @DepartmentID AND @DepartmentID
      And IsNull(HT.TeamID,'') Like isnull(@TeamIDIn,'') AND
       IsNull(HT.EmployeeID,'') Like isnull(@EmployeeIDIn,'') AND
				 HT2499.TranMonth = @TranMonth AND HT2499.TranYear = @TranYear 
) AND DivisionID = @DivisionID and TranMonth = @TranMonth AND TranYear = @TranYear 

CREATE TABLE #HT2400
	(
	EmployeeID VARCHAR(50), DivisionID VARCHAR(50), DepartmentID VARCHAR(50),  TeamID VARCHAR(50),
	SalaryCoefficient decimal(28,8), TimeCoefficient decimal(28,8), DutyCoefficient decimal(28,8), BaseSalary decimal(28,8), 
	TaxObjectID VARCHAR(50), InsuranceSalary decimal(28,8), Salary01 decimal(28,8), Salary02 decimal(28,8), Salary03 decimal(28,8), 
	C01 decimal(28,8), C02 decimal(28,8), C03 decimal(28,8), C04 decimal(28,8), C05 decimal(28,8), C06 decimal(28,8), C07 decimal(28,8), C08 decimal(28,8), 
	C09 decimal(28,8), C10 decimal(28,8), C11 decimal(28,8), C12 decimal(28,8), C13  decimal(28,8), 
	C14 decimal(28,8), C15 decimal(28,8), C16 decimal(28,8), C17 decimal(28,8), C18 decimal(28,8), C19 decimal(28,8), C20 decimal(28,8), C21 decimal(28,8), 
	C22 decimal(28,8), C23 decimal(28,8), C24 decimal(28,8), C25 decimal(28,8),
	C26	DECIMAL(28,8), C27	DECIMAL(28,8), C28	DECIMAL(28,8), C29	DECIMAL(28,8), C30	DECIMAL(28,8), C31	DECIMAL(28,8), C32	DECIMAL(28,8), C33	DECIMAL(28,8), 
	C34	DECIMAL(28,8), C35	DECIMAL(28,8), C36	DECIMAL(28,8), C37	DECIMAL(28,8), C38	DECIMAL(28,8), C39	DECIMAL(28,8), C40	DECIMAL(28,8), C41	DECIMAL(28,8), 
	C42	DECIMAL(28,8), C43	DECIMAL(28,8), C44	DECIMAL(28,8), C45	DECIMAL(28,8), C46	DECIMAL(28,8), C47	DECIMAL(28,8), C48	DECIMAL(28,8), C49	DECIMAL(28,8), 
	C50	DECIMAL(28,8), C51	DECIMAL(28,8), C52	DECIMAL(28,8), C53	DECIMAL(28,8), C54	DECIMAL(28,8), C55	DECIMAL(28,8), C56	DECIMAL(28,8), C57	DECIMAL(28,8), 
	C58	DECIMAL(28,8), C59	DECIMAL(28,8), C60	DECIMAL(28,8), C61	DECIMAL(28,8), C62	DECIMAL(28,8), C63	DECIMAL(28,8), C64	DECIMAL(28,8), C65	DECIMAL(28,8), 
	C66	DECIMAL(28,8), C67	DECIMAL(28,8), C68	DECIMAL(28,8), C69	DECIMAL(28,8), C70	DECIMAL(28,8), C71	DECIMAL(28,8), C72	DECIMAL(28,8), C73	DECIMAL(28,8), 
	C74	DECIMAL(28,8), C75	DECIMAL(28,8), C76	DECIMAL(28,8), C77	DECIMAL(28,8), C78	DECIMAL(28,8), C79	DECIMAL(28,8), C80	DECIMAL(28,8), C81	DECIMAL(28,8), 
	C82	DECIMAL(28,8), C83	DECIMAL(28,8), C84	DECIMAL(28,8), C85	DECIMAL(28,8), C86	DECIMAL(28,8), C87	DECIMAL(28,8), C88	DECIMAL(28,8), C89	DECIMAL(28,8), 
	C90	DECIMAL(28,8), C91	DECIMAL(28,8), C92	DECIMAL(28,8), C93	DECIMAL(28,8), C94	DECIMAL(28,8), C95	DECIMAL(28,8), C96	DECIMAL(28,8), C97	DECIMAL(28,8), 
	C98	DECIMAL(28,8), C99	DECIMAL(28,8), C100 DECIMAL(28,8), C101 DECIMAL(28,8), C102 DECIMAL(28,8), C103 DECIMAL(28,8), C104 DECIMAL(28,8), C105 DECIMAL(28,8),
	C106 DECIMAL(28,8), C107 DECIMAL(28,8), C108 DECIMAL(28,8), C109 DECIMAL(28,8), C110 DECIMAL(28,8), C111 DECIMAL(28,8), C112 DECIMAL(28,8), C113 DECIMAL(28,8), 
	C114 DECIMAL(28,8), C115 DECIMAL(28,8), C116 DECIMAL(28,8), C117 DECIMAL(28,8), C118 DECIMAL(28,8), C119 DECIMAL(28,8), C120 DECIMAL(28,8), C121 DECIMAL(28,8), 
	C122 DECIMAL(28,8), C123 DECIMAL(28,8), C124 DECIMAL(28,8), C125 DECIMAL(28,8), C126 DECIMAL(28,8), C127 DECIMAL(28,8), C128 DECIMAL(28,8), C129 DECIMAL(28,8), 
	C130 DECIMAL(28,8), C131 DECIMAL(28,8), C132 DECIMAL(28,8), C133 DECIMAL(28,8), C134 DECIMAL(28,8), C135 DECIMAL(28,8), C136 DECIMAL(28,8), C137 DECIMAL(28,8), 
	C138 DECIMAL(28,8), C139 DECIMAL(28,8), C140 DECIMAL(28,8), C141 DECIMAL(28,8), C142 DECIMAL(28,8), C143 DECIMAL(28,8), C144 DECIMAL(28,8), C145 DECIMAL(28,8), 
	C146 DECIMAL(28,8), C147 DECIMAL(28,8), C148 DECIMAL(28,8), C149 DECIMAL(28,8), C150 DECIMAL(28,8), 
	WorkDate DATETIME, WorkTerm decimal(28,8), EmployeeStatus TINYINT, IsOtherDayPerMonth TINYINT, RecruitDate DATETIME, IsJobWage TINYINT,IsPiecework TINYINT
	) 
	

IF @Mode = 1	 --- 	ho so nhan su
BEGIN
	SET @HV1400Cursor = CURSOR SCROLL KEYSET FOR
		SELECT HV1400.EmployeeID, HV1400.DivisionID , HV1400.DepartmentID, case when isnull(HV1400.TeamID,'') = '' then NULL else TeamID end as TeamID,
			HV1400.BaseSalary, HV1400.TaxObjectID,HV1400.InsuranceSalary, HV1400.Salary01, HV1400.Salary02, HV1400.Salary03, 
			HV1400.SalaryCoefficient, HV1400.TimeCoefficient, HV1400.DutyCoefficient,
			HV1400.C01, HV1400.C02, HV1400.C03, HV1400.C04, HV1400.C05, HV1400.C06, HV1400.C07, HV1400.C08, HV1400.C09, HV1400.C10, HV1400.C11, HV1400.C12, HV1400.C13,
			HV1400.C14, HV1400.C15, HV1400.C16, HV1400.C17, HV1400.C18, HV1400.C19, HV1400.C20, HV1400.C21, HV1400.C22, HV1400.C23, HV1400.C24, HV1400.C25,
			HT1403_1.C26, HT1403_1.C27, HT1403_1.C28, HT1403_1.C29, HT1403_1.C30, HT1403_1.C31, HT1403_1.C32, 
			HT1403_1.C33, HT1403_1.C34, HT1403_1.C35, HT1403_1.C36, HT1403_1.C37, HT1403_1.C38, HT1403_1.C39, 
			HT1403_1.C40, HT1403_1.C41, HT1403_1.C42, HT1403_1.C43, HT1403_1.C44, HT1403_1.C45, HT1403_1.C46, 
			HT1403_1.C47, HT1403_1.C48, HT1403_1.C49, HT1403_1.C50, HT1403_1.C51, HT1403_1.C52, HT1403_1.C53, 
			HT1403_1.C54, HT1403_1.C55, HT1403_1.C56, HT1403_1.C57, HT1403_1.C58, HT1403_1.C59, HT1403_1.C60, 
			HT1403_1.C61, HT1403_1.C62, HT1403_1.C63, HT1403_1.C64, HT1403_1.C65, HT1403_1.C66, HT1403_1.C67, 
			HT1403_1.C68, HT1403_1.C69, HT1403_1.C70, HT1403_1.C71, HT1403_1.C72, HT1403_1.C73, HT1403_1.C74, 
			HT1403_1.C75, HT1403_1.C76, HT1403_1.C77, HT1403_1.C78, HT1403_1.C79, HT1403_1.C80, HT1403_1.C81, 
			HT1403_1.C82, HT1403_1.C83, HT1403_1.C84, HT1403_1.C85, HT1403_1.C86, HT1403_1.C87, HT1403_1.C88, 
			HT1403_1.C89, HT1403_1.C90, HT1403_1.C91, HT1403_1.C92, HT1403_1.C93, HT1403_1.C94, HT1403_1.C95, 
			HT1403_1.C96, HT1403_1.C97, HT1403_1.C98, HT1403_1.C99, HT1403_1.C100,  HT1403_1.C101, HT1403_1.C102, 
			HT1403_1.C103, HT1403_1.C104, HT1403_1.C105, HT1403_1.C106, HT1403_1.C107, HT1403_1.C108, 
			HT1403_1.C109, HT1403_1.C110, HT1403_1.C111, HT1403_1.C112, HT1403_1.C113, HT1403_1.C114, 
			HT1403_1.C115, HT1403_1.C116, HT1403_1.C117, HT1403_1.C118, HT1403_1.C119, HT1403_1.C120, 
			HT1403_1.C121, HT1403_1.C122, HT1403_1.C123, HT1403_1.C124, HT1403_1.C125, HT1403_1.C126, 
			HT1403_1.C127, HT1403_1.C128, HT1403_1.C129, HT1403_1.C130, HT1403_1.C131, HT1403_1.C132, 
			HT1403_1.C133, HT1403_1.C134, HT1403_1.C135, HT1403_1.C136, HT1403_1.C137, HT1403_1.C138, 
			HT1403_1.C139, HT1403_1.C140, HT1403_1.C141, HT1403_1.C142, HT1403_1.C143, HT1403_1.C144, 
			HT1403_1.C145, HT1403_1.C146, HT1403_1.C147, HT1403_1.C148, HT1403_1.C149, HT1403_1.C150, 
			WorkDate, Datediff(m,WorkDate,Getdate()) as WorkTerm, EmployeeStatus,  IsOtherDayPerMonth,RecruitDate,IsJobWage,IsPiecework
		FROM HV1400 
		LEFT JOIN HT1403_1 ON HV1400.EmployeeID = HT1403_1.EmployeeID AND HV1400.DivisionID = HT1403_1.DivisionID
		WHERE 	HV1400.DivisionID = @DivisionID and
				HV1400.DepartmentID LIKE @DepartmentID and
				isnull(TeamID,'') Like @TeamIDIn and
				HV1400.EmployeeID Like @EmployeeIDIn And
				(HV1400.EmployeeStatus  = 1 or EmployeeStatus  = 2)
	
	OPEN @HV1400Cursor
	FETCH FIRST FROM @HV1400Cursor INTO  @EmployeeID, @DivisionID1, @DepartmentID1, @TeamID,
		@BaseSalary,@TaxObjectID, @InsuranceSalary, @Salary01, @Salary02, @Salary03,  
		@SalaryCoefficient, @TimeCoefficient, @DutyCoefficient,  
		@C01, @C02, @C03, @C04, @C05, @C06, @C07, @C08, @C09, @C10, @C11, @C12, @C13,
		@C14, @C15, @C16, @C17, @C18, @C19, @C20, @C21, @C22, @C23, @C24, @C25,@C26, @C27, @C28, @C29, @C30, @C31, @C32, 
		@C33, @C34, @C35, @C36, @C37, @C38, @C39, @C40, @C41, @C42, @C43, @C44, @C45, @C46, 
		@C47, @C48, @C49, @C50, @C51, @C52, @C53, @C54, @C55, @C56, @C57, @C58, @C59, @C60, 
		@C61, @C62, @C63, @C64, @C65, @C66, @C67, @C68, @C69, @C70, @C71, @C72, @C73, @C74, 
		@C75, @C76, @C77, @C78, @C79, @C80, @C81, @C82, @C83, @C84, @C85, @C86, @C87, @C88, 
		@C89, @C90, @C91, @C92, @C93, @C94, @C95, @C96, @C97, @C98, @C99, @C100,
		@C101, @C102, @C103, @C104, @C105, @C106, @C107, @C108, @C109, @C110, @C111, @C112, 
		@C113, @C114, @C115, @C116, @C117, @C118, @C119, @C120, @C121, @C122, @C123, @C124, 
		@C125, @C126, @C127, @C128, @C129, @C130, @C131, @C132, @C133, @C134, @C135, @C136, 
		@C137, @C138, @C139, @C140, @C141, @C142, @C143, @C144, @C145, @C146, @C147, @C148, 
		@C149, @C150, 
		@WorkDate, @WorkTerm, @EmployeeStatus, @IsOtherDayPerMonth, @RecruitDate,@IsJobWage,@IsPiecework
	
--print "1";
	WHILE @@FETCH_STATUS = 0
		BEGIN		  
		SET @sSQL001 ='
	
			DECLARE @EmpFileID VARCHAR(50)
	
			IF not Exists(SELECT EmployeeID FROM '+@TableHT2400+' WITH (NOLOCK) WHERE EmployeeID = '''+@EmployeeID+''' AND DivisionID = '''+@DivisionID1+'''
								and TranMonth = '+STR(@TranMonth)+'	
								AND TranYear = '+STR(@TranYear)+')
				BEGIN
	
				Exec AP0000 '''+@DivisionID1+''', @EmpFileID OUTPUT, ''HT2400'', ''HS'', '''+ISNULL(@TempYear,'')+''', '''+ISNULL(@TempMonth,'')+''', 15, 3, 0, ''''
	
				INSERT INTO '+@TableHT2400+' (EmpFileID, EmployeeID, DivisionID, DepartmentID, TeamID,
				BaseSalary, TaxObjectID,InsuranceSalary, Salary01, Salary02, Salary03, 
				SalaryCoefficient, TimeCoefficient, DutyCoefficient,
				C01, C02, C03, C04, C05, C06, C07, C08, C09, C10, C11, C12, C13,
				C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24, C25,
				TranMonth, TranYear ,WorkTerm, EmployeeStatus, IsOtherDayPerMonth,
				CreateDate, CreateUserID,LastModifyDate,LastmodifyUserID,
				IsJobWage,IsPiecework )
				VALUES (@EmpFileID, '''+@EmployeeID+''', '''+@DivisionID1+''', '''+@DepartmentID1+''', '''+ISNULL(@TeamID,'')+''',
				'+Convert(Varchar(50),ISNULL(@BaseSalary,0))+', '''+ISNULL(@TaxObjectID,'')+''', '+Convert(Varchar(50),ISNULL(@InsuranceSalary,0))+', '+Convert(Varchar(50),ISNULL(@Salary01,0))+', '+Convert(Varchar(50),ISNULL(@Salary02,0))+','+Convert(Varchar(50),ISNULL(@Salary03,0))+', 
				'+Convert(Varchar(50),ISNULL(@SalaryCoefficient,0))+', '+Convert(Varchar(50),ISNULL(@TimeCoefficient,0))+', '+Convert(Varchar(50),ISNULL(@DutyCoefficient,0))+',
				'+Convert(Varchar(50),ISNULL(@C01,0))+', '+Convert(Varchar(50),ISNULL(@C02,0))+', '+Convert(Varchar(50),ISNULL(@C03,0))+', '+Convert(Varchar(50),ISNULL(@C04,0))+', '+Convert(Varchar(50),ISNULL(@C05,0))+', '+Convert(Varchar(50),ISNULL(@C06,0))+', 
				'+Convert(Varchar(50),ISNULL(@C07,0))+', '+Convert(Varchar(50),ISNULL(@C08,0))+', '+Convert(Varchar(50),ISNULL(@C09,0))+','+Convert(Varchar(50),ISNULL(@C10,0))+', '+Convert(Varchar(50),ISNULL(@C11,0))+', '+Convert(Varchar(50),ISNULL(@C12,0))+', 
				'+Convert(Varchar(50),ISNULL(@C13,0))+', '+Convert(Varchar(50),ISNULL(@C14,0))+', '+Convert(Varchar(50),ISNULL(@C15,0))+', '+Convert(Varchar(50),ISNULL(@C16,0))+', '+Convert(Varchar(50),ISNULL(@C17,0))+', '+Convert(Varchar(50),ISNULL(@C18,0))+', 
				'+Convert(Varchar(50),ISNULL(@C19,0))+', '+Convert(Varchar(50),ISNULL(@C20,0))+', '+Convert(Varchar(50),ISNULL(@C21,0))+', '+Convert(Varchar(50),ISNULL(@C22,0))+', '+Convert(Varchar(50),ISNULL(@C23,0))+', '+Convert(Varchar(50),ISNULL(@C24,0))+', 
				'+Convert(Varchar(50),ISNULL(@C25,0))+', '+STR(@TranMonth)+', '+STR(@TranYear)+', '+Convert(Varchar(50),ISNULL(@WorkTerm,0))+', '+STR(@EmployeeStatus)+', '+STR(ISNULL(@IsOtherDayPerMonth,0))+',
				'''+CONVERT(VARCHAR(50),@CreateDate,120)+''','''+@CreateUserID+''','''+CONVERT(VARCHAR(50),@CreateDate,120)+''','''+@CreateUserID+''', '+STR(ISNULL(@IsJobWage,0))+','+STR(ISNULL(@IsPiecework,0))+' )
				'
				SET @sSQL003 ='
				-----Bổ sung C26->C100
				INSERT INTO HT2499 (EmpFileID, EmployeeID, DivisionID, 
				C26, C27, C28, C29, C30, C31, C32, C33, C34, C35, C36, C37, C38, C39, C40, C41, C42, C43, C44, C45, C46, C47, C48, C49, C50, C51, C52, C53, 
				C54, C55, C56, C57, C58, C59, C60, C61, C62, C63, C64, C65, C66, C67, C68, C69, C70, C71, C72, C73, C74, C75, C76, C77, C78, C79, C80, C81, 
				C82, C83, C84, C85, C86, C87, C88, C89, C90, C91, C92, C93, C94, C95, C96, C97, C98, C99, C100, C101, C102, C103, C104, C105, C106, C107, C108,
				C109, C110, C111, C112, C113, C114, C115, C116, C117, C118, C119, C120, C121, C122, C123, C124, C125, C126, C127, C128, C129, C130, C131, 
				C132, C133, C134, C135, C136, C137, C138, C139, C140, C141, C142, C143, C144, C145, C146, C147, C148, 
				C149, C150, TranMonth, TranYear, CreateDate, CreateUserID,LastModifyDate,LastmodifyUserID )
				VALUES (@EmpFileID, '''+@EmployeeID+''', '''+@DivisionID1+''', '+Convert(Varchar(50),ISNULL(@C26,0))+', '+Convert(Varchar(50),ISNULL(@C27,0))+', 
				'+Convert(Varchar(50),ISNULL(@C28,0))+', '+Convert(Varchar(50),ISNULL(@C29,0))+', '+Convert(Varchar(50),ISNULL(@C30,0))+','+Convert(Varchar(50),ISNULL(@C31,0))+', '+Convert(Varchar(50),ISNULL(@C32,0))+', '+Convert(Varchar(50),ISNULL(@C33,0))+', 
				'+Convert(Varchar(50),ISNULL(@C34,0))+', '+Convert(Varchar(50),ISNULL(@C35,0))+', '+Convert(Varchar(50),ISNULL(@C36,0))+', '+Convert(Varchar(50),ISNULL(@C37,0))+', '+Convert(Varchar(50),ISNULL(@C38,0))+', '+Convert(Varchar(50),ISNULL(@C39,0))+', 
				'+Convert(Varchar(50),ISNULL(@C40,0))+', '+Convert(Varchar(50),ISNULL(@C41,0))+', '+Convert(Varchar(50),ISNULL(@C42,0))+', '+Convert(Varchar(50),ISNULL(@C43,0))+', '+Convert(Varchar(50),ISNULL(@C44,0))+', '+Convert(Varchar(50),ISNULL(@C45,0))+', 
				'+Convert(Varchar(50),ISNULL(@C46,0))+', '+Convert(Varchar(50),ISNULL(@C47,0))+', '+Convert(Varchar(50),ISNULL(@C48,0))+', '+Convert(Varchar(50),ISNULL(@C49,0))+', '+Convert(Varchar(50),ISNULL(@C50,0))+', '+Convert(Varchar(50),ISNULL(@C51,0))+', 
				'+Convert(Varchar(50),ISNULL(@C52,0))+', '+Convert(Varchar(50),ISNULL(@C53,0))+', '+Convert(Varchar(50),ISNULL(@C54,0))+', '+Convert(Varchar(50),ISNULL(@C55,0))+', '+Convert(Varchar(50),ISNULL(@C56,0))+', '+Convert(Varchar(50),ISNULL(@C57,0))+', 
				'+Convert(Varchar(50),ISNULL(@C58,0))+', '+Convert(Varchar(50),ISNULL(@C59,0))+', '+Convert(Varchar(50),ISNULL(@C60,0))+', '+Convert(Varchar(50),ISNULL(@C61,0))+', '+Convert(Varchar(50),ISNULL(@C62,0))+', '+Convert(Varchar(50),ISNULL(@C63,0))+', 
				'+Convert(Varchar(50),ISNULL(@C64,0))+', '+Convert(Varchar(50),ISNULL(@C65,0))+', '+Convert(Varchar(50),ISNULL(@C66,0))+', '+Convert(Varchar(50),ISNULL(@C67,0))+', '+Convert(Varchar(50),ISNULL(@C68,0))+', '+Convert(Varchar(50),ISNULL(@C69,0))+', 
				'+Convert(Varchar(50),ISNULL(@C70,0))+', '+Convert(Varchar(50),ISNULL(@C71,0))+', '+Convert(Varchar(50),ISNULL(@C72,0))+', '+Convert(Varchar(50),ISNULL(@C73,0))+', '+Convert(Varchar(50),ISNULL(@C74,0))+', '+Convert(Varchar(50),ISNULL(@C75,0))+', 
				'+Convert(Varchar(50),ISNULL(@C76,0))+', '+Convert(Varchar(50),ISNULL(@C77,0))+', '+Convert(Varchar(50),ISNULL(@C78,0))+', '+Convert(Varchar(50),ISNULL(@C79,0))+', '+Convert(Varchar(50),ISNULL(@C80,0))+', '+Convert(Varchar(50),ISNULL(@C81,0))+', 
				'+Convert(Varchar(50),ISNULL(@C82,0))+', '+Convert(Varchar(50),ISNULL(@C83,0))+', '+Convert(Varchar(50),ISNULL(@C84,0))+', '+Convert(Varchar(50),ISNULL(@C85,0))+', '+Convert(Varchar(50),ISNULL(@C86,0))+', '+Convert(Varchar(50),ISNULL(@C87,0))+', 
				'+Convert(Varchar(50),ISNULL(@C88,0))+', '+Convert(Varchar(50),ISNULL(@C89,0))+', '+Convert(Varchar(50),ISNULL(@C90,0))+', '+Convert(Varchar(50),ISNULL(@C91,0))+', '+Convert(Varchar(50),ISNULL(@C92,0))+', '+Convert(Varchar(50),ISNULL(@C93,0))+', 
				'+Convert(Varchar(50),ISNULL(@C94,0))+', '+Convert(Varchar(50),ISNULL(@C95,0))+', '+Convert(Varchar(50),ISNULL(@C96,0))+', '+Convert(Varchar(50),ISNULL(@C97,0))+', '+Convert(Varchar(50),ISNULL(@C98,0))+', '+Convert(Varchar(50),ISNULL(@C99,0))+', 
				'+Convert(Varchar(50),ISNULL(@C100,0))+', '+Convert(Varchar(50),ISNULL(@C101,0))+','+Convert(Varchar(50),ISNULL(@C102,0))+','+Convert(Varchar(50),ISNULL(@C103,0))+', '+Convert(Varchar(50),ISNULL(@C104,0))+', '+Convert(Varchar(50),ISNULL(@C105,0))+',
				'+Convert(Varchar(50),ISNULL(@C106,0))+', '+Convert(Varchar(50),ISNULL(@C107,0))+', '+Convert(Varchar(50),ISNULL(@C108,0))+', '+Convert(Varchar(50),ISNULL(@C109,0))+', '+Convert(Varchar(50),ISNULL(@C110,0))+', '+Convert(Varchar(50),ISNULL(@C111,0))+', 
				'+Convert(Varchar(50),ISNULL(@C112,0))+', '+Convert(Varchar(50),ISNULL(@C113,0))+', '+Convert(Varchar(50),ISNULL(@C114,0))+', '+Convert(Varchar(50),ISNULL(@C115,0))+', '+Convert(Varchar(50),ISNULL(@C116,0))+', '+Convert(Varchar(50),ISNULL(@C117,0))+', 
				'+Convert(Varchar(50),ISNULL(@C118,0))+', '+Convert(Varchar(50),ISNULL(@C119,0))+', '+Convert(Varchar(50),ISNULL(@C120,0))+', '+Convert(Varchar(50),ISNULL(@C121,0))+', '+Convert(Varchar(50),ISNULL(@C122,0))+', '+Convert(Varchar(50),ISNULL(@C123,0))+', 
				'+Convert(Varchar(50),ISNULL(@C124,0))+', '+Convert(Varchar(50),ISNULL(@C125,0))+', '+Convert(Varchar(50),ISNULL(@C126,0))+', '+Convert(Varchar(50),ISNULL(@C127,0))+', '+Convert(Varchar(50),ISNULL(@C128,0))+', '+Convert(Varchar(50),ISNULL(@C129,0))+', 
				'+Convert(Varchar(50),ISNULL(@C130,0))+', '+Convert(Varchar(50),ISNULL(@C131,0))+', '+Convert(Varchar(50),ISNULL(@C132,0))+', '+Convert(Varchar(50),ISNULL(@C133,0))+', '+Convert(Varchar(50),ISNULL(@C134,0))+', '+Convert(Varchar(50),ISNULL(@C135,0))+', 
				'+Convert(Varchar(50),ISNULL(@C136,0))+', '+Convert(Varchar(50),ISNULL(@C137,0))+', '+Convert(Varchar(50),ISNULL(@C138,0))+', '+Convert(Varchar(50),ISNULL(@C139,0))+', '+Convert(Varchar(50),ISNULL(@C140,0))+', '+Convert(Varchar(50),ISNULL(@C141,0))+', 
				'+Convert(Varchar(50),ISNULL(@C142,0))+', '+Convert(Varchar(50),ISNULL(@C143,0))+', '+Convert(Varchar(50),ISNULL(@C144,0))+', '+Convert(Varchar(50),ISNULL(@C145,0))+', '+Convert(Varchar(50),ISNULL(@C146,0))+', '+Convert(Varchar(50),ISNULL(@C147,0))+', 
				'+Convert(Varchar(50),ISNULL(@C148,0))+', '+Convert(Varchar(50),ISNULL(@C149,0))+', '+Convert(Varchar(50),ISNULL(@C150,0))+', '+STR(@TranMonth)+', '+STR(@TranYear)+',
					'''+CONVERT(VARCHAR(50),@CreateDate,120)+''','''+@CreateUserID+''','''+CONVERT(VARCHAR(50),@CreateDate,120)+''','''+@CreateUserID+''')
	
				END
		'
		--PRINT (@sSQL001)
		--PRINT (@sSQL003)
		EXEC (@sSQL001+@sSQL003)
			
	
		FETCH NEXT FROM @HV1400Cursor INTO  @EmployeeID, @DivisionID1, @DepartmentID1, @TeamID,
		@BaseSalary,@TaxObjectID, @InsuranceSalary, @Salary01, @Salary02, @Salary03,  
		@SalaryCoefficient, @TimeCoefficient, @DutyCoefficient,  
		@C01, @C02, @C03, @C04, @C05, @C06, @C07, @C08, @C09, @C10, @C11, @C12, @C13,
		@C14, @C15, @C16, @C17, @C18, @C19, @C20, @C21, @C22, @C23, @C24, @C25, @C26, @C27, @C28, @C29, @C30, @C31, @C32, 
		@C33, @C34, @C35, @C36, @C37, @C38, @C39, @C40, @C41, @C42, @C43, @C44, @C45, @C46, 
		@C47, @C48, @C49, @C50, @C51, @C52, @C53, @C54, @C55, @C56, @C57, @C58, @C59, @C60, 
		@C61, @C62, @C63, @C64, @C65, @C66, @C67, @C68, @C69, @C70, @C71, @C72, @C73, @C74, 
		@C75, @C76, @C77, @C78, @C79, @C80, @C81, @C82, @C83, @C84, @C85, @C86, @C87, @C88, 
		@C89, @C90, @C91, @C92, @C93, @C94, @C95, @C96, @C97, @C98, @C99, @C100,
		@C101, @C102, @C103, @C104, @C105, @C106, @C107, @C108, @C109, @C110, @C111, @C112, 
		@C113, @C114, @C115, @C116, @C117, @C118, @C119, @C120, @C121, @C122, @C123, @C124, 
		@C125, @C126, @C127, @C128, @C129, @C130, @C131, @C132, @C133, @C134, @C135, @C136, 
		@C137, @C138, @C139, @C140, @C141, @C142, @C143, @C144, @C145, @C146, @C147, @C148, 
		@C149, @C150, @WorkDate, @WorkTerm, @EmployeeStatus, @IsOtherDayPerMonth,@RecruitDate,@IsJobWage,@IsPiecework
	  	END
--print "2";
	CLOSE @HV1400Cursor
	DEALLOCATE @HV1400Cursor 	
		  
	END
	
ELSE  ---Tu ho so luong
--print "3";
BEGIN	
	SET @sSQL001 ='
			INSERT INTO #HT2400 
			(
				EmployeeID, DivisionID , DepartmentID, TeamID,
				BaseSalary, TaxObjectID,InsuranceSalary, Salary01, Salary02, Salary03, 
				SalaryCoefficient, TimeCoefficient, DutyCoefficient,
				C01, C02, C03, C04, C05, C06, C07, C08, C09, C10, C11, C12, C13,
				C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24, C25,
				C26, C27, C28, C29, C30, C31, C32, C33, C34, C35, C36, C37, C38, C39, 
				C40, C41, C42, C43, C44, C45, C46, C47, C48, C49, C50, C51, C52, C53, 
				C54, C55, C56, C57, C58, C59, C60, C61, C62, C63, C64, C65, C66, C67, 
				C68, C69, C70, C71, C72, C73, C74, C75, C76, C77, C78, C79, C80, C81, 
				C82, C83, C84, C85, C86, C87, C88, C89, C90, C91, C92, C93, C94, C95, 
				C96, C97, C98, C99, C100,C101, C102, C103, C104, C105, C106, C107, C108, C109, C110, C111, C112, 
				C113, C114, C115, C116, C117, C118, C119, C120, C121, C122, C123, C124, 
				C125, C126, C127, C128, C129, C130, C131, C132, C133, C134, C135, C136, 
				C137, C138, C139, C140, C141, C142, C143, C144, C145, C146, C147, C148, 
				C149, C150, WorkDate, WorkTerm, EmployeeStatus, IsOtherDayPerMonth,RecruitDate,IsJobWage,IsPiecework
			)
			SELECT	HT00.EmployeeID, HT00.DivisionID, HT00.DepartmentID,  case when isnull(HT00.TeamID,'''') = '''' then NULL else HT00.TeamID end,
					HT00.BaseSalary, HT00.TaxObjectID, HT00.InsuranceSalary, HT00.Salary01, HT00.Salary02, HT00.Salary03,
					HT00.SalaryCoefficient, HT00.TimeCoefficient, HT00.DutyCoefficient, 						 
					HT00.C01, HT00.C02, HT00.C03, HT00.C04, HT00.C05, HT00.C06, HT00.C07, HT00.C08, HT00.C09, HT00.C10, HT00.C11, HT00.C12, HT00.C13, 
					HT00.C14, HT00.C15, HT00.C16, HT00.C17, HT00.C18, HT00.C19, HT00.C20, HT00.C21, HT00.C22, HT00.C23, HT00.C24, HT00.C25,
					HT02.C26, HT02.C27,HT02.C28, HT02.C29, HT02.C30, HT02.C31, HT02.C32, HT02.C33, HT02.C34, HT02.C35, HT02.C36, HT02.C37, HT02.C38, HT02.C39, 
					HT02.C40, HT02.C41,HT02.C42, HT02.C43, HT02.C44, HT02.C45, HT02.C46, HT02.C47, HT02.C48, HT02.C49, HT02.C50, HT02.C51, HT02.C52, HT02.C53, 
					HT02.C54, HT02.C55, HT02.C56, HT02.C57, HT02.C58, HT02.C59, HT02.C60, HT02.C61, HT02.C62, HT02.C63, HT02.C64, HT02.C65, HT02.C66, HT02.C67, 
					HT02.C68, HT02.C69, HT02.C70, HT02.C71, HT02.C72, HT02.C73, HT02.C74, HT02.C75, HT02.C76, HT02.C77, HT02.C78, HT02.C79, HT02.C80, HT02.C81, 
					HT02.C82, HT02.C83, HT02.C84, HT02.C85, HT02.C86, HT02.C87, HT02.C88, HT02.C89, HT02.C90, HT02.C91, HT02.C92, HT02.C93, HT02.C94, HT02.C95, 
					HT02.C96, HT02.C97, HT02.C98,HT02.C99, HT02.C100,HT02.C101, HT02.C102, HT02.C103, HT02.C104, HT02.C105, HT02.C106, HT02.C107, HT02.C108, 
					HT02.C109, HT02.C110, HT02.C111, HT02.C112, 
					HT02.C113, HT02.C114, HT02.C115, HT02.C116, HT02.C117, HT02.C118, HT02.C119, HT02.C120, HT02.C121, HT02.C122, HT02.C123, HT02.C124, 
					HT02.C125, HT02.C126, HT02.C127, HT02.C128, HT02.C129, HT02.C130, HT02.C131, HT02.C132, HT02.C133, HT02.C134, HT02.C135, HT02.C136, 
					HT02.C137, HT02.C138, HT02.C139, HT02.C140, HT02.C141, HT02.C142, HT02.C143, HT02.C144, HT02.C145, HT02.C146, HT02.C147, HT02.C148, 
					HT02.C149, HT02.C150, HT01.WorkDate, Datediff(m, HT01.WorkDate,Getdate()) as WorkTerm, 
					HT01.EmployeeStatus, HT01.IsOtherDayPerMonth, HT01.RecruitDate, HT00.IsJobWage,HT00.IsPiecework
			FROM	'+@FromTableHT2400+' HT00  
			INNER JOIN	HV1400 HT01 on  HT00.DivisionID = HT01.DivisionID and HT00.EmployeeID = HT01.EmployeeID
			LEFT JOIN	HT2499 HT02 on  HT00.DivisionID = HT02.DivisionID and HT00.EmployeeID = HT02.EmployeeID AND HT00.TranMonth = HT02.TranMonth AND HT00.TranYear = HT02.TranYear
			WHERE	HT00.DivisionID = '''+@DivisionID+''' and HT00.DepartmentID LIKE '''+@DepartmentID+''' And
					isnull(HT00.TeamID,'''') Like '''+@TeamIDIn+''' and
					HT00.EmployeeID Like '''+@EmployeeIDIn+''' And (HT01.EmployeeStatus  = 1 or HT01.EmployeeStatus  = 2)
					And	HT00.TranMonth = '+STR(@FromTranMonth)+' AND HT00.TranYear = '+STR(@FromTranYear)+'

	'
		PRINT ('aaa'+@sSQL001)
		EXEC (@sSQL001)
	
		SET @HT2400Cursor = CURSOR SCROLL KEYSET FOR
			SELECT	EmployeeID, DivisionID, DepartmentID,  case when isnull(TeamID,'') = '' then NULL else TeamID end,
					SalaryCoefficient, TimeCoefficient, DutyCoefficient, BaseSalary, 
					TaxObjectID, InsuranceSalary,Salary01, Salary02, Salary03, 
					C01, C02, C03, C04, C05, C06, C07, C08, C09, C10, C11, C12, C13, 
					C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24, C25,
					C26, C27, C28, C29, C30, C31, C32, C33, C34, C35, C36, C37, C38, C39, 
					C40, C41, C42, C43, C44, C45, C46, C47, C48, C49, C50, C51, C52, C53, 
					C54, C55, C56, C57, C58, C59, C60, C61, C62, C63, C64, C65, C66, C67, 
					C68, C69, C70, C71, C72, C73, C74, C75, C76, C77, C78, C79, C80, C81, 
					C82, C83, C84, C85, C86, C87, C88, C89, C90, C91, C92, C93, C94, C95, 
					C96, C97, C98, C99, C100,C101, C102, C103, C104, C105, C106, C107, C108, C109, C110, C111, C112, 
					C113, C114, C115, C116, C117, C118, C119, C120, C121, C122, C123, C124, 
					C125, C126, C127, C128, C129, C130, C131, C132, C133, C134, C135, C136, 
					C137, C138, C139, C140, C141, C142, C143, C144, C145, C146, C147, C148, 
					C149, C150, WorkDate, Datediff(m, WorkDate,Getdate()) as WorkTerm, 
					EmployeeStatus, IsOtherDayPerMonth, RecruitDate, IsJobWage,IsPiecework
			FROM	#HT2400  
	
		OPEN @HT2400Cursor
	
		FETCH NEXT FROM @HT2400Cursor INTO  @EmployeeID, @DivisionID1, @DepartmentID1, @TeamID, 
				@SalaryCoefficient,	@TimeCoefficient, @DutyCoefficient, @BaseSalary, 
				@TaxObjectID,@InsuranceSalary, @Salary01, @Salary02, @Salary03, 
				@C01,@C02, @C03, @C04, @C05, @C06, @C07, @C08, @C09, @C10, @C11, @C12, @C13,
				@C14, @C15, @C16, @C17, @C18, @C19, @C20, @C21, @C22, @C23, @C24, @C25, 
				@C26, @C27, @C28, @C29, @C30, @C31, @C32, 
				@C33, @C34, @C35, @C36, @C37, @C38, @C39, @C40, @C41, @C42, @C43, @C44, @C45, @C46, 
				@C47, @C48, @C49, @C50, @C51, @C52, @C53, @C54, @C55, @C56, @C57, @C58, @C59, @C60, 
				@C61, @C62, @C63, @C64, @C65, @C66, @C67, @C68, @C69, @C70, @C71, @C72, @C73, @C74, 
				@C75, @C76, @C77, @C78, @C79, @C80, @C81, @C82, @C83, @C84, @C85, @C86, @C87, @C88, 
				@C89, @C90, @C91, @C92, @C93, @C94, @C95, @C96, @C97, @C98, @C99, @C100,
				@C101, @C102, @C103, @C104, @C105, @C106, @C107, @C108, @C109, @C110, @C111, @C112, 
				@C113, @C114, @C115, @C116, @C117, @C118, @C119, @C120, @C121, @C122, @C123, @C124, 
				@C125, @C126, @C127, @C128, @C129, @C130, @C131, @C132, @C133, @C134, @C135, @C136, 
				@C137, @C138, @C139, @C140, @C141, @C142, @C143, @C144, @C145, @C146, @C147, @C148, 
				@C149, @C150, @WorkDate, @WorkTerm, @EmployeeStatus, @IsOtherDayPerMonth,@RecruitDate, @IsJobWage, @IsPiecework
--print "4";
		WHILE @@FETCH_STATUS = 0
		BEGIN
			IF @CustomerIndex = 74	--- GODREJ
				SET @sSQL002 = '
					DECLARE @EmpFileID VARCHAR(50)
					IF not Exists(SELECT EmployeeID FROM '+@TableHT2400+' WHERE EmployeeID = '''+@EmployeeID+''' AND DivisionID = '''+@DivisionID1+'''
										-- AND DepartmentID = @DepartmentID1 and isnull(TeamID, '') =isnull( @TeamID,'')
										AND TranMonth = '+STR(@TranMonth)+'	
										AND TranYear = '+STR(@TranYear)+' )
					BEGIN
					Exec AP0000  '''+@DivisionID1+''', @EmpFileID OUTPUT, ''HT2400'', ''HS'', '''+@TempYear+''', '''+@TempMonth+''', 15, 3, 0, ''''
					
					INSERT INTO '+@TableHT2400+' (EmpFileID, EmployeeID, DivisionID, DepartmentID, TeamID,
							BaseSalary, TaxObjectID,InsuranceSalary, Salary01, Salary02, Salary03, 
							SalaryCoefficient, TimeCoefficient, DutyCoefficient,
							C01, C02, C03, C04, C05, C06, C07, C08, C09, C10, C11, C12, C13,
							C14, C19, C21, C22, C23, C24,
							TranMonth, TranYear ,WorkTerm, EmployeeStatus, IsOtherDayPerMonth,
							CreateDate, CreateUserID,LastModifyDate,LastmodifyUserID,
							IsJobWage, IsPiecework)
	
					VALUES (@EmpFileID, '''+@EmployeeID+''', '''+@DivisionID1+''', '''+@DepartmentID1+''', '''+ISNULL(@TeamID,'')+''',
							'+Convert(Varchar(50),ISNULL(@BaseSalary,0))+', '''+ISNULL(@TaxObjectID,'')+''', '+Convert(Varchar(50),ISNULL(@InsuranceSalary,0))+', '+Convert(Varchar(50),ISNULL(@Salary01,0))+', '+Convert(Varchar(50),ISNULL(@Salary02,0))+','+Convert(Varchar(50),ISNULL(@Salary03,0))+', 
							'+Convert(Varchar(50),ISNULL(@SalaryCoefficient,0))+', '+Convert(Varchar(50),ISNULL(@TimeCoefficient,0))+', '+Convert(Varchar(50),ISNULL(@DutyCoefficient,0))+',
							'+Convert(Varchar(50),ISNULL(@C01,0))+', '+Convert(Varchar(50),ISNULL(@C02,0))+', '+Convert(Varchar(50),ISNULL(@C03,0))+', 
							'+Convert(Varchar(50),ISNULL(@C04,0))+', '+Convert(Varchar(50),ISNULL(@C05,0))+', '+Convert(Varchar(50),ISNULL(@C06,0))+', 
							'+Convert(Varchar(50),ISNULL(@C07,0))+', '+Convert(Varchar(50),ISNULL(@C08,0))+', '+Convert(Varchar(50),ISNULL(@C09,0))+',
							'+Convert(Varchar(50),ISNULL(@C10,0))+', '+Convert(Varchar(50),ISNULL(@C11,0))+', '+Convert(Varchar(50),ISNULL(@C12,0))+', 
							'+Convert(Varchar(50),ISNULL(@C13,0))+', '+Convert(Varchar(50),ISNULL(@C14,0))+', 		
							'+Convert(Varchar(50),ISNULL(@C19,0))+', '+Convert(Varchar(50),ISNULL(@C21,0))+', 
							'+Convert(Varchar(50),ISNULL(@C22,0))+', '+Convert(Varchar(50),ISNULL(@C23,0))+', '+Convert(Varchar(50),ISNULL(@C24,0))+', 					
							'+STR(@TranMonth)+', '+STR(@TranYear)+', '+Convert(Varchar(50),ISNULL(@WorkTerm,0))+', '+STR(@EmployeeStatus)+', '+STR(ISNULL(@IsOtherDayPerMonth,0))+',
							'''+CONVERT(VARCHAR(50),@CreateDate,120)+''','''+@CreateUserID+''','''+CONVERT(VARCHAR(50),@CreateDate,120)+''','''+@CreateUserID+''',
							'+STR(ISNULL(@IsJobWage,0))+','+STR(ISNULL(@IsPiecework,0))+' )	
					'
				ELSE
					SET @sSQL002 = '
					DECLARE @EmpFileID VARCHAR(50)
					IF not Exists(SELECT EmployeeID FROM '+@TableHT2400+' WHERE EmployeeID = '''+@EmployeeID+''' AND DivisionID = '''+@DivisionID1+'''
										-- AND DepartmentID = @DepartmentID1 and isnull(TeamID, '') =isnull( @TeamID,'')
										AND TranMonth = '+STR(@TranMonth)+'	
										AND TranYear = '+STR(@TranYear)+' )
						BEGIN
						Exec AP0000  '''+@DivisionID1+''', @EmpFileID OUTPUT, ''HT2400'', ''HS'', '''+@TempYear+''', '''+@TempMonth+''', 15, 3, 0, ''''
					
						INSERT INTO '+@TableHT2400+' (EmpFileID, EmployeeID, DivisionID, DepartmentID, TeamID,
								BaseSalary, TaxObjectID,InsuranceSalary, Salary01, Salary02, Salary03, 
								SalaryCoefficient, TimeCoefficient, DutyCoefficient,
								C01, C02, C03, C04, C05, C06, C07, C08, C09, C10, C11, C12, C13,
								C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24, C25,
								TranMonth, TranYear ,WorkTerm, EmployeeStatus, IsOtherDayPerMonth,
								CreateDate, CreateUserID,LastModifyDate,LastmodifyUserID,
								IsJobWage, IsPiecework)
	
						VALUES (@EmpFileID, '''+@EmployeeID+''', '''+@DivisionID1+''', '''+@DepartmentID1+''', '''+ISNULL(@TeamID,'')+''',
								'+Convert(Varchar(50),ISNULL(@BaseSalary,0))+', '''+ISNULL(@TaxObjectID,'')+''', '+Convert(Varchar(50),ISNULL(@InsuranceSalary,0))+', '+Convert(Varchar(50),ISNULL(@Salary01,0))+', '+Convert(Varchar(50),ISNULL(@Salary02,0))+','+Convert(Varchar(50),ISNULL(@Salary03,0))+', 
								'+Convert(Varchar(50),ISNULL(@SalaryCoefficient,0))+', '+Convert(Varchar(50),ISNULL(@TimeCoefficient,0))+', '+Convert(Varchar(50),ISNULL(@DutyCoefficient,0))+',
								'+Convert(Varchar(50),ISNULL(@C01,0))+', '+Convert(Varchar(50),ISNULL(@C02,0))+', '+Convert(Varchar(50),ISNULL(@C03,0))+', 
								'+Convert(Varchar(50),ISNULL(@C04,0))+', '+Convert(Varchar(50),ISNULL(@C05,0))+', '+Convert(Varchar(50),ISNULL(@C06,0))+', 
								'+Convert(Varchar(50),ISNULL(@C07,0))+', '+Convert(Varchar(50),ISNULL(@C08,0))+', '+Convert(Varchar(50),ISNULL(@C09,0))+',
								'+Convert(Varchar(50),ISNULL(@C10,0))+', '+Convert(Varchar(50),ISNULL(@C11,0))+', '+Convert(Varchar(50),ISNULL(@C12,0))+', 
								'+Convert(Varchar(50),ISNULL(@C13,0))+', '+Convert(Varchar(50),ISNULL(@C14,0))+', '+Convert(Varchar(50),ISNULL(@C15,0))+', 
								'+Convert(Varchar(50),ISNULL(@C16,0))+', '+Convert(Varchar(50),ISNULL(@C17,0))+', '+Convert(Varchar(50),ISNULL(@C18,0))+', 
								'+Convert(Varchar(50),ISNULL(@C19,0))+', '+Convert(Varchar(50),ISNULL(@C20,0))+', '+Convert(Varchar(50),ISNULL(@C21,0))+', 
								'+Convert(Varchar(50),ISNULL(@C22,0))+', '+Convert(Varchar(50),ISNULL(@C23,0))+', '+Convert(Varchar(50),ISNULL(@C24,0))+', 
								'+Convert(Varchar(50),ISNULL(@C25,0))+',
								'+STR(@TranMonth)+', '+STR(@TranYear)+', '+Convert(Varchar(50),ISNULL(@WorkTerm,0))+', '+STR(@EmployeeStatus)+', '+STR(ISNULL(@IsOtherDayPerMonth,0))+',
								'''+CONVERT(VARCHAR(50),@CreateDate,120)+''','''+@CreateUserID+''','''+CONVERT(VARCHAR(50),@CreateDate,120)+''','''+@CreateUserID+''',
								'+STR(ISNULL(@IsJobWage,0))+','+STR(ISNULL(@IsPiecework,0))+' )	
						'
				SET @sSQL003 = '
				-----Bổ sung C26->C100
				INSERT INTO HT2499 (EmpFileID, EmployeeID, DivisionID, 
				C26, C27, C28, C29, C30, C31, C32, C33, C34, C35, C36, C37, C38, C39, 
				C40, C41, C42, C43, C44, C45, C46, C47, C48, C49, C50, C51, C52, C53, 
				C54, C55, C56, C57, C58, C59, C60, C61, C62, C63, C64, C65, C66, C67, 
				C68, C69, C70, C71, C72, C73, C74, C75, C76, C77, C78, C79, C80, C81, 
				C82, C83, C84, C85, C86, C87, C88, C89, C90, C91, C92, C93, C94, C95, 
				C96, C97, C98, C99, C100, C101, C102, C103, C104, C105, C106, C107, C108, C109, C110, C111, C112, 
				C113, C114, C115, C116, C117, C118, C119, C120, C121, C122, C123, C124, 
				C125, C126, C127, C128, C129, C130, C131, C132, C133, C134, C135, C136, 
				C137, C138, C139, C140, C141, C142, C143, C144, C145, C146, C147, C148, 
				C149, C150, TranMonth, TranYear, CreateDate, CreateUserID,LastModifyDate,LastmodifyUserID )
				VALUES (@EmpFileID, '''+@EmployeeID+''', '''+@DivisionID1+''', 
				'+Convert(Varchar(50),ISNULL(@C26,0))+', '+Convert(Varchar(50),ISNULL(@C27,0))+', 
				'+Convert(Varchar(50),ISNULL(@C28,0))+', '+Convert(Varchar(50),ISNULL(@C29,0))+', '+Convert(Varchar(50),ISNULL(@C30,0))+', 
				'+Convert(Varchar(50),ISNULL(@C31,0))+', '+Convert(Varchar(50),ISNULL(@C32,0))+', '+Convert(Varchar(50),ISNULL(@C33,0))+', 
				'+Convert(Varchar(50),ISNULL(@C34,0))+', '+Convert(Varchar(50),ISNULL(@C35,0))+', '+Convert(Varchar(50),ISNULL(@C36,0))+', 
				'+Convert(Varchar(50),ISNULL(@C37,0))+', '+Convert(Varchar(50),ISNULL(@C38,0))+', '+Convert(Varchar(50),ISNULL(@C39,0))+', 
				'+Convert(Varchar(50),ISNULL(@C40,0))+', '+Convert(Varchar(50),ISNULL(@C41,0))+', '+Convert(Varchar(50),ISNULL(@C42,0))+', 
				'+Convert(Varchar(50),ISNULL(@C43,0))+', '+Convert(Varchar(50),ISNULL(@C44,0))+', '+Convert(Varchar(50),ISNULL(@C45,0))+', 
				'+Convert(Varchar(50),ISNULL(@C46,0))+', '+Convert(Varchar(50),ISNULL(@C47,0))+', '+Convert(Varchar(50),ISNULL(@C48,0))+', 
				'+Convert(Varchar(50),ISNULL(@C49,0))+', '+Convert(Varchar(50),ISNULL(@C50,0))+', '+Convert(Varchar(50),ISNULL(@C51,0))+', 
				'+Convert(Varchar(50),ISNULL(@C52,0))+', '+Convert(Varchar(50),ISNULL(@C53,0))+', '+Convert(Varchar(50),ISNULL(@C54,0))+', 
				'+Convert(Varchar(50),ISNULL(@C55,0))+', '+Convert(Varchar(50),ISNULL(@C56,0))+', '+Convert(Varchar(50),ISNULL(@C57,0))+', 
				'+Convert(Varchar(50),ISNULL(@C58,0))+', '+Convert(Varchar(50),ISNULL(@C59,0))+', '+Convert(Varchar(50),ISNULL(@C60,0))+', 
				'+Convert(Varchar(50),ISNULL(@C61,0))+', '+Convert(Varchar(50),ISNULL(@C62,0))+', '+Convert(Varchar(50),ISNULL(@C63,0))+', 
				'+Convert(Varchar(50),ISNULL(@C64,0))+', '+Convert(Varchar(50),ISNULL(@C65,0))+', '+Convert(Varchar(50),ISNULL(@C66,0))+', 
				'+Convert(Varchar(50),ISNULL(@C67,0))+', '+Convert(Varchar(50),ISNULL(@C68,0))+', '+Convert(Varchar(50),ISNULL(@C69,0))+', 
				'+Convert(Varchar(50),ISNULL(@C70,0))+', '+Convert(Varchar(50),ISNULL(@C71,0))+', '+Convert(Varchar(50),ISNULL(@C72,0))+', 
				'+Convert(Varchar(50),ISNULL(@C73,0))+', '+Convert(Varchar(50),ISNULL(@C74,0))+', '+Convert(Varchar(50),ISNULL(@C75,0))+', 
				'+Convert(Varchar(50),ISNULL(@C76,0))+', '+Convert(Varchar(50),ISNULL(@C77,0))+', '+Convert(Varchar(50),ISNULL(@C78,0))+', 
				'+Convert(Varchar(50),ISNULL(@C79,0))+', '+Convert(Varchar(50),ISNULL(@C80,0))+', '+Convert(Varchar(50),ISNULL(@C81,0))+', 
				'+Convert(Varchar(50),ISNULL(@C82,0))+', '+Convert(Varchar(50),ISNULL(@C83,0))+', '+Convert(Varchar(50),ISNULL(@C84,0))+', 
				'+Convert(Varchar(50),ISNULL(@C85,0))+', '+Convert(Varchar(50),ISNULL(@C86,0))+', '+Convert(Varchar(50),ISNULL(@C87,0))+', 
				'+Convert(Varchar(50),ISNULL(@C88,0))+', '+Convert(Varchar(50),ISNULL(@C89,0))+', '+Convert(Varchar(50),ISNULL(@C90,0))+', 
				'+Convert(Varchar(50),ISNULL(@C91,0))+', '+Convert(Varchar(50),ISNULL(@C92,0))+', '+Convert(Varchar(50),ISNULL(@C93,0))+', 
				'+Convert(Varchar(50),ISNULL(@C94,0))+', '+Convert(Varchar(50),ISNULL(@C95,0))+', '+Convert(Varchar(50),ISNULL(@C96,0))+', 
				'+Convert(Varchar(50),ISNULL(@C97,0))+', '+Convert(Varchar(50),ISNULL(@C98,0))+', '+Convert(Varchar(50),ISNULL(@C99,0))+', 
				'+Convert(Varchar(50),ISNULL(@C100,0))+', '+Convert(Varchar(50),ISNULL(@C101,0))+','+Convert(Varchar(50),ISNULL(@C102,0))+',
				'+Convert(Varchar(50),ISNULL(@C103,0))+', '+Convert(Varchar(50),ISNULL(@C104,0))+', '+Convert(Varchar(50),ISNULL(@C105,0))+',
				'+Convert(Varchar(50),ISNULL(@C106,0))+', '+Convert(Varchar(50),ISNULL(@C107,0))+', '+Convert(Varchar(50),ISNULL(@C108,0))+', 
				'+Convert(Varchar(50),ISNULL(@C109,0))+', '+Convert(Varchar(50),ISNULL(@C110,0))+', '+Convert(Varchar(50),ISNULL(@C111,0))+', 
				'+Convert(Varchar(50),ISNULL(@C112,0))+', '+Convert(Varchar(50),ISNULL(@C113,0))+', '+Convert(Varchar(50),ISNULL(@C114,0))+', 
				'+Convert(Varchar(50),ISNULL(@C115,0))+', '+Convert(Varchar(50),ISNULL(@C116,0))+', '+Convert(Varchar(50),ISNULL(@C117,0))+', 
				'+Convert(Varchar(50),ISNULL(@C118,0))+', '+Convert(Varchar(50),ISNULL(@C119,0))+', '+Convert(Varchar(50),ISNULL(@C120,0))+', 
				'+Convert(Varchar(50),ISNULL(@C121,0))+', '+Convert(Varchar(50),ISNULL(@C122,0))+', '+Convert(Varchar(50),ISNULL(@C123,0))+', 
				'+Convert(Varchar(50),ISNULL(@C124,0))+', '+Convert(Varchar(50),ISNULL(@C125,0))+', '+Convert(Varchar(50),ISNULL(@C126,0))+', 
				'+Convert(Varchar(50),ISNULL(@C127,0))+', '+Convert(Varchar(50),ISNULL(@C128,0))+', '+Convert(Varchar(50),ISNULL(@C129,0))+', 
				'+Convert(Varchar(50),ISNULL(@C130,0))+', '+Convert(Varchar(50),ISNULL(@C131,0))+', '+Convert(Varchar(50),ISNULL(@C132,0))+', 
				'+Convert(Varchar(50),ISNULL(@C133,0))+', '+Convert(Varchar(50),ISNULL(@C134,0))+', '+Convert(Varchar(50),ISNULL(@C135,0))+', 
				'+Convert(Varchar(50),ISNULL(@C136,0))+', '+Convert(Varchar(50),ISNULL(@C137,0))+', '+Convert(Varchar(50),ISNULL(@C138,0))+', 
				'+Convert(Varchar(50),ISNULL(@C139,0))+', '+Convert(Varchar(50),ISNULL(@C140,0))+', '+Convert(Varchar(50),ISNULL(@C141,0))+', 
				'+Convert(Varchar(50),ISNULL(@C142,0))+', '+Convert(Varchar(50),ISNULL(@C143,0))+', '+Convert(Varchar(50),ISNULL(@C144,0))+', 
				'+Convert(Varchar(50),ISNULL(@C145,0))+', '+Convert(Varchar(50),ISNULL(@C146,0))+', '+Convert(Varchar(50),ISNULL(@C147,0))+', 
				'+Convert(Varchar(50),ISNULL(@C148,0))+', '+Convert(Varchar(50),ISNULL(@C149,0))+', '+Convert(Varchar(50),ISNULL(@C150,0))+', 
				'+STR(@TranMonth)+', '+STR(@TranYear)+', '''+CONVERT(VARCHAR(50),@CreateDate,120)+''','''+@CreateUserID+''','''+CONVERT(VARCHAR(50),@CreateDate,120)+''','''+@CreateUserID+''')
				END
			
			'
			--PRINT (@sSQL002)
			--PRINT (@sSQL003)
			EXEC (@sSQL002+@sSQL003)
	
		FETCH NEXT FROM @HT2400Cursor INTO  @EmployeeID, @DivisionID1, @DepartmentID1, @TeamID, 
				@SalaryCoefficient,	@TimeCoefficient, @DutyCoefficient, @BaseSalary, 
				@TaxObjectID,@InsuranceSalary, @Salary01, @Salary02, @Salary03, 
				@C01,@C02, @C03, @C04, @C05, @C06, @C07, @C08, @C09, @C10, @C11, @C12,  @C13,
				@C14, @C15, @C16, @C17, @C18, @C19, @C20, @C21, @C22, @C23, @C24, @C25, @C26, @C27, @C28, @C29, @C30, @C31, @C32, 
				@C33, @C34, @C35, @C36, @C37, @C38, @C39, @C40, @C41, @C42, @C43, @C44, @C45, @C46, 
				@C47, @C48, @C49, @C50, @C51, @C52, @C53, @C54, @C55, @C56, @C57, @C58, @C59, @C60, 
				@C61, @C62, @C63, @C64, @C65, @C66, @C67, @C68, @C69, @C70, @C71, @C72, @C73, @C74, 
				@C75, @C76, @C77, @C78, @C79, @C80, @C81, @C82, @C83, @C84, @C85, @C86, @C87, @C88, 
				@C89, @C90, @C91, @C92, @C93, @C94, @C95, @C96, @C97, @C98, @C99, @C100,
				@C101, @C102, @C103, @C104, @C105, @C106, @C107, @C108, @C109, @C110, @C111, @C112, 
				@C113, @C114, @C115, @C116, @C117, @C118, @C119, @C120, @C121, @C122, @C123, @C124, 
				@C125, @C126, @C127, @C128, @C129, @C130, @C131, @C132, @C133, @C134, @C135, @C136, 
				@C137, @C138, @C139, @C140, @C141, @C142, @C143, @C144, @C145, @C146, @C147, @C148, 
				@C149, @C150, @WorkDate, @WorkTerm, @EmployeeStatus, @IsOtherDayPerMonth,@RecruitDate, @IsJobWage, @IsPiecework
	 		END
			 
	CLOSE @HT2400Cursor
	DEALLOCATE @HT2400Cursor 	
END

Set nocount off
--print "5";
DROP TABLE #HT2400

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
