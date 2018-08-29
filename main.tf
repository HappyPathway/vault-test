variable "vault_path" {
    type = "string"
    description = "Vault Path"
}

provider "vault" {

}

data "vault_generic_secret" "foo" {
    path = "${var.vault_path}"
}

data "template_file" "init" {
  template = "Foo: $${foo}"

  vars {
    foo = "${data.vault_generic_secret.foo.data["foo"]}"
  }
}

resource "null_resource" "null" {
    provisioner "local-exec" {
        command = "echo ${data.template_file.init.rendered}"

    }
}
output "foo" {
    value = "${data.template_file.init.rendered}"
}

