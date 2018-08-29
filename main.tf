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

output "foo" {
    value = "${data.template_file.init.rendered}"
}

