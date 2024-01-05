IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE [NAME] = 'ToRoman' AND [TYPE] = 'FN')
	DROP FUNCTION ToRoman
GO

CREATE FUNCTION [dbo].[ToRoman] (@Number INT)
  /**
 summary:   >
 This is a simple routine for converting a decimal integer into a roman numeral.
 Author: Phil Factor
 Revision: 1.2
 date: 3rd Feb 2014
 Why: converted to run on SQL Server 2008-12
 example:
      - code: Select dbo.ToRomanNumerals(187)
      - code: Select dbo.ToRomanNumerals(2011)
 returns:   >
 The Mediaeval-style 'roman' numeral as a string.
 **/   
 RETURNS NVARCHAR(100)
 AS
 BEGIN
  IF @Number<0
     BEGIN
     RETURN 'De romanorum non numero negative'
     end                          
   IF @Number> 200000
     BEGIN
     RETURN 'O Juppiter, magnus numerus'
     end                          
   DECLARE @RomanNumeral AS NVARCHAR(100)
   DECLARE @RomanSystem TABLE (symbol NVARCHAR(20) 
                                   COLLATE SQL_Latin1_General_Cp437_BIN ,
                               DecimalValue INT PRIMARY key)
    INSERT  INTO @RomanSystem (symbol, DecimalValue)
     VALUES('I', 1),
           ('IV', 4),
           ('V', 5),
           ('IX', 9),
           ('X', 10),
           ('XL', 40),
           ('L', 50),
           ('XC', 90),
           ('C', 100),
           ('CD', 400),
           ('D', 500),
           ('CM', 900),
           ('M', 1000),
           (N'|ↄↄ', 5000),
           (N'cc|ↄↄ', 10000),
           (N'|ↄↄↄ', 50000),
           (N'ccc|ↄↄↄ', 100000),
           (N'ccc|ↄↄↄↄↄↄ', 150000)
  
   WHILE @Number > 0
     SELECT  @RomanNumeral = COALESCE(@RomanNumeral, '') + symbol,
             @Number = @Number - DecimalValue
     FROM    @RomanSystem
     WHERE   DecimalValue = (SELECT  MAX(DecimalValue)
                             FROM    @RomanSystem
                             WHERE   DecimalValue <= @number)
   RETURN COALESCE(@RomanNumeral,'nulla')
   end