IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP5007]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[HP5007]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


---Created by:Pham Thi Phuong Loan, date: 01/09/2005
---purpose: Tinh thue thu nhap cho giao vien, ap dung cho SITC ( Tinh tong thu nhap cua GV o tat ca cac chi nhanh,
-- tinh thue thu nhap dua tren muc tong thu nhap do sau do phan bo thue ra cac chi nhanh theo ty le thu nhap cua chi nhanh)
--Cach tinh chua dong bo , se xem xet lai sau
/********************************************
'* Edited by: [GS] [Minh L�m] [02/08/2010]
'********************************************/
---- Modified by Phương Thảo on 05/12/2016: Bổ sung lưu S21->S100 (MEIKO)
---- Modified by Bảo Thy on 17/01/2017: BỔ sung I151 -> I200 (MEIKO)

CREATE PROCEDURE [dbo].[HP5007]
       @DivisionID AS nvarchar(50) ,
       @TranMonth AS int ,
       @TranYear AS int ,
       @PayrollMethodID AS nvarchar(50) ,
       @DepartmentID1 AS nvarchar(50) ,
       @TeamID1 AS nvarchar(50)
AS
DECLARE
        @sSQL nvarchar(4000) ,
        @sSQL1 AS nvarchar(4000) ,
		@sSQL11 AS nvarchar(4000) ,
		@sSQL12 AS nvarchar(4000) ,
        @sSQL2 AS nvarchar(4000) ,
        @IsProgressive tinyint ,
        @IsPercentSurtax AS tinyint ,
        @TaxObjectID nvarchar(50) ,
        @cur AS cursor ,
        @RateExchange AS decimal(28,8) ,
        @Currency AS nvarchar(50),		@CustomerIndex INT,		@sSQLSelect NVARCHAR(MAX) = '',		@sSQLSelect1 NVARCHAR(MAX) = '',		@sSQLSelect2 NVARCHAR(MAX) = '',		@sSQLSelect3 NVARCHAR(MAX) = '',		@sSQLSelect4 NVARCHAR(MAX) = ''SELECT @CustomerIndex = CustomerName From CustomerIndex
----BUOC 1 Tinh tong thu nhap chiu thue cua GV + thu nhap cua GV theo tung to nhom

--Select @Currency=CurrencyID From HT5000 Where PayrollMethodID=@PayrollMethodID
--If @Currency='VND'
SET @RateExchange = 1
--else
	--Select @RateExchange=RateExchange From HT0000 Where DivisionID=@DivisionID

SET @cur = CURSOR SCROLL KEYSET FOR 
			SELECT	DISTINCT TaxObjectID
            FROM	HT2400
            WHERE	TranMonth = @TranMonth AND TranYear = @TranYear AND DivisionID = @DivisionID 
					AND DepartmentID LIKE @DepartmentID1 AND isnull(TeamID , '') <> isnull(@TeamID1 , '') AND isnull(TaxObjectID , '') <> ''
                    AND DivisionID = @DivisionID
OPEN @cur
FETCH next FROM @cur INTO @TaxObjectID
WHILE @@Fetch_Status = 0
BEGIN
---Tinh tong thu nhap chiu thue roi insert vao bang tam HT5889 va HV5504
	
	SET @sSQLSelect = 'Select H00.DivisionID,  H00.DepartmentID, H00.EmployeeID, H00.PayrollMethodID, H02.IsTax,
		SUM(isnull(case when STUFF(H01.IncomeID,1,1,'''') = 01 then Income01
		when STUFF(H01.IncomeID,1,1,'''') = 02 then Income02 
		when STUFF(H01.IncomeID,1,1,'''') = 03 then Income03 
		when STUFF(H01.IncomeID,1,1,'''') = 04 then Income04 
		when STUFF(H01.IncomeID,1,1,'''') = 05 then Income05 
		when STUFF(H01.IncomeID,1,1,'''') = 06 then Income06 
		when STUFF(H01.IncomeID,1,1,'''') = 07 then Income07
		when STUFF(H01.IncomeID,1,1,'''') = 08 then Income08
		when STUFF(H01.IncomeID,1,1,'''') = 09 then Income09
		when STUFF(H01.IncomeID,1,1,'''') = 10 then Income10 
		when STUFF(H01.IncomeID,1,1,'''') = 11 then Income11
		when STUFF(H01.IncomeID,1,1,'''') = 12 then Income12 
		when STUFF(H01.IncomeID,1,1,'''') = 13 then Income13 
		when STUFF(H01.IncomeID,1,1,'''') = 14 then Income14 
		when STUFF(H01.IncomeID,1,1,'''') = 15 then Income15 
		when STUFF(H01.IncomeID,1,1,'''') = 16 then Income16 
		when STUFF(H01.IncomeID,1,1,'''') = 17 then Income17
		when STUFF(H01.IncomeID,1,1,'''') = 18 then Income18
		when STUFF(H01.IncomeID,1,1,'''') = 19 then Income19
		when STUFF(H01.IncomeID,1,1,'''') = 20 then Income20
		when STUFF(H01.IncomeID,1,1,'''') = 21 then Income21
		when STUFF(H01.IncomeID,1,1,'''') = 22 then Income22
		when STUFF(H01.IncomeID,1,1,'''') = 23 then Income23
		when STUFF(H01.IncomeID,1,1,'''') = 24 then Income24
		when STUFF(H01.IncomeID,1,1,'''') = 25 then Income25
		when STUFF(H01.IncomeID,1,1,'''') = 26 then Income26
		when STUFF(H01.IncomeID,1,1,'''') = 27 then Income27
		when STUFF(H01.IncomeID,1,1,'''') = 28 then Income28
		when STUFF(H01.IncomeID,1,1,'''') = 29 then Income29
		when STUFF(H01.IncomeID,1,1,'''') = 30 then Income30
		when STUFF(H01.IncomeID,1,1,'''') = 31 then Income31
		when STUFF(H01.IncomeID,1,1,'''') = 32 then Income32
		when STUFF(H01.IncomeID,1,1,'''') = 33 then Income33
		when STUFF(H01.IncomeID,1,1,'''') = 34 then Income34
		when STUFF(H01.IncomeID,1,1,'''') = 35 then Income35'
	SET @sSQLSelect1 = '
		when STUFF(H01.IncomeID,1,1,'''') = 36 then Income36
		when STUFF(H01.IncomeID,1,1,'''') = 37 then Income37
		when STUFF(H01.IncomeID,1,1,'''') = 38 then Income38
		when STUFF(H01.IncomeID,1,1,'''') = 39 then Income39
		when STUFF(H01.IncomeID,1,1,'''') = 40 then Income40
		when STUFF(H01.IncomeID,1,1,'''') = 41 then Income41
		when STUFF(H01.IncomeID,1,1,'''') = 42 then Income42
		when STUFF(H01.IncomeID,1,1,'''') = 43 then Income43
		when STUFF(H01.IncomeID,1,1,'''') = 44 then Income44
		when STUFF(H01.IncomeID,1,1,'''') = 45 then Income45
		when STUFF(H01.IncomeID,1,1,'''') = 46 then Income46
		when STUFF(H01.IncomeID,1,1,'''') = 47 then Income47
		when STUFF(H01.IncomeID,1,1,'''') = 48 then Income48
		when STUFF(H01.IncomeID,1,1,'''') = 49 then Income49
		when STUFF(H01.IncomeID,1,1,'''') = 50 then Income50
		when STUFF(H01.IncomeID,1,1,'''') = 51 then Income51
		when STUFF(H01.IncomeID,1,1,'''') = 52 then Income52
		when STUFF(H01.IncomeID,1,1,'''') = 53 then Income53
		when STUFF(H01.IncomeID,1,1,'''') = 54 then Income54
		when STUFF(H01.IncomeID,1,1,'''') = 55 then Income55
		when STUFF(H01.IncomeID,1,1,'''') = 56 then Income56
		when STUFF(H01.IncomeID,1,1,'''') = 57 then Income57
		when STUFF(H01.IncomeID,1,1,'''') = 58 then Income58
		when STUFF(H01.IncomeID,1,1,'''') = 59 then Income59
		when STUFF(H01.IncomeID,1,1,'''') = 60 then Income60
		when STUFF(H01.IncomeID,1,1,'''') = 61 then Income61
		when STUFF(H01.IncomeID,1,1,'''') = 62 then Income62
		when STUFF(H01.IncomeID,1,1,'''') = 63 then Income63
		when STUFF(H01.IncomeID,1,1,'''') = 64 then Income64
		when STUFF(H01.IncomeID,1,1,'''') = 65 then Income65
		when STUFF(H01.IncomeID,1,1,'''') = 66 then Income66
		when STUFF(H01.IncomeID,1,1,'''') = 67 then Income67
		when STUFF(H01.IncomeID,1,1,'''') = 68 then Income68
		when STUFF(H01.IncomeID,1,1,'''') = 69 then Income69
		when STUFF(H01.IncomeID,1,1,'''') = 70 then Income70
		when STUFF(H01.IncomeID,1,1,'''') = 71 then Income71
		when STUFF(H01.IncomeID,1,1,'''') = 72 then Income72
		when STUFF(H01.IncomeID,1,1,'''') = 73 then Income73
		when STUFF(H01.IncomeID,1,1,'''') = 74 then Income74
		when STUFF(H01.IncomeID,1,1,'''') = 75 then Income75
		when STUFF(H01.IncomeID,1,1,'''') = 76 then Income76
		when STUFF(H01.IncomeID,1,1,'''') = 77 then Income77
		when STUFF(H01.IncomeID,1,1,'''') = 78 then Income78
		when STUFF(H01.IncomeID,1,1,'''') = 79 then Income79
		when STUFF(H01.IncomeID,1,1,'''') = 80 then Income80
		when STUFF(H01.IncomeID,1,1,'''') = 81 then Income81
		when STUFF(H01.IncomeID,1,1,'''') = 82 then Income82
		when STUFF(H01.IncomeID,1,1,'''') = 83 then Income83
		when STUFF(H01.IncomeID,1,1,'''') = 84 then Income84
		when STUFF(H01.IncomeID,1,1,'''') = 85 then Income85'
	SET @sSQLSelect2 = '
		when STUFF(H01.IncomeID,1,1,'''') = 86 then Income86
		when STUFF(H01.IncomeID,1,1,'''') = 87 then Income87
		when STUFF(H01.IncomeID,1,1,'''') = 88 then Income88
		when STUFF(H01.IncomeID,1,1,'''') = 89 then Income89
		when STUFF(H01.IncomeID,1,1,'''') = 90 then Income90
		when STUFF(H01.IncomeID,1,1,'''') = 91 then Income91
		when STUFF(H01.IncomeID,1,1,'''') = 92 then Income92
		when STUFF(H01.IncomeID,1,1,'''') = 93 then Income93
		when STUFF(H01.IncomeID,1,1,'''') = 94 then Income94
		when STUFF(H01.IncomeID,1,1,'''') = 95 then Income95
		when STUFF(H01.IncomeID,1,1,'''') = 96 then Income96
		when STUFF(H01.IncomeID,1,1,'''') = 97 then Income97
		when STUFF(H01.IncomeID,1,1,'''') = 98 then Income98
		when STUFF(H01.IncomeID,1,1,'''') = 99 then Income99
		when STUFF(H01.IncomeID,1,1,'''') = 100 then Income100
		when STUFF(H01.IncomeID,1,1,'''') = 101 then Income101
		when STUFF(H01.IncomeID,1,1,'''') = 102 then Income102
		when STUFF(H01.IncomeID,1,1,'''') = 103 then Income103
		when STUFF(H01.IncomeID,1,1,'''') = 104 then Income104
		when STUFF(H01.IncomeID,1,1,'''') = 105 then Income105
		when STUFF(H01.IncomeID,1,1,'''') = 106 then Income106
		when STUFF(H01.IncomeID,1,1,'''') = 107 then Income107
		when STUFF(H01.IncomeID,1,1,'''') = 108 then Income108
		when STUFF(H01.IncomeID,1,1,'''') = 109 then Income109
		when STUFF(H01.IncomeID,1,1,'''') = 110 then Income110
		when STUFF(H01.IncomeID,1,1,'''') = 111 then Income111
		when STUFF(H01.IncomeID,1,1,'''') = 112 then Income112
		when STUFF(H01.IncomeID,1,1,'''') = 113 then Income113
		when STUFF(H01.IncomeID,1,1,'''') = 114 then Income114
		when STUFF(H01.IncomeID,1,1,'''') = 115 then Income115
		when STUFF(H01.IncomeID,1,1,'''') = 116 then Income116
		when STUFF(H01.IncomeID,1,1,'''') = 117 then Income117
		when STUFF(H01.IncomeID,1,1,'''') = 118 then Income118
		when STUFF(H01.IncomeID,1,1,'''') = 119 then Income119
		when STUFF(H01.IncomeID,1,1,'''') = 120 then Income120
		when STUFF(H01.IncomeID,1,1,'''') = 121 then Income121
		when STUFF(H01.IncomeID,1,1,'''') = 122 then Income122
		when STUFF(H01.IncomeID,1,1,'''') = 123 then Income123
		when STUFF(H01.IncomeID,1,1,'''') = 124 then Income124
		when STUFF(H01.IncomeID,1,1,'''') = 125 then Income125
		when STUFF(H01.IncomeID,1,1,'''') = 126 then Income126
		when STUFF(H01.IncomeID,1,1,'''') = 127 then Income127
		when STUFF(H01.IncomeID,1,1,'''') = 128 then Income128
		when STUFF(H01.IncomeID,1,1,'''') = 129 then Income129
		when STUFF(H01.IncomeID,1,1,'''') = 130 then Income130
		when STUFF(H01.IncomeID,1,1,'''') = 131 then Income131
		when STUFF(H01.IncomeID,1,1,'''') = 132 then Income132
		when STUFF(H01.IncomeID,1,1,'''') = 133 then Income133
		when STUFF(H01.IncomeID,1,1,'''') = 134 then Income134
		when STUFF(H01.IncomeID,1,1,'''') = 135 then Income135
		when STUFF(H01.IncomeID,1,1,'''') = 136 then Income136
		when STUFF(H01.IncomeID,1,1,'''') = 137 then Income137
		when STUFF(H01.IncomeID,1,1,'''') = 138 then Income138
		when STUFF(H01.IncomeID,1,1,'''') = 139 then Income139
		when STUFF(H01.IncomeID,1,1,'''') = 140 then Income140
		when STUFF(H01.IncomeID,1,1,'''') = 141 then Income141
		when STUFF(H01.IncomeID,1,1,'''') = 142 then Income142
		when STUFF(H01.IncomeID,1,1,'''') = 143 then Income143
		when STUFF(H01.IncomeID,1,1,'''') = 144 then Income144
		when STUFF(H01.IncomeID,1,1,'''') = 145 then Income145
		when STUFF(H01.IncomeID,1,1,'''') = 146 then Income146
		when STUFF(H01.IncomeID,1,1,'''') = 147 then Income147
		when STUFF(H01.IncomeID,1,1,'''') = 148 then Income148
		when STUFF(H01.IncomeID,1,1,'''') = 149 then Income149
		when STUFF(H01.IncomeID,1,1,'''') = 150 then Income150'
	SET @sSQLSelect3 = '
		when STUFF(H01.IncomeID,1,1,'''') = 151 then Income151
		when STUFF(H01.IncomeID,1,1,'''') = 152 then Income152
		when STUFF(H01.IncomeID,1,1,'''') = 153 then Income153
		when STUFF(H01.IncomeID,1,1,'''') = 154 then Income154
		when STUFF(H01.IncomeID,1,1,'''') = 155 then Income155
		when STUFF(H01.IncomeID,1,1,'''') = 156 then Income156
		when STUFF(H01.IncomeID,1,1,'''') = 157 then Income157
		when STUFF(H01.IncomeID,1,1,'''') = 158 then Income158
		when STUFF(H01.IncomeID,1,1,'''') = 159 then Income159
		when STUFF(H01.IncomeID,1,1,'''') = 160 then Income160
		when STUFF(H01.IncomeID,1,1,'''') = 161 then Income161
		when STUFF(H01.IncomeID,1,1,'''') = 162 then Income162
		when STUFF(H01.IncomeID,1,1,'''') = 163 then Income163
		when STUFF(H01.IncomeID,1,1,'''') = 164 then Income164
		when STUFF(H01.IncomeID,1,1,'''') = 165 then Income165
		when STUFF(H01.IncomeID,1,1,'''') = 166 then Income166
		when STUFF(H01.IncomeID,1,1,'''') = 167 then Income167
		when STUFF(H01.IncomeID,1,1,'''') = 168 then Income168
		when STUFF(H01.IncomeID,1,1,'''') = 169 then Income169
		when STUFF(H01.IncomeID,1,1,'''') = 170 then Income170
		when STUFF(H01.IncomeID,1,1,'''') = 171 then Income171
		when STUFF(H01.IncomeID,1,1,'''') = 172 then Income172
		when STUFF(H01.IncomeID,1,1,'''') = 173 then Income173
		when STUFF(H01.IncomeID,1,1,'''') = 174 then Income174
		when STUFF(H01.IncomeID,1,1,'''') = 175 then Income175
		when STUFF(H01.IncomeID,1,1,'''') = 176 then Income176
		when STUFF(H01.IncomeID,1,1,'''') = 177 then Income177
		when STUFF(H01.IncomeID,1,1,'''') = 178 then Income178
		when STUFF(H01.IncomeID,1,1,'''') = 179 then Income179
		when STUFF(H01.IncomeID,1,1,'''') = 180 then Income180
		when STUFF(H01.IncomeID,1,1,'''') = 181 then Income181
		when STUFF(H01.IncomeID,1,1,'''') = 182 then Income182
		when STUFF(H01.IncomeID,1,1,'''') = 183 then Income183
		when STUFF(H01.IncomeID,1,1,'''') = 184 then Income184
		when STUFF(H01.IncomeID,1,1,'''') = 185 then Income185
		when STUFF(H01.IncomeID,1,1,'''') = 186 then Income186
		when STUFF(H01.IncomeID,1,1,'''') = 187 then Income187
		when STUFF(H01.IncomeID,1,1,'''') = 188 then Income188
		when STUFF(H01.IncomeID,1,1,'''') = 189 then Income189
		when STUFF(H01.IncomeID,1,1,'''') = 190 then Income190
		when STUFF(H01.IncomeID,1,1,'''') = 191 then Income191
		when STUFF(H01.IncomeID,1,1,'''') = 192 then Income192
		when STUFF(H01.IncomeID,1,1,'''') = 193 then Income193
		when STUFF(H01.IncomeID,1,1,'''') = 194 then Income194
		when STUFF(H01.IncomeID,1,1,'''') = 195 then Income195
		when STUFF(H01.IncomeID,1,1,'''') = 196 then Income196
		when STUFF(H01.IncomeID,1,1,'''') = 197 then Income197
		when STUFF(H01.IncomeID,1,1,'''') = 198 then Income198
		when STUFF(H01.IncomeID,1,1,'''') = 199 then Income199
		when STUFF(H01.IncomeID,1,1,'''') = 200 then Income200
	else 0 end, 0) )* ' + str(@RateExchange) + '  as IncomeAmount, 0 as SubAmount '

	SET @sSQL = '
		From HT3400  H00 
		inner join HT5005 H01 on H00.PayrollMethodID = H01.PayrollMethodID AND H00.DivisionID = H01.DivisionID
		inner join HT0002 H02 on H02.IncomeID = H01.IncomeID  AND H02.DivisionID = H01.DivisionID 
		inner join HT2400 H03 on H03.TranMonth = H00.TranMonth and
					H03.TranYear = H00.TranYear and
					H03.DivisionID = H00.DivisionID and
					H03.DepartmentID=H00.DepartmentID and
					IsNull(H03.TeamID,'''') like ISNull(H00.TeamID,'''') and
					H03.EmployeeID = H00.EmployeeID and
					H03.TaxObjectID = ''' + ISNULL(@TaxObjectID,'') + '''
		LEFT JOIN HT3499 H04 WITH (NOLOCK) ON H00.DivisionID = H04.DivisionID AND H00.TransactionID = H04.TransactionID 
		Where H00.DivisionID = ''' + @DivisionID + ''' and 
			H00.DepartmentID like  ''' + @DepartmentID1 + ''' and 
			H00.PayrollMethodID like ''' + ISNULL(@PayrollMethodID,'') + ''' and 
			H02.IsTax = 1 and
			H00.TranMonth = ' + CAST(@TranMonth AS varchar(10)) + ' and
			H00.TranYear = ' + CAST(@TranYear AS varchar(10)) + ' 
			Group by H00.DivisionID,  H00.DepartmentID, H00.EmployeeID, H00.PayrollMethodID, H02.IsTax
		Union ' 

	
--Cac khoan giam tru
	SET @sSQL1 = ' Select H00.DivisionID,  H00.DepartmentID,  H00.EmployeeID, H00.PayrollMethodID, H02.IsTax,  0 as IncomeAmount,
					sum(isnull(case when STUFF(H01.SubID,1,1,'''') = 01 then SubAmount01
						when STUFF(H01.SubID,1,1,'''') = 02 then SubAmount02 
						when STUFF(H01.SubID,1,1,'''') = 03 then SubAmount03 
						when STUFF(H01.SubID,1,1,'''') = 04 then SubAmount04 
						when STUFF(H01.SubID,1,1,'''') = 05 then SubAmount05 
						when STUFF(H01.SubID,1,1,'''') = 06 then SubAmount06 
						when STUFF(H01.SubID,1,1,'''') = 07 then  SubAmount07
						when STUFF(H01.SubID,1,1,'''') = 08 then SubAmount08
						when STUFF(H01.SubID,1,1,'''') = 09 then SubAmount09
						when STUFF(H01.SubID,1,1,'''') = 10 then SubAmount10
						when STUFF(H01.SubID,1,1,'''') = 11 then SubAmount11
						when STUFF(H01.SubID,1,1,'''') = 12 then SubAmount12 
						when STUFF(H01.SubID,1,1,'''') = 13 then SubAmount13 
						when STUFF(H01.SubID,1,1,'''') = 14 then SubAmount14 
						when STUFF(H01.SubID,1,1,'''') = 15 then SubAmount15 
						when STUFF(H01.SubID,1,1,'''') = 16 then SubAmount16 
						when STUFF(H01.SubID,1,1,'''') = 17 then SubAmount17
						when STUFF(H01.SubID,1,1,'''') = 18 then SubAmount18
						when STUFF(H01.SubID,1,1,'''') = 19 then SubAmount19
						when STUFF(H01.SubID,1,1,'''') = 20 then SubAmount20
						when STUFF(H01.SubID,1,1,'''') = 21 then SubAmount21
						when STUFF(H01.SubID,1,1,'''') = 22 then SubAmount22 
						when STUFF(H01.SubID,1,1,'''') = 23 then SubAmount23 
						when STUFF(H01.SubID,1,1,'''') = 24 then SubAmount24 
						when STUFF(H01.SubID,1,1,'''') = 25 then SubAmount25 
						when STUFF(H01.SubID,1,1,'''') = 26 then SubAmount26 
						when STUFF(H01.SubID,1,1,'''') = 27 then SubAmount27
						when STUFF(H01.SubID,1,1,'''') = 28 then SubAmount28
						when STUFF(H01.SubID,1,1,'''') = 29 then SubAmount29
						when STUFF(H01.SubID,1,1,'''') = 30 then SubAmount30 '
		
	SET @sSQL11 = '	when STUFF(H01.SubID,1,1,'''') = 31 then SubAmount31
					when STUFF(H01.SubID,1,1,'''') = 32 then SubAmount32 
					when STUFF(H01.SubID,1,1,'''') = 33 then SubAmount33 
					when STUFF(H01.SubID,1,1,'''') = 34 then SubAmount34 
					when STUFF(H01.SubID,1,1,'''') = 35 then SubAmount35 
					when STUFF(H01.SubID,1,1,'''') = 36 then SubAmount36 
					when STUFF(H01.SubID,1,1,'''') = 37 then SubAmount37
					when STUFF(H01.SubID,1,1,'''') = 38 then SubAmount38
					when STUFF(H01.SubID,1,1,'''') = 39 then SubAmount39
					when STUFF(H01.SubID,1,1,'''') = 40 then SubAmount40 
					when STUFF(H01.SubID,1,1,'''') = 41 then SubAmount41
					when STUFF(H01.SubID,1,1,'''') = 42 then SubAmount42 
					when STUFF(H01.SubID,1,1,'''') = 43 then SubAmount43 
					when STUFF(H01.SubID,1,1,'''') = 44 then SubAmount44 
					when STUFF(H01.SubID,1,1,'''') = 45 then SubAmount45 
					when STUFF(H01.SubID,1,1,'''') = 46 then SubAmount46 
					when STUFF(H01.SubID,1,1,'''') = 47 then SubAmount47
					when STUFF(H01.SubID,1,1,'''') = 48 then SubAmount48
					when STUFF(H01.SubID,1,1,'''') = 49 then SubAmount49
					when STUFF(H01.SubID,1,1,'''') = 50 then SubAmount50 
					when STUFF(H01.SubID,1,1,'''') = 51 then SubAmount51
					when STUFF(H01.SubID,1,1,'''') = 52 then SubAmount52 
					when STUFF(H01.SubID,1,1,'''') = 53 then SubAmount53 
					when STUFF(H01.SubID,1,1,'''') = 54 then SubAmount54 
					when STUFF(H01.SubID,1,1,'''') = 55 then SubAmount55 
					when STUFF(H01.SubID,1,1,'''') = 56 then SubAmount56 
					when STUFF(H01.SubID,1,1,'''') = 57 then SubAmount57
					when STUFF(H01.SubID,1,1,'''') = 58 then SubAmount58
					when STUFF(H01.SubID,1,1,'''') = 59 then SubAmount59
					when STUFF(H01.SubID,1,1,'''') = 60 then SubAmount60 
					when STUFF(H01.SubID,1,1,'''') = 61 then SubAmount61
					when STUFF(H01.SubID,1,1,'''') = 62 then SubAmount62 
					when STUFF(H01.SubID,1,1,'''') = 63 then SubAmount63 
					when STUFF(H01.SubID,1,1,'''') = 64 then SubAmount64 
					when STUFF(H01.SubID,1,1,'''') = 65 then SubAmount65 
					when STUFF(H01.SubID,1,1,'''') = 66 then SubAmount66 
					when STUFF(H01.SubID,1,1,'''') = 67 then SubAmount67
					when STUFF(H01.SubID,1,1,'''') = 68 then SubAmount68
					when STUFF(H01.SubID,1,1,'''') = 69 then SubAmount69
					when STUFF(H01.SubID,1,1,'''') = 70 then SubAmount70 
					when STUFF(H01.SubID,1,1,'''') = 71 then SubAmount71
					when STUFF(H01.SubID,1,1,'''') = 72 then SubAmount72 
					when STUFF(H01.SubID,1,1,'''') = 73 then SubAmount73 
					when STUFF(H01.SubID,1,1,'''') = 74 then SubAmount74 
					when STUFF(H01.SubID,1,1,'''') = 75 then SubAmount75 
					when STUFF(H01.SubID,1,1,'''') = 76 then SubAmount76 
					when STUFF(H01.SubID,1,1,'''') = 77 then SubAmount77
					when STUFF(H01.SubID,1,1,'''') = 78 then SubAmount78
					when STUFF(H01.SubID,1,1,'''') = 79 then SubAmount79
					when STUFF(H01.SubID,1,1,'''') = 80 then SubAmount80 
					when STUFF(H01.SubID,1,1,'''') = 81 then SubAmount81
					when STUFF(H01.SubID,1,1,'''') = 82 then SubAmount82 
					when STUFF(H01.SubID,1,1,'''') = 83 then SubAmount83 
					when STUFF(H01.SubID,1,1,'''') = 84 then SubAmount84 
					when STUFF(H01.SubID,1,1,'''') = 85 then SubAmount85'
		SET @sSQL12 = '			
					when STUFF(H01.SubID,1,1,'''') = 86 then SubAmount86 
					when STUFF(H01.SubID,1,1,'''') = 87 then SubAmount87
					when STUFF(H01.SubID,1,1,'''') = 88 then SubAmount88
					when STUFF(H01.SubID,1,1,'''') = 89 then SubAmount89
					when STUFF(H01.SubID,1,1,'''') = 90 then SubAmount90 
					when STUFF(H01.SubID,1,1,'''') = 91 then SubAmount91
					when STUFF(H01.SubID,1,1,'''') = 92 then SubAmount92 
					when STUFF(H01.SubID,1,1,'''') = 93 then SubAmount93 
					when STUFF(H01.SubID,1,1,'''') = 94 then SubAmount94 
					when STUFF(H01.SubID,1,1,'''') = 95 then SubAmount95 
					when STUFF(H01.SubID,1,1,'''') = 96 then SubAmount96 
					when STUFF(H01.SubID,1,1,'''') = 97 then SubAmount97
					when STUFF(H01.SubID,1,1,'''') = 98 then SubAmount98
					when STUFF(H01.SubID,1,1,'''') = 99 then SubAmount99
					when STUFF(H01.SubID,1,1,'''') = 100 then SubAmount100 	else 0 end, 0))  * ' + str(@RateExchange) + '  as SubAmount   	
				From HT3400  H00 	inner join HT5006 H01 on H00.PayrollMethodID = H01.PayrollMethodID AND H00.DivisionID = H01.DivisionID
				inner join HT0005 H02 on H01.SubID = H02.SubID  AND H01.DivisionID = H02.DivisionID 
				inner join HT2400 H03 on H03.TranMonth = H00.TranMonth and
						H03.TranYear = H00.TranYear and
						H03.DivisionID = H00.DivisionID and
						H03.DepartmentID=H00.DepartmentID and
						IsNull(H03.TeamID,'''') like ISNull(H00.TeamID,'''') and
						H03.EmployeeID = H00.EmployeeID and
						H03.TaxObjectID = ''' + ISNULL(@TaxObjectID,'') + ''' 
				LEFT JOIN HT3499 H04 WITH (NOLOCK) ON H00.DivisionID = H04.DivisionID AND H00.TransactionID = H04.TransactionID 
				Where H00.DivisionID = ''' + @DivisionID + ''' and 
				H00.DepartmentID like  ''' + @DepartmentID1 + ''' and 
				H00.PayrollMethodID like ''' + ISNULL(@PayrollMethodID,'') + ''' and 
				H02.IsTax = 1 and
				H00.TranMonth = ' + CAST(@TranMonth AS varchar(10)) + ' and
				H00.TranYear = ' + CAST(@TranYear AS varchar(10)) + '
				Group by H00.DivisionID,  H00.DepartmentID, H00.EmployeeID, H00.PayrollMethodID, H02.IsTax'


--Tinh thu nhap theo tung chi nhanh roi insert vao bang tam HT5890
	SET @sSQL2 = 'Select H00.DivisionID,  H00.DepartmentID, IsNull(H00.TeamID,'''') as TeamID,H00.EmployeeID, H00.PayrollMethodID, 
		(sum(isnull(Income01,0))+ sum(isnull(Income02,0))+sum(isnull(Income03,0))+ sum(isnull(Income04,0))+sum(isnull(Income05,0))+ sum(isnull(Income06,0))+
		sum(isnull(Income07,0))+ sum(isnull(Income08,0))+sum(isnull(Income09,0))+ sum(isnull(Income10,0))+sum(isnull(Income11,0))+ sum(isnull(Income12,0))+
		sum(isnull(Income13,0))+ sum(isnull(Income14,0))+sum(isnull(Income15,0))+ sum(isnull(Income16,0))+sum(isnull(Income17,0))+ sum(isnull(Income18,0))+
		sum(isnull(Income19,0))+ sum(isnull(Income20,0))+sum(isnull(Income21,0))+sum(isnull(Income22,0))+sum(isnull(Income23,0))+sum(isnull(Income24,0))+
		sum(isnull(Income25,0))+sum(isnull(Income26,0))+sum(isnull(Income27,0))+sum(isnull(Income28,0))+sum(isnull(Income29,0))+sum(isnull(Income30,0))+
		sum(isnull(Income31,0))+sum(isnull(Income32,0))+sum(isnull(Income33,0))+sum(isnull(Income34,0))+sum(isnull(Income35,0))+sum(isnull(Income36,0))+
		sum(isnull(Income37,0))+sum(isnull(Income38,0))+sum(isnull(Income39,0))+sum(isnull(Income40,0))+sum(isnull(Income41,0))+sum(isnull(Income42,0))+
		sum(isnull(Income43,0))+sum(isnull(Income44,0))+sum(isnull(Income45,0))+sum(isnull(Income46,0))+sum(isnull(Income47,0))+sum(isnull(Income48,0))+
		sum(isnull(Income49,0))+sum(isnull(Income50,0))+sum(isnull(Income51,0))+sum(isnull(Income52,0))+sum(isnull(Income53,0))+sum(isnull(Income54,0))+
		sum(isnull(Income55,0))+sum(isnull(Income56,0))+sum(isnull(Income57,0))+sum(isnull(Income58,0))+sum(isnull(Income59,0))+sum(isnull(Income60,0))+
		sum(isnull(Income61,0))+sum(isnull(Income62,0))+sum(isnull(Income63,0))+sum(isnull(Income64,0))+sum(isnull(Income65,0))+sum(isnull(Income66,0))+
		sum(isnull(Income67,0))+sum(isnull(Income68,0))+sum(isnull(Income69,0))+sum(isnull(Income70,0))+sum(isnull(Income71,0))+sum(isnull(Income72,0))+
		sum(isnull(Income73,0))+sum(isnull(Income74,0))+sum(isnull(Income75,0))+sum(isnull(Income76,0))+sum(isnull(Income77,0))+sum(isnull(Income78,0))+
		sum(isnull(Income79,0))+sum(isnull(Income80,0))+sum(isnull(Income81,0))+sum(isnull(Income82,0))+sum(isnull(Income83,0))+sum(isnull(Income84,0))+
		sum(isnull(Income85,0))+sum(isnull(Income86,0))+sum(isnull(Income87,0))+sum(isnull(Income88,0))+sum(isnull(Income89,0))+sum(isnull(Income90,0))+
		sum(isnull(Income91,0))+sum(isnull(Income92,0))+sum(isnull(Income93,0))+sum(isnull(Income94,0))+sum(isnull(Income95,0))+sum(isnull(Income96,0))+
		sum(isnull(Income97,0))+sum(isnull(Income98,0))+sum(isnull(Income99,0))+sum(isnull(Income100,0))+sum(isnull(Income101,0))+sum(isnull(Income102,+0))+
		sum(isnull(Income103,0))+sum(isnull(Income104,0))+sum(isnull(Income105,0))+sum(isnull(Income106,0))+sum(isnull(Income107,0))+sum(isnull(Income108,0))+
		sum(isnull(Income109,0))+sum(isnull(Income110,0))+sum(isnull(Income111,0))+sum(isnull(Income112,0))+sum(isnull(Income113,0))+sum(isnull(Income114,0))+
		sum(isnull(Income115,0))+sum(isnull(Income116,0))+sum(isnull(Income117,0))+sum(isnull(Income118,0))+sum(isnull(Income119,0))+sum(isnull(Income120,0))+
		sum(isnull(Income121,0))+sum(isnull(Income122,0))+sum(isnull(Income123,0))+sum(isnull(Income124,0))+sum(isnull(Income125,0))+sum(isnull(Income126,0))+
		sum(isnull(Income127,0))+sum(isnull(Income128,0))+sum(isnull(Income129,0))+sum(isnull(Income130,0))+sum(isnull(Income131,0))+sum(isnull(Income132,0))+
		sum(isnull(Income133,0))+sum(isnull(Income134,0))+sum(isnull(Income135,0))+sum(isnull(Income136,0))+sum(isnull(Income137,0))+sum(isnull(Income138,0))+
		sum(isnull(Income139,0))+sum(isnull(Income140,0))+sum(isnull(Income141,0))+sum(isnull(Income142,0))+sum(isnull(Income143,0))+sum(isnull(Income144,0))+
		sum(isnull(Income145,0))+sum(isnull(Income146,0))+sum(isnull(Income147,0))+sum(isnull(Income148,0))+sum(isnull(Income149,0))+sum(isnull(Income150,0))+'
	SET @sSQLSelect4 = '
		sum(ISNULL(Income151,0))+sum(ISNULL(Income152,0))+sum(ISNULL(Income153,0))+sum(ISNULL(Income154,0))+sum(ISNULL(Income155,0))+
		sum(ISNULL(Income156,0))+sum(ISNULL(Income157,0))+sum(ISNULL(Income158,0))+sum(ISNULL(Income159,0))+sum(ISNULL(Income160,0))+
		sum(ISNULL(Income161,0))+sum(ISNULL(Income162,0))+sum(ISNULL(Income163,0))+sum(ISNULL(Income164,0))+sum(ISNULL(Income165,0))+
		sum(ISNULL(Income166,0))+sum(ISNULL(Income167,0))+sum(ISNULL(Income168,0))+sum(ISNULL(Income169,0))+sum(ISNULL(Income170,0))+
		sum(ISNULL(Income171,0))+sum(ISNULL(Income172,0))+sum(ISNULL(Income173,0))+sum(ISNULL(Income174,0))+sum(ISNULL(Income175,0))+
		sum(ISNULL(Income176,0))+sum(ISNULL(Income177,0))+sum(ISNULL(Income178,0))+sum(ISNULL(Income179,0))+sum(ISNULL(Income180,0))+
		sum(ISNULL(Income181,0))+sum(ISNULL(Income182,0))+sum(ISNULL(Income183,0))+sum(ISNULL(Income184,0))+sum(ISNULL(Income185,0))+
		sum(ISNULL(Income186,0))+sum(ISNULL(Income187,0))+sum(ISNULL(Income188,0))+sum(ISNULL(Income189,0))+sum(ISNULL(Income190,0))+
		sum(ISNULL(Income191,0))+sum(ISNULL(Income192,0))+sum(ISNULL(Income193,0))+sum(ISNULL(Income194,0))+sum(ISNULL(Income195,0))+
		sum(ISNULL(Income196,0))+sum(ISNULL(Income197,0))+sum(ISNULL(Income198,0))+sum(ISNULL(Income199,0))+sum(ISNULL(Income200,0)) - '
	SET @sSQLSelect3 = '
		(sum(isnull(SubAmount01, 0)) +sum(isnull(SubAmount02, 0)) +sum(isnull(SubAmount03, 0)) +sum(isnull(SubAmount04, 0)) +
		sum(isnull(SubAmount05, 0)) +sum(isnull(SubAmount06, 0)) +sum(isnull(SubAmount07, 0)) +sum(isnull(SubAmount08, 0)) +sum(isnull(SubAmount09, 0)) +sum(isnull(SubAmount10, 0)) +
		sum(isnull(SubAmount11, 0)) +sum(isnull(SubAmount12, 0)) +sum(isnull(SubAmount13, 0)) +sum(isnull(SubAmount14, 0)) +sum(isnull(SubAmount15, 0)) +sum(isnull(SubAmount16, 0)) +
		sum(isnull(SubAmount17, 0)) +sum(isnull(SubAmount18, 0)) +sum(isnull(SubAmount19, 0)) +sum(isnull(SubAmount20, 0)) +
		sum(isnull(SubAmount21,0)) +sum(isnull(SubAmount22,0))+sum(isnull(SubAmount23,0))+sum(isnull(SubAmount24,0))+
		sum(isnull(SubAmount25,0))+sum(isnull(SubAmount26,0))+sum(isnull(SubAmount27,0))+sum(isnull(SubAmount28,0))+sum(isnull(SubAmount29,0))+sum(isnull(SubAmount30,0))+
		sum(isnull(SubAmount31,0))+sum(isnull(SubAmount32,0))+sum(isnull(SubAmount33,0))+sum(isnull(SubAmount34,0))+sum(isnull(SubAmount35,0))+sum(isnull(SubAmount36,0))+
		sum(isnull(SubAmount37,0))+sum(isnull(SubAmount38,0))+sum(isnull(SubAmount39,0))+sum(isnull(SubAmount40,0))+sum(isnull(SubAmount41,0))+sum(isnull(SubAmount42,0))+
		sum(isnull(SubAmount43,0))+sum(isnull(SubAmount44,0))+sum(isnull(SubAmount45,0))+sum(isnull(SubAmount46,0))+sum(isnull(SubAmount47,0))+sum(isnull(SubAmount48,0))+
		sum(isnull(SubAmount49,0))+sum(isnull(SubAmount50,0))+sum(isnull(SubAmount51,0))+sum(isnull(SubAmount52,0))+sum(isnull(SubAmount53,0))+sum(isnull(SubAmount54,0))+
		sum(isnull(SubAmount55,0))+sum(isnull(SubAmount56,0))+sum(isnull(SubAmount57,0))+sum(isnull(SubAmount58,0))+sum(isnull(SubAmount59,0))+sum(isnull(SubAmount60,0))+
		sum(isnull(SubAmount61,0))+sum(isnull(SubAmount62,0))+sum(isnull(SubAmount63,0))+sum(isnull(SubAmount64,0))+sum(isnull(SubAmount65,0))+sum(isnull(SubAmount66,0))+
		sum(isnull(SubAmount67,0))+sum(isnull(SubAmount68,0))+sum(isnull(SubAmount69,0))+sum(isnull(SubAmount70,0))+sum(isnull(SubAmount71,0))+sum(isnull(SubAmount72,0))+
		sum(isnull(SubAmount73,0))+sum(isnull(SubAmount74,0))+sum(isnull(SubAmount75,0))+sum(isnull(SubAmount76,0))+sum(isnull(SubAmount77,0))+sum(isnull(SubAmount78,0))+
		sum(isnull(SubAmount79,0))+sum(isnull(SubAmount80,0))+sum(isnull(SubAmount81,0))+sum(isnull(SubAmount82,0))+sum(isnull(SubAmount83,0))+sum(isnull(SubAmount84,0))+
		sum(isnull(SubAmount85,0))+sum(isnull(SubAmount86,0))+sum(isnull(SubAmount87,0))+sum(isnull(SubAmount88,0))+sum(isnull(SubAmount89,0))+sum(isnull(SubAmount90,0))+
		sum(isnull(SubAmount91,0))+sum(isnull(SubAmount92,0))+sum(isnull(SubAmount93,0))+sum(isnull(SubAmount94,0))+sum(isnull(SubAmount95,0))+sum(isnull(SubAmount96,0))+
		sum(isnull(SubAmount97,0))+sum(isnull(SubAmount98,0))+sum(isnull(SubAmount99,0))+sum(isnull(SubAmount100,0)) ) )  as TeamSalary	
	From HT3400  H00 
	inner join HT2400 H03 on H03.TranMonth = H00.TranMonth and
				H03.TranYear = H00.TranYear and
				H03.DivisionID = H00.DivisionID and
				H03.DepartmentID=H00.DepartmentID and
				IsNull(H03.TeamID,'''')=IsNull(H00.TeamID,'''') and
				H03.EmployeeID = H00.EmployeeID and
				H03.TaxObjectID = ''' + @TaxObjectID + '''
	LEFT JOIN HT3499 H04 WITH (NOLOCK) ON H00.DivisionID = H04.DivisionID AND H00.TransactionID = H04.TransactionID 
	Where H00.DivisionID = ''' + @DivisionID + ''' and 
		H00.DepartmentID like  ''' + @DepartmentID1 + ''' and 
		H00.TeamID like   ''' + ISNULL(@TeamID1,'') + ''' and 
		H00.PayrollMethodID like ''' + @PayrollMethodID + ''' and 
		H00.TranMonth = ' + CAST(@TranMonth AS varchar(10)) + ' and
		H00.TranYear = ' + CAST(@TranYear AS varchar(10)) + ' 
	Group by H00.DivisionID,  H00.DepartmentID, IsNull(H00.TeamID,'''') ,H00.EmployeeID, H00.PayrollMethodID ' 

/*If exists(Select Top 1 1 From sysObjects Where Name = 'HV5510' and XType = 'V')
	Drop view HV5510
EXEC('Create view HV5510 ---tao boi HP5007
		as ' + @sSQL2)*/


    IF NOT EXISTS ( SELECT TOP 1 1 FROM SysObjects WHERE Name = 'HT5890' AND Xtype = 'U' )
    BEGIN
		CREATE TABLE [dbo].[HT5890]
                     (
                       [DivisionID] [nvarchar](50) NULL ,
                       [DepartmentID] [nvarchar](50) NULL ,
                       [TeamID] [nvarchar](50) NULL ,
                       [EmployeeID] [nvarchar](50) NOT NULL ,
                       [PayrollMethodID] [nvarchar](50) NULL ,
                       [TeamSalary] [decimal](28,8) NULL )
                     ON     [PRIMARY]
    END
    ELSE
        BEGIN
                DELETE HT5890
        END
    
	EXEC ( 'Insert into HT5890( DivisionID,  DepartmentID,TeamID,EmployeeID,  PayrollMethodID, TeamSalary)'+@sSQL2+@sSQLSelect4+@sSQLSelect3 )
			--PRINT ('@sSQL2'+ @sSQL2)
			--PRINT ('@sSQLSelect3'+@sSQLSelect3)
/*		H00.TranMonth + 100*H00.TranYear between ' + 
	cast(@FromMonth + @FromYear*100 as varchar(10)) + ' and ' + cast(@ToMonth + @ToYear*100 as varchar(10))   		

*/		

/*

If exists(Select Top 1 1 From sysObjects Where Name = 'HV5509' and XType = 'V')
	Drop view HV5509
EXEC('Create view HV5509 ---tao boi HP5006
		as ' + @sSQL+@sSQL1)*/
		

    IF NOT EXISTS ( SELECT TOP 1 1 FROM SysObjects WHERE Name = 'HT5889' AND Xtype = 'U' )
    BEGIN

			CREATE TABLE [dbo].[HT5889](
			[APK] [uniqueidentifier] NOT NULL,
			[DivisionID] [nvarchar](3) NULL,
			[DepartmentID] [nvarchar](50) NULL,
			[EmployeeID] [nvarchar](50) NOT NULL,
			[PayrollMethodID] [nvarchar](50) NULL,
			[IsTax] [int] NULL,
			[IncomeAmount] [decimal](28, 8) NULL,
			[SubAmount] [decimal](28, 8) NULL,
				CONSTRAINT [PK_HT5889] PRIMARY KEY NONCLUSTERED 
			(
				[APK] ASC
			)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
		) ON [PRIMARY]
					
		ALTER TABLE [dbo].[HT5889] ADD  DEFAULT (newid()) FOR [APK]

	END
	ELSE
	BEGIN
			DELETE HT5889
	END
	
	EXEC ( 'Insert into HT5889  ( DivisionID,  DepartmentID, EmployeeID,  PayrollMethodID, IsTax, IncomeAmount,  SubAmount)' 
				+@sSQLSelect+@sSQLSelect1+@sSQLSelect2+@sSQLSelect3+@sSQL+@sSQL1+@sSQL11+@sSQL12 )
		--PRINT (@sSQLSelect)
		--PRINT (@sSQLSelect1)
		--PRINT (@sSQLSelect2)
		--PRINT (@sSQL)
		--PRINT (@sSQL1)
		--PRINT (@sSQL11)
		--PRINT (@sSQL12)
	---Tinh luong tinh thue thu nhap
    SET @sSQL = '
	Select	DivisionID, DepartmentID,  EmployeeID, PayrollMethodID, 
			sum(IncomeAmount - SubAmount) as SalaryAmount, sum(IncomeAmount - SubAmount)  as SalaryAmount1
	From HT5889
	WHERE DivisionID = ''' +  @DivisionID + '''
	Group by DivisionID, DepartmentID, EmployeeID, PayrollMethodID'

	IF EXISTS ( SELECT TOP 1 1 FROM sysObjects WHERE Name = 'HV5504' AND XType = 'V' )
    BEGIN
       DROP VIEW HV5504
    END
    EXEC ( 'Create view HV5504 ---tao boi HP5007 as '+@sSQL )

	--Tinh thue tren tong luong tung nguoi
    SELECT	@IsProgressive = IsProgressive ,
			@IsPercentSurtax = IsPercentSurtax
    FROM	HT1011
    WHERE	TaxObjectID = @TaxObjectID

    IF @IsProgressive = 1
    BEGIN  ---luy tien	
        SET @sSQL = 'Select H00.DivisionID, DepartmentID, EmployeeID, PayrollMethodID, SalaryAmount,
		isnull(sum(case when (SalaryAmount > MinSalary and (SalaryAmount <= MaxSalary or MaxSalary = -1))
		then SalaryAmount - MinSalary
		else case when SalaryAmount <= MinSalary then 0 else
		MaxSalary - MinSalary end end* isnull(RateOrAmount,0)/100), 0)   as TaxAmount,
		isnull(max(case when (SalaryAmount > MinSalary and (SalaryAmount <= MaxSalary or MaxSalary = -1))
		then RateOrAmount else 0 end), 0) as TaxRate
		From HV5504 H00 inner join HT1012 H01 on H01.TaxObjectID = ''' + @TaxObjectID + '''	AND H00.DivisionID = H01.DivisionID 
		Group by H00.DivisionID, DepartmentID,  EmployeeID, PayrollMethodID, SalaryAmount'
    END
    ELSE
    BEGIN  ---nac thang
        SET @sSQL = '	Select H00.DivisionID, DepartmentID, EmployeeID, PayrollMethodID,  SalaryAmount,
		isnull(sum(case when (SalaryAmount > MinSalary and (SalaryAmount <= MaxSalary or MaxSalary = -1))
		then SalaryAmount else 0 end		* isnull(RateOrAmount,0)/100), 0)  as TaxAmount,
		isnull(max(case when (SalaryAmount > MinSalary and (SalaryAmount <= MaxSalary or MaxSalary = -1))
		then RateOrAmount else 0 end), 0) as TaxRate
		From HV5504 H00 inner join HT1012 H01 on H01.TaxObjectID = ''' + @TaxObjectID + ''' AND H00.DivisionID = H01.DivisionID
		Group by H00.DivisionID, DepartmentID,  EmployeeID, PayrollMethodID,  SalaryAmount '
    END


    IF EXISTS ( SELECT TOP 1 1 FROM sysObjects  WHERE Name = 'HV5508' AND Type = 'V' )
    BEGIN
            DROP VIEW HV5508
    END

    EXEC ( 'Create view HV5508 ---tao boi HP5007 as '+@sSQL )

    IF @IsPercentSurtax = 1 ---Tinh thue thu nhap bo sung
    BEGIN
        SET @sSQL = '
		Select DivisionID, DepartmentID, EmployeeID, PayrollMethodID, TaxRate,TaxAmount +
		case when (SalaryAmount - TaxAmount) > IncomeAfterTax then (SalaryAmount - TaxAmount)*RateOrAmount/100 else 0 end  as TaxAmount
		From HV5508 H00 inner join HT1011 H01  on H01.TaxObjectID = ''' + @TaxObjectID + ''' AND H00.DivisionID = H01.DivisionID ' 

        IF EXISTS ( SELECT TOP 1 1 FROM sysObjects WHERE Name = 'HV5007' AND Type = 'V' )
        BEGIN
                DROP VIEW HV5007
        END
        EXEC ( 'Create view HV5007 ---tao boi HP5007 as '+@sSQL )
    END


	----BUOC 2 Phan bo thue thu nhap ra tung chi nhanh theo ty le thu nhap 
			IF @IsPercentSurtax = 1
			BEGIN ---Tinh thue thu nhap bo sung
				SET @sSQL = 'Select H00.DivisionID,  H00.DepartmentID, IsNull(H00.TeamID,'''') as TeamID,H00.EmployeeID, H00.PayrollMethodID, 
				Case H03.SalaryAmount1 When 0 Then HV.TaxAmount*H00.TeamSalary/1 Else HV.TaxAmount*H00.TeamSalary/H03.SalaryAmount1 End 
					as TaxAmount, TaxRate
				From HT5890 H00 inner join HV5504 H03
					on H00.DivisionID = H03.DivisionID and
						H00.DepartmentID=H03.DepartmentID  and
						H03.EmployeeID = H00.EmployeeID
				Left Join HV5007 HV on H00.DivisionID = HV.DivisionID and
						H00.DepartmentID=HV.DepartmentID  and
						H03.EmployeeID = HV.EmployeeID'
			END
			ELSE
			BEGIN
				SET @sSQL = 'Select H00.DivisionID,  H00.DepartmentID, IsNull(H00.TeamID,'''') as TeamID,H00.EmployeeID, H00.PayrollMethodID, HV.TaxAmount as a, H00.TeamSalary, H03.SalaryAmount, H03.SalaryAmount1,
				Case H03.SalaryAmount1 When 0 Then HV.TaxAmount*H00.TeamSalary/1 Else HV.TaxAmount*H00.TeamSalary/H03.SalaryAmount1 End 
				as TaxAmount, TaxRate
				From HT5890 H00 left join HV5504 H03
				on H00.DivisionID = H03.DivisionID and
					H00.DepartmentID=H03.DepartmentID  and
					H03.EmployeeID = H00.EmployeeID
				Left Join HV5508 HV on H00.DivisionID = HV.DivisionID and
					H00.DepartmentID=HV.DepartmentID  and
					H03.EmployeeID = HV.EmployeeID'
			END


        IF EXISTS ( SELECT TOP 1 1 FROM sysObjects WHERE Name = 'HV5008' AND Type = 'V' )
        BEGIN
                DROP VIEW HV5008
        END
        EXEC ( 'Create view HV5008 ---tao boi HP5007 as '+@sSQL )


        UPDATE H00            
        SET	TaxAmount = H01.TaxAmount ,
            TaxRate = H01.TaxRate
        FROM HT3400 H00 
		INNER JOIN HV5008 H01 ON H00.DivisionID = H01.DivisionID AND H00.EmployeeID = H01.EmployeeID AND H00.DepartmentID = H01.DepartmentID 
							AND IsNull(H00.TeamID , '') = IsNull(H01.TeamID , '') AND H00.PayrollMethodID = H01.PayrollMethodID AND H00.TranMonth = @TranMonth AND H00.TranYear = @TranYear


        FETCH next FROM @cur INTO @TaxObjectID
    END

CLOSE @cur

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

