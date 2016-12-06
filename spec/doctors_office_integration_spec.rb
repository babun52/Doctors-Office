require('spec_helper')

describe('the new doctor path', {:type => :feature}) do
  it("displays a new doctor's name and specialty when a user inputs one in the form") do
    visit('/')
    fill_in('name', :with => 'Dr. Strangelove')
    fill_in('specialty', :with => 'oncology')
    click_button('Add Doctor')
    expect(page).to have_content('Dr. Strangelove, oncology')
  end
end
