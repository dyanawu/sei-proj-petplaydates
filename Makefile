APP_NAME=pet-playdates
DB_NAME=petplaydates_development

dbsync:
	heroku pg:reset -a $(APP_NAME) --confirm $(APP_NAME)
	heroku pg:push $(DB_NAME) DATABASE_URL -a $(APP_NAME)

prep:
	rails assets:precompile
	git add .
	git commit -m "Precompile for prod"
	git status

deploy: dbsync
	git push dyanawu heroku

.PHONY: dbsync prep deploy
