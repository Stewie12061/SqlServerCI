IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP2021]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP2021]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







-- <Summary>
--- Load Master phiếu báo giá.
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Kiều Nga on: 08/07/2019
---- Modified by Trọng Kiên on 21/10/2020: Bổ sung load tên người tạo và người sửa.
---- Modified by Cập nhật   on 08/07/2021: Load lại trạng thái duyệt.
---- Modified by Văn Tài    on 31/08/2021: Bổ sung ráp tên bảng để không bị lỗi Ambigous các cột duyệt.
---- Modified by Minh Hiếu  on 11/01/2022: Bổ sung load người liên hệ
---- Modified by Hoài Bảo   on 23/05/2022: Thay đổi lấy tình trạng phiếu báo giá từ bảng AT0099 -> CRMT0099
-- <Example>
/*
	EXEC SOP2021 'DTI', '2977ed14-c8b7-478f-abf8-ede2ff241a94', 'b964c015-c496-494b-8cb8-33818d32a7ca', 'PBG'
	EXEC SOP2021 @DivisionID, @QuotationID, @APKMaster, @Type
*/

CREATE PROCEDURE SOP2021
(
	@DivisionID VARCHAR(50),
	@QuotationID VARCHAR(50),
	@APKMaster VARCHAR(50) = '',
	@Type VARCHAR(50) = ''
)
AS

DECLARE @Ssql Nvarchar(max), 
		@Ssql2 Nvarchar(max),
		@Swhere  Nvarchar(max) = '',
		@Level INT,
		@sSQLSL NVARCHAR (MAX) = '',
		@i INT = 1, @s VARCHAR(2),
		@sSQLJon NVARCHAR (MAX) = ''

IF ISNULL(@Type, '') = 'PBG' 
BEGIN
	SET @Swhere = @Swhere + 'AND CONVERT(VARCHAR(50),OT2101.APKMaster_9000)= '''+@APKMaster+''''
	SELECT @Level = MAX(Level) FROM OOT9001 WITH (NOLOCK) WHERE APKMaster = @APKMaster
END
ELSE

BEGIN
	SET @Swhere = @Swhere + 'AND OT2101.QuotationID = '''+@QuotationID+''''
	SELECT @Level = MAX(Level) FROM OOT9001 WITH (NOLOCK) LEFT JOIN OT2101 ON OOT9001.APKMaster = OT2101.APKMaster_9000  WHERE OT2101.APK = @QuotationID
END
	WHILE @i <= @Level
	BEGIN
		IF @i < 10 SET @s = '0' + CONVERT(VARCHAR, @i)
		ELSE SET @s = CONVERT(VARCHAR, @i)
		SET @sSQLSL=@sSQLSL+' , APP'+@s+'.ApprovePerson'+@s+'ID, APP'+@s+'.ApprovePerson'+@s+'Name, APP'+@s+'.ApprovePerson'+@s+'Status, APP'+@s+'.ApprovePerson'+@s+'StatusName, APP'+@s+'.ApprovePerson'+@s+'Note'
		SET @sSQLJon =@sSQLJon+ '
						LEFT JOIN (SELECT ApprovePersonID ApprovePerson'+@s+'ID,OOT1.APKMaster,OOT1.DivisionID,OOT1.Status,
						 HT14.FullName As ApprovePerson'+@s+'Name, 
						OOT1.Status ApprovePerson'+@s+'Status, O99.Description ApprovePerson'+@s+'StatusName,
						OOT1.Note ApprovePerson'+@s+'Note
						FROM OOT9001 OOT1 WITH (NOLOCK)
						INNER JOIN AT1103 HT14 WITH (NOLOCK) ON (HT14.DivisionID=OOT1.DivisionID OR ISNULL(HT14.DivisionID,'''') = ''@@@'') AND HT14.EmployeeID=OOT1.ApprovePersonID
						LEFT JOIN OOT0099 O99 WITH (NOLOCK) ON O99.ID1=ISNULL(OOT1.Status,0) AND O99.CodeMaster=''Status''
						WHERE OOT1.Level='+STR(@i)+'
						)APP'+@s+' ON APP'+@s+'.DivisionID= OOT90.DivisionID  AND APP'+@s+'.APKMaster=OOT90.APK'
		SET @i = @i + 1		
	END	

SET @Ssql = '
	SELECT  OT2101.APK,OT2101.QuotationID, OT2101.QuotationNo, OT2101.DivisionID, OT2101.TranMonth, OT2101.TranYear,POST0011.Tel,OT2101.QuotationDate,OT2101.InventoryTypeID, AT1301.InventoryTypeName,OT2101.ObjectID,OT2101.ObjectName,  
	OT2101.EmployeeID,AT1103.FullName as EmployeeName,OT2101.Disabled,OT2101.OrderStatus,B.Description as OrderStatusName,OT2101.RefNo1,OT2101.RefNo2,OT2101.RefNo3,OT2101.Attention1,OT2101.Attention2,OT2101.Dear,OT2101.Condition, 
	OT2101.SaleAmount,OT2101.PurchaseAmount,OT2101.CurrencyID,AT1004.CurrencyName,OT2101.ExchangeRate,OT2101.Ana01ID,OT2101.Ana02ID,OT2101.Ana03ID,OT2101.Ana04ID,OT2101.Ana05ID,OT1002_1.AnaName as Ana01Name,OT1002_2.AnaName as Ana02Name, 
	OT1002_3.AnaName as Ana03Name,OT1002_4.AnaName as Ana04Name,OT1002_5.AnaName as Ana05Name, OT2101.CreateUserID +''_''+ A2.FullName as CreateUserID, OT2101.CreateDate, OT2101.LastModifyUserID +''_''+ A3.FullName as LastModifyUserID,
	OT2101.LastModifyDate,OT2101.IsSO,OT2101.Description,OT2101.VoucherTypeID, OT2101.EndDate,OT2101.Transport,OT2101.DeliveryAddress,case when isnull(OT2101.Address,'''') <> '''' then OT2101.Address else POST0011.Address end as Address,
	OT2101.PaymentID,OT2101.PaymentTermID,AT1208.PaymentTermName,AT1205.PaymentName,OT2101.ApportionID,OT2101.IsConfirm, OT2101.DescriptionConfirm,OT2101.NumOfValidDays,OT2101.Varchar01,OT2101.Varchar02,OT2101.Varchar03,OT2101.Varchar04,OT2101.Varchar05,OT2101.Varchar06,OT2101.Varchar07,
	OT2101.Varchar08,OT2101.Varchar09,OT2101.Varchar10,OT2101.Varchar11, OT2101.Varchar12,OT2101.Varchar13,OT2101.Varchar14,OT2101.Varchar15,OT2101.Varchar16,OT2101.Varchar17,OT2101.Varchar18,OT2101.Varchar19,OT2101.Varchar20,OT2101.QuotationStatus,
	OT2101.RelatedToTypeID,	OV0002.Description AS QuotationStatusDescription,OV0002.EDescription AS QuotationStatusEDescription,OT2101.PriceListID, OT2101.SalesManID, F.FullName as SalesManName, OT2101.OpportunityID, A.OpportunityName,OT2101.APKMaster_9000,
	OT2101.Coefficient as TotalCoefficient,Factor,ProfileCost,InternalShipCost,TaxImport,CustomsCost,CustomsInspectionCost,TT_Cost,LC_Open,LC_Receice,WarrantyCost,InformType,TaxFactor1
	,TaxFactor2,TaxCost,GuestsCost,SurveyCost,PlusCost,TotalCost,Revenue,PlusSaleCost,InheritNC,InheritKHCU,ST62.RevenueDetail,ST62.DiscountAmount, OT2101.Ana06ID,T06.AnaName as Ana06Name
	,OT2101.TaskID,OT2101.TaskID +''_''+ D24.TaskName as TaskName
	,OT2101.ContactorID, CRMT10001.ContactName AS ContactorName, CRMT10001.TitleContact AS DutyID
	'+@sSQLSL+''

set @Ssql2 = ' FROM OT2101 With (NOLOCK)
	LEFT JOIN OOT9000 OOT90 WITH (NOLOCK) ON OT2101.APKMaster_9000 = OOT90.APK
	LEFT JOIN POST0011 With (NOLOCK) on POST0011.MemberID = OT2101.ObjectID 
	LEFT JOIN CRMT20501 A With (NOLOCK) on OT2101.OpportunityID = A.OpportunityID 
	LEFT JOIN AT1004 With (NOLOCK) on AT1004.CurrencyID = OT2101.CurrencyID 
	LEFT JOIN AT1301 With (NOLOCK) on AT1301.InventoryTypeID = OT2101.InventoryTypeID 
	LEFT JOIN AT1103 With (NOLOCK) on AT1103.EmployeeID = OT2101.EmployeeID 
	LEFT JOIN AT1103 F With (NOLOCK) on F.EmployeeID = OT2101.SalesManID 
	LEFT JOIN AT0099 With (NOLOCK) on OT2101.OrderStatus = AT0099.ID AND AT0099.CodeMaster =''AT00000003''
	LEFT JOIN OT1002 OT1002_1 With (NOLOCK) on OT1002_1.AnaID = OT2101.Ana01ID AND OT1002_1.AnaTypeID = ''S01''
	LEFT JOIN OT1002 OT1002_2 With (NOLOCK) on OT1002_2.AnaID = OT2101.Ana02ID AND OT1002_2.AnaTypeID = ''S02''
	LEFT JOIN OT1002 OT1002_3 With (NOLOCK) on OT1002_3.AnaID = OT2101.Ana03ID AND OT1002_3.AnaTypeID = ''S03''
	LEFT JOIN OT1002 OT1002_4 With (NOLOCK) on OT1002_4.AnaID = OT2101.Ana04ID AND OT1002_4.AnaTypeID = ''S04''
	LEFT JOIN OT1002 OT1002_5 With (NOLOCK) on OT1002_5.AnaID = OT2101.Ana05ID AND OT1002_5.AnaTypeID = ''S05''
	LEFT JOIN AT1011 T06 WITH (NOLOCK) ON T06.AnaID = OT2101.Ana06ID AND T06.AnaTypeID = ''A06''
	LEFT JOIN AT0099 A1 With (NOLOCK) on A1.ID = OT2101.IsConfirm AND A1.CodeMaster = ''AT00000039''
	LEFT JOIN OV0002 With (NOLOCK) ON OV0002.DivisionID = OT2101.DivisionID and OV0002.Status = OT2101.QuotationStatus And OV0002.Mode = 1 AND OV0002.TypeID = ''QO''
	LEFT JOIN SOT2062 ST62 WITH (NOLOCK) ON ST62.APK_OT2101 = OT2101.APK
	LEFT JOIN OOT2110 D24 With (NOLOCK) on OT2101.TaskID = D24.TaskID and OT2101.DivisionID = D24.DivisionID
	LEFT JOIN AT1103 A2 WITH (NOLOCK) ON A2.EmployeeID = OT2101.CreateUserID
    LEFT JOIN AT1103 A3 WITH (NOLOCK) ON A3.EmployeeID = OT2101.LastModifyUserID
	LEFT JOIN AT1205 WITH (NOLOCK) ON AT1205.PaymentID = OT2101.PaymentID AND AT1205.Disabled = 0 
	LEFT JOIN AT1208 WITH (NOLOCK) ON AT1208.PaymentTermID = OT2101.PaymentTermID AND AT1208.Disabled = 0 
	LEFT JOIN CRMT10001 WITH (NOLOCK) ON OT2101.ContactorID = CRMT10001.ContactID
	LEFT JOIN CRMT0099 B With (NOLOCK) ON CONVERT(VARCHAR, OT2101.QuotationStatus) = B.ID and B.CodeMaster = ''CRMT00000015''
	'+@sSQLJon+'
	WHERE OT2101.DivisionID = '''+@DivisionID+''' '+@Swhere+''

EXEC (@Ssql + @Ssql2)
PRINT (@Ssql) 
print (@Ssql2)







GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

