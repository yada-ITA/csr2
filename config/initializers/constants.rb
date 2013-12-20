
module Constants
  module Enginestatus
    ID_BEFORE_ARRIVE   = 1 # 受領前
    ID_BEFORE_REPAIR   = 2 # 整備前
    ID_UNDER_REPAIR    = 3 # 整備中
    ID_FINISHED_REPAIR = 4 # 完成品
    ID_BEFORE_SHIPPING = 5 # 出荷準備中
    ID_AFTER_SHIPPING  = 6 # 出荷済
    ID_ABOLISHED       = 7 # 廃却済
  end

  module Businessstatus
    ID_INQUIRY              = 1 # 引合
    ID_ORDERED              = 2 # 受注
    ID_SHIPPING_PREPARATION = 3 # 出荷準備中
    ID_SHIPPED              = 4 # 出荷済
    ID_RETURNED             = 5 # 返却済
    ID_CANCELED             = 9 # キャンセル
  end

  module Engine
    EARLIEST_START_YEAR = 1990 # 最も古いエンジンの試運転年
  end
end
