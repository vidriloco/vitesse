require 'spec_helper'

describe "lugares/edit.html.erb" do
  before(:each) do
    @lugar = assign(:lugar, stub_model(Lugar,
      :string => "",
      :text => "",
      :string => "",
      :string => "",
      :integer => "",
      :integer => "",
      :string => "",
      :string => ""
    ))
  end

  it "renders the edit lugar form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => lugares_path(@lugar), :method => "post" do
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
