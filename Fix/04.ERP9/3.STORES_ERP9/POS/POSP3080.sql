IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP3080]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POSP3080]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Load dong chay chương trinh khuyên mãi
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by:Trà Giang, Date: 22/11/2018
-- <Example>
---- 
/*-- <Example>
 
exec  POSP3080 @DivisionID=N'AT',@ShopID=N'HCM.506CMTT'
----*/

CREATE PROCEDURE POSP3080 
(
	--@APK			VARCHAR(50),
	@DivisionID			VARCHAR(50),
	@ShopID				VARCHAR(50)
	
	
)
AS
DECLARE @sSQL   NVARCHAR(MAX)




SELECT	A.PromotionProgram
INTO #TEMP
FROM
(
-- KM hàng tặng hàng
Select  (AT28.Description + ' ('+CONVERT(varchar(10), AT28.Fromdate, 103) +'->' + 
       CONVERT(varchar(10), AT28.Todate, 103) +')' ) as PromotionProgram 
From POST0010 P10 WITH (NOLOCK) inner join 
      (Select Distinct DivisionID, PromoteID, FromDate, Todate, Description 
       From AT1328 WITH (NOLOCK)
       Where DivisionID = @DivisionID
        and convert(varchar(10), Getdate(), 111) between convert(varchar(10), FromDate, 111) 
        and convert(varchar(10), ToDate, 111)
      ) AT28
     on P10.DivisionID = AT28.DivisionID and P10.PromoteID = AT28.PromoteID
Where P10.DivisionID = @DivisionID and P10.ShopID =  @ShopID and P10.Disabled = 0
UNION 
--KM hàng theo hóa đơn
SELECT (AT28.Description + ' ('+CONVERT(varchar(10), AT28.Fromdate, 103) +'->' + 
       CONVERT(varchar(10), AT28.Todate, 103) +')' ) as PromotionProgram 
FROM POST0010 P10 WITH (NOLOCK)
INNER JOIN (SELECT DivisionID, PromoteID, FromDate, Todate, 
 Case when Isnull(Description,'')='' then PromoteID+N' Từ '+Convert(Nvarchar(50),FromDate,103)+N' Đến '+Convert(Nvarchar(50),ToDate,103) 
 else Description end Description 
            FROM CT0149 WITH (NOLOCK)
    Where DivisionID = @DivisionID
        and convert(varchar(10), Getdate(), 111) between convert(varchar(10), FromDate, 111) 
        and convert(varchar(10), ToDate, 111)) AT28
     on P10.DivisionID = AT28.DivisionID and P10.InvoicePromotionID = AT28.PromoteID
Where P10.DivisionID = @DivisionID and   P10.ShopID =  @ShopID and P10.Disabled = 0
UNION
--KM tăng tiền theo hóa đơn
SELECT distinct (AT28.Description + ' ('+CONVERT(varchar(10), AT28.Fromdate, 103) +'->' + 
       CONVERT(varchar(10), AT28.Todate, 103) +')' ) as PromotionProgram 
FROM POST0010 P10 WITH (NOLOCK)
INNER JOIN (SELECT DivisionID, PromoteID, FromDate, Todate, 
 Case when Isnull(Description,'')='' then PromoteID+N' Từ '+Convert(Nvarchar(50),FromDate,103)+N' Đến '+Convert(Nvarchar(50),ToDate,103) 
 else Description end Description 
            FROM AT0109 WITH (NOLOCK)
    Where DivisionID = @DivisionID
        and convert(varchar(10), Getdate(), 111) between convert(varchar(10), FromDate, 111) 
        and convert(varchar(10), ToDate, 111)) AT28
     on P10.DivisionID = AT28.DivisionID and P10.MoneyPromotionID = AT28.PromoteID
Where P10.DivisionID = @DivisionID and  P10.ShopID =  @ShopID and P10.Disabled = 0


UNION
-- hàng đồng giá
SELECT (O01.Description + ' ('+CONVERT(varchar(10), O01.Fromdate, 103) +'->' + 
       CONVERT(varchar(10), O01.Todate, 103) +')' ) as PromotionProgram 
FROM POST0010 P10 WITH (NOLOCK)
INNER JOIN (SELECT DivisionID, ID, FromDate, Todate, 
 Case when Isnull(Description,'')='' then Description+N' Từ '+Convert(Nvarchar(50),FromDate,103)+N' Đến '+Convert(Nvarchar(50),ToDate,103) 
 else Description end Description 
            FROM OT1301 WITH (NOLOCK)
    Where DivisionID = @DivisionID
        and convert(varchar(10), Getdate(), 111) between convert(varchar(10), FromDate, 111) 
        and convert(varchar(10), ToDate, 111)) O01
     on P10.DivisionID = O01.DivisionID and P10.SimilarListID = O01.ID
Where P10.DivisionID = @DivisionID and  P10.ShopID =  @ShopID and P10.Disabled = 0
-- Bảng giá khuyên mãi 
UNION
SELECT (O01.Description + ' ('+CONVERT(varchar(10), O01.Fromdate, 103) +'->' + 
       CONVERT(varchar(10), O01.Todate, 103) +')' ) as PromotionProgram 
FROM POST0010 P10 WITH (NOLOCK)
INNER JOIN (SELECT DivisionID, ID, FromDate, Todate, 
 Case when Isnull(Description,'')='' then Description+N' Từ '+Convert(Nvarchar(50),FromDate,103)+N' Đến '+Convert(Nvarchar(50),ToDate,103) 
 else Description end Description 
            FROM OT1301 WITH (NOLOCK)
    Where DivisionID = @DivisionID
        and convert(varchar(10), Getdate(), 111) between convert(varchar(10), FromDate, 111) 
        and convert(varchar(10), ToDate, 111)) O01
     on P10.DivisionID = O01.DivisionID and P10.PromotePriceTable = O01.ID
Where P10.DivisionID = @DivisionID and  P10.ShopID =  @ShopID and P10.Disabled = 0
) A



	--khai báo
	DECLARE @curTemp Cursor, @str NVARCHAR(MAX)='', @Value NVARCHAR(MAX)
	SET @curTemp  = Cursor Scroll KeySet FOR 
		SELECT PromotionProgram FROM #temp -- #temp là bảng có n dòng
	OPEN @curTemp
	FETCH NEXT FROM @curTemp INTO @Value
	WHILE @@Fetch_Status = 0
	BEGIN
		-- với mỗi dòng @curTemp lướt qua thì sẽ nối giá trị của @curTemp vào chuỗi

		set @str=@str +'     ,   ' + @Value

		FETCH NEXT FROM @curTemp INTO @Value
	END            
	CLOSE @curTemp
	DEALLOCATE @curTemp

	-- show chuỗi
		select SUBSTRING(@str,9,len(@str)) as PromotionProgram

	--Rollback tran
	











GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
