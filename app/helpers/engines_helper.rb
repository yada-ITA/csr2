module EnginesHelper
  def engine_arrived_path(engine)
    return new_repair_path + '/' + engine.id.to_s
  end
end
