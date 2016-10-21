require 'rails_helper'

def go_fill_execute
  # Point your browser towards the todo path
  visit todos_path

  # Enter description in the text field
  fill_in 'todo_title', with: 'Be Batman'

  # Press enter (to submit the form)
  page.execute_script("$('form').submit()")
end

feature 'Manage tasks', js: true do
  scenario 'add a new task' do
    go_fill_execute

    # Expect the new task to be displayed in the list of tasks
    expect(page).to have_content('Be Batman')
  end

  scenario 'counter changes' do
    go_fill_execute

    # Wait for 1 second so the counter can be updated
    sleep(1)

    expect( page.find(:css, 'span#todo-count').text ).to eq "1"
  end

  scenario 'complete a task' do

    go_fill_execute
    check('1')

    # Wait for 1 second so the counter can be updated
    sleep(1)

    expect( page.find(:css, 'span#todo-count').text ).to eq "0"
  end
end
