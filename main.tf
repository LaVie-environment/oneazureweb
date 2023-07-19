#create a resource group
resource "azurerm_resource_group" "webserver" {
  name = var.resource_group_name
  location = var.location
}

# Create a virtual network within the resource group
resource "azurerm_network_security_group" "allowedports" {
  name = "allowedports"
  resource_group_name = azurerm_resource_group.webserver.name
  location            = azurerm_resource_group.webserver.location
  
  security_rule {
    name = "http"
    priority = 100
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_port_range = "*"
    destination_port_range = "80"
    source_address_prefix = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name = "https"
    priority = 200
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_port_range = "*"
    destination_port_range = "443"
    source_address_prefix = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name = "ssh"
    priority = 300
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_port_range = "*"
    destination_port_range = "22"
    source_address_prefix = "*"
    destination_address_prefix = "*"
  }
}

# Create public ip
resource "azurerm_public_ip" "webserver_public_ip" {
  name = "webserver_public_ip"
  location = var.location
  resource_group_name = azurerm_resource_group.webserver.name
  allocation_method = "Dynamic"

  tags = {
    environment = var.environment
  }

  depends_on = [azurerm_resource_group.webserver]
}

# Create network interface
resource "azurerm_network_interface" "webserver" {
  name = "nginx-interface"
  location = azurerm_resource_group.webserver.location
  resource_group_name = azurerm_resource_group.webserver.name

  ip_configuration {
    name = "internal"
    private_ip_address_allocation = "Dynamic"
    subnet_id = module.network.vnet_subnets[0]
    public_ip_address_id = azurerm_public_ip.webserver_public_ip.id
  }

  depends_on = [azurerm_resource_group.webserver]
}

# Create Linux VM
resource "azurerm_linux_virtual_machine" "nginx" {
  size = var.instance_size
  name = "panta-nginx-webserver"
  resource_group_name = azurerm_resource_group.webserver.name
  location = azurerm_resource_group.webserver.location
  network_interface_ids = [
    azurerm_network_interface.webserver.id,
  ]

  source_image_reference {
    publisher = "Canonical"
    offer = "0001-com-ubuntu-server-focal"
    sku = "20_04-lts-gen2"
    version = "latest"

  }

  # Feel free to modify the credentials
  computer_name = "nginx"
  admin_username = "root"
  admin_password = "admin1234"
  disable_password_authentication = false

  os_disk {
    name = "nginxdisk01"
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  tags = {
    environment = var.environment
  }

  depends_on = [azurerm_resource_group.webserver]
}