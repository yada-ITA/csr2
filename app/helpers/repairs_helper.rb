module RepairsHelper

  # ƒGƒ“ƒWƒ““’…“o˜^‚Ì‚½‚ß‚ÌƒpƒX‚ğ¶¬‚·‚é  
  def engine_arrived_path(engine)
    return '/repairs/engineArrived/' + engine.id.to_s
  end

  # ®”õŠJn“o˜^‚Ì‚½‚ß‚ÌƒpƒX‚ğ¶¬‚·‚é
  def start_repair_path(repair)
    return '/repairs/repairStarted/' +  repair.id.to_s
  end

  # ®”õŠ®—¹“o˜^‚Ì‚½‚ß‚ÌƒpƒX‚ğ¶¬‚·‚é
  def finish_repair_path(repair)
    return '/repairs/repairFinished/' +  repair.id.to_s
  end
  
end
