# Metasploit development environment
[![License](http://img.shields.io/:license-mit-blue.svg)](https://github.com/l50/metasploit-development-environment/blob/master/LICENSE)

Automated aws environment for (my) development of metasploit modules.
Presently, this does the following:
1. Creates two micro ec2 instances and a security group for them
2. Creates a kali container on one of the instances
3. Installs metasploit on that container
4. Creates an rc file to setup a listener
5. Creates a payload to get a reverse shell from the victim to that
   listener
6. Transfer that payload to the target system and ```chmod +x``` it

## Installation:
1. Install [pipenv](https://github.com/pypa/pipenv)
2. Clone into this repo
3. Install [terraform](https://www.terraform.io/downloads.html)
4. Run ```make install```

## Usage
1. Fill out required vars in config.py and vars.tf
2. Run ```make build```

### To get a shell for testing purposes:
1. ssh into the instance with the kali container
2. Get into the kali container: ```sudo docker exec -it kali bash```
3. Run the listener: ```msfconsole -r /root/.msf4/evil.rc```
4. ssh into the "target" instance
5. Start the payload on the target: ```cd /tmp && ./shell.elf```

## To tear it down:
```make destroy```

### Something Missing?
Let me know: jayson.e.grace@gmail.com

### TODO:
- [] Set up proper metasploit development container using [instructions
  from the official guide](https://github.com/rapid7/metasploit-framework/wiki/Setting-Up-a-Metasploit-Development-Environment)
- [] Decide if we should run the kali container using ECS instead of
  running it on an EC2 instance

## License
MIT

