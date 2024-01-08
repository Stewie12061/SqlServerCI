IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP2705]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP2705]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


--------Quyet toan thue thu nhap ca nhan
--------Created by Le Hoai Minh
--------Date : 03/11/2005
------ Modified by Bảo Thy on 17/01/2017: BỔ sung I151 -> I200 (MEIKO)

/********************************************
'* Edited by: [GS] [Ngọc Nhựt] [29/07/2010]


EXEC HP2705  @TranYear=2016, @FromMonth=12, @ToMonth=12, @DivisionID='MK', @DepartmentID='E000000', @TeamID='%',@EmployeeID='007685', @IsYear=0
'********************************************/

CREATE PROCEDURE [dbo].[HP2705]  @TranYear int,
				@FromMonth int,
				@ToMonth int,
				@DivisionID NVARCHAR(50),
				@DepartmentID NVARCHAR(50),
				@TeamID NVARCHAR(50),
				@EmployeeID NVARCHAR(50),
				@IsYear tinyint		------1 : Quyet toan cuoi nam ,  0 : Quy?t toán theo k?

AS
DECLARE  @FMonth as int,
		@TMonth as int,
		@sSQL as nvarchar(4000),
		@sSQL1 as nvarchar(4000),		
		@sSQL2 as nvarchar(4000),
		@sSQL3 as nvarchar(4000),
		@Employ as NVARCHAR(50),
		@NoMonth  as int,--------------So thang quyet toan thue
		@IsPercentSurtax as tinyint,
		@IsProgressive as tinyint,
		@Cur_Tax as cursor,
		@PaidTax as decimal (28, 8),
		@NetAmount as decimal (18,8),
		@SumTax as decimal (28, 8),
		@UnpaidTax as decimal (28, 8),
		@DeductTax as decimal (28, 8),
		@TaxObjectID as NVARCHAR(50),
		@Cur_TaxObjectID as cursor,
		@CustomerIndex INT,
		@sSelect1 nvarchar(MAX)='', 
		@sSelect2 nvarchar(MAX)='', 
		@sSelect3 nvarchar(MAX)='' 

SELECT @CustomerIndex = CustomerName From CustomerIndex

If @IsYear = 1
begin
	set @FMonth = 1
	set @TMonth = 12
end
else
begin
	set @FMonth = @FromMonth
	set @TMonth = @ToMonth
end
set @NoMonth = (@TMonth - @FMonth) + 1
if  exists (select top 1 1 from HT3400 where DivisionID = @DivisionID and DepartmentID like @DepartmentID and Isnull(TeamID,0) like @TeamID
		and EmployeeID like @EmployeeID and TranMonth in (@FMonth, @TMonth) )
Begin

-----------------Tinh tat ca cac khoan thu nhap, giam tru cua tat ca nhan vien tu FMonth den TMonth
set @sSQL = 'select H01.DivisionID, H01.DepartmentID, H01.TeamID, H01.EmployeeID, H04.TaxObjectID,
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
	from HT3400 H01 inner join HT5005 H02 on H01.PayrollMethodID = H02.PayrollMethodID And H01.DivisionID = H02.DivisionID
			inner join HT0002 H03 on H02.IncomeID = H03.IncomeID And H02.DivisionID = H03.DivisionID
			inner join HT2400 H04 on H01.DivisionID = H04.DivisionID and H01.DepartmentID = H04.DepartmentID and
			H01.EmployeeID = H04.EmployeeID and H01.TranMonth = H04.TranMonth and H01.TranYear = H04.TranYear
			LEFT JOIN HT3499 H05 ON H01.DivisionID = H05.DivisionID AND H01.TransactionID = H05.TransactionID
	where H01.DivisionID = '''+@DivisionID+''' and H01.TranMonth in ( ' + cast(@FMonth as nvarchar(10)) + ',' + cast(@TMonth as nvarchar(10)) + ') and
			H01.TranYear = ' +cast(@TranYear as nvarchar(10)) + ' and H03.IsTax = 1 and H01.EmployeeID like '''+@EmployeeID+'''
			and H01.DepartmentID like '''+@DepartmentID+''' and Isnull(H01.TeamID,'''') like '''+@TeamID+'''
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
		from HT3400 H01 inner join HT5006 H02 on H01.PayrollMethodID = H02.PayrollMethodID And H01.DivisionID = H02.DivisionID
				inner join HT0005 H03 on H02.SubID = H03.SubID And H02.DivisionID = H03.DivisionID
				inner join HT2400 H04 on H01.DivisionID = H04.DivisionID and H01.DepartmentID = H04.DepartmentID and
				H01.EmployeeID = H04.EmployeeID and H01.TranMonth = H04.TranMonth and H01.TranYear = H04.TranYear
		where H01.DivisionID = '''+@DivisionID+''' and H01.TranMonth in ( ' + cast(@FMonth as nvarchar(10)) + ',' + cast(@TMonth as nvarchar(10)) + ') and 
				H01.TranYear = ' +cast(@TranYear as nvarchar(10)) + ' and H03.IsTax = 1 and H01.EmployeeID like '''+@EmployeeID+'''
				and H01.DepartmentID like '''+@DepartmentID+''' and Isnull(H01.TeamID,'''') like '''+@TeamID+''''

--PRINT @sSQL
--PRINT @sSelect1
--PRINT @sSelect2
--PRINT @sSelect3
--PRINT @sSQL1
--PRINT @sSQL2
--PRINT @sSQL3

If exists(Select Top 1 1 From sysObjects Where Name = 'HV2707' and Type = 'V')
	Drop view HV2707

EXEC('Create view HV2707 ---tao boi HP2705
		as ' + @sSQL+@sSelect1+@sSelect2+@sSelect3+@sSQL1+@sSQL2+@sSQL3)

set @sSQL = 'select  DivisionID, DepartmentID, TeamID,EmployeeID, TaxObjectID, sum(Isnull(InComeAmount,0) - Isnull(SubAmount,0)) as NetAmount, sum(Isnull(InComeAmount,0) - Isnull(SubAmount,0))/ '+cast(@NoMonth as NVARCHAR(50))+' as PerMonth
	from HV2707 where DivisionID = ''' + @DivisionID + ''' group by DivisionID, DepartmentID, TeamID,EmployeeID,TaxObjectID'
---------- --------(sum(InComeAmount - SubAmount)/ @NoMonth)

If exists(Select Top 1 1 From sysObjects Where Name = 'HV2708' and Type = 'V')
	Drop view HV2708
EXEC('Create view HV2708 ---tao boi HP2705
		as ' + @sSQL)

set @Cur_TaxObjectID = Cursor Scroll Keyset for
		select Distinct TaxObjectID from HV2708 

Open @Cur_TaxObjectID
Fetch next from @Cur_TaxObjectID into @TaxObjectID
While @@FETCH_STATUS = 0 
BEGIN
--Tinh thue 
Select @IsProgressive = IsProgressive, @IsPercentSurtax = IsPercentSurtax From HT1011 Where TaxObjectID = @TaxObjectID 

IF @IsProgressive = 1  ---luy tien
Set @sSQL='Select DivisionID, DepartmentID, TeamID, EmployeeID,H00.TaxObjectID, NetAmount, PerMonth,
		isnull(sum(case when ( PerMonth > MinSalary and ( PerMonth <= MaxSalary or MaxSalary = -1))
		then  PerMonth - MinSalary
		else case when  PerMonth <= MinSalary then 0 else
		MaxSalary - MinSalary end end* isnull(RateOrAmount,0)/100), 0) as TaxAmount
		
	From HV2708 H00 inner join HT1012 H01 on H01.TaxObjectID = ''' + @TaxObjectID + ''' and H00.DivisionID = H01.DivisionID 
	Group by DivisionID, DepartmentID, TeamID, EmployeeID, H00.TaxObjectID, NetAmount,PerMonth'

Else  ---nac thang
Set @sSQL ='	Select DivisionID, DepartmentID, TeamID, EmployeeID, H00.TaxObjectID, NetAmount, PerMonth,
		isnull(sum(case when ( PerMonth > MinSalary and ( PerMonth <= MaxSalary or MaxSalary = -1))
		then  PerMonth else 0 end* isnull(RateOrAmount,0)/100), 0) as TaxAmount
		
	From HV2708 H00 inner join HT1012 H01 on H01.TaxObjectID = ''' + @TaxObjectID + ''' and H00.DivisionID = H01.DivisionID 
	Group by DivisionID, DepartmentID, TeamID,  EmployeeID,  PerMonth ,H00.TaxObjectID, NetAmount'
print ('HV2709'+ @sSQL)
Fetch next from @Cur_TaxObjectID into @TaxObjectID
END

if exists(Select Top 1 1 from sysObjects where Name = 'HV2709' and Type = 'V' )
	Drop view HV2709
EXEC('Create view HV2709----------Tao boi HP2705
		as ' + @sSQL)

if exists (select top 1 1 from HT2705)
	delete HT2705
set @Cur_Tax = Cursor Scroll KeySet for
	select EmployeeID, TaxObjectID,NetAmount, (TaxAmount*@NoMonth) as SumTax
	from  HV2709

Open @Cur_Tax
FETCH NEXT from @Cur_Tax into @Employ, @TaxObjectID, @NetAmount,@SumTax
WHILE @@FETCH_STATUS = 0 
BEGIN
-------So thue da nop
SELECT @PaidTax = Sum(Isnull(TaxAmount, 0))
FROM   HT3400
WHERE  DivisionID = @DivisionID
       AND DepartmentID LIKE @DepartmentID
       AND Isnull(TeamID, '') LIKE @TeamID
       AND EmployeeID = @Employ
       AND TranMonth IN ( @FMonth, @TMonth )

SET @UnpaidTax = @SumTax - @PaidTax 



INSERT INTO HT2705
            (DivisionID,
            EmployeeID,
             PaidTax,
             NetAmount,
             SumTax,
             UnPaidTax,
             TaxObjectID)
VALUES      ( @DivisionID,
			  @Employ,
              @PaidTax,
              @NetAmount,
              @SumTax,
              @UnPaidTax,
              @TaxObjectID) 

Fetch next from @Cur_Tax into @Employ, @TaxObjectID, @NetAmount, @SumTax
END
END 
----else
----print 'a'

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
