require 'spec_helper'

describe 'Cost report in subproject', type: :feature, js: true do
  let!(:project) { FactoryGirl.create :project }
  let!(:subproject) { FactoryGirl.create :project, parent: project }

  let!(:role) { FactoryGirl.create :role, permissions: %i(view_cost_entries view_own_cost_entries) }
  let!(:user) do
    FactoryGirl.create :user,
                       member_in_project: subproject,
                       member_through_role: role
  end

  before do
    login_as(user)
    visit project_path(subproject)
  end

  it 'provides filtering' do
    within '#main-menu' do
      click_on 'Cost reports'
    end

    within '#content' do
      expect(page).to have_content 'New cost report'
    end
  end
end