resource "null_resource" "ansible_provisioner" {

  provisioner "local-exec" {
    command = "ansible-playbook -i ../ansible-assignment/hosts ../ansible-assignment/n01655478-playbook.yml"
  }

  depends_on = [ 
    module.rgroup-n01655478,
    module.datadisk-n01655478,
    module.vmlinux-n01655478
     ]

}
