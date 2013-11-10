require 'simplecov'
SimpleCov.start

require_relative '../lib/rcone.rb'

describe RCone::Cone do
  
  let(:request_params) {
    {
      apple: 'apple',
      pear: 'pear',
      peach: 'peach',
      mango: 'mango',
      orange: 'orange'
    }
  }
  
  let(:fields){
    [:apple, :pear, :orange, :banana]
  }
  
  it 'should return the value of a given parameter' do
    cone = RCone::Cone.new fields, request_params
    cone.get_apple.should == 'apple'
  end
  
  it 'should change the value of a given parameter' do
    value = 'dummy_apple'
    cone = RCone::Cone.new fields, request_params
    cone.set_apple value
    cone.get_apple.should == value
  end
  
  it 'should raise exception if a required parameter is not set' do
    required = [:banana]
    expect {RCone::Cone.new fields, request_params, required}.to raise_error(RCone::MissingParameterException)
  end
  
  it 'should raise exception if calling a method other than get/set' do
    cone = RCone::Cone.new fields, request_params
    expect {cone.blah_apple}.to raise_error(RCone::UndefinedMethodException)
  end
  
  it 'should raise exception if getting/setting an undefined field' do
    cone = RCone::Cone.new fields, request_params
    expect {cone.get_grape}.to raise_error(RCone::UndefinedFieldException)
    expect {cone.set_grape 'me likey'}.to raise_error(RCone::UndefinedFieldException)
  end
  
end