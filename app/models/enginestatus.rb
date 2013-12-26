class Enginestatus < ActiveRecord::Base
  include Constants::Enginestatus

  def self.of_before_arrive;   find(ID_BEFORE_ARRIVE) end
  def self.of_before_repair;   find(ID_BEFORE_REPAIR) end
  def self.of_under_repair;    find(ID_UNDER_REPAIR) end
  def self.of_finished_repair; find(ID_FINISHED_REPAIR) end
  def self.of_before_shipping; find(ID_BEFORE_SHIPPING) end
  def self.of_after_shipping;  find(ID_AFTER_SHIPPING) end
  def self.of_abolished;       find(ID_ABOLISHED) end
end
