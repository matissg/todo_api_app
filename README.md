# README

This demo Rails 5.2 API app is prepared by Matiss Gaigals.

Please, run `rails db:setup` before launching the app as it will create DB and seed in test data.

Tests are done with Rspec, so just run `rspec`
Postman collection for this app can be found in `postman.json` file.

Briefly about the app.
A simple TODO application that allows to:
* Add new task (at least 3 characters for task title)
* Edit existing task
* List all tasks
* Tag a task (at least 3 letters for tag and up to 30 tags allowed)
* Delete existing task
