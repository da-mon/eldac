
require 'rails_helper'

shared_examples_for "colorful" do

  let(:model) { described_class }

  it 'makes a color difference' do
    expect(Folder.diff('ff0000', 0.9)).to eq('e50000')
  end

  it 'makes a css background style' do
    c = 'ff0000'
    expect(Folder.bg_css(c, Folder.diff(c, 0.9))).to eq("      background:-webkit-linear-gradient(#ff0000, #e50000); background:-o-linear-gradient(#ff0000, #e50000); background:-moz-linear-gradient(#ff0000, #e50000); background:linear-gradient(#ff0000, #e50000); filter:progid:DXImageTransform.Microsoft.gradient(startColorstr=#ff0000, endColorstr=#e50000); -ms-filter:progid:DXImageTransform.Microsoft.gradient(startColorstr=#ff0000, endColorstr=#e50000);\n")
  end

end
