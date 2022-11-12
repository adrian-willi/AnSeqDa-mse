.DEFAULT_GOAL := help

###########################
# HELP
###########################
include *.mk

###########################
# VARIABLES
###########################
NOTEBOOK_DOCKER_START = docker compose up -d notebook && docker compose logs -f notebook
NOTEBOOK_DOCKER_STOP = docker-compose down -v
RSTUDIO_DOCKER_START = docker compose up -d rstudio && docker compose logs -f rstudio


###########################
# PROJECT UTILS
###########################
.PHONY: clean
clean: ##@Utils Cleans the project
	@find . -name '*.pyc' -delete
	@find . -name '__pycache__' -type d | xargs rm -fr
	@rm -f .DS_Store
	@rm -f -R .pytest_cache
	@rm -f -R .idea
	@rm -f .coverage
	@rm -f .coverage*
	@rm -f -R .ipynb_checkpoints
	@find . -name '*,cover' -exec rm -r "{}" \;

###########################
# JUPYTER
###########################
.PHONY: start_jupyter
start_jupyter: ##@Jupyterlab Starts jupyter lab service
	@echo "Starting jupyter lab"
	$(NOTEBOOK_DOCKER_START)

.PHONY: stop
stop: ##@Jupyterlab Stops all services
	@echo "Stopping all services"
	$(NOTEBOOK_DOCKER_STOP)

###########################
# RSTUDIO
###########################
.PHONY: start_rstudio
start_rstudio: ##@Rstudio Starts rstudio service
	@echo "Starting rstudio"
	$(RSTUDIO_DOCKER_START)

###########################
# Literature
###########################
.PHONY: open_forecasting_book
open_forecasting_book: ##@Literature Opens the forecasting book
	@echo "Opening the forecasting book"
	@open https://otexts.com/fpp2/
