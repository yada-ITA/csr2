module RepairsHelper

  # エンジン到着登録のためのパスを生成する  
  def engine_arrived_path(engine)
    return '/repairs/engineArrived/' + engine.id.to_s
  end

  # 整備依頼のためのパスを生成する
  def order_repair_path(repair)
    return '/repairs/repairOrder/' +  repair.id.to_s
  end
  
  # 整備開始登録のためのパスを生成する
  def start_repair_path(repair)
    return '/repairs/repairStarted/' +  repair.id.to_s
  end

  # 整備完了登録のためのパスを生成する
  def finish_repair_path(repair)
    return '/repairs/repairFinished/' +  repair.id.to_s
  end
  
end
