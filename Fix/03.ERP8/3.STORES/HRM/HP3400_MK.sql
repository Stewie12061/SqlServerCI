IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP3400_MEKIO]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP3400_MEKIO]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- 
-- <Param>
---- Load dữ liệu tính lương (thay cho view HV3400)
-- <Return>
---- 
-- <Reference> HRM/Nghiep vu/ Tinh luong
---- Bang phan ca
-- <History>
-- <Example>
---- EXEC HP3400 'MK', 12, 2016, 'A000000','E000000','P05', 'aaa', 'bbbb'
CREATE PROCEDURE HP3400_MEKIO
(
	@DivisionID Varchar(50),
	@TranMonth int,
	@TranYear int,
	@FromDepartment nvarchar(50),
	@ToDepartment nvarchar(50),
	@PayrollMethodID nvarchar(50),
	@ConditionDE nvarchar(max),
	@IsUsedConditionDE NVARCHAR(MAX)
)
AS
DECLARE	@TableHT2400 Varchar(50),
		@sTranMonth Varchar(2)

SELECT @sTranMonth = CASE WHEN @TranMonth >9 THEN Convert(Varchar(2),@TranMonth) ELSE '0'+Convert(Varchar(1),@TranMonth) END

IF EXISTS (SELECT TOP 1 1 FROM AT0001 WHERE IsSplitTable = 1)	
BEGIN
	SELECT  @TableHT2400 = 'HT2400M'+@sTranMonth+Convert(Varchar(4),@TranYear)
END
ELSE
BEGIN
	SELECT  @TableHT2400 = 'HT2400'
END	

BEGIN
DECLARE @SQL VARCHAR(MAX) = ''
update HT0002
set @SQL = @SQL + CASE WHEN @SQL <> '' THEN ' + ISNULL(' + REPLACE(IncomeID,'I','Income')+',0)'  ELSE 'ISNULL(' + REPLACE(IncomeID,'I','Income') + ',0)' END
FROM HT0002 WHERE DivisionID = @DivisionID AND IsCalculateNetIncome = 1 AND IsUsed = 1

DECLARE @SQL1 VARCHAR(MAX) = ''
update HT0005
set @SQL1 = @SQL1 + CASE WHEN @SQL1 <> '' THEN ' - ISNULL(' + REPLACE(SubID,'S','SubAmount')+',0)'  ELSE 'ISNULL(' + REPLACE(SubID,'S','SubAmount') + ',0)' END
from HT0005 where DivisionID = @DivisionID AND IsCalculateNetIncome = 1 AND IsUsed = 1

DECLARE @SQL2 VARCHAR(8000) = ''
DECLARE @SQL3 VARCHAR(8000) = ''
DECLARE @SQL4 VARCHAR(8000) = ''
DECLARE @SQL5 VARCHAR(8000) = ''
DECLARE @SQL6 VARCHAR(8000) = ''

IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HTT3400]') AND  OBJECTPROPERTY(ID, N'IsTable') = 1)			
DROP TABLE [DBO].[HTT3400]

set @SQL2 = '
	Select HT3400.TransactionID,
        	HT3400.EmployeeID,
	HV1400.FullName,
	HT3400.DivisionID,
        	HT3400.TranMonth,
	HT3400.TranYear,
	HT3400.DepartmentID,         --- Phong ban
	HT3400.TeamID,             --- To nhom  
	IsNull(HV1400.DutyID,'''') as DutyID,
	GeneralCo,             	-- He so chung
	GeneralAbsentAmount,    ---Ngay cong quy doi
	
	HT2400.SalaryCoefficient as C11 ,   HT2400.TimeCoefficient as C12 ,    HT2400.DutyCoefficient  as C13 ,    
	HT2400.BaseSalary   as SA01,         HT2400.Salary01   as SA03   ,
	HT2400.InsuranceSalary as SA02 ,    HT2400.Salary02    as SA04   ,       HT2400.Salary03  as SA05  ,          HT2400.C01              ,     HT2400.C02      ,             HT2400.C03   ,       
	HT2400.C04    ,               HT2400.C05     ,              HT2400.C06          ,         HT2400.C07              ,     HT2400.C08        ,
	HT2400.C09       ,            HT2400.C10   ,

	IGAbsentAmount01, IGAbsentAmount02, IGAbsentAmount03, IGAbsentAmount04, IGAbsentAmount05,
	IGAbsentAmount06,IGAbsentAmount07,IGAbsentAmount08, IGAbsentAmount09,IGAbsentAmount10,
	IGAbsentAmount11, IGAbsentAmount12,IGAbsentAmount13,IGAbsentAmount14, IGAbsentAmount15,
	IGAbsentAmount16,IGAbsentAmount17,IGAbsentAmount18, IGAbsentAmount19,IGAbsentAmount20,
	IGAbsentAmount21, IGAbsentAmount22,IGAbsentAmount23,IGAbsentAmount24, IGAbsentAmount25,
	IGAbsentAmount26,IGAbsentAmount27,IGAbsentAmount28, IGAbsentAmount29,IGAbsentAmount30,
	'
SET @SQL3 = '
	Income01, Income02, Income03, Income04, Income05, Income06, Income07, Income08, Income09,  Income10, Income11, Income12, Income13,              
	Income14, Income15, Income16, Income17, Income18, Income19, Income20,       
    Income21, Income22, Income23, Income24, Income25, Income26, Income27, Income28, Income29, Income30,
	Income31,Income32, Income33, Income34, Income35, Income36, Income37, Income38, Income39, Income40, 
	Income41, Income42, Income43, Income44, Income45, Income46, Income47, Income48, Income49, Income50, 
	Income51, Income52, Income53, Income54, Income55, Income56, Income57, Income58, Income59, Income60, 
	Income61, Income62, Income63, Income64, Income65, Income66, Income67, Income68, Income69, Income70, 
	Income71, Income72, Income73, Income74, Income75, Income76, Income77, Income78, Income79, Income80, 
	Income81, Income82, Income83, Income84, Income85, Income86, Income87, Income88, Income89, Income90, 
	Income91, Income92, Income93, Income94, Income95, Income96, Income97, Income98, Income99, Income100, 
	Income101, Income102, Income103, Income104, Income105, Income106, Income107, Income108, Income109, Income110, 
	Income111, Income112, Income113, Income114, Income115, Income116, Income117, Income118, Income119, Income120, 
	Income121, Income122, Income123, Income124, Income125, Income126, Income127, Income128, Income129, Income130, 
	Income131, Income132, Income133, Income134, Income135, Income136, Income137, Income138, Income139, Income140, 
	Income141, Income142, Income143, Income144, Income145, Income146, Income147, Income148, Income149, Income150,
	Income151, Income152, Income153, Income154, Income155, Income156, Income157, Income158, Income159, Income160,
	Income161, Income162, Income163, Income164, Income165, Income166, Income167, Income168, Income169, Income170, 
	Income171, Income172, Income173, Income174, Income175, Income176, Income177, Income178, Income179, Income180, 
	Income181, Income182, Income183, Income184, Income185, Income186, Income187, Income188, Income189, Income190, 
	Income191, Income192, Income193, Income194, Income195, Income196, Income197, Income198, Income199, Income200,'
SET @SQL5 = '
    InsAmount, HeaAmount,     ----- BHYT        
	TempAmount ,   --  Tam Ung         
	TraAmount,        --- BHXH     
	TaxAmount,   	--- Thue thu nhap
    SubAmount01,           SubAmount02,           SubAmount03,           SubAmount04,
    SubAmount05, SubAmount06, SubAmount07, SubAmount08, SubAmount09, SubAmount10, 
	SubAmount11, SubAmount12, SubAmount13, SubAmount14, SubAmount15, SubAmount16, SubAmount17, SubAmount18, SubAmount19, SubAmount20, 
	SubAmount21, SubAmount22, SubAmount23, SubAmount24, SubAmount25, SubAmount26, SubAmount27, SubAmount28, SubAmount29, SubAmount30, 
	SubAmount31, SubAmount32, SubAmount33, SubAmount34, SubAmount35, SubAmount36, SubAmount37, SubAmount38, SubAmount39, SubAmount40, 
	SubAmount41, SubAmount42, SubAmount43, SubAmount44, SubAmount45, SubAmount46, SubAmount47, SubAmount48, SubAmount49, SubAmount50, 
	SubAmount51, SubAmount52, SubAmount53, SubAmount54, SubAmount55, SubAmount56, SubAmount57, SubAmount58, SubAmount59, SubAmount60, 
	SubAmount61, SubAmount62, SubAmount63, SubAmount64, SubAmount65, SubAmount66, SubAmount67, SubAmount68, SubAmount69, SubAmount70, 
	SubAmount71, SubAmount72, SubAmount73, SubAmount74, SubAmount75, SubAmount76, SubAmount77, SubAmount78, SubAmount79, SubAmount80, 
	SubAmount81, SubAmount82, SubAmount83, SubAmount84, SubAmount85, SubAmount86, SubAmount87, SubAmount88, SubAmount89, SubAmount90, 
	SubAmount91, SubAmount92, SubAmount93, SubAmount94, SubAmount95, SubAmount96, SubAmount97, SubAmount98, SubAmount99, SubAmount100,'
SET @SQL4  =  '0' + CASE WHEN ISNULL(@SQL,'') = '' THEN '' ELSE ' + ' + @SQL END + CASE WHEN ISNULL(@SQL1,'') = '' THEN '' ELSE ' - ' + @SQL1 END + ' AS SalaryBeforeMinusTax,'+
		CASE WHEN ISNULL(@SQL,'') = '' THEN '' ELSE @SQL END + CASE WHEN ISNULL(@SQL1,'') = '' THEN '' ELSE ' - ' + @SQL1 END+ '-  Isnull(TaxAmount, 0) AS SalaryAmount, '+ '
        PayrollMethodID,   ---- PP tinh luong
       	HV1400.Orders, 
       	HT3400.CreatedUserID, 
       	HT3400.CreateDate, 
       	HT3400.LastModifyUserID, 
       	HT3400.LastModifyDate, 
       	HT3400.CreateUserID ,
		HT3400.IsKeepSalary,
		HT3400.IsReceiveSalary,
		--------- Modify by Phương Thảo on 29/04/2016: Bổ sung 10 mã PT ----     
		ISNULL(HV1400.Ana01ID,'''') AS Ana01ID, ISNULL(HV1400.Ana02ID,'''') AS Ana02ID, ISNULL(HV1400.Ana03ID,'''') AS Ana03ID,
		ISNULL(HV1400.Ana04ID,'''') AS Ana04ID, ISNULL(HV1400.Ana05ID,'''') AS Ana05ID, ISNULL(HV1400.Ana06ID,'''') AS Ana06ID,
		ISNULL(HV1400.Ana07ID,'''') AS Ana07ID, ISNULL(HV1400.Ana08ID,'''') AS Ana08ID, ISNULL(HV1400.Ana09ID,'''') AS Ana09ID, ISNULL(HV1400.Ana10ID,'''') AS Ana10ID
INTO HTT3400
FROM HT3400 inner join '+@TableHT2400+' HT2400 on HT3400. DivisionID=HT2400.DivisionID and HT3400.EmployeeID=HT2400.EmployeeID
'
SET @SQL6 = '
AND HT3400.DepartmentID=HT2400.DepartmentID and IsNull(HT3400.TeamID,'''')=IsNull(HT2400.TeamID,'''')
AND HT3400.TranMonth=HT2400.TranMonth and HT3400.TranYear=HT2400.TranYear
INNER JOIN HV1400 on HV1400.EmployeeID = HT3400.EmployeeID and HV1400.DivisionID = HT3400.DivisionID
LEFT JOIN HT3499 ON HT3400.DivisionID = HT3499.DivisionID AND HT3400.TransactionID = HT3499.TransactionID 
WHERE (Isnull(HT3400.DepartmentID,''#'') IN ' + @ConditionDE + ' OR  ' + @IsUsedConditionDE + ')
	  AND HT3400.TranMonth = '+STR(@TranMonth)+'
      AND HT3400.TranYear= '+STR(@TranYear)+'
      AND HT3400.DivisionID = '''+@DivisionID+'''
	  AND HT3400.PayrollMethodID like '''+@PayrollMethodID	+'''
      AND HT3400.DepartmentID between ''' + @FromDepartment + ''' AND ''' + @ToDepartment + '''            
'
print @SQL2
print @SQL3
print @SQL5
print @SQL4
print @SQL6


exec (@SQL2+ @SQL3+@SQL5+@SQL4+@SQL6)
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
