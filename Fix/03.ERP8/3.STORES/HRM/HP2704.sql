IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP2704]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP2704]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



---------In to khai thue thu nhap ca nhan
-------Created by Le Hoai Minh
-------Create day 28-10-2005
------ Modified by bảo Thy on 30/11/2016: Bổ sung 150 khoản thu nhập (MEIKO)
------ Modified by Bảo Thy on 17/01/2017: BỔ sung I151 -> I200 (MEIKO)
/********************************************
'* Edited by: [GS] [Ngọc Nhựt] [29/07/2010]
EXEC HP2704 @ReportCode = 'aaa', @DivisionID = 'MK', @TranMonth=1, @TranYear=2017

'********************************************/

CREATE PROCEDURE [dbo].[HP2704]  @ReportCode nvarchar(50),
				@DivisionID NVARCHAR(50),
				@TranMonth int,
				@TranYear int

 AS
declare @LA0 as decimal (28, 8),
	@LA1 as decimal (28, 8),
	@LA as decimal (18,8),
	@LT as decimal (28, 8),
	@LT0 as decimal (28, 8),
	@LT1 as decimal (28, 8),
	@ST as decimal (28, 8),
	@ST0 as decimal (28, 8),
	@ST1 as decimal (28, 8),
	@TA as decimal (28, 8),
	@TA0 as decimal (28, 8),
	@TA1 as decimal (28, 8),
	@sSQL as nvarchar(4000),
	@sSQL1 as nvarchar(4000),
	@sSQL2 as nvarchar(4000),
	@sSQL3 as nvarchar(4000),
	@OT as decimal (28, 8),
	@OT9 as decimal (28, 8),
	@OT0 as decimal (28, 8),
	@OT1 as decimal (28, 8),
	@DataType as NVARCHAR(50),
	@EmployeeType as int,
	@LineID as NVARCHAR(50),
	@LineDescription as nvarchar(120),
	@Code as NVARCHAR(50),
	@Code0 as NVARCHAR(50),
	@Rate as decimal (28, 8),
	@Step as int,
	@IsBold as int,
	@IsItalic as int,
	@IsGray as int,
	@IsNotPrint as int,
	@Amount as decimal (28, 8),
	@Method int,
	@Cur_HT2704 as cursor,
	@CustomerIndex INT,
	@sSelect1 nvarchar(MAX)='', 
	@sSelect2 nvarchar(MAX)='', 
	@sSelect3 nvarchar(MAX)='' 
	
SELECT @CustomerIndex = CustomerName From CustomerIndex

----------Tinh tong so lao dong trong thang
select @LA =  count(EmployeeID) from HT2400 
	where DivisionID =  @DivisionID  and TranMonth = @TranMonth and
	TranYear = @TranYear and EmployeeStatus = 1 

select @LA0 = count(HT2400.EmployeeID) from HT2400 left join HT1400 on HT1400.DivisionID = HT2400.DivisionID and HT1400.DepartmentID = HT2400.DepartmentID
					and HT1400.EmployeeID = HT2400.EmployeeID
	where HT2400.DivisionID = @DivisionID  and HT2400.TranMonth = @TranMonth
		and HT2400.EmployeeStatus = 1 and isnull(HT1400.IsForeigner,'') = 0


select @LA1 = count(HT2400.EmployeeID) from HT2400 left join HT1400 on HT1400.DivisionID = HT2400.DivisionID and HT1400.DepartmentID = HT2400.DepartmentID
					and HT1400.EmployeeID = HT2400.EmployeeID
	where HT2400.DivisionID = @DivisionID  and HT2400.TranMonth = @TranMonth
		and HT2400.EmployeeStatus = 1 and isnull(HT1400.IsForeigner,'') = 1



-------------Tinh so nguoi thuoc dien nop thue thang nay ( La nhung nguoi co TaxAmount >0)
select @LT = count(HT3.EmployeeID) from HT3400  HT3 inner join HT2400 HT2 on HT3.DivisionID = HT2.DivisionID and HT3.DepartmentID = HT2.DepartmentID
					and HT3.EmployeeID = HT2.EmployeeID and HT3.TranMonth = HT2.TranMonth and HT3.TranYear = HT2.TranYear
	where HT2.DivisionID = @DivisionID and HT2.TranMonth = @TranMonth and HT2.TranYear = @TranYear
		and TaxAmount >0



select @LT0 = count(HT3.EmployeeID) from HT3400  HT3 inner join HT2400 HT2 on HT3.DivisionID = HT2.DivisionID and HT3.DepartmentID = HT2.DepartmentID
					and HT3.EmployeeID = HT2.EmployeeID and HT3.TranMonth = HT2.TranMonth and HT3.TranYear = HT2.TranYear
	where HT2.DivisionID = @DivisionID  and HT2.TranMonth = @TranMonth and HT2.TranYear = @TranYear
		and TaxAmount >0 and TaxObjectID like '%VN%'


 select @LT1 = count(HT3.EmployeeID) from HT3400  HT3 inner join HT2400 HT2 on HT3.DivisionID = HT2.DivisionID and HT3.DepartmentID = HT2.DepartmentID
					and HT3.EmployeeID = HT2.EmployeeID and HT3.TranMonth = HT2.TranMonth and HT3.TranYear = HT2.TranYear
	where HT2.DivisionID = @DivisionID  and HT2.TranMonth = @TranMonth and HT2.TranYear = @TranYear
		and TaxAmount >0 and TaxObjectID like '%FOR%'



---------------Tinh tong so thue da khau tru ( Lay tu truong TaxAmount cua bang HT3400)
select @TA  = sum(TaxAmount)  from HT3400 
	where TaxAmount >0 and HT3400.DivisionID = @DivisionID
		and HT3400.TranMonth = @TranMonth and HT3400.TranYear = @TranYear


select @TA0 = sum(TaxAmount) from HT3400 HT3 inner join HT2400 HT2 on HT3.DivisionID = HT2.DivisionID and HT3.DepartmentID = HT2.DepartmentID
			and HT3.EmployeeID = HT2.EmployeeID and HT3.TranMonth = HT2.TranMonth and HT3.TranYear = HT2.TranYear
	where HT3.DivisionID = @DivisionID and HT3.TranMonth = @TranMonth and HT3.TranYear = @TranYear
	and TaxAmount >0 and TaxObjectID like '%VN%'


select @TA1 = sum(TaxAmount) from HT3400 HT3 inner join HT2400 HT2 on HT3.DivisionID = HT2.DivisionID and HT3.DepartmentID = HT2.DepartmentID
			and HT3.EmployeeID = HT2.EmployeeID and HT3.TranMonth = HT2.TranMonth and HT3.TranYear = HT2.TranYear
	where HT3.DivisionID = @DivisionID  and HT3.TranMonth = @TranMonth and HT3.TranYear = @TranYear
	and TaxAmount >0 and TaxObjectID like '%FOR%'


		

----------Tong so tien chi tra cho ca nhan nop thue

---B1: Liet ke cac khoan thu nhap va giam tru chiu the cua nhan vien
----------Cac khoan thu nhap chiu thue
set @sSQL = 'select H01.DivisionID, H01.EmployeeID, H04.TaxObjectID,
	isnull(case when STUFF(H02.IncomeID,1,1,'''') = 01 then Income01
		when STUFF(H02.IncomeID,1,1,'''') = 02 then Income02 
		when STUFF(H02.IncomeID,1,1,'''') = 03 then Income03 
		when STUFF(H02.IncomeID,1,1,'''') = 04 then Income04 
		when STUFF(H02.IncomeID,1,1,'''') = 05 then Income05 
		when STUFF(H02.IncomeID,1,1,'''') = 06 then Income06 
		when STUFF(H02.IncomeID,1,1,'''') = 07 then Income07
		when STUFF(H02.IncomeID,1,1,'''') = 08 then Income08
		when STUFF(H02.IncomeID,1,1,'''') = 09 then Income09
		when STUFF(H02.IncomeID,1,1,'''') = 10 then Income10 
		when STUFF(H02.IncomeID,1,1,'''') = 11 then Income11
		when STUFF(H02.IncomeID,1,1,'''') = 12 then Income12 
		when STUFF(H02.IncomeID,1,1,'''') = 13 then Income13 
		when STUFF(H02.IncomeID,1,1,'''') = 14 then Income14 
		when STUFF(H02.IncomeID,1,1,'''') = 15 then Income15 
		when STUFF(H02.IncomeID,1,1,'''') = 16 then Income16 
		when STUFF(H02.IncomeID,1,1,'''') = 17 then Income17
		when STUFF(H02.IncomeID,1,1,'''') = 18 then Income18
		when STUFF(H02.IncomeID,1,1,'''') = 19 then Income19
		when STUFF(H02.IncomeID,1,1,'''') = 20 then Income20
		when STUFF(H02.IncomeID,1,1,'''') = 21 then Income21
		when STUFF(H02.IncomeID,1,1,'''') = 22 then Income22
		when STUFF(H02.IncomeID,1,1,'''') = 23 then Income23
		when STUFF(H02.IncomeID,1,1,'''') = 24 then Income24
		when STUFF(H02.IncomeID,1,1,'''') = 25 then Income25
		when STUFF(H02.IncomeID,1,1,'''') = 26 then Income26
		when STUFF(H02.IncomeID,1,1,'''') = 27 then Income27
		when STUFF(H02.IncomeID,1,1,'''') = 28 then Income28
		when STUFF(H02.IncomeID,1,1,'''') = 29 then Income29
		when STUFF(H02.IncomeID,1,1,'''') = 30 then Income30
		when STUFF(H02.IncomeID,1,1,'''') = 31 then Income31
		when STUFF(H02.IncomeID,1,1,'''') = 32 then Income32
		when STUFF(H02.IncomeID,1,1,'''') = 33 then Income33
		when STUFF(H02.IncomeID,1,1,'''') = 34 then Income34
		when STUFF(H02.IncomeID,1,1,'''') = 35 then Income35
		when STUFF(H02.IncomeID,1,1,'''') = 36 then Income36
		when STUFF(H02.IncomeID,1,1,'''') = 37 then Income37
		when STUFF(H02.IncomeID,1,1,'''') = 38 then Income38
		when STUFF(H02.IncomeID,1,1,'''') = 39 then Income39
		when STUFF(H02.IncomeID,1,1,'''') = 40 then Income40'
SET @sSelect1 = '
		when STUFF(H02.IncomeID,1,1,'''') = 41 then Income41
		when STUFF(H02.IncomeID,1,1,'''') = 42 then Income42
		when STUFF(H02.IncomeID,1,1,'''') = 43 then Income43
		when STUFF(H02.IncomeID,1,1,'''') = 44 then Income44
		when STUFF(H02.IncomeID,1,1,'''') = 45 then Income45
		when STUFF(H02.IncomeID,1,1,'''') = 46 then Income46
		when STUFF(H02.IncomeID,1,1,'''') = 47 then Income47
		when STUFF(H02.IncomeID,1,1,'''') = 48 then Income48
		when STUFF(H02.IncomeID,1,1,'''') = 49 then Income49
		when STUFF(H02.IncomeID,1,1,'''') = 50 then Income50
		when STUFF(H02.IncomeID,1,1,'''') = 51 then Income51
		when STUFF(H02.IncomeID,1,1,'''') = 52 then Income52
		when STUFF(H02.IncomeID,1,1,'''') = 53 then Income53
		when STUFF(H02.IncomeID,1,1,'''') = 54 then Income54
		when STUFF(H02.IncomeID,1,1,'''') = 55 then Income55
		when STUFF(H02.IncomeID,1,1,'''') = 56 then Income56
		when STUFF(H02.IncomeID,1,1,'''') = 57 then Income57
		when STUFF(H02.IncomeID,1,1,'''') = 58 then Income58
		when STUFF(H02.IncomeID,1,1,'''') = 59 then Income59
		when STUFF(H02.IncomeID,1,1,'''') = 60 then Income60
		when STUFF(H02.IncomeID,1,1,'''') = 61 then Income61
		when STUFF(H02.IncomeID,1,1,'''') = 62 then Income62
		when STUFF(H02.IncomeID,1,1,'''') = 63 then Income63
		when STUFF(H02.IncomeID,1,1,'''') = 64 then Income64
		when STUFF(H02.IncomeID,1,1,'''') = 65 then Income65
		when STUFF(H02.IncomeID,1,1,'''') = 66 then Income66
		when STUFF(H02.IncomeID,1,1,'''') = 67 then Income67
		when STUFF(H02.IncomeID,1,1,'''') = 68 then Income68
		when STUFF(H02.IncomeID,1,1,'''') = 69 then Income69
		when STUFF(H02.IncomeID,1,1,'''') = 70 then Income70
		when STUFF(H02.IncomeID,1,1,'''') = 71 then Income71
		when STUFF(H02.IncomeID,1,1,'''') = 72 then Income72
		when STUFF(H02.IncomeID,1,1,'''') = 73 then Income73
		when STUFF(H02.IncomeID,1,1,'''') = 74 then Income74
		when STUFF(H02.IncomeID,1,1,'''') = 75 then Income75
		when STUFF(H02.IncomeID,1,1,'''') = 76 then Income76
		when STUFF(H02.IncomeID,1,1,'''') = 77 then Income77
		when STUFF(H02.IncomeID,1,1,'''') = 78 then Income78
		when STUFF(H02.IncomeID,1,1,'''') = 79 then Income79
		when STUFF(H02.IncomeID,1,1,'''') = 80 then Income80
		when STUFF(H02.IncomeID,1,1,'''') = 81 then Income81
		when STUFF(H02.IncomeID,1,1,'''') = 82 then Income82
		when STUFF(H02.IncomeID,1,1,'''') = 83 then Income83
		when STUFF(H02.IncomeID,1,1,'''') = 84 then Income84
		when STUFF(H02.IncomeID,1,1,'''') = 85 then Income85
		when STUFF(H02.IncomeID,1,1,'''') = 86 then Income86
		when STUFF(H02.IncomeID,1,1,'''') = 87 then Income87
		when STUFF(H02.IncomeID,1,1,'''') = 88 then Income88
		when STUFF(H02.IncomeID,1,1,'''') = 89 then Income89
		when STUFF(H02.IncomeID,1,1,'''') = 90 then Income90
		when STUFF(H02.IncomeID,1,1,'''') = 91 then Income91
		when STUFF(H02.IncomeID,1,1,'''') = 92 then Income92
		when STUFF(H02.IncomeID,1,1,'''') = 93 then Income93
		when STUFF(H02.IncomeID,1,1,'''') = 94 then Income94
		when STUFF(H02.IncomeID,1,1,'''') = 95 then Income95
		when STUFF(H02.IncomeID,1,1,'''') = 96 then Income96
		when STUFF(H02.IncomeID,1,1,'''') = 97 then Income97
		when STUFF(H02.IncomeID,1,1,'''') = 98 then Income98
		when STUFF(H02.IncomeID,1,1,'''') = 99 then Income99'
SET @sSelect2 = '
		when STUFF(H02.IncomeID,1,1,'''') = 100 then Income100
		when STUFF(H02.IncomeID,1,1,'''') = 101 then Income101
		when STUFF(H02.IncomeID,1,1,'''') = 102 then Income102
		when STUFF(H02.IncomeID,1,1,'''') = 103 then Income103
		when STUFF(H02.IncomeID,1,1,'''') = 104 then Income104
		when STUFF(H02.IncomeID,1,1,'''') = 105 then Income105
		when STUFF(H02.IncomeID,1,1,'''') = 106 then Income106
		when STUFF(H02.IncomeID,1,1,'''') = 107 then Income107
		when STUFF(H02.IncomeID,1,1,'''') = 108 then Income108
		when STUFF(H02.IncomeID,1,1,'''') = 109 then Income109
		when STUFF(H02.IncomeID,1,1,'''') = 110 then Income110
		when STUFF(H02.IncomeID,1,1,'''') = 111 then Income111
		when STUFF(H02.IncomeID,1,1,'''') = 112 then Income112
		when STUFF(H02.IncomeID,1,1,'''') = 113 then Income113
		when STUFF(H02.IncomeID,1,1,'''') = 114 then Income114
		when STUFF(H02.IncomeID,1,1,'''') = 115 then Income115
		when STUFF(H02.IncomeID,1,1,'''') = 116 then Income116
		when STUFF(H02.IncomeID,1,1,'''') = 117 then Income117
		when STUFF(H02.IncomeID,1,1,'''') = 118 then Income118
		when STUFF(H02.IncomeID,1,1,'''') = 119 then Income119
		when STUFF(H02.IncomeID,1,1,'''') = 120 then Income120
		when STUFF(H02.IncomeID,1,1,'''') = 121 then Income121
		when STUFF(H02.IncomeID,1,1,'''') = 122 then Income122
		when STUFF(H02.IncomeID,1,1,'''') = 123 then Income123
		when STUFF(H02.IncomeID,1,1,'''') = 124 then Income124
		when STUFF(H02.IncomeID,1,1,'''') = 125 then Income125
		when STUFF(H02.IncomeID,1,1,'''') = 126 then Income126
		when STUFF(H02.IncomeID,1,1,'''') = 127 then Income127
		when STUFF(H02.IncomeID,1,1,'''') = 128 then Income128
		when STUFF(H02.IncomeID,1,1,'''') = 129 then Income129
		when STUFF(H02.IncomeID,1,1,'''') = 130 then Income130
		when STUFF(H02.IncomeID,1,1,'''') = 131 then Income131
		when STUFF(H02.IncomeID,1,1,'''') = 132 then Income132
		when STUFF(H02.IncomeID,1,1,'''') = 133 then Income133
		when STUFF(H02.IncomeID,1,1,'''') = 134 then Income134
		when STUFF(H02.IncomeID,1,1,'''') = 135 then Income135
		when STUFF(H02.IncomeID,1,1,'''') = 136 then Income136
		when STUFF(H02.IncomeID,1,1,'''') = 137 then Income137
		when STUFF(H02.IncomeID,1,1,'''') = 138 then Income138
		when STUFF(H02.IncomeID,1,1,'''') = 139 then Income139
		when STUFF(H02.IncomeID,1,1,'''') = 140 then Income140
		when STUFF(H02.IncomeID,1,1,'''') = 141 then Income141
		when STUFF(H02.IncomeID,1,1,'''') = 142 then Income142
		when STUFF(H02.IncomeID,1,1,'''') = 143 then Income143
		when STUFF(H02.IncomeID,1,1,'''') = 144 then Income144
		when STUFF(H02.IncomeID,1,1,'''') = 145 then Income145
		when STUFF(H02.IncomeID,1,1,'''') = 146 then Income146
		when STUFF(H02.IncomeID,1,1,'''') = 147 then Income147
		when STUFF(H02.IncomeID,1,1,'''') = 148 then Income148
		when STUFF(H02.IncomeID,1,1,'''') = 149 then Income149
		when STUFF(H02.IncomeID,1,1,'''') = 150 then Income150
		when STUFF(H02.IncomeID,1,1,'''') = 151 then Income151
		when STUFF(H02.IncomeID,1,1,'''') = 152 then Income152
		when STUFF(H02.IncomeID,1,1,'''') = 153 then Income153
		when STUFF(H02.IncomeID,1,1,'''') = 154 then Income154
		when STUFF(H02.IncomeID,1,1,'''') = 155 then Income155
		when STUFF(H02.IncomeID,1,1,'''') = 156 then Income156
		when STUFF(H02.IncomeID,1,1,'''') = 157 then Income157
		when STUFF(H02.IncomeID,1,1,'''') = 158 then Income158
		when STUFF(H02.IncomeID,1,1,'''') = 159 then Income159
		when STUFF(H02.IncomeID,1,1,'''') = 160 then Income160
		when STUFF(H02.IncomeID,1,1,'''') = 161 then Income161
		when STUFF(H02.IncomeID,1,1,'''') = 162 then Income162
		when STUFF(H02.IncomeID,1,1,'''') = 163 then Income163
		when STUFF(H02.IncomeID,1,1,'''') = 164 then Income164
		when STUFF(H02.IncomeID,1,1,'''') = 165 then Income165
		when STUFF(H02.IncomeID,1,1,'''') = 166 then Income166
		when STUFF(H02.IncomeID,1,1,'''') = 167 then Income167
		when STUFF(H02.IncomeID,1,1,'''') = 168 then Income168
		when STUFF(H02.IncomeID,1,1,'''') = 169 then Income169'
SET @sSelect3 = '
		when STUFF(H02.IncomeID,1,1,'''') = 170 then Income170
		when STUFF(H02.IncomeID,1,1,'''') = 171 then Income171
		when STUFF(H02.IncomeID,1,1,'''') = 172 then Income172
		when STUFF(H02.IncomeID,1,1,'''') = 173 then Income173
		when STUFF(H02.IncomeID,1,1,'''') = 174 then Income174
		when STUFF(H02.IncomeID,1,1,'''') = 175 then Income175
		when STUFF(H02.IncomeID,1,1,'''') = 176 then Income176
		when STUFF(H02.IncomeID,1,1,'''') = 177 then Income177
		when STUFF(H02.IncomeID,1,1,'''') = 178 then Income178
		when STUFF(H02.IncomeID,1,1,'''') = 179 then Income179
		when STUFF(H02.IncomeID,1,1,'''') = 180 then Income180
		when STUFF(H02.IncomeID,1,1,'''') = 181 then Income181
		when STUFF(H02.IncomeID,1,1,'''') = 182 then Income182
		when STUFF(H02.IncomeID,1,1,'''') = 183 then Income183
		when STUFF(H02.IncomeID,1,1,'''') = 184 then Income184
		when STUFF(H02.IncomeID,1,1,'''') = 185 then Income185
		when STUFF(H02.IncomeID,1,1,'''') = 186 then Income186
		when STUFF(H02.IncomeID,1,1,'''') = 187 then Income187
		when STUFF(H02.IncomeID,1,1,'''') = 188 then Income188
		when STUFF(H02.IncomeID,1,1,'''') = 189 then Income189
		when STUFF(H02.IncomeID,1,1,'''') = 190 then Income190
		when STUFF(H02.IncomeID,1,1,'''') = 191 then Income191
		when STUFF(H02.IncomeID,1,1,'''') = 192 then Income192
		when STUFF(H02.IncomeID,1,1,'''') = 193 then Income193
		when STUFF(H02.IncomeID,1,1,'''') = 194 then Income194
		when STUFF(H02.IncomeID,1,1,'''') = 195 then Income195
		when STUFF(H02.IncomeID,1,1,'''') = 196 then Income196
		when STUFF(H02.IncomeID,1,1,'''') = 197 then Income197
		when STUFF(H02.IncomeID,1,1,'''') = 198 then Income198
		when STUFF(H02.IncomeID,1,1,'''') = 199 then Income199
		when STUFF(H02.IncomeID,1,1,'''') = 200 then Income200
	else 0 end, 0) as IncomeAmount , 0 as SubAmount
	from HT3400 H01 inner join HT5005 H02 on H01.PayrollMethodID = H02.PayrollMethodID
			inner join HT0002 H03 on H02.IncomeID = H03.IncomeID
			inner join HT2400 H04 on H01.DivisionID = H04.DivisionID and H01.DepartmentID = H04.DepartmentID and
			H01.EmployeeID = H04.EmployeeID and H01.TranMonth = H04.TranMonth and H01.TranYear = H04.TranYear
			LEFT JOIN HT3499 H05 WITH (NOLOCK) ON H01.DivisionID = H05.DivisionID AND H01.TransactionID = H05.TransactionID
	where H01.DivisionID = '''+@DivisionID+''' and H01.TranMonth = ' + cast(@TranMonth as nvarchar(10)) + ' and 
			H01.TranYear = ' +cast(@TranYear as nvarchar(10)) + ' and H03.IsTax = 1
union ' 

---------Cac khoan giam tru co tinh vao thue thu nhap
set @sSQL1 = '
	select H01.DivisionID, H01.EmployeeID, H04.TaxObjectID,0 as IncomeAmount,
	isnull(case when STUFF(H02.SubID,1,1,'''') = 01 then SubAmount01
		when STUFF(H02.SubID,1,1,'''') = 02 then SubAmount02 
		when STUFF(H02.SubID,1,1,'''') = 03 then SubAmount03 
		when STUFF(H02.SubID,1,1,'''') = 04 then SubAmount04 
		when STUFF(H02.SubID,1,1,'''') = 05 then SubAmount05 
		when STUFF(H02.SubID,1,1,'''') = 06 then SubAmount06 
		when STUFF(H02.SubID,1,1,'''') = 07 then SubAmount07
		when STUFF(H02.SubID,1,1,'''') = 08 then SubAmount08
		when STUFF(H02.SubID,1,1,'''') = 09 then SubAmount09
		when STUFF(H02.SubID,1,1,'''') = 10 then SubAmount10 
		when STUFF(H02.SubID,1,1,'''') = 11 then SubAmount11
		when STUFF(H02.SubID,1,1,'''') = 12 then SubAmount12 
		when STUFF(H02.SubID,1,1,'''') = 13 then SubAmount13 
		when STUFF(H02.SubID,1,1,'''') = 14 then SubAmount14 
		when STUFF(H02.SubID,1,1,'''') = 15 then SubAmount15 
		when STUFF(H02.SubID,1,1,'''') = 16 then SubAmount16 
		when STUFF(H02.SubID,1,1,'''') = 17 then SubAmount17
		when STUFF(H02.SubID,1,1,'''') = 18 then SubAmount18
		when STUFF(H02.SubID,1,1,'''') = 19 then SubAmount19
		when STUFF(H02.SubID,1,1,'''') = 20 then SubAmount20
		when STUFF(H02.SubID,1,1,'''') = 21 then SubAmount21
		when STUFF(H02.SubID,1,1,'''') = 22 then SubAmount22
		when STUFF(H02.SubID,1,1,'''') = 23 then SubAmount23
		when STUFF(H02.SubID,1,1,'''') = 24 then SubAmount24
		when STUFF(H02.SubID,1,1,'''') = 25 then SubAmount25
		when STUFF(H02.SubID,1,1,'''') = 26 then SubAmount26
		when STUFF(H02.SubID,1,1,'''') = 27 then SubAmount27
		when STUFF(H02.SubID,1,1,'''') = 28 then SubAmount28
		when STUFF(H02.SubID,1,1,'''') = 29 then SubAmount29
		when STUFF(H02.SubID,1,1,'''') = 30 then SubAmount30
		when STUFF(H02.SubID,1,1,'''') = 31 then SubAmount31
		when STUFF(H02.SubID,1,1,'''') = 32 then SubAmount32
		when STUFF(H02.SubID,1,1,'''') = 33 then SubAmount33
		when STUFF(H02.SubID,1,1,'''') = 34 then SubAmount34
		when STUFF(H02.SubID,1,1,'''') = 35 then SubAmount35
		when STUFF(H02.SubID,1,1,'''') = 36 then SubAmount36
		when STUFF(H02.SubID,1,1,'''') = 37 then SubAmount37
		when STUFF(H02.SubID,1,1,'''') = 38 then SubAmount38
		when STUFF(H02.SubID,1,1,'''') = 39 then SubAmount39
		when STUFF(H02.SubID,1,1,'''') = 40 then SubAmount40'
SET @sSQL2 = '
		when STUFF(H02.SubID,1,1,'''') = 41 then SubAmount41
		when STUFF(H02.SubID,1,1,'''') = 42 then SubAmount42
		when STUFF(H02.SubID,1,1,'''') = 43 then SubAmount43
		when STUFF(H02.SubID,1,1,'''') = 44 then SubAmount44
		when STUFF(H02.SubID,1,1,'''') = 45 then SubAmount45
		when STUFF(H02.SubID,1,1,'''') = 46 then SubAmount46
		when STUFF(H02.SubID,1,1,'''') = 47 then SubAmount47
		when STUFF(H02.SubID,1,1,'''') = 48 then SubAmount48
		when STUFF(H02.SubID,1,1,'''') = 49 then SubAmount49
		when STUFF(H02.SubID,1,1,'''') = 50 then SubAmount50
		when STUFF(H02.SubID,1,1,'''') = 51 then SubAmount51
		when STUFF(H02.SubID,1,1,'''') = 52 then SubAmount52
		when STUFF(H02.SubID,1,1,'''') = 53 then SubAmount53
		when STUFF(H02.SubID,1,1,'''') = 54 then SubAmount54
		when STUFF(H02.SubID,1,1,'''') = 55 then SubAmount55
		when STUFF(H02.SubID,1,1,'''') = 56 then SubAmount56
		when STUFF(H02.SubID,1,1,'''') = 57 then SubAmount57
		when STUFF(H02.SubID,1,1,'''') = 58 then SubAmount58
		when STUFF(H02.SubID,1,1,'''') = 59 then SubAmount59
		when STUFF(H02.SubID,1,1,'''') = 60 then SubAmount60
		when STUFF(H02.SubID,1,1,'''') = 61 then SubAmount61
		when STUFF(H02.SubID,1,1,'''') = 62 then SubAmount62
		when STUFF(H02.SubID,1,1,'''') = 63 then SubAmount63
		when STUFF(H02.SubID,1,1,'''') = 64 then SubAmount64
		when STUFF(H02.SubID,1,1,'''') = 65 then SubAmount65
		when STUFF(H02.SubID,1,1,'''') = 66 then SubAmount66
		when STUFF(H02.SubID,1,1,'''') = 67 then SubAmount67
		when STUFF(H02.SubID,1,1,'''') = 68 then SubAmount68
		when STUFF(H02.SubID,1,1,'''') = 69 then SubAmount69
		when STUFF(H02.SubID,1,1,'''') = 70 then SubAmount70
		when STUFF(H02.SubID,1,1,'''') = 71 then SubAmount71
		when STUFF(H02.SubID,1,1,'''') = 72 then SubAmount72
		when STUFF(H02.SubID,1,1,'''') = 73 then SubAmount73
		when STUFF(H02.SubID,1,1,'''') = 74 then SubAmount74
		when STUFF(H02.SubID,1,1,'''') = 75 then SubAmount75
		when STUFF(H02.SubID,1,1,'''') = 76 then SubAmount76
		when STUFF(H02.SubID,1,1,'''') = 77 then SubAmount77
		when STUFF(H02.SubID,1,1,'''') = 78 then SubAmount78
		when STUFF(H02.SubID,1,1,'''') = 79 then SubAmount79
		when STUFF(H02.SubID,1,1,'''') = 80 then SubAmount80
		when STUFF(H02.SubID,1,1,'''') = 81 then SubAmount81
		when STUFF(H02.SubID,1,1,'''') = 82 then SubAmount82
		when STUFF(H02.SubID,1,1,'''') = 83 then SubAmount83
		when STUFF(H02.SubID,1,1,'''') = 84 then SubAmount84
		when STUFF(H02.SubID,1,1,'''') = 85 then SubAmount85
		when STUFF(H02.SubID,1,1,'''') = 86 then SubAmount86
		when STUFF(H02.SubID,1,1,'''') = 87 then SubAmount87
		when STUFF(H02.SubID,1,1,'''') = 88 then SubAmount88
		when STUFF(H02.SubID,1,1,'''') = 89 then SubAmount89
		when STUFF(H02.SubID,1,1,'''') = 90 then SubAmount90
		when STUFF(H02.SubID,1,1,'''') = 91 then SubAmount91
		when STUFF(H02.SubID,1,1,'''') = 92 then SubAmount92
		when STUFF(H02.SubID,1,1,'''') = 93 then SubAmount93
		when STUFF(H02.SubID,1,1,'''') = 94 then SubAmount94
		when STUFF(H02.SubID,1,1,'''') = 95 then SubAmount95
		when STUFF(H02.SubID,1,1,'''') = 96 then SubAmount96
		when STUFF(H02.SubID,1,1,'''') = 97 then SubAmount97
		when STUFF(H02.SubID,1,1,'''') = 98 then SubAmount98
		when STUFF(H02.SubID,1,1,'''') = 99 then SubAmount99
		when STUFF(H02.SubID,1,1,'''') = 100 then SubAmount100
		'
SET @sSQL3 =
 ' else 0  end, 0) as SubAmount 
		from HT3400 H01 inner join HT5006 H02 on H01.PayrollMethodID = H02.PayrollMethodID
				inner join HT0005 H03 on H02.SubID = H03.SubID
				inner join HT2400 H04 on H01.DivisionID = H04.DivisionID and H01.DepartmentID = H04.DepartmentID and
				H01.EmployeeID = H04.EmployeeID and H01.TranMonth = H04.TranMonth and H01.TranYear = H04.TranYear
		where H01.DivisionID = '''+@DivisionID+''' and H01.TranMonth = ' + cast(@TranMonth as nvarchar(10)) + ' and 
				H01.TranYear = ' +cast(@TranYear as nvarchar(10)) + ' and H03.IsTax = 1'

if exists (select top 1 1 from sysObjects where Name = 'HV2700' and Type ='V')
	drop view HV2700
 Exec('Create View HV2700 as ' + @sSQL+@sSelect1+@sSelect2+@sSelect3+@sSQL1+@sSQL2+@sSQL3)

--PRINT @sSQL
--PRINT @sSelect1
--PRINT @sSelect2
--PRINT @sSelect3
--PRINT @sSQL1
-----------Tinh tong thu nhap de in bao cao
select @ST = sum(InComeAmount - SubAmount) from HV2700
select @ST0 =  sum(InComeAmount - SubAmount) from HV2700 where TaxObjectID like '%VN%'
select @ST1 = sum(IncomeAmount - SubAmount) from HV2700 where TaxObjectID like '%FOR%'


if exists (select top 1 1 from HT2704  where HT2704.DivisionID = @DivisionID and HT2704.ReportCode = @ReportCode )
	delete HT2704
set @Cur_HT2704 = cursor scroll keyset for
	select H02.LineID, H02.LineDescription, H02.Code,H02.Code0, H02.Rate, H02.Step,
		H02.IsBold,H02.IsItalic,H02.IsGray, H02.IsNotPrint,H02.Method,  H02.DataType, H02.EmployeeType, H03.Amount as Amount1
	from HT2702 H02 left join HT2703 H03 on H02.ReportCode = H03.ReportCode and H02.LineID = H03.LineID and H03.DivisionID = @DivisionID and H02.Method = 2
	where H02.ReportCode = @ReportCode
Open @Cur_HT2704

FETCH NEXT from @Cur_HT2704 into @LineID, @LineDescription, @Code, @Code0, @Rate, @Step, @IsBold, @IsItalic, @IsGray, @IsNotPrint, @Method, @DataType, @EmployeeType, @Amount
While @@FETCH_STATUS = 0
begin


---------Gan du lieu cho @Amount
if @Method <> 2 
begin
	
	if @DataType = 'LA'
	begin
		if @EmployeeType = 9 set @Amount = @LA
		if @EmployeeType = 0 set @Amount = @LA0
		if @EmployeeType = 1 set @Amount = @LA1
	
	end
	if @DataType = 'LT'
	begin
		if @EmployeeType = 9 set @Amount = @LT
		if @EmployeeType = 0 set @Amount = @LT0
		if @EmployeeType = 1 set @Amount = @LT1

	end
	if @DataType = 'ST'
	begin
		if @EmployeeType = 9 set @Amount = @ST
		if @EmployeeType = 0 set @Amount = @ST0
		if @EmployeeType = 1 set @Amount = @ST1

	end
	if @DataType = 'TA'
	begin
		if @EmployeeType = 9 set @Amount = @TA
		if @EmployeeType = 0 set @Amount = @TA0
		if @EmployeeType = 1 set @Amount = @TA1
	end
	if @DataType = 'OT'
	begin
		
		if @EmployeeType = 9 set @Amount = @TA * @OT		if @EmployeeType = 0 set @Amount = @TA0* @OT
		if @EmployeeType = 1 set @Amount = @TA1*@OT
		if isnull(@EmployeeType,2) = 2  
		begin
			set @Amount = @TA* isnull(@Rate,1)/100
			set @OT = 1-isnull(@Rate,1)/100
			
		end
	
	end
	
end
	
else
	set @Amount = @Amount
	

insert HT2704(DivisionID, TranMonth, TranYear, ReportCode, LineID, LineDescription, Code, Code0, Rate, Step, IsBold, IsItalic, IsGray, IsNotPrint, DataType, EmployeeType, Amount)
	VALUES (@DivisionID,@TranMonth, @TranYear, @ReportCode, @LineID, @LineDescription, @Code, @Code0, @Rate, @Step, @IsBold, @IsItalic,
			@IsGray, @IsNotPrint, @DataType, @EmployeeType, @Amount)


FETCH NEXT from @Cur_HT2704 into @LineID, @LineDescription, @Code, @Code0, @Rate, @Step, @IsBold, @IsItalic, @IsGray, @IsNotPrint, @Method, @DataType, @EmployeeType, @Amount
end




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
