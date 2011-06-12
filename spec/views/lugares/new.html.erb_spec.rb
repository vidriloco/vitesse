require 'spec_helper'

describe "lugares/new.html.erb" do
  before(:each) do
    assign(:lugar, stub_model(Lugar,
      :string => "",
      :text => "",
      :string => "",
      :string => "",
      :integer => "",
      :integer => "",
      :string => "",
      :string => ""
    ).as_new_record)
  end

  it "renders new lugar form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => lugares_path, :method => "post" do
      assert_select "input#lugar_string", :name => "lugar[string]"
      assert_select "input#lugar_text", :name => "lugar[text]"
      assert_select "input#lugar_string", :name => "lugar[string]"
      assert_select "input#lugar_string", :name => "lugar[string]"
      assert_select "input#lugar_integer", :name => "lugar[integer]"
      assert_select "input#lugar_integer", :name => "lugar[integer]"
      assert_select "input#lugar_string", :name => "lugar[string]"
      assert_select "input#lugar_string", :name => "lugar[string]"
    end
  end
end
