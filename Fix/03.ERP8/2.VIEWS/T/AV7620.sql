IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV7620]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[AV7620]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




--View chet
--Creater by Nguyen Quoc Huy, Date 13/10/2008
--In bao cao ket qua kinh doanh theo ma phan tich
---- Modified on 05/11/2012 by Lê Thị Thu Hiền : Bổ sung JOIN DivisionID
---- Modified on 15/01/2013 by Thiên Huỳnh : Bổ sung LevelID
---- Modified on 17/04/2013 by Lê Thị Thu Hiền : Amount21,	Amount22,	Amount23,	Amount24,
---- Modified on 22/07/2013 by Lê Thị Thu Hiền : Bổ sung DivisionName, DivisionNameE
---- Modify on 24/05/2016 by Bảo Anh: Bổ sung With (Nolock)
---- Modified on 30/06/2016 by Kim Vũ: Bổ sung trường LineCodeID
---- Modified on 30/09/2016 by Phương Thảo: Bổ sung group theo mã phân tích
---- Modified on 11/01/2019 by Kim Thư: Bổ sung cột AMount00 - Lũy kế từ đầu năm của kỳ hiện tại đến kỳ hiện tại
---- Modified on 18/07/2020 by Văn Tài: Bổ sung bảng cho LevelID. Loại bỏ Amount00.
---- Modified on 14/10/2020 by Văn Tài: Bổ sung lại cốt Amount00, vì cấu trúc bảng AT7622 đã có bổ sung cột này.
---- Modified on 29/11/2023 by Trọng Phúc: Bổ sung cột AnaID.
---- SELECT * FROM AV7620
CREATE VIEW [dbo].[AV7620] as
SELECT 	
	AT7621.LevelID,
	AT7621.LineDescription,
	AT7621.LineCode,	
	AT7622.Amount00,
	AT7622.Amount01,
	AT7622.Amount02,
	AT7622.Amount03,
	AT7622.Amount04,
	AT7622.Amount05,
	AT7622.Amount06,
	AT7622.Amount07,
	AT7622.Amount08,
	AT7622.Amount09,
	AT7622.Amount10,
	AT7622.Amount11,
	AT7622.Amount12,
	AT7622.Amount13,
	AT7622.Amount14,
	AT7622.Amount15,
	AT7622.Amount16,
	AT7622.Amount17,
	AT7622.Amount18,
	AT7622.Amount19,
	AT7622.Amount20,
	AT7622.Amount21,
	AT7622.Amount22,
	AT7622.Amount23,
	AT7622.Amount24,
	AT7622.Amount01A,
	AT7622.Amount02A,
	AT7622.Amount03A,
	AT7622.Amount04A,
	AT7622.Amount05A,
	AT7622.Amount06A,
	AT7622.Amount07A,
	AT7622.Amount08A,
	AT7622.Amount09A,
	AT7622.Amount10A,
	AT7622.Amount11A,
	AT7622.Amount12A,
	AT7622.Amount13A,
	AT7622.Amount14A,
	AT7622.Amount15A,
	AT7622.Amount16A,
	AT7622.Amount17A,
	AT7622.Amount18A,
	AT7622.Amount19A,
	AT7622.Amount20A,
	AT7622.Amount21A,
	AT7622.Amount22A,
	AT7622.Amount23A,
	AT7622.Amount24A,
	AT7622.DivisionID,
	AT1101.DivisionName,
	AT1101.DivisionNameE,
	Amount01LastPeriod,
	Amount02LastPeriod,
	Amount03LastPeriod,
	Amount04LastPeriod,
	Amount05LastPeriod,
	Amount06LastPeriod,
	Amount07LastPeriod,
	Amount08LastPeriod,
	Amount09LastPeriod,
	Amount10LastPeriod,
	Amount11LastPeriod,
	Amount12LastPeriod,
	Amount13LastPeriod,
	Amount14LastPeriod,
	Amount15LastPeriod,
	Amount16LastPeriod,
	Amount17LastPeriod,
	Amount18LastPeriod,
	Amount19LastPeriod,
	Amount20LastPeriod,
	Amount21LastPeriod,
	Amount22LastPeriod,
	Amount23LastPeriod,
	Amount24LastPeriod,
	Amount01ALastPeriod,
	Amount02ALastPeriod,
	Amount03ALastPeriod,
	Amount04ALastPeriod,
	Amount05ALastPeriod,
	Amount06ALastPeriod,
	Amount07ALastPeriod,
	Amount08ALastPeriod,
	Amount09ALastPeriod,
	Amount10ALastPeriod,
	Amount11ALastPeriod,
	Amount12ALastPeriod,
	Amount13ALastPeriod,
	Amount14ALastPeriod,
	Amount15ALastPeriod,
	Amount16ALastPeriod,
	Amount17ALastPeriod,
	Amount18ALastPeriod,
	Amount19ALastPeriod,
	Amount20ALastPeriod,
	Amount21ALastPeriod,
	Amount22ALastPeriod,
	Amount23ALastPeriod,
	Amount24ALastPeriod,	
	SUBSTRING(AT7621.LineID,0,3) + SUBSTRING(AT7621.LineID,4,2) as LineCodeID,
	AT7621.CaculatorID,
	AT6000.Description AS Caculator,
	AT7622.[GroupID1],
	AT7622.[GroupID2],
	AT7622.[GroupID3],
	AT7622.[GroupID4],
	AT7622.[GroupID5],
	AT7622.[GroupName1],
	AT7622.[GroupName2],
	AT7622.[GroupName3],
	AT7622.[GroupName4],
	AT7622.[GroupName5],
	AT7621.ReportCode,
	AT1011.AnaID
FROM		AT7622 WITH (NOLOCK)
INNER JOIN	AT7621 WITH (NOLOCK) 
	ON		AT7621.ReportCode = AT7622.ReportCode AND AT7621.LineID = AT7622.LineID AND AT7622.DivisionID = AT7621.DivisionID
LEFT JOIN	AT1101 WITH (NOLOCK) ON AT1101.DivisionID = AT7622.DivisionID
LEFT JOIN  AT6000 WITH (NOLOCK) On AT7621.DivisionID = AT6000.DivisionID AND AT7621.CaculatorID = AT6000.Code AND AT6000.Type = 0 and AT6000.Disabled = 0		
LEFT JOIN AT1011 WITH (NOLOCK) ON AT1011.AnaID = AT7621.FromAnaID AND AT1011.AnaID = AT7621.ToAnaID AND AT1011.AnaTypeID = AT7621.AnaTypeID
WHERE AT7621.IsPrint = 1
---SELECT * FROM AT7621





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

