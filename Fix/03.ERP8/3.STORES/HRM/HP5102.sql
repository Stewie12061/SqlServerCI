IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP5102]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP5102]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----- 	Created by Nguyen Van Nhan, Date 29/04/2004
----  	Purpose: Tinh luong theo PP luong Chia (Luong khoan)
----	Cong thuc: L = 
----	Modify on 01/08/2013 by Bao Anh: Bo sung 10 khoan thu nhap (Hung Vuong)
/********************************************
'* Edited by: [GS] [Minh Lâm] [02/08/2010]
'********************************************/
---- Modified by Phương Thảo on 05/12/2016: Bổ sung lưu S21->S100 (MEIKO)

CREATE PROCEDURE [dbo].[HP5102]
       @DivisionID AS nvarchar(50) ,
       @TranMonth AS int ,
       @TranYear AS int ,
       @PayrollMethodID nvarchar(50) ,
       @MethodID AS nvarchar(50) ,
       @SalaryTotal AS decimal(28,8) ,
       @AbsentAmount AS decimal(28,8) ,
       @Orders AS tinyint ,
       @IsIncome AS tinyint ,
       @DepartmentID1 AS nvarchar(50) ,
       @TeamID1 AS nvarchar(50)
AS --Print 'Luong congNhat'
DECLARE
        @Emp_cur AS cursor ,
        @DepartmentID AS nvarchar(50) ,
        @TeamID AS nvarchar(50) ,
        @EmployeeID AS nvarchar(50) ,
        @CoValues AS decimal(28,8) ,
        @AbsentValues AS decimal(28,8) ,
        @SalaryAmount AS decimal(28,8) ,
        @BaseSalary AS decimal(28,8) ,
        @TransactionID AS nvarchar(50) ,
        @SumCoAbsentAmount AS decimal(28,8) ,
        @UnitPrice AS decimal(28,8) ,
        @SumSalaryAmount AS decimal(28,8) ,
        @Diff AS decimal(28,8),
		@sSQl NVARCHAR(MAX)='',
		@OrderNum VARCHAR(5)

SELECT @OrderNum = CASE WHEN @Orders <10 THEN LTRIM(RTRIM('0'+CONVERT(VARCHAR(5),@Orders))) ELSE LTRIM(RTRIM(CONVERT(VARCHAR(5),@Orders))) END

--Kiem tra customize cho CSG
Declare @AP4444 Table(CustomerName Int, Export Int)
Declare @CustomerName as Int
Insert Into @AP4444(CustomerName,Export) EXEC('AP4444')
Select @CustomerName=CustomerName From @AP4444

IF @CustomerName = 19
	SET @SumCoAbsentAmount = ( SELECT
                               Sum(isnull(HV54.GeneralCo , 0) * Isnull(HV54.AbsentAmount , 0))
                           FROM
                               HT3444 HV54
                           WHERE
                               DivisionID = @DivisionID AND TranMonth = @TranMonth AND TranYear = @TranYear 
                               And EmployeeID In (SELECT EmployeeID From HT2400 Where HT2400.DivisionID = @DivisionID AND HT2400.TranMonth = @TranMonth AND HT2400.TranYear = @TranYear AND IsJobWage=1))
ELSE
	SET @SumCoAbsentAmount = ( SELECT
                               Sum(isnull(HV54.GeneralCo , 0) * Isnull(HV54.AbsentAmount , 0))
                           FROM
                               HT3444 HV54
                           WHERE
                               DivisionID = @DivisionID AND TranMonth = @TranMonth AND TranYear = @TranYear )


IF @SumCoAbsentAmount <> 0
   BEGIN
         SET @UnitPrice = @SalaryTotal / @SumCoAbsentAmount
   END
ELSE
   BEGIN
         SET @UnitPrice = 0
   END
--print cast(@SalaryTotal as nvarchar(50)) 
--print  cast(@SumCoAbsentAmount as nvarchar(50))
--print cast(@UnitPrice  as nvarchar(50))
IF @CustomerName = 19
	SET @Emp_cur = CURSOR SCROLL KEYSET FOR 
					SELECT
						HT34.TransactionID ,
						HT34.EmployeeID ,
						HT34.DepartmentID ,
						HT34.TeamID ,
						HV54.GeneralCo ,
						HV54.AbsentAmount ,
						HV54.BaseSalary
					FROM
						HT3400 HT34 LEFT JOIN HT3444 HV54
					ON  HT34.EmployeeID = HV54.EmployeeID AND HT34.DivisionID = HV54.DivisionID AND HT34.DepartmentID = HV54.DepartmentID AND isnull(HT34.TeamID , '') = isnull(HV54.TeamID , '') AND HT34.TranMonth = HV54.TranMonth AND HT34.TranYear = HV54.TranYear
					WHERE
						HT34.PayrollMethodID = @PayrollMethodID AND HT34.TranMonth = @TranMonth AND HT34.TranYear = @TranYear AND HT34.DivisionID = @DivisionID AND HT34.DepartmentID LIKE @DepartmentID1 AND ISNull(HT34.TeamID , '') LIKE ISNULL(@TeamID1 , '') 
						AND HT34.DepartmentID IN ( SELECT DepartmentID FROM HT5004 WHERE PayrollMethodID = @PayrollMethodID And DivisionID = @DivisionID )
						And HT34.EmployeeID In (SELECT EmployeeID From HT2400 Where HT2400.DivisionID = @DivisionID AND HT2400.TranMonth = @TranMonth AND HT2400.TranYear = @TranYear AND IsJobWage=1)							 
ELSE
	SET @Emp_cur = CURSOR SCROLL KEYSET FOR 
					SELECT
						HT34.TransactionID ,
						HT34.EmployeeID ,
						HT34.DepartmentID ,
						HT34.TeamID ,
						HV54.GeneralCo ,
						HV54.AbsentAmount ,
						HV54.BaseSalary
					FROM
						HT3400 HT34 LEFT JOIN HT3444 HV54
					ON  HT34.EmployeeID = HV54.EmployeeID AND HT34.DivisionID = HV54.DivisionID AND HT34.DepartmentID = HV54.DepartmentID AND isnull(HT34.TeamID , '') = isnull(HV54.TeamID , '') AND HT34.TranMonth = HV54.TranMonth AND HT34.TranYear = HV54.TranYear
					WHERE
						HT34.PayrollMethodID = @PayrollMethodID AND HT34.TranMonth = @TranMonth AND HT34.TranYear = @TranYear AND HT34.DivisionID = @DivisionID AND HT34.DepartmentID LIKE @DepartmentID1 AND ISNull(HT34.TeamID , '') LIKE ISNULL(@TeamID1 , '') 
						AND HT34.DepartmentID IN ( SELECT DepartmentID FROM HT5004 WHERE PayrollMethodID = @PayrollMethodID And DivisionID = @DivisionID )													 


OPEN @Emp_cur
FETCH NEXT FROM @Emp_cur INTO @TransactionID,@EmployeeID,@DepartmentID,@TeamID,@CoValues,@AbsentValues,@BaseSalary
WHILE @@FETCH_STATUS = 0
      BEGIN
            SET @SalaryAmount = 0
            SET @SalaryAmount = @UnitPrice * isnull(@CoValues , 0) * isnull(@AbsentValues , 0)  
		--Print ' @BaseSalary '+str(@BaseSalary)+ ' 	@SalaryAmount: '+str(@SalaryAmount)+' Orders: '+str(@Orders)--+' @AbsentAmount: '+str(@AbsentAmount)
			IF @Orders <= 30 
			BEGIN
				SET @sSQl = '
				IF '+STR(@IsIncome)+' = 1
					UPDATE HT3400 
					SET Income'+@OrderNum+' = '+CONVERT(VARCHAR(50),@SalaryAmount)+', IGAbsentAmount'+@OrderNum+' = '+CONVERT(VARCHAR(50),ISNULL(@AbsentValues , 0))+'
					WHERE  DivisionID = '''+@DivisionID +'''
					AND PayrollMethodID = '''+ISNULL(@PayrollMethodID ,'')+'''
					AND TranMonth = '+STR(@TranMonth)+' AND TranYear = '+STR(@TranYear )+'
					AND TransactionID = '''+@TransactionID +'''
				ELSE 
					UPDATE HT3400 
					SET SubAmount'+@OrderNum+' = '+CONVERT(VARCHAR(50),@SalaryAmount)+', IGAbsentAmount'+@OrderNum+' = '+CONVERT(VARCHAR(50),ISNULL(@AbsentValues , 0))+'
					WHERE  DivisionID = '''+@DivisionID +'''
					AND PayrollMethodID = '''+ISNULL(@PayrollMethodID ,'')+'''
					AND TranMonth = '+STR(@TranMonth)+' AND TranYear = '+STR(@TranYear )+'
					AND TransactionID = '''+@TransactionID +'''
				'
			END
			ELSE 
			IF @Orders > 30 AND @IsIncome = 1  
			BEGIN			
				SET @sSQl = '				
				UPDATE HT3499 
				SET Income'+@OrderNum+' = '+CONVERT(VARCHAR(50),@SalaryAmount)+'
				WHERE DivisionID = '''+@DivisionID+''' 
				AND TransactionID = '''+@TransactionID+'''
				
				'
			END
			ELSE
			IF @Orders > 30 AND @Orders <= 100 AND @IsIncome <> 1  
			BEGIN
				SET @sSQl = '
				UPDATE HT3499 
				SET SubAmount'+@OrderNum+' = '+CONVERT(VARCHAR(50),@SalaryAmount)+'
				WHERE DivisionID = '''+@DivisionID+''' 
				AND TransactionID = '''+@TransactionID+''' '
			END

			--PRINT ('hp5102'+@sSQl)
			EXEC (@sSQl)

			/*
            UPDATE
                HT3400
            SET
                Income01 = ( CASE
                                  WHEN @Orders = 01 THEN @SalaryAmount
                                  ELSE Income01
                             END ) ,
                Income02 = ( CASE
                                  WHEN @Orders = 02 THEN @SalaryAmount
                                  ELSE Income02
                             END ) ,
                Income03 = ( CASE
                                  WHEN @Orders = 03 THEN @SalaryAmount
                                  ELSE Income03
                             END ) ,
                Income04 = ( CASE
                                  WHEN @Orders = 04 THEN @SalaryAmount
                                  ELSE Income04
                             END ) ,
                Income05 = ( CASE
                                  WHEN @Orders = 05 THEN @SalaryAmount
                                  ELSE Income05
                             END ) ,
                Income06 = ( CASE
                                  WHEN @Orders = 06 THEN @SalaryAmount
                                  ELSE Income06
                             END ) ,
                Income07 = ( CASE
                                  WHEN @Orders = 07 THEN @SalaryAmount
                                  ELSE Income07
                             END ) ,
                Income08 = ( CASE
                                  WHEN @Orders = 08 THEN @SalaryAmount
                                  ELSE Income08
                             END ) ,
                Income09 = ( CASE
                                  WHEN @Orders = 09 THEN @SalaryAmount
                                  ELSE Income09
                             END ) ,
                Income10 = ( CASE
                                  WHEN @Orders = 10 THEN @SalaryAmount
                                  ELSE Income10
                             END ) ,
                             
                Income11 = ( CASE
                                     WHEN @Orders = 11 THEN @SalaryAmount
                                     ELSE Income11
                                END ) ,
                Income12 = ( CASE
                                     WHEN @Orders = 12 THEN @SalaryAmount
                                     ELSE Income12
                                END ) ,
                Income13 = ( CASE
                                     WHEN @Orders = 13 THEN @SalaryAmount
                                     ELSE Income13
                                END ) ,
                Income14 = ( CASE
                                     WHEN @Orders = 14 THEN @SalaryAmount
                                     ELSE Income14
                                END ) ,
                Income15 = ( CASE
                                     WHEN @Orders = 15 THEN @SalaryAmount
                                     ELSE Income15
                                END ) ,
                Income16 = ( CASE
                                     WHEN @Orders = 16 THEN @SalaryAmount
                                     ELSE Income16
                                END ) ,
                Income17 = ( CASE
                                     WHEN @Orders = 17 THEN @SalaryAmount
                                     ELSE Income17
                                END ) ,
                Income18 = ( CASE
                                     WHEN @Orders = 18 THEN @SalaryAmount
                                     ELSE Income18
                                END ) ,
                Income19 = ( CASE
                                     WHEN @Orders = 19 THEN @SalaryAmount
                                     ELSE Income19
                                END ) ,
                Income20 = ( CASE
                                     WHEN @Orders = 20 THEN @SalaryAmount
                                     ELSE Income20
                                END ) ,
                Income21 = ( CASE
                                     WHEN @Orders = 21 THEN @SalaryAmount
                                     ELSE Income21
                                END ) ,
                Income22 = ( CASE
                                     WHEN @Orders = 22 THEN @SalaryAmount
                                     ELSE Income22
                                END ) ,
                Income23 = ( CASE
                                     WHEN @Orders = 23 THEN @SalaryAmount
                                     ELSE Income23
                                END ) ,
                Income24 = ( CASE
                                     WHEN @Orders = 24 THEN @SalaryAmount
                                     ELSE Income24
                                END ) ,
                Income25 = ( CASE
                                     WHEN @Orders = 25 THEN @SalaryAmount
                                     ELSE Income25
                                END ) ,
                Income26 = ( CASE
                                     WHEN @Orders = 26 THEN @SalaryAmount
                                     ELSE Income26
                                END ) ,                                                                             
                Income27 = ( CASE
                                     WHEN @Orders = 27 THEN @SalaryAmount
                                     ELSE Income27
                                END ) ,
                Income28 = ( CASE
                                     WHEN @Orders = 28 THEN @SalaryAmount
                                     ELSE Income28
                                END ) ,
                Income29 = ( CASE
                                     WHEN @Orders = 29 THEN @SalaryAmount
                                     ELSE Income29
                                END ) ,
                Income30 = ( CASE
                                     WHEN @Orders = 30 THEN @SalaryAmount
                                     ELSE Income30
                                END ) ,
                IGAbsentAmount01 = ( CASE
                                          WHEN @Orders = 01 THEN isnull(@AbsentValues , 0)
                                          ELSE IGAbsentAmount01
                                     END ) ,
                IGAbsentAmount02 = ( CASE
                                          WHEN @Orders = 02 THEN isnull(@AbsentValues , 0)
                                          ELSE IGAbsentAmount02
                                     END ) ,
                IGAbsentAmount03 = ( CASE
                                          WHEN @Orders = 03 THEN isnull(@AbsentValues , 0)
                                          ELSE IGAbsentAmount03
                                     END ) ,
                IGAbsentAmount04 = ( CASE
                                          WHEN @Orders = 04 THEN isnull(@AbsentValues , 0)
                                          ELSE IGAbsentAmount04
                                     END ) ,
                IGAbsentAmount05 = ( CASE
                                          WHEN @Orders = 05 THEN isnull(@AbsentValues , 0)
                                          ELSE IGAbsentAmount05
                                     END ) ,
                IGAbsentAmount06 = ( CASE
                                          WHEN @Orders = 06 THEN isnull(@AbsentValues , 0)
                                          ELSE IGAbsentAmount06
                                     END ) ,
                IGAbsentAmount07 = ( CASE
                                          WHEN @Orders = 07 THEN isnull(@AbsentValues , 0)
                                          ELSE IGAbsentAmount07
                                     END ) ,
                IGAbsentAmount08 = ( CASE
                                          WHEN @Orders = 08 THEN isnull(@AbsentValues , 0)
                                          ELSE IGAbsentAmount08
                                     END ) ,
                IGAbsentAmount09 = ( CASE
                                          WHEN @Orders = 09 THEN isnull(@AbsentValues , 0)
                                          ELSE IGAbsentAmount09
                                     END ) ,
                IGAbsentAmount10 = ( CASE
                                          WHEN @Orders = 10 THEN isnull(@AbsentValues , 0)
                                          ELSE IGAbsentAmount10
                                     END )
            WHERE
                DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID AND TranMonth = @TranMonth AND TranYear = @TranYear AND TransactionID = @TransactionID AND @IsIncome = 1

            UPDATE
                HT3400
            SET
                SubAmount01 = ( CASE
                                     WHEN @Orders = 01 THEN @SalaryAmount
                                     ELSE SubAmount01
                                END ) ,
                SubAmount02 = ( CASE
                                     WHEN @Orders = 02 THEN @SalaryAmount
                                     ELSE SubAmount02
                                END ) ,
                SubAmount03 = ( CASE
                                     WHEN @Orders = 03 THEN @SalaryAmount
                                     ELSE SubAmount03
                                END ) ,
                SubAmount04 = ( CASE
                                     WHEN @Orders = 04 THEN @SalaryAmount
                                     ELSE SubAmount04
                                END ) ,
                SubAmount05 = ( CASE
                                     WHEN @Orders = 05 THEN @SalaryAmount
                                     ELSE SubAmount05
                                END ) ,
                SubAmount06 = ( CASE
                                     WHEN @Orders = 06 THEN @SalaryAmount
                                     ELSE SubAmount06
                                END ) ,
                SubAmount07 = ( CASE
                                     WHEN @Orders = 07 THEN @SalaryAmount
                                     ELSE SubAmount07
                                END ) ,
                SubAmount08 = ( CASE
                                     WHEN @Orders = 08 THEN @SalaryAmount
                                     ELSE SubAmount08
                                END ) ,
                SubAmount09 = ( CASE
                                     WHEN @Orders = 09 THEN @SalaryAmount
                                     ELSE SubAmount09
                                END ) ,
                SubAmount10 = ( CASE
                                     WHEN @Orders = 10 THEN @SalaryAmount
                                     ELSE SubAmount10
                                END ) ,
                SubAmount11 = ( CASE
                                     WHEN @Orders = 11 THEN @SalaryAmount
                                     ELSE SubAmount11
                                END ) ,
                SubAmount12 = ( CASE
                                     WHEN @Orders = 12 THEN @SalaryAmount
                                     ELSE SubAmount12
                                END ) ,
                SubAmount13 = ( CASE
                                     WHEN @Orders = 13 THEN @SalaryAmount
                                     ELSE SubAmount13
                                END ) ,
                SubAmount14 = ( CASE
                                     WHEN @Orders = 14 THEN @SalaryAmount
                                     ELSE SubAmount14
                                END ) ,
                SubAmount15 = ( CASE
                                     WHEN @Orders = 15 THEN @SalaryAmount
                                     ELSE SubAmount15
                                END ) ,
                SubAmount16 = ( CASE
                                     WHEN @Orders = 16 THEN @SalaryAmount
                                     ELSE SubAmount16
                                END ) ,
                SubAmount17 = ( CASE
                                     WHEN @Orders = 17 THEN @SalaryAmount
                                     ELSE SubAmount17
                                END ) ,
                SubAmount18 = ( CASE
                                     WHEN @Orders = 18 THEN @SalaryAmount
                                     ELSE SubAmount18
                                END ) ,
                SubAmount19 = ( CASE
                                     WHEN @Orders = 19 THEN @SalaryAmount
                                     ELSE SubAmount19
                                END ) ,
                SubAmount20 = ( CASE
                                     WHEN @Orders = 20 THEN @SalaryAmount
                                     ELSE SubAmount20
                                END ) ,
                IGAbsentAmount11 = ( CASE
                                          WHEN @Orders = 01 THEN isnull(@AbsentValues , 0)
                                          ELSE IGAbsentAmount11
                                     END ) ,
                IGAbsentAmount12 = ( CASE
                                          WHEN @Orders = 02 THEN isnull(@AbsentValues , 0)
                                          ELSE IGAbsentAmount12
                                     END ) ,
                IGAbsentAmount13 = ( CASE
                                          WHEN @Orders = 03 THEN isnull(@AbsentValues , 0)
                                          ELSE IGAbsentAmount13
                                     END ) ,
                IGAbsentAmount14 = ( CASE
                                          WHEN @Orders = 04 THEN isnull(@AbsentValues , 0)
                                          ELSE IGAbsentAmount14
                                     END ) ,
                IGAbsentAmount15 = ( CASE
                                          WHEN @Orders = 05 THEN isnull(@AbsentValues , 0)
                                          ELSE IGAbsentAmount15
                                     END ) ,
                IGAbsentAmount16 = ( CASE
                                          WHEN @Orders = 06 THEN isnull(@AbsentValues , 0)
                                          ELSE IGAbsentAmount16
                                     END ) ,
                IGAbsentAmount17 = ( CASE
                                          WHEN @Orders = 07 THEN isnull(@AbsentValues , 0)
                                          ELSE IGAbsentAmount17
                                     END ) ,
                IGAbsentAmount18 = ( CASE
                                          WHEN @Orders = 08 THEN isnull(@AbsentValues , 0)
                                          ELSE IGAbsentAmount18
                                     END ) ,
                IGAbsentAmount19 = ( CASE
                                          WHEN @Orders = 09 THEN isnull(@AbsentValues , 0)
                                          ELSE IGAbsentAmount19
                                     END ) ,
                IGAbsentAmount20 = ( CASE
                                          WHEN @Orders = 10 THEN isnull(@AbsentValues , 0)
                                          ELSE IGAbsentAmount20
                                     END )
            WHERE
                DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID AND TranMonth = @TranMonth AND TranYear = @TranYear AND TransactionID = @TransactionID AND @IsIncome = 0
			*/

            FETCH NEXT FROM @Emp_cur INTO @TransactionID,@EmployeeID,@DepartmentID,@TeamID,@CoValues,@AbsentValues,@BaseSalary
      END

CLOSE @Emp_cur

--Rem by: Dang Le Bao Quynh, bo xu ly lam tron
/*
IF @IsIncome = 1 ----Lam tron cac khoan thu nhap
   BEGIN
         SET @SumSalaryAmount = 0		
         SET @SumSalaryAmount = ( SELECT
                                      Sum(CASE
                                               WHEN @Orders = 01 THEN isnull(Income01 , 0)
                                               ELSE CASE
                                                         WHEN @Orders = 02 THEN isnull(Income02 , 0)
                                                         ELSE CASE
                                                                   WHEN @Orders = 03 THEN isnull(Income03 , 0)
                                                                   ELSE CASE
                                                                             WHEN @Orders = 04 THEN isnull(Income04 , 0)
                                                                             ELSE CASE
                                                                                       WHEN @Orders = 05 THEN isnull(Income05 , 0)
                                                                                       ELSE CASE
                                                                                                 WHEN @Orders = 06 THEN isnull(Income06 , 0)
                                                                                                 ELSE CASE
                                                                                                           WHEN @Orders = 07 THEN isnull(Income07 , 0)
                                                                                                           ELSE CASE
                                                                                                                     WHEN @Orders = 08 THEN isnull(Income08 , 0)
                                                                                                                     ELSE CASE
                                                                                                                               WHEN @Orders = 09 THEN isnull(Income09 , 0)
                                                                                                                               ELSE CASE
                                                                                                                                         WHEN @Orders = 10 THEN isnull(Income10 , 0)
                                                                                                                                         ELSE 0
                                                                                                                                    END
                                                                                                                          END
                                                                                                                END
                                                                                                      END
                                                                                            END
                                                                                  END
                                                                        END
                                                              END
                                                    END
                                          END)
                                  FROM
                                      HT3400
                                  WHERE
                                      DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID AND DepartmentID LIKE @DepartmentID1 AND ISNull(TeamID , '') LIKE ISNULL(@TeamID1 , '') AND TranMonth = @TranMonth AND TranYear = @TranYear ) --and
					--TransactionID =@TransactionID)						
					
		IF(@SumSalaryAmount = 0)
		BEGIN 
			SET @SumSalaryAmount = ( SELECT
							  Sum(CASE
									   WHEN @Orders = 11 THEN isnull(Income11 , 0)
									   ELSE CASE
												 WHEN @Orders = 12 THEN isnull(Income12 , 0)
												 ELSE CASE
														   WHEN @Orders = 13 THEN isnull(Income13 , 0)
														   ELSE CASE
																	 WHEN @Orders = 14 THEN isnull(Income14 , 0)
																	 ELSE CASE
																			   WHEN @Orders = 15 THEN isnull(Income15 , 0)
																			   ELSE CASE
																						 WHEN @Orders = 16 THEN isnull(Income16 , 0)
																						 ELSE CASE
																								   WHEN @Orders = 17 THEN isnull(Income17 , 0)
																								   ELSE CASE
																											 WHEN @Orders = 18 THEN isnull(Income18 , 0)
																											 ELSE CASE
																													   WHEN @Orders = 19 THEN isnull(Income19 , 0)
																													   ELSE CASE
																																 WHEN @Orders = 20 THEN isnull(Income20 , 0)	
																																 ELSE 0																																																											 
																															END
																												  END
																										END
																							  END
																					END
																		  END
																END
													  END
											END
								  END)
						  FROM
							  HT3400
						  WHERE
							  DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID AND DepartmentID LIKE @DepartmentID1 AND ISNull(TeamID , '') LIKE ISNULL(@TeamID1 , '') AND TranMonth = @TranMonth AND TranYear = @TranYear ) --and --TransactionID =@TransactionID)					
			END
			
----- Lam tron so -----
         IF @SumSalaryAmount <> @SalaryTotal
            BEGIN

                  SET @Diff = @SalaryTotal - @SumSalaryAmount
                  
                  BEGIN
                        SET @TransactionID = ( SELECT TOP 1
                                                   TransactionID
                                               FROM
                                                   HT3400
                                               WHERE
                                                   DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID AND TranMonth = @TranMonth AND TranYear = @TranYear
                                               ORDER BY
                                                   CASE
                                                        WHEN @Orders = 01 THEN isnull(Income01 , 0)
                                                        ELSE CASE
                                                                  WHEN @Orders = 02 THEN isnull(Income02 , 0)
                                                                  ELSE CASE
                                                                            WHEN @Orders = 03 THEN isnull(Income03 , 0)
                                                                            ELSE CASE
                                                                                      WHEN @Orders = 04 THEN isnull(Income04 , 0)
                                                                                      ELSE CASE
                                                                                                WHEN @Orders = 05 THEN isnull(Income05 , 0)
                                                                                                ELSE CASE
                                                                                                          WHEN @Orders = 06 THEN isnull(Income06 , 0)
                                                                                                          ELSE CASE
                                                                                                                    WHEN @Orders = 07 THEN isnull(Income07 , 0)
                                                                                                                    ELSE CASE
                                                                                                                              WHEN @Orders = 08 THEN isnull(Income08 , 0)
                                                                                                                              ELSE CASE
                                                                                                                                        WHEN @Orders = 09 THEN isnull(Income09 , 0)
                                                                                                                                        ELSE CASE
                                                                                                                                                  WHEN @Orders = 10 THEN isnull(Income10 , 0)
                                                                                                                                                  ELSE 0
                                                                                                                                             END
                                                                                                                                   END
                                                                                                                         END
                                                                                                               END
                                                                                                     END
                                                                                           END
                                                                                 END
                                                                       END
                                                             END
                                                   END DESC )
                          
                          IF(@Orders > 10)
                          BEGIN
							  SET @TransactionID = ( SELECT TOP 1
													   TransactionID
												   FROM
													   HT3400
												   WHERE
													   DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID AND TranMonth = @TranMonth AND TranYear = @TranYear
												   ORDER BY
													   CASE
															WHEN @Orders = 11 THEN isnull(Income11 , 0)
															ELSE CASE
																	  WHEN @Orders = 12 THEN isnull(Income12 , 0)
																	  ELSE CASE
																				WHEN @Orders = 13 THEN isnull(Income13 , 0)
																				ELSE CASE
																						  WHEN @Orders = 14 THEN isnull(Income14 , 0)
																						  ELSE CASE
																									WHEN @Orders = 15 THEN isnull(Income15 , 0)
																									ELSE CASE
																											  WHEN @Orders = 16 THEN isnull(Income16 , 0)
																											  ELSE CASE
																														WHEN @Orders = 17 THEN isnull(Income17 , 0)
																														ELSE CASE
																																  WHEN @Orders = 18 THEN isnull(Income18 , 0)
																																  ELSE CASE
																																			WHEN @Orders = 19 THEN isnull(Income19 , 0)
																																			ELSE CASE
																																					  WHEN @Orders = 20 THEN isnull(Income20 , 0)   
																																					  ELSE 0                                                                                                                                      
																																				 END
																																	   END
																															 END
																												   END
																										 END
																							   END
																					 END
																		   END
																 END
													   END DESC )   
							END                                  
                                             
                        IF @TransactionID IS NOT NULL
                           BEGIN


                                 UPDATE
                                     HT3400
                                 SET
                                     Income01 = ( CASE
                                                       WHEN @Orders = 01 THEN Income01 + @Diff
                                                       ELSE Income01
                                                  END ) ,
                                     Income02 = ( CASE
                                                       WHEN @Orders = 02 THEN Income02 + @Diff
                                                       ELSE Income02
                                                  END ) ,
                                     Income03 = ( CASE
                                                       WHEN @Orders = 03 THEN Income03 + @Diff
                                                       ELSE Income03
                                                  END ) ,
                                     Income04 = ( CASE
                                                       WHEN @Orders = 04 THEN Income04 + @Diff
                                                       ELSE Income04
                                                  END ) ,
                                     Income05 = ( CASE
                                                       WHEN @Orders = 05 THEN Income05 + @Diff
                                                       ELSE Income05
                                                  END ) ,
                                     Income06 = ( CASE
                                                       WHEN @Orders = 06 THEN Income06 + @Diff
                                                       ELSE Income06
                                                  END ) ,
                                     Income07 = ( CASE
                                                       WHEN @Orders = 07 THEN Income07 + @Diff
                                                       ELSE Income07
                                                  END ) ,
                                     Income08 = ( CASE
                                                       WHEN @Orders = 08 THEN Income08 + @Diff
                                                       ELSE Income08
                                                  END ) ,
                                     Income09 = ( CASE
                                                       WHEN @Orders = 09 THEN Income09 + @Diff
                                                       ELSE Income09
                                                  END ) ,
                                     Income10 = ( CASE
                                                       WHEN @Orders = 10 THEN Income10 + @Diff
                                                       ELSE Income10
                                                  END ),                                    
                                    Income11 = ( CASE
                                                       WHEN @Orders = 11 THEN Income11 + @Diff
                                                       ELSE Income11
                                                  END ) ,
                                     Income12 = ( CASE
                                                       WHEN @Orders = 12 THEN Income12 + @Diff
                                                       ELSE Income12
                                                  END ) ,
                                     Income13 = ( CASE
                                                       WHEN @Orders = 13 THEN Income13 + @Diff
                                                       ELSE Income13
                                                  END ) ,
                                     Income14 = ( CASE
                                                       WHEN @Orders = 14 THEN Income14 + @Diff
                                                       ELSE Income14
                                                  END ) ,
                                     Income15 = ( CASE
                                                       WHEN @Orders = 15 THEN Income15 + @Diff
                                                       ELSE Income15
                                                  END ) ,
                                     Income16 = ( CASE
                                                       WHEN @Orders = 16 THEN Income16 + @Diff
                                                       ELSE Income16
                                                  END ) ,
                                     Income17 = ( CASE
                                                       WHEN @Orders = 17 THEN Income17 + @Diff
                                                       ELSE Income17
                                                  END ) ,
                                     Income18 = ( CASE
                                                       WHEN @Orders = 18 THEN Income18 + @Diff
                                                       ELSE Income18
                                                  END ) ,
                                     Income19 = ( CASE
                                                       WHEN @Orders = 19 THEN Income19 + @Diff
                                                       ELSE Income19
                                                  END ) ,
                                     Income20 = ( CASE
                                                       WHEN @Orders = 20 THEN Income20 + @Diff
                                                       ELSE Income20
                                                  END )
                                    
                                 WHERE
                                     DivisionID = @DivisionID AND TransactionID = @TransactionID
                           END
                  END
            END

   END
ELSE----Lam tron cac khoan giam tru
   BEGIN
         SET @SumSalaryAmount = 0
         SET @SumSalaryAmount = ( SELECT
                                      Sum(CASE
                                               WHEN @Orders = 01 THEN isnull(SubAmount01 , 0)
                                               ELSE CASE
                                                         WHEN @Orders = 02 THEN isnull(SubAmount02 , 0)
                                                         ELSE CASE
                                                                   WHEN @Orders = 03 THEN isnull(SubAmount03 , 0)
                                                                   ELSE CASE
                                                                             WHEN @Orders = 04 THEN isnull(SubAmount04 , 0)
                                                                             ELSE CASE
                                                                                       WHEN @Orders = 05 THEN isnull(SubAmount05 , 0)
                                                                                       ELSE CASE
                                                                                                 WHEN @Orders = 06 THEN isnull(SubAmount06 , 0)
                                                                                                 ELSE CASE
                                                                                                           WHEN @Orders = 07 THEN isnull(SubAmount07 , 0)
                                                                                                           ELSE CASE
                                                                                                                     WHEN @Orders = 08 THEN isnull(SubAmount08 , 0)
                                                                                                                     ELSE CASE
                                                                                                                               WHEN @Orders = 09 THEN isnull(SubAmount09 , 0)
                                                                                                                               ELSE CASE
                                                                                                                                         WHEN @Orders = 10 THEN isnull(SubAmount10 , 0)
                                                                                                                                         ELSE 0
                                                                                                                                    END
                                                                                                                          END
                                                                                                                END
                                                                                                      END
                                                                                            END
                                                                                  END
                                                                        END
                                                              END
                                                    END
                                          END)
                                  FROM
                                      HT3400
                                  WHERE
                                      DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID AND DepartmentID LIKE @DepartmentID1 AND ISNull(TeamID , '') LIKE ISNULL(@TeamID1 , '') AND TranMonth = @TranMonth AND TranYear = @TranYear ) --and
					--TransactionID =@TransactionID)	
			IF(@SumSalaryAmount = 0)
			BEGIN	
				SET @SumSalaryAmount = ( SELECT
										  Sum(CASE
												   WHEN @Orders = 11 THEN isnull(SubAmount11 , 0)
												   ELSE CASE
															 WHEN @Orders = 12 THEN isnull(SubAmount12 , 0)
															 ELSE CASE
																	   WHEN @Orders = 13 THEN isnull(SubAmount13 , 0)
																	   ELSE CASE
																				 WHEN @Orders = 14 THEN isnull(SubAmount14 , 0)
																				 ELSE CASE
																						   WHEN @Orders = 15 THEN isnull(SubAmount15 , 0)
																						   ELSE CASE
																									 WHEN @Orders = 16 THEN isnull(SubAmount16 , 0)
																									 ELSE CASE
																											   WHEN @Orders = 17 THEN isnull(SubAmount17 , 0)
																											   ELSE CASE
																														 WHEN @Orders = 18 THEN isnull(SubAmount18 , 0)
																														 ELSE CASE
																																   WHEN @Orders = 19 THEN isnull(SubAmount19 , 0)
																																   ELSE CASE
																																			 WHEN @Orders = 20 THEN isnull(SubAmount20 , 0) 
																																			 ELSE 0                                                                                                                                  
																																		END
																															  END
																													END
																										  END
																								END
																					  END
																			END
																  END
														END
											  END)
									  FROM
										  HT3400
									  WHERE
										  DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID AND DepartmentID LIKE @DepartmentID1 AND ISNull(TeamID , '') LIKE ISNULL(@TeamID1 , '') AND TranMonth = @TranMonth AND TranYear = @TranYear ) --and
						--TransactionID =@TransactionID)
				END		
					




----- Lam tron so -----
         IF @SumSalaryAmount <> @SalaryTotal
            BEGIN

                  SET @Diff = @SalaryTotal - @SumSalaryAmount

                  BEGIN
                        SET @TransactionID = ( SELECT TOP 1
                                                   TransactionID
                                               FROM
                                                   HT3400
                                               WHERE
                                                   DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID AND TranMonth = @TranMonth AND TranYear = @TranYear
                                               ORDER BY
                                                   CASE
                                                        WHEN @Orders = 01 THEN isnull(SubAmount01 , 0)
                                                        ELSE CASE
                                                                  WHEN @Orders = 02 THEN isnull(SubAmount02 , 0)
                                                                  ELSE CASE
                                                                            WHEN @Orders = 03 THEN isnull(SubAmount03 , 0)
                                                                            ELSE CASE
                                                                                      WHEN @Orders = 04 THEN isnull(SubAmount04 , 0)
                                                                                      ELSE CASE
                                                                                                WHEN @Orders = 05 THEN isnull(SubAmount05 , 0)
                                                                                                ELSE CASE
                                                                                                          WHEN @Orders = 06 THEN isnull(SubAmount06 , 0)
                                                                                                          ELSE CASE
                                                                                                                    WHEN @Orders = 07 THEN isnull(SubAmount07 , 0)
                                                                                                                    ELSE CASE
                                                                                                                              WHEN @Orders = 08 THEN isnull(SubAmount08 , 0)
                                                                                                                              ELSE CASE
                                                                                                                                        WHEN @Orders = 09 THEN isnull(SubAmount09 , 0)
                                                                                                                                        ELSE CASE
                                                                                                                                                  WHEN @Orders = 10 THEN isnull(SubAmount10 , 0)
                                                                                                                                                  ELSE 0
                                                                                                                                             END
                                                                                                                                   END
                                                                                                                         END
                                                                                                               END
                                                                                                     END
                                                                                           END
                                                                                 END
                                                                       END
                                                             END
                                                   END DESC )
                        
                        IF(@Orders > 10)
                        BEGIN                           
							SET @TransactionID = ( SELECT TOP 1
													   TransactionID
												   FROM
													   HT3400
												   WHERE
													   DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID AND TranMonth = @TranMonth AND TranYear = @TranYear
												   ORDER BY
													   CASE
															WHEN @Orders = 11 THEN isnull(SubAmount11 , 0)
															ELSE CASE
																	  WHEN @Orders = 12 THEN isnull(SubAmount12 , 0)
																	  ELSE CASE
																				WHEN @Orders = 13 THEN isnull(SubAmount13 , 0)
																				ELSE CASE
																						  WHEN @Orders = 14 THEN isnull(SubAmount14 , 0)
																						  ELSE CASE
																									WHEN @Orders = 15 THEN isnull(SubAmount15 , 0)
																									ELSE CASE
																											  WHEN @Orders = 16 THEN isnull(SubAmount16 , 0)
																											  ELSE CASE
																														WHEN @Orders = 17 THEN isnull(SubAmount17 , 0)
																														ELSE CASE
																																  WHEN @Orders = 18 THEN isnull(SubAmount18 , 0)
																																  ELSE CASE
																																			WHEN @Orders = 19 THEN isnull(SubAmount19 , 0)
																																			ELSE CASE
																																					  WHEN @Orders = 20 THEN isnull(SubAmount20 , 0)                                                                                                                                                 
																																				 END
																																	   END
																															 END
																												   END
																										 END
																							   END
																					 END
																		   END
																 END
													   END DESC )
                        END                                           
                                                   
                        IF @TransactionID IS NOT NULL
                           BEGIN


                                 UPDATE
                                     HT3400
                                 SET
                                     SubAmount01 = ( CASE
                                                          WHEN @Orders = 01 THEN SubAmount01 + @Diff
                                                          ELSE SubAmount01
                                                     END ) ,
                                     SubAmount02 = ( CASE
                                                          WHEN @Orders = 02 THEN SubAmount02 + @Diff
                                                          ELSE SubAmount02
                                                     END ) ,
                                     SubAmount03 = ( CASE
                                                          WHEN @Orders = 03 THEN SubAmount03 + @Diff
                                                          ELSE SubAmount03
                                                     END ) ,
                                     SubAmount04 = ( CASE
                                                          WHEN @Orders = 04 THEN SubAmount04 + @Diff
                                                          ELSE SubAmount04
                                                     END ) ,
                                     SubAmount05 = ( CASE
                                                          WHEN @Orders = 05 THEN SubAmount05 + @Diff
                                                          ELSE SubAmount05
                                                     END ) ,
                                     SubAmount06 = ( CASE
                                                          WHEN @Orders = 06 THEN SubAmount06 + @Diff
                                                          ELSE SubAmount06
                                                     END ) ,
                                     SubAmount07 = ( CASE
                                                          WHEN @Orders = 07 THEN SubAmount07 + @Diff
                                                          ELSE SubAmount07
                                                     END ) ,
                                     SubAmount08 = ( CASE
                                                          WHEN @Orders = 08 THEN SubAmount08 + @Diff
                                                          ELSE SubAmount08
                                                     END ) ,
                                     SubAmount09 = ( CASE
                                                          WHEN @Orders = 09 THEN SubAmount09 + @Diff
                                                          ELSE SubAmount09
                                                     END ) ,
                                     SubAmount10 = ( CASE
                                                          WHEN @Orders = 10 THEN SubAmount10 + @Diff
                                                          ELSE SubAmount10
                                                     END ),
                                    SubAmount11 = ( CASE
                                                          WHEN @Orders = 11 THEN SubAmount11 + @Diff
                                                          ELSE SubAmount11
                                                     END ) ,
                                     SubAmount12 = ( CASE
                                                          WHEN @Orders = 12 THEN SubAmount12 + @Diff
                                                          ELSE SubAmount12
                                                     END ) ,
                                     SubAmount13 = ( CASE
                                                          WHEN @Orders = 13 THEN SubAmount13 + @Diff
                                                          ELSE SubAmount13
                                                     END ) ,
                                     SubAmount14 = ( CASE
                                                          WHEN @Orders = 14 THEN SubAmount14 + @Diff
                                                          ELSE SubAmount14
                                                     END ) ,
                                     SubAmount15 = ( CASE
                                                          WHEN @Orders = 15 THEN SubAmount15 + @Diff
                                                          ELSE SubAmount15
                                                     END ) ,
                                     SubAmount16 = ( CASE
                                                          WHEN @Orders = 16 THEN SubAmount16 + @Diff
                                                          ELSE SubAmount16
                                                     END ) ,
                                     SubAmount17 = ( CASE
                                                          WHEN @Orders = 17 THEN SubAmount17 + @Diff
                                                          ELSE SubAmount17
                                                     END ) ,
                                     SubAmount18 = ( CASE
                                                          WHEN @Orders = 18 THEN SubAmount18 + @Diff
                                                          ELSE SubAmount18
                                                     END ) ,
                                     SubAmount19 = ( CASE
                                                          WHEN @Orders = 19 THEN SubAmount19 + @Diff
                                                          ELSE SubAmount19
                                                     END ) ,
                                     SubAmount20 = ( CASE
                                                          WHEN @Orders = 20 THEN SubAmount20 + @Diff
                                                          ELSE SubAmount20
                                                     END )
                                 WHERE
                                     DivisionID = @DivisionID AND TransactionID = @TransactionID
                           END
                  END
            END



   END
*/




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
