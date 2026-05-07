# Terraform/Modules/TrackerCore/outputs.tf

output "vm_id" {
  description = "Resource ID of the Linux Virtual Machine."
  value       = azurerm_linux_virtual_machine.vm.id
}

output "vm_name" {
  description = "Name of the Linux Virtual Machine."
  value       = azurerm_linux_virtual_machine.vm.name
}

output "private_ip" {
  description = "Private IP address assigned to the VM's NIC."
  value       = azurerm_network_interface.nic.private_ip_address
}

output "nic_id" {
  description = "Resource ID of the Network Interface."
  value       = azurerm_network_interface.nic.id
}
