IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HV0383]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[HV0383]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- View chết đổ dữ liệu cho combo loại dữ liệu 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- Noi goi: HRM/ Danh mục/ Thiết lập báo cáo/ 
---- Báo cáo chấm công - HF0383
-- <History>
---- Create on 06/05/2016 by Phuong Thao: 
---- Modified on 
-- <Example>


CREATE  View [dbo].[HV0383] As 

SELECT 'Amount01' AS DataTypeID, N'Nghỉ việc riêng, nghỉ ốm' AS DataTypeName
UNION ALL
SELECT 'Amount02' AS DataTypeID, N'Nghỉ không trừ tiền thưởng chuyên cần' AS DataTypeName
UNION ALL
SELECT 'Amount03' AS DataTypeID, N'Nghỉ  thai sản' AS DataTypeName
UNION ALL
SELECT 'Amount04' AS DataTypeID, N'Số giờ bỏ làm, đến muộn, về sớm' AS DataTypeName
UNION ALL
SELECT 'Amount05' AS DataTypeID, N'Số giờ nghỉ phép năm' AS DataTypeName
UNION ALL
SELECT 'Amount06' AS DataTypeID, N'Số giờ nghỉ chế độ (cưới, ma chay, nuôi con nhỏ,nghỉ bù..)' AS DataTypeName
UNION ALL
SELECT 'Amount07' AS DataTypeID, N'Số giờ nghỉ TNLĐ' AS DataTypeName
UNION ALL
SELECT 'Amount08' AS DataTypeID, N'Số giờ trợ cấp OT cố dịnh khối VP, gián tiếp' AS DataTypeName
UNION ALL
SELECT 'Amount09' AS DataTypeID, N'Số giờ trợ cấp 2h phụ nữ' AS DataTypeName
UNION ALL
SELECT 'Amount10' AS DataTypeID, N'OT Ngày thường - Ngày(150%)' AS DataTypeName
UNION ALL
SELECT 'Amount11' AS DataTypeID, N'OT Ngày thường - Đêm (215%)' AS DataTypeName
UNION ALL
SELECT 'Amount12' AS DataTypeID, N'OT Ngày nghỉ - Ngày(200%)' AS DataTypeName
UNION ALL
SELECT 'Amount13' AS DataTypeID, N'OT Ngày nghỉ - Đêm (280%)' AS DataTypeName
UNION ALL
SELECT 'Amount14' AS DataTypeID, N'OT Ngày lễ - Ngày(300%)' AS DataTypeName
UNION ALL
SELECT 'Amount15' AS DataTypeID, N'OT Ngày lễ  - Đêm (410%)' AS DataTypeName
UNION ALL
SELECT 'Amount16' AS DataTypeID, N'Số giờ trợ cấp phát sinh ca đêm (30%)' AS DataTypeName
UNION ALL
SELECT 'Amount17' AS DataTypeID, N'Số giờ hưởng trợ cấp làm ca đêm (12h/ngày ca đêm)' AS DataTypeName
UNION ALL
SELECT 'Amount18' AS DataTypeID, N'Số giờ nghỉ chờ việc' AS DataTypeName
UNION ALL
SELECT 'Amount19' AS DataTypeID, N'Số ngày hưởng trợ cấp đi lại' AS DataTypeName
UNION ALL
SELECT 'Amount20' AS DataTypeID, N'Số ngày hưởng trợ cấp tiền ăn trưa (ra ngoài)' AS DataTypeName
UNION ALL
SELECT 'Amount21' AS DataTypeID, N'Số ngày hưởng trợ cấp ăn sáng (ra ngoài)' AS DataTypeName
UNION ALL
SELECT 'Amount22' AS DataTypeID, N'Số ngày khẩu trừ tiền ăn (1/2 giá trị 1 bữa sáng)' AS DataTypeName
UNION ALL
SELECT 'Amount23' AS DataTypeID, N'Loại dữ liệu số 23' AS DataTypeName
UNION ALL
SELECT 'Amount24' AS DataTypeID, N'Loại dữ liệu số 24' AS DataTypeName
UNION ALL
SELECT 'Amount25' AS DataTypeID, N'Loại dữ liệu số 25' AS DataTypeName





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

