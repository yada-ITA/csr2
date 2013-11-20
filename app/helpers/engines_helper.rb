#coding: UTF-8
module EnginesHelper
  def engine_arrived_path(engine)
    return new_repair_path + '/' + engine.id.to_s
  end
  
  def yesOffice?
    if  Company.find(current_user.company_id).name == "YES本社"
      return true      
    else
      return false
    end
  end
  
end
