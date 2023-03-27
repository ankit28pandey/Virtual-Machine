resource "azurerm_resource_group" "example" {
    name = "terraform-resource"
    location = var.location
}

resource "azurerm_virtual_network" "example" {
    name = var.resource_group_name
    address_space = ["10.0.0.0/32"]
    location = var.location
    resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet" "example" {
    name = var.subnet_name
    address_prefixes = ["10.0.0.0/24"]
    resource_group_name = azurerm_resource_group.example.name
    virtual_network_name = azurerm_virtual_network.example.name
}

resource "azurerm_network_interface" "example" {
    name = "terraform-ip"
    location = azurerm_resource_group.example.location
    resource_group_name = azurerm_resource_group.example.name

    ip_configuration {
        name = var.subnet_name
        subnet_id = azurerm_subnet.example.id
        private_ip_address_allocation = "Dynamic"
    }
}

resource "azurerm_public_ip" "example" {
  name                = "example-pip"
  location            = azurerm_resource_group.example.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
}

resource "azurerm_linux_virtual_machine" "example" {
    name = var.vm_name
    resource_group_name = azurerm_resource_group.example.name
    location = azurerm_resource_group.example.location
    size = var.vm_size
    admin_username = var.admin_username

    network_interface_ids = [
        azurerm_network_interface.example.id,
        ]

    admin_ssh_key {
        username = var.admin_username
        public_key = "${file("~/.ssh/id_rsa.pub")}"
    }

    os_disk {
        caching = "ReadWrite"
        storage_account_type = var.storage_account_type
    }

    source_image_reference {
        publisher = "Canonical"
        offer = "UbuntuServer"
        sku = "16.04-LTS"
        version = "latest"
    }
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y nginx",
      "sudo service nginx start"
    ]

    connection {
      type        = "ssh"
      user        = "adminuser"
      private_key = "${file("~/.ssh/id_rsa")}"
      host        = "${azurerm_public_ip.example.ip_address}"
    }
  }

  provisioner "remote-exec" {
  inline = [
      "chmod +x /scripts/install_jenkins.sh",
      "sudo /scripts/install_jenkins.sh",
    ]
  }

   provisioner "remote-exec" {
   inline = [
      "chmod +x /script/install_docker.sh",
      "sudo /script/install_docker.sh"
    ]
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /script/install_terraform.sh",
      "sudo /script/install_terraform.sh"
    ]
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /script/install_kubernetes.sh",
      "sudo /script/install_kubernetes.sh"
    ]
  }
}

resource "azurerm_network_security_group" "example" {
  name = var.azurerm_network_security_group
  location = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  security_rule {
    name = "Allow_Inbound_Port_22"
    priority = 100
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_port_range = "*"
    destination_port_range = "22"
    source_address_prefix = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name = "Allow_Inbound_Port_8080"
    priority = 101
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_port_range = "*"
    destination_port_range = "8080"
    source_address_prefix = "*"
    destination_address_prefix = "*"
  }
}

