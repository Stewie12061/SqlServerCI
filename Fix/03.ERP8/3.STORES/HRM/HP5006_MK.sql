IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[HP5006_MK]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[HP5006_MK]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







---Created by: Vo Thanh Huong, date: 17/02/2005
---purpose: Tinh thue thu nhap
---Edit By: Dang Le Bao Quynh; Date 27/08/2008
---Purpose: Sua Union thanh Union All
--- Modify on 01/08/2013 by Bao Anh: Bo sung them 10 khoan thu nhap 21 -> 30 (Hung Vuong)
---- Modified by Bảo Thy on 29/11/2016: Bổ sung Income31 - > Income150 (MEIKO)
---- Modified by Bảo Thy on 17/01/2017: BỔ sung I151 -> I200 (MEIKO)
/********************************************
'* Edited by: [GS] [Minh Lâm] [02/08/2010]
'********************************************/
---- Modified by Phương Thảo on 05/12/2016: Bổ sung lưu S21->S100 (MEIKO)
---- Modified by Phương Thảo on 01/06/2017: Customize tính thuế cho lđ thời vụ và nv tu nghiệp nước ngoài (MEIKO)

CREATE PROCEDURE [dbo].[HP5006_MK]
       @DivisionID AS nvarchar(50) ,
       @TranMonth AS int ,
       @TranYear AS int ,
       @PayrollMethodID AS nvarchar(50) ,
       @DepartmentID1 AS nvarchar(50) ,
       @TeamID1 AS nvarchar(50)
AS
DECLARE
        @sSQLSelect nvarchar(4000) ='',
		@sSQLSelect1 nvarchar(4000) ='',
		@sSQLSelect2 nvarchar(4000) ='',
		@sSQLSelect3 nvarchar(4000) ='',
        @sSQLFrom nvarchar(4000) ,
        @sSQLWhere nvarchar(4000) ,
        @sSQLUnion nvarchar(4000) ,
		@sSQLUnion1 nvarchar(4000) ,
		@sSQLUnion2 nvarchar(4000) ,
        @IsProgressive tinyint ,
        @IsPercentSurtax AS tinyint ,
        @TaxObjectID nvarchar(50) ,
        @cur AS cursor ,
        @RateExchange AS nvarchar(50) ,
        @Currency AS nvarchar(50),
		@CustomerIndex INT,
		@sJoin NVARCHAR(MAX)='',
		@FirstDate datetime, 
		@LastDate datetime


SET @FirstDate = CONVERT(Datetime,STR(@TranMonth)+'/'+'1'+'/'++STR(@TranYear)) 
SET @LastDate = DATEADD(s,-1,DATEADD(mm, DATEDIFF(m,0,@FirstDate)+1,0))

SELECT @CustomerIndex = CustomerName From CustomerIndex

IF @CustomerIndex = 50 --MEIKO
SET @sJoin = 'LEFT JOIN HT3499 H04 WITH (NOLOCK) ON H00.DivisionID = H04.DivisionID AND H00.TransactionID = H04.TransactionID'
SET @RateExchange = 1

IF EXISTS ( SELECT TOP 1
                1
            FROM
                HT3400
            WHERE
                DivisionID = @DivisionID AND DepartmentID LIKE @DepartmentID1 AND Isnull(TeamID , '') LIKE isnull(@TeamID1 , '') AND TranMonth = @TranMonth AND TranYear = @TranYear )
   BEGIN
         SET @cur = CURSOR SCROLL KEYSET FOR SELECT DISTINCT
                                                 TaxObjectID
                                             FROM
                                                 HT2400
                                             WHERE DivisionID = @DivisionID AND
                                                 TranMonth = @TranMonth AND TranYear = @TranYear AND isnull(TaxObjectID , '''') <> '''' AND DivisionID = @DivisionID AND DepartmentID LIKE @DepartmentID1 AND Isnull(TeamID , '') LIKE isnull(@TeamID1 , '')
         OPEN @cur
         FETCH next FROM @cur INTO @TaxObjectID
         WHILE @@Fetch_Status = 0
               BEGIN
---Tinh thu nhap chiu thue
IF @CustomerIndex = 50 --MEIKO
BEGIN
	SET @sSQLSelect = 'Select H00.DivisionID,  H00.DepartmentID, ISnull(H00.TeamID,'''') as TeamID,H00.EmployeeID, H00.PayrollMethodID, H02.IsTax,
		 isnull(case when STUFF(H01.IncomeID,1,1,'''') = 01 then Income01
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
		else 0 end, 0) * ' + str(@RateExchange) + '  as IncomeAmount, 0 as SubAmount '
END
ELSE
BEGIN
     SET @sSQLSelect = 'Select H00.DivisionID,  H00.DepartmentID, ISnull(H00.TeamID,'''') as TeamID,H00.EmployeeID, H00.PayrollMethodID, H02.IsTax,
		isnull(case when right(H01.IncomeID,2) = 01 then Income01
		when right(H01.IncomeID,2) = 02 then Income02 
		when right(H01.IncomeID,2) = 03 then Income03 
		when right(H01.IncomeID,2) = 04 then Income04 
		when right(H01.IncomeID,2) = 05 then Income05 
		when right(H01.IncomeID,2) = 06 then Income06 
		when right(H01.IncomeID,2) = 07 then Income07
		when right(H01.IncomeID,2) = 08 then Income08
		when right(H01.IncomeID,2) = 09 then Income09
		when right(H01.IncomeID,2) = 10 then Income10 
		when right(H01.IncomeID,2) = 11 then Income11
		when right(H01.IncomeID,2) = 12 then Income12 
		when right(H01.IncomeID,2) = 13 then Income13 
		when right(H01.IncomeID,2) = 14 then Income14 
		when right(H01.IncomeID,2) = 15 then Income15 
		when right(H01.IncomeID,2) = 16 then Income16 
		when right(H01.IncomeID,2) = 17 then Income17
		when right(H01.IncomeID,2) = 18 then Income18
		when right(H01.IncomeID,2) = 19 then Income19
		when right(H01.IncomeID,2) = 20 then Income20
		when right(H01.IncomeID,2) = 21 then Income21
		when right(H01.IncomeID,2) = 22 then Income22
		when right(H01.IncomeID,2) = 23 then Income23
		when right(H01.IncomeID,2) = 24 then Income24
		when right(H01.IncomeID,2) = 25 then Income25
		when right(H01.IncomeID,2) = 26 then Income26
		when right(H01.IncomeID,2) = 27 then Income27
		when right(H01.IncomeID,2) = 28 then Income28
		when right(H01.IncomeID,2) = 29 then Income29
		when right(H01.IncomeID,2) = 30 then Income30
		else 0 end, 0) * ' + str(@RateExchange) + '  as IncomeAmount, 0 as SubAmount '
END
--PRINT  @sSQLSelect1 
--PRINT  @sSQLSelect2
SET @sSQLFrom = ' From HT3400  H00 inner join HT5005 H01 on H00.PayrollMethodID = H01.PayrollMethodID AND H00.DivisionID = H01.DivisionID
		inner join HT0002 H02 on H02.IncomeID = H01.IncomeID AND  H02.DivisionID = H01.DivisionID 
		inner join HT2400 H03 on H03.TranMonth = H00.TranMonth and H03.DivisionID = H00.DivisionID
			and H03.TranYear = H00.TranYear and
			H03.DivisionID = H00.DivisionID and
			H03.DepartmentID=H00.DepartmentID and
			IsNull(H03.TeamID,'''') like ISNull(H00.TeamID,'''') and
			H03.EmployeeID = H00.EmployeeID and
			H03.TaxObjectID = ''' + @TaxObjectID + '''
			'+@sJoin+' '
                    SET @sSQLWhere = ' Where H00.DivisionID = ''' + @DivisionID + ''' and 
	H00.DepartmentID like ''' + @DepartmentID1 + ''' and 
	IsNull(H00.TeamID,'''') like  ''' + ISNULL(@TeamID1,'') + ''' and
	H00.PayrollMethodID like ''' + ISNULL(@PayrollMethodID,'') + ''' and 
	H02.IsTax = 1 and
	H00.TranMonth = ' + CAST(@TranMonth AS varchar(10)) + ' and
	H00.TranYear = ' + CAST(@TranYear AS varchar(10)) + ' '
   
IF (@CustomerIndex = 50)
BEGIN
	SET @sSQLUnion = ' Union All ' + --Cac khoan giam tru
    ' Select H00.DivisionID,  H00.DepartmentID, ISnull(H00.TeamID,'''') as TeamID, H00.EmployeeID, H00.PayrollMethodID, H02.IsTax,  0 as IncomeAmount,
		isnull(case when STUFF(H01.SubID,1,1,'''') = 01 then SubAmount01
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
		when STUFF(H01.SubID,1,1,'''') = 30 then SubAmount30'
	SET @sSQLUnion1 = 	' 
		when STUFF(H01.SubID,1,1,'''') = 31 then SubAmount31
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
		when STUFF(H01.SubID,1,1,'''') = 85 then SubAmount85 '
	SET @sSQLUnion2 = '
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
		when STUFF(H01.SubID,1,1,'''') = 100 then SubAmount100	else 0 end, 0) * ' + str(@RateExchange) + '  as SubAmount   	
	From HT3400  H00 
	inner join HT5006 H01 on H00.PayrollMethodID = H01.PayrollMethodID and H00.DivisionID = H01.DivisionID 
	inner join HT0005 H02 on H01.SubID = H02.SubID and H01.DivisionID = H02.DivisionID 
	inner join HT2400 H03 on H03.TranMonth = H00.TranMonth and H03.DivisionID = H00.DivisionID and
				H03.TranYear = H00.TranYear and
				H03.DivisionID = H00.DivisionID and
				H03.DepartmentID=H00.DepartmentID and
				IsNull(H03.TeamID,'''') like ISNull(H00.TeamID,'''') and
				H03.EmployeeID = H00.EmployeeID and
				H03.TaxObjectID = ''' + @TaxObjectID + ''' 
	'+@sJoin+'
	Where H00.DivisionID = ''' + @DivisionID + ''' and 
		H00.DepartmentID like ''' + @DepartmentID1 + ''' and 
		IsNull(H00.TeamID,'''') like  ''' + ISNULL(@TeamID1,'') + ''' and
		H00.PayrollMethodID like ''' + ISNULL(@PayrollMethodID,'') + ''' and 
		H02.IsTax = 1 and
		H00.TranMonth = ' + CAST(@TranMonth AS varchar(10)) + ' and
		H00.TranYear = ' + CAST(@TranYear AS varchar(10))
END
ELSE
BEGIN
	SET @sSQLUnion = ' Union All ' + --Cac khoan giam tru
                     ' Select H00.DivisionID,  H00.DepartmentID, ISnull(H00.TeamID,'''') as TeamID, H00.EmployeeID, H00.PayrollMethodID, H02.IsTax,  0 as IncomeAmount,
		isnull(case when right(H01.SubID,2) = 01 then SubAmount01
		 when right(H01.SubID,2) = 02 then SubAmount02 
		 when right(H01.SubID,2) = 03 then SubAmount03 
		 when right(H01.SubID,2) = 04 then SubAmount04 
		 when right(H01.SubID,2) = 05 then SubAmount05 
		 when right(H01.SubID,2) = 06 then SubAmount06 
		when right(H01.SubID,2) = 07 then  SubAmount07
		when right(H01.SubID,2) = 08 then SubAmount08
		when right(H01.SubID,2) = 09 then SubAmount09
		when right(H01.SubID,2) = 10 then SubAmount10
		when right(H01.SubID,2) = 11 then SubAmount11
		 when right(H01.SubID,2) = 12 then SubAmount12 
		 when right(H01.SubID,2) = 13 then SubAmount13 
		 when right(H01.SubID,2) = 14 then SubAmount14 
		 when right(H01.SubID,2) = 15 then SubAmount15 
		 when right(H01.SubID,2) = 16 then SubAmount16 
		when right(H01.SubID,2) = 17 then  SubAmount17
		when right(H01.SubID,2) = 18 then SubAmount18
		when right(H01.SubID,2) = 19 then SubAmount19
		when right(H01.SubID,2) = 20 then SubAmount20 else 0 end, 0) * ' + str(@RateExchange) + '  as SubAmount   	
	From HT3400  H00 inner join HT5006 H01 on H00.PayrollMethodID = H01.PayrollMethodID and H00.DivisionID = H01.DivisionID 
			inner join HT0005 H02 on H01.SubID = H02.SubID and H01.DivisionID = H02.DivisionID 
			inner join HT2400 H03 on H03.TranMonth = H00.TranMonth and H03.DivisionID = H00.DivisionID and
				H03.TranYear = H00.TranYear and
				H03.DivisionID = H00.DivisionID and
				H03.DepartmentID=H00.DepartmentID and
				IsNull(H03.TeamID,'''') like ISNull(H00.TeamID,'''') and
				H03.EmployeeID = H00.EmployeeID and
				H03.TaxObjectID = ''' + @TaxObjectID + ''' 
	Where H00.DivisionID = ''' + @DivisionID + ''' and 
		H00.DepartmentID like ''' + @DepartmentID1 + ''' and 
		IsNull(H00.TeamID,'''') like  ''' + ISNULL(@TeamID1,'') + ''' and
		H00.PayrollMethodID like ''' + ISNULL(@PayrollMethodID,'') + ''' and 
		H02.IsTax = 1 and
		H00.TranMonth = ' + CAST(@TranMonth AS varchar(10)) + ' and
		H00.TranYear = ' + CAST(@TranYear AS varchar(10))
END

                     IF EXISTS ( SELECT TOP 1
                                     1
                                 FROM
                                     sysObjects
                                 WHERE
                                     Name = 'HV5501' AND Type = 'V' )
                        BEGIN						
                             DROP VIEW HV5501
                        END
						
                     EXEC ( 'Create view HV5501 ---tao boi HP5006_MK
		as '+@sSQLSelect+@sSQLSelect1+@sSQLSelect2+@sSQLSelect3+@sSQLFrom+@sSQLWhere+@sSQLUnion+@sSQLUnion1+@sSQLUnion2 )
		--PRINT @sSQLSelect 
		--PRINT @sSQLSelect1
		--PRINT @sSQLSelect2
		--PRINT @sSQLSelect3
		--PRINT @sSQLFrom
		--PRINT @sSQLWhere
		--PRINT @sSQLUnion
		--PRINT @sSQLUnion1
		--PRINT @sSQLUnion2

		--select * from HV5501  order by EmployeeID
---Tính thu nh?p tr??c thu? (t?ng thu nh?p tr??c thu? - t?ng gi?m tr? tr??c thu?)
                     SET @sSQLSelect = 'Select DivisionID, DepartmentID, TeamID, EmployeeID, PayrollMethodID, 
		sum(IncomeAmount - SubAmount) as SalaryAmount 
	From HV5501
	Group by DivisionID, DepartmentID,TeamID, EmployeeID, PayrollMethodID'
	
	

                     IF EXISTS ( SELECT TOP 1
                                     1
                                 FROM
                                     sysObjects
                                 WHERE
                                     Name = 'HV5502' AND Type = 'V' )
                        BEGIN
                              DROP VIEW HV5502
                        END
                     EXEC ( 'Create view HV5502 ---tao boi HP5006_MK
		as '+@sSQLSelect )
--		print @sSQLSelect 
--select * from HV5502 order by EmployeeID
--Tinh thue 
                     SELECT
                         @IsProgressive = IsProgressive ,
                         @IsPercentSurtax = IsPercentSurtax
                     FROM
                         HT1011
                     WHERE
                         TaxObjectID = @TaxObjectID

                     IF @IsProgressive = 1
					 BEGIN  ---luy tien
                        SET @sSQLSelect = '	Select H00.DivisionID, DepartmentID, TeamID, EmployeeID, PayrollMethodID, SalaryAmount,
											isnull(sum(case when (SalaryAmount > MinSalary and (SalaryAmount <= MaxSalary or MaxSalary = -1))
											then SalaryAmount - MinSalary
											else case when SalaryAmount <= MinSalary then 0 else
											MaxSalary - MinSalary end end* isnull(RateOrAmount,0)/100), 0) as TaxAmount,
											isnull(max(case when (SalaryAmount > MinSalary and (SalaryAmount <= MaxSalary or MaxSalary = -1))
											then RateOrAmount else 0 end), 0) as TaxRate
										INTO HT5888
										From HV5502 H00 inner join HT1012 H01 on H01.TaxObjectID = ''' + @TaxObjectID + ''' AND H01.DivisionID = ''' + @DivisionID + '''
										Group by H00.DivisionID, DepartmentID, TeamID, EmployeeID, PayrollMethodID, SalaryAmount'
                     END
                     ELSE
                     BEGIN  ---nac thang
                        SET @sSQLSelect = '	Select H00.DivisionID, DepartmentID, TeamID, EmployeeID, PayrollMethodID,  SalaryAmount,
											isnull(sum(case when (SalaryAmount > MinSalary and (SalaryAmount <= MaxSalary or MaxSalary = -1))
											then SalaryAmount else 0 end		* isnull(RateOrAmount,0)/100), 0) as TaxAmount,
											isnull(max(case when (SalaryAmount > MinSalary and (SalaryAmount <= MaxSalary or MaxSalary = -1))
											then RateOrAmount else 0 end), 0) as TaxRate
										INTO HT5888
										From HV5502 H00 inner join HT1012 H01 on H01.TaxObjectID = ''' + @TaxObjectID + ''' AND H01.DivisionID = ''' + @DivisionID + '''
										Group by H00.DivisionID, DepartmentID, TeamID,  EmployeeID, PayrollMethodID,  SalaryAmount '
                      END

                     IF EXISTS ( SELECT TOP 1
                                     1
                                 FROM
                                     sysObjects
                                 WHERE
                                     XType = 'U' AND Name = 'HT5888' )
                        BEGIN
                              DROP TABLE HT5888
                        END
                     EXEC ( @sSQLSelect )

                     IF @IsPercentSurtax = 1 ---Tinh thue thu nhap bo sung
						BEGIN
                              SET @sSQLSelect = 'Select H00.DivisionID, DepartmentID, TeamID, EmployeeID, PayrollMethodID, TaxRate,TaxAmount + 
														case when (SalaryAmount - TaxAmount) > IncomeAfterTax then (SalaryAmount - TaxAmount)*RateOrAmount/100 else 0 end as TaxAmount
												From HT5888  H00 inner join HT1011 H01  on H01.TaxObjectID = ''' + @TaxObjectID + ''' AND H01.DivisionID = H00.DivisionID '

                              IF EXISTS ( SELECT TOP 1
                                              1
                                          FROM
                                              sysObjects
                                          WHERE
                                              Name = 'HV5006' AND Type = 'V' )
                                 BEGIN
									  DROP VIEW HV5006
                                 END
                              EXEC ( 'Create view HV5006 ---tao boi HP5006_MK
										as '+@sSQLSelect )

							IF (@CustomerIndex = 50)
							BEGIN 
						
								UPDATE	HT3400
								SET		TaxAmount = H01.TaxAmount ,
										TaxRate = H01.TaxRate
								FROM		HT3400 H00 
								INNER JOIN HV5006 H01 ON H00.DivisionID = H01.DivisionID AND H00.DepartmentID = H01.DepartmentID 
													AND IsNull(H00.TeamID , '') LIKE ISNull(H01.TeamID , '') AND H00.EmployeeID = H01.EmployeeID 
													AND H00.PayrollMethodID = H01.PayrollMethodID AND H00.TranMonth = @TranMonth AND H00.TranYear = @TranYear
								LEFT JOIN HT1403 ON H00.EmployeeID = HT1403.EmployeeID AND H00.DivisionID = HT1403.DivisionID							  
								LEFT join HT1414 ON HT1414.DivisionID = H00.DivisionID AND HT1414.EmployeeID = H00.EmployeeID
												AND	@LastDate BETWEEN ISNULL(HT1414.BeginDate,HT1403.WorkDate) AND Isnull(HT1414.EndDate,@LastDate) 
								WHERE H00.DivisionID = @DivisionID 
								AND (HT1403.TitleID <> 'OST' AND (CASE WHEN ISNULL(HT1414.EmployeeMode,'') <> '' THEN  HT1414.EmployeeMode ELSE HT1414.EmployeeStatus END <> 'TO') )
							
								--- Công nhân thời vụ thì không trừ thuế
								UPDATE	HT3400
								SET		TaxAmount = 0,
										TaxRate = 0
								FROM		HT3400 H00 
								INNER JOIN HV5006 H01 ON H00.DivisionID = H01.DivisionID AND H00.DepartmentID = H01.DepartmentID 
													AND IsNull(H00.TeamID , '') LIKE ISNull(H01.TeamID , '') AND H00.EmployeeID = H01.EmployeeID 
													AND H00.PayrollMethodID = H01.PayrollMethodID AND H00.TranMonth = @TranMonth AND H00.TranYear = @TranYear
								LEFT JOIN HT1403 ON H00.EmployeeID = HT1403.EmployeeID AND H00.DivisionID = HT1403.DivisionID							  							
								WHERE H00.DivisionID = @DivisionID 
								AND (HT1403.TitleID = 'OST' ) 

								--- Nhân viên có thời gian đào tạo ở nước ngoài thì tính 20%
								UPDATE	HT3400
								SET		TaxAmount = SalaryAmount * 0.2,
										TaxRate = 20
								FROM		HT3400 H00 
								INNER JOIN HV5502 H01 ON H00.DivisionID = H01.DivisionID AND H00.DepartmentID = H01.DepartmentID 
													AND IsNull(H00.TeamID , '') LIKE ISNull(H01.TeamID , '') AND H00.EmployeeID = H01.EmployeeID 
													AND H00.PayrollMethodID = H01.PayrollMethodID AND H00.TranMonth = @TranMonth AND H00.TranYear = @TranYear
								LEFT JOIN HT1403 ON H00.EmployeeID = HT1403.EmployeeID AND H00.DivisionID = HT1403.DivisionID							  
								LEFT join HT1414 ON HT1414.DivisionID = H00.DivisionID AND HT1414.EmployeeID = H00.EmployeeID
												AND	@LastDate BETWEEN ISNULL(HT1414.BeginDate,HT1403.WorkDate) AND Isnull(HT1414.EndDate,@LastDate) 						  							
								WHERE H00.DivisionID = @DivisionID 
								AND (CASE WHEN ISNULL(HT1414.EmployeeMode,'') <> '' THEN  HT1414.EmployeeMode ELSE HT1414.EmployeeStatus END = 'TO') 
								
							END
							ELSE 
							BEGIN
							
								UPDATE	HT3400
								SET		TaxAmount = H01.TaxAmount ,
										TaxRate = H01.TaxRate
								FROM		HT3400 H00 
								INNER JOIN HV5006 H01 ON H00.DivisionID = H01.DivisionID AND H00.DepartmentID = H01.DepartmentID 
													AND IsNull(H00.TeamID , '') LIKE ISNull(H01.TeamID , '') AND H00.EmployeeID = H01.EmployeeID 
													AND H00.PayrollMethodID = H01.PayrollMethodID AND H00.TranMonth = @TranMonth AND H00.TranYear = @TranYear							
								WHERE H00.DivisionID = @DivisionID 

							END
								
                              
                        END		
                     ELSE
                        BEGIN
							IF (@CustomerIndex = 50)
							BEGIN 
						
								UPDATE	HT3400
								SET		TaxAmount = H01.TaxAmount ,
										TaxRate = H01.TaxRate
								FROM		HT3400 H00 
								INNER JOIN HT5888 H01 ON H00.DivisionID = H01.DivisionID AND H00.DepartmentID = H01.DepartmentID 
													AND IsNull(H00.TeamID , '') LIKE ISNull(H01.TeamID , '') AND H00.EmployeeID = H01.EmployeeID 
													AND H00.PayrollMethodID = H01.PayrollMethodID AND H00.TranMonth = @TranMonth AND H00.TranYear = @TranYear
								LEFT JOIN HT1403 ON H00.EmployeeID = HT1403.EmployeeID AND H00.DivisionID = HT1403.DivisionID							  
								LEFT join HT1414 ON HT1414.DivisionID = H00.DivisionID AND HT1414.EmployeeID = H00.EmployeeID
												AND	@LastDate BETWEEN ISNULL(HT1414.BeginDate,HT1403.WorkDate) AND Isnull(HT1414.EndDate,@LastDate) 
								WHERE H00.DivisionID = @DivisionID 
								AND (HT1403.TitleID <> 'OST' AND (CASE WHEN ISNULL(HT1414.EmployeeMode,'') <> '' THEN  HT1414.EmployeeMode ELSE HT1414.EmployeeStatus END <> 'TO') )
							
								--- Công nhân thời vụ thì không trừ thuế
								UPDATE	HT3400
								SET		TaxAmount = 0,
										TaxRate = 0
								FROM		HT3400 H00 
								INNER JOIN HT5888 H01 ON H00.DivisionID = H01.DivisionID AND H00.DepartmentID = H01.DepartmentID 
													AND IsNull(H00.TeamID , '') LIKE ISNull(H01.TeamID , '') AND H00.EmployeeID = H01.EmployeeID 
													AND H00.PayrollMethodID = H01.PayrollMethodID AND H00.TranMonth = @TranMonth AND H00.TranYear = @TranYear
								LEFT JOIN HT1403 ON H00.EmployeeID = HT1403.EmployeeID AND H00.DivisionID = HT1403.DivisionID							  							
								WHERE H00.DivisionID = @DivisionID 
								AND (HT1403.TitleID = 'OST' ) 

								--- Nhân viên có thời gian đào tạo ở nước ngoài thì tính 20%
								UPDATE	HT3400
								SET		TaxAmount = SalaryAmount * 0.2,
										TaxRate = 20
								FROM		HT3400 H00 
								INNER JOIN HT5888 H01 ON H00.DivisionID = H01.DivisionID AND H00.DepartmentID = H01.DepartmentID 
													AND IsNull(H00.TeamID , '') LIKE ISNull(H01.TeamID , '') AND H00.EmployeeID = H01.EmployeeID 
													AND H00.PayrollMethodID = H01.PayrollMethodID AND H00.TranMonth = @TranMonth AND H00.TranYear = @TranYear
								LEFT JOIN HT1403 ON H00.EmployeeID = HT1403.EmployeeID AND H00.DivisionID = HT1403.DivisionID							  
								LEFT join HT1414 ON HT1414.DivisionID = H00.DivisionID AND HT1414.EmployeeID = H00.EmployeeID
												AND	@LastDate BETWEEN ISNULL(HT1414.BeginDate,HT1403.WorkDate) AND Isnull(HT1414.EndDate,@LastDate) 						  							
								WHERE H00.DivisionID = @DivisionID 
								AND (CASE WHEN ISNULL(HT1414.EmployeeMode,'') <> '' THEN  HT1414.EmployeeMode ELSE HT1414.EmployeeStatus END = 'TO') 
								
							END
							ELSE
							BEGIN
                              UPDATE HT3400
                              SET TaxAmount = H01.TaxAmount ,
                                  TaxRate = H01.TaxRate
                              FROM HT3400 H00 
							  INNER JOIN HT5888 H01 ON H00.DivisionID = H01.DivisionID AND H00.DepartmentID = H01.DepartmentID 
									AND IsNull(H00.TeamID , '') = ISNull(H01.TeamID , '') AND H00.EmployeeID = H01.EmployeeID 
									AND H00.PayrollMethodID = H01.PayrollMethodID AND H00.TranMonth = @TranMonth AND H00.TranYear = @TranYear
							  WHERE H00.DivisionID = @DivisionID                                  
							END
                        END

                     FETCH next FROM @cur INTO @TaxObjectID
               END
   END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

