-- <Summary>
---- Insert dữ liệu phân quyền vào bảng ST10504
-- <History>
---- Create on 19/08/2020 by Tấn Thành

DECLARE @CustomerName INT
--Tao bang tam de kiem tra day co phai la khach hang CustomerIndex 
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

DECLARE @OrderNo INT, @ID VARCHAR(50), @Description NVARCHAR(250), @DescriptionE NVARCHAR(250), @Disabled TINYINT, @LanguageID VARCHAR(50) = NULL, @ModuleID VARCHAR(50)

----------Phân quyền Xem dữ liệu
SET @OrderNo = 1  
SET @ID = 'LeadID' 
SET @ModuleID = 'AsoftCRM'
SET @Description = N'Đầu mối' 
SET @DescriptionE = N'Lead' 
SET @Disabled = 0 
SET @LanguageID ='A00.Lead'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID) INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID]) VALUES ( @OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID) ELSE UPDATE ST10504 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, ModuleID = @ModuleID WHERE ID = @ID 
---------
SET @OrderNo = 2  
SET @ID = 'ContactID' 
SET @ModuleID = 'AsoftCRM'
SET @Description = N'Liên hệ' 
SET @DescriptionE = N'Contact' 
SET @Disabled = 0 
SET @LanguageID ='A00.Contact'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID) INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID]) VALUES ( @OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID) ELSE UPDATE ST10504 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, ModuleID = @ModuleID WHERE ID = @ID 
---------
SET @OrderNo = 3  
SET @ID = 'ObjectID' 
SET @ModuleID = 'AsoftCRM'
SET @Description = N'Đối tượng' 
SET @DescriptionE = N'Object' 
SET @Disabled = 0 
SET @LanguageID ='A00.Object'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID) INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID]) VALUES ( @OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID) ELSE UPDATE ST10504 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, ModuleID = @ModuleID WHERE ID = @ID 
---------
SET @OrderNo = 4  
SET @ID = 'CampainID' 
SET @ModuleID = 'AsoftCRM'
SET @Description = N'Chiến dịch' 
SET @DescriptionE = N'Campain' 
SET @Disabled = 0 
SET @LanguageID ='A00.Campain'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID) INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID]) VALUES ( @OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID) ELSE UPDATE ST10504 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, ModuleID = @ModuleID WHERE ID = @ID 
---------
SET @OrderNo = 5  
SET @ID = 'OpportunityID' 
SET @ModuleID = 'AsoftCRM'
SET @Description = N'Cơ hội' 
SET @DescriptionE = N'Opportunity' 
SET @Disabled = 0 
SET @LanguageID ='A00.Opportunity'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID) INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID]) VALUES ( @OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID) ELSE UPDATE ST10504 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, ModuleID = @ModuleID WHERE ID = @ID 
---------
SET @OrderNo = 6  
SET @ID = 'QuotationID' 
SET @ModuleID = 'AsoftSO'
SET @Description = N'Báo giá' 
SET @DescriptionE = N'Quotation' 
SET @Disabled = 0 
SET @LanguageID ='A00.Quotation'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID) INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID]) VALUES ( @OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID) ELSE UPDATE ST10504 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, ModuleID = @ModuleID WHERE ID = @ID 
---------
SET @OrderNo = 7 
SET @ID = 'SOrderID' 
SET @ModuleID = 'AsoftCRM'
SET @Description = N'Đơn hàng bán' 
SET @DescriptionE = N'SOrder' 
SET @Disabled = 0 
SET @LanguageID ='A00.SOrder'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID) INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID]) VALUES ( @OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID) ELSE UPDATE ST10504 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, ModuleID = @ModuleID WHERE ID = @ID 
---------
SET @OrderNo = 8
SET @ID = 'GroupReceiverID' 
SET @ModuleID = 'AsoftCRM'
SET @Description = N'Nhóm người nhận' 
SET @DescriptionE = N'GroupReceiver' 
SET @Disabled = 0 
SET @LanguageID ='A00.GroupReceiver'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID) INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID]) VALUES ( @OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID) ELSE UPDATE ST10504 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, ModuleID = @ModuleID WHERE ID = @ID 

---------
SET @OrderNo = 9
SET @ID = 'RequestID' 
SET @ModuleID = 'AsoftHRM'
SET @Description = N'Yêu cầu' 
SET @DescriptionE = N'Request' 
SET @Disabled = 0 
SET @LanguageID ='A00.Request'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID) INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID]) VALUES ( @OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID) ELSE UPDATE ST10504 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, ModuleID = @ModuleID WHERE ID = @ID 

---------
SET @OrderNo = 10
SET @ID = 'EventID' 
SET @ModuleID = 'AsoftCRM'
SET @Description = N'Sự kiện' 
SET @DescriptionE = N'Event' 
SET @Disabled = 0 
SET @LanguageID ='A00.Event'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID) INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID]) VALUES ( @OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID) ELSE UPDATE ST10504 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, ModuleID = @ModuleID WHERE ID = @ID 
---------Modify by Cao thị Phượng bổ sung phân quyền tệp đính kèm
SET @OrderNo = 11
SET @ID = 'AttachID' 
SET @ModuleID = 'AsoftCRM'
SET @Description = N'Đính kèm' 
SET @DescriptionE = N'Attach' 
SET @Disabled = 0 
SET @LanguageID ='A00.Attach'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID) INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID]) VALUES ( @OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID) ELSE UPDATE ST10504 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, ModuleID = @ModuleID WHERE ID = @ID 

---------Modify by Hoàng vũ bổ sung phân quyền [Cá nhân tự đánh giá (KPI)]
SET @OrderNo = 12
SET @ID = 'AssessmentSelfID' 
SET @ModuleID = 'AsoftCRM'
SET @Description = N'Cá nhân tự đánh giá (KPI)' 
SET @DescriptionE = N'Self assessment' 
SET @Disabled = 0 
SET @LanguageID ='A00.AssessmentSelfID'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID) INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID]) VALUES ( @OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID) ELSE UPDATE ST10504 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, ModuleID = @ModuleID WHERE ID = @ID 

---------Modify by Hoàng vũ bổ sung phân quyền [Tính thưởng (KPI)]
SET @OrderNo = 13
SET @ID = 'BonusFeatureID' 
SET @ModuleID = 'AsoftCRM'
SET @Description = N'Tính thưởng (KPI)' 
SET @DescriptionE = N'Bonus Feature' 
SET @Disabled = 0 
SET @LanguageID ='A00.BonusFeatureID'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID) INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID]) VALUES ( @OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID) ELSE UPDATE ST10504 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, ModuleID = @ModuleID WHERE ID = @ID 

---------Modify by Hoàng vũ bổ sung phân quyền Đánh giá năng lực (PA)
SET @OrderNo = 14
SET @ID = 'AppraisalSelfID' 
SET @ModuleID = 'AsoftCRM'
SET @Description = N'Đánh giá năng lực' 
SET @DescriptionE = N'Self Appraisal' 
SET @Disabled = 0 
SET @LanguageID ='A00.AppraisalSelfID'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID) INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID]) VALUES ( @OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID) ELSE UPDATE ST10504 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, ModuleID = @ModuleID WHERE ID = @ID 

---------- Asoft-APP (Asoft best seller)
SET @OrderNo = 15
SET @ID = 'APPSaleOrderID' 
SET @ModuleID = 'AsoftSO'
SET @Description = N'Đơn hàng bán dưới APP'  
SET @DescriptionE = N'App Sale Order'
SET @Disabled = 0 
SET @LanguageID ='A00.APPSaleOrderID'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID) INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID]) VALUES ( @OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID) ELSE UPDATE ST10504 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, ModuleID = @ModuleID WHERE ID = @ID 

-----------Modify by Hoàng vũ bổ sung phân quyền Phiếu bảo hành (OKIA)
IF @CustomerName = 87
BEGIN
	SET @OrderNo = 16
	SET @ID = 'ConditionWarrantyID' 
	SET @ModuleID = 'AsoftHRM'
	SET @Description = N'Đơn hàng bán dưới APP'  
	SET @DescriptionE = N'Warranty Voucher'
	SET @Disabled = 0 
	SET @LanguageID ='A00.ConditionWarrantyID'
	IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID) INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID]) VALUES ( @OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID) ELSE UPDATE ST10504 SET OrderNo = @OrderNo, [Description] = @Description,DescriptionE = @DescriptionE, [Disabled] =@Disabled, [LanguageID]= @LanguageID, ModuleID = @ModuleID WHERE ID = @ID 
END

--------- Modify by Vĩnh Tâm on 27/09/2019: bổ sung phân quyền Công việc
SET @OrderNo = 17
SET @ID = 'TaskID'
SET @ModuleID = 'AsoftOO'
SET @Description = N'Công việc'
SET @DescriptionE = N'Task'
SET @Disabled = 0
SET @LanguageID ='A00.Task'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID

--------- Modify by Vĩnh Tâm on 27/09/2019: bổ sung phân quyền Dự án
SET @OrderNo = 18
SET @ID = 'ProjectID'
SET @ModuleID = 'AsoftOO'
SET @Description = N'Dự án/nhóm công việc'
SET @DescriptionE = N'Project/Group task'
SET @Disabled = 0
SET @LanguageID ='A00.Project'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID

--------- Modify by Vĩnh Tâm on 27/09/2019: bổ sung phân quyền Dự án
SET @OrderNo = 19
SET @ID = 'AssessTask'
SET @ModuleID = 'AsoftOO'
SET @Description = N'Đánh giá công việc'
SET @DescriptionE = N'Assess task'
SET @Disabled = 0
SET @LanguageID ='A00.AssessTask'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID

--------- Modify by Vĩnh Tâm on 27/09/2019: bổ sung phân quyền Định mức dự án
SET @OrderNo = 20
SET @ID = 'ProjectQuota'
SET @ModuleID = 'AsoftOO'
SET @Description = N'Định mức dự án'
SET @DescriptionE = N'Project quota'
SET @Disabled = 0
SET @LanguageID ='A00.ProjectQuota'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID

--------- Modify by Vĩnh Tâm on 27/09/2019: bổ sung phân quyền Thông báo
SET @OrderNo = 21
SET @ID = 'Inform'
SET @ModuleID = 'AsoftOO'
SET @Description = N'Thông báo'
SET @DescriptionE = N'Inform'
SET @Disabled = 0
SET @LanguageID ='A00.Inform'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID

--------- Modify by Vĩnh Tâm on 27/09/2019: bổ sung phân quyền Tính lương mềm
SET @OrderNo = 22
SET @ID = 'CalculateEffectiveSalary'
SET @ModuleID = 'AsoftKPI'
SET @Description = N'Tính lương mềm'
SET @DescriptionE = N'Calculate Effective salary'
SET @Disabled = 0
SET @LanguageID ='A00.CalculateEffectiveSalary'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID

--------- Modify by Bảo toàn on 01/10/2019: bổ sung phân quyền Yêu cầu mua hàng
SET @OrderNo = 23
SET @ID = 'PurchaseRequest'
SET @ModuleID = 'AsoftPO'
SET @Description = N'Yêu cầu mua hàng'
SET @DescriptionE = N'Goods purchase request'
SET @Disabled = 0
SET @LanguageID ='A00.PurchaseRequest'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID

--------- Modify by Bảo toàn on 01/10/2019: bổ sung phân quyền Báo giá nhà cung cấp
SET @OrderNo = 23
SET @ID = 'SupplierQuote'
SET @ModuleID = 'AsoftPO'
SET @Description = N'Báo giá nhà cung cấp'
SET @DescriptionE = N'Supplier quote'
SET @Disabled = 0
SET @LanguageID ='A00.SupplierQuote'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID

--------- Modify by Bảo toàn on 01/10/2019: bổ sung phân quyền ĐƠN HÀNG MUA
SET @OrderNo = 24
SET @ID = 'PurchaseOrders'
SET @ModuleID = 'AsoftPO'
SET @Description = N'Đơn hàng mua'
SET @DescriptionE = N'Purchase orders'
SET @Disabled = 0
SET @LanguageID ='A00.PurchaseOrders'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID

--------- Modify by Bảo toàn on 01/10/2019: bổ sung phân quyền ĐƠN HÀNG MUA
SET @OrderNo = 24
SET @ID = 'PurchaseOrders'
SET @ModuleID = 'AsoftCI'
SET @Description = N'Đơn hàng mua'
SET @DescriptionE = N'Purchase orders'
SET @Disabled = 0
SET @LanguageID ='A00.PurchaseOrders'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID
--------- Modify by Bảo toàn on 01/10/2019: bổ sung phân quyền HỢP ĐỒNG
SET @OrderNo = 26
SET @ID = 'Contract'
SET @ModuleID = 'AsoftCI'
SET @Description = N'Hợp đồng'
SET @DescriptionE = N'Contract '
SET @Disabled = 0
SET @LanguageID ='A00.Contract '
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID

--------- Modify by Bảo toàn on 03/10/2019: bổ sung phân quyền HỢP ĐỒNG
IF EXISTS(SELECT 1 FROM CustomerIndex WHERE CustomerName = '114')
BEGIN
	SET @OrderNo = 27
	SET @ID = 'QuotaID'
	SET @ModuleID = 'AsoftSO'
	SET @Description = N'Hạn mức Quota'
	SET @DescriptionE = N'Quota Sale '
	SET @Disabled = 0
	SET @LanguageID ='A00.QuotaID '
	IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
		INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
		VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
	ELSE
		UPDATE ST10504
		SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
		WHERE ID = @ID
END

-------- Modify by Bảo toàn on 04/10/2019: bổ sung phân quyền HỢP ĐỒNG
SET @OrderNo = 28
SET @ID = 'SabbaticalProfileID'
SET @ModuleID = 'AsoftHRM'
SET @Description = N'Danh mục hồ sơ phép'
SET @DescriptionE = N' '
SET @Disabled = 0
SET @LanguageID ='A00.SabbaticalProfileID'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID

SET @OrderNo = 29
SET @ID = 'RecruitPlanID'
SET @ModuleID = 'AsoftHRM'
SET @Description = N'Kế hoạch tuyển dụng'
SET @DescriptionE = N''
SET @Disabled = 0
SET @LanguageID ='A00.RecruitPlanID'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID

SET @OrderNo = 30
SET @ID = 'RecruitPeriodID'
SET @ModuleID = 'AsoftHRM'
SET @Description = N'Đợt phỏng vấn'
SET @DescriptionE = N''
SET @Disabled = 0
SET @LanguageID ='A00.RecruitPeriodID'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID

SET @OrderNo = 31
SET @ID = 'InterviewScheduleID'
SET @ModuleID = 'AsoftHRM'
SET @Description = N'Lịch phỏng vấn'
SET @DescriptionE = N''
SET @Disabled = 0
SET @LanguageID ='A00.InterviewScheduleID'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID

SET @OrderNo = 32
SET @ID = 'InterviewResultID'
SET @ModuleID = 'AsoftHRM'
SET @Description = N'Truy vấn kết quả phỏng vấn'
SET @DescriptionE = N''
SET @Disabled = 0
SET @LanguageID ='A00.InterviewResultID'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID

SET @OrderNo = 33
SET @ID = 'RecDecisionNo'
SET @ModuleID = 'AsoftHRM'
SET @Description = N'Quyết định tuyển dụng'
SET @DescriptionE = N''
SET @Disabled = 0
SET @LanguageID ='A00.RecDecisionNo'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID

SET @OrderNo = 34
SET @ID = 'ComfirmationRecruitmentID'
SET @ModuleID = 'AsoftHRM'
SET @Description = N'Xác nhận tuyển dụng '
SET @DescriptionE = N''
SET @Disabled = 0
SET @LanguageID ='A00.ComfirmationRecruitmentID'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID

SET @OrderNo = 35
SET @ID = 'BudgetID'
SET @ModuleID = 'AsoftHRM'
SET @Description = N'Danh mục ngân sách đào tạo'
SET @DescriptionE = N''
SET @Disabled = 0
SET @LanguageID ='A00.BudgetID'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID

SET @OrderNo = 36
SET @ID = 'TrainingPlanID'
SET @ModuleID = 'AsoftHRM'
SET @Description = N'Kế hoạch đào tạo định kỳ'
SET @DescriptionE = N''
SET @Disabled = 0
SET @LanguageID ='A00.TrainingPlanID'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID

SET @OrderNo = 37
SET @ID = 'TrainingRequestID'
SET @ModuleID = 'AsoftHRM'
SET @Description = N'Danh mục yêu cầu đào tạo'
SET @DescriptionE = N''
SET @Disabled = 0
SET @LanguageID ='A00.TrainingRequestID'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID

SET @OrderNo = 38
SET @ID = 'TrainingProposeID'
SET @ModuleID = 'AsoftHRM'
SET @Description = N'Danh mục đề xuất đào tạo'
SET @DescriptionE = N''
SET @Disabled = 0
SET @LanguageID ='A00.TrainingProposeID'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID

SET @OrderNo = 39
SET @ID = 'TrainingScheduleID'
SET @ModuleID = 'AsoftEDM'
SET @Description = N'Danh mục lịch đào tạo'
SET @DescriptionE = N''
SET @Disabled = 0
SET @LanguageID ='A00.TrainingScheduleID'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID

SET @OrderNo = 40
SET @ID = 'TrainingCostID'
SET @ModuleID = 'AsoftHRM'
SET @Description = N'Ghi nhận chi phí'
SET @DescriptionE = N''
SET @Disabled = 0
SET @LanguageID ='A00.TrainingCostID'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID

SET @OrderNo = 41
SET @ID = 'TrainingResultID'
SET @ModuleID = 'AsoftHRM'
SET @Description = N'Ghi nhận kết quả'
SET @DescriptionE = N''
SET @Disabled = 0
SET @LanguageID ='A00.TrainingResultID'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID

SET @OrderNo = 42
SET @ID = 'ShiftID'
SET @ModuleID = 'AsoftHRM'
SET @Description = N'Bảng phân ca'
SET @DescriptionE = N''
SET @Disabled = 0
SET @LanguageID ='A00.ShiftID'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID

SET @OrderNo = 43
SET @ID = 'ShiftChangeID'
SET @ModuleID = 'AsoftHRM'
SET @Description = N'Đơn đổi ca'
SET @DescriptionE = N''
SET @Disabled = 0
SET @LanguageID ='A00.ShiftChangeID'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID

SET @OrderNo = 44
SET @ID = 'TimekeepingID'
SET @ModuleID = 'AsoftHRM'
SET @Description = N'Đơn xin phép bổ sung/hủy quẹt thẻ'
SET @DescriptionE = N''
SET @Disabled = 0
SET @LanguageID ='A00.TimekeepingID'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID

SET @OrderNo = 45
SET @ID = 'PermissionFormID'
SET @ModuleID = 'AsoftHRM'
SET @Description = N'Đơn xin phép'
SET @DescriptionE = N''
SET @Disabled = 0
SET @LanguageID ='A00.PermissionFormID'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID

SET @OrderNo = 46
SET @ID = 'PermissionOutFormID'
SET @ModuleID = 'AsoftHRM'
SET @Description = N'Đơn xin ra ngoài'
SET @DescriptionE = N''
SET @Disabled = 0
SET @LanguageID ='A00.PermissionOutFormID'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID

SET @OrderNo = 47
SET @ID = 'OTFormID'
SET @ModuleID = 'AsoftHRM'
SET @Description = N'Đơn xin phép làm thêm giờ'
SET @DescriptionE = N''
SET @Disabled = 0
SET @LanguageID ='A00.OTFormID'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID

SET @OrderNo = 48
SET @ID = 'AbnormalID'
SET @ModuleID = 'AsoftHRM'
SET @Description = N'Xử lý bất thường'
SET @DescriptionE = N''
SET @Disabled = 0
SET @LanguageID ='A00.AbnormalID'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID

SET @OrderNo = 49
SET @ID = 'PermissionCatalogID'
SET @ModuleID = 'AsoftHRM'
SET @Description = N'Danh mục đơn xin phép'
SET @DescriptionE = N''
SET @Disabled = 0
SET @LanguageID ='A00.PermissionCatalogID'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID

SET @OrderNo = 49
SET @ID = 'DISCID'
SET @ModuleID = 'AsoftHRM'
SET @Description = N'Danh mục tính cách D.I.S.C'
SET @DescriptionE = N''
SET @Disabled = 0
SET @LanguageID ='A00.DISCID'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID

SET @OrderNo = 50
SET @ID = 'EvaluationKitID'
SET @ModuleID = 'AsoftHRM'
SET @Description = N'Danh mục đánh giá năng lực '
SET @DescriptionE = N''
SET @Disabled = 0
SET @LanguageID ='A00.EvaluationKitID'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID
-------- [END] Modify by Bảo toàn on 04/10/2019

--------- Modify by Vĩnh Tâm on 29/10/2019: Bổ sung phân quyền Quản lý vấn đề
SET @OrderNo = 51
SET @ID = 'IssueManagement'
SET @Description = N'Quản lý vấn đề'
SET @ModuleID = 'AsoftOO'
SET @DescriptionE = N'Issue management'
SET @Disabled = 0
SET @LanguageID ='A00.IssueManagement'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID

--------- Modify by Vĩnh Tâm on 09/11/2019: Bổ sung phân quyền Yêu cầu hỗ trợ
SET @OrderNo = 52
SET @ID = 'HelpDesk'
SET @ModuleID = 'AsoftOO'
SET @Description = N'Yêu cầu hỗ trợ'
SET @DescriptionE = N'Help Desk'
SET @Disabled = 0
SET @LanguageID ='A00.HelpDesk'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID

--------- Modify by Vĩnh Tâm on 09/11/2019: Bổ sung phân quyền Yêu cầu hỗ trợ
SET @OrderNo = 53
SET @ID = 'CallsHistory'
SET @ModuleID = 'AsoftOO'
SET @Description = N'Lịch sử cuộc gọi'
SET @DescriptionE = N'Calls history'
SET @Disabled = 0
SET @LanguageID ='A00.CallsHistory'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID

--------- Modify by Vĩnh Tâm on 26/12/2019: Bổ sung phân quyền Quản lý milestone
SET @OrderNo = 54
SET @ID = 'MilestoneManagement'
SET @ModuleID = 'AsoftOO'
SET @Description = N'Quản lý milestone'
SET @DescriptionE = N'Milestone management'
SET @Disabled = 0
SET @LanguageID ='A00.MilestoneManagement'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID

--------- Modify by Vĩnh Tâm on 02/01/2020: Bổ sung phân quyền Quản lý Release
SET @OrderNo = 55
SET @ID = 'ReleaseManagement'
SET @ModuleID = 'AsoftOO'
SET @Description = N'Quản lý Release'
SET @DescriptionE = N'Release management'
SET @Disabled = 0
SET @LanguageID ='A00.ReleaseManagement'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID
	
--------- Modify by Tấn Lộc on 23/07/2020: Bổ sung phân quyền Quản lý License
SET @OrderNo = 56
SET @ID = 'LicenseManagement'
SET @ModuleID = 'AsoftCRM'
SET @Description = N'Quản lý License'
SET @DescriptionE = N'License management'
SET @Disabled = 0
SET @LanguageID ='A00.LicenseManagement'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID

--------- Modify by Tấn Thành on 28/07/2020: Bổ sung phân quyền Phiếu DNTT/DNTTTU/DNTU 
SET @OrderNo = 57
SET @ID = 'BEMT2000'
SET @ModuleID = 'AsoftBEM'
SET @Description = N'Phiếu DNTT/DNTTTU/DNTU'
SET @DescriptionE = N'Proposal'
SET @Disabled = 0
SET @LanguageID ='A00.Proposal'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID

--------- Modify by Tấn Thành on 28/07/2020: Bổ sung phân quyền Đơn xin duyệt công tác nghỉ phép về nước
SET @OrderNo = 58
SET @ID = 'BEMT2010'
SET @ModuleID = 'AsoftBEM'
SET @Description = N'Đơn xin duyệt công tác nghỉ phép về nước'
SET @DescriptionE = N'Category work confirmation letter'
SET @Disabled = 0
SET @LanguageID ='A00.CategoryWorkConfirmationLetter'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID
	
--------- Modify by Tấn Lộc on 02/12/2020: Bổ sung phân quyền Chiến dịch Email
SET @OrderNo = 59
SET @ID = 'CampaignEmail'
SET @ModuleID = 'AsoftCRM'
SET @Description = N'Chiến dịch email'
SET @DescriptionE = N'Campaign Email'
SET @Disabled = 0
SET @LanguageID ='A00.CampaignEmail'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID
	
--------- Modify by Tấn Lộc on 07/01/2020: Bổ sung phân quyền Hộp thư đến
SET @OrderNo = 60
SET @ID = 'ReceiveEmailManagement'
SET @ModuleID = 'AsoftOO'
SET @Description = N'Hộp thư đến'
SET @DescriptionE = N'Receive Email Management'
SET @Disabled = 0
SET @LanguageID ='A00.ReceiveEmailManagement'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID
	
--------- Modify by Tấn Lộc on 07/01/2020: Bổ sung phân quyền Hộp thư đi
SET @OrderNo = 61
SET @ID = 'SendEmailManagement'
SET @ModuleID = 'AsoftOO'
SET @Description = N'Hộp thư đi'
SET @DescriptionE = N'Send Email Management'
SET @Disabled = 0
SET @LanguageID ='A00.SendEmailManagement'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID
	
--------- Modify by Tấn Lộc on 26/01/2020: Bổ sung phân quyền danh sách thư mục (Public)
SET @OrderNo = 62
SET @ID = 'FolderPublicManagement'
SET @ModuleID = 'AsoftOO'
SET @Description = N'Danh sách thư mục (Public)'
SET @DescriptionE = N'Folder Public Management'
SET @Disabled = 0
SET @LanguageID ='A00.FolderPublicManagement'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID
	
--------- Modify by Tấn Lộc on 26/01/2020: Bổ sung phân quyền danh sách file theo thư mục (Public)
SET @OrderNo = 63
SET @ID = 'FilePublicManagement'
SET @ModuleID = 'AsoftOO'
SET @Description = N'Danh sách file theo thư mục (Public)'
SET @DescriptionE = N'File Public Management'
SET @Disabled = 0
SET @LanguageID ='A00.FilePublicManagement'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID
	
--------- Modify by Tấn Lộc on 27/01/2020: Bổ sung phân quyền danh sách file theo user
SET @OrderNo = 64
SET @ID = 'FileUserManagement'
SET @ModuleID = 'AsoftOO'
SET @Description = N'Danh sách file theo user'
SET @DescriptionE = N'File User Management'
SET @Disabled = 0
SET @LanguageID ='A00.FileUserManagement'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID
	
--------- Modify by Tấn Lộc on 29/05/2020: Bổ sung phân dữ liệu màn hình chiến dịch SMS
SET @OrderNo = 65
SET @ID = 'CampaignSMS'
SET @ModuleID = 'AsoftCRM'
SET @Description = N'Danh sách chiến dịch SMS'
SET @DescriptionE = N'Campaign SMS'
SET @Disabled = 0
SET @LanguageID ='A00.CampaignSMS'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID
	
--------- Modify by Tấn Lộc on 24/11/2021: Bổ sung phân dữ liệu màn hình Dữ liệu nguồn online
SET @OrderNo = 66
SET @ID = 'SourceDataOnline'
SET @ModuleID = 'AsoftCRM'
SET @Description = N'Danh sách dữ liệu nguồn online'
SET @DescriptionE = N'Source Data Online'
SET @Disabled = 0
SET @LanguageID ='A00.SourceDataOnline'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID

--------- Modify by Hoài Bảo on 23/03/2022: Bổ sung phân dữ liệu màn hình Quản lý Server
SET @OrderNo = 67
SET @ID = 'ServerManagement'
SET @ModuleID = 'AsoftCRM'
SET @Description = N'Danh mục quản lý Server'
SET @DescriptionE = N'Server Management'
SET @Disabled = 0
SET @LanguageID ='A00.ServerManagement'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID

--------- Modify by Hoài Bảo on 24/03/2022: Bổ sung phân dữ liệu màn hình Quản lý Gói sản phẩm
SET @OrderNo = 68
SET @ID = 'PackageManagement'
SET @ModuleID = 'AsoftCRM'
SET @Description = N'Danh mục quản lý gói sản phẩm'
SET @DescriptionE = N'Package Management'
SET @Disabled = 0
SET @LanguageID ='A00.PackageManagement'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID

--------- Modify by Hoài Bảo on 28/03/2022: Bổ sung phân dữ liệu màn hình Quản lý Thuê bao
SET @OrderNo = 69
SET @ID = 'SubscriberManagement'
SET @ModuleID = 'AsoftCRM'
SET @Description = N'Danh mục quản lý thuê bao'
SET @DescriptionE = N'Subscriber Management'
SET @Disabled = 0
SET @LanguageID ='A00.SubscriberManagement'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID

--------- Modify by Thành Sang on 28/03/2022: Bổ sung phân dữ liệu màn hình chấm công
SET @OrderNo = 70
SET @ID = 'WorkTimeID'
SET @ModuleID = 'AsoftHRM'
SET @Description = N'Chấm công'
SET @DescriptionE = N'WorkTime'
SET @Disabled = 0
SET @LanguageID ='A00.WorkTime'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID

--------- Modify by Tấn Lộc on 11/05/2022: Bổ sung phân dữ liệu màn hình Văn bản đi
--------- Modify by Văn Tài on 27/05/2022: Chỉ xử lý 1 nghiệp vụ Quản lý văn bản
SET @OrderNo = 71
SET @ID = 'SentDocumentManagement'
SET @ModuleID = 'AsoftOO'
SET @Description = N'Quản lý Văn bản'
SET @DescriptionE = N'Sent Document Management'
SET @Disabled = 0
SET @LanguageID ='A00.SentDocumentManagement'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID
	
----------- Modify by Tấn Lộc on 11/05/2022: Bổ sung phân dữ liệu màn hình Văn bản đến
--SET @OrderNo = 72
--SET @ID = 'ReceiveDocumentManagement'
--SET @ModuleID = 'AsoftOO'
--SET @Description = N'Quản lý văn bản đến'
--SET @DescriptionE = N'Receive Document Management'
--SET @Disabled = 0
--SET @LanguageID ='A00.ReceiveDocumentManagement'
--IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
--	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
--	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
--ELSE
--	UPDATE ST10504
--	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
--	WHERE ID = @ID

--------- Modify by Tấn Lộc on 15/11/2022: Bổ sung phân dữ liệu màn hình Yêu cầu nhập kho
SET @OrderNo = 73
SET @ID = 'ImportWareHouseRequest'
SET @ModuleID = 'AsoftWM'
SET @Description = N'Yêu cầu nhập kho'
SET @DescriptionE = N'Import WareHouse Request'
SET @Disabled = 0
SET @LanguageID ='A00.ImportWareHouseRequest'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID
	
--------- Modify by Tấn Lộc on 15/11/2022: Bổ sung phân dữ liệu màn hình Yêu cầu xuất kho
SET @OrderNo = 74
SET @ID = 'ExportWareHouseRequest'
SET @ModuleID = 'AsoftWM'
SET @Description = N'Yêu cầu xuất kho'
SET @DescriptionE = N'Export WareHouse Request'
SET @Disabled = 0
SET @LanguageID ='A00.ExportWareHouseRequest'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID
	
--------- Modify by Tấn Lộc on 15/11/2022: Bổ sung phân dữ liệu màn hình Yêu cầu chuyển kho
SET @OrderNo = 75
SET @ID = 'TransferWareHouseRequest'
SET @ModuleID = 'AsoftWM'
SET @Description = N'Yêu cầu chuyển kho'
SET @DescriptionE = N'Transfer WareHouse Request'
SET @Disabled = 0
SET @LanguageID ='A00.TransferWareHouseRequest'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID
	
--------- Modify by Tấn Lộc on 15/11/2022: Bổ sung phân dữ liệu màn hình nhập kho
SET @OrderNo = 76
SET @ID = 'ImportWareHouse'
SET @ModuleID = 'AsoftWM'
SET @Description = N'Nhập kho'
SET @DescriptionE = N'Import WareHouse'
SET @Disabled = 0
SET @LanguageID ='A00.ImportWareHouse'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID
	
--------- Modify by Tấn Lộc on 15/11/2022: Bổ sung phân dữ liệu màn hình xuất kho
SET @OrderNo = 77
SET @ID = 'ExportWareHouse'
SET @ModuleID = 'AsoftWM'
SET @Description = N'Xuất kho'
SET @DescriptionE = N'Export WareHouse'
SET @Disabled = 0
SET @LanguageID ='A00.ExportWareHouse'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID
	
--------- Modify by Tấn Lộc on 15/11/2022: Bổ sung phân dữ liệu màn hình Chuyển kho
SET @OrderNo = 78
SET @ID = 'TransferWareHouse'
SET @ModuleID = 'AsoftWM'
SET @Description = N'Chuyển kho'
SET @DescriptionE = N'Transfer WareHouse'
SET @Disabled = 0
SET @LanguageID ='A00.TransferWareHouse'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID
	
--------- Modify by Tấn Lộc on 15/11/2022: Bổ sung phân dữ liệu màn hình Số dư đầu hàng tồn kho
SET @OrderNo = 79
SET @ID = 'InventoryBalance'
SET @ModuleID = 'AsoftWM'
SET @Description = N'Số dư đầu hàng tồn kho'
SET @DescriptionE = N'InventoryBalance'
SET @Disabled = 0
SET @LanguageID ='A00.TransferWareHouse'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID
	
--------- Modify by Tấn Lộc on 15/11/2022: Bổ sung phân dữ liệu màn hình Kết chuyển số du cuối kỳ
SET @OrderNo = 80
SET @ID = 'TransferBalance'
SET @ModuleID = 'AsoftWM'
SET @Description = N'Kết chuyển số du cuối kỳ'
SET @DescriptionE = N'InventoryBalance'
SET @Disabled = 0
SET @LanguageID ='A00.TransferWareHouse'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID

--------- Modify by Tấn Lộc on 15/11/2022: Bổ sung phân dữ liệu màn hình Kiểm kê
SET @OrderNo = 81
SET @ID = 'InventoryWarehouse'
SET @ModuleID = 'AsoftWM'
SET @Description = N'Kiểm kê kho'
SET @DescriptionE = N'Inventory Warehouse'
SET @Disabled = 0
SET @LanguageID ='A00.InventoryWarehouse'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID
	
--------- Modify by Tấn Lộc on 15/11/2022: Bổ sung phân dữ liệu màn hình Điều chỉnh
SET @OrderNo = 82
SET @ID = 'InventoryWarehouseAdjust'
SET @ModuleID = 'AsoftWM'
SET @Description = N'Điều chỉnh kho'
SET @DescriptionE = N'Inventory Warehouse Adjust'
SET @Disabled = 0
SET @LanguageID ='A00.InventoryWarehouseAdjust'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID

--------- Modify by Hoài Bảo on 09/12/2022: Bổ sung phân dữ liệu màn hình Yêu cầu dịch vụ
SET @OrderNo = 83
SET @ID = 'ServiceRequestManagement'
SET @ModuleID = 'AsoftCRM'
SET @Description = N'Danh mục yêu cầu dịch vụ'
SET @DescriptionE = N'Service Request Management'
SET @Disabled = 0
SET @LanguageID ='A00.ServiceRequestManagement'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID

--------- Modify by Hoài Bảo on 09/12/2022: Bổ sung phân dữ liệu màn hình Yêu cầu dịch vụ
SET @OrderNo = 83
SET @ID = 'ServiceRequestManagement'
SET @ModuleID = 'AsoftCRM'
SET @Description = N'Danh mục yêu cầu dịch vụ'
SET @DescriptionE = N'Service Request Management'
SET @Disabled = 0
SET @LanguageID ='A00.ServiceRequestManagement'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID

--------- Modify by Tấn Lộc on 15/11/2022: Bổ sung phân dữ liệu màn hình Giao chỉ tiêu/Công việc
SET @OrderNo = 84
SET @ID = 'TargetTaskManagement'
SET @ModuleID = 'AsoftOO'
SET @Description = N'Giao chỉ tiêu/công việc'
SET @DescriptionE = N'Assign targets/tasks'
SET @Disabled = 0
SET @LanguageID ='A00.TargetTaskManagement'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID
	
		
--------- Modify by Tấn Lộc on 15/11/2022: Bổ sung phân dữ liệu màn hình Kết quả thử việc
SET @OrderNo = 85
SET @ID = 'ProbationResults'
SET @ModuleID = 'AsoftHRM'
SET @Description = N'Kết quả thử việc'
SET @DescriptionE = N'Probation Results'
SET @Disabled = 0
SET @LanguageID ='A00.ProbationResults'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID

--------- Modify by Kiều Nga on 05/12/2023: Bổ sung phân dữ liệu AsoftM
SET @OrderNo = 86
SET @ID = 'ProductionStep'
SET @ModuleID = 'AsoftM'
SET @Description = N'Công Đoạn sản xuất'
SET @DescriptionE = N'Production Step'
SET @Disabled = 0
SET @LanguageID ='A00.ProductionStep'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID

SET @OrderNo = 87
SET @ID = 'RawMaterialsAlternative'
SET @ModuleID = 'AsoftM'
SET @Description = N'Nguyên liệu thay thế'
SET @DescriptionE = N'Raw Materials Alternative'
SET @Disabled = 0
SET @LanguageID ='A00.RawMaterialsAlternative'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID

SET @OrderNo = 88
SET @ID = 'ProductionProcess'
SET @ModuleID = 'AsoftM'
SET @Description = N'Quy trình sản xuất'
SET @DescriptionE = N'Production Process'
SET @Disabled = 0
SET @LanguageID ='A00.ProductionProcess'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID

SET @OrderNo = 89
SET @ID = 'StructureProduct'
SET @ModuleID = 'AsoftM'
SET @Description = N'Cấu trúc sản phẩm'
SET @DescriptionE = N'Structure Product'
SET @Disabled = 0
SET @LanguageID ='A00.StructureProduct'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID

SET @OrderNo = 90
SET @ID = 'ProductNorm'
SET @ModuleID = 'AsoftM'
SET @Description = N'Định mức sản phẩm'
SET @DescriptionE = N'Product Norm'
SET @Disabled = 0
SET @LanguageID ='A00.ProductNorm'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID

SET @OrderNo = 91
SET @ID = 'ManufacturingPurchaseOrder'
SET @ModuleID = 'AsoftM'
SET @Description = N'Đơn hàng sản xuất'
SET @DescriptionE = N'Manufacturing Purchase Order'
SET @Disabled = 0
SET @LanguageID ='A00.ManufacturingPurchaseOrder'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID

SET @OrderNo = 92
SET @ID = 'ProductionPlan'
SET @ModuleID = 'AsoftM'
SET @Description = N'Kế hoạch sản xuất'
SET @DescriptionE = N'Production Plan'
SET @Disabled = 0
SET @LanguageID ='A00.ProductionPlan'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID

SET @OrderNo = 93
SET @ID = 'EstimateCosts'
SET @ModuleID = 'AsoftM'
SET @Description = N'Dự trù chi phí'
SET @DescriptionE = N'Estimate Costs'
SET @Disabled = 0
SET @LanguageID ='A00.EstimateCosts'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID

SET @OrderNo = 94
SET @ID = 'ManufactureOrder'
SET @ModuleID = 'AsoftM'
SET @Description = N'Lệnh sản xuất'
SET @DescriptionE = N'Manufacture Order'
SET @Disabled = 0
SET @LanguageID ='A00.ManufactureOrder'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID

SET @OrderNo = 95
SET @ID = 'StatisticsProductionResults'
SET @ModuleID = 'AsoftM'
SET @Description = N'Thống kê kết quả sản xuất'
SET @DescriptionE = N'Statistics Production Results'
SET @Disabled = 0
SET @LanguageID ='A00.StatisticsProductionResults'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID

SET @OrderNo = 96
SET @ID = 'PackagingShipping'
SET @ModuleID = 'AsoftM'
SET @Description = N'Đóng gói - Vận chuyển'
SET @DescriptionE = N'Packaging Shipping'
SET @Disabled = 0
SET @LanguageID ='A00.PackagingShipping'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID

SET @OrderNo = 97
SET @ID = 'GeneralProductionStatistics'
SET @ModuleID = 'AsoftM'
SET @Description = N'Thống kê sản xuất chung'
SET @DescriptionE = N'General Production Statistics'
SET @Disabled = 0
SET @LanguageID ='A00.GeneralProductionStatistics'
IF NOT EXISTS (SELECT TOP 1 1 FROM ST10504 WHERE ID = @ID)
	INSERT INTO ST10504 (OrderNo, ID, ModuleID, [Description],DescriptionE, [Disabled], [LanguageID])
	VALUES (@OrderNo, @ID, @ModuleID, @Description, @DescriptionE, @Disabled, @LanguageID)
ELSE
	UPDATE ST10504
	SET OrderNo = @OrderNo, [Description] = @Description, DescriptionE = @DescriptionE, [Disabled] = @Disabled, [LanguageID] = @LanguageID, ModuleID = @ModuleID
	WHERE ID = @ID
