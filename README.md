# Metasploit development environment
[![License](http://img.shields.io/:license-mit-blue.svg)](https://github.com/l50/metasploit-development-environment/blob/master/LICENSE)

Automated aws environment for (my) development of metasploit  modules.
Presently, this creates two micro ec2 instances and a security group.

## Installation:
1. Clone into this repo
2. Install terraform
3. Run ```terraform init``` 
4. Create config.py and terraform.tfvars
5. Fill out required vars in terraform.tfvars and config.py (see example files)
6. Run ```terraform apply -auto-approve```

## To tear it down:
```terraform destroy -auto-approve```

### Something Missing?
Let me know: jayson.e.grace@gmail.com

### TODO:
- [] Try to automate establishing a reverse shell on create
- [] Decide if we should run the kali container using ECS
- [] Decide if we should run an msf container instead of a kali container
- [] Travis-CI

## License
MIT
