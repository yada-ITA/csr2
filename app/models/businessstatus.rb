class Businessstatus < ActiveRecord::Base
  include Constants::Businessstatus

  def self.of_inquiry;              find(ID_INQUIRY) end
  def self.of_ordered;              find(ID_ORDERED) end
  def self.of_shipping_preparation; find(ID_SHIPPING_PREPARATION) end
  def self.of_shipped;              find(ID_SHIPPED) end
  def self.of_returned;             find(ID_RETURNED) end
  def self.of_canceled;             find(ID_CANCELED) end
end
