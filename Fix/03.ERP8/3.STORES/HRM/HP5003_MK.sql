IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[HP5003_MK]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[HP5003_MK]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


----Created by Nguyen Van Nhan, Date 29/04/200
----Purpose: Tinh Ngay cong cho nhan vien (tong hop Ngay cong cho nhan vien)
----Edited by:Vo Thanh Huong, date 01/07/2004
----Edit by: Dang Le Bao Quynh, Date 31/07/2007
----Purpose: Sua lai cach tinh ngay cong tong hop theo phuong phap luong 2 ky
----- Edit by: Dang Le Bao Quynh; Date: 27/03/2013: Bo sung tinh cong tong hop theo cong trinh
/********************************************
'* Edited by: [GS] [Minh Lâm] [02/08/2010]
'********************************************/
---- Modified on 25/07/2013 by Lê Thị Thu Hiền : Bổ sung điều kiện HT5006 Các khoản giảm trừ
---- Modified on 25/08/2013 by Bảo Anh : Nếu có thiết lập điều kiện trong loại công ngày thì AbsentAmount không cần chia số giờ làm việc (Hưng Vượng)
---- Modified on 14/11/2013 by Lê Thị Thu Hiền : Bổ sung thêm customize cho cảng sài gòn
---- Modified on 14/11/2013 by Bảo Anh : Nếu tính lương công trình và không có chấm công tháng thì lấy ngày công từ chấm công theo công trình (Unicare)
---- Modified on 21/11/2013 by Lê Thị Thu Hiền : Chỉnh sửa AND HT2400.IsPiecework = 1 	
---- Modified on 24/08/2015 by Nguyen Thanh Thịnh : Xóa phần Nhân Hệ Số công tháng Vào
---- Modified on 27/04/2017 by Phương Thảo: Chỉnh sửa lại cho meiko phần tính công tổng hợp
---- Modified on 17/07/2017 by Phuong Thao: Bổ sung where thêm điều kiện EmployeeID (dùng cho màn hình tra cứu lương)
-- <Example> HP5003_MK 'UN',10,2013,'LCT2013','CPC','CN','%'
---- 

CREATE PROCEDURE [dbo].[HP5003_MK]
       @DivisionID nvarchar(50) ,
       @TranMonth int ,
       @TranYear int ,
       @PayrollMethodID nvarchar(50) ,
       @GeneralAbsentID nvarchar(50) ,
       @DepartmentID1 AS nvarchar(50) ,
       @TeamID1 AS nvarchar(50),
	   @EmployeeID AS nvarchar(50) = '%'
AS
DECLARE
        @Type AS tinyint ,
        @Days AS decimal(28,8) ,
        @sSQLSELECT AS nvarchar(4000) ,
        @sSQLFrom AS nvarchar(4000) ,
        @sSQLWhere AS nvarchar(4000) ,
        @IsMonth AS tinyint ,
        @TimeConvert AS decimal(28,8) ,
        @FromDate AS int ,
        @ToDate AS int ,
        @PeriodID nvarchar(50)
        
----------->>>> Kiem tra customize cho CSG
Declare @AP4444 Table(CustomerName Int, Export Int)
Declare @CustomerName AS Int
Insert Into @AP4444(CustomerName,Export) EXEC('AP4444')
Select @CustomerName=CustomerName From @AP4444
-----------<<<< Kiem tra customize cho CSG

------------>>>>  Lọc nhân viên lương khoán hay lương sản phẩm
DECLARE @sWhere AS NVARCHAR(MAX),
		@sWhere1 AS NVARCHAR(MAX)
SET @sWhere = ''
SET @sWhere1 = ''
IF @CustomerName = 19 --- Cảng sài gòn
	BEGIN
	IF @PayrollMethodID LIKE 'PPLKH%' --- Nếu là lương khoán chỉ hiển thị những người được check lương khoán
		BEGIN
			SET @sWhere = N' AND EmployeeID IN ( SELECT EmployeeID FROM HT2400 
			                                     WHERE	DivisionID = '''+@DivisionID + '''
														AND TranMonth = '+STR(@TranMonth)+'
														AND TranYear = '+STR(@TranYear) +' 
														AND IsJobWage = 1 )'
			SET @sWhere1 = N' AND HT2400.IsJobWage = 1 '  			
		END

	IF @PayrollMethodID LIKE 'PPLSP%' --- Nếu là lương sản phẩm chỉ hiển thị những người được check lương sản phẩm
		BEGIN
		SET @sWhere = N' AND EmployeeID IN ( SELECT EmployeeID FROM HT2400 
		                                     WHERE	DivisionID = '''+@DivisionID + '''
														AND TranMonth = '+STR(@TranMonth)+'
														AND TranYear = '+STR(@TranYear) +'
														AND IsPiecework = 1 ) '
		SET @sWhere1 = N' AND HT2400.IsPiecework = 1 '		
		END
 
	END
------------<<<<<  Lọc nhân viên lương khoán hay lương sản phẩm

	
SELECT  @PeriodID = PeriodID
FROM    HT5002
WHERE   GeneralAbsentID = @GeneralAbsentID AND DivisionID = @DivisionID

SELECT	@TimeConvert = TimeConvert
FROM    HT0000

SELECT	@Type = Type ,
		@Days = Days ,
		@IsMonth = IsMonth ,
		@FromDate = FromDate ,
		@ToDate = ToDate
FROM    HT5002 
WHERE	GeneralAbsentID = @GeneralAbsentID 
		AND DivisionID = @DivisionID
		
--    SELECT * from HT5002
--WHERE
--    GeneralAbsentID = @GeneralAbsentID AND DivisionID = @DivisionID

--SELECT * FROM HT5005
--SELECT * FROM HT5006

SET @Type = ISNULL(@Type , 0)
SET @Days = ISNULL(@Days , 24)

IF 'P06' <> (SELECT TOP 1 MethodID From HT5005 Where DivisionID = @DivisionID AND GeneralAbsentID = @GeneralAbsentID AND PayrollMethodID = @PayrollMethodID ) --- Các khoản thu nhập
		OR 'P06' <> (SELECT TOP 1 MethodID From HT5006 Where DivisionID = @DivisionID AND GeneralAbsentID = @GeneralAbsentID AND PayrollMethodID = @PayrollMethodID ) --- Các khoản giảm trừ

BEGIN
	--Edit by: Dang Le Bao Quynh viet gon lai dieu kien re nhanh
IF @IsMonth = 1
BEGIN
	IF @Type = 0 --- Luong công nhat
	BEGIN
		--- Nếu tính lương công trình và không có chấm công tháng thì lấy dữ liệu thì từ chấm công theo công trình
		IF (SELECT TOP 1 1 From HT5005 Where DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID And MethodID = 'P06') = 1
			AND (Select COUNT(*) FROM HT2402 Where DivisionID = @DivisionID And TranMonth = @TranMonth And TranYear = @TranYear) = 0
			BEGIN
				SET @sSQLSELECT = '
				SELECT 	ProjectID,TranMonth,TranYear,EmployeeID,
						Sum(AbsentAmount*HT1013.ConvertUnit/CASE WHEN HT1013.UnitID = ''' + 'H''' + ' THEN ' + STR(@TimeConvert) + '  ELSE 1 END ) as AbsentAmount, 
						HT2402.DivisionID,	DepartmentID,	ISNULL(TeamID,'''') as TeamID '
				SET @sSQLFrom = ' 
				FROM		HT2432 HT2402  
				INNER JOIN	HT1013 
					ON		HT2402.AbsentTypeID = HT1013.AbsentTypeID 
							AND HT2402.DivisionID = HT1013.DivisionID '
				SET @sSQLWhere = ' 
				WHERE	DepartmentID in (SELECT	DepartmentID 
										FROM	HT5004 
										WHERE 	DivisionID =''' + @DivisionID + ''' and										
												PayrollMethodID = ''' + @PayrollMethodID + ''' 
										) AND 
						HT2402.DivisionID = ''' + @DivisionID + ''''
						
			---	IF 'P10' <> (SELECT TOP 1 MethodID From HT5005 Where DivisionID = @DivisionID AND GeneralAbsentID = @GeneralAbsentID AND PayrollMethodID = @PayrollMethodID)
					SET @sSQLWhere = @sSQLWhere + ' AND 
						HT2402.AbsentTypeID in (SELECT AbsentTypeID 
												FROM	HT5003 
												WHERE	GeneralAbsentID =''' + @GeneralAbsentID + '''  
														AND DivisionID =''' + @DivisionID + ''' )  and
						ISNULL(HT2402.PeriodID,'''') IN (''' + ISNULL(@PeriodID , '') + ''','''')'
						
				SET @sSQLWhere = @sSQLWhere + '	AND	
						HT2402.DepartmentID Like ''' + @DepartmentID1 + ''' AND 
						ISNULL(HT2402.TeamID,'''') like  ''' + @TeamID1 + ''' AND
						ISNULL(HT2402.EmployeeID,'''') like  ''' + @EmployeeID+ '''	AND					
						TranMonth =' + str(@TranMonth) + ' and
						TranYear =' + str(@TranYear) + ' 
						'+@sWhere +'
				GROUP BY ProjectID, TranMonth, TranYear, 	EmployeeID, 
						HT2402.DivisionID,DepartmentID,ISNULL(TeamID,'''')'
			END		
		ELSE
			BEGIN
				SET @sSQLSELECT = '
				SELECT 	Null As ProjectID,TranMonth,TranYear,EmployeeID,
						Sum(AbsentAmount*HT1013.ConvertUnit/CASE WHEN HT1013.UnitID = ''' + 'H''' + ' THEN ' + STR(@TimeConvert) + '  ELSE 1 END ) as AbsentAmount, 
						--Sum(AbsentAmount/(CASE WHEN HT1013.UnitID = ''H'' and ISNULL(H3.ConditionCode,'''') = ''''
						--THEN ' + STR(@TimeConvert) + '  ELSE 1 END)) as AbsentAmount,
						HT2402.DivisionID,
						DepartmentID,
						ISNULL(TeamID,'''') as TeamID '
				SET @sSQLFrom = ' 
				FROM	HT2402  
				INNER JOIN HT1013 on HT2402.AbsentTypeID = HT1013.AbsentTypeID AND HT2402.DivisionID = HT1013.DivisionID
				LEFT JOIN HT1013 H3 on H3.ParentID = HT1013.AbsentTypeID AND H3.DivisionID = HT1013.DivisionID'
				SET @sSQLWhere = ' 
				WHERE	DepartmentID in (	SELECT	DepartmentID 
											FROM	HT5004 
		                       				WHERE 	DivisionID =''' + @DivisionID + ''' and										
													PayrollMethodID = ''' + @PayrollMethodID + ''' ) and
						HT2402.AbsentTypeID in (SELECT	AbsentTypeID 
												FROM	HT5003 
												WHERE	GeneralAbsentID =''' + @GeneralAbsentID + '''  
														AND DivisionID =''' + @DivisionID + ''' )  AND 
						HT2402.DivisionID =''' + @DivisionID + ''' AND 
						HT2402.DepartmentID Like ''' + @DepartmentID1 + ''' AND 
						ISNULL(HT2402.TeamID,'''') like  ''' + @TeamID1 + ''' AND 
						ISNULL(HT2402.EmployeeID,'''') like  ''' + @EmployeeID+ '''	AND
						ISNULL(HT2402.PeriodID,'''') IN (''' + ISNULL(@PeriodID , '') + ''','''') and
						TranMonth =' + str(@TranMonth) + ' and
						TranYear =' + str(@TranYear) + ' 
						'+@sWhere +'
				GROUP BY TranMonth, TranYear, 	EmployeeID, HT2402.DivisionID,DepartmentID,ISNULL(TeamID,'''') '
			END
	END
	ELSE	---- Cong loai tru
	 BEGIN
		   SET @sSQLSELECT = '
			SELECT 	Null As ProjectID, HT2400.TranMonth, HT2400.TranYear,HT2400.EmployeeID,
					' + str(@Days) + ' + + Sum(Case when ISNULL(TypeID,'''') in ( ''G'', ''P'' )  then - ISNULL(AbsentAmount*ConvertUnit,0) ELSE 
								 Case When  ISNULL(TypeID,'''') =''T'' then ISNULL(AbsentAmount*ConvertUnit,0) ELSE 0 end  end/ 
								CASE WHEN UnitID = ''' + 'H''' + ' THEN ' + STR(@TimeConvert) + ' ELSE 1 END ) as AbsentAmount,		
					HT2400.DivisionID,
					HT2400.DepartmentID,
					ISNULL(HT2400.TeamID,'''') as TeamID '
		   SET @sSQLFrom = ' 
			FROM		HT2400 	
			LEFT JOIN 	HT2402 
				ON		HT2402.EmployeeID = HT2400.EmployeeID and
						HT2402.DepartmentID = HT2400.DepartmentID and
						ISNULL(HT2402.TeamID,'''') = ISNULL(HT2400.TeamID,'''') and
						HT2402.DivisionID = HT2400.DivisionID and
						Ht2402.TranMonth = HT2400.TranMonth and
						Ht2402.TranYear = HT2400.TranYear
			LEFT JOIN 	(	SELECT  AbsentTypeID , TypeID, UnitID, ConvertUnit 
							FROM	HT1013 
			          	 	WHERE	IsMonth = 1 
									AND DivisionID =''' + @DivisionID + ''' 
									AND AbsentTypeID in (	SELECT	AbsentTypeID 
									                     	FROM	HT5003 
															WHERE	GeneralAbsentID  =''' + @GeneralAbsentID + '''  
																	AND DivisionID =''' + @DivisionID + ''' ) 
														) as H
				ON  H.AbsentTypeID = HT2402.AbsentTypeID '

			SET @sSQLWhere = ' 
			WHERE	HT2400.DepartmentID in (SELECT DepartmentID 
			     	                        From HT5004 
			     	                        Where 	DivisionID =''' + @DivisionID + ''' and										
											PayrollMethodID = ''' + @PayrollMethodID + ''' 
											)  and
					HT2400.DivisionID =''' + @DivisionID + ''' and
					HT2400.DepartmentID like ''' + @DepartmentID1 + ''' AND 
					ISNULL(HT2400.TeamID,'''') like  ''' + @TeamID1 + ''' AND 
					ISNULL(HT2400.EmployeeID,'''') like  ''' + @EmployeeID+ '''	AND
					ISNULL(HT2402.PeriodID,'''') IN (''' + ISNULL(@PeriodID , '') + ''','''') and
					HT2400.TranMonth =' + str(@TranMonth) + ' and
					HT2400.TranYear =' + str(@TranYear) + ' 
					'+@sWhere1 +'
			GROUP BY	HT2400.TranMonth, HT2400.TranYear,HT2400.EmployeeID, 
						HT2400.DivisionID,HT2400.DepartmentID,ISNULL(HT2400.TeamID,'''') '
	 END
END
ELSE --- Tu cham cong ngay
BEGIN
IF @Type = 0 --- Luong công nhat
	BEGIN
	SET @sSQLSELECT = '
		SELECT 	Null As ProjectID, TranMonth,TranYear,
				EmployeeID,
				Sum(AbsentAmount*HT1013.ConvertUnit/ CASE WHEN HT1013.UnitID = ''' + 'H''' + ' THEN ' + STR(@TimeConvert) + ' ELSE 1 END) as AbsentAmount,
				--Sum(AbsentAmount*HT1013.ConvertUnit/(CASE WHEN HT1013.UnitID = ''H'' and ISNULL(H3.ConditionCode,'''') = ''''
				THEN ' + STR(@TimeConvert) + '  ELSE 1 END)) as AbsentAmount,
				HT2401.DivisionID,
				DepartmentID,
				ISNULL(TeamID,'''') as TeamID '
		SET @sSQLFrom = ' 
		FROM		HT2401 
		INNER JOIN	HT1013 
			ON		HT2401.AbsentTypeID = HT1013.AbsentTypeID 
					AND HT2401.DivisionID = HT1013.DivisionID
		LEFT JOIN HT1013 H3 on H3.ParentID = HT1013.AbsentTypeID AND H3.DivisionID = HT1013.DivisionID'
		SET @sSQLWhere = '
		WHERE		DepartmentID in (SELECT DepartmentID 
		     		                 From HT5004 
		     		                 Where 	DivisionID =''' + @DivisionID + ''' and										
											PayrollMethodID = ''' + @PayrollMethodID + ''' 
									) AND 
					HT2401.DivisionID =''' + @DivisionID + ''' AND 							
					HT2401.DepartmentID Like ''' + @DepartmentID1 + ''' AND 					
					ISNULL(HT2401.TeamID,'''') like  ''' + @TeamID1 + ''' AND 
					HT2401.EmployeeID Like ''' + @EmployeeID + ''' AND 
					HT2401.AbsentTypeID in (SELECT AbsentTypeID From HT5003 
					Where GeneralAbsentID =''' + @GeneralAbsentID + '''  AND 
					DivisionID =''' + @DivisionID + ''' )  and
					TranMonth =' + str(@TranMonth) + ' and
					TranYear =' + str(@TranYear) + '  AND 
					Day(AbsentDate) between ' + STR(@FromDate) + ' AND ' + STR(@ToDate) + '
					'+@sWhere +'
		GROUP BY	TranMonth, TranYear, 	EmployeeID, 
					HT2401.DivisionID,DepartmentID,ISNULL(TeamID,'''') '
	END
ELSE	---- Cong loai tru
BEGIN
	SET @sSQLSELECT = '
	SELECT 	Null As ProjectID, HT2400.TranMonth,
			HT2400.TranYear,	HT2400.EmployeeID,
			' + str(@Days) + ' + + Sum( Case when ISNULL(TypeID,'''') in ( ''G'', ''P'' )  then - ISNULL(AbsentAmount*ConvertUnit, 0) ELSE 
						 Case When  ISNULL(TypeID,'''') =''T'' then ISNULL(AbsentAmount*ConvertUnit,0) ELSE 0 end  end/ 
						CASE WHEN UnitID = ''' + 'H''' + ' THEN ' + STR(@TimeConvert) + ' ELSE 1 END) as AbsentAmount,		
			HT2400.DivisionID,
			HT2400.DepartmentID,
			ISNULL(HT2400.TeamID,'''') as TeamID '
	SET @sSQLFrom = ' 
	FROM		HT2400 	
	LEFT JOIN 	HT2401 
		ON		HT2401.EmployeeID = HT2400.EmployeeID and
				HT2401.DepartmentID = HT2400.DepartmentID and
				ISNULL(HT2401.TeamID,'''') = ISNULL(HT2400.TeamID,'''') and
				HT2401.DivisionID = HT2400.DivisionID and
				Ht2401.TranMonth = HT2400.TranMonth and
				Ht2401.TranYear = HT2400.TranYear
	LEFT  JOIN 	(	SELECT  AbsentTypeID , TypeID, ConvertUnit, UnitID 
					FROM	HT1013 
	           	 	WHERE	IsMonth = 0 
					AND DivisionID =''' + @DivisionID + ''' 
					AND AbsentTypeID in (	SELECT	AbsentTypeID 
											FROM	HT5003 
											WHERE	GeneralAbsentID  =''' + @GeneralAbsentID + '''  
													AND DivisionID =''' + @DivisionID + ''' ) 
				) AS H
		ON		H.AbsentTypeID = HT2401.AbsentTypeID'

	SET @sSQLWhere = ' 
	WHERE	HT2400.DepartmentID in (SELECT	DepartmentID 
									FROM	HT5004 
									WHERE 	DivisionID =''' + @DivisionID + ''' and										
											PayrollMethodID = ''' + @PayrollMethodID + ''' )  and
			HT2400.DivisionID =''' + @DivisionID + ''' AND 
			HT2400.DepartmentID = ''' + @DepartmentID1 + ''' AND 
			ISNULL(HT2400.TeamID,'''') like  ''' + @TeamID1 + ''' AND 
			HT2400.EmployeeID Like ''' + @EmployeeID + ''' AND 
			HT2400.TranMonth =' + str(@TranMonth) + ' and
			HT2400.TranYear =' + str(@TranYear) + '  AND 
			Day(AbsentDate) between ' + STR(@FromDate) + ' AND ' + STR(@ToDate) + '
			'+@sWhere1 +'
	GROUP BY	HT2400.TranMonth,HT2400.TranYear,HT2400.EmployeeID, 
				HT2400.DivisionID,HT2400.DepartmentID,ISNULL(HT2400.TeamID,'''') '
END
END
		
	--IF NOT EXISTS ( SELECT 1 FROM SysObjects WHERE Xtype = 'V' AND name = 'HV5003' )
	--   BEGIN
	--		 EXEC ( 'CREATE VIEW HV5003 as '+@sSQLSelect+@sSQLFrom+@sSQLWhere )
	--   END
	--ELSE
	--   BEGIN
	--		 EXEC ( ' ALTER VIEW HV5003 as  '+@sSQLSelect+@sSQLFrom+@sSQLWhere )
	--   END
END
ELSE
--Xu ly ngay cong tong hop theo cong trinh
BEGIN
	IF @Type = 0 --- Luong công nhat
	BEGIN
		SET @sSQLSELECT = '
		SELECT 	ProjectID,TranMonth,TranYear,EmployeeID,
				Sum(AbsentAmount*ConvertUnit/CASE WHEN UnitID = ''' + 'H''' + ' THEN ' + STR(@TimeConvert) + '  ELSE 1 END ) as AbsentAmount, 
				HT2402.DivisionID,	DepartmentID,	ISNULL(TeamID,'''') as TeamID '
		SET @sSQLFrom = ' 
		FROM		HT2432 HT2402  
		INNER JOIN	HT1013 
			ON		HT2402.AbsentTypeID = HT1013.AbsentTypeID 
					AND HT2402.DivisionID = HT1013.DivisionID '
		SET @sSQLWhere = ' 
		WHERE	DepartmentID in (SELECT	DepartmentID 
								FROM	HT5004 
								WHERE 	DivisionID =''' + @DivisionID + ''' and										
										PayrollMethodID = ''' + @PayrollMethodID + ''' 
								) AND 
				HT2402.DivisionID = ''' + @DivisionID + ''' AND 
				HT2402.AbsentTypeID in (SELECT AbsentTypeID 
				                        FROM	HT5003 
				                        WHERE	GeneralAbsentID =''' + @GeneralAbsentID + '''  
												AND DivisionID =''' + @DivisionID + ''' )  and
				HT2402.DepartmentID Like ''' + @DepartmentID1 + ''' AND 
				ISNULL(HT2402.TeamID,'''') like  ''' + @TeamID1 + ''' AND 
				HT2402.EmployeeID Like ''' + @EmployeeID + ''' AND 
				ISNULL(HT2402.PeriodID,'''') IN (''' + ISNULL(@PeriodID , '') + ''','''') and
				TranMonth =' + str(@TranMonth) + ' and
				TranYear =' + str(@TranYear) + ' 
				'+@sWhere +'
		GROUP BY ProjectID, TranMonth, TranYear, 	EmployeeID, 
				HT2402.DivisionID,DepartmentID,ISNULL(TeamID,'''') '
	END
	ELSE	---- Cong loai tru
	BEGIN
	   SET @sSQLSELECT = '
		SELECT 	ProjectID, HT2400.TranMonth, HT2400.TranYear,HT2400.EmployeeID,
				' + str(@Days) + ' + + Sum(Case when ISNULL(TypeID,'''') in ( ''G'', ''P'' )  then - ISNULL(AbsentAmount*ConvertUnit,0) ELSE 
							 Case When  ISNULL(TypeID,'''') =''T'' then ISNULL(AbsentAmount*ConvertUnit,0) ELSE 0 end  end/ 
							CASE WHEN UnitID = ''' + 'H''' + ' THEN ' + STR(@TimeConvert) + ' ELSE 1 END ) as AbsentAmount,		
				HT2400.DivisionID,
				HT2400.DepartmentID,
				ISNULL(HT2400.TeamID,'''') as TeamID '
	   SET @sSQLFrom = ' 
		FROM	HT2400 	
		LEFT JOIN 	HT2432 HT2402 
			ON		HT2402.EmployeeID = HT2400.EmployeeID and
					HT2402.DepartmentID = HT2400.DepartmentID and
					ISNULL(HT2402.TeamID,'''') = ISNULL(HT2400.TeamID,'''') and
					HT2402.DivisionID = HT2400.DivisionID and
					Ht2402.TranMonth = HT2400.TranMonth and
					Ht2402.TranYear = HT2400.TranYear
		LEFT JOIN 	(	SELECT  AbsentTypeID , TypeID, UnitID, ConvertUnit 
						FROM	HT1013 Where IsMonth = 1 
								AND DivisionID =''' + @DivisionID + ''' 
								AND AbsentTypeID in (SELECT AbsentTypeID 
								                     FROM	HT5003 
													WHERE	GeneralAbsentID  =''' + @GeneralAbsentID + '''  
															AND DivisionID =''' + @DivisionID + ''' ) ) as H
			ON		H.AbsentTypeID = HT2402.AbsentTypeID '
		SET @sSQLWhere = ' 
		WHERE	HT2400.DepartmentID in (SELECT	DepartmentID 
										FROM	HT5004 
										WHERE 	DivisionID =''' + @DivisionID + ''' and										
												PayrollMethodID = ''' + @PayrollMethodID + ''' 
									)  AND
				HT2400.DivisionID =''' + @DivisionID + ''' AND 
				HT2400.DepartmentID like ''' + @DepartmentID1 + ''' AND 
				ISNULL(HT2400.TeamID,'''') like  ''' + @TeamID1 + ''' AND 
				HT2400.EmployeeID Like ''' + @EmployeeID + ''' AND 
				ISNULL(HT2402.PeriodID,'''') IN (''' + ISNULL(@PeriodID , '') + ''','''') and
				HT2400.TranMonth =' + str(@TranMonth) + ' and
				HT2400.TranYear =' + str(@TranYear) + ' 
				'+@sWhere1 +'
		GROUP BY	ProjectID, HT2400.TranMonth, HT2400.TranYear,HT2400.EmployeeID, 
					HT2400.DivisionID,HT2400.DepartmentID,ISNULL(HT2400.TeamID,'''') '
	END

	--IF NOT EXISTS ( SELECT 1 FROM SysObjects WHERE Xtype = 'V' AND name = 'HV5003' )
	--BEGIN
	--EXEC ( 'CREATE VIEW HV5003 as '+@sSQLSelect+@sSQLFrom+@sSQLWhere )
	--END
	--ELSE
	--BEGIN
	--EXEC ( ' ALTER VIEW HV5003 as  '+@sSQLSelect+@sSQLFrom+@sSQLWhere )
	--END
END
		 
INSERT INTO #HV5003 (ProjectID, TranMonth, TranYear, EmployeeID, AbsentAmount, DivisionID, DepartmentID, TeamID)
EXEC(@sSQLSelect+@sSQLFrom+@sSQLWhere)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

