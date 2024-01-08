IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP3499]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP3499]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----- Created by Bảo Anh on 25/09/2013
----- Purpose: In tờ khai khấu trừ thuế TNCN và bảng kê thuế TNCN (mẫu 02/KK-TNCN và 05A/BK-TNCN)
---- Modified on 04/02/2015 by Lê Thị Hạnh: Bổ sung mẫu HR2706 - Chứng từ khấu trừ thuế Thu nhập cá nhân
---- Modified by Bảo Thy on 29/11/2016: Bổ sung lưu I21->I150 (MEIKO)
---- Modified by Bảo Thy on 17/01/2017: BỔ sung I151 -> I200 (MEIKO)
----- HP3499 @DivisionID=N'MK',@TranMonth=11,@TranYear=2016,@Type=2
					
CREATE PROCEDURE 	[dbo].[HP3499] 	
					@DivisionID as nvarchar(50),   		
					@TranMonth as int, 			
					@TranYear as int,
					@Type as tinyint	

AS
DECLARE @CustomerIndex INT
SELECT @CustomerIndex = CustomerName From CustomerIndex

IF @Type = 1	--- in tờ khai khấu trừ thuế TNCN 02/KK-TNCN
BEGIN
	Declare @EmpTotal as int,	--- tổng số lao động
			@ResEmpTotal as int,	--- tổng lao động cư trú có HĐLĐ
			@DeductedResEmpTotal as int,	--- tổng lao động cư trú đã khấu trừ thuế
			@DeductedNoResEmpTotal as int,	--- tổng lao động không cư trú đã khấu trừ thuế
			@ResHCSalaryTotal as decimal(28,8),	--- tổng TNCT trả cho lao động cư trú có HĐLĐ
			@ResNoHCSalaryTotal as decimal(28,8),	--- tổng TNCT trả cho lao động cư trú không có HĐLĐ
			@NoResSalaryTotal as decimal(28,8),	--- tổng TNCT trả cho lao động không cư trú
			@DeductedResHCSalaryTotal as decimal(28,8),	--- tổng TNCT trả cho lao động cư trú có HĐLĐ và thuộc diện khấu trừ thuế
			@DeductedResNoHCSalaryTotal as decimal(28,8),	--- tổng TNCT trả cho lao động cư trú không có HĐLĐ và thuộc diện khấu trừ thuế
			@DeductedNoResSalaryTotal as decimal(28,8),	--- tổng TNCT trả cho lao động không cư trú và thuộc diện khấu trừ thuế
			@DeductedResHCTaxTotal as decimal(28,8),	--- tổng thuế TNCN đã khấu trừ dành cho lao động cư trú có HĐLĐ
			@DeductedResNoHCTaxTotal as decimal(28,8)	--- tổng thuế TNCN đã khấu trừ dành cho lao động cư trú không có HĐLĐ
			

	SELECT @EmpTotal = COUNT (EmployeeID)
	FROM HT3400
	WHERE DivisionID = @DivisionID And TranMonth = @TranMonth And TranYear = @TranYear

	SELECT @ResEmpTotal = COUNT (HT3400.EmployeeID)
	FROM HT3400
	INNER JOIN HT1400 On HT3400.DivisionID = HT1400.DivisionID And HT3400.EmployeeID = HT1400.EmployeeID
	WHERE HT3400.DivisionID = @DivisionID And HT3400.TranMonth = @TranMonth And HT3400.TranYear = @TranYear
	AND HT3400.EmployeeID in (Select HT1360.EmployeeID From HT1360
							INNER JOIN HT1105 On HT1360.DivisionID = HT1105.DivisionID And HT1360.ContractTypeID = HT1105.ContractTypeID
							Where HT1360.DivisionID = HT3400.DivisionID And HT1105.Months >= 3
							And month(dateadd(month,HT1105.Months,HT1360.SignDate)) + year(dateadd(month,HT1105.Months,HT1360.SignDate)) * 12 >= @TranMonth + @TranYear*12
							)
	 And HT1400.CountryID = 'VN'

	SELECT @DeductedResEmpTotal = COUNT (HT0338.EmployeeID)
	FROM HT0338
	INNER JOIN HT1400 On HT0338.DivisionID = HT1400.DivisionID And HT0338.EmployeeID = HT1400.EmployeeID
	WHERE HT0338.DivisionID = @DivisionID And HT0338.TranMonth = @TranMonth And HT0338.TranYear = @TranYear
	AND HT0338.IncomeTax > 0 AND HT1400.CountryID = 'VN'

	SELECT @DeductedNoResEmpTotal = COUNT (HT0338.EmployeeID)
	FROM HT0338
	INNER JOIN HT1400 On HT0338.DivisionID = HT1400.DivisionID And HT0338.EmployeeID = HT1400.EmployeeID
	WHERE HT0338.DivisionID = @DivisionID And HT0338.TranMonth = @TranMonth And HT0338.TranYear = @TranYear
	AND HT0338.IncomeTax > 0 AND HT1400.CountryID <> 'VN'

	SELECT @ResHCSalaryTotal = Isnull(Sum(HT0338.TotalAmount),0)
	FROM HT0338
	INNER JOIN HT1400 On HT0338.DivisionID = HT1400.DivisionID And HT0338.EmployeeID = HT1400.EmployeeID
	WHERE HT0338.DivisionID = @DivisionID And HT0338.TranMonth = @TranMonth And HT0338.TranYear = @TranYear
	AND HT0338.EmployeeID in (Select HT1360.EmployeeID From HT1360
							INNER JOIN HT1105 On HT1360.DivisionID = HT1105.DivisionID And HT1360.ContractTypeID = HT1105.ContractTypeID
							Where HT1360.DivisionID = HT0338.DivisionID And HT1105.Months >= 3
							And month(dateadd(month,HT1105.Months,HT1360.SignDate)) + year(dateadd(month,HT1105.Months,HT1360.SignDate)) * 12 >= @TranMonth + @TranYear*12
							)
	And HT1400.CountryID = 'VN'

	SELECT @ResNoHCSalaryTotal = Isnull(Sum(HT0338.TotalAmount),0)
	FROM HT0338
	INNER JOIN HT1400 On HT0338.DivisionID = HT1400.DivisionID And HT0338.EmployeeID = HT1400.EmployeeID
	WHERE HT0338.DivisionID = @DivisionID And HT0338.TranMonth = @TranMonth And HT0338.TranYear = @TranYear
	AND HT0338.EmployeeID not in (Select HT1360.EmployeeID From HT1360
							INNER JOIN HT1105 On HT1360.DivisionID = HT1105.DivisionID And HT1360.ContractTypeID = HT1105.ContractTypeID
							Where HT1360.DivisionID = HT0338.DivisionID And HT1105.Months >= 3
							And month(dateadd(month,HT1105.Months,HT1360.SignDate)) + year(dateadd(month,HT1105.Months,HT1360.SignDate)) * 12 >= @TranMonth + @TranYear*12
							)
	And HT1400.CountryID = 'VN'

	SELECT @NoResSalaryTotal = Isnull(Sum(HT0338.TotalAmount),0)
	FROM HT0338
	INNER JOIN HT1400 On HT0338.DivisionID = HT1400.DivisionID And HT0338.EmployeeID = HT1400.EmployeeID
	WHERE HT0338.DivisionID = @DivisionID And HT0338.TranMonth = @TranMonth And HT0338.TranYear = @TranYear
	And HT1400.CountryID <> 'VN'

	SELECT @DeductedResHCSalaryTotal = Isnull(Sum(HT0338.TotalAmount),0), @DeductedResHCTaxTotal = Isnull(Sum(HT0338.IncomeTax),0)
	FROM HT0338
	INNER JOIN HT1400 On HT0338.DivisionID = HT1400.DivisionID And HT0338.EmployeeID = HT1400.EmployeeID
	WHERE HT0338.DivisionID = @DivisionID And HT0338.TranMonth = @TranMonth And HT0338.TranYear = @TranYear
	AND HT0338.EmployeeID in (Select HT1360.EmployeeID From HT1360
							INNER JOIN HT1105 On HT1360.DivisionID = HT1105.DivisionID And HT1360.ContractTypeID = HT1105.ContractTypeID
							Where HT1360.DivisionID = HT0338.DivisionID And HT1105.Months >= 3
							And month(dateadd(month,HT1105.Months,HT1360.SignDate)) + year(dateadd(month,HT1105.Months,HT1360.SignDate)) * 12 >= @TranMonth + @TranYear*12
							)
	AND HT0338.IncomeTax > 0 And HT1400.CountryID = 'VN'

	SELECT @DeductedResNoHCSalaryTotal = Isnull(Sum(HT0338.TotalAmount),0), @DeductedResNoHCTaxTotal = Isnull(Sum(HT0338.IncomeTax),0)
	FROM HT0338
	INNER JOIN HT1400 On HT0338.DivisionID = HT1400.DivisionID And HT0338.EmployeeID = HT1400.EmployeeID
	WHERE HT0338.DivisionID = @DivisionID And HT0338.TranMonth = @TranMonth And HT0338.TranYear = @TranYear
	AND HT0338.EmployeeID not in (Select HT1360.EmployeeID From HT1360
							INNER JOIN HT1105 On HT1360.DivisionID = HT1105.DivisionID And HT1360.ContractTypeID = HT1105.ContractTypeID
							Where HT1360.DivisionID = HT0338.DivisionID And HT1105.Months >= 3
							And month(dateadd(month,HT1105.Months,HT1360.SignDate)) + year(dateadd(month,HT1105.Months,HT1360.SignDate)) * 12 >= @TranMonth + @TranYear*12
							)
	AND HT0338.IncomeTax > 0 And HT1400.CountryID = 'VN'

	SELECT @DeductedNoResSalaryTotal = Isnull(Sum(HT0338.TotalAmount),0)
	FROM HT0338
	INNER JOIN HT1400 On HT0338.DivisionID = HT1400.DivisionID And HT0338.EmployeeID = HT1400.EmployeeID
	WHERE HT0338.DivisionID = @DivisionID And HT0338.TranMonth = @TranMonth And HT0338.TranYear = @TranYear
	AND HT0338.IncomeTax > 0 And HT1400.CountryID <> 'VN'

	--- Trả ra dữ liệu
	SELECT DivisionName, VATNO, [Address], Tel, Fax, Email,
	@EmpTotal as EmpTotal, @ResEmpTotal as ResEmpTotal, @DeductedResEmpTotal as DeductedResEmpTotal,
	@DeductedNoResEmpTotal as DeductedNoResEmpTotal, @ResHCSalaryTotal as ResHCSalaryTotal, @ResNoHCSalaryTotal as ResNoHCSalaryTotal,
	@NoResSalaryTotal as NoResSalaryTotal, @DeductedResHCSalaryTotal as DeductedResHCSalaryTotal,
	@DeductedResNoHCSalaryTotal as DeductedResNoHCSalaryTotal, @DeductedNoResSalaryTotal as DeductedNoResSalaryTotal,
	@DeductedResHCTaxTotal as DeductedResHCTaxTotal, @DeductedResNoHCTaxTotal as DeductedResNoHCTaxTotal

	FROM AT1101
	WHERE DivisionID = @DivisionID
END

ELSE	--- in bảng kê 05A/BK-TNCN + Chứng từ thuế TNCN
BEGIN
	SELECT	AT1101.DivisionName, AT1101.VATNO, HT34.EmployeeID, HV14.FullName, HV14.PersonalTaxID, HV14.IdentifyCardNo,
	Isnull(HT38.TotalAmount,0) as TotalAmount, ISNULL(HT38.TaxReducedAmount,0) as TaxReducedAmount,
	(Isnull(HT34.SubAmount01,0) + Isnull(HT34.SubAmount02,0) + Isnull(HT34.SubAmount03,0)) as InsAmount,
	ISNULL(HT38.IncomeTax,0) as IncomeTax, 
	-- Chung tu thue TNCN - HR2706
	AT1101.[Address], AT1101.Tel, AT1101.Fax, HV14.CountryName, HV14.FullAddress,
	HV14.PermanentAddress, HV14.TemporaryAddress, HV14.HomePhone, HV14.MobiPhone, 
	HV14.PassportNo, HV14.PassportDate, HV14.PassportEnd, HV14.IdentifyDate, HV14.IdentifyPlace,
	ISNULL(HT34.Income01,0) AS Income01, ISNULL(HT34.Income02,0) AS Income02, 
	ISNULL(HT34.Income03,0) AS Income03, ISNULL(HT34.Income04,0) AS Income04,
	ISNULL(HT34.Income05,0) AS Income05, ISNULL(HT34.Income06,0) AS Income06, 
	ISNULL(HT34.Income07,0) AS Income07, ISNULL(HT34.Income08,0) AS Income08,
	ISNULL(HT34.Income09,0) AS Income09, ISNULL(HT34.Income10,0) AS Income10, 
	ISNULL(HT34.Income11,0) AS Income11, ISNULL(HT34.Income12,0) AS Income12,
	ISNULL(HT34.Income13,0) AS Income13, ISNULL(HT34.Income14,0) AS Income14, 
	ISNULL(HT34.Income15,0) AS Income15, ISNULL(HT34.Income16,0) AS Income16,
	ISNULL(HT34.Income17,0) AS Income17, ISNULL(HT34.Income18,0) AS Income18, 
	ISNULL(HT34.Income19,0) AS Income19, ISNULL(HT34.Income20,0) AS Income20,
	ISNULL(HT34.Income21,0) AS Income21, ISNULL(HT34.Income22,0) AS Income22, 
	ISNULL(HT34.Income23,0) AS Income23, ISNULL(HT34.Income24,0) AS Income24,
	ISNULL(HT34.Income25,0) AS Income25, ISNULL(HT34.Income26,0) AS Income26, 
	ISNULL(HT34.Income27,0) AS Income27, ISNULL(HT34.Income28,0) AS Income28,
	ISNULL(HT34.Income29,0) AS Income29, ISNULL(HT34.Income30,0) AS Income30,
	ISNULL(HT35.Income31,0) AS Income31,
	ISNULL(HT35.Income32,0) AS Income32,
	ISNULL(HT35.Income33,0) AS Income33,
	ISNULL(HT35.Income34,0) AS Income34,
	ISNULL(HT35.Income35,0) AS Income35,
	ISNULL(HT35.Income36,0) AS Income36,
	ISNULL(HT35.Income37,0) AS Income37,
	ISNULL(HT35.Income38,0) AS Income38,
	ISNULL(HT35.Income39,0) AS Income39,
	ISNULL(HT35.Income40,0) AS Income40,
	ISNULL(HT35.Income41,0) AS Income41,
	ISNULL(HT35.Income42,0) AS Income42,
	ISNULL(HT35.Income43,0) AS Income43,
	ISNULL(HT35.Income44,0) AS Income44,
	ISNULL(HT35.Income45,0) AS Income45,
	ISNULL(HT35.Income46,0) AS Income46,
	ISNULL(HT35.Income47,0) AS Income47,
	ISNULL(HT35.Income48,0) AS Income48,
	ISNULL(HT35.Income49,0) AS Income49,
	ISNULL(HT35.Income50,0) AS Income50,
	ISNULL(HT35.Income51,0) AS Income51,
	ISNULL(HT35.Income52,0) AS Income52,
	ISNULL(HT35.Income53,0) AS Income53,
	ISNULL(HT35.Income54,0) AS Income54,
	ISNULL(HT35.Income55,0) AS Income55,
	ISNULL(HT35.Income56,0) AS Income56,
	ISNULL(HT35.Income57,0) AS Income57,
	ISNULL(HT35.Income58,0) AS Income58,
	ISNULL(HT35.Income59,0) AS Income59,
	ISNULL(HT35.Income60,0) AS Income60,
	ISNULL(HT35.Income61,0) AS Income61,
	ISNULL(HT35.Income62,0) AS Income62,
	ISNULL(HT35.Income63,0) AS Income63,
	ISNULL(HT35.Income64,0) AS Income64,
	ISNULL(HT35.Income65,0) AS Income65,
	ISNULL(HT35.Income66,0) AS Income66,
	ISNULL(HT35.Income67,0) AS Income67,
	ISNULL(HT35.Income68,0) AS Income68,
	ISNULL(HT35.Income69,0) AS Income69,
	ISNULL(HT35.Income70,0) AS Income70,
	ISNULL(HT35.Income71,0) AS Income71,
	ISNULL(HT35.Income72,0) AS Income72,
	ISNULL(HT35.Income73,0) AS Income73,
	ISNULL(HT35.Income74,0) AS Income74,
	ISNULL(HT35.Income75,0) AS Income75,
	ISNULL(HT35.Income76,0) AS Income76,
	ISNULL(HT35.Income77,0) AS Income77,
	ISNULL(HT35.Income78,0) AS Income78,
	ISNULL(HT35.Income79,0) AS Income79,
	ISNULL(HT35.Income80,0) AS Income80,
	ISNULL(HT35.Income81,0) AS Income81,
	ISNULL(HT35.Income82,0) AS Income82,
	ISNULL(HT35.Income83,0) AS Income83,
	ISNULL(HT35.Income84,0) AS Income84,
	ISNULL(HT35.Income85,0) AS Income85,
	ISNULL(HT35.Income86,0) AS Income86,
	ISNULL(HT35.Income87,0) AS Income87,
	ISNULL(HT35.Income88,0) AS Income88,
	ISNULL(HT35.Income89,0) AS Income89,
	ISNULL(HT35.Income90,0) AS Income90,
	ISNULL(HT35.Income91,0) AS Income91,
	ISNULL(HT35.Income92,0) AS Income92,
	ISNULL(HT35.Income93,0) AS Income93,
	ISNULL(HT35.Income94,0) AS Income94,
	ISNULL(HT35.Income95,0) AS Income95,
	ISNULL(HT35.Income96,0) AS Income96,
	ISNULL(HT35.Income97,0) AS Income97,
	ISNULL(HT35.Income98,0) AS Income98,
	ISNULL(HT35.Income99,0) AS Income99,
	ISNULL(HT35.Income100,0) AS Income100,
	ISNULL(HT35.Income101,0) AS Income101,
	ISNULL(HT35.Income102,0) AS Income102,
	ISNULL(HT35.Income103,0) AS Income103,
	ISNULL(HT35.Income104,0) AS Income104,
	ISNULL(HT35.Income105,0) AS Income105,
	ISNULL(HT35.Income106,0) AS Income106,
	ISNULL(HT35.Income107,0) AS Income107,
	ISNULL(HT35.Income108,0) AS Income108,
	ISNULL(HT35.Income109,0) AS Income109,
	ISNULL(HT35.Income110,0) AS Income110,
	ISNULL(HT35.Income111,0) AS Income111,
	ISNULL(HT35.Income112,0) AS Income112,
	ISNULL(HT35.Income113,0) AS Income113,
	ISNULL(HT35.Income114,0) AS Income114,
	ISNULL(HT35.Income115,0) AS Income115,
	ISNULL(HT35.Income116,0) AS Income116,
	ISNULL(HT35.Income117,0) AS Income117,
	ISNULL(HT35.Income118,0) AS Income118,
	ISNULL(HT35.Income119,0) AS Income119,
	ISNULL(HT35.Income120,0) AS Income120,
	ISNULL(HT35.Income121,0) AS Income121,
	ISNULL(HT35.Income122,0) AS Income122,
	ISNULL(HT35.Income123,0) AS Income123,
	ISNULL(HT35.Income124,0) AS Income124,
	ISNULL(HT35.Income125,0) AS Income125,
	ISNULL(HT35.Income126,0) AS Income126,
	ISNULL(HT35.Income127,0) AS Income127,
	ISNULL(HT35.Income128,0) AS Income128,
	ISNULL(HT35.Income129,0) AS Income129,
	ISNULL(HT35.Income130,0) AS Income130,
	ISNULL(HT35.Income131,0) AS Income131,
	ISNULL(HT35.Income132,0) AS Income132,
	ISNULL(HT35.Income133,0) AS Income133,
	ISNULL(HT35.Income134,0) AS Income134,
	ISNULL(HT35.Income135,0) AS Income135,
	ISNULL(HT35.Income136,0) AS Income136,
	ISNULL(HT35.Income137,0) AS Income137,
	ISNULL(HT35.Income138,0) AS Income138,
	ISNULL(HT35.Income139,0) AS Income139,
	ISNULL(HT35.Income140,0) AS Income140,
	ISNULL(HT35.Income141,0) AS Income141,
	ISNULL(HT35.Income142,0) AS Income142,
	ISNULL(HT35.Income143,0) AS Income143,
	ISNULL(HT35.Income144,0) AS Income144,
	ISNULL(HT35.Income145,0) AS Income145,
	ISNULL(HT35.Income146,0) AS Income146,
	ISNULL(HT35.Income147,0) AS Income147,
	ISNULL(HT35.Income148,0) AS Income148,
	ISNULL(HT35.Income149,0) AS Income149,
	ISNULL(HT35.Income150,0) AS Income150,
	ISNULL(HT35.Income151,0) AS Income151,
	ISNULL(HT35.Income152,0) AS Income152,
	ISNULL(HT35.Income153,0) AS Income153,
	ISNULL(HT35.Income154,0) AS Income154,
	ISNULL(HT35.Income155,0) AS Income155,
	ISNULL(HT35.Income156,0) AS Income156,
	ISNULL(HT35.Income157,0) AS Income157,
	ISNULL(HT35.Income158,0) AS Income158,
	ISNULL(HT35.Income159,0) AS Income159,
	ISNULL(HT35.Income160,0) AS Income160,
	ISNULL(HT35.Income161,0) AS Income161,
	ISNULL(HT35.Income162,0) AS Income162,
	ISNULL(HT35.Income163,0) AS Income163,
	ISNULL(HT35.Income164,0) AS Income164,
	ISNULL(HT35.Income165,0) AS Income165,
	ISNULL(HT35.Income166,0) AS Income166,
	ISNULL(HT35.Income167,0) AS Income167,
	ISNULL(HT35.Income168,0) AS Income168,
	ISNULL(HT35.Income169,0) AS Income169,
	ISNULL(HT35.Income170,0) AS Income170,
	ISNULL(HT35.Income171,0) AS Income171,
	ISNULL(HT35.Income172,0) AS Income172,
	ISNULL(HT35.Income173,0) AS Income173,
	ISNULL(HT35.Income174,0) AS Income174,
	ISNULL(HT35.Income175,0) AS Income175,
	ISNULL(HT35.Income176,0) AS Income176,
	ISNULL(HT35.Income177,0) AS Income177,
	ISNULL(HT35.Income178,0) AS Income178,
	ISNULL(HT35.Income179,0) AS Income179,
	ISNULL(HT35.Income180,0) AS Income180,
	ISNULL(HT35.Income181,0) AS Income181,
	ISNULL(HT35.Income182,0) AS Income182,
	ISNULL(HT35.Income183,0) AS Income183,
	ISNULL(HT35.Income184,0) AS Income184,
	ISNULL(HT35.Income185,0) AS Income185,
	ISNULL(HT35.Income186,0) AS Income186,
	ISNULL(HT35.Income187,0) AS Income187,
	ISNULL(HT35.Income188,0) AS Income188,
	ISNULL(HT35.Income189,0) AS Income189,
	ISNULL(HT35.Income190,0) AS Income190,
	ISNULL(HT35.Income191,0) AS Income191,
	ISNULL(HT35.Income192,0) AS Income192,
	ISNULL(HT35.Income193,0) AS Income193,
	ISNULL(HT35.Income194,0) AS Income194,
	ISNULL(HT35.Income195,0) AS Income195,
	ISNULL(HT35.Income196,0) AS Income196,
	ISNULL(HT35.Income197,0) AS Income197,
	ISNULL(HT35.Income198,0) AS Income198,
	ISNULL(HT35.Income199,0) AS Income199,
	ISNULL(HT35.Income200,0) AS Income200,
	HV14.Target01ID, HV14.Target02ID, HV14.Target03ID, HV14.Target04ID, HV14.Target05ID, 
	HV14.Target06ID, HV14.Target07ID, HV14.Target08ID, HV14.Target09ID, HV14.Target10ID
		
	FROM HT3400 HT34
	LEFT JOIN AT1101 On HT34.DivisionID = AT1101.DivisionID
	INNER JOIN HV1400 HV14 On HT34.DivisionID = HV14.DivisionID And HT34.EmployeeID = HV14.EmployeeID
	LEFT JOIN HT3499 HT35 On HT34.DivisionID = HT35.DivisionID And HT34.TransactionID = HT35.TransactionID
	--LEFT JOIN (Select * From HT0338 Where DivisionID = @DivisionID And TranMonth = @TranMonth And TranYear = @TranYear) HT38
	LEFT JOIN HT0338 HT38 
	On HT34.DivisionID = HT38.DivisionID And HT34.EmployeeID = HT38.EmployeeID
		AND HT38.DivisionID = @DivisionID AND HT38.TranMonth = @TranMonth AND HT38.TranYear = @TranYear

	WHERE HT34.DivisionID = @DivisionID And HT34.TranMonth = @TranMonth And HT34.TranYear = @TranYear
	ORDER BY HT34.EmployeeID
	
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

