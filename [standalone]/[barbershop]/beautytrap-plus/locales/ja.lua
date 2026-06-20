--[[
    ============================================
    JAPANESE LOCALE - BEAUTYTRAP-PLUS
    日本語ローカライズ - 完全版
    ============================================
]]--

Locales['ja'] = {
    -- ============================================
    -- GENERAL / 一般
    -- ============================================
    ['General.AccessDenied'] = "アクセス拒否",
    ['General.NoPermission'] = "このコンテンツにアクセスする権限がありません。",
    ['General.Error'] = "エラー",
    ['General.Success'] = "成功",
    ['General.Info'] = "情報",
    ['General.Cancel'] = "キャンセル",
    ['General.Confirm'] = "確認",
    ['General.Back'] = "戻る",
    ['General.Close'] = "閉じる",
    ['General.UnknownError'] = "不明なエラー",
    
    -- ============================================
    -- DUTY SYSTEM / 勤務システム
    -- ============================================
    ['Duty.OnDuty'] = "勤務中",
    ['Duty.OffDuty'] = "勤務外",
    ['Duty.NowOnDuty'] = "%sとして勤務を開始しました",
    ['Duty.NowOffDuty'] = "勤務を終了しました",
    ['Duty.ToggleDuty'] = "勤務切替",
    ['Duty.NoPermission'] = "勤務状態を変更する権限がありません。",
    ['Duty.NoPermissionStation'] = "この勤務ステーションを使用する権限がありません。",
    
    -- ============================================
    -- BASKET / SHOPPING SYSTEM / 買い物カゴシステム
    -- ============================================
    ['Basket.Title'] = "買い物カゴ",
    ['Basket.GrabbedBasket'] = "買い物カゴを手に取りました！",
    ['Basket.GrabbedGunCase'] = "ガンケースを手に取りました！",
    ['Basket.GrabbedShoppingBag'] = "ショッピングバッグを手に取りました！",
    ['Basket.AlreadyHaveBasket'] = "すでに買い物カゴを持っています！",
    ['Basket.NeedBasket'] = "まず買い物カゴを手に取ってください！",
    ['Basket.PutAway'] = "買い物カゴを戻しました。",
    ['Basket.NoBasketToPutAway'] = "戻す買い物カゴがありません！",
    ['Basket.NoLongerHaveBasket'] = "買い物カゴを持っていません。",
    ['Basket.InvalidStoreData'] = "無効な店舗データです！",
    ['Basket.StoreTypeNotExist'] = "この店舗タイプは存在しません！",
    ['Basket.ItemAdded'] = "%sをカゴに追加しました！",
    ['Basket.ItemRemoved'] = "%sをカゴから削除しました",
    ['Basket.BasketFull'] = "カゴがいっぱいです",
    ['Basket.BasketLimit'] = "買い物カゴには%d個までしか入りません。",
    ['Basket.BasketLimitFull'] = "買い物カゴには%d個までしか入りません。すでに%d個入っています。",
    ['Basket.Shoplifting'] = "万引きが見つかり、すべての商品を落としました！",
    
    -- ============================================
    -- SHOP / ITEM BROWSING / 商品閲覧
    -- ============================================
    ['Shop.SelectItems'] = "商品を選択",
    ['Shop.SelectQuantity'] = "数量を選択",
    ['Shop.Quantity'] = "数量",
    ['Shop.Price'] = "価格",
    ['Shop.InvalidQuantity'] = "無効な数量です！",
    ['Shop.AddToBasket'] = "カゴに追加 (在庫: %d)",
    ['Shop.HowManyAdd'] = "いくつ追加しますか？ (最大: %d)",
    
    -- ============================================
    -- COOLDOWN SYSTEM / クールダウンシステム
    -- ============================================
    ['Cooldown.Title'] = "購入クールダウン",
    ['Cooldown.OnCooldown'] = "再び買い物をするには%s待つ必要があります。",
    ['Cooldown.LimitReached'] = "購入制限に達しました",
    ['Cooldown.LimitReachedDesc'] = "%d個の購入制限に達しました。%d時間後に再試行してください。",
    
    -- ============================================
    -- CHECKOUT / PAYMENT SYSTEM / 会計システム
    -- ============================================
    ['Checkout.Title'] = "会計",
    ['Checkout.PaymentProcessed'] = "お支払いが処理され、商品を受け取りました！",
    ['Checkout.PaymentRequest'] = "支払いリクエスト",
    ['Checkout.PaymentRequestDesc'] = "$%dの支払いリクエストを受け取りました",
    ['Checkout.AcceptPayment'] = "承諾して支払う",
    ['Checkout.AcceptPaymentDesc'] = "購入を完了する",
    ['Checkout.DeclinePayment'] = "支払いを拒否",
    ['Checkout.DeclinePaymentDesc'] = "取引をキャンセル",
    ['Checkout.ProcessPayment'] = "支払いを処理",
    ['Checkout.UseRegister'] = "レジで$%dの支払いを処理してください",
    ['Checkout.RequestedWait'] = "会計をリクエストしました。スタッフの対応をお待ちください。",
    ['Checkout.BasketEmpty'] = "買い物カゴが空です！",
    ['Checkout.NoBasket'] = "買い物カゴがありません！",
    ['Checkout.RequestAssistance'] = "%sが会計のサポートを求めています。",
    ['Checkout.SaleComplete'] = "販売完了",
    ['Checkout.PurchaseComplete'] = "購入完了",
    ['Checkout.YouPaid'] = "商品に$%dを支払いました。",
    ['Checkout.CustomerPaidBusiness'] = "お客様が事業口座に$%dを支払いました。",
    ['Checkout.CustomerPaidDirect'] = "お客様があなたに直接$%dを支払いました。",
    ['Checkout.PaymentFailed'] = "支払い失敗",
    ['Checkout.TransactionFailed'] = "取引を完了できませんでした。",
    ['Checkout.CustomerPaymentFailed'] = "お客様の支払いが失敗しました。",
    ['Checkout.PurchaseCancelled'] = "購入キャンセル",
    ['Checkout.YouDeclined'] = "支払いを拒否しました。",
    ['Checkout.CustomerDeclined'] = "お客様が支払いを拒否しました。",
    ['Checkout.PaymentMethod'] = "支払い方法",
    ['Checkout.Cash'] = "現金",
    ['Checkout.BankCard'] = "銀行カード",
    ['Checkout.BankMoney'] = "銀行口座の残高",
    ['Checkout.Amount'] = "金額",
    ['Checkout.From'] = "送金元",
    ['Checkout.AmountMismatch'] = "金額不一致",
    ['Checkout.AmountMismatchDesc'] = "支払い金額がカゴの合計と一致しません: $%d",
    ['Checkout.CustomerNotEnoughMoney'] = "お客様の%sが不足しています",
    ['Checkout.YouNotEnoughMoney'] = "%sが不足しています",
    
    -- ============================================
    -- STOCK MANAGEMENT / 在庫管理
    -- ============================================
    ['Stock.Management'] = "在庫管理",
    ['Stock.ManageStock'] = "このセクションの在庫を管理",
    ['Stock.Location'] = "場所",
    ['Stock.CurrentStock'] = "現在の在庫",
    ['Stock.Stock'] = "在庫",
    ['Stock.AddStock'] = "在庫を追加",
    ['Stock.RemoveStock'] = "在庫を削除",
    ['Stock.Restock'] = "補充",
    ['Stock.RestockDesc'] = "棚にいくつ追加しますか？",
    ['Stock.OutOfStock'] = "在庫切れ",
    ['Stock.OutOfStockDesc'] = "申し訳ございません、%sは在庫切れです。",
    ['Stock.LowStock'] = "在庫わずか",
    ['Stock.NoPermission'] = "在庫を管理する権限がありません。",
    ['Stock.Updated'] = "在庫更新完了",
    ['Stock.AddedItems'] = "%d個追加しました。新しい在庫: %d",
    ['Stock.RestockFailed'] = "補充失敗",
    ['Stock.NotEnoughInventory'] = "インベントリに十分な%sがありません。",
    
    -- ============================================
    -- CUSTOMER BASKET (EMPLOYEE VIEW) / 顧客カゴ表示
    -- ============================================
    ['CustomerBasket.Title'] = "%sのカゴ",
    ['CustomerBasket.NoBasket'] = "このお客様はカゴを持っていません。",
    ['CustomerBasket.Empty'] = "このお客様のカゴは空です。",
    ['CustomerBasket.Total'] = "合計",
    ['CustomerBasket.Each'] = "各",
    ['CustomerBasket.NoPermission'] = "お客様のカゴを見る権限がありません。",
    
    -- ============================================
    -- REGISTER / CASH REGISTER / レジ
    -- ============================================
    ['Register.Title'] = "レジ",
    ['Register.NoPermission'] = "レジを使用する権限がありません。",
    ['Register.NoItems'] = "お客様に購入商品がありません。",
    ['Register.NoCustomers'] = "近くにお客様がいません。",
    ['Register.SelectCustomer'] = "お客様を選択",
    ['Register.InvalidAmount'] = "無効な金額です。",
    
    -- ============================================
    -- TARGET LABELS / ターゲットラベル
    -- ============================================
    ['Target.GrabBasket'] = "カゴを取る",
    ['Target.PutAwayBasket'] = "カゴを戻す",
    ['Target.ViewBasket'] = "お客様のカゴを見る",
    ['Target.Checkout'] = "会計をリクエスト",
    ['Target.CashRegister'] = "レジを使用",
    ['Target.BossMenu'] = "オーナーメニューを開く",
    ['Target.ManageStock'] = "在庫を管理",
    ['Target.OpenStash'] = "%sを開く",
    ['Target.OpenLocker'] = "ロッカーを開く",
    ['Target.SitDown'] = "座る",
    ['Target.StandUp'] = "立ち上がる",
    ['Target.Browse'] = "%sを閲覧",
    ['Target.UseAsClient'] = "%sをお客様として使用",
    ['Target.UseAsEmployee'] = "%sをスタッフとして使用",
    
    -- ============================================
    -- STASH / STORAGE / 収納
    -- ============================================
    ['Stash.NoPermission'] = "この収納にアクセスする権限がありません。",
    
    -- ============================================
    -- CLOTHING / 衣装
    -- ============================================
    ['Clothing.Locker'] = "衣装ロッカー",
    ['Clothing.OpenMenu'] = "衣装メニューを開く",
    
    -- ============================================
    -- JOB INFO / 仕事情報
    -- ============================================
    ['Job.Title'] = "仕事情報",
    ['Job.Status'] = "仕事状態",
    ['Job.Name'] = "名前",
    ['Job.Grade'] = "等級",
    ['Job.IsBoss'] = "オーナー",
    ['Job.Duty'] = "勤務",
    
    -- ============================================
    -- BOSS MENU / オーナーメニュー
    -- ============================================
    ['Boss.Title'] = "ビューティーオーナーメニュー",
    ['Boss.SocietyBalance'] = "会社残高",
    ['Boss.CurrentBalance'] = "現在の残高: $%s",
    ['Boss.WithdrawMoney'] = "会社から引き出し",
    ['Boss.DepositMoney'] = "入金",
    ['Boss.HireEmployee'] = "従業員を雇用",
    ['Boss.FireEmployee'] = "従業員を解雇",
    ['Boss.EmployeeManagement'] = "従業員管理",
    ['Boss.ViewBalance'] = "会社残高を確認",
    ['Boss.SetGrade'] = "等級を設定",
    ['Boss.HowMuchWithdraw'] = "いくら引き出しますか？",
    ['Boss.HowMuchDeposit'] = "いくら入金しますか？",
    ['Boss.Amount'] = "金額",
    ['Boss.NeedBeautyJob'] = "このコマンドを使用するにはビューティーサロンで働く必要があります。",
    ['Boss.NoPermission'] = "ビューティーオーナーメニューにアクセスする権限がありません。",
    ['Boss.OnlyManagersHire'] = "マネージャーのみが従業員を雇用できます",
    ['Boss.OnlyManagersFire'] = "マネージャーのみが従業員を解雇できます",
    ['Boss.OnlyManagersGrade'] = "マネージャーのみが従業員の等級を変更できます",
    ['Boss.NoPermissionWithdraw'] = "引き出しの権限がありません。",
    ['Boss.NoPermissionDeposit'] = "入金の権限がありません。",
    ['Boss.NoPermissionBalance'] = "会社残高を確認する権限がありません。",
    ['Boss.NoPermissionEmployees'] = "従業員リストを見る権限がありません。",
    ['Boss.Hired'] = "雇用完了！",
    ['Boss.YouHaveBeenHired'] = "ビューティーサロンに雇用されました",
    ['Boss.EmployeeHiredSuccess'] = "従業員の雇用に成功しました",
    ['Boss.Fired'] = "解雇",
    ['Boss.YouHaveBeenFired'] = "ビューティーサロンから解雇されました",
    ['Boss.EmployeeFiredSuccess'] = "従業員を解雇しました",
    ['Boss.GradeChanged'] = "等級変更",
    ['Boss.YourGradeUpdated'] = "あなたの等級が更新されました",
    ['Boss.GradeUpdatedTo'] = "従業員の等級を%dに更新しました",
    ['Boss.WithdrawalSuccessful'] = "引き出し成功",
    ['Boss.WithdrewAmount'] = "会社口座から$%sを引き出しました。",
    ['Boss.WithdrawalFailed'] = "引き出し失敗",
    ['Boss.InsufficientFunds'] = "会社口座の残高が不足しています。",
    ['Boss.DepositSuccessful'] = "入金成功",
    ['Boss.DepositedAmount'] = "会社口座に$%sを入金しました。",
    ['Boss.DepositFailed'] = "入金失敗",
    ['Boss.SocietyNotFound'] = "会社口座が見つかりません。",
    ['Boss.NotEnoughMoney'] = "お金が足りません。",
    
    -- ============================================
    -- HAIR STYLING / ヘアスタイリング
    -- ============================================
    ['Hair.Title'] = "ヘアスタイリング",
    ['Hair.StyledSuccess'] = "ヘアスタイリング完了！",
    ['Hair.StylistWorking'] = "スタイリストがあなたの髪を施術中です",
    ['Hair.Cancelled'] = "ヘアスタイリングがキャンセルされました",
    ['Hair.NoPermission'] = "ヘアスタイリングを行う権限がありません",
    ['Hair.AlreadyStyling'] = "すでに他の方の髪を施術中です",
    ['Hair.SitInChair'] = "サロンチェアに座る",
    ['Hair.StyleHair'] = "髪をスタイリング",
    ['Hair.DoHair'] = "ヘアをする",
    ['Hair.ClientLeft'] = "お客様がサーバーを離れました",
    ['Hair.StylistLeft'] = "スタイリストがサーバーを離れました",
    
    -- ============================================
    -- NAIL SERVICES / ネイルサービス
    -- ============================================
    ['Nails.Title'] = "ネイルサービス",
    ['Nails.LashServices'] = "まつげサービス",
    ['Nails.ApplyStyles'] = "%sスタイルを適用",
    ['Nails.ApplyingService'] = "サービスを適用中...",
    ['Nails.GettingService'] = "サービスを受けています...",
    ['Nails.NailsComplete'] = "ネイルがとても素敵になりました！",
    ['Nails.NailServiceComplete'] = "ネイルサービス完了！",
    ['Nails.LashesComplete'] = "まつげがとても美しくなりました！",
    ['Nails.LashServiceComplete'] = "まつげサービス完了！",
    ['Nails.TechWorking'] = "ネイリストがあなたのネイルを施術中です",
    ['Nails.LashExpertWorking'] = "まつげの専門家があなたのまつげを施術中です",
    ['Nails.NoPermissionNails'] = "ネイルをするにはネイリスト（等級%d以上）である必要があります",
    ['Nails.NoPermissionLashes'] = "まつげをするにはまつげ専門家（等級%d以上）である必要があります",
    ['Nails.SitInChair'] = "ネイルチェアに座る",
    ['Nails.DoNails'] = "ネイルをする",
    ['Nails.DoLashes'] = "まつげをする",
    ['Nails.ClientDisconnected'] = "お客様が切断されました",
    ['Nails.TechDisconnected'] = "ネイリストが切断されました",
    ['Nails.LashExpertDisconnected'] = "まつげ専門家が切断されました",
    ['Nails.NailCancelledRestart'] = "ネイルサービスがキャンセルされました（サーバー再起動）",
    ['Nails.LashCancelledRestart'] = "まつげサービスがキャンセルされました（サーバー再起動）",
    ['Nails.NailCancelled'] = "ネイルサービスがキャンセルされました",
    ['Nails.LashCancelled'] = "まつげサービスがキャンセルされました",
    ['Nails.AppearanceSaved'] = "外見が保存されました！",
    
    -- ============================================
    -- TRAP / STREET SELLING / 路上販売
    -- ============================================
    ['Trap.NotWoman'] = "女性のみが美容製品を販売できます！",
    ['Trap.NoPolice'] = "販売を開始するには警察が不足しています。",
    ['Trap.NoProducts'] = "販売する美容製品がありません！",
    ['Trap.AlreadySelling'] = "すでに商品を販売中です！",
    ['Trap.WaitCustomer'] = "顧客を探しています...近くにいてください！",
    ['Trap.CustomerApproaching'] = "お客様が近づいています！",
    ['Trap.CustomerWaiting'] = "お客様が購入の準備ができました！",
    ['Trap.CustomerLeft'] = "お客様は興味を失い、立ち去りました。",
    ['Trap.SellProduct'] = "美容製品を販売",
    ['Trap.SaleSuccess'] = "%sを%d個、$%dで販売しました",
    ['Trap.SaleRejected'] = "お客様があなたのオファーを断りました！",
    ['Trap.SaleFailed'] = "販売失敗: %s",
    ['Trap.TooFar'] = "お客様から離れすぎました！",
    ['Trap.Robbed'] = "お客様があなたを強盗しようとしました！",
    ['Trap.RobberyFailed'] = "強盗を撃退しました！",
    ['Trap.RobberGotAway'] = "強盗が逃げました！",
    ['Trap.StoppedSelling'] = "美容製品の販売を停止しました。",
    ['Trap.InVehicle'] = "車内では販売できません！",
    ['Trap.NotBeautyJob'] = "製品を販売するにはビューティーサロンで働く必要があります！",
    ['Trap.Disabled'] = "路上販売システムは現在無効です",
    ['Trap.WaitingProductData'] = "製品データを待っています...",
    ['Trap.NoItemAnymore'] = "このアイテムはもう持っていません！",
    
    -- ============================================
    -- NOTIFICATIONS (GENERAL) / 通知
    -- ============================================
    ['Notify.CheckoutRequest'] = "会計リクエスト",
    ['Notify.CustomerNeedsAssistance'] = "%sでお客様が会計のサポートを必要としています！",
    
    -- ============================================
    -- TABLET SYSTEM / タブレットシステム
    -- ============================================
    ['Tablet.NoJob'] = "これを使用するにはビューティーサロンの従業員である必要があります。",
    ['Tablet.Opened'] = "タブレットを開きました。",
    ['Tablet.Closed'] = "タブレットを閉じました。",
    
    -- Passing tablet / タブレット受け渡し
    ['Tablet.SelectCustomer'] = "タブレットを渡すお客様を選択してください。",
    ['Tablet.NoNearbyPlayers'] = "近くにお客様がいません。",
    ['Tablet.NoCustomerNearby'] = "近くにお客様がいません。",
    ['Tablet.PassTablet'] = "タブレットを渡す",
    ['Tablet.PassingTablet'] = "お客様にタブレットを渡しています...",
    ['Tablet.TabletPassed'] = "タブレットを渡しました。お客様の応答を待っています。",
    
    -- Customer prompts / お客様へのプロンプト
    ['Tablet.OfferTitle'] = "ビューティーサロン お支払い",
    ['Tablet.OfferDesc'] = "%sが支払いタブレットを渡そうとしています。",
    ['Tablet.Accept'] = "承諾",
    ['Tablet.Decline'] = "拒否",
    ['Tablet.DeclineReasonTitle'] = "拒否理由",
    ['Tablet.DeclineReasonDesc'] = "なぜ拒否しますか？（任意）",
    
    -- Customer received / お客様受取
    ['Tablet.Received'] = "サービスを確認し、お支払いを完了してください。",
    
    -- Decline handling / 拒否処理
    ['Tablet.Declined'] = "お客様がタブレットを拒否しました。",
    ['Tablet.DeclinedWithReason'] = "お客様が拒否しました: %s",
    ['Tablet.YouDeclined'] = "タブレットを拒否しました。",
    
    -- Payment / 支払い
    ['Tablet.PaymentSuccessEmployee'] = "$%sの支払いを受け取りました！（チップ: $%s）",
    ['Tablet.PaymentSuccessCustomer'] = "$%sをお支払いいただきました。ビューティーサロンにお越しいただきありがとうございます！",
    ['Tablet.NoMoneyCash'] = "現金が足りません。",
    ['Tablet.NoMoneyBank'] = "銀行口座の残高が不足しています。",
    ['Tablet.PaymentFailed'] = "支払いに失敗しました。",
    ['Tablet.TransactionExpired'] = "取引の有効期限が切れました。",
    
    -- Availability / 対応可否
    ['Tablet.AvailabilityTitle'] = "対応状況を設定",
    ['Tablet.SetAvailable'] = "対応可能に設定",
    ['Tablet.SetUnavailable'] = "対応不可に設定",
    ['Tablet.NowAvailable'] = "予約を受け付け可能になりました。",
    ['Tablet.NowUnavailable'] = "現在対応不可です。",
    
    -- Management / 管理
    ['Tablet.PriceUpdated'] = "%sの価格を$%sに更新しました。",
    ['Tablet.ShelfPriceUpdated'] = "棚の価格を$%sに更新しました。",
    ['Tablet.LimitUpdated'] = "カスタム請求限度額を$%sに設定しました。",
    ['Tablet.ChargeLimitUpdated'] = "請求限度額を$%sに設定しました。",
    ['Tablet.NoPermission'] = "これを行う権限がありません。",
    
    -- Stats / 統計
    ['Tablet.StatsToday'] = "本日の売上: $%s（%d人のお客様）",
    ['Tablet.StatsWeek'] = "今週: $%s（%d人のお客様）",
    
    -- Finances / 財務
    ['Tablet.DepositSuccess'] = "会社に$%sを入金しました。",
    ['Tablet.WithdrawSuccess'] = "会社から$%sを引き出しました。",
    ['Tablet.DepositFailed'] = "会社への入金に失敗しました。",
    ['Tablet.WithdrawFailed'] = "会社口座の残高が不足しています。",
    ['Tablet.NotEnoughCash'] = "現金が足りません。",
    
    -- Employee Management / 従業員管理
    ['Tablet.EmployeeHired'] = "%sを等級%dで雇用しました。",
    ['Tablet.YouWereHired'] = "ビューティーサロンに雇用されました！",
    ['Tablet.EmployeeFired'] = "従業員を解雇しました。",
    ['Tablet.YouWereFired'] = "ビューティーサロンから解雇されました。",
    ['Tablet.GradeUpdated'] = "従業員の等級が更新されました。",
    ['Tablet.YourGradeUpdated'] = "あなたの役職が更新されました！",
    ['Tablet.PlayerNotFound'] = "プレイヤーが見つかりません。",
    
    -- Disconnection / 切断
    ['Tablet.EmployeeDisconnected'] = "従業員が切断されました。",
    ['Tablet.CustomerDisconnected'] = "お客様が切断されました。",
    
    -- Customer accepted/declined / お客様の承諾/拒否
    ['Tablet.CustomerAccepted'] = "お客様がタブレットを受け取りました。",

    -- Appointments (Full Booking System)
    ['Tablet.AvailabilitySaved'] = "空き状況が保存されました。",
    ['Tablet.NewAppointment'] = "新しい予約",
    ['Tablet.AppointmentCancelledRefund'] = "予約がキャンセルされました - デポジットが返金されました。",
    ['Tablet.AppointmentCancelledNoRefund'] = "予約がキャンセルされました - 返金なし（期限切れ）。",
    ['Tablet.AppointmentReminder'] = "予約リマインダー",
    ['Tablet.ReminderCustomer'] = "リマインダー: %s分後に予約があります！",
    ['Tablet.ReminderEmployee'] = "%sさんの予約が%s分後にあります。",
    ['Tablet.NotEnoughForDeposit'] = "デポジットに必要な金額が不足しています（$%s必要）。",
    ['Tablet.BookingSuccess'] = "予約完了！デポジット$%sを支払いました。",
    ['Tablet.RefundGiven'] = "デポジット$%sが返金されました。",
    ['Tablet.BookAppointment'] = "予約する",
    ['Tablet.SelectEmployee'] = "スタイリストを選択",
    ['Tablet.SelectDate'] = "日付を選択",
    ['Tablet.SelectTime'] = "時間を選択",
    ['Tablet.ConfirmBooking'] = "予約を確認",
    ['Tablet.DepositRequired'] = "デポジット: $%s",
    ['Tablet.NoEmployeesAvailable'] = "予約可能なスタイリストがいません。",
    ['Tablet.NoDatesAvailable'] = "利用可能な日付がありません。",
    ['Tablet.NoTimesAvailable'] = "利用可能な時間がありません。",
    ['Tablet.MyBookings'] = "マイ予約",
    ['Tablet.ManageAvailability'] = "空き状況を管理",
}