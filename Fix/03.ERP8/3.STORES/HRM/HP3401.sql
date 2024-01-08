IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP3401]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP3401]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



----Created date: 19/09/2005
----purpose: Luu luong khi hieu chinh luong thang 
---- Modified by Bảo Thy on 29/11/2016: Bổ sung lưu I21->I150 (MEIKO)
---- Modified by Bảo Thy on 17/01/2017: BỔ sung I151 -> I200 (MEIKO)
---- EXEC [HP3401] 'MK','A000000','AFN0000','000199',11,2016,1,99,5000000,'PP1'
/**********************************************
** Edited by: [GS] [Cẩm Loan] [02/08/2010]

***********************************************/
---- Modified by Phương Thảo on 05/12/2016: Bổ sung lưu S21->S100 (MEIKO)

CREATE PROCEDURE [dbo].[HP3401] @DivisionID nvarchar(50),
				@DepartmentID nvarchar(50),
				@TeamID nvarchar(50),
				@EmployeeID nvarchar(50),
				@TranMonth int,
				@TranYear int,
				@IsIncome int,	-------0 la SubAmount, 1 la Income, 2 la TaxAmount
				@Orders int,	------thu tu cua Income, SubAmount tren HT3400, vd Income01 co thu tu la 01
				@SalaryAmount decimal(28,8),
				@PayrollMethodID as nvarchar(50)
				
AS
Declare @sSQL nvarchar(4000),
	@cur cursor,
	@DepartmentID1 nvarchar(50),
	@TeamID1 nvarchar(50),	
	@EmployeeID1 nvarchar(50),
	@TransactionID nvarchar(50),
	@CustomerIndex INT
	
SELECT @CustomerIndex = CustomerName From CustomerIndex

Set @cur = Cursor scroll keyset for
	Select  DepartmentID, TeamID, EmployeeID
		 From HT2400
		Where DivisionID  = @DivisionID and
			DepartmentID like @DepartmentID and
			isnull(TeamID, '')  like isnull(@TeamID, '') and
			EmployeeID like @EmployeeID and
			TranMonth = @TranMonth and
			TranYear = @TranYear 
		 	
Open @cur
Fetch next from @cur into @DepartmentID1, @TeamID1, @EmployeeID1
While @@fetch_status = 0
	Begin 
--------------------------- kiểm tra không tồn tại -------------------	
		if not exists(Select Top 1 1 From HT3400 Where DivisionID = @DivisionID and
							DepartmentID = @DepartmentID1 and
							Isnull(TeamID,'')  like IsNull(@TeamID1,'') and
							EmployeeID = @EmployeeID1 and
							TranMonth = @TranMonth and
							TranYear = @TranYear and 
							PayrollMethodID = @PayrollMethodID )		

			BEGIN
				Exec AP0000 @DivisionID,  @TransactionID  OUTPUT, 'HT3400', 'EP', @TranYear ,'',15, 3, 0, '-'

---------	------------------ insert vào HT3400 -------------------
				insert HT3400 (TransactionID, DivisionID, DepartmentID, TeamID, EmployeeID, TranMonth, TranYear, PayrollMethodID) 
					values  (@TransactionID,@DivisionID, @DepartmentID1, @TeamID1, @EmployeeID1, @TranMonth, @TranYear, @PayrollMethodID) 
				
				insert HT3499 (DivisionID, EmployeeID, TranMonth, TranYear) 
				values  (@DivisionID, @EmployeeID1, @TranMonth, @TranYear) 

			
---------	------------------ update vào HT3400 -------------------
				Update  HT3400			
					Set		Income01 = (Case When @Orders =01 then @SalaryAmount Else Income01 end),
							Income02 = (Case When @Orders =02 then @SalaryAmount Else Income02 end),
							Income03 = (Case When @Orders =03 then @SalaryAmount Else Income03 end),
							Income04 = (Case When @Orders =04 then @SalaryAmount Else Income04 end),
							Income05 = (Case When @Orders =05 then @SalaryAmount Else Income05 end),
							Income06 = (Case When @Orders =06 then @SalaryAmount Else Income06 end),
							Income07 = (Case When @Orders =07 then @SalaryAmount Else Income07 end),
							Income08 = (Case When @Orders =08 then @SalaryAmount Else Income08 end),
							Income09= (Case When @Orders =09 then @SalaryAmount Else Income09 end),
							Income10 = (Case When @Orders =10 then @SalaryAmount Else Income10 end),
							Income11 = (Case When @Orders =11 then @SalaryAmount Else Income11 end),
							Income12 = (Case When @Orders =12 then @SalaryAmount Else Income12 end),
							Income13 = (Case When @Orders =13 then @SalaryAmount Else Income13 end),
							Income14 = (Case When @Orders =14 then @SalaryAmount Else Income14 end),
							Income15 = (Case When @Orders =15 then @SalaryAmount Else Income15 end),
							Income16 = (Case When @Orders =16 then @SalaryAmount Else Income16 end),
							Income17 = (Case When @Orders =17 then @SalaryAmount Else Income17 end),
							Income18 = (Case When @Orders =18 then @SalaryAmount Else Income18 end),
							Income19= (Case When @Orders =19 then @SalaryAmount Else Income19 end),
							Income20 = (Case When @Orders =20 then @SalaryAmount Else Income20 end),
							Income21 = (Case When @Orders =21 then @SalaryAmount Else Income21 end),
							Income22 = (Case When @Orders =22 then @SalaryAmount Else Income22 end),
							Income23 = (Case When @Orders =23 then @SalaryAmount Else Income23 end),
							Income24 = (Case When @Orders =24 then @SalaryAmount Else Income24 end),
							Income25 = (Case When @Orders =25 then @SalaryAmount Else Income25 end),
							Income26 = (Case When @Orders =26 then @SalaryAmount Else Income26 end),
							Income27 = (Case When @Orders =27 then @SalaryAmount Else Income27 end),
							Income28 = (Case When @Orders =28 then @SalaryAmount Else Income28 end),
							Income29 = (Case When @Orders =29 then @SalaryAmount Else Income29 end),
							Income30 = (Case When @Orders =30 then @SalaryAmount Else Income30 end)
					Where	DivisionID = @DivisionID and
						TransactionID=@TransactionID and
						DepartmentID = @DepartmentID1 and
						Isnull(TeamID,'')  like IsNull(@TeamID1,'') and
						EmployeeID = @EmployeeID1 and
						TranMonth = @TranMonth and
						TranYear = @TranYear and 			
						PayrollMethodID = @PayrollMethodID and
						@IsIncome = 1
					
				
				Update  HT3499		
				Set		Income31 = (Case When @Orders =31 then @SalaryAmount Else Income31 end),
						Income32 = (Case When @Orders =32 then @SalaryAmount Else Income32 end),
						Income33 = (Case When @Orders =33 then @SalaryAmount Else Income33 end),
						Income34 = (Case When @Orders =34 then @SalaryAmount Else Income34 end),
						Income35 = (Case When @Orders =35 then @SalaryAmount Else Income35 end),
						Income36 = (Case When @Orders =36 then @SalaryAmount Else Income36 end),
						Income37 = (Case When @Orders =37 then @SalaryAmount Else Income37 end),
						Income38 = (Case When @Orders =38 then @SalaryAmount Else Income38 end),
						Income39 = (Case When @Orders =39 then @SalaryAmount Else Income39 end),
						Income40 = (Case When @Orders =40 then @SalaryAmount Else Income40 end),
						Income41 = (Case When @Orders =41 then @SalaryAmount Else Income41 end),
						Income42 = (Case When @Orders =42 then @SalaryAmount Else Income42 end),
						Income43 = (Case When @Orders =43 then @SalaryAmount Else Income43 end),
						Income44 = (Case When @Orders =44 then @SalaryAmount Else Income44 end),
						Income45 = (Case When @Orders =45 then @SalaryAmount Else Income45 end),
						Income46 = (Case When @Orders =46 then @SalaryAmount Else Income46 end),
						Income47 = (Case When @Orders =47 then @SalaryAmount Else Income47 end),
						Income48 = (Case When @Orders =48 then @SalaryAmount Else Income48 end),
						Income49 = (Case When @Orders =49 then @SalaryAmount Else Income49 end),
						Income50 = (Case When @Orders =50 then @SalaryAmount Else Income50 end),
						Income51 = (Case When @Orders =51 then @SalaryAmount Else Income51 end),
						Income52 = (Case When @Orders =52 then @SalaryAmount Else Income52 end),
						Income53 = (Case When @Orders =53 then @SalaryAmount Else Income53 end),
						Income54 = (Case When @Orders =54 then @SalaryAmount Else Income54 end),
						Income55 = (Case When @Orders =55 then @SalaryAmount Else Income55 end),
						Income56 = (Case When @Orders =56 then @SalaryAmount Else Income56 end),
						Income57 = (Case When @Orders =57 then @SalaryAmount Else Income57 end),
						Income58 = (Case When @Orders =58 then @SalaryAmount Else Income58 end),
						Income59 = (Case When @Orders =59 then @SalaryAmount Else Income59 end),
						Income60 = (Case When @Orders =60 then @SalaryAmount Else Income60 end),
						Income61 = (Case When @Orders =61 then @SalaryAmount Else Income61 end),
						Income62 = (Case When @Orders =62 then @SalaryAmount Else Income62 end),
						Income63 = (Case When @Orders =63 then @SalaryAmount Else Income63 end),
						Income64 = (Case When @Orders =64 then @SalaryAmount Else Income64 end),
						Income65 = (Case When @Orders =65 then @SalaryAmount Else Income65 end),
						Income66 = (Case When @Orders =66 then @SalaryAmount Else Income66 end),
						Income67 = (Case When @Orders =67 then @SalaryAmount Else Income67 end),
						Income68 = (Case When @Orders =68 then @SalaryAmount Else Income68 end),
						Income69 = (Case When @Orders =69 then @SalaryAmount Else Income69 end),
						Income70 = (Case When @Orders =70 then @SalaryAmount Else Income70 end),
						Income71 = (Case When @Orders =71 then @SalaryAmount Else Income71 end),
						Income72 = (Case When @Orders =72 then @SalaryAmount Else Income72 end),
						Income73 = (Case When @Orders =73 then @SalaryAmount Else Income73 end),
						Income74 = (Case When @Orders =74 then @SalaryAmount Else Income74 end),
						Income75 = (Case When @Orders =75 then @SalaryAmount Else Income75 end),
						Income76 = (Case When @Orders =76 then @SalaryAmount Else Income76 end),
						Income77 = (Case When @Orders =77 then @SalaryAmount Else Income77 end),
						Income78 = (Case When @Orders =78 then @SalaryAmount Else Income78 end),
						Income79 = (Case When @Orders =79 then @SalaryAmount Else Income79 end),
						Income80 = (Case When @Orders =80 then @SalaryAmount Else Income80 end),
						Income81 = (Case When @Orders =81 then @SalaryAmount Else Income81 end),
						Income82 = (Case When @Orders =82 then @SalaryAmount Else Income82 end),
						Income83 = (Case When @Orders =83 then @SalaryAmount Else Income83 end),
						Income84 = (Case When @Orders =84 then @SalaryAmount Else Income84 end),
						Income85 = (Case When @Orders =85 then @SalaryAmount Else Income85 end),
						Income86 = (Case When @Orders =86 then @SalaryAmount Else Income86 end),
						Income87 = (Case When @Orders =87 then @SalaryAmount Else Income87 end),
						Income88 = (Case When @Orders =88 then @SalaryAmount Else Income88 end),
						Income89 = (Case When @Orders =89 then @SalaryAmount Else Income89 end),
						Income90 = (Case When @Orders =90 then @SalaryAmount Else Income90 end),
						Income91 = (Case When @Orders =91 then @SalaryAmount Else Income91 end),
						Income92 = (Case When @Orders =92 then @SalaryAmount Else Income92 end),
						Income93 = (Case When @Orders =93 then @SalaryAmount Else Income93 end),
						Income94 = (Case When @Orders =94 then @SalaryAmount Else Income94 end),
						Income95 = (Case When @Orders =95 then @SalaryAmount Else Income95 end),
						Income96 = (Case When @Orders =96 then @SalaryAmount Else Income96 end),
						Income97 = (Case When @Orders =97 then @SalaryAmount Else Income97 end),
						Income98 = (Case When @Orders =98 then @SalaryAmount Else Income98 end),
						Income99 = (Case When @Orders =99 then @SalaryAmount Else Income99 end),
						Income100 = (Case When @Orders =100 then @SalaryAmount Else Income100 end),
						Income101 = (Case When @Orders =101 then @SalaryAmount Else Income101 end),
						Income102 = (Case When @Orders =102 then @SalaryAmount Else Income102 end),
						Income103 = (Case When @Orders =103 then @SalaryAmount Else Income103 end),
						Income104 = (Case When @Orders =104 then @SalaryAmount Else Income104 end),
						Income105 = (Case When @Orders =105 then @SalaryAmount Else Income105 end),
						Income106 = (Case When @Orders =106 then @SalaryAmount Else Income106 end),
						Income107 = (Case When @Orders =107 then @SalaryAmount Else Income107 end),
						Income108 = (Case When @Orders =108 then @SalaryAmount Else Income108 end),
						Income109 = (Case When @Orders =109 then @SalaryAmount Else Income109 end),
						Income110 = (Case When @Orders =110 then @SalaryAmount Else Income110 end),
						Income111 = (Case When @Orders =111 then @SalaryAmount Else Income111 end),
						Income112 = (Case When @Orders =112 then @SalaryAmount Else Income112 end),
						Income113 = (Case When @Orders =113 then @SalaryAmount Else Income113 end),
						Income114 = (Case When @Orders =114 then @SalaryAmount Else Income114 end),
						Income115 = (Case When @Orders =115 then @SalaryAmount Else Income115 end),
						Income116 = (Case When @Orders =116 then @SalaryAmount Else Income116 end),
						Income117 = (Case When @Orders =117 then @SalaryAmount Else Income117 end),
						Income118 = (Case When @Orders =118 then @SalaryAmount Else Income118 end),
						Income119 = (Case When @Orders =119 then @SalaryAmount Else Income119 end),
						Income120 = (Case When @Orders =120 then @SalaryAmount Else Income120 end),
						Income121 = (Case When @Orders =121 then @SalaryAmount Else Income121 end),
						Income122 = (Case When @Orders =122 then @SalaryAmount Else Income122 end),
						Income123 = (Case When @Orders =123 then @SalaryAmount Else Income123 end),
						Income124 = (Case When @Orders =124 then @SalaryAmount Else Income124 end),
						Income125 = (Case When @Orders =125 then @SalaryAmount Else Income125 end),
						Income126 = (Case When @Orders =126 then @SalaryAmount Else Income126 end),
						Income127 = (Case When @Orders =127 then @SalaryAmount Else Income127 end),
						Income128 = (Case When @Orders =128 then @SalaryAmount Else Income128 end),
						Income129 = (Case When @Orders =129 then @SalaryAmount Else Income129 end),
						Income130 = (Case When @Orders =130 then @SalaryAmount Else Income130 end),
						Income131 = (Case When @Orders =131 then @SalaryAmount Else Income131 end),
						Income132 = (Case When @Orders =132 then @SalaryAmount Else Income132 end),
						Income133 = (Case When @Orders =133 then @SalaryAmount Else Income133 end),
						Income134 = (Case When @Orders =134 then @SalaryAmount Else Income134 end),
						Income135 = (Case When @Orders =135 then @SalaryAmount Else Income135 end),
						Income136 = (Case When @Orders =136 then @SalaryAmount Else Income136 end),
						Income137 = (Case When @Orders =137 then @SalaryAmount Else Income137 end),
						Income138 = (Case When @Orders =138 then @SalaryAmount Else Income138 end),
						Income139 = (Case When @Orders =139 then @SalaryAmount Else Income139 end),
						Income140 = (Case When @Orders =140 then @SalaryAmount Else Income140 end),
						Income141 = (Case When @Orders =141 then @SalaryAmount Else Income141 end),
						Income142 = (Case When @Orders =142 then @SalaryAmount Else Income142 end),
						Income143 = (Case When @Orders =143 then @SalaryAmount Else Income143 end),
						Income144 = (Case When @Orders =144 then @SalaryAmount Else Income144 end),
						Income145 = (Case When @Orders =145 then @SalaryAmount Else Income145 end),
						Income146 = (Case When @Orders =146 then @SalaryAmount Else Income146 end),
						Income147 = (Case When @Orders =147 then @SalaryAmount Else Income147 end),
						Income148 = (Case When @Orders =148 then @SalaryAmount Else Income148 end),
						Income149 = (Case When @Orders =149 then @SalaryAmount Else Income149 end),
						Income150 = (Case When @Orders =150 then @SalaryAmount Else Income150 end),
						Income151 = (Case When @Orders =151 then @SalaryAmount Else Income151 end),
						Income152 = (Case When @Orders =152 then @SalaryAmount Else Income152 end),
						Income153 = (Case When @Orders =153 then @SalaryAmount Else Income153 end),
						Income154 = (Case When @Orders =154 then @SalaryAmount Else Income154 end),
						Income155 = (Case When @Orders =155 then @SalaryAmount Else Income155 end),
						Income156 = (Case When @Orders =156 then @SalaryAmount Else Income156 end),
						Income157 = (Case When @Orders =157 then @SalaryAmount Else Income157 end),
						Income158 = (Case When @Orders =158 then @SalaryAmount Else Income158 end),
						Income159 = (Case When @Orders =159 then @SalaryAmount Else Income159 end),
						Income160 = (Case When @Orders =160 then @SalaryAmount Else Income160 end),
						Income161 = (Case When @Orders =161 then @SalaryAmount Else Income161 end),
						Income162 = (Case When @Orders =162 then @SalaryAmount Else Income162 end),
						Income163 = (Case When @Orders =163 then @SalaryAmount Else Income163 end),
						Income164 = (Case When @Orders =164 then @SalaryAmount Else Income164 end),
						Income165 = (Case When @Orders =165 then @SalaryAmount Else Income165 end),
						Income166 = (Case When @Orders =166 then @SalaryAmount Else Income166 end),
						Income167 = (Case When @Orders =167 then @SalaryAmount Else Income167 end),
						Income168 = (Case When @Orders =168 then @SalaryAmount Else Income168 end),
						Income169 = (Case When @Orders =169 then @SalaryAmount Else Income169 end),
						Income170 = (Case When @Orders =170 then @SalaryAmount Else Income170 end),
						Income171 = (Case When @Orders =171 then @SalaryAmount Else Income171 end),
						Income172 = (Case When @Orders =172 then @SalaryAmount Else Income172 end),
						Income173 = (Case When @Orders =173 then @SalaryAmount Else Income173 end),
						Income174 = (Case When @Orders =174 then @SalaryAmount Else Income174 end),
						Income175 = (Case When @Orders =175 then @SalaryAmount Else Income175 end),
						Income176 = (Case When @Orders =176 then @SalaryAmount Else Income176 end),
						Income177 = (Case When @Orders =177 then @SalaryAmount Else Income177 end),
						Income178 = (Case When @Orders =178 then @SalaryAmount Else Income178 end),
						Income179 = (Case When @Orders =179 then @SalaryAmount Else Income179 end),
						Income180 = (Case When @Orders =180 then @SalaryAmount Else Income180 end),
						Income181 = (Case When @Orders =181 then @SalaryAmount Else Income181 end),
						Income182 = (Case When @Orders =182 then @SalaryAmount Else Income182 end),
						Income183 = (Case When @Orders =183 then @SalaryAmount Else Income183 end),
						Income184 = (Case When @Orders =184 then @SalaryAmount Else Income184 end),
						Income185 = (Case When @Orders =185 then @SalaryAmount Else Income185 end),
						Income186 = (Case When @Orders =186 then @SalaryAmount Else Income186 end),
						Income187 = (Case When @Orders =187 then @SalaryAmount Else Income187 end),
						Income188 = (Case When @Orders =188 then @SalaryAmount Else Income188 end),
						Income189 = (Case When @Orders =189 then @SalaryAmount Else Income189 end),
						Income190 = (Case When @Orders =190 then @SalaryAmount Else Income190 end),
						Income191 = (Case When @Orders =191 then @SalaryAmount Else Income191 end),
						Income192 = (Case When @Orders =192 then @SalaryAmount Else Income192 end),
						Income193 = (Case When @Orders =193 then @SalaryAmount Else Income193 end),
						Income194 = (Case When @Orders =194 then @SalaryAmount Else Income194 end),
						Income195 = (Case When @Orders =195 then @SalaryAmount Else Income195 end),
						Income196 = (Case When @Orders =196 then @SalaryAmount Else Income196 end),
						Income197 = (Case When @Orders =197 then @SalaryAmount Else Income197 end),
						Income198 = (Case When @Orders =198 then @SalaryAmount Else Income198 end),
						Income199 = (Case When @Orders =199 then @SalaryAmount Else Income199 end),
						Income200 = (Case When @Orders =200 then @SalaryAmount Else Income200 end)
				Where	DivisionID = @DivisionID 
						AND EmployeeID = @EmployeeID1 
						AND TranMonth = @TranMonth 
						AND TransactionID = @TransactionID
						AND TranYear = @TranYear 
						AND @IsIncome = 1
				
---------	------------------ update vào HT3400 -------------------
				Update  HT3400
					Set 	SubAmount01 = (Case When @Orders = 01 then @SalaryAmount Else SubAmount01 end),
						SubAmount02 = (Case When @Orders = 02 then @SalaryAmount Else SubAmount02 end),
						SubAmount03 = (Case When @Orders = 03 then @SalaryAmount Else SubAmount03 end),
						SubAmount04= (Case When @Orders = 04 then @SalaryAmount Else SubAmount04 end),
						SubAmount05 = (Case When @Orders = 05 then @SalaryAmount Else SubAmount05 end),
						SubAmount06 = (Case When @Orders = 06 then @SalaryAmount Else SubAmount06 end),
						SubAmount07 = (Case When @Orders = 07 then @SalaryAmount Else SubAmount07 end),
						SubAmount08 = (Case When @Orders = 08 then @SalaryAmount Else SubAmount08 end),
						SubAmount09= (Case When @Orders = 09 then @SalaryAmount Else SubAmount09 end),
						SubAmount10 = (Case When @Orders = 10 then @SalaryAmount Else SubAmount10 end), 	
						SubAmount11 = (Case When @Orders = 11 then @SalaryAmount Else SubAmount11 end),
						SubAmount12 = (Case When @Orders = 12 then @SalaryAmount Else SubAmount12 end),
						SubAmount13 = (Case When @Orders = 13 then @SalaryAmount Else SubAmount13 end),
						SubAmount14= (Case When @Orders = 14 then @SalaryAmount Else SubAmount14 end),
						SubAmount15 = (Case When @Orders = 15 then @SalaryAmount Else SubAmount15 end),
						SubAmount16 = (Case When @Orders = 16 then @SalaryAmount Else SubAmount16 end),
						SubAmount17 = (Case When @Orders = 17 then @SalaryAmount Else SubAmount17 end),
						SubAmount18 = (Case When @Orders = 18 then @SalaryAmount Else SubAmount18 end),
						SubAmount19= (Case When @Orders = 19 then @SalaryAmount Else SubAmount19 end),
						SubAmount20 = (Case When @Orders = 20 then @SalaryAmount Else SubAmount20 end)

					Where 	DivisionID = @DivisionID and
					TransactionID=@TransactionID and
					DepartmentID = @DepartmentID1 and
					Isnull(TeamID,'')  like IsNull(@TeamID1,'') and
					EmployeeID = @EmployeeID1 and
					TranMonth = @TranMonth and
					TranYear = @TranYear and 			
					PayrollMethodID = @PayrollMethodID and
					@IsIncome = 0
					
						
				Update  HT3499		
				Set		SubAmount21 = (Case When @Orders =21 then @SalaryAmount Else SubAmount21 end),
						SubAmount22 = (Case When @Orders =22 then @SalaryAmount Else SubAmount22 end),
						SubAmount23 = (Case When @Orders =23 then @SalaryAmount Else SubAmount23 end),
						SubAmount24 = (Case When @Orders =24 then @SalaryAmount Else SubAmount24 end),
						SubAmount25 = (Case When @Orders =25 then @SalaryAmount Else SubAmount25 end),
						SubAmount26 = (Case When @Orders =26 then @SalaryAmount Else SubAmount26 end),
						SubAmount27 = (Case When @Orders =27 then @SalaryAmount Else SubAmount27 end),
						SubAmount28 = (Case When @Orders =28 then @SalaryAmount Else SubAmount28 end),
						SubAmount29 = (Case When @Orders =29 then @SalaryAmount Else SubAmount29 end),
						SubAmount30 = (Case When @Orders =30 then @SalaryAmount Else SubAmount30 end),
						SubAmount31 = (Case When @Orders =31 then @SalaryAmount Else SubAmount31 end),
						SubAmount32 = (Case When @Orders =32 then @SalaryAmount Else SubAmount32 end),
						SubAmount33 = (Case When @Orders =33 then @SalaryAmount Else SubAmount33 end),
						SubAmount34 = (Case When @Orders =34 then @SalaryAmount Else SubAmount34 end),
						SubAmount35 = (Case When @Orders =35 then @SalaryAmount Else SubAmount35 end),
						SubAmount36 = (Case When @Orders =36 then @SalaryAmount Else SubAmount36 end),
						SubAmount37 = (Case When @Orders =37 then @SalaryAmount Else SubAmount37 end),
						SubAmount38 = (Case When @Orders =38 then @SalaryAmount Else SubAmount38 end),
						SubAmount39 = (Case When @Orders =39 then @SalaryAmount Else SubAmount39 end),
						SubAmount40 = (Case When @Orders =40 then @SalaryAmount Else SubAmount40 end),
						SubAmount41 = (Case When @Orders =41 then @SalaryAmount Else SubAmount41 end),
						SubAmount42 = (Case When @Orders =42 then @SalaryAmount Else SubAmount42 end),
						SubAmount43 = (Case When @Orders =43 then @SalaryAmount Else SubAmount43 end),
						SubAmount44 = (Case When @Orders =44 then @SalaryAmount Else SubAmount44 end),
						SubAmount45 = (Case When @Orders =45 then @SalaryAmount Else SubAmount45 end),
						SubAmount46 = (Case When @Orders =46 then @SalaryAmount Else SubAmount46 end),
						SubAmount47 = (Case When @Orders =47 then @SalaryAmount Else SubAmount47 end),
						SubAmount48 = (Case When @Orders =48 then @SalaryAmount Else SubAmount48 end),
						SubAmount49 = (Case When @Orders =49 then @SalaryAmount Else SubAmount49 end),
						SubAmount50 = (Case When @Orders =50 then @SalaryAmount Else SubAmount50 end),
						SubAmount51 = (Case When @Orders =51 then @SalaryAmount Else SubAmount51 end),
						SubAmount52 = (Case When @Orders =52 then @SalaryAmount Else SubAmount52 end),
						SubAmount53 = (Case When @Orders =53 then @SalaryAmount Else SubAmount53 end),
						SubAmount54 = (Case When @Orders =54 then @SalaryAmount Else SubAmount54 end),
						SubAmount55 = (Case When @Orders =55 then @SalaryAmount Else SubAmount55 end),
						SubAmount56 = (Case When @Orders =56 then @SalaryAmount Else SubAmount56 end),
						SubAmount57 = (Case When @Orders =57 then @SalaryAmount Else SubAmount57 end),
						SubAmount58 = (Case When @Orders =58 then @SalaryAmount Else SubAmount58 end),
						SubAmount59 = (Case When @Orders =59 then @SalaryAmount Else SubAmount59 end),
						SubAmount60 = (Case When @Orders =60 then @SalaryAmount Else SubAmount60 end),
						SubAmount61 = (Case When @Orders =61 then @SalaryAmount Else SubAmount61 end),
						SubAmount62 = (Case When @Orders =62 then @SalaryAmount Else SubAmount62 end),
						SubAmount63 = (Case When @Orders =63 then @SalaryAmount Else SubAmount63 end),
						SubAmount64 = (Case When @Orders =64 then @SalaryAmount Else SubAmount64 end),
						SubAmount65 = (Case When @Orders =65 then @SalaryAmount Else SubAmount65 end),
						SubAmount66 = (Case When @Orders =66 then @SalaryAmount Else SubAmount66 end),
						SubAmount67 = (Case When @Orders =67 then @SalaryAmount Else SubAmount67 end),
						SubAmount68 = (Case When @Orders =68 then @SalaryAmount Else SubAmount68 end),
						SubAmount69 = (Case When @Orders =69 then @SalaryAmount Else SubAmount69 end),
						SubAmount70 = (Case When @Orders =70 then @SalaryAmount Else SubAmount70 end),
						SubAmount71 = (Case When @Orders =71 then @SalaryAmount Else SubAmount71 end),
						SubAmount72 = (Case When @Orders =72 then @SalaryAmount Else SubAmount72 end),
						SubAmount73 = (Case When @Orders =73 then @SalaryAmount Else SubAmount73 end),
						SubAmount74 = (Case When @Orders =74 then @SalaryAmount Else SubAmount74 end),
						SubAmount75 = (Case When @Orders =75 then @SalaryAmount Else SubAmount75 end),
						SubAmount76 = (Case When @Orders =76 then @SalaryAmount Else SubAmount76 end),
						SubAmount77 = (Case When @Orders =77 then @SalaryAmount Else SubAmount77 end),
						SubAmount78 = (Case When @Orders =78 then @SalaryAmount Else SubAmount78 end),
						SubAmount79 = (Case When @Orders =79 then @SalaryAmount Else SubAmount79 end),
						SubAmount80 = (Case When @Orders =80 then @SalaryAmount Else SubAmount80 end),
						SubAmount81 = (Case When @Orders =81 then @SalaryAmount Else SubAmount81 end),
						SubAmount82 = (Case When @Orders =82 then @SalaryAmount Else SubAmount82 end),
						SubAmount83 = (Case When @Orders =83 then @SalaryAmount Else SubAmount83 end),
						SubAmount84 = (Case When @Orders =84 then @SalaryAmount Else SubAmount84 end),
						SubAmount85 = (Case When @Orders =85 then @SalaryAmount Else SubAmount85 end),
						SubAmount86 = (Case When @Orders =86 then @SalaryAmount Else SubAmount86 end),
						SubAmount87 = (Case When @Orders =87 then @SalaryAmount Else SubAmount87 end),
						SubAmount88 = (Case When @Orders =88 then @SalaryAmount Else SubAmount88 end),
						SubAmount89 = (Case When @Orders =89 then @SalaryAmount Else SubAmount89 end),
						SubAmount90 = (Case When @Orders =90 then @SalaryAmount Else SubAmount90 end),
						SubAmount91 = (Case When @Orders =91 then @SalaryAmount Else SubAmount91 end),
						SubAmount92 = (Case When @Orders =92 then @SalaryAmount Else SubAmount92 end),
						SubAmount93 = (Case When @Orders =93 then @SalaryAmount Else SubAmount93 end),
						SubAmount94 = (Case When @Orders =94 then @SalaryAmount Else SubAmount94 end),
						SubAmount95 = (Case When @Orders =95 then @SalaryAmount Else SubAmount95 end),
						SubAmount96 = (Case When @Orders =96 then @SalaryAmount Else SubAmount96 end),
						SubAmount97 = (Case When @Orders =97 then @SalaryAmount Else SubAmount97 end),
						SubAmount98 = (Case When @Orders =98 then @SalaryAmount Else SubAmount98 end),
						SubAmount99 = (Case When @Orders =99 then @SalaryAmount Else SubAmount99 end),
						SubAmount100 = (Case When @Orders =100 then @SalaryAmount Else SubAmount100 end)							
				Where	DivisionID = @DivisionID 
						AND EmployeeID = @EmployeeID1 
						AND TranMonth = @TranMonth 
						AND TransactionID = @TransactionID
						AND TranYear = @TranYear 
						AND @IsIncome = 1
				
							
---------	------------------ update vào HT3400 -------------------						
				Update  HT3400
						Set 	TaxAmount = @SalaryAmount
						Where 	DivisionID = @DivisionID and
						TransactionID=@TransactionID and
						DepartmentID = @DepartmentID1 and
						Isnull(TeamID,'')  like IsNull(@TeamID1,'') and
						EmployeeID = @EmployeeID1 and
						TranMonth = @TranMonth and
						TranYear = @TranYear and 			
						PayrollMethodID = @PayrollMethodID and
						@IsIncome = 2
		End

--------------------------- if tồn tại -------------------	
		else
		BEGIN
--------------------------- update vào HT3400 -------------------								
			Update  HT3400
	
			Set		Income01 = (Case When @Orders =01 then @SalaryAmount Else Income01 end),
					Income02 = (Case When @Orders =02 then @SalaryAmount Else Income02 end),
					Income03 = (Case When @Orders =03 then @SalaryAmount Else Income03 end),
					Income04 = (Case When @Orders =04 then @SalaryAmount Else Income04 end),
					Income05 = (Case When @Orders =05 then @SalaryAmount Else Income05 end),
					Income06 = (Case When @Orders =06 then @SalaryAmount Else Income06 end),
					Income07 = (Case When @Orders =07 then @SalaryAmount Else Income07 end),
					Income08 = (Case When @Orders =08 then @SalaryAmount Else Income08 end),
					Income09= (Case When @Orders =09 then @SalaryAmount Else Income09 end),
					Income10 = (Case When @Orders =10 then @SalaryAmount Else Income10 end),
					Income11 = (Case When @Orders =11 then @SalaryAmount Else Income11 end),
					Income12 = (Case When @Orders =12 then @SalaryAmount Else Income12 end),
					Income13 = (Case When @Orders =13 then @SalaryAmount Else Income13 end),
					Income14 = (Case When @Orders =14 then @SalaryAmount Else Income14 end),
					Income15 = (Case When @Orders =15 then @SalaryAmount Else Income15 end),
					Income16 = (Case When @Orders =16 then @SalaryAmount Else Income16 end),
					Income17 = (Case When @Orders =17 then @SalaryAmount Else Income17 end),
					Income18 = (Case When @Orders =18 then @SalaryAmount Else Income18 end),
					Income19= (Case When @Orders =19 then @SalaryAmount Else Income19 end),
					Income20 = (Case When @Orders =20 then @SalaryAmount Else Income20 end),
					Income21 = (Case When @Orders =21 then @SalaryAmount Else Income21 end),
					Income22 = (Case When @Orders =22 then @SalaryAmount Else Income22 end),
					Income23 = (Case When @Orders =23 then @SalaryAmount Else Income23 end),
					Income24 = (Case When @Orders =24 then @SalaryAmount Else Income24 end),
					Income25 = (Case When @Orders =25 then @SalaryAmount Else Income25 end),
					Income26 = (Case When @Orders =26 then @SalaryAmount Else Income26 end),
					Income27 = (Case When @Orders =27 then @SalaryAmount Else Income27 end),
					Income28 = (Case When @Orders =28 then @SalaryAmount Else Income28 end),
					Income29 = (Case When @Orders =29 then @SalaryAmount Else Income29 end),
					Income30 = (Case When @Orders =30 then @SalaryAmount Else Income30 end)

			Where	DivisionID = @DivisionID and
				DepartmentID = @DepartmentID1 and
				Isnull(TeamID,'')  like IsNull(@TeamID1,'') and
				EmployeeID = @EmployeeID1 and
				TranMonth = @TranMonth and
				TranYear = @TranYear and 			
				PayrollMethodID = @PayrollMethodID and
				@IsIncome = 1

			
			Update  HT3499		
			Set		Income31 = (Case When @Orders =31 then @SalaryAmount Else Income31 end),
					Income32 = (Case When @Orders =32 then @SalaryAmount Else Income32 end),
					Income33 = (Case When @Orders =33 then @SalaryAmount Else Income33 end),
					Income34 = (Case When @Orders =34 then @SalaryAmount Else Income34 end),
					Income35 = (Case When @Orders =35 then @SalaryAmount Else Income35 end),
					Income36 = (Case When @Orders =36 then @SalaryAmount Else Income36 end),
					Income37 = (Case When @Orders =37 then @SalaryAmount Else Income37 end),
					Income38 = (Case When @Orders =38 then @SalaryAmount Else Income38 end),
					Income39 = (Case When @Orders =39 then @SalaryAmount Else Income39 end),
					Income40 = (Case When @Orders =40 then @SalaryAmount Else Income40 end),
					Income41 = (Case When @Orders =41 then @SalaryAmount Else Income41 end),
					Income42 = (Case When @Orders =42 then @SalaryAmount Else Income42 end),
					Income43 = (Case When @Orders =43 then @SalaryAmount Else Income43 end),
					Income44 = (Case When @Orders =44 then @SalaryAmount Else Income44 end),
					Income45 = (Case When @Orders =45 then @SalaryAmount Else Income45 end),
					Income46 = (Case When @Orders =46 then @SalaryAmount Else Income46 end),
					Income47 = (Case When @Orders =47 then @SalaryAmount Else Income47 end),
					Income48 = (Case When @Orders =48 then @SalaryAmount Else Income48 end),
					Income49 = (Case When @Orders =49 then @SalaryAmount Else Income49 end),
					Income50 = (Case When @Orders =50 then @SalaryAmount Else Income50 end),
					Income51 = (Case When @Orders =51 then @SalaryAmount Else Income51 end),
					Income52 = (Case When @Orders =52 then @SalaryAmount Else Income52 end),
					Income53 = (Case When @Orders =53 then @SalaryAmount Else Income53 end),
					Income54 = (Case When @Orders =54 then @SalaryAmount Else Income54 end),
					Income55 = (Case When @Orders =55 then @SalaryAmount Else Income55 end),
					Income56 = (Case When @Orders =56 then @SalaryAmount Else Income56 end),
					Income57 = (Case When @Orders =57 then @SalaryAmount Else Income57 end),
					Income58 = (Case When @Orders =58 then @SalaryAmount Else Income58 end),
					Income59 = (Case When @Orders =59 then @SalaryAmount Else Income59 end),
					Income60 = (Case When @Orders =60 then @SalaryAmount Else Income60 end),
					Income61 = (Case When @Orders =61 then @SalaryAmount Else Income61 end),
					Income62 = (Case When @Orders =62 then @SalaryAmount Else Income62 end),
					Income63 = (Case When @Orders =63 then @SalaryAmount Else Income63 end),
					Income64 = (Case When @Orders =64 then @SalaryAmount Else Income64 end),
					Income65 = (Case When @Orders =65 then @SalaryAmount Else Income65 end),
					Income66 = (Case When @Orders =66 then @SalaryAmount Else Income66 end),
					Income67 = (Case When @Orders =67 then @SalaryAmount Else Income67 end),
					Income68 = (Case When @Orders =68 then @SalaryAmount Else Income68 end),
					Income69 = (Case When @Orders =69 then @SalaryAmount Else Income69 end),
					Income70 = (Case When @Orders =70 then @SalaryAmount Else Income70 end),
					Income71 = (Case When @Orders =71 then @SalaryAmount Else Income71 end),
					Income72 = (Case When @Orders =72 then @SalaryAmount Else Income72 end),
					Income73 = (Case When @Orders =73 then @SalaryAmount Else Income73 end),
					Income74 = (Case When @Orders =74 then @SalaryAmount Else Income74 end),
					Income75 = (Case When @Orders =75 then @SalaryAmount Else Income75 end),
					Income76 = (Case When @Orders =76 then @SalaryAmount Else Income76 end),
					Income77 = (Case When @Orders =77 then @SalaryAmount Else Income77 end),
					Income78 = (Case When @Orders =78 then @SalaryAmount Else Income78 end),
					Income79 = (Case When @Orders =79 then @SalaryAmount Else Income79 end),
					Income80 = (Case When @Orders =80 then @SalaryAmount Else Income80 end),
					Income81 = (Case When @Orders =81 then @SalaryAmount Else Income81 end),
					Income82 = (Case When @Orders =82 then @SalaryAmount Else Income82 end),
					Income83 = (Case When @Orders =83 then @SalaryAmount Else Income83 end),
					Income84 = (Case When @Orders =84 then @SalaryAmount Else Income84 end),
					Income85 = (Case When @Orders =85 then @SalaryAmount Else Income85 end),
					Income86 = (Case When @Orders =86 then @SalaryAmount Else Income86 end),
					Income87 = (Case When @Orders =87 then @SalaryAmount Else Income87 end),
					Income88 = (Case When @Orders =88 then @SalaryAmount Else Income88 end),
					Income89 = (Case When @Orders =89 then @SalaryAmount Else Income89 end),
					Income90 = (Case When @Orders =90 then @SalaryAmount Else Income90 end),
					Income91 = (Case When @Orders =91 then @SalaryAmount Else Income91 end),
					Income92 = (Case When @Orders =92 then @SalaryAmount Else Income92 end),
					Income93 = (Case When @Orders =93 then @SalaryAmount Else Income93 end),
					Income94 = (Case When @Orders =94 then @SalaryAmount Else Income94 end),
					Income95 = (Case When @Orders =95 then @SalaryAmount Else Income95 end),
					Income96 = (Case When @Orders =96 then @SalaryAmount Else Income96 end),
					Income97 = (Case When @Orders =97 then @SalaryAmount Else Income97 end),
					Income98 = (Case When @Orders =98 then @SalaryAmount Else Income98 end),
					Income99 = (Case When @Orders =99 then @SalaryAmount Else Income99 end),
					Income100 = (Case When @Orders =100 then @SalaryAmount Else Income100 end),
					Income101 = (Case When @Orders =101 then @SalaryAmount Else Income101 end),
					Income102 = (Case When @Orders =102 then @SalaryAmount Else Income102 end),
					Income103 = (Case When @Orders =103 then @SalaryAmount Else Income103 end),
					Income104 = (Case When @Orders =104 then @SalaryAmount Else Income104 end),
					Income105 = (Case When @Orders =105 then @SalaryAmount Else Income105 end),
					Income106 = (Case When @Orders =106 then @SalaryAmount Else Income106 end),
					Income107 = (Case When @Orders =107 then @SalaryAmount Else Income107 end),
					Income108 = (Case When @Orders =108 then @SalaryAmount Else Income108 end),
					Income109 = (Case When @Orders =109 then @SalaryAmount Else Income109 end),
					Income110 = (Case When @Orders =110 then @SalaryAmount Else Income110 end),
					Income111 = (Case When @Orders =111 then @SalaryAmount Else Income111 end),
					Income112 = (Case When @Orders =112 then @SalaryAmount Else Income112 end),
					Income113 = (Case When @Orders =113 then @SalaryAmount Else Income113 end),
					Income114 = (Case When @Orders =114 then @SalaryAmount Else Income114 end),
					Income115 = (Case When @Orders =115 then @SalaryAmount Else Income115 end),
					Income116 = (Case When @Orders =116 then @SalaryAmount Else Income116 end),
					Income117 = (Case When @Orders =117 then @SalaryAmount Else Income117 end),
					Income118 = (Case When @Orders =118 then @SalaryAmount Else Income118 end),
					Income119 = (Case When @Orders =119 then @SalaryAmount Else Income119 end),
					Income120 = (Case When @Orders =120 then @SalaryAmount Else Income120 end),
					Income121 = (Case When @Orders =121 then @SalaryAmount Else Income121 end),
					Income122 = (Case When @Orders =122 then @SalaryAmount Else Income122 end),
					Income123 = (Case When @Orders =123 then @SalaryAmount Else Income123 end),
					Income124 = (Case When @Orders =124 then @SalaryAmount Else Income124 end),
					Income125 = (Case When @Orders =125 then @SalaryAmount Else Income125 end),
					Income126 = (Case When @Orders =126 then @SalaryAmount Else Income126 end),
					Income127 = (Case When @Orders =127 then @SalaryAmount Else Income127 end),
					Income128 = (Case When @Orders =128 then @SalaryAmount Else Income128 end),
					Income129 = (Case When @Orders =129 then @SalaryAmount Else Income129 end),
					Income130 = (Case When @Orders =130 then @SalaryAmount Else Income130 end),
					Income131 = (Case When @Orders =131 then @SalaryAmount Else Income131 end),
					Income132 = (Case When @Orders =132 then @SalaryAmount Else Income132 end),
					Income133 = (Case When @Orders =133 then @SalaryAmount Else Income133 end),
					Income134 = (Case When @Orders =134 then @SalaryAmount Else Income134 end),
					Income135 = (Case When @Orders =135 then @SalaryAmount Else Income135 end),
					Income136 = (Case When @Orders =136 then @SalaryAmount Else Income136 end),
					Income137 = (Case When @Orders =137 then @SalaryAmount Else Income137 end),
					Income138 = (Case When @Orders =138 then @SalaryAmount Else Income138 end),
					Income139 = (Case When @Orders =139 then @SalaryAmount Else Income139 end),
					Income140 = (Case When @Orders =140 then @SalaryAmount Else Income140 end),
					Income141 = (Case When @Orders =141 then @SalaryAmount Else Income141 end),
					Income142 = (Case When @Orders =142 then @SalaryAmount Else Income142 end),
					Income143 = (Case When @Orders =143 then @SalaryAmount Else Income143 end),
					Income144 = (Case When @Orders =144 then @SalaryAmount Else Income144 end),
					Income145 = (Case When @Orders =145 then @SalaryAmount Else Income145 end),
					Income146 = (Case When @Orders =146 then @SalaryAmount Else Income146 end),
					Income147 = (Case When @Orders =147 then @SalaryAmount Else Income147 end),
					Income148 = (Case When @Orders =148 then @SalaryAmount Else Income148 end),
					Income149 = (Case When @Orders =149 then @SalaryAmount Else Income149 end),
					Income150 = (Case When @Orders =150 then @SalaryAmount Else Income150 end),
					Income151 = (Case When @Orders =151 then @SalaryAmount Else Income151 end),
					Income152 = (Case When @Orders =152 then @SalaryAmount Else Income152 end),
					Income153 = (Case When @Orders =153 then @SalaryAmount Else Income153 end),
					Income154 = (Case When @Orders =154 then @SalaryAmount Else Income154 end),
					Income155 = (Case When @Orders =155 then @SalaryAmount Else Income155 end),
					Income156 = (Case When @Orders =156 then @SalaryAmount Else Income156 end),
					Income157 = (Case When @Orders =157 then @SalaryAmount Else Income157 end),
					Income158 = (Case When @Orders =158 then @SalaryAmount Else Income158 end),
					Income159 = (Case When @Orders =159 then @SalaryAmount Else Income159 end),
					Income160 = (Case When @Orders =160 then @SalaryAmount Else Income160 end),
					Income161 = (Case When @Orders =161 then @SalaryAmount Else Income161 end),
					Income162 = (Case When @Orders =162 then @SalaryAmount Else Income162 end),
					Income163 = (Case When @Orders =163 then @SalaryAmount Else Income163 end),
					Income164 = (Case When @Orders =164 then @SalaryAmount Else Income164 end),
					Income165 = (Case When @Orders =165 then @SalaryAmount Else Income165 end),
					Income166 = (Case When @Orders =166 then @SalaryAmount Else Income166 end),
					Income167 = (Case When @Orders =167 then @SalaryAmount Else Income167 end),
					Income168 = (Case When @Orders =168 then @SalaryAmount Else Income168 end),
					Income169 = (Case When @Orders =169 then @SalaryAmount Else Income169 end),
					Income170 = (Case When @Orders =170 then @SalaryAmount Else Income170 end),
					Income171 = (Case When @Orders =171 then @SalaryAmount Else Income171 end),
					Income172 = (Case When @Orders =172 then @SalaryAmount Else Income172 end),
					Income173 = (Case When @Orders =173 then @SalaryAmount Else Income173 end),
					Income174 = (Case When @Orders =174 then @SalaryAmount Else Income174 end),
					Income175 = (Case When @Orders =175 then @SalaryAmount Else Income175 end),
					Income176 = (Case When @Orders =176 then @SalaryAmount Else Income176 end),
					Income177 = (Case When @Orders =177 then @SalaryAmount Else Income177 end),
					Income178 = (Case When @Orders =178 then @SalaryAmount Else Income178 end),
					Income179 = (Case When @Orders =179 then @SalaryAmount Else Income179 end),
					Income180 = (Case When @Orders =180 then @SalaryAmount Else Income180 end),
					Income181 = (Case When @Orders =181 then @SalaryAmount Else Income181 end),
					Income182 = (Case When @Orders =182 then @SalaryAmount Else Income182 end),
					Income183 = (Case When @Orders =183 then @SalaryAmount Else Income183 end),
					Income184 = (Case When @Orders =184 then @SalaryAmount Else Income184 end),
					Income185 = (Case When @Orders =185 then @SalaryAmount Else Income185 end),
					Income186 = (Case When @Orders =186 then @SalaryAmount Else Income186 end),
					Income187 = (Case When @Orders =187 then @SalaryAmount Else Income187 end),
					Income188 = (Case When @Orders =188 then @SalaryAmount Else Income188 end),
					Income189 = (Case When @Orders =189 then @SalaryAmount Else Income189 end),
					Income190 = (Case When @Orders =190 then @SalaryAmount Else Income190 end),
					Income191 = (Case When @Orders =191 then @SalaryAmount Else Income191 end),
					Income192 = (Case When @Orders =192 then @SalaryAmount Else Income192 end),
					Income193 = (Case When @Orders =193 then @SalaryAmount Else Income193 end),
					Income194 = (Case When @Orders =194 then @SalaryAmount Else Income194 end),
					Income195 = (Case When @Orders =195 then @SalaryAmount Else Income195 end),
					Income196 = (Case When @Orders =196 then @SalaryAmount Else Income196 end),
					Income197 = (Case When @Orders =197 then @SalaryAmount Else Income197 end),
					Income198 = (Case When @Orders =198 then @SalaryAmount Else Income198 end),
					Income199 = (Case When @Orders =199 then @SalaryAmount Else Income199 end),
					Income200 = (Case When @Orders =200 then @SalaryAmount Else Income200 end)
			Where	DivisionID = @DivisionID 
					AND TransactionID = @TransactionID
					AND EmployeeID = @EmployeeID1 
					AND TranMonth = @TranMonth 
					AND TranYear = @TranYear 
					AND @IsIncome = 1
			
--------------------------- update vào HT3400 -------------------						
			Update  HT3400
				Set 	SubAmount01 = (Case When @Orders = 01 then @SalaryAmount Else SubAmount01 end),
					SubAmount02 = (Case When @Orders = 02 then @SalaryAmount Else SubAmount02 end),
					SubAmount03 = (Case When @Orders = 03 then @SalaryAmount Else SubAmount03 end),
					SubAmount04= (Case When @Orders = 04 then @SalaryAmount Else SubAmount04 end),
					SubAmount05 = (Case When @Orders = 05 then @SalaryAmount Else SubAmount05 end),
					SubAmount06 = (Case When @Orders = 06 then @SalaryAmount Else SubAmount06 end),
					SubAmount07 = (Case When @Orders = 07 then @SalaryAmount Else SubAmount07 end),
					SubAmount08 = (Case When @Orders = 08 then @SalaryAmount Else SubAmount08 end),
					SubAmount09= (Case When @Orders = 09 then @SalaryAmount Else SubAmount09 end),
					SubAmount10 = (Case When @Orders = 10 then @SalaryAmount Else SubAmount10 end), 	
					SubAmount11 = (Case When @Orders = 11 then @SalaryAmount Else SubAmount11 end),
					SubAmount12 = (Case When @Orders = 12 then @SalaryAmount Else SubAmount12 end),
					SubAmount13 = (Case When @Orders = 13 then @SalaryAmount Else SubAmount13 end),
					SubAmount14= (Case When @Orders = 14 then @SalaryAmount Else SubAmount14 end),
					SubAmount15 = (Case When @Orders = 15 then @SalaryAmount Else SubAmount15 end),
					SubAmount16 = (Case When @Orders = 16 then @SalaryAmount Else SubAmount16 end),
					SubAmount17 = (Case When @Orders = 17 then @SalaryAmount Else SubAmount17 end),
					SubAmount18 = (Case When @Orders = 18 then @SalaryAmount Else SubAmount18 end),
					SubAmount19= (Case When @Orders = 19 then @SalaryAmount Else SubAmount19 end),
					SubAmount20 = (Case When @Orders = 20 then @SalaryAmount Else SubAmount20 end)

				Where 	DivisionID = @DivisionID and
				DepartmentID = @DepartmentID1 and
				Isnull(TeamID,'')  like IsNull(@TeamID1,'') and
				EmployeeID = @EmployeeID1 and
				TranMonth = @TranMonth and
				TranYear = @TranYear and 			
				PayrollMethodID = @PayrollMethodID and
				@IsIncome = 0
		
			Update  HT3499		
			Set		SubAmount21 = (Case When @Orders =21 then @SalaryAmount Else SubAmount21 end),
					SubAmount22 = (Case When @Orders =22 then @SalaryAmount Else SubAmount22 end),
					SubAmount23 = (Case When @Orders =23 then @SalaryAmount Else SubAmount23 end),
					SubAmount24 = (Case When @Orders =24 then @SalaryAmount Else SubAmount24 end),
					SubAmount25 = (Case When @Orders =25 then @SalaryAmount Else SubAmount25 end),
					SubAmount26 = (Case When @Orders =26 then @SalaryAmount Else SubAmount26 end),
					SubAmount27 = (Case When @Orders =27 then @SalaryAmount Else SubAmount27 end),
					SubAmount28 = (Case When @Orders =28 then @SalaryAmount Else SubAmount28 end),
					SubAmount29 = (Case When @Orders =29 then @SalaryAmount Else SubAmount29 end),
					SubAmount30 = (Case When @Orders =30 then @SalaryAmount Else SubAmount30 end),
					SubAmount31 = (Case When @Orders =31 then @SalaryAmount Else SubAmount31 end),
					SubAmount32 = (Case When @Orders =32 then @SalaryAmount Else SubAmount32 end),
					SubAmount33 = (Case When @Orders =33 then @SalaryAmount Else SubAmount33 end),
					SubAmount34 = (Case When @Orders =34 then @SalaryAmount Else SubAmount34 end),
					SubAmount35 = (Case When @Orders =35 then @SalaryAmount Else SubAmount35 end),
					SubAmount36 = (Case When @Orders =36 then @SalaryAmount Else SubAmount36 end),
					SubAmount37 = (Case When @Orders =37 then @SalaryAmount Else SubAmount37 end),
					SubAmount38 = (Case When @Orders =38 then @SalaryAmount Else SubAmount38 end),
					SubAmount39 = (Case When @Orders =39 then @SalaryAmount Else SubAmount39 end),
					SubAmount40 = (Case When @Orders =40 then @SalaryAmount Else SubAmount40 end),
					SubAmount41 = (Case When @Orders =41 then @SalaryAmount Else SubAmount41 end),
					SubAmount42 = (Case When @Orders =42 then @SalaryAmount Else SubAmount42 end),
					SubAmount43 = (Case When @Orders =43 then @SalaryAmount Else SubAmount43 end),
					SubAmount44 = (Case When @Orders =44 then @SalaryAmount Else SubAmount44 end),
					SubAmount45 = (Case When @Orders =45 then @SalaryAmount Else SubAmount45 end),
					SubAmount46 = (Case When @Orders =46 then @SalaryAmount Else SubAmount46 end),
					SubAmount47 = (Case When @Orders =47 then @SalaryAmount Else SubAmount47 end),
					SubAmount48 = (Case When @Orders =48 then @SalaryAmount Else SubAmount48 end),
					SubAmount49 = (Case When @Orders =49 then @SalaryAmount Else SubAmount49 end),
					SubAmount50 = (Case When @Orders =50 then @SalaryAmount Else SubAmount50 end),
					SubAmount51 = (Case When @Orders =51 then @SalaryAmount Else SubAmount51 end),
					SubAmount52 = (Case When @Orders =52 then @SalaryAmount Else SubAmount52 end),
					SubAmount53 = (Case When @Orders =53 then @SalaryAmount Else SubAmount53 end),
					SubAmount54 = (Case When @Orders =54 then @SalaryAmount Else SubAmount54 end),
					SubAmount55 = (Case When @Orders =55 then @SalaryAmount Else SubAmount55 end),
					SubAmount56 = (Case When @Orders =56 then @SalaryAmount Else SubAmount56 end),
					SubAmount57 = (Case When @Orders =57 then @SalaryAmount Else SubAmount57 end),
					SubAmount58 = (Case When @Orders =58 then @SalaryAmount Else SubAmount58 end),
					SubAmount59 = (Case When @Orders =59 then @SalaryAmount Else SubAmount59 end),
					SubAmount60 = (Case When @Orders =60 then @SalaryAmount Else SubAmount60 end),
					SubAmount61 = (Case When @Orders =61 then @SalaryAmount Else SubAmount61 end),
					SubAmount62 = (Case When @Orders =62 then @SalaryAmount Else SubAmount62 end),
					SubAmount63 = (Case When @Orders =63 then @SalaryAmount Else SubAmount63 end),
					SubAmount64 = (Case When @Orders =64 then @SalaryAmount Else SubAmount64 end),
					SubAmount65 = (Case When @Orders =65 then @SalaryAmount Else SubAmount65 end),
					SubAmount66 = (Case When @Orders =66 then @SalaryAmount Else SubAmount66 end),
					SubAmount67 = (Case When @Orders =67 then @SalaryAmount Else SubAmount67 end),
					SubAmount68 = (Case When @Orders =68 then @SalaryAmount Else SubAmount68 end),
					SubAmount69 = (Case When @Orders =69 then @SalaryAmount Else SubAmount69 end),
					SubAmount70 = (Case When @Orders =70 then @SalaryAmount Else SubAmount70 end),
					SubAmount71 = (Case When @Orders =71 then @SalaryAmount Else SubAmount71 end),
					SubAmount72 = (Case When @Orders =72 then @SalaryAmount Else SubAmount72 end),
					SubAmount73 = (Case When @Orders =73 then @SalaryAmount Else SubAmount73 end),
					SubAmount74 = (Case When @Orders =74 then @SalaryAmount Else SubAmount74 end),
					SubAmount75 = (Case When @Orders =75 then @SalaryAmount Else SubAmount75 end),
					SubAmount76 = (Case When @Orders =76 then @SalaryAmount Else SubAmount76 end),
					SubAmount77 = (Case When @Orders =77 then @SalaryAmount Else SubAmount77 end),
					SubAmount78 = (Case When @Orders =78 then @SalaryAmount Else SubAmount78 end),
					SubAmount79 = (Case When @Orders =79 then @SalaryAmount Else SubAmount79 end),
					SubAmount80 = (Case When @Orders =80 then @SalaryAmount Else SubAmount80 end),
					SubAmount81 = (Case When @Orders =81 then @SalaryAmount Else SubAmount81 end),
					SubAmount82 = (Case When @Orders =82 then @SalaryAmount Else SubAmount82 end),
					SubAmount83 = (Case When @Orders =83 then @SalaryAmount Else SubAmount83 end),
					SubAmount84 = (Case When @Orders =84 then @SalaryAmount Else SubAmount84 end),
					SubAmount85 = (Case When @Orders =85 then @SalaryAmount Else SubAmount85 end),
					SubAmount86 = (Case When @Orders =86 then @SalaryAmount Else SubAmount86 end),
					SubAmount87 = (Case When @Orders =87 then @SalaryAmount Else SubAmount87 end),
					SubAmount88 = (Case When @Orders =88 then @SalaryAmount Else SubAmount88 end),
					SubAmount89 = (Case When @Orders =89 then @SalaryAmount Else SubAmount89 end),
					SubAmount90 = (Case When @Orders =90 then @SalaryAmount Else SubAmount90 end),
					SubAmount91 = (Case When @Orders =91 then @SalaryAmount Else SubAmount91 end),
					SubAmount92 = (Case When @Orders =92 then @SalaryAmount Else SubAmount92 end),
					SubAmount93 = (Case When @Orders =93 then @SalaryAmount Else SubAmount93 end),
					SubAmount94 = (Case When @Orders =94 then @SalaryAmount Else SubAmount94 end),
					SubAmount95 = (Case When @Orders =95 then @SalaryAmount Else SubAmount95 end),
					SubAmount96 = (Case When @Orders =96 then @SalaryAmount Else SubAmount96 end),
					SubAmount97 = (Case When @Orders =97 then @SalaryAmount Else SubAmount97 end),
					SubAmount98 = (Case When @Orders =98 then @SalaryAmount Else SubAmount98 end),
					SubAmount99 = (Case When @Orders =99 then @SalaryAmount Else SubAmount99 end),
					SubAmount100 = (Case When @Orders =100 then @SalaryAmount Else SubAmount100 end)						
			Where	DivisionID = @DivisionID 
					AND TransactionID = @TransactionID
					AND EmployeeID = @EmployeeID1 
					AND TranMonth = @TranMonth 
					AND TranYear = @TranYear 
					AND @IsIncome = 1
			
--------------------------- update vào HT3400 -------------------										
		Update  HT3400
				Set 	TaxAmount = @SalaryAmount
				Where 	DivisionID = @DivisionID and
				DepartmentID = @DepartmentID1 and
				Isnull(TeamID,'')  like IsNull(@TeamID1,'') and
				EmployeeID = @EmployeeID1 and
				TranMonth = @TranMonth and
				TranYear = @TranYear and 			
				PayrollMethodID = @PayrollMethodID and
				@IsIncome = 2
		END
Fetch next from @cur into @DepartmentID1, @TeamID1, @EmployeeID1
End
Close @cur

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
