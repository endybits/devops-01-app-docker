install:
	sudo apt update && sudo apt upgrade -y
	python -m pip install -U pip && \
	pip install -r requirements.txt
	export PYTHONPATH=.