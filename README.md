# Metasploit development environment
[![License](http://img.shields.io/:license-mit-blue.svg)](https://github.com/l50/metasploit-development-environment/blob/master/LICENSE)

Automated aws environment for (my) development of metasploit  modules.
Presently, this creates two micro ec2 instances and a security group.

## Installation:
1. Install pipenv
2. Clone into this repo
3. Install terraform
4. Run ```make install```
5. Fill out required vars in config.py and vars.tf
6. Run ```make build```

## To tear it down:
```make destroy```

### Something Missing?
Let me know: jayson.e.grace@gmail.com

### TODO:
- [] Set up proper metasploit development container using instructions
  from
  https://github.com/rapid7/metasploit-framework/wiki/Setting-Up-a-Metasploit-Development-Environment
- [] Decide if we should run the kali container using ECS instead of
  running it on an EC2 instance
- [] Travis-CI - is this even possible?

## License
MIT
