# == Schema Information
#
# Table name: gedcoms
#
#  id                  :integer         not null, primary key
#  gedcom_file_name    :string(255)
#  gedcom_file_size    :integer
#  gedcom_content_type :string(255)
#  gedcom_updated_at   :datetime
#  user_id             :integer
#  created_at          :datetime
#  updated_at          :datetime
#

require 'spec_helper'

describe Gedcom do
  pending "add some examples to (or delete) #{__FILE__}"
end
