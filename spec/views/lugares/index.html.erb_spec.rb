require 'spec_helper'

describe "lugares/index.html.erb" do
  before(:each) do
    assign(:lugares, [
      stub_model(Lugar,
        :string => "",
        :text => "",
        :string => "",
        :string => "",
        :integer => "",
        :integer => "",
        :string => "",
        :string => ""
      ),
      stub_model(Lugar,
        :string => "",
        :text => "",
        :string => "",
        :string => "",
        :integer => "",
        :integer => "",
        :string => "",
        :string => ""
      )
    ])
  end

  it "renders a list of lugares" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
