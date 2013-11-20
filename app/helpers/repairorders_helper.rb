module RepairordersHelper

  # エンジン返却登録のためのパスを生成する
  def engine_returning_path(engine)
    return '/repairorders/engineReturning/' + engine.id.to_s
  end

  # 整備依頼のためのパスを生成する
  def repair_ordered_path(repairorder)
    return '/repairorders/repairOrdered/' +  repairorder.id.to_s
  end
  
  # 仕入のためのパスを生成する
  def repair_accepted_path(repairorder)
    return '/repairorders/repairAccepted/' +  repairorder.id.to_s
  end

end
