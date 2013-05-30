# == Schema Information
#
# Table name: import_cells
#
#  id            :integer          not null, primary key
#  import_row_id :integer
#  number        :integer
#  header        :text
#  data          :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'spec_helper'

describe ImportCell do
  pending "add some examples to (or delete) #{__FILE__}"
end
