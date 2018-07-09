import config
import os
import subprocess


__auth__ = 'jayson.e.grace@gmail.com'


def run_cmd(cmd):
    p = subprocess.Popen(cmd, stdout=subprocess.PIPE, shell=True)
    (output, err) = p.communicate()
    p_status = p.wait()
    return output


def get_hostname(system):
    output = run_cmd(f"terraform state show aws_instance.{system} | grep public_dns")
    return output.decode("utf-8").split('= ')[1].strip()


def get_payload(kali):
    run_cmd(f"scp -i {config.ssh_key} ubuntu@{kali}:/tmp/shell.elf .")


def transfer_payload(target):
    run_cmd(f"scp -i {config.ssh_key} shell.elf ubuntu@{target}:/tmp/shell.elf")


def clean_up(file):
    if os.path.isfile(file):
        os.remove(file)


kali = get_hostname('kali-container')
print(f"Kali: {kali}")
target = get_hostname('target')
print(f"Target: {target}")
get_payload(kali)
transfer_payload(target)
clean_up('shell.elf')
