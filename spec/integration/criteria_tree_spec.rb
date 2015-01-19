require "spec_helper"

RSpec.describe "Criteria Tree", type: :feature do
  before do
    allow(Sentimeta::Client).to receive(:spheres).and_return build_list(:sphere, 1)
    allow(Criterion).to receive(:all).and_return build_list(:criterion, 1).map { |crit| Criterion.new crit }
  end

  context 'page', js: true do
    before do
      visit('/en/hotels')
    end

    it 'should have parent criterion' do
      expect(page).to have_content "Some Criterion"
    end

    it 'should show and hide subcriteria' do
      expect(page).to_not have_content "Subcriteria"
      click_link 'Some Criterion'
      expect(page).to have_content "Subcriteria"
      click_link 'Some Criterion'
      expect(page).to_not have_content "Subcriteria"
    end

    it 'should redirect to right url' do
      click_link 'Some Criterion'
      click_link 'Subcriteria'
      expect(current_path).to eq '/en/hotels/objects/criteria/subcriteria'
    end
  end
end
