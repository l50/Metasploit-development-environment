import config
import json
import os
import paramiko
import subprocess
import time


__auth__ = 'jayson.e.grace@gmail.com'

payload_file = 'shell.elf'
payload_location = '/tmp'
payload = f"{payload_location}/{payload_file}"


def run_cmd(cmd):
    p = subprocess.Popen(cmd, stdout=subprocess.PIPE, shell=True)
    (output, err) = p.communicate()
    p_status = p.wait()
    # Convert output to string
    output = output.decode('utf-8')
    return output


def get_hostname(system):
    output = run_cmd('terraform output -json')
    tf_json = json.loads(output)
    return tf_json[system]['value']


def transfer_payload(kali, payload, target):
    run_cmd(f"scp -3 -o 'StrictHostKeyChecking no' -i {config.ssh_key} ubuntu@{kali}:{payload} ubuntu@{target}:{payload}")


def setPayloadPermissions(payload, target):
    k = paramiko.RSAKey.from_private_key_file(config.ssh_key)
    c = paramiko.SSHClient()
    c.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    c.connect( hostname = target, username = "ubuntu", pkey = k )
    stdin , stdout, stderr = c.exec_command(f"chmod +x {payload}")
    c.close()


def clean_up(payload):
    # Clean up local payload on host system
    if os.path.isfile(payload):
        os.remove(payload)


kali = get_hostname(config.kali_system_name)
target = get_hostname(config.target_system_name)
transfer_payload(kali, payload, target)
setPayloadPermissions(payload, target)
clean_up(payload)
