module RepairsHelper
  def start_repair_path(repair)
     return 'repairs/repairStarted/' +  repair.id.to_s
  end
  def finish_repair_path(repair)
     return 'repairs/repairFinished/' +  repair.id.to_s
  end
  def engine_arrived_path(engine)
     return 'repairs/engineArrived/' + engine.id.to_s
  end
end
