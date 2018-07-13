build:
	terraform apply --auto-approve
	terraform output
	pipenv run python scripts/transfer_payload.py

destroy:
	terraform destroy --auto-approve

install:
	pipenv --python 3.6.5 install
	terraform init
	cp examples/config.py.example scripts/config.py
	cp examples/vars.tf.example vars.tf
	echo 'You, human! Fill out config.py and vars.tf'
