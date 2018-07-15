provider "aws" {
    region = "us-west-1"
}

resource "aws_instance" "kali-container" {
    ami        = "ami-8d948ced"
    instance_type   = "t2.micro"
    key_name        = "${var.key_name}"
    security_groups = ["${aws_security_group.msf-dev-sec-group.name}"]

    provisioner "file" {
        source      = "scripts/setup_kali.sh"
        destination = "/tmp/setup_kali.sh"
        connection {
            type = "ssh"
            user = "${var.ssh_user}"
            private_key = "${file("${var.ssh_key}")}"
        }
    }

    provisioner "remote-exec" {
        inline = [
            "chmod +x /tmp/setup_kali.sh",
            "sudo /tmp/setup_kali.sh",
        ]
        connection {
            type = "ssh"
            user = "${var.ssh_user}"
            private_key = "${file("${var.ssh_key}")}"
        }
    }

    tags {
        Name = "kali-container"
    }
}

resource "aws_instance" "target" {
    ami        = "ami-8d948ced"
    instance_type   = "t2.micro"
    key_name        = "${var.key_name}"
    security_groups = ["${aws_security_group.msf-dev-sec-group.name}"]

    tags {
        Name = "target"
    }
}

output "kali-container" {
    value = "${aws_instance.kali-container.public_dns}"
}

output "target" {
    value = "${aws_instance.target.public_dns}"
}
